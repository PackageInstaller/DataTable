local ActivityEx = {}
local this = ActivityEx

local ExPanel = {}

local function InitContent(activitySelf, page)
    local maxCount = table.count(page.zData)
    local index = 0
    for i = 1, maxCount do
        --达成条件未领取的
        if not table.any(page.activityInfos.Records, function(v) return v == i end) and page.zData[i].RewardStandard <= page.activityInfos.TotalCount then
            index = i
            break
        end
    end

    local info
    if index == 0 then
        page.Label:SetActive(false)
        local standard = table.choose(page.zData, function(k, v)
            return page.zData[k].RewardStandard <= page.activityInfos.TotalCount
        end)
        index = table.count(standard) > 0 and table.count(standard) + 1 or 1
        index = math.min(index, maxCount)
        info = page.zData[index]
    else
        page.Label:SetActive(true)
        info = page.zData[index]
    end

    page.NumTxt.text = info.Amount
    page.PhaseTxt.text = "PHASE  " .. index .. "/" .. maxCount
    coroutine.start(function()
        UIPublic.InitItemIcon(page.Icon, page.IconBg, info.RewardKind, info.RewardId)
    end)

    local slider = page.Slider:GetComponent("Slider")
    --if page.activityInfos.TotalCount >= info.RewardStandard then
    --    slider.value = 1
    --else
    slider.value = page.activityInfos.TotalCount / info.RewardStandard
    page.sNumText.text = page.activityInfos.TotalCount .. "/" .. info.RewardStandard
   -- end

    if page.timeSlots then
        page.timeText.text = UIPublic.GetTimeStr(page.timeSlots.Start, page.timeSlots.End)
    end
end

function this.isActive(activitySelf, activityName)
    if activityName then
        if activityName == "BattleDemon" then
            return Game.Scene.Player:GetComponent("GameEventComponent"):ActiveIsOpen(1001)
        elseif activityName == "ExActivityWei" then
            return Game.Scene.Player:GetComponent("GameEventComponent"):ActiveIsOpen(1002)
        end
    end
    
    return false
end

function this.GetStartDate(activitySelf, activityName)
    if activityName then
        if activityName == "BattleDemon" then
            return Game.Scene.Player:GetComponent("GameEventComponent"):GetStartDate(1001)
        elseif activityName == "ExActivityWei" then
            return Game.Scene.Player:GetComponent("GameEventComponent"):GetStartDate(1002)
        end
    end
    
    return nil
end

function this.OnCreate(activitySelf, item)
    local page = {}
    page.panel = item.panelObj.transform
    page.activityName = item.activityName
    ExPanel[page.activityName] = page

    local bg = page.panel:Find("bg").transform
    page.Label = bg:Find("Label").gameObject
    local Item = bg:Find("Item")
    page.IconBg = Item:Find("Bg"):GetComponent("Image")
    page.Icon = Item.transform:Find("Icon"):GetComponent("Image")
    page.NumTxt = Item.transform:Find("NumTxt"):GetComponent("Text")
    page.PhaseTxt = bg:Find("PhaseTxt"):GetComponent("Text")

    page.Slider = bg:Find("Slider").transform
    page.sImage = page.Slider.transform:Find("SImage"):GetComponent("Image")

    page.InfoBtn = page.panel:Find("InfoBtn")
    local ShowInfo = page.panel:Find("ShowInfo").gameObject
    ShowInfo:SetActive(false)
    UIUtil.AddBtnEvent(page.InfoBtn, function(go) ShowInfo:SetActive(not ShowInfo.activeInHierarchy) end)
    UIUtil.AddBtnEvent(ShowInfo.transform:Find("EventBg"), function(go) ShowInfo:SetActive(false) end)

    page.RewardBtn = bg:Find("RewardBtn").gameObject
    local btnPanel = page.panel:Find("BtnPanel")
    page.ChangeBtn = btnPanel:Find("ChangeBtn").gameObject
    page.ExBtn = btnPanel:Find("ExBtn").gameObject
    page.StoryBtn = btnPanel:Find("StoryBtn").gameObject

    local btn = {page.ExBtn, page.ChangeBtn}
    for k, v in ipairs(btn) do
        UIUtil.AddBtnEvent(v, function(go) UIManager:GetInstance():OpenWindow(Z_ActivityStory[page.activityId].WindowName[k]) end)
    end
    UIUtil.AddBtnEvent(page.StoryBtn, function(go) UIManager:GetInstance():OpenWindow(UIWindowNames.UIStoryChapter, {mode = 2, kind = 2}) end)

    page.RewardBtn:GetComponent("Button").enabled = false
end

function this.OnLangCreate(activitySelf, activityName)
    local page = ExPanel[activityName]
    if IsNull(page) then return end
    local aStory = Z_ActivityStory[page.activityId]

    page.timeText = LangUtil.BindText(page.panel:Find("bg/TimeImage/Text"))
    LangUtil.BindText(page.InfoBtn.transform:Find("Text")).text = LangUtil.GetSysLang(894)--活动说明
    LangUtil.BindText(page.Label.transform:Find("Text"), "Number").text = LangUtil.GetSysLang(845)
    LangUtil.BindText(page.Slider.transform:Find("TitleTxt")).text = LangUtil.GetSysLang(838)
    LangUtil.BindText(page.NumTxt)
    LangUtil.BindText(page.PhaseTxt)
    page.sNumText = LangUtil.BindText(page.Slider.transform:Find("SNumText")) 
    local str = string.gsub(LangUtil.GetSysLang(921), "XX", aStory.Title)
    LangUtil.BindText(page.panel:Find("ShowInfo/Tips/Text")).text = string.gsub(str, "YY", aStory.Name)
    coroutine.start(function()
        UIPublic.InitItemIcon(page.sImage, nil, GoodsKind.DemonPoint, page.activityId)
    end)
    local spriteLang = {}
    local spriteGo = {page.RewardBtn, page.ChangeBtn, page.ExBtn, page.StoryBtn, page.panel}
    if page.activityId == 1001 then
        spriteLang = {144, 145, 146, 163, 48}
    elseif page.activityId == 1002 then
        spriteLang = {258, 259, 276, 277, 257}
    end
    
    for k, v in ipairs(spriteLang) do
        LangUtil.GetSpriteLang(v, function(sprite) spriteGo[k].transform:GetComponent("Image").sprite = sprite end)
    end
end



function this.InitPanel(activitySelf, activityName)
    local page = ExPanel[activityName]
    if IsNull(page) then return end
    if not page.isInit then
        page.isInit = true
        this.activityDemonComponent = Game.Scene.Player:GetComponent("GameEventComponent")
        page.activityInfos = this.activityDemonComponent.ActivityInfos[page.activityId]
        page.timeSlots = this.activityDemonComponent.TimeSlots[page.activityId]
        coroutine.start(function()
            InitContent(activitySelf, page)
            page.RewardBtn:GetComponent("Button").enabled = true
        end)
    end

end

function this.OnInfoChg(activitySelf, activityName)
    local page = ExPanel[activityName]
    if IsNull(page) then return end
    page.isInit = nil
    this.InitPanel(activitySelf, activityName)
end

function this.OnDisable(activitySelf, activityName)
    local page = ExPanel[activityName]
    if IsNull(page) then return end
    page.isInit = nil
end

function this.OnDestroy(activitySelf, activityName)
   ExPanel[activityName] = nil
end

return this