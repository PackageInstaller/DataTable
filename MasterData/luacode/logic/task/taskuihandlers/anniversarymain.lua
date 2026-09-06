local TaskUIHandler = {}

function TaskUIHandler:Handle()
  if NekoData.BehaviorManager.BM_Anniversary:IsDisplayFirstDrama() then
    local dialog = DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog")
    if dialog then
      local chatdialogId = tonumber(BeanManager.GetTableByName("dungeonselect.canniversaryspecialcfg"):GetRecorder(4).type)
      dialog:SetDialogLibraryId(chatdialogId, false, dialog.DialogType.MidAutumn)
    end
  else
    DialogManager.CreateSingletonDialog("activity.anniversary.anniversarymaindialog"):SetTabType(NekoData.BehaviorManager.BM_Game:GetLocalCache(DataCommon.LocalCache.AnniversaryOpenType))
  end
  DialogManager.DestroySingletonDialog("activity.anniversarypackage.anniversarypackagemaindialog")
end

return TaskUIHandler
