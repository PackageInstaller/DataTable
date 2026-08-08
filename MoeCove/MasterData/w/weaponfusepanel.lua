---@class WeaponFusePanel : WeaponFusePanel_Generate
---##################### 【WeaponFusePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【WeaponFusePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local WeaponFusePanel = require "WeaponFusePanel_Generate"

function WeaponFusePanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.RefreshTopResource, function()
            self.customBackPanel.customBackPanel:RefreshTopResource()
        end},
    }
    self:clear()
    self.weaponList.loopGridView:InitGridView(0, BindCallback_NoParams(self, self.changeWeaponBoxData))
end

function WeaponFusePanel:clear()

    self.needFuseWeponCount = 2         --融合武器个数
    self.selectFuseWeaponMap = {}       --选中的武器数据
    self.fuseWeaponBoxList = {}         --显示的融合武器格子
    self.lockAttrGroupId = {}           --锁定的词条id
    self.openPanelWeaponId = 0          --外部传入选中武器id
    self.selectWeaponCid = 0            --选中武器的Cid
    self.haveWeaponSkillMap = {}        --融合的武器是否有技能

    self.nowWeaponSortIndex = 1      --当前武器排序
    self.weaponSortBtnlist = {}
    self.nowWeaponSortFace = 1
end

function WeaponFusePanel:InitPanel()
    self:initFuseWeaponBox()
    self:setWeaponListData()
    
    local UICamera = UIMgr.uiCamera
    UICamera.orthographic = true
    self:resetSortingOrder()
    self:SetPostProcessing()
end

--function WeaponFusePanel:StartCreating(time)
--
--end

--function WeaponFusePanel:StartEnter(time)
--
--end

--function WeaponFusePanel:StartRemoving(time)
--
--end

--function WeaponFusePanel:StartExit(time)
--
--end

function WeaponFusePanel:OnOpen(data, initiative)
    --导航栏
    self.customBackPanel.customBackPanel:Bind(GE.NavigationType.WeaponFusePanel, self)
    self.customBackPanel.customBackPanel:OverrideBackFunc(function()
        self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = false
        self.animator:SetTrigger("Out")
        self.animOverCallBack:SetCallBack(function()
            self:clear()
            self:setFuseWeaponBoxData()
            self:refreshNewWeaponData()
            UIMgr:closeUI(self)
            self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = true
            self.customBackPanel.customBackPanel:ClearInstructionsOpenFunc()
            self.customBackPanel.customBackPanel:ClearInstructionsCloseFunc()
        end)

    end)
    self.customBackPanel.customBackPanel:OverrideInstructionsOpenFunc(function()
        self.iconNewBox:SetActive(false)
    end)

    self.customBackPanel.customBackPanel:OverrideInstructionsCloseFunc(function()
        self.iconNewBox:SetActive(true)
    end)

    --if initiative then
    if data and data.weaponId then
        self.openPanelWeaponId = data.weaponId
    end
    self:InitPanel()
    --end
end

--武器筛选及排序
function WeaponFusePanel:weaponSortFunc()
    local weaponMapData = Me:getAllWeaponData()

    self.weaponListData = {}
    for _, weaponData in pairs(weaponMapData) do
        local weaponConfig = Config.GetWeaponInfo(weaponData.cid)
        if weaponData.level == weaponConfig.levelMax and weaponConfig.rare >= 4 then
            table.insert(self.weaponListData, weaponData)
        end
    end

    self:WeaponSortInfo()
    self:setWeaponSortView()
end

--初始化武器列表
function WeaponFusePanel:setWeaponListData(isRefresh)
    self:weaponSortFunc()

    self.weaponList.loopGridView:SetListItemCount(tablex.size(self.weaponListData), false)
end

--刷新武器格子数据
function WeaponFusePanel:changeWeaponBoxData(gridView, index, row, col)
    local loopListViewItem = gridView:GetShownItemByItemIndex(index)
    if loopListViewItem == nil then
        loopListViewItem = gridView:NewListViewItem("CustomBox")
    end
    local customBoxObj = loopListViewItem.gameObject
    EngineUtil.FillPeer(self.customBox, customBoxObj)

    local needIndex = index + 1

    local customBox = customBoxObj.customBox
    local weaponData = self.weaponListData[needIndex]
    local weaponConfig = Config.GetWeaponInfo(weaponData.cid)
    local customData = {
        id = weaponData.cid,
        itemType = GE.ItemTypeIndex.weapon,
        scale = 0.8,
        isLock = weaponData.isLock,
        itemNum = "+"..weaponData.level,
        ownerId = weaponData.ownerId,
        ownerPanelName = self.uiConfig.id,
        delBtnListener = function()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            for key, selectData in pairs(self.selectFuseWeaponMap) do
                if selectData and selectData.id == weaponData.id then--移除
                    self.selectFuseWeaponMap[key] = nil
                    self.lockAttrGroupId = {}
                    if tablex.size(self.selectFuseWeaponMap) == 0 then
                        self.selectWeaponCid = 0
                    end
                    self.haveWeaponSkillMap[weaponData.id] = nil
                    break
                end
            end
            self.weaponList.loopGridView:RefreshAllShownItem2()
            self:setFuseWeaponBoxData()
            self:refreshNewWeaponData()
        end,
        listener = function()
            
            if weaponData.ownerId ~= 0 then
                UICommonUtils.PopToast("该武器装备中，请先卸下!")
                return
            end
            if weaponData.isLock then
                UICommonUtils.PopToast("该武器处于锁定状态!")
                return
            end
            if self.selectWeaponCid ~= 0 and weaponConfig.id ~= self.selectWeaponCid then
                UICommonUtils.PopToast("武器类型不同!")
                return
            end
            local isSelect = false
            for key, selectData in pairs(self.selectFuseWeaponMap) do
                if selectData and selectData.id == weaponData.id then--移除
                    isSelect = true
                    self.selectFuseWeaponMap[key] = nil
                    self.lockAttrGroupId = {}
                    if tablex.size(self.selectFuseWeaponMap) == 0 then
                        self.selectWeaponCid = 0
                    end
                    self.haveWeaponSkillMap[weaponData.id] = nil
                    break
                end
            end
            if tablex.size(self.selectFuseWeaponMap) >= self.needFuseWeponCount then
                return
            end
            if not isSelect then--选中
                for i = 1, self.needFuseWeponCount do
                    if not self.selectFuseWeaponMap[i] then
                        self.selectFuseWeaponMap[i] = weaponData
                        self.selectWeaponCid = weaponConfig.id
                        self:weaponSortFunc()
                        local btnSoundPath = string.format(Config.AudioPath.SE, "weaponselect")
                        self:play2DSound(btnSoundPath)
                        break
                    end
                end
            end
            self.weaponList.loopGridView:RefreshAllShownItem2()
            self:setFuseWeaponBoxData()
            self:refreshNewWeaponData()
        end
    }
    for _, selectData in pairs(self.selectFuseWeaponMap) do
        if selectData.id == weaponData.id then
            customData.isIn = true
            customData.isInIsOne = true
            customData.delBtnState = true
            break
        end
    end
    customBox:setCommonMask((self.selectWeaponCid ~= 0 and weaponConfig.id ~= self.selectWeaponCid)
    or (weaponData.ownerId ~= 0))
    customBox:setMono(self)
    customBox:refreshUI(customData)

    return loopListViewItem
end

--初始化融合武器格子
function WeaponFusePanel:initFuseWeaponBox()
    self:FillTemplateContent(self.weaponBox, self.selectList, self.needFuseWeponCount, function(index, weaponBox)
        weaponBox.transform.position = self["boxPos"..index].transform.position
        table.insert(self.fuseWeaponBoxList, weaponBox)
        weaponBox:SetActive(false)
        if index == self.needFuseWeponCount then
            --外部选中装备时初始化选中
            if self.openPanelWeaponId ~= 0 then
                for key, weaponData in pairs(self.weaponListData) do
                    if self.openPanelWeaponId == weaponData.id then
                        self.openPanelWeaponId = 0
                        if weaponData.isLock then
                            UICommonUtils.PopToast("该武器处于锁定状态!")
                            break
                        end
                        if weaponData.ownerId ~= 0 then
                            UICommonUtils.PopToast("该武器处于装备状态!")
                            break
                        end
                        local weaponConfig = Config.GetWeaponInfo(weaponData.cid)
                        self.selectFuseWeaponMap[1] = weaponData
                        self.selectWeaponCid = weaponConfig.id
                        self:setFuseWeaponBoxData()
                        self.weaponList.loopGridView:MovePanelToItemByIndex(key - 1, 0)
                    end
                end
            else
                self:setFuseWeaponBoxData()
            end
        end
    end)

    local weaponFuseItem = Config.GetConfigInfo("WeaponEntryLock")[1][1]
    self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, "ItemIcon_"..weaponFuseItem), self.resIcon.image)
end

--设置融合武器格子数据
function WeaponFusePanel:setFuseWeaponBoxData()
    for k, weaponBox in pairs(self.fuseWeaponBoxList) do
        if self.selectFuseWeaponMap[k] then
            local weaponData = self.selectFuseWeaponMap[k]
            local weaponConfig = Config.GetWeaponInfo(weaponData.cid)

            --相关武器图片
            self:LoadSpriteAsync(string.format(Config.SpritePath.EquipShowRankBg, weaponConfig.rare), self["iconBox"..k].weaponFrame.image)
            self:LoadSpriteAsync(string.format(Config.SpritePath.WeaponIconPath, weaponConfig.icon), self["iconBox"..k].weaponIcon.image)

            self["iconBox"..k].nameText.text.text = weaponConfig.name

            weaponBox.accuracyNum.text.text = weaponData.accuracy
            weaponBox.qualityNum.text.text = weaponData.quality
            weaponBox.scoreText.text.text = math.floor((weaponConfig.bulletNum * weaponData.accuracy * weaponData.quality / 1000))

            local needAttrList = {}
            for attrType, attrData in pairs(weaponData.attributeValue) do
                local entryList = Config.GetWeaponEntryInfoByGroup(attrType)
                local data = {
                    name = entryList[1].name,
                    valueType = entryList[1].type,
                    groupId = entryList[1].group,
                    value = attrData.value,
                    type = entryList[1].attributeId,
                    isSpecial = attrData.isSpecial,
                }
                needAttrList[attrData.id] = data
            end
            weaponBox.skillPanel:SetActive(false)
            self:FillTemplateContent(self.attributeBox, weaponBox.attributeList, 6, function(index, attributeBox)
                if needAttrList[index] then
                    attributeBox.msgTIpsTxt.text.text = needAttrList[index].name
                    if needAttrList[index].valueType == GE.WeaponEntryAttrType.integer then--数值
                        attributeBox.msgNumTxt.text.text = needAttrList[index].value
                    elseif needAttrList[index].valueType == GE.WeaponEntryAttrType.percentage then--百分比
                        attributeBox.msgNumTxt.text.text = needAttrList[index].value.."%"
                    elseif needAttrList[index].valueType == GE.WeaponEntryAttrType.specialSkill then--特殊技能
                        attributeBox.haveAttr:SetActive(false)
                        attributeBox.noAttr:SetActive(true)
                        weaponBox.skillPanel:SetActive(true)
                        local skillConfig = Config.GetSkillInfo(needAttrList[index].value)
                        weaponBox.skillPanel.weaponSkillTxt.text.text = skillConfig.desKey
                        self.haveWeaponSkillMap[weaponData.id] = needAttrList[index].value--技能Id
                        return
                    end
                    self:LoadSpriteAsync(string.format(Config.SpritePath.AttributeIcon, needAttrList[index].type), function(s)
                        if s then
                            attributeBox.msgIcon.image.sprite = s
                        end
                    end)
                    if needAttrList[index].isSpecial then
                        attributeBox.msgNumTxt.text.color = Color.NewFromStr("FF8019")
                    else
                        attributeBox.msgNumTxt.text.color = Color.NewFromStr("494949")
                    end
                    attributeBox.scaleButton.onClick:RemoveAllListeners()
                    attributeBox.scaleButton.onClick:AddListener(function()
                        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
                        if next(self.lockAttrGroupId) then
                            --取消选中
                            if self.lockAttrGroupId[weaponData.id] and self.lockAttrGroupId[weaponData.id].groupId == needAttrList[index].groupId then
                                self.lockAttrGroupId[weaponData.id] = nil
                                for _, groupIdData in pairs(self.lockAttrGroupId) do
                                    groupIdData.orderId = tablex.size(self.lockAttrGroupId)
                                end
                                self:setFuseWeaponBoxData()
                                self:refreshNewWeaponData()
                            end
                            return
                        end
                        --选中
                        self.lockAttrGroupId[weaponData.id] = {
                            orderId = tablex.size(self.lockAttrGroupId) + 1,
                            groupId = needAttrList[index].groupId,
                        }
                        self:setFuseWeaponBoxData()
                        self:refreshNewWeaponData()
                    end)

                    --根据选中词条显示词条状态
                    local lockIdData = self.lockAttrGroupId[weaponData.id]
                    local isLimit = next(self.lockAttrGroupId) and true or false
                    local isSelect = (lockIdData and lockIdData.groupId == needAttrList[index].groupId) and true or false
                    attributeBox.selectBox:SetActive(isSelect)
                    attributeBox.notBox:SetActive(isLimit)
                    attributeBox.errorBox:SetActive(false)
                    for _, value in pairs(self.lockAttrGroupId) do
                        if value.groupId == needAttrList[index].groupId and not isSelect then
                            attributeBox.errorBox:SetActive(true)
                            break
                        end
                    end
                end
                attributeBox.haveAttr:SetActive(needAttrList[index] and true or false)
                attributeBox.noAttr:SetActive(not needAttrList[index] and true or false)
            end)
            self["iconBox"..k].isShow:SetActive(self.selectFuseWeaponMap[k] and true or false)
            self["iconBox"..k].tobeSelect:SetActive(not self.selectFuseWeaponMap[k] and true or false)
            weaponBox:SetActive(self.selectFuseWeaponMap[k] and true or false)
            self["point"..k].emptyText:SetActive(not self.selectFuseWeaponMap[k] and true or false)
        else
            self["iconBox"..k].isShow:SetActive(false)
            self["iconBox"..k].tobeSelect:SetActive(true)
            weaponBox:SetActive(false)
            self["point"..k].emptyText:SetActive(true)
        end
    end
end

--刷新新武器数据
function WeaponFusePanel:refreshNewWeaponData(newWeaponId)
    if tablex.size(self.selectFuseWeaponMap) < self.needFuseWeponCount and not newWeaponId then
        self.newBox.emptyText:SetActive(true)
        self.newBox.fireInfo:SetActive(false)
        self.iconNewBox.isShow:SetActive(false)
        self.iconNewBox.tobeSelect:SetActive(true)
        for k, weaponBox in pairs(self.fuseWeaponBoxList) do
            weaponBox.accuracyNum.text.color = Color.NewFromStr("494949")
            weaponBox.qualityNum.text.color = Color.NewFromStr("494949")
        end
        for i = 1, self.needFuseWeponCount do
            self["point"..i].noneIcon:SetActive(false)
        end
        return
    else
        self.newBox.emptyText:SetActive(false)
        self.newBox.fireInfo:SetActive(true)
    end
    self.iconNewBox.isNew:SetActive(newWeaponId and true or false)
    local newData = {
        accuracy = 0,
        quality = 0,
        attributeValue = {},
    }
    if newWeaponId then
        for i = 1, self.needFuseWeponCount do
            self["point"..i].emptyText:SetActive(false)
            self["point"..i].noneIcon:SetActive(true)
        end
        local needData = Me:getWeaponDataById(newWeaponId)
        newData = needData

        --TODO: 这里做特效吧！
        self.effectMask:SetActive(true)
        self.effectMask.canvasGroup:DOFade(1, 1)
        self.effectList:SetActive(true)
        local laterTime = 4
        if self.laterTimer then
            DLuaTimer:RemoveTimer(self.laterTimer)
        end
        self.laterTimer = DLuaTimer:DoAfter(laterTime, function()
            self.effectList:SetActive(false)
            self.effectMask.canvasGroup:DOFade(0, 0.1):OnComplete(function()
                self.effectMask:SetActive(false)
            end)
        end)

        if self.boxTimer then
            DLuaTimer:RemoveTimer(self.boxTimer)
        end
        self.boxTimer = DLuaTimer:DoAfter(laterTime - 1.2, function()
            self.iconNewBox.isShow:SetActive(true)
            self.iconNewBox.tobeSelect:SetActive(false)
        end)
    else
        for _, weaponData in pairs(self.selectFuseWeaponMap) do
            newData.cid = weaponData.cid
            newData.accuracy = math.max(newData.accuracy, weaponData.accuracy)
            newData.quality = math.max(newData.quality, weaponData.quality)
            if self.lockAttrGroupId[weaponData.id] then
                newData.attributeValue[self.lockAttrGroupId[weaponData.id].groupId] = {
                    id = self.lockAttrGroupId[weaponData.id].orderId,
                    value = weaponData.attributeValue[self.lockAttrGroupId[weaponData.id].groupId].value,
                    isSpecial = weaponData.attributeValue[self.lockAttrGroupId[weaponData.id].groupId].isSpecial
                }
            end
        end
    end

    local weaponConfig = Config.GetWeaponInfo(newData.cid)
    self.newBox.accuracyNum.text.text = newData.accuracy
    self.newBox.qualityNum.text.text = newData.quality
    self.newBox.scoreText.text.text = math.floor((weaponConfig.bulletNum * newData.accuracy * newData.quality / 1000))

    --相关武器图片
    self:LoadSpriteAsync(string.format(Config.SpritePath.EquipShowRankBg, weaponConfig.rare), self.iconNewBox.weaponFrame.image)
    self:LoadSpriteAsync(string.format(Config.SpritePath.WeaponIconPath, weaponConfig.icon), self.iconNewBox.weaponIcon.image)

    local needAttrList = {}
    for attrType, attrData in pairs(newData.attributeValue) do
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
    self.newBox.skillPanel:SetActive(false)
    local lockAttrNum = tablex.size(self.lockAttrGroupId)
    local maxEntryNum = newWeaponId and #needAttrList or weaponConfig.entryMax
    self:FillTemplateContent(self.newBox.attributeBox, self.newBox.attributeList, maxEntryNum, function(index, attributeBox)
        if needAttrList[index] then
            attributeBox.attrTxt.text.text = needAttrList[index].name
            if needAttrList[index].valueType == GE.WeaponEntryAttrType.integer then--数值
                attributeBox.msgNumTxt.text.text = needAttrList[index].value
            elseif needAttrList[index].valueType == GE.WeaponEntryAttrType.percentage then--百分比
                attributeBox.msgNumTxt.text.text = needAttrList[index].value.."%"
            elseif needAttrList[index].valueType == GE.WeaponEntryAttrType.specialSkill then--特殊技能
                attributeBox:SetActive(false)
                self.newBox.skillPanel:SetActive(true)
                self.newBox.showSkill:SetActive(true)
                self.newBox.lockedSkill:SetActive(false)
                local skillConfig = Config.GetSkillInfo(needAttrList[index].value)
                self.newBox.weaponSkillTxt.text.text = skillConfig.desKey
            end
            self:LoadSpriteAsync(string.format(Config.SpritePath.AttributeIcon, needAttrList[index].type), function(s)
                if s then
                    attributeBox.attrIcon.image.sprite = s
                end
            end)
            if needAttrList[index].isSpecial then
                attributeBox.msgNumTxt.text.color = Color.NewFromStr("FF8019")
            else
                attributeBox.msgNumTxt.text.color = Color.NewFromStr("494949")
            end
        else
            attributeBox.unlockText.text.text = "?"
        end
        --合成预览时根据情况显示技能
        if not newWeaponId and index == weaponConfig.entryMax then
            attributeBox:SetActive(false)
            local singleSkill = tablex.size(self.haveWeaponSkillMap) == 1
            local fullSkill = tablex.size(self.haveWeaponSkillMap) == self.needFuseWeponCount
            self.newBox.skillPanel:SetActive(singleSkill or fullSkill)
            self.newBox.lockedSkill:SetActive(fullSkill)
            self.newBox.showSkill:SetActive(singleSkill)
            for _, skillId in pairs(self.haveWeaponSkillMap) do
                local skillConfig = Config.GetSkillInfo(skillId)
                self.newBox.weaponSkillTxt.text.text = skillConfig.desKey
            end
        end
        
        if newWeaponId then 
            if lockAttrNum > 0 and index == 1 then
                return
            end
            attributeBox.lockedAttr:SetActive(true)
            DLuaTimer:DoAfter(2.8 + index * 0.03, function()
                attributeBox.lockedAttr:SetActive(false)
                attributeBox.showAttr:SetActive(true)
            end)
        else
            attributeBox.showAttr:SetActive(needAttrList[index] and true or false)
            attributeBox.lockedAttr:SetActive(not needAttrList[index] and true or false)
        end
    end)

    self.newBox.inheritBg:SetActive(not newWeaponId and true or false)
    self.newBox.inheritNum.text.text = tablex.size(needAttrList).."/1"

    --显示道具消耗
    self.resNumText.text.color = Color.NewFromStr("494949")
    self.haveFuseItem = true
    if lockAttrNum ~= 0 then
        local entryLockConfig = Config.GetConfigInfo("WeaponEntryLock")[lockAttrNum]
        local haveNum = Me:getItemById(entryLockConfig[1]) and Me:getItemById(entryLockConfig[1]).num or 0
        local needNum = entryLockConfig[2]
        self.resNumText.text.text = needNum
        if needNum > haveNum then
            self.haveFuseItem = false
            self.resNumText.text.color = Color.NewFromStr("FF3535")
        end
    else
        self.resNumText.text.text = "——"
    end
    
    --突出显示自动选中的武器基础属性
    for k, weaponBox in pairs(self.fuseWeaponBoxList) do
        local weaponData = self.selectFuseWeaponMap[k]
        if weaponData then
            if weaponData.accuracy == newData.accuracy then
                weaponBox.accuracyNum.text.color = Color.NewFromStr("5FB34F")
            end
            if weaponData.quality == newData.quality then
                weaponBox.qualityNum.text.color = Color.NewFromStr("5FB34F")
            end
        end
    end
end

---------------------------------------------------------------------------------------

--武器排序初始化
function WeaponFusePanel:WeaponSortInfo()
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
function WeaponFusePanel:refreshSortView()
    for k,v in pairs(self.weaponSortBtnlist) do
        v.obj.isOpen:SetActive(self.nowWeaponSortIndex == v.key)
    end
end

--设置武器排序详情
function WeaponFusePanel:setWeaponSortView()
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
                    if a_config.type > b_config.type then
                        return true
                    elseif a_config.type < b_config.type then
                        return false
                    else
                        return a_config.id < b_config.id
                    end
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

--重置sortingOrder
function WeaponFusePanel:resetSortingOrder()
    local nowOrder = self.transform:GetComponent("Canvas").sortingOrder
    local effects = {self.effect_Ui_WeaponFuse_1, self.effect_Ui_WeaponFuse_2_L, self.effect_Ui_WeaponFuse_2_R}
    
    for _, effect in ipairs(effects) do
        local effectTransform = effect.transform
        for j = 1, effectTransform.childCount do
            local particleSystemRenderer = effectTransform:GetChild(j - 1):GetComponent("ParticleSystemRenderer")
            particleSystemRenderer.sortingOrder = nowOrder + 1
        end
    end

    self.iconNewBox.canvas.sortingLayerName = "UI"
    self.iconNewBox.canvas.sortingOrder = nowOrder + 2
end

--设置相机的后处理
function WeaponFusePanel:SetPostProcessing()
    --特效相关
    --local UICamera = UIMgr.uiCamera
    --local cameraData = UICamera:GetComponent(typeof(UnityEngine.Rendering.Universal.UniversalAdditionalCameraData))
    --if cameraData then
    --    cameraData.renderPostProcessing = true                      --后处理
    --    cameraData.volumeTrigger = self.uiVolume.transform          --特效触发器
    --    cameraData.volumeLayerMask = LayerMask.GetMask("UI")            --默认层和UI层
    --end
end

--function WeaponFusePanel:OnClose(initiative)
--
--end

function WeaponFusePanel:OnDestroy()
	local UICamera = UIMgr.uiCamera
    if UICamera then
        UICamera.orthographic = false
    end
    if self.laterTimer then
        DLuaTimer:RemoveTimer(self.laterTimer)
    end
    if self.boxTimer then
        DLuaTimer:RemoveTimer(self.boxTimer)
    end

    self.super:OnDestroy(self)
end

--function WeaponFusePanel:OnRefresh(data)
--
--end

--[[
/WeaponPanel/SortBg/SortStateBtn onClick 
--]]
function WeaponFusePanel:sortStateBtn_ScaleButton_onClick(sortStateBtn)
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
/FuseBtn onClick 
--]]
function WeaponFusePanel:fuseBtn_ScaleButton_onClick(fuseBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if tablex.size(self.selectFuseWeaponMap) < self.needFuseWeponCount then
        return
    end
    if not self.haveFuseItem then
        return
    end
    local fuseList = {}
    for _, weaponData in pairs(self.selectFuseWeaponMap) do
        local fuseData = {
            weaponId = weaponData.id,
            lockGroupId = self.lockAttrGroupId[weaponData.id] and self.lockAttrGroupId[weaponData.id].groupId or -1,
        }
        --fuseList[self.lockAttrGroupId[weaponData.id].orderId] = fuseData
        table.insert(fuseList, fuseData)
    end
    Me:fuseWeaponReq({fuseList = fuseList}, function(newWeaponId)
        self.selectFuseWeaponMap = {}
        self.selectWeaponCid = 0
        self.haveWeaponSkillMap = {}
        self:setWeaponListData()
        self.weaponList.loopGridView:RefreshAllShownItem2()
        self:setFuseWeaponBoxData()
        self:refreshNewWeaponData(newWeaponId)
        self.lockAttrGroupId = {}
        local btnSoundPath = string.format(Config.AudioPath.SE, "weaponsynthesis")
        self:play2DSound(btnSoundPath)
    end)
end

--[[
/ClearBtn onClick 
--]]
function WeaponFusePanel:clearBtn_ScaleButton_onClick(clearBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.selectFuseWeaponMap = {}
    self.lockAttrGroupId = {}
    self.selectWeaponCid = 0
    self.haveWeaponSkillMap = {}
    self.weaponList.loopGridView:RefreshAllShownItem2()
    self:setFuseWeaponBoxData()
    self:refreshNewWeaponData()
end

--[[
/WeaponPanel/SortPanel/SortMask onClick 
--]]
function WeaponFusePanel:sortMask_Button_onClick(sortMask)
    self.sortSelectList:SetActive(not self.sortSelectList.activeSelf)
    self.sortMask:SetActive(self.sortSelectList.activeSelf)
    if self.sortSelectList.activeSelf then
        self:refreshSortView()
    end
end

--[[
/WeaponPanel/SortPanel/SortBg/SortBtn onClick 
--]]
function WeaponFusePanel:sortBtn_ScaleButton_onClick(sortBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.sortSelectList:SetActive(not self.sortSelectList.activeSelf)
    self.sortMask:SetActive(self.sortSelectList.activeSelf)
    if self.sortSelectList.activeSelf then
        self:refreshSortView()
    end
end

return WeaponFusePanel
