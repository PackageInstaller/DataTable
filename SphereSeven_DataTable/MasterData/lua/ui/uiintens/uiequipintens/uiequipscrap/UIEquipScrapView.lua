--
-- <代码文件解释说明>
--

---@class UIEquipScrapView : UIBaseView
---@field model UIEquipScrapModel
---@field ctrl UIEquipScrapCtrl
---@field equipShowList Equip[]
local UIEquipScrapView = BaseClass("UIEquipScrapView",UIBaseView)
local base = UIBaseView
local this = UIEquipScrapView

--- 最大分解上限
local EQUIPMENT_MAX_SCRAP_COUNT = tonumber(Z_Misc["EQUIPMENT_MAX_SCRAP_COUNT"].Value[1])

local PrefabName = "EquipItemNew_Prop_Scrap"
local recordOrder = { order = 1, kind = 1 }  --是否正序  顺序类型
local screenTypes = { star = 0, Part = 0, exclusive = 0, isEquip = 0 }

function this:RefreshChooseInfo()
    self.itemIds = {}
    self.itemsCount = {}
    for _, equip in ipairs(self.chooseEquips) do
        local items = UIPublic.GetEquipDecomposeItem(equip.TemplateId, equip.Star, equip.Level)
        for _, value in pairs(items) do
            if self.itemsCount[value.id] == nil then
                table.insert(self.itemIds, value.id)
                self.itemsCount[value.id] = value.count
            else
                self.itemsCount[value.id] = self.itemsCount[value.id] + value.count
            end
        end
    end
    if table.count(self.itemIds) == 0 then
        self.getItem:SetActive(false)
    else
        self.getItem:SetActive(true)
        if self.itemIds[1] ~= nil then
            local id = self.itemIds[1]
            self.item1.gameObject:SetActive(true)
            UIUtil.SetSprite(self.item1,AtlasConfig.Item,GetItemIcon(Z_Item[id]),true)
            self.item1Text.text = "x" .. self.itemsCount[id]
        else
            self.item1.gameObject:SetActive(false)
        end
        
        if self.itemIds[2] ~= nil then
            local id = self.itemIds[2]
            self.item2.gameObject:SetActive(true)
            UIUtil.SetSprite(self.item2,AtlasConfig.Item,GetItemIcon(Z_Item[id]),true)
            self.item2Text.text = "x" .. self.itemsCount[id]
        else
            self.item2.gameObject:SetActive(false)
        end
    end

    self.holdNumberValue.text = table.count(self.chooseIds) .. "/" .. EQUIPMENT_MAX_SCRAP_COUNT
end

function this:ClearChoose()
    self.chooseEquips = {}
    self.chooseIds = {}
    self:RefreshChooseInfo()
end

function this:OnScreenButton()
    local uiData = {}
    uiData.recordOrder = recordOrder
    uiData.screenTypes = screenTypes
    uiData.callBack = function(list, kind)
        screenTypes = table.clone(list)
        recordOrder.kind = kind
        self:ClearChoose()
        self:InitEquipListData()
        --this.scrollView.verticalScrollbar.value = 1
        self.scroll:MoveTop()
    end

    UIManager:GetInstance():OpenWindow(UIWindowNames.UIEquipSort1, uiData)
end

function this:InitSortButton()
    self.sortButtonText.text = (recordOrder.order == 1 and { LangUtil.GetSysLang(154) } or { LangUtil.GetSysLang(153) })[1]
    --this.scrollView.verticalScrollbar.value = 1
    self.scroll:MoveTop()
end

function this:OnSortButton()
    recordOrder.order = (recordOrder.order == 1 and { 2 } or { 1 })[1]
    self:InitSortButton()
    self:ClearChoose()
    self:InitEquipListData()
end

function this:InitEquipListData()
    self.equipShowList = {}
    for k, v in table.pairsByKeys(self.model.equipList) do
        table.insert(self.equipShowList, v)
    end

    self.equipShowList = UIPublic.EquipScreenFunc(self.equipShowList, screenTypes)
    table.sort(self.equipShowList, function(a, b)
        return UIPublic.EquipSortFunc(a, b, recordOrder)
    end)

    if recordOrder.order ~= 1 then
        self.equipShowList = table.reverseTable(self.equipShowList)
    end

    self.scroll:RefreshData(self.equipShowList)
end

function this:OnQuickSelect(count)
    self:ClearChoose()
    local newCount = 0
    for index, equip in ipairs(self.equipShowList) do
        if not equip.Lock and equip.Level == 1 and equip.characterId == 0 then
            if equip.Star == count then
                table.insert(self.chooseIds, equip.Id)
                table.insert(self.chooseEquips, equip)
                newCount = newCount + 1
                if newCount >= EQUIPMENT_MAX_SCRAP_COUNT then
                    break
                end
            end
        end
    end
    self:RefreshChooseInfo()
    self.scroll:RefreshData(self.equipShowList)
end

function this:OnConfirm()
    if table.count(self.chooseIds) == 0 then
        UIUtil.ToolTipFourth(LangUtil.GetSysLang(1305)) -- 没有选择装备
        return
    end
    ---@type ToolTipGetItemData
    local uiData = {}
    uiData.itemText = LangUtil.GetSysLang(252) -- 分解可获得
    uiData.items = {}
    for id, count in pairs(self.itemsCount) do
        table.insert(uiData.items,{
            id = id,
            count = count,
        })
    end
    
    uiData.callBack = function()
        PublicRequest.SendRequest(
            PROTOCOL.EquipmentPackScrapReq,
            {eids = self.chooseIds},
            function(response, errorCode)
                self:ClearChoose()
                UIPublic.OpenRewardUIByRewardDateils(response.reward_details)
            end
        )
    end

    local bottomText = {}
    local hasLock = table.first(self.chooseEquips, function(v) return v.Lock end)
    local hasIsEquip = table.first(self.chooseEquips, function(v) return v.characterId ~= 0 end)
    local hasLevelUp = table.first(self.chooseEquips, function(v) return v.Level > 1 end)
    if hasLock then
        table.insert(bottomText, LangUtil.GetSysLang(1303)) -- 选中已锁定的装备
    end
    if hasIsEquip then
        table.insert(bottomText, LangUtil.GetSysLang(1302)) -- 选中已装备的装备
    end
    if hasLevelUp then
        table.insert(bottomText, LangUtil.GetSysLang(1304)) -- 选中已强化的装备
    end
    if table.count(bottomText) > 0 then
        uiData.topText = LangUtil.GetSysLang(788) -- 确定要进行装备分解吗？
        uiData.bottomText = bottomText
    else
        uiData.bottomText = LangUtil.GetSysLang(788) -- 确定要进行装备分解吗？
    end

    UIManager:GetInstance():OpenWindow(UIWindowNames.ToolTipGetItem, uiData)
end

function this:OnLangCreate()
    -- LangUtil.BindText(self.langRc:GetObject("Text"))
    self.item1Text = LangUtil.BindText(self.item1.transform:Find("Text"), FontType.All_Number)
    self.item2Text = LangUtil.BindText(self.item2.transform:Find("Text"), FontType.All_Number)
    LangUtil.BindText(self.getItem).text = LangUtil.GetSysLang(269) -- 可获得
    LangUtil.BindText(self.holdNumber.transform:Find("Text")).text = LangUtil.GetSysLang(2060) -- 已选择
    self.holdNumberValue = LangUtil.BindText(self.holdNumber.transform:Find("Value"), FontType.All_Number)
    self.sortButtonText = LangUtil.BindText(self.sortButton.transform:Find("Text"))
end

function this:OnCreate()
    base.OnCreate(self)

    self.chooseEquips = {}
    self.chooseIds = {}

    self.getItem = self.rc:GetObject("GetItem")
    self.item1 = self.getItem.transform:Find("Item1"):GetComponent("Image")
    self.item2 = self.getItem.transform:Find("Item2"):GetComponent("Image")
    self.holdNumber = self.rc:GetObject("HoldNum")

    UIPublic.SetHelpButton(self.rc:GetObject("HelpButton"), UIWindowNames.UIEquipScrap)

    self.sortButton = self.rc:GetObject("SortButton")
    UIUtil.AddBtnEvent(self.sortButton, function()
        self:OnSortButton()
    end)

    self.screenButton = self.rc:GetObject("ScreenButton")
    UIUtil.AddBtnEvent(self.screenButton, function()
        self:OnScreenButton()
    end)
    self.returnButton = self.rc:GetObject("ReturnButton")
    UIPublic.SetBackButton(
        self.returnButton,
        UIWindowNames.UIEquipScrap,
        nil
    )
    self.cancelButton = self.rc:GetObject("CancelButton")
    UIUtil.AddBtnEvent(self.cancelButton, function()
        self.ctrl:CloseSelf()
    end)

    self.confirmButton = self.rc:GetObject("ConfirmButton")
    UIUtil.AddBtnEvent(self.confirmButton, function()
        self:OnConfirm()
    end)

    self.quickSelectButton = self.rc:GetObject("QuickSelectButton")
    self.quickChoosePanel = self.rc:GetObject("QuickChoosePanel")
    self.starButtons = self.rc:GetObject("StarButtons").transform
    UIUtil.AddBtnEvent(self.quickSelectButton, function()
        UIUtil.ToolTipFourth(LangUtil.GetSysLang(1378))
        self.quickChoosePanel:SetActive(true)
    end)
    UIUtil.AddBtnEvent(self.quickChoosePanel, function()
        self.quickChoosePanel:SetActive(false)
    end)
    for i = 0, self.starButtons.childCount - 1 do
        local count = i + 1
        local starButton = self.starButtons:GetChild(i)
        for j = 0, starButton.transform.childCount - 1 do
            local star = starButton.transform:GetChild(j)
            star.gameObject:SetActive(j < count)
        end

        UIUtil.AddBtnEvent(starButton, function()
            self.quickChoosePanel:SetActive(false)
            self:OnQuickSelect(count)
        end)
    end

    self.equipShowList = {}
    ---@type VerticalScroll
    self.scroll = VerticalScroll.New()
    self.scroll:SetUpdateCount(15)
    self.scrollView = self.rc:GetObject("Scroll View"):GetComponent("ScrollRect")
    self.scroll:Clear()
    self.scroll:ScrollInit(self.equipShowList, self.scrollView, PrefabName, function (arg)
        local gameObject = arg.go
        ---@type Equip
        local equip = arg.data
        local select = gameObject.transform:Find("Bg/SelectImage/Image").gameObject -- 对号
        local selectImage = gameObject.transform:Find("Bg/SelectImage").gameObject
        local mask = gameObject.transform:Find("Bg/Mask").gameObject
        local lock = gameObject.transform:Find("Bg/Lock").gameObject
        UIPublic.InitEquipItemNew(gameObject.transform, equip)
        local canSelect = equip.characterId == 0 and not equip.Lock
        lock:SetActive(not canSelect)
        mask:SetActive(not canSelect)
        UIUtil.AddBtnEventNoBug(gameObject, function()
            if not canSelect then
                return
            end
            if table.contains(self.chooseIds, equip.Id) then
                table.remove(self.chooseIds, table.indexof(self.chooseIds, equip.Id))
                table.remove(self.chooseEquips, table.indexof(self.chooseEquips, equip))
            else
                table.insert(self.chooseIds, equip.Id)
                table.insert(self.chooseEquips, equip)
            end
            local isSelect = table.first(self.chooseIds,function(v) return v == equip.Id  end)
            selectImage:SetActive(canSelect)
            select:SetActive(isSelect)
            self:RefreshChooseInfo()
        end)
        -- LongPress.New(gameObject, function()
        --     Logger.LogError("长按" .. equip.config.Name)
        -- end)
        local isSelect = table.first(self.chooseIds,function(v) return v == equip.Id  end)
        selectImage:SetActive(canSelect)
        select:SetActive(isSelect)
    end)
end

function this:OnEnable()
    base.OnEnable(self)
     recordOrder = { order = 1, kind = 1 }  --是否正序  顺序类型
     screenTypes = { star = 0, Part = 0, exclusive = 0, isEquip = 0 }
    self:ClearChoose()
    self.quickChoosePanel:SetActive(false)
    self:OnRefresh()
end

function this:OnRefresh()
    self:InitSortButton()
    self:InitEquipListData()
end

local function ON_EQUIP_UPDATE(self)
    self.model.equipList = Game.Scene.Player:GetComponent("EquipComponent"):GetEquipList()
    self:OnRefresh()
end

function this:OnAddListener()
    base.OnAddListener(self)
    self:AddUIListener(UIMessageNames.ON_EQUIP_UPDATE, ON_EQUIP_UPDATE)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    self:RemoveUIListener(UIMessageNames.ON_EQUIP_UPDATE)
end

function this.OnViewTop(self)
    base.OnViewTop(self)
    UIManager:GetInstance():OpenWindow(UIWindowNames.UIComTop)
    self.comTopView = UIManager:GetInstance():GetWindow(UIWindowNames.UIComTop).View
    self.comTopView:InitComTop(self, self:GetName())
end

function this.OnDisViewTop(self)
    base.OnDisViewTop(self)
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIComTop)
end

function this:OnDisable()
    base.OnDisable(self)
end

function this:OnDestroy()
    base.OnDestroy(self)
end

return this
