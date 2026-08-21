local M = BaseClass("DormFurnitureTypeRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end

    self.checkResult = OtakuFurniturDataMgr:CheckFurnitureTypeRedPoint(param) and 1 or 0
end

return M
