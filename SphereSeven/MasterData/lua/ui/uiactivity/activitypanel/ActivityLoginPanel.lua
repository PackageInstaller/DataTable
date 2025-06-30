local ActivityLogin = {}
local this = ActivityLogin


local pfbName = "ActiveLoginItem"
local LoginPanel = {}


local function InitContent(activitySelf, arg, page)
    local transform = arg.go.transform
    local data = arg.data

    local activeImg = transform:Find("Active").gameObject
    local activityGetImg = transform:Find("ActivityGet").gameObject
    local getImg = transform:Find("Get").gameObject
    local dateTxt = LangUtil.BindText(transform:Find("Text"))
    local numTxt = LangUtil.BindText(transform:Find("Amount"), "Number")
    local item = transform:Find("Item")

    dateTxt.text = string.gsub(LangUtil.GetSysLang(722), "X", data.index)
    activeImg:SetActive(false)
    activityGetImg:SetActive(false)
    getImg:SetActive(false)
    local btn = transform:GetComponent("Button")
    if not IsNull(btn) then
        btn.enabled = false
    end
    local isInfo = true
    if data.index <= page.activityLogin.LoginNum then
        if table.any(page.activityLogin.Records, function(v) return v == data.index end) then
            getImg:SetActive(true)
        else
            LangUtil.GetSpriteLang(255, function(sprite) activityGetImg:GetComponent("Image").sprite = sprite end)
            activeImg:SetActive(true)
            activityGetImg:SetActive(true)
            isInfo = false
        end
    end
    UIUtil.AddBtnEvent(transform.gameObject, function()
        if isInfo then
            UIPublic.OpenThingsDetail(data.RewardType[1], data.TemplateId[1])
        else
            transform:GetComponent("Button").enabled = false
            coroutine.start(function()
                this.activityDemonComponent:ReceiveLoginReward(page.activityId, data.Id, function()
                activeImg:SetActive(false)
                activityGetImg:SetActive(false)
                getImg:SetActive(true)
                isInfo = true
                transform:GetComponent("Button").enabled = true
                end)
            end)
        end
    end)
    
    if data.RewardType[1] == GoodsKind.FightSoul then
        item:GetComponent("Image").enabled = true
        numTxt.text = ""
    else
        item:GetComponent("Image").enabled = false
        numTxt.text = data.Num
    end
    local icon = item:Find("Icon"):GetComponent("Image")
    icon.sprite = DeActiveSprite
    coroutine.start(function()
        UIPublic.InitItemIcon(icon, nil, data.RewardType[1], data.TemplateId[1])
    end)

    if page.timeSlots then
        page.timeText.text = UIPublic.GetTimeStr(page.timeSlots.Start, page.timeSlots.End)
    end
end

function this.InitPanel(activitySelf, activityName)
    local page = LoginPanel[activityName]
    if IsNull(page) then return end
    this.activityDemonComponent = Game.Scene.Player:GetComponent("GameEventComponent")
    if not page.isInit then
        page.activityLogin = this.activityDemonComponent.ActivityLogins[page.activityId]
        page.timeSlots = this.activityDemonComponent.LoginTimeSlots[page.activityId]

        page.DayText.text = string.gsub(LangUtil.GetSysLang(955),"XX", page.activityLogin.LoginNum)
        page.isInit = true
        page.ScrollViewCanvas.enabled = false
        coroutine.start(function()
            coroutine.yieldstart(page.vs_scroll.CoScrollInit, nil, page.vs_scroll,
                    page.zData, page.view, pfbName, function(arg)
                        InitContent(activitySelf, arg, page)
                    end)
            --page.vs_scroll:MoveTop()
            page.view:GetComponent("ScrollRect").movementType = 1
            local offset_x = math.modf((page.activityLogin.LoginNum - 1) / 5) * 144 - page.vs_scroll.paddingTop
            offset_x = math.max(0, offset_x)
            page.view.transform:Find("Viewport/Content"):DOLocalMoveY(offset_x, 0)
            page.ScrollViewCanvas.enabled = true
        end)
    end
end
    
function this.OnCreate(activitySelf, item)
    local page = {}
    page.panel = item.panelObj.transform
    page.activityName = item.activityName
    LoginPanel[page.activityName] = page

    page.rc = page.panel:GetComponent("ReferenceCollector")
    page.view = page.rc:GetObject("ScrollView").transform
    page.vs_scroll = VerticalScroll.New()
    page.vs_scroll:SetUpdateCount(5)
    page.ScrollViewCanvas = page.rc:GetObject("ScrollViewCanvas"):GetComponent("Canvas")

    page.InfoBtn = page.panel:Find("InfoBtn")
    local ShowInfo = page.panel:Find("ShowInfo").gameObject
    ShowInfo:SetActive(false)
    UIUtil.AddBtnEvent(page.InfoBtn, function(go)
        ShowInfo:SetActive(not ShowInfo.activeInHierarchy)
    end)
    UIUtil.AddBtnEvent(ShowInfo.transform:Find("EventBg"), function(go)
        ShowInfo:SetActive(false)
    end)
    if page.activityName == "ActivityLogin" then
        page.activityId = 1001
        local bgImage = page.rc:GetObject("BgImage").transform
        page.ScrollViewCanvas.transform.sizeDelta = bgImage.sizeDelta
        page.ScrollViewCanvas.transform.anchoredPosition = Vector3.New(384, 214, 0)
    end
    page.zData = {}
    for i, v in table.pairsByKeys(Z_ActivityLoginInfo) do
        if v.ActivityId == page.activityId then
            v.index = table.count(page.zData) + 1
            table.insert(page.zData, v)
        end
    end
end

function this.OnLangCreate(activitySelf, activityName)
    local page = LoginPanel[activityName]
    if IsNull(page) then return end
    page.timeText = LangUtil.BindText(page.rc:GetObject("TimeText"))
    
    LangUtil.BindText(page.InfoBtn.transform:Find("Text")).text = LangUtil.GetSysLang(894)--活动说明
    page.DayText = LangUtil.BindText(page.rc:GetObject("DayText"))
    page.DayText.text = ""
    
    if page.activityId == 1001 then
        LangUtil.BindText(page.panel:Find("ShowInfo/Tips/Text")).text = LangUtil.GetSysLang(4074)
        LangUtil.GetSpriteLang(256, function(sprite) page.panel:GetComponent("Image").sprite = sprite end)
    end

end

function this.OnInfoChg(activitySelf, activityName)
    local page = LoginPanel[activityName]
    if IsNull(page) then return end
    page.vs_scroll:RefreshData(page.zData)
end

function this.isActive(activitySelf, activityName)
    if activityName then
        if activityName == "ActivityLogin" then
            return Game.Scene.Player:GetComponent("GameEventComponent"):LoginIsOpen(1001)
        end
    end
    return false
end

function this.GetStartDate(activitySelf, activityName)
    if activityName then
        if activityName == "ActivityLogin" then
            return Game.Scene.Player:GetComponent("GameEventComponent"):GetLoginStartDate(1001)
        end
    end
    return nil
end

function this.OnDisable(activitySelf, activityName)
    local page = LoginPanel[activityName]
    if IsNull(page) then return end
    page.isInit = nil
    page.vs_scroll:Dispose()
end

function this.OnDestroy(activitySelf, activityName)
    LoginPanel[activityName] = nil
end

return this