---@class SkillTreePanel : SkillTreePanel_Generate
---##################### 【SkillTreePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【SkillTreePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local SkillTreePanel = require "SkillTreePanel_Generate"

local function ResetLocalZ(target)
    if target == nil then
        return
    end
    local trans = target.transform or target
    if trans == nil then
        return
    end
    local localPos = trans.localPosition
    if localPos.z ~= 0 then
        trans.localPosition = Vector3.New(localPos.x, localPos.y, 0)
    end
    local rectTransform = trans:GetComponent(TypeInfo.RectTransform)
    if rectTransform ~= nil then
        local anchoredPos = rectTransform.anchoredPosition3D
        if anchoredPos.z ~= 0 then
            rectTransform.anchoredPosition3D = Vector3.New(anchoredPos.x, anchoredPos.y, 0)
        end
    end
end

function SkillTreePanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.RefreshTopResource, function()
            self.customBackPanel.customBackPanel:RefreshTopResource()
        end},
        {GameMsgType.HeroListNtf, self.setMaxStageLevel},
        {GameMsgType.RedPointRefresh, self.refreshRedPoint},
        {GameMsgType.ItemMapNtf, self.updateNowSelect},
        
        
        
	}
    self.treeData = {}          --技能树数据
    self.objList = {}           --对象列表
    self.LineObjList = {}       --线对象列表
    self.nowSelectId = nil      --当前选择的id
    self.lineParentObj = nil
    --线的父物体
    self.maxStage = 1
    self.effectToIconMap = {
        [GE.TalentTypeNew.naturePoint] = {iconIndex = 1, name = "属性节点", EngName = "Nature node", mode = 1},
        [GE.TalentTypeNew.skillChosePoint] = {iconIndex = 2, name = "技能选择节点", EngName = "Skill Unlocker node", mode = 1},
        [GE.TalentTypeNew.getSkillPoint] = {iconIndex = 2, name = "技能节点", EngName = "Skill node", mode = 2},
        [GE.TalentTypeNew.unlockWeaponPoint] = {iconIndex = 3, name = "武器解锁节点", EngName = "Weapon node", mode = 1},
        [GE.TalentTypeNew.getTagPoint] = {iconIndex = 4, name = "标签节点", EngName = "Tag node", mode = 1},
        [GE.TalentTypeNew.changeTagPoint] = {iconIndex = 4, name = "标签节点", EngName = "Tag node", mode = 1},
        [GE.TalentTypeNew.delTagPoint] = {iconIndex = 4, name = "负载节点", EngName = "Tag node", mode = 1},
        [GE.TalentTypeNew.loadUpPoint] = {iconIndex = 5, name = "标签节点", EngName = "Load node", mode = 1},
        [GE.TalentTypeNew.skinPoint] = {iconIndex = 6, name = "皮肤节点", EngName = "Skin node", mode = 2},
    }
    self.uiModeType = {
        ["normal"] = 1, --普通模式
        ["hankBook"] = 2, --图鉴模式
        ["character"] = 3, --角色模式
    }
    self.btnSoundPath = string.format(Config.AudioPath.SE, "click")
    self.uiMode = self.uiModeType.normal --默认界面模式
end

-- 图鉴/角色预览模式：无真实服务器养成数据
function SkillTreePanel:isPreviewMode()
    return self.uiMode == self.uiModeType.hankBook or self.uiMode == self.uiModeType.character
end

-- 角色id：普通模式取服务器数据，图鉴/预览模式取配置表id
function SkillTreePanel:getRoleId()
    if self.serverData and self.serverData.id then
        return self.serverData.id
    end
    if self.configData and self.configData.id then
        return self.configData.id
    end
    return nil
end

--function SkillTreePanel:StartCreating(time)
--
--end

--function SkillTreePanel:StartEnter(time)
--
--end

--function SkillTreePanel:StartRemoving(time)
--
--end

--function SkillTreePanel:StartExit(time)
--
--end

function SkillTreePanel:OnOpen(data, initiative)
    self.nowSelectId = nil
    -- 每次打开都重新绑定返回，避免复用实例时回调丢失
    self.customBackPanel.customBackPanel:Bind(GE.NavigationType.SkillTreePanel, self)
    self.customBackPanel.customBackPanel:OverrideBackFunc(function()
        if UIMgr:getCurUIName() ~= "SkillTreePanel" then
            return
        end
        self.customBackPanel.customBackPanel:ClearBackFunc()
        UIMgr:closeSpecificUI(self)
    end)

    if data then
        self.uiMode = data.uiMode or self.uiModeType.normal --界面模式
        if self.lineParentObj ~= nil and not IsNull(self.lineParentObj) then
            -- SetView 里 ClearChildren 会清掉 content 下节点；这里先置空引用即可
            self.lineParentObj = nil
        end
        self:ClearLineObjList()

        self.serverData = data.serverData
        self.configData = data.config
        self.treeData = Config.GetTalentTreeInfoByTreeId(data.config.talentTree)
        self:ResetScrollView()
        self:SetView()
    end
    self.panelList:SetActive(false)
    self.tagInfo:SetActive(false)
    self.tagInfo.button.onClick:AddListener(function()
        self:play2DSound(self.btnSoundPath)
        self.tagInfo:SetActive(false)
    end)
    self:refreshRedPoint()
end

function SkillTreePanel:refreshRedPoint()
    if self:isPreviewMode() then
        self.stageFinishBg.redPoint:SetActive(false)
        return
    end
    local roleId = self:getRoleId()
    if roleId == nil then
        self.stageFinishBg.redPoint:SetActive(false)
        return
    end
    self.stageFinishBg.redPoint:SetActive(RedPointMgr:RoleTalentTreeStageCanUp(roleId))
end

-- 设置视图
function SkillTreePanel:SetView()
    --self.skinImg.canvasGroup.alpha = 0
    local roleConfig = Config.GetCharacterInfo(self:getRoleId())
    local skinConfig = Config.GetCharacterSkinInfo(roleConfig.baseSkinID)
    local resourceFolder = nil
    if tonumber(skinConfig.resourceFolder) ~= nil then
        resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
    else
        resourceFolder = skinConfig.resourceFolder
    end
    local PortraitRolePath = string.format(Config.SpritePath.PortraitRolePath, resourceFolder, skinConfig.imgKey)
    self:LoadSpriteAsync(PortraitRolePath, function (s)
        self.skinImg.image.sprite = s
        self.skinImg.image:SetNativeSize()
        self.skinImg:SetActive(true)
        self.skinImg.canvasGroup.alpha = 0
        self.skinImg.canvasGroup:DOFade(1, 0.15)
    end)
    self.skinImg.rectTransform.anchoredPosition = Vector2(skinConfig.SkillimgOffset[1], skinConfig.SkillimgOffset[2])
    self.skinImg.rectTransform.localScale = Vector2.New(skinConfig.SkillimgRate, skinConfig.SkillimgRate)

    local maxCountList = {}
    -- 每次打开按当前技能树重算，避免复用面板时沿用上一角色的 maxStage
    self.maxStage = 1
    for _, v in pairs(self.treeData) do
        if v.stageId > self.maxStage then
            self.maxStage = v.stageId
        end
    end

    -- 计算每个阶段的最大坐标
    for i = 1, self.maxStage do
        local StageData = Config.GetTalentTreeInfoByTreeIdStageId(self.treeData[1].treeId, i)
        for _, value in pairs(StageData) do
            if maxCountList[i] == nil then
                maxCountList[i] = {
                    count = 0,
                    stage = i
                }
            end

            if value.coordinate[2] > maxCountList[i].count then
                maxCountList[i].count = value.coordinate[2]
            end
        end
    end

    self.objList = {}  -- 初始化对象列表
    local partObjList = {}
    local blockObjList = {}
    self.content.verticalLayoutGroup.enabled = true
    self.content.contentSizeFitter.enabled = true
    self.content.rectTransform.anchoredPosition = Vector2.zero
    local totalParts = tablex.size(maxCountList)
    local completedParts = 0 -- 记录已完成的部分数量
    self.lineParentObj = nil
    DLuaUtil.ClearChildren(self.content.transform)

    -- 按阶段序号强制 sibling：PartList / Block 交替，避免异步创建或二次打开时顺序错乱
    local function SyncPartBlockSiblingOrder()
        for stageIndex = 1, totalParts do
            local part = partObjList[stageIndex]
            local block = blockObjList[stageIndex]
            if part ~= nil and not IsNull(part) then
                part.transform:SetSiblingIndex((stageIndex - 1) * 2)
            end
            if block ~= nil and not IsNull(block) then
                block.transform:SetSiblingIndex((stageIndex - 1) * 2 + 1)
            end
        end
    end

    self:FillTemplateContent(self.partList, self.content, totalParts, function(index, partList)
        ResetLocalZ(partList)
        if partList.gridLayoutGroup then
            partList.gridLayoutGroup.enabled = true
        end
        local x, y = 0, 0
        partObjList[index] = partList
        -- 立刻占位，保证后续异步回调不会把 PartList 插到错误位置
        partList.transform:SetSiblingIndex((index - 1) * 2)

        self:FillTemplateContent(self.pointBox, partList, (maxCountList[index].count + 1) * 3, function(k, pointBox)
            ResetLocalZ(pointBox)
            pointBox:SetActive(true)
            if pointBox.rankBg then
                pointBox.rankBg:SetActive(false)
            end
            local temp = {
                pos = {y = y, x = x},
                obj = pointBox,
                config = {},
                isLock = false,
                nowMode = nil,          --1 主模式 2 技能模式
                stage = maxCountList[index].stage
            }
            table.insert(self.objList, temp)
            self:SetBoxStateByPos(temp, k)

            -- 更新坐标
            if x < 2 then
                x = x + 1
            else
                x = 0
                y = y + 1
            end

            self:SetBoxState(pointBox, temp)
            pointBox.btn.scaleButton.onClick:RemoveAllListeners()
            pointBox.btn.scaleButton.onClick:AddListener(function()
                local btnSoundPath = string.format(Config.AudioPath.SE, "pointselect")
                self:play2DSound(btnSoundPath)
                self:SetNowSelect(temp.config.id)  -- 设置当前选择
            end)
        end, function()  -- 添加一个回调函数
            -- 当点框内容填充完成时，检查是否所有部分都已完成
            completedParts = completedParts + 1
            if completedParts == totalParts then
                SyncPartBlockSiblingOrder()
                -- 所有部分都生成完毕，调用指定的方法
                -- 强制 Unity 立即完成布局计算，确保 RectTransform 位置有效
                UnityEngine.Canvas.ForceUpdateCanvases()
                self.content.verticalLayoutGroup.enabled = false
                self.content.contentSizeFitter.enabled = false
                for stageIndex = 1, totalParts do
                    local part = partObjList[stageIndex]
                    if part ~= nil and not IsNull(part) and part.gridLayoutGroup then
                        part.gridLayoutGroup.enabled = false
                    end
                end
                self:SetLineView()
                self.scrollRect.canvasGroup:DOFade(1, 0.2)
                GuideMgr:StartGuideTrigger("SkillTreePanel")
            end
        end)

        -- 实例化区块（与 PartList 成对，并固定 sibling）
        local block = GameObject.Instantiate(self.block)
        block.gameObject.transform:SetParent(self.content.transform, false)
        block.transform:GetComponent(TypeInfo.LayoutElement).preferredHeight = 180
        block.gameObject.transform.localScale = Vector3.one
        block.gameObject.transform.localPosition = Vector3.zero
        ResetLocalZ(block)
        block:SetActive(true)
        blockObjList[index] = block
        block.transform:SetSiblingIndex((index - 1) * 2 + 1)
    end)

    self:setMaxStageLevel()

    self.stageFinishBg:SetActive(self.uiMode == self.uiModeType.normal)
end

--- 获取最大阶段等级
function SkillTreePanel:SelectInfo()
    local nowSelect = nil 
    for _, value in pairs(self.objList) do
        if not value.isLock then
            if value.config.coordinate then
                if value.config.coordinate[1] == 1 then
                    nowSelect = value.config.id
                    break
                end
            end
        end
    end
    --self:SetNowSelect(nowSelect)
end

--清空线段列表
function SkillTreePanel:ClearLineObjList()
    if self.LineObjList and next(self.LineObjList) then
        for _, value in pairs(self.LineObjList) do
            GameObject.Destroy(value.obj)
        end
        self.LineObjList = {}
    end
end

--重置滚动位置
function SkillTreePanel:ResetScrollView()
    self.scrollRect.canvasGroup.alpha = 0
    self.scrollRect.scrollRect.verticalNormalizedPosition = 1  -- 将垂直滚动位置重置为顶部
end

function SkillTreePanel:SetBoxState(obj, talentData)
    local TalentData = Me:getTalentTreeDataById(self.configData.id, talentData.config.id)
    local configData = self:getObjDataById(talentData.config.id).config
    local function updateModeUI(mode, isLock, isActive, canOpen)
        if self:isPreviewMode() then
            isLock = true
            isActive = false
            canOpen = false
        end

        if mode == 1 then
            obj.mainMode.lockMask:SetActive(isLock)
            obj.mainMode.isOn:SetActive(isActive)
            obj.mainMode.canOpen:SetActive(canOpen)
        else
            obj.skillMode.lockMask:SetActive(isLock)
            obj.skillMode.isOn:SetActive(isActive)
            obj.skillMode.canOpen:SetActive(canOpen)
        end
    end
    if configData and next(configData) then
        local iconIndex = self.effectToIconMap[configData.specialEffect[1]].iconIndex
        local TreeIconPath = string.format(Config.SpritePath.TreeIconPath, iconIndex)

        self:LoadSpriteAsync(TreeIconPath, function(s)
            obj.mainMode.iconImg.image.sprite = s
            obj.skillMode.iconImg.image.sprite = s
            obj.mainMode.iconImg:SetActive(true)
            obj.skillMode.iconImg:SetActive(true)
        end)

        local isSkillPoint = configData.specialEffect[1] == GE.TalentTypeNew.getSkillPoint
        obj.skillMode.mainView:SetActive(not isSkillPoint)
        obj.skillMode.skillView:SetActive(isSkillPoint)
        obj.skillMode.skillView.iconBg:SetActive(true)

        if isSkillPoint then
            local skillConfig = Config.GetSkillInfo(configData.specialEffect[2]) 
            self:LoadSpriteAsync(string.format(Config.SpritePath.SkillIconPath, skillConfig.icon), obj.skillMode.skillView.iconImg.image)
        end

        if isSkillPoint or configData.specialEffect[1] == GE.TalentTypeNew.skinPoint then
            obj.mainMode:SetActive(false)
            obj.skillMode:SetActive(true)
            talentData.nowMode = 2
        else
            obj.mainMode:SetActive(true)
            obj.skillMode:SetActive(false)
            talentData.nowMode = 1
        end
    end
    if TalentData then  -- 已激活
        talentData.isLock = false
        updateModeUI(talentData.nowMode, talentData.isLock, true, false)
        self:UnlockLine(talentData.config.id)
    else
        if configData.unlock and next(configData.unlock) then           --解锁条件
            for _, value in pairs(configData.unlock) do
                local unlockData = Me:getTalentTreeDataById(self.configData.id, value)
                if unlockData == nil then
                    talentData.isLock = true
                    updateModeUI(talentData.nowMode, talentData.isLock, false, false)
                else
                    talentData.isLock = false
                    self:UnlockLine(talentData.config.id)
                    updateModeUI(talentData.nowMode, talentData.isLock, false, true)
                end
            end
        else
            talentData.isLock = false
            self:UnlockLine(talentData.config.id)
            updateModeUI(talentData.nowMode, talentData.isLock, false, true)
        end
    end
    
end

function SkillTreePanel:updateNowSelect()
    self:SetNowSelect(self.nowSelectId, true)
end

-- 设置当前选择的技能树节点
function SkillTreePanel:SetNowSelect(index, isRefresh) 
    if index == self.nowSelectId and not isRefresh then
        return
    end
    LuaLogger.ds(">>>>>>>id<<<<<<<", index)
    self.nowSelectId = index
    if not self.nowSelectId then
        for _, v in pairs(self.objList) do
            v.obj.isSelect:SetActive(false)
        end
        self.panelList:SetActive(false)
        return
    else
        self.panelList:SetActive(true)
    end
    local objData = self:getObjDataById(self.nowSelectId)
    local data = self:UpdateSelectionState()
    self:UpdateUI(objData, data)
    if data.specialEffect[1] == GE.TalentTypeNew.getSkillPoint and not objData.isLock then
        self:HandleSkillPoint(data)
    end
    if data.specialEffect[1] == GE.TalentTypeNew.getSkillPoint then
        self:UpdateSkillInfo(data)
    end
end

-- 更新选择状态并返回当前选择的配置数据
function SkillTreePanel:UpdateSelectionState()
    local data = {}
    for _, v in pairs(self.objList) do
        v.obj.isSelect:SetActive(v.config.id == self.nowSelectId)
        if v.config.id == self.nowSelectId then
            data = v.config
        end
    end
    return data
end

-- 更新UI界面
function SkillTreePanel:UpdateUI(objData, data)
    local TalentData = Me:getTalentTreeDataById(self.configData.id, self.nowSelectId)
    local heroLevel
    local affectionLevel
    if self.uiMode == self.uiModeType.normal then
        heroLevel = self.serverData.level
        affectionLevel = Me:getPlayerHero(self.serverData.id).affectionLevel
    else
        -- 图鉴/角色预览模式：无服务器数据，使用容错默认值
        heroLevel = 1
        affectionLevel = 0
    end
    self.lockBg:SetActive(objData.isLock)
    self.okBtn:SetActive(not objData.isLock and not TalentData)
    if data.extraUnlock[1] == GE.TreeExtraUnlock.Level then
        self.overloadTips:SetActive(heroLevel < data.extraUnlock[2])
        self.overloadTips.text.text = string.format("角色达到%s级解锁", data.extraUnlock[2])
        self.okBtn:SetActive(not (heroLevel < data.extraUnlock[2]) and not objData.isLock and not TalentData)
    elseif data.extraUnlock[1] == GE.TreeExtraUnlock.AffectionLevel then
        self.overloadTips:SetActive(affectionLevel < data.extraUnlock[2])
        self.overloadTips.text.text = string.format("心音共鸣达到%s级解锁", data.extraUnlock[2])
        self.okBtn:SetActive(not (affectionLevel < data.extraUnlock[2]) and not objData.isLock and not TalentData)
    else
        self.overloadTips:SetActive(false)
    end
    self.isOn:SetActive(TalentData ~= nil)
    local boxType = data.specialEffect[1]
    self:UpdateTitle(boxType, data)
    self:UpdateIcon(boxType, data)
    self:UpdatePanels(boxType, data)
    self:UpdateAttributes(data)
    self:UpdateMessages(boxType, data)
    self:UpdateTags(boxType, data)
    self:UpdateSkin(boxType, data, TalentData)
    self:UpdateResources(data, TalentData, objData)

    self.isOpenLine:SetActive(self:isPreviewMode())
    self.resView:SetActive(self.uiMode == self.uiModeType.normal)
    if self:isPreviewMode() then
        self.resBoxView:SetActive(false)
        self.resNullView:SetActive(false)
    end
end

-- 更新标题信息
function SkillTreePanel:UpdateTitle(boxType, data)
    self.mainTitleTxt.text.text = self.effectToIconMap[boxType].name
    self.mainTitleEngTxt.text.text = self.effectToIconMap[boxType].EngName
    local StrLen = string.len(self.mainTitleTxt.text.text)
    local LineRect = self.lineBg.rectTransform
    LineRect:SetSizeWithCurrentAnchors(UnityEngine.RectTransform.Axis.Horizontal, 480)
    LineRect:SetSizeWithCurrentAnchors(UnityEngine.RectTransform.Axis.Horizontal, LineRect.rect.width - StrLen * 8.3)
end

-- 更新图标信息
function SkillTreePanel:UpdateIcon(boxType, data)
    self.circle:SetActive(self.effectToIconMap[boxType].mode == 2)
    local iconIndex = self.effectToIconMap[boxType].iconIndex
    local TreeIconPath = string.format(Config.SpritePath.TreeIconPath, iconIndex)
    self.cube:SetActive(self.effectToIconMap[boxType].mode == 1)
    self.circle.pointBg:SetActive(boxType ~= GE.TalentTypeNew.getSkillPoint)
    self.circle.skillBg:SetActive(boxType == GE.TalentTypeNew.getSkillPoint)
    if boxType == GE.TalentTypeNew.getSkillPoint then
        local skillConfig = Config.GetSkillInfo(data.specialEffect[2])
        TreeIconPath = string.format(Config.SpritePath.SkillIconPath, skillConfig.icon)
        self.pointNameTxt.text.text = skillConfig.nameKey
        self.circle.skillBg.isAnim:SetActive(skillConfig.skillTimeline ~= nil and skillConfig.skillTimeline ~= "")
    else
        self.pointNameTxt.text.text = data.name
        self.circle.skillBg.isAnim:SetActive(false)
    end
    self:LoadSpriteAsync(TreeIconPath, function(s)
        self.circle.skillBg.iconImg.image.sprite = s
        self.cube.iconImg.image.sprite = s
        self.circle.iconImg:SetActive(true)
        self.cube.iconImg:SetActive(true)
    end)
end

-- 更新面板显示状态
function SkillTreePanel:UpdatePanels(boxType, data)
    self.simpleGroup:SetActive(boxType ~= GE.TalentTypeNew.getSkillPoint)
    self.skillGroup:SetActive(boxType == GE.TalentTypeNew.getSkillPoint)
    self.attributeView:SetActive(data.attributeType == 1)
end

-- 更新属性信息
function SkillTreePanel:UpdateAttributes(data)
    local natureData = {
        hp = {type = GE.NatureType.hp, value = data.hp},
        armor = {type = GE.NatureType.armor, value = data.armor},
        evade = {type = GE.NatureType.evade, value = data.evade},
        bombard = {type = GE.NatureType.bombard, value = data.bombard},
        torpedo = {type = GE.NatureType.torpedo, value = data.torpedo},
        lucky = {type = GE.NatureType.lucky, value = data.lucky},
        airdefense = {type = GE.NatureType.airdefense, value = data.airdefense},
    }

    local temp = {}
    for _, value in pairs(natureData) do
        table.insert(temp, value)
    end

    table.sort(temp, function(a, b)
        return a.type < b.type
    end)
    if data.attributeType == 1 then
        self:FillTemplateContent(self.attributeBox, self.attributeList, tablex.size(temp), function(key, attributeBox)
            ResetLocalZ(attributeBox)
            attributeBox:SetActive(temp[key].value ~= 0)
            attributeBox.msgTIpsTxt.text.text = LocalStrEnum["NatureType_"..temp[key].type]
            attributeBox.msgNumTxt.text.text = temp[key].value
            self:LoadSpriteAsync(string.format(Config.SpritePath.AttributeIcon, temp[key].type), attributeBox.msgIcon.image)
        end)
    end
end

-- 更新消息显示
function SkillTreePanel:UpdateMessages(boxType, data)
    local validBoxTypes = {
        GE.TalentTypeNew.skillChosePoint,
        GE.TalentTypeNew.unlockWeaponPoint,
        GE.TalentTypeNew.loadUpPoint,
        GE.TalentTypeNew.getTagPoint,
        GE.TalentTypeNew.changeTagPoint,
        GE.TalentTypeNew.delTagPoint,
        GE.TalentTypeNew.skinPoint
    }

    local function isValidBoxType(boxType)
        return tablex.contains(validBoxTypes, boxType)
    end

    self.msgView:SetActive(isValidBoxType(boxType))
    self.msgTxt:SetActive(false)

    if boxType == GE.TalentTypeNew.skillChosePoint then
        local skill1, skill2 = self:GetSkillChosePointInfo(data)
        self.msgTxt.text.text = string.format(LocalStrEnum["TalentTreeEvent10"], skill1.nameKey, skill2.nameKey)
        self.msgTxt:SetActive(true)
    elseif boxType == GE.TalentTypeNew.unlockWeaponPoint then
        self.msgTxt.text.text = LocalStrEnum["TalentTreeEvent32"]
        self.msgTxt:SetActive(true)
    elseif boxType == GE.TalentTypeNew.loadUpPoint then
        self.msgTxt.text.text = string.format(LocalStrEnum["TalentTreeEvent33"], data.specialEffect[2])
        self.msgTxt:SetActive(true)
    end
end

-- 获取技能选择点信息
function SkillTreePanel:GetSkillChosePointInfo(data)
    local treeData_1 = Config.TalentTreeInfo(data.after[1])
    local treeData_2 = Config.TalentTreeInfo(data.after[2])
    local skill1 = Config.GetSkillInfo(treeData_1.specialEffect[2])
    local skill2 = Config.GetSkillInfo(treeData_2.specialEffect[2])
    return skill1, skill2
end

-- 更新标签信息
function SkillTreePanel:UpdateTags(boxType, data)
    local tagConfigs = {
        [GE.TalentTypeNew.getTagPoint] = {
            {msg = "<color=#2089F0>获取特质</color>", effect = data.specialEffect[2]},
        },
        [GE.TalentTypeNew.changeTagPoint] = {
            {msg = "<color=#F03A20>消除特质</color>", effect = data.specialEffect[2]},
            {msg = "<color=#2089F0>获取特质</color>", effect = data.specialEffect[3]},
        },
        [GE.TalentTypeNew.delTagPoint] = {
            {msg = "<color=#F03A20>消除特质</color>", effect = data.specialEffect[2]},
        }
    }
    if tagConfigs[boxType] then
        self:FillTagMessage(tagConfigs[boxType])
    end
    self.tagList:SetActive(boxType == GE.TalentTypeNew.getTagPoint or boxType == GE.TalentTypeNew.changeTagPoint or boxType == GE.TalentTypeNew.delTagPoint)
end

-- 填充标签消息
function SkillTreePanel:FillTagMessage(specialEffect)
    self:FillTemplateContent(self.tagMsgBox, self.tagList, tablex.size(specialEffect), function(key, tagMsgBox)
        ResetLocalZ(tagMsgBox)
        tagMsgBox:SetActive(true)
        tagMsgBox.tagMgsTxt.text.text = specialEffect[key].msg
        local tagConfig = Config.SignalInfo(specialEffect[key].effect)
        tagMsgBox.tagBox.tagTxt.text.text = tagConfig.SignalName
        self:LoadSpriteAsync(string.format(Config.SpritePath.RolePeculiarity, tagConfig.type), tagMsgBox.tagBox.tagBg.image)
        tagMsgBox.tagBox.tagBg.scaleButton.onClick:RemoveAllListeners()
        tagMsgBox.tagBox.tagBg.scaleButton.onClick:AddListener(function()
            self:play2DSound(self.btnSoundPath)
            self.tagInfo:SetActive(true)
            self.tagInfoBg.transform.position = tagMsgBox.transform.position
            self.tagTitle.text.text = tagConfig.SignalName
            self.tagDesc.text.text = tagConfig.Signaldesc
        end)
    end)
end

-- 更新皮肤信息
function SkillTreePanel:UpdateSkin(boxType, data, TalentData)
    self.skinView:SetActive(boxType == GE.TalentTypeNew.skinPoint)
    if boxType == GE.TalentTypeNew.skinPoint then
        local SkinConfig = Config.GetCharacterSkinInfo(data.specialEffect[2])
        self.skinNameTxt.text.text = SkinConfig.skinName
        local resourceFolder = SkinConfig.resourceFolder
        if tonumber(resourceFolder) then
            resourceFolder = tostring(math.floor(tonumber(resourceFolder)))
        end
        self.skinBox.roleIconImg:SetActive(true)
        self:LoadSpriteAsync(string.format(Config.SpritePath.IconRolePath, resourceFolder, SkinConfig.driverKey), self.skinBox.roleIconImg.image)
        self.skinBox.rankFarmeImg:SetActive(true)
        self.skinBox.isGet:SetActive(TalentData ~= nil)
    end
end

-- 更新资源信息
function SkillTreePanel:UpdateResources(data, TalentData, objData)
    if data.cost and next(data.cost) then
        self.resBoxView:SetActive(true)
        self.resNullView:SetActive(false)
        self.itemList:SetActive(true)
        self:FillTemplateContent(self.customBox, self.itemList, tablex.size(data.cost), function(key, itemObj)
            ResetLocalZ(itemObj)
            local customBox = itemObj.customBox
            local itemId = data.cost[key][1]
            local itemData = Me:getItemById(itemId)
            local boxCfg = {
                itemNum = itemData and itemData.num .. "/" .. data.cost[key][2] or "0/" .. data.cost[key][2],
                tipsPassEventState = false,
                navType = GE.NavigationType.SkillTreePanel,
                needNum = data.cost[key][2],
            }
            local data = tablex.clone(data.cost[key])
            table.insert(data, 1, GE.RewardType.ItemProp)
            customBox:setMono(self)
            customBox:SetUIData(data, boxCfg)
        end)
    else
        self.resBoxView:SetActive(false)
        self.resNullView:SetActive(true)
        self.itemList:SetActive(false)
    end

    if TalentData then
        self.resBoxView:SetActive(false)
        self.resNullView:SetActive(false)
        self.itemList:SetActive(false)
    end

    self.resMsg:SetActive(TalentData == nil and self.overloadTips.activeSelf ~= true and objData.isLock ~= true and data.specialCost[1] ~= nil)
    self.isOpenLine:SetActive(TalentData ~= nil)
end

-- 处理技能点逻辑
function SkillTreePanel:HandleSkillPoint(data)
    local unlock = Config.TalentTreeInfo(data.unlock[1])
    for _, value in pairs(unlock.after) do
        local ConfigData = Config.TalentTreeInfo(value)
        if ConfigData.specialEffect[1] == GE.TalentTypeNew.getSkillPoint and ConfigData.id ~= data.id then
            self:HandleSkillPointSelection(data, ConfigData)
        end
    end
end

-- 处理技能点选择逻辑
function SkillTreePanel:HandleSkillPointSelection(data, ConfigData)
    if self:isPreviewMode() then
        return
    end
    local roleId = self:getRoleId()
    local OthenData = Me:getTalentTreeDataById(roleId, ConfigData.id)
    local MineData = Me:getTalentTreeDataById(roleId, data.id)
    if OthenData then
        self:CheckSpecialCost(data)
    elseif not OthenData and not MineData then
        self:OpenSkillTreeChosePanel(data, ConfigData)
    end
end

-- 检查特殊资源消耗
function SkillTreePanel:CheckSpecialCost(data)
    if data.specialCost and next(data.specialCost) then
        local resData = Config.GetItemInfo(data.specialCost[1])
        local resUserData = Me:getItemById(data.specialCost[1])
        if resData then
            self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, resData.icon), self.resIcon.image)
            if resUserData then
                self.needResTxt.text.text = resUserData.num < data.specialCost[2] and "<color=#FF3838>" .. resUserData.num .. "</color> / " .. data.specialCost[2] or resUserData.num .. " / " .. data.specialCost[2]
            else
                self.needResTxt.text.text = "<color=#FF3838>0</color> / " .. data.specialCost[2]
            end
        end
    end
end

-- 打开技能树选择面板
function SkillTreePanel:OpenSkillTreeChosePanel(data, ConfigData)
    local chose_1, chose_2
    if data.coordinate[1] > 1 then
        chose_2 = data
    else
        chose_1 = data
    end
    if ConfigData.coordinate[1] < 1 then
        chose_1 = ConfigData
    else
        chose_2 = ConfigData
    end
    UIMgr:popUICover("SkillTreeChosePanel", {chose_1 = chose_1, chose_2 = chose_2, roleUid = self:getRoleId()})
    self:SelectInfo()
    self:SetNowSelect(nil)
    self.panelList:SetActive(false)
end

-- 更新技能信息
function SkillTreePanel:UpdateSkillInfo(data)
    self.curSkillId = data.specialEffect[2]
    local skillConfig = Config.GetSkillInfo(data.specialEffect[2])
    self:LoadSpriteAsync(string.format(Config.SpritePath.SkillrePlacBg, skillConfig.skillType), self.skillrePlaceBox.image)
    self.skillrePlaceTxt.text.text = skillConfig.skillTypeName
    self.skillMsgTxt.text.text = skillConfig.desKey
    self.preCdTxt.text.text = skillConfig.preCdKey
    self.skillRangeTxt.text.text = skillConfig.rangeDes
    self.rangeBg:SetActive(skillConfig.skillType == GE.SkillType.Active)
    if skillConfig.skillType ~= GE.SkillType.Active then
        self.skillMsgList.rectTransform.sizeDelta = Vector2.New(self.skillMsgList.rectTransform.sizeDelta.x, 200)
    else
        self.skillMsgList.rectTransform.sizeDelta = Vector2.New(self.skillMsgList.rectTransform.sizeDelta.x, 185)
    end
    self.skillTypeBox_1.typeTxt.text.text = skillConfig.rangeTypeDes
    self.skillTypeBox_2.typeTxt.text.text = skillConfig.skillTypeDes
    self:LoadSpriteAsync(string.format(Config.SpritePath.SkillTypeBg, skillConfig.backColorType), self.skillTypeBox_2.image)
    self:UpdateSkillRangeDisplay(skillConfig)
end

-- 更新技能范围显示
function SkillTreePanel:UpdateSkillRangeDisplay(skillConfig)
    local showConfig = Config.GetSkillRangeShowInfo(skillConfig.rangeShow)
    if showConfig then
        local lengthNum = #showConfig.DefaultParam / showConfig.WidthNum
        local newScale = math.floor(120 / math.max(showConfig.WidthNum, lengthNum)) - 2
        self.skillRangeList.gridLayoutGroup.cellSize = Vector2.New(newScale, newScale)
        self.skillRangeList.gridLayoutGroup.constraintCount = showConfig.WidthNum
        self:FillTemplateContent(self.rangebox, self.skillRangeList, #showConfig.DefaultParam, function(index, rangebox)
            ResetLocalZ(rangebox)
            rangebox.rangeIcon1:SetActive(false)
            rangebox.rangeIcon2:SetActive(false)
            rangebox.rangeIcon3:SetActive(false)
            rangebox.rangeIcon4:SetActive(false)
            if showConfig.DefaultParam[index] ~= 0 then
                rangebox["rangeIcon" .. showConfig.DefaultParam[index]]:SetActive(true)
            end
        end)
    end
end

--根据坐标显示数据
function SkillTreePanel:SetBoxStateByPos(data, index)
    for _, value in pairs(self.treeData) do
        if data.pos.x == value.coordinate[1] and data.pos.y == value.coordinate[2] and data.stage == value.stageId then
            DLuaTimer:DoAfter(index * 0.025, function()
                data.obj.canvasGroup:DOFade(1, 0.2)
            end)
            data.obj.canvasGroup.blocksRaycasts = true
            data.obj.btn.scaleButton.interactable = true
            data.config = value
            return
        else
            data.obj.canvasGroup.alpha = 0
            data.obj.canvasGroup.blocksRaycasts = false
            data.obj.btn.scaleButton.interactable = false
        end
    end
end

-- 生成线段
function SkillTreePanel:SetLineView()
    -- 每阶段只在「最上方」的中心节点（coordinate[1]==1 且 y 最小）显示阶段标题
    local stageTopCenter = {}
    for _, v in pairs(self.objList) do
        if v.obj and v.obj.rankBg then
            v.obj.rankBg:SetActive(false)
        end
        if v.config.coordinate and v.config.coordinate[1] == 1 then
            local stageId = v.config.stageId
            local y = v.config.coordinate[2]
            local cur = stageTopCenter[stageId]
            if cur == nil or y < cur.y then
                stageTopCenter[stageId] = { node = v, y = y }
            end
        end
    end
    for stageId, info in pairs(stageTopCenter) do
        info.node.obj.rankBg:SetActive(true)
        info.node.obj.rankTxt.text.text = "第" .. stageId .. "阶段"
    end

    -- 遍历对象列表画线
    for _, v in pairs(self.objList) do
        local startPos, endPos = nil, nil  -- 初始化起始和结束位置

        -- 检查解锁条件
        if v.config.unlock and next(v.config.unlock) then
            for _, unlockId in pairs(v.config.unlock) do
                local finallyPoint = v
                local startPoint = self:getObjDataById(unlockId)
                local needChange = false
                local typeMode = 0

                -- 判断起始点和目标点的阶段和坐标
                if startPoint.config.stageId == finallyPoint.config.stageId then
                    if startPoint.config.coordinate[2] == finallyPoint.config.coordinate[2] then
                        typeMode = 1  -- 同一阶段同一行
                        if startPoint.config.coordinate[1] > finallyPoint.config.coordinate[1] then
                            startPos = startPoint.obj.left
                            endPos = finallyPoint.obj.right
                            needChange = true
                        else
                            startPos = startPoint.obj.right
                            endPos = finallyPoint.obj.left
                        end
                    else
                        typeMode = 2  -- 同一阶段不同列
                        if startPoint.config.coordinate[2] > finallyPoint.config.coordinate[2] then
                            startPos = startPoint.obj.up
                            endPos = finallyPoint.obj.down  -- 下方
                        else
                            startPos = startPoint.obj.down
                            endPos = finallyPoint.obj.up  -- 上方
                        end
                    end
                elseif startPoint.config.stageId > finallyPoint.config.stageId then
                    startPos = startPoint.obj.up
                    endPos = finallyPoint.obj.down  -- 上到下
                else
                    startPos = startPoint.obj.down
                    endPos = finallyPoint.obj.up  -- 下到上
                end

                -- 创建连接线
                self:CreateLine(startPos, endPos, needChange, typeMode, startPoint, finallyPoint)
            end
        end
    end

    -- 调整线段父对象顺序，确保在格子下方
    self.lineParentObj.transform:SetAsFirstSibling()
    self.lineParentObj:SetActive(true)
end

-- 创建线段
function SkillTreePanel:CreateLine(startPoint, endPoint, needChange, typeMode, startData, endData)
    local now_point_pos = startPoint.rectTransform.position  -- 起始点位置
    local link_point_pos = endPoint.rectTransform.position  -- 结束点位置
    if self.lineParentObj == nil then
        self.lineParentObj = GameObject.Instantiate(self.lineParent)    -- 实例化线段父对象
        -- GameObject.SetParent 仅支持单参数；worldPositionStays 需走 Transform 重载
        self.lineParentObj.transform:SetParent(self.content.transform, false)
        self.lineParentObj.transform.localPosition = Vector3.zero
        ResetLocalZ(self.lineParentObj)
        self.lineParentObj.transform:SetAsFirstSibling()
    end

    -- 实例化线段对象
    local line = GameObject.Instantiate(self.line)
    line.gameObject.transform.name = "Line"
    line.gameObject.transform:SetParent(self.lineParentObj.transform, false)
    line.gameObject.transform.localPosition = Vector3.zero
    ResetLocalZ(line)
    local startWorldPos = startPoint.transform.position
    line.gameObject.transform.position = Vector3.New(startWorldPos.x, startWorldPos.y, 0)  -- 设置线段起始位置并归零Z轴
    line.gameObject.transform.localScale = needChange and Vector3.New(1, -1, 1) or Vector3.New(1, 1, 1)
    local type1Trans = line.gameObject.transform:Find("Type1")
    if type1Trans then
        type1Trans.gameObject:SetActive(true)
    end

    -- 计算线段的旋转角度
    local angle = math.atan2(link_point_pos.y - now_point_pos.y, link_point_pos.x - now_point_pos.x) * 180 / math.pi
    line.gameObject.transform.rotation = Quaternion.Euler(0, 0, angle)
    line:SetActive(true)
    self.startPoint.rectTransform.position = now_point_pos
    self.endPoint.rectTransform.position = link_point_pos
    local linkDistance = Vector2.Distance(self.startPoint.rectTransform.localPosition, self.endPoint.rectTransform.localPosition)
    line.gameObject.transform.sizeDelta = Vector3.New(linkDistance + 10, line.gameObject.transform.sizeDelta.y, 0)
    ResetLocalZ(line)
    if type1Trans then
        ResetLocalZ(type1Trans)
    end

    -- 创建临时数据存储线段信息
    local temp = {
        startData = startData.config.id,
        endData = endData.config.id,
        obj = line
    }

    -- 根据起始数据的锁定状态调整线段的显示
    if not startData.isLock and type1Trans then
        type1Trans:Find("LineOn").gameObject:SetActive(true)
        type1Trans:Find("Line").gameObject:SetActive(false)
    end

    -- 将线段信息添加到列表中
    table.insert(self.LineObjList, temp)
end

function SkillTreePanel:UnlockLine(id)
    for k,v in pairs(self.LineObjList) do
        if v.startData == id then
            v.obj.gameObject.transform:Find("Type1").gameObject.transform:Find("LineOn").gameObject:SetActive(true)
            v.obj.gameObject.transform:Find("Type1").gameObject.transform:Find("Line").gameObject:SetActive(false)
        end
    end
end

--根据id获取预制体信息
function SkillTreePanel:getObjDataById(id)
    for k,v in pairs(self.objList) do
        if v.config.id == id then
            return v
        end
    end
end

--刷新界面信息
function SkillTreePanel:Refresh()
    if self:isPreviewMode() then
        return
    end
    self.serverData = Me:getPlayerHero(self:getRoleId())
    for _, value in pairs(self.objList) do
        self:SetBoxState(value.obj, value)
    end
    self:SetNowSelect(self.nowSelectId, true)
    self:setMaxStageLevel()
end

--获取当前天赋树最大阶段值
function SkillTreePanel:setMaxStageLevel()
    if self:isPreviewMode() then
        return
    end

    local temp = {}
    local roleId = self:getRoleId()
    for i = 1, self.maxStage do
        local data = Config.GetTalentTreeStageInfoByTreeIdStageId(self.treeData[1].treeId, i)
        local stageData = Me:getTalentTreeStageDataById(roleId, i)
        table.insert(temp, stageData)
    end
    self.stageFinishTxt.text.text = tablex.size(temp).."/"..self.maxStage
end

--function SkillTreePanel:OnClose(initiative)
--
--end

function SkillTreePanel:OnDestroy()
	self.super:OnDestroy(self)
end

--function SkillTreePanel:OnRefresh(data)
--
--end

--[[
/HelpBtn onClick 
--]]
function SkillTreePanel:helpBtn_ScaleButton_onClick(helpBtn)

end

--[[
/SkillMsgPanel/OkBtn onClick 
--]]
function SkillTreePanel:okBtn_ScaleButton_onClick(okBtn)
    if self:isPreviewMode() then
        return
    end
    self:play2DSound(self.btnSoundPath)
    local roleId = self:getRoleId()
    local temp = {
        talentID = self.nowSelectId,
        RoleId = roleId,
    }
    Me:talentTreeUnLockPointReq(temp, function()
        if UIMgr:getCurUIName() ~= "SkillTreePanel" then
            return
        end
        UIMgr:popUICover("SkillTreeOnPanel", {id = temp.talentID, roleUid = roleId})
        self:Refresh()
    end)
end

--[[
/SkillBox onClick 
--]]
function SkillTreePanel:skillBox_ScaleButton_onClick(pointBox)

end

--[[
/ItemBox/ItemBtn onClick 
--]]
function SkillTreePanel:itemBtn_ScaleButton_onClick(itemBtn)

end

--[[
/SkillBox/Btn onClick 
--]]
function SkillTreePanel:btn_ScaleButton_onClick(btn)

end

--[[
/StageFinishBg onClick 
--]]
function SkillTreePanel:stageFinishBg_ScaleButton_onClick(stageFinishBg)
    if self:isPreviewMode() then
        return
    end
    self:play2DSound(self.btnSoundPath)
    UIMgr:popUICover("SkillTreeStagePanel",  {treeData = self.treeData, maxStage = self.maxStage, roleId = self:getRoleId()})
end

--[[
/PanelList/SkillPanel/Image (1)/SkillMsg onClick 
--]]
function SkillTreePanel:skillMsg_ScaleButton_onClick(skillMsg)

end

--[[
/Custom/ItemBox onClick 
--]]
function SkillTreePanel:itemBox_ScaleButton_onClick(itemBox)

end

--[[
/Custom/TagMsgBox/TagBox onClick 
--]]
function SkillTreePanel:tagBox_ScaleButton_onClick(tagBox)

end

--[[
/PanelList/ResView/LockBg onClick 
--]]
function SkillTreePanel:lockBg_ScaleButton_onClick(lockBg)

end

--[[
/Scroll View/UnSelectBtn onClick 
--]]
function SkillTreePanel:unSelectBtn_Button_onClick(unSelectBtn)
    self:play2DSound(self.btnSoundPath)
    self:SetNowSelect(nil)
end

--[[
/SkillMsgPanel/SkillMsgBg/EquipBtn onClick 
--]]
function SkillTreePanel:equipBtn_ScaleButton_onClick(equipBtn)

end

--[[
/SkillMsgPanel/SkillMsgBg/UnEquipBtn onClick 
--]]
function SkillTreePanel:unEquipBtn_ScaleButton_onClick(unEquipBtn)

end

--[[
/SkillMsgPanel/SkillMsgBg/ChangeBtn onClick 
--]]
function SkillTreePanel:changeBtn_ScaleButton_onClick(changeBtn)

end

--[[
/TagInfo onClick 
--]]
function SkillTreePanel:tagInfo_Button_onClick(tagInfo)

end

--[[
/Custom/TagMsgBox/TagBox/TagBg onClick 
--]]
function SkillTreePanel:tagBg_ScaleButton_onClick(tagBg)

end

--[[
/PanelList/SkillGroup/SkillMsgList onClick 
--]]
function SkillTreePanel:skillMsgList_ScaleButton_onClick(skillMsgList)
    self:play2DSound(self.btnSoundPath)
    local data = {
        skillId = self.curSkillId,
        target = self.skillMsgList
    }
    UIMgr:popUICover("SkillInfoListPanel", data)
end

--[[
/PanelList/SimpleGroup/MsgView/SkinView/SkinBg/SkinBox onClick 
--]]
function SkillTreePanel:skinBox_ScaleButton_onClick(skinBox)
    --TODO: 显示皮肤预览界面
    local data = {
        skinId = self.nowSelectId and self:getObjDataById(self.nowSelectId).config.specialEffect[2] or nil,
        roleId = self:getRoleId()
    }
    UIMgr:popUICover("SkinSeePanel", data)
end

return SkillTreePanel
