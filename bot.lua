local fs = require('fs')

local client = discordia.Client()

local prefix = '!'

local commands = {}

-- Load commands from the 'cmds' directory

local cmdFiles = fs.readdirSync('./cmds/')

for _, file in ipairs(cmdFiles) do

    if file:sub(-4) == '.lua' then

        local cmd = require('./cmds/' .. file:sub(1, -5))

        commands[cmd.name] = cmd

    end

end

client:on('ready', function()

    print('Connecté')

end)

client:on('messageCreate', function(message)

    if message.author.bot then

        return

    end

    if not message.guild then

        message.author:send("Doucement, tu peux rien faire ici mdrr.")

        return

    end

    if not message.content:startswith(prefix) then

        return

    end

    local args = message.content:split(' ')

    local commandName = args[1]:sub(#prefix + 1)

    if commands[commandName] then

        commands[commandName]:execute(message, args)

    else

        message.channel:send('commande inconnu: ' .. commandName)

    end

end)

local fs = require('fs')

local cmds = {}

-- Load commands from the 'MyLuaBot/cmds' directory

for _, filename in ipairs(fs.scandirSync('MyLuaBot/cmds')) do

    if filename:sub(-4) == '.lua' then

        local command = require('MyLuaBot.cmds.'..filename:sub(1, -5))

        cmds[command.name] = command

    end

end -- Ajouter cette accolade fermante

client:run('Bot YOUR_BOT_TOKEN_HERE')
