-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/chat/channeltype.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local ChannelType = dataclass("ChannelType")
ChannelType.CHANNEL_SYSTEM = 1
ChannelType.CHANNEL_WORLD = 2
ChannelType.CHANNEL_PARTY = 3
ChannelType.CHANNEL_FRIEND = 4
ChannelType.Ctor = function(self)
  -- function num : 0_0
end

ChannelType.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

ChannelType.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return ChannelType

