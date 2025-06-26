-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/party/boss/spartybosspanelinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_Guild):OnPartyBossPanelInfoProcess(protocol)
  local dialog = (DialogManager.CreateSingletonDialog)("guildboss.guildbossmaindialog")
  dialog:Init()
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_GuildBossInfo, nil, nil)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

