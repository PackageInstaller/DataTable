local M = BaseClass("MissionOfferRewardsRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))

function M:Check()
    self.checkResult = 0
    self.isChecking = true
    UIContextMgr:GetInstance():GetContext("MissionOfferRewards"):CheckAwardRedPoint(function(isShow)
        self.checkResult = isShow and 1 or 0
        self.isChecking = false
    end)
end

return M
