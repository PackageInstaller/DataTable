---@class UIFightSoulFilterView : UIBaseView
local UIFightSoulFilterView = BaseClass("UIFightSoulFilterView",UIBaseView);
local base = UIBaseView
local this = UIFightSoulFilterView

local RareType = {
    [Rarity.R] = true,
    [Rarity.SR] = false,
    [Rarity.SSR] = false,
}

local StatusType = {
    isLevelUp = FightSoulScreenType.isLevelUp.None,
    isMerge = FightSoulScreenType.isMerge.None,
}

local levelUpButtonOrder = {
    [1] = false,
    [2] = true
}
local equipButtonOrder = {
    [1] = false,
    [2] = true
}



local function OnClickConfirmBtn(self)
    self.callBack(self.rareType, self.statusType)
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIFightSoulFilter)
end

local function OnClickCancelBtn(self)

end

local function OnClickSortBtn(self, rare, isBool)
    if isBool == nil then
        self.rareType[rare] = not self.rareType[rare]
    else
        self.rareType[rare] = isBool
    end
    self.rareButtonList[rare].active:SetActive(self.rareType[rare])
end

local LevelUpList = {
    FightSoulScreenType.isLevelUp.NotLevelUp,
    FightSoulScreenType.isLevelUp.LevelUp
}
local function OnCilckLevelUpButton(self, isLevelUp, force)
    if force then
        self.statusType.isLevelUp = isLevelUp
    else
        if self.statusType.isLevelUp == isLevelUp then -- 取消选择
            self.statusType.isLevelUp = FightSoulScreenType.isLevelUp.None
        else
            self.statusType.isLevelUp = isLevelUp
        end
    end
    
    for key, value in pairs(levelUpButtonOrder) do
        self.statusButtonList[1][key].active:SetActive(LevelUpList[key] == self.statusType.isLevelUp)
    end
end

local MergeList = {
    FightSoulScreenType.isMerge.NotMerge,
    FightSoulScreenType.isMerge.Merge
}
local function OnClickMergeButton(self, isMerge, force)
    if force then
        self.statusType.isMerge = isMerge
    else
        if self.statusType.isMerge == isMerge then -- 取消选择
            self.statusType.isMerge = FightSoulScreenType.isMerge.None
        else
            self.statusType.isMerge = isMerge
        end
    end

    for key, value in pairs(equipButtonOrder) do
        self.statusButtonList[2][key].active:SetActive(MergeList[key] == self.statusType.isMerge)
    end
end

local function InitButtons(self, force)
    for key, value in pairs(self.rareType) do
        OnClickSortBtn(self, key, value)
    end
    OnCilckLevelUpButton(self, self.statusType.isLevelUp, force)
    OnClickMergeButton(self, self.statusType.isMerge, force)
end

  
    
function this.OnLangCreate(self)
    local mainRoot=self.langRc:GetObject("MainRoot").transform
    LangUtil.BindText(self.langRc:GetObject("Title").transform).text = LangUtil.GetSysLang(187)

    LangUtil.BindText( mainRoot:Find("Bg1"):GetChild(0):Find("Text")).text = LangUtil.GetSysLang(163)
    LangUtil.BindText( mainRoot:Find("Bg2"):GetChild(0):Find("Text")).text = LangUtil.GetSysLang(164)

    LangUtil.BindText(self.langRc:GetObject("Confirm").transform:Find("Text")).text = LangUtil.GetSysLang(145)
    LangUtil.BindText(self.langRc:GetObject("Cancel").transform:Find("Text")).text = LangUtil.GetSysLang(146)

    local btnRoot1 = mainRoot:Find("RareRoot")
    LangUtil.BindText(btnRoot1:GetChild(0):Find("Text")).text = RarityName[Rarity.R]
    LangUtil.BindText(btnRoot1:GetChild(1):Find("Text")).text = RarityName[Rarity.SR]
    LangUtil.BindText(btnRoot1:GetChild(2):Find("Text")).text = RarityName[Rarity.SSR]

    local btnRoot2 = mainRoot:Find("ScreenRoot")
    LangUtil.BindText(btnRoot2:GetChild(0):GetChild(0):Find("Text")).text = LangUtil.GetSysLang(1156)
    LangUtil.BindText(btnRoot2:GetChild(0):GetChild(1):Find("Text")).text = LangUtil.GetSysLang(1155)
 
    LangUtil.BindText(btnRoot2:GetChild(1):GetChild(0):Find("Text")).text= LangUtil.GetSysLang(1161)
    LangUtil.BindText(btnRoot2:GetChild(1):GetChild(1):Find("Text")).text= LangUtil.GetSysLang(1162)
end


function this.OnCreate(self)
    base.OnCreate(self);
    local close = self.rc:GetObject("CloseButton")
    self.confirmBtn = self.rc:GetObject("Confirm")
    self.cancelBtn = self.rc:GetObject("Cancel")
    self.rareButtonList = {}
    self.statusButtonList = {}

    self.sort_BtnCtrl = self.rc:GetObject("RareRoot").transform
    self.sort_ToggleCtrl = self.rc:GetObject("ScreenRoot").transform

    self.recordScreen = {}
    local eventList = {
        [1] = {
            func = OnCilckLevelUpButton,
            params = {
                [1] = FightSoulScreenType.isLevelUp.NotLevelUp,
                [2] = FightSoulScreenType.isLevelUp.LevelUp,
            }
        },
        [2] = {
            func = OnClickMergeButton,
            params = {
                [1] = FightSoulScreenType.isMerge.NotMerge,
                [2] = FightSoulScreenType.isMerge.Merge,
            }
        },
    }
    for i = 0, self.sort_ToggleCtrl.childCount - 1 do
        local toggleParent = self.sort_ToggleCtrl:GetChild(i)
        local event = eventList[i+1] -- 点击时触发的事件
        self.statusButtonList[i+1] = {}
        for j = 0, toggleParent.childCount -1 do
            self.statusButtonList[i+1][j+1] = {}
            local toggle = toggleParent:GetChild(j).gameObject
            self.statusButtonList[i+1][j+1].active = toggle.transform:Find("Active").gameObject
            UIUtil.AddBtnEvent(toggle,function(go)
                event.func(self, event.params[j+1])
            end)
        end
    end

    for i = 0,self.sort_BtnCtrl.childCount - 1 do
        local btn = self.sort_BtnCtrl:GetChild(i).gameObject
        self.rareButtonList[i+1] = {}
        self.rareButtonList[i+1].active = btn.transform:Find("Active").gameObject
        
        UIUtil.AddBtnEvent(btn,function(v) OnClickSortBtn(self, i+1) end)
    end

    EventTriggerListener.Get(self.rc:GetObject("EventBg")).onLuaClick = function() UIManager:GetInstance():CloseWindow(UIWindowNames.UIFightSoulFilter) end
    
    UIUtil.AddBtnEvent(self.confirmBtn,function(v) OnClickConfirmBtn(self) UIManager:GetInstance():CloseWindow(UIWindowNames.UIFightSoulFilter) end)
    UIUtil.AddBtnEvent(self.cancelBtn,function()UIManager:GetInstance():CloseWindow(UIWindowNames.UIFightSoulFilter) end)
    UIUtil.AddBtnEvent(close,function()UIManager:GetInstance():CloseWindow(UIWindowNames.UIFightSoulFilter) end)

end

function this.OnEnable(self)
    base.OnEnable(self);
    self:OnRefresh();
end

function this.OnRefresh(self)
    self.rareType = self.model.data.rareType or RareType
    self.statusType = self.model.data.statusType or StatusType
    self.callBack = self.model.data.callBack
    InitButtons(self, true)
end

function this.OnAddListener(self)
    base.OnAddListener(self)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
end

function this.OnDisable(self)
    base.OnDisable(self)
end

function this.OnDestroy(self)
    base.OnDestroy(self);
end

return this;

