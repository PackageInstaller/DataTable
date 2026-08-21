-- 突破成功界面
-- 预制体  CommonBreachUI
local UIAdvancedCtrl = BaseClass("UIAdvancedCtrl", BaseUICtrl)
local M = UIAdvancedCtrl
local EAttributeType = EnumConst.EAttributeType
local tInsert = table.insert
local sfmt = string.format
local ATTRNUM = 5

function M:Init()
    self._view.btnMask:onClick(Bind(self, self.Close))
    self.tabItem = {}
end

function M:OnEnter(heroId, breakLv, closeFunc)
    self.closeFunc = closeFunc
    self.heroData = IHeroDataMgr:GetMyHeroDataById(heroId)
    self.heroId = heroId
    self.breakLv = breakLv
    local rare = ConfigHelper.GetCfgPropByLua("hero", heroId, "rare")
    self._view.UIBreakCtrl:Updata(rare, breakLv)
    local geneStars = {0, 0, 0, 0, 0}
    local tempGeneStars = self.heroData:GetGenesStars()

    if tempGeneStars then
        for i = 0, tempGeneStars.Length - 1 do
            geneStars[i + 1] = tempGeneStars[i]
        end
    end

    local heroAiStars = {}

    for i = 1, #geneStars do
        local star = geneStars[i]

        if geneStars[i] > 0 then
            local heroAi = ConfigHelper.GetCfgsByLua("heroAi", {heroId=heroId, slot=i})
            local heroAiStar = ConfigHelper.GetCfgsByLua("heroAiStar", {aiType=heroAi[1].aiType, star=star})
            tInsert(heroAiStars, heroAiStar[1])
        end
    end

    local allAttributeType = {EAttributeType.EAT_MaxHP, EAttributeType.EAT_Damage, EAttributeType.EAT_DamageDef, EAttributeType.EAT_MagicDef, EAttributeType.EAT_MaxArmor}
    local lv = self.heroData:GetLevel()
    local nowHeroBreak = ConfigHelper.GetCfgsByLua("heroBreak", Bind(self, self.GetHeroBreakFunc))
    for i = 1, ATTRNUM do
        local attributeId = allAttributeType[i]
        local oldAtt = self.heroData:GetDevelopAttribute(attributeId, lv, self.breakLv - 1)
        local newAtt = self.heroData:GetDevelopAttribute(attributeId, lv, self.breakLv)
        self._view["Attr" .. i]:Update(attributeId, oldAtt, newAtt)
    end

    self:_InitTips(nowHeroBreak[0].breakDes)
end

function M:GetHeroBreakFunc(heroBreak)
    if heroBreak.hero == self.heroId and heroBreak.breakLevel == self.breakLv then
        return true
    end
end

function M:_InitTips(breakDes)
    self._view.UnlockItem:SetActive(false)

    if breakDes.Length <= 0 or breakDes[0] <= 0 then
        self._view.tfTips.gameObject:SetActive(false)
        return
    end

    for i = 0, breakDes.Length - 1 do
        local tips = nil

        if breakDes[i] == 2026 then
            tips = ConfigHelper.GetLocalString(breakDes[0])
            local heroPersona = ConfigHelper.GetCfgByLua("heroPersona", self.heroData:GetSkinId())
            local storyLimit = heroPersona.storyLimit

            for k, v in pairs(storyLimit) do
                if v == self.breakLv then
                    local storyTitle = heroPersona.storyTitle[k]
                    storyTitle = ConfigHelper.GetLocalString(storyTitle)
                    tips = sfmt(tips, storyTitle)
                    break
                end
            end
        else
            tips = breakDes[i]
        end

        local UnlockItem = self.tabItem[i + 1]

        if not UnlockItem then
            UnlockItem = self._view.UnlockItem:Instantiate()
            tInsert(self.tabItem, UnlockItem)
        end
        UnlockItem:UpdateData(tips)
        UnlockItem:SetActive(true)
    end

    self._view.tfTips.gameObject:SetActive(true)
end

-- 点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:Close()
    if self.closeFunc then
        self.closeFunc()
    end
    M.super.Close(self)
end

function M:OnDispose()
    for k, value in ipairs(self.tabItem) do
        CS.UnityEngine.GameObject.Destroy(value.gameObject)
        value:OnDestroy()
    end
    M.super.OnDispose(self)
end

return UIAdvancedCtrl
