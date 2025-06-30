-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/task/taskuihandlers/yardmain.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskUIHandler = {}
TaskUIHandler.Handle = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).CourtYard) then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100195)
    return 
  end
  local csend = (LuaNetManager.CreateProtocol)("protocol.yard.copenyard")
  csend:Send()
  ;
  (DialogManager.DestroySingletonDialog)("task.taskmaindialog")
end

return TaskUIHandler

