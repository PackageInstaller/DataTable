--[[
-- added by wsh @ 2017-11-30
-- Lua全局配置
--]]

local Config = Config or {}

-- 调试模式：真机出包时关闭
Config.Debug = true
-- AssetBundle
Config.UseAssetBundle = false
Config.LuaLoggerOn = true

Config.BattleLogOn = false
if UNITY_EDITOR then
    Config.BattleLogOn = true
end

-- Mock模式

Config.MockEnabled = CS.Game.Instance.settings.mockEnabled
Config.SessionClassName = "Session"
if Config.MockEnabled then
    Config.SessionClassName = "MockSession"
end

return Config