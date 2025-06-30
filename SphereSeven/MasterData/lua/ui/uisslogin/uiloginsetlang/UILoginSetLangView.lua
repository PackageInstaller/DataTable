local UILoginSetLangView = BaseClass("UILoginSetLangView", UIBaseView)
local base = UIBaseView
local this = UILoginSetLangView


local function OnItemClicked(self, name)
    self.langName = name
    for i, v in ipairs(self.dropItems) do
        v.Checkmark:SetActive(name == self.dropItems[i].LangName)
    end
    this.OnLangCreate(self)
end

function this.OnCreate(self)
    base.OnCreate(self)

    self.clientData = ClientData:GetInstance()
    self.langName = self.clientData.LangName
    self.dropdown = self.rc:GetObject("Dropdown").transform
    local dropdownBtn = self.dropdown:Find("Button").transform
    local dropdownListView = self.dropdown:Find("ListView").gameObject
    local dropdownContent = self.rc:GetObject("Content").transform
    dropdownListView:SetActive(false)

    self.dropItems = {}
    for i = 0, dropdownContent.childCount - 1 do
        self.dropItems[i + 1] = {}
        local transform = dropdownContent:GetChild(i)
        self.dropItems[i + 1].LangName = transform.name
        self.dropItems[i + 1].transform = transform
        self.dropItems[i + 1].Label = transform:Find("Label")
        self.dropItems[i + 1].Checkmark = transform:Find("Checkmark").gameObject
        self.dropItems[i + 1].Checkmark:SetActive(self.clientData.LangName == transform.name)
        UIUtil.AddBtnEvent(transform, function(go)
            dropdownListView:SetActive(false)
            OnItemClicked(self, transform.name)
        end)
    end
    UIUtil.AddBtnEvent(dropdownBtn, function(go)
        dropdownListView:SetActive(not dropdownListView.activeInHierarchy)
    end)

    self.ConfirmBtn = self.rc:GetObject("ConfirmBtn")
    self.CancelBtn = self.rc:GetObject("CancelBtn")
    self.CloseBtn = self.rc:GetObject("CloseBtn")
    --self.EventBg = self.rc:GetObject("EventBg")
    self.Mask = self.rc:GetObject("Mask")
    self.Mask:SetActive(false)
    local func = function()
        UIManager:GetInstance():CloseWindow(UIWindowNames.UILoginSetLang)
        UIManager:GetInstance():OpenWindow(UIWindowNames.UILoginStatute)
    end
    UIUtil.AddBtnEvent(self.CancelBtn, func)
    UIUtil.AddBtnEvent(self.CloseBtn, func)
    --UIUtil.AddBtnEvent(self.EventBg, func)
    UIUtil.AddBtnEvent(self.ConfirmBtn, function()
        self.Mask:SetActive(true)
        coroutine.start(function()
            if self.clientData.LangName ~= self.langName then
                self.clientData:SetLangName(self.langName)
                LangUtil.SetLangType()
                DataManager:GetInstance():Broadcast(DataMessageNames.ON_LANG_TYPE_CHG)
            end
            self.Mask:SetActive(false)
            func()
        end)
    end)
end

function this.OnEnable(self)
    base.OnEnable(self)
    --if not string.IsNullOrEmpty(self.clientData.LangName) then
    --    UIManager:GetInstance():CloseWindow(UIWindowNames.UILoginSetLang)
    --    UIManager:GetInstance():OpenWindow(UIWindowNames.UILoginStatute)
    --end
end

function this.GetTempSysLang(self, number)
    return Z_SysLang[number]["Sys_"..self.langName]
end

function this.OnLangCreate(self)
    LangUtil.BindText(self.rc:GetObject("Text")).text = self:GetTempSysLang(868) --LangUtil.GetSysLang(868)--选择语言
    LangUtil.BindText(self.dropdown:Find("Label")).text = self:GetTempSysLang(867)
    LangUtil.BindText(self.rc:GetObject("TopText")).text = self:GetTempSysLang(9) --LangUtil.GetSysLang(9)--提示
    LangUtil.BindText(self.rc:GetObject("CancelText")).text = self:GetTempSysLang(146) --LangUtil.GetSysLang(146)--提示
    LangUtil.BindText(self.rc:GetObject("ConfirmText")).text = self:GetTempSysLang(145) --LangUtil.GetSysLang(145)--提示
    for k, v in pairs(self.dropItems) do
        LangUtil.BindText(v.Label).text = LangUtil.GetSysLang(869 + k)--繁体中文  日本语
    end
end

return UILoginSetLangView;