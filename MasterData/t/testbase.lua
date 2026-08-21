local testBase = class("testBase")

function testBase:ctor(abc)
    self.uiTable = {}
    self:Init(abc)
    
end

function testBase:Init(abc)
    if abc == 1 then
        self.uiTable["subA"] = 1
    elseif abc == 2 then
        self.uiTable["subB"] = 2
    elseif abc == 3 then
        self.uiTable["subC"] = 3
    elseif abc == 4 then
        self.uiTable["subD"] = 4
    end
end

return testBase