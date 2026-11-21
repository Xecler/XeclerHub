local StarterGui = game:GetService("StarterGui")

local hubUrl = "https://githubusercontent.com"

local supportedGames = {
    [123064301391841] = { name = "Mini War", file = "MiniWar.lua" },
    [131346454575416] = { name = "Mini War", file = "MiniWar.lua" },
    [120219252362013] = { name = "Throw Food for Animals", file = "ThrowFood.lua" }
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

local currentPlace = supportedGames[game.PlaceId]

if not currentPlace then
    notify("❄️ XECLER HUB 🎄", "Эта игра пока не добавлена в хаб! (ID: " .. tostring(game.PlaceId) .. ")")
    return
end

notify("❄️ XECLER HUB 🎄", "Загрузка скрипта для: " .. currentPlace.name .. "...")

local fullUrl = hubUrl .. currentPlace.file

for attempt = 1, 3 do
    local success, scriptCode = pcall(function()
        return game:HttpGet(fullUrl)
    end)

    if success and type(scriptCode) == "string" and scriptCode ~= "" then
        local loadedFunc, err = loadstring(scriptCode)
        if loadedFunc then
            loadedFunc()
            return
        else
            notify("❌ Ошибка кода", tostring(err))
            return
        end
    end

    if attempt < 3 then
        task.wait(0.6)
    end
end

notify("❌ Ошибка сети", "Не удалось скачать файл с GitHub. Проверьте VPN.")
