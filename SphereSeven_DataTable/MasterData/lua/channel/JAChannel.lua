local JAChannel = BaseClass("JAChannel", BaseChannel)
local base = BaseChannel

local function __init(self)
    base.__init(self, ChannelType.JA)
    base.OnInit(self, "com.romanzone.ss", -1, ChannelCurrency.JA, true)
end

JAChannel.__init = __init

return JAChannel