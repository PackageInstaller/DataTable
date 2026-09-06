local function p1(protocol)
  NekoData.DataManager.DM_Activity:GetManager(DataCommon.ChristmasActivityManagerID):OnSGetChristmasActivityInfo(protocol)
  
  if protocol.firstEnter == 1 then
    local dialog = DialogManager.CreateSingletonDialog("activity.christmas.christmasmaindialog"):Init(true)
    local dialog = DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog")
    if dialog then
      LuaAudioManager.StopBGM(136)
      dialog:SetDialogLibraryId(DataCommon.ChristmasChatDialogId, false, 5)
    end
  else
    DialogManager.CreateSingletonDialog("activity.christmas.christmastransitiondialog"):SetState(protocol.stage)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
