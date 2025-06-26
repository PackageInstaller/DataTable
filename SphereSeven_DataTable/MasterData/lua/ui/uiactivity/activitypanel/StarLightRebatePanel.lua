local StarLightStonePanel = {}
local this = StarLightStonePanel

function this.InitContent(activitySelf)
    local maxCount = table.count(Z_StarLightRebate)
    local index = 0
    local count = math.min(table.count(this.StarLightRecords), maxCount)
    for i = 1, count do
        --达成条件未领取的
        if this.StarLightRecords[i] == 0 and Z_StarLightRebate[i].RewardStandard <= this.StarLightTotal then
            index = i
            break
        end
    end

    local info
    if index == 0 then
        this.Label:SetActive(false)
        local standard = table.choose(Z_StarLightRebate, function(k, v)
            return Z_StarLightRebate[k].RewardStandard <= this.StarLightTotal
        end)
        index = table.count(standard) > 0 and table.count(standard) + 1 or 1
        index = math.min(index, maxCount)
        info = Z_StarLightRebate[index]
    else
        this.Label:SetActive(true)
        info = Z_StarLightRebate[index]
    end

    this.NumTxt.text = info.Amount
    this.PhaseTxt.text = "PHASE  " .. index .. "/" .. maxCount
    coroutine.start(function()
        UIPublic.InitItemIcon(this.Icon, this.IconBg, info.RewardKind, info.RewardId)
        UIPublic.InitItemIcon(this.sImage, nil, 11)
    end)

    local slider = this.Slider:GetComponent("Slider")
    --if this.StarLightTotal >= info.RewardStandard then
    --    slider.value = 1
    --else
        slider.value = this.StarLightTotal / info.RewardStandard
    --end
    this.sNumText.text = this.StarLightTotal .. "/" .. info.RewardStandard
    this.timeText.text = UIPublic.GetTimeStr(this.starLightRebateComponent.StartDate, this.starLightRebateComponent.EndDate)
end

function this.isActive()
    return Game.Scene.Player:GetComponent("StarLightRebateComponent"):ActiveIsOpen()
end

function this.GetStartDate(activitySelf)
    return Game.Scene.Player:GetComponent("StarLightRebateComponent").StartDate
end

function this.OnCreate(activitySelf, item)
    this.starLightRebateComponent = Game.Scene.Player:GetComponent("StarLightRebateComponent")
    this.panel = item.panelObj.transform
    this.StarShopBtn = this.panel:Find("StarShopBtn").gameObject
    local bg = this.panel:Find("bg").transform

    this.Label = bg:Find("Label").gameObject
    local Item = bg:Find("Item")
    this.IconBg = Item:Find("Bg"):GetComponent("Image")
    this.Icon = Item:Find("Icon"):GetComponent("Image")
    this.NumTxt = Item:Find("NumTxt"):GetComponent("Text")
    this.PhaseTxt = bg:Find("PhaseTxt"):GetComponent("Text")

    this.Slider = bg:Find("Slider").transform
    this.sImage = this.Slider.transform:Find("SImage"):GetComponent("Image")
    this.sNumText = this.Slider.transform:Find("SNumText"):GetComponent("Text")
    this.RewardBtn = bg:Find("RewardBtn").gameObject
    UIUtil.AddBtnEventNoBug(this.RewardBtn, function(v)
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIShowStarLightList)
    end)
    this.RewardBtn:GetComponent("Button").enabled = false

    UIUtil.AddBtnEvent(this.StarShopBtn, function(v)
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIStarLightStoneShop)
    end)
    
    this.InfoBtn = this.panel:Find("InfoBtn")
    local ShowInfo = this.panel:Find("ShowInfo").gameObject
    ShowInfo:SetActive(false)
    UIUtil.AddBtnEvent(this.InfoBtn, function(go)
        ShowInfo:SetActive(not ShowInfo.activeInHierarchy)
    end)
    UIUtil.AddBtnEvent(ShowInfo.transform:Find("EventBg"), function(go)
        ShowInfo:SetActive(false)
    end)
end

function this.OnLangCreate(activitySelf)
    LangUtil.BindText(this.Label.transform:Find("Text"), "Number").text = LangUtil.GetSysLang(845)
    LangUtil.BindText(this.Slider.transform:Find("TitleTxt")).text = LangUtil.GetSysLang(838)
    LangUtil.BindText(this.InfoBtn.transform:Find("Text")).text = LangUtil.GetSysLang(894)
    LangUtil.BindText(this.panel:Find("ShowInfo/Tips/Text")).text = LangUtil.GetSysLang(903)
    this.timeText = LangUtil.BindText(this.panel:Find("bg/TimeImage/Text"))

    LangUtil.GetSpriteLang(141, function(sprite)
        this.RewardBtn.transform:GetComponent("Image").sprite = sprite
    end)
    LangUtil.GetSpriteLang(142, function(sprite)
        this.StarShopBtn.transform:GetComponent("Image").sprite = sprite
    end)
    LangUtil.GetSpriteLang(33, function(sprite)
        this.panel:GetComponent("Image").sprite = sprite
    end)
    LangUtil.BindText(this.NumTxt)
    LangUtil.BindText(this.PhaseTxt)
    LangUtil.BindText(this.sNumText)
    
end

function this.InitPanel(activitySelf)
    this.StarLightRecords = this.starLightRebateComponent.Records
    this.StarLightTotal = 0 --this.recordComponent.PaidStarStoneNum
    if not this.isInit then
        this.isInit = true
        coroutine.start(function()
            this.starLightRebateComponent:ActiveIsOpen()
            this.StarLightRecords = this.starLightRebateComponent.Records
            this.InitContent(activitySelf)
            this.RewardBtn:GetComponent("Button").enabled = true
        end)
    end

end

function this.OnInfoChg(activitySelf)
    this.isInit = nil
    this.InitPanel(activitySelf)
end

function this.OnDisable()
    this.isInit = nil
end

return this