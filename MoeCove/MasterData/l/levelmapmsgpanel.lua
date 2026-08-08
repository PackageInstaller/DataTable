---@class LevelMapMsgPanel : LevelMapMsgPanel_Generate
---##################### 【LevelMapMsgPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【LevelMapMsgPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local LevelMapMsgPanel = require "LevelMapMsgPanel_Generate"

function LevelMapMsgPanel:InitLogic(data)
    self.nowSelectIndex = 0     --默认选中索引
    self.chapterData = {}
    self.levelConfig = {}
    self.levelData = {}
    self.nowSelectEnemyIndex = nil
    self.enemyObjList = {}
    self.skillMsgPanel.skillMsgPanel:setMono(self)
end

--function LevelMapMsgPanel:StartCreating(time)
--
--end

--function LevelMapMsgPanel:StartEnter(time)
--
--end

--function LevelMapMsgPanel:StartRemoving(time)
--
--end

--function LevelMapMsgPanel:StartExit(time)
--
--end

function LevelMapMsgPanel:OnOpen(data, initiative)
    if initiative then
        --LuaLogger.ds("data", tablex.dump(data))
        self:SetView(data)
    end
end

function LevelMapMsgPanel:SetView(data)
    self.chapterData = Config.GetChapterInfo(data.id)
    self.levelConfig = Config.GetPveLevelInfo(data.levelId)
    self.levelData = Me:getLevelDataByid(data.levelId)
    self.closeFunc = data.closeFunc
    --self.rewardBtn:SetActive(next(self.levelConfig.achieve) ~= nil and self.levelData ~= nil)
    self:SetPanelState(data.mode)
end

--根据模式设置界面显示
function LevelMapMsgPanel:SetPanelState(mode)
    if mode == self.nowSelectIndex then
        return
    end
    self.nowSelectIndex = mode
    self.enemyPanel:SetActive(self.nowSelectIndex == 1)
    self.rewardPanel:SetActive(self.nowSelectIndex == 2)

    if self.nowSelectIndex == 1 then                --敌方情报
        local total = tablex.size(self.levelConfig.monsterShow)
        self:FillTemplateContent(self.enemyMsgBox, self.normalList, total, function (index, enemyMsgBox)
            enemyMsgBox:SetActive(true)
            if self.levelConfig.monsterShow and next(self.levelConfig.monsterShow) then
                self:setEnemyBox(enemyMsgBox, self.levelConfig.monsterShow[index], index)
            end
            if index == total then
                self:selectEnemyBox(1)
            end
        end)
    elseif self.nowSelectIndex == 2 then            --隐藏奖励
        self:FillTemplateContent(self.rewardBox, self.rewardList, 3, function (index, rewardBox)
            rewardBox:SetActive(true)
            rewardBox.isNull:SetActive(self.levelConfig.achieve[index] == nil)
            rewardBox.isHas:SetActive(self.levelConfig.achieve[index] ~= nil)
            if self.levelConfig.achieve[index] ~= nil then
                local rewardAchieveConfig = Config.GetPveLevelAchieveInfo(self.levelConfig.achieve[index])
                local isFinish = self:getLevelRewardData(self.levelConfig.achieve[index])
                rewardBox.notGetIcon:SetActive(not isFinish)
                rewardBox.isGetIcon:SetActive(isFinish)
                rewardBox.taskTxt.text.text = rewardAchieveConfig.achiveDesKey
                rewardBox.notFinishBg:SetActive(not isFinish)
                rewardBox.finishBg:SetActive(isFinish)
                self:FillTemplateContent(self.customBox, rewardBox.rewardMsgList, tablex.size(rewardAchieveConfig.award), function(index, itemObj)
                    local rewardData = rewardAchieveConfig.award[index]
                    local customBox = itemObj.customBox
                    --[[local data = {
                        id = rewardData[2],
                    }
                    if rewardData[1] == GE.RewardType.ItemProp then
                        data.itemType = GE.ItemTypeIndex.item
                        data.itemNum = rewardData[3]
                    elseif rewardData[1] == GE.RewardType.Equipment then
                        data.itemType = GE.ItemTypeIndex.equip
                        data.itemNum = "Lv.1"
                    elseif rewardData[1] == GE.RewardType.Weapon then
                        data.itemType = GE.ItemTypeIndex.weapon
                    end]]
                    customBox:setMono(self)
                    customBox:SetUIData(rewardData)
                end)
            end
        end)
    end
end

--设置怪物格子显示
function LevelMapMsgPanel:setEnemyBox(obj, enemyShowData, index)
    local enemyId = enemyShowData[1]
    local enemyType = enemyShowData[2]
    local enemyConfig = Config.GetMonsterInfo(enemyId)
    if enemyConfig then
        local temp = {
            index = index,
            obj = obj,
            config = enemyConfig,
            enemyType = enemyType,
        }
        table.insert(self.enemyObjList, temp)
        obj.enemyBossBg:SetActive(enemyType == 3)
        obj.enemyBg:SetActive(enemyType ~= 3)
        --没记录过的怪物显示为未知
        if Me:isHandbookUnlocked(GE.HandbookType.Monster, enemyId) then
            -- obj.isUnKown:SetActive(false)
            obj.enemyBox.isHas:SetActive(true)
            obj.enemyBox.isNo:SetActive(false)

            obj.enemyName.text.text = enemyConfig.name
            obj.enemyShipTypeTxt.text.text = enemyConfig.typeName
            obj.moveTxt.text.text = "移动力："..enemyConfig.movePowr

            --设置信息
            local skinConfig = Config.GetCharacterSkinInfo(enemyConfig.baseSkinID) or {}
            local function is_numeric(str)
                return tonumber(str) ~= nil
            end
            local resourceFolder = nil
            if is_numeric(skinConfig.resourceFolder) then
                resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
            else
                resourceFolder = skinConfig.resourceFolder
            end

            obj.enemyBox.frameImg:SetActive(true)
            self:LoadSpriteAsync(string.format(Config.SpritePath.EnemyFrameIconPath, enemyType), obj.enemyBox.frameImg.image)
            local headIconPath = string.format(Config.SpritePath.IconRolePath, resourceFolder, skinConfig.driverKey)
            obj.enemyBox.enemyIconImg:SetActive(true)
            self:LoadSpriteAsync(headIconPath, obj.enemyBox.enemyIconImg.image)
            obj.enemyBox.typeIcon:SetActive(true)
            self:LoadSpriteAsync(string.format(Config.SpritePath.RoleTypeIconPath, enemyConfig.attribute), obj.enemyBox.typeIcon.image)
            obj.enemyBox.titleBgRed:SetActive(enemyType == 3)
            obj.enemyBox.titleBgOrange:SetActive(enemyType == 2)
            obj.enemyBox.titleNameTxt:SetActive(enemyType ~= 1)
            if enemyType == 2 then
                obj.enemyBox.titleNameTxt.text.text = "精英"
            elseif enemyType == 3 then
                obj.enemyBox.titleNameTxt.text.text = "首领"
            end
        else
            obj.enemyName.text.text = "???"
            obj.enemyShipTypeTxt.text.text = "???"
            obj.moveTxt.text.text = "移动力：???"
            -- obj.isUnKown:SetActive(true)
            obj.enemyBox.isHas:SetActive(false)
            obj.enemyBox.isNo:SetActive(true)
        end
        obj.scaleButton.onClick:RemoveAllListeners()
        obj.scaleButton.onClick:AddListener(function()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            self:selectEnemyBox(index)
        end)
    end
end

--选择怪物格子
function LevelMapMsgPanel:selectEnemyBox(index)
    if index == self.nowSelectEnemyIndex then
        return
    end
    self.nowSelectEnemyIndex = index
    LuaLogger.ds("selectEnemyBox", index)
    LuaLogger.ds("enemyObjList", tablex.dump(self.enemyObjList))
    for _, value in pairs(self.enemyObjList) do
        value.obj.isSelect:SetActive(value.index == self.nowSelectEnemyIndex)
        if value.index == index then
            self:setEnemyMsg(value.config, value.enemyType)
        end
    end
end

--设置详情信息
function LevelMapMsgPanel:setEnemyMsg(config, enemyType)
    local isOn = Me:isHandbookUnlocked(GE.HandbookType.Monster, config.id)
    self.enemyMsgPanel:SetActive(isOn)
    self.isUnKnow:SetActive(not isOn)
    self.typeIcon:SetActive(true)
    self:LoadSpriteAsync(string.format(Config.SpritePath.RoleTypeIconPath, config.attribute), self.typeIcon.image)
    self.enemyName.text.text = config.name
    self.titleNameBg:SetActive(enemyType ~= 1)
    self.titleBgBoss:SetActive(enemyType == 3)
    self.titleBgLeader:SetActive(enemyType == 2)
    if enemyType == 2 then
        self.titleNameTxt.text.text = "精英"
    elseif enemyType == 3 then
        self.titleNameTxt.text.text = "首领"
    end
    self.moveTxt.text.text  = config.movePowr
    self.shipTypeTxt.text.text = config.typeName
    local restranintConfig = Config.GetCharacterRestraintInfo(config.attribute)
    self.shipTypeBg:SetActive(true)
    self:LoadSpriteAsync(string.format(Config.SpritePath.RoleTypeBgPath, restranintConfig.restraintType), self.shipTypeBg.image)
    self.enemyMsgTxt.text.text  = config.desInfo
    local skillList = config.baseSkill
    for i = 1, 3 do
        --self["skillBox_"..i].shadow:SetActive(false)
        self["skillBox_"..i].btn.scaleButton.onClick:RemoveAllListeners()
        self["skillBox_"..i].btn.scaleButton.onClick:AddListener(function()
            local temp = {
                roleCid = config.id,
                skillId = skillList[i],
                index = i
            }

            if skillList[i] ~= nil then
                self.skillMsgPanel.skillMsgPanel:showSkillMsg(temp, true)
            end
        end)
        self["skillBox_"..i].addBg:SetActive(false)
        if skillList[i] ~= 0 and skillList[i] ~= nil then
            self["skillBox_"..i].nullBg:SetActive(false)
            self["skillBox_"..i].isOn:SetActive(true)
            local skillConfig = Config.GetSkillInfo(skillList[i])
            self["skillBox_"..i].isOn:SetActive(true)
            self["skillBox_"..i].iconImg:SetActive(true)
            self:LoadSpriteAsync(string.format(Config.SpritePath.SkillIconPath, skillConfig.icon), self["skillBox_"..i].iconImg.image)

            self["skillBox_"..i].passivity:SetActive(skillConfig.skillType == GE.SkillType.Passive)
        else
            self["skillBox_"..i].nullBg:SetActive(true)
            self["skillBox_"..i].isOn:SetActive(false)
            self["skillBox_"..i].passivity:SetActive(false)
        end
    end

    if config.talentId ~= 0 then
        local talentConfig = Config.GetSkillInfo(config.talentId)
        if talentConfig then
            self.talentBox.nullBg:SetActive(false)
            self.talentBox.isOn:SetActive(true)
            self.talentBox.iconImg:SetActive(true)
            self:LoadSpriteAsync(string.format(Config.SpritePath.SkillIconPath, talentConfig.icon), self.talentBox.iconImg.image)
        else
            self.talentBox.nullBg:SetActive(true)
            self.talentBox.isOn:SetActive(false)
        end
    else
        self.talentBox.nullBg:SetActive(true)
        self.talentBox.isOn:SetActive(false)
    end
    self.talentBox.btn.scaleButton.onClick:RemoveAllListeners()
    self.talentBox.btn.scaleButton.onClick:AddListener(function()
        local temp = {
            skillId = config.talentId
        }
        if config.talentId ~= 0 then
            self.skillMsgPanel.skillMsgPanel:showSkillMsg(temp, true)
        end
    end)
end

function LevelMapMsgPanel:_onStartDrag()
    self.isDraging = true
end
function LevelMapMsgPanel:_onStopDrag()
    self.isDraging = false
end

--根据隐藏奖励id获取是否已完成
function LevelMapMsgPanel:getLevelRewardData(rewardId)
    if self.levelData and next(self.levelData) then     
        for _, value in pairs(self.levelData.achieveList) do
            if value == rewardId then
                return true
            end
        end
    end
    return false
end

--界面关闭
function LevelMapMsgPanel:playCloseAnim()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.mask.button.interactable = false
    self.animOverCallBack:SetCallBack(function()
        if self.closeFunc then
            self.closeFunc()
        end
        self.mask.button.interactable = true
        UIMgr:closeSpecificUI(self)
    end)
end

--function LevelMapMsgPanel:OnClose(initiative)
--
--end

--function LevelMapMsgPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function LevelMapMsgPanel:OnRefresh(data)
--
--end

--[[
/mask onClick 
--]]
function LevelMapMsgPanel:mask_Button_onClick(mask)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Back)
    self:playCloseAnim()
end

--[[
/PanelBg/EnemyPanel/EnemyMsgPanel/TalentBg/TalentBox/Btn onClick 
--]]
function LevelMapMsgPanel:btn_ScaleButton_onClick(btn)

end

--[[
/SkillMsgPanel/SkillMsgBg/EquipBtn onClick 
--]]
function LevelMapMsgPanel:equipBtn_ScaleButton_onClick(equipBtn)

end

--[[
/SkillMsgPanel/SkillMsgBg/UnEquipBtn onClick 
--]]
function LevelMapMsgPanel:unEquipBtn_ScaleButton_onClick(unEquipBtn)

end

--[[
/SkillMsgPanel/SkillMsgBg/ChangeBtn onClick 
--]]
function LevelMapMsgPanel:changeBtn_ScaleButton_onClick(changeBtn)

end

--[[
/EnemyPanel/TitleBg/EnemyCloseBtn onClick 
--]]
function LevelMapMsgPanel:enemyCloseBtn_ScaleButton_onClick(enemyCloseBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Back)
    self:playCloseAnim()
end

--[[
/RewardPanel/TitleBg/RewardCloseBtn onClick 
--]]
function LevelMapMsgPanel:rewardCloseBtn_ScaleButton_onClick(rewardCloseBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Back)
    self:playCloseAnim()
end

return LevelMapMsgPanel
