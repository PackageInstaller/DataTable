local UIActivityFightSoulelistView = BaseClass("UIActivityFightSoulelistView", UIBaseView);
local base = UIBaseView
local this = UIActivityFightSoulelistView

local pfbName = "ActivityFightItem"

function this.OnClickReceiveReward(self, Id, callback)
    if UIUtil.GetDiffTime(5) > 0 then
        coroutine.start(function()
            Game.Scene.Player:GetComponent("TaskComponent"):CompleteTask(Id, function()
                if callback then
                    callback()
                end
                DataManager:GetInstance():Broadcast(DataMessageNames.ON_ACTIVITY_FIGHTSOULE_CHG)
            end)
        end)
    else
        UIUtil.ToolTipFourth(LangUtil.GetSysLang(839))--活动已结束
    end
end

local function SetNumText(self)
    local task = table.choose(self.taskComponent.Tasks,function(_,v) return v.MissionType == 6 end)
    local num1 = 0
    local num2 = 0
    if task then
        for _,v in table.pairsByKeys(task) do
            if v.State == 2 then
                if v.TemplateId <= 7005 then
                    num1 = num1 + 1
                else
                    num2 = num2 + 1
                end
            end
        end
    end
    num1 = math.min(num1, 5)
    num2 = math.min(num2, 5)
    self.NumText1.text = num1
    self.NumText2.text = num2
end


local function InitItem(self, transform, data, isOpen)
    coroutine.start(function()
        local id = 40002
        if data.Id <= 7005 then
            id = 40001
        end
        UIPublic.InitItemIcon(transform:Find("Item/Image"):GetComponent("Image"), nil,GoodsKind.FightSoul, id)
        UIUtil.AddBtnEvent(transform:Find("Item"), function() UIPublic.OpenThingsDetail(GoodsKind.FightSoul, id) end)
    end)
    LangUtil.BindText(transform:Find("Item/Num")).text = data.RewardNum
    LangUtil.BindText(transform:Find("InfoText")).text = data.Desc
    local isGetImage = transform:Find("Item/isGet").gameObject
    isGetImage:SetActive(false)
    local Btn = transform:Find("Btn")
    local btnText = LangUtil.BindText(transform:Find("Btn/Text"))

    local task = table.first(self.taskComponent.Tasks,function(v) return v.TemplateId == data.Id end)
    if task == nil or task.State == 0 then
        UIPublic.InitButton(Btn, false, 1, LangUtil.GetSysLang(310), btnText)
    elseif task.State == 1 then
        if isOpen then
            UIPublic.InitButton(Btn, true, 1, LangUtil.GetSysLang(310), btnText)
            UIUtil.AddBtnEvent(Btn, function()
                UIPublic.InitButton(Btn, false)
                self:OnClickReceiveReward(task.MissionId, function()
                    UIPublic.InitButton(Btn, false, 1, LangUtil.GetSysLang(837), btnText)--已领取
                    isGetImage:SetActive(true)
                    SetNumText(self)
                end)
            end)
        else
            UIPublic.InitButton(Btn, false, 1, LangUtil.GetSysLang(310), btnText)
        end
    else
        UIPublic.InitButton(Btn, false, 1, LangUtil.GetSysLang(837), btnText)--已领取
        isGetImage:SetActive(true)
    end

end

local function InitContent(self)
    ListChildPool:GetInstance():ClearContent(self.content1)
    ListChildPool:GetInstance():ClearContent(self.content2)
    self.taskComponent = Game.Scene.Player:GetComponent("TaskComponent")
    local isOpen = self.taskComponent:LimitTaskIsOpen(6)
    local data = table.choose(Z_Mission, function(_, v)  return v.MissionType == 6 end)
    coroutine.start(function()
        SetNumText(self)
        for _,v in table.pairsByKeys(data) do
            if v.Id <= 7005 then
                ListChildPool:GetInstance():GetChild(pfbName, self.content1, function(gameObject)
                    if self.active == false then ListChildPool:GetInstance():Remove(gameObject) return end
                    InitItem(self, gameObject.transform, v, isOpen)
                end)
            else
                ListChildPool:GetInstance():GetChild(pfbName, self.content2, function(gameObject)
                    if self.active == false then ListChildPool:GetInstance():Remove(gameObject) return end
                    InitItem(self, gameObject.transform, v, isOpen)
                end)
            end
        end
    end)
end

function this.OnCreate(self)
    base.OnCreate(self);
    local colseBtn = self.rc:GetObject("Close")
    local subEventBg = self.rc:GetObject("EventBg")

    EventTriggerListener.Get(subEventBg).onLuaClick = function()
        UIManager:GetInstance():CloseWindow(UIWindowNames.UIActivityFightSoulelist);
    end
    UIUtil.AddBtnEvent(colseBtn, function(go)
        UIManager:GetInstance():CloseWindow(UIWindowNames.UIActivityFightSoulelist);
    end)

    self.ScrollView1 = self.rc:GetObject("ScrollView1").transform
    self.ScrollView2 = self.rc:GetObject("ScrollView2").transform
    self.content1 = self.ScrollView1:Find("Viewport/Content")
    self.content2 = self.ScrollView2:Find("Viewport/Content")
    
    self.accumulate1 = self.rc:GetObject("Accumulate1").transform
    self.accumulate2 = self.rc:GetObject("Accumulate2").transform

end

function this.OnLangCreate(self)
    LangUtil.BindText(self.rc:GetObject("TitleText")).text = LangUtil.GetSysLang(887)

    LangUtil.BindText(self.accumulate1:Find("Text")).text = string.gsub(LangUtil.GetSysLang(898),"XX", Z_FightSoul[40001].Name)--【霸者的孤独】累计
    LangUtil.BindText(self.accumulate2:Find("Text")).text = string.gsub(LangUtil.GetSysLang(898),"XX", Z_FightSoul[40002].Name)--【冰凤涅槃】累计
    self.NumText1 = LangUtil.BindText(self.accumulate1:Find("NumText"), FontType.All_Number)
    self.NumText2 = LangUtil.BindText(self.accumulate2:Find("NumText"), FontType.All_Number)

end

function this.OnEnable(self)
    base.OnEnable(self)
    self.ScrollView1:GetComponent("ScrollRect").verticalNormalizedPosition = 0
    self.ScrollView2:GetComponent("ScrollRect").verticalNormalizedPosition = 0
    self:OnRefresh()
end

function this.OnRefresh(self)
    InitContent(self)
end

function this.OnActivityFightsouleChg(self)
    --InitContent(self)
    
end

function this.OnAddListener(self)
    base.OnAddListener(self);
    --self:AddUIListener(UIMessageNames.ON_ACTIVITY_FIGHTSOULE_CHG, self.OnActivityFightsouleChg)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
    --self:RemoveUIListener(UIMessageNames.ON_ACTIVITY_FIGHTSOULE_CHG)
end

function this.OnViewTop(self)
    base.OnViewTop(self)
end

function this.OnDisViewTop(self)
    base.OnDisViewTop(self)
end

function this.OnDisable(self)
    base.OnDisable(self);
    ListChildPool:GetInstance():ClearContent(self.content1)
    ListChildPool:GetInstance():ClearContent(self.content2)
end

function this.OnDestroy(self)
    base.OnDestroy(self);
end

return this;