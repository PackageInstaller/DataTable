local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local ChannelType = dataclass("ChannelType")
ChannelType.CHANNEL_SYSTEM = 1
ChannelType.CHANNEL_WORLD = 2
ChannelType.CHANNEL_PARTY = 3
ChannelType.CHANNEL_FRIEND = 4

function ChannelType:Ctor()
end

function ChannelType:Marshal(buffer)
  return true
end

function ChannelType:Unmarshal(buffer)
  local ret = true
  return ret
end

return ChannelType
