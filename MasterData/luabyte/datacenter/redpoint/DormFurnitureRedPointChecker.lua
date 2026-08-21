local M = BaseClass("DormFurnitureRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end

    self.checkResult = OtakuFurniturDataMgr:CheckFurnitureRedPoint(param) and 1 or 0
end

return M
