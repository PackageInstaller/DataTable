-- baoruichang
-- 2022/12/1 10:34:15
-- RoleAwakeUINew   UIAwake
local UIAwakeCtrl = BaseClass("UIAwakeCtrl", BaseUICtrl)
local M = UIAwakeCtrl
local tInsert = table.insert
local tIndexof = table.indexof
local sfmt = string.format
local EQuality = EnumConst.EQuality
local AwakeOpenId = EnumConst.AwakeOpenId
local JBattleLevel = CS.GameBase.JBattleLevel

function M:Init()
    self.tabArrt = {self._view.ItemAttr}
    self._view.stateBtn1:onClick(Bind(self, self._OnBtnAwakeClick))
    self._view.btnMask:onClick(Bind(self, self._OnClickIcom))
end

-- 进入UI，可传参数
function M:OnEnter(heroId)
    self.heroId = heroId
    self._tempOnSwitch = EventMgr:AddListener(UIMessageNames.ROLE_DEVELOP_REFRESH_DATA, Bind(self, self._OnSwitchHero))
    self._tempOnRefHero = EventMgr:AddListener(UIMessageNames.ROLE_DEVELOP_AWAKE, Bind(self, self._OnRefHero))
    self:_InitRight()
    self._view.roleAwakeRedpoint:SetParam(0, heroId)
    self._view.roleAwakeRedpoint:Check()
end

function M:_OnRefHero(heroId)
    if heroId ~= self.heroId then
        return
    end
    -- 觉醒成功后刷新页面
    self:_InitRight()
    self._view.roleAwakeRedpoint:SetParam(0, self.heroId)
    self._view.roleAwakeRedpoint:Check()
end

-- 切换英雄
function M:_OnSwitchHero(heroId)
    if self.heroId == heroId then
        return
    end
    self.heroId = heroId
    self:_InitRight()
end

function M:_InitRight()
    self.heroData = IHeroDataMgr:GetMyHeroDataById(self.heroId)
    local hero = ConfigHelper.GetCfg("hero", self.heroId)
    self.rare = hero.rare
    self.awakeLevel = self.heroData:GetAwakeLevel()
    self.heroAwakes = ConfigHelper.GetCfgsByLua("heroAwake", {heroId=self.heroId})
    self._view.labName:SetAvatarName(self.heroId, RoleType.ERT_Hero)
    self._view.imgQuality:SetHeroRare(self.heroId)
    local illustration = ConfigHelper.GetCfgPropByLua("resource", self.heroId, "illustration")
    self._view.rawImgIcon:SetPic(illustration)
    local positionAwake = hero.positionAwake
    if IsNull(positionAwake) or positionAwake.Length < 2 then
        positionAwake = {}
        positionAwake[0] = 0
        positionAwake[1] = 0
    end
    self._view.rawImgIcon.rectTransform.anchoredPosition = Vector2(positionAwake[0] / 1000, positionAwake[1] / 1000)
    self._view.labNum1:SetText(tostring(self.awakeLevel))
    self._view.labNum2:SetText("/" .. (self.rare == EQuality.SSR and 6 or 3))
    self._view.stateNum:SetState(self.awakeLevel > 0 and 2 or 1)
    self:_InitProp()
    self:_InitAttr()
    self:_InitSkill()
    self:_InitBtnState()
end

function M:_InitBtnState()
    self.lockBtn = nil
    local tips
    local showCondition = ConfigHelper.GetCfgPropByLua("functionOpen", AwakeOpenId[self.rare], "showCondition")
    for _, conditionId in pairs(showCondition) do
        local isOpen = GameHelper.CheckLockByOpenConditionId(conditionId, self.heroId)
        if not isOpen then
            self.lockBtn = true
            local openCondition = ConfigHelper.GetCfg("openCondition", conditionId)
            tips = ConfigHelper.GetLocalString(openCondition.tips)
            local heroName = ConfigHelper.GetHeroName(self.heroId)
            tips = sfmt(tips, heroName, openCondition.unlockParam2)
            self._view.labLock:SetText(tips)
            break
        end
    end
    self._view.stateBtn:SetState(self.lockBtn and 2 or 1)
    if tips then
        self._view.labLock:SetText(tips)
    end
end

function M:_InitProp()
    -- self.stateProp
    local heroAwakeProp = nil
    for _, heroAwake in pairs(self.heroAwakes) do
        if tIndexof(heroAwake.effectType, 1) then
            heroAwakeProp = heroAwake
            break
        end
    end
    if not heroAwakeProp then
        return
    end
    local isOpen = self.awakeLevel >= heroAwakeProp.level
    self._view.stateProp:SetState(isOpen and 1 or 2)
    if not isOpen then
        local openTips = sfmt(ConfigHelper.GetLocalString(5804), heroAwakeProp.level)
        self._view.labGet:SetText(openTips)
    end
end

function M:_InitAttr()
    for k, attributeType in ipairs(self.heroAwakes[1].attributeType) do
        local ItemAttr = self.tabArrt[k]
        local itemAttrData = {}
        itemAttrData.id = attributeType
        itemAttrData.num = self.heroAwakes[1].attributeValue[k]
        itemAttrData.index = k
        if not ItemAttr then
            ItemAttr = self._view.ItemAttr:Instantiate()
            tInsert(self.tabArrt, ItemAttr)
        end
        ItemAttr:UpdateData(itemAttrData)
        ItemAttr:SetActive(true)
    end
    for i = #self.heroAwakes[1].attributeType + 1, #self.tabArrt do
        self.tabArrt[i]:SetActive(false)
    end
end

function M:_InitSkill()
    local heroAwakeSkill1, skillDescIndex1 -- 被动技能
    local heroAwakeSkill2, skillDescIndex2 -- 三路技能
    for _, heroAwake in pairs(self.heroAwakes) do
        local tempSkillindex = tIndexof(heroAwake.effectType, 3)
        if tempSkillindex then
            skillDescIndex1 = tempSkillindex
            heroAwakeSkill1 = heroAwake
        end
        tempSkillindex = tIndexof(heroAwake.effectType, 4)
        if tempSkillindex then
            skillDescIndex2 = tempSkillindex
            heroAwakeSkill2 = heroAwake
        end
    end
    if heroAwakeSkill1 then
        local itemData = {}
        itemData.skillIcon = heroAwakeSkill1.icon
        itemData.skillName = heroAwakeSkill1.skillName
        itemData.skillDesc = heroAwakeSkill1.desc
        itemData.isOpen = self.awakeLevel >= heroAwakeSkill1.level
        itemData.openLevel = heroAwakeSkill1.level
        self._view.UIAwakenSkillCtrl1:Update(itemData)
        self._view.UIAwakenSkillCtrl1:SetActive(true)
    else
        self._view.UIAwakenSkillCtrl1:SetActive(false)
    end
    if heroAwakeSkill2 then
        local skinId = self.heroData:GetSkinId()
        local tempBattleLevels = JBattleLevel.GetHeroBattleByGrade(skinId, 1)

        if tempBattleLevels.Count <= 0 then
            Logger.LogError("配置错误")
        end
        local battleLevel = tempBattleLevels[0]
        tempBattleLevels = nil
        if battleLevel then
            local nextGrade = 0
            if battleLevel.nextGrade.Length > 0 then
                nextGrade = battleLevel.nextGrade[battleLevel.nextGrade.Length - 1]
            end
            tempBattleLevels = JBattleLevel.GetHeroBattleByGrade(skinId, nextGrade)
        end

        if tempBattleLevels.Count > 0 then
            tempBattleLevel = tempBattleLevels[1]
            local itemData = {}
            itemData.skillIcon = tempBattleLevel.icon
            itemData.skillName = tempBattleLevel.name
            itemData.skillDesc = tempBattleLevel.skillDesc
            itemData.isOpen = self.awakeLevel >= heroAwakeSkill2.level
            itemData.openLevel = heroAwakeSkill2.level
            self._view.UIAwakenSkillCtrl2:Update(itemData)
        end
        self._view.UIAwakenSkillCtrl2:SetActive(true)
    else
        self._view.UIAwakenSkillCtrl2:SetActive(false)
    end
end

function M:_OnBtnAwakeClick()
    if self.lockBtn then
        return
    end
    UIContextMgr:GetInstance():Show(UIDefine.UIAwakeCon, self.heroId)
end

function M:_OnClickIcom()
    if self.heroData:IsAwake() then
        return
    end
    self:_OnBtnAwakeClick()
end

-- 关闭时回调，无参
function M:OnClose()
    EventMgr:RemoveListener(UIMessageNames.ROLE_DEVELOP_REFRESH_DATA, self._tempOnSwitch)
    EventMgr:RemoveListener(UIMessageNames.ROLE_DEVELOP_AWAKE, self._tempOnRefHero)
end

function M:OnDispose()
    for _, value in ipairs(self.tabArrt) do
        CS.UnityEngine.GameObject.Destroy(value.gameObject)
        value:OnDestroy()
    end

    M.super.OnDispose(self)
end

return UIAwakeCtrl
