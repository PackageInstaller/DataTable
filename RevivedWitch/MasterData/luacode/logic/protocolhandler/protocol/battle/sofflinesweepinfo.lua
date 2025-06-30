-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/battle/sofflinesweepinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  LogInfoFormat("sofflineSweepinfo", "-battleType:%s status:%s,id:%s,leftTime:%s,totalNum:%s,leftNum:%s", protocol.battleType, protocol.status, protocol.id, protocol.leftTime, protocol.totalNum, protocol.leftNum)
  ;
  ((NekoData.DataManager).DM_OfflineSweep):OnSOfflineSweepInfo(protocol)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshOfflineSweepActive, nil)
  local dialog = (DialogManager.GetDialog)("teamedit.teameditprewardialog")
  if dialog and dialog:IsCurCopyTypeDispatch() then
    (DialogManager.DestroySingletonDialog)("teamedit.teameditprewardialog")
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

