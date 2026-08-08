local testSubD = class("testSubD", require("testSubA"))

function testSubD:ctor(abc)
    
    self.super:ctor(4)
end

function testSubD:Init(abc)
end

function testSubD:Print()
    self.super:Print("testSubD")
end

return testSubD