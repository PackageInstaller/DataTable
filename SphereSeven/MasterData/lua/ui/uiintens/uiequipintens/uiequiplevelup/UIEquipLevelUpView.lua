--
-- <代码文件解释说明>
--

---@class UIEquipLevelUpView : UIBaseView
---@field model UIEquipLevelUpModel
---@field ctrl UIEquipLevelUpCtrl
---@field itemList UIItemClass[]
local UIEquipLevelUpView = BaseClass("UIEquipLevelUpView",UIBaseView)
local base = UIBaseView
local this = UIEquipLevelUpView

local EQUIPMENT_MAX_LEVEL = tonumber(Z_Misc["EQUIPMENT_MAX_LEVEL"].Value[1])
local GOLD_ID = tonumber(Z_Misc["GOLD_ID"].Value[1])
function this:OnLangCreate()
    LangUtil.GetSpriteLang(501, function(Sprite) self.langRc:GetObject("Pic"):GetComponent("Image").sprite = Sprite  end)
    LangUtil.BindText(self.langRc:GetObject("MaterialsTitle")).text = LangUtil.GetSysLang(1307) -- 材料
    LangUtil.BindText(self.langRc:GetObject("Title")).text = LangUtil.GetSysLang(84) -- 强化
    LangUtil.GetSpriteLang(507, function(Sprite) self.cancelButton.transform:Find("Text"):GetComponent("Image").sprite = Sprite  end) -- 取消
    LangUtil.GetSpriteLang(508, function(Sprite) self.levelUpButton.transform:Find("Text"):GetComponent("Image").sprite = Sprite  end) -- 强化

    self.currentEffectText = LangUtil.BindText(self.langRc:GetObject("OldDesc"))
    self.nextEffectText = LangUtil.BindText(self.langRc:GetObject("NewDesc"))
    self.descArraw = self.langRc:GetObject("DescArraw").gameObject

    local layout = self.langRc:GetObject("Layout").transform
    self.propertys = {}
    for i = 0, 2 do
        local child = layout:GetChild(i).transform
        local text = LangUtil.BindText(child:Find("Text"):GetComponent("Text"))
        local value = LangUtil.BindText(child:Find("Value"):GetComponent("Text"))
        local arraw = child:Find("Arraw").gameObject
        local finalValue = LangUtil.BindText(child:Find("FinalValue"):GetComponent("Text"))
        
        if i == 0 then
            self.currentLevelText = value
            self.nextLevelText = finalValue
            text.text = LangUtil.GetSysLang(1238) .. ":" -- 等级
            self.levelArraw = arraw
        else
            self.propertys[i] = {
                root = child.gameObject,
                text = text,
                value = value,
                arraw = arraw,
                finalValue = finalValue,
            }
        end
    end
end

function this:OnCreate()
    base.OnCreate(self)

    self.canLevelUp = false
    local eventBg = self.rc:GetObject("EventBg")
    UIUtil.AddBtnEvent(eventBg, function()
        self.ctrl.closeSelf()
    end)
    self.cancelButton = self.rc:GetObject("CancelButton")
    UIUtil.AddBtnEvent(self.cancelButton, function()
        self.ctrl.closeSelf()
    end)
    self.equipItemNew = self.rc:GetObject("EquipItemNew").transform
    self.levelUpButton = self.rc:GetObject("LevelUpButton")

    UIUtil.AddBtnEvent(self.levelUpButton, function()
        self.ctrl:SendLevelUpRequest(self.model.equipId)
    end)
    self.addEffectImage = self.rc:GetObject("AddEffectImage")
    self.itemList = {}
    self.itemRoot = self.rc:GetObject("ItemRoot")
    self.newDescRoot = self.rc:GetObject("NewDescRoot")
end

function this:OnEnable()
    base.OnEnable(self)
    self:OnRefresh()
end

function this:OnRefresh()
    UIPublic.InitEquipItemNew(self.equipItemNew, self.model.equip)

    local isMaxLevel = self.model.equip.Level >= EQUIPMENT_MAX_LEVEL
    
    self.currentLevelText.text = "LV." .. self.model.equip.Level
    self.currentEffectText.text = UIPublic.GetEquipEffectText(self.model.equip.TemplateId, self.model.equip.Level)
    if string.IsNullOrEmpty(self.currentEffectText.text) then
        self.currentEffectText.text = LangUtil.GetSysLang(911) -- 无
    end
    self.nextLevelText.text = "LV." .. self.model.equip.Level + 1
    self.nextLevelText.gameObject:SetActive(not isMaxLevel)
    self.addEffectImage:SetActive(not isMaxLevel)
    if not isMaxLevel then
        self.nextEffectText.text = UIPublic.GetEquipEffectText(self.model.equip.TemplateId, self.model.equip.Level + 1)
        if string.IsNullOrEmpty(self.nextEffectText.text) then
            self.nextEffectText.text = LangUtil.GetSysLang(911) -- 无
        end
    else
        self.nextEffectText.text = ""
    end

    self.itemRoot:SetActive(false)
    local propertyList = UIPublic.GetEquipProperty(self.model.equip.TemplateId, self.model.equip.Level)
    local count = 0
    for index, key in ipairs(PropertySort) do
        local property = propertyList[key.type]
        if property ~= nil then
            count = count + 1
            if self.propertys[count] == nil then
                Logger.LogError("equip property count is more than 2. templateId:" .. self.model.equip.TemplateId)
                break
            end
            self.propertys[count].text.text = LangUtil.GetSysLang(Z_Property[key.type].SysLangKey) .. ":"
            if key.IsPct then
                self.propertys[count].value.text = property .. "%"
            else
                self.propertys[count].value.text = property
            end
        end
    end

    self.propertys[1].root:SetActive(count >= 1)
    self.propertys[2].root:SetActive(count >= 2)

    if not isMaxLevel then
        ---@type {ItemId:number, Count:number}[]
        if Z_EquipLevelUp[self.model.equip.TemplateId] == nil then
            Logger.LogError("Z_EquipLevelUp表 不存在cid为" .. self.model.equip.TemplateId .. "的装备")
            return
        end
        if Z_EquipLevelUp[self.model.equip.TemplateId][self.model.equip.Level] == nil then
            Logger.LogError("Z_EquipLevelUp表 不存在cid为" .. self.model.equip.TemplateId .. "的装备的等级为" .. self.model.equip.Level .. "的数据")
            return
        end
        local needItems = Z_Cost[Z_EquipLevelUp[self.model.equip.TemplateId][self.model.equip.Level].Cost]
        local itemCount = 0

        self.canLevelUp = true

        self.itemRoot:SetActive(true)
        for key, value in pairs(needItems) do
            itemCount = itemCount + 1         
            if self.itemList[itemCount] == nil then
                self.itemList[itemCount] = UIItemClass(self.itemRoot.transform)
            end
            local count = UIPublic.GetItemAmount(value.ItemId)
            local color
            if count >= value.Count then
                color = Color.white
            else
                color = Color.red
                self.canLevelUp = false
            end
            self.itemList[itemCount].show()
            self.itemList[itemCount].SetData(value.ItemId, value.Count, color)
            self.itemList[itemCount].SetIsBag(true)
        end
        for i = itemCount + 1, #self.itemList do
            if self.itemList[i] ~= nil then
                self.itemList[i].hide()
            end
        end
        coroutine.start(function ()
            LayoutRebuilder.ForceRebuildLayoutImmediate(self.itemRoot.transform:GetComponent("RectTransform"))
        end)
        self.propertys[1].arraw:SetActive(true)
        self.propertys[2].arraw:SetActive(true)
        self.descArraw:SetActive(true)
        self.levelArraw:SetActive(true)
        self.newDescRoot:SetActive(true)
        local propertyList = UIPublic.GetEquipProperty(self.model.equip.TemplateId, self.model.equip.Level + 1)
        local count = 0
        for index, key in ipairs(PropertySort) do
            local property = propertyList[key.type]
            if property ~= nil then
                count = count + 1
                if self.propertys[count] == nil then
                    Logger.LogError("equip property count is more than 2. templateId:" .. self.model.equip.TemplateId)
                    break
                end
                if key.IsPct then
                    self.propertys[count].finalValue.text = property .. "%"
                else
                    self.propertys[count].finalValue.text = property
                end
            end
        end
    else
        self.canLevelUp = false
        self.propertys[1].arraw:SetActive(false)
        self.propertys[1].finalValue.text = ""
        self.propertys[2].arraw:SetActive(false)
        self.propertys[2].finalValue.text = ""
        self.descArraw:SetActive(false)
        self.levelArraw:SetActive(false)
        self.newDescRoot:SetActive(false)
    end

    UIPublic.InitButton(self.levelUpButton, self.canLevelUp)
end

local function ON_EQUIP_UPDATE(self)
    this.OnRefresh(self)
end

function this:OnAddListener()
    base.OnAddListener(self)
    self:AddUIListener(UIMessageNames.ON_EQUIP_UPDATE, ON_EQUIP_UPDATE)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    self:RemoveUIListener(UIMessageNames.ON_EQUIP_UPDATE)
end


function this:OnDisable()
    base.OnDisable(self)
end

function this:OnDestroy()
    base.OnDestroy(self)
end

return this
