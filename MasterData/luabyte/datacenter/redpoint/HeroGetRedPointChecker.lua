local HeroGetRedPointChecker = BaseClass("HeroGetRedPointChecker",require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = HeroGetRedPointChecker

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end

    self.checkResult = DevelopMgr:GetInstance():IsNewHero(param) and 1 or 0
end

return HeroGetRedPointChecker