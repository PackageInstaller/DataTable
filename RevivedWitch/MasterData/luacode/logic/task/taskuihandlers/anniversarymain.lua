-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/task/taskuihandlers/anniversarymain.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskUIHandler = {}
TaskUIHandler.Handle = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Anniversary):IsDisplayFirstDrama() then
    local dialog = (DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")
    if dialog then
      local chatdialogId = tonumber((((BeanManager.GetTableByName)("dungeonselect.canniversaryspecialcfg")):GetRecorder(4)).type)
      dialog:SetDialogLibraryId(chatdialogId, false, (dialog.DialogType).MidAutumn)
    end
  else
    do
      ;
      ((DialogManager.CreateSingletonDialog)("activity.anniversary.anniversarymaindialog")):SetTabType(((NekoData.BehaviorManager).BM_Game):GetLocalCache((DataCommon.LocalCache).AnniversaryOpenType))
      ;
      (DialogManager.DestroySingletonDialog)("activity.anniversarypackage.anniversarypackagemaindialog")
    end
  end
end

return TaskUIHandler

