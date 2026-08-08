---##################### 【BattleMainPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【BattleMainPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
---@class BattleMainPanel : BattleMainPanel_Generate
local BattleMainPanel = require "BattleMainPanel_Generate"
local BattleCore = require "BattleCore"
local Screen = UnityEngine.Screen
local formatStr = "%s/%s"
local maxIndex = 3

---技能按钮单击最大时间
local clickSkillTime = 0.3
---长按按钮显示技能Tips时间
local longPressTime = 0.8

function BattleMainPanel:InitLogic(data)
    self._orginRound = 1
    self._orginIndex = 1
    self._tmpRound = 1
    self._tmpIndex = 1
    ---@type BattleRole
    self._selectedRole = nil
    self._roleSkills = {}
    self.enterBattleTestBtn:SetActive(GV.IsEditor)
    self.focusLineTestBtn:SetActive(GV.IsEditor)
    self._borderLineList = {}
    self._borderLineShow = false
    self._borderLineFocusedId = nil --当前正在聚焦的id

    ---技能按钮按下时间
    self.skillBtnOnPressTime = 0
    ---@type LongPressUIEffect[]
    self.longPressUIEffects = {}       --三个技能的长按表现提示
    local LongPressUIEffect = require "LongPressUIEffect"
    for i = 1, maxIndex, 1 do
        local rTrs = self[string.format("longPressUIEffect_%s", i)].rectTransform
        local uiEffet = LongPressUIEffect:new(rTrs.gameObject)
        uiEffet.gameObject:SetActive(false)
        table.insert(self.longPressUIEffects, uiEffet)
    end

    self.btnSoundPath = string.format(Config.AudioPath.SE, "click")

    if GV.IsEditor then
        self:initFocusLine()
    end
end

--function BattleMainPanel:StartCreating(time)
--
--end

--function BattleMainPanel:StartEnter(time)
--
--end

--function BattleMainPanel:StartRemoving(time)
--
--end

--function BattleMainPanel:StartExit(time)
--
--end

function BattleMainPanel:OnOpen(data, initiative)
    self.skillMsgPanel.skillMsgPanel:setMono(self)
    if (initiative) then
        -- LuaLogger.ds("BattleMainPanel:refreshBacktraceBtns OnOpen",debug.traceback())
        self._battleMgr = BattleCore:getBattleMgr()
        ---@type ClientBattleManager
        self._clientBattleMgr = ClientBattleManager.getInstance()
        self._histroyMgr = self._battleMgr:getHistoryManager()
        self._roleMgr = self._battleMgr:getRoleManager()
        self:showInputMask(false)
        -- self._orginRound = self._histroyMgr:getLastRound()
        -- self._orginIndex = #self._histroyMgr:getDataListByRound(self._orginRound)
        -- self._tmpRound = self._orginRound
        -- self._tmpIndex = self._orginIndex
        self:SetPostProcessing()
    end
    self.roleAudioBox.gameObject:SetActive(false)
    self:refreshPanel()
    self:refreshSpeedBtn()
    self:RefreshAngleDisplay()
    self:InitAutoAndSpeedBtnState()
    self.roundGroup.gameObject:SetActive(false)
    self.skillMsgPanel.skillMsgPanel.mask.gameObject:SetActive(false)
    for i = 1, maxIndex, 1 do
        ---@type BattleMainPanel_Generate_actionGroup_skill1Btn
        local skillBtn = self.actionGroup[string.format("skill%sBtn", i)]
        local longPressListener = skillBtn.clickLongPressListener
        longPressListener.onLongpress = function ()
            self._isLongPress = true
            self:showRoleSkillInfo(i)
        end
        longPressListener.onUp = function ()
            self._isLongPress = false
            self:hideRoleSkillInfo(i)
        end

        longPressListener.onDown = function ()
            self:OnSkillBtnDown(i)
        end
    end

    self:refreshWinDesc()
    local showFullMask = false
    if initiative == true then
        showFullMask = self._clientBattleMgr:isPlayReport()
    end
    self:showFullMask(showFullMask)
end

--- 刷新战斗胜利描述
function BattleMainPanel:refreshWinDesc()
    local levelConfig = self._battleMgr:getLevelConfig()
    if levelConfig then
        self.levelTargetBox.targetText.text.text = levelConfig.victoryDesKey
        --- 设置周常BOSS标签显示
        local isWeeklyBossLevel = levelConfig.typemain == GE.LevelTypeMain.WeeklyBoss
        if isWeeklyBossLevel then
            self:ShowBossScoreBox()
        end
        self.weeklyBossTagRoot.gameObject:SetActive(isWeeklyBossLevel)
    end
end

--初始化战斗相机聚焦边界
function BattleMainPanel:initFocusLine()
    local borderList = Config.GetConfigInfo("cameraRange")
    local width = Screen.width
    local height = Screen.height
    self:FillTemplateContent(self.focusLine, self.focusLineGroup, #borderList, function(index, focusLine)
        if self._borderLineShow then
            focusLine.lineId.text.text = index
            focusLine.selected:SetActive(self._borderLineFocusedId == index)
            focusLine.image.color = Color.New(math.random(0,1), math.random(0,1), math.random(0,1), 0.2)  
            focusLine.rectTransform.offsetMin = Vector2.New(borderList[index][1] * width, borderList[index][3] * height)
            focusLine.rectTransform.offsetMax = Vector2.New(-borderList[index][2] * width, -borderList[index][4] * height)
            self._borderLineList[index] = focusLine
        end
        focusLine:SetActive(self._borderLineShow)
    end)
end
--function BattleMainPanel:OnClose(initiative)
--
--end

function BattleMainPanel:OnDestroy()

    if self.longPressUIEffects ~= nil then
        for i,v in ipairs(self.longPressUIEffects) do
            v:OnDestroy()
        end
    end
    self.longPressUIEffects = nil

    -- if self.super.OnDestroy ~= nil then
    --     self.super:OnDestroy(self)
    -- end
    self.super:OnDestroy(self)
end

--function BattleMainPanel:OnRefresh(data)
--
--end

function BattleMainPanel:refreshPanel()
    self._curBattleMaxRound = tostring(self._battleMgr:getMaxRounds())
    self.maxRoundsText.text.text = self._curBattleMaxRound
    self.curRoundText.text.text = self._battleMgr:getCurrentRound()
    self.backtraceRoundTxt.text.text = string.format("%s/%s",self._battleMgr:getCurrentRound(),self._battleMgr:getMaxRounds())

    self.allMemberCntText.text.text = tablex.size(self._roleMgr:getRolesByCamp(self._roleMgr:actionCamp()))
    self.actionMemberCntText.text.text = tablex.size(self._roleMgr:getActionRolesByCamp(self._roleMgr:actionCamp()))
end

---显示角色信息
---@param roleInfo BattleRole
function BattleMainPanel:showRoleInfo(roleInfo)
    --头像
    local skinConfig = {}
    if roleInfo.isMonster then
        local monsterConfig = Config.GetMonsterInfo(roleInfo.cid)
        skinConfig = Config.GetCharacterSkinInfo(monsterConfig.baseSkinID)
    else
        skinConfig = Config.GetCharacterSkinInfo(roleInfo.serverData.equipSkin)
    end
    local resourceFolder = nil
    local folder = tonumber(skinConfig.resourceFolder)
    if folder then
        resourceFolder = tostring(math.floor(folder))
    else
        resourceFolder = skinConfig.resourceFolder
    end
    --左上角角色头像使用半身像
    -- local iconPath = string.format(Config.SpritePath.IconRolePath, resourceFolder, skinConfig.driverKey)
    local iconPath = string.format(Config.SpritePath.CutRolePath, resourceFolder, skinConfig.halfimgKey)
    self:LoadSpriteAsync(iconPath, self.roleInfo.roleImg.image)

    --战舰类型
    local typeIconPath = string.format(Config.SpritePath.RoleTypeIconPath, roleInfo.roleConfig.attribute)
    self:LoadSpriteAsync(typeIconPath, self.roleInfo.shipTypeIcon.image)

    --等级
    self.roleInfo.levelText.text.text = roleInfo.showLevel

    --名字
    self.roleInfo.nameText.text.text = roleInfo.roleConfig.name

    --血量
    local hp = roleInfo:getAttrib(GE.AttribType.Hp)
    local maxHp = roleInfo:getAttrib(GE.AttribType.MaxHp)
    self.roleInfo.maxHpText.text.text = string.format("/%s", maxHp)
    self.roleInfo.hpText.text.text = hp
    self.roleInfo.enemyHpText.text.text = hp
    self.roleInfo.npcHpText.text.text = hp

    --血条
    local hpValue = 1.0 * hp / maxHp
    self.roleInfo.hpSlider.slider.value = hpValue
    self.roleInfo.enemyHpSlider.slider.value = hpValue
    self.roleInfo.npcHpSlider.slider.value = hpValue

    self.roleInfo:SetActive(true)
    self.restrictionInfo:SetActive(false)
    self.roundsBox:SetActive(false)

    -- local isEnemy = self._roleMgr:isEnemyCampByCamp(GE.BattleCampType.Friend, roleInfo.camp)
    -- self.roleInfo.friendColor:SetActive(not isEnemy)
    -- self.roleInfo.enemyColor:SetActive(isEnemy)
    self.roleInfo.hpText:SetActive(GE.BattleCampType.Friend == roleInfo.camp)
    self.roleInfo.enemyHpText:SetActive(GE.BattleCampType.Enemy == roleInfo.camp)
    self.roleInfo.npcHpText:SetActive(GE.BattleCampType.FriendNPC == roleInfo.camp)
    -- self.roleInfo.hpSlider:SetActive(not isEnemy)
    -- self.roleInfo.enemyHpSlider:SetActive(isEnemy)
    self.roleInfo.friendGroup:SetActive(GE.BattleCampType.Friend == roleInfo.camp)
    self.roleInfo.enemyGroup:SetActive(GE.BattleCampType.Enemy == roleInfo.camp)
    self.roleInfo.npcGroup:SetActive(GE.BattleCampType.FriendNPC == roleInfo.camp)
end

function BattleMainPanel:hideRoleInfo()
    self.roleInfo:SetActive(false)
    self.restrictionInfo:SetActive(true)
    self.roundsBox:SetActive(true)
end

function BattleMainPanel:showBlockInfo(blockInfo)
    --LuaLogger.ds("BattleMainPanel:showBlockInfo blockInfo", tablex.dump(blockInfo))
    self.blockNameText.text.text = blockInfo.name
    local defAdd = (blockInfo.defAdd - 1)*100
    self.blockDefAddText.text.text = "防御"..(defAdd >= 0 and "+" or "")..defAdd.."%"
    self.blockInfo:SetActive(true)
    --地形图标
    local icon = blockInfo.mapPcr
    -- local icon = "test"
    if icon then
        local defAddIconPath = string.format(Config.SpritePath.BattleBlockDefAddPath, icon)
        self:LoadSpriteAsync(defAddIconPath, self.blockImg.image)
    end
end

function BattleMainPanel:hideBlockInfo()
    self.blockInfo:SetActive(false)
end

function BattleMainPanel:showBacktraceBtn(isShow)
    self.backtraceBtn:SetActive(isShow)
end

function BattleMainPanel:OnRefreshBacktraceData()
    self._roleMgr:calculateAllRolesActionRange()
    local isShowDangerRange = self._clientBattleMgr:isShowDangerBlockRange()
    if isShowDangerRange then
        self._clientBattleMgr:showDangerRange()
    end
end

function BattleMainPanel:refreshBacktraceBtns()
    BattleCore.ds("BattleMainPanel:refreshBacktraceBtns orginRound", self._orginRound)
    self.backtraceTimesTxt.text.text = self._battleMgr:getBacktraceTimes()
    self.backtraceBtn.scaleButton.interactable = self._battleMgr:getBacktraceTimes() > 0
    local lastIndex = 0
    local histroyData = self._histroyMgr:getDataListByRound(self._orginRound)
    if histroyData then
        lastIndex = #histroyData
    end
    --判断
    local stateList = {
        [1] = self._tmpRound > 1,               --上一回合
        [2] = self._tmpRound < self._orginRound,    --下一回合
        [3] = self._tmpRound > 1 or self._tmpIndex > 1, --上一个角色
        [4] = self._tmpRound < self._orginRound or self._tmpIndex < lastIndex,  --下一个角色
    }
    local interactableList = {
        [1] = {
            button = self.lastRoundBtn,
            disableIcon = self.lastRoundBtn.disable,
            text = self.lastRoundTxt
        },
        [2] = {
            button = self.nextRoundBtn,
            disableIcon = self.nextRoundBtn.disable,
            text = self.nextRoundTxt
        },
        [3] = {
            button = self.lastRoleBtn,
            disableIcon = self.lastRoleBtn.disable,
            text = self.lastRoleTxt
        },
        [4] = {
            button = self.nextRoleBtn,
            disableIcon = self.nextRoleBtn.disable,
            text = self.nextRoleTxt
        },
    }
    for i, v in ipairs(interactableList) do
        v.button.scaleButton.interactable = stateList[i]    --交互
        v.disableIcon:SetActive(stateList[i] == false)      --禁止提示
        v.text.text.color = stateList[i] and Color.New(1,1,1,1) or Color.New(116/255, 116/255, 116/255,1)   --文字变色
    end

    -- 失败/非三星回溯进入时已停在最后历史节点，允许直接确认
    if self._clientBattleMgr:isPendingLoseBacktrace() then
        self.backtraceConfirmBtn.scaleButton.interactable = true
    else
        self.backtraceConfirmBtn.scaleButton.interactable = (self._tmpRound ~= self._orginRound) or (self._tmpIndex ~= lastIndex)
    end
end

function BattleMainPanel:showRoleAction(isShow, role, actionType)
    self.roleAction:SetActive(isShow)
    self.skillBtnGroup:SetActive(actionType == GE.RoleActionType.Normal)
    if (role) then
        self._selectedRole = role
        self:setSkill()
        self:enterActionState()
    end
end

---设置技能
function BattleMainPanel:setSkill()
    ---@type integer[]
    self._roleSkills = {}
    local baseSkills = self._selectedRole:getActiveSkillList()
    local skillCount = #baseSkills
    
    --普通攻击
    local skillConfig = Config.GetSkillInfo(self._selectedRole.normalSkill)
    self:LoadSpriteAsync(string.format(Config.SpritePath.SkillIconPath, skillConfig.icon), self.actionGroup.normalSkillBtn.image)
    self.actionGroup.switchNormalSkillBtn:SetActive(self._selectedRole.normalSkill2 ~= 0)

    --技能
    for skillIndex = 1, maxIndex do
        ---@type BattleMainPanel_Generate_actionGroup_skill1Btn
        local btn = self.actionGroup[string.format("skill%sBtn", skillIndex)]
        local hasSkill = false
        local btnCanClick = false
        if skillIndex <= skillCount then
            local skillId = baseSkills[skillIndex]
            self._roleSkills[skillIndex] = skillId
            local skillConfig1 = Config.GetSkillInfo(skillId)
            if (skillConfig1) then
                local isInCD = false
                -- btn.nameTxt.text.text = LocalStrEnum[skillConfig1.nameKey]
                --技能图标
                self:LoadSpriteAsync(string.format(Config.SpritePath.SkillIconPath, skillConfig1.icon), btn.skillIcon.image)

                --技能类型
                if (skillConfig1.skillType == GE.SkillType.Active or skillConfig1.skillType == GE.SkillType.Preparatory) then
                    btnCanClick = true
                    btn.infinityBox:SetActive(true)
                    btn.passiveBox:SetActive(false)
                    local maxCDNum = skillConfig1.preCd
                    local curCDNum = self._selectedRole:getSkillCD(skillId)
                    if curCDNum > 0 then
                        isInCD = true
                        btn.cDText.text.text = tostring(curCDNum)
                        btn.cDMask.image.fillAmount = curCDNum/maxCDNum
                    end
                else
                    btn.scaleButton.interactable = false
                    btn.passiveBox:SetActive(true)
                    btn.infinityBox:SetActive(false)
                end

                --技能CD
                local alphaCD = isInCD and 1 or 0
                btn.skillCD.canvasGroup.alpha = alphaCD
                btnCanClick = btnCanClick and isInCD == false
                hasSkill = true
            end
        end
        local longPressListener = btn.clickLongPressListener
        local alphaNum = hasSkill and 1 or 0
        btn.normal.canvasGroup.alpha = alphaNum
        btn.scaleButton.interactable = hasSkill
        btn.normal.canvasGroup.blocksRaycasts = hasSkill
        longPressListener.enabled = hasSkill
        -- btn.nullSkill.canvasGroup.alpha = 1 - alphaNum
    end
end

function BattleMainPanel:showBacktrace(isShow)
    self.backtraceGroup:SetActive(isShow)
    self:showMainGroup(not isShow)
    self._battleMgr:setInBacktrace(isShow)
    if (isShow) then
        self.actionGroup:SetActive(false)
        self._clientBattleMgr:removeMoveRange()
    else
        self:ShowBossScoreBox()
    end
end

function BattleMainPanel:showMainGroup(isShow)
    self.mainGroup:SetActive(isShow)
end

function BattleMainPanel:showAutoModeHideGroup(isShow)
    self.autoModeHideGroup:SetActive(isShow)
end

function BattleMainPanel:showFullMaskHideGroup(isShow)
    self.fullMaskHideGroup:SetActive(isShow)
end

function BattleMainPanel:showInputMask(isShow)
    self.inputMask:SetActive(isShow)
end

function BattleMainPanel:enterActionState()
    self._lastRoleState = self._curRoleState
    self._curRoleState = GE.BattleRoleState.ActionState
    self.actionGroup:SetActive(true)
    self.chooseTargetGroup:SetActive(false)
    self.doSkillGroup:SetActive(false)
    self:showMainGroup(true)
end

function BattleMainPanel:enterChooseState()
    if self._curRoleState == GE.BattleRoleState.ChooseState then
        BattleCore.ws("BattleMainPanel:enterChooseState already in ChooseState")
        return
    end
    self._lastRoleState = self._curRoleState
    self._curRoleState = GE.BattleRoleState.ChooseState
    local skillConfig = Config.GetSkillInfo(self._selectedRole.selectedSkill)
    self:LoadSpriteAsync(string.format(Config.SpritePath.SkillIconPath, skillConfig.icon), self.chooseTargetGroup.skillIcon.image)
    self.chooseTargetGroup.tipText.text.text = LocalStrEnum["skillOperateTypeDes_"..skillConfig.skillOperateType]--"请选择目标"
    self.chooseTargetGroup.skillNameText.text.text = skillConfig.nameKey
    self.chooseTargetGroup.skillDesText.text.text = skillConfig.desKey
    self.actionGroup:SetActive(false)
    self.chooseTargetGroup:SetActive(true)
    self.doSkillGroup:SetActive(false)
    self:showMainGroup(false)
end

function BattleMainPanel:enterDoSkillState()
    if self._curRoleState == GE.BattleRoleState.DoSkillState then
        BattleCore.ws("BattleMainPanel:enterDoSkillState already in DoSkillState")
        return
    end
    self._lastRoleState = self._curRoleState
    self._curRoleState = GE.BattleRoleState.DoSkillState
    self.actionGroup:SetActive(false)
    self.chooseTargetGroup:SetActive(false)
    self.doSkillGroup:SetActive(true)
    self:showMainGroup(false)
    self:showVSInfo()
end

function BattleMainPanel:enterLastState()
    BattleCore.ds("BattleMainPanel:enterLastState", self._lastRoleState)
    if (self._lastRoleState == GE.BattleRoleState.ActionState) then
        self._battleMgr:refreshRoleActionState(self._selectedRole)
        self._battleMgr:callClientShowEvent(GE.ClientBattleShowType.RefreshRoleAction, {
            role = self._selectedRole
        })
        self:enterActionState()
    elseif (self._lastRoleState == GE.BattleRoleState.ChooseState) then
        self._selectedRole:skillChooseTarget()
        self:enterChooseState()
    elseif (self._lastRoleState == GE.BattleRoleState.DoSkillState) then
        self:enterDoSkillState()
    else
        BattleCore.es("BattleMainPanel:enterLastState no lastRoleState", self._lastRoleState)
    end
end

function BattleMainPanel:refreshSpeedBtn()
    local speedValue = self._clientBattleMgr:getBattleSpeed()
    self.speedChangeBtn.speedChangeIcon1:SetActive(speedValue == 1)
    self.speedChangeBtn.speedChangeIcon2:SetActive(speedValue == 2)
    self.speedChangeBtn.speedChangeIcon3:SetActive(speedValue == 3)
end

function BattleMainPanel:InitAutoAndSpeedBtnState()
    local levelconfig = self._battleMgr:getLevelConfig()
    if levelconfig then
        if not self.autoCloseBtn.activeSelf then
            self.autoBtn:SetActive(levelconfig.autoForbid == 0)
        end
        self.speedChangeBtn:SetActive(levelconfig.speedUpForbid == 0)
        self.angleChangeBtn:SetActive(levelconfig.cameraForbid == 0)
        self.pauseBtn:SetActive(levelconfig.id > 10102)
        self:showBacktraceBtn(levelconfig.id > 10102)
    end
end

function BattleMainPanel:showFullMask(isShow)
    self.fullMask:SetActive(isShow)
end

function BattleMainPanel:cancelBacktrace()
    self:showFullMask(true)
    if (self._orginRound ~= self._tmpRound or self._orginIndex ~= self._tmpIndex) then
        local histroyData = self._histroyMgr:getHistoryData(self._orginRound, self._orginIndex)
        self._clientBattleMgr:setCreateRoleCallback(function()
            self:showFullMask(false)
        end)
        self._battleMgr:resetBattleData(histroyData)
    end
    self:showBacktrace(false)
    self._battleMgr:confirmBackTrace()
    self._battleMgr:cancelBackTrace()
    local isShowDangerRange = self._clientBattleMgr:isShowDangerBlockRange()
    if isShowDangerRange then
        self._clientBattleMgr:showDangerRange()
    end
    self._clientBattleMgr:SetCanInputClick(true)
    if self._clientBattleMgr:isPendingLoseBacktrace() then
        -- 失败/非三星回溯中取消，直接结算，与弹窗取消一致
        self._clientBattleMgr:settleLoseBattle()
        return
    end
    self._battleMgr:setBattleState(GE.BattleState.RoleAction)
end

---显示战斗双方信息
function BattleMainPanel:showVSInfo()
    --判定目标数量
    local targets = self._battleMgr:getSkillTargets()
    if targets == nil or #targets ~= 1 then
        self.vSInfoBox:SetActive(false)
        return
    end
    local curBlock = targets[1]

    --获取双方角色信息，判定双方角色是否存在
    ---@type BattleRole
    local hero = self._selectedRole
    ---@type BattleRole
    local target = curBlock:tryGetRole()
    if (not hero or not target) then
        self.vSInfoBox:SetActive(false)
        return
    end

    --展示攻击方信息
    self:showVSHeroInfo(hero, target, true)

    --展示受击方信息
    self:showVSHeroInfo(target, hero, false)

    self.vSInfoBox.leftFriendHpIcon:SetActive(GE.BattleCampType.Friend == hero.camp)
    self.vSInfoBox.leftEnemyHpIcon:SetActive(GE.BattleCampType.Enemy == hero.camp)
    self.vSInfoBox.leftNpcHpIcon:SetActive(GE.BattleCampType.FriendNPC == hero.camp)
    self.vSInfoBox.rightFriendHpIcon:SetActive(GE.BattleCampType.Friend == target.camp)
    self.vSInfoBox.rightEnemyHpIcon:SetActive(GE.BattleCampType.Enemy == target.camp)
    self.vSInfoBox.rightNpcHpIcon:SetActive(GE.BattleCampType.FriendNPC == target.camp)

    self.vSInfoBox:SetActive(true)
end

---展示VS角色信息
---@param hero BattleRole
---@param target BattleRole
---@param isLeft boolean
function BattleMainPanel:showVSHeroInfo(hero, target, isLeft)
    local uiGroup = isLeft and self.vSInfoBox.leftGroup or self.vSInfoBox.rightGroup
    --头像
    local heroSkinConfig = {}
    if hero.isMonster then
        local monsterConfig = Config.GetMonsterInfo(hero.cid)
        heroSkinConfig = Config.GetCharacterSkinInfo(monsterConfig.baseSkinID)
    else
        heroSkinConfig = Config.GetCharacterSkinInfo(hero.serverData.equipSkin)
    end
    local resourceFolder = nil
    local folder = tonumber(heroSkinConfig.resourceFolder)
    if folder then
        resourceFolder = tostring(math.floor(folder))
    else
        resourceFolder = heroSkinConfig.resourceFolder
    end
    local heroIconPath = string.format(Config.SpritePath.IconRolePath, resourceFolder, heroSkinConfig.driverKey)
    uiGroup.roleImg:SetActive(true)
    self:LoadSpriteAsync(heroIconPath, uiGroup.roleImg.image)

    --战舰类型
    local heroTypeIconPath = string.format(Config.SpritePath.RoleTypeIconPath, hero.roleConfig.attribute)
    uiGroup.shipTypeIcon:SetActive(true)
    self:LoadSpriteAsync(heroTypeIconPath, uiGroup.shipTypeIcon.image)
    
    --名字
    uiGroup.nameText.text.text = hero.roleConfig.name

    --等级
    uiGroup.levelText.text.text = "Lv."..hero.showLevel

    --当前血量
    local curHP = hero:getAttrib(GE.AttribType.Hp)
    local previewValue, previewIsRepaire = nil, nil
    if isLeft == false then
        previewValue, previewIsRepaire = self._clientBattleMgr:getHpPreviewValue()
    end
    local changeValue = 0
    if previewValue then
        local num = previewIsRepaire and 1 or -1
        changeValue = num * previewValue
    end
    local afterValue = curHP + changeValue
    local maxHP = hero:getAttrib(GE.AttribType.MaxHp)
    local hpValue = 1.0 * curHP / maxHP
    local afterHpValue = 1.0 * afterValue / maxHP
    local maxValue = math.max(afterHpValue, hpValue)
    maxValue = math.min(maxValue, 1)
    local minValue = math.min(afterHpValue, hpValue)
    minValue = math.max(minValue, 0)
    local curSlider, curPreviewImg = nil, nil
    local myCamp = hero.camp
    if myCamp == GE.BattleCampType.Friend then
        curSlider = uiGroup.friendHpSlider
        curPreviewImg = uiGroup.friendGroup.hpPreviewImg
    elseif myCamp == GE.BattleCampType.FriendNPC then
        curSlider = uiGroup.npcHpSlider
        curPreviewImg = uiGroup.npcGroup.hpPreviewImg
    else
        curSlider = uiGroup.enemyHpSlider
        curPreviewImg = uiGroup.enemyGroup.hpPreviewImg
    end
    curSlider.slider.value = minValue
    --是否死亡
    curSlider.breakImage:SetActive(minValue <= 0)
    if isLeft == false then
        local c = previewIsRepaire and Color.New(35/255, 1, 149/255, 1) or Color.New(1, 0, 0, 1)
        curPreviewImg.gameObject:SetActive(changeValue ~= 0)
        curPreviewImg.image.fillAmount = maxValue
        curPreviewImg.image.color = c
    end

    -- uiGroup.friendHpSlider.slider.value = hpValue
    -- uiGroup.enemyHpSlider.slider.value = hpValue
    -- uiGroup.npcHpSlider.slider.value = hpValue
    uiGroup.hpText.text.text = curHP.."<color=#b7b7b7>/"..maxHP.."</color>"

    --优劣势
    local heroRestraintConfig = Config.GetCharacterRestraintInfo(hero.roleConfig.attribute)
    local heroRestraintValue = heroRestraintConfig.ratio[target.restraintType]
    uiGroup.advantageImg:SetActive(heroRestraintValue > 1)
    uiGroup.disadvantageImg:SetActive(heroRestraintValue < 1)

    --Buff
    self:refreshVSBuffList(hero, uiGroup)

    --根据阵营展示不同UI
    uiGroup.friendGroup:SetActive(GE.BattleCampType.Friend == hero.camp)
    uiGroup.enemyGroup:SetActive(GE.BattleCampType.Enemy == hero.camp)
    uiGroup.npcGroup:SetActive(GE.BattleCampType.FriendNPC == hero.camp)
end

---刷新VS角色信息Buff列表
---@param hero BattleRole
---@param uiGroup GameObject
function BattleMainPanel:refreshVSBuffList(hero, uiGroup)
    local buffList = hero.buffController:getBuffList()
    local buffCount = #buffList
    local showBuffCount = 0
    self:FillTemplateContent(self.vSInfoBox.buffIcon, uiGroup.buffContent, buffCount, function (index, buffListItem)
        local buff = buffList[index]
        local buffConfig = buff.configData
        buffListItem:SetActive(false)
        if(string.len(buffConfig.buffIcon) > 0) then
            buffListItem:SetActive(true)
            self:LoadSpriteAsync(string.format(Config.SpritePath.BuffIconPath, buffConfig.buffIcon), buffListItem.image)
            showBuffCount = showBuffCount + 1
        end
    end)
end

---显示角色声音界面
---@param skinConfig CharacterSkinTable
---@param roleName LocalStrEnum
---@param nowLineConfig ScriptLinesTable
---@param actionId integer
function BattleMainPanel:ShowRoleAudio(skinConfig, nowLineConfig, roleName, actionId)
    -- local resourceFolder = nil
    -- local numberPath = tonumber(skinConfig.resourceFolder)
    -- if numberPath ~= nil then
    --     resourceFolder = tostring(math.floor(numberPath))
    -- else
    --     resourceFolder = skinConfig.resourceFolder
    -- end
    -- local iconPath = string.format(Config.SpritePath.IconRolePath, resourceFolder, skinConfig.driverKey)
    -- self:LoadSpriteAsync(iconPath, function(sprite)
    --     self.roleAudioBox.roleImg.image.sprite = sprite
    -- end)
    if UICommonUtils.Checkobj(self.nowSpineObj) then
        GameObject.Destroy(self.nowSpineObj)
    end
    local newScale = 0.25
    local baseSpineName = "Role_"..skinConfig.CharacterID
    local prefabPath = string.format(Config.PrefabPath.RoleSpine, baseSpineName, baseSpineName)
    self:LoadGameObjectAsync(prefabPath, function (obj)
        self.nowSpineObj = obj
        local spineObject = self.nowSpineObj
        spineObject:SetParent(self.roleAudioBox.spineMask.transform)
        spineObject.transform.sizeDelta = Vector2.New(300, 5000)
        spineObject.transform.localScale = Vector3.New(newScale, newScale, newScale)
        local headPointPos = spineObject.transform:Find("HeadPoint").transform.localPosition
        spineObject.transform.localPosition = Vector3.New(-headPointPos.x * newScale, (-headPointPos.y * newScale) + 30, 0)

        self:doSpineAction(spineObject, actionId)
        self.roleAudioBox.gameObject:SetActive(true)
    end)
    self.roleAudioBox.roleName.text.text = roleName
    self.roleAudioBox.roleLines.text.text = nowLineConfig.line
    self.roleAudioBox.communicatingTxt.text.text = "通讯中"
end

--角色spine表情
function BattleMainPanel:doSpineAction(nowObj, actionId)
    if not actionId then
        return
    end
    local actionList = {}
    actionList = Config.GetActionDesignInfoByGroupId(actionId)

    local spineAnimation = nowObj:GetComponent("SetSpineAnimation")
    local objSpine = nowObj:GetComponent("SkeletonGraphic")
    local objSpineAnim = nowObj:GetComponent("SkeletonAnimation")

    --首先分出表情与动作
    local poseList = {}
    local emoteList = {}
    for _, actionConfig in pairs(actionList) do
        if actionConfig.basicType == GE.RoleSpineActionType.Emote then
            table.insert(emoteList, actionConfig)
        elseif actionConfig.basicType == GE.RoleSpineActionType.Action then
            --先将需要拼接的动作拆分放入列表
            local lastEndName = ""
            local newBeginName = ""

            local newName = actionConfig.resource
            newBeginName = string.gsub(newName, "_idle", "_begin")
            local nowName = ""
            if objSpineAnim.AnimationState:GetTrack(actionConfig.basicType) then
                nowName = objSpineAnim.AnimationState:GetTrack(actionConfig.basicType).Animation.Name
            end
            lastEndName = string.gsub(nowName, "_idle", "_end")

            local newActConfig = {
                basicType = GE.RoleSpineActionType.Action,
                actType = 2,
            }

            if lastEndName ~= nowName and spineAnimation:CheckAnimationExist(lastEndName) then
                newActConfig.resource = lastEndName
                table.insert(poseList, clone(newActConfig))
            end

            if newBeginName ~= newName and spineAnimation:CheckAnimationExist(newBeginName) then
                newActConfig.resource = newBeginName
                table.insert(poseList, clone(newActConfig))
            end

            table.insert(poseList, actionConfig)
        end
    end

    --动作轨道
    for k, poseConfig in pairs(poseList) do
        local setTrack = poseConfig.basicType
        local poseName = poseConfig.resource
        local isLoop = poseConfig.actType == 1

        if k == 1 then
            objSpineAnim.AnimationState:SetAnimation(setTrack, poseName, isLoop)
        else
            local defaultTime = objSpine.Skeleton.Data:FindAnimation(poseList[k - 1].resource).Duration
            objSpineAnim.AnimationState:AddAnimation(setTrack, poseName, isLoop, defaultTime)
        end
    end

    --表情轨道
    if next(emoteList) then
        for k, emoteConfig in pairs(emoteList) do
            local setTrack = emoteConfig.basicType
            local emoteName = emoteConfig.resource
            local isLoop = emoteConfig.actType == 1

            if k == 1 then
                objSpineAnim.AnimationState:SetAnimation(setTrack, emoteName, isLoop)
            else
                local defaultTime = objSpine.Skeleton.Data:FindAnimation(emoteList[k - 1].resource).Duration
                objSpineAnim.AnimationState:AddAnimation(setTrack, emoteName, true, defaultTime)
            end
        end
    else
        objSpineAnim.AnimationState:ClearTrack(GE.RoleSpineActionType.Emote)
    end
end

function BattleMainPanel:HideRoleAudio()
    self.roleAudioBox.gameObject:SetActive(false)
end

---切换回合时的显示
---@param state BattleMainPanelRoundShowType
---@param roundNum integer?
function BattleMainPanel:ShowRound(state, roundNum)
    local isNone = state == GE.BattleMainPanelRoundShowType.None
    self.roundGroup.gameObject:SetActive(isNone == false)
    if isNone then
        return
    end
    local isMyTurn = state == GE.BattleMainPanelRoundShowType.MyTurn
    self.roundGroup.battleStart.gameObject:SetActive(state == GE.BattleMainPanelRoundShowType.BattleStart)
    self.roundGroup.myTurn.gameObject:SetActive(isMyTurn)
    self.roundGroup.enemyTurn.gameObject:SetActive(state == GE.BattleMainPanelRoundShowType.EnemyTurn)
    if isMyTurn and roundNum then
        self.roundGroup.roundText.text.text = string.format(formatStr, roundNum, self._curBattleMaxRound)
    end
end

--- 设置相机的后处理
function BattleMainPanel:SetPostProcessing()
    --特效相关
    --local UICamera = UIMgr.uiCamera
    --local cameraData = UICamera:GetComponent(typeof(UnityEngine.Rendering.Universal.UniversalAdditionalCameraData))
    --if cameraData then
    --    cameraData.renderPostProcessing = true                      --后处理
    --    cameraData.volumeTrigger = self.uiVolume.transform          --特效触发器
    --    cameraData.volumeLayerMask = LayerMask.GetMask("UI")            --默认层和UI层
    --end
end

--隐藏侧边按钮列表
function BattleMainPanel:hideBtnList()
    self.btnList:SetActive(false)
end

function BattleMainPanel:openBtnList()
    self.btnList:SetActive(true)
end

function BattleMainPanel:showRoleSkillInfo(index)
    local skillId = self._roleSkills[index]
    if skillId and skillId > 0 then
        self.skillMsgPanel.gameObject:SetActive(true)
        ---@type SkillMsgPanelData
        local skillData = {
            skillId = skillId,
            roleCid = self._selectedRole.cid,
        }
        self.skillMsgPanel.skillMsgPanel:setSkillMsgView(skillData, true)
    end
end

function BattleMainPanel:OnSkillBtnDown(skillIndex)
    --开始计时长按进度显示条 TODO
    local uiEffect = self.longPressUIEffects[skillIndex]
    if uiEffect ~= nil then
        uiEffect:Start(clickSkillTime, longPressTime, 0.986)    
    end

    self.skillBtnOnPressTime = Time.time
end

function BattleMainPanel:hideRoleSkillInfo()
    self.skillMsgPanel.gameObject:SetActive(false)

    --关闭计时长按进度显示条 
    for i,v in ipairs(self.longPressUIEffects) do
        v:Hide()
    end
end

function BattleMainPanel:onClickSkillBtn(skillIndex)
    if self._isLongPress then
        return
    end

    if (Time.time - self.skillBtnOnPressTime) > clickSkillTime and not self.userGuidePanel.activeSelf then
        return
    end

    local canClick = false
    local skillId = self._roleSkills[skillIndex]
    if skillId and skillId > 0 then
        local skillConfig = Config.GetSkillInfo(skillId)
        if skillConfig then
            local skillType = skillConfig.skillType
            canClick = skillType == GE.SkillType.Active
            if skillType == GE.SkillType.Passive then
                UICommonUtils.PopToast(LocalStrEnum.PressShowSkillinfo)
            end
        end
    end

    if canClick then
        local btnSoundPath = string.format(Config.AudioPath.SE, "skillselect")
        self:play2DSound(btnSoundPath)
        local skillCD = self._selectedRole:getSkillCD(skillId)
        if skillCD > 0 then
            UICommonUtils.PopToast(LocalStrEnum.SkillCooling)
        elseif self._selectedRole:checkHasCanNotUseActiveSkill() then
            UICommonUtils.PopToast(LocalStrEnum.CanNotUseSkill)
        else
            self._selectedRole:selectSkill(skillId)
        end
    end

    local uiEffect = self.longPressUIEffects[skillIndex]
    if uiEffect ~= nil then
        uiEffect:Hide()    
    end
end

function BattleMainPanel:focusNextRole()
    self._battleMgr:resetAndStopActionState(true, false)
    self._clientBattleMgr:resetAndStopActionState(true)
    self._roleMgr:selectNextRole()
    local selectRole = self._battleMgr:getSelectedRole()
    self._clientBattleMgr:refreshSelectedCube(selectRole:getShowBlock().id)
end

function BattleMainPanel:ShowBossScoreBox()
    local levelConfig = self._battleMgr:getLevelConfig()
    if levelConfig.typemain == GE.LevelTypeMain.WeeklyBoss then
        local additionNum = self._battleMgr:getweeklyBossScoreAddition()
        local damageValue = self._battleMgr:getFriendCampAllDamageValue()
        local totalScore = math.floor(damageValue * (1 + additionNum))
        self:refreshBossScore(totalScore)
    end
end

function BattleMainPanel:refreshBossScore(score)
    self.scoreText.text.text = tostring(score)
end

function BattleMainPanel:enterBacktraceMode()
    self:showBacktrace(true)
    self._orginRound = self._histroyMgr:getLastRound()
    self._orginIndex = #self._histroyMgr:getDataListByRound(self._orginRound)
    BattleCore.ds("orginRound", self._orginRound, self._orginIndex)
    self._tmpRound = self._orginRound
    self._tmpIndex = self._orginIndex
    -- 失败/非三星回溯：场景先回退到最后一个战斗历史节点
    if self._clientBattleMgr:isPendingLoseBacktrace() then
        local histroyData = self._histroyMgr:getHistoryData(self._tmpRound, self._tmpIndex)
        if histroyData then
            self:showFullMask(true)
            self._clientBattleMgr:setCreateRoleCallback(function()
                self:showFullMask(false)
            end)
            self._battleMgr:resetBattleData(histroyData)
            self:refreshPanel()
            self:OnRefreshBacktraceData()
        end
    end
    self:refreshBacktraceBtns()
    self._battleMgr:setBattleState(GE.BattleState.InBacktrace)
    self._clientBattleMgr:SetCanInputClick(false)
end

--[[
/BacktraceBtn onClick 
--]]
function BattleMainPanel:backtraceBtn_ScaleButton_onClick(backtraceBtn)
    self:play2DSound(self.btnSoundPath)
    local canDoAction = self._clientBattleMgr:checkRoleCanDoAction()
    local roleMgr = self._battleMgr:getRoleManager()
    local lockRole = roleMgr:getLockRole()
    if roleMgr:isManualCamp() == false or canDoAction == false or lockRole ~= nil then
        return
    end
    self:enterBacktraceMode()
end

--[[
/backtraceGroup/backtraceBtns/LastRoundBtn onClick 
--]]
function BattleMainPanel:lastRoundBtn_ScaleButton_onClick(lastRoundBtn)
    local isCreatingRole = self._clientBattleMgr:isCreatingRole()
    if isCreatingRole then
        return
    end
    self:showFullMask(true)
    self:play2DSound(self.btnSoundPath)
    local histroyData = self._histroyMgr:getHistoryData(self._tmpRound - 1, 1)
    if (histroyData) then
        self._tmpRound = self._tmpRound - 1
        self._tmpIndex = 1
        self._clientBattleMgr:setCreateRoleCallback(function()
            self:showFullMask(false)
        end)
        self._battleMgr:resetBattleData(histroyData)
    end
    self:refreshBacktraceBtns()
    self:refreshPanel()
    self:OnRefreshBacktraceData()
end

--[[
/backtraceGroup/backtraceBtns/NextRoundBtn onClick 
--]]
function BattleMainPanel:nextRoundBtn_ScaleButton_onClick(nextRoundBtn)
    local isCreatingRole = self._clientBattleMgr:isCreatingRole()
    if isCreatingRole then
        return
    end
    self:showFullMask(true)
    self:play2DSound(self.btnSoundPath)
    local histroyData = self._histroyMgr:getHistoryData(self._tmpRound + 1, 1)
    if (histroyData) then
        self._tmpRound = self._tmpRound + 1
        self._tmpIndex = 1
        self._clientBattleMgr:setCreateRoleCallback(function()
            self:showFullMask(false)
        end)
        self._battleMgr:resetBattleData(histroyData)
    end
    self:refreshBacktraceBtns()
    self:refreshPanel()
    self:OnRefreshBacktraceData()
end

--[[
/backtraceGroup/backtraceBtns/LastRoleBtn onClick 
--]]
function BattleMainPanel:lastRoleBtn_ScaleButton_onClick(lastRoleBtn)
    local isCreatingRole = self._clientBattleMgr:isCreatingRole()
    if isCreatingRole then
        return
    end
    self:showFullMask(true)
    self:play2DSound(self.btnSoundPath)
    local round = self._tmpRound
    local index = self._tmpIndex
    if (index <= 1) then
        round = round - 1
        local dataList = self._histroyMgr:getDataListByRound(round)
        if (dataList) then
            local maxIndex = #dataList
            index = maxIndex
        end
    else
        index = index - 1
    end
    local histroyData = self._histroyMgr:getHistoryData(round, index)
    if (histroyData) then
        self._tmpRound = round
        self._tmpIndex = index
        self._clientBattleMgr:setCreateRoleCallback(function()
            self:showFullMask(false)
        end)
        self._battleMgr:resetBattleData(histroyData)
    end
    self:refreshBacktraceBtns()
    self:refreshPanel()
    self:OnRefreshBacktraceData()
end

--[[
/backtraceGroup/backtraceBtns/NextRoleBtn onClick 
--]]
function BattleMainPanel:nextRoleBtn_ScaleButton_onClick(nextRoleBtn)
    local isCreatingRole = self._clientBattleMgr:isCreatingRole()
    if isCreatingRole then
        return
    end
    self:showFullMask(true)
    self:play2DSound(self.btnSoundPath)
    local round = self._tmpRound
    local index = self._tmpIndex
    local dataList = self._histroyMgr:getDataListByRound(round)
    if (dataList) then
        local maxIndex = #dataList
        if (index >= maxIndex) then
            round = round + 1
            index = 1
        else
            index = index + 1
        end
        local histroyData = self._histroyMgr:getHistoryData(round, index)
        if (histroyData) then
            self._tmpRound = round
            self._tmpIndex = index
            self._clientBattleMgr:setCreateRoleCallback(function()
                self:showFullMask(false)
            end)
            self._battleMgr:resetBattleData(histroyData)
        end
    end
    self:refreshBacktraceBtns()
    self:refreshPanel()
    self:OnRefreshBacktraceData()
end

--[[
/BacktraceGroup/BacktraceCancelBtn onClick 
--]]
function BattleMainPanel:backtraceCancelBtn_ScaleButton_onClick(backtraceCancelBtn)
    self:play2DSound(self.btnSoundPath)
    self:cancelBacktrace()
    self:refreshPanel()
end

--[[
/BacktraceGroup/BacktraceConfirmBtn onClick 
--]]
function BattleMainPanel:backtraceConfirmBtn_ScaleButton_onClick(backtraceConfirmBtn)
    self:play2DSound(self.btnSoundPath)
    self._histroyMgr:cutAfterData(self._tmpRound, self._tmpIndex)
    self:showBacktrace(false)
    self._battleMgr:setBacktraceTimes(self._battleMgr:getBacktraceTimes() - 1)
    self:refreshBacktraceBtns()
    self._clientBattleMgr:clearPendingLoseBacktrace()
    self._battleMgr:setBattleState(GE.BattleState.RoleAction)
    self._battleMgr:confirmBackTrace()
    self._clientBattleMgr:SetCanInputClick(true)
    self:refreshPanel()
end

--[[
/PauseBtn onClick 
--]]
function BattleMainPanel:pauseBtn_ScaleButton_onClick(pauseBtn)
    self:play2DSound(self.btnSoundPath)
    local uiData = {
        isFormation = false
    }
    UIMgr:popUI("BattleSetupPanel", uiData)
end

--[[
/AutoBtn onClick 
--]]
function BattleMainPanel:autoBtn_ScaleButton_onClick(autoBtn)
    self:play2DSound(self.btnSoundPath)
    local isMyCamy = self._battleMgr:getRoleManager():isManualCamp()
    local canDoAction = self._clientBattleMgr:checkRoleCanDoAction()
    if isMyCamy == false or canDoAction == false then
        return
    end
    self.autoBtn:SetActive(false)
    self.autoCloseBtn:SetActive(true)
    self._clientBattleMgr:SetAutoMode(true)
    self.autoTip:SetActive(true)
    self:showAutoModeHideGroup(false)
end

--[[
/SpeedChangeBtn onClick 
--]]
function BattleMainPanel:speedChangeBtn_ScaleButton_onClick(speedChangeBtn)
    self:play2DSound(self.btnSoundPath)
    self._clientBattleMgr:addBattleSpeed()
    self:refreshSpeedBtn()
end

--[[
/EndRoundBtn onClick 
--]]
function BattleMainPanel:endRoundBtn_ScaleButton_onClick(endRoundBtn)
    self:play2DSound(self.btnSoundPath)
    UIMgr:popUI("MsgBox", {
        title = LocalStrEnum.PromptTitle,
        content = LocalStrEnum.EndRoundConfirm,
        type = MsgBoxType.OKCancel,
        okCallback = function()
            self._battleMgr:endCurRound()
        end,
    })
end

--[[
/DangerRangeBtn onClick 
--]]
function BattleMainPanel:dangerRangeBtn_ScaleButton_onClick(dangerRangeBtn)
    self:play2DSound(self.btnSoundPath)
    self.dangerRangeBtn:SetActive(false)
    self.dangerRangeCloseBtn:SetActive(true)
    self._clientBattleMgr:showDangerRange()
end

--[[
/DangerRangeCloseBtn onClick 
--]]
function BattleMainPanel:dangerRangeCloseBtn_ScaleButton_onClick(dangerRangeCloseBtn)
    self:play2DSound(self.btnSoundPath)
    self.dangerRangeBtn:SetActive(true)
    self.dangerRangeCloseBtn:SetActive(false)
    self._clientBattleMgr:removeDangerRange()
end

--[[
/AutoCloseBtn onClick 
--]]
function BattleMainPanel:autoCloseBtn_ScaleButton_onClick(autoCloseBtn)
    self:play2DSound(self.btnSoundPath)
    self.autoBtn:SetActive(true)
    self.autoCloseBtn:SetActive(false)
    self._clientBattleMgr:SetAutoMode(false)
    self.autoTip:SetActive(false)
    local canDoAction = self._clientBattleMgr:checkRoleCanDoAction()
    if (self._battleMgr:getRoleManager():isManualCamp() and canDoAction == true) then
        self:showAutoModeHideGroup(true)
    end
end

--[[
/ActionGroup/StandbyBtn onClick 
--]]
function BattleMainPanel:standbyBtn_ScaleButton_onClick(standbyBtn)
    self:play2DSound(self.btnSoundPath)
    self._selectedRole:doAction(GE.ActionType.Standby)
end

--[[
/ActionGroup/Skill1Btn onClick 
--]]
function BattleMainPanel:skill1Btn_ScaleButton_onClick(skill1Btn)
    self:onClickSkillBtn(1)
    -- self:enterChooseState()
end

--[[
/ActionGroup/Skill2Btn onClick 
--]]
function BattleMainPanel:skill2Btn_ScaleButton_onClick(skill2Btn)
    self:onClickSkillBtn(2)
    -- self:enterChooseState()
end

--[[
/ActionGroup/Skill3Btn onClick 
--]]
function BattleMainPanel:skill3Btn_ScaleButton_onClick(skill3Btn)
    self:onClickSkillBtn(3)
    -- self:enterChooseState()
end

--[[
/DoSkillGroup/ConfirmBtn onClick 
--]]
function BattleMainPanel:confirmBtn_ScaleButton_onClick(confirmBtn)
    self:play2DSound(self.btnSoundPath)
    ---判断二次扩散是否有目标在范围内
    local targetList = self._selectedRole:getCurSkillTarget()
    if next(targetList) then
        self._selectedRole:doAction(GE.ActionType.DoSkill)
    else
        UICommonUtils.PopToast(LocalStrEnum.ActionFailReason_BattleNoTarget)
    end
end

--[[
/DoSkillGroup/BackBtn onClick 
--]]
function BattleMainPanel:backBtn_ScaleButton_onClick(backBtn)
    self:play2DSound(self.btnSoundPath)
    -- self._selectedRole:skillChooseTarget()
    -- self:enterChooseState()
    self:enterLastState()
end

--[[
/RoleAction/ChooseTargetGroup/ChooseBackBtn onClick 
--]]
function BattleMainPanel:chooseBackBtn_ScaleButton_onClick(chooseBackBtn)
    local btnSoundPath = string.format(Config.AudioPath.SE, "skillselect_cancel")
    self:play2DSound(btnSoundPath)
	self._battleMgr:refreshRoleActionState(self._selectedRole, false, true)
    self._battleMgr:callClientShowEvent(GE.ClientBattleShowType.RefreshRoleAction, {
        role = self._selectedRole,
        
    })
    self:enterActionState()
    -- self:enterLastState()
end

--[[
/RoleAction/ChooseTargetGroup/SkillInfoTip onClick 
--]]
function BattleMainPanel:skillInfoTip_Button_onClick(skillInfoTip)
    self:play2DSound(self.btnSoundPath)
    local isShow = self.chooseTargetGroup.skillDesText.activeSelf
    self.chooseTargetGroup.skillDesText:SetActive(not isShow)
    self.chooseTargetGroup.showSkillDecIcon:SetActive(isShow)
    self.chooseTargetGroup.hideSkillDecIcon:SetActive(not isShow)
end

--[[
/RoleAction/ActionGroup/NormalSkillBtn onClick 
--]]
function BattleMainPanel:normalSkillBtn_ScaleButton_onClick(normalSkillBtn)
    self:play2DSound(self.btnSoundPath)
    self._selectedRole:selectSkill(self._selectedRole.normalSkill)
    self:enterChooseState()
end

--[[
/MainGroup/AutoModeHideGroup/ActionMemberBox onClick 
--]]
function BattleMainPanel:actionMemberBox_Button_onClick(actionMemberBox)
    self:play2DSound(self.btnSoundPath)
    self:focusNextRole()
end

--[[
/BacktraceGroup/BacktraceTitle/BacktraceBackBtn onClick 
--]]
function BattleMainPanel:backtraceBackBtn_ScaleButton_onClick(backtraceBackBtn)
    self:play2DSound(self.btnSoundPath)
    self:cancelBacktrace()
end

--[[
/MainGroup/camHeightSlider onValueChanged 
--]]
function BattleMainPanel:camHeightSlider_Slider_onValueChanged(camHeightSlider,value)
    self._battleMgr:getShowManager():refreshViewHeightByFinalValue(value)
end

--[[
/MainGroup/camAngleSlider onValueChanged 
--]]
function BattleMainPanel:camAngleSlider_Slider_onValueChanged(camAngleSlider,value)
    self._battleMgr:getShowManager():refreshViewRotatByFinalValue(value)
end

--[[
/RoleAction/ActionGroup/SkillBtnGroup/SwitchNormalSkillBtn onClick 
--]]
function BattleMainPanel:switchNormalSkillBtn_ScaleButton_onClick(switchNormalSkillBtn)
    self:play2DSound(self.btnSoundPath)
    self._selectedRole:switchNormalSkill()
    self:setSkill()
end

--[[
/RoleAction/DoSkillGroup/VSInfoBox/OurSide/DamageSlider onValueChanged 
--]]
function BattleMainPanel:damageSlider_Slider_onValueChanged(damageSlider,value)

end

--[[
/RoleAction/DoSkillGroup/VSInfoBox/OurSide/HpSlider onValueChanged 
--]]
function BattleMainPanel:hpSlider_Slider_onValueChanged(hpSlider,value)

end

--[[
/MainGroup/AutoModeHideGroup/RestrictionInfo onClick 
--]]
function BattleMainPanel:restrictionInfo_Button_onClick(restrictionInfo)
    self:play2DSound(self.btnSoundPath)
    UIMgr:popUICover("BattleRestrictionPanel")
end

--[[
/MainGroup/AutoModeHideGroup/FullMaskHideGroup/RoleInfo/RoleInfoBg onClick 
--]]
function BattleMainPanel:roleInfoBg_Button_onClick(roleInfoBg)
    self:play2DSound(self.btnSoundPath)
    if (self._selectedRole) then
        if (UIMgr:getCurrentUIName() == "BattleRoleMsgPanel") then
            UIMgr:replaceUI("BattleRoleMsgPanel", {role = self._selectedRole})
        else
            UIMgr:popUI("BattleRoleMsgPanel", {role = self._selectedRole})
        end
    end
end

--[[
/RoleAction/DoSkillGroup/VSInfoBox/LeftGroup/FriendGroup/FriendDamageSlider onValueChanged 
--]]
function BattleMainPanel:friendDamageSlider_Slider_onValueChanged(friendDamageSlider,value)

end

--[[
/RoleAction/DoSkillGroup/VSInfoBox/LeftGroup/FriendGroup/FriendHpSlider onValueChanged 
--]]
function BattleMainPanel:friendHpSlider_Slider_onValueChanged(friendHpSlider,value)

end

--[[
/RoleAction/DoSkillGroup/VSInfoBox/LeftGroup/EnemyGroup/EnemyDamageSlider onValueChanged 
--]]
function BattleMainPanel:enemyDamageSlider_Slider_onValueChanged(enemyDamageSlider,value)

end

--[[
/RoleAction/DoSkillGroup/VSInfoBox/LeftGroup/EnemyGroup/EnemyHpSlider onValueChanged 
--]]
function BattleMainPanel:enemyHpSlider_Slider_onValueChanged(enemyHpSlider,value)

end

--[[
/RoleAction/DoSkillGroup/VSInfoBox/LeftGroup/NpcGroup/NpcDamageSlider onValueChanged 
--]]
function BattleMainPanel:npcDamageSlider_Slider_onValueChanged(npcDamageSlider,value)

end

--[[
/RoleAction/DoSkillGroup/VSInfoBox/LeftGroup/NpcGroup/NpcHpSlider onValueChanged 
--]]
function BattleMainPanel:npcHpSlider_Slider_onValueChanged(npcHpSlider,value)

end

--[[   战斗演出测试按钮
/MainGroup/AdjustRoot/BtnList/EnterBattleTestBtn onClick 
--]]
function BattleMainPanel:enterBattleTestBtn_Button_onClick(enterBattleTestBtn)
    --测试id
    local showMgr = self._clientBattleMgr:getShowManager()
    local testId = tonumber(self.testId.tMP_InputField.text)
    if testId then
        showMgr:SetEnterBattleTestId(testId)
    end
    self._clientBattleMgr.getInstance():playBattleShow(function()
        self._clientBattleMgr.getInstance():endPlayBattleShow(function()
            -- self._clientBattleMgr.getInstance():finishFormation()
        end)
    end)
end

--[[
/MainGroup/AdjustRoot/BtnList/FocusLineTestBtn onClick 战斗尽头边界跟随测试按钮
--]]
function BattleMainPanel:focusLineTestBtn_Button_onClick(focusLineTestBtn)
    self._borderLineShow = not self._borderLineShow
    self:initFocusLine()
end

---更新当前选中边框
---@param id FollowTargetType
function BattleMainPanel:focusLineOnSelected(id)
    if self._borderLineFocusedId == id then
        return
    end
    self._borderLineFocusedId = id
    for k, v in pairs(self._borderLineList) do
        v.selected:SetActive(k == self._borderLineFocusedId)
    end
end

--- 清除当前选中边框
function BattleMainPanel:clearfocusLineSelected()
    self._borderLineFocusedId = nil
    for k, v in pairs(self._borderLineList) do
        v.selected:SetActive(false)
    end
end

--[[
/MainGroup/AdjustRoot/BtnList/AngleChangeBtn onClick 相机角度切换按钮
--]]
function BattleMainPanel:angleChangeBtn_ScaleButton_onClick(angleChangeBtn)
    local typeList = Config.GetConfigInfo("BattleCameraType")
    local max = tablex.size(typeList)
    local index = MyPrefs:GetInt(GE.LocalCustomDataKey.BattleCameraAngle)
    index = index + 1 > max and 1 or index + 1
    MyPrefs:SetInt(GE.LocalCustomDataKey.BattleCameraAngle, index)
    self._battleMgr:getShowManager():RefreshCameraAngle(true)
    self:RefreshAngleDisplay()
end

---刷新相机角度显示
function BattleMainPanel:RefreshAngleDisplay()
    local index = MyPrefs:GetInt(GE.LocalCustomDataKey.BattleCameraAngle)
    -- self.angleTypeText.text.text = "x"..index
end

---添加一个3D图标
---@param markData MarkData
---@param camera UnityEngine.Camera
---@param markType integer
function BattleMainPanel:addRolePosMark(markData, camera, markType)
    self.sceneMarkView.mainPanel_SceneMarkViwe:Add3DMark(markData, camera, markType)
end

---@param markData MarkData
function BattleMainPanel:removeRolePosMark(markData)
    self.sceneMarkView.mainPanel_SceneMarkViwe:Remove3DMark(markData)
end

return BattleMainPanel
