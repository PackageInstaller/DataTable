local SOpenArenaPanelProtocols = require("protocols.def.protocol.battle.sopenarenapanel")
local CArenaSeasonConfig = BeanManager.GetTableByName("dungeonselect.carenaseasonconfig")

local function p1(protocol)
  if protocol.waiting == 1 then
    DialogManager.CreateSingletonDialog("mainline.offlinepvp.offlinepvpemptydialog"):SetWaitDescribe()
    return
  end
  if protocol.seasonId == -1 then
    DialogManager.CreateSingletonDialog("mainline.offlinepvp.offlinepvpemptydialog")
    return
  end
  NekoData.DataManager.DM_Activity:SetKeyExchangeTimes(protocol.apAddTimes)
  NekoData.DataManager.DM_Activity:SetArenaSeasonId(protocol.seasonId)
  NekoData.DataManager.DM_Activity:SetArenaId(protocol.arenaId)
  NekoData.DataManager.DM_Activity:SetArenaCamp(protocol.camp)
  NekoData.DataManager.DM_Activity:SetArenaEndDay(protocol.leftTime)
  local camp = protocol.camp
  if camp == SOpenArenaPanelProtocols.NOCAMP then
    if protocol.firstEnter == 1 then
      local dialog1 = DialogManager.CreateSingletonDialog("mainline.offlinepvp.campselectiondialog")
      if dialog1 then
        dialog1:Init(protocol.arenaId)
      end
      local dialog2 = DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog")
      if dialog2 then
        local dialogId = CArenaSeasonConfig:GetRecorder(protocol.arenaId).startDialog
        dialog2:SetDialogLibraryId(dialogId, true, dialog2.DialogType.Arena)
      end
    else
      local dialog = DialogManager.CreateSingletonDialog("mainline.offlinepvp.campselectiondialog")
      if dialog then
        dialog:Init(protocol.arenaId)
      end
    end
  end
end

local function p2(protocol, client)
end

return {p1, p2}
