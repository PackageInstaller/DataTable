---@class WarePanel : WarePanel_Generate
---##################### 【WarePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【WarePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local WarePanel = require "WarePanel_Generate"
local CustomTips = require("CustomTips")

function WarePanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.RefreshWarehousePanel, function()
            self:ViewDataInfo()
            self:forceRefresh()
        end},
        {GameMsgType.RefreshTopResource, function()
            self.customBackPanel.customBackPanel:RefreshTopResource()
        end},
        {GameMsgType.ItemMapNtf, function()
            self:SetMsgView()
        end},
    }
    --页签枚举 GE.ItemTypeIndex
    self.nowMode = 0
    self.toggleList = {}
    self.toggleTable = {}
    --self.nowSelect
    self.selectList = {}
    self.dataList = {
        weapon = {}, equip = {}, debris = {}, materials = {}, item = {},
    }
    self.nowSelectEquip = nil
    self.nowSelectWeaponId = nil
    self.nowSelectItemId = nil
    self.nowWeaponLvMax = false
    self.canGoFuse = false

    self.nowEquipSortIndex = 1      --当前装备排序
    self.equipSortBtnlist = {}
    self.nowEquipSortFace = 1

    self.nowWeaponSortIndex = 1      --当前武器排序
    self.weaponSortBtnlist = {}
    self.nowWeaponSortFace = 1

    self.curDataList = {}
    self.curToggleType = nil
    self.btnSoundPath = string.format(Config.AudioPath.SE, "click")

    ---@type CustomTips
    local lua_customTips = CustomTips:new(self.customTips.gameObject)
    lua_customTips:InitGenerate()
    lua_customTips:setMono(self)
    lua_customTips:SetData(data)
    self.lua_customTips = lua_customTips

    self.autoRoot.autoAdjustCanvasRoot:ResetPadding()

    self.wareList.loopGridView:InitGridView(0, BindCallback_NoParams(self, self.OnContentValueChange))
    UICommonUtils.CalculateColumnCount(self.wareList.loopGridView)
end

--function WarePanel:StartCreating(time)
--
--end

--function WarePanel:StartEnter(time)
--
--end

--function WarePanel:StartRemoving(time)
--
--end

--function WarePanel:StartExit(time)
--
--end

--- func desc
---@class data
---@field pageIndex GE.ItemTypeIndex    --初始显示页签 默认显示第一个页签
---@param initiative boolean
function WarePanel:OnOpen(data, initiative)
    self:doOpenAni()
    -- 重置选择状态，不保留上次的选择
    local pageIndex = data and data.pageIndex or nil
    -- 没有指定页签时，优先使用上次的页签；首次打开（nowMode==0）则默认 item
    local defaultMode = (self.nowMode ~= 0) and self.nowMode or GE.ItemTypeIndex.item
    self.selectList = {}
    if initiative then
        --导航栏
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.WarePanel, self)
        local toggleList = Config.GetConfigInfo("warehouseTab")
        -- FillTemplateContent 可能异步（对象池不足时），需用计数器确保全部创建完毕后再执行后续逻辑
        local totalToggleCount = tablex.size(toggleList)
        local createdToggleCount = 0
        self:FillTemplateContent(self.typeBtn, self.togglePanel, totalToggleCount, function(index, typeBtn)
            typeBtn:SetActive(true)
            self.toggleList[toggleList[index][2]] = typeBtn
            typeBtn.typeTxt.text.text = LocalStrEnum[toggleList[index][1].."Tab"]
            typeBtn.isSelect.typeTxt.text.text = LocalStrEnum[toggleList[index][1].."Tab"]

            typeBtn.typeIcon:SetActive(true)
            self:LoadSpriteAsync(string.format(Config.SpritePath.TypeBtnIconOff, toggleList[index][2]), typeBtn.typeIcon.image)
            
            typeBtn.typeIconOn:SetActive(true)
            self:LoadSpriteAsync(string.format(Config.SpritePath.TypeBtnIconOn, toggleList[index][2]), typeBtn.typeIconOn.image)
            
            typeBtn.scaleButton.onClick:RemoveAllListeners()
            typeBtn.scaleButton.onClick:AddListener(function()
                self:play2DSound(self.btnSoundPath)
                self:SetViewByMode(toggleList[index][2], false, true)
            end)
            -- 所有页签创建完毕后，再初始化数据和默认选中页签
            createdToggleCount = createdToggleCount + 1
            if createdToggleCount == totalToggleCount then
                self:ViewDataInfo()
                --self:bindWareList()
                --默认显示第一个页签（此时 toggleList 已全部填充，isSelect 可正常生效）
                self:SetViewByMode(pageIndex or defaultMode, true)
            end
        end)
    else
        self:ViewDataInfo()
        self:SetViewByMode(pageIndex or defaultMode, true)
    end
end

function WarePanel:doOpenAni()
    self.togglePanel.rectTransform.anchoredPosition = Vector2.New(-400, -111)
    self.togglePanel.rectTransform:DOAnchorPosX(140, 0.4):SetEase(DG.Tweening.Ease.OutQuart)
    self.togglePanel.canvasGroup.alpha = 0
    self.togglePanel.canvasGroup:DOFade(1, 0.5):SetEase(DG.Tweening.Ease.OutQuart)

    self.customTips.rectTransform.anchoredPosition = Vector2.New(600, -8)
    self.customTips.rectTransform:DOAnchorPosX(-257, 0.4):SetEase(DG.Tweening.Ease.OutQuart)
    self.customTips.canvasGroup.alpha = 0
    self.customTips.canvasGroup:DOFade(1, 0.5):SetEase(DG.Tweening.Ease.OutQuart)
end

--仓库信息初始化
function WarePanel:ViewDataInfo()
    self:EquipDataInfo()
    self:WeaponDataInfo()
    self:ItemDataInfo()
    self:DebrisDataInfo()
    self:MaterialsDataInfo()
end

--道具信息初始化
function WarePanel:ItemDataInfo()
    self.dataList.item = {}
    for key, value in pairs(ClientData:getItemMap()) do
        local itemConfig = Config.GetItemInfo(value.id)
        if itemConfig and value.num > 0 and itemConfig.type == GE.ItemTypeIndex.item and itemConfig.isShow == 1 then
            table.insert(self.dataList.item, value)
        end
    end
    table.sort(self.dataList.item, function(a, b)
        local a_config = Config.GetItemInfo(a.id)
        local b_config = Config.GetItemInfo(b.id)
        if a_config.quality == b_config.quality then
            return a_config.id < b_config.id
        end
        return a_config.quality > b_config.quality
    end)
    if self.dataList.item[1] ~= nil and self.selectList[GE.ItemTypeIndex.item] == nil then
        self:SetNowSelectID(GE.ItemTypeIndex.item, self.dataList.item[1].id)
    end
end

--碎片信息初始化
function WarePanel:DebrisDataInfo()
    self.dataList.debris = {}
    for key, value in pairs(ClientData:getItemMap()) do
        local itemConfig = Config.GetItemInfo(value.id)
        if itemConfig and value.num > 0 and itemConfig.type == GE.ItemTypeIndex.debris and itemConfig.isShow == 1 then
            table.insert(self.dataList.debris, value)
        end
    end
    table.sort(self.dataList.debris, function(a, b)
        local a_config = Config.GetItemInfo(a.id)
        local b_config = Config.GetItemInfo(b.id)
        if a_config.quality == b_config.quality then
            return a_config.id < b_config.id
        end
        return a_config.quality > b_config.quality
    end)
    if self.dataList.debris[1] ~= nil and self.selectList[GE.ItemTypeIndex.debris] == nil then
        self:SetNowSelectID(GE.ItemTypeIndex.debris, self.dataList.debris[1].id)
    end
end

--材料信息初始化
function WarePanel:MaterialsDataInfo()
    self.dataList.materials = {}
    for key, value in pairs(ClientData:getItemMap()) do
        local itemConfig = Config.GetItemInfo(value.id)
        if itemConfig and value.num > 0 and itemConfig.type == GE.ItemTypeIndex.materials and itemConfig.isShow == 1 then
            table.insert(self.dataList.materials, value)
        end
    end
    table.sort(self.dataList.materials, function(a, b)
        local a_config = Config.GetItemInfo(a.id)
        local b_config = Config.GetItemInfo(b.id)
        if a_config.quality == b_config.quality then
            return a_config.id < b_config.id
        end
        return a_config.quality > b_config.quality
    end)
    if self.dataList.materials[1] ~= nil and self.selectList[GE.ItemTypeIndex.materials] == nil then
        self:SetNowSelectID(GE.ItemTypeIndex.materials, self.dataList.materials[1].id)
    end
end

--武器信息初始化
function WarePanel:WeaponDataInfo()
    self.dataList.weapon = {}
    for key, value in pairs(Me:getAllWeaponData()) do
        table.insert(self.dataList.weapon, value)
    end
    self:WeaponSortInfo()
    self:setWeaponSortView()
    if self.dataList.weapon[1] ~= nil and self.selectList[GE.ItemTypeIndex.weapon] == nil then
        self:SetNowSelectID(GE.ItemTypeIndex.weapon, self.dataList.weapon[1].id)
    end
end

--装备信息初始化
function WarePanel:EquipDataInfo()
    self.dataList.equip = {}
    for key, value in pairs(Me:getAllEquipData()) do
        table.insert(self.dataList.equip, value)
    end
    self:EquipSortInfo()
    self:setEquipSortView()
    if self.dataList.equip[1] ~= nil and self.selectList[GE.ItemTypeIndex.equip] == nil then
        self:SetNowSelectID(GE.ItemTypeIndex.equip, self.dataList.equip[1].id)
    end
end

-------------------------------------------------------------------------------------------

--武器排序初始化
function WarePanel:WeaponSortInfo()
    self.sortTxt.text.text = LocalStrEnum["weaponFilterType"..GE.WeaponSortType[GE.WeaponSortTypeName[self.nowWeaponSortIndex]]]
    self.weaponSortBtnlist = {}
    self:FillTemplateContent(self.sortTypeBtn, self.sortSelectList, tablex.size(GE.WeaponSortTypeName), function(index, sortTypeBtn)
        local temp = {
            obj = sortTypeBtn,
            key = index,
        }
        table.insert(self.weaponSortBtnlist, temp)
        sortTypeBtn.sortTypeTxtOff.text.text =  LocalStrEnum["weaponFilterType"..GE.WeaponSortType[GE.WeaponSortTypeName[index]]]
        sortTypeBtn.sortTypeTxt.text.text =  LocalStrEnum["weaponFilterType"..GE.WeaponSortType[GE.WeaponSortTypeName[index]]]
        sortTypeBtn.isEx:SetActive(GE.WeaponSortType[GE.WeaponSortTypeName[index]] == GE.WeaponSortType.nature)
        sortTypeBtn.scaleButton.onClick:RemoveAllListeners()
        sortTypeBtn.scaleButton.onClick:AddListener(function()
            self:play2DSound(self.btnSoundPath)
            self.nowWeaponSortIndex = index
            self.sortTxt.text.text = LocalStrEnum["weaponFilterType"..GE.WeaponSortType[GE.WeaponSortTypeName[self.nowWeaponSortIndex]]]
            self.sortSelectList:SetActive(false)
            self.sortMask:SetActive(false)
            self:WeaponDataInfo()
            self:forceRefresh()
            self:refreshSortView()
        end)
    end)
end

--装备排序初始化
function WarePanel:EquipSortInfo()
    self.sortTxt.text.text = LocalStrEnum["equipFilterType"..GE.EquipSortType[GE.EquipSortTypeName[self.nowEquipSortIndex]]]
    self.equipSortBtnlist = {}
    self:FillTemplateContent(self.sortTypeBtn, self.sortSelectList, tablex.size(GE.EquipSortTypeName), function(index, sortTypeBtn)
        local temp = {
            obj = sortTypeBtn,
            key = index,
        }
        table.insert(self.equipSortBtnlist, temp)
        sortTypeBtn.sortTypeTxtOff.text.text =  LocalStrEnum["equipFilterType"..GE.EquipSortType[GE.EquipSortTypeName[index]]]
        sortTypeBtn.sortTypeTxt.text.text =  LocalStrEnum["equipFilterType"..GE.EquipSortType[GE.EquipSortTypeName[index]]]
        sortTypeBtn.isEx:SetActive(GE.EquipSortType[GE.EquipSortTypeName[index]] == GE.EquipSortType.nature)
        sortTypeBtn.scaleButton.onClick:RemoveAllListeners()
        sortTypeBtn.scaleButton.onClick:AddListener(function()
            self:play2DSound(self.btnSoundPath)
            self.nowEquipSortIndex = index
            self.sortTxt.text.text = LocalStrEnum["equipFilterType"..GE.EquipSortType[GE.EquipSortTypeName[self.nowEquipSortIndex]]]
            self.sortSelectList:SetActive(false)
            self.sortMask:SetActive(false)
            self:EquipDataInfo()
            self:forceRefresh()
            self:refreshSortView()
        end)
    end)
end

--设置装备排序详情
function WarePanel:setEquipSortView()
    local function compare(a, b, primary, secondary, ascending)
        if primary(a, b) then
            return ascending
        elseif primary(b, a) then
            return not ascending
        else
            if secondary(a, b) then
                return ascending
            elseif secondary(b, a) then
                return not ascending
            else
                local a_config = Config.GetEquipmentInfo(a.cid)
                local b_config = Config.GetEquipmentInfo(b.cid)
                if a_config ~= nil and b_config ~= nil then
                    return a_config.id < b_config.id
                end
            end
        end
    end

    local function getPrimarySecondary()
        if self.nowEquipSortIndex == GE.EquipSortType.default or self.nowEquipSortIndex == GE.EquipSortType.level then
            return function(a, b) return a.level > b.level end,
                   function(a, b) return Config.GetEquipmentInfo(a.cid).quality > Config.GetEquipmentInfo(b.cid).quality end
        elseif self.nowEquipSortIndex == GE.EquipSortType.quality then
            return function(a, b) return Config.GetEquipmentInfo(a.cid).quality > Config.GetEquipmentInfo(b.cid).quality end,
                   function(a, b) return a.level > b.level end
        end
    end

    local primary, secondary = getPrimarySecondary()
    local ascending = self.nowEquipSortFace == 1

    table.sort(self.dataList.equip, function(a, b)
        return compare(a, b, primary, secondary, ascending)
    end)
end

--设置武器排序详情
function WarePanel:setWeaponSortView()
    local function compare(a, b, primary, secondary, ascending)
        if primary(a, b) then
            return ascending
        elseif primary(b, a) then
            return not ascending
        else
            if secondary(a, b) then
                return ascending
            elseif secondary(b, a) then
                return not ascending
            else
                local a_config = Config.GetWeaponInfo(a.cid)
                local b_config = Config.GetWeaponInfo(b.cid)
                if a_config ~= nil and b_config ~= nil then
                    return a_config.id < b_config.id
                end
            end
        end
    end

    local function getPrimarySecondary()
        if self.nowWeaponSortIndex == GE.WeaponSortType.default or self.nowWeaponSortIndex == GE.WeaponSortType.level then
            return function(a, b) return a.level > b.level end,
                   function(a, b) return a.rare > b.rare end
        elseif self.nowWeaponSortIndex == GE.WeaponSortType.quality then
            return function(a, b) return a.rare > b.rare end,
                    function(a, b) return a.level > b.level end
        elseif self.nowWeaponSortIndex == GE.WeaponSortType.loadValue then
            return function(a, b) return a.load > b.load end,
                    function(a, b) return a.level > b.level end
        elseif self.nowWeaponSortIndex == GE.WeaponSortType.point then
            return function(a, b) return a.point > b.point end,
                    function(a, b) return a.level > b.level end
        end
    end

    local primary, secondary = getPrimarySecondary()
    local ascending = self.nowWeaponSortFace == 1

    table.sort(self.dataList.weapon, function(a, b)
        return compare(a, b, primary, secondary, ascending)
    end)
end

--刷新排序显示
function WarePanel:refreshSortView()
    if self.nowMode == GE.ItemTypeIndex.equip then
        for k,v in pairs(self.equipSortBtnlist) do
            v.obj.isOpen:SetActive(self.nowEquipSortIndex == v.key)
        end
    elseif self.nowMode == GE.ItemTypeIndex.weapon then
        for k,v in pairs(self.weaponSortBtnlist) do
            v.obj.isOpen:SetActive(self.nowWeaponSortIndex == v.key)
        end
    end
end

--------------------------------------------------------------------------------------------

--设置当前选中id
function WarePanel:SetNowSelectID(typeIndex, id)
    if self.selectList[typeIndex] == nil then
        self.selectList[typeIndex] = 0
    end
    self.selectList[typeIndex] = id
    self.wareList.loopGridView:RefreshAllShownItem2()
end

--设置当前详情显示
function WarePanel:SetMsgView()
    self.nowSelectEquip = nil
    self.nowSelectWeaponId = nil
    self.nowSelectItemId = nil
    self.nowSelectMaterialsId = nil
    self.nowSelectDebrisId = nil
    self.nowWeaponLvMax = false
    self.canGoFuse = false
    self.fuseLocked = false

    self.customTips:SetActive(self.selectList[self.nowMode] ~= nil)
    self.isNull:SetActive(self.selectList[self.nowMode] == nil)
    -- self.lockBtn:SetActive(self.nowMode == GE.ItemTypeIndex.weapon or self.nowMode == GE.ItemTypeIndex.equip)
    --self.spBtn:SetActive(false)

   -- self.itemMode:SetActive(self.nowMode == GE.ItemTypeIndex.item or self.nowMode == GE.ItemTypeIndex.debris or self.nowMode == GE.ItemTypeIndex.materials)
    --self.weaponMode:SetActive(self.nowMode == GE.ItemTypeIndex.weapon)
    --self.weaponTypeIcon:SetActive(self.nowMode == GE.ItemTypeIndex.weapon)
   -- self.space:SetActive(self.nowMode ~= GE.ItemTypeIndex.weapon)
    -- local middlelineShow = {
    --     GE.ItemTypeIndex.weapon,
    --     GE.ItemTypeIndex.equip,
    -- }
    -- self.middleline:SetActive(tablex.contains(middlelineShow, self.nowMode))
    -- self.equipMode:SetActive(self.nowMode == GE.ItemTypeIndex.equip)
    -- self.lockBtn.scaleButton.onClick:RemoveAllListeners()

    self.btnList:SetActive(self.selectList[self.nowMode] ~= nil)
    self.delBtn:SetActive(self.nowMode == GE.ItemTypeIndex.equip)
    self.levelUpBtn:SetActive(self.nowMode == GE.ItemTypeIndex.weapon or self.nowMode == GE.ItemTypeIndex.equip)
    self.useBtn:SetActive(self.nowMode == GE.ItemTypeIndex.item)
    self.notFuse:SetActive(false)
    --编辑器下跳转测试入口
    self.jumpBtn:SetActive(self.nowMode == GE.ItemTypeIndex.item and GV.IsEditor)
    self.fuseLocked = Me:getFunctionOpenStateById(GE.FunctionOpenModule.WeaponFuse) == GE.FunctionOpenState.Lock

    for index, data in pairs(self.curDataList) do
        if data.id == self.selectList[self.nowMode] then
            if self.nowMode == GE.ItemTypeIndex.weapon then
                self.nowSelectWeaponId = data.id
                local weaponConfig = Config.GetWeaponInfo(data.cid)
                if data.level == weaponConfig.levelMax then
                    self.nowWeaponLvMax = true
                    self.canGoFuse = (weaponConfig.rare >= 4) and not self.fuseLocked
                    self.notFuse:SetActive(not self.canGoFuse)
                    self.levelUpText.text.text = "熔 合"
                else
                    self.levelUpText.text.text = "提 升"
                end

                self.lua_customTips:SetUIData({
                    id = data.id,
                    type = GE.RewardType.Weapon,
                    navType = GE.NavigationType.WarePanel,
                })

                self.lua_customTips.lockCallBack = function()
                    self:WeaponDataInfo()
                    self:Refresh()
                    self:RefreshItem(data.id)
                    self:SetMsgView()
                end
            elseif self.nowMode == GE.ItemTypeIndex.equip then
                local equipData = Me:getEquipDataByid(data.id) or data
                local equipConfig = Config.GetEquipmentInfo(equipData.cid)
                self.nowSelectEquip = data.id
                self.levelUpText.text.text = "提 升"
                self.levelUpBtn:SetActive(equipConfig.equipType ~= GE.EquipType.rankUp)
                self.delBtn:SetActive(equipConfig.equipType ~= GE.EquipType.rankUp and equipConfig.equipType ~= GE.EquipType.sp)
                self.lua_customTips:SetUIData({
                    id = data.id,
                    type = GE.RewardType.Equipment,
                    navType = GE.NavigationType.WarePanel,
                })

                self.lua_customTips.lockCallBack = function()
                    self:EquipDataInfo()
                    local equipData = Me:getEquipDataByid(data.id) or data
                    self:RefreshItem(equipData.id)
                    self:SetMsgView()
                end
            elseif self.nowMode == GE.ItemTypeIndex.item then
                self.nowSelectItemId = data.id
                local itemConfig = Config.GetItemInfo(data.id)
                --判断是否打开使用按钮
                local openUseBtn = false
                if itemConfig.useType == GE.ItemUseType.multiple or itemConfig.useType == GE.ItemUseType.randomGift then
                    openUseBtn = true
                end
                self.useBtn:SetActive(openUseBtn)
                self.lua_customTips:SetUIData({
                    id = data.id,
                    type = GE.RewardType.ItemProp,
                    navType = GE.NavigationType.WarePanel,
                })
            elseif self.nowMode == GE.ItemTypeIndex.debris then
                self.nowSelectDebrisId = data.id
                self.lua_customTips:SetUIData({
                    id = data.id,
                    type = GE.RewardType.ItemProp,
                    navType = GE.NavigationType.WarePanel,
                })
            elseif self.nowMode == GE.ItemTypeIndex.materials then
                self.nowSelectMaterialsId = data.id
                self.lua_customTips:SetUIData({
                    id = data.id,
                    type = GE.RewardType.ItemProp,
                    navType = GE.NavigationType.WarePanel,
                })
            end
        end
    end
    for k,v in pairs(self.toggleList) do
        v.red:SetActive(RedPointMgr:WarePanelTypeBtnRedJudge(k))
    end
end

--根据模式设置右侧详情页
function WarePanel:SetMsgViewByMode(data, mode)
    local itemConfig = Config.GetItemInfo(data.id)
    if not itemConfig then
        LuaLogger.e("WarePanel:SetMsgViewByMode itemConfig is nil, id: " .. tostring(data.id))
        return
    end
    self.nowSelectItemId = data.id
    local itemCount = data.num
    if itemConfig.numShowType == GE.ItemNumShowType.OverflowWithK then
        if itemCount >= 100000 then
            local kCount = math.floor(itemCount / 1000)
            local hCount = math.floor((itemCount % 1000) / 100)
            itemCount = string.format("%dk", kCount)
            if hCount > 0 then
                itemCount = string.format("%s.%d k", itemCount, hCount)
            end
        end
    end
    self.countTxt.text.text = itemCount
    self.nameTxt.text.text = itemConfig.itemName
    self.itemMsgTxt.text.text = itemConfig.describe
    self:LoadSpriteAsync(string.format(Config.SpritePath.itemRankLine, itemConfig.quality), self.rankImgBg.image)
    self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, itemConfig.icon), self.itemIcon.image)
    self:FillTemplateContent(self.getActiveBox, self.channeList, tablex.size(itemConfig.turnTo), function (index, itemObj)
        local skipInfo = Config.SkipFuncInfo(itemConfig.turnTo[index])
        if skipInfo then
            itemObj.channelTxt.text.text = skipInfo.desc
            local canUseSkip, showBtn = UICommonUtils.CanUseSkipJudge(skipInfo.id, false)
            itemObj.scaleButton.onClick:RemoveAllListeners()
            itemObj.goBtn:SetActive(showBtn)
            if canUseSkip == false then
                itemObj.channelboxBg:SetActive(false)
                itemObj.isLock:SetActive(true)
            else
                itemObj.channelboxBg:SetActive(true)
                itemObj.isLock:SetActive(false)
            end
            itemObj.scaleButton.onClick:AddListener(function()
                if canUseSkip == false then
                    UICommonUtils.CanUseSkipJudge(skipInfo.id, true)
                    return
                end
                if showBtn == false then
                    return
                end
                local curWnd = nil
                if skipInfo.isClose == 1 then
                    curWnd = UIMgr:getCurWndName()
                end
                UICommonUtils.CommonTurnTo(skipInfo.id, curWnd)
            end)
        else
            itemObj.gameObject:SetActive(false)
        end
    end)

    Me:ShowItemTips({
        id = data.id,
        type = Me:ItemTypeToReward(mode) ,
        navType = GE.NavigationType.WarePanel,
    })
end

--根据模式显示对应列表
function WarePanel:SetViewByMode(mode, isRefresh, isClick)
    if isClick and self.nowMode and mode ~= self.nowMode then
        self:markViewRed(self.nowMode)
    end
    for k,v in pairs(self.toggleList) do
        v.red:SetActive(RedPointMgr:WarePanelTypeBtnRedJudge(k))
    end
    if not isRefresh then
        if mode == self.nowMode then
            return
        end
    end

    self.nowMode = mode
    local toggleList = Config.GetConfigInfo("warehouseTab")
    for k,v in pairs(self.toggleList) do
        v.isSelect:SetActive(k == self.nowMode)
        v.typeOff:SetActive(k ~= self.nowMode)
    end

    self.customSortBox:SetActive((self.nowMode == GE.ItemTypeIndex.weapon or self.nowMode == GE.ItemTypeIndex.equip) and self.selectList[self.nowMode] ~= nil)
    for k, toggle in pairs(toggleList) do
        if toggle[2] == self.nowMode then
            if toggle[1] == "equip" then
                self.curDataList = self.dataList.equip
                self.curToggleType = "equip"
            elseif toggle[1] == "weapon" then
                self.curDataList = self.dataList.weapon
                self.curToggleType = "weapon"
            elseif toggle[1] == "item" then
                self.curDataList = self.dataList.item
                self.curToggleType = "item"
            elseif toggle[1] == "debris" then
                self.curDataList = self.dataList.debris
                self.curToggleType = "debris"
            elseif toggle[1] == "materials" then
                self.curDataList = self.dataList.materials
                self.curToggleType = "materials"
            end

            local size = tablex.size(self.curDataList)
            self.waitPlayEffect = true

            local trs = self.wareList.loopGridView.ScrollRect.content
            for i = 0, trs.childCount - 1 do
                local child = trs:GetChild(i)
                ---@type UnityEngine.CanvasGroup
                local canvasGroup = child:GetComponent(TypeInfo.CanvasGroup)
                child:DOKill()
                canvasGroup:DOKill()
            end

            self.wareList.loopGridView:SetListItemCount(0)
            self.wareList.loopGridView:SetListItemCount(size, true)

           
            TimeMgr:AddWaitTimeExecute(2, function()
                self.waitPlayEffect = false
                local loopGridView = self.wareList.loopGridView
                for i = 0, size -1 do
                    local item = loopGridView:GetShownItemByItemIndex(i)

                    if item ~= nil then
                        ---@type UnityEngine.RectTransform
                        local trs = item.transform
                        ---@type UnityEngine.CanvasGroup
                        local canvasGroup = trs:GetComponent(TypeInfo.CanvasGroup)

                        ---@type UnityEngine.RectTransform
                        local rTrs = trs:Find("EquipBtn")
                        rTrs.anchoredPosition = Vector2.New(0, -20)
                        canvasGroup.alpha = 0
                        rTrs:DOKill()
                        canvasGroup:DOKill()
                        rTrs:DOAnchorPosY(0, 0.2):SetDelay((i)*0.02)
                        canvasGroup:DOFade(1, 0.2):SetDelay((i)*0.02)
                    end
                end
            end, self, true)
        end
    end
    if self.nowMode == GE.ItemTypeIndex.equip then
        self.sortTxt.text.text = LocalStrEnum["equipFilterType"..GE.EquipSortType[GE.EquipSortTypeName[self.nowEquipSortIndex]]]
        self:EquipSortInfo()
        self.sortStateBtn.upImg:SetActive(self.nowEquipSortFace == 2)
        self.sortStateBtn.downImg:SetActive(self.nowEquipSortFace == 1)
    elseif self.nowMode == GE.ItemTypeIndex.weapon then
        self.sortTxt.text.text = LocalStrEnum["weaponFilterType"..GE.WeaponSortType[GE.WeaponSortTypeName[self.nowWeaponSortIndex]]]
        self:WeaponSortInfo()
        self.sortStateBtn.upImg:SetActive(self.nowWeaponSortFace == 2)
        self.sortStateBtn.downImg:SetActive(self.nowWeaponSortFace == 1)
    end
    self.sortSelectList:SetActive(false)
    self.sortMask:SetActive(false)
    self:SetMsgView()
end

function WarePanel:markViewRed(mode)
    local redDotKey = "NewItem"
    local dataList = {}
     if mode == GE.ItemTypeIndex.equip then
        dataList = self.dataList.equip
        redDotKey = "NewEquip"
    elseif mode == GE.ItemTypeIndex.weapon then
        dataList = self.dataList.weapon
        redDotKey = "NewWeapon"
    elseif mode == GE.ItemTypeIndex.item then
        dataList = self.dataList.item
    elseif mode == GE.ItemTypeIndex.debris then
        dataList = self.dataList.debris
    elseif mode == GE.ItemTypeIndex.materials then
        dataList = self.dataList.materials
    end
    for _, v in pairs(dataList) do
        RedPointMgr:SetRedDotState(redDotKey.. v.id, true)
    end
    RedPointMgr:Refresh("WarehouseBtnRedJudge")
end

--[[
function WarePanel:bindWareList()
    --LuaLogger.ds("self.curDataList", tablex.dump(self.curDataList))
    self.wareList.loopGridView:InitGridView(tablex.size(self.curDataList), function(gridView, index, row, col)
        --LuaLogger.ds("index", index)
        local loopGridViewItem = gridView:GetShownItemByItemIndex(index)
        if loopGridViewItem == nil then
            loopGridViewItem = gridView:NewListViewItem("CustomBox")
        end
        index = index + 1
        local itemObj = loopGridViewItem.gameObject
        EngineUtil.FillPeer(self.customBox, itemObj)
        local customBox = itemObj.customBox
        customBox.transform.localScale = Vector3.New(0.95, 0.95, 1)
        local isSelect = self.curDataList[index].id == self.selectList[self.nowMode]
        if self.curToggleType == "equip" then
            local EquipData = self.curDataList[index]
            ---@type RewardInfo
            local rData = {
                id = self.curDataList[index].id,
                type = GE.RewardType.Equipment,
                num = 1
            }
            local data = {
                showNew = true,
                listener = function()
                    self:SetNowSelectID(GE.ItemTypeIndex.equip, self.curDataList[index].id)
                    self:SetMsgView()
                end,
                ownerId = EquipData.ownerId
            }
            customBox:setMono(self)
            customBox:SetUIData(rData, data)
        elseif self.curToggleType == "weapon" then
            local weaponData = self.curDataList[index]
            ---@type RewardInfo
            local rData = {
                id = self.curDataList[index].id,
                type = GE.RewardType.Weapon,
                num = 1, 
            }
            local data = {
                showNew = true,
                listener = function()
                    self:SetNowSelectID(GE.ItemTypeIndex.weapon, self.curDataList[index].id)
                    self:SetMsgView()
                end,
                ownerId = weaponData.ownerId
            }
            customBox:setMono(self)
            customBox:SetUIData(rData, data)
        elseif self.curToggleType == "item" then
            self:SetBoxView(customBox, index, self.curDataList, GE.ItemTypeIndex.item)
        elseif self.curToggleType == "debris" then
            self:SetBoxView(customBox, index, self.curDataList, GE.ItemTypeIndex.debris)
        elseif self.curToggleType == "materials" then
            self:SetBoxView(customBox, index, self.curDataList, GE.ItemTypeIndex.materials)
        end

        customBox:setSelect(isSelect)
        return loopGridViewItem
    end)
end]]

---更新滑动列表
---@param index integer 数据索引
---@param gridView SuperScrollView.LoopGridView
---@param index integer
---@param row integer
---@param col integer
function WarePanel:OnContentValueChange(gridView, index, row, col)
    local loopItem = gridView:GetShownItemByItemIndex(index)
    if loopItem == nil then
        loopItem = gridView:NewListViewItem("CustomBox")
    end
    local obj = loopItem.gameObject
    obj.name = "index:" .. tostring(index)
    EngineUtil.FillPeer(self.customBox, obj)
    local data = self.curDataList[index+1]
    if data == nil then
        obj:SetActive(false)
        return 
    end
    obj:SetActive(true)

    ---@type UnityEngine.CanvasGroup
    local canvasGroup = obj:GetComponent(TypeInfo.CanvasGroup)
    if self.waitPlayEffect then
        canvasGroup.alpha = 0
    else
        canvasGroup.alpha = 1
    end

    ---@type CustomBox
    local customBox = obj.customBox
    customBox.transform.localScale = Vector3.New(0.95, 0.95, 1)
    local isSelect = data.id == self.selectList[self.nowMode]
    if self.curToggleType == "equip" then
        local EquipData = data
        ---@type RewardInfo
        local rData = {
            id = data.id,
            type = GE.RewardType.Equipment,
            num = 1
        }
        local data = {
            showNew = true,
            listener = function()
                self:SetNowSelectID(GE.ItemTypeIndex.equip, data.id)
                self:SetMsgView()
            end,
            ownerId = EquipData.ownerId
        }
        customBox:setMono(self)
        customBox:SetUIData(rData, data)
    elseif self.curToggleType == "weapon" then
        local weaponData = data
        ---@type RewardInfo
        local rData = {
            id = data.id,
            type = GE.RewardType.Weapon,
            num = 1, 
        }
        local data = {
            showNew = true,
            listener = function()
                self:SetNowSelectID(GE.ItemTypeIndex.weapon, data.id)
                self:SetMsgView()
            end,
            ownerId = weaponData.ownerId
        }
        customBox:setMono(self)
        customBox:SetUIData(rData, data)
    elseif self.curToggleType == "item" then
        self:SetBoxView(customBox, index+1, self.curDataList, GE.ItemTypeIndex.item)
    elseif self.curToggleType == "debris" then
        self:SetBoxView(customBox, index+1, self.curDataList, GE.ItemTypeIndex.debris)
    elseif self.curToggleType == "materials" then
        self:SetBoxView(customBox, index+1, self.curDataList, GE.ItemTypeIndex.materials)
    end
    customBox:setSelect(isSelect)
    return loopItem
end

--设置模式格子显示
function WarePanel:SetBoxView(customBox, index, nowList, mode)
    local rData = {
        id = nowList[index].id,
        itemType = GE.RewardType.ItemProp,
        num = nowList[index].num,
    }
    local data = {
        showNew = true,
        listener = function()
            self:SetNowSelectID(mode, nowList[index].id)
            self:SetMsgView()
        end
    }
    customBox:setMono(self)
    customBox:SetUIData(rData, data)
end

--设置当前模式
function WarePanel:SetNowMode(mode)
    self.nowMode = mode
end

--获取当前模式
function WarePanel:GetNowMode()
    return self.nowMode
end

function WarePanel:forceRefresh()
    self:SetViewByMode(self:GetNowMode(), true)
end
function WarePanel:RefreshItem(id)

    local size = tablex.size(self.curDataList)
    local index = -1
    for i = 1, #self.curDataList do
        if self.curDataList[i].id == id then
            index = i
            break
        end
    end
    if index == -1 then
       return 
    end
    self:OnContentValueChange(self.wareList.loopGridView, index -1, 0, 0)

end
--function WarePanel:OnClose(initiative)
--
--end

function WarePanel:OnDestroy()
	--self.super:OnDestroy(self)

    local trs = self.wareList.loopGridView.ScrollRect.content
    if IsNull(trs) then
       return 
    end
    for i = 0, trs.childCount - 1 do
        local child = trs:GetChild(i)
        ---@type UnityEngine.CanvasGroup
        local canvasGroup = child:GetComponent(TypeInfo.CanvasGroup)
        child:DOKill()
        canvasGroup:DOKill()
    end
end

--function WarePanel:OnRefresh(data)
--
--end

--[[
/ItemBox onClick 
--]]
function WarePanel:itemBox_ScaleButton_onClick(itemBox)
    self:play2DSound(self.btnSoundPath)
end

--[[
/TypeBtn onClick 
--]]
function WarePanel:typeBtn_ScaleButton_onClick(typeBtn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/EquipBox onClick 
--]]
function WarePanel:equipBox_ScaleButton_onClick(equipBox)
    self:play2DSound(self.btnSoundPath)
end

--[[
/BackPanel/HelpBtn onClick 
--]]
function WarePanel:helpBtn_ScaleButton_onClick(helpBtn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/SortPanel/SortBtn onClick 
--]]
function WarePanel:sortBtn_ScaleButton_onClick(sortBtn)
    self:play2DSound(self.btnSoundPath)
    self.sortSelectList:SetActive(not self.sortSelectList.activeSelf)
    self.sortMask:SetActive(self.sortSelectList.activeSelf)
    if self.sortSelectList.activeSelf then
        self:refreshSortView()
    end
end

--[[
/SortPanel/SortStateBtn onClick 
--]]
function WarePanel:sortStateBtn_ScaleButton_onClick(sortStateBtn)
    self:play2DSound(self.btnSoundPath)
    if self.nowMode == GE.ItemTypeIndex.equip then
        if self.nowEquipSortFace == 1 then
            self.nowEquipSortFace = 2
        elseif self.nowEquipSortFace == 2 then
            self.nowEquipSortFace = 1
        end
        self.sortStateBtn.upImg:SetActive(self.nowEquipSortFace == 2)
        self.sortStateBtn.downImg:SetActive(self.nowEquipSortFace == 1)
        self:EquipDataInfo()
        self:forceRefresh()
    elseif self.nowMode == GE.ItemTypeIndex.weapon then
        if self.nowWeaponSortFace == 1 then
            self.nowWeaponSortFace = 2
        elseif self.nowWeaponSortFace == 2 then
            self.nowWeaponSortFace = 1
        end
        self.sortStateBtn.upImg:SetActive(self.nowWeaponSortFace == 2)
        self.sortStateBtn.downImg:SetActive(self.nowWeaponSortFace == 1)
        self:WeaponDataInfo()
        self:forceRefresh()
    end
    
    self.sortSelectList:SetActive(false)
    self.sortMask:SetActive(false)
end

--[[
/SortPanel/FiltrateBtn onClick 
--]]
function WarePanel:filtrateBtn_ScaleButton_onClick(filtrateBtn)
    self:play2DSound(self.btnSoundPath)
    UIMgr:popUICover("FilterPanel", {})
end

--[[
/SortPanel/LikeFiltrateBtn onClick 
--]]
function WarePanel:likeFiltrateBtn_ScaleButton_onClick(likeFiltrateBtn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/DelBtn onClick 
--]]
function WarePanel:delBtn_ScaleButton_onClick(delBtn)
    self:play2DSound(self.btnSoundPath)
    local delType, id = nil, nil
    if self.nowMode == 1 then
        --delType = GE.RewardType.Weapon
    elseif self.nowMode == 2 then
        delType = GE.RewardType.Equipment
        if self.selectList[GE.ItemTypeIndex.equip] then
            id = self.selectList[GE.ItemTypeIndex.equip]
        end
    end
    UIMgr:popUI("EquipDelPanel", {openType = delType, selList = {id}})
end

--[[
/BtnList/LevelUpBtn onClick 
--]]
function WarePanel:levelUpBtn_ScaleButton_onClick(levelUpBtn)
    self:play2DSound(self.btnSoundPath)
    if self.nowMode == GE.ItemTypeIndex.equip then
        UIMgr:popUI("EquipIntensifyPanel", {data = self.nowSelectEquip, mode = 1})
    elseif self.nowMode == GE.ItemTypeIndex.weapon then
        if self.nowWeaponLvMax then
            if self.fuseLocked then
                local functionOpenConfig = Config.GetFunctionOpenInfo(GE.FunctionOpenModule.WeaponFuse)
                UICommonUtils.PopToast(functionOpenConfig.unlockKey)
                return
            end
            if self.canGoFuse then
                UIMgr:popUI("WeaponFusePanel",{weaponId = self.nowSelectWeaponId})
            else
                UICommonUtils.PopToast(LocalStrEnum.Tips_WeaponCannotAdd)
            end
            
        else
            UIMgr:popUI("WeaponLevelUpPanel",{weaponId = self.nowSelectWeaponId})
        end

    end
end

--[[
/BtnList/UseBtn onClick 
--]]
function WarePanel:useBtn_ScaleButton_onClick(useBtn)
    self:play2DSound(self.btnSoundPath)
    local callBackFunc = function(data)
        Me:openGiftPackReq({id = self.nowSelectItemId, num = data.num}, function()
            GameMsgMgr:sendEvent(GameMsgType.RefreshWarehousePanel)
        end)
    end
    local itemConfig = Config.GetItemInfo(self.nowSelectItemId)
    if not itemConfig then
        return
    end
    if itemConfig.useType == GE.ItemUseType.multiple then--自选礼包
        UIMgr:popUICover("GiftPackPanel", {itemId = self.nowSelectItemId})
    elseif itemConfig.useType == GE.ItemUseType.randomGift then--随机礼包
        UIMgr:popUICover("UseItemPanel", {itemId = self.nowSelectItemId})
    end
end

--[[
/ViewPanel/AllObjList/Viewport/Content/CustomBox/EquipBtn onClick 
--]]
function WarePanel:equipBtn_ScaleButton_onClick(equipBtn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/Custom/SortTypeBtn onClick 
--]]
function WarePanel:sortTypeBtn_ScaleButton_onClick(sortTypeBtn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/Custom/NatureNameBtn onClick 
--]]
function WarePanel:natureNameBtn_ScaleButton_onClick(natureNameBtn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/SortMask onClick 
--]]
function WarePanel:sortMask_Button_onClick(sortMask)
    self:play2DSound(self.btnSoundPath)
    self.sortSelectList:SetActive(false)
    self.sortMask:SetActive(false)
end

--[[
/BtnList/JumpBtn onClick 跳转按钮
--]]
function WarePanel:jumpBtn_ScaleButton_onClick(jumpBtn)
    self:play2DSound(self.btnSoundPath)
    local itemInfo = Config.GetItemInfo(self.nowSelectItemId)
    local jumpId = itemInfo.TurnTo
    UICommonUtils.CommonTurnTo(jumpId)
end

--[[
/Custom/GetActiveBox/ChannelboxBg/Image onClick 
--]]
function WarePanel:image_ScaleButton_onClick(image)

end

--[[
/Custom/GetActiveBox/GoBtn onClick 
--]]
function WarePanel:goBtn_ScaleButton_onClick(goBtn)

end

--[[
/autoRoot/Custom/GetActiveBox onClick 
--]]
function WarePanel:getActiveBox_ScaleButton_onClick(getActiveBox)

end

--[[
/autoRoot/MsgPanel/LockBtn onClick 
--]]
function WarePanel:lockBtn_ScaleButton_onClick(lockBtn)

end

--[[
/autoRoot/MsgPanel/SpBtn onClick 
--]]
function WarePanel:spBtn_ScaleButton_onClick(spBtn)

end

return WarePanel
