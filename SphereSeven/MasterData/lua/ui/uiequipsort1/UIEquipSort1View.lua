---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/5/24 16:58
---

local UIEquipSort1View = BaseClass("UIEquipSort1View",UIBaseView);
local base = UIBaseView
local this = UIEquipSort1View


local function SetActive(btn,bool)
    local transform = btn.transform
    transform:GetChild(0).gameObject:SetActive(bool)
end

local function IsActive(btn)
    local transform = btn.transform
    return transform:GetChild(0).gameObject.activeInHierarchy
end



local function OnClickConfirmBtn(self)
    self.callBack(self.cloneScreenTypes,self.recordOrder.Part)
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIEquipSort1)
end

local function OnClickCancelBtn(self)

end

function this.OnClickSortBtn(self,id)
    self.recordOrder.Part = id
    for k,v in pairs(self.sort_BtnTab) do
        SetActive(v,k == id)
    end
end

local function OnClickToggle(self,key,id)
    if IsActive(self.toggle_Tab[key][id])  then
        if key == 1 then
            self.cloneScreenTypes.star = 0
        elseif key == 2 then
            self.cloneScreenTypes.Part = 0
        elseif key == 3 then
            self.cloneScreenTypes.exclusive = 0
        elseif key == 4 then
            self.cloneScreenTypes.isEquip = 0
        end
        SetActive(self.toggle_Tab[key][id],false)
        return
    end

    for k,v in pairs(self.toggle_Tab[key]) do
        if key == 1 then
            self.cloneScreenTypes.star = id
        elseif key == 2 then
            self.cloneScreenTypes.Part = id
        elseif key == 3 then
            self.cloneScreenTypes.exclusive = id
        elseif key == 4 then
            self.cloneScreenTypes.isEquip = id
        end

        SetActive(v,id == k)
    end
end

local function InitButtons(self)
    self:OnClickSortBtn(self.recordOrder.Part)
    for k,v in table.pairsByKeys(self.toggle_Tab[1]) do
        SetActive(v,k == self.screenTypes.star )
    end

    for k,v in table.pairsByKeys(self.toggle_Tab[2]) do
        SetActive(v,k == self.screenTypes.Part )
    end

    for k,v in table.pairsByKeys(self.toggle_Tab[3]) do
        SetActive(v,k == self.screenTypes.exclusive )
    end

    for k,v in table.pairsByKeys(self.toggle_Tab[4]) do
        SetActive(v,k == self.screenTypes.isEquip )
    end
    
end

function this.OnLangCreate(self)
    local mainRoot=self.langRc:GetObject("MainRoot").transform
    LangUtil.BindText(self.langRc:GetObject("Title").transform).text = LangUtil.GetSysLang(187)

    LangUtil.GetSpriteLang(424, function(sprite) mainRoot:Find("Bg1"):GetChild(0):GetComponent("Image").sprite = sprite end) -- 属性
    LangUtil.GetSpriteLang(425, function(sprite) mainRoot:Find("Bg2"):GetChild(0):GetComponent("Image").sprite = sprite end) -- 排列

    -- LangUtil.BindText( mainRoot:Find("Bg1"):GetChild(0):Find("Text")).text = LangUtil.GetSysLang(163)
    -- LangUtil.BindText( mainRoot:Find("Bg2"):GetChild(0):Find("Text")).text = LangUtil.GetSysLang(164)
    LangUtil.GetSpriteLang(507, function(Sprite) self.langRc:GetObject("Cancel"):GetComponent("Image").sprite = Sprite  end) -- 取消
    LangUtil.GetSpriteLang(426, function(Sprite) self.langRc:GetObject("Confirm"):GetComponent("Image").sprite = Sprite  end) -- 取消

    local btnRoot1 = mainRoot:Find("SortRoot")
    LangUtil.BindText(btnRoot1:GetChild(0):Find("Text")).text = LangUtil.GetSysLang(680)
    LangUtil.BindText(btnRoot1:GetChild(1):Find("Text")).text = LangUtil.GetSysLang(1238)
    LangUtil.BindText(btnRoot1:GetChild(2):Find("Text")).text = LangUtil.GetSysLang(167)
    LangUtil.BindText(btnRoot1:GetChild(3):Find("Text")).text = LangUtil.GetSysLang(169)
   

    local btnRoot2 = mainRoot:Find("ScreenRoot")

    --装备星级
    LangUtil.BindText(btnRoot2:GetChild(0):GetChild(0):Find("Text")).text = string.gsub(LangUtil.GetSysLang(584),"X","1")  
    LangUtil.BindText(btnRoot2:GetChild(0):GetChild(1):Find("Text")).text = string.gsub(LangUtil.GetSysLang(584),"X","2")
    LangUtil.BindText(btnRoot2:GetChild(0):GetChild(2):Find("Text")).text = string.gsub(LangUtil.GetSysLang(584),"X","3")
    LangUtil.BindText(btnRoot2:GetChild(0):GetChild(3):Find("Text")).text = string.gsub(LangUtil.GetSysLang(584),"X","4")
    LangUtil.BindText(btnRoot2:GetChild(0):GetChild(4):Find("Text")).text = string.gsub(LangUtil.GetSysLang(584),"X","5")
    LangUtil.BindText(btnRoot2:GetChild(0):GetChild(5):Find("Text")).text = LangUtil.GetSysLang(1453)
    --装备部位

    LangUtil.BindText(btnRoot2:GetChild(1):GetChild(0):Find("Text")).text= LangUtil.GetSysLang(243)
    LangUtil.BindText(btnRoot2:GetChild(1):GetChild(1):Find("Text")).text= LangUtil.GetSysLang(244)
    LangUtil.BindText(btnRoot2:GetChild(1):GetChild(2):Find("Text")).text= LangUtil.GetSysLang(245)
    LangUtil.BindText(btnRoot2:GetChild(1):GetChild(3):Find("Text")).text= LangUtil.GetSysLang(246)
    LangUtil.BindText(btnRoot2:GetChild(1):GetChild(4):Find("Text")).text= LangUtil.GetSysLang(247)
    LangUtil.BindText(btnRoot2:GetChild(1):GetChild(5):Find("Text")).text= LangUtil.GetSysLang(248)


    --是否专属
    LangUtil.BindText(btnRoot2:GetChild(2):GetChild(0):Find("Text")).text=LangUtil.GetSysLang(589)
    LangUtil.BindText(btnRoot2:GetChild(2):GetChild(1):Find("Text")).text=LangUtil.GetSysLang(588)
    
    --是否已装备
    LangUtil.BindText(btnRoot2:GetChild(3):GetChild(0):Find("Text")).text=LangUtil.GetSysLang(590)
    LangUtil.BindText(btnRoot2:GetChild(3):GetChild(1):Find("Text")).text=LangUtil.GetSysLang(591)
    
end

function this.OnCreate(self)
    base.OnCreate(self);
    self.confirmBtn = self.rc:GetObject("Confirm")
    self.cancelBtn = self.rc:GetObject("Cancel")
    local close = self.rc:GetObject("CloseButton")
    
    self.sort_BtnCtrl = self.rc:GetObject("SortRoot").transform;
    self.sort_ToggleCtrl = self.rc:GetObject("ScreenRoot").transform;
    self.sort_BtnTab = {}
    
    
    self.toggle_Tab = {};
    self.recordScreen = {}
    for i = 0,self.sort_ToggleCtrl.childCount - 1 do
        local toggleParent = self.sort_ToggleCtrl:GetChild(i)
        self.toggle_Tab[i+1] = {}
        if self.recordScreen[i+1] == nil then self.recordScreen[i+1] = {} end
        for j = 0,toggleParent.childCount -1 do
            local toggle = toggleParent:GetChild(j).gameObject
            self.toggle_Tab[i+1][j+1] = toggle;
            UIUtil.AddBtnEvent(toggle,function(go)
                OnClickToggle(self,i+1,j+1)
            end)
        end
    end

    for i = 0,self.sort_BtnCtrl.childCount - 1 do
        local btn = self.sort_BtnCtrl:GetChild(i).gameObject;
        self.sort_BtnTab[i + 1] = btn
        UIUtil.AddBtnEvent(btn,function(v) self:OnClickSortBtn(i+1) end)
    end

    EventTriggerListener.Get(self.rc:GetObject("EventBg")).onLuaClick = function() UIManager:GetInstance():CloseWindow(UIWindowNames.UIEquipSort1) end
    UIUtil.AddBtnEvent(self.confirmBtn,function(v) OnClickConfirmBtn(self) end)
    UIUtil.AddBtnEvent(self.cancelBtn,function()UIManager:GetInstance():CloseWindow(UIWindowNames.UIEquipSort1) end)
    UIUtil.AddBtnEvent(close,function()UIManager:GetInstance():CloseWindow(UIWindowNames.UIEquipSort1) end)
end

function this.OnEnable(self)
    base.OnEnable(self);
    self:OnRefresh();
end

function this.OnRefresh(self)
    self.player = Game.Scene.Player
    self.recordOrder = self.model.data.recordOrder
    self.screenTypes = self.model.data.screenTypes
    self.cloneScreenTypes = table.clone(self.screenTypes)
    self.callBack = self.model.data.callBack
    InitButtons(self)
end

function this.OnAddListener(self)
    base.OnAddListener(self)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
end

function this.OnDisable(self)
    base.OnDisable(self);
end

function this.OnDestroy(self)
    base.OnDestroy(self);
end

return this;

