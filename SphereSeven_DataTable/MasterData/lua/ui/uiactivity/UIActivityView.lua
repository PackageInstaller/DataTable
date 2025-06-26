local SignInPanel = require "UI/UIActivity/ActivityPanel/SignInPanel"
local StarLightRebatePanel = require "UI/UIActivity/ActivityPanel/StarLightRebatePanel"
local LoginRewardPanel = require "UI/UIActivity/ActivityPanel/LoginRewardPanel"
local ActivityFightSoulePanel = require "UI/UIActivity/ActivityPanel/ActivityFightSoulePanel"
local ActivityLogin = require "UI/UIActivity/ActivityPanel/ActivityLoginPanel"
local ActivityEx = require "UI/UIActivity/ActivityPanel/ActivityEx"

---@class UIActivityView : UIBaseView
local UIActivityView = BaseClass("UIActivityView", UIBaseView);
local base = UIBaseView
local this = UIActivityView

local pfbPathPanel = "UI/Prefabs/UI/Activity/"
local pfbBtn = "UI/Prefabs/UI/Activity/ActivityBtn.prefab"

local PanelDataList = nil
local SubViewList = nil

local ActivityShowList = {
    {
        PrefabName = "SignIn",
        SubView = SignInPanel,
    },
    {
        PrefabName = "LoginReward",
        SubView = LoginRewardPanel,
        IsCheckIn = true,
    },
}

local color1 = Color.New(111 / 255, 156 / 255, 206 / 255)

local function OnLeftBtnClick(self, type)

    -- 活动页面按钮点击次数
    ChannelManager:GetInstance():OnActivityViewBtnClick(Z_ActivityConfig[type])

    self.selectType = type
    for _, v in pairs(self.Panels) do
        if v.type == type then
            v.btnText.color = Color.white
            v.btnImageObj:SetActive(true)
            v.panelObj:SetActive(true)
        else
            v.btnText.color = color1
            v.btnImageObj:SetActive(false)
            v.panelObj:SetActive(false)
        end
    end

    if SubViewList[type].OnRefresh ~= nil then
        SubViewList[type].OnRefresh(self)
    end

    -- gh: 添加红点
    -- coroutine.start(function()
    --     if PanelDataList[type] and PanelDataList[type] ~= "SignIn" and PanelDataList[type] ~= "LoginReward" then
    --         local activityType = ClientData:GetInstance():GetActivityType()
    --         if not table.any(activityType,function(f) return f == PanelDataList[type] end) then
    --             self.activityHint:GetChild(PanelDataList[type]):AddCount(-1)
    --             ClientData:GetInstance():SetActivityType(PanelDataList[type])
    --         end
    --     end
    -- end)
    
end

---@param info RewardData
function this.OnClickItem(self, info, basePos, contentView)
    local root = self.itemPanel.transform:Find("Item")

    --local avatar = root:Find("Icon/Avatar"):GetComponent("Image")
    --local starBg = root:Find("Icon/StarBg").gameObject
    --local nameTxt = LangUtil.BindText(root:Find("Size/Name"))
    --local kindTxt = LangUtil.BindText(root:Find("Kind"))

    coroutine.start(function()
        --nameTxt.text = info.name
        --kindTxt.text = info.typeName
        --self.desc.text = info.desc
        --UIUtil.ScrollText(nameTxt)

        --UIPublic.InitItemIcon(avatar, nil, info.kind, info.id)
        --starBg:SetActive(false)
        UIPublic.OpenRewardThingsDetail(info.type, info.id)
        
        --if info.kind == 7 then
            --装备
            --UIPublic.InitEquipBg(Z_Equip[info.id], starBg:GetComponent("Image"))
            --starBg:SetActive(true)
        --end
        --if contentView == nil then
        --contentView = self.view.transform
        --end
        --UIPublic.SetPanelPosition(root, contentView, basePos)
        --self.itemPanel:SetActive(true)
    end)
end

function this:AddActivityPanel(type)
    local panel = table.first(self.Panels,function(v) return type == v.type end)
    local active = SubViewList[type].isActive(self, PanelDataList[type])
    if panel == nil and active then
        panel = {}
        local prefabName = PanelDataList[type].PrefabName
        panel.activityName = prefabName
        panel.data = PanelDataList[type]
        panel.panelObj = GameObjectPool:GetInstance():CoGetGameObjectAsync(pfbPathPanel .. prefabName .. ".prefab")
        if IsNull(panel.panelObj) then
            return nil
        end
        panel.panelObj.transform:SetParent(self.rightPanel, false)
        panel.panelObj:SetActive(false)
        local startDate
        if SubViewList[type].GetStartDate then
            startDate = SubViewList[type].GetStartDate(self, panel.activityName)
        end
        panel.startDate = startDate and startDate or type
        panel.type = type--PanelType的下标
        --panel.SubViewList = SubViewList[type]
        panel.btnObj = GameObjectPool:GetInstance():CoGetGameObjectAsync(pfbBtn)
        panel.btnObj.transform:SetParent(self.leftBtnPanel, false)
        panel.btnText = LangUtil.BindText(panel.btnObj.transform:Find("Text"))
        panel.btnText.text = LangUtil.GetSysLang(Z_ActivityConfig[type].BtnLang)
        panel.btnImageObj = panel.btnObj.transform:Find("Active").gameObject
        panel.btnImageObj:SetActive(false)

        coroutine.start(function ()
            -- self.activityHint:GetChild(prefabName):AddObject(panel.btnObj.transform:Find("Hint").gameObject, "Activity")--活动开启
            -- self.activityHint:GetChild(prefabName .. "2"):AddObject(panel.btnObj.transform:Find("Hint2").gameObject, "Activity2")--活动奖励
            panel.btnObj:GetComponent("Image").sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Activity/"..prefabName..".png")
            panel.btnImageObj:GetComponent("Image").sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Activity/"..prefabName.."_select.png")
            UIUtil.AddBtnEvent(panel.btnObj, function(v) OnLeftBtnClick(self, type) end)
        end)

        local index = 1
        for i, v in ipairs(self.Panels) do
            if v.startDate < panel.startDate then
                index = i
                break
            end
        end
        table.insert(self.Panels, index, panel)
        for _, v in ipairs(self.Panels) do
            v.btnObj.transform:SetAsLastSibling()
        end
    end
    if panel ~= nil then
        panel.btnObj:SetActive(active)
        SubViewList[type].OnCreate(self, panel)
    end

end

local function GetPanelByName(self, Name)
    local panel = table.first(self.Panels,function(v) return PanelDataList[v.type].PrefabName == Name end)
    if panel == nil then
        for i, v in ipairs(PanelDataList) do--添加创建
            if v.PrefabName == Name then
                self:AddActivityPanel(i)
                panel = table.first(self.Panels,function(p) return p.type == i end)
                if panel then
                    panel.btnText.text = LangUtil.GetSysLang(Z_ActivityConfig[i].BtnLang)
                    if SubViewList[i].OnLangCreate ~= nil then
                        SubViewList[i].OnLangCreate(self, panel.activityName)
                    end
                end
                break
            end
        end
    end
    if panel then
        local active = SubViewList[panel.type].isActive(self, panel.activityName)
        panel.btnObj:SetActive(active)
    end
    return panel
end

function this:OnCreate()
    base.OnCreate(self);
    -- self.activityHint = Game.Scene:GetComponent("HintComponent").Activity
    PanelDataList= {}
    SubViewList= {}
    -- ---@type GameEventComponent
    -- local gameEventComponent = Game.Scene.Player:GetComponent("GameEventComponent")
    for i, v in ipairs(ActivityShowList) do
        -- if v.GameEventId ~= nil or v.GameEventModuleId ~= nil then
        --     if gameEventComponent:CheckIsOpen(v.GameEventId, v.GameEventModuleId) then
        --         PanelDataList[i] = v
        --         SubViewList[i] = v.SubView
        --     end
        -- else
            PanelDataList[i] = v
            SubViewList[i] = v.SubView
        -- end
    end
    
    self.ReturnButton = self.rc:GetObject("ReturnButton")
    self.itemPanel = self.rc:GetObject("ShowItem")
    local subEventBg = self.itemPanel.transform:Find("EventBg").gameObject
    EventTriggerListener.Get(subEventBg).onLuaClick = function()
        self.itemPanel:SetActive(false)
    end
    UIUtil.AddBtnEvent(self.ReturnButton, function(go)
        UIManager:GetInstance():CloseWindow(UIWindowNames.UIActivity);
    end)
    self.Panels = {}
    self.rightPanel = self.rc:GetObject("Right").transform
    self.BtnScrollRect = self.rc:GetObject("Scroll View"):GetComponent("ScrollRect")
    self.leftBtnPanel = self.rc:GetObject("Content").transform
    for k, _ in pairs(SubViewList) do
        self:AddActivityPanel(k)
    end
    
end

function this.OnLangCreate(self)
    LangUtil.BindText(self.rc:GetObject("TitleText")).text = LangUtil.GetSysLang(833)
    self.desc = LangUtil.BindText(self.rc:GetObject("Desc"))

    for _, v in pairs(self.Panels) do
        if SubViewList[v.type].OnLangCreate ~= nil then
            SubViewList[v.type].OnLangCreate(self, v.activityName)
        end
        v.btnText.text = LangUtil.GetSysLang(Z_ActivityConfig[v.type].BtnLang)
    end

end

local function GetOpenIndex(self)
    local index
    if self.openTypeName then
        for _, v in ipairs(self.Panels) do
            if PanelDataList[v.type].PrefabName == self.openTypeName then
                index = v.type
                break
            end
        end
    end
    if index == nil then
        if self.selectType ~= nil then
            index = self.selectType
        else
            for _, v in ipairs(self.Panels) do
                if v.btnObj.activeSelf then--默认打开的
                    index = v.type
                    break
                end
            end
        end
    end
    return index
end

function this.OnEnable(self)
    base.OnEnable(self)

    -- 活动页面曝光次数埋点
    ChannelManager:GetInstance():CommonCallback(GameEvent.View_Activity)
    
    self.leftBtnPanel.localPosition = Vector3.zero
    self.openTypeName = nil
    local index = GetOpenIndex(self)
    if SubViewList[index] then
        SubViewList[index].InitPanel(self, PanelDataList[index].PrefabName)
    end
    coroutine.start(function()
        for _, v in ipairs(PanelDataList) do
            local panel = GetPanelByName(self, v.PrefabName)
            if panel and panel.btnObj.activeSelf and SubViewList[panel.type].InitPanel then
                SubViewList[panel.type].InitPanel(self, panel.activityName)
            end
        end
    end)

    self:OnRefresh()
end

function this.OnRefresh(self)
    local num = 0
    for _, v in ipairs(self.Panels) do
        local active = SubViewList[v.type].isActive(self, v.activityName)
        v.btnObj:SetActive(active)
        if active then
            num = num + 1
        end
    end
    self.BtnScrollRect.movementType = num <= 5 and 2 or 1
    if self.selectType ~= nil and not SubViewList[self.selectType].isActive(self, PanelDataList[self.selectType].PrefabName) then
        self.selectType = nil
    end

    OnLeftBtnClick(self, GetOpenIndex(self))
    self.openTypeName = nil--打开界面时有用(刷新时为nil)
end

local function PanelOnInfoChg(self, name)
    coroutine.start(function ()
        local panel = GetPanelByName(self, name)
        if panel then
            if panel.btnObj.activeSelf and SubViewList[panel.type].OnInfoChg then
                SubViewList[panel.type].OnInfoChg(self, panel.activityName)
            elseif not panel.btnObj.activeSelf then
                self:OnRefresh()
            end
        end
    end)
end

local function OnStarLightInfoChg(self)
    PanelOnInfoChg(self, "StarLightRebate")
end

local function OnActivityFightsouleChg(self)
    PanelOnInfoChg(self, "ActivityFightSoule")
end

function this.OnActivityLoginChg(self)
    PanelOnInfoChg(self, "ActivityLogin")
end

local function OnTimeRest(self)
    coroutine.start(function ()
        for _, v in ipairs(PanelDataList) do
            local panel = GetPanelByName(self, v.PrefabName)
            if panel and panel.btnObj.activeSelf and SubViewList[panel.type].OnInfoChg then
                SubViewList[panel.type].OnInfoChg(self, panel.activityName)
            end
        end

        self:OnRefresh()
    end)
end

---@param self UIActivityView
local function OnGameEventUpdate(self)
    for _, v in ipairs(PanelDataList) do
        local panel = GetPanelByName(self, v.PrefabName)
        if panel and panel.btnObj.activeSelf and SubViewList[panel.type].OnInfoChg then
            SubViewList[panel.type].OnInfoChg(self, panel.activityName)
        end
    end
end

---@param self UIActivityView
local function OnCheckInUpdate(self)
    for _, v in ipairs(PanelDataList) do
        local panel = GetPanelByName(self, v.PrefabName)
        if panel and panel.data.IsCheckIn and panel.btnObj.activeSelf and SubViewList[panel.type].OnInfoChg then
            SubViewList[panel.type].OnInfoChg(self, panel.activityName)
        end
    end
end

function this.OnAddListener(self)
    base.OnAddListener(self);
    self:AddUIListener(UIMessageNames.ON_GAME_EVENT_UPDATE, OnGameEventUpdate)
    self:AddUIListener(UIMessageNames.ON_CHECK_IN_UPDATE, OnCheckInUpdate)
    -- self:AddUIListener(UIMessageNames.ON_STAR_LIGHT_REBATE_CHG, OnStarLightInfoChg)
    -- self:AddUIListener(UIMessageNames.ON_STAR_LIGHT_INFO_CHG, OnStarLightInfoChg)
    -- self:AddUIListener(UIMessageNames.ON_ACTIVITY_FIGHTSOULE_CHG, OnActivityFightsouleChg) 
    -- self:AddUIListener(UIMessageNames.ON_ACTIVITY_LOGIN_CHG, OnActivityLoginChg) 
    -- self:AddUIListener(UIMessageNames.ON_TIME_RESET, OnTimeRest)
    
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
    self:RemoveUIListener(UIMessageNames.ON_GAME_EVENT_UPDATE)
    self:RemoveUIListener(UIMessageNames.ON_CHECK_IN_UPDATE)
    -- self:RemoveUIListener(UIMessageNames.ON_STAR_LIGHT_REBATE_CHG)
    -- self:RemoveUIListener(UIMessageNames.ON_STAR_LIGHT_INFO_CHG)
    -- self:RemoveUIListener(UIMessageNames.ON_ACTIVITY_FIGHTSOULE_CHG)
    -- self:RemoveUIListener(UIMessageNames.ON_ACTIVITY_LOGIN_CHG)
    -- self:RemoveUIListener(UIMessageNames.ON_TIME_RESET)
end

function this.OnViewTop(self)
    base.OnViewTop(self)
    UIManager:GetInstance():OpenWindow(UIWindowNames.UIComTop)
end

function this.OnDisViewTop(self)
    base.OnDisViewTop(self)
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIComTop)
end

function this.OnDisable(self)
    base.OnDisable(self);
    for _, v in ipairs(self.Panels) do
        if SubViewList[v.type].OnDisable ~= nil then
            SubViewList[v.type].OnDisable(self, v.activityName)
        end
    end
    self.selectType = nil
    --local monthCardComponent = Game.Scene.Player:GetComponent("MonthCardComponent");
    --if monthCardComponent.CurDay ~= 0 then
    --    coroutine.start(function()
    --        coroutine.waitforseconds(0.5)
    --        local daysDetail = monthCardComponent.DaysDetail;
    --        local day = monthCardComponent.CurDay ;
    --        for i = 1,day do
    --            if table.first(daysDetail,function(v) return v == i end) == nil then
    --                UIManager:GetInstance():OpenWindow(UIWindowNames.UIMonthCardShop);--购买月卡
    --                break;
    --            end
    --        end
    --    end)
    --end
end

function this.OnDestroy(self)
    base.OnDestroy(self);
    for _, v in ipairs(self.Panels) do
        if SubViewList[v.type].OnDestroy ~= nil then
            SubViewList[v.type].OnDestroy(self, v)
        end
    end
    --self.Panels = nil
    PanelDataList = nil
    SubViewList = nil
end

--function this.SendReq(self)
--    if Game.Scene.Player.NewToday == 1 then return end
--    coroutine.start(function()
--        local rr= coroutine.yieldstart(Game.Scene.Session.CoCall,nil,Game.Scene.Session,
--                OuterOpcode.Name2Code.ETModel_C2M_DailyReward, {})
--        if rr.Error == ErrorCode.ERR_Success then
--            Game.Scene.Player. NewNum = rr.Num
--            Game.Scene.Player.NewToday = 1
--            UIUtil.UpdateRewardInfoList({rr.RewardInfo},true)
--            self:OnRefresh(2)
--        else
--            UIUtil.ToolTipFourth(rr.Message)
--        end
--    end)
--end

return this;