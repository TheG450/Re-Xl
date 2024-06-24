_G.Setting = {
    Start = true,
    InstantKill = true,
    SetTeleport = true,
    AutoEquip = true,
    WeaponName = "Ittoryu; Wado Ichimonji",
    TargetOne = "Zoro (PTS)",
    TargetTwo = "Zoro (TS)",
    AutoSkill = true,
    SkillKey = {
        E = false,
        R = true,
        C = false,
        X = false
    },
}

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local VirtualInputManager = game:GetService("VirtualInputManager")

local function Teleport()
    local player = Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(4475.07324, 216.284943, 2372.44287, -0.114426658, 1.66275598e-08, 0.993431687, 3.32588144e-08, 1, -1.29066384e-08, -0.993431687, 3.15634949e-08, -0.114426658)
    end
end

local function InstantKill(TargetName)
    for _, v in pairs(Workspace.Live:GetDescendants()) do
        if v.Name == TargetName and v:FindFirstChild("Humanoid") and v.Humanoid.Health < v.Humanoid.MaxHealth then
            v.Humanoid.Health = 0
        end
    end
end

local function Equip()
    local player = Players.LocalPlayer
    local Character = player.Character

    if not Character then return end

    for _, v in pairs(player.Backpack:GetChildren()) do
        if v.Name == _G.Setting.WeaponName and v:IsA("Tool") then
            v.Parent = Character
        end
    end
end

local function AutoSkill()
    for key, isEnabled in pairs(_G.Setting.SkillKey) do
        if isEnabled then
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode[key], false, game)
        end
    end
end

local function OnCharacterAdded(character)
    character:WaitForChild("HumanoidRootPart")
    if _G.Setting.SetTeleport then
        Teleport()
    end
end

local function SetupPlayer(player)
    player.CharacterAdded:Connect(OnCharacterAdded)
    if player.Character then
        OnCharacterAdded(player.Character)
    end
end

Players.PlayerAdded:Connect(SetupPlayer)
for _, player in pairs(Players:GetPlayers()) do
    SetupPlayer(player)
end

while task.wait() do
    if _G.Setting.Start then
        if _G.Setting.SetTeleport then
            Teleport()
        end
        if _G.Setting.AutoEquip then
            Equip()
        end
        if _G.Setting.AutoSkill then
            AutoSkill()
        end
        if _G.Setting.InstantKill then
            InstantKill(_G.Setting.TargetOne)
            InstantKill(_G.Setting.TargetTwo)
        end  
    end
end
