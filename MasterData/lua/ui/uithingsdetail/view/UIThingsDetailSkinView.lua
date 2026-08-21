
---@class UIThingsDetailSkinView
---@field label UnityEngine.GameObject @ icon下 标题图标(目测表示item类型用的)
local UIThingsDetailSkinView = BaseClass("UIThingsDetailSkinView",UIBaseView)
local base = UIBaseView
local this = UIThingsDetailSkinView

local stageConfig = {}
local labConfig = {}


---@param self UIThingsDetailSkinView
local function InitItemPanel(self,data)
    local skinId = data.tempId


    local zSkin = Z_Skin[data.tempId]

    self.countText.text = ""

    UIPublic.InitItemIconNew(self.icon, self.bg, RewardType.RewardTypeCharacterSkin, skinId, 0, false, false, self.frame)

    self.nameText.text = zSkin.Name
    self.descText.text = zSkin.Desc
end

---@param self UIThingsDetailSkinView
local function OnLangCreate(self)
    LangUtil.BindText(self.langRc:GetObject("TitleText")).text = LangUtil.GetSysLang(229) -- 详情
    self.nameText = LangUtil.BindText(self.langRc:GetObject("NameText"))
    self.descText = LangUtil.BindText(self.langRc:GetObject("DescText"))
    self.countText = LangUtil.BindText(self.langRc:GetObject("CountText"))
end

---@param self UIThingsDetailSkinView
local function OnCreate(self)
    base.OnCreate(self)
    EventTriggerListener.Get(self.rc:GetObject("EventBg")).onLuaClick = self.ctrl.CloseSelf
    self.icon = self.rc:GetObject("Icon"):GetComponent("Image")
    self.bg = self.rc:GetObject("ItemBg"):GetComponent("Image")
    self.frame = self.rc:GetObject("Frame"):GetComponent("Image")
end

---@param self UIThingsDetailSkinView
local function OnEnable(self)
    base.OnEnable(self)
    coroutine.start(function()
        self.gameObject:SetActive(false)
        self:OnRefresh()
        self.gameObject:SetActive(true)
    end)
end

---@param self UIThingsDetailSkinView
local function OnRefresh(self)
    InitItemPanel(self,self.model.data)
end

local function OnAddListener(self)
    base.OnAddListener(self)
end

local function OnRemoveListener(self)
    base.OnRemoveListener(self)
end

---@param self UIThingsDetailSkinView
local function OnDisable(self)
end

local function OnDestroy(self)
    base.OnDestroy(self)
end



UIThingsDetailSkinView.OnCreate = OnCreate
UIThingsDetailSkinView.OnEnable = OnEnable
UIThingsDetailSkinView.OnRefresh = OnRefresh
UIThingsDetailSkinView.OnAddListener = OnAddListener
UIThingsDetailSkinView.OnRemoveListener = OnRemoveListener
UIThingsDetailSkinView.OnDisable= OnDisable
UIThingsDetailSkinView.OnDestroy = OnDestroy
UIThingsDetailSkinView.OnLangCreate = OnLangCreate

return UIThingsDetailSkinView