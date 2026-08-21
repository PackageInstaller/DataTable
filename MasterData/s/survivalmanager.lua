require "class"
---@class SurvivalManager
local time = UnityEngine.Time
local SurvivalManager = class("SurvivalManager")
local SurvivalRoleManager = require("SurvivalRoleManager")
local SurvivalBulletManager = require("SurvivalBulletManager")
local SurvivalEventManager = require("SurvivalEventManager")
local SurvivalColliderManager = require("SurvivalColliderManager")
local SurvivalSkillManager = require("SurvivalSkillManager")
local SurvivalAreaEffectManager = require("SurvivalAreaEffectManager")
local SurvivalItemManager = require("SurvivalItemManager")
local SurvivalState = require "SurvivalState"
--跳字显示时间
local hitNumShowTime = 1.5
--跳字行y间距
local hitYSpace = 0.1
--跳字行x间距
local hitXSpace = 0.15
---1 级升 2 级所需经验，之后每级在上一级基础上 +100
local BASE_EXP_PER_LEVEL = 100
--单个字符跳跃间隔时间
local hitJumpInterval = 0.1
--相邻字符间距
local hitJumpSpace = 28
local utf8util = require "utf8util"

function SurvivalManager:ctor(...)
	local CanvasScaler = UIMgr.uiCanvas.gameObject:GetComponent("CanvasScaler")
	self.screen_width = CanvasScaler.referenceResolution.x
	self.screen_height = CanvasScaler.referenceResolution.y
end

---设置用户输入方向
function SurvivalManager:SetInputDirection(direction)
	if self._isSkillCharging and not self._skillChargeCanMove then
		self.InputDirection = Vector2.zero
		return
	end
	self.InputDirection = direction
end

---获取用户输入方向
function SurvivalManager:GetInputDirection()
	return self.InputDirection
end

---是否处于技能瞄准阶段
function SurvivalManager:IsSkillAiming()
	return self._isSkillAiming
end

---获取技能瞄准方向（世界坐标）
function SurvivalManager:GetSkillAimDirection()
	return self._skillAimDirection
end

---UI 偏移方向转世界方向（与摇杆一致）
function SurvivalManager:_uiDirectionToWorld(uiDirection)
	if not uiDirection or uiDirection.sqrMagnitude <= 0 then
		return Vector3.zero
	end
	local cameraRotationY = self:GetCameraRotationY()
	local theta_cam = cameraRotationY * Mathf.Deg2Rad
	local theta_ui = math.atan2(uiDirection.x, uiDirection.y)
	local theta_world = theta_ui + theta_cam
	return Vector3(math.sin(theta_world), 0, math.cos(theta_world)).normalized
end

---进入技能瞄准阶段，显示方向提示
function SurvivalManager:StartSkillAim()
	if self._isSkillAiming then
		return
	end
	self._isSkillAiming = true
	self._skillAimDirection = Vector3.zero
	if self._skillAimLineObj then
		return
	end
	PoolMgr:Get(Config.PrefabPath.AimLine, function(obj)
		if not self._isSkillAiming then
			PoolMgr.Free(obj)
			return
		end
		self._skillAimLineObj = obj
		self:UpdateSkillAimLine()
	end)
end

---更新技能瞄准方向
---@param uiDirection Vector2 相对技能按钮中心的 UI 偏移
function SurvivalManager:UpdateSkillAimDirection(uiDirection)
	self._skillAimDirection = self:_uiDirectionToWorld(uiDirection)
	self:UpdateSkillAimLine()
end

---刷新脚下方向提示线
function SurvivalManager:UpdateSkillAimLine()
	if not self._isSkillAiming or not self._skillAimLineObj then
		return
	end
	local playerRole = self:GetRoleMgr():GetPlayerRole()
	if not playerRole or self._skillAimDirection == Vector3.zero then
		return
	end
	local pos = playerRole:GetPosition()
	local startPos = Vector3(pos.x, pos.y + 0.1, pos.z)
	local lineLength = 3
	local endPos = startPos + self._skillAimDirection * lineLength
	local lineCtr = self._skillAimLineObj.transform:GetComponent("SkillArrowLine")
	if lineCtr then
		lineCtr:ShowArrowLine(startPos, endPos)
	end
end

---结束技能瞄准阶段
function SurvivalManager:EndSkillAim()
	self._isSkillAiming = false
	self._skillAimDirection = Vector3.zero
	if self._skillAimLineObj then
		PoolMgr.Free(self._skillAimLineObj)
		self._skillAimLineObj = nil
	end
end

---是否处于技能蓄力阶段
function SurvivalManager:IsSkillCharging()
	return self._isSkillCharging == true
end

---蓄力期间是否允许移动
function SurvivalManager:CanMoveWhileSkillCharging()
	return self._skillChargeCanMove ~= false
end

---获取当前蓄力比例 0~1
function SurvivalManager:GetSkillChargeRatio()
	return self._skillChargeRatio or 0
end

---尝试开始蓄力（skillType=Manual 且 skillTypeParam.time > 0）
---@return boolean
function SurvivalManager:TryStartSkillCharge()
	self:EndSkillCharge()
	local role = self:GetRoleMgr():GetPlayerRole()
	if not role then
		return false
	end
	local skillIndex = role:GetManualSkillIndex()
	if not skillIndex then
		return false
	end
	local skill = role:GetSkillByIndex(skillIndex)
	if not skill or skill.cdRemain > 0 then
		return false
	end
	local cfg = Config.GetSurvivorSkillInfo(skill.skillId)
	local param = cfg and cfg.skillTypeParam
	if not param or not param.time or param.time <= 0 then
		return false
	end
	self._isSkillCharging = true
	self._skillChargeElapsed = 0
	self._skillChargeMaxTime = param.time
	self._skillChargeCanMove = param.canMove ~= 0
	self._skillChargeRatio = 0
	return true
end

---更新蓄力进度
---@param deltaTime number
function SurvivalManager:UpdateSkillCharge(deltaTime)
	if not self._isSkillCharging then
		return
	end
	self._skillChargeElapsed = math.min(self._skillChargeMaxTime, self._skillChargeElapsed + deltaTime)
	if self._skillChargeMaxTime > 0 then
		self._skillChargeRatio = self._skillChargeElapsed / self._skillChargeMaxTime
	else
		self._skillChargeRatio = 1
	end
end

---结束蓄力阶段
function SurvivalManager:EndSkillCharge()
	self._isSkillCharging = false
	self._skillChargeElapsed = 0
	self._skillChargeMaxTime = 0
	self._skillChargeCanMove = true
	self._skillChargeRatio = 0
end

---手动释放主控角色技能
function SurvivalManager:CastPlayerSkill()
	local role = self:GetRoleMgr():GetPlayerRole()
	if not role or not role:IsAlive() then
		self:EndSkillAim()
		self:EndSkillCharge()
		return
	end
	local skillIndex = role:GetManualSkillIndex()
	if not skillIndex then
		self:EndSkillAim()
		self:EndSkillCharge()
		return
	end
	local skill = role:GetSkillByIndex(skillIndex)
	if not skill or skill.cdRemain > 0 then
		self:EndSkillAim()
		self:EndSkillCharge()
		return
	end
	local castDirection = self._skillAimDirection
	if castDirection == Vector3.zero then
		castDirection = role:GetDirection()
	end
	if castDirection == Vector3.zero then
		self:EndSkillAim()
		self:EndSkillCharge()
		return
	end
	local chargeRatio = self:GetSkillChargeRatio()
	local isUsed, feedBack = self:GetSkillMgr():DoSkill(role, skillIndex, castDirection, chargeRatio)
	self:EndSkillAim()
	self:EndSkillCharge()
	if isUsed then
		skill.cdRemain = skill.MaxCd
		role:_notifySkillCdChange(skillIndex)
		if feedBack and feedBack.direction and feedBack.direction ~= Vector3.zero then
			role:PlaySkillAttack(feedBack)
		end
	end
end

---获取相机旋转Y轴角度
function SurvivalManager:GetCameraRotationY()
	-- return self.cameraRotateRoot.transform.localRotation.eulerAngles.y
	return self._cameraRotationY
end

--初始化
function SurvivalManager:Init()
	--自走棋游戏状态
	---@type SurvivalStateEnum
	self._state = nil
	---游戏计时器
	self._time = 0
	self._timeBefore = 0
	self._ui = nil
	--用户输入方向
	---@type Vector2
	self.InputDirection = Vector2.zero
	self._cameraRotationY = 0
	---是否显示范围
	self._isShowRange = false
	self._isSkillAiming = false
	self._skillAimDirection = Vector3.zero
	self._skillAimLineObj = nil
	self._isSkillCharging = false
	self._skillChargeElapsed = 0
	self._skillChargeMaxTime = 0
	self._skillChargeCanMove = true
	self._skillChargeRatio = 0
	self._playerLevel = 1
	self._playerExp = 0
	local survivalRoot = SurvivalState:GetSurvivalRoot()
	--主相机
	self.mainVcamObj = survivalRoot.transform:Find("GameSceneInfo/CameraRoot/CameraRotateRoot/MainVcam").gameObject
	self.mainVcamVcam = self.mainVcamObj:GetComponent(TypeInfo.CinemachineVirtualCamera)
	self.cameraRoot = survivalRoot.transform:Find("GameSceneInfo/CameraRoot").gameObject
	self.cameraRotateRoot = survivalRoot.transform:Find("GameSceneInfo/CameraRoot/CameraRotateRoot").gameObject
	self._cameraRotationY = self.cameraRotateRoot.transform.localRotation.eulerAngles.y
	self.coveAudioListener = self.cameraRotateRoot:GetComponent(typeof(UnityEngine.AudioListener))
	--替换renderTexture
	self.cameraObj = survivalRoot.transform:Find("GameSceneInfo/MainCamera").gameObject
	self.camera = self.cameraObj:GetComponent("Camera")
	UIMgr.SetBaseCamera(self.camera)
	self.camera.enabled = true
	self._hitTextList = {}
	self._timerList = {}
	self._copyTextList = {}
end

--帧同步
function SurvivalManager:Update()
	local deltaTime = time.deltaTime
	if self._state == GE.SurvivalStateEnum.Battle then
		--刷新游戏时间 
		self._time = self._time + deltaTime
		if self._time - self._timeBefore >= 1 then
			self._timeBefore = self._timeBefore + 1
			self:GetMainUI():RefreshTime(self._timeBefore)
		end
		self:GetRoleMgr():Update(deltaTime)
		self:GetBulletMgr():Update(deltaTime)
		self:GetItemMgr():Update(deltaTime)
		self:GetColliderMgr():Update(deltaTime)
		self:GetAreaEffectMgr():Update(deltaTime)
		self:GetEventMgr():Update(deltaTime)
		self:UpdateCamera(deltaTime)
		self:UpdateHitTextPos()
		if self._isSkillCharging then
			self:UpdateSkillCharge(deltaTime)
		end
		if self._isSkillAiming then
			self:UpdateSkillAimLine()
		end
		--更新切换角色CD显示
		self:GetMainUI():UpdateSwitchCd()
	end
end

--更新跳字位置
function SurvivalManager:UpdateHitTextPos()
	local camera = self.camera
	local width = self.screen_width
	local height = self.screen_height
	for hitTextObj, pos in pairs(self._hitTextList) do
		local result = camera:WorldToViewportPoint(pos)
		if result.x < 0 or result.x > 1 or result.y < 0 or result.y > 1 or result.z < 0 then
			hitTextObj:SetActive(false)
		else
			local finalPos = Vector3.New(result.x * width - width/2, result.y * height - height/2, 0)
			if Vector3.Distance(finalPos, hitTextObj.transform.localPosition) > 2 then
				hitTextObj.transform.localPosition = finalPos
				hitTextObj:SetActive(true)
			end
		end
	end
end

---更新相机位置到主控角色
function SurvivalManager:UpdateCamera(deltaTime)
	local playerRole = self:GetRoleMgr():GetPlayerRole()
	if playerRole then
		local playerRolePos = playerRole.position
		self.cameraRoot.transform.position = playerRolePos
	end
end

---实例化
---@return SurvivalManager SurvivalManager
function SurvivalManager.instance()
	if (SurvivalManager._instance == nil) then
		SurvivalManager._instance = SurvivalManager:new()
	end
	return SurvivalManager._instance
end

---角色管理器实例化
---@return SurvivalRoleManager
function SurvivalManager:GetRoleMgr()
	return SurvivalRoleManager.instance()
end

---子弹管理器实例化
---@return SurvivalBulletManager
function SurvivalManager:GetBulletMgr()
	return SurvivalBulletManager.instance()
end

---事件管理器实例化
---@return SurvivalEventManager
function SurvivalManager:GetEventMgr()
	return SurvivalEventManager.instance()
end

---碰撞管理器实例化
---@return SurvivalColliderManager
function SurvivalManager:GetColliderMgr()
	return SurvivalColliderManager.instance()
end

---技能管理器
---@return SurvivalSkillManager
function SurvivalManager:GetSkillMgr()
	return SurvivalSkillManager.instance()
end

---区域效果管理器
---@return SurvivalAreaEffectManager
function SurvivalManager:GetAreaEffectMgr()
	return SurvivalAreaEffectManager.instance()
end

---掉落道具管理器
---@return SurvivalItemManager
function SurvivalManager:GetItemMgr()
	return SurvivalItemManager.instance()
end

---当前等级升级所需经验（level 1 需 100，level 2 需 200…）
---@param level integer|nil
---@return number
function SurvivalManager:GetExpRequiredForLevel(level)
	level = level or self._playerLevel or 1
	return level * BASE_EXP_PER_LEVEL
end

---@return integer
function SurvivalManager:GetPlayerLevel()
	return self._playerLevel or 1
end

---@return number
function SurvivalManager:GetPlayerExp()
	return self._playerExp or 0
end

---重置玩家经验（新局开始）
function SurvivalManager:ResetPlayerExp()
	self._playerLevel = 1
	self._playerExp = 0
end

---增加经验并处理升级
---@param amount number
function SurvivalManager:AddPlayerExp(amount)
	if not amount or amount <= 0 then
		return
	end
	self._playerExp = (self._playerExp or 0) + amount
	local need = self:GetExpRequiredForLevel(self._playerLevel)
	while need > 0 and self._playerExp >= need do
		self._playerExp = self._playerExp - need
		self._playerLevel = self._playerLevel + 1
		need = self:GetExpRequiredForLevel(self._playerLevel)
	end
	self:GetEventMgr():AddEvent(0, GE.SurvivalEventType.PlayerExpChange)
end

---切换状态
---@param newState SurvivalStateEnum 状态
function SurvivalManager:ChangeState(newState)
	-- LuaLogger.ds("SurvivalManager:ChangeState 切换状态", newState)
	--退出状态方法
	local leaveFunc = {
		[GE.SurvivalStateEnum.Pause] = function()
			self:GetMainUI():PauseMenu(false)
		end,
		[GE.SurvivalStateEnum.Battle] = function()
			self:GetMainUI():PlayState(false)
		end,
		[GE.SurvivalStateEnum.Prepare] = function()
			self:GetMainUI():PrepareState(false)
		end,
		[GE.SurvivalStateEnum.GameOver] = function()
			self:GetMainUI():GameOverState(false)
			self:Clear()
			self:Init()
		end,
	}
	--进入状态方法
	local inFunc = {
		[GE.SurvivalStateEnum.Pause] = function()
			self:GetMainUI():PauseMenu(true)
		end,
		[GE.SurvivalStateEnum.Battle] = function()
			self:GetMainUI():PlayState(true)
		end,
		[GE.SurvivalStateEnum.Prepare] = function()
			self:GetMainUI():PrepareState(true)
			self._time = 0
			self:ResetPlayerExp()
			self:GetMainUI():RefreshExpUI()
		end,
		[GE.SurvivalStateEnum.GameOver] = function()
			self:GetMainUI():GameOverState(true)
		end,
	}
	if self._state and leaveFunc[self._state] then
		leaveFunc[self._state]()
	end
	self._state = newState
	if inFunc[newState] then
		inFunc[newState]()
	end
end

---显示伤害数字
---@param position Vector3 位置
---@param damage number 伤害
function SurvivalManager:ShowHitNumber(position, hpChange)	
	local path = Config.PrefabPath.SurvivalHitText
	PoolMgr:Get(path, function (obj)
		if (obj) then
			local textController = obj.transform:GetComponent("HitTextController")
			
			local totalText = textController.totalText:GetComponent(TypeInfo.Text)
			local totalTextParent = textController.totalTextParent --总伤害
			local totalRoot = textController.totalRoot			--总伤害父节点

			local hitTextParent = textController.hitTextParent
			local hitText = textController.hitText:GetComponent(TypeInfo.Text)
			local hitRoot = textController.hitRoot

			local healTextParent = textController.healTextParent	--治疗
			local healText = textController.healText:GetComponent(TypeInfo.Text)
			local healRoot = textController.healRoot				--治疗父节点

			local critImg = textController.critImg
			local descImg = textController.descImg
			local missImg = textController.missImg
			critImg.gameObject:SetActive(false)
			descImg.gameObject:SetActive(false)
			missImg.gameObject:SetActive(false)

			local isRepair = hpChange > 0
			hpChange = math.abs(hpChange)
			hitTextParent:SetActive(not isRepair)
			totalTextParent:SetActive(false)
			healTextParent:SetActive(isRepair)
			--字体颜色 
			-- local color = self:HexToColor("#fff9b4", 1)	--默认金色
			if isRepair then
				-- color = self:HexToColor("#5ef985", 1)	--绿色
			end
			--需要复制的节点
			local targetText
			local targetRoot
			if isRepair then
				targetText = healText
				targetRoot = healRoot
			else
				targetText = hitText
				targetRoot = hitTextParent
				--最终跳字是否需要显示 总伤害 字样
				textController.totalIcon:SetActive(false)
			end
			targetRoot.transform.localScale = Vector3(1, 1, 1)
			--跳字位置
			local targetPos = position 
			--跳字转ui层
			local uiroot = UIMgr:GetUIRootParent()
			obj.transform:SetParent(uiroot.transform, false)
			local camera = self.camera
			local width = self.screen_width
			local height = self.screen_height
			local result = camera:WorldToViewportPoint(targetPos)
			local finalPos = Vector3.New(result.x * width - width/2, result.y * height - height/2, 0)
			obj.transform.localPosition = finalPos
			self:addHitTextList(obj, targetPos)	--添加到跳字列表
			--伤害显示
			local tempList = self:splitDamageText(tostring(hpChange), targetText, targetRoot, hitJumpSpace, hitJumpInterval)
			local timer = self:_DoAfter(hitNumShowTime, function()
				-- PoolMgr.Free(obj)
				self:removeHitTextList(obj)	--移除跳字列表
				for k, v in pairs(tempList) do
					v:Destroy()
				end
			end)
			table.insert(self._timerList, timer)
			table.insert(self._copyTextList, tempList)
			-- LuaLogger.ds("BattleShowManager:showHitNumber end")
		end
	end)
end

function SurvivalManager:splitDamageText(damage, targetText, targetRoot, hitJumpSpace, hitJumpInterval)
	-- LuaLogger.ds("SurvivalManager:splitDamageText damage", damage)
	local tempList = {}
	local damageStr = tostring(damage)
	local strList = string.utfchars(damageStr)
	local totalWidth = (tablex.size(strList) - 1) * hitJumpSpace
	targetText.gameObject:SetActive(true)
	local i = 0
	for k, str in pairs(strList) do
		i = i + 1
		local tempTextObj = Instantiate(targetText).gameObject
		tempTextObj.transform:SetParent(targetRoot.transform, false)
		tempTextObj.transform.localRotation = Quaternion.Euler(0, 0, 0)
		local originalPosition = targetText.transform.localPosition
		local offsetX = (i - 1) * hitJumpSpace - totalWidth / 2
		tempTextObj.transform.localPosition = Vector3(originalPosition.x + offsetX, originalPosition.y, originalPosition.z)
		local text = tempTextObj:GetComponent(TypeInfo.Text)
		text.text = strList[i]
		local timer = self:_DoAfter(hitJumpInterval * (i - 1), function()
			if tempTextObj then
				tempTextObj.transform:DOPunchPosition(Vector3.New(0, 10, 0), 0.2, 0, 0)
			end
		end)
		table.insert(tempList, tempTextObj)
		table.insert(self._timerList, timer)
	end
	targetText.gameObject:SetActive(false)
	return tempList
end

function SurvivalManager:addHitTextList(obj, pos)
	self._hitTextList[obj] = pos
end

function SurvivalManager:removeHitTextList(obj)
	self._hitTextList[obj] = nil
	PoolMgr.Free(obj)
end

function SurvivalManager:GetGameState()
	return self._state
end

function SurvivalManager:GetIsShowRange()
	return self._isShowRange
end

function SurvivalManager:SetIsShowRange(isShowRange)
	self._isShowRange = isShowRange
end

function SurvivalManager:GetMainUI()
	if not self._ui then
		self._ui = UIMgr:GetUI("SurvivalMainPanel")
	end
	return self._ui
end

function SurvivalManager:_DoAfter(time, event)
	if (time <= 0) then
		if (event) then
			event()
		end
		return nil
	end
	return DLuaTimer:DoAfter(time/Time.timeScale, function()
		if (event) then
			event()
		end
	end)
end

function SurvivalManager:Clear()
	self:EndSkillAim()
	self:EndSkillCharge()
	self:GetRoleMgr():Clear()
	self:GetBulletMgr():Clear()
	self:GetItemMgr():Clear()
	self:GetAreaEffectMgr():Clear()
	self:GetEventMgr():Clear()
	self:GetColliderMgr():Clear()
	for obj, pos in pairs(self._hitTextList) do
		self._hitTextList[obj] = nil
		PoolMgr.Free(obj)
	end
	for _, timer in pairs(self._timerList) do
		DLuaTimer:RemoveTimer(timer)
	end
	self._timerList = {}
	for _, objList in pairs(self._copyTextList) do
		for _, obj in pairs(objList) do
			if obj then
				obj:Destroy()
			end
		end
	end
	self._copyTextList = {}
end

return SurvivalManager