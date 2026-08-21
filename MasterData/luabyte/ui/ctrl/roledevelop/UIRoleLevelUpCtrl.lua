-- baoruichang
-- 2022/6/30 11:41:15
-- 预制体 RoleDevelopUpNew
local UIRoleLevelUpCtrl = BaseClass("UIRoleLevelUpCtrl", BaseUICtrl)
local M = UIRoleLevelUpCtrl
local tInsert = table.insert
local EQuality = EnumConst.EQuality
local NUMTYPE = CS.GameX.ItemPfbUI.NUMTYPE
local EAttributeType = EnumConst.EAttributeType
local mModf = math.modf
local sfmt = string.format
local LevelUpTips = "LevelUpTips"
local MessageId = Proto.MessageId
-- 升级提示10次
local LEVELUPTIPS = 10
local NUM = 5

function M:Init()
    self._view.slider:OnSliderChanged(Bind(self, self._OnSliderChanged))
    self._view.btnCoin:onClick(Bind(self, self._OnClickCoin))
    self._view.btnlvUp:SetOnClick(Bind(self, self.OnBtnLvClick))
    -- C#表索引从0开始
    self._lvCosts = ConfigHelper.GetCfgs("heroLevelcost")
    self._costItems = {}
    tInsert(self._costItems, self._view.costItem)
    self.system187 = ConfigHelper.GetSystemParams(187)
    self.EState = {LevelUp=1, -- 升级
    EBreak=2, -- 突破
    -- Awaken = 3, --觉醒
    MaxLevel=4 -- 满级
    }
    self.TipsNum = PlayerPrefTools.GetPlayerPrefsInt(LevelUpTips, 0)
    self.allAttributeType = {
        EAttributeType.EAT_MaxHP,
        EAttributeType.EAT_Damage,
        EAttributeType.EAT_DamageDef,
        EAttributeType.EAT_MagicDef,
        EAttributeType.EAT_MaxArmor,
    }
    self._tempRefData = EventMgr:AddListener(UIMessageNames.ROLE_DEVELOP_REFRESH_DATA, Bind(self, self._OnSwitchHero))
    self.coinChange = ItemDataMgr:GetInstance():AddItemChange(1, Bind(self, self.OnCoinChange))
end

-- 进入UI，可传参数
function M:OnEnter(heroId)
    self.clickOn = nil
    DevelopHelper.SetDrag(false)
    self:_OnSwitchHero(heroId)
    DevelopHelper.CameraMove(DevelopCameraConfig.Type.MainLevelUp)
    self.getRes = true
    UIContextMgr:GetInstance():GetContext(UIDefine.RoleDevelopMain):SetAttrState(1)
end

function M:OnVisible()
    self:_InitCost()
end

-- 切换英雄
function M:_OnSwitchHero(heroId)
    self.heroId = heroId
    self.heroData = IHeroDataMgr:GetMyHeroDataById(self.heroId)
    self.rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(heroId)
    self:_InitHeroData()
    self:_UpdateState()
end

function M:_UpdateState()
    self:_InitLevel()
    self:_InitState()
    self:_InitCost()
end

function M:_InitHeroData()
    self.breakLevel = self.heroData:GetBreakLevel()
    self.lv = self.heroData:GetLevel()
    self._view.labName:SetAvatarName(self.heroId, RoleType.ERT_Hero)
    self._view.imgQuality:SetHeroRare(self.heroId)
end

function M:_InitLevel()
    self._curBreak = CS.GameBase.JHeroBreak.GetBreak(self.heroId, self.breakLevel)
    self._nextBreak = CS.GameBase.JHeroBreak.GetBreak(self.heroId, self.breakLevel + 1)

    self.rare = ConfigHelper.GetCfgPropByLua("hero", self.heroId, "rare")

    if self._nextBreak then
        self.maxLevel = self._nextBreak.needLevel
    else
        local addLv = self.system187[self.rare - 1]
        local favorUpLv = self.rshd.upLevel
        self.maxLevel = self._curBreak.needLevel + addLv + favorUpLv
    end

    self._view.labMaxLv:SetText(tostring(self.maxLevel))
    self._view.UIBreakCtrl:Updata(self.rare, self.breakLevel)
end

function M:_InitState()
    if self.lv < self.maxLevel then
        -- 升级
        self.state = self.EState.LevelUp
        self._view.slider:SetMax(self.maxLevel) -- limitLv

        if self.lv + 1 == self.maxLevel then
            self._view.slider:SetMin(self.lv)
            self._view.slider:SetInteractive(false)
        else
            self._view.slider:SetMin(self.lv + 1)
            self._view.slider:SetInteractive(true)
        end
        local endValue = self._view.slider:GetValue()
        self._view.slider:SetValue(self.lv + 1)
        if endValue == self.lv + 1 then -- 需要手动刷新属性  数字相同不会执行slider 改变回调函数
            self:_OnSliderChanged(endValue)
        end
        self._view.UIState:SetState(self.state)
        self._view.lvState:SetState(2)
        self._view.labBtn:SetText(1204)
        self._view.labLv:SetText(tostring(mModf(self.TargetLevel or self.lv + 1)))
        local tipsState = self.TipsNum <= LEVELUPTIPS
        tipsState = tipsState and self.lv % 10 ~= 9
        self._view.tfUpTips.gameObject:SetActive(tipsState)
        self.TipsNum = self.TipsNum + 1
        PlayerPrefTools.SetPlayerPrefs(LevelUpTips, self.TipsNum)
        local guideData = CS.GameX.Data.PlayerDataNew.Instance.guideData
        local guideState26 = guideData:IsGuideDone(26)
        if tipsState and not guideState26 then
            self.view.tfHand.localScale = Vector3(3, 3, 3)
        else
            self.view.tfHand.localScale = Vector3.one
        end
        return
    end

    self._view.tfUpTips.gameObject:SetActive(false)
    self._view.labLv:SetText(tostring(self.lv))
    -- 满级
    if not self._nextBreak then
        self.state = self.EState.MaxLevel
        self._view.UIState:SetState(self.state)
        self._view.lvState:SetState(3)
        self:_AttrValue(0)
        return
    end

    self._view.lvState:SetState(2)
    local maxLevel = self.maxLevel
    local tempBreak = CS.GameBase.JHeroBreak.GetBreak(self.heroId, self.breakLevel + 2)

    if tempBreak then
        maxLevel = tempBreak.needLevel
    else
        local addLv = self.system187[self.rare - 1]
        local favorUpLv = self.rshd.upLevel
        self.maxLevel = self._nextBreak.needLevel + addLv + favorUpLv
    end

    self._view.labMaxLv2:SetText(tostring(maxLevel))
    -- 突破
    self.state = self.EState.EBreak
    self._view.labBtn:SetText(1205)
    if self._nextBreak.breakDes.Length > 0 then
        if self._nextBreak.breakDes[0] == 2026 then
            local tips = ConfigHelper.GetLocalString(self._nextBreak.breakDes[0])
            local skinId = self.heroData:GetSkinId()
            local heroPersona = ConfigHelper.GetCfgByLua("heroPersona", skinId)
            local storyLimit = heroPersona.storyLimit
            for k, v in pairs(storyLimit) do
                if v == self.breakLevel + 1 then
                    local storyTitle = heroPersona.storyTitle[k]
                    storyTitle = ConfigHelper.GetLocalString(storyTitle)
                    tips = sfmt(tips, storyTitle)
                    self._view.labHistory:SetText(tips)
                end
            end
        else
            self._view.labHistory:SetText(self._nextBreak.breakDes[0])
        end
        self._view.labHistory.transform.parent:SetActive(true)
    else
        self._view.labHistory.transform.parent:SetActive(false)
    end

    self._view.UIState:SetState(self.state)
    self:_AttrValue(0)
end

-- 进度条改变
function M:_OnSliderChanged(value)
    self.TargetLevel = value
    self._view.labTargetLv:SetText(tostring(mModf(value)))
    self._view.labLv:SetText(tostring(mModf(self.TargetLevel)))
    -- 计算消耗
    local needCostDic = self:_CountQuickCost(value)
    self:_RefCost(needCostDic)
    self:_AttrValue(value)

    local tipsState = self.TipsNum <= LEVELUPTIPS
    tipsState = tipsState and value % 10 ~= 0
    self._view.tfUpTips.gameObject:SetActive(tipsState)
    local guideData = CS.GameX.Data.PlayerDataNew.Instance.guideData
    local guideState26 = guideData:IsGuideDone(26)
    if tipsState and not guideState26 then
        self.view.tfHand.localScale = Vector3(3, 3, 3)
    else
        self.view.tfHand.localScale = Vector3.one
    end
end

function M:_OnClickCoin()
    GameHelper.PopItem(1, self.constNum, self._view)
end

function M:OnBtnLvClick()
    if self.clickOn then
        return
    end

    local isEnough = GameHelper.CheckItemsEnough(self._costIds, self._costNum, true, true)

    if not isEnough then
        return
    end

    if self.state == self.EState.LevelUp then
        self:RequestHeroLevelsUp(self.heroId, self.TargetLevel)
    elseif self.state == self.EState.EBreak then
        self:RequestHeroAdvanced(self.heroId, self._nextBreak.id)
    end

    self.clickOn = true
end

-- 计算初始消耗
function M:_InitCost()
    -- 满级不需要计算消耗
    if self.state == self.EState.MaxLevel then
        return
    end

    local needCostDic = {}
    -- 突破或者觉醒
    if self.state == self.EState.EBreak then
        local tempHeroBreak = ConfigHelper.GetCfgsByLua("heroBreak", {hero=self.heroId, breakLevel=self.breakLevel + 1}) or {}
        local costItems = tempHeroBreak[0].costItems
        local costNum = tempHeroBreak[0].costNum

        for i = 0, costItems.Length - 1 do
            local id = costItems[i]

            if needCostDic[id] then
                needCostDic[id] = needCostDic[id] + costNum[i]
            else
                needCostDic[id] = costNum[i]
            end
        end
    elseif self.state == self.EState.LevelUp then
        self.TargetLevel = self.TargetLevel or self.lv + 1
        needCostDic = self:_CountQuickCost(self.TargetLevel)
    end

    self:_RefCost(needCostDic)
end

-- 刷新消耗
function M:_RefCost(needCostDic)
    self._costIds = {}
    self._costNum = {}
    local index = 1

    for k, v in pairs(needCostDic) do
        tInsert(self._costIds, k)
        tInsert(self._costNum, v)

        if k ~= 1 then
            local costItem = self._costItems[index]

            if not costItem then
                costItem = GameUtil.InstantiateComponent(self._view.costItem, self._view.costContent)
                tInsert(self._costItems, costItem)
            end

            costItem:SetInfo(k, NUMTYPE.BALANCE, v)
            index = index + 1
            costItem.gameObject:SetActive(true)
            costItem:EnablePopItem(true)
        end
    end

    for k = index, #self._costItems do
        self._costItems[k].gameObject:SetActive(false)
    end

    self.constNum = needCostDic[1] or 0
    self._view.labCoin:SetText(tostring(self.constNum))
    local haveConst = ItemDataMgr:GetInstance():GetItemNumById(1)
    self._view.costState:SetState(haveConst >= self.constNum and 1 or 2)
    local isEnough = GameHelper.CheckItemsEnough(self._costIds, self._costNum, false, false)
    self._view.stateBtn:SetState(isEnough and 1 or 2)
end

-- 计算快速升级的开销
function M:_CountQuickCost(endLv)
    local needCostDic = {}

    for i = self.lv, endLv - 1 do
        local heroLvCostCfg = self._lvCosts[i]

        for j = 1, #heroLvCostCfg.needItem do
            local needItemId = heroLvCostCfg.needItem[j]
            local needItemNum = 0

            if self.rare == EQuality.N then
                needItemNum = heroLvCostCfg.needNumN[j]
            elseif self.rare == EQuality.R then
                needItemNum = heroLvCostCfg.needNumR[j]
            elseif self.rare == EQuality.SR then
                needItemNum = heroLvCostCfg.needNumSR[j]
            elseif self.rare == EQuality.SSR then
                needItemNum = heroLvCostCfg.needNumSSR[j]
            end

            if not needCostDic[needItemId] then
                needCostDic[needItemId] = needItemNum
            else
                needCostDic[needItemId] = needCostDic[needItemId] + needItemNum
            end
        end
    end
    return needCostDic
end

-- 计算属性变化
function M:_AttrValue(endLv)
    local hideNum2

    for i = 1, NUM do
        local attributeId = self.allAttributeType[i]
        local num1 = self.heroData:GetDevelopAttribute(attributeId, self.lv, self.breakLevel)
        local num2 = 0

        if self.state == self.EState.LevelUp then
            num2 = self.heroData:GetDevelopAttribute(attributeId, endLv, self.breakLevel)
        elseif self.state == self.EState.EBreak then
            num2 = self.heroData:GetDevelopAttribute(attributeId, self.lv, self.breakLevel + 1)
        elseif self.state == self.EState.MaxLevel then
            hideNum2 = true
        end

        self._view["Attr" .. i]:Update(num1, num2, attributeId, hideNum2)
    end
end

function M:OnCoinChange(itemId)
    if itemId ~= 1 then
        return
    end
    self:_InitCost()
end

---------------------------------------------------------------------
-- 升级
function M:RequestHeroLevelsUp(heroId, TargetLevel)
    self._tempHeroLevelsUp = NetPack:RegistResponse(MessageId.ResponseHeroLevelsUp, Bind(self, self._ResponseHeroLevelsUpCallback))
    local request = {}
    request.HeroId = heroId
    request.TargetLevel = TargetLevel
    NetPack:SendMessage(MessageId.RequestHeroLevelsUp, request)
end

-- 升级ack
function M:_ResponseHeroLevelsUpCallback(messagId, result, msg)
    NetPack:UnRegistResponse(MessageId.ResponseHeroLevelsUp, self._tempHeroLevelsUp)
    self._tempHeroLevelsUp = nil

    if result ~= 0 then
        Logger.LogError("英雄批量升级错误，错误码" .. result)
        return
    end
    if self.heroId ~= msg.Data.HeroId then
        return
    end
    self.heroData:SetLevel(msg.Data.Level)
    self.lv = msg.Data.Level
    if self.lv % 10 == 0 then
        -- 刷新突破红点
        IRedPointMgr:ForceCheck(RedPointConst.HeroBreakRedPointChecker)
    else
        self.TargetLevel = self.lv + 1
    end
    self:_UpdateState()
    -- 埋点数据
    local profession = ConfigHelper.GetCfgPropByLua("role", self.heroId, "profession")
    -- local dataKey = { "hero_type", "hero_quality", "hero_id", "hero_level" }
    local dataValues = {tostring(profession), tostring(self.rare), tostring(self.heroId), tostring(self.lv)}
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.HeroLevelup, dataValues)
    UIContextMgr:GetInstance():Show(UIDefine.UpLevel, Bind(self, self._CloseUpLvOrBreak))
    EventMgr:Broadcast(UIMessageNames.ROLE_HERO_LVUP, self.lv)
end

-- 突破
function M:RequestHeroAdvanced(heroId, breakId)
    self._TempResponseHeroAdvancedMsg = NetPack:RegistResponse(MessageId.ResponseHeroAdvanced, Bind(self, self._ResponseHeroAdvancedCallback))
    local request = {}
    request.HeroId = heroId
    request.BreakId = breakId
    NetPack:SendMessage(MessageId.RequestHeroAdvanced, request)
end

function M:_ResponseHeroAdvancedCallback(messagId, result, msg)
    NetPack:UnRegistResponse(MessageId.ResponseHeroAdvanced, self._TempResponseHeroAdvancedMsg)

    if result ~= 0 then
        return
    end
    if self.heroId ~= msg.HeroId then
        return
    end
    self.breakLevel = msg.BreakId
    self.heroData:SetBreakLevel(self.breakLevel)
    self.TargetLevel = self.lv + 1
    self:_UpdateState()
    -- 刷新人设红点
    IRedPointMgr:ForceCheck(RedPointConst.HeroStoryRedPointChecker)
    -- 刷新突破红点
    IRedPointMgr:ForceCheck(RedPointConst.HeroBreakRedPointChecker)

    if DevelopMgr:GetInstance():OpenGene(self.heroId, self.rare) then
        -- 首次激活基因红点
        IRedPointMgr:ForceCheck(RedPointConst.HeroGeneAllRedPointChecker)
        IRedPointMgr:ForceCheck(RedPointConst.HeroGeneLevelRedPointChecker)
    end
    -- 埋点数据
    local profession = ConfigHelper.GetCfgPropByLua("role", self.heroId, "profession")
    -- local dataKey = { "hero_type", "hero_quality", "hero_id", "hero_level" }
    local dataValues = {tostring(profession), tostring(self.rare), tostring(self.heroId), tostring(self.breakLevel)}
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.HeroAdvanceup, dataValues)
    UIContextMgr:GetInstance():Show(UIDefine.UIAdvanced, msg.HeroId, msg.BreakId, Bind(self, self._CloseUpLvOrBreak))
end

---------------------------------------------------------------------
-- 升级突破成功关闭回调
function M:_CloseUpLvOrBreak()
    -- Logger.LogError("升级突破成功关闭回调")
    self.clickOn = nil
end

function M:OnClose()
    DevelopHelper.SetDrag(true)
    M.super.OnClose(self)
end

function M:OnDispose()
    self._view.btnlvUp:RemoveOnClick()
    EventMgr:RemoveListener(UIMessageNames.ROLE_DEVELOP_REFRESH_DATA, self._tempRefData)
    self.heroId = nil
    ItemDataMgr:GetInstance():RemoveItemChangeByTag(self.coinChange)
    M.super.OnDispose(self)
end

return UIRoleLevelUpCtrl
