
---@class UIThingsDetailItemView
---@field label UnityEngine.GameObject @ icon下 标题图标(目测表示item类型用的)
local UIThingsDetailItemView = BaseClass("UIThingsDetailItemView",UIBaseView)
local base = UIBaseView
local this = UIThingsDetailItemView

local stageConfig = {}
local labConfig = {}


---@param self UIThingsDetailItemView
local function InitItemPanel(self,data)
    local zItem = Z_Item[data.tempId]
    self.itemClass.SetData(data.tempId)
    local count = UIPublic.GetItemAmount(data.tempId)
    self.countText.text = string.gsub(LangUtil.GetSysLang(1320),"XX", count)
    self.itemClass.hideName()
    self.itemClass.SetClickAble(false)
    self.nameText.text = zItem.Name
    self.descText.text = zItem.Desc
end

---@param self UIThingsDetailItemView
local function OnLangCreate(self)
    LangUtil.BindText(self.langRc:GetObject("TitleText")).text = LangUtil.GetSysLang(229) -- 详情
    self.nameText = LangUtil.BindText(self.langRc:GetObject("NameText"))
    self.descText = LangUtil.BindText(self.langRc:GetObject("DescText"))
    self.countText = LangUtil.BindText(self.langRc:GetObject("CountText"))
end

---@param self UIThingsDetailItemView
local function OnCreate(self)
    base.OnCreate(self)
    EventTriggerListener.Get(self.rc:GetObject("EventBg")).onLuaClick = self.ctrl.CloseSelf
    self.ItemPrefab = self.rc:GetObject("ItemPrefab")
    self.itemClass = UIItemClass(nil, self.ItemPrefab)
end

---@param self UIThingsDetailItemView
local function OnEnable(self)
    base.OnEnable(self)
    coroutine.start(function()
        self.gameObject:SetActive(false)
        self:OnRefresh()
        self.gameObject:SetActive(true)
    end)
end

---@param self UIThingsDetailItemView
local function OnRefresh(self)
    InitItemPanel(self,self.model.data)
end

local function OnAddListener(self)
    base.OnAddListener(self)
end

local function OnRemoveListener(self)
    base.OnRemoveListener(self)
end

---@param self UIThingsDetailItemView
local function OnDisable(self)
end

local function OnDestroy(self)
    base.OnDestroy(self)
end



UIThingsDetailItemView.OnCreate = OnCreate
UIThingsDetailItemView.OnEnable = OnEnable
UIThingsDetailItemView.OnRefresh = OnRefresh
UIThingsDetailItemView.OnAddListener = OnAddListener
UIThingsDetailItemView.OnRemoveListener = OnRemoveListener
UIThingsDetailItemView.OnDisable= OnDisable
UIThingsDetailItemView.OnDestroy = OnDestroy
UIThingsDetailItemView.OnLangCreate = OnLangCreate

return UIThingsDetailItemView