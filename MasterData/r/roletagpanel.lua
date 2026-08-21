---@class RoleTagPanel : RoleTagPanel_Generate
---##################### 【RoleTagPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【RoleTagPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local RoleTagPanel = require "RoleTagPanel_Generate"

function RoleTagPanel:InitLogic(data)
    self.roleData = {}
    self.nowSelectData = {}
    self.objList = {}
    self.roleIndex = nil
    self.RoleList = {}
    self.uiModeType = {
        ["normal"] = 1, --普通模式
        ["hankBook"] = 2, --图鉴模式
    }

    self.uiMode = self.uiModeType.normal --默认界面模式
end

--function RoleTagPanel:StartCreating(time)
--
--end

--function RoleTagPanel:StartEnter(time)
--
--end

--function RoleTagPanel:StartRemoving(time)
--
--end

--function RoleTagPanel:StartExit(time)
--
--end

function RoleTagPanel:OnOpen(data, initiative)
    if data then
        self.uiMode = data.uiMode or self.uiModeType.normal --界面模式
        self.RoleIndex = data.roleIndex
        self.RoleList = data.roleList
        self:SetView(self.RoleIndex)
    end
end

--设置显示
function RoleTagPanel:SetView(index)
    if next(self.RoleList) and index > tablex.size(self.RoleList) then
        self.RoleIndex = 1
    elseif index < 1 then
        self.RoleIndex = tablex.size(self.RoleList)
    else
        self.RoleIndex = index
    end

    -- 翻页时重置，避免旧数据累积；异步未完成时标记为未就绪
    self.objList = {}
    self.tagBoxReady = false
    self.selectViewToken = (self.selectViewToken or 0) + 1

    self.roleData = self.RoleList[self.RoleIndex]
    self.influenceTable = {}            --势力
    self.peculiarityTable = {}          --特性
    self.dwellingTable = {}             --后勤
    local roleTagList = Me:getHeroTagList(self.roleData.server.id)
    if self.uiMode == self.uiModeType.hankBook then
        roleTagList = self.roleData.config.signal
    end

    local CharacterNationPath = string.format(Config.SpritePath.CharacterNationPath, self.roleData.config.nation)
    self:LoadSpriteAsync(CharacterNationPath, function (s)
        self.influenceIcon.image.sprite = s
        self.influenceIcon:SetActive(true)
        self.influenceIconShadow.image.sprite = s
        self.influenceIconShadow:SetActive(true)
    end)

    for _,v in pairs(roleTagList) do
        local tagData = Config.SignalInfo(v)
        if tagData.type == GE.TagType.dwelling then
            table.insert(self.dwellingTable, tagData)
        elseif tagData.type == GE.TagType.influence then
            table.insert(self.influenceTable, tagData)
        else
            table.insert(self.peculiarityTable, tagData)
        end
    end

    self.influenceTxt.text.text = self.influenceTable[1].SignalName

    -- --势力显示
    -- self:FillTemplateContent(self.influenceBox, self.influenceList, tablex.size(self.influenceTable), function(index, influenceBox)
    --     influenceBox:SetActive(true)
    --     influenceBox.influenceTxt.text.text = self.influenceTable[index].SignalName
    -- end)

    local PeculiarCount = 0
    if tablex.size(self.peculiarityTable) > 8 then
        local temp = (tablex.size(self.peculiarityTable) - 10) % 4
        if temp == 0 then
            temp = 1
        end
        PeculiarCount = tablex.size(self.peculiarityTable) + temp * 4
    else
        PeculiarCount = 8
    end

    local dwellingCount = 0
    if tablex.size(self.dwellingTable) > 4 then
        local temp = (tablex.size(self.dwellingTable) - 4) % 4
        if temp == 0 then
            temp = 1
        end
        dwellingCount = tablex.size(self.dwellingTable) + temp * 4
    else
        dwellingCount = 4
    end

    -- 用计数器等待两个异步FillTemplateContent全部完成后再标记就绪
    local pendingFill = 2
    local function onTagBoxFillComplete()
        pendingFill = pendingFill - 1
        if pendingFill <= 0 then
            self.tagBoxReady = true
        end
    end

    --特性
    self:FillTemplateContent(self.tagBox, self.peculiarityContent, PeculiarCount, function(key, tagBox)
        tagBox:SetActive(true)
        local temp = {
            obj = tagBox,
            data = self.peculiarityTable[key]
        }
        table.insert(self.objList, temp)

        if self.peculiarityTable[key] and next(self.peculiarityTable[key]) then
            self:LoadSpriteAsync(string.format(Config.SpritePath.RolePeculiarity, self.peculiarityTable[key].type), tagBox.tagBg.image)
            tagBox.tagTxt.text.text = self.peculiarityTable[key].SignalName
            tagBox.tagSTxt.text.text = self.peculiarityTable[key].SignalName
            tagBox.isNull:SetActive(false)
            tagBox.tagBg:SetActive(true)
            tagBox.scaleButton.onClick:RemoveAllListeners()
            tagBox.scaleButton.onClick:AddListener(function()
                if not self.tagBoxReady then return end
                self.nowSelectData = self.peculiarityTable[key]
                self.influenceIsSelect:SetActive(false)
                self:SetSelectView()
            end)
        else
            tagBox.isNull:SetActive(true)
            tagBox.tagBg:SetActive(false)
        end
    end, onTagBoxFillComplete)

    --后勤适应
    self:FillTemplateContent(self.tagBox, self.dwellingContent, dwellingCount, function(k, tagBox)
        tagBox:SetActive(true)
        local temp = {
            obj = tagBox,
            data = self.dwellingTable[k]
        }
        table.insert(self.objList, temp)

        if self.dwellingTable[k] and next(self.dwellingTable[k]) then

            self:LoadSpriteAsync(string.format(Config.SpritePath.RolePeculiarity, self.dwellingTable[k].type), tagBox.tagBg.image)

            tagBox.tagTxt.text.text = self.dwellingTable[k].SignalName
            tagBox.isNull:SetActive(false)
            tagBox.tagBg:SetActive(true)
            tagBox.scaleButton.onClick:RemoveAllListeners()
            tagBox.scaleButton.onClick:AddListener(function()
                if not self.tagBoxReady then return end
                self.nowSelectData = self.dwellingTable[k]
                self.influenceIsSelect:SetActive(false)
                self:SetSelectView()
            end)
        else
            tagBox.isNull:SetActive(true)
            tagBox.tagBg:SetActive(false)
        end

    end, onTagBoxFillComplete)
end

--更新选中显示
function RoleTagPanel:SetSelectView()
    for _, value in pairs(self.objList) do
        if value.data then
            value.obj.isSelect:SetActive(value.data.id == self.nowSelectData.id)
        else
            value.obj.isSelect:SetActive(false)
        end
    end
    self.msgTxt.text.text = self.nowSelectData.Signaldesc
    self.tagNameTxt.text.text = self.nowSelectData.SignalName

    -- 快速切换标签时取消上一轮异步 Fill，避免旧回调残留或格子数不完整
    self.selectViewToken = (self.selectViewToken or 0) + 1
    local token = self.selectViewToken

    local rolelist = {}
    local singleConfig = Config.SignalInfo(self.nowSelectData.id)
    if singleConfig and singleConfig.showCharacter then
        for _, value in pairs(singleConfig.showCharacter) do
            local roleConfig = Config.GetCharacterInfo(value)
            if roleConfig and roleConfig.isOpen == 1 then
                table.insert(rolelist, roleConfig)
            end
        end
    end

    local boxCount = math.max(9, tablex.size(rolelist))

    self:FillTemplateContent(self.roleBox, self.sameRoleContent, boxCount, function(index, roleBox)
        if token ~= self.selectViewToken then
            return
        end
        roleBox:SetActive(true)
        if rolelist[index] and next(rolelist[index]) then
            local roleConfig = rolelist[index]
            local roleData = Me:getPlayerHero(roleConfig.id)
            roleBox.rankFarmeImg:SetActive(true)
            self:LoadSpriteAsync(string.format(Config.SpritePath.roleNewRankFarmeBg, roleConfig.rank), roleBox.rankFarmeImg.image)
            roleBox.typeIcon:SetActive(true)
            self:LoadSpriteAsync(string.format(Config.SpritePath.RoleTypeIconPath, roleConfig.attribute), roleBox.typeIcon.image)

            local skinId = roleConfig.baseSkinID
            if roleData and roleData.equipSkin then
                skinId = roleData.equipSkin
            end
            local skinConfig = Config.GetCharacterSkinInfo(skinId)
            if not skinConfig then
                roleBox.isNull:SetActive(true)
                roleBox.roleMsg:SetActive(false)
                return
            end

            local resourceFolder = skinConfig.resourceFolder
            if tonumber(resourceFolder) ~= nil then
                resourceFolder = tostring(math.floor(tonumber(resourceFolder)))
            else
                resourceFolder = skinConfig.resourceFolder
            end
            local iconPath = string.format(Config.SpritePath.IconRolePath, resourceFolder, skinConfig.driverKey)

            roleBox.roleIconImg:SetActive(true)
            self:LoadSpriteAsync(iconPath, roleBox.roleIconImg.image)
            roleBox.isNull:SetActive(false)
            roleBox.roleMsg:SetActive(true)
            roleBox.roleName.text.text = roleConfig.name
        else
            roleBox.isNull:SetActive(true)
            roleBox.roleMsg:SetActive(false)
        end
    end, function()
        if token ~= self.selectViewToken then
            return
        end
        -- 异步补齐格子后强制刷新布局，避免 Scroll/Grid 仍按旧数量裁切
        if self.sameRoleContent and not IsNull(self.sameRoleContent) then
            UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.sameRoleContent.transform)
        end
    end)
end

--function RoleTagPanel:OnClose(initiative)
--
--end

--function RoleTagPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function RoleTagPanel:OnRefresh(data)
--
--end

--[[
/Mask onClick 
--]]
function RoleTagPanel:mask_Button_onClick(imgMask)
    --UIMgr:closeCurrentUI(self)
    self:playCloseAnim()
end

--[[
/ImgBg/SameBtn onClick 
--]]
function RoleTagPanel:sameBtn_ScaleButton_onClick(sameBtn)
    self.sameRolePanel.canvasGroup.alpha = self.sameRolePanel.canvasGroup.alpha == 1 and 0 or 1
end

--[[
/TagBox onClick 
--]]
function RoleTagPanel:tagBox_ScaleButton_onClick(tagBox)

end

--[[
/LastBtn onClick 
--]]
function RoleTagPanel:lastBtn_ScaleButton_onClick(lastBtn)
    self:SetView(self.RoleIndex - 1)
end

--[[
/NextBtn onClick 
--]]
function RoleTagPanel:nextBtn_ScaleButton_onClick(nextBtn)
    self:SetView(self.RoleIndex + 1)
end

--[[
/ImgBg/InfluenceBg/InfluenceNameBg onClick 
--]]
function RoleTagPanel:influenceNameBg_ScaleButton_onClick(influenceNameBg)
    if not self.tagBoxReady then return end
    self.influenceIsSelect:SetActive(true)
    local tagData = Config.SignalInfo(self.roleData.config.nationSignal)
    self.nowSelectData = tagData
    self:SetSelectView()
end

function RoleTagPanel:playCloseAnim()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeSpecificUI(self)
    end)
end

return RoleTagPanel
