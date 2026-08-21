local FriendApplyRedPointChecker = BaseClass("FriendApplyRedPointChecker",require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = FriendApplyRedPointChecker

function M:__init()
    self.dataCenterId = {EGetterID.FriendApply}    
end

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end
    
    local num = FriendDataMgr:GetInstance():GetApplyFriendNumMax()
    self.checkResult = num
end


return FriendApplyRedPointChecker