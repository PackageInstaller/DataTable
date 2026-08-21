local AddressBookRedPointChecker = BaseClass("AddressBookRedPointChecker",require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = AddressBookRedPointChecker

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end
    
    self.checkResult = ComRoomDataMgr:GetInstance():GetUnreadCount(param)
end


return AddressBookRedPointChecker