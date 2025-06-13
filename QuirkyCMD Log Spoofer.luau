
--[[
    (THIS WILL NO LONGER WORK, THEY REMOVED THE GAME LOGGING FUNCTINALITY ENTIRELY)

    QuirkyCMD is ran by brain-dead skids (not Eli), and I was bored so I decided to make a simple script that sends fake logs in their discord. (And it's open-source!!)

    One of the people that got falsely banned, they posted his ip in announcements??? (I put the censor there)
    https://ibb.co/Q74tcXGJ

    Sorry for the 2 people I got falsely banned.

    If you want to use this script, USE A VPN. They log ips. 💩 (eww stinky)

    (This is the first time I've published a script with comments like this, tell me what you think!)
]]

-->> Cache globals. (Better memory management, better used with bigger scripts)
local getgenv = getgenv()
local typeof = typeof
local setmetatable = setmetatable

local Instance_new = Instance.new

local game = game
local ReplicatedStorage = game.ReplicatedStorage
local Players = game.Players
local LocalPlayer = Players.LocalPlayer
--<<

-->> (Fake Remote) <<--
-->> Create our fake remote to handle logs. (you don't technically need this, it just makes it easier to fake when they log info about the found remote)
local fakeRemote = Instance_new("RemoteEvent")
fakeRemote.Name = "delete"
fakeRemote.Parent = ReplicatedStorage
--<<

-->> Create a function that handles the FireServer calls.
local function fireServerHandler(_, ...): any
    local args = {...}
    local instance = args[1]

    -->> Check if arg1 is an actual Instance.
    if instance and typeof(instance) == "Instance" then
    --<<

        -->> Remove instance to trick their check. (you could just return nil, but that could be a detection vector becuase the actual instance isin't removed)
        instance:Remove(instance)
        --<<

        -->> Return original instance. (you don't actually need this, it's just on the off-chance that they are able to tell if the instance is actually removed)
        return instance
        --<<

    end
end

-->> (Proxy Remote Table) <<--
-->> Create our proxy remote to handle FireServer calls.
getgenv.foundRemote = setmetatable({}, {
    __index = function(self: table, key: string)

        -->> Only return fireServerHandler when they call FireServer on the proxied remote table.
        if key == "FireServer" then
            return fireServerHandler
        end
        --<<

        -->> Retreive value they are trying to access from the fake remote. (Name, Parent, etc...)
        local value = fakeRemote[key]
        --<<

        -->> Return retrieved value.
        return value
        --<<

    end
})
--<<

-->> Change our players info so our account isin't logged.
local character = LocalPlayer.Character
if character then
    character.Name = "nicetry"
end

LocalPlayer.Name = "nicetry"
LocalPlayer.DisplayName = "nicetry"
LocalPlayer.UserId = 163037 -->> This is the uid of the player "nicetry" <<--
LocalPlayer.CharacterAppearanceId = 163037 -->> This is the uid of the player "nicetry" <<--
--<<
