local SignInPanel = {}
local this = SignInPanel

local pfbName = "SignInItem"

---@param activitySelf UIActivityView
local function InitItem(activitySelf, arg)
    local transform = arg.go.transform

    local get = transform:Find("Get").gameObject
    local dateTxt = LangUtil.BindText(transform:Find("Date/Value"))
    local numTxt = LangUtil.BindText(transform:Find("Amount"), "Number")
    local active = transform:Find("Active").gameObject

    dateTxt.text = string.gsub(LangUtil.GetSysLang(722), "X", arg.data.Day)
    get:SetActive(this.getNum >= arg.data.Day)
    if not this.canGet then
        active:SetActive(this.getNum == arg.data.Day)
    else
        active:SetActive((this.getNum + 1) == arg.data.Day)
    end
    local zRewards = Z_Reward[arg.data.Reward]
    local zReward = zRewards[1]
    local reward = UIPublic.GetRewardDataNew(zReward.Type, zReward.ObjId, zReward.Count)
    numTxt.text = reward.count

    local icon = transform:Find("Icon"):GetComponent("Image")
    UIPublic.InitItemIconNew(icon,nil, reward.type, reward.id, reward.count, true, false)
end

function this.InitPanel(activitySelf)

end

function this.OnInfoChg(activitySelf)
    this.isInit = nil
    this.OnRefresh(activitySelf)
end

function this.isActive(activitySelf)
    return true
end

function this.OnCreate(activitySelf, item)
    this.panel = item.panelObj.transform
    activitySelf.signInScroll = this.panel:Find("Scroll View").transform

    this.itemPanel = this.panel:Find("ShowItem").gameObject
    this.itemPanel:SetActive(false)
    local subEventBg = this.itemPanel.transform:Find("EventBg").gameObject    
    EventTriggerListener.Get(subEventBg).onLuaClick = function() this.itemPanel:SetActive(false) end
    this.desc = LangUtil.BindText(this.itemPanel.transform:Find("Item/TextScroll/Viewport/Content/Desc"))
    this.objectList = {}

    this.canGet = Game.Scene.Player:GetComponent("CheckInComponent"):HasDailyReward()
    this.getNum = Game.Scene.Player:GetComponent("CheckInComponent"):GetDailyRewardReceivedCount()
    this.vs_scroll = VerticalScroll.New()
    this.vs_scroll:SetUpdateCount(10)

    coroutine.yieldstart(this.vs_scroll.CoScrollInit, nil, this.vs_scroll,
    {}, activitySelf.signInScroll, pfbName, function(arg)
        InitItem(activitySelf, arg)
        this.objectList[arg.data.Day] = arg
    end)
end

local function FreshItems(activitySelf)
    local checkInData = Z_DailyCheckIn[this.timeData.month]
    this.vs_scroll:RefreshData(checkInData)
    this.vs_scroll:MoveTop()
end

function this.OnRefresh(activitySelf)
    local player = Game.Scene.Player
    this.canGet = Game.Scene.Player:GetComponent("CheckInComponent"):HasDailyReward()
    this.getNum = Game.Scene.Player:GetComponent("CheckInComponent"):GetDailyRewardReceivedCount()
    this.timeData = TimeUtil.GetServerTimeSplitData()
    this.itemPanel:SetActive(false)

    FreshItems()
end

function this.OnDisable(activitySelf)

end

function this.OnDestroy(activitySelf)
    if not IsNull(this.vs_scroll) then
        this.vs_scroll:Dispose()
    end
    this.isInit = nil
end

return this