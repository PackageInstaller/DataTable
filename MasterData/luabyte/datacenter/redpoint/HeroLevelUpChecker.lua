---英雄升级红点
local HeroLevelUpChecker = BaseClass("HeroLevelUpChecker",require("DataCenter.RedPoint.BaseRedPointChecker") )
local M = HeroLevelUpChecker

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end
    local heroId = 0 
    if param and param > 0 then
        heroId = param
    end
    local fromIdx = 1 
    local allHeros = nil
    local heroMaxIdx = 0
    if heroId == 0 then 
        allHeros = IHeroDataMgr:GetHeros()
        fromIdx = 0
        heroMaxIdx = allHeros.Length - 1 
    else
        allHeros = {IHeroDataMgr:GetMyHeroDataById(heroId)}
        fromIdx = 1
        heroMaxIdx = 1
    end
    
    for i = fromIdx , heroMaxIdx do
        local heroData = allHeros[i]
        if IsNull(heroData) then 
            self.checkResult = 0 
            return 
        end
        local heroLevel = heroData:GetLevel()
        local userLevel = IPlayerData.level
        if heroLevel < userLevel then 
            local heroLevelCostCfg = ConfigHelper.GetCfg("heroLevelcost",heroLevel)
            local isEnough = true
            for n = 1 , #heroLevelCostCfg.needItem do 
                local needItemId = heroLevelCostCfg.needItem[1]
                local needItemNum = heroLevelCostCfg.needNum[1]
                if isEnough == false and not GameHelper.CheckItem( needItemId , needItemNum ) then 
                    isEnough = false
                end
            end
            if isEnough then 
                self.checkResult = 1
            else
                self.checkResult = 0 
            end
        end
    end
end

return HeroLevelUpChecker