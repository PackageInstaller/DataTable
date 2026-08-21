-- 基因首次激活红点
local BaseRedPointChecker = require("DataCenter.RedPoint.BaseRedPointChecker")
local M = BaseClass("HeroGeneAllRedPointChecker", BaseRedPointChecker)

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end
    if param == -1 then
        self.checkResult = 0
        return
    end
    local isShow
    if param > 0 then
        isShow = self:IsHero(param)
    else
        isShow = self:IsAll()
    end

    self.checkResult = isShow and 1 or 0
end

function M:IsAll()
    local heroDadas = IHeroDataMgr:GetHeros()
    local count = heroDadas.Count

    for i = 0, count - 1 do
        local data = heroDadas[i]
        if self:HeroUpGene(data) then
            return true
        end
    end

    return
end

function M:IsHero(id)
    local heroData = IHeroDataMgr:GetMyHeroDataById(id)
    return self:HeroUpGene(heroData)
end

function M:HeroUpGene(heroData)
    local geneStar = heroData:GetGenesStars()
    local stars = {0, 0, 0, 0, 0}

    if geneStar then
        local length = geneStar.Length
        for i = 0, length - 1 do
            stars[i + 1] = geneStar[i]
        end
    end
    -- 并且资源足够，显示红点
    for i, v in ipairs(stars) do
        if DevelopMgr:GetInstance():IsUpRoleGene(heroData, i) then
            return true
        end
    end

    return false
end

return M
