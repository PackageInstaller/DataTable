local testSubC = class("testSubC", require("testSubA"))

function testSubC:ctor(abc)
    
    self.super:ctor(3)
end

function testSubC:Init(abc)
end

function testSubC:Print()
    self.super:Print("testSubC")

end

return testSubC