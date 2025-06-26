-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/npc/svisitnpc.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("login.eventreconnectdialog")
  local userinfo = {}
  userinfo.npcID = protocol.npcId
  userinfo.services = protocol.serviceIds
  userinfo.effectId = protocol.effectid
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_NPCServerListReceive, nil, userinfo)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

