return {

  name = 'kick',

  description = 'Kicks a user from the server.',

  usage = '<user mention> [reason]',

  execute = function(message, args)

    -- Check if user has permission to kick members

    if not message.member:hasPermission('kickMembers') then

      message.channel:send('You do not have permission to kick members.')

      return

    end

    

    -- Check if a user was mentioned

    local userToKick = message.mentionedUsers.first

    if not userToKick then

      message.channel:send('You must mention a user to kick.')

      return

    end

    

    -- Kick the user

    userToKick:kick('Kicked by '..message.author.username..' for '..table.concat(args, ' ')..'.')

    message.channel:send('User '..userToKick.username..' has been kicked.')

  end

}
