---@class EquipHandbookPanel : EquipHandbookPanel_Generate
---##################### 【EquipHandbookPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【EquipHandbookPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local EquipHandbookPanel = require "EquipHandbookPanel_Generate"

---@type FiltrateGroupData[]
local equipFiltrateCfg = {
    {
        tagName = LocalStrEnum.EquipHandFiltrate_1,
        selectType = FiltrateSelectType.AllMultiSelect,
        items = {
            {itemName = LocalStrEnum.skinTag_0, isDefault = true},
            {itemName = LocalStrEnum.equipType_1, val = 1},
            {itemName = LocalStrEnum.equipType_2, val = 2},
            {itemName = LocalStrEnum.equipType_3, val = 3},
            {itemName = LocalStrEnum.equipType_4, val = 4},
            {itemName = LocalStrEnum.equipType_5, val = 5},
            {itemName = LocalStrEnum.equipType_21, val = 21},
            {itemName = LocalStrEnum.equipType_31, val = 31},
            {itemName = LocalStrEnum.equipType_41, val = 41},
            {itemName = LocalStrEnum.equipType_42, val = 42},
            {itemName = LocalStrEnum.equipType_43, val = 43},
            {itemName = LocalStrEnum.equipType_44, val = 44},
        },
    },
    {
        tagName = LocalStrEnum.EquipHandFiltrate_2,
        selectType = FiltrateSelectType.AllMultiSelect,
        items = {
            {itemName = LocalStrEnum.skinTag_0, isDefault = true},
            {itemName = LocalStrEnum.quality_2, val = 2},
            {itemName = LocalStrEnum.quality_3, val = 3},
            {itemName = LocalStrEnum.quality_4, val = 4},
            {itemName = LocalStrEnum.quality_5, val = 5},
        },
    },
    {
        tagName = LocalStrEnum.EquipHandFiltrate_3,
        selectType = FiltrateSelectType.AllMultiSelect,
        items = {
            {itemName = LocalStrEnum.skinTag_0, isDefault = true},
            {itemName = LocalStrEnum.natureType_hp, val = GE.NatureType.hp},
            {itemName = LocalStrEnum.natureType_bombard, val = GE.NatureType.bombard},
            {itemName = LocalStrEnum.natureType_torpedo, val = GE.NatureType.torpedo},
            {itemName = LocalStrEnum.natureType_armor, val = GE.NatureType.armor},
            {itemName = LocalStrEnum.natureType_evade, val = GE.NatureType.evade},
            {itemName = LocalStrEnum.natureType_airdefense, val = GE.NatureType.airdefense},
            {itemName = LocalStrEnum.natureType_lucky, val = GE.NatureType.lucky},
        },
    },
    {
        tagName = LocalStrEnum.EquipHandFiltrate_4,
        selectType = FiltrateSelectType.AllMultiSelect,
        items = {
            {itemName = LocalStrEnum.skinTag_0, isDefault = true},
            {itemName = LocalStrEnum.ownState_1, val = 1},
            {itemName = LocalStrEnum.ownState_2, val = 2},
        },
    },
}

function EquipHandbookPanel:InitLogic(data)
    self.selectedIndex = nil  -- 初始化选中索引为1

    ---@type EquipmentTable
    self.nowSelectConfigData = {}   -- 当前选中图鉴配置数据

    ---@type HandbookData
    self.nowSelectHandBookData = {}     -- 当前选中图鉴数据

    self.maxMode = false  -- 是否满级模式
    
    self.nowEquipSortIndex = 1      -- 当前装备排序
    self.equipSortBtnlist = {}
    self.nowEquipSortFace = 1

    self.allEquipListData = {}  -- 所有装备列表（未筛选）

    ---@type FiltrateData
    self.filterData = {
        groups = equipFiltrateCfg,
        callback = BindCallback_NoParams(self, self.OnFiltrateSelectCallBack)
    }

    -- 初始化筛选状态
    for i = 1, #self.filterData.groups do
        local group = self.filterData.groups[i]
        for j = 1, #group.items do
            group.items[j].isSelect = group.items[j].isDefault
        end
    end
    self.equipList.loopGridView:InitGridView(0, BindCallback_NoParams(self, self.OnEquipItemValueChange))
end

--function EquipHandbookPanel:StartCreating(time)
--
--end

--function EquipHandbookPanel:StartEnter(time)
--
--end

--function EquipHandbookPanel:StartRemoving(time)
--
--end

--function EquipHandbookPanel:StartExit(time)
--
--end

function EquipHandbookPanel:OnOpen(data, initiative)
    -- 初始化选中索引
    self.selectedIndex = nil
    self:setView()
    -- 只有当有装备时才选中第一个
    if tablex.size(self.equipListData) > 0 then
        self:selectBox(1)
    end
end

function EquipHandbookPanel:setView()
    self.customBackPanel.customBackPanel:Bind(GE.NavigationType.HandbooksEquip, self)
    self.customBackPanel.customBackPanel:OverrideBackFunc(function()
        self.animator.enabled = true
        self.animator:SetTrigger("Out")
        self.animOverCallBack:SetCallBack(function()
            UIMgr:closeSpecificUI(self)
            self.customBackPanel.customBackPanel:ClearBackFunc()
        end)
    end)
    -- 只在第一次加载所有装备配置
    if tablex.size(self.allEquipListData) == 0 then
        local allEquipConfigs = Config.GetAllConfig("EquipmentTable")
        for _, value in pairs(allEquipConfigs) do
            if value.isOpen == 1 and value.equipType ~= GE.EquipType.rankUp then
                table.insert(self.allEquipListData, value)
            end 
        end
    end

    -- 应用筛选
    self.equipListData = self:FiltrateEquips()

    self:EquipSortInfo()
    self:setEquipSortView()

    -- 验证selectedIndex是否仍然有效，如果超出范围则重置为nil
    local listSize = tablex.size(self.equipListData)
    if self.selectedIndex ~= nil and (self.selectedIndex < 1 or self.selectedIndex > listSize) then
        self.selectedIndex = nil
    end

    self.equipList.loopGridView:SetListItemCount(listSize, true)
    self.equipList.loopGridView:RefreshAllShownItem2()

    local loopGridView = self.equipList.loopGridView
    for i = 0, listSize - 1 do
        local item = loopGridView:GetShownItemByItemIndex(i)
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

---选中某个装备格子
---@param index number 装备格子索引
function EquipHandbookPanel:selectBox(index)
    if self.selectedIndex == index then
        return
    end

    -- 检查index是否有效
    if index < 1 or index > tablex.size(self.equipListData) then
        return
    end

    local previousIndex = self.selectedIndex
    self.selectedIndex = index
    self.equipList.loopGridView:RefreshAllShownItem2()
    self.nowSelectHandBookData = Me:getHandbookDataByTypeAndId(GE.HandbookType.Equip, self.equipListData[index].id) or {}
    self.nowSelectConfigData = Config.GetEquipmentInfo(self.equipListData[index].id)
    self:setMsgView()
end

---LoopGridView 装备格子回调
function EquipHandbookPanel:OnEquipItemValueChange(gridView, index, row, col)
    local loopItem = gridView:GetShownItemByItemIndex(index)
    if loopItem == nil then
        loopItem = gridView:NewListViewItem("CustomBox")
    end
    local obj = loopItem.gameObject
    EngineUtil.FillPeer(self.customBox, obj)
    local dataIndex = index + 1
    local boxData = self.equipListData[dataIndex]
    if not boxData then return loopItem end

    local customBox = obj.customBox
    local handbookData = Me:isHandbookUnlocked(GE.HandbookType.Equip, boxData.id)
    local rData = {
        id = boxData.id,
        type = GE.RewardType.Equipment,
        num = 0,
    }
    local customData = {
        scale = 0.8,
        isSelect = self.selectedIndex == dataIndex,
        listener = function()
            self:selectBox(dataIndex)
        end
    }
    customBox:setMono(self)
    customBox:SetUIData(rData, customData)
    customBox:setCommonMask(not handbookData)
    return loopItem
end

---设置右侧信息显示
function EquipHandbookPanel:setMsgView()
    self.isHasCount.text.text = (self.nowSelectHandBookData and self.nowSelectHandBookData.count) or 0

    self.equipNameText.text.text = self.nowSelectConfigData.name
    self.amountNum.text.text = self.nowSelectConfigData.dec
    self.isSp:SetActive(self.nowSelectConfigData.equipType == GE.EquipType.sp)
    self:updateAttr()

    local nowStar = 1
    local nowLevel = 1
    if self.maxMode then
        nowStar = self.nowSelectConfigData.breakTimes + self.nowSelectConfigData.basicStar
        nowLevel = self.nowSelectConfigData.levelMax[nowStar]
    else
        nowStar = self.nowSelectConfigData.basicStar
        nowLevel = 1
    end

    local str = LocalStrEnum.ActionFailReason_EquipLevelUpTips
    local romanNumerals = {"I", "II", "III", "IV", "V"}
    local equipSkill = self.nowSelectConfigData.skill
    local nowEffectId = Me:getEquipEffectIdByCidAndLevel(self.nowSelectConfigData.id, nowLevel)
    local nowEffectStage = Me:getEquipEffectStageByCidAndLevel(self.nowSelectConfigData.id, nowLevel)
    local skillConfig = nil
    if tablex.next(equipSkill) == nil then  --配置skill为空，视为没有特殊效果
        self.nullEffect:SetActive(true)
        self.hasEffect:SetActive(false)
        self.effectLevel.text.text = ""
        self.effectLevelMsg.text.text = ""
        self.skillMsgTxt:SetActive(false)
    elseif nowEffectId == nil then  --当前星级未解锁技能
        self.nullEffect:SetActive(false)
        self.hasEffect:SetActive(true)
        self.effectLevel.text.text = ""
        self.effectLevelMsg.text.text = string.format(str, self.nowSelectConfigData.unLockSkillLv[1])
        self.skillMsgTxt:SetActive(true)
        local nextEffectId = equipSkill[1] or 0
        skillConfig = Config.GetSkillInfo(nextEffectId)
        local c1 = self.skillMsgTxt.text.color
        self.skillMsgTxt.text.color = Color.New(c1.r, c1.g, c1.b, 0.65)
    else  --已解锁特殊效果
        self.nullEffect:SetActive(false)
        self.hasEffect:SetActive(true)
        self.effectLevel.text.text = romanNumerals[nowEffectStage].." "..LocalStrEnum.AffectionLevel
        self.effectLevelMsg.text.text = ""
        self.skillMsgTxt:SetActive(true)
        skillConfig = Config.GetSkillInfo(nowEffectId)
        local c2 = self.skillMsgTxt.text.color
        self.skillMsgTxt.text.color = Color.New(c2.r, c2.g, c2.b, 1)
    end
    if skillConfig then
        self.skillMsgTxt.text.text = skillConfig.desKey
    else
        self.skillMsgTxt.text.text = ""
    end
    self.equipMsgTxt.text.text = self.nowSelectConfigData.equipinfo

    --中间图标
    self.equipIcon:SetActive(true)
    self:LoadSpriteAsync(string.format(Config.SpritePath.EquipIconPath, self.nowSelectConfigData.icon), self.equipIcon.image)

    self.equipRareIcon:SetActive(true)
    self:LoadSpriteAsync(string.format(Config.SpritePath.EquipShowRankBg, self.nowSelectConfigData.quality), self.equipRareIcon.image)

     self:FillTemplateContent(self.getActiveBox, self.channeList, tablex.size(self.nowSelectConfigData.turnTo), function (index, itemObj)
        local skipInfo = Config.SkipFuncInfo(self.nowSelectConfigData.turnTo[index])
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
                -- if self.beforeTruntoFunc then
                --     self.beforeTruntoFunc()
                -- end
                local curWnd = nil
                if skipInfo.isClose == 1 then
                    curWnd = UIMgr:getCurWndName()
                end
                UICommonUtils.CommonTurnTo(skipInfo.id, curWnd, function()
                    --跳转隐藏打开当前界面的界面
                    if self.ownerPanelName then
                        UIMgr:hideUI(self.ownerPanelName)
                    end
                end)
            end)
        else
            itemObj.gameObject:SetActive(false)
        end
    end)
end

function EquipHandbookPanel:updateAttr()
    local maxLevel = self.nowSelectConfigData.breakTimes + self.nowSelectConfigData.basicStar
    if self.maxMode then
        self.NatureData = Me:getEquipNatureDataByCidAndLevel(self.nowSelectConfigData.id, self.nowSelectConfigData.levelMax[maxLevel])
    else
        self.NatureData = Me:getEquipNatureDataByCidAndLevel(self.nowSelectConfigData.id, 1)
    end
    local temp = {}
    for _, value in pairs(self.NatureData) do
        table.insert(temp, value)
    end
    self.attributeBoxList = {}
    self:FillTemplateContent(self.attributeBox, self.attributeList, tablex.size(temp), function(index, attributeBox)
        self.attributeBoxList[temp[index].type] = attributeBox.attributeBox
        local boxData = {
            boxType = GE.ItemTypeIndex.equip,
            attrData = temp[index],
            boxIndex = index,
        }
        boxData.attrData.isMax = self.maxMode
        attributeBox.attributeBox:setMono(self)
        attributeBox.attributeBox:setAttrBoxData(boxData)
    end)
end

-------------------------------排序-----------------------------------------
--装备排序初始化
function EquipHandbookPanel:EquipSortInfo()
    local nowType = GE.EquipHandBookSortType[GE.EquipHandBookSortTypeName[self.nowEquipSortIndex]]
    self.sortTxt.text.text = LocalStrEnum["equipHandFilterType"..nowType]
    self.equipSortBtnlist = {}
    self:FillTemplateContent(self.sortTypeBtn, self.sortSelectList, tablex.size(GE.EquipHandBookSortTypeName), function(index, sortTypeBtn)
        local temp = {
            obj = sortTypeBtn,
            key = index,
        }
        table.insert(self.equipSortBtnlist, temp)
        sortTypeBtn:SetActive(true)
        sortTypeBtn.sortTypeTxtOff.text.text =  LocalStrEnum["equipHandFilterType"..GE.EquipHandBookSortType[GE.EquipHandBookSortTypeName[index]]]
        sortTypeBtn.sortTypeTxt.text.text =  LocalStrEnum["equipHandFilterType"..GE.EquipHandBookSortType[GE.EquipHandBookSortTypeName[index]]]
        sortTypeBtn.scaleButton.onClick:RemoveAllListeners()
        sortTypeBtn.scaleButton.onClick:AddListener(function()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            self.nowEquipSortIndex = index
            self.sortTxt.text.text = LocalStrEnum["equipHandFilterType"..nowType]
            self:setView()
            self.equipList.loopGridView:RefreshAllShownItem2()
            self.sortSelectList:SetActive(false)
            self.sortMask:SetActive(false)
        end)
    end)
end

--设置装备排序详情
function EquipHandbookPanel:setEquipSortView()
    local ascending = self.nowEquipSortFace == 1
    
    table.sort(self.equipListData, function(a, b)
        local primaryA, primaryB
        local secondaryA, secondaryB
        
        -- 根据排序类型获取比较值
        if self.nowEquipSortIndex == 1 then
            -- default - 默认按品质排序，同品质按id排序
            primaryA = a.quality or 0
            primaryB = b.quality or 0
            secondaryA = a.id
            secondaryB = b.id
        elseif self.nowEquipSortIndex == 2 then
            -- type - 按装备类型排序
            primaryA = a.equipWearType or 0
            primaryB = b.equipWearType or 0
            secondaryA = a.id
            secondaryB = b.id
        elseif self.nowEquipSortIndex == 3 then
            -- quality - 按稀有度排序
            primaryA = a.quality or 0
            primaryB = b.quality or 0
            secondaryA = a.id
            secondaryB = b.id
        elseif self.nowEquipSortIndex == 4 then
            -- count - 按持有数量排序
            local handbookDataA = Me:getHandbookDataByTypeAndId(GE.HandbookType.Equip, a.id)
            local handbookDataB = Me:getHandbookDataByTypeAndId(GE.HandbookType.Equip, b.id)
            primaryA = handbookDataA.count or 0
            primaryB = handbookDataB.count or 0
            secondaryA = a.id
            secondaryB = b.id
        end
        
        -- 主要排序比较
        if primaryA ~= primaryB then
            if ascending then
                return primaryA < primaryB
            else
                return primaryA > primaryB
            end
        end
        
        -- 次要排序比较（默认按id升序）
        if secondaryA and secondaryB then
            return secondaryA < secondaryB
        end
        
        return false
    end)
end

--刷新排序显示
function EquipHandbookPanel:refreshSortView()
    for k,v in pairs(self.equipSortBtnlist) do
        v.obj.isOpen:SetActive(v.key == self.nowEquipSortIndex)
    end
end
-----------------------------------------------------------------------------

--function EquipHandbookPanel:OnClose(initiative)
--
--end

--function EquipHandbookPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function EquipHandbookPanel:OnRefresh(data)
--
--end

--[[
/AdjustRoot/EquipPanel/SortPanel/SortBg/SortBtn onClick 
--]]
function EquipHandbookPanel:sortBtn_ScaleButton_onClick(sortBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.sortSelectList:SetActive(not self.sortSelectList.activeSelf)
    self.sortMask:SetActive(self.sortSelectList.activeSelf)
    if self.sortSelectList.activeSelf then
        self:refreshSortView()
    end
end

--[[
/AdjustRoot/EquipPanel/SortPanel/SortBg/SortStateBtn onClick 
--]]
function EquipHandbookPanel:sortStateBtn_ScaleButton_onClick(sortStateBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.nowEquipSortFace == 1 then
        self.nowEquipSortFace = 2
    elseif self.nowEquipSortFace == 2 then
        self.nowEquipSortFace = 1
    end
    self.sortStateBtn.upImg:SetActive(self.nowEquipSortFace == 2)
    self.sortStateBtn.downImg:SetActive(self.nowEquipSortFace == 1)
    self:setView()
    self.equipList.loopGridView:RefreshAllShownItem2()
    self.sortSelectList:SetActive(false)
    self.sortMask:SetActive(false)
end

--[[
/AdjustRoot/EquipPanel/SortPanel/FiltrateBtn onClick 
--]]
function EquipHandbookPanel:filtrateBtn_ScaleButton_onClick(filtrateBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    UIMgr:popUICover("SkinGoodsFiltrateBox", self.filterData)
end

--[[
/AdjustRoot/EquipPanel/SortPanel/SortMask onClick 
--]]
function EquipHandbookPanel:sortMask_Button_onClick(sortMask)
    self.sortSelectList:SetActive(false)
    self.sortMask:SetActive(false)
end

---筛选回调
function EquipHandbookPanel:OnFiltrateSelectCallBack(filtrateOperation)
    if filtrateOperation == nil then
        return
    end

    -- 更新筛选状态
    for i = 1, #self.filterData.groups do
        local g = filtrateOperation[i]
        if g == nil then
            goto continue
        end
        local group = self.filterData.groups[i]
        for j = 1, #group.items do
            local isSelect = tablex.indexof(g, j) > 0
            group.items[j].isSelect = isSelect
        end
        ::continue::
    end

    -- 重新筛选并刷新显示
    self:setView()

    -- 重置选中索引，避免 selectBox(1) 因索引未变而跳过刷新
    self.selectedIndex = nil
    if tablex.size(self.equipListData) > 0 then
        self:selectBox(1)
    end
end

---筛选装备列表
---@return table 筛选后的装备配置列表
function EquipHandbookPanel:FiltrateEquips()
    local equipTypeList = {}    -- 装备类型筛选条件
    local qualityList = {}      -- 品质筛选条件
    local natureList = {}       -- 基础属性筛选条件
    local ownStateList = {}     -- 拥有状态筛选条件
    
    local filterLists = {equipTypeList, qualityList, natureList, ownStateList}
    
    -- 解析筛选条件
    for i = 1, #self.filterData.groups do
        local group = self.filterData.groups[i]
        local filterList = filterLists[i]
        
        if group.selectType == FiltrateSelectType.AllMultiSelect then
            if not group.items[1].isSelect then
                -- 没有选中"全部"，只添加选中项的值
                for j = 2, #group.items do
                    if group.items[j].isSelect then
                        local val = group.items[j].val
                        if val ~= nil then
                            table.insert(filterList, val)
                        end
                    end
                end
            end
            -- 如果选中"全部"，filterList保持为空，表示不筛选这个维度
        end
    end
    
    -- 筛选装备
    local result = {}
    for _, equipConfig in pairs(self.allEquipListData) do
        local equipId = equipConfig.id
        
        -- 筛选装备类型
        if #equipTypeList > 0 then
            if tablex.indexof(equipTypeList, equipConfig.equipWearType) <= 0 then
                goto continue
            end
        end
        
        -- 筛选品质
        if #qualityList > 0 then
            if tablex.indexof(qualityList, equipConfig.quality) <= 0 then
                goto continue
            end
        end
        
        -- 筛选基础属性（装备至少有一个选中的属性值 > 0）
        if #natureList > 0 then
            local hasNature = false
            local natureData = Me:getEquipNatureDataByCidAndLevel(equipId, 1)
            for _, attrData in pairs(natureData) do
                if tablex.indexof(natureList, attrData.type) > 0 and attrData.value > 0 then
                    hasNature = true
                    break
                end
            end
            if not hasNature then
                goto continue
            end
        end
        
        -- 筛选拥有状态
        if #ownStateList > 0 then
            local isOwn = Me:isHandbookUnlocked(GE.HandbookType.Equip, equipId)
            local matchOwn = false
            
            for _, ownState in ipairs(ownStateList) do
                if ownState == 1 and isOwn then  -- 拥有
                    matchOwn = true
                    break
                elseif ownState == 2 and not isOwn then  -- 未拥有
                    matchOwn = true
                    break
                end
            end
            
            if not matchOwn then
                goto continue
            end
        end
        
        table.insert(result, equipConfig)
        ::continue::
    end
    
    return result
end

--[[
/AdjustRoot/MsgPanel/showMaxBtn onClick 
--]]
function EquipHandbookPanel:showMaxBtn_ScaleButton_onClick(showMaxBtn)
    self.maxMode = not self.maxMode
    self.showMaxBtn.isOnMax:SetActive(self.maxMode)
    self:setMsgView()
end

--[[
/GetActiveBox onClick 
--]]
function EquipHandbookPanel:getActiveBox_ScaleButton_onClick(getActiveBox)

end

return EquipHandbookPanel
