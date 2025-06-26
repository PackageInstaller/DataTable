-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/task/taskuihandlers/friend.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CVarConfig = (BeanManager.GetTableByName)("var.cvarconfig")
local TaskUIHandler = {}
TaskUIHandler.Handle = function(self)
  -- function num : 0_0 , upvalues : _ENV, CVarConfig
  if ((NekoData.BehaviorManager).BM_Game):IsGuest() and (CVarConfig:GetRecorder(94)).Value == "0" then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100338)
    return 
  end
  if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Friend) then
    (DialogManager.CreateSingletonDialog)("friend.friendsmaindialog")
  end
end

return TaskUIHandler

