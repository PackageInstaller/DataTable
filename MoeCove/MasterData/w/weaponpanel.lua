---@class WeaponPanel : WeaponPanel_Generate
---##################### 【WeaponPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【WeaponPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local WeaponPanel = require "WeaponPanel_Generate"

function WeaponPanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.RefreshTopResource, function()
            self.customBackPanel.customBackPanel:RefreshTopResource()
        end},
        {GameMsgType.OnWeaponChange, self.Refresh},
        {GameMsgType.HeroNatureChange, self.Refresh},
    }
    self.selectIndex = 1
    self.nowSelectWeaponId = 0
    self.roleId = 0

    self.nowWeaponSortIndex = 1      --当前武器排序
    self.weaponSortBtnlist = {}
    self.nowWeaponSortFace = 1
    self.weaponList.loopGridView:InitGridView(0, BindCallback_NoParams(self, self.changeWeaponBoxData))
    UIMgr:depositUI(self)
end

function WeaponPanel:InitPanel()
    local roleData = Me:getPlayerHero(self.roleId)
    self.remainingLoad = roleData.load
    for key, value in pairs(roleData.carryWeapon) do
        local weaponData = Me:getWeaponDataById(value)
        if weaponData then
            self.remainingLoad = self.remainingLoad - weaponData.load
        end
    end

    self:setWeaponListData()

    self.compareTxt.text.text = "对比"
    if self.nowSelectWeaponId ~= 0 then
        for index, data in pairs(self.weaponListData) do
            if data.id == self.nowSelectWeaponId then
                index = index - 1
                if index < 0 then
                    index = 0
                end
                self.weaponList.loopGridView:MovePanelToItemByIndex(index - 1, 0)
                break
            end
        end
    end
end

--function WeaponPanel:StartCreating(time)
--
--end

--function WeaponPanel:StartEnter(time)
--
--end

--function WeaponPanel:StartRemoving(time)
--
--end

--function WeaponPanel:StartExit(time)
--
--end

function WeaponPanel:OnOpen(data, initiative)
    --导航栏
    self.customBackPanel.customBackPanel:Bind(GE.NavigationType.WeaponPanel, self)
    self.customBackPanel.customBackPanel:OverrideBackFunc(function()
        self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = false
        self.animator:SetTrigger("Out")
        self.animOverCallBack:SetCallBack(function()
            UIMgr:closeSpecificUI(self)
            self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = true
        end)

        --清空返回方法
        self.customBackPanel.customBackPanel:ClearBackFunc()
    end)

    self.roleId = data and data.roleId or 0
    self.partId = data and data.partId or 0
    self.wearWeaponId = Me:getPlayerHero(self.roleId) and Me:getPlayerHero(self.roleId).carryWeapon[self.partId] or 0
    self.nowSelectWeaponId = self.wearWeaponId

    self.sortStateBtn.upImg:SetActive(self.nowWeaponSortFace == 2)
    self.sortStateBtn.downImg:SetActive(self.nowWeaponSortFace == 1)
    self:InitPanel()
    GuideMgr:StartGuideTrigger("WeaponPanel")
end

---设置武器列表数据
---@param isRefresh? boolean 是否刷新
---@param notSort? boolean 不重新排序
function WeaponPanel:setWeaponListData(isRefresh, notSort)
    local weaponMapData = Me:getAllWeaponData()
    if not isRefresh then
        self.weaponListData = {}
        local roleConfig = Config.GetCharacterInfo(self.roleId) or {}

        for _, weaponData in pairs(weaponMapData) do
            if next(roleConfig) then
                local weaponConfig = Config.GetWeaponInfo(weaponData.cid)
                for _, weaponType in pairs(roleConfig.useWeaponType) do
                    if weaponType == weaponConfig.type then
                        table.insert(self.weaponListData, weaponData)
                    end
                end
            else
                table.insert(self.weaponListData, weaponData)
            end
        end
    else
        for i = 1, #self.weaponListData do
            self.weaponListData[i] = weaponMapData[self.weaponListData[i].id]
        end
    end

    self:WeaponSortInfo()
    if not notSort then
        self:setWeaponSortView()
    end

    
    local remainingLoad = self.remainingLoad
    if self.wearWeaponId ~= 0 then
        local wearWeaponData = Me:getWeaponDataById(self.wearWeaponId)
        if wearWeaponData then
            remainingLoad = wearWeaponData.load + remainingLoad
        end
    end
    self.listRemainingLoad = remainingLoad
    self.weaponList.loopGridView:SetListItemCount(#self.weaponListData, false)
    -- 数量未变时 SetListItemCount 不会刷新，排序后需主动重绑可见格子
    if not notSort then
        self.weaponList.loopGridView:RefreshAllShownItem2()
    end
    --无武器时判断
    local noWeapon = self.wearWeaponId == 0 and not next(self.weaponListData)
    self.noWeapon:SetActive(noWeapon)
    self.noWeaponMsg:SetActive(noWeapon)
    self.noSetWeapon:SetActive(noWeapon)
    self.msgPanel:SetActive(not noWeapon)
    self.weaponFrame:SetActive(not noWeapon)
    if not noWeapon and self.nowSelectWeaponId ~= 0 then
        self:setWeaponInfo(self.nowSelectWeaponId)
    end
end

--武器列表格子数据回调
function WeaponPanel:changeWeaponBoxData(gridView, index, row, col)
    local loopListViewItem = gridView:GetShownItemByItemIndex(index)
    if loopListViewItem == nil then
        loopListViewItem = gridView:NewListViewItem("CustomBox")
    end
    local customBoxObj = loopListViewItem.gameObject
    EngineUtil.FillPeer(self.customBox, customBoxObj)

    local needIndex = index + 1
    local customBox = customBoxObj.customBox
    local weaponData = self.weaponListData[needIndex]
    if self.nowSelectWeaponId == weaponData.id then
        self.selectIndex = needIndex
    end

    local remainingLoad = self.listRemainingLoad
    local customData = {
        id = weaponData.cid,
        itemType = GE.ItemTypeIndex.weapon,
        scale = 0.8,
        isSelect = self.nowSelectWeaponId == weaponData.id and true or false,
        isLock = weaponData.isLock,
        itemNum = "+"..weaponData.level,
        ownerId = weaponData.ownerId,
        overLoad = weaponData.load > remainingLoad and true or false,
        ownerPanelName = self.uiConfig.id,
        listener = function()
            self.selectIndex = needIndex
            self:setWeaponInfo(weaponData.id)
            self.weaponList.loopGridView:RefreshAllShownItem2()
            if self.comparePanel.activeSelf then
                self:setCompareWeaponInfo(self.wearWeaponId)
            end
        end
    }
    --未穿戴时默认选中第一个
    if self.nowSelectWeaponId == 0 and needIndex == 1 then
        customData.isSelect = true
        self:setWeaponInfo(weaponData.id)
    end
    customBox:setMono(self)
    customBox:refreshUI(customData)

    return loopListViewItem
end

--设置武器信息界面
function WeaponPanel:setWeaponInfo(weaponId)
    self.fuseLocked = false
    self.canGoFuse = false
    self.nowWeaponLvMax = false
    self.nowSelectWeaponId = weaponId
    local weaponData = Me:getWeaponDataById(weaponId)
    local weaponConfig = Config.GetWeaponInfo(weaponData.cid)
    self.weaponNameText.text.text = weaponConfig.name
    self.weaponLevel.text.text = "+"..weaponData.level

    self:LoadSpriteAsync(string.format(Config.SpritePath.EquipShowRankBg, weaponConfig.rare), self.weaponRareIcon.image)
    self:LoadSpriteAsync(string.format(Config.SpritePath.WeaponIconPath, weaponConfig.icon), self.weaponIcon.image)
    self:LoadSpriteAsync(string.format(Config.SpritePath.WeaponTypePath, weaponConfig.type), self.weaponTypeIcon.image)
    self.isLock:SetActive(weaponData.isLock)
    self.amountNum.text.text = weaponConfig.weaponTypeDec
    self.accuracyNum.text.text = weaponData.accuracy
    self.qualityNum.text.text = weaponData.quality
    self.scoreText.text.text = math.floor((weaponConfig.bulletNum * weaponData.accuracy * weaponData.quality / 1000) )

    --跟穿戴中的数据做对比
    local wearWeaponData = Me:getWeaponDataById(self.wearWeaponId)
    if wearWeaponData then
        local wearweaponConfig = Config.GetWeaponInfo(wearWeaponData.cid)
        local wearScore = math.floor((wearweaponConfig.bulletNum * wearWeaponData.accuracy * wearWeaponData.quality / 1000))
        -- self.scoreUp:SetActive(tonumber(self.scoreText.text.text) > wearScore)
        -- self.scoreDown:SetActive(tonumber(self.scoreText.text.text) < wearScore)
        self.scoreText.text.color = tonumber(self.scoreText.text.text) > wearScore and Color.NewFromStr("69D174")
        or tonumber(self.scoreText.text.text) < wearScore and Color.NewFromStr("DC3F3F") or Color.NewFromStr("FFFFFF")
    end

    local needAttrList = {}
    for attrType, attrData in pairs(weaponData.attributeValue) do
        local entryList = Config.GetWeaponEntryInfoByGroup(attrType)
        local data = {
            name = entryList[1].name,
            valueType = entryList[1].type,
            value = attrData.value,
            type = entryList[1].attributeId,
            compare = self:compareSameAttrValue(attrData.value, entryList[1], wearWeaponData),
            isSpecial = attrData.isSpecial,
        }
        needAttrList[attrData.id] = data
    end

    self.skillPanel:SetActive(false)
    self:FillTemplateContent(self.attributeBox, self.attributeList, #weaponConfig.entryUnlock, function(index, attributeBox)
        local boxData = {
            boxType = GE.ItemTypeIndex.weapon,
            attrData = needAttrList[index],
            weaponConfig = weaponConfig,
            weaponData = weaponData,
            boxIndex = index,
        }
        attributeBox.attributeBox:setMono(self)
        attributeBox.attributeBox:setAttrBoxData(boxData)

        if needAttrList[index] then
            if needAttrList[index].valueType == GE.WeaponEntryAttrType.specialSkill then--特殊技能
                self.skillPanel:SetActive(true)
                local skillConfig = Config.GetSkillInfo(needAttrList[index].value)
                self.weaponSkillTxt.text.text = skillConfig.desKey
            end
        end
    end)

    if self.wearWeaponId == self.nowSelectWeaponId then
        self.disboardTxt.text.text = "卸 下"
    elseif self.wearWeaponId ~= self.nowSelectWeaponId and self.wearWeaponId ~= 0 then
        self.disboardTxt.text.text = "替 换"
    else
        self.disboardTxt.text.text = "装 备"
    end
    self.disBoardGray:SetActive(self.wearWeaponId == self.nowSelectWeaponId)
    self.fuseLocked = Me:getFunctionOpenStateById(GE.FunctionOpenModule.WeaponFuse) == GE.FunctionOpenState.Lock

    if weaponData.level == weaponConfig.levelMax then
        self.nowWeaponLvMax = true
        self.canGoFuse = weaponConfig.rare >= 4 and not self.fuseLocked
        self.notFuse:SetActive(not self.canGoFuse)
        self.levelUpTxt.text.text = "熔 合"
    else
        self.notFuse:SetActive(false)
        self.levelUpTxt.text.text = "提 升"
    end

    --根据情况计算是否可装备
    local overLoadBoxList = {}
    if self.overLoadTimer then

        DLuaTimer:RemoveTimer(self.overLoadTimer)
    end
    local remainingLoad = self.remainingLoad
    if self.wearWeaponId ~= 0 then
        remainingLoad = wearWeaponData.load + remainingLoad
    end
    self.overloadTips:SetActive(weaponData.load > remainingLoad)

    self:FillTemplateContent(self.weaponLoadBox, self.weaponLoadList, weaponConfig.load, function(index, weaponLoadBox)
        weaponLoadBox:SetActive(true)
        weaponLoadBox.canvasGroup.alpha = 1
        if index > remainingLoad then
            table.insert(overLoadBoxList, weaponLoadBox)
        end
    end)
    local function doFadeBox()
        for _, weaponLoadBox in ipairs(overLoadBoxList) do
            weaponLoadBox.canvasGroup:DOFade(1, 1):OnComplete(function()
                weaponLoadBox.canvasGroup:DOFade(0.3, 1)
            end)
        end
    end
    doFadeBox()
    if next(overLoadBoxList) then
        self.overLoadTimer = DLuaTimer:DoRepeatForever(2, function()
            doFadeBox()
        end)
    end
    
end

--相对选中武器的相同词条数值对比
function WeaponPanel:compareSameAttrValue(nowValue, enterConfig, wearWeaponData)
    for attrType, attrData in pairs(wearWeaponData and wearWeaponData.attributeValue or {}) do
        local entryList = Config.GetWeaponEntryInfoByGroup(attrType)
        if entryList[1].attributeId == enterConfig.attributeId
         and entryList[1].type == enterConfig.type then
            if nowValue > attrData.value then
                return 1
            end
            if nowValue < attrData.value then
                return 2
            end
        end
    end
    return 0
end

--设置对比武器信息界面
function WeaponPanel:setCompareWeaponInfo(weaponId)
    local weaponData = Me:getWeaponDataById(weaponId)
    local weaponConfig = Config.GetWeaponInfo(weaponData.cid)
    self.comparePanel.weaponNameText.text.text = weaponConfig.name
    self.comparePanel.weaponLevel.text.text = "+"..weaponData.level
    self:FillTemplateContent(self.weaponLoadBox, self.comparePanel.weaponLoadList, weaponConfig.load, function(index, weaponLoadBox)
        weaponLoadBox:SetActive(true)
    end)
    self:LoadSpriteAsync(string.format(Config.SpritePath.WeaponTypePath, weaponConfig.type), self.comparePanel.weaponTypeIcon.image)

    self.comparePanel.isLock:SetActive(weaponData.isLock)
    self.comparePanel.amountNum.text.text = weaponConfig.weaponTypeDec
    self.comparePanel.accuracyNum.text.text = weaponData.accuracy
    self.comparePanel.qualityNum.text.text = weaponData.quality
    self.comparePanel.scoreText.text.text = math.floor((weaponConfig.bulletNum * weaponData.accuracy * weaponData.quality / 1000))

    --跟穿戴中的数据做对比
    local selectWeaponData = Me:getWeaponDataById(self.nowSelectWeaponId)
    if selectWeaponData then
        local selectweaponConfig = Config.GetWeaponInfo(selectWeaponData.cid)
        local selectScore = math.floor((selectweaponConfig.bulletNum * selectWeaponData.accuracy * selectWeaponData.quality / 1000))
        -- self.comparePanel.scoreUp:SetActive(tonumber(self.comparePanel.scoreText.text.text) > selectScore)
        -- self.comparePanel.scoreDown:SetActive(tonumber(self.comparePanel.scoreText.text.text) < selectScore)
        self.comparePanel.scoreText.text.color = tonumber(self.comparePanel.scoreText.text.text) > selectScore and Color.NewFromStr("69D174")
        or tonumber(self.comparePanel.scoreText.text.text) < selectScore and Color.NewFromStr("DC3F3F") or Color.NewFromStr("FFFFFF")
    end

    local needAttrList = {}
    for attrType, attrData in pairs(weaponData.attributeValue) do
        local entryList = Config.GetWeaponEntryInfoByGroup(attrType)
        local data = {
            name = entryList[1].name,
            valueType = entryList[1].type,
            value = attrData.value,
            type = entryList[1].attributeId,
            compare = self:compareSameAttrValue(attrData.value, entryList[1], selectWeaponData),
            isSpecial = attrData.isSpecial,
        }
        needAttrList[attrData.id] = data
    end
    self.comparePanel.skillPanel:SetActive(false)
    self:FillTemplateContent(self.attributeBox, self.comparePanel.attributeList, #weaponConfig.entryUnlock, function(index, attributeBox)
        local boxData = {
            boxType = GE.ItemTypeIndex.weapon,
            attrData = needAttrList[index],
            weaponConfig = weaponConfig,
            weaponData = weaponData,
            boxIndex = index,
        }
        attributeBox.attributeBox:setMono(self)
        attributeBox.attributeBox:setAttrBoxData(boxData)

        if needAttrList[index] then
            if needAttrList[index].valueType == GE.WeaponEntryAttrType.specialSkill then--特殊技能
                self.skillPanel:SetActive(true)
                local skillConfig = Config.GetSkillInfo(needAttrList[index].value)
                self.weaponSkillTxt.text.text = skillConfig.desKey
            end
        end
    end)
end

---------------------------------------------------------------------------------------

--武器排序初始化
function WeaponPanel:WeaponSortInfo()
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
            self.nowWeaponSortIndex = index
            self.sortTxt.text.text = LocalStrEnum["weaponFilterType"..GE.WeaponSortType[GE.WeaponSortTypeName[self.nowWeaponSortIndex]]]
            self.sortSelectList:SetActive(false)
            self.sortMask:SetActive(false)
            self:setWeaponListData(true)
            self:refreshSortView()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        end)
    end)
end

--刷新排序显示
function WeaponPanel:refreshSortView()
    for k,v in pairs(self.weaponSortBtnlist) do
        v.obj.isOpen:SetActive(self.nowWeaponSortIndex == v.key)
    end
end

--设置武器排序详情
function WeaponPanel:setWeaponSortView()
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

    table.sort(self.weaponListData, function(a, b)
        return compare(a, b, primary, secondary, ascending)
    end)
end

function WeaponPanel:OnClose(initiative)
    if self.overLoadTimer then
        DLuaTimer:RemoveTimer(self.overLoadTimer)
    end
end

--function WeaponPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

---武器数据变更后刷新列表与详情（如从升级界面返回）
function WeaponPanel:Refresh()
    if not self.weaponListData or not self.roleId or self.roleId == 0 then
        return
    end
    local selectId = self.nowSelectWeaponId
    self:setWeaponListData(true, true)
    self.weaponList.loopGridView:RefreshAllShownItem2()
    if selectId ~= 0 then
        self:setWeaponInfo(selectId)
    end
    if self.comparePanel and self.comparePanel.activeSelf then
        self:setCompareWeaponInfo(self.wearWeaponId)
    end
end

--[[
/BackPanel/BackMainlBtn onClick 
--]]
function WeaponPanel:backMainlBtn_ScaleButton_onClick(backMainlBtn)

end

--[[
/BackPanel/HelpBtn onClick 
--]]
function WeaponPanel:helpBtn_ScaleButton_onClick(helpBtn)

end

--[[
/EquipPanel/EquipList/Viewport/Content/CustomBox/EquipBtn onClick 
--]]
function WeaponPanel:equipBtn_ScaleButton_onClick(equipBtn)

end

--[[
/EquipPanel/SortBg/SortBtn onClick 
--]]
function WeaponPanel:sortBtn_ScaleButton_onClick(sortBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.sortSelectList:SetActive(not self.sortSelectList.activeSelf)
    self.sortMask:SetActive(self.sortSelectList.activeSelf)
    if self.sortSelectList.activeSelf then
        self:refreshSortView()
    end
end

--[[
/EquipPanel/SortBg/SortStateBtn onClick 
--]]
function WeaponPanel:sortStateBtn_ScaleButton_onClick(sortStateBtn)
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
/MsgPanel/NameBg/LockBtn onClick 
--]]
function WeaponPanel:lockBtn_ScaleButton_onClick(lockBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    Me:changeWeaponLockStateReq({weaponId = self.nowSelectWeaponId}, function()
        self:setWeaponListData(true, true)
        self.weaponList.loopGridView:RefreshAllShownItem2()
    end)
end

--[[
/MsgPanel/MsgBtn onClick 
--]]
function WeaponPanel:msgBtn_ScaleButton_onClick(msgBtn)
    
end

--[[
/MsgPanel/LevelUpBtn onClick 
--]]
function WeaponPanel:levelUpBtn_ScaleButton_onClick(levelUpBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
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

--[[
/MsgPanel/DisboardBtn onClick 
--]]
function WeaponPanel:disboardBtn_ScaleButton_onClick(disboardBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.wearWeaponId == self.nowSelectWeaponId then--卸下
        Me:removeCharWeaponReq({weaponId = self.wearWeaponId}, function()
            self.wearWeaponId = 0
            self.remainingLoad = self.remainingLoad + Me:getWeaponDataById(self.nowSelectWeaponId).load
            self:setWeaponListData(true, true)
            self.weaponList.loopGridView:RefreshAllShownItem2()
            GameMsgMgr:sendEvent(GameMsgType.OnWeaponChange)
        end)
    else--装备or替换
        --根据情况计算是否可装备
        local remainingLoad = self.remainingLoad
        if self.wearWeaponId ~= 0 then
            local weaponData = Me:getWeaponDataById(self.wearWeaponId)
            remainingLoad = weaponData.load + remainingLoad
        end
        local selectWeaponData = Me:getWeaponDataById(self.nowSelectWeaponId)
        if selectWeaponData.load > remainingLoad then
            UICommonUtils.PopToast("超过负载！")
            return
        end

        local data = {
            charId = self.roleId,
            partId = self.partId,
            weaponId = self.nowSelectWeaponId,
        }
        Me:setCharWeaponReq(data, function()
            self.wearWeaponId = self.nowSelectWeaponId
            self:setWeaponListData(true)
            --self.animator:SetTrigger("out")
            --self.disboardBtn.scaleButton.interactable = false
            --self.animOverCallBack:SetCallBack(function()
            --self.disboardBtn.scaleButton.interactable = true
            UIMgr:closeSpecificUI(self)
            --end)
            GameMsgMgr:sendEvent(GameMsgType.OnWeaponChange)
        end)
    end
end

--[[
/MsgPanel/CompareBtn onClick 
--]]
function WeaponPanel:compareBtn_ScaleButton_onClick(compareBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.wearWeaponId == 0 then
        return
    end
    if self.comparePanel.activeSelf then
        self.compareTxt.text.text = "对比"
        self.comparePanel:SetActive(false)
        self.compareArrow.transform.localRotation = Quaternion.Euler(0, 0, 0)
        -- self.bgList.transform:DOLocalRotateQuaternion(Quaternion.Euler(100, 0, 0), 0.5)
        -- self.weaponBg.transform:DOLocalMoveX(self.weaponBg.transform.localPosition.x + 150, 0.5)
    else
        self.compareTxt.text.text = "收起"
        self.comparePanel:SetActive(true)
        self:setCompareWeaponInfo(self.wearWeaponId)
        self.compareArrow.transform.localRotation = Quaternion.Euler(0, 0, 180)
        -- self.bgList.transform:DOLocalRotateQuaternion(Quaternion.Euler(100, 10, 0), 0.5)
        -- self.weaponBg.transform:DOLocalMoveX(self.weaponBg.transform.localPosition.x - 150, 0.5)
    end
end

--[[
/ComparePanel/NameBg/CompareLockBtn onClick 
--]]
function WeaponPanel:compareLockBtn_ScaleButton_onClick(compareLockBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    Me:changeWeaponLockStateReq({weaponId = self.wearWeaponId}, function()
        self:setWeaponListData(true, true)
        self:setCompareWeaponInfo(self.wearWeaponId)
    end)
end

--[[
/WeaponPanel/SortPanel/SortMask onClick 
--]]
function WeaponPanel:sortMask_Button_onClick(sortMask)
    self.sortSelectList:SetActive(false)
    self.sortMask:SetActive(false)
end

--[[
/Custom/SortTypeBtn onClick 
--]]
function WeaponPanel:sortTypeBtn_ScaleButton_onClick(sortTypeBtn)

end

return WeaponPanel
