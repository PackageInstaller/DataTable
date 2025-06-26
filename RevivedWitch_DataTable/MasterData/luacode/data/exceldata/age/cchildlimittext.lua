-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/age/cchildlimittext.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cchildlimittext = {}
cchildlimittext.Data = {
[1] = {id = 1, tipText = "此账号已通过实名认证，经验证您未满18岁，今日剩余游戏时长$parameter1$分钟。"}
, 
[2] = {id = 2, tipText = "此账号已通过实名认证，经验证您已满18岁，无游戏时长限制，祝游戏愉快。"}
, 
[3] = {id = 3, tipText = "您的在线时长已满60分钟，请尽快完成实名认证。"}
, 
[4] = {id = 4, tipText = "根据国家新闻出版署发布的《关于进一步严格管理切实防止未成年人沉迷网络游戏的通知》，您本次体验游戏时间已结束，请合理安排游戏时间，劳逸结合。"}
, 
[5] = {id = 5, tipText = "由于您未满18周岁，将在$parameter1$分钟后受到防沉迷限制。"}
, 
[6] = {id = 6, tipText = "由于您处于游客模式，将在$parameter1$分钟后受到防沉迷限制。"}
}
cchildlimittext.AllIds = {1, 2, 3, 4, 5, 6}
return cchildlimittext

