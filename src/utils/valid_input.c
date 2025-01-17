/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   valid_input.c                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: cocheong <cocheong@student.42kl.my>        +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/02/16 17:31:46 by cocheong          #+#    #+#             */
/*   Updated: 2024/02/16 17:31:46 by cocheong         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/minishell.h"

extern long long	g_exit_status;

static void	exit_shell(int exit_status, t_data *data)
{
	ft_putendl_fd("exit", STDOUT_FILENO);
	g_exit_status = exit_status;
	if (data)
		destroy(data);
	exit(g_exit_status);
}

bool	valid_input(char *input, t_data *data)
{
	bool	valid;

	valid = true;
	if (input == NULL)
	{
		free(input);
		exit_shell(EXIT_SUCCESS, data);
	}
	if (input[0] == '\0')
		valid = false;
	else if (unclosed_quotes(input))
	{
		ft_putendl_fd(UNCLOSED_QUOTES, STDERR_FILENO);
		valid = false;
	}
	else if (invalid_syntax(input)
		|| invalid_syntax2(input)
		|| invalid_syntax_on_operator(input))
		valid = false;
	if (!valid)
	{
		free(input);
		g_exit_status = 2;
	}
	return (valid);
}
