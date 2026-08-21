-- 新的核心激活界面 包小威
-- 预制体：RoleCore
local UIRoleCoreCtrl = BaseClass("UIRoleCoreCtrl", BaseUICtrl)
local M = UIRoleCoreCtrl
local CORENUM = 6
local NumPicPath = EnumConst.NumPicPath
local ItemPfbCtrl = require("UI.Ctrl.RoleDevelop.UICoreCostCtrl")
local ItemPfbView = require("UI.View.Common.ItemPfbView")
local MessageId = Proto.MessageId

function M:Init()
    self._view.btnActive:onClick(Bind(self, self._OnBtnActiveClick))
    self._view.touchMask:SetActive(false)
    self._view.labDesc:SetOnClick(Bind(self, self.OnClickCurHrefWord))
    self.grid = self._view.grid
    self.grid:Init(ItemPfbCtrl, ItemPfbView)
    self.cores = {}
    for i = 1, CORENUM do
        self.cores[i] = self._view["Core" .. i]
    end
end

function M:OnShow()
    self.isClick = nil
    self._tempClickCore = EventMgr:AddListener(UIMessageNames.ROLE_DEVELOP_CLICKCORE, Bind(self, self.OnClickItem))
    self._refreshDataHandler = EventMgr:AddListener(UIMessageNames.ROLE_DEVELOP_REFRESH_DATA, Bind(self, self._OnSwitchHero))
    self:InitCore()
end

function M:OnEnter(heroId)
    self.isClick = nil
    self.heroId = heroId
    self.heroData = IHeroDataMgr:GetMyHeroDataById(heroId)
    self.coreLevel = self.heroData:GetCoreLevel()
    self:_InitHeroName()
end

-- 切换英雄
function M:_OnSwitchHero(heroId)
    self.isClick = nil
    if self.heroId == heroId then
        return
    end

    self.heroId = heroId
    self.heroData = IHeroDataMgr:GetMyHeroDataById(heroId)
    self.coreLevel = self.heroData:GetCoreLevel()
    self:InitCore()
    self:_InitHeroName()
end

function M:_InitHeroName()
    self._view.labName2:SetAvatarName(self.heroId, RoleType.ERT_Hero)
    self._view.imgQuality:SetHeroRare(self.heroId)
end

function M:InitCore()
    for i = 1, CORENUM do
        local data = {}
        data.id = i
        data.coreLevel = self.coreLevel
        data.heroId = self.heroId
        self.cores[i]:Update(data)
    end

    -- 默认选中第一个需要激活的
    EventMgr:Broadcast(UIMessageNames.ROLE_DEVELOP_CLICKCORE, self.coreLevel >= CORENUM and CORENUM or self.coreLevel + 1)
end

function M:OnClickItem(i)
    local heroCores = ConfigHelper.GetCfgsByLua("heroCore", { heroId = self.heroId, coreLevel = i })

    if heroCores.Length <= 0 then
        Logger.LogError("配置错误")
        return
    end

    self.heroCore = heroCores[0]
    self:InitUI(i)
end

function M:InitUI(i)
    self.selectIndex = i
    self._view.imgIcon:SetPic(self.heroCore.icon)
    self._view.imgNum:SetPic(NumPicPath .. i)
    self._view.labName:SetText(self.heroCore.name)
    self._view.labDesc:SetText(self.heroCore.desc)
    self._view.stateIcon:SetState(self.coreLevel >= i and 2 or 1)

    if self.coreLevel < i - 1 then
        self._view.stateCore:SetState(1)
        self._view.imgNum2:SetPic(NumPicPath .. (self.coreLevel + 1))
    elseif self.coreLevel == i - 1 then
        self._view.stateCore:SetState(2)
    else
        self._view.stateCore:SetState(3)
        return
    end

    local datas = {}
    -- 自己
    self.costId = self.heroCore.costItems[0]
    self.costNum = self.heroCore.costNum[0]
    local haveCostNum = ItemDataMgr:GetInstance():GetItemNumById(self.costId)
    local powerId = self.heroCore.keepsakeId
    local havePowerNum = ItemDataMgr:GetInstance():GetItemNumById(powerId)

    if haveCostNum >= self.costNum then                                 -- 自己的足够
        datas[1] = { id = self.costId, haveNum = haveCostNum, needNum = self.costNum }
        self.enough = true
    elseif (haveCostNum <= 0) and (havePowerNum >= self.costNum) then   -- 全部用通用的
        datas[1] = { id = powerId, haveNum = havePowerNum, needNum = self.costNum }
        self.enough = true
    elseif (haveCostNum + havePowerNum) >= self.costNum then            -- 需要自己和通用的
        datas[1] = { id = self.costId, haveNum = haveCostNum, needNum = haveCostNum }
        datas[2] = { id = powerId, haveNum = havePowerNum, needNum = self.costNum - haveCostNum }
        self.enough = true
    else
        datas[1] = { id = self.costId, haveNum = haveCostNum, needNum = self.costNum - havePowerNum }
        if havePowerNum > 0 then
            datas[2] = { id = powerId, haveNum = havePowerNum, needNum = havePowerNum }
        end
        self.enough = false
    end

    self.grid:SetDataList(datas)
end

function M:OnClickCurHrefWord(hrefName, centerX, centerY)
    local alignDir = Vector2.New(-0.5, 0) -- 点击处 -- 以点击文字的锚点居中为标准，对齐点在右侧居中位置
    local tipsPivot = Vector2.New(1, 0.5) -- 弹出框 -- tips以左侧居中点对齐文字的对齐点
    local worldPos = Vector3.New(centerX, centerY, 0)
    self._view.labDesc:ShowHrefWordTips(hrefName, worldPos, alignDir, tipsPivot)
end

function M:_OnBtnActiveClick()
    if self._OnResponseHeroCoreLevelUpHandler then return end
    self.isClick = true

    if not self.enough then
        GameHelper.CheckItemsEnough({ self.costId }, { self.costNum }, true, true)
        return
    end

    -- 锵锵：SSR通用名牌使用需要提示 23/08/10
    local hasKeepsake = false
    for _, v in ipairs(self.grid:GetDataList() or {}) do
        if v.id == 152 then
            hasKeepsake = true
            break
        end
    end

    local stamp = PlayerPrefTools.GetPlayerPrefsString("CoreAwake", "0")
    if hasKeepsake and not TimeUtil.IsToday(tonumber(stamp)) then -- 使用SSR通用铭牌并且今天需要提示
        GameHelper.Confirm(ConfigHelper.GetLocalString(10040), function(ok)
            if ok then
                self._OnResponseHeroCoreLevelUpHandler = NetPack:RegistResponse(MessageId.ResponseHeroCoreLevelUp, Bind(self, self._OnResponseHeroCoreLevelUp))
                NetPack:SendMessage(MessageId.RequestHeroCoreLevelUp, { HeroId = self.heroId })
            end
        end, "CoreAwake")
        return
    end

    self._OnResponseHeroCoreLevelUpHandler = NetPack:RegistResponse(MessageId.ResponseHeroCoreLevelUp, Bind(self, self._OnResponseHeroCoreLevelUp))
    NetPack:SendMessage(MessageId.RequestHeroCoreLevelUp, { HeroId = self.heroId })
end

function M:_OnResponseHeroCoreLevelUp(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self._OnResponseHeroCoreLevelUpHandler)
    self._OnResponseHeroCoreLevelUpHandler = nil
    self.isClick = nil
    if result ~= 0 then
        Logger.LogError("核心激活错误")
        return
    end

    self.coreLevel = msg.CoreLevel
    self.heroData:SetCoreLevel(self.coreLevel)
    self:InitCore()
    IRedPointMgr:ForceCheck(RedPointConst.HeroCoreRedPointChecker)
    UIContextMgr:GetInstance():Show(UIDefine.UpLevel, nil, 5643, 688)
    -- 埋点数据
    local profession = ConfigHelper.GetCfgPropByLua("role", self.heroId, "profession")
    local rare = ConfigHelper.GetCfgPropByLua("hero", self.heroId, "rare")
    -- local dataKey = { "hero_type", "hero_quality", "hero_id", "core_id" }
    local dataValues = { tostring(profession), tostring(rare), tostring(self.heroId), tostring(self.coreLevel) }
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.HeroCoreup, dataValues)
end

function M:OnClose()
    M.super.OnClose(self)
    EventMgr:RemoveListener(UIMessageNames.ROLE_DEVELOP_CLICKCORE, self._tempClickCore)
    EventMgr:RemoveListener(UIMessageNames.ROLE_DEVELOP_REFRESH_DATA, self._refreshDataHandler)
end

return UIRoleCoreCtrl
