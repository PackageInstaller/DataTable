---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/4/12 21:12
---
---@class UIMonthCardShopView : UIBaseView
---@field model UIMonthCardShopModel
---@field ctrl UIMonthCardShopCtrl
---@field id number @ 当前月卡id
---@field monthCard MonthCard @ 当前月卡
local UIMonthCardShopView = BaseClass(" UIMonthCardShopView",UIBaseView)
local base = UIBaseView
local this =  UIMonthCardShopView

local item_prefab_path = "MonthCardItem"
local DayCardItem = {[1]="DayCardItem7",[2]="DayCardItem3" }
local ShopId ={0,32,31}

--- 关闭的时候 判断还有没有可以领取的月卡, 如果没有 才能关闭. 否则自动跳转, 领取奖励.
function this:CloseSelf()
    for index, value in ipairs(self.model.monthCards) do
        if value:GetLastTime() > 0 and not value.isReceived then
            self:ButOnClick(value.id)
            return
        end
    end

    UIManager:GetInstance():CloseWindow(UIWindowNames.UIMonthCardShop)
end

function this:ButOnClick(id)
    self.id = id
    self.monthCard = Game.Scene.Player:GetComponent("MonthCardComponent"):GetMonthCard(self.id)

    for key, leftButton in pairs(self.leftButtonMap) do
        leftButton.transform:Find("Active").gameObject:SetActive(key == self.id)
    end

    coroutine.start(function () 
        self.bgImage.sprite = AtlasManager:GetInstance():CoLoadImageAsync(string.format("UI/MonthCard/Bg/%s.png", self.monthCard.config.BgImage))
    end)
    self.showInfoText.text = self.monthCard.config.Info

    local lastTime = TimeUtil.ConvertTimeForm(self.monthCard:GetLastTime())
    self.text.text = "临时显示: \n"
    if self.monthCard:GetLastTime() > 0 then
        self.text.text = self.text.text .. "剩余时间:" .. lastTime.day .. "天"
    else
        self.text.text = self.text.text .. "剩余时间:已过期"
    end

    UIPublic.InitButton(self.buyButton, lastTime.day + self.monthCard.config.Duration < self.monthCard.config.StoreLimit)

    self:CheckGetReward()
end

function this:OnCreate()
    base.OnCreate(self)

    self.content = self.rc:GetObject("Content")
    -- self.Main =  self.rc:GetObject("Main")
    self.showInfo = self.rc:GetObject("ShowInfo")

    self.ScrollView3 = self.rc:GetObject("Scroll View3")
    self.ScrollView7 = self.rc:GetObject("Scroll View7")
    
    self.dContent = self.rc:GetObject("DContent2")
    self.dInfoImage = self.rc:GetObject("DInfoImage")

    self.leftButton = self.rc:GetObject("LeftButton")
    self.leftButton:SetActive(false)
    self.leftButtons = {}
    self.leftButtonMap = {}

    self.bgImage = self.rc:GetObject("BgImage"):GetComponent("Image")

    self.buyButton = self.rc:GetObject("BuyButton")

    UIUtil.AddBtnEvent(self.rc:GetObject("ReturnButton"), function()self:CloseSelf()  end,"Back")
    UIUtil.AddBtnEvent(self.rc:GetObject("Background"), function()self:CloseSelf()  end,"Back")
    UIUtil.AddBtnEvent(self.rc:GetObject("InfoBtn"), function(go) self.showInfo:SetActive(not self.showInfo.activeInHierarchy) end)
    UIUtil.AddBtnEvent(self.showInfo.transform:Find("EventBg"), function(go) self.showInfo:SetActive(false) end)
    UIUtil.AddBtnEvent(self.buyButton, function(go) self.ctrl:BuyMonthCard(self.monthCard) end)
end

function this:OnLangCreate()
    self.showInfoText = LangUtil.BindText(self.langRc:GetObject("ShowInfoText"))

    self.text = LangUtil.BindText(self.langRc:GetObject("Text"))

    LangUtil.BindText(self.langRc:GetObject("BuyText")).text = LangUtil.GetSysLang(223) -- 购买

    -- local money = ""
    -- local currencyType = ChannelManager:GetInstance():GetCurrencyType()
    -- if currencyType == ChannelCurrency.JA then
    --     money = "￥" .. Z_StarLightStoneShop[ShopId[self.type+1]].Price
    -- elseif currencyType == ChannelCurrency.US then
    --     money = "$" .. Z_StarLightStoneShop[ShopId[self.type+1]].Dollar
    -- end
    -- if self.type == 1 then
    --     LangUtil.GetSpriteLang(347, function(sprite)
    --         self.DayCard:GetComponent("Image").sprite = sprite
    --     end)
    -- elseif self.type == 2 then
    --     LangUtil.GetSpriteLang(348, function(sprite)
    --         self.DayCard:GetComponent("Image").sprite = sprite
    --     end)
    -- end
    
    -- if self.type == 0 then
    --     LangUtil.BindText(self.showInfo.transform:Find("Tips/Text")).text = LangUtil.GetSysLang(4066)
    --     LangUtil.BindText(self.pay_btn.transform:Find("Text"), "Number").text = money
    -- elseif self.type == 1 then
    --     LangUtil.BindText(self.showInfo.transform:Find("Tips/Text")).text = LangUtil.GetSysLang(4078)
    --     LangUtil.BindText(self.dPay_btn.transform:Find("Text"), "Number").text = money
    -- else
    --     LangUtil.BindText(self.showInfo.transform:Find("Tips/Text")).text = LangUtil.GetSysLang(4079)
    --     LangUtil.BindText(self.dPay_btn.transform:Find("Text"), "Number").text = money
    -- end
end

function this:CheckGetReward()  --自动领取月卡
    if self.monthCard ~= nil and self.monthCard:GetLastTime() > 0 and not self.monthCard.isReceived then
        Logger.Log("领取月卡" .. self.monthCard.id)
        ---@param response protocol.MonthlyCardReceiveResp
        PublicRequest.SendRequest(
            PROTOCOL.MonthlyCardReceiveReq,
            {
                ids = { self.id }
            },
            function(response)
                -- 这里是只领取了一个月卡, 所以直接 [1] 既可.
                UIPublic.OpenRewardUI(response.monthly_card_reward_results[1].reward_results)
            end
        )
    end
end

function this:OnEnable()
    base.OnEnable(self)
    self.showInfo:SetActive(false)
    self.id = self.model.id
    self:OnRefresh()
end

local function OnMonthCardInfoChg(self)
    self:OnRefresh()
end

function this:OnRefresh()
    self:RefreshLeftButton()
    
    self.content.transform:DOLocalMoveY(0,0)
    self:ButOnClick(self.id)
end

function this:RefreshLeftButton()
    self.leftButtonMap = {}
    for index, monthCard in ipairs(self.model.monthCards) do
        local leftButton = self.leftButtons[index]
        if leftButton == nil then
            leftButton = CS.UnityEngine.GameObject.Instantiate(self.leftButton)
            leftButton:SetActive(true)

            leftButton.transform:SetParent(self.leftButton.transform.parent)
            leftButton.transform.localPosition = Vector3.New(0,0,0)
            leftButton.transform.localScale = Vector3.New(1,1,1)
            self.leftButtons[index] = leftButton
        else
            leftButton:SetActive(true)
        end

        local image = leftButton.transform:Find("Image"):GetComponent("Image")
        local activeImage = leftButton.transform:Find("Active"):GetComponent("Image")
        image.sprite = AtlasManager:GetInstance():CoLoadImageAsync(string.format("UI/MonthCard/Preview/%s.png", monthCard.config.Preview))
        activeImage.sprite = AtlasManager:GetInstance():CoLoadImageAsync(string.format("UI/MonthCard/Preview/%s.png", monthCard.config.PreviewSelect))

        -- LangUtil.GetSpriteLang(monthCard.config.Preview, function(sprite)
        --     image.sprite = sprite
        -- end)
        -- LangUtil.GetSpriteLang(monthCard.config.PreviewSelect, function(sprite)
        --     activeImage.sprite = sprite
        -- end)

        self.leftButtonMap[monthCard.id] = leftButton
        UIUtil.AddBtnEvent(leftButton, function()
            self:ButOnClick(monthCard.id)
        end)
    end

    for i = table.count(self.model.monthCards) + 1, table.count(self.leftButtons) do
        local leftButton = self.leftButtons[i]
        if leftButton ~= nil then
            leftButton:SetActive(false)
        end
    end
end

function this:OnAddListener()
    base.OnAddListener(self)
    self:AddUIListener(UIMessageNames.ON_MONTH_CARD_INFO_CHG,OnMonthCardInfoChg)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    self:RemoveUIListener(UIMessageNames.ON_MONTH_CARD_INFO_CHG)
end

function this:OnDisable()
    base.OnDisable(self)
    -- local story = Game.Scene.Player:GetComponent("StoryComponent").StoryChapters
    -- local activityCom = Game.Scene.Player:GetComponent("GameEventComponent")
    -- local storyChapter = table.first(story,function (a) return a.ChapterId == 1 end)
    -- --ListChildPool:GetInstance():ClearContent(self.content)
    -- --ListChildPool:GetInstance():ClearContent(self.dContent)
    
    -- self.DayCard.gameObject:SetActive(false)
    -- self.Main.gameObject:SetActive(false)
    
    -- coroutine.start(function()
    --     coroutine.waitforseconds(0.5)
    --     local GuideComplete, GuideStep, run = Game.Scene:GetComponent("GuideComponent"):GetCurrentData()
    --     if run == false and UIManager:GetInstance():GetLastBgWindowName() == UIWindowNames.UIHome then
    --         local home = UIManager:GetInstance():GetWindow(UIWindowNames.UIHome)
    --         if home ~= nil and home.View ~= nil then
    --             home.View.uiDrawing:CoPlay(SoundType.Main)
    --         end
    --     end
    --     coroutine.waitforseconds(0.5)
    --     UIManager:GetInstance():GetWindow(UIWindowNames.UIHome).View.eventImg:SetActive(false)
    -- end)
end

function this:OnDestroy()
    self.content = nil
    self.back_btn = nil
    base.OnDestroy(self)
end

return this