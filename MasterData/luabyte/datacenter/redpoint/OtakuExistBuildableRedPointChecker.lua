local OtakuExistBuildableRedPointChecker = BaseClass("OtakuExistBuildableRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = OtakuExistBuildableRedPointChecker

function M:__init()
    self.dataCenterId = { EGetterID.ShopData }
end

function M:Check(type)
    if not self:OnChanged(type) then
        return 
    end
    self.checkResult = OtakuRoomDataMgr:GetInstance():CheckRedDotInOtaku() and 1 or 0
end

return M