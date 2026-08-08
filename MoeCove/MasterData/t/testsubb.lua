local testSubB = class("testSubB", require("testBase"))

function testSubB:ctor(abc)
    
    self.super:ctor(2)
end

function testSubB:Init(abc)
end

function testSubB:Print()
    for k,v in pairs(self.super.uiTable) do
        print("testSubB",k,v)
    end

    print("super", self.super)
end

return testSubB