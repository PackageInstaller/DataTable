local LuaCodeVersionManager = {}

function LuaCodeVersionManager.GetAllVersion()
  return {
    Lua_Code_Version = _G.Lua_Code_Version,
    Battle_Data_Version = _G.Battle_Data_Version,
    Behavior_Version = _G.Behavior_Version,
    Dungeon_Data_Version = _G.Dungeon_Data_Version,
    Excel_Data_Version = _G.Excel_Data_Version
  }
end

function LuaCodeVersionManager.GetLuaCodeVersion()
  return _G.Lua_Code_Version
end

function LuaCodeVersionManager.GetBattleDataVersion()
  return _G.Battle_Data_Version
end

function LuaCodeVersionManager.GetBehaviorVersion()
  return _G.Behavior_Version
end

function LuaCodeVersionManager.GetDungeonDataVersion()
  return _G.Dungeon_Data_Version
end

function LuaCodeVersionManager.GetExcelDataVersion()
  return _G.Excel_Data_Version
end

return LuaCodeVersionManager
