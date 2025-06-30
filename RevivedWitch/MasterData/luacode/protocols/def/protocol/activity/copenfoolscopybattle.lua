-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/copenfoolscopybattle.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenFoolsCopyBattle = dataclass("COpenFoolsCopyBattle", require("framework.net.protocol"))
COpenFoolsCopyBattle.ProtocolType = 2635
COpenFoolsCopyBattle.MaxSize = 65535
COpenFoolsCopyBattle.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenFoolsCopyBattle
  ((COpenFoolsCopyBattle.super).Ctor)(self, client)
end

COpenFoolsCopyBattle.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

COpenFoolsCopyBattle.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return COpenFoolsCopyBattle

