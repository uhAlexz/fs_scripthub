local Players = game:GetService("Players")
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Flame Script Hub",
    LoadingTitle = "Flame Script Hub",
    LoadingSubtitle = "by FlameServices",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = nil, -- Create a custom folder for your hub/game
       FileName = "FS_ScriptHub"
    },
    Discord = {
       Enabled = true,
       Invite = "tknv6PS8ch", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
    KeySystem = false, -- Set this to true to use our key system
    KeySettings = {
       Title = "Flame Services",
       Subtitle = "Key System",
       Note = "Join our Discord",
       FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
       SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = "flame.services" -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
 })

local PlayerTab = Window:CreateTab("Player", 4483362458)

local slider = PlayerTab:CreateSlider({
    Name = "Walkspeed",
    Range = {16, 100},
    Increment = 1,
    Suffix = "Walkspeed",
    CurrentValue = 16,
    Flag = "",
    Callback = function(Value)
        Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

local slider = PlayerTab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 100},
    Increment = 1,
    Suffix = "JumpPower",
    CurrentValue = 16,
    Flag = "",
    Callback = function(Value)
        Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end
})

local Toggle = PlayerTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Flag = "",
    Callback = function(Value)
        if Value then
            startFlying()
        else
            stopFlying()
        end
    end
})

local flying = false
local speed = 50
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootpart = character:WaitForChild("HumanoidRootPart")

function startFlying()
    flying = true
    local bodyGyro = Instance.new("BodyGyro")
    bodyGyro.P = 9e4
    bodyGyro.Parent = rootpart
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0,0,0)
    bodyVelocity.Parent = rootpart
    
    while true do
        wait()
        humanoid.PlatformStand = true
        local direction = Vector3.new(0,0,0)
        if player:FindFirstChild("Backpack") then
            direction = workspace.CurrentCamera.CFrame.LookVector
        end
        bodyVelocity.Velocity = direction * speed
        bodyGyro.CFrame = workspace.CurrentCamera.CFrame
    end

    bodyGyro:Destroy()
    bodyVelocity:Destroy()
    humanoid.PlatformStand = false
end

function stopFlying()
    flying = false
end
