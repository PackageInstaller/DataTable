-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/friendchat/cstorefriendchat.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStoreFriendChat = dataclass("CStoreFriendChat")
CStoreFriendChat.ProtocolType = 103
CStoreFriendChat.userId = 0
CStoreFriendChat.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : _ENV
  self.msg = ((require("localprotocols.bean.data.friendchatinfo")).Create)()
end

CStoreFriendChat.Marshal = function(self, data)
  -- function num : 0_1
  data.userId = self.userId
  data.msg = {}
  ;
  (self.msg):Marshal(data.msg)
end

CStoreFriendChat.Unmarshal = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  self.userId = data.userId
  self.msg = ((require("localprotocols.bean.data.friendchatinfo")).Create)()
  ;
  (self.msg):Unmarshal(data.msg)
  return true
end

CStoreFriendChat.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.userId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.userId) = %s. number required.", type(self.userId))
    return false
  end
  if not (self.msg):CheckVariable() then
    return false
  end
  return true
end

return CStoreFriendChat

