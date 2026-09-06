local function p1(protocol)
  LogInfoFormat("sofflineSweepinfo", "-battleType:%s status:%s,id:%s,leftTime:%s,totalNum:%s,leftNum:%s", protocol.battleType, protocol.status, protocol.id, protocol.leftTime, protocol.totalNum, protocol.leftNum)
  
  local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
  if protocol.battleType ~= CBattleStartProtocol.ANNIVERSARY then
    NekoData.DataManager.DM_OfflineSweep:OnSOfflineSweepInfo(protocol)
    LuaNotificationCenter.PostNotification(Common.n_RefreshOfflineSweepActive, nil)
  end
  local dialog = DialogManager.GetDialog("teamedit.teameditprewardialog")
  if dialog and dialog:IsCurCopyTypeDispatch() then
    DialogManager.DestroySingletonDialog("teamedit.teameditprewardialog")
  end
end

local function p2(protocol, client)
end

return {p1, p2}
