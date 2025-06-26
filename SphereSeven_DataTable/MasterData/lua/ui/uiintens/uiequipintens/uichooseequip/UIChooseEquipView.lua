--
-- <代码文件解释说明>
--

---@class UIChooseEquipView : UIBaseView
---@field model UIChooseEquipModel
---@field ctrl UIChooseEquipCtrl
---@field currentEquip Equip
local UIChooseEquipView = BaseClass("UIChooseEquipView",UIBaseView)
local base = UIBaseView
local this = UIChooseEquipView
local pfbName = "EquipItemNew_Choose"

local recordOrder = { order = 1, kind = 1 }  --是否正序  顺序类型
local screenTypes = { star = 0, Part = 0, exclusive = 0, isEquip = 0 }

local EquipInfoIndex = {
    old = 1,
    new = 2,
}

function this:OnScreenButton()
    local uiData = {}
    uiData.recordOrder = recordOrder
    uiData.screenTypes = screenTypes
    uiData.callBack = function(list, kind)
        screenTypes = table.clone(list)
        recordOrder.kind = kind
        self:InitEquipListData()
        self.equipScroll:MoveTop()
    end

    UIManager:GetInstance():OpenWindow(UIWindowNames.UIEquipSort1, uiData)
end

function this:InitSortButton()
    self.sortText.text = (recordOrder.order == 1 and { LangUtil.GetSysLang(154) } or { LangUtil.GetSysLang(153) })[1]
    self.equipScroll:MoveTop()
end

function this:OnSortButton()
    recordOrder.order = (recordOrder.order == 1 and { 2 } or { 1 })[1]
    self:InitSortButton()
    self:InitEquipListData()
end

function this:InitEquipListData()
    -- self.equipShowList = {}
    self.equipShowList = UIPublic.EquipScreenFunc(self.model.showEquips, screenTypes)
    table.sort(self.equipShowList, function(a, b)
        return UIPublic.EquipSortFunc(a, b, recordOrder)
    end)

    if recordOrder.order ~= 1 then
        self.equipShowList = table.reverseTable(self.equipShowList)
    end

    self.hint:SetActive(table.count(self.equipShowList) == 0)
    self.holdNumValue.text = table.count(Game.Scene.Player:GetComponent("EquipComponent"):GetEquipList(nil, self.model.characterId)) .. "/" .. Game.Scene.Player:GetComponent("EquipComponent"):GetBagCapacity()
    if self.model.oldEquip ~= nil then
        table.insert(self.equipShowList, 1, self.model.oldEquip)
    end

    self.oldEquipSelect = nil
    self.equipScroll:RefreshData(self.equipShowList)
end

function this:RefreshEquipInfo()
    for key, value in pairs(self.propertys) do
        value.object:SetActive(false)
    end

    -- (key:属性枚举, value:数值)
    local oldProperty = {}
    local newProperty = {}
    if self.model.oldEquip ~= nil then
        oldProperty = UIPublic.GetEquipPropertyByEid(self.model.oldEquip.Id)
        local desc = UIPublic.GetEquipEffectText(self.model.oldEquip.TemplateId, self.model.oldEquip.Level)
        if string.IsNullOrEmpty(desc) then
            self.oldDesc.text = LangUtil.GetSysLang(911)
        else
            self.oldDesc.text = desc
        end
        self.oldName.text = Z_Equip[self.model.oldEquip.TemplateId].Name
    else
        self.oldDesc.text = LangUtil.GetSysLang(1305)
        self.oldName.text = ""
    end
    if self.currentEquip ~= nil then
        newProperty = UIPublic.GetEquipPropertyByEid(self.currentEquip.Id)
        local desc = UIPublic.GetEquipEffectText(self.currentEquip.TemplateId, self.currentEquip.Level)
        if string.IsNullOrEmpty(desc) then
            self.newDesc.text = LangUtil.GetSysLang(911)
        else
            self.newDesc.text = desc
        end
        self.newName.text = Z_Equip[self.currentEquip.TemplateId].Name
    else
        self.newDesc.text = LangUtil.GetSysLang(1305)
        self.newName.text = ""
    end
    self.effectArrow:SetActive(self.model.oldEquip ~= nil and self.currentEquip ~= nil)
    --- 显示哪些属性
    local allProperty = {}
    for key, value in pairs(oldProperty) do
        allProperty[key] = {
            old = value,
            new = newProperty[key] or 0,
        }
    end
    for key, value in pairs(newProperty) do
        if allProperty[key] == nil then
            allProperty[key] = {
                old = 0,
                new = newProperty[key]
            }
        else
            allProperty[key].new = value
        end
    end

    --- 准备比较大小 并且赋值数据
    for key, value in pairs(allProperty) do
        self.propertys[key].object:SetActive(true)
        if self.propertys[key].isPct then
            self.propertys[key].value.text = value.old .. "%"
            self.propertys[key].newValue.text = value.new .. "%"
        else
            self.propertys[key].value.text = value.old
            self.propertys[key].newValue.text = value.new
        end
        self.propertys[key].arraw1:SetActive(value.old < value.new)
        self.propertys[key].arraw2:SetActive(value.old > value.new)
        if value.old > value.new then
            self.propertys[key].newValue.color = Color(1, 61/255, 61/255)
        else
            self.propertys[key].newValue.color = Color(1, 192/255, 61/255)
        end
    end
end

function this:RefreshLeftEquips()
    for slot, value in ipairs(self.tabList) do
        local equip = self.model.equips[slot]
        if equip == nil then
            value.item:SetActive(false)
        else
            value.item:SetActive(true)
            UIPublic.InitEquipItemNew(value.item.transform, equip)
        end
    end
end

function this:OnChangeTab(slot)
    for index, value in ipairs(self.tabList) do
        value.active:SetActive(index == slot)
    end
    self.model.slot = slot
    self.currentEquip = nil
    self.model:RefreshEquips()
    self.model:RefreshShowEquips()
    self:RefreshEquipInfo()
    self:InitEquipListData()
end

function this:OnLangCreate()
    -- LangUtil.BindText(self.langRc:GetObject("Text"))
    self.holdNumValue = LangUtil.BindText(self.langRc:GetObject("HoldNumValue"))
    LangUtil.BindText(self.langRc:GetObject("HoldNumText")).text = LangUtil.GetSysLang(354) -- 持有
    self.sortText = LangUtil.BindText(self.langRc:GetObject("SortText"))
    LangUtil.BindText(self.langRc:GetObject("ScreenText")).text = LangUtil.GetSysLang(155)

    LangUtil.GetSpriteLang(499, function(sprite) self.langRc:GetObject("ConfirmText"):GetComponent("Image").sprite = sprite end)
    LangUtil.GetSpriteLang(500, function(sprite) self.langRc:GetObject("UnloadText"):GetComponent("Image").sprite = sprite end)
    LangUtil.GetSpriteLang(497, function(sprite) self.langRc:GetObject("PropertyTitle"):GetComponent("Image").sprite = sprite end)
    LangUtil.GetSpriteLang(498, function(sprite) self.langRc:GetObject("EffectTitle"):GetComponent("Image").sprite = sprite end)
    LangUtil.GetSpriteLang(566, function(sprite) self.langRc:GetObject("LevelUpText"):GetComponent("Image").sprite = sprite end)

    self.oldDesc = LangUtil.BindText(self.langRc:GetObject("OldDesc"))
    self.oldName = LangUtil.BindText(self.langRc:GetObject("OldName"))
    self.newDesc = LangUtil.BindText(self.langRc:GetObject("NewDesc"))
    self.newName = LangUtil.BindText(self.langRc:GetObject("NewName"))

    self.propertys = {}
    local rawProperty = self.propertyRoot:GetChild(0)
    for index, value in ipairs(PropertySort) do
        local property = value.type
        local propertyObj
        if self.propertyRoot.childCount >= index then
            propertyObj = self.propertyRoot:GetChild(index - 1).gameObject
        else
            propertyObj = GameObject.Instantiate(rawProperty)
            propertyObj.transform:SetParent(self.propertyRoot.transform, false)

            propertyObj.transform:SetParent(rawProperty.transform.parent)
            propertyObj.transform.localPosition = Vector3.New(0,0,0)
            propertyObj.transform.localScale = Vector3.New(1,1,1)
        end
        self.propertys[property] = {}
        self.propertys[property].object = propertyObj.gameObject
        if Z_Property[property] == nil then
            local a = 1
        end
        LangUtil.BindText(propertyObj.transform:Find("Text")).text = LangUtil.GetSysLang(Z_Property[property].SysLangKey)
        self.propertys[property].isPct = value.IsPct
        self.propertys[property].value = LangUtil.BindText(propertyObj.transform:Find("Value"))
        self.propertys[property].newValue = LangUtil.BindText(propertyObj.transform:Find("NewValue"))
        self.propertys[property].arraw1 = propertyObj.transform:Find("Arraw1").gameObject
        self.propertys[property].arraw2 = propertyObj.transform:Find("Arraw2").gameObject
    end
end

function this:OnCreate()
    base.OnCreate(self)
    self.currentEquip = nil
    self.oldEquipSelect = nil

    self.sortButton = self.rc:GetObject("SortButton")
    self.screenButton = self.rc:GetObject("ScreenButton")
    self.returnButton = self.rc:GetObject("ReturnButton")
    self.hint = self.rc:GetObject("Hint")
    self.confirmButton = self.rc:GetObject("ConfirmButton")
    self.unloadButton = self.rc:GetObject("UnloadButton")
    self.levelUpButton = self.rc:GetObject("LevelUpButton")

    UIUtil.AddBtnEvent(self.sortButton, function() self:OnSortButton() end)
    UIUtil.AddBtnEvent(self.screenButton, function() self:OnScreenButton() end)
    UIPublic.SetBackButton(
        self.returnButton,
        UIWindowNames.UIChooseEquip,
        422
    )
    UIUtil.AddBtnEvent(self.confirmButton, function()
        if self.model.callBack ~= nil then
            if self.currentEquip ~= nil then
                self.model.callBack(self.model.slot, self.currentEquip.Id)
                self.currentEquip = nil
            end
        end
    end)

    UIUtil.AddBtnEvent(self.unloadButton, function()
        if self.model.callBack ~= nil then
            self.model.callBack(self.model.slot, nil)
            self.currentEquip = nil
        end
    end)

    UIUtil.AddBtnEvent(self.levelUpButton, function()
        if self.currentEquip == nil and self.model.oldEquip == nil then
            UIUtil.ToolTipFourth(LangUtil.GetSysLang(1305))
            return
        end
        if self.currentEquip ~= nil then
            UIManager:GetInstance():OpenWindow(UIWindowNames.UIEquipLevelUp,{equipId = self.currentEquip.Id})
        else
            UIManager:GetInstance():OpenWindow(UIWindowNames.UIEquipLevelUp,{equipId = self.model.oldEquip.Id})
        end
    end)

    self.propertyRoot = self.rc:GetObject("Property").transform
    self.propertyButton = self.rc:GetObject("PropertyButton").gameObject
    UIUtil.AddBtnEvent(self.propertyButton, function()
        Logger.LogError("todo: 显示角色属性详情")
    end)
    self.effectArrow = self.rc:GetObject("EffectArrow")

    self.equipScroll = VerticalScroll.New()
    self.equipScroll:SetUpdateCount(5)

    self.equipShowList = {}
    self.equipScrollView = self.rc:GetObject("EquipScrollView"):GetComponent("ScrollRect")
    self.equipContent = self.rc:GetObject("EquipContent").transform
    self.equipScroll:ScrollInit(self.equipShowList, self.equipScrollView, pfbName, function(arg)
        local gameObject = arg.go
        local equip = arg.data
        local select = gameObject.transform:Find("Bottom/Select").gameObject
        if self.model.oldEquip == nil then
            gameObject.transform:Find("Bg/Mask").gameObject:SetActive(false)
        else
            gameObject.transform:Find("Bg/Mask").gameObject:SetActive(self.model.oldEquip.Id == equip.Id)
        end
        UIPublic.InitEquipItemNew(gameObject.transform, equip)
        if self.currentEquip ~= nil then
            select:SetActive(self.currentEquip.Id == equip.Id)
        else
            select:SetActive(false)
        end

        UIUtil.AddBtnEvent(gameObject, function(go)
            if self.model.oldEquid ~= nil and equip.Id == self.model.oldEquip.Id then
                -- 如果跟旧的是一个, 就不管
                return
            elseif self.currentEquip ~= nil and equip.Id == self.currentEquip.Id then
                -- 如果是已经选的这个 就取消
                self.currentEquip = nil
            else
                self.currentEquip = equip
            end

            self:RefreshEquipInfo()
            for i = 0, self.equipContent.childCount - 1 do
                if self.equipContent:GetChild(i).gameObject ~= gameObject then
                    self.equipContent:GetChild(i).gameObject.transform:Find("Bottom/Select").gameObject:SetActive(false)
                else
                    select:SetActive(self.currentEquip ~= nil)
                end
            end
            if self.oldEquipSelect ~= nil then
                self.oldEquipSelect:SetActive(true)
            end
        end)
    end)

    self.tabList = {}
    local left = self.rc:GetObject("Left").transform
    for i = 0, left.childCount - 1 do
        local tab = left:GetChild(i)
        local slot = i + 1
        self.tabList[slot] = {}
        self.tabList[slot].active = tab:Find("Active").gameObject
        self.tabList[slot].item = tab:Find("Item").gameObject

        UIUtil.AddBtnEvent(tab, function(go)
            self:OnChangeTab(slot)
        end)
    end
end

function this:OnEnable()
    base.OnEnable(self)
    self.currentEquip = nil
    recordOrder = { order = 1, kind = 1 }  --是否正序  顺序类型
    screenTypes = { star = 0, Part = 0, exclusive = 0, isEquip = 0 }

    self:OnRefresh()
end

function this:OnRefresh()
    self:OnChangeTab(self.model.slot)
    self:RefreshLeftEquips()
    self:InitEquipListData()
    self:RefreshEquipInfo()
    self:InitSortButton()
end

local function ON_CARD_INFO_CHG_ChOOSE_EQUIP(self)
    self.model:RefreshEquips()
    self:RefreshLeftEquips()
    self:RefreshEquipInfo()
end

local function ON_EQUIP_UPDATE(self)
    self.model:RefreshEquips()
    self.model:RefreshShowEquips()
    self:RefreshLeftEquips()
    self:InitEquipListData()
    self:RefreshEquipInfo()
end

function this:OnAddListener()
    base.OnAddListener(self)
    self:AddUIListener(UIMessageNames.ON_CARD_INFO_CHG_ChOOSE_EQUIP, ON_CARD_INFO_CHG_ChOOSE_EQUIP)
    self:AddUIListener(UIMessageNames.ON_EQUIP_UPDATE, ON_EQUIP_UPDATE)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    self:RemoveUIListener(UIMessageNames.ON_CARD_INFO_CHG_ChOOSE_EQUIP)
    self:RemoveUIListener(UIMessageNames.ON_EQUIP_UPDATE)
end

function this:OnDisable()
    base.OnDisable(self)
end

function this:OnDestroy()
    base.OnDestroy(self)
    self.equipScroll:Dispose()
end

return this
