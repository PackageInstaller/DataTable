local UIRechargePopUpView = BaseClass("UIRechargePopUpView",UIBaseView)
local base = UIBaseView
local this = UIRechargePopUpView

function this.InitContent(self, data)
    local shopData = {}
    for key, value in pairs(Z_StarLightStoneShop) do
        if value.Group == data.ModuleParams[1] then
            shopData = value
        end
    end
    self.sellPriceText:GetComponent("Text").text = 
    string.gsub(LangUtil.GetSysLang(2232), "XX", "$" .. shopData.Price / 100)
    
    UIUtil.AddBtnEventNoBug(self.buyButton, function()
        self.ctrl:SendStarLightRequest(shopData)
        UIManager:GetInstance():CloseWindow(UIWindowNames.UIRechargePopUp)
    end)

    for i = 0, 2 do
        self.content.transform:GetChild(i).gameObject:SetActive(false)
    end

    local itemList = {}

    itemList = Z_Reward[shopData.Rewards]

    for index, value in ipairs(itemList) do
        local itemTransform = self.content.transform:GetChild(index - 1)
        itemTransform.gameObject:SetActive(true)
        
        local Avatar = itemTransform:Find("Icon"):GetComponent("Image")
        local BG = itemTransform:Find("ItemBg"):GetComponent("Image")
        local Num = itemTransform:Find("Num"):GetComponent("Text")
        Num.text = value.Count

        UIPublic.InitItemIconNew(Avatar, BG, value.Type, value.ObjId)

        UIUtil.AddBtnEvent(itemTransform, function()
            local showData ={}
            showData.tempId = value.ObjId
            showData.showType = ShowType.Item
            UIUtil.OpenThingsDetailWindow(showData)
        end)
    end
end

function this.OnCreate(self)
    base.OnCreate(self)

    self.player = Game.Scene.Player

    self.back_btn = self.rc:GetObject("BackButton")
    self.mask = self.rc:GetObject("Mask")
    self.countdownText = self.rc:GetObject("CountdownText")
    self.sellPriceText = self.rc:GetObject("SellPriceText")
    self.buyButton = self.rc:GetObject("BuyButton")
    self.buttonText = self.rc:GetObject("ButtonText")
    self.itemScrollView = self.rc:GetObject("ItemScrollView")
    self.packageNameTextImage = self.rc:GetObject("PackageNameTextImage")
    self.content = self.rc:GetObject("Content")

    UIUtil.AddBtnEventNoBug(self.back_btn.gameObject, function()
        UIManager:GetInstance():CloseWindow(UIWindowNames.UIRechargePopUp)
    end, "Back")

    UIUtil.AddBtnEventNoBug(self.mask.gameObject, function()
        UIManager:GetInstance():CloseWindow(UIWindowNames.UIRechargePopUp)
    end, "Back")


    self.timeUpdate=function(self)
        self:OnUpdate()
    end
    self.timer = TimerManager:GetInstance():GetTimer(0.001, self.timeUpdate , self)
    -- 启动定时器
    self.timer:Start()

end

function this.OnEnable(self)
    base.OnEnable(self)
    self:OnRefresh()
end

function this.OnRefresh(self)
    this.InitContent(self,self.model.data)
end

function this.OnUpdate(self)
    if self.model == nil then
        return
    end
    local curmodule = Game.Scene.Player:GetComponent("GameEventComponent"):GetGameEventModule(self.model.data.ModuleId)
    local seconds = curmodule.endTime - TimeUtil.GetServerTime()
    local tb = TimeUtil.ConvertTimeForm(seconds)
    local downTime = ""

    if tb.day > 0 then
        downTime = string.format("%d"..LangUtil.GetSysLang(2005).." %02d:%02d:%02d", tb.day, tb.hour, tb.minute, tb.second)
    else
        downTime = string.format("%02d:%02d:%02d", tb.hour, tb.minute, tb.second)
    end

    self.countdownText:GetComponent("Text").text = string.gsub(LangUtil.GetSysLang(2231), "XX", downTime)
    
end

function this.OnAddListener(self)
    base.OnAddListener(self)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self)
end

function this.OnDisable(self)
    base.OnDisable(self)
end

function this.OnDestroy(self)
    base.OnDestroy(self)
end

return this
