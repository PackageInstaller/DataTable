local M = BaseClass("HeroGene5RedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end
    if param == -1 then
        self.checkResult = 0
        return
    end
    local isShow = false
    local heroData = IHeroDataMgr:GetMyHeroDataById(param)
    isShow = DevelopMgr:GetInstance():IsUpRoleGene(heroData, 5)
    self.checkResult = isShow and 1 or 0
end


return M
