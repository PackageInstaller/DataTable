-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/task/taskuihandlers/taskmain.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskUIHandler = {}
TaskUIHandler.Handle = function(self, id)
  -- function num : 0_0 , upvalues : _ENV
  if id ~= 2 then
    return 
  end
  if not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Task_Every) then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100412)
    return 
  end
  local dialogName = "task.taskmaindialog"
  local dialog = (DialogManager.GetDialog)(dialogName)
  if dialog then
    (DialogManager.DestroySingletonDialog)(dialogName)
  end
  local dlg = (DialogManager.CreateSingletonDialog)(dialogName)
  if dlg then
    dlg:ToPage(id)
  end
end

return TaskUIHandler

