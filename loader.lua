local StarterGui = game:GetService("StarterGui")
local host = "https://githubusercontent.com"
local repoPath = "Xecler/loader.lua/main/"
local hubUrl = host .. repoPath

local supportedGames = {
    ["123064301391841"] = { name = "Mini War", file = "MiniWar.lua" },
    ["131346454575416"] = { name = "Mini War", file = "MiniWar.lua" },
    ["120219252362013"] = { name = "Throw Food for Animals", file = "ThrowFood.lua" }
}

local function notify(title, text)
    pcall(function()
        StarterGui:SetCore("SendNotification", { Title = title, Text = text, Duration = 5 })
    end)
end

local currentPlace = supportedGames[tostring(game.PlaceId)]
if not currentPlace then
    notify("❄️ XECLER HUB 🎄", "Игра не добавлена! ID: " .. tostring(game.PlaceId))
    return
end

notify("❄️ XECLER HUB 🎄", "Загрузка: " .. currentPlace.name .. "...")

local ok, res = pcall(function()
    return game:HttpGet(hubUrl .. currentPlace.file)
end)

if not ok or type(res) ~= "string" or res == "" then
    notify("❌ Ошибка", "Xeno не смог скачать файл")
    return
end

local fn, err = loadstring(res)
if fn then
    fn()
else
    notify("❌ Ошибка кода", tostring(err))
end
