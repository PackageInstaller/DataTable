-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/task/taskuihandlers/yardroom.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskUIHandler = {}
TaskUIHandler.Handle = function(self)
  -- function num : 0_0 , upvalues : _ENV
  ((DialogManager.GetGroup)("Modal")):CloseAllDialog()
  ;
  ((NekoData.DataManager).DM_Game):SetFastMenuSignFromCourtyard(6)
  local csend = (LuaNetManager.CreateProtocol)("protocol.yard.copenyard")
  csend:Send()
end

return TaskUIHandler

