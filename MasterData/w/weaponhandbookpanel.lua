---@diagnostic disable: undefined-label
---@class WeaponHandbookPanel : WeaponHandbookPanel_Generate
---##################### 【WeaponHandbookPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【WeaponHandbookPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local WeaponHandbookPanel = require "WeaponHandbookPanel_Generate"

---@type FiltrateGroupData[]
local weaponFiltrateCfg = {
    {
        tagName = LocalStrEnum.weaponHandFiltrate_1,
        selectType = FiltrateSelectType.AllMultiSelect,
        items = {
            {itemName = LocalStrEnum.skinTag_0, isDefault = true},
            {itemName = LocalStrEnum.weaponTypeDec_1, val = 1},
            {itemName = LocalStrEnum.weaponTypeDec_2, val = 2},
            {itemName = LocalStrEnum.weaponTypeDec_3, val = 3},
            {itemName = LocalStrEnum.weaponTypeDec_4, val = 4},
            {itemName = LocalStrEnum.weaponTypeDec_5, val = 5},
            {itemName = LocalStrEnum.weaponTypeDec_6, val = 6},
            {itemName = LocalStrEnum.weaponTypeDec_7, val = 7},
            {itemName = LocalStrEnum.weaponTypeDec_8, val = 8},
        },
    },
    {
        tagName = LocalStrEnum.weaponHandFiltrate_2,
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
        tagName = LocalStrEnum.weaponHandFiltrate_3,
        selectType = FiltrateSelectType.AllMultiSelect,
        items = {
            {itemName = LocalStrEnum.skinTag_0, isDefault = true},
            {itemName = LocalStrEnum.ownState_1, val = 1},
            {itemName = LocalStrEnum.ownState_2, val = 2},
        },
    },
}

function WeaponHandbookPanel:InitLogic(data)
    self.selectedIndex = nil  -- 初始化选中索引

    ---@type WeaponTable
    self.nowSelectConfigData = {}   -- 当前选中图鉴配置数据

    ---@type HandbookData
    self.nowSelectHandBookData = {}     -- 当前选中图鉴数据
    
    self.nowWeaponSortIndex = 1      -- 当前武器排序
    self.weaponSortBtnlist = {}
    self.nowWeaponSortFace = 1

    self.allWeaponListData = {}  -- 所有武器列表（未筛选）

    ---@type FiltrateData
    self.filterData = {
        groups = weaponFiltrateCfg,
        callback = BindCallback_NoParams(self, self.OnFiltrateSelectCallBack)
    }

    -- 初始化筛选状态
    for i = 1, #self.filterData.groups do
        local group = self.filterData.groups[i]
        for j = 1, #group.items do
            group.items[j].isSelect = group.items[j].isDefault
        end
    end
    self.weaponList.loopGridView:InitGridView(0, BindCallback_NoParams(self, self.OnWeaponItemValueChange))
end

--function WeaponHandbookPanel:StartCreating(time)
--
--end

--function WeaponHandbookPanel:StartEnter(time)
--
--end

--function WeaponHandbookPanel:StartRemoving(time)
--
--end

--function WeaponHandbookPanel:StartExit(time)
--
--end

function WeaponHandbookPanel:OnOpen(data, initiative)
    -- 初始化选中索引
    self.selectedIndex = nil
    self:setView()
    -- 只有当有武器时才选中第一个
    if tablex.size(self.weaponListData) > 0 then
        self:selectBox(1)
    end
end

function WeaponHandbookPanel:setView()
    self.customBackPanel.customBackPanel:Bind(GE.NavigationType.HandbooksWeapon, self)
    self.customBackPanel.customBackPanel:OverrideBackFunc(function()
        self.animator:SetTrigger("Out")
        self.animOverCallBack:SetCallBack(function()
            UIMgr:closeSpecificUI(self)
            self.customBackPanel.customBackPanel:ClearBackFunc()
        end)
    end)
    -- 只在第一次加载所有武器配置
    if tablex.size(self.allWeaponListData) == 0 then
        local allWeaponConfigs = Config.GetAllConfig("WeaponTable")
        for _, value in pairs(allWeaponConfigs) do
            if value.isOpen == 1 then
                table.insert(self.allWeaponListData, value)
            end 
        end
    end

    -- 应用筛选
    self.weaponListData = self:FiltrateWeapons()

    self:WeaponSortInfo()
    self:setWeaponSortView()

    -- 验证selectedIndex是否仍然有效，如果超出范围则重置为nil
    local listSize = tablex.size(self.weaponListData)
    if self.selectedIndex ~= nil and (self.selectedIndex < 1 or self.selectedIndex > listSize) then
        self.selectedIndex = nil
    end

    self.weaponList.loopGridView:SetListItemCount(listSize, true)

    local loopGridView = self.weaponList.loopGridView
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

    -- self.getActiveBox1.goBtn.scaleButton.onClick:RemoveAllListeners()
    -- self.getActiveBox1.goBtn.scaleButton.onClick:AddListener(function()
    --     self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    --     local functionState = Me:getFunctionOpenStateById(GE.FunctionOpenModule.WeaponMake)
    --     local functionOpenConfig = Config.GetFunctionOpenInfo(GE.FunctionOpenModule.WeaponMake)
    --     if functionState == GE.FunctionOpenState.Lock then
    --         UICommonUtils.PopToast(functionOpenConfig.unlockKey)
    --         return
    --     elseif functionState == GE.FunctionOpenState.Open then
    --         Me:readFunctionReq({functionId = GE.FunctionOpenModule.WeaponMake})
    --     end
    --     UIMgr:popUI("HomeWeaponProPanel")
    -- end)

end

---选中某个武器格子
---@param index number 武器格子索引
function WeaponHandbookPanel:selectBox(index)
    if self.selectedIndex == index then
        return
    end

    -- 检查index是否有效
    if index < 1 or index > tablex.size(self.weaponListData) then
        return
    end

    local previousIndex = self.selectedIndex
    self.selectedIndex = index
    self.weaponList.loopGridView:RefreshAllShownItem2()
    self.nowSelectHandBookData = Me:getHandbookDataByTypeAndId(GE.HandbookType.Weapon, self.weaponListData[index].id) or {}
    self.nowSelectConfigData = Config.GetWeaponInfo(self.weaponListData[index].id)
    self:setMsgView()
end

---LoopGridView 武器格子回调
function WeaponHandbookPanel:OnWeaponItemValueChange(gridView, index, row, col)
    local loopItem = gridView:GetShownItemByItemIndex(index)
    if loopItem == nil then
        loopItem = gridView:NewListViewItem("CustomBox")
    end
    local obj = loopItem.gameObject
    EngineUtil.FillPeer(self.customBox, obj)
    local dataIndex = index + 1
    local boxData = self.weaponListData[dataIndex]
    if not boxData then return loopItem end

    local customBox = obj.customBox
    local handbookData = Me:isHandbookUnlocked(GE.HandbookType.Weapon, boxData.id)
    local customData = {
        id = boxData.id,
        itemType = GE.ItemTypeIndex.weapon,
        scale = 0.8,
        isSelect = self.selectedIndex == dataIndex,
        ownerPanelName = self.uiConfig.id,
        listener = function()
            self:selectBox(dataIndex)
        end
    }
    customBox:setMono(self)
    customBox:refreshUI(customData)
    customBox:setCommonMask(not handbookData)
    return loopItem
end

---设置右侧信息显示
function WeaponHandbookPanel:setMsgView()
    self.isHasCount.text.text = (self.nowSelectHandBookData and self.nowSelectHandBookData.count) or 0

    self.weaponNameText.text.text = self.nowSelectConfigData.name
    self.amountNum.text.text = self.nowSelectConfigData.weaponTypeDec
    
    -- 设置武器载重显示
    self:FillTemplateContent(self.weaponLoadBox, self.weaponLoadList, self.nowSelectConfigData.load, function(index, weaponLoadBox)
        weaponLoadBox:SetActive(true)
    end)

    local effectList = {}
    if self.nowSelectConfigData.entry5 == nil or tablex.size(self.nowSelectConfigData.entry5) == 0 then
        self.effectTitle.text.text = string.format("可出现效果：%s种", 0)
    else
        local rawEffectList = Config.GetWeaponEntryInfoByGroup(self.nowSelectConfigData.entry5[1][1]) or {}
        for _, effectData in ipairs(rawEffectList) do
            table.insert(effectList, effectData)
        end
        self.effectTitle.text.text = string.format("可出现效果：%s种", #effectList)
    end

    local romanNumerals = {"I", "II", "III", "IV", "V"}
    local effectCount = #effectList
    self:FillTemplateContent(self.effectBox, self.weaponMsgList, effectCount, function(index, effectBox)
        local effectData = effectList[index]
        if effectData == nil then
            effectBox:SetActive(false)
            return
        end
        effectBox:SetActive(true)
        local skillConfig = Config.GetSkillInfo(effectData.attribute)
        effectBox.rankTxt.text.text = "效果"..(romanNumerals[index] or tostring(index))
        effectBox.effectTxt.text.text = skillConfig.desKey
    end)

    local rootTransform = self.weaponMsgList.transform
    local shownIndex = 0
    for i = 0, rootTransform.childCount - 1 do
        local child = rootTransform:GetChild(i).gameObject
        if child ~= self.effectBox.gameObject then
            shownIndex = shownIndex + 1
            if shownIndex > effectCount then
                child:SetActive(false)
            end
        end
    end

    -- 中间图标
    self.weaponIcon:SetActive(true)
    self:LoadSpriteAsync(string.format(Config.SpritePath.WeaponIconPath, self.nowSelectConfigData.icon), self.weaponIcon.image)

    self.weaponRareIcon:SetActive(true)
    self:LoadSpriteAsync(string.format(Config.SpritePath.EquipShowRankBg, self.nowSelectConfigData.rare), self.weaponRareIcon.image)

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

-------------------------------排序-----------------------------------------
--武器排序初始化
function WeaponHandbookPanel:WeaponSortInfo()
    local nowType = GE.WeaponHandBookSortType[GE.WeaponHandBookSortTypeName[self.nowWeaponSortIndex]]
    self.sortTxt.text.text = LocalStrEnum["weaponHandFilterType"..nowType]
    self.weaponSortBtnlist = {}
    self:FillTemplateContent(self.sortTypeBtn, self.sortSelectList, tablex.size(GE.WeaponHandBookSortTypeName), function(index, sortTypeBtn)
        local temp = {
            obj = sortTypeBtn,
            key = index,
        }
        table.insert(self.weaponSortBtnlist, temp)
        sortTypeBtn:SetActive(true)
        sortTypeBtn.sortTypeTxtOff.text.text =  LocalStrEnum["weaponHandFilterType"..GE.WeaponHandBookSortType[GE.WeaponHandBookSortTypeName[index]]]
        sortTypeBtn.sortTypeTxt.text.text =  LocalStrEnum["weaponHandFilterType"..GE.WeaponHandBookSortType[GE.WeaponHandBookSortTypeName[index]]]
        sortTypeBtn.scaleButton.onClick:RemoveAllListeners()
        sortTypeBtn.scaleButton.onClick:AddListener(function()
            self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
            self.nowWeaponSortIndex = index
            self.sortTxt.text.text = LocalStrEnum["weaponHandFilterType"..nowType]
            self:setView()
            self.weaponList.loopGridView:RefreshAllShownItem2()
            self.sortSelectList:SetActive(false)
            self.sortMask:SetActive(false)
        end)
    end)
end

--设置武器排序详情
function WeaponHandbookPanel:setWeaponSortView()
    local ascending = self.nowWeaponSortFace == 1
    
    table.sort(self.weaponListData, function(a, b)
        local primaryA, primaryB
        local secondaryA, secondaryB
        
        -- 根据排序类型获取比较值
        if self.nowWeaponSortIndex == 1 then
            -- default - 默认按id排序
            primaryA = a.id
            primaryB = b.id
            secondaryA = a.rare
            secondaryB = b.rare
        elseif self.nowWeaponSortIndex == 2 then
            -- quality - 按品质排序
            primaryA = a.rare or 0
            primaryB = b.rare or 0
            secondaryA = a.id
            secondaryB = b.id
        elseif self.nowWeaponSortIndex == 3 then
            -- type - 按类型排序
            primaryA = a.type or 0
            primaryB = b.type or 0
            secondaryA = a.id
            secondaryB = b.id
        elseif self.nowWeaponSortIndex == 4 then
            -- count - 按持有数量排序
            local handbookDataA = Me:getHandbookDataByTypeAndId(GE.HandbookType.Weapon, a.id)
            local handbookDataB = Me:getHandbookDataByTypeAndId(GE.HandbookType.Weapon, b.id)
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
function WeaponHandbookPanel:refreshSortView()
    for k,v in pairs(self.weaponSortBtnlist) do
        v.obj.isOpen:SetActive(v.key == self.nowWeaponSortIndex)
    end
end
-----------------------------------------------------------------------------

--function WeaponHandbookPanel:OnClose(initiative)
--
--end

--function WeaponHandbookPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function WeaponHandbookPanel:OnRefresh(data)
--
--end

--[[
/AdjustRoot/WeaponPanel/SortPanel/SortBg/SortBtn onClick 
--]]
function WeaponHandbookPanel:sortBtn_ScaleButton_onClick(sortBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.sortSelectList:SetActive(not self.sortSelectList.activeSelf)
    self.sortMask:SetActive(self.sortSelectList.activeSelf)
    if self.sortSelectList.activeSelf then
        self:refreshSortView()
    end
end

--[[
/AdjustRoot/WeaponPanel/SortPanel/SortBg/SortStateBtn onClick 
--]]
function WeaponHandbookPanel:sortStateBtn_ScaleButton_onClick(sortStateBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.nowWeaponSortFace == 1 then
        self.nowWeaponSortFace = 2
    elseif self.nowWeaponSortFace == 2 then
        self.nowWeaponSortFace = 1
    end
    self.sortStateBtn.upImg:SetActive(self.nowWeaponSortFace == 2)
    self.sortStateBtn.downImg:SetActive(self.nowWeaponSortFace == 1)
    self:setView()
    self.weaponList.loopGridView:RefreshAllShownItem2()
    self.sortSelectList:SetActive(false)
    self.sortMask:SetActive(false)
end

--[[
/AdjustRoot/WeaponPanel/SortPanel/FiltrateBtn onClick 
--]]
function WeaponHandbookPanel:filtrateBtn_ScaleButton_onClick(filtrateBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    UIMgr:popUICover("SkinGoodsFiltrateBox", self.filterData)
end

--[[
/AdjustRoot/WeaponPanel/SortPanel/SortMask onClick 
--]]
function WeaponHandbookPanel:sortMask_Button_onClick(sortMask)
    self.sortSelectList:SetActive(false)
    self.sortMask:SetActive(false)
end

---筛选回调
function WeaponHandbookPanel:OnFiltrateSelectCallBack(filtrateOperation)
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
    
    -- 重新选择第一个
    if tablex.size(self.weaponListData) > 0 then
        self:selectBox(1)
    else
        self.selectedIndex = nil
    end
end

---筛选武器列表
---@return table 筛选后的武器配置列表
function WeaponHandbookPanel:FiltrateWeapons()
    local weaponTypeList = {}    -- 武器类型筛选条件
    local qualityList = {}       -- 品质筛选条件
    local ownStateList = {}      -- 拥有状态筛选条件
    
    local filterLists = {weaponTypeList, qualityList, ownStateList}
    
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
    
    -- 筛选武器
    local result = {}
    for _, weaponConfig in pairs(self.allWeaponListData) do
        local weaponId = weaponConfig.id
        
        -- 筛选武器类型
        if #weaponTypeList > 0 then
            if tablex.indexof(weaponTypeList, weaponConfig.type) <= 0 then
                goto continue
            end
        end
        
        -- 筛选品质
        if #qualityList > 0 then
            if tablex.indexof(qualityList, weaponConfig.rare) <= 0 then
                goto continue
            end
        end
        
        -- 筛选拥有状态
        if #ownStateList > 0 then
            local isOwn = Me:isHandbookUnlocked(GE.HandbookType.Weapon, weaponId)
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
        
        table.insert(result, weaponConfig)
        ::continue::
    end
    
    return result
end

--[[
/AdjustRoot/TipsView/ExitMask onClick 
--]]
function WeaponHandbookPanel:exitMask_Button_onClick(exitMask)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    self.tipsView:SetActive(false)
end

--[[
/AdjustRoot/MsgPanel/NameBg/EffectMsgBtn onClick 
--]]
function WeaponHandbookPanel:effectMsgBtn_ScaleButton_onClick(effectMsgBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    self.tipsView:SetActive(true)
end

--[[
/GetActiveBox onClick 
--]]
function WeaponHandbookPanel:getActiveBox_ScaleButton_onClick(getActiveBox)

end

return WeaponHandbookPanel
