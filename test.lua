local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/ni7ykt/test1/refs/heads/main/UI.lua"))()
local win = ui:new("测试")
local UITab1 = win:Tab("测试")
local UITab2 = win:Tab("测试1")
local UITab3 = win:Tab("测试2")
local Tab = UITab1:section("测试", true)
Tab:Slider("视角缩放距离", "Slider", 128, 128, 10000, false, function(Value)
    game:GetService("Players").LocalPlayer.CameraMaxZoomDistance = Value
end)
Tab:Label("-----------")
Tab:Slider("移动速度滑块1", "WalkSpeedSlider", 16, 500, 16, function(Value)
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = Value
    end
end)
Tab:Label("-----------")
Tab:Slider("速度设置1", "WalkSpeed", game.Players.LocalPlayer.Character.Humanoid.WalkSpeed, 16, 400, false, function(Speed)
  spawn(function() while task.wait() do game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Speed end end)
end)
Tab:Label("-----------")
Tab:Textbox("速度设置2", "WalkSpeed", "输入速度值2", function(Value)
    local tspeed = tonumber(Value)
    if tspeed then
        local hb = game:GetService("RunService").Heartbeat
        local tpwalking = true
        local player = game:GetService("Players")
        local lplr = player.LocalPlayer
        local chr = lplr.Character
        local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
        while tpwalking and hb:Wait() and chr and hum and hum.Parent do
          if hum.MoveDirection.Magnitude > 0 then
            if tspeed then
              chr:TranslateBy(hum.MoveDirection * tspeed)
            else
              chr:TranslateBy(hum.MoveDirection)
            end
          end
        end
    end
end)
Tab:Label("-----------")
Tab:Textbox("速度设置3", "TranslateAccelSpeed", "输入速度值", function(Value)
    local speed = tonumber(Value)
    if speed then
        getfenv().translateSpeed = speed
    end
end)

Tab:Toggle("加速开关", "TranslateAccelToggle", false, function(State)
    getfenv().translateAccelEnabled = State
    
    if State then
        if getfenv().sudu then
            getfenv().sudu:Disconnect()
            getfenv().sudu = nil
        end
        
        getfenv().translateConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if game:GetService("Players").LocalPlayer.Character and 
               game:GetService("Players").LocalPlayer.Character.Humanoid and 
               game:GetService("Players").LocalPlayer.Character.Humanoid.Parent then
               
                local humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid
                
                if humanoid.MoveDirection.Magnitude > 0 then
                    local moveDirection = humanoid.MoveDirection
                    local acceleration = moveDirection * (getfenv().translateSpeed or 50) / 30
                    
                    game:GetService("Players").LocalPlayer.Character:TranslateBy(acceleration)
                end
            end
        end)
    else
        if getfenv().translateConnection then
            getfenv().translateConnection:Disconnect()
            getfenv().translateConnection = nil
        end
    end
end)
