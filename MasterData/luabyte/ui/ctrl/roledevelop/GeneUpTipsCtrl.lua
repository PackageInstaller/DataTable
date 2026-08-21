local GeneUpTipsCtrl = BaseClass("GeneUpTipsCtrl", require("UI.Ctrl.Common.BaseSubCtrl"))
local M = GeneUpTipsCtrl
local MAXSTAR = 6
local mCeil = math.ceil

function M:OpenPanel(heroId)
    self.heroId = heroId
    self.heroData = IHeroDataMgr:GetMyHeroDataById(heroId)
    self._star = self:_CalculateLevel()
    self:_InitData()
    self:_Init()
end

function M:PlayAnimation(star, callback)
    self._playStar = star
    self._endCallBack = callback
    self._view.animator:Play("GeneTips" .. star)
    self._delayTimer = TimerManager:GetInstance():GetTimer(2, Bind(self, self._OnDelayTimerComplete), nil, true)
    self._delayTimer:Start()
end

function M:_OnDelayTimerComplete()
    if self._delayTimer then
        self._delayTimer:Stop()
        self._delayTimer = nil
    end

    for i = 1, self._playStar do
        local name = "state" .. i
        self._view[name]:SetState(1)
    end

    if self._endCallBack then
        self._endCallBack();
        self._endCallBack = nil;
    end
end

function M:_InitData()
    self.heroAiEffects = ConfigHelper.GetCfgsByLua("heroAiEffect", {heroId=self.heroId})
    self.heroAiEffect = self.heroAiEffects[self._star] or self.heroAiEffects[1]
end

function M:_Init()
    self._view.imgStar.unity_uiimage.fillAmount = self._star / MAXSTAR
    self._view.Name:SetText(self.heroAiEffect.name)
    self._view.imgProfession:SetProfessional(self.heroId)
    for i = 1, MAXSTAR do
        local state = self._star >= i
        local alpha = state and 255 or 51
        self._view["title" .. i]:SetColor(255, 255, 255, alpha)
        self._view["Detail" .. i]:Update(state, self.heroAiEffects[i].detailDesc)
    end
    -- for i = 1, MAXSTAR / 2 do
    --     local groupState = mCeil(self._star / 2) >= i
    --     alpha = groupState and 255 or 51
    --     self._view["titleGroup" .. i]:SetColor(255, 255, 255, alpha)
    -- end
end

function M:_CalculateLevel()
    local tempStar = 100
    local Stars = self.heroData:GetGenesStars()
    if Stars == nil then
        return 0
    else
        for i = 0, Stars.Length - 1 do
            tempStar = tempStar < Stars[i] and tempStar or Stars[i]
        end
    end
    return tempStar
end

function M:OnDispose()
    if self._delayTimer then
        self._delayTimer:Stop()
        self._delayTimer = nil
    end
    M.super.OnDispose(self)
end

return GeneUpTipsCtrl
