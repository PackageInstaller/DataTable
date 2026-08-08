---@class PosterPanel : PosterPanel_Generate
---##################### 【PosterPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【PosterPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local PosterPanel = require "PosterPanel_Generate"

function PosterPanel:InitLogic(data)
    self.btnSoundPath = string.format(Config.AudioPath.SE, "click")
    self.msgEventHandler = {
        {GameMsgType.RefreshTopResource, function()
            self.customBackPanel.customBackPanel:RefreshTopResource()
        end},
	}
    self.nowSortMode = 1    --当前排序模式 默认
    self.sortBtnlist = {}
    self.natureBtnlist = {}
    self.nowSortIndex = 1
    self.lastSortIndex = nil --上次选中的模式
    self.nowNatureMode = nil

    self.filtrateData = nil
    self.nowSortFace = 1            --排序正反 默认从大到小
    self.RoleList = {}

    self.nowSelectIndex = nil
    self.roleObjList = {}

    self.nowSelectSkinId = nil
    self.skinObjList = {}
    self._skinListLoadVersion = 0
    self.nowShowSpineObj = nil
    self.roleList.loopGridView:InitGridView(0, BindCallback_NoParams(self, self.changeCustomRoleBoxData))
end

--function PosterPanel:StartCreating(time)
--
--end

--function PosterPanel:StartEnter(time)
--
--end

--function PosterPanel:StartRemoving(time)
--
--end

--function PosterPanel:StartExit(time)
--
--end

function PosterPanel:OnOpen(data, initiative)
    --导航栏
    self:__RefreshNavigation()
    self:SetView()
    if not initiative then
        self:refreshRoleBoxList()
    end
    self:SortInfo()
    if self.sortSelectList.activeSelf then
        if self.nowSortIndex == GE.RoleSortType.nature and self.nowNatureMode == nil then
            self.sortSelectList:SetActive(false)
            self.nowSortIndex = self.lastSortIndex
            self.nowSortMode = self.lastSortIndex
            if self.nowSortMode == GE.RoleSortType.nature and self.nowNatureMode ~= nil then
                self.sortTxt.text.text = LocalStrEnum["NatureType_"..GE.NatureType[GE.NatureTypeName[self.nowNatureMode]]]
            else
                self.sortTxt.text.text = LocalStrEnum["RoleSortType_"..GE.RoleSortType[GE.RoleSortTypeName[self.nowSortMode]]]
            end
        end
    end
    self:refreshSortView()
end

--刷新导航栏
function PosterPanel:__RefreshNavigation()
    self.customBackPanel.customBackPanel:Bind(GE.NavigationType.PosterPanel)
    self.customBackPanel.customBackPanel:OverrideBackFunc(function()
        self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = false
        self.animator:SetTrigger("Out")
        self.animOverCallBack:SetCallBack(function()
            local MainPanel = UIMgr:getUIData("MainPanel")
            if MainPanel then
                MainPanel.ui:PosterPanelMode(false)
            end
            UIMgr:closeUI(self)
            self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = true
        end)

        --清空返回方法
        self.customBackPanel.customBackPanel:ClearBackFunc()
    end)
end

--根据筛选信息显示
function PosterPanel:SetFiltrate(FiltrateData)
    local function CheackFiltrateDataByType(typeName, data)
        for key, value in pairs(FiltrateData[typeName]) do
            if value == data or value == 0 then
                return true
            end
        end
        return false
    end

    local roleList = ClientData:GetRoleList()
    self.RoleList = {}
    for _,v in pairs(roleList) do
        local data = {
            server = v,
            config = Config.GetCharacterInfo(v.id)
        }

        if FiltrateData ~= nil then
            if CheackFiltrateDataByType("StarList", data.server.star) and
                CheackFiltrateDataByType("RankList", data.config.rank) and 
                CheackFiltrateDataByType("TypeList", data.config.attribute) then
                table.insert(self.RoleList, data)
            end
        else
            table.insert(self.RoleList, data)
        end
    end
    self:SetSortView()
end

--设置排序
function PosterPanel:SetSortView()
    local function compareValues(aValue, bValue, ascending)
        if ascending then
            return aValue > bValue
        else
            return aValue < bValue
        end
    end
    --获取排序方法
    local function getComparisonFunction()
        local ascending = self.nowSortFace == 1
        if self.nowSortIndex == GE.RoleSortType.default then
            return function(a, b)
                if a.server.level ~= b.server.level then
                    return compareValues(a.server.level, b.server.level, ascending)
                elseif a.config.rank ~= b.config.rank then
                    return compareValues(a.config.rank, b.config.rank, ascending)
                else
                    -- 等级和品质均相同时，获取时间越早的排越后
                    return a.server.getTime > b.server.getTime
                end
            end
        elseif self.nowSortIndex == GE.RoleSortType.level then
            return function(a, b)
                return compareValues(a.server.level, b.server.level, ascending)
            end
        elseif self.nowSortIndex == GE.RoleSortType.star then
            return function(a, b)
                return compareValues(a.server.star, b.server.star, ascending)
            end
        elseif self.nowSortIndex == GE.RoleSortType.quality then
            return function(a, b)
                return compareValues(a.config.rank, b.config.rank, ascending)
            end
        elseif self.nowSortIndex == GE.RoleSortType.getTime then
            return function(a, b)
                return compareValues(a.server.getTime, b.server.getTime, ascending)
            end
        elseif self.nowSortIndex == GE.RoleSortType.allDmg then
            return function(a, b)
                return compareValues(a.server.allDmg, b.server.allDmg, ascending)
            end
        elseif self.nowSortIndex == GE.RoleSortType.nature then
            local attribute = GE.NatureTypeName[self.nowNatureMode]
            return function(a, b)
                return compareValues(a.server[attribute], b.server[attribute], ascending)
            end
        end
    end

    local comparisonFunction = getComparisonFunction()
    if comparisonFunction then
        table.sort(self.RoleList, comparisonFunction)
    end
end

--初始化排序按钮列表
function PosterPanel:SortInfo()
    self.sortBtnlist = {}
    if self.nowSortMode == GE.RoleSortType.nature and self.nowNatureMode ~= nil then
        self.sortTxt.text.text = LocalStrEnum["NatureType_"..GE.NatureType[GE.NatureTypeName[self.nowNatureMode]]]
    else
        self.sortTxt.text.text = LocalStrEnum["RoleSortType_"..GE.RoleSortType[GE.RoleSortTypeName[self.nowSortMode]]]
    end
    self:FillTemplateContent(self.sortTypeBtn, self.sortSelectList, tablex.size(GE.RoleSortTypeName), function(index, sortTypeBtn)
        if GE.RoleSortTypeName[index] == GE.RoleSortType.favorability then
            sortTypeBtn:SetActive(false)
            return
        end

        local temp = {
            obj = sortTypeBtn,
            key = index,
        }
        table.insert(self.sortBtnlist, temp)
        sortTypeBtn.sortTypeTxtOff.text.text =  LocalStrEnum["RoleSortType_"..GE.RoleSortType[GE.RoleSortTypeName[index]]]
        sortTypeBtn.sortTypeTxt.text.text =  LocalStrEnum["RoleSortType_"..GE.RoleSortType[GE.RoleSortTypeName[index]]]
        sortTypeBtn.isEx:SetActive(GE.RoleSortType[GE.RoleSortTypeName[index]] == GE.RoleSortType.nature)
        --初始化属性按钮
        if GE.RoleSortType[GE.RoleSortTypeName[index]] == GE.RoleSortType.nature then
            self.natureBtnlist = {}
            self:FillTemplateContent(self.natureNameBtn, sortTypeBtn.natureList, tablex.size(GE.NatureTypeName), function(key, natureNameBtn)
                natureNameBtn.natureNameTxtOff.text.text =  LocalStrEnum["NatureType_"..GE.NatureType[GE.NatureTypeName[key]]]
                natureNameBtn.natureNameTxt.text.text =  LocalStrEnum["NatureType_"..GE.NatureType[GE.NatureTypeName[key]]]
                local t = {
                    obj = natureNameBtn,
                    key = key,
                }
                table.insert(self.natureBtnlist, t)
                natureNameBtn.scaleButton.onClick:RemoveAllListeners()
                natureNameBtn.scaleButton.onClick:AddListener(function()
                    self:play2DSound(self.btnSoundPath)
                    self.nowNatureMode = key
                    self.sortSelectList:SetActive(false)
                    self.sortMask:SetActive(false)
                    self.sortTxt.text.text = LocalStrEnum["NatureType_"..GE.NatureType[GE.NatureTypeName[self.nowNatureMode]]]
                    for _, v in pairs(self.natureBtnlist) do
                        v.obj.isOpen:SetActive(self.nowNatureMode == v.key)
                    end
                    self:SetView(nil, true)
                end)
            end)
        end
        sortTypeBtn.scaleButton.onClick:RemoveAllListeners()
        sortTypeBtn.scaleButton.onClick:AddListener(function()
            self:play2DSound(self.btnSoundPath)
            self.lastSortIndex = self.nowSortIndex
            self.nowSortIndex = index
            if GE.RoleSortType[GE.RoleSortTypeName[self.nowSortIndex]] == GE.RoleSortType.nature then
                self.nowSortMode = GE.RoleSortType.nature
            else
                self.nowNatureMode = nil
                self.nowSortMode = GE.RoleSortType[GE.RoleSortTypeName[self.nowSortIndex]]
                self.sortTxt.text.text = LocalStrEnum["RoleSortType_"..GE.RoleSortType[GE.RoleSortTypeName[self.nowSortMode]]]
                self.sortSelectList:SetActive(false)
                self.sortMask:SetActive(false)
                self:SetView(nil, true)
            end
            self:refreshSortView()
            for _, v in pairs(self.natureBtnlist) do
                v.obj.isOpen:SetActive(self.nowNatureMode == v.key)
            end
        end)
    end)
end

function PosterPanel:changeCustomRoleBoxData(gridView, index, row, col)
    local function is_numeric(str)
        return tonumber(str) ~= nil
    end

    local loopListViewItem = gridView:GetShownItemByItemIndex(index)
    if loopListViewItem == nil then
        loopListViewItem = gridView:NewListViewItem("CustomRoleBox")
    end
    local customRoleBox = loopListViewItem.gameObject
    EngineUtil.FillPeer(self.customRoleBox, customRoleBox)

    local needIndex = index + 1
    local temp = {
        obj = customRoleBox,
        index = needIndex,
        data = self.RoleList[needIndex]
    }
    table.insert(self.roleObjList, temp)

    customRoleBox.transform.localScale = Vector3.New(0.8, 0.8, 1)

    customRoleBox:SetActive(true)
    customRoleBox.nameTxt.text.text = self.RoleList[needIndex].config.name
    customRoleBox.rankFarmeImg:SetActive(false)
    customRoleBox.typeIcon:SetActive(false)

    customRoleBox.isSelectMiddle:SetActive(needIndex == self.nowSelectIndex)

    local skinConfig = tablex.clone(Config.GetCharacterSkinInfo(self.RoleList[needIndex].server.equipSkin))
    local resourceFolder = nil
    if is_numeric(skinConfig.resourceFolder) then
        resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
    else
        resourceFolder = skinConfig.resourceFolder
    end
    customRoleBox._spriteLoadVersion = (customRoleBox._spriteLoadVersion or 0) + 1
    local loadVersion = customRoleBox._spriteLoadVersion
    self:LoadSpriteAsync(string.format(Config.SpritePath.IconRolePath, resourceFolder, skinConfig.driverKey), function(s)
        if loadVersion ~= customRoleBox._spriteLoadVersion then
            return
        end
        if not UICommonUtils.Checkobj(customRoleBox) or not customRoleBox.roleIconImg or not customRoleBox.roleIconImg.image then
            return
        end
        customRoleBox.roleIconImg.image.sprite = s
        customRoleBox.roleIconImg:SetActive(true)
        --customRoleBox.roleIconImg.image:SetNativeSize()
    end)

    local posterConfig = Config.GetCharacterSkinInfo(ClientData:GetPosterData().SkinId)
    customRoleBox.isEquip:SetActive(self.RoleList[needIndex].config.id == posterConfig.CharacterID)
    customRoleBox.btn.scaleButton.onClick:RemoveAllListeners()
    customRoleBox.btn.scaleButton.onClick:AddListener(function()
        self:play2DSound(self.btnSoundPath)
        self:setRoleListSelect(needIndex, true)
    end)

    return loopListViewItem
end

function PosterPanel:SetView(FiltrateData, isSort)
    self.filtrateData = FiltrateData
    self:SetFiltrate(self.filtrateData)

    self.roleList.loopGridView:SetListItemCount(tablex.size(self.RoleList))

    isSort = false

    self:RefreshBoxState()

    local listSize = tablex.size(self.RoleList)
    local loopGridView = self.roleList.loopGridView
    for i = 0, listSize - 1 do
        local item = loopGridView:GetShownItemByItemIndex(i)
        if item ~= nil then
            local trs = item.transform
            ---@type UnityEngine.CanvasGroup
            local rTrs = trs:Find("Btn")
            rTrs.anchoredPosition = Vector2.New(0, -20)
            local canvasGroup = rTrs:GetComponent(TypeInfo.CanvasGroup)
            canvasGroup.alpha = 0
            rTrs:DOKill()
            canvasGroup:DOKill()
            rTrs:DOAnchorPosY(0, 0.2):SetDelay(i * 0.02)
            canvasGroup:DOFade(1, 0.2):SetDelay(i * 0.02)
        end
    end
end

function PosterPanel:RefreshBoxState()
    -- 查找到当前已经设置的看板娘是哪个角色的
    local posterConfig = Config.GetCharacterSkinInfo(ClientData:GetPosterData().SkinId)
    -- 先更新所有可见格子的已装备标记
    for key, value in pairs(self.roleObjList) do
        value.obj.isEquip:SetActive(value.data.config.id == posterConfig.CharacterID)
    end
    -- 从完整数据列表中查找目标索引，避免格子不在可视区域时找不到
    for i, roleData in ipairs(self.RoleList) do
        if roleData.config.id == posterConfig.CharacterID then
            self:setRoleListSelect(i)
            return
        end
    end
end

function PosterPanel:refreshRoleBoxList()
    self.roleHeadBoxList = {}
    self.roleList.loopGridView:SetListItemCount(tablex.size(self.RoleList))
    self.roleList.loopGridView:RefreshAllShownItem2()
end

function PosterPanel:setRoleListSelect(index, isClick)
    if index == self.nowSelectIndex then
        return
    end
    self.nowSelectIndex = index

    -- 先用 RoleList 兜底，防止目标格子不在可视区域时 roleData 为空
    local roleData = self.RoleList[index] or {}
    for _, value in pairs(self.roleObjList) do
        if value.index == self.nowSelectIndex then
            value.obj.isSelectMiddle:SetActive(true)
            roleData = value.data
        else
            value.obj.isSelectMiddle:SetActive(false)
        end
    end
    local skinList = tablex.clone(Config.GetCharacterSkinInfoByCharacterID(roleData.config.id))

    for i = tablex.size(skinList), 1, -1 do
        local skinData = Me:getSkinData(skinList[i].id)
        if skinData == nil then
            table.remove(skinList, i)
        end
    end
    table.sort(skinList, function(a, b)
        return a.id < b.id
    end)
    self:SetSkinListView(skinList, isClick)
end

--设置皮肤列表
function PosterPanel:SetSkinListView(SkinListData, isClick)
    local function is_numeric(str)
        return tonumber(str) ~= nil
    end
    self.skinObjList = {}
    self._skinListLoadVersion = (self._skinListLoadVersion or 0) + 1
    local loadVersion = self._skinListLoadVersion
    self:FillTemplateContent(self.customSkinBox, self.content, tablex.size(SkinListData), function(index, customSkinBox)
        local temp = {
            obj = customSkinBox,
            index = index,
            data = SkinListData[index],
        }
        table.insert(self.skinObjList, temp)

        customSkinBox.btn.canvasGroup.alpha = 0
        DLuaTimer:DoAfter(index * 0.025, function()
            if loadVersion ~= self._skinListLoadVersion then
                return
            end
            if not UICommonUtils.Checkobj(customSkinBox) or not customSkinBox.btn or not customSkinBox.btn.canvasGroup then
                return
            end
            customSkinBox.btn.canvasGroup:DOFade(1, 0.2)
        end)
        customSkinBox:SetActive(true)
        local skinConfig = SkinListData[index]
        local resourceFolder = nil
        if is_numeric(skinConfig.resourceFolder) then
            resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
        else
            resourceFolder = skinConfig.resourceFolder
        end
        self:LoadSpriteAsync(string.format(Config.SpritePath.CutRolePath, resourceFolder, skinConfig.halfimgKey), function(s)
            if loadVersion ~= self._skinListLoadVersion then
                return
            end
            if not UICommonUtils.Checkobj(customSkinBox) or not customSkinBox.roleIconImg or not customSkinBox.roleIconImg.image then
                return
            end
            customSkinBox.roleIconImg.image.sprite = s
            customSkinBox.roleIconImg:SetActive(true)
            customSkinBox.roleIconImg.image:SetNativeSize()
        end)
        customSkinBox.btn.scaleButton.onClick:RemoveAllListeners()
        customSkinBox.btn.scaleButton.onClick:AddListener(function()
            self:play2DSound(self.btnSoundPath)
            self:setSkinSelect(skinConfig)
        end)

        if index == tablex.size(SkinListData) then
            if isClick then
                self:setSkinSelect(SkinListData[1])
            else
                local skinConfig = Config.GetCharacterSkinInfo(ClientData:GetPosterData().SkinId)
                self:setSkinSelect(skinConfig)
            end
        end
    end)
end

--设置皮肤选中态
function PosterPanel:setSkinSelect(skinConfig)
    local skinId = skinConfig.id
    if self.nowSelectSkinId == skinId then
        return
    end
    self.nowSelectSkinId = skinId
    for _, value in pairs(self.skinObjList) do
        if value.data.id == self.nowSelectSkinId then
            value.obj.isSelect:SetActive(true)
            UICommonUtils:ShowRolePicOrSpine(self, self.showCharacter, self.nowSelectSkinId, function(spineObject)
                if UICommonUtils.Checkobj(self.nowShowSpineObj) then
                     GameObject.Destroy(self.nowShowSpineObj)
                end
                self.nowShowSpineObj = spineObject
            end)
        else
            value.obj.isSelect:SetActive(false)
        end
    end
    local roleConfig = Config.GetCharacterInfo(skinConfig.CharacterID)
    self.roleNameTxt.text.text = roleConfig.name
    self.skinNameTxt.text.text = skinConfig.skinName

    self.adjustBtn:SetActive(self.nowSelectSkinId == ClientData:GetPosterData().SkinId)
end

function PosterPanel:refreshSortView()
    for k,v in pairs(self.sortBtnlist) do
        v.obj.isOpen:SetActive(self.nowSortIndex == v.key)
        if GE.RoleSortType[GE.RoleSortTypeName[self.nowSortIndex]] == GE.RoleSortType.nature and self.nowSortIndex == v.key then
            v.obj.natureList:SetActive(not v.obj.natureList.activeSelf)
        else
            v.obj.natureList:SetActive(false)
        end
    end
end

--function PosterPanel:OnClose(initiative)
--
--end

--function PosterPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function PosterPanel:OnRefresh(data)
--
--end

--[[
/AdjustBtn onClick 
--]]
function PosterPanel:adjustBtn_ScaleButton_onClick(adjustBtn)
    self:play2DSound(self.btnSoundPath)
    UIMgr:hideUI(self)
    local MainPanel = UIMgr:getUIData("MainPanel")
    if MainPanel then
        MainPanel.ui:PosterPanelMode(true)
        MainPanel.ui:OpenRoleChangeMode()
    end
    UIMgr:popUICover("PosterAdjustPanel", {skinId = self.nowSelectSkinId})
end

--[[
/RoleListBg/CustomSortBox/SortBg/SortBtn onClick 
--]]
function PosterPanel:sortBtn_ScaleButton_onClick(sortBtn)
    self:play2DSound(self.btnSoundPath)
    self.sortSelectList:SetActive(not self.sortSelectList.activeSelf)
    self.sortMask:SetActive(self.sortSelectList.activeSelf)
    if self.sortSelectList.activeSelf then
        if self.nowSortIndex == GE.RoleSortType.nature and self.nowNatureMode == nil then
            self.nowSortIndex = self.lastSortIndex
            self.nowSortMode = self.lastSortIndex
            self:refreshSortView()
        end
    end
end

--[[
/RoleListBg/CustomSortBox/SortBg/SortStateBtn onClick 
--]]
function PosterPanel:sortStateBtn_ScaleButton_onClick(sortStateBtn)
    self:play2DSound(self.btnSoundPath)
    if self.nowSortFace == 1 then
        self.nowSortFace = 2
    elseif self.nowSortFace == 2 then
        self.nowSortFace = 1
    end
    self.sortStateBtn.upImg:SetActive(self.nowSortFace == 2)
    self.sortStateBtn.downImg:SetActive(self.nowSortFace == 1)
    self:SetView(nil, true)
    self.sortSelectList:SetActive(false)
    self.sortMask:SetActive(false)
end

--[[
/RoleListBg/CustomSortBox/FiltrateBtn onClick 
--]]
function PosterPanel:filtrateBtn_ScaleButton_onClick(filtrateBtn)
    self:play2DSound(self.btnSoundPath)
    UIMgr:popUICover("DockFiltrateBox", {mode = 2})
    self.sortSelectList:SetActive(false)
    self.sortMask:SetActive(false)
end

--[[
/RoleListBg/CustomSortBox/LikeFiltrateBtn onClick 
--]]
function PosterPanel:likeFiltrateBtn_ScaleButton_onClick(likeFiltrateBtn)

end

--[[
/CustomBackPanel/Bg/BackBg/BackBtn onClick 
--]]
function PosterPanel:backBtn_ScaleButton_onClick(backBtn)
    local MainPanel = UIMgr:getUIData("MainPanel")
    if MainPanel then
        MainPanel.ui:PosterPanelMode(false)
    end
    UIMgr:closeUI(self)
end

--[[
/CustomBackPanel/Bg/HelpBtn onClick 
--]]
function PosterPanel:helpBtn_ScaleButton_onClick(helpBtn)

end

--[[
/CustomRoleBox/Btn onClick 
--]]
function PosterPanel:btn_ScaleButton_onClick(btn)

end

--[[
/RoleListBg/ChangeBtn onClick 
--]]
function PosterPanel:changeBtn_ScaleButton_onClick(changeBtn)
    self:play2DSound(self.btnSoundPath)
    local skinConfig = Config.GetCharacterSkinInfo(self.nowSelectSkinId)
    Me:setPosterDataReq({posterId = self.nowSelectSkinId}, function()
        local needOffsetY
        if skinConfig.spineKey then
            needOffsetY = skinConfig.spineOffset[2]
        else
            needOffsetY = skinConfig.imgOffsetF[2]
        end
        Me:setPosterPosReq({PosX = 0, PosY = needOffsetY, Size = 1}, function()
            GameMsgMgr:sendEvent(GameMsgType.RefreshPoster)
            self:RefreshBoxState()
            self.adjustBtn:SetActive(self.nowSelectSkinId == ClientData:GetPosterData().SkinId)
            UICommonUtils.PopToast("更换成功O v O")
        end)
    end)
end

--[[
/SortTypeBtn onClick 
--]]
function PosterPanel:sortTypeBtn_ScaleButton_onClick(sortTypeBtn)

end

--[[
/NatureNameBtn onClick 
--]]
function PosterPanel:natureNameBtn_ScaleButton_onClick(natureNameBtn)

end

--[[
/SortMask onClick 
--]]
function PosterPanel:sortMask_Button_onClick(sortMask)

end

return PosterPanel
