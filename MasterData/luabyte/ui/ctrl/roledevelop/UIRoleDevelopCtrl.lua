-- baoruichang
-- 2022/11/24 19:55:19
-- RoleDevelopUI_New
local UIRoleDevelopCtrl = BaseClass("UIRoleDevelopCtrl", BaseUICtrl)
local M = UIRoleDevelopCtrl
local EQuality = EnumConst.EQuality
local GeneOpenId = EnumConst.GeneOpenId
local AwakeOpenId = EnumConst.AwakeOpenId

function M:Init()
    self:_InitConf()
    self._view.charPicBtn:SetOnClick(self, self._OnClickCharPic)
    self._clickRoleInfoHandler = Bind(self, self._ClickRoleInfo)
    self._refreshData = EventMgr:AddListener(UIMessageNames.ROLE_DEVELOP_REFRESH_DATA, Bind(self, self._SetHeroInfo))
    self._tempOnPosClick = EventMgr:AddListener(UIMessageNames.ROLE_LIST_POS, Bind(self, self._OnPosClick))
    self._view.UISkillClassCtrl:SetOnClick(Bind(self, self._onClickTab, 1))
    self._view.UIAwakeClassCtrl:SetOnClick(Bind(self, self._onClickTab, 5))
    self._view.UIGeneClassCtrl:SetOnClick(Bind(self, self._onClickTab, 3))
    self._view.UICore2Ctrl:SetOnClick(Bind(self, self._onClickTab, 2)) -- 核心
    self._view.btnInfo:onClick(Bind(self, self._onClickTab, 4)) -- 资料
    self._view.btnSkin:onClick(Bind(self, self._onBtnSkinClick))
    self._view.btnProfession:onClick(Bind(self, self._OnBtnClickProfession))
end

function M:_InitConf()
    self.system187 = ConfigHelper.GetSystemParams(187) -- 达到最高突破等级后等级上限增加值
    self.skillShowLv = ConfigHelper.GetSystemParams(347)
    self.geneShowLv = ConfigHelper.GetSystemParams(348)
    self.coreShowLv = ConfigHelper.GetSystemParams(349)
    self.awakeShowLv = ConfigHelper.GetSystemParams(350)
end

function M:OnEnter(baseCtrl, heroId)
    self._baseCtrl = baseCtrl
    self:_SetHeroInfo(heroId)
end

function M:_OnBtnClickProfession()
    UIContextMgr:GetInstance():Show(UIDefine.UIProfessional)
end

-- 立绘
function M:_OnClickCharPic()
    local isAwake = self.heroData:IsAwake()
    local skinId = self.heroData:GetSkinId()
    UIContextMgr:GetInstance():Show("ShowGirlUI", skinId, isAwake)
end

function M:_SetHeroInfo(heroId)
    self.heroId = heroId
    self.heroData = IHeroDataMgr:GetMyHeroDataById(self.heroId)
    self.rare = ConfigHelper.GetCfgPropByLua("hero", self.heroId, "rare")
    self.curhero = self.heroData:GetHeroCfg()
    self:_UpdateInfo(self.heroData)
    self._view.infoRedPoint:SetParam(0, self.heroId)
    self._view.infoRedPoint:Check()
    self:InitBtnState()
    DevelopHelper.SetDrag(true)
end

function M:InitBtnState()
    -- 基因
    local state = self:_getGeneState(self.rare, self.lv)
    self._view.UIGeneClassCtrl:SetActive(state)
    -- if state then
    --     local isOpen, openLv = self:_getGeneOpen(self.heroId, self.rare)
    --     self._view.UIGeneClassCtrl:SetState(isOpen and 2 or 1, openLv)
    -- end
    -- 核心
    state = self:_getCoreState(self.rare, self.lv)
    self._view.UICore2Ctrl:SetActive(state)
    -- 技能
    state = self:_getSkillState(self.rare, self.lv)
    self._view.UISkillClassCtrl:SetActive(state)
    -- 跃迁
    state = self:_getAwakeState(self.rare, self.lv)
    self._view.UIAwakeClassCtrl:SetActive(state)
    -- if state then
    --     local isOpen, openLv = self:_getAwakeOpen(self.heroId, self.rare)
    --     self._view.UIAwakeClassCtrl:SetState(isOpen and 2 or 1, openLv)
    -- end
end

function M:_UpdateInfo(heroData)
    self._view.roleInfo:SetInfo(heroData, self._clickRoleInfoHandler)
    self._view.UICore2Ctrl:Updata(heroData:GetCoreLevel() or 0)
    local breakLevel = self.heroData:GetBreakLevel() or 0
    self._view.breakClass:Updata(self.rare, breakLevel)
    local skillLv = heroData:GetSkillLevel()
    self._view.UISkillClassCtrl:UpdataData(skillLv)
    local awakeLv = heroData:GetAwakeLevel()
    self._view.UIAwakeClassCtrl:UpdateData(awakeLv, self:_getMaxAwake())
    self:_InitLevel()
    self._view.UIBreakCtrl:Updata(self.rare, breakLevel)
    local geneLv = heroData:GetGeneStar()
    self._view.UIGeneClassCtrl:Update(geneLv)
    self._view.CoreRedpoint:SetParam(0, self.heroId)
    self._view.CoreRedpoint:Check()
    self._view.GeneRedpoint:SetParam(0, self.heroId)
    self._view.GeneRedpoint:SetParam(1, self.heroId)
    self._view.GeneRedpoint:Check()
    self._view.AwakeRedpoint:SetParam(0, self.heroId)
    self._view.AwakeRedpoint:Check()
end

function M:_onBtnSkinClick()
    UIContextMgr:GetInstance():Show("RoleFashionUI", self.heroData:GetHeroId())
    -- UIContextMgr:GetInstance():Show(UIDefine.UISkin)
end

function M:_InitLevel()
    local breakLevel = self.heroData:GetBreakLevel() or 0
    self._curBreak = CS.GameBase.JHeroBreak.GetBreak(self.heroId, breakLevel)
    self._nextBreak = CS.GameBase.JHeroBreak.GetBreak(self.heroId, breakLevel + 1)
    self.lv = self.heroData:GetLevel()

    if self._nextBreak then
        self.maxLevel = self._nextBreak.needLevel
    else
        self.rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(self.heroId)
        local addLv = self.system187[self.rare - 1]
        local favorUpLv = self.rshd.upLevel
        self.maxLevel = self._curBreak.needLevel + addLv + favorUpLv
    end

    self._view.labLv1:SetText(tostring(self.lv))
    self._view.labLv2:SetText(tostring(self.maxLevel))
end

function M:_getMaxAwake()
    local maxAwake = 0
    if self.rare == EQuality.SR then
        maxAwake = 3
    elseif self.rare == EQuality.SSR then
        maxAwake = 6
    end
    return maxAwake
end

function M:_ClickRoleInfo()
    self:_onClickTab(0)
end

function M:_onClickTab(idx)
    self._baseCtrl:SetTabSelect(idx)
end

function M:_OnPosClick(idx)
    self._view.statePos:SetState(idx)
end

---获取技能页签是否显示
function M:_getSkillState(rare, lv)
    return lv >= self.skillShowLv[rare - 1]
end

---获取基因页签是否能显示
function M:_getGeneState(rare, lv)
    return lv >= self.geneShowLv[rare - 1]
end

function M:_getCoreState(rare, lv)
    return lv >= self.coreShowLv[rare - 1]
end

---获取跃迁页签是否显示
function M:_getAwakeState(rare, lv)
    if rare <= EQuality.R then
        return false
    end
    return lv >= self.awakeShowLv[rare - 3]
end

-- 基因是否开放
function M:_getGeneOpen(heroId, rare)
    local showCondition = ConfigHelper.GetCfgPropByLua("functionOpen", GeneOpenId[rare], "showCondition")
    for _, conditionId in pairs(showCondition) do
        local isOpen = GameHelper.CheckLockByOpenConditionId(conditionId, heroId)
        if not isOpen then
            local openCondition = ConfigHelper.GetCfg("openCondition", conditionId)
            return nil, openCondition.unlockParam2
        end
    end
    return true
end

-- 跃迁是否开放
function M:_getAwakeOpen(heroId, rare)
    local showCondition = ConfigHelper.GetCfgPropByLua("functionOpen", AwakeOpenId[rare], "showCondition")
    for _, conditionId in pairs(showCondition) do
        local isOpen = GameHelper.CheckLockByOpenConditionId(conditionId, heroId)
        local openCondition = ConfigHelper.GetCfg("openCondition", conditionId)
        if not isOpen then
            return nil, openCondition.unlockParam2
        end
    end
    return true
end

function M:OnDispose()
    self.baseCtrl = nil
    EventMgr:RemoveListener(UIMessageNames.ROLE_LIST_POS, self._tempOnPosClick)
    self:_RemoveListener(UIMessageNames.ROLE_DEVELOP_REFRESH_DATA, self._refreshData)
    M.super.OnDispose(self)
end

return UIRoleDevelopCtrl
