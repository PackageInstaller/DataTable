local TestChannel = BaseClass("TestChannel", BaseChannel)
local base = BaseChannel

-- 构造函数
local function __init(self)
    base.__init(self, ChannelType.Test)
    base.OnInit(self, "com.romanzone.ss", 0, ChannelCurrency.JA, false)
end

TestChannel.__init = __init

return TestChannel