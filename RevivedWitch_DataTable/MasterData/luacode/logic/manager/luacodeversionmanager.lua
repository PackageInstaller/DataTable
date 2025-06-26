-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/luacodeversionmanager.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local LuaCodeVersionManager = {}
LuaCodeVersionManager.GetAllVersion = function()
  -- function num : 0_0 , upvalues : _ENV
  return {Lua_Code_Version = _G.Lua_Code_Version, Battle_Data_Version = _G.Battle_Data_Version, Behavior_Version = _G.Behavior_Version, Dungeon_Data_Version = _G.Dungeon_Data_Version, Excel_Data_Version = _G.Excel_Data_Version}
end

LuaCodeVersionManager.GetLuaCodeVersion = function()
  -- function num : 0_1 , upvalues : _ENV
  return _G.Lua_Code_Version
end

LuaCodeVersionManager.GetBattleDataVersion = function()
  -- function num : 0_2 , upvalues : _ENV
  return _G.Battle_Data_Version
end

LuaCodeVersionManager.GetBehaviorVersion = function()
  -- function num : 0_3 , upvalues : _ENV
  return _G.Behavior_Version
end

LuaCodeVersionManager.GetDungeonDataVersion = function()
  -- function num : 0_4 , upvalues : _ENV
  return _G.Dungeon_Data_Version
end

LuaCodeVersionManager.GetExcelDataVersion = function()
  -- function num : 0_5 , upvalues : _ENV
  return _G.Excel_Data_Version
end

return LuaCodeVersionManager

