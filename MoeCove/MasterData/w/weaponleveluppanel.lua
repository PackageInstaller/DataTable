---@class WeaponLevelUpPanel : WeaponLevelUpPanel_Generate
---##################### 【WeaponLevelUpPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【WeaponLevelUpPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
---@class WeaponLevelUpPanel : WeaponLevelUpPanel_Generate
---##################### 【WeaponLevelUpPanel Custom Field�? Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【WeaponLevelUpPanel Custom Field�?End %%%%%%%%%%%%%%%%%%%%%
local WeaponLevelUpPanel = require "WeaponLevelUpPanel_Generate"
---@enum WeaponLevelUpTypeEnum 数据类型
WeaponLevelUpTypeEnum = {
    Weapon = 1,          --装备
    ExpItem = 2,        --狗粮
}

function WeaponLevelUpPanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.RefreshTopResource, function()
            self.customBackPanel.customBackPanel:RefreshTopResource()
        end},
    }
    self.maxLevelUpCount = 10       --最大强化可选装备数�?
    self.levelUpSelectBoxList = {}  --强化右侧选择格子列表
    self.selectGoodsNum = 0         --选中材料的个�?狗粮堆叠算一�?
    self.selectGoodsList = {}       --左侧选中武器、材料数�?
    self.expItemList = {}           --狗粮列表
    self.weaponData = {}
    self.realAddEXP = 0
    self.limitEXP = 0
    self.isAutoMode = true          --自动选择是否可用

    self.nowWeaponSortIndex = 1      --当前武器排序
    self.weaponSortBtnlist = {}
    self.nowWeaponSortFace = 1

    self.customTips.customTips:setMono(self)
    self.levelWeapon.loopGridView:InitGridView(0, BindCallback_NoParams(self, self.OnWeaponItemValueChange))
end

function WeaponLevelUpPanel:InitPanel()
    self.expItemList = {}
    self:setWeaponListData()
    self:initWeaponInfoAndGoodsBox()
end

--function WeaponLevelUpPanel:StartCreating(time)
--
--end

--function WeaponLevelUpPanel:StartEnter(time)
--
--end

--function WeaponLevelUpPanel:StartRemoving(time)
--
--end

--function WeaponLevelUpPanel:StartExit(time)
--
--end

function WeaponLevelUpPanel:OnOpen(data, initiative)
    UIMgr.uiCamera.orthographic = true
    if initiative then
        --导航�?
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.WeaponLevelUpPanel, self)
        self.customBackPanel.customBackPanel:OverrideBackFunc(function()
            self.animator:SetTrigger("out")
            self.animOverCallBack:SetCallBack(function()
                UIMgr:closeSpecificUI(self)
                self.customBackPanel.customBackPanel:ClearBackFunc()
            end)
        end)
        self.lvUpWeaponId = data and data.weaponId or 0
        self:InitPanel()
    end
end

--设置武器列表数据
function WeaponLevelUpPanel:setWeaponListData(isRefresh)
    local weaponMapData = Me:getAllWeaponData()
    self:WeaponSortInfo()
    self.weaponListData = {}
    self.expItemList = {}
    for _, weaponData in pairs(weaponMapData) do
        if (not weaponData.isLock) and weaponData.ownerId == 0 and weaponData.id ~= self.lvUpWeaponId then
            local weaponConfig = Config.GetWeaponInfo(weaponData.cid)
            local temp = {
                data = weaponData,
                quality = weaponConfig.rare,
                type = 1,       --武器
            }
            table.insert(self.weaponListData, temp)
        end
    end
    self:setWeaponSortView()
    --狗粮数据
    local itemList = ClientData:getItemMap()
    for key, value in pairs(itemList) do
        local itemConfig = Config.GetItemInfo(value.id)
        if itemConfig == nil then
            LuaLogger.es("道具配置错误2 未找到对应道具id:" .. value.id)
            goto continue
        end

        if itemConfig.useType == GE.ItemUseType.weaponExp and value.num ~= 0 then
            local temp = {
                data = value,
                quality = itemConfig.quality,
                config = itemConfig,
                type = 2,       --狗粮
            }
            table.insert(self.expItemList, temp)
        end
        ::continue::
    end

    --狗粮排序
    table.sort(self.expItemList, function(a, b)
        return a.config.effect[2] > b.config.effect[2]
    end)
    --狗粮放在最前面
    for i = #self.expItemList, 1, -1 do
        table.insert(self.weaponListData, 1, self.expItemList[i])
    end

    self.noWeapon:SetActive(#self.weaponListData == 0)

    -- FillPeer 要求 obj 的层级内激活，面板 inactive 时临时激�?
    local levelPanelWasActive = self.levelListPanel.activeSelf
    if not levelPanelWasActive then 
        self.levelListPanel:SetActive(true) 
        self.exitMask.gameObject:SetActive(true)
    end
    self.levelWeapon.loopGridView:SetListItemCount(#self.weaponListData, true)
    if not levelPanelWasActive then 
        self.levelListPanel:SetActive(false) 
        self.exitMask.gameObject:SetActive(false)
    end
end

---刷新武器备选列表（面板 inactive 时跳过，避免 LoopGridView 在非激活层级下崩溃�?
function WeaponLevelUpPanel:__refreshWeaponList()
    if self.levelListPanel.activeSelf then
        self.levelWeapon.loopGridView:RefreshAllShownItem2()
    end
end

---LoopGridView 武器备选列表回�?
function WeaponLevelUpPanel:OnWeaponItemValueChange(gridView, index, row, col)
    local loopItem = gridView:GetShownItemByItemIndex(index)
    if loopItem == nil then
        loopItem = gridView:NewListViewItem("CustomBox")
    end
    local obj = loopItem.gameObject
    EngineUtil.FillPeer(self.levelListPanel.customBox, obj)
    local dataIndex = index + 1
    local listData = self.weaponListData[dataIndex]
    if not listData then return loopItem end

    local customBox = obj.customBox
    local weaponData = listData.data
    local dataType = listData.type
    local customData = {
        scale = 0.8,
        isInIsOne = dataType == 1 and true or false,
        inCountTxtState = dataType == 2 and true or false,
        -- LoopGridView item 会复用，需要每次都显式重置选中相关状态，避免残留
        isIn = false,
        delBtnState = false,
        inCountTxt = 0,
        ownerPanelName = self.uiConfig.id,
        delBtnListener = function()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            for key, goodData in pairs(self.selectGoodsList) do
                if goodData.goodId == weaponData.id then
                    if goodData.data.type == 2 then
                        if goodData.num > 0 then
                            goodData.num = goodData.num - 1
                        end
                        if goodData.num == 0 then
                            table.remove(self.selectGoodsList, key)
                            self.selectGoodsNum = self.selectGoodsNum - 1
                        end
                    end
                    break
                end
            end
            self:__refreshWeaponList()
            self:refreshWeaponInfo()
            self:refreshGoodsBox()
        end,
        onDownListener = function()
            self.isLongPress = false
            self.longPressTimer = Timer.New(function()
                self.isLongPress = true
                self.longPressTimer = nil
            end, 0.2, 1)
            self.longPressTimer:Start()
        end,
        onLongpressListener = function()
            self.isLongPress = true
            if dataType == 2 and not self.isMaxLevel then
                self.longPressTimer = Timer.New(function()
                    if not self.isMaxLevel then
                        local itemData = Me:getItemById(weaponData.id)
                        if not itemData then return end
                        local isIn = false
                        for key, goodData in pairs(self.selectGoodsList) do
                            if goodData.goodId == weaponData.id and goodData.data.type == 2 then
                                isIn = true
                                if goodData.num < itemData.num then
                                    goodData.num = goodData.num + 1
                                end
                                break
                            end
                        end
                        if not isIn and itemData.num > 0 then
                            table.insert(self.selectGoodsList, {
                                goodId = weaponData.id,
                                data = listData,
                                num = 1,
                            })
                            self.selectGoodsNum = self.selectGoodsNum + 1
                        end
                        self:__refreshWeaponList()
                        self:refreshWeaponInfo()
                        self:refreshGoodsBox()
                    end
                end, 0.1, -1)
                self.longPressTimer:Start()
            end
        end,
        onUpListener = function()
            if self.longPressTimer then
                self.longPressTimer:Stop()
                self.longPressTimer = nil
            end
        end,
        listener = function()
            if not self.isLongPress then
                self:SelectBox(weaponData, dataIndex, dataType)
            end
            return true
        end,
    }
    -- 分类型判断显�?
    if dataType == 1 then
        customData.id = weaponData.cid
        customData.itemNum = "+"..weaponData.level
        customData.itemType = GE.ItemTypeIndex.weapon
    elseif dataType == 2 then
        customData.id = weaponData.id
        customData.itemType = GE.ItemTypeIndex.item
        local itemData = Me:getItemById(weaponData.id)
        if itemData then
            customData.itemNum = itemData.num
        end
    end
    for _, goodData in pairs(self.selectGoodsList) do
        if goodData.goodId == weaponData.id then
            customData.isIn = true
            customData.delBtnState = dataType == 2 and true or false
            if goodData.data.type == 2 then
                customData.inCountTxt = goodData.num
            end
            break
        end
    end
    customData.tipsPassEventState = false
    customBox:setMono(self)
    customBox:refreshUI(customData)
    return loopItem
end

--选择武器
function WeaponLevelUpPanel:SelectBox(weaponData, index, dataType)
    local isSelect = false
    local temp = {}
    for key, goodData in pairs(self.selectGoodsList) do
        if goodData.goodId == weaponData.id then--移除
            isSelect = true
            if dataType == 1 then
                table.remove(self.selectGoodsList, key)
                self.selectGoodsNum = self.selectGoodsNum - 1
            elseif dataType == 2 and not self.isMaxLevel then            -- 狗粮加一
                -- 检查是否超过拥有数�?
                local itemData = Me:getItemById(weaponData.id)
                if itemData and goodData.num < itemData.num then
                    goodData.num = goodData.num + 1
                    self:__refreshWeaponList()
                    self:refreshWeaponInfo()
                    self:refreshGoodsBox()
                end
                return
            end
            break
        end
    end
    if tablex.size(self.selectGoodsList) >= self.maxLevelUpCount then--选中上限
        return
    end
    if not isSelect and not self.isMaxLevel then--选中
        local data = {
            goodId = weaponData.id,
            data = self.weaponListData[index],
            num = 1,
        }                
        table.insert(self.selectGoodsList, data)
        self.selectGoodsNum = self.selectGoodsNum + 1
    end
    self:__refreshWeaponList()
    self:refreshWeaponInfo()
    self:refreshGoodsBox()
    if dataType == WeaponLevelUpTypeEnum.Weapon then
        local weaponConfig = Config.GetWeaponInfo(weaponData.cid)
        self:OpenCustomMsgPanel({
            type = GE.RewardType.Weapon,
            id = weaponData.id,
            navType = GE.NavigationType.WeaponLevelUpPanel,
            CanLock = false,
            disableMaskEvent = true,
            })

        
        --Me:ShowItemTips({id = weaponData.id, type = GE.RewardType.Weapon, navType = GE.NavigationType.WeaponLevelUpPanel, CanLock = false, tipsPassEventState = false}) 

    elseif dataType == WeaponLevelUpTypeEnum.ExpItem then
        local itemConfig = Config.GetItemInfo(weaponData.id)
        self:OpenCustomMsgPanel({
            type = GE.RewardType.ItemProp,
            id = weaponData.id,
            navType = GE.NavigationType.WeaponLevelUpPanel,
        })
        --Me:ShowItemTips({id = weaponData.id, type = GE.RewardType.ItemProp, navType = GE.NavigationType.WeaponLevelUpPanel, tipsPassEventState = false}) 
    end
   
end

--初始化右侧选中格子
function WeaponLevelUpPanel:initWeaponInfoAndGoodsBox()
    self:refreshWeaponInfo()

    self:FillTemplateContent(self.customBox, self.selectList, self.maxLevelUpCount, function(index, itemObj)
        local customBox = itemObj.customBox
        local function DelBox()
            if customBox.hasDataPanel.activeSelf then
                if self.selectGoodsList[index] then
                    if self.selectGoodsList[index].data.type == 1 then
                        table.remove(self.selectGoodsList, index)
                        self.selectGoodsNum = self.selectGoodsNum - 1
                    elseif self.selectGoodsList[index].data.type == 2 then
                        if self.selectGoodsList[index].num > 0 then
                            self.selectGoodsList[index].num = self.selectGoodsList[index].num - 1
                        end
                        if self.selectGoodsList[index].num == 0 then
                            table.remove(self.selectGoodsList, index)
                            self.selectGoodsNum = self.selectGoodsNum - 1
                        end
                    end
                end
                self:__refreshWeaponList()
                self:refreshWeaponInfo()
                self:refreshGoodsBox()
            else
                self.levelListPanel:SetActive(true)
                self.exitMask.gameObject:SetActive(true)
                self:__refreshWeaponList()
            end
        end
        local customData = {
            scale = 0.65,
            nullDataPanel = true,
            listener = function()
                DelBox()
            end,
            delBtnListener = function()
                DelBox()
            end
        }
        customBox:setMono(self)
        customBox:refreshUI(customData)
        local a = {
            index = index, customBox = customBox,
        }
        table.insert(self.levelUpSelectBoxList, a)
    end)
end

--刷新右边信息框数�?
function WeaponLevelUpPanel:refreshWeaponInfo(isLevelUp)
    --LuaLogger.e("refreshWeaponInfo")
    self.weaponData = Me:getWeaponDataById(self.lvUpWeaponId)
    local weaponConfig = Config.GetWeaponInfo(self.weaponData.cid)

    local spritePaths = {
        {path = Config.SpritePath.EquipShowRankBg, key = weaponConfig.rare, target = self.weaponRareIcon},
        {path = Config.SpritePath.WeaponIconPath, key = weaponConfig.icon, target = self.weaponIcon},
        {path = Config.SpritePath.WeaponTypePath, key = weaponConfig.type, target = self.weaponTypeIcon}
    }

    for _, spriteInfo in ipairs(spritePaths) do
        self:LoadSpriteAsync(string.format(spriteInfo.path, spriteInfo.key), spriteInfo.target.image)
    end

    self.weaponNameText.text.text = weaponConfig.name
    self.levelTxt.text.text = "+"..self.weaponData.level

    --经验�?
    local newLevel = 0
    self.realAddEXP = 0
    self.isMaxLevel = self.weaponData.level == weaponConfig.levelMax
    if self.isMaxLevel then
        self.nowSlider.image.fillAmount = 1
        self.expTxt.text.text = ""
        self.newLevelTxt.text.text = ""
        self.addExpTxt.text.text = ""
    else
        --增加经验
        local addExp = 0
        self.weaponLvLimit = weaponConfig.levelMax
        local lvGroup = Config.GetLevelconfigInfoByType(weaponConfig.levelupType)
        if next(self.selectGoodsList) then
            -- 接入狗粮
            for _, expItem in pairs(self.selectGoodsList) do
                if expItem.data.type == 1 then
                    local useData = expItem.data.data
                    local useConfig = Config.GetWeaponInfo(useData.cid)
                    local weaponExp = useData.exp
                    addExp = addExp + useConfig.expValue + weaponExp * Config.GetConfigInfo("weaponReturn")
                elseif expItem.data.type == 2 then
                    local itemData = expItem.data
                    local itemConfig = Config.GetItemInfo(expItem.goodId)
                    addExp = addExp + itemConfig.effect[2] * expItem.num
                end
            end
            self.limitEXP = 0
            local newExp = self.weaponData.exp + addExp
            for _, value in pairs(lvGroup) do
                --装备达到当前突破上限
                if value.level == self.weaponLvLimit then
                    self.limitEXP = value.exp_sum
                end
                if self.limitEXP ~= 0 and newExp >= self.limitEXP then
                    self.realAddEXP = self.limitEXP - self.weaponData.exp
                    newLevel = self.weaponLvLimit
                else
                    if newExp < value.exp_sum then
                        self.realAddEXP = addExp
                        newLevel = value.level - 1
                        break
                    end
                end
            end
            self.newLevelTxt.text.text = newLevel - self.weaponData.level ~= 0 and "+"..(newLevel - self.weaponData.level) or ""
            self.addExpTxt.text.text = "+"..self.realAddEXP
            self.isMaxLevel = newLevel == weaponConfig.levelMax
        else
            self.newLevelTxt.text.text = ""
            self.addExpTxt.text.text = ""
        end
        --当前经验
        local nextLvMaxExp = 0
        local nowLvSumExp = 0
        for _, value in pairs(lvGroup) do
            if value.level == self.weaponData.level + 1 then
                nextLvMaxExp = value.exp
            end
            if value.level == self.weaponData.level then
                nowLvSumExp = value.exp_sum
            end
        end
        local showExp = self.weaponData.exp - nowLvSumExp
        self.expTxt.text.text = showExp.."/"..nextLvMaxExp
        self.nowSlider.image.fillAmount = showExp / nextLvMaxExp
        self.addSlider.image.fillAmount = (showExp + self.realAddEXP) / nextLvMaxExp
    end

    --满级与可升级显示状�?
    self.levelUpPanel:SetActive(not (self.weaponData.level == weaponConfig.levelMax))
    self.maxTipsBg:SetActive(self.weaponData.level == weaponConfig.levelMax)
    --self.newLevelBg:SetActive(not self.isMaxLevel and newLevel ~= 0)
    self.maxLevelBg:SetActive(self.isMaxLevel)
    self.expTxt:SetActive(not self.isMaxLevel)

    --基础属�?
    self.amountNum.text.text = weaponConfig.weaponTypeDec
    self.accuracyNum.text.text = self.weaponData.accuracy
    self.qualityNum.text.text = self.weaponData.quality

    self.scoreText.text.text = math.floor((weaponConfig.bulletNum * self.weaponData.accuracy * self.weaponData.quality / 1000))

    --词条
    local needAttrList = {}
    for attrType, attrData in pairs(self.weaponData.attributeValue) do
        local entryList = Config.GetWeaponEntryInfoByGroup(attrType)
        local data = {
            name = entryList[1].name,
            valueType = entryList[1].type,
            value = attrData.value,
            type = entryList[1].attributeId,
            isSpecial = attrData.isSpecial,
        }
        needAttrList[attrData.id] = data
    end
    self.skillPanel:SetActive(false)
    self:FillTemplateContent(self.attributeBox, self.attributeList, tablex.size(weaponConfig.entryUnlock), function(index, attributeBox)
        local boxData = {
            boxType = GE.ItemTypeIndex.weapon,
            attrData = needAttrList[index],
            weaponConfig = weaponConfig,
            weaponData = self.weaponData,
            boxIndex = index,
        }

        --if needAttrList[index] then
            if needAttrList[index] and needAttrList[index].valueType == GE.WeaponEntryAttrType.specialSkill then
                self.skillPanel:SetActive(true)
                local skillConfig = Config.GetSkillInfo(needAttrList[index].value)
                self.weaponSkillTxt.text.text = skillConfig.desKey
                --升级刷新时播放动�?
                if isLevelUp then
                    self.effect.animOverCallBack:SetCallBack(function()
                        self.effect:SetActive(false)
                    end)
                    self.effect:SetActive(true)
                end
                attributeBox.attributeBox.gameObject:SetActive(false)
            else
                --升级刷新时播放动�?
                if isLevelUp and needAttrList[index] then
                    attributeBox.attributeBox:playLevelUpAnim(needAttrList[index])
                end
                attributeBox.attributeBox:setMono(self)
                attributeBox.attributeBox:setAttrBoxData(boxData)
            end
        --else
        --    attributeBox.attributeBox.gameObject:SetActive(false)
        --end
    end)

    --消耗货�?
    self.payTitleTxt.text.text = "消耗材料 ("..self.selectGoodsNum.."/"..self.maxLevelUpCount..")"
    local useResRatio = Config.GetConfigInfo("weaponExpCost")
    local equipCurrency = Config.GetConfigInfo("weaponCurrency")
    self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, "ItemIcon_"..equipCurrency), self.resIcon.image)
    local resCost = useResRatio * self.realAddEXP
    local resItemData = Me:getItemById(equipCurrency)
    local resHasEnough = resCost == 0 or (resItemData and resItemData.num >= resCost)
    if resHasEnough then
        self.levelPanel.resCount.text.text = tostring(resCost)
    else
        self.levelPanel.resCount.text.text = "<color=#FF3131>"..resCost.."</color>"
    end

    -- --货币信息
    -- self.resCountTxt.text.text = UICommonUtils.SetResourceFormatByType(GE.ResourceType.Gold)
end

--刷新右边选中格子数据
function WeaponLevelUpPanel:refreshGoodsBox()  
    for key, boxInfo in pairs(self.levelUpSelectBoxList) do
        local customBox = boxInfo.customBox
        local customData = {
            scale = 0.65,
            delBtnState = true,
            clickLongPressListener = {},
            ownerPanelName = self.uiConfig.id,
        }
        if self.selectGoodsList[key] then
            if self.selectGoodsList[key].data.type == 1 then
                local weaponData = self.selectGoodsList[key].data.data
                customData.id = weaponData.cid
                customData.itemType = GE.ItemTypeIndex.weapon
                customData.itemNum = "+"..weaponData.level
            elseif self.selectGoodsList[key].data.type == 2 then
                local itemData = Me:getItemById(self.selectGoodsList[key].goodId)
                customData.id = self.selectGoodsList[key].goodId
                customData.itemType = GE.ItemTypeIndex.item
                if itemData then
                    customData.itemNum = self.selectGoodsList[key].num
                end
            end
            customData.nullDataPanel = false
        else
            customData.nullDataPanel = true
        end

        local function DelBox()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            if customBox.hasDataPanel.activeSelf then
                if self.selectGoodsList[key] then
                    if self.selectGoodsList[key].data.type == WeaponLevelUpTypeEnum.Weapon then
                        table.remove(self.selectGoodsList, key)
                        self.selectGoodsNum = self.selectGoodsNum - 1
                    elseif self.selectGoodsList[key].data.type == WeaponLevelUpTypeEnum.ExpItem then
                        if self.selectGoodsList[key].num > 0 then
                            self.selectGoodsList[key].num = self.selectGoodsList[key].num - 1
                        end
                        if self.selectGoodsList[key].num == 0 then
                            table.remove(self.selectGoodsList, key)
                            self.selectGoodsNum = self.selectGoodsNum - 1
                        end
                    end
                    if self.selectGoodsNum <= 0 then
                        self:clearSelection()
                    end
                end
                self:__refreshWeaponList()
                self:refreshWeaponInfo()
                self:refreshGoodsBox()
            else
               self.levelListPanel:SetActive(true)
               self.exitMask.gameObject:SetActive(true)
               self:__refreshWeaponList()
            end
        end

        customData.listener = function()
            DelBox()
        end
        customData.delBtnListener = function()
            DelBox()
        end
        
        customBox:setMono(self)
        customBox:refreshUI(customData)
    end
end

---------------------------------------------------------------------------------------

--武器排序初始�?
function WeaponLevelUpPanel:WeaponSortInfo()
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
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            self.nowWeaponSortIndex = index
            self.sortTxt.text.text = LocalStrEnum["weaponFilterType"..GE.WeaponSortType[GE.WeaponSortTypeName[self.nowWeaponSortIndex]]]
            self.sortSelectList:SetActive(false)
            self.sortMask:SetActive(false)
            self:setWeaponListData(true)
            self:refreshSortView()
        end)
    end)
end

--刷新排序显示
function WeaponLevelUpPanel:refreshSortView()
    for k,v in pairs(self.weaponSortBtnlist) do
        v.obj.isOpen:SetActive(self.nowWeaponSortIndex == v.key)
    end
end

--设置武器排序详情
function WeaponLevelUpPanel:setWeaponSortView()
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
                local a_config = Config.GetWeaponInfo(a.data.cid)
                local b_config = Config.GetWeaponInfo(b.data.cid)
                if a_config ~= nil and b_config ~= nil then
                    return a_config.id < b_config.id
                end
            end
        end
    end

    --获取主次排序
    local function getPrimarySecondary()
        if self.nowWeaponSortIndex == GE.WeaponSortType.default or self.nowWeaponSortIndex == GE.WeaponSortType.level then
            return function(a, b) return a.data.level > b.data.level end,
                   function(a, b) return a.data.rare > b.data.rare end
        elseif self.nowWeaponSortIndex == GE.WeaponSortType.quality then
            return function(a, b) return a.data.rare > b.data.rare end,
                    function(a, b) return a.data.level > b.data.level end
        elseif self.nowWeaponSortIndex == GE.WeaponSortType.loadValue then
            return function(a, b) return a.data.load > b.data.load end,
                    function(a, b) return a.data.level > b.data.level end
        elseif self.nowWeaponSortIndex == GE.WeaponSortType.point then
            return function(a, b) return a.data.point > b.data.point end,
                    function(a, b) return a.data.level > b.data.level end
        end
    end

    local primary, secondary = getPrimarySecondary()
    local ascending = self.nowWeaponSortFace == 1

    table.sort(self.weaponListData, function(a, b)
        return compare(a, b, primary, secondary, ascending)
    end)
end

--清除选择
function WeaponLevelUpPanel:clearSelection()
    self.selectGoodsList = {}
    self.selectGoodsNum = 0
    -- 刷新数据列表，确保使用最新的道具数量
    self:setWeaponListData(true)
    self:refreshWeaponInfo()
    self:refreshGoodsBox()
    self.autoTxt.text.text = "自动选择"
    self.isAutoMode = true
end

--计算需要的经验
--@param lvGroup 等级数据
--@param levelMax 最大等�?
function WeaponLevelUpPanel:calculateNeededExp(lvGroup, levelMax)
    local needExp = 0
    for _, value in pairs(lvGroup) do
        if value.level == levelMax then
            needExp = value.exp_sum
            break
        end
    end
    return needExp - self.weaponData.exp - self.realAddEXP
end

--选择狗粮
--@param needExp 需要的经验
function WeaponLevelUpPanel:selectExpItems(needExp)
    table.sort(self.expItemList, function(a, b)
        return a.config.effect[2] > b.config.effect[2]
    end)
    local temp = {}
    for _, itemData in pairs(self.expItemList) do
        local id = itemData.config.id
        local expNum = itemData.config.effect[2]
        if needExp > 0 then
            temp[id] = math.min(math.floor(needExp / expNum), itemData.data.num)
            needExp = needExp - temp[id] * expNum
            if temp[id] == 0 then
                temp[id] = nil
            end
        end
    end
    return temp, needExp
end

--选择武器
--@param temp 已选择的狗粮列�?
--@param needExp 需要的经验
function WeaponLevelUpPanel:selectWeapons(temp, needExp)
    local vacancy = self.maxLevelUpCount - tablex.size(temp) - tablex.size(self.selectGoodsList)
    -- 先处理已选的狗粮（exp items�?
    for _, value in pairs(self.weaponListData) do
        if value.type == 2 and temp[value.data.id] then
            local id = value.data.id
            local count = temp[id]
            local isIn = false
            
            -- 检查狗粮拥有数�?
            local itemData = Me:getItemById(id)
            if not itemData then
                temp[id] = nil
                goto continue
            end

            for _, v in pairs(self.selectGoodsList) do
                if v.goodId == id then
                    -- 确保不超过拥有数�?
                    local newCount = math.min(v.num + count, itemData.num)
                    v.num = newCount
                    isIn = true
                    break
                end
            end

            if not isIn then
                -- 确保不超过拥有数�?
                local finalCount = math.min(count, itemData.num)
                table.insert(self.selectGoodsList, {
                    goodId = id,
                    num = finalCount,
                    data = value,
                })
                self.selectGoodsNum = self.selectGoodsNum + 1
            end

            temp[id] = nil
            ::continue::
        end
    end

    -- 逆序遍历武器列表，跳过已�?selectGoodsList 中的武器，避免重复添�?
    for i = tablex.size(self.weaponListData), 1, -1 do
        local weaponData = self.weaponListData[i]
        if weaponData.type == 1 and vacancy > 0 and needExp > 0 then
            -- 检查是否已在选中列表�?
            local alreadyIn = false
            for _, v in pairs(self.selectGoodsList) do
                if v.goodId == weaponData.data.id then
                    alreadyIn = true
                    break
                end
            end

            if not alreadyIn then
                -- 根据品质尝试添加（保留原逻辑的品质循环）
                for q = 1, 3 do
                    if weaponData.quality == q then
                        local weaponConfig = Config.GetWeaponInfo(weaponData.data.cid)
                        local exp = weaponConfig.expValue
                        needExp = needExp - exp
                        vacancy = vacancy - 1
                        table.insert(self.selectGoodsList, { goodId = weaponData.data.id, num = 1, data = weaponData })
                        self.selectGoodsNum = self.selectGoodsNum + 1
                        if vacancy <= 0 or needExp <= 0 then
                            break
                        end
                    end
                end
            end
        end
    end

    return needExp
end

function WeaponLevelUpPanel:OnClose(initiative)
    UIMgr.uiCamera.orthographic = false
end

--function WeaponLevelUpPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function WeaponLevelUpPanel:OnRefresh(data)
--
--end

--[[
/BackPanel/BackMainlBtn onClick 
--]]
function WeaponLevelUpPanel:backMainlBtn_ScaleButton_onClick(backMainlBtn)

end

--[[
/BackPanel/HelpBtn onClick 
--]]
function WeaponLevelUpPanel:helpBtn_ScaleButton_onClick(helpBtn)

end

--[[
/ResBg/AddBtn onClick 
--]]
function WeaponLevelUpPanel:addBtn_ScaleButton_onClick(addBtn)

end

--[[
/LevelPanel/LevelUpPanel/AutoBtn onClick 
--]]
function WeaponLevelUpPanel:autoBtn_ScaleButton_onClick(autoBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if not self.isAutoMode then
        self:clearSelection()
        return
    end

    self.levelListPanel:SetActive(true)
    self.exitMask.gameObject:SetActive(true)
    local weaponConfig = Config.GetWeaponInfo(self.weaponData.cid)                  --武器配置
    local lvGroup = Config.GetLevelconfigInfoByType(weaponConfig.levelupType)             --等级数据
    local needExp = self:calculateNeededExp(lvGroup, weaponConfig.levelMax)         --需要的经验

    local temp, itemMoreExp  = self:selectExpItems(needExp)
    local moreExp = self:selectWeapons(temp, itemMoreExp)
    if moreExp > 0 then
        local itemData = self.expItemList[#self.expItemList]
        if itemData then
            local id = itemData.config.id
            local expNum = itemData.config.effect[2]
            local ownedNum = Me:getItemById(id)
            if moreExp > 0 and ownedNum and ownedNum.num > 0 then
                local numToUse = math.ceil(moreExp / expNum)
                
                -- 检查是否已经在选择列表�?
                local alreadyIn = false
                for _, v in pairs(self.selectGoodsList) do
                    if v.goodId == id then
                        -- 确保不超过拥有数�?
                        local newNum = math.min(v.num + numToUse, ownedNum.num)
                        v.num = newNum
                        alreadyIn = true
                        break
                    end
                end
                
                if not alreadyIn then
                    -- 确保不超过拥有数�?
                    numToUse = math.min(numToUse, ownedNum.num)
                    table.insert(self.selectGoodsList, {goodId = id, num = numToUse, data = itemData })
                    self.selectGoodsNum = self.selectGoodsNum + 1
                end
            end
        end
    end
    self:__refreshWeaponList()
    self:refreshWeaponInfo()
    self:refreshGoodsBox()
    self.isAutoMode = false
    self.autoTxt.text.text = "全部清除"
end

--[[
/LevelPanel/LevelUpPanel/LevelOkBtn onClick 
--]]
function WeaponLevelUpPanel:levelOkBtn_ScaleButton_onClick(levelOkBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if not next(self.selectGoodsList) then
        return
    end
    local needGoodsList = {}
    for _, goodData in pairs(self.selectGoodsList) do
        local newData = {}
        if goodData.data.type == 1 then
            newData = {
                id = goodData.goodId,
                type = GE.RewardType.Weapon,
                num = goodData.num,
            }
        elseif goodData.data.type == 2 then
            newData = {
                id = goodData.goodId,
                type = GE.RewardType.ItemProp,
                num = goodData.num,
            }
        end
        table.insert(needGoodsList, newData)
    end
    local data = {
        weaponId = self.lvUpWeaponId,
        useList = needGoodsList,
    }
    Me:addWeaponExpReq(data, function()
        -- 先清空选择列表
        self.selectGoodsList = {}
        self.selectGoodsNum = 0
        self.autoTxt.text.text = "自动选择"
        self.isAutoMode = true
        -- 再刷新数据列表，确保使用最新的道具数量和武器数据，且清除选中状�?
        self:setWeaponListData(true)
        self:showLevelUp()
        self:refreshGoodsBox()
        local btnSoundPath = string.format(Config.AudioPath.SE, "strengthen")
        self:play2DSound(btnSoundPath)
        GameMsgMgr:sendEvent(GameMsgType.OnWeaponChange)
        GameMsgMgr:sendEvent(GameMsgType.HeroNatureChange)
    end)
end

function WeaponLevelUpPanel:showLevelUp()
    local preData = self.weaponData
    local newData = Me:getWeaponDataById(self.lvUpWeaponId)
    local weaponConfig = Config.GetWeaponInfo(self.weaponData.cid)
    self:progressAni(preData, newData, weaponConfig)
end

function WeaponLevelUpPanel:progressAni(preData, newData, weaponConfig)
    self.addSlider.image.fillAmount = 0
    self.addExpTxt.text.text = ""
    self.newLevelTxt.text.text = ""
    self.maxLevelBg:SetActive(false)
    self.expTxt:SetActive(true)

    self.isMaxLevel = newData.level == weaponConfig.levelMax
    if preData.level ~= newData.level then
        self:exitMask_Button_onClick()
    end
    self:showSlider(preData, newData, weaponConfig.levelupType, function()
        self:refreshWeaponInfo(true)
    end)
end

function WeaponLevelUpPanel:showSlider(preData, newData, levelupType, callback)
    -- LuaLogger.e("showSlider")
    -- LuaLogger.e(preData.level..","..preData.exp)
    -- LuaLogger.e(newData.level..","..newData.exp)
    local curShowLvData = Config.GetLevelconfigInfoByTypeLevel(levelupType, preData.level)
    --LuaLogger.e(tablex.dump(curShowLvData))
    local nextLv = preData.level + 1
    if curShowLvData and nextLv > curShowLvData.max_level then
        nextLv = curShowLvData.max_level
    end
    local nextLvData = Config.GetLevelconfigInfoByTypeLevel(levelupType, nextLv)
    --LuaLogger.e(tablex.dump(nextLvData))

    local curShowExp = preData.exp
    local curLvSumExp = 0
    if curShowLvData then
        curLvSumExp = curShowLvData.exp_sum
    end
    if preData.exp ~= 0 then
        curShowExp = curShowExp - curLvSumExp
    end

    self.levelTxt.text.text = "+"..preData.level
    if preData.level ~= newData.level then
        --时间随等级差值变�?
        local needTime = 0.5 / (newData.level - preData.level + 2)
        self:nowSliderAni(curShowExp, nextLvData.exp, nextLvData.exp, needTime, function()
            if newData.level == nextLvData.max_level and preData.level == newData.level -1 then
                self.levelTxt.text.text = "+"..newData.level
                self.maxLevelBg:SetActive(true)
                self.expTxt:SetActive(false)
                callback()
            else
                local temp = {
                    exp = 0,
                    level = preData.level + 1,
                }
                self:showSlider(temp, newData, levelupType, callback)
            end
        end)
    else
        local newShowExp = newData.exp - curLvSumExp
        self:nowSliderAni(curShowExp, newShowExp, nextLvData.exp, 0.5, function()
            callback()
        end)
    end
end

function WeaponLevelUpPanel:nowSliderAni(pre, new, max, dt, callback)
    --LuaLogger.e(pre..","..new..","..max)
    DG.Tweening.DOVirtual.Float(pre, new, dt, function(v)
        self.nowSlider.image.fillAmount = v / max
        self.expTxt.text.text = math.floor(v).."/"..max
    end):SetEase(DG.Tweening.Ease.OutCubic):OnComplete(function()
        callback()
    end)
end

---@param data CustomMsgData
function WeaponLevelUpPanel:OpenCustomMsgPanel(data)
    -- self.customMsgPanel:SetActive(true)
    -- self.customMsgPanel.customMsgPanel:SetPassEventState(false)
    -- self.customMsgPanel.customMsgPanel:setMono(self)
    -- self.customMsgPanel.customMsgPanel:SetView(data)

    self.customTips.gameObject:SetActive(true)
    self.customTips.customTips:SetUIData(data)
end

--[[
/LevelListPanel/ExitMask onClick 
--]]
function WeaponLevelUpPanel:exitMask_Button_onClick(exitMask)
    self.levelListPanel.animation:Play("LevelListPanelOff")
    self.exitMask.button.interactable = false
    self.customTips.gameObject:SetActive(false)
    self.levelListPanel.animOverCallBack:SetCallBack(function()
        self.levelListPanel:SetActive(false)
        self.exitMask.gameObject:SetActive(false)
        self.exitMask.button.interactable = true
    end)
end

--[[
/LevelListPanel/SortBg/SortBtn onClick 
--]]
function WeaponLevelUpPanel:sortBtn_ScaleButton_onClick(sortBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.sortSelectList:SetActive(not self.sortSelectList.activeSelf)
    self.sortMask:SetActive(self.sortSelectList.activeSelf)
    if self.sortSelectList.activeSelf then
        self:refreshSortView()
    end
end

--[[
/LevelListPanel/SortBg/SortStateBtn onClick 
--]]
function WeaponLevelUpPanel:sortStateBtn_ScaleButton_onClick(sortStateBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.nowWeaponSortFace == 1 then
        self.nowWeaponSortFace = 2
    elseif self.nowWeaponSortFace == 2 then
        self.nowWeaponSortFace = 1
    end
    self.sortStateBtn.upImg:SetActive(self.nowWeaponSortFace == 2)
    self.sortStateBtn.downImg:SetActive(self.nowWeaponSortFace == 1)
    self:setWeaponListData(true)
    self.sortSelectList:SetActive(false)
    self.sortMask:SetActive(false)
end

--[[
/LevelListPanel/DelBtn onClick 
--]]
function WeaponLevelUpPanel:delBtn_ScaleButton_onClick(delBtn)
    --UIMgr:popUI("EquipDelPanel", {openType = GE.RewardType.Weapon})
end

--[[
/LevelListPanel/SortPanel/SortMask onClick 
--]]
function WeaponLevelUpPanel:sortMask_Button_onClick(sortMask)
    self.sortSelectList:SetActive(false)
    self.sortMask:SetActive(false)
end

--[[
/SortTypeBtn onClick 
--]]
function WeaponLevelUpPanel:sortTypeBtn_ScaleButton_onClick(sortTypeBtn)

end

return WeaponLevelUpPanel
