-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/srefreshfoolsdaysinglerole.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRefreshFoolsDaySingleRole = dataclass("SRefreshFoolsDaySingleRole", require("framework.net.protocol"))
SRefreshFoolsDaySingleRole.ProtocolType = 2631
SRefreshFoolsDaySingleRole.MaxSize = 65535
SRefreshFoolsDaySingleRole.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRefreshFoolsDaySingleRole, _ENV
  ((SRefreshFoolsDaySingleRole.super).Ctor)(self, client)
  self.role = ((require("protocols.bean.protocol.activity.foolsdayrole")).Create)()
end

SRefreshFoolsDaySingleRole.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.role):Marshal(buffer) then
    return false
  end
  return true
end

SRefreshFoolsDaySingleRole.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.role):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SRefreshFoolsDaySingleRole

