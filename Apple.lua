# -Applelocal AppleHub = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local ScrollingFrame = Instance.new("ScrollingFrame")

-- Criando UI
AppleHub.Name = "AppleHub"
AppleHub.Parent = game.CoreGui

MainFrame.Parent = AppleHub
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 300, 0, 400)

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

Title.Parent = MainFrame
Title.Text = "🍏 Apple Hub - Blox Fruits"
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18

ScrollingFrame.Parent = MainFrame
ScrollingFrame.Size = UDim2.new(1, 0, 1, -50)
ScrollingFrame.Position = UDim2.new(0, 0, 0, 50)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 5, 0)

-- Criando botão genérico
function CreateButton(text, callback)
    local Button = Instance.new("TextButton")
    Button.Parent = ScrollingFrame
    Button.Size = UDim2.new(1, -10, 0, 40)
    Button.Position = UDim2.new(0, 5, 0, #ScrollingFrame:GetChildren() * 45)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.SourceSansBold
    Button.TextSize = 16

    Button.MouseButton1Click:Connect(callback)
end

-- 📋 Funções principais
function AutoFarm()
    while true do
        wait(1)
        for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
            if enemy:FindFirstChild("HumanoidRootPart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame
                game.ReplicatedStorage.Remotes.Combat:FireServer("Attack")
            end
        end
    end
end

function AutoQuest()
    local player = game.Players.LocalPlayer
    for _, npc in pairs(game.Workspace.NPCs:GetChildren()) do
        if npc.Name:match("Quest") then
            player.Character.HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame
            wait(1)
            game.ReplicatedStorage.Remotes.Communication:InvokeServer("StartQuest", npc.Name)
        end
    end
end

function FruitESP()
    for _, fruit in pairs(game.Workspace:GetChildren()) do
        if fruit:IsA("Tool") and fruit:FindFirstChild("Handle") then
            local highlight = Instance.new("Highlight", fruit)
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        end
    end
end

function SpeedHack()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 200
end

function InfiniteJump()
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 500
end

function AutoBoss()
    while true do
        wait(1)
        for _, boss in pairs(game.Workspace.Bosses:GetChildren()) do
            if boss:FindFirstChild("HumanoidRootPart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame
                game.ReplicatedStorage.Remotes.Combat:FireServer("Attack")
            end
        end
    end
end

function FlyMode()
    local player = game.Players.LocalPlayer
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    humanoid.PlatformStand = true
    local bodyVelocity = Instance.new("BodyVelocity", player.Character.HumanoidRootPart)
    bodyVelocity.Velocity = Vector3.new(0, 50, 0)
end

function TeleportIslands()
    local islands = {
        ["Starter"] = Vector3.new(100, 10, 100),
        ["Jungle"] = Vector3.new(-1200, 10, 300),
        ["Sky Island"] = Vector3.new(300, 500, -200)
    }

    local selection = "Jungle" -- Mudar para qualquer ilha da tabela
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(islands[selection])
end

function CollectFruits()
    for _, fruit in pairs(game.Workspace:GetChildren()) do
        if fruit:IsA("Tool") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = fruit.Handle.CFrame
        end
    end
end

-- 🛠 Adicionando botões na UI
CreateButton("Auto Farm", AutoFarm)
CreateButton("Auto Quest", AutoQuest)
CreateButton("Fruit ESP", FruitESP)
CreateButton("Speed Hack", SpeedHack)
CreateButton("Infinite Jump", InfiniteJump)
CreateButton("Auto Boss", AutoBoss)
CreateButton("Fly Mode", FlyMode)
CreateButton("Teleport Ilhas", TeleportIslands)
CreateButton("Coletar Frutas", CollectFruits)

print("🍏 Apple Hub carregado com sucesso!")
