local StarterGui = game:GetService("StarterGui")
local hubUrl = "https://githubusercontent.com"

local supportedGames = {
    ["123064301391841"] = { name = "Mini War", file = "MiniWar.lua" },
    ["131346454575416"] = { name = "Mini War", file = "MiniWar.lua" },
    ["120219252362013"] = { name = "Throw Food for Animals", file = "ThrowFood.lua" }
}

local function notify(title, text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = 5
        })
    end)
end

local placeKey = tostring(game.PlaceId)
local currentPlace = supportedGames[placeKey]

if not currentPlace then
    notify("❄️ XECLER HUB 🎄", "Игра не добавлена! ID: " .. placeKey)
    return
end

notify("❄️ XECLER HUB 🎄", "Загрузка: " .. currentPlace.name .. "...")

local fullUrl = hubUrl .. currentPlace.file .. "?v=" .. tostring(math.random(10000, 99999))
local ok, res = pcall(function()
    return game:HttpGet(fullUrl)
end)

if not ok or type(res) ~= "string" or res == "" or string.find(res, "404: Not Found") then
    notify("❌ Ошибка ответа", tostring(res):sub(1, 50))
    return
end

local fn, err = loadstring(res)
if fn then
    fn()
else
    notify("❌ Ошибка кода", tostring(err))
end
