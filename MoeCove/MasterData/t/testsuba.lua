local testSubA = class("testSubA", require("testBase"))

function testSubA:ctor(abc)

    if abc == nil then
        self.super:ctor(1)
    else
        self.super:ctor(nil)
    end
    
    --self.super:ctor(abc)
end

function testSubA:Init(abc)
end

function testSubA:Print(xx)
    if xx == nil then
        xx = "testSubA"
    end
    for k,v in pairs(self.super.uiTable) do
        print(xx, k,v)
    end
    print("super", self.super)
end

return testSubA