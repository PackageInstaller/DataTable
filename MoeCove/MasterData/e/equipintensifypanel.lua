---@class EquipIntensifyPanel : EquipIntensifyPanel_Generate
---##################### 【EquipIntensifyPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【EquipIntensifyPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local EquipIntensifyPanel = require "EquipIntensifyPanel_Generate"
---@enum EquipIntensifyTypeEnum 数据类型
EquipIntensifyTypeEnum = {
    Equip = 1,          --装备
    ExpItem = 2,        --狗粮
}

-- ->装备数据<-
---@class EquipData                   
---@field isIn boolean                  是否选中
---@field data EquipInfo                装备数据
---@field index integer                 装备索引
---@field config EquipmentTableTable    装备配置

-- ->狗粮数据<-
---@class EquipExpData                    
---@field isIn boolean                      是否选中
---@field data ItemTableTable | EquipmentTableTable    狗粮数据 或 装备数据
---@field index integer                     狗粮索引
---@field config ItemTableTable             狗粮配置
---@field selectCount integer?              选中数量
---@field type EquipIntensifyTypeEnum        类型

function EquipIntensifyPanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.RefreshTopResource, function()
            self.customBackPanel.customBackPanel:RefreshTopResource()
        end},
    }

    self.nowMode = 0
    self.modeList = {
        "level", "star"
    }
    self.maxLevelUpCount = 10       --最大强化可选装备数量
    self.levelUpSelectBoxList = {}  --强化右侧选择格子列表
    self.levelStarUpSelectBoxList = {}
    self.nowMaxExp = 0
    self.limitEXP = 0
    self.AddNatureData = {}
    self.NatureData = {}
    self.equipLevelCfg = {}
    self.nowEquipData = {}          --当前选中的装备数据

    self.levelList = {}             --已经选择用于升级的的列表
    ---@type EquipData[]
    self.starList = {}              --准备使用的突破列表
    self.delList = {}               --准备分解的装备列表

    self.equipObjList = {}          --强化装备预制体列表
    self.equipDataList = {}         --强化装备备选装备列表数据
    self.equipConfig = {}           --当前选择装备配置

    self.attributeBoxList = {}
    self.isMax = false

    self.nowMaxData = {}            --当前可突破的最大等级信息
    self.expItemList = {}           --狗粮列表
    
    self.isAutoMode = true          --自动选择是否可用

    self.nowEquipSortIndex = 1      --当前装备排序
    self.equipSortBtnlist = {}
    self.nowEquipSortFace = 2

    self.nowStarSortIndex = 1
    self.starSortBtnlist = {}
    self.nowStarSortFace = 1

    self.canClick = true

    self.levelEquip.loopGridView:InitGridView(0, BindCallback_NoParams(self, self.OnLevelEquipItemValueChange))
    self.starEquip.loopGridView:InitGridView(0, BindCallback_NoParams(self, self.OnStarEquipItemValueChange))
end

--function EquipIntensifyPanel:StartCreating(time)
--
--end

--function EquipIntensifyPanel:StartEnter(time)
--
--end

--function EquipIntensifyPanel:StartRemoving(time)
--
--end

--function EquipIntensifyPanel:StartExit(time)
--
--end

function EquipIntensifyPanel:OnOpen(data, initiative)
    UIMgr.uiCamera.orthographic = true
    if initiative then
        self.nowEquipData = Me:getEquipDataByid(data.data)
        self.equipConfig = Config.GetEquipmentInfo(self.nowEquipData.cid)
        self:SetToggle(data.mode)
    else
        self:SetToggle(self.nowMode, true)
    end
    self.customBackPanel.customBackPanel:OverrideBackFunc(function()
        self.animator:SetTrigger("out")
        self.animOverCallBack:SetCallBack(function()
            UIMgr:closeSpecificUI(self)
            self.customBackPanel.customBackPanel:ClearBackFunc()
        end)
    end)
    GuideMgr:StartGuideTrigger("EquipIntensifyPanel")
end

function EquipIntensifyPanel:SetToggle(mode, refresh)
    if mode == self.nowMode and not refresh then
        return
    end
    if mode == 1 then
        self:SetLevelPanel()
        self.levelPanel.animation:Play("LvIn")
        self.starPanel.animation:Play("StarOut")
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.EquipIntensifyPanel_LevelUp)
    elseif mode == 2 then
        self:SetStarPanel()
        self.levelPanel.animation:Play("LvOut")
        self.starPanel.animation:Play("StarIn")
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.EquipIntensifyPanel_StarUp)
    end
    self.nowMode = mode

    for k,v in pairs(self.modeList) do
        self[v.."Btn"].isSelect:SetActive(self.modeList[mode] == v)
        self[v.."Panel"]:SetActive(self.modeList[mode] == v)
    end
    self:emptyLevelList()
    self:emptyStarList()
end

--设置升级界面
function EquipIntensifyPanel:SetLevelPanel(isUpdate, isLevelUp)
    self.equipDataList = {}
    if not isUpdate then
        self.levelList = {}
        self.levelUpSelectBoxList = {}
        self.equipConfig = Config.GetEquipmentInfo(self.nowEquipData.cid)
        self:LoadSpriteAsync(string.format(Config.SpritePath.EquipShowRankBg, self.equipConfig.quality), self.weaponRareIcon.image)
        self:LoadSpriteAsync(string.format(Config.SpritePath.EquipIconPath, self.equipConfig.icon), self.weaponIcon.image)
        self.equipNameText.text.text = self.equipConfig.name
        self.isSp:SetActive(self.equipConfig.equipType == GE.EquipType.sp)

        self.levelTxt.text.text = "Lv."..self.nowEquipData.level
        self.equipLevelCfg = Config.GetEquipLevelByLevelGroup(GE.EquipLevelType.Normal, self.equipConfig.levelGroup)
        self.nowMaxExp = 0
        self.limitEXP = 0
        self.levelPanel.resCount.text.text = "x0"

        self:FillTemplateContent(self.starBox, self.lvStarList, #self.equipConfig.levelMax, function(index, starBox)
            starBox.isOn:SetActive(index <= self.nowEquipData.star)
        end)
        
        for _, levelCfg in pairs(self.equipLevelCfg) do
            if levelCfg.equipLevel == self.equipConfig.levelMax[self.nowEquipData.star] then
                self.nowMaxData = levelCfg
            end
            if levelCfg.equipLevel == self.nowEquipData.level then
                self.nowMaxExp = levelCfg.exp
                self.limitEXP = self.nowEquipData.exp - levelCfg.expTotal
            end
        end
        self.nowSlider.image.fillAmount = self.limitEXP / self.nowMaxExp
    
        --初始化的时候判断是否已经满级，满级显示max
        self.isMax = self.equipConfig.levelMax[self.nowEquipData.star] == self.nowEquipData.level
        if self.isMax then
            self.nowSlider.image.fillAmount = 1
        end
        self.levelUpPanel:SetActive(not self.isMax)
        self.maxTipsBg:SetActive(self.isMax)
        self.maxLevelBg:SetActive(self.isMax)
        self:updateAttr(isLevelUp)
    
        --技能信息显示
        local nowEffectId = Me:getEquipEffectIdByid(self.nowEquipData.id)
        local nowEffectStage = Me:getEquipEffectStageByid(self.nowEquipData.id)
        local equipSkill = self.equipConfig.skill
        local romanNumerals = {"I", "II", "III", "IV", "V"}
        local unlockStr = LocalStrEnum.ActionFailReason_EquipLevelUpTips
        self.levelChange:SetActive(false)
        if nowEffectId == nil and tablex.next(equipSkill) == nil then
            self.nullEffect:SetActive(true)
            self.hasEffect:SetActive(false)
            self.effectLevel.text.text = ""
            self.effectLevelMsg.text.text = ""
            self.isMaxLevel:SetActive(false)
            self.skillPanel.canvasGroup.alpha = 0
        elseif nowEffectId == nil and tablex.next(equipSkill) ~= nil then
            self.nullEffect:SetActive(false)
            self.hasEffect:SetActive(true)
            self.effectLevel.text.text = ""
            self.effectLevelMsg.text.text = string.format(unlockStr, self.equipConfig.unLockSkillLv[1])
            self.isMaxLevel:SetActive(false)
            local nextEffectId = equipSkill[1] or 0
            local skillConfig = Config.GetSkillInfo(nextEffectId)
            self.skillMsgTxt.text.text = skillConfig and skillConfig.desKey or ""
            self.skillPanel.canvasGroup.alpha = 1
        else
            self.nullEffect:SetActive(false)
            self.hasEffect:SetActive(true)
            local maxStage = #self.equipConfig.unLockSkillLv
            if nowEffectStage >= maxStage then
                self.isMaxLevel:SetActive(true)
                self.effectLevel.text.text = ""
                self.effectLevelMsg.text.text = ""
            else
                self.isMaxLevel:SetActive(false)
                self.effectLevel.text.text = romanNumerals[nowEffectStage] .. " " .. LocalStrEnum.AffectionLevel
                self.effectLevelMsg.text.text = ""
            end
            local skillConfig = Config.GetSkillInfo(nowEffectId)
            self.skillMsgTxt.text.text = skillConfig and skillConfig.desKey or ""
            self.skillPanel.canvasGroup.alpha = 1
        end
        
        self.payTitleTxt.text.text = "消耗材料:("..tablex.size(self.levelList).."/"..self.maxLevelUpCount..")"
        self:fillSelectList(function()
            self:__refreshLevelEquipList()
        end)
        return
    end
    self:__refreshLevelEquipList()
end

---强化备选列表数据构建与刷新（在 fillSelectList 完成后调用）
function EquipIntensifyPanel:__refreshLevelEquipList()
    self:EquipSortInfo()
    local equipList = Me:getAllEquipData()
    for key, value in pairs(equipList) do
        local configData = Config.GetEquipmentInfo(value.cid)
        ---@type EquipData|BuyItemData
        local temp = {
            isIn = false,
            data = value,
            index = key,
            config = configData,
            type = EquipIntensifyTypeEnum.Equip,           -- 装备
        }
        local canSelected = false
        --列表筛选
        canSelected = value.id ~= self.nowEquipData.id and 
            not Me:checkEquipLockState(value.id) and 
            value.ownerId == 0 and configData.equipType ~= GE.EquipType.rankUp and value.level <= 1
        if canSelected then
            table.insert(self.equipDataList, temp)
        end
    end
    self:setEquipSortView()

    ---@type EquipExpData
    self.expItemList = {}
    local itemList = ClientData:getItemMap()
    for key, value in pairs(itemList) do
        ---@type ItemTable
        local itemConfig = Config.GetItemInfo(value.id)
        if itemConfig == nil then
           LuaLogger.es("道具配置错误1 未找到对应道具id:" .. value.id)
            goto continue
        end
        if itemConfig.useType == GE.ItemUseType.equipExp and value.num ~= 0 then
            local temp = {
                isIn = false,
                data = value,
                index = key,
                config = itemConfig,
                selectCount = 0,
                type = EquipIntensifyTypeEnum.ExpItem,   --狗粮
            }
            table.insert(self.expItemList, temp)
        end

        ::continue::
    end
    table.sort(self.expItemList, function(a, b)
        if a.config.quality ~= b.config.quality then
            return a.config.quality < b.config.quality
        end
        return a.config.id < b.config.id
    end)
    for i = #self.expItemList, 1, -1 do
        table.insert(self.equipDataList, 1, self.expItemList[i])
    end

    --强化列表显示   显示1星的装备
    local levelCount = tablex.size(self.equipDataList)
    -- FillPeer 要求 obj 的层级内激活，面板 inactive 时临时激活使回调正常运行
    local levelPanelWasActive = self.levelListPanel.activeSelf
    if not levelPanelWasActive then self.levelListPanel:SetActive(true) end
    self.levelEquip.loopGridView:SetListItemCount(levelCount, true)
    if not levelPanelWasActive then self.levelListPanel:SetActive(false) end

    -- 入场动画仅在面板当前可见时执行
    if levelPanelWasActive then
        local levelLoopGridView = self.levelEquip.loopGridView
        for i = 0, levelCount - 1 do
            local item = levelLoopGridView:GetShownItemByItemIndex(i)
            if item ~= nil then
                local trs = item.transform
                ---@type UnityEngine.CanvasGroup
                local canvasGroup = trs:GetComponent(TypeInfo.CanvasGroup)
                local rTrs = trs:Find("EquipBtn")
                rTrs.anchoredPosition = Vector2.New(0, -20)
                canvasGroup.alpha = 0
                rTrs:DOKill()
                canvasGroup:DOKill()
                rTrs:DOAnchorPosY(0, 0.2):SetDelay(i * 0.02)
                canvasGroup:DOFade(1, 0.2):SetDelay(i * 0.02)
            end
        end
    end
    self.isNull:SetActive(levelCount == 0)
end

---LoopGridView 强化备选装备回调
function EquipIntensifyPanel:OnLevelEquipItemValueChange(gridView, index, row, col)   
local loopItem = gridView:GetShownItemByItemIndex(index)
    if loopItem == nil then
        loopItem = gridView:NewListViewItem("CustomBox")
    end
    local obj = loopItem.gameObject
    EngineUtil.FillPeer(self.customBox, obj)
    local dataIndex = index + 1
    local boxData = self.equipDataList[dataIndex]
    if not boxData then return loopItem end

    local customBox = obj.customBox
    local itemData = Me:getItemById(boxData.config.id)
    local data = {
        id = boxData.config.id,
        isIn = boxData.isIn,
        delBtnState = (boxData.isIn and boxData.type == 2) and true or false,
        scale = 0.8,
        isLock = boxData.isLock,
        isInIsOne = boxData.type == 1 and true or false,
        inCountTxtState = boxData.type == 2 and true or false,
        ownerPanelName = self.uiConfig.id,
        delBtnListener = function()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            if boxData.selectCount > 0 then
                boxData.selectCount = boxData.selectCount - 1
                if boxData.selectCount == 0 then
                    boxData.isIn = false
                    self.levelList[boxData.data.id] = nil
                end
            end
            self.levelEquip.loopGridView:RefreshAllShownItem2()
            self:SetBoxState()
        end,
        listener = function()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            LuaLogger.ds("self.isMax", self.isMax)
            if not self.isMax then
                if boxData.type == EquipIntensifyTypeEnum.Equip then
                    if tablex.size(self.levelList) < self.maxLevelUpCount then
                        if boxData.isIn then
                            boxData.isIn = false
                            self.levelList[boxData.data.id] = nil
                        else
                            boxData.isIn = true
                            self.levelList[boxData.data.id] = boxData
                        end
                    else
                        if boxData.isIn then
                            boxData.isIn = false
                            self.levelList[boxData.data.id] = nil
                        end
                    end
                elseif boxData.type == EquipIntensifyTypeEnum.ExpItem then
                    if boxData.selectCount < itemData.num then
                        boxData.selectCount = boxData.selectCount + 1
                        boxData.isIn = true
                        self.levelList[boxData.data.id] = boxData
                    end
                end
            else
                if boxData.type == EquipIntensifyTypeEnum.Equip then
                    if boxData.isIn then
                        boxData.isIn = false
                        self.levelList[boxData.data.id] = nil
                    end
                end
            end
            self.levelEquip.loopGridView:RefreshAllShownItem2()
            self:SetBoxState()
            if boxData.type == EquipIntensifyTypeEnum.Equip then
                self:OpenCustomMsgPanel({
                    type = GE.CustomMsgType.Equip,
                    config = boxData.config,
                    Id = boxData.data.id,
                    navType = GE.NavigationType.EquipIntensifyPanel_LevelUp
                })
            elseif boxData.type == EquipIntensifyTypeEnum.ExpItem then
                self:OpenCustomMsgPanel({
                    type = GE.CustomMsgType.Item,
                    config = boxData.config,
                    Id = boxData.data.id,
                    navType = GE.NavigationType.EquipIntensifyPanel_LevelUp
                })
            end
        end,
        onUpListener = function()
            if self.longPressTimer then
                self.longPressTimer:Stop()
                self.longPressTimer = nil
            end
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
            if boxData.type == 2 and not self.isMax then
                self.longPressTimer = Timer.New(function()
                    if not self.isMax then
                        if boxData.selectCount < itemData.num then
                            boxData.selectCount = boxData.selectCount + 1
                            boxData.isIn = true
                            self.levelList[boxData.data.id] = boxData
                        end
                        self.levelEquip.loopGridView:RefreshAllShownItem2()
                        self:SetBoxState()
                    end
                end, 0.1, -1)
                self.longPressTimer:Start()
            end
        end,
    }
    if boxData.type == 1 then
        data.itemType = GE.ItemTypeIndex.equip
        data.star = boxData.data.star
        data.itemNum = "Lv."..boxData.data.level
    elseif boxData.type == 2 then
        data.itemType = GE.ItemTypeIndex.item
        if itemData then
            data.itemNum = itemData.num
        end
        data.inCountTxt = boxData.selectCount
    end
    data.tipsPassEventState = false
    customBox:setMono(self)
    customBox:refreshUI(data)
    return loopItem
end

---装备属性更新
function EquipIntensifyPanel:updateAttr(isLevelUp)
    --六维显示
    self.NatureData = Me:getEquipNatureDataById(self.nowEquipData.id)
    local temp = {}
    for key, value in pairs(self.NatureData) do
        table.insert(temp, value)
    end
    self.attributeBoxList = {}
    self:FillTemplateContent(self.attributeBox, self.attributeList, tablex.size(temp), function(index, attributeBox)
        self.attributeBoxList[temp[index].type] = attributeBox.attributeBox
        if isLevelUp then
            attributeBox.attributeBox:playLevelUpAnim(temp[index])
        end
        local boxData = {
            boxType = GE.ItemTypeIndex.equip,
            attrData = temp[index],
            boxIndex = index,
        }
        attributeBox.attributeBox:setMono(self)
        attributeBox.attributeBox:setAttrBoxData(boxData)
    end)
end

---消耗品列表填充
function EquipIntensifyPanel:fillSelectList(onComplete)
    local total = self.maxLevelUpCount
    local count = 0
    self:FillTemplateContent(self.customBox, self.selectList, total, function(index, itemObj)
    local customBox = itemObj.customBox
    local a = {
        index = index, customBox = customBox, data = {}
    }
    table.insert(self.levelUpSelectBoxList, a)
    local boxData = self.levelUpSelectBoxList[index]
    local customData = {
        scale = 0.65,
        nullDataPanel = true,
        ownerPanelName = self.uiConfig.id,
        listener = function()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            if boxData.data and next(boxData.data) then
                if boxData.data.type == 1 then
                    self:getLevelUpFindEquipDataListData(boxData.data.data.id).isIn = false
                    self.levelList[boxData.data.data.id] = nil
                    boxData.data = nil
                elseif boxData.data.type == 2 then
                    if boxData.data.selectCount > 0 then
                        boxData.data.selectCount = boxData.data.selectCount - 1
                        if boxData.data.selectCount == 0 then
                            boxData.data.isIn = false
                            self.levelList[boxData.data.data.id] = nil
                        end
                    end
                end
                
                self.levelEquip.loopGridView:RefreshAllShownItem2()
                self:SetBoxState()
            else
               self.levelListPanel:SetActive(true)
            end
        end
    }
    customBox:setMono(self)
    customBox:refreshUI(customData)
    count = count + 1
    if count == total and onComplete then
        onComplete()
    end
end)
end

--设置强化右侧格子显示
function EquipIntensifyPanel:SetBoxState()
    local temp = {}
    self.expValue = 0
    for key, value in pairs(self.levelList) do
        if value.type == 1 then
            self.expValue = self.expValue + value.config.expValue + value.data.exp * Config.GetConfigInfo("equipReturn")
        elseif value.type == 2 then
            self.expValue = self.expValue + value.config.effect[2] * value.selectCount
        end 
        table.insert(temp, value)
    end
    for k, v in pairs(self.levelUpSelectBoxList) do
        v.data = temp[k]
        local customData = {}
        customData.delBtnState = true
        if v.data and next(v.data) then
            customData.id = v.data.config.id
            if v.data.type == 1 then
                customData.star = v.data.data.star
                customData.itemNum = "Lv."..v.data.data.level
                customData.itemType = GE.ItemTypeIndex.equip
            elseif v.data.type == 2 then
                customData.itemNum = v.data.selectCount
                customData.itemType = GE.ItemTypeIndex.item
            end
            customData.isLock = v.data.data.isLock
            customData.nullDataPanel = false
        else
            customData.nullDataPanel = true
        end
        
        local function delBox()
            local boxData = v
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            if boxData.data and next(boxData.data) then
                if boxData.data.type == 1 then
                    self:getLevelUpFindEquipDataListData(boxData.data.data.id).isIn = false
                    self.levelList[boxData.data.data.id] = nil
                    boxData.data = nil
                elseif boxData.data.type == 2 then
                    if boxData.data.selectCount > 0 then
                        boxData.data.selectCount = boxData.data.selectCount - 1
                        if boxData.data.selectCount == 0 then
                            boxData.data.isIn = false
                            self.levelList[boxData.data.data.id] = nil
                        end
                    end
                end
                
                self.levelEquip.loopGridView:RefreshAllShownItem2()
                self:SetBoxState()
            else
               self.levelListPanel:SetActive(true)
            end
        end
        
        customData.listener = function()
            delBox()
        end
        customData.delBtnListener = function()
            delBox()
        end
        customData.ownerPanelName = self.uiConfig.id,
        v.customBox:setMono(self)
        v.customBox:refreshUI(customData)
    end
    self.payTitleTxt.text.text = "消耗材料:("..tablex.size(self.levelList).."/"..self.maxLevelUpCount..")"
    local addLevel = 0
    if self.expValue == 0 then
        self.expTxt.text.text = ""
        self.addExpTxt.text.text = ""
        self.newLevelTxt.text.text =""
        self.maxLevelBg:SetActive(false)
        self.isMax = false
        for _, value in pairs(self.attributeBoxList) do
            value.changeIcon:SetActive(false)
            value.changeValueTxt:SetActive(false)
        end
    else
        self.expTxt.text.text = self.limitEXP.."/"..self.nowMaxExp
        self.addExpTxt.text.text = "+"..self.expValue
        for _, value in pairs(self.equipLevelCfg) do
            if self.nowEquipData.exp + self.expValue < value.expTotal + value.exp then
                addLevel = value.equipLevel
                break
            end
        end
        local maxLevel = self.equipConfig.levelMax[self.nowEquipData.star]

        if addLevel > self.nowEquipData.level and addLevel < 100 then
            self.AddNatureData = Me:getEquipNatureDataByIdAndLevel(self.nowEquipData.id, addLevel - 1)
            for _, value in pairs(self.AddNatureData) do
                self.attributeBoxList[value.type].changeValueTxt.text.color = Color.NewFromStr("1B8AE6")
                self.attributeBoxList[value.type].changeValueTxt.text.text = math.ceil(value.value)
                self.attributeBoxList[value.type].changeIcon:SetActive(true)
                self.attributeBoxList[value.type].changeValueTxt:SetActive(true)
            end

            if addLevel >= maxLevel then
                self.expTxt.text.text = ""
                self.maxLevelBg:SetActive(true)
                self.isMax = true
                self.newLevelTxt.text.text = "+".. maxLevel - self.nowEquipData.level
            else
                self.maxLevelBg:SetActive(false)
                self.isMax = false
                self.newLevelTxt.text.text = "+".. addLevel - self.nowEquipData.level
            end
        else
            self.maxLevelBg:SetActive(false)
            self.isMax = false
            for _, value in pairs(self.attributeBoxList) do
                value.changeIcon:SetActive(false)
                value.changeValueTxt:SetActive(false)
            end
        end
    end
    local upExp = self.limitEXP + self.expValue

    if upExp > self.nowMaxExp then
        self.addSlider.image.fillAmount = 1
    else
        self.addSlider.image.fillAmount = upExp / self.nowMaxExp
    end
    local useResRatio = Config.GetConfigInfo("equipExpCost")
    local equipCurrency = Config.GetConfigInfo("equipCurrency")
    self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, "ItemIcon_"..equipCurrency), self.resIcon.image)
    local resCost = useResRatio * self.expValue
    local resItemData = Me:getItemById(equipCurrency)
    local resHasEnough = resCost == 0 or (resItemData and resItemData.num >= resCost)
    if resHasEnough then
        self.levelPanel.resCount.text.text = "x"..resCost
    else
        self.levelPanel.resCount.text.text = "<color=#FF3131>x"..resCost.."</color>"
    end

    -- 技能等级预览更新
    do
        local nowEffectId = Me:getEquipEffectIdByid(self.nowEquipData.id)
        local nowEffectStage = Me:getEquipEffectStageByid(self.nowEquipData.id)
        local equipSkill = self.equipConfig.skill
        local romanNumerals = {"I", "II", "III", "IV", "V"}
        local unlockStr = LocalStrEnum.ActionFailReason_EquipLevelUpTips
        if nowEffectId == nil and tablex.next(equipSkill) == nil then
            -- 无技能，不处理预览
        elseif self.expValue == 0 or addLevel <= self.nowEquipData.level then
            -- 无选择或无等级变化，恢复静态显示
            self.levelChange:SetActive(false)
            if nowEffectId == nil then
                self.isMaxLevel:SetActive(false)
                self.effectLevel.text.text = ""
                self.effectLevelMsg.text.text = string.format(unlockStr, self.equipConfig.unLockSkillLv[1])
            else
                local maxStage = #self.equipConfig.unLockSkillLv
                if nowEffectStage >= maxStage then
                    self.isMaxLevel:SetActive(true)
                    self.effectLevel.text.text = ""
                    self.effectLevelMsg.text.text = ""
                else
                    self.isMaxLevel:SetActive(false)
                    self.effectLevel.text.text = romanNumerals[nowEffectStage] .. " " .. LocalStrEnum.AffectionLevel
                    self.effectLevelMsg.text.text = ""
                end
            end
        else
            -- 有等级变化，计算预览技能阶段
            local maxStage = #self.equipConfig.unLockSkillLv
            local targetLevel = math.min(addLevel, self.equipConfig.levelMax[self.nowEquipData.star])
            local newStage = 0
            for i, unlockLv in ipairs(self.equipConfig.unLockSkillLv) do
                if targetLevel >= unlockLv then
                    newStage = i
                end
            end
            if nowEffectId ~= nil and nowEffectStage >= maxStage then
                -- 当前已最高阶，提级不改变技能
                self.isMaxLevel:SetActive(true)
                self.levelChange:SetActive(false)
                self.effectLevel.text.text = ""
                self.effectLevelMsg.text.text = ""
            elseif nowEffectId ~= nil and newStage > nowEffectStage then
                -- 技能档位提升（已有技能，档位继续提升）
                self.isMaxLevel:SetActive(false)
                self.levelChange:SetActive(true)
                self.lastLevelTxt.text.text = romanNumerals[nowEffectStage] .. " " .. LocalStrEnum.AffectionLevel
                self.newEffectLevelTxt.text.text = romanNumerals[newStage] .. " " .. LocalStrEnum.AffectionLevel
                self.effectLevel.text.text = ""
                self.effectLevelMsg.text.text = ""
            elseif nowEffectId == nil and newStage > 0 then
                -- 从未解锁提升到某个档位
                self.isMaxLevel:SetActive(false)
                self.levelChange:SetActive(true)
                self.lastLevelTxt.text.text = "未解锁"
                self.newEffectLevelTxt.text.text = romanNumerals[newStage] .. " " .. LocalStrEnum.AffectionLevel
                self.effectLevel.text.text = ""
                self.effectLevelMsg.text.text = ""
            else
                -- 档位无变化
                self.isMaxLevel:SetActive(false)
                self.levelChange:SetActive(false)
                if nowEffectId ~= nil then
                    self.effectLevel.text.text = romanNumerals[nowEffectStage] .. " " .. LocalStrEnum.AffectionLevel
                    self.effectLevelMsg.text.text = ""
                else
                    self.effectLevel.text.text = ""
                    self.effectLevelMsg.text.text = string.format(unlockStr, self.equipConfig.unLockSkillLv[1])
                end
            end
        end
    end

    if self.equipConfig.levelMax[self.nowEquipData.star] == self.nowEquipData.level then
        self.addSlider.image.fillAmount = 0
    end

    if tablex.size(self.levelList) == 0 then
        self.autoTxt.text.text = "自动选择"
        self.isAutoMode = true
    end
end

--根据装备id获取装备数据
---@param id integer    装备id
---@return EquipData
function EquipIntensifyPanel:getLevelUpFindEquipDataListData(id)
    for k,v in pairs(self.equipDataList) do
        if v.data.id == id then
            return v
        end
    end
    return {}
end

--根据装备id获取升星数据
---@param id integer    装备id
---@return EquipData
function EquipIntensifyPanel:getStarUpFindEquipDataListData(id)
    for k,v in pairs(self.starList) do
        if v.data.id == id then
            return v
        end
    end
    return {}
end

---背包中是否存在可用于突破的指定材料装备
---@param materialCid integer breakMaterial 中的装备配置 id
---@return boolean
function EquipIntensifyPanel:hasUsableStarBreakMaterial(materialCid)
    if not materialCid then
        return false
    end
    local equipList = Me:getAllEquipData()
    for _, value in pairs(equipList) do
        if value.cid == materialCid and value.level <= 1
            and value.id ~= self.nowEquipData.id
            and not Me:checkEquipLockState(value.id)
            and value.ownerId == 0 then
            return true
        end
    end
    return false
end

---按 breakMaterial 顺序决定「材料不足」提示显示的装备图标 cid
---@return integer?
function EquipIntensifyPanel:getStarInsufficientMaterialCid()
    local materials = self.equipConfig and self.equipConfig.breakMaterial
    if not materials then
        return self.nowEquipData and self.nowEquipData.cid
    end
    local count = tablex.size(materials)
    if count == 0 then
        return self.nowEquipData and self.nowEquipData.cid
    end
    for i = 1, count do
        local cid = materials[i]
        if not self:hasUsableStarBreakMaterial(cid) then
            if i < count then
                local nextCid = materials[i + 1]
                if self:hasUsableStarBreakMaterial(nextCid) then
                    return nextCid
                end
            end
            return materials[1]
        end
    end
    return materials[1]
end

---突破材料为空时，在右侧待选格显示不足提示
function EquipIntensifyPanel:RefreshStarInsufficientSelectBox()
    local existBox = self.levelStarUpSelectBoxList[1]
    if not existBox or tablex.size(self.starList) > 0 then
        return
    end
    if existBox.data and next(existBox.data) then
        return
    end
    local showCid = self:getStarInsufficientMaterialCid()
    if not showCid then
        return
    end
    local customData = {
        scale = 1,
        id = showCid,
        itemType = GE.ItemTypeIndex.equip,
        disableClick = true,
        ownerPanelName = self.uiConfig.id,
    }
    existBox.customBox:setMono(self)
    existBox.customBox:refreshUI(customData)
    existBox.customBox.starList:SetActive(false)
    existBox.customBox.equipInsufficient:SetActive(true)
end

--设置突破界面
function EquipIntensifyPanel:SetStarPanel(isUpdate)
    if not isUpdate then
        ---@type EquipData[]
        self.starList = {}
        self.equipStarObjList = {}
        self.levelStarList = {}
        self.levelStarUpSelectBoxList = {}

        --初始化待选中列表
        DLuaUtil.ClearChildren(self.selectStarList.transform)
        self:FillTemplateContent(self.customBox, self.selectStarList, 1, function(index, itemObj)
            local customBox = itemObj.customBox
            local a = {
                index = index, customBox = customBox, data = {}
            }
            local customData = {
                scale = 1,
                nullDataPanel = true,
                ownerPanelName = self.uiConfig.id,
                listener = function()
                    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
                    if self.levelStarUpSelectBoxList[index].data and next(self.levelStarUpSelectBoxList[index].data) then
                        self:getStarUpFindEquipDataListData(self.levelStarUpSelectBoxList[index].data.data.id).isIn = false
                        self.levelStarList[self.levelStarUpSelectBoxList[index].data.data.id] = nil
                        self.levelStarUpSelectBoxList[index].data = nil
                        self.starEquip.loopGridView:RefreshAllShownItem2()
                        self:SetStarBoxState()
                    else
                        self:openStarListPanel()
                    end
                end
            }
            customBox:setMono(self)
            customBox:refreshUI(customData)
            table.insert(self.levelStarUpSelectBoxList, a)
        end)

        if self.nowEquipData.star >= 6 then
            self.newStar:SetActive(true)
        else
            self.newStar:SetActive(false)
        end

        self.equipConfig = Config.GetEquipmentInfo(self.nowEquipData.cid)
        local nextStar = self.nowEquipData.star + 1
        --设置星级显示
        for i = 1, 6 do
            self.nowStar.starList["star_"..i]:SetActive(#self.equipConfig.levelMax >= i)
            if i <= self.nowEquipData.star then
                self.nowStar.starList["star_"..i].starOn:SetActive(true)
            else
                self.nowStar.starList["star_"..i].starOn:SetActive(false)
            end
        end
        if nextStar > #self.equipConfig.levelMax then
            nextStar = #self.equipConfig.levelMax
            self.nowStar.starTxt.text.text = "<color=#1b8ae6>"..self.nowEquipData.level.."</color>".."/".."<color=#1b8ae6>"..self.equipConfig.levelMax[#self.equipConfig.levelMax].."</color>"
            -- 显示满级模式
            self.newStar:SetActive(false)
            -- self.newSkillBg:SetActive(false)
            self.starPanel.selectPanel:SetActive(false)
            self.starPanel.starMax:SetActive(true)
        else
            -- local newSkillConfig = Config.GetSkillInfo(self.equipConfig.skill[nextStar])
            self.newStar:SetActive(true)
            -- self.newSkillBg:SetActive(true)
            self.starPanel.selectPanel:SetActive(true)
            self.starPanel.starMax:SetActive(false)
            -- if newSkillConfig then
            --     self.skillNewTxt.canvasGroup.alpha = 1
            --     self.skillNewTxt.text.text = newSkillConfig.desKey
            --     self.newSkillStarTxt.text.text = (self.nowEquipData.star + 1) .. "星"
            -- else
            --     self.skillNewTxt.canvasGroup.alpha = 0
            -- end
        end

        -- 根据当前星级和突破后星级的最大等级，查找技能档位并显示罗马数字+级
        do
            local romanNumerals = {"I", "II", "III", "IV", "V"}
            local equipSkill = self.equipConfig.skill
            if tablex.next(equipSkill) == nil then
                self.lastStarTxt.text.text = ""
                self.newEffectStarTxt.text.text = ""
                self.nullStarEffect:SetActive(true)
                self.hasEffectTitleTxt:SetActive(false)
                self.limitUp:SetActive(false)
            else
                self.limitUp:SetActive(true)
                self.nullStarEffect:SetActive(false)
                self.hasEffectTitleTxt:SetActive(true)
                local currentMaxLevel = self.equipConfig.levelMax[self.nowEquipData.star]
                local nextMaxLevel = self.equipConfig.levelMax[nextStar]
                local currentStage = 0
                for i, unlockLv in ipairs(self.equipConfig.unLockSkillLv) do
                    if currentMaxLevel >= unlockLv then
                        currentStage = i
                    end
                end
                local nextStage = 0
                for i, unlockLv in ipairs(self.equipConfig.unLockSkillLv) do
                    if nextMaxLevel >= unlockLv then
                        nextStage = i
                    end
                end
                self.lastStarTxt.text.text = currentStage > 0 and (romanNumerals[currentStage] .. " " .. LocalStrEnum.AffectionLevel) or "未解锁"
                self.newEffectStarTxt.text.text = nextStage > 0 and (romanNumerals[nextStage] .. " " .. LocalStrEnum.AffectionLevel) or "未解锁"
            end
        end

        self.nowStar.starTxt.text.text = self.nowEquipData.level.."/"..self.equipConfig.levelMax[self.nowEquipData.star]
        self.newStar.starTxt.text.text = self.nowEquipData.level.."/".."<color=#1b8ae6>"..self.equipConfig.levelMax[nextStar].."</color>"

        for i = 1, 6 do
            self.newStar.starList["star_"..i]:SetActive(#self.equipConfig.levelMax >= i)
            if i <= nextStar then
                self.newStar.starList["star_"..i].starOn:SetActive(true)
            else
                self.newStar.starList["star_"..i].starOn:SetActive(false)
            end
        end

        local equipList = Me:getAllEquipData()
        for key, value in pairs(equipList) do
            local configData = Config.GetEquipmentInfo(value.cid)
            for _, v in pairs(self.equipConfig.breakMaterial) do
                if v == value.cid and value.level <= 1 then
                   if value.id ~= self.nowEquipData.id and not Me:checkEquipLockState(value.id) and value.ownerId == 0 then --这里还需要把已经装备的排除掉
                        ---@type EquipData
                        local data = {
                            isIn = false,
                            data = value,
                            index = key,
                            config = configData,
                        }
                        table.insert(self.starList, data)
                    end
                end
            end
        end
    end

    self:StarSortInfo()
    self:setStarSortView()

    local starCount = tablex.size(self.starList)
    -- FillPeer 要求 obj 的层级内激活，面板 inactive 时临时激活使回调正常运行
    local starPanelWasActive = self.starListPanel.activeSelf
    if not starPanelWasActive then self.starListPanel:SetActive(true) end
    self.starEquip.loopGridView:SetListItemCount(starCount, true)
    if not starPanelWasActive then self.starListPanel:SetActive(false) end

    -- 入场动画仅在面板当前可见时执行
    if starPanelWasActive then
        local starLoopGridView = self.starEquip.loopGridView
        for i = 0, starCount - 1 do
            local item = starLoopGridView:GetShownItemByItemIndex(i)
            if item ~= nil then
                local trs = item.transform
                ---@type UnityEngine.CanvasGroup
                local canvasGroup = trs:GetComponent(TypeInfo.CanvasGroup)
                local rTrs = trs:Find("EquipBtn")
                rTrs.anchoredPosition = Vector2.New(0, -20)
                canvasGroup.alpha = 0
                rTrs:DOKill()
                canvasGroup:DOKill()
                rTrs:DOAnchorPosY(0, 0.2):SetDelay(i * 0.02)
                canvasGroup:DOFade(1, 0.2):SetDelay(i * 0.02)
            end
        end
    end
    self.starListPanel.isNull:SetActive(starCount == 0)
    if starCount == 0 then
        self:RefreshStarInsufficientSelectBox()
    end

    --设置需要材料显示
    local equipLevelCfg = Config.GetEquipLevelByBreakGroup(GE.EquipLevelType.Advanced, self.equipConfig.breakGroup, self.nowEquipData.star + 1)
    if equipLevelCfg then
        self:FillTemplateContent(self.customBox, self.itemList, tablex.size(equipLevelCfg.breakCurrency), function(index, itemObj)
            local customBox = itemObj.customBox
            local itemCount = 0
            local itemId = equipLevelCfg.breakCurrency[index][1]
            local itemData = Me:getItemById(itemId)
            if itemData then
                itemCount = itemData.num
            end
            local data = {
                id = itemId,
                scale = 0.65,
                itemType = GE.ItemTypeIndex.item,
                itemNum = itemCount.."/"..equipLevelCfg.breakCurrency[index][2],
				navType = GE.NavigationType.EquipIntensifyPanel_StarUp,
                ownerPanelName = self.uiConfig.id,
            }
            customBox:setMono(self)
            customBox:refreshUI(data)
        end)
        local starGoldCost = equipLevelCfg.breakGoldCost
        local starEquipCurrency = Config.GetConfigInfo("equipCurrency")
        local starResItemData = Me:getItemById(starEquipCurrency)
        local starResEnough = starResItemData and starResItemData.num >= starGoldCost
        if starResEnough then
            self.starPanel.resCount.text.text = "x"..starGoldCost
        else
            self.starPanel.resCount.text.text = "<color=#FF3131>x"..starGoldCost.."</color>"
        end
    end

    local equipCurrency = Config.GetConfigInfo("equipCurrency")
    self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, "ItemIcon_"..equipCurrency), self.starPanel.resIcon.image)
end

---LoopGridView 突破备选装备回调
function EquipIntensifyPanel:OnStarEquipItemValueChange(gridView, index, row, col)
    local loopItem = gridView:GetShownItemByItemIndex(index)
    if loopItem == nil then
        loopItem = gridView:NewListViewItem("CustomBox")
    end
    local obj = loopItem.gameObject
    EngineUtil.FillPeer(self.customBox, obj)
    local dataIndex = index + 1
    local starData = self.starList[dataIndex]
    if not starData then return loopItem end

    local customBox = obj.customBox
    local customData = {
        id = starData.data.cid,
        itemType = GE.ItemTypeIndex.equip,
        scale = 0.8,
        isInIsOne = true,
        isIn = starData.isIn,
        star = starData.data.star,
        itemNum = "Lv."..starData.data.level,
        isLock = starData.isLock,
        ownerPanelName = self.uiConfig.id,
        listener = function()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            if tablex.size(self.levelStarList) == 1 then
                if starData.isIn then
                    starData.isIn = false
                    self.levelStarList[starData.data.id] = nil
                end
            else
                if starData.isIn then
                    starData.isIn = false
                    self.levelStarList[starData.data.id] = nil
                else
                    starData.isIn = true
                    self.levelStarList[starData.data.id] = starData
                end
            end
            self.starEquip.loopGridView:RefreshAllShownItem2()
            self:SetStarBoxState()
        end
    }
    customBox:setMono(self)
    customBox:refreshUI(customData)
    return loopItem
end

--设置突破右侧格子显示
function EquipIntensifyPanel:SetStarBoxState()
    local temp = {}
    for key, value in pairs(self.levelStarList) do
        table.insert(temp, value)
    end

    for k,v in pairs(self.levelStarUpSelectBoxList) do
        v.data = temp[k]
        local customData ={
            scale = 1,
            ownerPanelName = self.uiConfig.id,
        }
        if v.data and next(v.data) then
            customData.id = v.data.data.cid
            customData.star = v.data.data.star
            customData.itemType = GE.ItemTypeIndex.equip
            customData.itemNum = "Lv."..v.data.data.level
            customData.isLock = v.data.data.isLock
            v.customBox.equipInsufficient:SetActive(false)
        else
            customData.nullDataPanel = true
            v.customBox.equipInsufficient:SetActive(false)
        end
        customData.listener = function()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            if v.data and next(v.data) then
                self:getStarUpFindEquipDataListData(v.data.data.id).isIn = false
                self.levelStarList[v.data.data.id] = nil
                v.data = nil
                self.starEquip.loopGridView:RefreshAllShownItem2()
                self:SetStarBoxState()
            else
                self:openStarListPanel()
            end
        end
        v.customBox:setMono(self)
        v.customBox:refreshUI(customData)
    end
    if tablex.size(self.starList) == 0 and tablex.size(self.levelStarList) == 0 then
        self:RefreshStarInsufficientSelectBox()
    end
end

--打开突破侧边栏，材料为空时在已有格子上显示不足提示
function EquipIntensifyPanel:openStarListPanel()
    self.starListPanel:SetActive(true)
    if tablex.size(self.starList) == 0 then
        self:RefreshStarInsufficientSelectBox()
    end
end

--清空待强化列表
function EquipIntensifyPanel:emptyLevelList()
    self.levelList = {}
    -- 重置所有狗粮的选择状态
    for _, value in pairs(self.equipDataList) do
        if value.type == EquipIntensifyTypeEnum.ExpItem then
            value.isIn = false
            value.selectCount = 0
        elseif value.type == EquipIntensifyTypeEnum.Equip then
            value.isIn = false
        end
    end
    -- 清零额外经验进度条，避免残留显示
    self.addSlider.image.fillAmount = 0
    self:SetBoxState()
end

--清空待突破列表
function EquipIntensifyPanel:emptyStarList()
    self.levelStarList = {}
    -- 重置所有突破装备的选择状态
    for _, value in pairs(self.starList) do
        value.isIn = false
    end
    self:SetStarBoxState()
end

--刷新排序显示
function EquipIntensifyPanel:refreshSortView()
    if self.nowMode == 1 then  --升级用
        for k, v in pairs(self.equipSortBtnlist) do
            v.obj.isOpen:SetActive(self.nowEquipSortIndex == v.key)
        end
    elseif self.nowMode == 2 then  --突破用
        for k,v in pairs(self.starSortBtnlist) do
            v.obj.isOpen:SetActive(self.nowStarSortIndex == v.key)
        end
    end
end

-------------------------------排序-----------------------------------------
--装备排序初始化
function EquipIntensifyPanel:EquipSortInfo()
    self.levelListPanel.sortTxt.text.text = LocalStrEnum["equipFilterType"..GE.EquipSortType[GE.EquipSortTypeName[self.nowEquipSortIndex]]]
    self.sortStateBtn.upImg:SetActive(self.nowEquipSortFace == 2)
    self.sortStateBtn.downImg:SetActive(self.nowEquipSortFace == 1)
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
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            self.nowEquipSortIndex = index
            self.levelListPanel.sortTxt.text.text = LocalStrEnum["equipFilterType"..GE.EquipSortType[GE.EquipSortTypeName[self.nowEquipSortIndex]]]
            self.sortSelectList:SetActive(false)
            self.sortMask:SetActive(false)
            self:SetLevelPanel(true)
            --self:Refresh()
            self:refreshSortView()
        end)
    end)
end

--设置装备排序详情
function EquipIntensifyPanel:setEquipSortView()
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
                local a_config = Config.GetEquipmentInfo(a.data.cid)
                local b_config = Config.GetEquipmentInfo(b.data.cid)
                if a_config ~= nil and b_config ~= nil then
                    return a_config.id < b_config.id
                end
            end
        end
    end

    local function getPrimarySecondary()
        if self.nowEquipSortIndex == GE.EquipSortType.default or self.nowEquipSortIndex == GE.EquipSortType.level then
            return function(a, b) return a.data.level > b.data.level end,
                   function(a, b) return Config.GetEquipmentInfo(a.data.cid).quality > Config.GetEquipmentInfo(b.data.cid).quality end
        elseif self.nowEquipSortIndex == GE.EquipSortType.quality then
            return function(a, b) return Config.GetEquipmentInfo(a.data.cid).quality > Config.GetEquipmentInfo(b.data.cid).quality end,
                   function(a, b) return a.data.level > b.data.level end
        end
    end

    local primary, secondary = getPrimarySecondary()
    local ascending = self.nowEquipSortFace == 1

    table.sort(self.equipDataList, function(a, b)
        return compare(a, b, primary, secondary, ascending)
    end)
end

--装备突破排序初始化
function EquipIntensifyPanel:StarSortInfo()
    self.starListPanel.sortTxt.text.text = LocalStrEnum["equipFilterType"..GE.EquipSortType[GE.EquipSortTypeName[self.nowStarSortIndex]]]
    self.starSortBtnlist = {}
    self:FillTemplateContent(self.sortTypeBtn, self.starSortSelectList, tablex.size(GE.EquipSortTypeName), function(index, sortTypeBtn)
        local temp = {
            obj = sortTypeBtn,
            key = index,
        }
        table.insert(self.starSortBtnlist, temp)
        sortTypeBtn.sortTypeTxtOff.text.text =  LocalStrEnum["equipFilterType"..GE.EquipSortType[GE.EquipSortTypeName[index]]]
        sortTypeBtn.sortTypeTxt.text.text =  LocalStrEnum["equipFilterType"..GE.EquipSortType[GE.EquipSortTypeName[index]]]
        sortTypeBtn.isEx:SetActive(GE.EquipSortType[GE.EquipSortTypeName[index]] == GE.EquipSortType.nature)
        sortTypeBtn.scaleButton.onClick:RemoveAllListeners()
        sortTypeBtn.scaleButton.onClick:AddListener(function()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            self.nowStarSortIndex = index
            self.starListPanel.sortTxt.text.text = LocalStrEnum["equipFilterType"..GE.EquipSortType[GE.EquipSortTypeName[self.nowStarSortIndex]]]
            self.starSortSelectList:SetActive(false)
            self.sortMask:SetActive(false)
            self:SetStarPanel(true)
            --self:Refresh()
            self:refreshSortView()
        end)
    end)
end

--设置装备排序详情
function EquipIntensifyPanel:setStarSortView()
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
                local a_config = Config.GetEquipmentInfo(a.data.cid)
                local b_config = Config.GetEquipmentInfo(b.data.cid)
                if a_config ~= nil and b_config ~= nil then
                    return a_config.id < b_config.id
                end
            end
        end
    end

    local function getPrimarySecondary()
        if self.nowEquipSortIndex == GE.EquipSortType.default or self.nowEquipSortIndex == GE.EquipSortType.level then
            return function(a, b) return a.data.level > b.data.level end,
                   function(a, b) return Config.GetEquipmentInfo(a.data.cid).quality > Config.GetEquipmentInfo(b.data.cid).quality end
        elseif self.nowEquipSortIndex == GE.EquipSortType.quality then
            return function(a, b) return Config.GetEquipmentInfo(a.data.cid).quality > Config.GetEquipmentInfo(b.data.cid).quality end,
                   function(a, b) return a.data.level > b.data.level end
        end
    end

    local primary, secondary = getPrimarySecondary()
    local ascending = self.nowStarSortFace == 1

    table.sort(self.starList, function(a, b)
        return compare(a, b, primary, secondary, ascending)
    end)
end
-----------------------------------------------------------------------------

---@param data CustomMsgData
function EquipIntensifyPanel:OpenCustomMsgPanel(data)
    self.customMsgPanel:SetActive(true)
    self.customMsgPanel.customMsgPanel:setMono(self)
    self.customMsgPanel.customMsgPanel:SetView(data)
end

--自动选择按钮点击事件
function EquipIntensifyPanel:__autoBtnOnClick()
    if self.nowEquipData.level == self.nowMaxData.equipLevel then
        UICommonUtils.PopToast("等级已满")
        return
    end

    --清空列表
    if not self.isAutoMode then
        for _,v in pairs(self.levelList) do
            v.isIn = false
            if v.type == EquipIntensifyTypeEnum.ExpItem then
                v.selectCount = 0
            end
        end
        self.levelList = {}
        self.levelEquip.loopGridView:RefreshAllShownItem2()
        self:SetBoxState()
        self.autoTxt.text.text = "自动选择"
        self.isAutoMode = true
        return
    end

    self.levelListPanel:SetActive(true)
    local needExp = self.nowMaxData.expTotal - self.nowEquipData.exp - self.expValue

    --处理狗粮
    table.sort(self.expItemList, function(a, b)
        return a.config.effect[2] > b.config.effect[2]
    end)

    local temp = {}
    for _, value in pairs(self.expItemList) do
        if needExp > 0 then
            temp[value.config.id] = math.floor(needExp / value.config.effect[2])
            --如果狗粮数量大于所需数量
            if temp[value.config.id] > value.data.num - value.selectCount then
                --设置为最大数量
                temp[value.config.id] = value.data.num - value.selectCount
            end

            --计算剩余需要多少经验
            if temp[value.config.id] > 0 then
                needExp = needExp - temp[value.config.id] * value.config.effect[2]
            else
                temp[value.config.id] = nil
            end
        end
    end

    -- 如果needExp还有剩余，倒序查找消耗最小的道具
    if needExp > 0 then
        for i = #self.expItemList, 1, -1 do
            local value = self.expItemList[i]
            if needExp > 0 and (not temp[value.config.id] or temp[value.config.id] < value.data.num - value.selectCount) then
                local additionalCount = math.min(math.ceil(needExp / value.config.effect[2]), value.data.num - value.selectCount - (temp[value.config.id] or 0))
                if additionalCount > 0 then
                    temp[value.config.id] = (temp[value.config.id] or 0) + additionalCount
                    needExp = needExp - additionalCount * value.config.effect[2]
                end
            end
        end
    end

    --计算剩余需要多少装备
    local selectList = {}
    local vacancy = self.maxLevelUpCount - tablex.size(temp) - tablex.size(self.levelList)
    local exp = 0
    --狗粮加入正式选中
    for _, value in pairs(self.equipDataList) do
        if value.type == EquipIntensifyTypeEnum.ExpItem then
            for id, count in pairs(temp) do
                if value.data.id == id then
                    value.isIn = true
                    value.selectCount = count
                    self.levelList[value.data.id] = value
                end
            end
        end
    end

    -- 倒序遍历装备，从品质最低的装备开始查找
    for i = tablex.size(self.equipDataList), 1, -1 do
        local equipData = self.equipDataList[i]
        if equipData.type == EquipIntensifyTypeEnum.Equip then
            if vacancy > 0 and needExp > 0 then
                for i = 1, 3 do
                    if equipData.config.quality == i then
                        exp = equipData.config.expValue + equipData.data.exp * Config.GetConfigInfo("equipReturn")
                        needExp = needExp - exp
                        vacancy = vacancy - 1
                        equipData.isIn = true
                        self.levelList[equipData.data.id] = equipData
                        table.insert(selectList, equipData)
                    end
                end
            end
        end
    end
    
    self.levelEquip.loopGridView:RefreshAllShownItem2()
    self:SetBoxState()
    self.isAutoMode = false
    self.autoTxt.text.text = "全部清除"
end

--根据装备id清除选中数据
---@param equipId integer   装备id
function EquipIntensifyPanel:ClearSelectDataById(equipId)
    self:getLevelUpFindEquipDataListData(equipId).isIn = false
    self.levelList[equipId] = nil
    for _, value in pairs(self.levelUpSelectBoxList) do
        if value.id == equipId then
            value.data = nil
            value.customBox:setMono(self)
            value.customBox:refreshUI({nullDataPanel = true})
        end
    end
    self.levelEquip.loopGridView:RefreshAllShownItem2()
    self:SetBoxState()
    self:SetLevelPanel(true)
end

function EquipIntensifyPanel:OnClose(initiative)
    UIMgr.uiCamera.orthographic = false
end

--function EquipIntensifyPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function EquipIntensifyPanel:OnRefresh(data)
--
--end

--[[
/ToggleList/LevelBtn onClick 
--]]
function EquipIntensifyPanel:levelBtn_ScaleButton_onClick(levelBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:SetToggle(1)
end

--[[
/ToggleList/StarBtn onClick 
--]]
function EquipIntensifyPanel:starBtn_ScaleButton_onClick(starBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:SetToggle(2)
    self.levelUpMask:SetActive(false)
end

--[[
/ToggleList/DelBtn onClick 
--]]
function EquipIntensifyPanel:delBtn_ScaleButton_onClick(delBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    UIMgr:popUI("EquipDelPanel", {}) 
end

--[[
/LevelPanel/AutoBtn onClick 
--]]
function EquipIntensifyPanel:autoBtn_ScaleButton_onClick(autoBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:__autoBtnOnClick()
end

--[[
/LevelPanel/LevelOkBtn onClick 
--]]
function EquipIntensifyPanel:levelOkBtn_ScaleButton_onClick(levelOkBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.equipConfig.levelMax[self.nowEquipData.star] == self.nowEquipData.level then
        UICommonUtils.PopToast("请先突破后再升级")
        return
    end
    local temp = {}
    for key, value in pairs(self.levelList) do
        local data
        if value.type == 1 then
            data = {
                id = value.data.id,
                type = GE.RewardType.Equipment,
                num = 1,
            }
        else
            data = {
                id = value.data.id,
                type = GE.RewardType.ItemProp,
                num = value.selectCount,
            }
        end
        table.insert(temp, data)
    end

    if not next(self.levelList) then
        UICommonUtils.PopToast("请选择强化所需的舰装")
        return
    end
    self.levelListPanel:SetActive(false)
    self.customMsgPanel:SetActive(false)
    local preEffectStage = Me:getEquipEffectStageByid(self.nowEquipData.id)
    Me:addEquipExpReq({id = self.nowEquipData.id, useList = temp}, function()
       -- UICommonUtils.PopToast("强化成功")
        -- 先清空选择列表
        self.levelList = {}
        self.autoTxt.text.text = "自动选择"
        self.isAutoMode = true
        -- 再刷新装备数据列表，确保使用最新的道具数量，且清除选中状态
        self:SetLevelPanel(true)
        -- 强制刷新列表显示的项目
        self.levelEquip.loopGridView:RefreshAllShownItem2()
        -- 确保侧边栏保持关闭状态
        self.levelListPanel:SetActive(false)
        self.customMsgPanel:SetActive(false)

        local newEffectStage = Me:getEquipEffectStageByid(self.nowEquipData.id)
        local Raycaster = self.transform:GetComponent(TypeInfo.GraphicRaycaster)
        if newEffectStage then
            Raycaster.enabled = false
        end
        self:showLevelUp(function()
            if newEffectStage and newEffectStage ~= preEffectStage then
                local newEffectId = Me:getEquipEffectIdByid(self.nowEquipData.id)
                local skillConfig = Config.GetSkillInfo(newEffectId)
                local data = {
                    rank = newEffectStage,
                    effectDesc = skillConfig and skillConfig.desKey or "",
                }
                UIMgr:popUICover("EquipLevelPanel", data)
            end
            Raycaster.enabled = true
        end)
        GameMsgMgr:sendEvent(GameMsgType.HeroNatureChange)
        local btnSoundPath = string.format(Config.AudioPath.SE, "strengthen")
        self:play2DSound(btnSoundPath)
	end)
end

function EquipIntensifyPanel:showLevelUp(callback)
    local preData = self.nowEquipData
    local newData = Me:getEquipDataByid(self.nowEquipData.id)
    self:progressAni(preData, newData, callback)
end

function EquipIntensifyPanel:progressAni(preData, newData, callback)
    self.addSlider.image.fillAmount = 0
    self.addExpTxt.text.text = ""
    self.newLevelTxt.text.text = ""
    self.maxLevelBg:SetActive(false)
    self.expTxt:SetActive(true)
    local totalDuration = 0.6       --速度
    local totalWork = self:calcSliderAniTotalWork(preData, newData)
    if totalWork <= 0 then
        self.levelUpMask:SetActive(false)
        self.nowEquipData = Me:getEquipDataByid(self.nowEquipData.id)
        -- 先更新面板数据（包括limitEXP和nowMaxExp），再清空列表避免计算错误
        self:SetLevelPanel(nil, true)
        self:emptyLevelList()
        if callback then
            callback()
        end
        return
    end
    self:showSlider(preData, newData, totalWork, totalDuration, function()
        self.levelUpMask:SetActive(false)
        self.nowEquipData = Me:getEquipDataByid(self.nowEquipData.id)
        -- 先更新面板数据（包括limitEXP和nowMaxExp），再清空列表避免计算错误
        self:SetLevelPanel(nil, true)
        self:emptyLevelList()
        if callback then
            callback()
        end
    end)
end

function EquipIntensifyPanel:calcSliderAniTotalWork(preData, newData)
    if not preData or not newData or newData.level < preData.level then
        return 0
    end

    local totalWork = 0
    local level = preData.level
    local exp = preData.exp

    while level < newData.level do
        local lvData = Config.GetEquipLevelByGroupAndLevel(GE.EquipLevelType.Normal, self.equipConfig.levelGroup, level)
        if not lvData then
            break
        end
        local curExp = exp - lvData.expTotal
        totalWork = totalWork + math.max(lvData.exp - curExp, 0)
        exp = lvData.expTotal + lvData.exp
        level = level + 1
    end

    local finalLvData = Config.GetEquipLevelByGroupAndLevel(GE.EquipLevelType.Normal, self.equipConfig.levelGroup, level)
    if finalLvData then
        local curExp = exp - finalLvData.expTotal
        local targetExp = newData.exp - finalLvData.expTotal
        totalWork = totalWork + math.max(targetExp - curExp, 0)
    end

    return totalWork
end

function EquipIntensifyPanel:showSlider(preData, newData, remainWork, remainTime, callback)
    local maxLevel = self.equipConfig.levelMax[self.nowEquipData.star]
    local curShowLvData = Config.GetEquipLevelByGroupAndLevel(GE.EquipLevelType.Normal, self.equipConfig.levelGroup, preData.level)
    if not curShowLvData then
        callback()
        return
    end
    local curShowExp = preData.exp - curShowLvData.expTotal
    self.levelTxt.text.text = "+"..preData.level

    if preData.level ~= newData.level then
        local segmentWork = math.max(curShowLvData.exp - curShowExp, 0)
        local dt = math.max(remainTime * (segmentWork / math.max(remainWork, 1)), 0.01)
        self:nowSliderAni(curShowExp, curShowLvData.exp, curShowLvData.exp, dt, function()
            if newData.level == maxLevel and preData.level == newData.level - 1 then
                self.levelTxt.text.text = "+"..newData.level
                self.maxLevelBg:SetActive(true)
                self.expTxt:SetActive(false)
                callback()
            else
                local temp = {
                    exp = curShowLvData.expTotal + curShowLvData.exp,
                    level = preData.level + 1,
                }
                local nextWork = math.max(remainWork - segmentWork, 0)
                local nextTime = math.max(remainTime - dt, 0.01)
                self:showSlider(temp, newData, nextWork, nextTime, callback)
            end
        end)
    else
        local newShowExp = newData.exp - curShowLvData.expTotal
        local segmentWork = math.max(newShowExp - curShowExp, 0)
        local dt = math.max(remainTime * (segmentWork / math.max(remainWork, 1)), 0.01)
        self:nowSliderAni(curShowExp, newShowExp, curShowLvData.exp, dt, function()
            callback()
        end)
    end
end

--进度条动画
function EquipIntensifyPanel:nowSliderAni(pre, new, max, dt, callback)
    self.levelUpMask:SetActive(true)
    DG.Tweening.DOVirtual.Float(pre, new, dt, function(v)
        self.nowSlider.image.fillAmount = v / max
        self.expTxt.text.text = math.floor(v).."/"..max
    end):SetEase(DG.Tweening.Ease.OutCubic):OnComplete(function()
        callback()
    end)
end

--[[
/StarPanel/StarOkBtn onClick 
--]]
function EquipIntensifyPanel:starOkBtn_ScaleButton_onClick(starOkBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.starListPanel:SetActive(false)
    if self.equipConfig.levelMax[self.nowEquipData.star] ~= self.nowEquipData.level then
        UICommonUtils.PopToast("舰装等级未达到上限")
        return
    end

    if not next(self.levelStarList) then
        UICommonUtils.PopToast(LocalStrEnum["ActionFailReason_WeaponBreakItemNotEnough"])
        return
    end

    local temp = {}
    for key, value in pairs(self.levelStarList) do
        table.insert(temp, value.data.id)
    end
    local preStar = self.nowEquipData.star
    Me:addEquipStarReq({id = self.nowEquipData.id, idList = temp}, function()
        --UICommonUtils.PopToast("突破成功")
        self.levelStarList = {}
        self.nowEquipData = Me:getEquipDataByid(self.nowEquipData.id)
        local newStar = self.nowEquipData.star
        local preMaxLevel = self.equipConfig.levelMax[preStar]
        local newMaxLevel = self.equipConfig.levelMax[newStar]
        local preStage = 0
        local newStage = 0
        for i, unlockLv in ipairs(self.equipConfig.unLockSkillLv) do
            if preMaxLevel >= unlockLv then preStage = i end
            if newMaxLevel >= unlockLv then newStage = i end
        end
        local starPanelData = {
            lastStar       = preStar,
            newStar        = newStar,
            lastLevelLimit = preMaxLevel,
            newLevelLimit  = newMaxLevel,
            LastRankLimit  = preStage,
            newRankLimit   = newStage,
            equipCid       = self.nowEquipData.cid,
            equipStar      = newStar,
            equipLevel     = self.nowEquipData.level,
            equipIsLock    = self.nowEquipData.isLock,
        }
        UIMgr:popUICover("EquipStarPanel", starPanelData)
        self:emptyStarList()
        self:SetStarBoxState()
        -- 重建突破材料列表数据
        self:SetStarPanel()
        -- 重建强化材料列表数据
        self:SetLevelPanel(true)
        -- 强制刷新两个列表的显示
        self.starEquip.loopGridView:RefreshAllShownItem2()
        self.levelEquip.loopGridView:RefreshAllShownItem2()
        -- 确保侧边栏保持关闭状态
        self.starListPanel:SetActive(false)
        self.levelListPanel:SetActive(false)
        self.customMsgPanel:SetActive(false)
        local btnSoundPath = string.format(Config.AudioPath.SE, "strengthen")
        self:play2DSound(btnSoundPath)
        GameMsgMgr:sendEvent(GameMsgType.HeroNatureChange)
	end)

end

--[[
/Test/Content/EquipBox/EquipBtn onClick 
--]]
function EquipIntensifyPanel:equipBtn_ScaleButton_onClick(equipBtn)

end

--[[
/BackPanel/HelpBtn onClick 
--]]
function EquipIntensifyPanel:helpBtn_ScaleButton_onClick(helpBtn)

end

--[[
/LevelList/OrderBtn onClick 
--]]
function EquipIntensifyPanel:orderBtn_ScaleButton_onClick(orderBtn)

end

--[[
/ResBg/AddBtn onClick 
--]]
function EquipIntensifyPanel:addBtn_ScaleButton_onClick(addBtn)

end

--[[
/LevelPanel/DataPanel/ExpSlider onValueChanged 
--]]
function EquipIntensifyPanel:expSlider_Slider_onValueChanged(expSlider,value)

end

--[[
/LevelList/ExitMask onClick 
--]]
function EquipIntensifyPanel:exitMask_Button_onClick(exitMask)
    self.levelListPanel:SetActive(false)
    self.customMsgPanel:SetActive(false)
end

--[[
/StarListPanel/StarExitMask onClick 
--]]
function EquipIntensifyPanel:starExitMask_Button_onClick(starExitMask)
    self.starListPanel:SetActive(false)
    self.customMsgPanel:SetActive(false)
    local existBox = self.levelStarUpSelectBoxList[1]
    if existBox and tablex.size(self.starList) == 0 then
        existBox.customBox.equipInsufficient:SetActive(false)
        existBox.customBox:setMono(self)
        existBox.customBox:refreshUI({
            scale = 1,
            nullDataPanel = true,
            ownerPanelName = self.uiConfig.id,
            listener = function()
                UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
                self:openStarListPanel()
            end,
        })
    end
end

--[[
/StarListPanel/DelStarBtn onClick 
--]]
function EquipIntensifyPanel:delStarBtn_ScaleButton_onClick(delStarBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    UIMgr:popUI("EquipDelPanel", {})
end

--[[
/DelPanel/SortBtn onClick 
--]]
function EquipIntensifyPanel:sortBtn_ScaleButton_onClick(sortBtn)
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
function EquipIntensifyPanel:sortStateBtn_ScaleButton_onClick(sortStateBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.nowEquipSortFace == 1 then
        self.nowEquipSortFace = 2
    elseif self.nowEquipSortFace == 2 then
        self.nowEquipSortFace = 1
    end
    self.sortStateBtn.upImg:SetActive(self.nowEquipSortFace == 2)
    self.sortStateBtn.downImg:SetActive(self.nowEquipSortFace == 1)
    self:SetLevelPanel(true)    
    self.sortSelectList:SetActive(false)
    self.sortMask:SetActive(false)
end

--[[
/LevelListPanel/SortPanel/SortMask onClick 
--]]
function EquipIntensifyPanel:sortMask_Button_onClick(sortMask)
    self.sortSelectList:SetActive(false)
    self.sortMask:SetActive(false)
end

--[[
/StarListPanel/SortPanel/SortBg/StarSortBtn onClick 
--]]
function EquipIntensifyPanel:starSortBtn_ScaleButton_onClick(starSortBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.starSortSelectList:SetActive(not self.starSortSelectList.activeSelf)
    self.starSortMask:SetActive(self.starSortSelectList.activeSelf)
    if self.starSortSelectList.activeSelf then
        self:refreshSortView()
    end
end

--[[
/StarListPanel/SortPanel/SortBg/StarSortStateBtn onClick 
--]]
function EquipIntensifyPanel:starSortStateBtn_ScaleButton_onClick(starSortStateBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.nowStarSortFace == 1 then
        self.nowStarSortFace = 2
    elseif self.nowStarSortFace == 2 then
        self.nowStarSortFace = 1
    end
    self.starSortStateBtn.upImg:SetActive(self.nowStarSortFace == 2)
    self.starSortStateBtn.downImg:SetActive(self.nowStarSortFace == 1)
    self:SetStarPanel(true)    
    self.starSortSelectList:SetActive(false)
    self.starSortMask:SetActive(false)
end

--[[
/StarListPanel/SortPanel/StarSortMask onClick 
--]]
function EquipIntensifyPanel:starSortMask_Button_onClick(starSortMask)
    self.starSortSelectList:SetActive(false)
    self.starSortMask:SetActive(false)
end

--[[
/AdjustRoot/LevelListPanel onClick 
--]]
function EquipIntensifyPanel:levelListPanel_Button_onClick(levelListPanel)

end

--[[
/AdjustRoot/StarListPanel onClick 
--]]
function EquipIntensifyPanel:starListPanel_Button_onClick(starListPanel)

end

return EquipIntensifyPanel
