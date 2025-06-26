-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/chat/schangesubchannel.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.chat.cchangesubchannel")
  ;
  ((NekoData.DataManager).DM_Chat):OnSChangeSubChannel(protocol)
  if protocol.num == req.FLAG_CHANNEL_FULL then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100186)
  else
    if protocol.num == req.FLAG_CHANNEL_INEXISTENT then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100187)
    end
  end
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_SubChannelChange, nil, nil)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

