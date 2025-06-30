-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/friendchat/sgetfriendchat.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SGetFriendChat = dataclass("SGetFriendChat")
SGetFriendChat.ProtocolType = 105
SGetFriendChat.clientId = 0
SGetFriendChat.userId = 0
SGetFriendChat.Ctor = function(self, client)
  -- function num : 0_0
  self.msgs = {}
end

SGetFriendChat.Marshal = function(self, data)
  -- function num : 0_1 , upvalues : _ENV
  data.clientId = self.clientId
  data.userId = self.userId
  data.msgs = {}
  for index,value in ipairs(self.msgs) do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R7 in 'UnsetPending'

    (data.msgs)[index] = {}
    ;
    ((self.msgs)[index]):Marshal((data.msgs)[index])
  end
end

SGetFriendChat.Unmarshal = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  self.clientId = data.clientId
  self.userId = data.userId
  for index,value in ipairs(data.msgs) do
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R7 in 'UnsetPending'

    (self.msgs)[index] = ((require("localprotocols.bean.data.friendchatinfo")).Create)()
    ;
    ((self.msgs)[index]):Unmarshal((data.msgs)[index])
  end
  return true
end

SGetFriendChat.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.clientId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.clientId) = %s. number required.", type(self.clientId))
    return false
  end
  if type(self.userId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.userId) = %s. number required.", type(self.userId))
    return false
  end
  if type(self.msgs) ~= "table" then
    LogErrorFormat("LocalProtocols", "type error!type(self.msgs) = %s. table required.", type(self.msgs))
    return false
  end
  for index,value in ipairs(self.msgs) do
    if not value:CheckVariable() then
      return false
    end
  end
  return true
end

return SGetFriendChat

