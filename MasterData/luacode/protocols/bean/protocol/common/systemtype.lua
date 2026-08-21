-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/common/systemtype.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SystemType = dataclass("SystemType")
SystemType.WINDOWS = 0
SystemType.IOS = 1
SystemType.ANDROID = 2
SystemType.UNITY = 3
SystemType.MAC = 4
SystemType.LINUX = 5
SystemType.Ctor = function(self)
  -- function num : 0_0
end

SystemType.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

SystemType.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return SystemType

