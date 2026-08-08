---@class SurvivalMainPanel : SurvivalMainPanel_Generate
---##################### 【SurvivalMainPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【SurvivalMainPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local SurvivalMainPanel = require "SurvivalMainPanel_Generate"
local SurvivalLog = require "SurvivalLog"
local Input = UnityEngine.Input
local KeyCode = UnityEngine.KeyCode
local MAX_SQUAD_SIZE = 3
local MAX_AUTO_SKILL_COUNT = 6

function SurvivalMainPanel:InitLogic(data)
    self._joystickRadius = self.circle.rectTransform.sizeDelta.x * 0.5
    self._keyboardJoystickActive = false
    self._touchId = nil
    self.mouseDownPosition = nil
    self._circleOriginalAnchoredPosition = self.circle.rectTransform.anchoredPosition
    self.isShowRangeToggle.toggle.isOn = false
    SurvivalManager.instance():SetIsShowRange(false)
    self.isOpenLogToggle.toggle.isOn = SurvivalLog.IsEnabled()
    self._roleButtons = { 
        [1] = self.role1, 
        [2] = self.role2, 
        [3] = self.role3 
    }
    self._autoSkillButtons = {
        self.skillBtn1,
        self.skillBtn2,
        self.skillBtn3,
        self.skillBtn4,
        self.skillBtn5,
        self.skillBtn6,
    }
    --技能按钮相关参数
    self._skillPressActive = false
    self._skillAiming = false
    self._skillTouchId = nil
    self._skillSlotMap = {}
    --右侧技能按钮按下
    self:_initSkillBtnListener()
    self:_resetSkillChargeUI()
    self:RefreshExpUI()
    --左侧移动面板按下
    self.touchArea.clickLongPressListener.onDown = function()
        self._touchId = Input.touchCount > 0 and Input.GetTouch(0).fingerId or -1
		self.mouseDownPosition = Input.touchCount > 0 and Input.GetTouch(0).position or Vector2(UnityEngine.Input.mousePosition.x, UnityEngine.Input.mousePosition.y)
        local parentRect = self.circle.rectTransform.parent
        local uiCam = UIMgr.uiCamera
        local localPos = UICommonUtils.ScreenToUILocalPos(parentRect, uiCam, self.mouseDownPosition)
        self.circle.rectTransform.anchoredPosition = localPos
        self.handle.rectTransform.anchoredPosition = Vector2.zero
        self.circle:SetActive(true)
        SurvivalManager.instance():SetInputDirection(Vector2.zero)
    end
    --左侧移动面板抬起
    self.touchArea.clickLongPressListener.onUp = function()
        self._touchId = nil
        self.mouseDownPosition = nil
        --归位
        self.handle.rectTransform.anchoredPosition = Vector2.zero
        self.circle.rectTransform.anchoredPosition = self._circleOriginalAnchoredPosition
        self.circle:SetActive(false)
        SurvivalManager.instance():SetInputDirection(Vector2.zero)
    end
end

function SurvivalMainPanel:Update()
    self:_updateSkillBtnDrag()  --技能交互检测
    self:_updateSkillChargeUI()
    self:_updateJoystickDrag()  --移动交互检测
end

function SurvivalMainPanel:_updateJoystickDrag()
    --移动
    if SurvivalManager.instance():GetGameState() == GE.SurvivalStateEnum.Battle then
        -- 编辑器：WASD 模拟（真机不跑）
        if GV.IsEditor then
            local dir = self:_getKeyboardJoystickDir()
            --有键入
            if dir then
                if not self._keyboardJoystickActive then
                    self._keyboardJoystickActive = true
                    self.circle.rectTransform.anchoredPosition = self._circleOriginalAnchoredPosition
                    self.circle:SetActive(true)
                end
                local radius = self._joystickRadius
                self:_applyJoystickOffset(Vector2(dir.x * radius, dir.y * radius))
                SurvivalManager.instance():SetInputDirection(Vector2(dir.x * radius, dir.y * radius))
                self:_updateSkillBtnDrag()
                return  -- 键盘按下时不再走鼠标拖动
            --键入后抬起
            elseif self._keyboardJoystickActive then
                self._keyboardJoystickActive = false
                self.handle.rectTransform.anchoredPosition = Vector2.zero
                self.circle.rectTransform.anchoredPosition = self._circleOriginalAnchoredPosition
                self.circle:SetActive(false)
                self._lastJoystickOffset = nil
                SurvivalManager.instance():SetInputDirection(Vector2.zero)
                self:_updateSkillBtnDrag()
                return
            end
        end
        --真机拖动
        if(Input.GetMouseButton(0) and self.mouseDownPosition) then
            local currentMousePosition = nil
            if GV.IsEditor then
                currentMousePosition = Vector2(UnityEngine.Input.mousePosition.x, UnityEngine.Input.mousePosition.y)
            else
                -- 真机:根据保存的touchId查找对应的触摸
                if Input.touchCount > 0 and self._touchId then
                    for i = 0, Input.touchCount - 1 do
                        local touch = Input.GetTouch(i)
                        if touch.fingerId == self._touchId then
                            currentMousePosition = touch.position
                            break
                        end
                    end
                end
            end
            LuaLogger.ds("onDrag", tablex.dump(currentMousePosition))
            -- 相对 circle，不是 touchArea
            local localPos = UICommonUtils.ScreenToUILocalPos(
                self.circle.rectTransform, UIMgr.uiCamera, currentMousePosition)
            LuaLogger.ds("localPos", tablex.dump(localPos))
            local offset = localPos  -- circle 轴心在 (0,0) 时，localPos 就是偏移
            local radius = self._joystickRadius
            if offset.magnitude > radius then
                offset = offset.normalized * radius
            end
            self.handle.rectTransform.anchoredPosition = offset
            SurvivalManager.instance():SetInputDirection(offset.normalized)
        end
    end
end

---键盘wsad映射
function SurvivalMainPanel:_getKeyboardJoystickDir()
    local x, y = 0, 0
    if Input.GetKey(KeyCode.A) then x = x - 1 end
    if Input.GetKey(KeyCode.D) then x = x + 1 end
    if Input.GetKey(KeyCode.W) then y = y + 1 end
    if Input.GetKey(KeyCode.S) then y = y - 1 end
    if x == 0 and y == 0 then
        return nil
    end
    -- 八方向；只要四方向可不必 normalize
    local len = math.sqrt(x * x + y * y)
    return Vector2(x / len, y / len)
end

function SurvivalMainPanel:_getSkillBtnRectTransform()
    return self.skillBtn.transform
end

function SurvivalMainPanel:_isActiveSkillOnCd()
    local role = SurvivalManager.instance():GetRoleMgr():GetPlayerRole()
    if not role then
        return true
    end
    local activeSkill = role:GetActiveSkill()
    if not activeSkill then
        return true
    end
    return activeSkill.cdRemain > 0
end

--技能按钮范围内检测
function SurvivalMainPanel:_isScreenPointInSkillBtn(screenPos)
    return RectTransformUtility.RectangleContainsScreenPoint(
        self:_getSkillBtnRectTransform(), screenPos, UIMgr.uiCamera)
end

function SurvivalMainPanel:_getSkillDragScreenPos()
    if GV.IsEditor then
        return Vector2(UnityEngine.Input.mousePosition.x, UnityEngine.Input.mousePosition.y)
    end
    if Input.touchCount > 0 and self._skillTouchId then
        for i = 0, Input.touchCount - 1 do
            local touch = Input.GetTouch(i)
            if touch.fingerId == self._skillTouchId then
                return touch.position
            end
        end
    end
    return nil
end

function SurvivalMainPanel:_initSkillBtnListener()
    local btn = self.skillBtn.button
    local trigger = EventTriggerListener.Get(self.skillBtn.gameObject)
    trigger.onDown = function(go, eventData)
        if SurvivalManager.instance():GetGameState() ~= GE.SurvivalStateEnum.Battle then
            return
        end
        if self:_isActiveSkillOnCd() then
            return
        end
        self._skillPressActive = true
        self._skillAiming = false
        self._skillTouchId = eventData.pointerId
        local mgr = SurvivalManager.instance()
        if mgr:TryStartSkillCharge() then
            self:_resetSkillChargeUI()
            if self.skillBtn.charge then
                self.skillBtn.charge.gameObject:SetActive(true)
            end
        end
    end
    trigger.onUp = function(go, eventData)
        self:_onSkillBtnUp(eventData.position)
    end
end

--主动技能按钮拖动检测
function SurvivalMainPanel:_updateSkillBtnDrag()
    if not self._skillPressActive then
        return
    end
    local screenPos = self:_getSkillDragScreenPos()
    if not screenPos then
        return
    end
    local inBtn = self:_isScreenPointInSkillBtn(screenPos)
    --移动到了按钮外 准备释放技能
    if not inBtn then
        if not self._skillAiming then
            self._skillAiming = true
            SurvivalManager.instance():StartSkillAim()
        end
        local offset = UICommonUtils.ScreenToUILocalPos(
            self:_getSkillBtnRectTransform(), UIMgr.uiCamera, screenPos)
        if offset.sqrMagnitude > 0 then
            SurvivalManager.instance():UpdateSkillAimDirection(offset)
        end
    else
        --移动到了按钮内 结束技能瞄准
        if self._skillAiming then
            self._skillAiming = false
            SurvivalManager.instance():EndSkillAim()
        end
    end
end

function SurvivalMainPanel:_onSkillBtnUp(screenPos)
    local mgr = SurvivalManager.instance()
    local shouldCast = false
    if self._skillAiming then
        if not self:_isScreenPointInSkillBtn(screenPos) then
            shouldCast = true
        end
    elseif mgr:IsSkillCharging() then
        -- 蓄力技能：按钮内松手也可释放（使用角色朝向）
        shouldCast = true
    end
    if shouldCast then
        mgr:CastPlayerSkill()
    end
    mgr:EndSkillCharge()
    mgr:EndSkillAim()
    self:_resetSkillChargeUI()
    self._skillPressActive = false
    self._skillAiming = false
    self._skillTouchId = nil
end

function SurvivalMainPanel:_updateSkillChargeUI()
    if not self.skillBtn or not self.skillBtn.charge or not self.skillBtn.charge.image then
        return
    end
    local mgr = SurvivalManager.instance()
    if mgr:IsSkillCharging() and self._skillPressActive then
        local ratio = mgr:GetSkillChargeRatio()
        self.skillBtn.charge.gameObject:SetActive(true)
        self.skillBtn.charge.image.fillAmount = ratio
    elseif not self._skillPressActive then
        self:_resetSkillChargeUI()
    end
end

function SurvivalMainPanel:_resetSkillChargeUI()
    if not self.skillBtn or not self.skillBtn.charge then
        return
    end
    self.skillBtn.charge.gameObject:SetActive(false)
    if self.skillBtn.charge.image then
        self.skillBtn.charge.image.fillAmount = 0
    end
end

function SurvivalMainPanel:_applyJoystickOffset(offset)
    local radius = self._joystickRadius  -- InitLogic 里缓存: circle.rectTransform.sizeDelta.x * 0.5
    if offset.sqrMagnitude > radius * radius then
        local m = offset.magnitude
        offset = Vector2(offset.x / m * radius, offset.y / m * radius)
    end
    self.handle.rectTransform.anchoredPosition = offset
    -- 若有移动: SurvivalManager.instance():SetMoveInput(offset.x / radius, offset.y / radius)
    self._lastJoystickOffset = offset
end

--function SurvivalMainPanel:StartCreating(time)
--
--end

--function SurvivalMainPanel:StartEnter(time)
--
--end

--function SurvivalMainPanel:StartRemoving(time)
--
--end

--function SurvivalMainPanel:StartExit(time)
--
--end

function SurvivalMainPanel:OnOpen(data, initiative)
    if initiative then
        self:SetUpdateInterval(0)
        self.gamePlayMenu:SetActive(false)
    end
end

--function SurvivalMainPanel:OnClose(initiative)
--
--end

--function SurvivalMainPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function SurvivalMainPanel:OnRefresh(data)
--
--end

function SurvivalMainPanel:RefreshTime(time)
    LuaLogger.ds("SurvivalMainPanel time", time)
    self.timeText.text.text = string.format("Time: %d", time)
end

--准备阶段UI开关
function SurvivalMainPanel:PrepareState(bool)
    self.gamePrepareMenu:SetActive(bool)
    for _, btn in ipairs(self._roleButtons) do
        btn.cdNum.gameObject:SetActive(false)
        btn.cdNum.image.fillAmount = 0
        btn.hpBar.image.fillAmount = 1
    end
end

--暂停菜单UI开关
function SurvivalMainPanel:PauseMenu(bool)
    --todo 暂停菜单
end

--游戏结束阶段UI开关
function SurvivalMainPanel:GameOverState(bool)
    self.gameOverMenu:SetActive(bool)
end

--战斗阶段UI开关
function SurvivalMainPanel:PlayState(bool)
    self.gamePlayMenu:SetActive(bool)
    self.circle:SetActive(false)
    self.isShowRangeToggle.toggle.isOn = SurvivalManager.instance():GetIsShowRange()
    if not bool then
        self._skillPressActive = false
        self._skillAiming = false
        self._skillTouchId = nil
        local mgr = SurvivalManager.instance()
        mgr:EndSkillAim()
        mgr:EndSkillCharge()
        self:_resetSkillChargeUI()
    end
    if bool then
        self:UpdatePlayerHp()
        self:UpdateRoleIconsState()
        self:UpdateSkillButtons()
        self:_resetSkillChargeUI()
    end
end

--同步主控角色主动、被动技能按钮显示，并绑定 [skillIndex] -> UI槽位
function SurvivalMainPanel:UpdateSkillButtons()
    self._skillSlotMap = {}
    local role = SurvivalManager.instance():GetRoleMgr():GetPlayerRole()
    --主动技能
    local activeSkill, activeIndex = nil, nil
    if role then
        activeSkill, activeIndex = role:GetActiveSkill()
    end
    if activeSkill and activeIndex then
        self.skillBtn:SetActive(true)
        self._skillSlotMap[activeIndex] = { btn = self.skillBtn }
    else
        self.skillBtn:SetActive(false)
        self:_resetSkillCdDisplay(self.skillBtn)
    end
    --todo 主动技能ui图标

    local autoSlot = 0
    if role then
        for index = 1, role.skillIndex do
            local skill = role:GetSkillByIndex(index)
            if skill and role:IsAutoSkillId(skill.skillId) then
                autoSlot = autoSlot + 1
                local btn = self._autoSkillButtons[autoSlot]
                if btn and btn.image then
                    btn.image.enabled = true
                end
                if btn then
                    self._skillSlotMap[index] = { btn = btn }
                end
            end
        end
    end
    for i = autoSlot + 1, MAX_AUTO_SKILL_COUNT do
        local btn = self._autoSkillButtons[i]
        if btn and btn.image then
            btn.image.enabled = false
        end
        self:_resetSkillCdDisplay(btn)
    end
    --todo 被动技能ui图标

    if role then
        for skillIndex, _ in pairs(self._skillSlotMap) do
            local skill = role:GetSkillByIndex(skillIndex)
            if skill then
                self:UpdateSkillCdByIndex(skillIndex, skill.cdRemain, skill.MaxCd)
            end
        end
    end
end

function SurvivalMainPanel:_resetSkillCdDisplay(btn)
    if not btn or not btn.cdNum then
        return
    end
    btn.cdNum.gameObject:SetActive(false)
    btn.cdNum.image.fillAmount = 0
end

---由 SurvivalRole 在技能 CD 变化时驱动，直接改对应槽位
---@param skillIndex integer 技能实例索引
---@param cdRemain number CD剩余时间
---@param maxCd number CD总时长
function SurvivalMainPanel:UpdateSkillCdByIndex(skillIndex, cdRemain, maxCd)
    local binding = self._skillSlotMap[skillIndex]
    if not binding or not binding.btn or not binding.btn.cdNum or not binding.btn.cdNum.image then
        return
    end
    local cdNum = binding.btn.cdNum
    if cdRemain > 0 and maxCd > 0 then
        cdNum.gameObject:SetActive(true)
        cdNum.image.fillAmount = cdRemain / maxCd
    else
        cdNum.gameObject:SetActive(false)
        cdNum.image.fillAmount = 0
    end
end

--更新切换角色CD显示
function SurvivalMainPanel:UpdateSwitchCd()
    local roleMgr = SurvivalManager.instance():GetRoleMgr()
    local cdRemain = roleMgr:GetSwitchCdRemain()
    local cdDuration = roleMgr:GetSwitchCdDuration()
    local onCd = cdRemain > 0
    for _, btn in ipairs(self._roleButtons) do
        if onCd then
            btn.cdNum.gameObject:SetActive(true)
            btn.cdNum.image.fillAmount = cdRemain / cdDuration
        else
            btn.cdNum.gameObject:SetActive(false)
            btn.cdNum.image.fillAmount = 0
        end
    end
end

--更新右上角角色按钮状态 选中框
function SurvivalMainPanel:UpdateRoleIconsState()
    local roleMgr = SurvivalManager.instance():GetRoleMgr()
    local activeSlot = roleMgr:GetActiveSlot()
    for i, btn in ipairs(self._roleButtons) do
        --选中框
        btn.selected:SetActive(i == activeSlot)
        --死亡框
        local role = roleMgr:GetSquadRole(i)
        if role and not role:IsAlive() then
            btn.die:SetActive(true)
        else
            btn.die:SetActive(false)
        end
    end
end

--更新编队槽位头像
function SurvivalMainPanel:UpdateSquadRoleIcon(slot, roleCfgId)
    local btn = self._roleButtons[slot]
    if not btn then
        return
    end
    local characterSkinCfg = Config.GetCharacterSkinInfo(roleCfgId)
    if not characterSkinCfg then
        LuaLogger.ws("SurvivalMainPanel UpdateSquadRoleIcon roleCfg not found", roleCfgId)
        return
    end
    local iconPath = string.format(Config.SpritePath.IconRolePath, characterSkinCfg.resourceFolder, characterSkinCfg.driverKey)
    self:LoadSpriteAsync(iconPath, btn.icon.image)
end

--切换角色
function SurvivalMainPanel:_switchRole(slot)
    if SurvivalManager.instance():GetRoleMgr():SwitchPlayerRole(slot) then
        self:UpdatePlayerHp()
        self:UpdateRoleIconsState()
        self:UpdateSkillButtons()
    end
end

--更新玩家血量
function SurvivalMainPanel:UpdatePlayerHp()
    local roleMgr = SurvivalManager.instance():GetRoleMgr()
    local player = roleMgr:GetPlayerRole()
    --主控角色血量
    if player then
        local hp = player:GetHp()
        local maxHp = player:GetMaxHp()
        self.hpText.text.text = string.format("%d/%d", hp, maxHp)
        self.hpBar.image.fillAmount = maxHp > 0 and hp / maxHp or 0
    end
    --右上角角色头像血量
    for i, btn in ipairs(self._roleButtons) do
        local role = roleMgr:GetSquadRole(i)
        if role then
            local hp = role:GetHp()
            local maxHp = role:GetMaxHp()
            btn.hpBar.image.fillAmount = maxHp > 0 and hp / maxHp or 0
        end
    end
end

--[[
/BtnList/PauseBtn onClick 暂停按钮
--]]
function SurvivalMainPanel:pauseBtn_ScaleButton_onClick(pauseBtn)
    SurvivalManager.instance():ChangeState(GE.SurvivalStateEnum.Pause)

	LoadingMgr:SetLoadingStart(function()
		StateMgr:ChangeToState(GameFlowState.GameState)
	end, nil, nil, "SurvivalMainPanel")
end

--[[
/GMList/AddSkill onClick 主角添加技能
--]]
function SurvivalMainPanel:addSkill_Button_onClick(addSkill)
    local skilllist = tostring(self.addSkill.inputField.tMP_InputField.text)
    --按逗号拆分技能列表
    local skillList = string.split(skilllist, ",")
    local skillResult = {}
    for _, skill in pairs(skillList) do
        if tonumber(skill) then
            skillResult[#skillResult + 1] = tonumber(skill)
        end
    end
    LuaLogger.ds("SurvivalMainPanel skillList", tablex.dump(skillResult))
    SurvivalManager.instance():GetRoleMgr():GetPlayerRole():AddSkillList(skillResult)
end

--[[
/GamePrepareMenu/StartBtn onClick 开始游戏
--]]
function SurvivalMainPanel:startBtn_Button_onClick(startBtn)
    local idText = tostring(self.mainCharId.inputField.tMP_InputField.text)
    local idStrList = string.split(idText, ",")
    local playerIdList = {}
    for _, idStr in pairs(idStrList) do
        local id = tonumber(idStr)
        if id then
            playerIdList[#playerIdList + 1] = id
        end
    end
    if #playerIdList == 0 then
        LuaLogger.ws("SurvivalMainPanel 角色id列表为空")
        return
    end
    SurvivalManager.instance():ResetPlayerExp()
    if #playerIdList > MAX_SQUAD_SIZE then
        LuaLogger.ws("SurvivalMainPanel 角色数量超过上限", MAX_SQUAD_SIZE)
        return
    end
    --生成玩家编队（最多3个角色，槽位1为初始主控）
    for slot, playerId in ipairs(playerIdList) do
        local roleCfg = Config.GetSurvivorRoleInfo(playerId)
        if not roleCfg then
            LuaLogger.ws("SurvivalMainPanel roleCfg not found", playerId)
            return
        end
        local characterSkinCfg = Config.GetCharacterSkinInfo(roleCfg.role)
        local baseAttr = UICommonUtils.ProcessSurvivalCfgAttr(roleCfg.basicAttribute)
        local eventData = {
            baseAttr = baseAttr,
            skillList = roleCfg.basicSkill,
            team = GE.SurvivalTeam.friend,
            isPlayer = (slot == 1),
            playerSlot = slot,
            shipType = roleCfg.roleRestraint,
            roleModel = characterSkinCfg.modelKey,
            roleCfgId = roleCfg.role,
            survivorRoleId = playerId,
        }
        SurvivalManager.instance():GetEventMgr():AddEvent(0, GE.SurvivalEventType.RoleCreate, eventData)
    end
    SurvivalManager.instance():ChangeState(GE.SurvivalStateEnum.Battle)
    self:RefreshExpUI()
end

---刷新经验条与等级
function SurvivalMainPanel:RefreshExpUI()
    local mgr = SurvivalManager.instance()
    local level = mgr:GetPlayerLevel()
    local exp = mgr:GetPlayerExp()
    local need = mgr:GetExpRequiredForLevel(level)
    if self.curLevel and self.curLevel.text then
        self.curLevel.text.text = tostring(level)
    end
    if self.expText and self.expText.text then
        self.expText.text.text = string.format("%d/%d", math.floor(exp), need)
    end
    if self.expBar and self.expBar.image then
        self.expBar.image.fillAmount = need > 0 and (exp / need) or 0
    end
end

--[[
/GamePlayMenu/touchArea onClick 
--]]
function SurvivalMainPanel:touchArea_Button_onClick(touchArea)

end

--[[
/GmBtn onClick GM开关
--]]
function SurvivalMainPanel:gmBtn_Button_onClick(gmBtn)
    self.gMList:SetActive(not self.gMList.activeSelf)
end

--[[
/GMList/KillEnemy/killEnemyBtn onClick 杀死所有敌人
--]]
function SurvivalMainPanel:killEnemyBtn_Button_onClick(killEnemyBtn)
    SurvivalManager.instance():GetEventMgr():AddEvent(0, GE.SurvivalEventType.KillEnemyAll)
end

--[[
/GMList/SpawnEnemyById/Btn2 onClick 根据id生成敌人
--]]
function SurvivalMainPanel:btn2_Button_onClick(btn2)
    local enemyId = tonumber(self.spawnEnemyById.id.inputField.tMP_InputField.text)
    local num = tonumber(self.spawnEnemyById.num.inputField.tMP_InputField.text)
    local roleCfg = Config.GetSurvivorRoleInfo(enemyId)
    if not roleCfg then
        LuaLogger.ws("SurvivalMainPanel roleCfg not found", enemyId)
        return
    end
    local skilllist = tostring(self.spawnEnemyById.skillList.inputField.tMP_InputField.text)
    --按逗号拆分技能列表
    local skillList = string.split(skilllist, ",")
    local skillResult = roleCfg.basicSkill
    for _, skill in pairs(skillList) do
        if tonumber(skill) then
            skillResult[#skillResult + 1] = tonumber(skill)
        end
    end
    local characterSkinCfg = Config.GetCharacterSkinInfo(roleCfg.role)
    local baseAttr = UICommonUtils.ProcessSurvivalCfgAttr(roleCfg.basicAttribute)
    local eventData = {
        baseAttr = baseAttr,
        skillList = skillResult,
        team = GE.SurvivalTeam.enemy,
        isPlayer = false,
        shipType = roleCfg.roleRestraint,
        roleModel = characterSkinCfg.modelKey,
        roleCfgId = roleCfg.role,
        survivorRoleId = enemyId,
        spawnType = GE.SurvivalSpawnType.FarRandom,
    }
    for i = 1, num do
        SurvivalManager.instance():GetEventMgr():AddEvent(0, GE.SurvivalEventType.RoleCreate, eventData)
    end
end

--[[
/GameOverMenu/retryBtn onClick 重试按钮
--]]
function SurvivalMainPanel:retryBtn_Button_onClick(retryBtn)
    SurvivalManager.instance():ChangeState(GE.SurvivalStateEnum.Prepare)
end

--[[
/GamePrepareMenu/isShowRange/isShowRangeToggle onValueChanged 游玩阶段是否显示范围
--]]
function SurvivalMainPanel:isShowRangeToggle_Toggle_onValueChanged(isShowRangeToggle,isOn)
    SurvivalManager.instance():SetIsShowRange(isOn)
end

--[[
/GamePlayMenu/RoleList/role1/rolebtn1 onClick 切换角色1
--]]
function SurvivalMainPanel:rolebtn1_Button_onClick(rolebtn1)
    self:_switchRole(1)
end

--[[
/GamePlayMenu/RoleList/role2/rolebtn2 onClick 切换角色2
--]]
function SurvivalMainPanel:rolebtn2_Button_onClick(rolebtn2)
    self:_switchRole(2)
end

--[[
/GamePlayMenu/RoleList/role3/rolebtn3 onClick 切换角色3
--]]
function SurvivalMainPanel:rolebtn3_Button_onClick(rolebtn3)
    self:_switchRole(3)
end

--[[
/GamePlayMenu/skillBtn onClick 右下角主动技能
--]]
function SurvivalMainPanel:skillBtn_Button_onClick(skillBtn)

end

--[[
/GamePrepareMenu/isOpenLog/isOpenLogToggle onValueChanged 开关日志按钮
--]]
function SurvivalMainPanel:isOpenLogToggle_Toggle_onValueChanged(isOpenLogToggle,isOn)
    SurvivalLog.SetEnabled(isOn)
end

return SurvivalMainPanel
