---@class UIFormationChooseFightSoulView : UIBaseView
---@field model UIFormationChooseFightSoulModel
---@field ctrl UIFormationChooseFightSoulCtrl
---@field chooseFightSoul FightSoul
---@field oldFightSoul FightSoul
local UIFormationChooseFightSoulView = BaseClass("UIFormationChooseFightSoulView",UIBaseView);
local base = UIBaseView
local this = UIFormationChooseFightSoulView
local pfbName = "FightVisitItemMid_Formation"

local recordOrder = {order = 1,kind = 1, lockFirst = true, firstChooseFuns = nil}  --是否正序  顺序类型 优先显示锁定的
local screenTypes = {
    --- 职业
    abiliType = 0,
    --- 星级
    star = 0, 
    --- 稀有度
    rare = 0,
    --- 是否装备
    isEquip = 0
}

local ShowPropertyIndex = {
    [1] = NumericType.Hp,
    [2] = NumericType.Atk,
    [3] = NumericType.Def,
    [4] = NumericType.MagicDef,
}

function this:InitButton()
    if self.oldFightSoul ~= nil and self.chooseFightSoul ~= nil and self.oldFightSoul.Id == self.chooseFightSoul.Id then
        self.cancelButton:SetActive(true)
        self.confirmButton:SetActive(false)
    else
        self.cancelButton:SetActive(false)
        self.confirmButton:SetActive(self.chooseFightSoul ~= nil)
    end
end

function this:RefreshChooseFightSoulShow()
    self.content:DOLocalMoveY(0, 0)

        if self.chooseFightSoul == nil then
            for property, v in pairs(self.propertys) do
                v.arraw1:SetActive(false)
                v.arraw2:SetActive(false)
                v.addValueText.text = ""
            end
            self.newDesc.text = LangUtil.GetSysLang(1217) -- 无效果
            self.newDesc.alignment = 4--TextAnchor.MiddleCenter
        else
            for property, v in pairs(self.propertys) do
                local value = self.chooseFightSoul:GetProperty(property)
                v.addValueText.text = value
                v.arraw1:SetActive(value > v.oldValue)
                v.arraw2:SetActive(value < v.oldValue)
            end
            self.newDesc.text = UIPublic.GetFightSoulEffectText(self.chooseFightSoul.TemplateId, self.chooseFightSoul.Star)
            UIPublic.InitVsFightSoulItemMId(self.chooseFightSoul, self.newFightVisitItem.transform, nil, true)
            self.newFightVisitItemName.text = self.chooseFightSoul.config.Name
            self.newDesc.alignment = 0--TextAnchor.UpperLeft
        end
        self.newFightVisitItem:SetActive(self.chooseFightSoul ~= nil)
        self.newFightSoulAdd:SetActive(self.chooseFightSoul == nil)
        self:InitButton()

    coroutine.start(function () 
		coroutine.waitforframes(1)
        LayoutRebuilder.ForceRebuildLayoutImmediate(self.content:GetComponent("RectTransform"))
    end)
end

function this.OnScreen(self)
    local uiData = {}
    uiData.recordOrder = recordOrder
    uiData.screenTypes = screenTypes
    uiData.callBack = function(list,kind)
        screenTypes = table.clone(list)
        recordOrder.kind = kind
        this.RefreshFightSoulListData(self)
        this.RefreshFightSoulList(self)
        self.scroll:MoveTop()
    end

    UIManager:GetInstance():OpenWindow(UIWindowNames.UIFightSoulSort, uiData)
end

function this.OnSort(self)
    recordOrder.order = (recordOrder.order == 1 and {2}or {1})[1]
    this.RefreshSortButton(self)
    this.RefreshFightSoulListData(self)
    this.RefreshFightSoulList(self)
end

---@param self UIFormationChooseFightSoulView
function this.RefreshFightSoulListData(self)
    self.trueShowFightSoulList = {}
    for k,v in table.pairsByKeys(self.showFightSoulList) do
        table.insert(self.trueShowFightSoulList,v)
    end
    self.trueShowFightSoulList = UIPublic.FightSoulScreenFunc(self.trueShowFightSoulList,screenTypes)
    table.sort(self.trueShowFightSoulList, function(a,b) return UIPublic.FightSoulSortFunc(a,b,recordOrder)end )

    if recordOrder.order ~= 1 then
        self.trueShowFightSoulList = table.reverseTable(self.trueShowFightSoulList)
    end

    if self.chooseFightSoul ~= nil then
        local hasOld = false
        -- 将 self.chooseFightSoul 提到第一位
        for i = 1, #self.trueShowFightSoulList do
            if self.trueShowFightSoulList[i].Id == self.chooseFightSoul.Id then
                table.remove(self.trueShowFightSoulList, i)
                table.insert(self.trueShowFightSoulList, 1, self.chooseFightSoul)
                hasOld = true
                break
            end
        end
        if not hasOld then
            table.insert(self.trueShowFightSoulList, 1, self.chooseFightSoul)
        end
    end

    if self.oldFightSoul ~= nil then
        local hasOld = false
        -- 将 self.oldFightSoul 提到第一位
        for i = 1, #self.trueShowFightSoulList do
            if self.trueShowFightSoulList[i].Id == self.oldFightSoul.Id then
                table.remove(self.trueShowFightSoulList, i)
                table.insert(self.trueShowFightSoulList, 1, self.oldFightSoul)
                hasOld = true
                break
            end
        end
        if not hasOld then
            table.insert(self.trueShowFightSoulList, 1, self.oldFightSoul)
        end
    end
end

---@param self UIFormationChooseFightSoulView
function this.RefreshFightSoulList(self)
    -- self.vs_hint:SetActive(table.count(self.fightSoulShowList) == 0)
    if self.chooseFightSoul == nil then
        if self.trueShowFightSoulList[1] == nil then
            -- 如果没有 就是空
            self.chooseFightSoul = nil
        else
            if self.oldFightSoul ~= nil and self.trueShowFightSoulList[1].Id == self.oldFightSoul.Id then
                -- 如果第一个是旧的,就选第二个
                if table.count(self.trueShowFightSoulList) > 1 then
                    self.chooseFightSoul = self.trueShowFightSoulList[2]
                else
                    -- 如果只有一个,就选这个
                    self.chooseFightSoul = self.trueShowFightSoulList[1]
                end
            else
                -- 如果第一个不是旧的,就选第一个
                self.chooseFightSoul = self.trueShowFightSoulList[1]
            end
        end
    end

    self.scroll:RefreshData(self.trueShowFightSoulList)
    local isNull = table.count(self.trueShowFightSoulList) == 0
    self.ScrollViewBg.enabled = not isNull
    self.NullImage:SetActive(isNull)

    self.scroll:MoveTop()
end

--- 刷新排序按钮显示
---@param self UIFormationChooseFightSoulView
function this.RefreshSortButton(self)
    local txt = self.sortButton.transform:Find("Text"):GetComponent("Text")
    txt.text = (recordOrder.order == 1 and {LangUtil.GetSysLang(154)} or {LangUtil.GetSysLang(153)})[1]
end

---@param self UIFormationChooseFightSoulView
function this.OnLangCreate(self)
    LangUtil.BindText(self.langRc:GetObject("HoldNumText")).text = LangUtil.GetSysLang(354)
    self.holdNumValueText = LangUtil.BindText(self.langRc:GetObject("HoldNumValue"), FontType.All_Number)
    self.oldDesc = LangUtil.BindText(self.langRc:GetObject("Desc"))
    self.newDesc = LangUtil.BindText(self.langRc:GetObject("NextDesc"))

    LangUtil.GetSpriteLang(503, function(sprite) self.langRc:GetObject("PropertyTitle"):GetComponent("Image").sprite = sprite end) -- 属性
    LangUtil.GetSpriteLang(472, function(sprite) self.langRc:GetObject("EquipEffectTitle"):GetComponent("Image").sprite = sprite end) -- 装备效果
    LangUtil.GetSpriteLang(504, function(sprite) self.langRc:GetObject("ConfirmText"):GetComponent("Image").sprite = sprite end) -- 替换战魂
    LangUtil.GetSpriteLang(505, function(sprite) self.langRc:GetObject("CancelText"):GetComponent("Image").sprite = sprite end) -- 卸下战魂

    self.oldFightVisitItemName = LangUtil.BindText(self.rc:GetObject("OldFightVisitItem").transform:Find("Name"))
    self.newFightVisitItemName = LangUtil.BindText(self.rc:GetObject("NewFightVisitItem").transform:Find("Name"))

    LangUtil.BindText(self.langRc:GetObject("OnPropertyText")).text =  LangUtil.GetSysLang(1278)
end

function this:OnCreate()
    base.OnCreate(self)

    self.returnButton = self.rc:GetObject("ReturnButton")
    UIPublic.SetBackButton(
        self.returnButton,
        UIWindowNames.UIFormationChooseFightSoul,
        506
    )

    self.onProperty = self.rc:GetObject("OnProperty")
    UIUtil.AddBtnEvent(self.onProperty,function()
        local id
        if self.oldFightSoul ~= nil then
            id = self.oldFightSoul.Id
        end
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIFormationChooseFightSoulProperty, {
            characterId = self.model.characterId, 
            fightSoulId = id,
        })
    end)

    self.ScrollViewBg = self.rc:GetObject("ScrollViewBg"):GetComponent("Image")
    self.NullImage = self.rc:GetObject("NullImage")
    self.showFightSoulList = {}
    self.trueShowFightSoulList = {}
    self.chooseFightSoul = nil
    self.content = self.rc:GetObject("Content").transform
    self.scrollView = self.rc:GetObject("ScrollView")
     ---@type VerticalScroll
     self.scroll = VerticalScroll.New()
     self.scroll:SetUpdateCount(12)
     self.scroll:Clear()
     self.fightSoulContent = self.rc:GetObject("FightSoulContent").transform
     self.scroll:ScrollInit(self.trueShowFightSoulList, self.scrollView, pfbName, function (arg)
        local gameObject = arg.go
        ---@type FightSoul
        local fightSoul = arg.data
        local index = arg.index
        UIPublic.InitVsFightSoulItemMId(fightSoul, gameObject.transform, nil, true)
        local select = gameObject.transform:Find("Select").gameObject
        local holder = gameObject.transform:Find("Holder").gameObject
        select:SetActive(self.model.fightSoulToCard[fightSoul.Id] ~= nil)
        holder:SetActive(self.model.fightSoulToCard[fightSoul.Id] ~= nil)
    
        local BgChooseImage = gameObject.transform:Find("BgRoot/BgChooseImage").gameObject
        BgChooseImage:SetActive(self.chooseFightSoul ~= nil and fightSoul.Id == self.chooseFightSoul.Id)
        UIUtil.AddBtnEvent(gameObject,function()
            -- if self.oldFightSoul ~= nil and self.oldFightSoul.Id == fightSoul.Id then
            --     return
            -- end

            -- if self.chooseFightSoul ~= nil and self.chooseFightSoul.Id == fightSoul.Id then
            --     self.chooseFightSoul = nil
            -- else
            --     self.chooseFightSoul = fightSoul
            -- end

            self.chooseFightSoul = fightSoul
            for i = 0, self.fightSoulContent.childCount - 1 do
                if self.fightSoulContent:GetChild(i).gameObject ~= gameObject then
                    self.fightSoulContent:GetChild(i).gameObject.transform:Find("BgRoot/BgChooseImage").gameObject:SetActive(false)
                else
                    BgChooseImage:SetActive(self.chooseFightSoul ~= nil and fightSoul.Id == self.chooseFightSoul.Id)
                end
            end

            self:RefreshChooseFightSoulShow()
        end)
     end)

     self.propertys = {}
     local property = self.rc:GetObject("Property").transform
     for i = 0, property.childCount-1 do
        local child = property.transform:GetChild(i)
        local property = ShowPropertyIndex[i + 1]
        self.propertys[property] = {}
        self.propertys[property].valueText = LangUtil.BindText(child:Find("Value"))
        self.propertys[property].oldValue = 0
        self.propertys[property].addValueText = LangUtil.BindText(child:Find("AddValue"))
        self.propertys[property].arraw1 = child:Find("Arraw1").gameObject
        self.propertys[property].arraw2 = child:Find("Arraw2").gameObject

        child:Find("Text"):GetComponent("Text").text = LangUtil.GetSysLang(Z_Property[property].SysLangKey)
     end

     self.sortButton = self.rc:GetObject("SortButton")
     UIUtil.AddBtnEvent(self.sortButton, function(v) this.OnSort(self) end)
     self.screenBtn = self.rc:GetObject("ScreenButton")
     UIUtil.AddBtnEvent(self.screenBtn, function() this.OnScreen(self) end)

     self.confirmButton = self.rc:GetObject("ConfirmButton")
     UIUtil.AddBtnEvent(self.confirmButton, function(v)
        if self.model.fightSoulToCard[self.chooseFightSoul.Id] ~= nil then
            ---@type ToolTipFirstData
            local tipData = {}
            tipData.message = LangUtil.GetSysLang(1315)
            tipData.callBack = function()
                self.ctrl:OnConfirmButtonClick(self.chooseFightSoul)
                Game.Scene:GetComponent("SoundComponent"):PlaySoulEquipSound(self.chooseFightSoul.TemplateId)
            end

            UIUtil.ToolTipFirst(tipData)
        else
            self.ctrl:OnConfirmButtonClick(self.chooseFightSoul)
            Game.Scene:GetComponent("SoundComponent"):PlaySoulEquipSound(self.chooseFightSoul.TemplateId)
        end
    end)
    self.cancelButton = self.rc:GetObject("CancelButton")
    UIUtil.AddBtnEvent(self.cancelButton, function(v)
        self.ctrl:OnConfirmButtonClick(nil)
    end)

    self.oldFightVisitItem = self.rc:GetObject("OldFightVisitItem")
    self.newFightVisitItem = self.rc:GetObject("NewFightVisitItem")
    self.oldFightSoulAdd = self.rc:GetObject("OldFightSoulAdd")
    self.newFightSoulAdd = self.rc:GetObject("NewFightSoulAdd")
end

function this:OnEnable()
    base.OnEnable(self)
    self.chooseFightSoul = nil
    recordOrder = {
        order = 1,
        kind = 1,
        lockFirst = true, 
        firstChooseFuns = function(a, b)
            if self.model.fightSoulToCard[a.Id] ~= self.model.fightSoulToCard[b.Id] then
                return not self.model.fightSoulToCard[a.Id] and self.model.fightSoulToCard[b.Id]
            end
            return nil
        end
    }  --是否正序  顺序类型 优先显示锁定的
    screenTypes = {
        --- 职业
        abiliType = 0,
        --- 星级
        star = 0, 
        --- 稀有度
        rare = 0,
        --- 是否装备
        isEquip = 0
    }
    self.onProperty:SetActive(self.model.isShowProperty)
    self:OnRefresh()
end

---@param self UIFormationChooseFightSoulView
function this.OnRefresh(self)
    self.showFightSoulList = self.model.showFightSouls
    self.oldFightSoul = self.model.chooseFightSoul
    self.holdNumValueText.text = table.count(self.model.showFightSouls) .. "/" .. Game.Scene.Player:GetComponent("FightSoulComponent"):GetBagCapacity()
    this.RefreshFightSoulListData(self)
    this.RefreshFightSoulList(self)

    if self.oldFightSoul ~= nil then
        for property, v in pairs(self.propertys) do
            local value = self.oldFightSoul:GetProperty(property)
            v.valueText.text = value
            v.oldValue = value
        end
        self.oldDesc.text = UIPublic.GetFightSoulEffectText(self.oldFightSoul.TemplateId, self.oldFightSoul.Star)
        UIPublic.InitVsFightSoulItemMId(self.oldFightSoul, self.oldFightVisitItem.transform, nil, true)
        self.oldFightVisitItemName.text = self.oldFightSoul.config.Name
        self.oldDesc.alignment = 0--TextAnchor.UpperLeft
    else
        for _, v in pairs(self.propertys) do
            v.valueText.text = 0
            v.oldValue = 0
        end
        self.oldDesc.text = LangUtil.GetSysLang(1217) -- 无效果
        -- text 文本设置居中
        self.oldDesc.alignment = 4--TextAnchor.MiddleCenter
    end
    self.oldFightVisitItem:SetActive(self.oldFightSoul ~= nil)
    self.oldFightSoulAdd:SetActive(self.oldFightSoul == nil)
    self:RefreshChooseFightSoulShow()
end

local function ON_FIGHTSOUL_DATA_UPDATE(self)
    this.OnRefresh(self)
end

function this.OnAddListener(self)
    base.OnAddListener(self)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self)
end

---@param self UIFormationChooseFightSoulView
function this.OnDisable(self)
    base.OnDisable(self)
end

---@param self UIFormationChooseFightSoulView
function this.OnDestroy(self)
    base.OnDestroy(self)
    self.scroll:Dispose()
end

return this;

