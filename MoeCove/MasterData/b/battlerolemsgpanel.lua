---##################### 【BattleRoleMsgPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【BattleRoleMsgPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
---@class BattleRoleMsgPanel : BattleRoleMsgPanel_Generate
local BattleRoleMsgPanel = require "BattleRoleMsgPanel_Generate"
local battleCore = require "BattleCore"
local battleMgr = battleCore:getBattleMgr()

---@class modeData
---@field role BattleRole

function BattleRoleMsgPanel:InitLogic(data)
    self.greenAttribStr = "<color=#6AD073>%s</color>"
    self.redAttribStr = "<color=#DB3E3E>%s</color>"
    ---@type modeData
    self.modeData = nil
    self.roleConfig = {}
end

--function BattleRoleMsgPanel:StartCreating(time)
--
--end

--function BattleRoleMsgPanel:StartEnter(time)
--
--end

--function BattleRoleMsgPanel:StartRemoving(time)
--
--end

--function BattleRoleMsgPanel:StartExit(time)
--
--end

function BattleRoleMsgPanel:OnOpen(data, initiative)
    self.skillMsgPanel.skillMsgPanel:setMono(self)
    if data then
        self.modeData = data
    end
    self.skillMsgPanel.skillMsgPanel:closeSkillMask()
    self:SetView()
    self.mask.gameObject:SetActive(false)
    self.buffInfoItem:SetActive(false)
    -- self.mask.pointerListener.onPointerClickEvent = function ()
    --     if (not self.isDraging) then
    --         UIMgr:closeUI(self)
    --         UIMgr:popUI("BattleMainPanel")
    --     end
    -- end
    local dragListener = self.mask.dragListener
    dragListener.onBeginDragEvent = function (v2)
        self:_onStartDrag()
    end
    dragListener.onEndDragEvent = function (v2)
        self:_onRoleStopDrag()
    end
end

--初始化显示
function BattleRoleMsgPanel:SetView()
    ---@type BattleRole
    local role = self.modeData.role
    local roleConfig = role.roleConfig
    local skillConfig = Config.GetSkillInfo(roleConfig.normalSkill)
    local skinConfig = nil
    if role.isMonster then
        local monsterConfig = Config.GetMonsterInfo(role.cid)
        skinConfig = Config.GetCharacterSkinInfo(monsterConfig.baseSkinID)
    else
        skinConfig = Config.GetCharacterSkinInfo(role.serverData.equipSkin)
    end

    if not skinConfig then
        LuaLogger.LogError("BattleRoleMsgPanel:SetView skinConfig is nil")
    end
    -- LuaLogger.ds("roleData", tablex.dump(roleData))

    --显示详细信息
    --名称
    self.nameText.text.text = roleConfig.name

    --血量
    local hp = role:getAttrib(GE.AttribType.Hp)
    local maxHp = role:getAttrib(GE.AttribType.MaxHp)
    self.hpTxt.text.text = hp
    self.enemyHpTxt.text.text = hp
    self.npcHpTxt.text.text = hp
    self.maxHpTxt.text.text = "/"..maxHp
    local hpValue = 1.0 * hp / maxHp
    self.hpSlider.slider.value = hpValue
    self.enemyHpSlider.slider.value = hpValue
    self.npcHpSlider.slider.value = hpValue

    --等级
    self.levelText.text.text = role.showLevel

    local skillMgr = battleMgr:getSkillManager()
    local range = skillMgr:GetSkillSelectRangeByRole(skillConfig, role)
    --射程
    self.rangeTxt.text.text = self:GetAttribColorStr(range[1], skillConfig.skillRange)

    --移动
    self.moveTxt.text.text = self:GetAttribColorStr(role:getAttrib(GE.AttribType.MovePower), role:getBaseAttrib(GE.AttribType.MovePower))

    --头像&立绘
    local resourceFolder = nil
    if DLuaUtil.IsNumber(skinConfig.resourceFolder) then
        resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
    else
        resourceFolder = skinConfig.resourceFolder
    end
    local scale = 1
    self.roleImg.image.rectTransform.localScale = Vector3.New(scale, scale, 1)
    self.roleImg.canvasGroup.alpha = 0
    local iconPath = string.format(Config.SpritePath.IconRolePath, resourceFolder, skinConfig.driverKey)
    self:LoadSpriteAsync(iconPath, function(s)
        self.roleImg.image.sprite = s
        self.roleImg.canvasGroup:DOFade(1, 0.3)
    end)

    self.rolePortraitBg.canvasGroup.alpha = 0
    self.rolePortraitImg.canvasGroup.alpha = 0
    if (skinConfig.imgKey and skinConfig.imgKey ~= "") then
        local portraitPath = string.format(Config.SpritePath.PortraitRolePath, resourceFolder, skinConfig.imgKey)
        self:LoadSpriteAsync(portraitPath, function(s)
            self.rolePortraitImg.image.sprite = s
            self.rolePortraitImg.image:SetNativeSize()
            self.rolePortraitBg.canvasGroup:DOFade(1, 0.3)
            self.rolePortraitImg.canvasGroup:DOFade(1, 0.3)
        end)
        self.rolePortraitImg.rectTransform.anchoredPosition = Vector2(skinConfig.imgOffsetF[1], skinConfig.imgOffsetF[2])
        self.rolePortraitImg.rectTransform.localScale = Vector2.New(skinConfig.imgRateF, skinConfig.imgRateF)
    end

    --战舰类型
    local typeIconPath = string.format(Config.SpritePath.RoleTypeIconPath, roleConfig.attribute)
    self:LoadSpriteAsync(typeIconPath, self.shipTypeIcon.image)

    --六维
    self.torpedoTxt.text.text = self:GetAttribColorStr(role:getAttrib(GE.AttribType.Torpedo), role:getBaseAttrib(GE.AttribType.Torpedo), self.torpedoTxt.upArrow, self.torpedoTxt.downArrow)
    self.armorTxt.text.text = self:GetAttribColorStr(role:getAttrib(GE.AttribType.Armor), role:getBaseAttrib(GE.AttribType.Armor), self.armorTxt.upArrow, self.armorTxt.downArrow)
    self.evadeTxt.text.text = self:GetAttribColorStr(role:getAttrib(GE.AttribType.Evade), role:getBaseAttrib(GE.AttribType.Evade), self.evadeTxt.upArrow, self.evadeTxt.downArrow)
    self.bombardTxt.text.text = self:GetAttribColorStr(role:getAttrib(GE.AttribType.Bombard), role:getBaseAttrib(GE.AttribType.Bombard), self.bombardTxt.upArrow, self.bombardTxt.downArrow)
    self.luckyTxt.text.text = self:GetAttribColorStr(role:getAttrib(GE.AttribType.Lucky), role:getBaseAttrib(GE.AttribType.Lucky), self.luckyTxt.upArrow, self.luckyTxt.downArrow)
    self.airdefenseTxt.text.text = self:GetAttribColorStr(role:getAttrib(GE.AttribType.AirDefense), role:getBaseAttrib(GE.AttribType.AirDefense), self.airdefenseTxt.upArrow, self.airdefenseTxt.downArrow)

    -- local isEnemy = battleMgr:getRoleManager():isEnemyCampByCamp(GE.BattleCampType.Friend, role.camp)
    --self.nameText:SetActive(not isEnemy)
    --self.enemyNameText:SetActive(isEnemy)
    self.hpTxt:SetActive(GE.BattleCampType.Friend == role.camp)
    self.enemyHpTxt:SetActive(GE.BattleCampType.Enemy == role.camp)
    self.npcHpTxt:SetActive(GE.BattleCampType.FriendNPC == role.camp)
    --self.roleInfoBg:SetActive(not isEnemy)
    --self.enemyInfoBg:SetActive(isEnemy)
    -- self.hpSlider:SetActive(not isEnemy)
    -- self.enemyHpSlider:SetActive(isEnemy)
    -- self.friendHpBg:SetActive(not isEnemy)
    -- self.enemyHpBg:SetActive(isEnemy)
    -- self.friendTagImg:SetActive(not isEnemy)
    -- self.enemyTagImg:SetActive(isEnemy)
    self.friendGroup:SetActive(GE.BattleCampType.Friend == role.camp)
    self.enemyGroup:SetActive(GE.BattleCampType.Enemy == role.camp)
    self.npcGroup:SetActive(GE.BattleCampType.FriendNPC == role.camp)

    --技能面板
    local skills = role:getActiveSkillList()
    local skillIndex = 1
    for index, skillId in ipairs(skills) do
        local skillConfig = Config.GetSkillInfo(skillId)
        ---@type BattleRoleMsgPanel_Generate_skillPanel_skillBox1
        local box = self.skillPanel[string.format("skillBox%s", index)]
        if (skillConfig) then
            box.nameText.text.text = skillConfig.nameKey
            box.desText.text.text = skillConfig.desKey
            box.roundsText.text.text = skillConfig.preCd
            box.rangeText.text.text = skillConfig.skillRange
            box.distanceText.text.text = skillConfig.effectRange[2]
            box.typeText.text.text = skillConfig.skillTypeName
            box:SetActive(true)
        else
            box:SetActive(false)
        end
        skillIndex = index + 1
    end
    for i = skillIndex, 3 do
        local box = self.skillPanel[string.format("skillBox%s", i)]
        box:SetActive(false)
    end

    self:SetSkillView()
    self:RefreshBuffList()
end

---刷新Buff列表
function BattleRoleMsgPanel:RefreshBuffList()
    local role = self.modeData.role
    local buffList = role.buffController:getBuffList()
    local buffCount = #buffList
    local showBuffCount = 0
    self:FillTemplateContent(self.buffListItem, self.buffList.buffContent, buffCount, function (index, buffListItem)
        local buff = buffList[index]
        local buffConfig = buff.configData
        buffListItem:SetActive(false)
        if(string.len(buffConfig.buffIcon) > 0) then
            buffListItem:SetActive(true)
            self:LoadSpriteAsync(string.format(Config.SpritePath.BuffIconPath, buffConfig.buffIcon), buffListItem.image)
            showBuffCount = showBuffCount + 1
        end
        buffListItem.button.onClick:AddListener(function ()
            self:showBuffView()
        end)
        if index >= buffCount then
            self.buffList.gameObject:SetActive(showBuffCount > 0)
        end
    end)
end

---获取属性颜色字符串
---@param attrib number
---@param baseAttrib number
---@param upArrow UnityEngine.GameObject?
---@param downArrow UnityEngine.GameObject?
---@return string
function BattleRoleMsgPanel:GetAttribColorStr(attrib, baseAttrib, upArrow, downArrow)
    if upArrow then
        upArrow:SetActive(attrib > baseAttrib)
    end
    if downArrow then
        downArrow:SetActive(baseAttrib > attrib)
    end

    --根据属性判断显示颜色
    if (attrib > baseAttrib) then
        return string.format(self.greenAttribStr, attrib)
    elseif (baseAttrib > attrib) then
        return string.format(self.redAttribStr, attrib)
    else
        return attrib
    end
end

--设置技能显示
function BattleRoleMsgPanel:SetSkillView()
    local curRole = self.modeData.role
    local roleCid = curRole.cid
    local isMonster = curRole.isMonster
    local skillData = curRole:getActiveSkillList()
    for i = 1, 3 do
        local skillId = skillData[i]
        local hasSkill = skillId and skillId > 0
        ---@type BattleRoleMsgPanel_Generate_skillBox_1
        local curBox = self["skillBox_"..i]
        curBox.btn.scaleButton.onClick:RemoveAllListeners()
        curBox.btn.scaleButton.onClick:AddListener(function()
            local temp = {
                roleCid = roleCid,
                skillId = skillId,
                index = i
            }
            if hasSkill then
                self.skillMsgPanel.skillMsgPanel:showSkillMsg(temp, true)
            else
                if not isMonster then
                    self.skillMsgPanel.skillMsgPanel:closeSkillMask()
                end
            end
        end)
        curBox.addBg:SetActive(false)
        if hasSkill then
            curBox.nullBg:SetActive(true)
            curBox.isOn:SetActive(true)
            local skillConfig = Config.GetSkillInfo(skillId)
            curBox.passivity:SetActive(skillConfig.skillType == GE.SkillType.Passive)
            curBox.iconImg:SetActive(true)
            self:LoadSpriteAsync(string.format(Config.SpritePath.SkillIconPath, skillConfig.icon), curBox.iconImg.image)
            
            local maxCDNum = skillConfig.preCd
            local isInCD = false
            local curCDNum = curRole:getSkillCD(skillId)
            if curCDNum > 0 and maxCDNum > 0 then
                isInCD = true
                curBox.cdValueTxt.text.text = tostring(curCDNum)
                curBox.cdMask.image.fillAmount = curCDNum / maxCDNum
            end
            curBox.cdMask.gameObject:SetActive(isInCD)
        else
            curBox.nullBg:SetActive(true)
            curBox.isOn:SetActive(false)
            curBox.passivity:SetActive(false)
        end
    end
    local roleConfig = {}
    local talentConfig = {}
    local roleData = Me:getPlayerHero(roleCid)
    if isMonster then
        roleConfig = Config.GetMonsterInfo(roleCid)
        if roleConfig.talentId ~= nil and roleConfig.talentId ~= 0 then
            self.talentBox.isOn:SetActive(true)
            self.talentBox.nullBg:SetActive(true)
            talentConfig = Config.GetSkillInfo(roleConfig.talentId)
        else
            self.talentBox.isOn:SetActive(false)
            self.talentBox.nullBg:SetActive(true)
        end
    else
        roleConfig = Config.GetCharacterInfo(roleCid)
        if roleConfig.talentId[roleData.star] == nil or roleConfig.talentId[roleData.star] == 0 then
            self.talentBox.isOn:SetActive(false)
            self.talentBox.nullBg:SetActive(true)
        else
            self.talentBox.isOn:SetActive(true)
            self.talentBox.nullBg:SetActive(true)
            talentConfig = Config.GetSkillInfo(roleConfig.talentId[roleData.star])
        end
    end

    if talentConfig and next(talentConfig) then
        self.talentBox.iconImg:SetActive(true)
        self:LoadSpriteAsync(string.format(Config.SpritePath.SkillIconPath, talentConfig.icon), self.talentBox.iconImg.image)
    end

    self.talentBox.btn.scaleButton.onClick:RemoveAllListeners()
    self.talentBox.btn.scaleButton.onClick:AddListener(function()
        local temp = {}
        if isMonster then
            temp = {
                skillId = roleConfig.talentId
            }
        else
            temp = {
                skillId = roleConfig.talentId[roleData.star]
            }
        end
        if temp.skillId ~= nil and temp.skillId ~= 0 then
            self.skillMsgPanel.skillMsgPanel:showSkillMsg(temp, true)
        end
    end)
end
function BattleRoleMsgPanel:_onStartDrag()
    self.isDraging = true
end
function BattleRoleMsgPanel:_onRoleStopDrag()
    self.isDraging = false
end

---region 战斗buff显示弹窗
function BattleRoleMsgPanel:showBuffView()
    self.buffPanel.gameObject:SetActive(true)
    self:setBuffViewData()
end

function BattleRoleMsgPanel:setBuffViewData()
    local role = self.modeData.role
    local buffList = role.buffController:getBuffList()
    local content = self.buffPanel.buffContent
    local item = self.buffInfoItem
    local showBuffList = {}
    for _, buff in ipairs(buffList) do
        local buffConfig = buff.configData
        if(string.isNullOrEmpty(buffConfig.buffIcon) == false) then
            table.insert(showBuffList, buff)
        end
    end
    local buffCount = #showBuffList
    self:FillTemplateContent(item, content, buffCount, function (index, buffListItem)
        local buff = showBuffList[index]
        local buffConfig = buff.configData
        buffListItem.gameObject:SetActive(false)
        local leftRound = buff:getRemainRounds()
        local roundText = leftRound == 99 and "-" or tostring(leftRound)
        buffListItem.buffRoundsText.text.text = roundText
        buffListItem.buffDesText.text.text = buffConfig.name
        buffListItem.endLine:SetActive(buffCount > 1 and index ~= buffCount)
        self:LoadSpriteAsync(string.format(Config.SpritePath.BuffIconPath, buffConfig.buffIcon), function(s)
            buffListItem.buffIcon.image.sprite = s
            buffListItem.gameObject:SetActive(true)
            local height = buffListItem.buffDesText.text.preferredHeight
            local itemHeight = math.max(110, height + 15)
            buffListItem.rectTransform:SetSizeWithCurrentAnchors(UnityEngine.RectTransform.Axis.Vertical, itemHeight)
        end)
    end)
end

function BattleRoleMsgPanel:closeBuffView()
    self.buffPanel.gameObject:SetActive(false)
end
---endregion

--function BattleRoleMsgPanel:OnClose(initiative)
--
--end

--function BattleRoleMsgPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function BattleRoleMsgPanel:OnRefresh(data)
--
--end

--[[
/Mask onClick 
--]]
function BattleRoleMsgPanel:mask_Button_onClick(mask)
    UIMgr:closeUI(self)
    -- UIMgr:showUI("BattleMainPanel")
end

--[[
/RoleInfoGroup/RoleDetailBtn onClick 
--]]
function BattleRoleMsgPanel:roleDetailBtn_ScaleButton_onClick(roleDetailBtn)

end

--[[
/RoleInfoGroup/CheckEquipBtn onClick 
--]]
function BattleRoleMsgPanel:checkEquipBtn_ScaleButton_onClick(checkEquipBtn)

end

--[[
/RoleInfoGroup/SkillInfoBtn onClick 
--]]
function BattleRoleMsgPanel:skillInfoBtn_Button_onClick(skillInfoBtn)
    self.skillMsgPanel.skillMsgPanel:closeSkillMask()
    self.skillPanel:SetActive(true)
end

--[[
/SkillPanel/SkillPanelMask onClick 
--]]
function BattleRoleMsgPanel:skillPanelMask_Button_onClick(skillPanelMask)
    self.skillMsgPanel.skillMsgPanel:closeSkillMask()
    self.skillPanel:SetActive(false)
end

--[[
/EquipPanel/UnfoldRBtn onClick 
--]]
function BattleRoleMsgPanel:unfoldRBtn_ScaleButton_onClick(unfoldRBtn)

end

--[[
/EquipPanel/UnfoldLBtn onClick 
--]]
function BattleRoleMsgPanel:unfoldLBtn_ScaleButton_onClick(unfoldLBtn)

end

--[[
/EquipPanel/WeaponBox_1 onClick 
--]]
function BattleRoleMsgPanel:weaponBox_1_ScaleButton_onClick(weaponBox_1)

end

--[[
/EquipPanel/WeaponBox_2 onClick 
--]]
function BattleRoleMsgPanel:weaponBox_2_ScaleButton_onClick(weaponBox_2)

end

--[[
/EquipPanel/EquipList/EquipBox_1 onClick 
--]]
function BattleRoleMsgPanel:equipBox_1_ScaleButton_onClick(equipBox_1)

end

--[[
/EquipPanel/EquipList/EquipBox_2 onClick 
--]]
function BattleRoleMsgPanel:equipBox_2_ScaleButton_onClick(equipBox_2)

end

--[[
/EquipPanel/EquipList/EquipBox_3 onClick 
--]]
function BattleRoleMsgPanel:equipBox_3_ScaleButton_onClick(equipBox_3)

end

--[[
/EquipPanel/EquipList/EquipBox_4 onClick 
--]]
function BattleRoleMsgPanel:equipBox_4_ScaleButton_onClick(equipBox_4)

end

--[[
/BuffPanel/BuffPanelMask onClick 
--]]
function BattleRoleMsgPanel:buffPanelMask_Button_onClick(buffPanelMask)
    self:closeBuffView()
end

--[[
/RoleInfoGroup/SkillList/SkillBox_1/Btn onClick 
--]]
function BattleRoleMsgPanel:btn_ScaleButton_onClick(btn)

end

--[[
/SkillMsgPanel/SkillMsgBg/EquipBtn onClick 
--]]
function BattleRoleMsgPanel:equipBtn_ScaleButton_onClick(equipBtn)

end

--[[
/SkillMsgPanel/SkillMsgBg/UnEquipBtn onClick 
--]]
function BattleRoleMsgPanel:unEquipBtn_ScaleButton_onClick(unEquipBtn)

end

--[[
/SkillMsgPanel/SkillMsgBg/ChangeBtn onClick 
--]]
function BattleRoleMsgPanel:changeBtn_ScaleButton_onClick(changeBtn)

end

--[[
/BuffListItem onClick 
--]]
function BattleRoleMsgPanel:buffListItem_Button_onClick(buffListItem)

end

return BattleRoleMsgPanel
