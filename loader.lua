local StarterGui = game:GetService("StarterGui")
local host = "https://githubusercontent.com"
local path = "Xecler/loader.lua/main/"

local games = {
    ["123064301391841"] = "MiniWar.lua",
    ["131346454575416"] = "MiniWar.lua",
    ["120219252362013"] = "ThrowFood.lua"
}

local function notify(t, msg)
    pcall(function()
        StarterGui:SetCore("SendNotification", { Title = t, Text = msg, Duration = 5 })
    end)
end

local file = games[tostring(game.PlaceId)]
if not file then
    notify("❄️ XECLER HUB 🎄", "Нет игры: " .. tostring(game.PlaceId))
    return
end

notify("❄️ XECLER HUB 🎄", "Загрузка " .. file .. "...")

local url = host .. path .. file
local code = nil

local ok1, res1 = pcall(function() return game:HttpGet(url) end)
if ok1 and type(res1) == "string" and #res1 > 10 then
    code = res1
else
    local req = (syn and syn.request) or (http and http.request) or http_request or request
    if req then
        local ok2, res2 = pcall(function() return req({ Url = url, Method = "GET" }) end)
        if ok2 and res2 and res2.Body and #res2.Body > 10 then
            code = res2.Body
        end
    end
end

if not code then
    notify("❌ Сбой сети", "Не скачался " .. file)
    return
end

local fn, err = loadstring(code)
if fn then
    fn()
else
    notify("❌ Ошибка Lua", tostring(err))
end
