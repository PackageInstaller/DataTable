local DormitoryDressupSuitPopupContext = BaseClass("DormitoryDressupSuitPopupContext", BaseContext)
local M = DormitoryDressupSuitPopupContext

local function SortFurnitures(data1, data2)
    return data1.num > data2.num
end

function M:Init()
    self.dormAction = DormActionMgr:GetInstance():GetCurrentDormAction()
    self.module = ModuleMgr:GetInstance():GetCurrentModule()
end

function M:Open(data)
    self:_Show(data)
end

function M:_Destory()
    M.super._Destory(self)
end

function M:OnDispose()
    M.super.OnDispose(self)
end

return DormitoryDressupSuitPopupContext
