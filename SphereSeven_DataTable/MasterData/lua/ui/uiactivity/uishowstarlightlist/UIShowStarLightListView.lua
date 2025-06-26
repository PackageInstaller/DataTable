local UIShowStarLightListView = BaseClass("UIShowStarLightListView", UIBaseView);
local base = UIBaseView
local this = UIShowStarLightListView

local pfbName = "StarLightItem"

function this.OnClickReceiveReward(self, Id, callback)
    if not self.starLightRebateComponent:ActiveIsOpen() then
        UIUtil.ToolTipFourth(LangUtil.GetSysLang(839))--活动已结束
        return
    end
    coroutine.start(function()
        self.starLightRebateComponent:ReceiveReward(Id, function()
            if callback then
                callback()
            end
        end)
    end)

end

local function InitItem(self, arg)
    local transform = arg.go.transform
    local data = arg.data

    local Item = transform:Find("Item").transform
    local IconBg = Item:Find("Bg"):GetComponent("Image")
    local Icon = Item:Find("Image"):GetComponent("Image")
    local Num = LangUtil.BindText(Item:Find("Num"))
    local SliderGo = transform:Find("Slider").gameObject
    local PhaseTxt = LangUtil.BindText(transform:Find("PhaseTxt"))
    local Btn = transform:Find("Btn").gameObject
    local label = Item:Find("label")
    label.gameObject:SetActive(data.RewardKind == GoodsKind.FightSoul)
    if data.RewardKind == GoodsKind.FightSoul then
        LangUtil.BindText(label:Find("Text")).text = LangUtil.GetSysLang(259)
    end

    Num.text = data.Amount
    PhaseTxt.text = "PHASE  " .. data.Id
    UIPublic.InitItemIcon(Icon, IconBg, data.RewardKind, data.RewardId)

    local slider = SliderGo.transform:GetComponent("Slider")
    if self.StarLightTotal >= data.RewardStandard then
        --达到标准
        SliderGo:SetActive(false)
        Btn:SetActive(true)
        local btnText = LangUtil.BindText(Btn.transform:GetChild(0))
        --未领取
        if self.StarLightRecords[data.Id] ~= nil and self.StarLightRecords[data.Id] == 0 then
            if UIUtil.GetDiffTime(5) <= 0 then
                UIPublic.InitButton(Btn, false, 1, LangUtil.GetSysLang(310), btnText)
            else
                UIPublic.InitButton(Btn, true, 1, LangUtil.GetSysLang(310), btnText)
                UIUtil.AddBtnEvent(Btn, function()
                    UIPublic.InitButton(Btn, false)
                    self:OnClickReceiveReward(data.Id, function()
                        UIPublic.InitButton(Btn, false, 1, LangUtil.GetSysLang(837), btnText)
                    end)
                end)
            end
        else
            UIPublic.InitButton(Btn, false, 1, LangUtil.GetSysLang(837), btnText)
        end
    else
        local sImage = SliderGo.transform:Find("SImage"):GetComponent("Image")
        local sNumText = LangUtil.BindText(SliderGo.transform:Find("SNumText"))
        LangUtil.BindText(SliderGo.transform:Find("TitleText")).text = LangUtil.GetSysLang(838)
        slider.value = self.StarLightTotal / data.RewardStandard
        sNumText.text = self.StarLightTotal .. "/" .. data.RewardStandard
        UIPublic.InitItemIcon(sImage, nil, 11)
        SliderGo:SetActive(true)
        Btn:SetActive(false)
    end
    UIUtil.AddBtnEvent(Item.gameObject, function()
        UIPublic.OpenThingsDetail(data.RewardKind, data.RewardId)
    end)

end

local function InitContent(self)
    coroutine.yieldstart(self.vs_scroll.CoScrollInit, nil, self.vs_scroll,
            Z_StarLightRebate, self.view, pfbName, function(arg)
                InitItem(self, arg)
            end)

    self.vs_scroll:MoveTop()
end

function this.OnCreate(self)
    base.OnCreate(self);
    local colseBtn = self.rc:GetObject("Close")
    local subEventBg = self.rc:GetObject("EventBg")

    EventTriggerListener.Get(subEventBg).onLuaClick = function()
        UIManager:GetInstance():CloseWindow(UIWindowNames.UIShowStarLightList);
    end
    UIUtil.AddBtnEvent(colseBtn, function(go)
        UIManager:GetInstance():CloseWindow(UIWindowNames.UIShowStarLightList);
    end)

    self.view = self.rc:GetObject("Scroll View").transform
    self.Image = self.rc:GetObject("Image"):GetComponent("Image")
    self.vs_scroll = VerticalScroll.New()
    self.vs_scroll:SetUpdateCount(4)
    self.starLightRebateComponent = Game.Scene.Player:GetComponent("StarLightRebateComponent")

    self.StarLightTotal = 0 -- self.recordComponent.PaidStarStoneNum
    self.StarLightRecords = self.starLightRebateComponent.Records
end

function this.OnLangCreate(self)
    LangUtil.BindText(self.rc:GetObject("TitleText")).text = LangUtil.GetSysLang(846)
    LangUtil.BindText(self.rc:GetObject("Text")).text = LangUtil.GetSysLang(847)
    self.NumText = LangUtil.BindText(self.rc:GetObject("NumText"), "Number")

end

function this.OnEnable(self)
    base.OnEnable(self)
    self.NumText.text = self.StarLightTotal
    UIPublic.InitItemIcon(self.Image, nil, 11)
    self:OnRefresh()
end

function this.OnRefresh(self)
    self.StarLightRecords = self.starLightRebateComponent.Records
    self.StarLightTotal = 0 -- self.recordComponent.PaidStarStoneNum
    InitContent(self)
end

function this.OnStarLightInfoChg(self)
    self.StarLightTotal = 0 -- self.recordComponent.PaidStarStoneNum
    self.vs_scroll:RefreshData(Z_StarLightRebate)
end

function this.OnAddListener(self)
    base.OnAddListener(self);
    self:AddUIListener(UIMessageNames.ON_STAR_LIGHT_REBATE_CHG, self.OnStarLightInfoChg)
    self:AddUIListener(UIMessageNames.ON_STAR_LIGHT_INFO_CHG, self.OnStarLightInfoChg)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
    self:RemoveUIListener(UIMessageNames.ON_STAR_LIGHT_REBATE_CHG)
    self:RemoveUIListener(UIMessageNames.ON_STAR_LIGHT_INFO_CHG)
end

function this.OnViewTop(self)
    base.OnViewTop(self)
end

function this.OnDisViewTop(self)
    base.OnDisViewTop(self)
end

function this.OnDisable(self)
    base.OnDisable(self);
    self.vs_scroll:Dispose()
end

function this.OnDestroy(self)
    base.OnDestroy(self);
end

return this;