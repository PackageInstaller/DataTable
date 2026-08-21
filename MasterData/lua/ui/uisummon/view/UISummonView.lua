
---@class UISummonView : UIBaseView
---@field model UISummonModel
---@field ctrl UISummonCtrl
---@field currentPool RecruitPool
local UISummonView = BaseClass("UISummonView",UIBaseView)
local base = UIBaseView
local this = UISummonView

local leftButtonPrefabName = "RecruitLeftButton"

local STAR_STONE_ID = tonumber(Z_Misc["STAR_STONE_ID"].Value[1])

local function UITransition(transform,_bool)
    transform = transform.transform
    if _bool == false then
        table.csenuObject(transform,function(v)
            local txt = v:GetComponent("Text")
            local img = v:GetComponent("Image")
            local btn = v:GetComponent("Button")
            if txt ~= nil then
                txt:DOFade(0,0)
            end
            if img ~= nil then
                img:DOFade(0,0)
            end
            if btn ~= nil then btn.enabled = false end
        end)
    else
        table.csenuObject(transform,function(v)
            local txt = v:GetComponent("Text")
            local img = v:GetComponent("Image")
            local btn = v:GetComponent("Button")
            if txt ~= nil then
                txt:DOFade(1,0.5)
            end
            if img ~= nil then
                img:DOFade(1,0.5)
            end
            if btn ~= nil then btn.enabled = true end
        end)
    end
end

function this:RefreshPoolShow()
    local itemId
    if self.currentPool == nil then
        itemId = STAR_STONE_ID
    else
        local zReward = Z_Reward[self.currentPool.config.Reward]
        itemId = zReward[1].ObjId
    end
    self.starStoneCount.text = UIPublic.GetItemAmount(itemId)
    self.starStoneName.text = Z_Item[itemId].Name
    coroutine.start(function () 
        self.bgImage.sprite = AtlasManager:GetInstance():CoLoadImageAsync(string.format("UI/Recruit/Bg/%s.png", self.currentPool.config.BgImage))
        UIUtil.SetSprite(self.starStoneImage, AtlasConfig.Item, GetItemIcon(Z_Item[itemId]))
    end)
    ---@type RecruitComponent
    local recruitComponent = Game.Scene.Player:GetComponent("RecruitComponent")
    self.guarantee:SetActive(self.currentPool.config.HideGuaranteeShow ~= 1)
    self.guaranteeText.text = string.gsub(LangUtil.GetSysLang(1428), "XX", recruitComponent:GetRecruitGuaranteeCount(self.currentPoolId))
    self.recruitOneItemData = self.ctrl:GetRecruitItemData(self.currentPoolId, RECRUIT_COUNT.ONE)
    self.recruitOneButtonHint:SetActive(false)
    if self.recruitOneItemData ~= nil then
        if UIPublic.isFreeRecruitItemId(self.recruitOneItemData.templateId) then
            self.recruitHint:GetChild(self.currentPoolId):AddObject(self.recruitOneButtonHint, "FreeRecruitItem")

            self.recruitOneItemRoot.gameObject:SetActive(false)
            LangUtil.GetSpriteLang(293, function(sprite) self.recruitOneButton.transform:Find("TextImage"):GetComponent("Image").sprite = sprite end) -- 改为免费抽卡
        else
            self.recruitHint:GetChild(self.currentPoolId):AddObject(nil, "FreeRecruitItem")

            self.recruitOneItemRoot.gameObject:SetActive(true)
            LangUtil.GetSpriteLang(239, function(sprite) self.recruitOneButton.transform:Find("TextImage"):GetComponent("Image").sprite = sprite end) -- 单抽
            UIUtil.SetSprite(self.recruitOneItemImage, AtlasConfig.Item, GetItemIcon(self.recruitOneItemData.itemConfig), true)
            self.recruitOneItemText.text = "x" .. self.recruitOneItemData.count
            if self.recruitOneItemData.enough then
                self.recruitOneItemText.color = Color(1,1,1,1)
            else
                self.recruitOneItemText.color = Color(200/255, 72/255, 72/255, 1)
            end
        end
    else
        self.recruitHint:GetChild(self.currentPoolId):AddObject(nil, "FreeRecruitItem")
    end

    self.recruitTenItemData = self.ctrl:GetRecruitItemData(self.currentPoolId, RECRUIT_COUNT.TEN)
    if self.recruitTenItemData ~= nil then
        UIUtil.SetSprite(self.recruitTenItemImage, AtlasConfig.Item, GetItemIcon(self.recruitTenItemData.itemConfig), true)
        self.recruitTenItemText.text = "x" .. self.recruitTenItemData.count
        if self.recruitTenItemData.enough then
            self.recruitTenItemText.color = Color(1,1,1,1)
        else
            self.recruitTenItemText.color = Color(200/255, 72/255, 72/255, 1)
        end

        UIUtil.SetSprite(self.recruitRookieItemImage, AtlasConfig.Item, GetItemIcon(self.recruitTenItemData.itemConfig), true)
        self.recruitRookieItemText.text = "x" .. self.recruitTenItemData.count
        if self.recruitTenItemData.enough then
            self.recruitRookieItemText.color = Color(1,1,1,1)
        else
            self.recruitRookieItemText.color = Color(200/255, 72/255, 72/255, 1)
        end
    end

    self.recruitOneButton.gameObject:SetActive(self.currentPool.config.CardPoolType ~= RecruitPoolType.RecruitPoolRookie)
    if self.currentPool.config.CardPoolType ~= RecruitPoolType.RecruitPoolRookie then
        self.recruitTenButton.gameObject:SetActive(true)
        self.recruitRookieButton.gameObject:SetActive(false)
    elseif Game.Scene.Player:GetComponent("RecruitComponent"):CheckRookiePoolHasReward(self.currentPoolId) then
        self.recruitTenButton.gameObject:SetActive(false)
        self.recruitRookieButton.gameObject:SetActive(true)
    else
        self.recruitTenButton.gameObject:SetActive(true)
        self.recruitRookieButton.gameObject:SetActive(false)
    end

    if Z_RecruitCharacterPreview[self.currentPool.config.CharacterPreview] == nil then
        self.buttonRoot.gameObject:SetActive(false)
    else
        self.buttonRoot.gameObject:SetActive(true)
        local template = self.buttonRoot:GetChild(0)
        local count = 0
        for index, value in ipairs(Z_RecruitCharacterPreview[self.currentPool.config.CharacterPreview]) do
            local go
            if index > self.buttonRoot.childCount then
                go = GameObject.Instantiate(template.gameObject, self.buttonRoot)
                go:SetActive(true)
                go.transform.localPosition = Vector3.New(0,0,0)
                go.transform.localScale = Vector3.New(1,1,1)
            else
                go = self.buttonRoot:GetChild(index - 1).gameObject
            end
            go.transform.localPosition = Vector3(value.X, value.Y, 0)

            local image = go:GetComponent("Image")
            coroutine.start(function()
                if value.Icon == 1 then
                    image.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Recruit/img_inquire.png")
                elseif value.Icon == 2 then
                    image.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Recruit/Banner_fdj.png")
                elseif value.Icon == 3 then
                    image.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Recruit/img_inquire_2.png")
                elseif value.Icon == 4 then
                    image.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Recruit/img_inquire_2.png")
                end
                image:SetNativeSize()
            end)

            UIUtil.AddBtnEventNoBug(go, function()
                UIUtil.OpenThingsDetailWindow({
                    showType = value.ShowType,
                    tempId = value.CardId,
                })
            end)
            count = count + 1
        end
        for i = count, self.buttonRoot.childCount - 1 do
            self.buttonRoot:GetChild(i).gameObject:SetActive(false)
        end
    end
end

function this:OnChangePool(id)
    -- if self.currentPoolId == id then
    --     return
    -- end
    self.currentPoolId = id
    self.currentPool = Game.Scene.Player:GetComponent("RecruitComponent"):GetPool(id)
    for object, key in pairs(self.leftButtonObjectMap) do
        -- print(key, id, key==id)
        object:SetActive(key ~= id)
    end

    self.recruitHint:GetChild(id):GetChild("Click"):Click()
    self:RefreshPoolShow()
end

function this:OnCreate()
    base.OnCreate(self)
    self.currentPoolId = nil
    self.leftButtonObjectMap = {}

    self.bgImage = self.rc:GetObject("BgImage"):GetComponent("Image")
    -- self.SummonInfoButtonRoot = self.rc:GetObject("SummonInfoButtonRoot") -- todo: 根据data加载item预制体
    self.guarantee = self.rc:GetObject("Guarantee")

    ---@type HintComponent
    local hintComponent = Game.Scene:GetComponent("HintComponent")
    ---@type HintNode
    self.recruitHint = hintComponent.Recruit

    ---@type VerticalScroll
    self.leftButtonScroll = VerticalScroll.New()
    self.leftButtonScroll:SetUpdateCount(10)
    self.leftButtonScrollView = self.rc:GetObject("LeftButtonScrollView"):GetComponent("ScrollRect")

    self.leftButtonScroll:Clear()
    self.leftButtonScroll:ScrollInit({}, self.leftButtonScrollView, leftButtonPrefabName, function (arg)
        local gameObject = arg.go
        ---@type RecruitPool
        local pool = arg.data

        local rc = gameObject:GetComponent("ReferenceCollector")
        local image = rc:GetObject("Image"):GetComponent("Image")
        local hint = rc:GetObject("Hint")
        self.recruitHint:GetChild(pool.id):AddObject(hint, "RecruitPoolTab")
        image.sprite =  AtlasManager:GetInstance():CoLoadImageAsync(string.format("UI/Recruit/Preview/%s.png", pool.config.Preview))
        local mask = rc:GetObject("Mask")
        self.leftButtonObjectMap[mask] = pool.id
        mask:SetActive(pool.id ~= self.currentPoolId)
        UIUtil.AddBtnEvent(gameObject, function() self:OnChangePool(pool.id) end)

        local lastTimeImage = rc:GetObject("LastTimeImage")
        
        ---@type RecruitComponent
        local recruitComponent = Game.Scene.Player:GetComponent("RecruitComponent")
        ---@type RecruitPool
        local recruit = recruitComponent:GetPool(pool.id)
        if recruit == nil then
            lastTimeImage:SetActive(false)
        else
            if recruit.endTime ~= nil and recruit.endTime > 0 then
                lastTimeImage:SetActive(true)
                local lastTimeText = LangUtil.BindText(rc:GetObject("LastTimeText"))
                local time = TimeUtil.ConvertTimeForm(recruit.endTime - TimeUtil.GetServerTime())
                local timeText = LangUtil.GetSysLang(904)
                if time.day > 0 then
                    timeText = timeText .. time.day .. LangUtil.GetSysLang(2006) -- 天
                elseif time.hour > 0 then
                    timeText = timeText .. time.hour .. LangUtil.GetSysLang(2007) -- 小时
                else
                    timeText = timeText .. time.minute .. LangUtil.GetSysLang(1478) -- 分钟
                end
                lastTimeText.text = timeText
            else
                lastTimeImage:SetActive(false)
            end
        end
    end)

    self.recruitOneButton = self.rc:GetObject("RecruitOneButton")
    self.recruitTenButton = self.rc:GetObject("RecruitTenButton")
    self.recruitRookieButton = self.rc:GetObject("RecruitRookieButton")
    self.recruitOneItemImage = self.rc:GetObject("RecruitOneItemImage"):GetComponent("Image")
    self.recruitTenItemImage = self.rc:GetObject("RecruitTenItemImage"):GetComponent("Image")
    self.recruitRookieItemImage = self.rc:GetObject("RecruitRookieItemImage"):GetComponent("Image")
    self.recruitOneItemRoot = self.rc:GetObject("RecruitOneItemRoot")
    self.recruitOneButtonHint = self.rc:GetObject("RecruitOneButtonHint")

    UIUtil.AddBtnEvent(self.recruitOneButton, function()
        self.recruitCount = RECRUIT_COUNT.ONE

        local func = function()
            self.ctrl:ReadyToRecruit(self.currentPoolId, RECRUIT_COUNT.ONE, self.recruitOneItemData, true)
        end
        if self.recruitOneItemData ~= nil and UIPublic.isFreeRecruitItemId(self.recruitOneItemData.templateId) then
            -- 免费抽卡
            if not Game.Scene:GetComponent("GuideComponent").GuideRun then
                ---@type ToolTipFirstData
                local tipData = {}
                tipData.message = string.gsub(LangUtil.GetSysLang(1362), "XXX", self.currentPool.config.Name)
                tipData.callBack = function()
                    func()
                end
                UIUtil.ToolTipFirst(tipData)
            else
                -- 引导中不显示弹窗
                func()
            end
        else
            func()
        end
    end)

    UIUtil.AddBtnEvent(self.recruitTenButton, function()
        self.recruitCount = RECRUIT_COUNT.TEN
        self.ctrl:ReadyToRecruit(self.currentPoolId, RECRUIT_COUNT.TEN, self.recruitTenItemData)
    end)

    UIUtil.AddBtnEvent(self.recruitRookieButton, function()
        if self.currentPool ~= nil and self.currentPool.config.CardPoolType ~= RecruitPoolType.RecruitPoolRookie then
            Logger.LogError("当前不是新手卡池, 卡池id:" .. self.currentPoolId)
            return
        end
        if not Game.Scene.Player:GetComponent("RecruitComponent"):CheckRookiePoolHasReward(self.currentPoolId) then
            Logger.LogError("当前不存在为领取的新手卡池奖励" .. self.currentPoolId)
            return
        end
        if not self.recruitTenItemData.enough then
            ---@type ToolTipFirstData
            local tipData = {}
            tipData.message = LangUtil.GetSysLang(540)
            tipData.callBack = function()
                UIManager:GetInstance():OpenWindow(UIWindowNames.UIAllShop, {
                    ShopTitleType = ShopTitleType.Diamond,
                })
            end
            UIUtil.ToolTipFirst(tipData)
            return
        end

        ---@type protocol.RecruitRookiePool
        local rookieData = Game.Scene.Player:GetComponent("RecruitComponent").rookie[self.currentPoolId]
        local resultList = {}
        local recrultIds = {}
        for _, value in pairs(rookieData.rewards) do
            local isNew = false
            if value.type == RewardType.RewardTypeCharacter then
                if not Game.Scene.Player:GetComponent("RecordComponent"):CheckIsOnOld(RecordType.Character, value.id) then
                    if recrultIds[RewardType.RewardTypeCharacter] == nil then
                        recrultIds[RewardType.RewardTypeCharacter] = {}
                    end

                    if not table.contains(recrultIds[RewardType.RewardTypeCharacter], value.id) then
                        isNew = true
                        table.insert(recrultIds[RewardType.RewardTypeCharacter], value.id)
                    end
                end
            elseif value.type == RewardType.RewardTypeFightSoul then
                if not Game.Scene.Player:GetComponent("RecordComponent"):CheckIsOnOld(RecordType.FightSoul, value.id) then
                    if recrultIds[RewardType.RewardTypeFightSoul] == nil then
                        recrultIds[RewardType.RewardTypeFightSoul] = {}
                    end

                    if not table.contains(recrultIds[RewardType.RewardTypeFightSoul], value.id) then
                        isNew = true
                        table.insert(recrultIds[RewardType.RewardTypeFightSoul], value.id)
                    end
                end
            end
            table.insert(resultList, {
                reward = value,
                rewardResult = {},
                isNew = isNew
            })
        end

        Game.Scene.Player:GetComponent("RecordComponent"):ClearOldRecord()
        UIManager:GetInstance():CloseWindow(UIWindowNames.UIComTop)
        UIManager:GetInstance():OpenWindow(UIWindowNames.UISummonStage1,
            {
                skip = true,
                resultList = resultList,
                poolId = self.currentPoolId,
                briefItem = {
                    uid = self.recruitTenItemData.id,
                    count = self.recruitTenItemData.count,
                },
                isConfirm = false
            }
        )
    end)

    UIUtil.AddBtnEvent(self.rc:GetObject("InformationButton"), function()
        UIManager:GetInstance():OpenWindow(UIWindowNames.UISummonFormula, {poolId = self.currentPoolId})
    end)

    UIPublic.SetBackButton(
        self.rc:GetObject("ReturnButton"),
        UIWindowNames.UISummon,
        531
    )

    self.buttonRoot = self.rc:GetObject("ButtonRoot").transform

    local StarStoneImage = self.rc:GetObject("StarStoneImage")
    self.starStoneImage = StarStoneImage:GetComponent("Image")
    UIUtil.AddBtnEvent(StarStoneImage, function()
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIAllShop, {
            ShopTitleType = ShopTitleType.General,
            GeneralShopType = GeneralShopType.StarDust, -- 非GeneralShop不用填
        })
    end)
end

function this:OnLangCreate()
    self.recruitOneItemText = LangUtil.BindText(self.langRc:GetObject("RecruitOneItemText"))
    self.recruitTenItemText = LangUtil.BindText(self.langRc:GetObject("RecruitTenItemText"))
    self.recruitRookieItemText = LangUtil.BindText(self.langRc:GetObject("RecruitRookieItemText"))
    self.starStoneCount = LangUtil.BindText(self.langRc:GetObject("StarStoneCount"))
    self.guaranteeText = LangUtil.BindText(self.langRc:GetObject("GuaranteeText"))

    self.starStoneName = LangUtil.BindText(self.langRc:GetObject("StarStoneName"))
    LangUtil.GetSpriteLang(238, function(sprite) self.recruitTenButton.transform:Find("TextImage"):GetComponent("Image").sprite = sprite end)
    LangUtil.GetSpriteLang(238, function(sprite) self.recruitRookieButton.transform:Find("TextImage"):GetComponent("Image").sprite = sprite end)
    LangUtil.BindText(self.langRc:GetObject("InformationButtonText")).text = LangUtil.GetSysLang(890)--"召唤说明"
end

function this:OnEnable()
    base.OnEnable(self)
    --coroutine.start(function () 
     --   coroutine.waitforframes(3)
     --   Game.Scene:GetComponent("BgmComponent"):CoPlay(BgmType.UI, "Summon")
    --end)
    if self.model ~= nil then
        self.currentPoolId = self.model.poolId
    end
    self:OnRefresh()
end

function this:OnRefresh()
    self.showPoolList = {}
    for _, value in ipairs(self.model.poolList) do
        if value.status == RecruitPoolStatus.RecruitPoolStatusOpen then
            table.insert(self.showPoolList, value)
        end
    end

    self.leftButtonScroll:RefreshData(self.showPoolList)
    self.leftButtonScroll:MoveTop()
    local poolId
    if self.currentPoolId ~= nil then
        poolId = self.currentPoolId
    elseif self.model ~= nil then
        poolId = self.model.poolId
    else
        poolId = self.showPoolList[1].id
    end

    if table.any(self.showPoolList, function (v) return v.id == poolId end) then
        self:OnChangePool(poolId)
    else
        self:OnChangePool(self.showPoolList[1].id)
    end
end

---@param self UISummonView
local function OnReadyToRecruit(self)
    self.ctrl:ReadyToRecruit(self.currentPoolId, self.recruitCount, nil, true)
end

---@param self UISummonView
local function OnRecruitUpdate(self)
    self:OnRefresh()
    self:RefreshPoolShow()
end

---@param self UISummonView
local function ON_ITEM_DATA_UPDATE(self)

    self:RefreshPoolShow()
    self.comTopView:InitComTop(self, self:GetName())
end

--新手引导
local function ON_Guide_Click(self,cid,num,isrun,minStep)
    if cid==1 and isrun then
        if num==4 and minStep == 4 then
            self.recruitCount = RECRUIT_COUNT.ONE
            self.ctrl:ReadyToRecruit(self.currentPoolId, RECRUIT_COUNT.ONE, self.recruitOneItemData)
        elseif num==9 and minStep == 2 then
            self.recruitCount = RECRUIT_COUNT.ONE
            self.ctrl:ReadyToRecruit(self.currentPoolId, RECRUIT_COUNT.ONE, self.recruitOneItemData)
        elseif num==12 and minStep == 2 then
            self.recruitCount = RECRUIT_COUNT.ONE
            self.ctrl:ReadyToRecruit(self.currentPoolId, RECRUIT_COUNT.ONE, self.recruitOneItemData)
        elseif num==15 then
            self.ctrl:CloseSelf()
        end
    end

end

function this:OnAddListener()
    base.OnAddListener(self)
    self:AddUIListener(UIMessageNames.ON_READY_TO_RECRUIT, OnReadyToRecruit)
    self:AddUIListener(UIMessageNames.ON_RECRUIT_UPDATE, OnRecruitUpdate)
    self:AddUIListener(UIMessageNames.ON_ITEM_DATA_UPDATE, ON_ITEM_DATA_UPDATE)
    self:AddUIListener(UIMessageNames.ON_Guide_Click,ON_Guide_Click)

end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    self:RemoveUIListener(UIMessageNames.ON_READY_TO_RECRUIT)
    self:RemoveUIListener(UIMessageNames.ON_RECRUIT_UPDATE)
    self:RemoveUIListener(UIMessageNames.ON_ITEM_DATA_UPDATE)
    self:RemoveUIListener(UIMessageNames.ON_Guide_Click)

end

function this.OnViewTop(self)
    base.OnViewTop(self)
    UIManager:GetInstance():OpenWindow(UIWindowNames.UIComTop)   
    self.comTopView = UIManager:GetInstance():GetWindow(UIWindowNames.UIComTop).View
    self.comTopView:InitComTop(self, self:GetName())
end

function this.OnDisViewTop(self)
    base.OnDisViewTop(self)
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIComTop)
end

function this:OnDisable()
    base.OnDisable(self)
    Game.Scene:GetComponent("SoundComponent"):Stop()
    Game.Scene:GetComponent("SoundComponent"):MainStop()
end

function this.OnDestroy(self)
    base.OnDestroy(self)
    self.leftButtonScroll:Dispose()
end

return this
