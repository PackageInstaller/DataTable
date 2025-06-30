-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/userbeanimport.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local UserBeanImport = dataclass("UserBeanImport", require("framework.net.protocol"))
UserBeanImport.ProtocolType = 2010
UserBeanImport.MaxSize = 65535
UserBeanImport.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : UserBeanImport, _ENV
  ((UserBeanImport.super).Ctor)(self, client)
  self.guideTypes = ((require("protocols.bean.protocol.user.guidtypes")).Create)()
  self.sysConfig = ((require("protocols.bean.protocol.user.sysconfig")).Create)()
  self.bookType = ((require("protocols.bean.protocol.user.handbooktype")).Create)()
end

UserBeanImport.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.guideTypes):Marshal(buffer) then
    return false
  end
  if not (self.sysConfig):Marshal(buffer) then
    return false
  end
  if not (self.bookType):Marshal(buffer) then
    return false
  end
  return true
end

UserBeanImport.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.guideTypes):Unmarshal(buffer) then
    return false
  end
  if not (self.sysConfig):Unmarshal(buffer) then
    return false
  end
  if not (self.bookType):Unmarshal(buffer) then
    return false
  end
  return ret
end

return UserBeanImport

