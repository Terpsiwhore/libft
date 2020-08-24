/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_get_next_line.c                                 :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcorazon <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/08/24 19:39:18 by kcorazon          #+#    #+#             */
/*   Updated: 2020/08/24 19:39:22 by kcorazon         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#define BUFFER_SIZE (42)
#include "libft.h"

static int		check_tail(int fd, char **line, char **remainder)
{
	char	*tail;
	char	*tmp;

	tail = NULL;
	if (*remainder)
		if ((tail = ft_strchr(*remainder, '\n')))
		{
			*tail = '\0';
			*line = ft_strdup(*remainder);
			tmp = *remainder;
			*remainder = ft_strdup(tail + 1);
			free(tmp);
		}
		else
		{
			*line = ft_strdup(*remainder);
			free(*remainder);
			*remainder = NULL;
		}
	else
		*line = ft_strdup("");
	return (tail ? 1 : 0);
}

static int		read_from_fd(int fd, char **line, char *buffer, char **remainder)
{
	char	*tail;
	char	*tmp;
	int		read_res;

	tail = NULL;
	while (!tail && (read_res = read(fd, buffer, BUFFER_SIZE)))
	{
		buffer[read_res] = '\0';
		if ((tail = ft_strchr(buffer, '\n')))
		{
			*tail = '\0';
			*remainder = ft_strdup(tail + 1);
		}
		tmp = *line;
		*line = ft_strjoin(*line, buffer);
		free(tmp);
	}
	return (read_res);
}

int				get_next_line(int fd, char **line)
{
	static char 	*remainder;
	char			*buffer;
	int				read_res;

	read_res = 1;
	if (!line || !(buffer = malloc(BUFFER_SIZE + 1)))
		return (-1);
	if (read(fd, buffer, 0) < 0)
	{
		free(buffer);
		return (-1);
	}
	if (!check_tail(fd, line, &remainder))
		read_res = read_from_fd(fd, line, buffer, &remainder);
	free(buffer);
	return (read_res || ft_strlen(remainder) || ft_strlen(*line)) ? 1 : 0;
}

