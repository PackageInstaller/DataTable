local ActivityFightSoulePanel = {}
local this = ActivityFightSoulePanel

local FightSoulePanel = {}
local imageFill = { 0, 0.08, 0.31, 0.54, 0.76, 1}
local TaskData ={ ActivityFightSoule = {7000, 7005, 7010},
                  ActivityFightSouleWei = {0, 0, 0}}

local function InitContent(activitySelf, page)
    this.taskComponent = Game.Scene.Player:GetComponent("TaskComponent")
    local task = table.choose(this.taskComponent.Tasks,function(_,v) return v.MissionType == 6 end)
    local num1 = 0
    local num2 = 0
    local activityTask = TaskData[page.activityName]
    if task then
        for _,v in table.pairsByKeys(task) do
            if v.State == 2 then
                if v.TemplateId > activityTask[1] and v.TemplateId <= activityTask[2] then
                    num1 = num1 + 1
                elseif v.TemplateId > activityTask[2] and v.TemplateId <= activityTask[3] then
                    num2 = num2 + 1
                end
            end
        end
    end
    num1 = math.min(num1, 5)
    num2 = math.min(num2, 5)
    page.ImageBar1.fillAmount = imageFill[num1 + 1]
    page.ImageBar2.fillAmount = imageFill[num2 + 1]
    page.NumTxt1.text = num1 .. "/5".. LangUtil.GetSysLang(902)
    page.NumTxt2.text = num2 .. "/5".. LangUtil.GetSysLang(902)

    if page.timeSlots then
        page.timeText.text = UIPublic.GetTimeStr(page.timeSlots.Start, page.timeSlots.End)
    end

end

function this.isActive(activitySelf, activityName)
    if activityName then
        if activityName == "ActivityFightSoule" then
            return UIUtil.GetDiffTime(5) > 0
        elseif activityName == "ActivityFightSouleWei" then
            return Game.Scene.Player:GetComponent("GameEventComponent"):ActiveIsOpen(1002)
        end
    end
    
    return false
end

function this.GetStartDate(activitySelf, activityName)
    if activityName then
        if activityName == "ActivityFightSoule" then
            
        elseif activityName == "ActivityFightSouleWei" then
            return Game.Scene.Player:GetComponent("GameEventComponent"):GetStartDate(1002)
        end
    end

    return nil
end

function this.OnCreate(activitySelf, item)
    local page = {}
    page.panel = item.panelObj.transform
    page.activityName = item.activityName
    FightSoulePanel[page.activityName] = page

    page.bg1 = page.panel:Find("bg1").transform
    page.bg2 = page.panel:Find("bg2").transform
    page.RewardBtn = page.panel:Find("RewardBtn")
    page.ImageBar1 = page.bg1:Find("Image/ImageBar"):GetComponent("Image")
    page.ImageBar2 = page.bg2:Find("Image/ImageBar"):GetComponent("Image")
    page.ImageBar1.fillAmount = 0
    page.ImageBar2.fillAmount = 0

    page.InfoBtn = page.panel:Find("InfoBtn")
    local ShowInfo = page.panel:Find("ShowInfo").gameObject
    ShowInfo:SetActive(false)
    UIUtil.AddBtnEvent(page.InfoBtn, function(go) ShowInfo:SetActive(not ShowInfo.activeInHierarchy) end)
    UIUtil.AddBtnEvent(ShowInfo.transform:Find("EventBg"), function(go) ShowInfo:SetActive(false) end)

    if page.activityName == "ActivityFightSoule" then
        local node = Game.Scene:GetComponent("HintComponent").Activity:GetChild("ActivityFightSoule2"):GetChild("Reward")
        node:AddObject(page.RewardBtn:Find("Hint").gameObject, "Reward")
        
        UIPublic.InitItemIcon(page.bg1:Find("Item/Icon"):GetComponent("Image"), page.bg1:Find("Item/Bg"):GetComponent("Image"), GoodsKind.FightSoul,40001)
        UIPublic.InitItemIcon(page.bg2:Find("Item/Icon"):GetComponent("Image"), page.bg2:Find("Item/Bg"):GetComponent("Image"), GoodsKind.FightSoul,40002)
    elseif page.activityName == "ActivityFightSouleWei" then
        local node = Game.Scene:GetComponent("HintComponent").Activity:GetChild("ActivityFightSouleWei2"):GetChild("Reward")
        node:AddObject(page.RewardBtn:Find("Hint").gameObject, "Reward")
        
        UIPublic.InitItemIcon(page.bg1:Find("Item/Icon"):GetComponent("Image"), page.bg1:Find("Item/Bg"):GetComponent("Image"), GoodsKind.FightSoul,30001)
        UIPublic.InitItemIcon(page.bg2:Find("Item/Icon"):GetComponent("Image"), page.bg2:Find("Item/Bg"):GetComponent("Image"), GoodsKind.FightSoul,30002)
    end

    UIUtil.AddBtnEvent(page.RewardBtn, function(go) 
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIActivityFightSoulelist, {activityName = page.activityName}) 
    end)
    page.RewardBtn:GetComponent("Button").enabled = false
end

function this.OnLangCreate(activitySelf, activityName)
    local page = FightSoulePanel[activityName]
    if IsNull(page) then return end
    page.timeText = LangUtil.BindText(page.panel:Find("TimeImage/Text"))
    LangUtil.BindText(page.InfoBtn.transform:Find("Text")).text = LangUtil.GetSysLang(894)
    LangUtil.BindText(page.bg1:Find("Txt1")).text = LangUtil.GetSysLang(899)
    LangUtil.BindText(page.bg2:Find("Txt1")).text = LangUtil.GetSysLang(899)
    page.NumTxt1 = LangUtil.BindText(page.bg1:Find("NumTxt"))
    page.NumTxt2 = LangUtil.BindText(page.bg2:Find("NumTxt"))
    if page.activityName == "ActivityFightSoule" then
        LangUtil.BindText(page.RewardBtn:Find("Text")).text = LangUtil.GetSysLang(887)
        LangUtil.BindText(page.panel:Find("ShowInfo/Tips/Text")).text = LangUtil.GetSysLang(895)
        LangUtil.BindText(page.bg1:Find("NameTxt")).text = string.gsub(LangUtil.GetSysLang(897),"XX", Z_FightSoul[40001].Name)
        LangUtil.BindText(page.bg2:Find("NameTxt")).text = string.gsub(LangUtil.GetSysLang(897),"XX", Z_FightSoul[40002].Name)

        LangUtil.GetSpriteLang(156, function(sprite) page.panel:GetComponent("Image").sprite = sprite end)
    elseif page.activityName == "ActivityFightSouleWei" then
        --LangUtil.BindText(page.panel:Find("ShowInfo/Tips/Text")).text = LangUtil.GetSysLang(895)
        LangUtil.BindText(page.bg1:Find("NameTxt")).text = string.gsub(LangUtil.GetSysLang(897),"XX", Z_FightSoul[30001].Name)
        LangUtil.BindText(page.bg2:Find("NameTxt")).text = string.gsub(LangUtil.GetSysLang(897),"XX", Z_FightSoul[30002].Name)

        LangUtil.GetSpriteLang(282, function(sprite) page.RewardBtn:GetComponent("Image").sprite = sprite end)
        LangUtil.GetSpriteLang(281, function(sprite) page.panel:GetComponent("Image").sprite = sprite end)
    end

end

function this.InitPanel(activitySelf, activityName)
    local page = FightSoulePanel[activityName]
    if IsNull(page) then return end
    if not page.isInit then
        page.isInit = true
        if page.activityName == "ActivityFightSouleWei" then
            this.activityDemonComponent = Game.Scene.Player:GetComponent("GameEventComponent")
            page.timeSlots = this.activityDemonComponent.TimeSlots[1002]
        elseif page.activityName == "ActivityFightSoule" then
            page.timeSlots = {}
            page.timeSlots.Start = Game.Scene:GetComponent("SessionComponent").DateTime
            page.timeSlots.End = UIUtil.GetRefreshTime(5)
        end
        coroutine.start(function()
            InitContent(activitySelf, page)
            page.RewardBtn:GetComponent("Button").enabled = true
        end)
    end
end

function this.OnInfoChg(activitySelf, activityName)
    local page = FightSoulePanel[activityName]
    if IsNull(page) then return end
    page.isInit = nil
    this.InitPanel(activitySelf, activityName)
end

function this.OnDisable(activitySelf, activityName)
    local page = FightSoulePanel[activityName]
    if IsNull(page) then return end
    page.isInit = nil
end

function this.OnDestroy(activitySelf, activityName)
    FightSoulePanel[activityName] = nil
end

return this