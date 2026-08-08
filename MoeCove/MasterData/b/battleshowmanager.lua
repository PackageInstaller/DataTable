---@diagnostic disable: undefined-global
require "class"
local BaseShowManager = require "BaseShowManager"
---@class BattleShowManager:BaseShowManager
local BattleShowManager = class("BattleShowManager", BaseShowManager)
-- local GameObject = nil
local utf8util = require "utf8util"

local BattleCore = require "BattleCore"
local activeColor = Color.New(1,1,1,1)
local unactiveColor = Color.New(1,1,1,0)
local halfAlphaColor = Color.New(1,1,1,0.25)
local baseColor = Color.New(1,1,1,1)
local roleActiveColor = Color.New(0,0,0,0)
local roleUnactiveColor = Color.New(0,0,0,0.7)
local roleSelectedColor = Color.New(1,1,1,0.2)

local dirBlockRotate = {
	[GE.RoleDirectionType.Up] = 90,
	[GE.RoleDirectionType.Down] = 270,
	[GE.RoleDirectionType.Left] = 0,
	[GE.RoleDirectionType.Right] = 180,
}

--跳字显示时间
local hitNumShowTime = 1.5
--跳字行y间距
local hitYSpace = 0.1
--跳字行x间距
local hitXSpace = 0.15
--单个字符跳跃间隔时间
local hitJumpInterval = 0.1
--烟雾特效延迟时间
local smokeEffectDelay = 0
--防空特效触发距离(沿飞行朝向，忽略高度和横向)
local airDefenseTriggerDist = 2
--相邻字符间距
local hitJumpSpace = 28
--2025/11/25 缩放比例
local scaleIndex = 1.3
local mapCubeOffsetY = 1/2 * (scaleIndex - 1)
local BattleCameraSet = Config.GetConfigInfo("BattleCameraSet")
local cameraMax = BattleCameraSet[1] / 1.3 * scaleIndex
local cameraMin = BattleCameraSet[2] / 1.3 * scaleIndex
local cameraSpace = (cameraMax - cameraMin) * BattleCameraSet[3]
--战斗入场演出：角色相对迎光方向向右偏转角度、roleLight X 轴偏移
local enterBattleShowRoleYawOffset = 10
local enterBattleShowRoleLightPitchOffset = 10
--同样还要修改battlerole里面的RoleRoot y轴 为0.5+mapCubeOffsetY 因为cube的宽度半径为0.5 扩大1.3倍多了0.15
--还需要修改战斗入场,退场镜头EnterBattlePath的CMvcam1的tracked object Offest.y

---战斗表现类型对应的tips路径
local BulletDisTypeToTips = {
	[GE.BulletDisType.Miss] = Config.HitTipsPath.Miss,
	[GE.BulletDisType.Ricochet] = Config.HitTipsPath.Miss3,
	-- [GE.BulletDisType.Hit] = Config.HitTipsPath.Miss,	--命中不需要提示
	[GE.BulletDisType.Partial] = Config.HitTipsPath.Partial,
	[GE.BulletDisType.DefReduce] = Config.HitTipsPath.Partial2,
}

function BattleShowManager:ctor()
	BattleCore.ds("BattleShowManager:ctor")
	self:reset()
end

---@class ShowManagerBattleMainPanelData
---@field ui BattleMainPanel
function BattleShowManager:reset()
	BattleCore.ds("BattleShowManager:reset===========================")
	---@type BaseShowManager
	local baseClass = self.super
	baseClass.reset(self)

	self._formationRangeList = {}
	---@type AreaObject[]
	self._moveRangeList = {}
	---@type AreaObject[]
	self._skillRangeList = {}
	---@type AreaObject[]
	self._chooseRangeList = {}
	---@type AreaObject[]
	self._dangerRangeList = {}
	---@type table<integer,table<AreaObject[], integer>>
	self._prepareSkillRangeList = {}
	---@type BlockTagObject[]
	self._blockTagList = {}

	---@type table<AreaObject[], table<integer, boolean>> 对象池等待列表，key为对象池列表，value为当前正在等待的blockId列表（因为同一个对象池可能会有多个blockId在等待，所以用一个表来存储）
	self._waitShowRangeList = {}
	self._targetEffectList = {}
	self._eventObjlist = {}
	self._aimLineList = {}
	self._calculateLineList = {}
	self._sceneEffectList = {}
	self._airDefenseEffectMap = {}
	self._battleUIFog = nil

	self._preloadWaitList = {}
	self._allFinishCallBack = nil

	---@type DTimer.TimerInfo[]
	self._actionAreaTimer = {}

	self._director = nil			--TimeLine导演节点
	self._timelineMgr = nil
	self._cinemachineBrain = nil
	self._enterBattleTestId = nil
	---@type Cinemachine.CinemachineVirtualCamera
	self._enterBattleVcam = nil
	Time.timeScale = 1
	self.protectedRoleId = nil	--保护角色ID
	---@type CoveScene
	self._coveScene = nil
end

---@param roleCid integer
---@return BaseRole?
function BattleShowManager:_findBaseRole(roleCid)
	local battleRoleManager = BattleCore:getBattleRoleMgr()
	return battleRoleManager and battleRoleManager:getRoleByCidNoCamp(roleCid)
end

---@param roleCid integer
---@return boolean
function BattleShowManager:_isAdvantageousRoleEffect(roleCid)
	local battleMgr = BattleCore:getBattleMgr()
	if not battleMgr then return false end
	local roleEffect = battleMgr:GetAdvantageousRoleEffectList(roleCid)
	return roleEffect ~= nil and next(roleEffect) ~= nil
end

------------------ 血条 & 伤害跳字（战斗专用） ------------------

--更新血条位置
function BattleShowManager:UpdateHpPos(id)
	local camera = self.camera
	local width = self.screen_width
	local height = self.screen_height
	for k, v in pairs(self.rolesMap) do
		if (not id) or (id and id == v.roleId) then
			local RoleController = v.controller
			local hpObj = v.hpObj
			if hpObj then
				local uiroot = RoleController.uiRoot
				local targetPos = uiroot.transform.position
				local result = camera:WorldToViewportPoint(targetPos)
				if result.x < 0 or result.x > 1 or result.y < 0 or result.y > 1 or result.z < 0 then
					hpObj.gameObject:SetActive(false)
				else
					hpObj.gameObject:SetActive(true)
					local finalPos = Vector3.New(result.x * width - width/2, result.y * height - height/2, 0)
					if Vector3.Distance(finalPos, hpObj.transform.localPosition) > 0.2 then
						hpObj.transform.localPosition = finalPos
					end
				end
			end
			local skillIconObj = v.SkillIconObj
			if skillIconObj then
				local skillIconRoot = RoleController.skillIconRoot
				local targetPos = skillIconRoot.transform.position
				local result = camera:WorldToViewportPoint(targetPos)
				if result.x < 0 or result.x > 1 or result.y < 0 or result.y > 1 or result.z < 0 then
					skillIconObj.gameObject:SetActive(false)
				else
					skillIconObj.gameObject:SetActive(true)
					local finalPos = Vector3.New(result.x * width - width/2, result.y * height - height/2, 0)
					if Vector3.Distance(finalPos, skillIconObj.transform.localPosition) > 0.2 then
						skillIconObj.transform.localPosition = finalPos
					end
				end
			end
		end
	end
end

--更新跳字位置
function BattleShowManager:UpdateHitTextPos()
	local camera = self.camera
	local width = self.screen_width
	local height = self.screen_height
	for hitTextObj, pos in pairs(self._hitTextList) do
		local result = camera:WorldToViewportPoint(pos)
		local finalPos = Vector3.New(result.x * width - width/2, result.y * height - height/2, 0)
		if Vector3.Distance(finalPos, hitTextObj.transform.localPosition) > 2 then
			hitTextObj.transform.localPosition = finalPos
		end
	end
end

--更新特效文本位置
function BattleShowManager:UpdateEffectTextPos()
	local camera = self.camera
	local width = self.screen_width
	local height = self.screen_height
	for effectTextObj, pos in pairs(self._effectTextList) do
		local result = camera:WorldToViewportPoint(pos)
		local finalPos = Vector3.New(result.x * width - width/2, result.y * height - height/2, 0)
		if Vector3.Distance(finalPos, effectTextObj.transform.localPosition) > 2 then
			effectTextObj.transform.localPosition = finalPos
		end
	end
end

function BattleShowManager:addHitTextList(obj, pos)
	self._hitTextList[obj] = pos
end

function BattleShowManager:removeHitTextList(obj)
	self._hitTextList[obj] = nil
	PoolMgr.Free(obj)
end

function BattleShowManager:addEffectTextList(obj, pos)
	self._effectTextList[obj] = pos
end

function BattleShowManager:removeEffectTextList(obj)
	self._effectTextList[obj] = nil
	PoolMgr.Free(obj)
end

function BattleShowManager:showRoleHp(data, callback)
	local roleCtor = self:getRoleController(data.id)
	local hpObj = self:getRoleHpObj(data.id)
	if roleCtor == nil then
		if (callback) then callback() end
		return
	end
	UICommonUtils.Hp_SetHpImageByCamp(hpObj, roleCtor, data.camp)
	UICommonUtils.Hp_SetUIRootActive(hpObj, true)
	roleCtor:SetHp(data.hp, data.maxHp)
	UICommonUtils.HP_SetHp(hpObj, data.hp, data.maxHp)
	self:setRoleUIActive(data.id, true)
	if (callback) then
		callback()
	end
end

---刷新角色Buff状态
---@param data BuffStateReportData
function BattleShowManager:refreshHeroBuffState(data, callback)
	local maxIndex = 3
	local hpObj = self:getRoleHpObj(data.id)
	local index = 0
	if hpObj then
		for _, v in ipairs(data.buffs) do
			local buffId = v
			local buffConfig = Config.GetBuffInfo(buffId)
			index = index + 1
			local buffIndex = index
			ResMgr:LoadSpriteAsyncInOwner(string.format(Config.SpritePath.BuffIconPath, buffConfig.buffIcon),
				function(s)
					if s and hpObj then
						UICommonUtils.Hp_SetBuffIcon(hpObj, s, buffIndex)
					end
				end
			, hpObj)
			UICommonUtils.HP_OpenBuffIcon(hpObj, true, index)
			if index >= maxIndex then
				break
			end
		end
		if index < maxIndex then
			for i = index + 1, maxIndex do
				UICommonUtils.HP_OpenBuffIcon(hpObj, false, i)
			end
		end
	end
	self:BuffBehavior({
		id = data.id,
		buffs = data.buffs,
	}, function()
		if (callback) then
			callback()
		end
	end)
end

function BattleShowManager:justHit(data, callback, isStory)
	local roleId = data.roleId
	local targetRoleId = data.targetRoleId
	local blockid = data.blockId
	local targetBlockId = data.targetBlockId
	local role = self:getRole(roleId)
	local model = role.model
	local targetRole = self:getRole(targetRoleId)
	local targetModel = targetRole.model
	local delay = data.delay or 0
	if (model) then
		local shootRootTrans = self:__findShootPoint(model, data.shootPos)
		if not shootRootTrans then
			BattleCore.es("没有找到发射点位")
			return
		end
		local hitRootTrans, isSelf = self:__findHitPoint(targetModel, 1)
		if not hitRootTrans then
			BattleCore.es("没有找到受击点位")
			return
		end
		local blockObj = self:getBlockObj(blockid)
		local targetBlockObj = self:getBlockObj(targetBlockId)
		local startPos = shootRootTrans.position
		local targetPos = hitRootTrans.position
		local hitResult = data.hitResult
		local hitEffect
		local disType = self:getDisTypeByHitType(hitResult.type, GE.CannonHitToDis)
		if disType == GE.BulletDisType.Miss then
			local randomX = UnityEngine.Random.Range(-0.5, 0.5)
			local randomZ = UnityEngine.Random.Range(-0.5, 0.5)
			targetPos = targetBlockObj.transform.position + Vector3(randomX, 0.5 + mapCubeOffsetY, randomZ)
			hitEffect = 1080
		else
			if isSelf then
				targetPos = targetPos + Vector3(0, 0.3, 0)
			end
			local randomX = UnityEngine.Random.Range(-0.1, 0.1)
			local randomZ = UnityEngine.Random.Range(-0.1, 0.1)
			targetPos = targetPos + Vector3(randomX, 0, randomZ)
			if disType == GE.BulletDisType.Ricochet then
				hitEffect = 1083
			elseif disType == GE.BulletDisType.Partial then
				hitEffect = 1081
			elseif disType == GE.BulletDisType.Hit then
				hitEffect = data.hitEffect
			end
		end
		local shootEffect = data.shootEffect
		if shootEffect then
			local targetTrans = data.shoottyp == 0 and shootRootTrans or nil
			self:playEffect(startPos, shootEffect, Quaternion.LookRotation(-shootRootTrans.right, shootRootTrans.up) * Quaternion.Euler(0, 180, 0), nil, nil, nil, nil, targetTrans)
		end
		local smoke = data.smoke
		if smoke then
			self:_DoAfter(smokeEffectDelay, function()
				self:playEffect(startPos, smoke, self:__getSmokeRotation(shootRootTrans))
			end)
		end
		self:_DoAfter(data.dmgDelay, function()
			if hitEffect then
				self:playEffect(targetPos, hitEffect, nil, hitResult, GE.SkillPerformanceType.JustHit)
			end
			if hitResult and not isStory then
				self:playHitText(hitResult, targetRoleId, targetPos, disType)
			end
		end)
	end
	self:_DoAfter(data.dmgDelay + 1, function()
		if (callback) then
			callback()
		end
	end)
end

function BattleShowManager:__findShootPoint(model, index)
	BattleCore.ds("__findShootPoint", tablex.dump(index))
	local shootRootsList = model.shootPoints
	local torpedoList = model.shootPoints2
	local targetList
	local targetIndex = 0
	if not index then
		BattleCore.ws("表里没有配置子弹发射点 随机射击点位  ", model.transform.name)
		local Length = shootRootsList.Length
		if Length == 0 then
			BattleCore.ws("角色模型没有绑定射击点位 默认用自身位置  ", model.transform.name)
			return model.transform
		else
			targetIndex = math.random(1, Length) - 1
			if shootRootsList[targetIndex] then
				return shootRootsList[targetIndex]
			else
				BattleCore.ws("角色射击点位为None 默认用自身位置  ", model.transform.name)
				return model.transform
			end
		end
	else
		if index[1] == 1 then
			targetList = shootRootsList
		elseif index[1] == 2 then
			targetList = torpedoList
		end
		local Length = targetList.Length
		if Length == 0 then
			BattleCore.ws("角色模型没有绑定射击点位 默认用自身位置  ", model.transform.name)
			return model.transform
		else
			if index[2] > Length then
				targetIndex = math.random(1, Length) - 1
				BattleCore.ws(model.transform.name .. "角色没有对应射击点位  ", index[2])
			else
				targetIndex = index[2] - 1
			end
			if targetList[targetIndex] then
				return targetList[targetIndex]
			else
				BattleCore.ws("角色射击点位为None 默认用自身位置  ", model.transform.name)
				return model.transform
			end
		end
	end
end

---烟雾特效旋转：只保留Y轴朝向，XZ不倾斜，-Z为朝向
---@param shootRootTrans UnityEngine.Transform
---@return UnityEngine.Quaternion
function BattleShowManager:__getSmokeRotation(shootRootTrans)
	local shootDir = -shootRootTrans.right
	shootDir.y = 0
	if shootDir.sqrMagnitude > 0.0001 then
		return Quaternion.LookRotation(shootDir.normalized, Vector3.up) * Quaternion.Euler(0, 180, 0)
	end
	return Quaternion.identity
end

---播放防空特效：目标地格海平面，朝向受击者地格指向攻击者地格，绑定目标角色
---@param targetRoleId number
---@param blockObj UnityEngine.GameObject
---@param targetBlockObj UnityEngine.GameObject
function BattleShowManager:tryPlayAirDefenseEffect(targetRoleId, blockObj, targetBlockObj, time)
	if not self._airDefenseEffectMap then
		self._airDefenseEffectMap = {}
	end
	if self._airDefenseEffectMap[targetRoleId] then
		return
	end
	local targetRole = self:getRole(targetRoleId)
	if not targetRole or not targetRole.model then
		return
	end
	local battleRole = BattleCore:getBattleRoleMgr():getRole(targetRole.roleId, true)
	if not battleRole then
		BattleCore.ws("BattleShowManager:tryPlayAirDefenseEffect 角色不存在", targetRoleId)
		return
	end
	local effectId = battleRole:getAirDefenseEff()
	BattleCore.ds("BattleShowManager:tryPlayAirDefenseEffect effectId", effectId)
	if not effectId or effectId == 0 then
		return
	end
	local pos = targetBlockObj.transform.position + Vector3(0, 0.5 + mapCubeOffsetY, 0)
	local direction = blockObj.transform.position - targetBlockObj.transform.position
	direction.y = 0
	local baseRotation = Quaternion.identity
	if direction.sqrMagnitude > 0.0001 then
		baseRotation = Quaternion.LookRotation(direction.normalized, Vector3.up)
	end
	local startRotation = baseRotation 
	local endRotation = baseRotation * Quaternion.Euler(-45, 0, 0)
	self._airDefenseEffectMap[targetRoleId] = true
	local effectDuration = time or 2
	self:playEffect(pos, effectId, startRotation, nil, nil, nil, nil, targetRole.model.transform, time, function(obj)
		obj.transform:DORotateQuaternion(endRotation, effectDuration * 0.6):SetEase(DG.Tweening.Ease.Linear)
	end)
	self:_DoAfter(effectDuration, function()
		self._airDefenseEffectMap[targetRoleId] = nil
	end)
end

---沿飞行朝向检测目标并播放防空特效
---@param pos Vector3
---@param flyDir Vector3 平飞朝向(水平)
---@param blockObj UnityEngine.GameObject
---@param pendingTargetMap table<integer, table> 待检测目标，触发或飞过后移除
---@param airDefenseDist number?
---@return boolean 是否还有待检测目标
function BattleShowManager:__tryPlayAirDefenseEffectsByDist(pos, flyDir, blockObj, pendingTargetMap, airDefenseDist)
	if not pendingTargetMap or not next(pendingTargetMap) then
		return false
	end
	airDefenseDist = airDefenseDist or airDefenseTriggerDist
	if flyDir.sqrMagnitude <= 0.0001 then
		return true
	end
	local flyDirNorm = flyDir.normalized
	for roleId, targetInfo in pairs(pendingTargetMap) do
		local targetBlockObj = self:getBlockObj(targetInfo.targetBlockId)
		if not targetBlockObj then
			pendingTargetMap[roleId] = nil
		else
			local targetBlockPos = targetBlockObj.transform.position
			local toTarget = Vector3(
				targetBlockPos.x - pos.x,
				0,
				targetBlockPos.z - pos.z
			)
			local forwardDist = Vector3.Dot(toTarget, flyDirNorm)
			if forwardDist <= 0 then
				pendingTargetMap[roleId] = nil
			elseif forwardDist < airDefenseDist then
				self:tryPlayAirDefenseEffect(targetInfo.targetRoleId, blockObj, targetBlockObj, 2)
				pendingTargetMap[roleId] = nil
			end
		end
	end
	return next(pendingTargetMap) ~= nil
end

---寻找受击点位
---@return UnityEngine.Transform
---@return boolean
function BattleShowManager:__findHitPoint(model, index)
	local hitPointsList = model.hitPoints
	local targetIndex = 0
	local Length = hitPointsList.Length
	if Length == 0 then
		return model.transform, true
	end
	if index > Length then
		targetIndex = math.random(1, Length) - 1
	else
		targetIndex = index - 1
	end
	return hitPointsList[targetIndex]
end

function BattleShowManager:getDisTypeByHitType(hitType, hitToDis)
	local targetTable = hitToDis[hitType]
	local randomIndex = math.random(1, #targetTable)
	return targetTable[randomIndex]
end

---显示伤害数字
---@param data HitResult
---@param roleId number
---@param pos Vector3
---@param disType BulletDisType
function BattleShowManager:playHitText(data, roleId, hitPos, disType)
	BattleCore.ds("BattleShowManager:playHitText", data, roleId, hitPos)
	local path = Config.PrefabPath.HitText
	local roleCtor = self:getRoleController(roleId)
	local hpObj = self:getRoleHpObj(roleId)
	local hitRootPos = roleCtor.hitTextRoot.transform.position
	local role = self:getRole(roleId)
	local model = role.model
	PoolMgr:Get(path, function (obj)
		if (obj) then
			local textController = obj.transform:GetComponent("HitTextController")
			local hitText = textController.hitText:GetComponent(TypeInfo.Text)
			local critImg = textController.critImg
			local descImg = textController.descImg
			local missImg = textController.missImg
			local hitTextRootObj = textController.hitRoot
			local hitTextParent = textController.hitTextParent
			local totalTextParent = textController.totalTextParent
			local healTextParent = textController.healTextParent
			local healText = textController.healText:GetComponent(TypeInfo.Text)
			local healRoot = textController.healRoot
			hitTextParent:SetActive(true)
			totalTextParent:SetActive(false)
			healTextParent:SetActive(false)
			missImg.gameObject:SetActive(false)
			descImg.gameObject:SetActive(false)
			local FontPath = Config.FontPath.White
			local targetPos = hitRootPos
			local uiroot = UIMgr:GetUIRootParent()
			obj.transform:SetParent(uiroot.transform, false)
			local randomX = UnityEngine.Random.Range(-0.3, 0.4)
			local randomZ = UnityEngine.Random.Range(-0.3, 0.4)
			local randomY = UnityEngine.Random.Range(0, 0.2)
			targetPos = targetPos + Vector3(randomX, randomY, randomZ)
			local camera = self.camera
			local width = self.screen_width
			local height = self.screen_height
			local result = camera:WorldToViewportPoint(targetPos)
			self:addHitTextList(obj, targetPos)
			local finalPos = Vector3.New(result.x * width - width/2, result.y * height - height/2, 0)
			obj.transform.localPosition = finalPos
			local restraintCorrect = data.restraintCorrect or 1
			if restraintCorrect < 1 then
				FontPath = Config.FontPath.Grey
			elseif restraintCorrect > 1 then
				FontPath = Config.FontPath.Red
			end
			hitText.text = ""
			local showText = tostring(data.dmg)
			local isCrit = data.isCrit
			local targetImg = nil
			local tipsPath = BulletDisTypeToTips[disType]
			if disType == GE.BulletDisType.Miss then
				targetImg = missImg
				showText = ""
				isCrit = false
			elseif disType == GE.BulletDisType.DefReduce then
				targetImg = missImg
				showText = ""
				isCrit = false
			elseif disType == GE.BulletDisType.Partial then
				targetImg = descImg
				if (model) then
					model:PlayAnim(RoleModelAnimEnum.Hit)
				end
			elseif disType == GE.BulletDisType.Hit then
				if (model) then
					model:PlayAnim(RoleModelAnimEnum.Hit)
				end
			elseif disType == GE.BulletDisType.Ricochet then
				targetImg = missImg
				showText = ""
				isCrit = false
			end
			critImg.gameObject:SetActive(isCrit)
			roleCtor.HitTextNum = roleCtor.HitTextNum + 1
			local space = hitJumpSpace
			if utf8util.isOnlyChinese(showText) then
				space = 0.26
			end
			if targetImg then
				targetImg.gameObject:SetActive(true)
				if tipsPath then
					ResMgr:LoadSpriteAsyncInOwner(tipsPath, function(s)
						if s and descImg then
							targetImg.sprite = s
						end
					end, targetImg.gameObject)
				end
			end
			ResMgr:LoadFontAsyncInOwner(FontPath, function(font)
				hitText.font = font
				local tempList = self:splitDamageText(showText, hitText, hitTextRootObj, space, hitJumpInterval)
				self:_DoAfter(hitNumShowTime, function()
					self:removeHitTextList(obj)
					if roleCtor.HitTextNum > 1 then
						roleCtor.HitTextNum = roleCtor.HitTextNum - 1
					end
					for k, v in pairs(tempList) do
						v:Destroy()
					end
				end)
				UICommonUtils.HP_ChangeHp(hpObj, data.dmg, false, roleCtor)
				roleCtor:ChangeHp(data.dmg, false)
			end, ResMgr:GetResCarrier())
		end
	end)
end

function BattleShowManager:splitDamageText(damage, targetText, targetRoot, hitJumpSpace, hitJumpInterval)
	BattleCore.ds("BattleShowManager:splitDamageText damage", damage)
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
		self:_DoAfter(hitJumpInterval * (i - 1), function()
			if tempTextObj then
				tempTextObj.transform:DOPunchPosition(Vector3.New(0, 10, 0), 0.2, 0, 0)
			end
		end)
		table.insert(tempList, tempTextObj)
	end
	targetText.gameObject:SetActive(false)
	return tempList
end

---@param hitResult HitResult?
---@param performanceType SkillPerformanceType?
---@param data ShakeData
function BattleShowManager:ShakeCameraByDmg(hitResult, performanceType, data)
	local frequency = data.frequency or 4
	local amplitude = data.amplitude or 2
	if hitResult then
		local type = hitResult.type
		local isCrit = hitResult.isCrit
		if type == GE.BulletHitType.Miss then
			BattleCore.ds("BattleShowManager:ShakeCameraByDmg Miss")
			return
		end
		if isCrit then
			amplitude = amplitude + 1
		end
	end
	self:ShakeLiveCamera(frequency, amplitude, data)
end

---@param frequency number
---@param amplitude number
---@param data ShakeData
function BattleShowManager:ShakeLiveCamera(frequency, amplitude, data)
	BattleCore.ds("BattleShowManager:ShakeLiveCamera 相机抖动参数", tablex.dump(data))
	if self._cinemachineImpulseSource then
		self._cinemachineImpulseSource.m_ImpulseDefinition.m_FrequencyGain = frequency
		self._cinemachineImpulseSource.m_ImpulseDefinition.m_AmplitudeGain = amplitude
		local envelope = self._cinemachineImpulseSource.m_ImpulseDefinition.m_TimeEnvelope
		envelope.m_AttackShape = data.entryCurve
		envelope.m_AttackTime = data.entryTime
		envelope.m_DecayShape = data.decayCurve
		envelope.m_DecayTime = data.decayTime
		envelope.m_SustainTime = data.sustainTime
		self._cinemachineImpulseSource.m_ImpulseDefinition.m_TimeEnvelope = envelope
		self._cinemachineImpulseSource:GenerateImpulse(Vector3(0.1, 0.1, 0.1))
	end
end

------------------ 帧更新（战斗） ------------------

function BattleShowManager:update()
	if (self.followTarget) then
		self:smoothFollow(self.followTarget, 0.08)
	end
	--清除提示线
	if self.smoothFollowLastTime ~= 0 and os.time() - self.smoothFollowLastTime > 1 then
		self.smoothFollowLastTime = 0
		---@type BattleMainPanel
		local BattleMainPanel = UIMgr:GetUI("BattleMainPanel")
		if BattleMainPanel then
			BattleMainPanel:clearfocusLineSelected()
		end
	end

	-- if (self.camera and self.roleCamera.fieldOfView ~= self.camera.fieldOfView) then
	-- 	self.roleCamera.fieldOfView = self.camera.fieldOfView
	-- end
end

--C# FixedUpdate 回调
function BattleShowManager:FixedUpdate()
	self:UpdateHpPos()
	self:UpdateHitTextPos()
	self:UpdateEffectTextPos()
	self:VcamCurveUpdate()
	self:CustomedUpdate()
	self:UpdateTagPos()
end

--更新标签位置位置
function BattleShowManager:UpdateTagPos()
	local camera = self.camera
	local width = self.screen_width
	local height = self.screen_height
	for blockId, obj in pairs(self._blockTagList) do
		if obj then
			local targetBlock = self:getBlockObj(blockId)
			local targetPos = targetBlock.transform.position + Vector3.New(0, 1.5, 0)	--地格上方偏移量
			local result = camera:WorldToViewportPoint(targetPos)
			if result.x < 0 or result.x > 1 or result.y < 0 or result.y > 1 or result.z < 0 then
				obj.gameObject:SetActive(false)
			else
				obj.gameObject:SetActive(true)
				local finalPos = Vector3.New(result.x * width - width/2, result.y * height - height/2, 0)
				if Vector3.Distance(finalPos, obj.transform.localPosition) > 0.2 then
					obj.transform.localPosition = finalPos
				end
			end
		end	
	end
end

function BattleShowManager:VcamCurveUpdate()
	if self.vcamPathUpdate then
		self.vcamPathUpdate()
	end
end

--C# lateupdate 回调 
function BattleShowManager:CustomedUpdate()
	--主相机切换监听
	if self._activatedCamListener then
		self._activatedCamListener()
	end
end

function BattleShowManager:checkPreload(path)
    if path ~= nil then
        local callback = self._preloadWaitList[path]
        if callback then
			if type(callback) == "function" then
				callback()
			end
            self._preloadWaitList[path] = nil
        end
    end

	if next(self._preloadWaitList) == nil then
		if self._allFinishCallBack then
			self._allFinishCallBack()
		end
	end
end

---@param path string
---@param callback function?
function BattleShowManager:setPreloadData(path, callback)
	self._preloadWaitList[path] = callback or 1
end

---@param path string
---@param num integer?
---@param callback function?
function BattleShowManager:setPreload(path, num, callback)
	self:setPreloadData(path, callback)
	PoolMgr:Preload(path, num, function ()
		self:checkPreload(path)
	end)
end

function BattleShowManager:clear()
	self:clearAllPrepareSkillRange()
	self._prepareSkillRangeList = nil
	UIMgr:closeSpecificUI("BattleMainPanel")
	---@class BattleMainUIData
	---@field ui BattleMainPanel
	self._uiBattleMain = nil
	if UICommonUtils.Checkobj(self._enterBattlePathObj) then
		DUtil.Destroy(self._enterBattlePathObj)
	end
	self._enterBattlePathObj = nil	--演出相机预制体
	self._pathDollyCart = nil		--演出相机dollycart组件
	self._curFollowNeedMove = false
	if UICommonUtils.Checkobj(self.battleRoot) then
		DUtil.Destroy(self.battleRoot)
	end
	self:removeFormationRange()
	self:removeMoveRange()
	self:removeSkillRange()
	self:removeChooseRange()
	self:removeDangerRange()
	self:removeAllAimLine()
	self:removeAllTorpedoLine()
	self:removeAllEventObj()
	self:removeBlockTag()
	self._waitShowRangeList = nil
	---@type BaseShowManager
	local baseClass = self.super
	baseClass.clear(self)
end

function BattleShowManager:preloadRes()
	self:setPreload(Config.PrefabPath.SelectedArea, 1)
	self:setPreload(Config.PrefabPath.BattleRole, 1)
	self:setPreload(Config.PrefabPath.FormationArea, 1)
	self:setPreload(Config.PrefabPath.MoveArea, 1)
	self:setPreload(Config.PrefabPath.ChooseArea, 1)
	self:setPreload(Config.PrefabPath.SkillArea, 1)
	self:setPreload(Config.PrefabPath.EdgeArea, 1)
	self:setPreload(Config.PrefabPath.BattleBlockTag, 1)
	self:setPreload(Config.PrefabPath.FriendCreateEffect, 1)
	self:setPreload(Config.PrefabPath.EnemyCreateEffect, 1)
	self:setPreload(Config.PrefabPath.PrepareSkillArea, 1)

	--预加载特效表中通用特效资源
	local targetEffectList = {}
	local effectSoundConfig = Config.GetAllConfig("SoundAndEffectTable")
	for k, v in pairs(effectSoundConfig) do
		if v.preLoad == 1 then
			targetEffectList[v.effectResource] = true
		end
	end
	--LuaLogger.ds("preloadRes targetEffectList", tablex.dump(targetEffectList))
	for name, _ in pairs(targetEffectList) do
		self:preloadEff(name)
	end
end

--预加载特效资源
function BattleShowManager:preloadEff(name)
	local path = string.format(Config.PrefabPath.BattleEffect, name, name)
	BattleCore.ds("preloadEff path", path)
	PoolMgr:Preload(path, 1)
end

--预加载子弹、飞机、鱼雷等资源
function BattleShowManager:preloadBullet(name)
	local path = string.format(Config.PrefabPath.BulletPrefab, name)
	BattleCore.ds("preloadBullet path", path)
	PoolMgr:Preload(path, 1)
end

--预加载角色相关资源 子弹、特效等（在确定上阵角色后+协议返回后 调用）
function BattleShowManager:preloadRoleRes()
	local battleMgr = BattleCore:getBattleMgr()
	local heroList = battleMgr:getHeroDataAll()
	-- LuaLogger.ds("preloadRoleRes heroList", tablex.dump(heroList))
	local targetListBullet = {}
	local targetListEff = {}

	for _, heroData in pairs(heroList) do
		local heroConfig = Config.GetCharacterInfo(heroData.id)
		local skinId = heroData.equipSkin
		local skinConfig = Config.GetCharacterSkinInfo(skinId)
		local skillList = heroData.EquippedSkillList
		--遍历携带技能
		for _, skillId in pairs(skillList) do
			if skillId ~= 0 then
				local targetConfig = nil
				local isSkillOverride = false	--是否优先用skill表
				local skillConfig = Config.GetSkillInfo(skillId)
				local actId = skillConfig.skillActId
				if actId ~= 0 then
					--以技能表配置的子弹、特效资源为准
					if skillConfig.effPriority == 1 then
						targetConfig = skillConfig
						isSkillOverride = true
					else
						targetConfig = skinConfig
					end
					BattleCore.ds("preloadRoleRes targetConfig", tablex.dump(targetConfig))
					--预加载子弹资源
					local bulletList = tablex.clone(skinConfig.bulletModel)
					--TODO:  这里处理成武器更新后的最终子弹
					self:changeBulletModelByWeapon(heroData.id, bulletList)
					for _, bulletName in pairs(bulletList) do
						targetListBullet[bulletName] = true
					end
					--预加载特效资源
					local skillActEff
					local skillHitEff
					if isSkillOverride then
						skillActEff = targetConfig.skillActEff
						skillHitEff = targetConfig.skillHitEff
					else
						BattleCore.ds("preloadRoleRes actId", actId)
						skillActEff = targetConfig["skillActEff"..actId]
						skillHitEff = targetConfig["skillHitEff"..actId]
					end
					targetListEff[skillActEff] = true
					--递归
					local aimKey = {
						"beeff",
						"hiteff",
						"shooteff"
					}
					-- LuaLogger.ds("preloadRoleRes skillHitEff", tablex.dump(skillHitEff))
					if skillHitEff then
						local effectResult = self:findAllKeyValues(skillHitEff, aimKey)
						-- LuaLogger.ds("preloadRoleRes effectResult", tablex.dump(effectResult))
						for effectId, _ in pairs(effectResult) do
							targetListEff[effectId] = true
						end
					end
				end
			end
		end
	end
	for effectId, _ in pairs(targetListEff) do
		if effectId ~= 0 then
			local effectConfig = Config.GetSoundAndEffectInfo(effectId)
			if effectConfig then
				self:preloadEff(effectConfig.effectResource)
			end
		end
	end
	targetListBullet["pd2"] = true
	for bulletName, _ in pairs(targetListBullet) do
		self:preloadBullet(bulletName)
	end
end

--根据角色ID和子弹模型列表，更改对应武器的子弹显示 预加载用
---@param heroId integer
---@param bulletList string[]
function BattleShowManager:changeBulletModelByWeapon(heroId, bulletList)
	local heroInfo = Me:getPlayerHero(heroId)
	if heroInfo then
		local weaponList = heroInfo.carryWeapon
		if weaponList and next(weaponList) then
			for i = #weaponList, 1, -1 do
				if weaponList[i] ~= 0 then
					local weaponInfo = Me:getWeaponDataById(weaponList[i])
					local weaponConfig = Config.GetWeaponInfo(weaponInfo.cid)
					if weaponConfig then
						local bulletModel = weaponConfig.bulletModel
						if bulletModel and next(bulletModel) then
							bulletList[bulletModel[1]] = bulletModel[2]
						end
					end
				end
			end
		end
	end
end

--- 寻找递归table中所有key == keys中任意一个值 的value集合
---@param tbl table
---@param keys string[]
---@param visited string[]
---@param result string[]
function BattleShowManager:findAllKeyValues(tbl, keys, visited, result)
    visited = visited or {}            -- 防止循环引用
    result = result or {}              -- 存储所有匹配的键值对
    
    -- 如果已经访问过这个 table，则跳过
    if visited[tbl] then
        return
    end
    visited[tbl] = true                -- 标记为已访问
    
    -- 遍历当前 table
    for key, value in pairs(tbl) do
        
        -- 检查当前 key 是否在目标 keys 列表中
        for _, targetKey in ipairs(keys) do
            if key == targetKey then
                result[value] = true
            end
        end
        
        -- 如果 value 是 table，则递归查找
        if type(value) == "table" then
            self:findAllKeyValues(value, keys, visited, result)
        end
    end
    
    return result
end

---加载战斗根节点
---@param levelConfig PveLevelTable
---@param callback function?
function BattleShowManager:loadBattleRoot(levelConfig, callback)
	self._allFinishCallBack = function ()
		if self.levelLoaded then
			if (callback) then
				callback()
			end
		end
	end
	self:preloadRes()
	self:setPreloadData(Config.PrefabPath.StartBattleCamPath)
	ResMgr:LoadGameObjectAsync(Config.PrefabPath.StartBattleCamPath, function(obj)
		self._enterBattlePathObj = obj
		-- self._enterBattlePathObj:SetActive(false)
		self._pathDollyCart = self._enterBattlePathObj.transform:Find("CMvcam1"):GetComponent("CinemachineDollyCart")
		self._enterBattleVcam = self._enterBattlePathObj.transform:Find("CMvcam1"):GetComponent(TypeInfo.CinemachineVirtualCamera)
		self._enterBattleVcam.Priority = 0
		self:checkPreload(Config.PrefabPath.StartBattleCamPath)
	end)
	-- UIMgr.baseCamera.gameObject:SetActive(false)
	self:setPreloadData(Config.PrefabPath.BattleRoot)
	self:setPreloadData(Config.PrefabPath.BattleMapCube)
	ResMgr:LoadGameObjectAsync(Config.PrefabPath.BattleRoot, function (obj)
		---@type UnityEngine.GameObject
		self.battleRoot = obj
		---@type UnityEngine.GameObject
		self.cameraRoot = self.battleRoot.Find("CameraRoot").gameObject
		self.cameraRotateRoot = self.battleRoot.Find("CameraRotateRoot").gameObject
		self.mainVcam = self.battleRoot.Find("MainVcam").gameObject
        self.cameraObj = self.battleRoot.Find("BattleCamera").gameObject
		self.camera = self.cameraObj:GetComponent("Camera")
		-- self.roleCamera = self.battleRoot.Find("RoleCamera").gameObject:GetComponent("Camera")
		self.cameraControl = self.cameraRoot:GetComponent("BattleCameraController")
		self.sceneEdgesLine = self.battleRoot.Find("EdgeLine").gameObject
		self.sceneEdgesWall = self.battleRoot.Find("EdgeWall").gameObject
		self._cinemachineBrain = self.cameraObj:GetComponent("CinemachineBrain")
		self._cinemachineImpulseSource = self.cameraObj:GetComponent("CinemachineImpulseSource")
		local CameraRenderCB = self.cameraObj:GetComponent("CameraRenderCB")
		CameraRenderCB.lateUpdateFunc = function ()
			self:FixedUpdate()
		end
		self:setMapAngle(levelConfig.MapAngle)
		self:activeCameraFollow(false)
		-- self._director = self.battleRoot.Find("Director").gameObject:GetComponent("PlayableDirector")
		-- self._timelineMgr = self.battleRoot.Find("Director").gameObject:GetComponent("TimeLineMgr")
        local mapRoot = self.battleRoot.Find("Map").transform
		UIMgr.SetBaseCamera(self.camera)
		self:RefreshCameraAngle()
		--设置血条相机RT
		-- if not self.roleCameraRT then
		-- 	--获取当前UICanvas的尺寸
		-- 	local canvasScaler = UIMgr.uiCanvas.gameObject:GetComponent("CanvasScaler")
		-- 	local rtWidth = canvasScaler.referenceResolution.x
		-- 	local rtHeight = canvasScaler.referenceResolution.y
		-- 	--创建RenderTexture
		-- 	self.roleCameraRT = UnityEngine.RenderTexture(rtWidth, rtHeight, 40)
		-- end
		-- self.roleCamera.targetTexture = self.roleCameraRT
		
		for i = 0, mapRoot.childCount - 1 do
			UnityEngine.GameObject.Destroy(mapRoot:GetChild(i).gameObject)
		end
		local battleMgr = BattleCore:getBattleMgr()
		local map = battleMgr:getMap()
		local blocks = map:getBlocks()
		mapRoot.localPosition = Vector3.New(map.offsetX, 0, map.offsetY)
		scaleIndex = map.ratio * scaleIndex
		self.cameraMoveBounds.xMin = map.minRows * scaleIndex
		self.cameraMoveBounds.yMin = map.minCols * scaleIndex
		self.cameraMoveBounds.xMax = (map.minRows + map.maxRows) * scaleIndex
		self.cameraMoveBounds.yMax = (map.minCols + map.maxCols) * scaleIndex
		-- print("loadBattleRoot blocks", #blocks)
		self:checkPreload(Config.PrefabPath.BattleRoot)
		ResMgr:LoadPrefabAsyncInOwner(Config.PrefabPath.BattleMapCube, function (cube)
			-- LuaLogger.ds("loadBattleRoot blocks", tablex.size(blocks))
			local edgesPos = {}
			for _, block in pairs(blocks) do
				local blockObj = Instantiate(cube).gameObject
				blockObj:SetParent(mapRoot)
				blockObj.transform.localPosition = Vector3.New(block.row * scaleIndex, mapCubeOffsetY, block.col * scaleIndex)
				blockObj.name = block.id
				blockObj.transform.localScale = Vector3.New(scaleIndex, scaleIndex, scaleIndex)
				self:_setBlockMat(blockObj, block.terrain)
				self.blocksObjMap[block.id] = blockObj
				self.blocksMap[blockObj] = block
			end

			self:initScreen()
			BattleCore.ds("inittest loadBattleRoot finish")
			self.levelLoaded = true
			self:checkPreload(nil)

			-- 画战场边缘线
			local offset = 1 * scaleIndex * 1.5
			local pointA = Vector3.New(self.cameraMoveBounds.xMin - offset, 0.5 + mapCubeOffsetY * 2, self.cameraMoveBounds.yMin - offset)
			local pointB = Vector3.New(self.cameraMoveBounds.xMin - offset, 0.5 + mapCubeOffsetY * 2, self.cameraMoveBounds.yMax - offset)
			local pointC = Vector3.New(self.cameraMoveBounds.xMax - offset, 0.5 + mapCubeOffsetY * 2, self.cameraMoveBounds.yMax - offset)
			local pointD = Vector3.New(self.cameraMoveBounds.xMax - offset, 0.5 + mapCubeOffsetY * 2, self.cameraMoveBounds.yMin - offset)
			table.insert(edgesPos, pointA)
			table.insert(edgesPos, pointB)
			table.insert(edgesPos, pointC)
			table.insert(edgesPos, pointD)
			local lineRenderer = self.sceneEdgesLine:GetComponent(TypeInfo.LineRenderer)
			lineRenderer.startWidth = 0.2
			lineRenderer.endWidth = 0.2
			lineRenderer.positionCount = 4
			lineRenderer.loop = true
			lineRenderer:SetPositions(edgesPos)

			local wallCtor = self.sceneEdgesWall:GetComponent("EdgeWallController")
			local wallOffset = Vector3.New(0, 0.1, -0.5)
			wallCtor:InitWall(2, map.maxCols * scaleIndex, (pointA + pointB) / 2 + wallOffset)
			wallCtor:InitWall(0, map.maxRows * scaleIndex, (pointB + pointC) / 2 + wallOffset)
			wallCtor:InitWall(3, map.maxCols * scaleIndex, (pointC + pointD) / 2 + wallOffset)
			wallCtor:InitWall(1, map.maxRows * scaleIndex, (pointD + pointA) / 2 + wallOffset)
			self:checkPreload(Config.PrefabPath.BattleMapCube)
		end, self.battleRoot.gameObject)
		self.sceneRootObj = UnityEngine.GameObject.Find("SceneRoot")
		self.backgroundObj = UnityEngine.GameObject.Find("BattleBackground")
		self.planarReflectionRendererObj = UnityEngine.GameObject.Find("BattleScenePlanarReflectionRenderer")
		self:initCoveScene()

		--加载场景特效
		if levelConfig.Mapeffect and next(levelConfig.Mapeffect) then
			for _, effectId in pairs(levelConfig.Mapeffect) do
				local effectConfig = Config.GetSoundAndEffectInfo(effectId)
				if effectConfig then
					local prefabPath = string.format(Config.PrefabPath.BattleEffect, effectConfig.effectResource, effectConfig.effectResource)
					PoolMgr:Get(prefabPath, function (obj)
						local effectObj = obj
						effectObj.transform:SetParent(self.cameraRoot.transform, false)
						effectObj.transform.localScale = Vector3.one 
						effectObj.name = effectConfig.effectResource
						table.insert(self._sceneEffectList,effectObj)
					end)

					if effectConfig.id == 2001 then
						--加载UI雾效
						PoolMgr:Get(Config.PrefabPath.BattleUIFogPrefab, function (obj)
							self._battleUIFog = obj
							self._battleUIFog.transform:SetParent(UIMgr.uiCanvas.transform, false)
							self._battleUIFog.transform.localScale = Vector3.one
							self._battleUIFog.name = "BattleUIFog"
							-- table.insert(self._sceneEffectList,uiFogObj)
						end)
					end
				end
			end
		end
	end)
	self:setRenderPipeline()
end

--- 初始化摄像机视角
---@param dotweenData table? dotween数据 {time = 1}
---@param CB function? 回调函数
function BattleShowManager:initScreen(dotweenData, CB)
	local battleMgr = BattleCore:getBattleMgr()
	local levelConfig = battleMgr:getLevelConfig()
	local blockId
	if (levelConfig.screen_init and levelConfig.screen_init ~= 0) then
		blockId = battleMgr:getMap():blockCidToId(levelConfig.screen_init)
	else
		blockId = battleMgr:getMap():blockCidToId(levelConfig.CentralPosition)
	end
	self:lookAtBlock(blockId, dotweenData, CB)
	self:refreshViewDistanceByFinalValue(self.cameraViewDistance, false, 0)
end

function BattleShowManager:setRenderPipeline()
	-- PoolMgr:Get(string.format(Config.PrefabPath.RenderPipelineSetup) , function (modelObj)
	-- 	self._renderMgr = modelObj.transform:GetComponent("JLRenderPipelineManager")
	-- 	self._renderMgr:SetPlanarShadowPlaneY(0.5)
	-- end)
end

---@param blockId integer? 地格ID
function BattleShowManager:refreshSelectedCube(blockId)
	if (self._selectedCube) then
		PoolMgr.Free(self._selectedCube)
		self._selectedCube = nil
	end
	if (blockId) then
		PoolMgr:Get(Config.PrefabPath.SelectedArea, function (obj)
			local areaObj = obj
			local blockObj = self:getBlockObj(blockId)
			areaObj.transform.position = blockObj.transform.position
			areaObj:SetActive(true)
			self._selectedCube = areaObj
		end)
	end
end

function BattleShowManager:refreshFormationRange(list)
	-- print("inittest refreshFormationRange", tablex.dump(list))
	for _, blockId in ipairs(list) do
		--如果布阵格子上有剧情角色，则清除剧情角色
		if self._storyRoleBlockIdList[blockId] then
			self:roleRemove({id = self._storyRoleBlockIdList[blockId]}, nil)
			-- self.rolesMap[self._storyRoleBlockIdList[blockId]] = nil
			self._storyRoleBlockIdList[blockId] = nil
		end
		PoolMgr:Get(Config.PrefabPath.FormationArea, function (obj)
			local areaObj = obj
			local blockObj = self:getBlockObj(blockId)
			areaObj.transform.position = blockObj.transform.position
			areaObj:SetActive(true)
			table.insert(self._formationRangeList, areaObj)
			self:lookAtBlock(blockId)
		end)
	end
	self._formationRangeIdList = list
end

function BattleShowManager:removeFormationRange()
	self:_freeObjects(self._formationRangeList)
	self._formationRangeList = {}
end

function BattleShowManager:formationRangeSetActive(bool)
	for _, obj in pairs(self._formationRangeList) do
		obj:SetActive(bool)
	end
end

function BattleShowManager:refreshMoveRange(list, isActive, cancelAnim)
	self:clearActionAreaTimer()
	for _, blockData in ipairs(list) do
		self:_createAreaObj(Config.PrefabPath.MoveArea, blockData, self._moveRangeList, self._actionAreaTimer, isActive, cancelAnim)
	end
end

function BattleShowManager:removeMoveRange()
	self:_freeAreaObjectList(self._moveRangeList)
	self._moveRangeList = {}

	self:removeChooseRange()
end

---@param chooseRangelist BlockData[]
---@param moveRangeList table<integer,BlockData>
---@param isActive boolean?
---@param cancelAnim boolean?
function BattleShowManager:refreshChooseRange(chooseRangelist, moveRangeList, isActive, cancelAnim)
	-- self:clearActionAreaTimer(false)
	for _, blockData in ipairs(chooseRangelist) do
		-- if (not tablex.contains(moveRangeList, blockId)) then
		if moveRangeList[blockData.blockId] == nil then
			self:_createAreaObj(Config.PrefabPath.ChooseArea, blockData, self._chooseRangeList, self._actionAreaTimer, isActive, cancelAnim)
		end
	end
end

function BattleShowManager:removeChooseRange()
	self:_freeAreaObjectList(self._chooseRangeList)
	self._chooseRangeList = {}

	self:clearActionAreaTimer()
end

---刷新技能一次扩散范围
---@param list BlockData[]
---@param skillConfig SkillTable
function BattleShowManager:refreshSkillRange(list, skillConfig, isActive, cancelAnim)
	local prefabPath = nil
	if skillConfig.skillOperateType == GE.SkillOperateType.Direction then
		prefabPath = Config.PrefabPath.SkillArrowArea
	else
		prefabPath = skillConfig.skillType == GE.SkillType.Normal
			and Config.PrefabPath.ChooseArea or Config.PrefabPath.SkillArea2
	end
	self:removeSkillRange()
	for _, blockData in ipairs(list) do
		self:_createAreaObj(prefabPath, blockData, self._skillRangeList, self._actionAreaTimer, isActive, cancelAnim)
	end
end

---刷新技能二次扩散范围
---@param list BlockData[]
---@param skillConfig SkillTable
function BattleShowManager:refreshSkillEffectRange(list, skillConfig, isActive, cancelAnim, role)
	---根据技能目标类型决定预制体
	local skillType = skillConfig.effectSoldierType
	local prefabPath = Config.PrefabPath.SkillArea
	if skillType == GE.SkillEffectTargetType.Enemy or skillType == GE.SkillEffectTargetType.Block then
		prefabPath = Config.PrefabPath.ChooseArea
	elseif skillType == GE.SkillEffectTargetType.RangeAllTarget then
		prefabPath = Config.PrefabPath.SkillArea2
	end
	self:removeSkillRange()
	local largestLap = 0
	for _, blockData in ipairs(list) do
		largestLap = math.max(largestLap, blockData.lap)
		self:_createAreaObj(prefabPath, blockData, self._skillRangeList, self._actionAreaTimer, isActive, cancelAnim)
	end
	self:clearSkillEffectRangeTimer()
	self.skillEffectRangeTimer = self:_DoAfter(0.04 * largestLap, function()
		self:removeTargetEffect()
		-- local targetList = role:getSkillTarget()
		local targetList = role:getCurSkillTarget()
		-- LuaLogger.ds("refreshSkillEffectRange targetList", tablex.dump(targetList))
		for _, block in pairs(targetList) do
			local camp
			local role = block:tryGetRole()
			if role then
				camp = role.camp
			end
			self:showTargetEffectedEffect({
				blockId = block.id,
				camp = camp
			})
		end
	end)
end

--清除技能二次扩散范围格子timer
function BattleShowManager:clearSkillEffectRangeTimer()
	if self.skillEffectRangeTimer then
		DLuaTimer:RemoveTimer(self.skillEffectRangeTimer)
		self.skillEffectRangeTimer = nil
	end
end

function BattleShowManager:removeSkillRange()
	self:_freeAreaObjectList(self._skillRangeList)
	self._skillRangeList = {}

	self:clearActionAreaTimer()
end

---刷新危险范围
---@param blockDataList BlockData[]
function BattleShowManager:refreshDangerRange(blockDataList)
	---@type table<integer,EdgeBlockData>
	local edgeBlocks = self:findEdgeBlocks(blockDataList)
	self:clearActionAreaTimer()
	for _, edgeBlockData in ipairs(edgeBlocks) do
		self:_createEdgeAreaObj(Config.PrefabPath.EdgeArea, edgeBlockData, self._dangerRangeList, self._actionAreaTimer, true, true)
	end
end

---@class PrepareSkillReportData
---@field roleId integer
---@field blockDataList table<integer,BlockData>
---@field delay number?

---@param reportData PrepareSkillReportData
---@param callback function?
function BattleShowManager:showPrepareSkillRangeByReport(reportData, callback)
	local roleId = reportData.roleId
	local blockDataList = reportData.blockDataList
	self:refreshPrepareSkillRange(roleId, blockDataList)
	if (callback) then
		callback()
	end
end

---@param reportData PrepareSkillReportData
---@param callback function?
function BattleShowManager:removePrepareSkillRangeByReport(reportData, callback)
	local roleId = reportData.roleId
	self:removePrepareSkillRange(roleId)
	if (callback) then
		callback()
	end
end

---刷新准备类技能的范围
---@param roleId integer 技能释放角色id
---@param blockDataList table<integer,BlockData>
---@param targetRoleId integer? 目标角色id
function BattleShowManager:refreshPrepareSkillRange(roleId, blockDataList, targetRoleId)
	BattleCore.ds("refreshPrepareSkillRange", roleId, targetRoleId)
	self:removePrepareSkillRange(roleId)
	self._prepareSkillRangeList[roleId] = {
		blockObjList = {},
		targetRoleId = targetRoleId
	}
	local blockObjList = self._prepareSkillRangeList[roleId].blockObjList
	self:clearActionAreaTimer(false)
	for _, blockData in ipairs(blockDataList) do
		PoolMgr:Get(Config.PrefabPath.PrepareSkillArea, function (obj)
			local areaObj = obj
			local blockObj = self:getBlockObj(blockData.blockId)
			areaObj.transform.position = blockObj.transform.position
			areaObj:SetActive(true)
			table.insert(blockObjList, areaObj)
		end)
	end
	--选中箭头
	if targetRoleId then
		self:setRoleFollowArrowActive(targetRoleId, true)
	end
end

function BattleShowManager:setRoleFollowArrowActive(roleId, bool)
	local role = self:getRole(roleId)
	if role and role.controller then
		local selectedArrow = role.controller.gameObject.transform:Find("JianTou")
		selectedArrow.gameObject:SetActive(bool)
	end
end

--重置准备类技能表现
--@param roleId integer 技能释放角色id
function BattleShowManager:removePrepareSkillRange(roleId)
	if self._prepareSkillRangeList[roleId] then
		--清空准备类技能地格
		local blockObjList = self._prepareSkillRangeList[roleId].blockObjList
		local targetRoleId = self._prepareSkillRangeList[roleId].targetRoleId
		for _, obj in pairs(blockObjList) do
			PoolMgr.Free(obj)
		end
		--重置角色身上跟踪箭头 如果还被其他角色锁定 则不重置箭头
		local isRepeat = false
		for k, v in pairs(self._prepareSkillRangeList) do
			if k ~= roleId and targetRoleId == v.targetRoleId then
				isRepeat = true
				break
			end
		end
		self._prepareSkillRangeList[roleId] = nil
		if targetRoleId and not isRepeat then
			self:setRoleFollowArrowActive(targetRoleId, false)
		end
	end
end

function BattleShowManager:clearAllPrepareSkillRange()
	if next(self._prepareSkillRangeList) then
		for _, v in pairs(self._prepareSkillRangeList) do
			for _, Obj in pairs(v.blockObjList) do
				PoolMgr.Free(Obj)
			end
			self:setRoleFollowArrowActive(v.targetRoleId, false)
		end
		self._prepareSkillRangeList = {}
	end
end

--设置所有准备技能相关显隐
function BattleShowManager:allPrepareSkillRangeSetActive(bool)
	if next(self._prepareSkillRangeList) then
		for _, v in pairs(self._prepareSkillRangeList) do
			for _, Obj in pairs(v.blockObjList) do
				Obj:SetActive(bool)
			end
			self:setRoleFollowArrowActive(v.targetRoleId, bool)
		end
	end
end

---@class EdgeBlockData
---@field blockId integer 格子ID
---@field lap integer 圈层
---@field image integer 贴图序号
---@field direction integer 旋转角度

---找出边缘格子
---@param blockDataList table<integer,BlockData>
---@return table<integer,EdgeBlockData>
---将格子检测边线及补角的结果通过toBitValue函数转换为方向编码，然后按照优先级匹配规则进行分类
---最终返回的列表中包含了所有边缘格子的信息，包括格子ID、贴图序号、旋转角度
function BattleShowManager:findEdgeBlocks(blockDataList)
	local edgeBlocks = {}
	local battleMgr = BattleCore:getBattleMgr()
	local blockDataMap = {}
	
	-- 预处理块数据，填充坐标并建立快速查找表
	for _, v in ipairs(blockDataList) do
		local block = battleMgr:getBlockById(v.blockId)
		v.col, v.row = block.col, block.row
		blockDataMap[string.format("%d_%d", v.col, v.row)] = v
	end

	-- 方向编码转换辅助函数
	local function toBitValue(arr)
		return arr[1] * 8 + arr[2] * 4 + arr[3] * 2 + arr[4]
	end

	-- 预定义匹配规则（按优先级排序）
	local MATCH_RULES = {
		-- 衔接块（无边线无补角）
		{
			check = function(lineVal, cornerVal)
				return lineVal == 0 and cornerVal == 0
			end,
			build = function() return {image=0, direction=0} end
		},
		-- 单边类型
		{
			---@class LineConfig
			---@field integer image 图片序号
			---@field integer direction 旋转角度
			check = function(lineVal)
				---@type table<integer,LineConfig>
				local configs = {
					[0]   = {5, 0},   -- 全空
					[8]   = {4, 90},  -- 上
					[4]   = {4, 180}, -- 右
					[2]   = {4, -90}, -- 下
					[1]   = {4, 0},   -- 左
					[10]  = {3, 0},   -- 上下
					[5]   = {3, 90}   -- 左右
				}
				return configs[lineVal]
			end
		},
		-- 转角边类型（需要检查对角）
		{
			---@class CornerConfig
			---@field [1] integer 边线方向编码
			---@field [2] integer 对角位置序号
			---@field [3] integer 带补角的图片序号
			---@field [4] integer 边线对应的图片序号
			---@field integer 旋转角度
			check = function(lineVal, cornerVal, lineArr, cornerArr)
				---@type CornerConfig[]
				local cornerConfigs = {
					{12, 1, 14, 2, 90},   -- 上右（检查右上）
					{9,  2, 14, 2, 0},    -- 上左（检查左上）
					{3,  3, 14, 2, -90},  -- 下右（检查左下）
					{6,  4, 14, 2, 180}   -- 下左（检查右下）
				}
				for _, cfg in ipairs(cornerConfigs) do
					if lineVal == cfg[1] then
						local img = cornerArr[cfg[2]] == 0 and cfg[3] or cfg[4]
						return {img, cfg[5]}
					end
				end
			end
		},
		-- 单边补角类型（需要检查两个对角）
		{
			---@class SingleConfig
			---@field [1] integer 边线方向编码
			---@field [2] table<integer,integer> 对角位置序号
			---@field [3] table<integer,integer,integer,integer> 图片序号
			---@field integer 旋转角度
			check = function(lineVal, cornerVal, lineArr, cornerArr)
				---@type table<SingleConfig>
				local singleConfigs = {
					{14, {4,1}, {13, 12, 11, 1}, 180}, -- 下
					{13, {2,1}, {13, 12, 11, 1}, 90},  -- 左
					{11, {3,2}, {13, 12, 11, 1}, 0},   -- 上
					{7,  {4,3}, {13, 12, 11, 1}, -90}  -- 右
				}
				for _, cfg in ipairs(singleConfigs) do
					if lineVal == cfg[1] then
						local c1, c2 = cornerArr[cfg[2][1]], cornerArr[cfg[2][2]]
						-- if c1 == 0 and c2 == 0 then
						-- 	return {cfg[3][1], cfg[4]}
						-- elseif c1 == 0 then
						-- 	return {cfg[3][2], cfg[4]}
						-- elseif c2 == 0 then
						-- 	return {cfg[3][3], cfg[4]}
						-- else
						-- 	return {cfg[3][4], cfg[4]}
						-- end
						local key = (c1 == 0 and 0 or 2) + (c2 == 0 and 0 or 1) + 1
						return {cfg[3][key] or cfg[3][4], cfg[4]}
					end
				end
			end
		},
		-- 补角类型（纯补角）
		{
			---@class CornerConfig
			---@field [1] integer 对角位置序号
			---@field [2] integer 图片序号
			---@field [3] integer 旋转角度
			check = function(_, cornerVal)
				---@type table<integer,CornerConfig>
				local configs = {
					[15] = {0,0}, [0] = {10,0}, [8] = {9,90}, [4] = {9,180},
					[2] = {9,-90}, [1] = {9,0}, [12] = {7,90}, [10] = {8,0},
					[9] = {7,180}, [6] = {7,0}, [5] = {8,90}, [3] = {7,-90},
					[14] = {6,0}, [13] = {6,90}, [11] = {6,180}, [7] = {6,-90}
				}
				return configs[cornerVal]
			end
		}
	}

	-- 主处理逻辑
	for _, v in pairs(blockDataMap) do
		-- 获取相邻信息
		local line = {
			blockDataMap[string.format("%d_%d", v.col, v.row+1)] and 1 or 0,  -- 上
			blockDataMap[string.format("%d_%d", v.col+1, v.row)] and 1 or 0,  -- 右
			blockDataMap[string.format("%d_%d", v.col, v.row-1)] and 1 or 0,  -- 下
			blockDataMap[string.format("%d_%d", v.col-1, v.row)] and 1 or 0   -- 左
		}
		local corner = {
			blockDataMap[string.format("%d_%d", v.col+1, v.row+1)] and 1 or 0, -- 右上
			blockDataMap[string.format("%d_%d", v.col-1, v.row+1)] and 1 or 0, -- 左上
			blockDataMap[string.format("%d_%d", v.col-1, v.row-1)] and 1 or 0, -- 左下
			blockDataMap[string.format("%d_%d", v.col+1, v.row-1)] and 1 or 0  -- 右下
		}

		-- 计算特征值
		local lineVal = toBitValue(line)
		local cornerVal = toBitValue(corner)

		-- 按优先级匹配规则
		for _, rule in ipairs(MATCH_RULES) do
			local result = rule.check(lineVal, cornerVal, line, corner)
			if result then
				table.insert(edgeBlocks, {
					blockId = v.blockId,
					lap = v.lap,
					image = result[1],
					direction = result[2]
				})
				break
			end
		end
	end

	return edgeBlocks
end

function BattleShowManager:removeDangerRange()
	self:_freeAreaObjectList(self._dangerRangeList)
	self._dangerRangeList = {}
	self:clearActionAreaTimer()
end

---@param notStopTimer boolean? 是否需要停止计时器
function BattleShowManager:clearActionAreaTimer(notStopTimer)
	if self._actionAreaTimer and notStopTimer ~= false then
		for _, timer in ipairs(self._actionAreaTimer) do
			-- if timer.OnComp then
			-- 	timer:OnComp()
			-- end
			DLuaTimer:RemoveTimer(timer)
		end
	end
	self._actionAreaTimer = {}
end

---刷新地块标签
---@param list table<integer,BlockTagData>
function BattleShowManager:refreshBlockTag(list)
	for _, blockTagData in ipairs(list) do
		local tagImg = blockTagData[1]
		local blockCidList = blockTagData[2]
		for _, blockCid in ipairs(blockCidList) do
			if (not tagImg) then
				break
			end
			local blockId = BattleCore:getBattleMgr():getMap():blockCidToId(blockCid)
			self:loadBlockTag(blockId, tagImg)
		end
	end
	self._formationRangeIdList = list
end

---加载地块标签
---@param blockId integer --地块ID
---@param tagImg integer --标签图片
function BattleShowManager:loadBlockTag(blockId, tagImg)
	--加载标签预制体
	PoolMgr:Get(Config.PrefabPath.BattleBlockTag, function (tagObj)
		tagObj:SetActive(false)
		ResMgr:LoadSpriteAsyncInOwner(string.format(Config.SpritePath.BattleBlockTagPath, tagImg), function (sprite)
			if sprite then
				UICommonUtils.BlockTag_SetBlockIcon(tagObj, sprite)
				local uiroot = UIMgr:GetUIRootParent()
				tagObj.transform:SetParent(uiroot.transform, false)
				self._blockTagList[blockId] = tagObj
			end
		end, tagObj)
	end)
end

---移除地块标签
function BattleShowManager:removeBlockTag()
	self:_freeObjects(self._blockTagList)
	self._blockTagList = {}
end

---@param objList AreaObject[]
function BattleShowManager:_freeAreaObjectList(objList)
	self._waitShowRangeList[objList] = nil
	for _, obj in ipairs(objList) do
		self:setAreaObjectActive(obj, false)
		PoolMgr.FreeWithOutSetActive(obj.AreaObj)
	end
end

---@class AreaObject
---@field AreaObj UnityEngine.GameObject
---@field MianMaterial UnityEngine.Material
---@field ChildMaterial UnityEngine.Material

---@param path string
---@param blockData BlockData
---@param objList AreaObject[]
---@param timerList DTimer.TimerInfo[]
function BattleShowManager:_createAreaObj(path, blockData, objList, timerList, isActive, cancelAnim)
	if not self._waitShowRangeList[objList] then
		self._waitShowRangeList[objList] = {}
	end
	self._waitShowRangeList[objList][blockData.blockId] = true
    PoolMgr:Get(path, function(obj)
		if timerList == nil or not self._waitShowRangeList[objList] or not self._waitShowRangeList[objList][blockData.blockId] then
			PoolMgr.FreeWithOutSetActive(obj)
			return
		end
		local isShowBlock = isActive
        ---@type UnityEngine.GameObject
        local areaObj = obj
        local blockObj = self:getBlockObj(blockData.blockId)
        areaObj.transform.position = blockObj.transform.position
		---@type UnityEngine.Material
		local mat1
		---@type UnityEngine.Renderer
		local render1 = areaObj:GetComponent("Renderer")
		if render1 then
			mat1 = render1.material
		end
		---@type UnityEngine.Transform
		local childTrans = areaObj.transform:GetChild(0)
		local mat2
		if childTrans then
			---@type UnityEngine.Renderer
			local rander = childTrans:GetComponent("Renderer")
			if rander then
				mat2 = rander.material
			end
		end
		---@type AreaObject
		local areaObjData = {
			AreaObj = obj,
			MianMaterial = mat1,
			ChildMaterial = mat2,
		}
        objList[#objList + 1] = areaObjData
		local dir = blockData.direction
		if dir then
			local y = dirBlockRotate[dir]
			childTrans.localRotation = Quaternion.Euler(90, y, 0)
		end
        if (not cancelAnim) then
			self:setAreaObjectActive(areaObjData, false)
			local timer = self:_DoAfter(0.04 * blockData.lap, function()
				self:setAreaObjectActive(areaObjData, true)
				self._waitShowRangeList[objList][blockData.blockId] = nil
			end)
            if (timer ~= nil) then
                table.insert(timerList, timer)
            end
		else
			self:setAreaObjectActive(areaObjData, isShowBlock)
			self._waitShowRangeList[objList][blockData.blockId] = nil
        end
    end)
end

function BattleShowManager:_createAreaObjByList(path, blockList, objList, timerList, isActive, cancelAnim)
	local loadNum = 0
	local maxNum = tablex.size(blockList)
	local list = {}
	local loadFinish = function(lap)
		if (loadNum >= maxNum and #list > 0) then
			if (not cancelAnim) then
				for _, data in ipairs(list) do
					self:setAreaObjectActive(data, false)
				end
				local timer = self:_DoAfter(0.04 * lap, function()
					for _, data in ipairs(list) do
						self:setAreaObjectActive(data, true)
					end
				end)
				if (timer ~= nil) then
					table.insert(timerList, timer)
				end
			else
				for _, data in ipairs(list) do
					self:setAreaObjectActive(data, true)
				end
			end
		end
	end
	for _, blockData in ipairs(blockList) do
		self:_loadAreaObj(path, blockData, objList, isActive, function(areaObjData)
			loadNum = loadNum + 1
			table.insert(list, areaObjData)
			loadFinish(blockData.lap)
		end)
	end
end

function BattleShowManager:_loadAreaObj(path, blockData, objList, isActive, callback)
	PoolMgr:Get(path, function(obj)
        ---@type UnityEngine.GameObject
        local areaObj = obj
        local blockObj = self:getBlockObj(blockData.blockId)
        areaObj.transform.position = blockObj.transform.position
		---@type UnityEngine.Material
		local mat1 = areaObj:GetComponent("Renderer").material
		---@type UnityEngine.Material
		local mat2 = areaObj.transform:GetChild(0):GetComponent("Renderer").material
		---@type AreaObject
		local areaObjData = {
			AreaObj = obj,
			MianMaterial = mat1,
			ChildMaterial = mat2,
		}
        objList[#objList + 1] = areaObjData
        -- table.insert(objList, areaObj)

        if (isActive) then
            mat1:SetColor("_BaseColor", activeColor)
        else
            mat1:SetColor("_BaseColor", halfAlphaColor)
        end

		if (callback) then
			callback(areaObjData)
		end
    end)
end

---@param obj AreaObject
---@param isActive boolean
function BattleShowManager:setAreaObjectActive(obj, isActive)
	local c = isActive == true and activeColor or unactiveColor
	if obj.MianMaterial then
		obj.MianMaterial:SetColor("_BaseColor", c)
	end
	if obj.ChildMaterial then
		obj.ChildMaterial:SetColor("_BaseColor", c)
	end
end

---创建边缘区域
---@param path string
---@param edgeBlockData EdgeBlockData
---@param objList AreaObject[]
---@param timerList table<integer,DLuaTimer>
---@param isActive boolean
---@param cancelAnim boolean
function BattleShowManager:_createEdgeAreaObj(path, edgeBlockData, objList, timerList, isActive, cancelAnim)
	if self._waitShowRangeList[objList] == nil then
		self._waitShowRangeList[objList] = {}
	end
	self._waitShowRangeList[objList][edgeBlockData.blockId] = true
	PoolMgr:Get(path, function(obj)
		if timerList == nil or not self._waitShowRangeList[objList] or not self._waitShowRangeList[objList][edgeBlockData.blockId] then
			PoolMgr.FreeWithOutSetActive(obj)
			return
		end
		---@type UnityEngine.GameObject
		local areaObj = obj
		local isShowBlock = isActive

		-- 显示边缘线
		---@type EdgeAreaController
		local edgeCtor = areaObj.transform:GetComponent("EdgeAreaController")
		edgeCtor.quadRenderer.material.mainTexture = edgeCtor.edgeTextures[edgeBlockData.image]
		edgeCtor.quadRenderer.transform.localRotation = Quaternion.Euler(90, 0, edgeBlockData.direction)

		local blockObj = self:getBlockObj(edgeBlockData.blockId)
		areaObj.transform.position = blockObj.transform.position
		---@type UnityEngine.Material
		local mat1 = areaObj:GetComponent("Renderer").material
		---@type UnityEngine.Material
		local mat2 = areaObj.transform:GetChild(0):GetComponent("Renderer").material
		---@type AreaObject
		local areaObjData = {
			AreaObj = obj,
			MianMaterial = mat1,
			ChildMaterial = mat2,
		}
		objList[#objList + 1] = areaObjData

		if (not cancelAnim) then
			self:setAreaObjectActive(areaObjData, false)
			local timer = self:_DoAfter(0.04 * edgeBlockData.lap, function()
				self:setAreaObjectActive(areaObjData, true)
				self._waitShowRangeList[objList][edgeBlockData.blockId] = nil
			end)
			if (timer ~= nil) then
				table.insert(timerList, timer)
			end
		else
			self:setAreaObjectActive(areaObjData, isShowBlock)
			self._waitShowRangeList[objList][edgeBlockData.blockId] = nil
		end
	end)
end

---创建瞄准线
function BattleShowManager:createAimLine(roleId, targetId)
	BattleCore.ds("BattleShowManager:createAimLine", roleId, targetId)
	local role = self:getRole(roleId)
	local targetRole = self:getRole(targetId)
	if (role and targetRole) then
        PoolMgr:Get(Config.PrefabPath.AimLine, function(lineObj)
            ---@type SkillArrowLine
            local lineCtr = lineObj.transform:GetComponent("SkillArrowLine")
            local offsetV3 = Vector3.New(0, 1.4, 0)
            lineCtr:ShowArrowLine(role.root.transform.position + offsetV3, targetRole.root.transform.position + offsetV3)
            table.insert(self._aimLineList, lineObj)
            -- local timer = self:_DoAfter(0.04 * blockData.lap, function()
            -- 	areaObj:SetActive(true)
            -- end)
            -- if (timer ~= nil) then
            -- 	table.insert(self._actionAreaTimer, timer)
            -- end
        end)
	end
end

---移除所有瞄准线
function BattleShowManager:removeAllAimLine()
	self:_freeObjects(self._aimLineList)
	self._aimLineList = {}
end

---创建鱼雷阻拦线
function BattleShowManager:createTorpedoLine(startBlockId, endBlockId)
	local block1 = self:getBlockObj(startBlockId)
	local block2 = self:getBlockObj(endBlockId)
	if block1 ~= nil and block2 ~= nil then
		PoolMgr:Get(Config.PrefabPath.AimLine, function (lineObj)
            ---@type SkillArrowLine
			local lineCtr = lineObj.transform:GetComponent("SkillArrowLine")
			local offsetV3 = Vector3.New(0, 2, 0)
            lineCtr:ShowArrowLine(block1.transform.position + offsetV3, block2.transform.position + offsetV3)
			table.insert(self._calculateLineList, lineObj)
		end)
	end
end

---移除所有瞄准线
function BattleShowManager:removeAllTorpedoLine()
	self:_freeObjects(self._calculateLineList)
	self._calculateLineList = {}
end

---@class ShowManagerHeroData
---@field root UnityEngine.GameObject
---@field controller RoleController
---@field model RoleModelController
---@field rootPoint UnityEngine.Transform
---@field speakPoint UnityEngine.Transform
---@field progressiveMesh ProgressiveMeshRuntime
---@field roleId integer
---@field hpObj UnityEngine.GameObject
---@field SkillIconObj UnityEngine.GameObject
---@field buffToeffectObj table<integer,UnityEngine.GameObject>
---@field buffToOffset table<integer,integer>
---@field hpBarOffset number
---@field skillTypeIconOffset number
---@field moveShowType integer

---角色击毁
---@param data DefateReportData
---@param callback function
function BattleShowManager:showDefeat(data, callback)
	BattleCore.ds("BattleShowManager:showDefeat", tablex.dump(data))
	local role = self:getRole(data.id)
	-- PoolMgr.Free(role.spine.gameObject)
	-- PoolMgr.Free(role.shadowProjector)
	local model = role.model
	model:PlayAnim(RoleModelAnimEnum["Die"])
	local audioData = data.audioData
	if audioData and data.skinConfig then
		self:PlayBattleAudio(data.skinConfig, audioData, data.roleName)
	end
	local effectId = data.skinConfig and data.skinConfig.dieEff or 1000
	-- self:_DoAfter(0.5, function()
		self:playEffect(model.transform.position, effectId)
		if (callback) then
			callback()
		end
	-- end)
end

---角色位置重置
---@param roleId integer 角色id
function BattleShowManager:roleResetPosition(roleId)
	local battleMgr = BattleCore:getBattleMgr()
	if battleMgr:isVerifyMode() then
		return
	end
	local role = self:getRole(roleId)
	role.root.transform.position = role.block.obj.transform.position
end

---设置镜头目标组
---@param roleId integer 攻击角色id
---@param targetList table<integer> 目标id列表
function BattleShowManager:setCMTargetGroup(roleId, targetList)
	local role = self:getRole(roleId)
	if (role and role.controller) then
		self:hideOtherRoleByIdList(targetList)
		role.controller.cmTargetGroup.m_Targets = {}
		-- local isSelf = true
		for _, targetId in ipairs(targetList) do
			local target = self:getRole(targetId)
			if target then
				--敌方权重
				if (targetId ~= roleId) then
					role.controller.cmTargetGroup:AddMember(target.model.transform, 1, 1)
				--攻击者权重
				else
					role.controller.cmTargetGroup:AddMember(target.model.transform, 1, 1)
				end
			end
			-- if (targetId ~= roleId) then
			-- 	isSelf = false
			-- end
		end
		-- if (isSelf) then
		-- 	role.controller.attackVcam.gameObject.transform.localRotation = Quaternion.Euler(12, role.model.transform.localRotation.eulerAngles.y -135, 0)
		-- else
			-- role.controller.attackVcam.gameObject.transform.localRotation = Quaternion.Euler(12, role.model.transform.localRotation.eulerAngles.y -30, 0)
		-- end
	end
end

--隐藏遮挡物
---@param posList table<UnityEngine.Vector3> 位置列表（支持任意数量点）
---@param isHide boolean 是否隐藏
function BattleShowManager:hideRaycastObstruction(posList, isHide, roleIdList)
    if not isHide then
        -- 恢复所有隐藏的物体
        for _, obj in pairs(self._hiddenObstructionList) do
            if UICommonUtils.Checkobj(obj) then
                obj:SetActive(true)
            end
        end
        self._hiddenObstructionList = {}
        return
    end
	local modelObjList = {}
    for _, roleId in pairs(roleIdList) do
		local modelObj = self:getRole(roleId).modelObj
		table.insert(modelObjList, modelObj)
	end
    
    -- 1. 根据所有点计算包围盒的最小值和最大值
    local min = Vector3.New(posList[1].x, posList[1].y, posList[1].z)
    local max = Vector3.New(posList[1].x, posList[1].y, posList[1].z)
    
    for i = 2, #posList do
        local p = posList[i]
        min.x = math.min(min.x, p.x)
        min.y = math.min(min.y, p.y)
        min.z = math.min(min.z, p.z)
        
        max.x = math.max(max.x, p.x)
        max.y = math.max(max.y, p.y)
        max.z = math.max(max.z, p.z)
    end
    
    -- 防止盒子厚度为0（如果所有点在同一平面上）
    local minThickness = 0.1
    if math.abs(max.x - min.x) < 0.001 then
        min.x = min.x - minThickness
        max.x = max.x + minThickness
    end
    if math.abs(max.y - min.y) < 0.001 then
        min.y = min.y - minThickness
        max.y = max.y + minThickness
    end
    if math.abs(max.z - min.z) < 0.001 then
        min.z = min.z - minThickness
        max.z = max.z + minThickness
    end
    max.y = max.y + 1	-- 向上扩展一些高度，确保能检测到角色头顶的遮挡物
	max.x = max.x + 0.25	-- 向左右扩展一些宽度，确保能检测到角色两侧的遮挡物
	min.x = min.x - 0.25
	max.z = max.z + 0.25		
	min.z = min.z - 0.25
    local center = (min + max) / 2
    local size = max - min
    local halfExtents = size / 2
    
    -- 2. 可视化碰撞体（编辑器模式）
    if GV.IsEditor then
        -- 绘制包围盒的12条边
        local function DrawLine(x1, y1, z1, x2, y2, z2)
            UnityEngine.Debug.DrawLine(
                Vector3.New(x1, y1, z1),
                Vector3.New(x2, y2, z2),
                Color.green, 15
            )
        end
        
        -- 下面四条边
        DrawLine(min.x, min.y, min.z, max.x, min.y, min.z)
        DrawLine(max.x, min.y, min.z, max.x, min.y, max.z)
        DrawLine(max.x, min.y, max.z, min.x, min.y, max.z)
        DrawLine(min.x, min.y, max.z, min.x, min.y, min.z)
        
        -- 上面四条边
        DrawLine(min.x, max.y, min.z, max.x, max.y, min.z)
        DrawLine(max.x, max.y, min.z, max.x, max.y, max.z)
        DrawLine(max.x, max.y, max.z, min.x, max.y, max.z)
        DrawLine(min.x, max.y, max.z, min.x, max.y, min.z)
        
        -- 垂直四条边
        DrawLine(min.x, min.y, min.z, min.x, max.y, min.z)
        DrawLine(max.x, min.y, min.z, max.x, max.y, min.z)
        DrawLine(max.x, min.y, max.z, max.x, max.y, max.z)
        DrawLine(min.x, min.y, max.z, min.x, max.y, max.z)
        
        -- 绘制所有输入点
        for i = 1, #posList do
            UnityEngine.Debug.DrawRay(posList[i], Vector3.up * 2.5, Color.red, 15)
        end
    end
    
    -- 3. 用 BoxCastAll 移动 0.1 来检测范围内的物体
    local hits = UnityEngine.Physics.BoxCastAll(
        center,                     -- 起点
        halfExtents,                -- 盒子半边长
        Vector3.up,                 -- 方向（随便，因为距离很短）
        Quaternion.identity,        -- 旋转
        0.1,                        -- 移动距离 0.1
        LayerMask.GetMask("Default", "SceneOutlined", "SceneOutlined2", "SceneOutlined3")
    )
    
    -- 4. 处理检测结果
    if hits and hits.Length > 0 then
        for i = 0, hits.Length - 1 do
            local hit = hits[i]
            local hitObj = hit.collider.gameObject
            
            -- 跳过角色自身
            if not self:IsChildOf(hitObj, modelObjList) then
                BattleCore.ds("命中遮挡物", hitObj.name)
                hitObj:SetActive(false)
                table.insert(self._hiddenObstructionList, hitObj)
            end
        end
    end
end

-- 辅助方法：判断是否是指定物体的子物体
function BattleShowManager:IsChildOf(child, parentList)
    local current = child.transform
    while current ~= nil do
        for _, parent in ipairs(parentList) do
            if current.gameObject == parent then
                return true
            end
        end
        current = current.parent
    end
    return false
end

---切换镜头(战斗模式)
---@class ChangeAttackVcamData
---@field id integer	角色id
---@field targets table<integer>	目标id列表 1为攻击角色 
---@field isChange boolean	是否切换到攻击镜头 true为开始 false为结束
---@param data ChangeAttackVcamData
---@param callback any
function BattleShowManager:changeAttackVcam(data, callback)
	local BattleMainPanel = UIMgr:GetUI("BattleMainPanel")
	local roleCtor = self:getRoleController(data.id)
	local hpObj = self:getRoleHpObj(data.id)
	
	if (roleCtor and roleCtor.attackVcam) then
		if (data.isChange) then
			--设置目标组中心位置
			self:setCMTargetGroup(data.id, data.targets)
			
			--计算朝向方向
			local attackRole = self:getRole(data.id)
			local targetRole = self:getRole(data.targets[2])
			local attackPos = attackRole.model.gameObject.transform.position
			local targetPos = targetRole.model.gameObject.transform.position
			
			local direction = targetPos - attackPos
			local rotation = Quaternion.LookRotation(direction)
			
			--距离
			local distance = Vector3.Distance(attackPos, targetPos)
			local virtualCamera = roleCtor.attackVcam:GetComponent(TypeInfo.CinemachineVirtualCamera)
			local framingTransposer = virtualCamera:GetCinemachineComponent(Cinemachine.CinemachineCore.Stage.Body)
			
			BattleCore.ds("BattleShowManager:changeAttackVcam", distance)
			local cameraDistance = distance > 3 and distance or 3
			framingTransposer.m_CameraDistance = cameraDistance
			
			-- 获取目标组中心（Cinemachine Target Group 的位置）
			local targetGroupCenter = ((attackPos + targetPos) / 2)
			
			-- 计算初始旋转欧拉角
			local initialEuler = Vector3.New(12, rotation.eulerAngles.y - 30, rotation.eulerAngles.z)
			
			-- 计算目标旋转欧拉角（在初始基础上再旋转 -20 度）
			local targetEuler = Vector3.New(initialEuler.x, initialEuler.y - 20, initialEuler.z)
			
			-- 【手动计算】初始位置的相机坐标
			local function CalcCamPos(euler)
				local rot = Quaternion.Euler(euler.x, euler.y, euler.z)
				local forward = rot * Vector3.forward
				-- 相机位置 = 目标中心 - 前方向量 * 相机距离
				return targetGroupCenter - forward * cameraDistance
			end
			
			local initialCamPos = CalcCamPos(initialEuler)
			local finalCamPos = CalcCamPos(targetEuler)
			
			-- 设置虚拟相机的实际旋转
			local vcamTransform = roleCtor.attackVcam.transform
			vcamTransform.localRotation = Quaternion.Euler(initialEuler.x, initialEuler.y, initialEuler.z)
			
			--旋转动画
			vcamTransform:DOLocalRotate(targetEuler, 1):OnUpdate(function()
				self:RefreshCameraMatrix()
			end)
			
			if BattleMainPanel then
				BattleMainPanel:showMainGroup(false)
			end
			
			-- 使用手动计算的相机位置进行遮挡物检测
			self:hideRaycastObstruction({
				attackPos,       -- 攻击者位置
				targetPos,       -- 目标位置
				initialCamPos,   -- 起始相机位置（手动计算）
				finalCamPos      -- 最终相机位置（手动计算）
			}, true, data.targets)
			
			--隐藏其他角色
			self:hideOtherRoleByIdList(data.targets)
		else
			--显示障碍物
			self:hideRaycastObstruction(nil, false, nil)
			if BattleMainPanel then
				BattleMainPanel:showMainGroup(true)
			end
		end
		
		-- 设置优先级
		local currentPriority = self._cinemachineBrain.ActiveVirtualCamera.Priority
		local mainPriority = self.mainVcam:GetComponent(TypeInfo.CinemachineVirtualCamera).Priority
		if data.isChange then
			roleCtor.attackVcam.Priority = currentPriority + 1
		else
			roleCtor.attackVcam.Priority = mainPriority - 1
		end
		
		UICommonUtils.Hp_SetUIRootActive(hpObj, not data.isChange)
		self:allPrepareSkillRangeSetActive(not data.isChange)
		self:showEdgesWall(not data.isChange)
		self:showEdgesLine(not data.isChange)
	end

	if (not data.isChange) then
		self:showAllRole()
	end

	if (data.isChange) then
		self:_DoAfter(1, function()
			if (callback) then
				callback()
			end
		end)
	else
		if (callback) then
			callback()
		end
	end
end

-- 辅助方法：获取 Cinemachine Target Group 的中心位置
function BattleShowManager:getCMTargetGroupCenter(roleId)
	local roleCtor = self:getRoleController(roleId)
	if roleCtor and roleCtor.cmTargetGroup then
		-- Target Group 的位置就是所有目标的中心
		return roleCtor.cmTargetGroup.transform.position
	end
	return nil
end

---角色播放Timeline动画
function BattleShowManager:roleTimeline(data, callback)
	BattleCore.ds("BattleShowManager:roleTimeline", tablex.dump(data))
	local role = self:getRole(data.id)
	if (not role) or (not role.model) or (not role.model.timelineMgr) then
		BattleCore.ws("BattleShowManager:roleTimeline skip, timeline file missing", data.id, data.timeline)
		if callback then
			callback()
		end
		return
	end
	local hasDirectors = role.model.timelineMgr.directors ~= nil and role.model.timelineMgr.directors.Length > 0
	if (not hasDirectors) or (not data.timeline) or data.timeline == "" then
		BattleCore.ws("BattleShowManager:roleTimeline skip, invalid timeline data", data.id, data.timeline)
		if callback then
			callback()
		end
		return
	end
	--提前加载界面 替换boss名称texture
	if data.name and data.name ~= "" then
		UIMgr:popUICover("BattleEffectPanel", {tipsName = data.name, tipsDesc = data.desc})
	end
	--结束回调
	role.model.timelineMgr.animCallback:SetCallBack(function()
		-- role.model.transform.localPosition = Vector3.New(0,0.5,0)
		BattleCore.ds("<color=#FFFFFF>播放完成2========</color>",data.timeline)
		self:setAllHpDis(true)
		self:showEdgesLine(true)
		self:showEdgesWall(true)
		self:allPrepareSkillRangeSetActive(true)
		local BattleMainPanel = UIMgr:GetUI("BattleMainPanel")
		if BattleMainPanel then
			BattleMainPanel:showMainGroup(true)
		end
		UIMgr:closeSpecificUI("BattleEffectPanel")
		if (callback) then
			callback()
		end
	end)
	--特殊回调
	role.model.timelineMgr.animCallback:SetCallBackOfName(function(name)
		BattleCore.ds("TimelineCallBackName", name)
		if name == GE.TimelineCallBackName.BossTips1 then
			local BattleEffectPanel = UIMgr:GetUI("BattleEffectPanel")
			if BattleEffectPanel then
				BattleEffectPanel:ShowEffectTips("warning1", 2)
			end
		end
		if name == GE.TimelineCallBackName.BossTips2 then
			local BattleEffectPanel = UIMgr:GetUI("BattleEffectPanel")
			if BattleEffectPanel then
				BattleEffectPanel:ShowEffectTips("warning2", 5)
			end
		end
	end)

	role.model.timelineMgr.AudioPlay:SetCallBack(function()
		if (data.skinConfig) then
			self:PlayBattleAudio(data.skinConfig, data.skinConfig.battleSkill, data.roleName)
		end
	end)

	self:setAllHpDis(false)
	self:showEdgesLine(false)
	self:showEdgesWall(false)
	self:allPrepareSkillRangeSetActive(false)
	---Timeline测试
	self:setPlayableAsset(data.id, data.timeline,data.skinConfig,  function()
		BattleCore.ds("<color=#FFFFFF>播放完成========</color>",data.timeline)
		self:setAllHpDis(true)
		--role.model.transform.localPosition = Vector3.New(0,0.5,0)
	end)
end

---舰载机攻击
---@class bombDetail
---@field delay number		炸弹从飞机俯冲开始的延迟

---@class BulletDataPlaneAttack
---@field planeName string		飞机
---@field speed number			速度
---@field index number			发射点位index
---@field delay number			延迟时间 秒
---@field roleId number			角色id
---@field blockId number		源地块id
---@field targetBlockId number	目标地块id
---@field targetRoleId number	目标角色id
---@field hitEffect number		命中特效
---@field hitResult HitResult[]	伤害详情
---@field bombDetail bombDetail[]	曲线度
---@field type PerformancePlaneType	飞机类型
---@field height number		飞机高度
---@field shootPos table		发射点位

---@param data BulletDataPlaneAttack
---@param callback function
function BattleShowManager:PlaneAttack(data, callback)
	-- LuaLogger.ds("BattleShowManager:PlaneAttack", tablex.dump(data))
	local roleId = data.roleId
	local targetRoleId = data.targetRoleId
	local blockid = data.blockId
	local targetBlockId = data.targetBlockId
	local role = self:getRole(roleId)
	local model = role.model
	local targetRole = self:getRole(targetRoleId)
	local targetModel = targetRole.model
	local perfTime = 0
	--第一家飞机随机往左往右 第一架确定之后后续飞机依次左右左右交替
	local randomDirection = UnityEngine.Random.Range(0, 1) == 0 and -1 or 1
	local planeIndex = data.index
	local boomNum = 0
	local boomNeedNum = 0
	local checkEnd = function()
		if boomNum == boomNeedNum then
			if callback then
				self:_DoAfter(1, function()
					callback()
				end)
			end
		end
	end
	if (model) then
		local shootRootTrans = self:__findShootPoint(model, data.shootPos)
		if not shootRootTrans then
			checkEnd()
			return
		end
		local hitRootTrans, isSelf = self:__findHitPoint(targetModel, 1)
		if not hitRootTrans then
			checkEnd()
			return
		end
		--飞机 起飞 - 平飞 - 俯冲 - 离场
		PoolMgr:Get(string.format(Config.PrefabPath.BulletPrefab, data.planeName), function (planeObj)
			--起飞音效
			local soundPath = string.format(Config.AudioPath.SE, "plane1")
			local fadeInTime = 1
			local targetVolume = 1
			self:play2DSound(soundPath, targetVolume, nil, nil, 1, fadeInTime, nil, planeObj)
			local blockObj = self:getBlockObj(blockid)
			local targetBlockObj = self:getBlockObj(targetBlockId)
			local startPos = shootRootTrans.position
			local endPos = hitRootTrans.position
			local totalToward = endPos - startPos
			local hitResultList = data.hitResult
			local hitEffect	--命中特效id
			local toward = endPos - startPos
			local takeoffBezier = 0.1	--起飞贝塞尔曲线点位
			local takeOffTime = 0.3	--起飞结束节点位置

			local diveStartTime = 0.6 	--俯冲开始节点位置	轰炸机
			local diveBezier = 0.8 	--俯冲贝塞尔曲线点位	轰炸机

			local torpedoEnd = 1.6	--鱼雷机消失节点位置
			-- data.speed = 0.8 --测试速度
			local leftDirection = Vector3.Cross(toward, Vector3.up).normalized
			local randomIndex = UnityEngine.Random.Range(0.2, 0.5) * (randomDirection * (((planeIndex/2) == 0) and 1 or -1))
			local randomPos =  leftDirection * randomIndex
			local targetPos = startPos + toward * takeOffTime + Vector3(0, data.height, 0) + randomPos
			local bezierPoint = endPos + (targetPos - endPos) * (1 + takeOffTime - takeoffBezier)
			bezierPoint.y = targetPos.y
			local distance = Vector3.Distance(startPos, targetPos)
			local speed = data.speed * 0.8 * Time.timeScale	--起飞速度
			local totalTime = distance/speed
			planeObj.transform.position = startPos
			local airDefensePendingMap = {
				[targetRoleId] = {
					targetRoleId = targetRoleId,
					targetBlockId = targetBlockId,
				},
			}
			local flyDirTakeoff = Vector3(toward.x, 0, toward.z)
			--贝赛尔曲线 飞机起飞
			self:startBezierMove(startPos, {bezierPoint}, targetPos, totalTime,
				--起飞过程
				function(pos, progress)
					-- 改变飞机的方向，使其朝向目标位置
					planeObj.transform:LookAt(pos)
					planeObj.transform.position = pos
					--飞机缩放
					local index = 0.8	--什么阶段scale变为1
					local scaleSpeed = 1/index
					local scale = progress * scaleSpeed >= 1 and 1 or progress * scaleSpeed
					planeObj.transform.localScale = Vector3(scale, scale, scale)
					if airDefensePendingMap then
						local hasPending = self:__tryPlayAirDefenseEffectsByDist(pos, flyDirTakeoff, blockObj, airDefensePendingMap)
						if not hasPending then
							airDefensePendingMap = nil
						end
					end
				end, 
				--起飞结束
				function()
					--轰炸机
					if data.type == GE.PerformancePlaneType.BombPlane then
						local startPos = planeObj.transform.position
						local flyProgress = diveStartTime - takeOffTime	--平飞占全程百分比
						local flyToward = endPos - startPos
						local flyEndPos = Vector3(startPos.x + flyToward.x * flyProgress, startPos.y, startPos.z + flyToward.z * flyProgress)
						local distance = Vector3.Distance(startPos, flyEndPos)
						local speed = data.speed * Time.timeScale	--平飞速度
						local time = distance/speed
						planeObj.transform:LookAt(flyEndPos)
						local flyDir = Vector3(flyToward.x, 0, flyToward.z)
						--平飞
						local flatFlyTween = planeObj.transform:DOMove(flyEndPos, time)
						if airDefensePendingMap then
							flatFlyTween:OnUpdate(function()
								if airDefensePendingMap then
									local hasPending = self:__tryPlayAirDefenseEffectsByDist(planeObj.transform.position, flyDir, blockObj, airDefensePendingMap)
									if not hasPending then
										airDefensePendingMap = nil
									end
								end
							end)
						end
						flatFlyTween:OnComplete(function()
							--平飞结束 俯冲阶段
							BattleCore.ds("BattleShowManager:PlaneAttack 俯冲")
							local startPos = planeObj.transform.position
							local toward = endPos - startPos
							local diveProgress = 1 - diveBezier	--俯冲占比 攻击角色到目标角色
							local diveEndIndex = 4				--俯冲后拉升距离倍数
							local diveEndProgress = diveEndIndex * diveProgress 	--俯冲后拉升距离
							--终点
							local diveEndPos = Vector3(startPos.x + totalToward.x * (1 + diveEndProgress), 1, startPos.z + totalToward.z * (1 + diveEndProgress))
							--俯冲预热占比
							local diveStartProgress = diveBezier - diveStartTime
							local flybezierPoint = startPos + Vector3(diveStartProgress * flyToward.x, 0, diveStartProgress * flyToward.z)
							--最低点
							local bezierPoint = Vector3(endPos.x, endPos.y + 0.5, endPos.z)
							local distance = Vector3.Distance(startPos, diveEndPos)
							local speed = data.speed * 3 * Time.timeScale	--俯冲速度
							local totalTime = distance/speed	--子弹位移总时间
							--投弹相关
							local bombIndex = 0
							for _, bomb in pairs(data.bombDetail) do
								boomNeedNum = boomNeedNum + 1
								--开始俯冲延迟
								local diveStartDelay = totalTime * Time.timeScale * (diveStartProgress/(diveStartProgress + diveProgress + diveEndProgress)) 
								self:_DoAfter(diveStartDelay + bomb.delay, function()
									local bombName = "pd2"
									PoolMgr:Get(string.format(Config.PrefabPath.BulletPrefab, bombName), function (bomb)
										bombIndex = bombIndex + 1
										--贝赛尔曲线 投弹
										local hitEffect	--命中特效id
										local targetPos = endPos
										local hitResult = hitResultList[bombIndex]
										--转换表现类型
										local disType = self:getDisTypeByHitType(hitResult.type, GE.BombHitToDis)
										--未命中 炮弹随机落到水中
										if disType == GE.BulletDisType.Miss then
											local randomX = UnityEngine.Random.Range(-0.5,0.5)
											local randomZ = UnityEngine.Random.Range(-0.5,0.5)
											targetPos = targetBlockObj.transform.position + Vector3(randomX, 0.5 + mapCubeOffsetY, randomZ)
											hitEffect = 1080 --miss特效
										else
											--若是自身位置 则需要上移
											if isSelf then
												targetPos = targetPos + Vector3(0,0.3,0)
											end
											local randomX = UnityEngine.Random.Range(-0.1,0.1)
											local randomZ = UnityEngine.Random.Range(-0.1,0.1)
											targetPos = targetPos + Vector3(randomX, 0, randomZ)
											--跳弹
											if disType == GE.BulletDisType.Ricochet then
												hitEffect = 1083 --跳弹特效
											--擦弹和命中
											elseif disType == GE.BulletDisType.Partial then
												hitEffect = 1081		--擦弹特效
											elseif disType == GE.BulletDisType.Hit then
												hitEffect = data.hitEffect					--配置命中特效id
											end
										end
										local startPos = planeObj.transform.position
										local bezierPoint = self:getBezierPoint(startPos, targetPos, 0.8, Vector3(0, 0.3, 0))
										local speed = 4 * Time.timeScale	--炸弹下落速度
										local totalTime = distance/speed	--子弹位移总时间
										bomb.transform.position = startPos
										bomb:SetActive(false)	--修复第一帧弹头瞬移bug
										self:startBezierMove(startPos, {bezierPoint}, targetPos, totalTime, 
											function(pos, progress)
												-- 改变飞机的方向，使其朝向目标位置
												bomb.transform:LookAt(pos)
												bomb.transform.position = pos
												bomb:SetActive(true)
											end, 
											function()
												--炸弹销毁
												PoolMgr.Free(bomb)
												if hitEffect then
													self:playEffect(targetPos, hitEffect, nil, hitResult, GE.SkillPerformanceType.PlaneAttack)
												end
												--伤害跳字
												if hitResult then
													self:playHitText(hitResult, targetRoleId, targetPos, disType)
												end
												boomNum = boomNum + 1
												checkEnd()
											end
										)
									end)
								end)
							end
							--贝赛尔曲线 飞机俯冲
							local diveFlyDir = Vector3(toward.x, 0, toward.z)
							self:startBezierMove(startPos, {flybezierPoint, bezierPoint}, diveEndPos, totalTime, 
								--俯冲过程
								function(pos, progress)
									-- 改变飞机的方向，使其朝向目标位置
									planeObj.transform:LookAt(pos)
									planeObj.transform.position = pos
									if airDefensePendingMap then
										local hasPending = self:__tryPlayAirDefenseEffectsByDist(pos, diveFlyDir, blockObj, airDefensePendingMap)
										if not hasPending then
											airDefensePendingMap = nil
										end
									end
									-- local startIndex = 0.8
									local startIndex = 1 - (diveEndProgress/2)/(diveStartProgress + diveProgress + diveEndProgress)
									if progress > startIndex then
										local scale = 1 - (progress - startIndex)/(1 - startIndex)
										planeObj.transform.localScale = Vector3(scale, scale, scale)
									end
								end, 
								--俯冲结束
								function()
									--离场
									local fadeOutTime = 2
									self:play2DSound(soundPath, 1, nil, nil, 1, fadeOutTime, nil, planeObj)
									self:_DoAfter(fadeOutTime, function()
										PoolMgr.Free(planeObj)
									end)
								end
							)
						end):SetEase(DG.Tweening.Ease.Linear)
					--鱼雷机
					elseif data.type == GE.PerformancePlaneType.TorpedoPlane then
						local offsetY = 0.45 + mapCubeOffsetY
						local startPos = planeObj.transform.position
						local flyToward = endPos - startPos
						local index = (torpedoEnd - takeOffTime)/(1 - takeOffTime)
						local flyEndPos = Vector3(startPos.x + flyToward.x * index, startPos.y, startPos.z + flyToward.z * index)
						local distance = Vector3.Distance(startPos, flyEndPos)
						local speed = data.speed * Time.timeScale	--平飞速度
						local time = distance/speed	--平飞总时间
						local startDroped = false	--是否开始丢鱼雷
						local flyDir = Vector3(flyToward.x, 0, flyToward.z)
						--平飞
						self:startBezierMove(startPos, {}, flyEndPos, time, 
							function(pos, progress)
								-- 改变飞机的方向，使其朝向目标位置
								planeObj.transform:LookAt(pos)
								planeObj.transform.position = pos
								if airDefensePendingMap then
									local hasPending = self:__tryPlayAirDefenseEffectsByDist(pos, flyDir, blockObj, airDefensePendingMap)
									if not hasPending then
										airDefensePendingMap = nil
									end
								end
								local aboveHeadTime = (1 - takeOffTime)/(torpedoEnd - takeOffTime) * time	--经过头顶的时间
								local aheadTime = 1/speed	--提前丢鱼雷的时间
								local dropPre = (aboveHeadTime - aheadTime)/time
								--到达指定位置 开始丢鱼雷
								if not startDroped and progress >= dropPre then
									startDroped = true
									local bombIndex = 0
									for _, bomb in pairs(data.bombDetail) do
										boomNeedNum = boomNeedNum + 1
										local bulletName = "pd3"
										--延迟丢雷
										self:_DoAfter(bomb.delay, function()
											PoolMgr:Get(string.format(Config.PrefabPath.BulletPrefab, bulletName), function (torpedoObj)
												bombIndex = bombIndex + 1
												--计算鱼雷终点位置
												local startPos = planeObj.transform.position
												local targetPos = targetBlockObj.transform.position + Vector3(0, offsetY, 0) --目标脚下地面
												local hitResult = hitResultList[bombIndex]
												local hitEffect	--命中特效
												local toward = targetPos - startPos	--默认方向打到目标脚下地面上
												--转换表现类型
												local disType = self:getDisTypeByHitType(hitResult.type, GE.TorpedoHitToDis)
												--未命中 则鱼雷穿过目标位置随机偏移并向后延伸随机1~2米
												if disType == GE.BulletDisType.Miss then
													local randomX = UnityEngine.Random.Range(0.1,0.2)
													local randomX = randomX * (math.random(0,1) == 0 and -1 or 1)
													local randomZ = UnityEngine.Random.Range(0.1,0.2)
													local randomZ = randomZ * (math.random(0,1) == 0 and -1 or 1)
													targetPos = targetPos + Vector3(randomX, 0, randomZ)
													toward = targetPos - (blockObj.transform.position + Vector3(0, offsetY, 0))
													local targetPos = targetPos + toward.normalized * UnityEngine.Random.Range(1, 2)
													toward = targetPos - startPos
												else
													local randomX = UnityEngine.Random.Range(-0.1,0.1)
													local randomZ = UnityEngine.Random.Range(-0.1,0.1)
													targetPos = targetPos + Vector3(randomX, 0, randomZ)
													--防护消耗
													if disType == GE.BulletDisType.DefReduce then
														hitEffect = 1084 --跳弹特效
													--擦弹和命中
													elseif disType == GE.BulletDisType.Partial then
														hitEffect = 1084
													elseif disType == GE.BulletDisType.Hit then
														hitEffect = data.hitEffect
													end
												end
												local startPos = planeObj.transform.position
												torpedoObj.transform.position = startPos
												--鱼雷下落保持水平
												torpedoObj.transform:LookAt(targetPos)
												torpedoObj.transform.eulerAngles = Vector3(0, torpedoObj.transform.eulerAngles.y, 0)
												local groundPos = Vector3(startPos.x, 0.45 + targetBlockObj.transform.position.y, startPos.z)
												local bezierPoint = self:getBezierPoint(startPos, targetPos, 0.2, Vector3(0, 0.3, 0))
												local distance = Vector3.Distance(targetBlockObj.transform.position , groundPos)
												local speed = 2 * Time.timeScale	--鱼雷下落速度
												local totalTime = distance/speed	--鱼雷下落总时间
												self:TorpedoDrop(torpedoObj, startPos, {}, groundPos, targetPos, totalTime, function()
													if hitEffect then
														self:playEffect(targetPos, hitEffect, nil, hitResult, GE.SkillPerformanceType.PlaneAttack)
													end
													--伤害跳字
													if hitResult then
														self:playHitText(hitResult, targetRoleId, targetPos, disType)
													end
													PoolMgr.Free(torpedoObj)
													boomNum = boomNum + 1
													checkEnd()
												end)
											end)
										end)
									end
								end
							end, 
							function()
								--离场
								PoolMgr.Free(planeObj)
							end
						)
					end
				end
			)
		end)
	else
		checkEnd()
	end
end

---发射子弹
---@class BulletData
---@field bulletName string			子弹名
---@field speed number			速度
---@field focus number			中点点位 0~1
---@field curve Vector3			偏移量
---@field index number			发射点位index
---@field delay number			延迟时间 秒
---@field roleId integer		角色id
---@field blockId number		源地块id
---@field targetBlockId number	目标地块id
---@field targetRoleId number	目标角色id
---@field shootEffect number	射击特效
---@field smoke number			烟雾特效
---@field hitEffect number		命中特效
---@field hitResult HitResult	伤害详情
---@field shootPos table		发射点位index
---@field shoottyp number		是否跟随射击炮口 默认0跟随 1不跟随

---@param data BulletData
---@param callback function
function BattleShowManager:shootBullet(data, callback)
	BattleCore.ds("BattleShowManager:shootBullet", tablex.dump(data))
	local roleId = data.roleId
	local targetRoleId = data.targetRoleId
	local blockid = data.blockId
	local targetBlockId = data.targetBlockId
	local role = self:getRole(roleId)
	local model = role.model
	local targetRole = self:getRole(targetRoleId)
	local targetModel = targetRole.model
	local perfTime = 0

	if (model) then
		local shootRootTrans = self:__findShootPoint(model, data.shootPos)
		if not shootRootTrans then
			BattleCore.es("没有找到发射点位")
			return
		end
		local hitRootTrans, isSelf = self:__findHitPoint(targetModel, 1)
		if not hitRootTrans then
			BattleCore.es("没有找到受击点位")
			return
		end
		--子弹
		PoolMgr:Get(string.format(Config.PrefabPath.BulletPrefab, data.bulletName), function (bulletObj)
			local blockObj = self:getBlockObj(blockid)
			local targetBlockObj = self:getBlockObj(targetBlockId)
			local startPos = shootRootTrans.position
			local targetPos = hitRootTrans.position
			local hitResult = data.hitResult
			local hitEffect	--命中特效
			--转换表现类型
			local disType = self:getDisTypeByHitType(hitResult.type, GE.CannonHitToDis)
			--未命中 炮弹随机落到水中
			if disType == GE.BulletDisType.Miss then
				local randomX = UnityEngine.Random.Range(-0.5,0.5)
				local randomZ = UnityEngine.Random.Range(-0.5,0.5)
				targetPos = targetBlockObj.transform.position + Vector3(randomX, 0.5 + mapCubeOffsetY, randomZ)
				hitEffect = 1080	
			else
				--若是自身位置 则需要上移
				if isSelf then
					targetPos = targetPos + Vector3(0,0.3,0)
				end
				local randomX = UnityEngine.Random.Range(-0.1,0.1)
				local randomZ = UnityEngine.Random.Range(-0.1,0.1)
				targetPos = targetPos + Vector3(randomX, 0, randomZ)
				--跳弹
				if disType == GE.BulletDisType.Ricochet then
					hitEffect = 1083 --跳弹特效
				--擦弹和命中
				elseif disType == GE.BulletDisType.Partial then
					hitEffect = 1081
				elseif disType == GE.BulletDisType.Hit then
					hitEffect = data.hitEffect
				end
			end
			--射击特效
			local shootEffect = data.shootEffect
			if shootEffect then
				local targetTrans = data.shoottyp == 0 and shootRootTrans or nil
				self:playEffect(startPos, shootEffect, Quaternion.LookRotation(-shootRootTrans.right, shootRootTrans.up) * Quaternion.Euler(0, 180, 0), nil, nil, nil, nil, targetTrans)
			end
			--烟雾特效
			local smoke = data.smoke
			if smoke then
				self:_DoAfter(smokeEffectDelay, function()
					self:playEffect(startPos, smoke, self:__getSmokeRotation(shootRootTrans))
				end)
			end
			--子弹起始位置
			bulletObj.transform.position = startPos
			local block = self:getBlockByObj(blockObj)
			local targetBlock = self:getBlockByObj(targetBlockObj)
			local bezierPoint = self:getBezierPoint(startPos, targetPos, data.focus, data.curve)
			-- local distance = Vector3.Distance(block:getPosition(), targetBlock:getPosition())
			local distance = Vector3.Distance(startPos, targetPos)
			local distCovered = 0
			local currentTimes = 0
			-- LuaLogger.ds("距离", distance)
			local speed = data.speed * Time.timeScale	--算上整体倍速
			local totalTime = distance/speed	--子弹位移总时间
			BattleCore.ds("BattleShowManager:shootBullet 子弹移动时间: ", totalTime)
			-- totalTime = math.max(totalTime)
			perfTime = totalTime
			local passTime = 0.02 				--刷新间隔
			local times = math.ceil(totalTime/passTime)	--刷新次数
			--贝赛尔曲线
			self:_DoRepeat(passTime, times, function ()
				if (bulletObj and bulletObj.transform) then
					currentTimes = currentTimes + 1
					--命中
					if (currentTimes == times) then
						if hitEffect then
							self:playEffect(targetPos, hitEffect, nil, hitResult, GE.SkillPerformanceType.ShootBullet)
						end
						--伤害跳字
						if hitResult then
							self:playHitText(hitResult, targetRoleId, targetPos, disType)
						end
						PoolMgr.Free(bulletObj)
					else
						distCovered = (currentTimes / times)
						local nextPos = luautil.getBezier(startPos, bezierPoint, targetPos, distCovered)
						-- 改变子弹的方向，使其朝向目标位置
						bulletObj.transform:LookAt(nextPos)
						bulletObj.transform.position = nextPos
					end
				end
			end)
			self:_DoAfter(perfTime + 1, function()
				if (callback) then
					callback()
				end
			end)
		end)
	end
end

---侧翼子弹数据
---@class SideAttackBulletData
---@field bulletName string			子弹名
---@field speed number			速度
---@field focus table<number>	中点点位 0~1
---@field index number			发射点位index
---@field delay number			延迟时间 秒
---@field roleId integer		角色id
---@field blockId number		源地块id
---@field targetBlockId number	目标地块id
---@field targetRoleId number	目标角色id
---@field shootEffect number	射击特效
---@field smoke number			烟雾特效
---@field hitEffect number		命中特效
---@field hitResult HitResult	伤害详情
---@field shootPos table		发射点位index
---@field partialEffect number	擦弹特效
---@field offsetx table<number>  子弹偏移
---@field offsety table<number>  子弹偏移
---@field isfall number		    是否需要下落 1是 0否

---@param data BulletData
---@param callback function
function BattleShowManager:SideAttack(data, callback)
	BattleCore.ds("BattleShowManager:SideAttack", tablex.dump(data))
	local roleId = data.roleId
	local targetRoleId = data.targetRoleId
	local blockid = data.blockId
	local targetBlockId = data.targetBlockId
	local role = self:getRole(roleId)
	local model = role.model
	local targetRole = self:getRole(targetRoleId)
	local targetModel = targetRole.model
	local perfTime = 0
	local fallSpeed = 0.75 --下落速度
	if (model) then
		local shootRootTrans = self:__findShootPoint(model, data.shootPos)
		if not shootRootTrans then
			BattleCore.es("没有找到发射点位")
			return
		end
		-- local hitRootTrans, isSelf = self:__findHitPoint(targetModel, 1)
		-- if not hitRootTrans then
		-- 	LuaLogger.es("没有找到受击点位")
		-- 	return
		-- end
		--子弹
		PoolMgr:Get(string.format(Config.PrefabPath.BulletPrefab, data.bulletName), function (bulletObj)
			self:setTorpedoEffect(bulletObj, false)
			bulletObj:SetActive(false)
			local blockObj = self:getBlockObj(blockid)
			local targetBlockObj = self:getBlockObj(targetBlockId)
			local startPos = shootRootTrans.position	--炮口位置
			local secondStartPos	--射击起始位置
			local targetPos = targetBlockObj.transform.position + Vector3(0, 0.5 + mapCubeOffsetY, 0)	--目标脚下地面上
			local hitResult = data.hitResult
			local hitEffect	--命中特效
			-- -- 转换表现类型
			local disType = self:getDisTypeByHitType(hitResult.type, GE.CannonHitToDis)
			--未命中 没有特效
			if hitResult.type == GE.BulletHitType.Miss then
			--擦弹
			elseif hitResult.type == GE.BulletHitType.Partial then
				hitEffect = data.partialEffect 	
			else
				local randomX = UnityEngine.Random.Range(-0.1,0.1)
				local randomZ = UnityEngine.Random.Range(-0.1,0.1)
				targetPos = targetPos + Vector3(randomX, 0, randomZ)
				hitEffect = data.hitEffect
			end
			--射击特效
			local shootEffect = data.shootEffect
			if shootEffect then
				self:playEffect(startPos, shootEffect, Quaternion.LookRotation(-shootRootTrans.right, shootRootTrans.up) * Quaternion.Euler(0, 180, 0), nil, nil, nil, nil, shootRootTrans)
			end
			--烟雾特效
			local smoke = data.smoke
			if smoke then
				self:_DoAfter(smokeEffectDelay, function()
					self:playEffect(startPos, smoke, self:__getSmokeRotation(shootRootTrans))
				end)
			end
			--总时间
			local totalTime
			--需要下落 二段流程
			if data.isfall == 1 then
				secondStartPos = Vector3(startPos.x, 0.5 + mapCubeOffsetY, startPos.z)
				totalTime = Vector3.Distance(startPos, secondStartPos)/(fallSpeed * Time.timeScale) + 
				Vector3.Distance(secondStartPos, targetPos)/(data.speed * Time.timeScale)
			else
				--无需下落
				secondStartPos = startPos
				totalTime = Vector3.Distance(secondStartPos, targetPos)/(data.speed * Time.timeScale)
			end
			self:playBulletExtra(bulletObj, data.bulletName, totalTime)
			perfTime = totalTime
			--射击流程
			local shootfunc = function()
				--子弹起始位置
				bulletObj.transform.position = secondStartPos
				bulletObj:SetActive(true)
				self:setTorpedoEffect(bulletObj, true)
				self:SetTrailEmitting(bulletObj, true)
				local block = self:getBlockByObj(blockObj)
				local targetBlock = self:getBlockByObj(targetBlockObj)
				local randomx = UnityEngine.Random.Range(data.offsetx[1], data.offsetx[2])
				local randomy = UnityEngine.Random.Range(data.offsety[1], data.offsety[2]) or 0	--y轴偏移
				local curve = Vector3(randomx, 0, 0)
				local focus = UnityEngine.Random.Range(data.focus[1], data.focus[2])
				local bezierPoint = self:getBezierPoint(secondStartPos, targetPos, focus, curve)
				bezierPoint.y = secondStartPos.y + randomy	--贝塞尔曲线高度为设计点位+随机偏移量
				local distance = Vector3.Distance(secondStartPos, targetPos)
				local speed = data.speed * Time.timeScale	--算上整体倍速
				local shootTime = distance/speed	--子弹位移总时间
				-- LuaLogger.ds("BattleShowManager:SideAttack 射击流程子弹起始位置", tablex.dump(secondStartPos))
				-- LuaLogger.ds("BattleShowManager:SideAttack 射击流程子弹终点位置", tablex.dump(targetPos))
				-- LuaLogger.ds("BattleShowManager:SideAttack curve随机x为: ", randomx)
				-- LuaLogger.ds("BattleShowManager:SideAttack 随机focus中点为: ", focus)
				-- LuaLogger.ds("BattleShowManager:SideAttack 子弹移动时间: ", shootTime)
				--贝赛尔曲线
				ResMgr:LoadCurveLibraryAsyncInOwner(Config.AssetFile.CurveLibrary, function(lib)
					self:startBezierMove(secondStartPos, {bezierPoint}, targetPos, shootTime, 
						function(pos, progress)
							-- 改变子弹的方向，使其朝向目标位置
							bulletObj.transform:LookAt(pos)
							--位置
							bulletObj.transform.position = pos
						end, 
						function()
							if hitEffect then
								self:playEffect(targetPos, hitEffect, nil, hitResult, GE.SkillPerformanceType.SideAttack)
							end
							--伤害跳字
							if hitResult then
								self:playHitText(hitResult, targetRoleId, targetPos, disType)
							end
							-- PoolMgr.Free(bulletObj)
							self:TrailEmittingEnd(bulletObj)
						end,
						lib:GetCurve("Missile1")
					)
					self:_DoAfter(perfTime + 1, function()
						if (callback) then
							callback()
						end
					end)
				end, ResMgr:GetResCarrier())
			end
			--下落流程
			local fallfunc = function()
				BattleCore.ds("BattleShowManager:SideAttack 下落流程子弹起始位置", tablex.dump(startPos))
				BattleCore.ds("BattleShowManager:SideAttack 下落流程子弹终点位置", tablex.dump(secondStartPos))
				self:setTorpedoEffect(bulletObj, false)
				local distance = Vector3.Distance(secondStartPos, startPos)
				local fallTime = distance/(fallSpeed * Time.timeScale)	--下落时间
				--贝塞尔曲线
				self:startBezierMove(startPos, {}, secondStartPos, fallTime, 
					function(pos, progress)
						--位置
						bulletObj.transform.position = pos
					end, 
					function()
						shootfunc()
					end
				)
			end
			if data.isfall == 1 then
				fallfunc()
			else
				shootfunc()
			end
		end)
	end

end

---无人机攻击子弹数据
---@class BulletDataDroneAttack
---@field bulletName string		子弹名
---@field speed number			速度
---@field focus table<number>	中点点位 0~1
---@field index number			发射点位index
---@field delay number			延迟时间 秒
---@field roleId integer		角色id
---@field blockId number		源地块id
---@field targetBlockId number	目标地块id
---@field targetRoleId number	目标角色id
---@field shootEffect number	射击特效
---@field smoke number			烟雾特效
---@field hitEffect number		命中特效
---@field hitResult HitResult	伤害详情
---@field shootPos table		发射点位index
---@field waitPoint table<number>	无人机悬停点位
---@field wait number		    无人机悬停时间
---@field offsetx number	        --无人机二段冲刺贝赛尔曲线偏移x
---@field offsety number	        --无人机二段冲刺贝赛尔曲线偏移y

---@param data BulletData
---@param callback function
function BattleShowManager:DroneAttack(data, callback)
	BattleCore.ds("BattleShowManager:DroneAttack", tablex.dump(data))
	local roleId = data.roleId
	local targetRoleId = data.targetRoleId
	local blockid = data.blockId
	local targetBlockId = data.targetBlockId
	local role = self:getRole(roleId)
	local model = role.model
	local targetRole = self:getRole(targetRoleId)
	local targetModel = targetRole.model
	local perfTime = 0
	local upSpeed = 1.25 --无人机上升速度
	if (model) then
		local shootRootTrans = self:__findShootPoint(model, data.shootPos)
		if not shootRootTrans then
			BattleCore.es("没有找到发射点位")
			return
		end
		local hitRootTrans, isSelf = self:__findHitPoint(targetModel, 1)
		if not hitRootTrans then
			BattleCore.es("没有找到受击点位")
			return
		end
		--无人机
		PoolMgr:Get(string.format(Config.PrefabPath.BulletPrefab, data.bulletName), function (planeObj)
			local blockObj = self:getBlockObj(blockid)
			local targetBlockObj = self:getBlockObj(targetBlockId)
			local startPos = shootRootTrans.position	--炮口位置
			local secondStartPos	--射击起始位置
			local targetPos = hitRootTrans.position	--目标
			local hitResult = data.hitResult
			local hitEffect	--命中特效
			-- 转换表现类型
			local disType = self:getDisTypeByHitType(hitResult.type, GE.CannonHitToDis)
			--未命中 没有特效
			--若是自身位置 则需要上移
			if isSelf then
				targetPos = targetPos + Vector3(0,0.3,0)
			end
			if hitResult.type == GE.BulletHitType.Miss then
			--擦弹
			elseif hitResult.type == GE.BulletHitType.Partial then
				hitEffect = data.partialEffect 	
			else
				local randomX = UnityEngine.Random.Range(-0.1,0.1)
				local randomZ = UnityEngine.Random.Range(-0.1,0.1)
				targetPos = targetPos + Vector3(randomX, 0, randomZ)
				hitEffect = data.hitEffect
			end
			--射击特效
			local shootEffect = data.shootEffect
			if shootEffect then
				self:playEffect(startPos, shootEffect, Quaternion.LookRotation(-shootRootTrans.right, shootRootTrans.up) * Quaternion.Euler(0, 180, 0), nil, nil, nil, nil, shootRootTrans)
			end
			--烟雾特效
			local smoke = data.smoke
			if smoke then
				self:_DoAfter(smokeEffectDelay, function()
					self:playEffect(startPos, smoke, self:__getSmokeRotation(shootRootTrans))
				end)
			end
			--总时间
			local totalTime
			self:playBulletExtra(planeObj, data.bulletName, totalTime)
			--无人机上升
			local dirction = targetBlockObj.transform.position - blockObj.transform.position
			local x = Vector3.Cross(dirction, Vector3.up).normalized * data.waitPoint[1] --左右偏移
			local y = Vector3.up.normalized * data.waitPoint[2] --上下偏移
			local z = dirction.normalized * data.waitPoint[3] --前后偏移

			local waitPos = startPos + x + y + z	--悬停点位
			planeObj.transform.position = startPos
			local upTime = Vector3.Distance(startPos, waitPos)/(upSpeed * Time.timeScale)
			--无人机升空
			planeObj.transform:DOMove(waitPos,upTime):SetEase(DG.Tweening.Ease.Linear):OnUpdate(function()
				--始终面朝目标
				planeObj.transform:LookAt(targetPos)
			end
			):OnComplete(function()
				self:_DoAfter(data.wait, function()
					--悬停结束
					local randomx = UnityEngine.Random.Range(data.offsetx[1], data.offsetx[2])
					local randomy = UnityEngine.Random.Range(data.offsety[1], data.offsety[2]) or 0	--y轴偏移
					local curve = Vector3(randomx, 0, 0)
					local focus = UnityEngine.Random.Range(data.focus[1], data.focus[2])
					local bezierPoint = self:getBezierPoint(waitPos, targetPos, focus, curve)
					bezierPoint.y = waitPos.y + randomy	--贝塞尔曲线高度为设计点位+随机偏移量
					local distance = Vector3.Distance(waitPos, targetPos)
					local speed = data.speed * Time.timeScale	--算上整体倍速
					local shootTime = distance/speed	--子弹位移总时间
					BattleCore.ds("BattleShowManager:DroneAttack 无人机二段冲刺子弹起始位置", tablex.dump(secondStartPos))
					BattleCore.ds("BattleShowManager:DroneAttack 无人机二段冲刺子弹终点位置", tablex.dump(targetPos))
					BattleCore.ds("BattleShowManager:DroneAttack curve随机x为: ", randomx)
					BattleCore.ds("BattleShowManager:DroneAttack 随机focus中点为: ", focus)
					BattleCore.ds("BattleShowManager:DroneAttack 子弹移动时间: ", shootTime)
					--贝赛尔曲线
					ResMgr:LoadCurveLibraryAsyncInOwner(Config.AssetFile.CurveLibrary, function(lib)
						self:startBezierMove(waitPos, {bezierPoint}, targetPos, shootTime,
							function(pos, progress)
								-- 改变无人机的方向，使其朝向目标位置
								planeObj.transform:LookAt(pos)
								--位置
								planeObj.transform.position = pos
							end, 
							function()
								if hitEffect then
									self:playEffect(targetPos, hitEffect, nil, hitResult, GE.SkillPerformanceType.DroneAttack)
								end
								--伤害跳字
								if hitResult then
									self:playHitText(hitResult, targetRoleId, targetPos, disType)
								end
								--销毁
								PoolMgr.Free(planeObj)
								self:_DoAfter(1, function()
									if (callback) then
										callback()
									end
								end)
							end,
							lib:GetCurve("Drone1")
						)
					end, ResMgr:GetResCarrier())
				end)
			end)
		end)
	end
end

---直接命中
---@class BulletDataJustHit
---@field delay number			延迟时间 秒
---@field roleId number			角色id
---@field blockId number		源地块id
---@field targetBlockId number	目标地块id
---@field targetRoleId number	目标角色id
---@field shootEffect string	射击特效
---@field smoke number			烟雾特效
---@field hitEffect number		命中特效
---@field hitResult HitResult	伤害详情
---@field index number			子弹索引
---@field dmgDelay number		伤害延迟
---@field shootPos table		射击位置
---@field shoottyp number		是否跟随射击炮口 默认0跟随 1不跟随

---没有伤害数据的纯表现方法 治疗或纯表现用
---@class BulletDataJustEffect
---@field delay number			技能延迟时间 秒
---@field roleId number			角色id
---@field blockId number		源地块id
---@field targetBlockId number?	目标地块id
---@field targetRoleId number?	目标角色id
---@field shootEffect integer	射击特效
---@field smoke integer			烟雾特效
---@field hitEffect integer		命中特效
---@field dmgDelay number		角色伤特效延迟
---@field beeff integer			角色被击特效
---@field index number			子弹索引
---@field targetIndex number	单次技能目标索引 用于判断aoe类技能只在第一个角色地块受击时播放特效
---@field skillTargetBlockId number	技能目标地块id
---@field shootPos table		射击位置
---@field targetBlockIdList table	技能生效地块id列表

---@param data BulletDataJustEffect
---@param callback function
function BattleShowManager:justEffect(data, callback)
	BattleCore.ds("BattleShowManager:JustEffect", tablex.dump(data))
	local roleId = data.roleId
	local blockid = data.blockId
	-- local targetBlockId = data.targetBlockId
	local skillTargetBlockId = data.skillTargetBlockId
	local role = self:getRole(roleId)
	local model = role.model
	local targetRoleId
	local targetRole
	local targetModel
	--可能没有目标角色
	if data.targetRoleId then
		targetRoleId = data.targetRoleId
		targetRole = self:getRole(targetRoleId)
		targetModel = targetRole.model
	end
	local dmgDelay = data.dmgDelay or 0
	local perfTime = 0

	if (model) then
		local shootRootTrans = self:__findShootPoint(model, data.shootPos)
		if not shootRootTrans then
			BattleCore.es("没有找到发射点位")
			return
		end
		local hitRootTrans, isSelf
		if targetModel then
			hitRootTrans, isSelf = self:__findHitPoint(targetModel, 1)
			if not hitRootTrans then
				BattleCore.es("没有找到受击点位")
				return
			end
		end
		local blockObj = self:getBlockObj(blockid)
		-- local targetBlockObj = self:getBlockObj(targetBlockId)
		local skillTargetBlockObj = self:getBlockObj(skillTargetBlockId)
		local startPos = shootRootTrans.position
		local targetPos = skillTargetBlockObj.transform.position + Vector3(0, 0.5 + mapCubeOffsetY, 0)	--aoe选中地块位置
		local roleTargetPos
		if hitRootTrans then
			roleTargetPos = hitRootTrans.position	--角色受击位置
			--若是自身位置 则需要上移
			if isSelf then
				roleTargetPos = roleTargetPos + Vector3(0,0.3,0)
			end
		end
		
		--命中选中地块特效
		local hitEffect = data.hitEffect
		--射击特效
		local shootEffect = data.shootEffect
		--受击特效
		local beEffect = data.beeff
		--只有第一个角色受击时播放特效
		if data.targetIndex == 1 then
			--攻击特效
			if shootEffect then
				self:playEffect(startPos, shootEffect, Quaternion.LookRotation(-shootRootTrans.right, shootRootTrans.up) * Quaternion.Euler(0, 180, 0))
			end
			--烟雾特效
			local smoke = data.smoke
			if smoke then
				self:_DoAfter(smokeEffectDelay, function()
					self:playEffect(startPos, smoke, self:__getSmokeRotation(shootRootTrans))
				end)
			end
			--命中地块
			if hitEffect then
				self:playEffect(targetPos, hitEffect)
			end
		end
		--延迟播放角色特效 4类型没有子弹数据 为治疗或为纯表现
		if data.targetBlockIdList and tablex.size(data.targetBlockIdList) > 0 then
			for _, id in pairs(data.targetBlockIdList) do
				local blockObj = self:getBlockObj(id)
				--地格地面位置
				local blockObjPos = blockObj.transform.position + Vector3(0, 0.5 + mapCubeOffsetY, 0)
				self:_DoAfter(dmgDelay, function()
					BattleCore.ds("BattleShowManager:JustEffect beEffect 角色受击特效id", beEffect)
					self:playEffect(blockObjPos + Vector3(0, 0.3, 0), beEffect)
				end)
			end
		end
	end
	perfTime = dmgDelay
	self:_DoAfter(perfTime + 0.3, function()
		if (callback) then
			callback()
		end
	end)
end

---aoe
---@class BulletDataAreaAttack
---@field delay number			技能延迟时间 秒
---@field roleId number			角色id
---@field blockId number		源地块id
---@field targetBlockId number?	目标地块id
---@field targetRoleId number?	目标角色id
---@field shootEffect number	射击特效
---@field smoke number			烟雾特效
---@field hitEffect number		命中特效
---@field hitResult HitResult?	伤害详情
---@field dmgDelay number		角色伤害跳字延迟
---@field beeff number			角色被击特效
---@field index number			子弹索引
---@field targetIndex number	单次技能目标索引 用于判断aoe类技能只在第一个角色地块受击时播放特效
---@field skillTargetBlockId integer	技能目标地块id
---@field shootPos table		射击位置

---@param data BulletDataAreaAttack
---@param callback function
function BattleShowManager:areaAttack(data, callback)
	BattleCore.ds("BattleShowManager:areaAttack", tablex.dump(data))
	local roleId = data.roleId
	local blockid = data.blockId
	-- local targetBlockId = data.targetBlockId
	local skillTargetBlockId = data.skillTargetBlockId
	local role = self:getRole(roleId)
	local model = role.model
	local dmgDelay = data.dmgDelay or 0
	local perfTime = 0

	if (model) then
		local shootRootTrans = self:__findShootPoint(model, data.shootPos)
		if not shootRootTrans then
			BattleCore.es("没有找到发射点位")
			return
		end
		local blockObj = self:getBlockObj(blockid)
		-- local targetBlockObj = self:getBlockObj(targetBlockId)
		local skillTargetBlockObj = self:getBlockObj(skillTargetBlockId)
		local startPos = shootRootTrans.position
		local targetPos = skillTargetBlockObj.transform.position + Vector3(0, 0.5 + mapCubeOffsetY, 0)	--aoe选中地块位置
		--命中选中地块特效
		local hitEffect = data.hitEffect
		--射击特效
		local shootEffect = data.shootEffect
		--受击特效
		local beEffect = data.beeff
		--只有第一个角色受击时播放特效
		if data.targetIndex == 1 then
			--攻击特效
			if shootEffect then
				self:playEffect(startPos, shootEffect, Quaternion.LookRotation(-shootRootTrans.right, shootRootTrans.up) * Quaternion.Euler(0, 180, 0), nil, nil, nil, nil, shootRootTrans)
			end
			--烟雾特效
			local smoke = data.smoke
			if smoke then
				self:_DoAfter(smokeEffectDelay, function()
					self:playEffect(startPos, smoke, self:__getSmokeRotation(shootRootTrans))
				end)
			end
			--命中地块
			if hitEffect then
				self:playEffect(targetPos, hitEffect, nil, data.hitResult, GE.SkillPerformanceType.AreaAttack)
			end
		end
		--如果有受击目标
		if data.hitResult then
			local targetRoleId = data.targetRoleId
			local targetRole = self:getRole(targetRoleId)
			local targetModel = targetRole.model
			local hitRootTrans, isSelf = self:__findHitPoint(targetModel, 1)
			if not hitRootTrans then
				BattleCore.es("没有找到受击点位")
				return
			end
			local roleTargetPos = hitRootTrans.position	--角色受击位置
			--若是自身位置 则需要上移
			if isSelf then
				roleTargetPos = roleTargetPos + Vector3(0,0.3,0)
			end
			--延迟播放角色受击特效+跳字
			self:_DoAfter(dmgDelay, function()
				self:playEffect(roleTargetPos, beEffect)
				local hitResult = data.hitResult
				--转换表现类型
				local disType = self:getDisTypeByHitType(hitResult.type, GE.CannonHitToDis)
				--伤害跳字
				if hitResult then
					self:playHitText(hitResult, targetRoleId, roleTargetPos, disType)
				end
			end)
		end
	end
	perfTime = dmgDelay
	self:_DoAfter(perfTime + 1, function()
		if (callback) then
			callback()
		end
	end)
end

---地毯式轰炸 单个飞机
---@class BulletDataPlaneBombing
---@field planeName string		飞机
---@field speed number			速度
---@field index number			飞机索引
---@field delay number			延迟时间 秒
---@field roleId number			角色id
---@field blockId number		源地块id
---@field targetBlockId number?	目标地块id
---@field targetRoleId number?	目标角色id
---@field hitEffect number		命中特效
---@field hitResult HitResult[]?	伤害详情
---@field bombDetail bombDetail[]	炸弹详情
---@field height number			飞机高度
---@field allPlaneNum number	总计飞机数量
---@field dmgDelay number			飞机类型
---@field area integer[]			飞机速度
---@field skillTargetBlockId number	技能选中目标格子id
---@field targetIndex		单次技能目标索引 用于判断aoe类技能只在第一个角色地块受击时播放特效
---@field shootPos table		射击位置
---@field allTargetList table[]?	本次技能全部受击目标

---@param data BulletDataPlaneBombing
---@param callback function
function BattleShowManager:PlaneBombing(data, callback)
	BattleCore.ds("BattleShowManager:PlaneBombing", tablex.dump(data))
	local roleId = data.roleId
	local blockid = data.blockId
	local targetBlockId = data.targetBlockId
	local skillTargetBlockId = data.skillTargetBlockId
	local role = self:getRole(roleId)
	local model = role.model
	local perfTime = 0
	--所有飞机居中飞行 每架间隔1个单位距离
	local totalSpace = 1 * (data.allPlaneNum - 1) --飞机编队总距离
	--当前飞机距离终点偏移量
	local currentSpace = ((totalSpace/2) * -1) + totalSpace * ((data.index - 1)/data.allPlaneNum)
	local currentSpace = ((totalSpace/2) * -1) + totalSpace * ((data.index - 1)/data.allPlaneNum) + 0.25 
	local planeIndex = data.index
	if (model) then
		local shootRootTrans = self:__findShootPoint(model, data.shootPos)
		if not shootRootTrans then
			BattleCore.es("没有找到发射点位")
			return
		end
		BattleCore.ds("BattleShowManager:PlaneBombing")
		--aoe类技能只在第一个角色受击时播放表现
		if data.targetIndex == 1 then
			--飞机 起飞 - 平飞 - 俯冲 - 离场
			PoolMgr:Get(string.format(Config.PrefabPath.BulletPrefab, data.planeName), function (planeObj)
				--起飞音效
				BattleCore.ds("BattleShowManager:PlaneBombing")
				local soundPath = string.format(Config.AudioPath.SE, "plane1")
				local fadeInTime = 1
				local targetVolume = 1
				self:play2DSound(soundPath, targetVolume, nil, nil, 1, fadeInTime, nil, planeObj)
				local blockObj = self:getBlockObj(blockid)
				local targetBlockObj = self:getBlockObj(targetBlockId)
				local skillTargetBlockObj = self:getBlockObj(skillTargetBlockId)
				local startPos = shootRootTrans.position
				local startBlockPos = blockObj.transform.position + Vector3(0, 0.5 + mapCubeOffsetY, 0)	--地毯式轰炸起始地块位置
				local selectedPos = skillTargetBlockObj.transform.position + Vector3(0, 0.5 + mapCubeOffsetY, 0)	--地毯式轰炸选中地块位置
				BattleCore.ds("BattleShowManager:PlaneBombing area", tablex.dump(data.area))
				local endPos = startBlockPos + (selectedPos - startBlockPos) * data.area[2]	--地毯式轰炸目标地块位置
				local hitResultList = data.hitResult
				local hitEffect	= data.hitEffect --命中特效id
				local toward = endPos - startBlockPos
				local takeoffBezier = 0.1	--起飞贝塞尔曲线点位
				local takeOffTime = 0.3	--起飞结束节点位置

				local torpedoEnd = 1.6	--鱼雷机消失节点位置
				-- data.speed = 0.8 --测试速度
				--计算队列飞行左右偏移
				local rightDirection = - Vector3.Cross(toward, Vector3.up).normalized
				local offset =  rightDirection * currentSpace
				local targetPos = startBlockPos + toward * takeOffTime + Vector3(0, data.height, 0) + offset
				local bezierPoint = endPos + (targetPos - endPos) * ((1 - takeoffBezier)/(1 - takeOffTime))
				bezierPoint.y = targetPos.y
				local distance = Vector3.Distance(startPos, targetPos)
				local speed = data.speed * 0.8 * Time.timeScale	--起飞速度
				local totalTime = distance/speed
				local airDefensePendingMap = nil
				local flyDirTakeoff = Vector3(toward.x, 0, toward.z)
				if data.index == 1 and data.allTargetList then
					airDefensePendingMap = {}
					for _, targetInfo in ipairs(data.allTargetList) do
						airDefensePendingMap[targetInfo.targetRoleId] = targetInfo
					end
				end
				--贝赛尔曲线 飞机起飞
				BattleCore.ds("BattleShowManager:PlaneBombing")
				self:startBezierMove(startPos, {bezierPoint}, targetPos, totalTime,
					--起飞过程
					function(pos, progress)
						-- 改变飞机的方向，使其朝向目标位置
						planeObj.transform:LookAt(pos)
						planeObj.transform.position = pos
						--飞机缩放
						local index = 0.8	--什么阶段scale变为1
						local scaleSpeed = 1/index
						local scale = progress * scaleSpeed >= 1 and 1 or progress * scaleSpeed
						planeObj.transform.localScale = Vector3(scale, scale, scale)
						if airDefensePendingMap then
							local hasPending = self:__tryPlayAirDefenseEffectsByDist(pos, flyDirTakeoff, blockObj, airDefensePendingMap)
							if not hasPending then
								airDefensePendingMap = nil
							end
						end
					end, 
					--起飞结束
					function()
						local offsetY = 0.45
						local startPos = planeObj.transform.position
						local flyToward = (endPos + offset) - startPos
						local index = (torpedoEnd - takeOffTime)/(1 - takeOffTime)
						local flyEndPos = Vector3(startPos.x + flyToward.x * index, startPos.y, startPos.z + flyToward.z * index)
						local distance = Vector3.Distance(startPos, flyEndPos)
						local speed = data.speed * Time.timeScale	--平飞速度
						local time = distance/speed	--平飞总时间
						local flyDir = Vector3(flyToward.x, 0, flyToward.z)

						---转向
						local direction = flyEndPos - startPos
						planeObj.transform:DORotateQuaternion(Quaternion.LookRotation(direction), 0.5)
						--平飞
						self:startBezierMove(startPos, {}, flyEndPos, time, 
							function(pos, progress)
								-- 改变飞机的方向，使其朝向目标位置
								-- planeObj.transform:LookAt(pos)
								planeObj.transform.position = pos
								if airDefensePendingMap then
									local hasPending = self:__tryPlayAirDefenseEffectsByDist(pos, flyDir, blockObj, airDefensePendingMap)
									if not hasPending then
										airDefensePendingMap = nil
									end
								end
							end, 
							function()
								--离场
								PoolMgr.Free(planeObj)
							end
						)
						--轰炸
						local bombingTime = time * ((1 - takeOffTime)/(torpedoEnd - takeOffTime)) 
						for _, bomb in pairs(data.bombDetail) do
							--计算轰炸延迟 乘以Time.timeScale是因为self:_DoAfter里面计算了倍速，bombingTime这里startBezierMove用的time也计算了倍速 多计算了一次
							local bombDelay = bomb.delay * bombingTime * Time.timeScale
							self:_DoAfter(bombDelay, function()
								local bombName = "pd2"
								PoolMgr:Get(string.format(Config.PrefabPath.BulletPrefab, bombName), function (bomb)
									--贝赛尔曲线 投弹
									local startPos = planeObj.transform.position
									local targetPos = Vector3(startPos.x, 0.5 + mapCubeOffsetY, startPos.z)
									local distance = Vector3.Distance(startPos, targetPos)
									local speed = 2 * Time.timeScale	--炸弹下落速度
									local totalTime = distance/speed	--子弹位移总时间
									bomb.transform.position = startPos
									-- bomb.transform:LookAt(targetPos)
									-- bomb.transform:DOMove(targetPos, totalTime):OnComplete(function()
									-- 	--爆炸特效
									-- 	PoolMgr.Free(bomb)
									-- 	if hitEffect then
									-- 		self:playEffect(targetPos, hitEffect)
									-- 	end
									-- end):SetEase(DG.Tweening.Ease.InQuad)
									targetPos = Vector3(targetPos.x + direction.normalized.x * 0.5 , 0.5, targetPos.z + direction.normalized.z * 0.5)
									local bezierPoint = startPos + (targetPos - startPos) * 0.5 + Vector3(0, (startPos.y - targetPos.y) * 0.2, 0)
									--投弹角度初始与飞机一致 旋转下落
									bomb.transform.rotation = planeObj.transform.rotation
									local targetRotation = bomb.transform.eulerAngles + Vector3(45, 0, 0)
									bomb.transform:DORotate(targetRotation, totalTime):SetEase(DG.Tweening.Ease.OutQuad)
									self:startBezierMove(startPos, {bezierPoint}, targetPos, totalTime, 
										function(pos, progress)
											bomb.transform.position = pos
										end, 
										function()
											--爆炸特效
											PoolMgr.Free(bomb)
											if hitEffect then
												self:playEffect(targetPos, hitEffect, nil, {}, GE.SkillPerformanceType.PlaneBombing)
											end
										end
									)
								end)
							end)
						end
					end
				)
			end)
		end
		if data.hitResult then
			--地毯式轰炸只在每个目标的第一家飞机战报里播放伤害
			if data.index == 1 then
				local targetRoleId = data.targetRoleId
				local targetRole = self:getRole(targetRoleId)
				local targetModel = targetRole.model
				local hitRootTrans, isSelf = self:__findHitPoint(targetModel, 1)
				if not hitRootTrans then
					BattleCore.es("没有找到受击点位")
					return
				end
				--延迟播放角色受击特效+跳字
				local roleTargetPos = hitRootTrans.position	--角色受击位置
				--若是自身位置 则需要上移
				if isSelf then
					roleTargetPos = roleTargetPos + Vector3(0,0.3,0)
				end
				self:_DoAfter(data.dmgDelay, function()
					local hitResult = data.hitResult
					--转换表现类型
					local disType = self:getDisTypeByHitType(hitResult.type, GE.CannonHitToDis)
					--伤害跳字
					if hitResult then
						self:playHitText(hitResult, targetRoleId, roleTargetPos, disType)
					end
				end)
			end
		end
	end
	self:_DoAfter(data.dmgDelay + 1.5, function()
		if (callback) then
			callback()
		end
	end)
end

---轨道攻击
---@class BulletDataRailAttack
---@field delay number			技能延迟时间 秒
---@field roleId number			角色id
---@field blockId number		源地块id
---@field targetBlockId number?	目标地块id
---@field targetRoleId number?	目标角色id
---@field shootEffect number	射击炮口特效
---@field smoke number			烟雾特效
---@field hitEffect number		攻击特效
---@field hitResult HitResult?	伤害详情
---@field dmgDelay number		角色伤害跳字延迟
---@field beeff number			角色被击特效
---@field index number			子弹索引
---@field targetIndex number	单次技能目标索引 用于判断aoe类技能只在第一个角色地块受击时播放特效
---@field skillTargetBlockId number	技能目标地块id
---@field shootPos table		射击位置

---@param data BulletDataRailAttack
---@param callback function
function BattleShowManager:RailAttack(data, callback)
	BattleCore.ds("BattleShowManager:RailAttack", tablex.dump(data))
	local roleId = data.roleId
	local blockid = data.blockId
	local targetBlockId = data.targetBlockId
	local skillTargetBlockId = data.skillTargetBlockId
	local role = self:getRole(roleId)
	local model = role.model
	local dmgDelay = data.dmgDelay or 0
	local perfTime = 0

	if (model) then
		local shootRootTrans = self:__findShootPoint(model, data.shootPos)
		if not shootRootTrans then
			BattleCore.es("没有找到发射点位")
			return
		end
		local blockObj = self:getBlockObj(blockid)
		-- local targetBlockObj = self:getBlockObj(targetBlockId)
		local skillTargetBlockObj = self:getBlockObj(skillTargetBlockId)
		local startPos = shootRootTrans.position
		local targetPos = skillTargetBlockObj.transform.position + Vector3(0, 0.5 + mapCubeOffsetY, 0)	--aoe选中地块位置
		--定向攻击特效
		local hitEffect = data.hitEffect
		--射击特效
		local shootEffect = data.shootEffect
		--受击特效
		local beEffect = data.beeff
		--只有第一个角色受击时播放特效
		if data.targetIndex == 1 then
			--攻击特效
			if shootEffect then
				self:playEffect(startPos, shootEffect)
			end
			--烟雾特效
			local smoke = data.smoke
			if smoke then
				self:_DoAfter(smokeEffectDelay, function()
					self:playEffect(startPos, smoke, self:__getSmokeRotation(shootRootTrans))
				end)
			end
			--轨道攻击特效 水平方向
			local direction = skillTargetBlockObj.transform.position - blockObj.transform.position
			direction.y = 0
			local rotation = Quaternion.LookRotation(direction)
			local pos = model.transform.position
			if hitEffect then
				self:playEffect(pos, hitEffect, rotation, data.hitResult, GE.SkillPerformanceType.RailAttack)
			end
		end
		if data.hitResult then
			local targetRoleId = data.targetRoleId
			local targetRole = self:getRole(targetRoleId)
			local targetModel = targetRole.model
			local hitRootTrans, isSelf = self:__findHitPoint(targetModel, 1)
			if not hitRootTrans then
				BattleCore.es("没有找到受击点位")
				return
			end
			local roleTargetPos = hitRootTrans.position	--角色受击位置
			--若是自身位置 则需要上移
			if isSelf then
				roleTargetPos = roleTargetPos + Vector3(0,0.3,0)
			end
			--延迟播放角色受击特效+跳字
			self:_DoAfter(dmgDelay, function()
				self:playEffect(roleTargetPos, beEffect)
				local hitResult = data.hitResult
				--转换表现类型
				local disType = self:getDisTypeByHitType(hitResult.type, GE.CannonHitToDis)
				--伤害跳字
				if hitResult then
					self:playHitText(hitResult, targetRoleId, roleTargetPos, disType)
				end
			end)
		end			
	end
	perfTime = dmgDelay
	self:_DoAfter(perfTime + 1, function()
		if (callback) then
			callback()
		end
	end)
end

---鱼雷攻击
---@class BulletDataTorpedoAttack
---@field bulletName string			子弹名
---@field speed number			速度
---@field index number			发射点位index
---@field delay number			延迟时间 秒
---@field roleId number			角色id
---@field blockId number		源地块id
---@field targetBlockId number	目标地块id
---@field targetRoleId number	目标角色id
---@field hitEffect number		命中特效
---@field hitResult HitResult	伤害详情
---@field shootPos table		射击位置

---@param data BulletDataTorpedoAttack
---@param callback function
function BattleShowManager:TorpedoAttack(data, callback)
	BattleCore.ds("BattleShowManager:TorpedoAttack", tablex.dump(data))
	local roleId = data.roleId
	local targetRoleId = data.targetRoleId
	local blockid = data.blockId
	local targetBlockId = data.targetBlockId
	local role = self:getRole(roleId)
	local model = role.model
	local targetRole = self:getRole(targetRoleId)
	local targetModel = targetRole.model
	local offsetY = 0.45 + mapCubeOffsetY --鱼雷相对与blockobj的y轴偏移量
	local perfTime = 0
	if (model) then
		local shootRootTrans = self:__findShootPoint(model, data.shootPos)
		if not shootRootTrans then
			BattleCore.es("没有找到发射点位")
			return
		end
		--鱼雷
		PoolMgr:Get(string.format(Config.PrefabPath.BulletPrefab, data.bulletName), function (torpedoObj)
			local blockObj = self:getBlockObj(blockid)
			local targetBlockObj = self:getBlockObj(targetBlockId)
			local startPos = shootRootTrans.position	--炮口
			local targetPos = targetBlockObj.transform.position + Vector3(0, offsetY, 0) --目标脚下地面
			local hitResult = data.hitResult
			local hitEffect	--命中特效
			local toward = targetPos - startPos	--默认方向打到目标脚下地面上
			--转换表现类型
			local disType = self:getDisTypeByHitType(hitResult.type, GE.TorpedoHitToDis)
			--未命中 则鱼雷穿过目标位置随机偏移并向后延伸随机1~2米
			if disType == GE.BulletDisType.Miss then
				local randomX = UnityEngine.Random.Range(0.1,0.2)
				local randomX = randomX * (math.random(0,1) == 0 and -1 or 1)
				local randomZ = UnityEngine.Random.Range(0.1,0.2)
				local randomZ = randomZ * (math.random(0,1) == 0 and -1 or 1)
				targetPos = targetPos + Vector3(randomX, 0, randomZ)
				toward = targetPos - (blockObj.transform.position + Vector3(0, offsetY, 0))
				local targetPos = targetPos + toward.normalized * UnityEngine.Random.Range(1, 2)
				toward = targetPos - startPos
			else
				local randomX = UnityEngine.Random.Range(-0.1,0.1)
				local randomZ = UnityEngine.Random.Range(-0.1,0.1)
				targetPos = targetPos + Vector3(randomX, 0, randomZ)
				--防护消耗
				if disType == GE.BulletDisType.DefReduce then
					hitEffect = 1084 --跳弹特效
				--擦弹和命中
				elseif disType == GE.BulletDisType.Partial then
					hitEffect = 1084
				elseif disType == GE.BulletDisType.Hit then
					hitEffect = data.hitEffect
				end
			end
			--射击特效
			local shootEffect = data.shootEffect
			if shootEffect then
				self:playEffect(startPos, shootEffect, Quaternion.LookRotation(-shootRootTrans.right, shootRootTrans.up) * Quaternion.Euler(0, 180, 0), nil, nil, nil, nil, shootRootTrans)
			end
			--烟雾特效
			local smoke = data.smoke
			if smoke then
				self:_DoAfter(smokeEffectDelay, function()
					self:playEffect(startPos, smoke, self:__getSmokeRotation(shootRootTrans))
				end)
			end
			--鱼雷流程 丢到水中->加速->命中或穿过
			--鱼雷起始位置
			torpedoObj.transform.position = startPos
			torpedoObj.transform:LookAt(targetPos)
			--鱼雷下落保持水平
			torpedoObj.transform.eulerAngles = Vector3(0, torpedoObj.transform.eulerAngles.y, 0)
			local block = self:getBlockByObj(blockObj)
			--鱼雷丢到水中位置
			local groundx = toward.normalized.x * UnityEngine.Random.Range(0.1,0.2)
			local groundz = toward.normalized.z * UnityEngine.Random.Range(0.1,0.2)
			-- local groundPos = blockObj.transform.position + Vector3(groundx, 0.2, groundz)
			local groundPos = Vector3(startPos.x, blockObj.transform.position.y + offsetY, startPos.z)
			local bezierPoint = self:getBezierPoint(startPos, targetPos, 0.2, Vector3(0, 0.3, 0))
			local distance = Vector3.Distance(targetBlockObj.transform.position , groundPos)
			local speed = 2 * Time.timeScale	--鱼雷下落速度
			local totalTime = distance/speed
			self:TorpedoDrop(torpedoObj, startPos, {}, groundPos, targetPos, totalTime, function()
				if hitEffect then
					self:playEffect(targetPos, hitEffect, nil, hitResult, GE.SkillPerformanceType.TorpedoAttack)
				end
				--伤害跳字
				if hitResult then
					self:playHitText(hitResult, targetRoleId, targetPos, disType)
				end
				PoolMgr.Free(torpedoObj)
				self:_DoAfter(perfTime + 1, function()
					if (callback) then
						callback()
					end
				end)
			end)
		end)
	end
end

---鱼雷下落
---@param torpedoObj GameObject	鱼雷对象
---@param startPos Vector3		起始位置
---@param bezierList Vector3[]		贝赛尔曲线点位集合 为空则为线性
---@param groundPos Vector3		水中位置
---@param targetPos Vector3		目标位置
---@param totalTime number		总时间
---@param callback function		命中回调
function BattleShowManager:TorpedoDrop(torpedoObj, startPos, bezierList, groundPos, targetPos, totalTime, callback)
	--落水加速
	local nextFunc = function(groundPos, targetPos)
		--开鱼雷特效
		self:setTorpedoEffect(torpedoObj, true)
		self:SetTrailEmitting(torpedoObj, true)
		BattleCore.ds("BattleShowManager:TorpedoAttack 落水完成 准备加速")
		local distance = Vector3.Distance(groundPos, targetPos)
		local speed = 1.5 * Time.timeScale
		local totalTime = distance/speed
		BattleCore.ds("BattleShowManager:TorpedoAttack 鱼雷加速目标位置: ", targetPos)
		torpedoObj.transform:LookAt(targetPos)
		torpedoObj.transform:DOLocalMove(targetPos, totalTime):SetEase(DG.Tweening.Ease.InQuad):OnComplete(
			function ()
				if callback then
					callback()
				end
			end
		)
		local soundPath = string.format(Config.AudioPath.SE, "fight_yulei")
		BattleCore.ds("BattleShowManager:TorpedoAttack 鱼雷加速音效", soundPath)
		self:play2DSound(soundPath)
	end
	--起始点在水下 需要直接释放
	if startPos.y < 0.5 then
		nextFunc(startPos, targetPos)
	else
		torpedoObj:SetActive(false)
		--关鱼雷特效
		self:setTorpedoEffect(torpedoObj, false)
		self:SetTrailEmitting(torpedoObj, false)
		--贝赛尔曲线 丢鱼雷
		self:startBezierMove(startPos, bezierList, groundPos, totalTime, 
			--落水过程	
			function(pos, progress)
				BattleCore.ds("BattleShowManager:TorpedoAttack 落水过程", progress)
				--鱼雷缩放
				local index = 0.8	--什么阶段scale变为1
				local scaleSpeed = 1/index
				local scale = progress * scaleSpeed >= 1 and 1 or progress * scaleSpeed
				torpedoObj.transform.localScale = Vector3(scale, scale, scale)
				torpedoObj.transform.position = pos
				torpedoObj:SetActive(true)
			end, 
			--落水完成 准备加速
			function()
				if nextFunc then
					nextFunc(groundPos, targetPos)
				end
			end
		)
	end
end

---护卫表现
---@class DataProtectAction
---@field roleId number		角色id
---@field protectedRoleId number 	被保护角色id
---@field isStart boolean	是否为开始护卫状态
---@field delay number		延迟
---@field blockId number	护卫者地块id
---@field protectedBlockId number	被保护者地块id
---@field sourceBlockId number		攻击者地块id
---@field isDead boolean	护卫者是否死亡	isStart为false时有效

---@param data DataProtectAction
function BattleShowManager:ProtectAction(data, callback)
	BattleCore.ds("BattleShowManager:ProtectAction", tablex.dump(data))
	local protectedRoleId = data.protectedRoleId
	self.protectedRoleId = protectedRoleId
	--护卫者死亡时 特殊处理
	if data.isStart == false and data.isDead == true then
		self:_showOrHideRole(self.rolesMap[protectedRoleId], true)
		self.protectedRoleId = nil
	else
		local roleId = data.roleId
		local role = self:getRole(roleId)
		local model = role.model
		local protectedRole = self:getRole(protectedRoleId)
		local protectedModel = protectedRole.model
	
		local blockid = data.blockId
		local protectedBlockId = data.protectedBlockId
		local sourceBlockId = data.sourceBlockId
		local protectorBlockObj = self:getBlockObj(blockid)	--护卫者地块
		local protectedBlockObj = self:getBlockObj(protectedBlockId)	--被保护者地块
		local sourceBlockObj = self:getBlockObj(sourceBlockId)	--攻击者地块
		--开始护卫
		if data.isStart then
			-- model:FadeIn()
			-- protectedModel:FadeOut()
			self:_showOrHideRole(self.rolesMap[protectedRoleId], false)
			--移动动作
			model:SetDefaultState(RoleAnimStateType.Into)
			role.controller.idleEFX:SetActive(false)
			--面朝被保护者地块
			local direction = protectedBlockObj.transform.position - protectorBlockObj.transform.position
			model.transform:DOLocalRotateQuaternion(Quaternion.LookRotation(direction), 0.1)
			role.root.transform:DOMove(protectedBlockObj.transform.position, 0.3/Time.timeScale):OnComplete(function()
				--到达目标点后 转向面朝攻击者地块
				local curDirection = self:getFaceToBlockDirection(self:getBlockByObj(protectedBlockObj), self:getBlockByObj(sourceBlockObj), role.model:GetNowDirectionType())
				--LuaLogger.ds("BattleShowManager:ProtectAction 护卫者转向面朝攻击者地块", curDirection)
				-- if (model) then
				-- 	model:TurnDirection(curDirection)
				-- end
				self:roleTurnDirection({
					id = role.roleId,
					direction = curDirection,
				})

				role.controller.idleEFX:SetActive(true)
				role.controller.intoEFX:SetActive(false)
				--待机动作
				model:SetDefaultState(RoleAnimStateType.IdleShip)
			end)
		else
			self.protectedRoleId = nil
			--回到原位
			-- model:FadeOut()
			-- protectedModel:FadeIn()
			self:_showOrHideRole(self.rolesMap[protectedRoleId], true)
			--移动动作
			model:SetDefaultState(RoleAnimStateType.Into)
			--面朝目标点
			local direction = protectorBlockObj.transform.position - protectedBlockObj.transform.position
			model.transform:DOLocalRotateQuaternion(Quaternion.LookRotation(direction), 0.1)
			role.controller.idleEFX:SetActive(false)
			role.root.transform:DOMove(protectorBlockObj.transform.position, 0.3/Time.timeScale):OnComplete(function()
				--回去的位置
				local curDirection = self:getFaceToBlockDirection(self:getBlockByObj(protectedBlockObj), self:getBlockByObj(protectorBlockObj), role.model:GetNowDirectionType())
				--LuaLogger.ds("BattleShowManager:ProtectAction 护卫者转向面朝攻击者地块", curDirection)
				-- if (model) then
				-- 	model:TurnDirection(curDirection)
				-- end
				self:roleTurnDirection({
					id = role.roleId,
					direction = curDirection,
				})
				--设置原始朝向
				local battleRole = BattleCore:getBattleRoleMgr():getRole(role.roleId)
				if battleRole then
					battleRole:setOrgDirection(curDirection)
				end
				role.controller.idleEFX:SetActive(true)
				role.controller.intoEFX:SetActive(false)
				--待机动作
				model:SetDefaultState(RoleAnimStateType.IdleShip)
			end)
		end
	end
	self:_DoAfter(0.5, function()
		if (callback) then
			callback()
		end
	end)
end

---撞击
---@class DataImpactAttack
---@field roleId number		角色id
---@field targetRoleId number 	被保护角色id
---@field delay number		延迟
---@field blockId number	护卫者地块id
---@field targetBlockId number	被保护者地块id
---@field sourceBlockId number		攻击者地块id
---@param data DataImpactAttack
function BattleShowManager:ImpactAttack(data, callback)
	BattleCore.ds("BattleShowManager:ImpactAttack", tablex.dump(data))
	local roleMgr = BattleCore:getBattleMgr():getRoleManager()
	local roleId = data.roleId
	local targetRoleId = data.targetRoleId
	local role = self:getRole(roleId)
	local model = role.model
	local targetRole = self:getRole(targetRoleId)
	local targetRoleModel = targetRole.model

	local blockid = data.blockId
	local targetBlockId = data.targetBlockId
	local sourceBlockId = data.sourceBlockId
	local blockObj = self:getBlockObj(blockid)
	local targetBlockObj = self:getBlockObj(targetBlockId)
	local sourceBlockObj = self:getBlockObj(sourceBlockId)

	--受击相关
	local hitResult = data.hitResult
	--转换表现类型
	local disType = self:getDisTypeByHitType(hitResult.type, GE.MissileHitToDis)
	--撞击特效
	local hitEffect = 1081
	local hitRootTrans, isSelf = self:__findHitPoint(targetRoleModel, 1)
	if not hitRootTrans then
		BattleCore.es("没有找到受击点位")
		return
	end
	--若是自身位置 则需要上移
	local hitPos = hitRootTrans.position	--角色受击位置
	if isSelf then
		hitPos = hitPos + Vector3(0,0.3,0)
	end

	--撞击相关
	--移动动作
	model:SetDefaultState(RoleAnimStateType.Into)
	role.controller.idleEFX:SetActive(false)
	--面朝目标点
	local direction = targetBlockObj.transform.position - blockObj.transform.position
	model.transform:DOLocalRotateQuaternion(Quaternion.LookRotation(direction), 0.1)
	local originPos = role.root.transform.position
	local targetPos = targetRole.root.transform.position + direction * -0.3
	hitPos = hitPos + direction * -0.3
	--开始撞击
	role.root.transform:DOMove(targetPos, 1):OnComplete(function()
		--伤害跳字
		if hitResult then
			self:playHitText(hitResult, targetRoleId, hitPos, disType)
		end
		--命中特效
		if hitEffect then
			self:playEffect(hitPos, hitEffect)
		end
		--碰撞抖动
		role.root.transform:DOShakePosition(0.3, Vector3(0.1, 0, 0.1), 20, 10):OnComplete(function()
			--撞击结束 归位
			role.root.transform:DOMove(originPos, 1):OnComplete(function()
				self:_DoAfter(1, function()
					if (callback) then
						callback()
					end
				end)
			end)
		end)
	end):SetEase(DG.Tweening.Ease.InBack)
end

--dotween位移
---@class RoleOffsetMoveData
---@field roleId number	角色id
---@field offset number	高度偏移量
---@param data RoleOffsetMoveData
function BattleShowManager:RoleOffsetMove(data, callback)
	BattleCore.ds("BattleShowManager:RoleOffsetMove", tablex.dump(data))
	local role = self:getRole(data.roleId)
	local model = role.model
	local originPos = model.transform.position
	model.transform:DOMoveY(originPos.y + data.offset, 1):OnComplete(function()
		if callback then
			callback()
		end
	end)
end

---导弹攻击
---@class BulletDataMissileAttack
---@field bulletName string			子弹名
---@field speed number			速度
---@field index number			发射点位index
---@field delay number			延迟时间 秒
---@field roleId number			角色id
---@field blockId number		源地块id
---@field targetBlockId number	目标地块id
---@field targetRoleId number	目标角色id
---@field hitEffect number		命中特效
---@field hitResult HitResult	伤害详情
---@field shootPos table		射击位置
---@field height number			导弹最高点高度

---@param data BulletDataMissileAttack
---@param callback function
function BattleShowManager:MissileAttack(data, callback)
	BattleCore.ds("BattleShowManager:MissileAttack", tablex.dump(data))
	local roleId = data.roleId
	local targetRoleId = data.targetRoleId
	local blockid = data.blockId
	local targetBlockId = data.targetBlockId
	local role = self:getRole(roleId)
	local model = role.model
	local targetRole = self:getRole(targetRoleId)
	local targetModel = targetRole.model
	local perfTime = 0
	if (model) then
		local shootRootTrans = self:__findShootPoint(model, data.shootPos)
		if not shootRootTrans then
			BattleCore.es("没有找到发射点位")
			return
		end
		local hitRootTrans, isSelf = self:__findHitPoint(targetModel, 1)
		if not hitRootTrans then
			BattleCore.es("没有找到受击点位")
			return
		end
		data.bulletName = "pd3"
		--导弹
		PoolMgr:Get(string.format(Config.PrefabPath.BulletPrefab, data.bulletName), function (missileObj)
			local blockObj = self:getBlockObj(blockid)
			local targetBlockObj = self:getBlockObj(targetBlockId)
			local startPos = shootRootTrans.position	--炮口
			local hitResult = data.hitResult
			local hitEffect	--命中特效
			local topPoint = startPos + Vector3(0, data.height, 0)	--导弹最高点
			local distance = Vector3.Distance(startPos, topPoint)
			local upTime = distance/(data.speed * 0.5)--导弹上升时间
			local targetPos = hitRootTrans.transform.position --导弹目标位置

			--距离目标点水平方向
			local horizontalDirection = targetPos - startPos
			horizontalDirection.y = 0
			--转换表现类型
			local disType = self:getDisTypeByHitType(hitResult.type, GE.MissileHitToDis)
			--未命中 导弹随机落到水中
			if disType == GE.BulletDisType.Miss then
				local randomX = UnityEngine.Random.Range(-0.5,0.5)
				local randomZ = UnityEngine.Random.Range(-0.5,0.5)
				targetPos = targetBlockObj.transform.position + Vector3(randomX, 0.5 + mapCubeOffsetY, randomZ)
				hitEffect = 1080	
			else
				--若是自身位置 则需要上移
				if isSelf then
					targetPos = targetPos + Vector3(0,0.3,0)
				end
				local randomX = UnityEngine.Random.Range(-0.1,0.1)
				local randomZ = UnityEngine.Random.Range(-0.1,0.1)
				targetPos = targetPos + Vector3(randomX, 0, randomZ)
				--跳弹
				if disType == GE.BulletDisType.Ricochet then
					hitEffect = 1083 --跳弹特效
				--擦弹和命中
				elseif disType == GE.BulletDisType.Partial then
					hitEffect = 1081
				elseif disType == GE.BulletDisType.Hit then
					hitEffect = data.hitEffect
				end
			end
			--射击特效
			local shootEffect = data.shootEffect
			BattleCore.ds("BattleShowManager:MissileAttack shootEffect 射击特效id", shootEffect)
			if shootEffect then
				self:playEffect(startPos, shootEffect, Quaternion.LookRotation(-shootRootTrans.right, shootRootTrans.up) * Quaternion.Euler(0, 180, 0), nil, nil, nil, nil, shootRootTrans)
			end
			--烟雾特效
			local smoke = data.smoke
			if smoke then
				self:_DoAfter(smokeEffectDelay, function()
					self:playEffect(startPos, smoke, self:__getSmokeRotation(shootRootTrans))
				end)
			end
			--导弹上升到最高点
			missileObj.transform.position = startPos
			missileObj.transform:LookAt(topPoint)
			missileObj.transform:DOMove(topPoint, upTime):OnComplete(function()
				--一边转向一边上升到前上方
				local speed = data.speed * 0.2 * Time.timeScale
				local startPos1 = missileObj.transform.position
				local targetPos1 = startPos1 + horizontalDirection.normalized * 0.3 + Vector3(0, 0.3, 0)
				local bezierPoint = self:getBezierPoint(startPos1, targetPos1, 0.5)
				bezierPoint.y = targetPos1.y
				local distance = Vector3.Distance(startPos1, targetPos1)
				local totalTime = distance/speed	--上升和转向时间
				--导弹上升到目标点
				self:startBezierMove(startPos1, {bezierPoint}, targetPos1, totalTime, 
					function(pos, progress)
						-- 改变飞机的方向，使其朝向目标位置
						missileObj.transform.position = pos
					end, 
					function()
					end
				)
				--面朝目标点
				local direction = targetPos - topPoint
				local rotateTime = totalTime	--转向时间
				missileObj.transform:DOLocalRotateQuaternion(Quaternion.LookRotation(horizontalDirection), rotateTime):OnComplete(function()
					local speed = data.speed * 2 * Time.timeScale
					local startPos1 = missileObj.transform.position
					local bezierPoint = self:getBezierPoint(startPos1, targetPos, 0.1, Vector3(0, 0.3, 0))
					local distance = Vector3.Distance(targetPos, startPos1)
					local totalTime = distance/speed	--俯冲时间
					--导弹冲向目标点
					self:startBezierMove(startPos1, {bezierPoint}, targetPos, totalTime, 
						function(pos, progress)
							-- 改变飞机的方向，使其朝向目标位置
							missileObj.transform.position = pos
						end, 
						function()
							if hitEffect then
								self:playEffect(targetPos, hitEffect, nil, hitResult, GE.SkillPerformanceType.MissileAttack)
							end
							--伤害跳字
							if hitResult then
								self:playHitText(hitResult, targetRoleId, targetPos, disType)
							end
							self:_DoAfter(1, function()
								if (callback) then
									callback()
								end
							end)
							PoolMgr.Free(missileObj)
						end
					)
					--导弹转向
					local finalDirection = targetPos - startPos1
					missileObj.transform:DOLocalRotateQuaternion(Quaternion.LookRotation(finalDirection), totalTime)
				end):SetEase(DG.Tweening.Ease.Linear)
			end):SetEase(DG.Tweening.Ease.Linear)
		end)
	end
end

---设置鱼雷特效
function BattleShowManager:setTorpedoEffect(obj, isShow)
	local trans = UICommonUtils.FindDeepChild(obj.transform, "Effect")
	if trans then
		trans.gameObject:SetActive(isShow)
	end
end

--设置拖尾发射状态
function BattleShowManager:SetTrailEmitting(obj, isEmitting)
	local trails = self:findComponent(obj, typeof(UnityEngine.TrailRenderer))
	for _, trail in pairs(trails) do
		trail.emitting = isEmitting
	end
end

--拖尾类特效结束 需要先隐藏meshrender 然后等待拖尾消失后再显示meshrender 然后free
function BattleShowManager:TrailEmittingEnd(obj)
	local maxTime = 0
	--关轨迹
	local trails = self:findComponent(obj, typeof(UnityEngine.TrailRenderer))
	for _, trail in pairs(trails) do
		trail.emitting = false
		maxTime = math.max(maxTime, trail.time)
	end
	--关模型
	local meshRenders = self:findComponent(obj, typeof(UnityEngine.MeshRenderer))
	for _, meshRender in pairs(meshRenders) do
		meshRender.enabled = false
	end
	self:_DoAfter(maxTime, function()
		--重新打开模型
		for _, meshRender in pairs(meshRenders) do
			meshRender.enabled = true
		end
		--销毁对象
		PoolMgr.Free(obj)
	end)
end

function BattleShowManager:findComponent(obj, component, result)
    result = result or {}
    local trans = obj.transform
    
    for i = 0, trans.childCount - 1 do
        local child = trans:GetChild(i)
        local childObj = child.gameObject
        
        local target = child:GetComponent(component)
        if target then
            table.insert(result, target)
        end
        
        -- 继续递归遍历
        self:findComponent(childObj, component, result)
    end
    
    return result
end

---显示技能效果
---@param pos Vector3	生成位置
---@param iconPath string	图标路径
---@param desc string	描述
function BattleShowManager:playEffText(pos, iconPath, desc)
	BattleCore.ds("BattleShowManager:playEffText", pos, iconPath, desc)
	local path = Config.PrefabPath.EffectText
	PoolMgr:Get(path, function (obj)
		if (obj) then
			BattleCore.ds("BattleShowManager:playEffText")
			--跳字转ui层
			local uiroot = UIMgr:GetUIRootParent()
			obj.transform:SetParent(uiroot.transform, false)
			self:addEffectTextList(obj, pos)	--添加到特效列表

			local textController = obj.transform:GetComponent("EffectTextController")
			local descText = textController.DescText	--textmeshpro
			local iconParent = textController.CircleRoot	--图标父节点
			local skillImage = textController.SkillIcon		--图标

			descText.text = desc
			iconParent.gameObject:SetActive(iconPath and iconPath ~= "")
			if iconPath then
				ResMgr:LoadSpriteAsyncInOwner(iconPath, function(s)
					if s and skillImage then
						skillImage.sprite = s
					end
				end, skillImage.gameObject)
			end
			self:_DoAfter(2, function()
				self:removeEffectTextList(obj)	--移除特效
			end)
		end
	end)
end

function BattleShowManager:RoleMaxHpChange(data, callback)
	local roleCtor = self:getRoleController(data.roleId)
	if roleCtor then
		roleCtor:SetHp(data.hp, data.maxHp)
	end
	local hpObj = self:getRoleHpObj(data.roleId)
	UICommonUtils.HP_SetHp(hpObj, data.hp, data.maxHp)
	if callback then
		callback()
	end
end

---16进制转color
---@param hex string 16进制
---@param alpha	number 透明度
---@return UnityEngine.Color
function BattleShowManager:HexToColor(hex, alpha)
    hex = hex:gsub("#", "")
    return UnityEngine.Color(
        tonumber("0x" .. hex:sub(1, 2)) / 255,
        tonumber("0x" .. hex:sub(3, 4)) / 255,
        tonumber("0x" .. hex:sub(5, 6)) / 255,
        1
    )
end

-- function BattleShowManager:getBezierPointV2(sPos, ePos, middleValue, curve)
-- 	return sPos + (ePos - sPos) * speedValue + Vector2.New(0,0,curveValue)
-- end

---计算三维贝塞尔点位（基于朝向的偏移，包含Y轴）
---@param sPos Vector3 起始点
---@param ePos Vector3 结束点
---@param middleValue number 0 ~ 1 插值比例
---@param curve Vector3 偏移量（x为横向，y为垂直方向，z为前进方向）
function BattleShowManager:getBezierPoint(sPos, ePos, middleValue, curve)
    local curve = curve or Vector3.zero
    local direction = (ePos - sPos).normalized  -- 获取从sPos指向ePos的单位方向向量
    
    -- 如果方向为零（起点和终点重合），则使用默认方向（Z轴正方向）
    if direction.magnitude == 0 then
        direction = Vector3.forward
    end
    
    -- 计算横向（右方向），垂直于运动方向和世界上方向（Y轴）
    local right = Vector3.Cross(Vector3.up, direction).normalized
    
    -- 计算上方向（垂直于运动方向和右方向）
    local up = Vector3.Cross(direction, right).normalized
    
    -- 将偏移量转换到世界坐标系（包含curve.y）
    local worldOffset = right * curve.x + up * curve.y + direction * curve.z
    
    -- 计算贝塞尔点并应用偏移
    return sPos + (ePos - sPos) * middleValue + worldOffset
end

---贝赛尔曲线移动
---@param startPos Vector3	起始点
---@param bezierPoint Vector3	贝塞尔点
---@param endPos Vector3	终点
---@param totalTime number	移动时间
---@param updateFunc function	更新回调
---@param endFunc function	结束回调
function BattleShowManager:startBezierMove(startPos, bezierPointList, endPos, totalTime, updateFunc, endFunc, curve)
	if not totalTime or totalTime == 0 then
		endFunc()
		BattleCore.ds("BattleShowManager:startBezierMove", "totalTime is 0,直接结束")
		return
	end
	local passTime = 0.02
	local currentTimes = 0
	local times = math.ceil(totalTime/passTime)
	local pointList = {}
	table.insert(pointList, startPos)
	for _, v in pairs(bezierPointList) do
		table.insert(pointList, v)
	end
	table.insert(pointList, endPos)
	BattleCore.ds("贝塞尔点位表", tablex.dump(pointList))
	self:_DoRepeat(passTime, times, function ()
		currentTimes = currentTimes + 1
		--到终点
		if (currentTimes == times) then
			if endFunc then
				endFunc()
			end
		else
			local progress = (currentTimes / times)
			--曲线
			local cueveProgress
			if curve then
				cueveProgress = curve:Evaluate(progress)
			end
			local nextPos = luautil.getBezierMultiple(pointList, cueveProgress or progress)
			if updateFunc then
				updateFunc(nextPos, progress)
			end
		end
	end)
end

---Buff行为
---@class data BuffBehaviorData
---@field id integer			角色id
---@field buffs integer[]		所有buff
function BattleShowManager:BuffBehavior(data, callback)
	BattleCore.ds("BattleShowManager:BuffBehavior RoleAnimState", tablex.dump(data))
	local role = self:getRole(data.id)
	if not role then
		if callback then
			callback()
		end
		return
	end
	local model = role.model
	local isAction = false
	--角色动作
	for k, id in pairs(data.buffs) do
		local buffConfig = Config.GetBuffInfo(id)
		if buffConfig.roleAction ~= "" then
			isAction = true
			model:SetDefaultState(RoleAnimStateType[buffConfig.roleAction])
			break
		end
	end
	--检测是否有新增特效
	for k, id in pairs(data.buffs) do
		local buffConfig = Config.GetBuffInfo(id)
		if buffConfig.effectOnHero ~= "" then
			if not self:getRoleEffectObjByBuffIdIsExist(data.id, id) then
				local pos = model.transform.position
				self:playEffect(pos, buffConfig.effectOnHero, nil, nil, nil, id, data.id)
			end
		end
	end
	--检测是否需要移除特效
	local RemovedList = {}
	for k, v in pairs(role.buffToeffectObj or {}) do
		if not tablex.contains(data.buffs, k) then
			PoolMgr.Free(v)
			role.buffToeffectObj[k] = nil
			table.insert(RemovedList, k)
		end
	end
	--若当前buff列表中没有改变默认动作 则检测消失的的buff中是否带动作 带了则重置角色状态
	if not isAction then
		for k, v in pairs(RemovedList) do
			local buffConfig = Config.GetBuffInfo(k)
			if buffConfig.effectOnHero ~= "" then
				model:SetDefaultState(RoleAnimStateType.IdleShip)
			end
		end
	end

	--位移相关
	local isDotween = false
	--buff改变角色位移
	for k, buffid in pairs(data.buffs) do
		local buffConfig = Config.GetBuffInfo(buffid)
		if buffConfig.roleOffset ~= nil then
			--新增
			if not self:getRoleOffsetByBuffId(data.id, buffid) then
				--todo dotween
				-- if battleRole then
				-- 	battleRole:RoleOffsetMoveReport(0, buffConfig.roleOffset)
				-- end
				isDotween = true
				self:RoleOffsetMove({
					roleId = data.id,
					offset = buffConfig.roleOffset,
				}, callback)
				self:setRoleOffsetByBuffId(data.id, buffid, buffConfig.roleOffset)
			end
		end
	end
	--检测是否需要还原位移
	local RemovedList = {}
	for k, v in pairs(role.buffToOffset or {}) do
		if not tablex.contains(data.buffs, k) then
			role.buffToOffset[k] = nil
			table.insert(RemovedList, k)
		end
	end
	for k, buffId in pairs(RemovedList) do
		local buffConfig = Config.GetBuffInfo(buffId)
		local offset = - buffConfig.roleOffset
		-- if battleRole then
		-- 	battleRole:RoleOffsetMoveReport(0, offset)
		-- end
		isDotween = true
		self:RoleOffsetMove({
			roleId = data.id,
			offset = offset,
		}, callback)
	end
	if not isDotween then
		callback()
	end
end

-- ---清除角色buffid绑定的位移
-- ---@param roleId integer	角色id
-- ---@param buffId integer	Buffid
-- function BattleShowManager:clearRoleOffsetByBuffId(roleId, buffId)
-- 	local role = self:getRole(roleId)
-- 	role.buffToOffset[buffId] = nil
-- end

---控制所有角色特效显隐
---@param bool boolean	是否显示
function BattleShowManager:SetAllRoleEffectObjActive(bool)
	for k, v in pairs(self.rolesMap) do
		local effectList = self:getRoleEffectObjByRoleId(v.roleId)
		if effectList then
			for _, effectObj in pairs(effectList) do
				effectObj:SetActive(bool)
			end
		end
	end
end

---@class RoleMoveData
---@field id integer			角色id
---@field path integer[]		路径
---@field blockId integer		地块id
---@field direction integer		方向

---角色移动(根据路径行动到目标点)
---@param data RoleMoveData
---@param callback function?
function BattleShowManager:roleMove(data, callback)
	local role = self:getRole(data.id)
	if (role == nil) then
		if (callback) then
			callback()
		end
		return
	end
	BattleCore.ds("BattleShowManager:roleMove", tablex.dump(data.path))
	local moveShowType = role.moveShowType
	--LuaLogger.ds("角色移动表现类型 moveShowType", moveShowType)
	if (data.path) then
		self:play2DSound(Config.AudioPath.RoleMove)
		-- self.cameraControl:SetFollowTarget(role.root.transform, GE.FollowTargetType.Move)
		self:setFollowTarget(role.root.transform, GE.FollowTargetType.Move)
		local model = role.model
		if (model) then
			--移动类型区分
			if moveShowType == 1 then
				model:SetDefaultState(RoleAnimStateType.Into2)
			else
				model:SetDefaultState(RoleAnimStateType.Into)
			end
			role.controller.idleEFX:SetActive(false)
			role.controller.intoEFX:SetActive(true)
		end

		--普通移动流程
		local move = function(f)
			local index = 1
			local startBlockObj = self:getBlockObj(data.path[index])
			local startBlock = self:getBlockByObj(startBlockObj)
			self:_moveToNext(role, data.path, startBlock, index + 1, data.direction, f)
		end

		--开始移动
		local start = function(f)
			if moveShowType == 1 then
				role.model:PlayAnim(RoleModelAnimEnum.Into2Start, function()
					move(f)
				end)
			else
				move(f)
			end
		end

		--移动结束
		local f = function ()
			if moveShowType == 1 then
				role.model:PlayAnim(RoleModelAnimEnum.Into2End, function()
					if callback then
						callback()
					end
				end)
				model:SetDefaultState(RoleAnimStateType.Into)
			else
				if callback then
					callback()
				end
			end
		end
		start(f)
	else
		local blockObj = self:getBlockObj(data.blockId)
		role.root.transform.position = blockObj.transform.position
		role.controller.idleEFX:SetActive(true)
		-- role.controller.intoEFX:SetActive(false)
		if (callback) then
			callback()
		end
	end
end

function BattleShowManager:selectRole(roleId)
	self:cancelSelectRole()
	local role = self:getRole(roleId)
	self._selectedRole = role
	if (self._selectedRole and self._selectedRole.model) then
		self._selectedRole.model:SetDefaultState(RoleAnimStateType.Into)
	end
end

function BattleShowManager:cancelSelectRole()
	if (self._selectedRole and self._selectedRole.model) then
		self._selectedRole.model:SetDefaultState(RoleAnimStateType.IdleShip)
	end
	self._selectedRole = nil
end

---角色移动(根据路径行动到目标点)
---@param role ShowManagerHeroData 角色数据
---@param blockList integer[] 路径
---@param curBlock BattleBlock 当前地块
---@param targetIndex integer 目标地块索引
---@param direction integer 方向
---@param callback function? 回调函数
function BattleShowManager:_moveToNext(role, blockList, curBlock, targetIndex, direction, callback)
	if (targetIndex > #blockList) then
		--移动完成
		self:activeCameraFollow(false)
		self:showFullMask(false)
		if (role) then
			local model = role.model
			if (model and direction) then
				-- model:TurnDirection(direction)
				self:roleTurnDirection({
					id = role.roleId,
					direction = direction,
				})
				
			end
			if (role.controller) then
				role.controller.idleEFX:SetActive(true)
				-- role.controller.intoEFX:SetActive(false)
			end
		end
		if (callback) then
			callback()
		end
		return
	end

	local targetBlockObj = self:getBlockObj(blockList[targetIndex])
	local targetBlock = self:getBlockByObj(targetBlockObj)
	local curDirection = self:getFaceToBlockDirection(curBlock, targetBlock, role.model:GetNowDirectionType())
	local model = role.model

	-- 将方向一致的目标合并处理
	local segmentEndIndex = targetIndex
	while segmentEndIndex < #blockList do
		local nextBlockObj = self:getBlockObj(blockList[segmentEndIndex + 1])
		local nextBlock = self:getBlockByObj(nextBlockObj)
		local segmentDirection = self:getFaceToBlockDirection(targetBlock, nextBlock, model:GetNowDirectionType())

		if segmentDirection ~= curDirection then
			break
		end
		segmentEndIndex = segmentEndIndex + 1
		curBlock = targetBlock
		targetBlockObj = nextBlockObj
		targetBlock = nextBlock
	end

	-- 角色转向，移动至目标
	if (model) then
		-- model:TurnDirection(curDirection)
		self:roleTurnDirection({
			id = role.roleId,
			direction = curDirection,
		})
		self:ObjectTurnDirection(role.controller.intoEFX, curDirection)
		local particle = role.controller.intoEFX.transform:Find("Effect"):GetComponent("ParticleSystem")
		particle:Simulate(0)
		particle:Play()
	end
	self:showFullMask(true, true)
	role.root.transform:DOMove(targetBlockObj.transform.position, 0.12 * (segmentEndIndex - targetIndex + 1)):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
		local nextIndex = segmentEndIndex + 1
		self:_moveToNext(role, blockList, targetBlock, nextIndex, direction, callback)
	end)
end

---物体转向
---@param obj GameObject
---@param direction GE.RoleDirectionType
function BattleShowManager:ObjectTurnDirection(obj, direction)
	if not obj or not obj.transform then
		BattleCore.es("BattleShowManager:ObjectTurnDirection: obj or obj.transform is nil")
		return
	end
	
	local targetDirection = Vector3.zero
	if direction == GE.RoleDirectionType.Up then
		targetDirection = Vector3.forward
	elseif direction == GE.RoleDirectionType.Down then
		targetDirection = Vector3.back
	elseif direction == GE.RoleDirectionType.Left then
		targetDirection = Vector3.left
	elseif direction == GE.RoleDirectionType.Right then
		targetDirection = Vector3.right
	end
	
	obj.transform:DOLookAt(obj.transform.position + targetDirection, 0.1):SetEase(DG.Tweening.Ease.Linear)
end

---角色待机
function BattleShowManager:roleStandby(data, callback)
	BattleCore.ds("BattleShowManager:roleStandby RoleAnimState", tablex.dump(data))
	local role = self:getRole(data.id)
	local delayTime = self._curFollowNeedMove and self._smoothMoveTime or 0
	self:_DoAfter(0.2 + delayTime, function()
		if (role and role.model) then
			role.model:SetDefaultState(RoleAnimStateType.IdleShip)
			role.controller.idleEFX:SetActive(true)
			-- role.controller.intoEFX:SetActive(false)
			self:_setRoleColor(role, roleUnactiveColor, 0.5)
		end
		self:_DoAfter(0.2, function()
            if (callback) then
                callback()
            end
        end)
    end)
end

---角色再行动或再移动时设置成激活颜色
---@param roleID integer
function BattleShowManager:roleReActivate(roleID)
	local role = self:getRole(roleID)
	if (role and role.model) then
		self:_setRoleColor(role, roleActiveColor, 0)
	end
end

---角色转向
---@class RoleTurnDirectionData
---@field id integer	角色id
---@field direction GE.RoleDirectionType	转向方向
---@param data RoleTurnDirectionData
---@param callback function?
function BattleShowManager:roleTurnDirection(data, callback)
	--LuaLogger.ds("Showmgr TurnDirection", debug.traceback())
	--LuaLogger.ds("Showmgr TurnDirection 方向", data.direction)
	local role = self:getRole(data.id)
	-- local spine = role.spine
	-- if (spine) then
	-- 	spine:TurnDirection(data.direction)
	-- end
	local model = role.model
	if (model) then
		model:TurnDirection(data.direction, callback)
		--同步修改battlerole的direction
		local roleList = BattleCore:getBattleRoleMgr():getRolesList()
		for k, v in pairs(roleList) do
			if data.id == v.id then
				v.direction = data.direction
				break
			end
		end
	end
end

---角色面向目标
---@class RoleFaceTofaceData
---@field id integer	角色id
---@field targetIds integer[]	目标角色id
---@field isStart boolean 是否为开始阶段
---@field attackNeedTurn boolean 攻击者是否需要转向
---@field targetNeedTurn boolean 受击者是否需要转向

---@param data RoleFaceTofaceData
---@param callback function?
function BattleShowManager:RoleFaceToface(data, callback)
	--LuaLogger.ds("BattleShowManager:RoleFaceToface TurnDirection", tablex.dump(data))
	local attackRole = self:getRole(data.id)
	--开始 面对面
	if data.isStart == true then
		if data.attackNeedTurn then
			--攻击者转向目标
			local targetRole = self:getRole(data.targetIds[1])
			if (attackRole and targetRole) then
				local attackModel = attackRole.model
				local targetModel = targetRole.model
				if (attackModel and targetModel) then
					local direction = targetModel.transform.position - attackModel.transform.position
					direction.y = 0 -- 保持水平面
					if direction ~= Vector3.zero then --屏蔽自己
						attackModel.transform.rotation = Quaternion.LookRotation(direction)
					end
				end
			end
		end
		if data.targetNeedTurn then
			--目标转向攻击者
			for k, v in pairs(data.targetIds) do
				local targetRole = self:getRole(v)
				if (targetRole) then
					local targetModel = targetRole.model
					if (targetModel) then
						local direction = attackRole.model.transform.position - targetModel.transform.position
						direction.y = 0 -- 保持水平面
						if direction ~= Vector3.zero then -- 屏蔽自己
							targetModel.transform.rotation = Quaternion.LookRotation(direction)
						end
					end
				end
			end
		end
		if (callback) then
			callback()
		end
	elseif data.isStart == false then
		local sum = tablex.size(data.targetIds) + 1
		local num = 0
		--转向完回调
		local doTweenCB = function()
			num = num + 1
			if (num >= sum) then
				if (callback) then
					callback()
				end
			end
		end
		--结束 归位
		local model = attackRole.model
		model:TurnDirection(model:GetNowDirectionType(), doTweenCB)
		for k, v in pairs(data.targetIds) do
			local targetRole = self:getRole(v)
			local targetModel = targetRole.model
			targetModel:TurnDirection(targetModel:GetNowDirectionType(), doTweenCB)
		end
	end
end

---角色拖动到格子外
function BattleShowManager:roleDragOutBlock(id)
	local role = self:getRole(id)
	self:_setRoleTintColor(role, roleSelectedColor)
end

---取消角色拖动
function BattleShowManager:cancelRoleDrag(id)
	local role = self:getRole(id)
	self:_setRoleTintColor(role, baseColor)
end

---角色激活状态
function BattleShowManager:roleActive(data, callback)
	local role = self:getRole(data.id)
	if (role) then
		self:_setRoleColor(role, roleActiveColor, 0)
	end
	if (callback) then
		callback()
	end
end

---所有角色激活状态
function BattleShowManager:allRoleActive(data, callback)
	for _, role in pairs(self.rolesMap) do
		self:_setRoleColor(role, roleActiveColor, 0)
	end
	if (callback) then
		callback()
	end
end

---@param data BattleMainPanelRoundShowType
function BattleShowManager:showBattleStart(data, callback)
	local type = data.showType
	UIMgr:popUI("BattleMainPanel")
	local clientBattleMgr = ClientBattleManager.getInstance()
	clientBattleMgr:initBattleSpeed()
	self:SetBattleMainPanelRoundShow(type)
	if (callback) then
		callback()
	end
end

---显示回合数
function BattleShowManager:showBattleRound(data, callback)
	if (callback) then
		callback()
	end
end

---显示当前阵营
---@param data CampReportData
---@param callback function
function BattleShowManager:showCurrCamp(data, callback)
	UIMgr:popUI("BattleMainPanel")
	---@type BattleMainPanelRoundShowType?
	local state = nil
	local num = nil
	if data.camp == GE.BattleCampType.Friend then
		state = GE.BattleMainPanelRoundShowType.MyTurn
		num = data.round
	elseif data.camp == GE.BattleCampType.Enemy then
		state = GE.BattleMainPanelRoundShowType.EnemyTurn
	end
	if state then
		self:SetBattleMainPanelRoundShow(state, num)
	end
	if (callback) then
		callback()
	end
end

---@param state BattleMainPanelRoundShowType
---@param num integer?
function BattleShowManager:SetBattleMainPanelRoundShow(state, num)
	self._uiBattleMain.ui:ShowRound(state, num)
end

function BattleShowManager:refreshBattleMainPanelBossScore(data, callback)
	self._uiBattleMain.ui:refreshBossScore(data.totalValue)
	if (callback) then
		callback()
	end
end

---打开战斗界面
function BattleShowManager:openBattleMainPanel(callback)
	UIMgr:popUI("BattleMainPanel", nil, nil, nil, nil, function()
		self._uiBattleMain = UIMgr:getUIData("BattleMainPanel")
		UIMgr:depositUI(self._uiBattleMain.ui)
		if (callback) then
			callback()
		end
	end)
end

---关闭战斗界面
function BattleShowManager:hideBattleMainPanel()
	UIMgr:closeSpecificUI("BattleMainPanel")
	self._uiBattleMain = nil
end

---刷新战斗界面
function BattleShowManager:refreshBattleMainPanel()
	if (self._uiBattleMain) then
		self._uiBattleMain.ui:refreshPanel()
	end
end

---显示地块信息
function BattleShowManager:showBlockInfo(blockInfo)
	if (self._uiBattleMain) then
		self._uiBattleMain.ui:showBlockInfo(blockInfo)
	end
end

---隐藏地块信息
function BattleShowManager:hideBlockInfo()
	if (self._uiBattleMain) then
		self._uiBattleMain.ui:hideBlockInfo()
	end
end

---显示角色信息
function BattleShowManager:showRoleInfo(roleInfo)
	if (self._uiBattleMain) then
		self._uiBattleMain.ui:showRoleInfo(roleInfo)
	end
end

---隐藏角色信息
function BattleShowManager:hideRoleInfo()
	if (self._uiBattleMain) then
		self._uiBattleMain.ui:hideRoleInfo()
	end
end

---显示角色行动界面
function BattleShowManager:showRoleAction(role, actionType)
	if (self._uiBattleMain) then
		self._uiBattleMain.ui:showRoleAction(true, role, actionType)
	end
end

---隐藏角色行动界面
function BattleShowManager:hideRoleAction()
	if (self._uiBattleMain) then
		self._uiBattleMain.ui:showRoleAction(false)
		self._uiBattleMain.ui:showMainGroup(true)
	end
end

---显示自动模式隐藏组
function BattleShowManager:showAutoModeHideGroup(isShow)
	if (self._uiBattleMain) then
		self._uiBattleMain.ui:showAutoModeHideGroup(isShow)
	end
end

---显示战斗场景
function BattleShowManager:showSceneRoot(isShow)
	if UICommonUtils.Checkobj(self.sceneRootObj) then
		self.sceneRootObj.gameObject:SetActive(isShow)
	end
end

---显示战斗背景
function BattleShowManager:showBackground(isShow)
	if UICommonUtils.Checkobj(self.backgroundObj) then
		self.backgroundObj.gameObject:SetActive(isShow)
	end
end

---显示战斗场景边界线
function BattleShowManager:showEdgesLine(isShow)
	if UICommonUtils.Checkobj(self.sceneEdgesLine) then
		self.sceneEdgesLine.gameObject:SetActive(isShow)
	end
end

---显示战斗场景边界特效
function BattleShowManager:showEdgesWall(isShow)
	if UICommonUtils.Checkobj(self.sceneEdgesLine) then
		self.sceneEdgesWall.gameObject:SetActive(isShow)
	end
end

--显示战斗镜面反射渲染
function BattleShowManager:showBattlePRRenderer(isShow)
	if UICommonUtils.Checkobj(self.planarReflectionRendererObj) then
		self.planarReflectionRendererObj.gameObject:SetActive(isShow)
	end
end

---显示角色伤害跳字
---@param data HitReportData
---@param callback function?
function BattleShowManager:showHitNumber(data, callback)
	BattleCore.ds("BattleShowManager:showHitNumber", tablex.dump(data))
	local roleCtor = self:getRoleController(data.id)
	local hpObj = self:getRoleHpObj(data.id)
	if (roleCtor == nil) then
		if (callback) then
			callback()
		end
		return
	end
	local perfTime = 1
	local isRepair = (data.isRepair == nil) and false or data.isRepair
	local isCrit = (data.isCrit == nil) and false or data.isCrit
	local restraintCoeff = (data.restraintCoeff == nil) and 1 or data.restraintCoeff

	local hitRootPos = roleCtor.hitTextRoot.transform.position	--角色跳字默认位置
	local path = Config.PrefabPath.HitText
	PoolMgr:Get(path, function (obj)
		if (obj) then
			BattleCore.ds("BattleShowManager:showHitNumber")
			local textController = obj.transform:GetComponent("HitTextController")
			local totalText = textController.totalText:GetComponent(TypeInfo.Text)
			local hitTextParent = textController.hitTextParent	   --分段伤害
			local totalTextParent = textController.totalTextParent --总伤害
			local totalRoot = textController.totalRoot			--总伤害父节点

			local healTextParent = textController.healTextParent	--治疗
			local healText = textController.healText:GetComponent(TypeInfo.Text)
			local healRoot = textController.healRoot				--治疗父节点

			hitTextParent:SetActive(false)
			totalTextParent:SetActive(not isRepair)
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
				targetText = totalText
				targetRoot = totalRoot
				--最终跳字是否需要显示 总伤害 字样
				textController.totalIcon:SetActive(data.hasPerf)
			end
			targetRoot.transform.localScale = Vector3(1, 1, 1)
			--跳字位置
			local targetPos = hitRootPos --角色脑袋顶上的hitRootPos（battlerole预制体）
			--跳字转ui层
			local uiroot = UIMgr:GetUIRootParent()
			obj.transform:SetParent(uiroot.transform, false)
			local camera = self.camera
			local width = self.screen_width
			local height = self.screen_height
			local result = camera:WorldToViewportPoint(targetPos)
			self:addHitTextList(obj, targetPos)	--添加到跳字列表
			local finalPos = Vector3.New(result.x * width - width/2, result.y * height - height/2, 0)
			obj.transform.localPosition = finalPos
			--伤害显示
			local tempList = self:splitDamageText(tostring(data.dmg), targetText, targetRoot, hitJumpSpace, hitJumpInterval)
			--血条修改 有表现则不再次修改
			if not data.hasPerf then
				UICommonUtils.HP_ChangeHp(hpObj, data.dmg, isRepair, roleCtor)
				roleCtor:ChangeHp(data.dmg, isRepair)
			end
			self:_DoAfter(1.5, function()
				-- PoolMgr.Free(obj)
				self:removeHitTextList(obj)	--移除跳字列表
				for k, v in pairs(tempList) do
					v:Destroy()
				end
			end)
			BattleCore.ds("BattleShowManager:showHitNumber end")
		end
	end)
	self:_DoAfter(perfTime, function()
		-- self:showFullMask(false)
		if (callback) then
			callback()
		end
	end)
end

---处理受击数据
---@class HitResult table 受击数据
---@field type BulletHitType 受击类型
---@field dmg number 伤害
---@field isCrit boolean 是否暴击
---@field restraintCorrect number 克制系数

---@param data HitData 受击数据
---@return HitResult[]
function BattleShowManager:ProcessHitData(data)
	BattleCore.ds("处理受击数据", tablex.dump(data))
	--命中子弹数量 默认全额伤害 系数1
	local hitMax = math.floor(data.hitNumCorrect)
	local hitMin = math.floor(data.hitNumCorrect / 2.0)
	local hitNum = math.random(hitMin, hitMax)
	--未命中子弹数量 0伤害
	local missNum = math.random(0, data.bulletNum - math.ceil(data.hitNumCorrect))	
	--擦弹子弹数量
	local PartialNum = data.bulletNum - missNum - hitNum
	local PartialFactor = data.hitNumCorrect - hitNum		--擦弹中弹系数
	local factorList = self:generateRandomNumbers(PartialFactor, PartialNum)
	--打包伤害数据
	local tempResult = {}
	--命中伤害计算
	for i = 1, hitNum do
		local temp = {
			type = GE.BulletHitType.Hit,
			dmg = math.floor(data.singleBulletDmg),
			isCrit = data.isCrit,
			restraintCorrect = data.restraintCorrect
		}
		table.insert(tempResult, temp)
	end
	--擦弹伤害计算
	for _, factor in pairs(factorList) do
		local temp = {
			type = GE.BulletHitType.Partial,
			dmg = math.floor(factor * data.singleBulletDmg),
			isCrit = data.isCrit,
			restraintCorrect = data.restraintCorrect
		}
		--0.5 ~ 1的伤害系数算作命中
		if factor > 0.5 then
			temp.type = GE.BulletHitType.Hit
		end
		table.insert(tempResult, temp)
	end
	--miss伤害计算
	for i = 1, missNum do
		local temp = {
			type = GE.BulletHitType.Miss,
			dmg = 0,
			isCrit = data.isCrit,
			restraintCorrect = data.restraintCorrect
		}
		table.insert(tempResult, temp)
	end
	---@type HitResult[]
	local result = {}
	--打乱顺序
	while tablex.size(tempResult) > 0 do
		local randomIndex = math.random(1, tablex.size(tempResult))
		table.insert(result, tempResult[randomIndex])
		table.remove(tempResult, randomIndex)
	end
	BattleCore.ds("子弹伤害详情", tablex.dump(result))
	local dmgSum = 0
	for _, v in pairs(result) do
		dmgSum = dmgSum + v.dmg
	end
	local remainDmg = data.dmgValue - dmgSum
	local index = 1
	while remainDmg > 0 and index <= #result do
		local single = result[index]
		while single.dmg < math.floor(data.singleBulletDmg) do
			single.dmg = single.dmg + 1
			-- print(string.format("第%s子弹填补后伤害:%s",index, single.dmg))
			remainDmg = remainDmg - 1
			if remainDmg <= 0 then
				break
			end
		end
		result[index] = single
		index = index + 1
	end
	--防止一点伤害没有正确补入命中计算中，导致最后一点伤害没有正确显示出来的问题。
	if remainDmg > 0 then
		for _, v in pairs(result) do
			if v.type ~= GE.BulletHitType.Miss then
				v.dmg = v.dmg + remainDmg
				remainDmg = 0
				break
			end
		end
	end
	--没有不为miss的子弹就只能加在miss上
	if remainDmg > 0 then
		local single = result[tablex.size(result)]
		single.dmg = single.dmg + remainDmg
	end
	BattleCore.ds("修正后的子弹详情", tablex.dump(result))
	--检测是否有伤害补正并且原本为miss的伤害
	for _, v in pairs(result) do
		if v.dmg > 0 and v.type == GE.BulletHitType.Miss then
			v.type = GE.BulletHitType.Partial
		end
	end
	return result
end

function BattleShowManager:randomBetween(min, max)
    return min + math.random() * (max - min)
end

function BattleShowManager:generateRandomNumbers(x, n)
    local randomNumbers = {}
    local sum = 0
    
    for i = 1, n-1 do
        local remindValue = x - sum
		local average = (remindValue / (n - i + 1))
        -- local minValue = remindValue - math.floor(remindValue)
        local randomNumber = self:randomBetween(average / 2, math.min(1.0, average * 2))
        sum = sum + randomNumber
        table.insert(randomNumbers, randomNumber)
    end
    
    local lastNumber = x - sum
    table.insert(randomNumbers, lastNumber)
    
    return randomNumbers
end

---角色高亮设置
function BattleShowManager:setRoleHighlight(data, callback)
	local role = self:getRole(data.id)
	role.model:SetHighlight(data.state)
	if (callback) then
		callback()
	end
end

---所有角色高亮设置
function BattleShowManager:setAllRoleHighlight(data, callback)
	for _, role in pairs(self.rolesMap) do
		if role ~= nil and role.model then
			role.model:SetHighlight(data.state)
		end
	end
	if (callback) then
		callback()
	end
end

---显示效果提示
---@class EffectTipData table
---@field effectDesc string 效果提示名称
---@field delay number 表现延时
---@field effectId integer 特效id
---@field id integer 角色id
---@field icon string 图标路径
---@field modelOffset number 角色偏移量
---@field effectAct string 动作名称

---@param data EffectTipData
function BattleShowManager:showEffectTip(data, callback)
	BattleCore.ds("BattleShowManager:showEffectTip", tablex.dump(data))
	local roleCtor = self:getRoleController(data.id)
	if (roleCtor == nil) then
		if (callback) then
			callback()
		end
		return
	end
	local pos = roleCtor.modelController.roleObj.transform.position
	--新增偏移量
	if data.modelOffset then
		pos = pos + Vector3.New(0, -data.modelOffset, 0)
	end
	--特效持续时间
	local effectTime = 0
	local textpos = roleCtor.hitTextRoot.transform.position + Vector3.New(0, 0.3, 0)
	if tonumber(data.effectId) then
		effectTime = self:playEffect(pos, data.effectId)
	end
	--描述
	if data.effectDesc then
		local desc = tostring(data.effectDesc)
		local strList = string.utfchars(desc)
		local length = tablex.size(strList)
		if length > 0 then
			local iconPath
			if data.icon and data.icon ~= "" then
				iconPath = string.format(Config.SpritePath.SkillIconPath, data.icon)
			end
			self:playEffText(textpos, iconPath, desc)
		end
		--角色动作
		local effectAct = data.effectAct
		if effectAct and effectAct ~= "" then
			local role = self:getRole(data.id)
			role.model:PlayAnim(RoleModelAnimEnum[effectAct])
		end
	end
	self:_DoAfter(0.3 + effectTime, function()
		if (callback) then
			callback()
		end
	end)
end

---取消显示技能特效
function BattleShowManager:removeSkillTypeIcon()
	local roles = self.rolesMap
	for _, role in pairs(roles) do
		local skillIconObj = role.SkillIconObj
		if skillIconObj then
			UICommonUtils.HP_OpenSkillTypeIcon(skillIconObj, false)
		end
	end
end

---显示技能类型图标
---@param roleId integer 角色id
---@param skillConfig SkillTable 技能配置
---@param showType integer 0是未选择技能，1是一次扩散，2是二次扩散
function BattleShowManager:showSkillTypeIcon(roleId, skillConfig, showType)
	local roleCtor = self:getRoleController(roleId)
	local skillIconObj = self:getRoleSkillIconObj(roleId)
	if roleCtor then
		local atkCalculateType = skillConfig.atkCalculateType
		UICommonUtils.HP_OpenSkillTypeIcon(skillIconObj, true)
		local skillType = 1
		if showType == 1 then
			skillType = 4
		else
			if atkCalculateType == GE.SkillCalculateType.Normal or atkCalculateType == GE.SkillCalculateType.AirDefense then
				if skillConfig.attackDamageType == GE.SkillDamageType.Bombard then
					skillType = 1
				elseif skillConfig.attackDamageType == GE.SkillDamageType.Torpedo then
					skillType = 2
				end
			elseif atkCalculateType == GE.SkillCalculateType.Repair then
				skillType = 3
			elseif atkCalculateType == GE.SkillCalculateType.NonDamage then
				skillType = 4
			end
		end
		local path = string.format(Config.SpritePath.SkillTypeIconPath, skillType)
		ResMgr:LoadSpriteAsyncInOwner(path, function(s)
			if s and skillIconObj then
				UICommonUtils.HP_SetSkillTypeIcon(skillIconObj, s)
			end
		end, skillIconObj.gameObject)
	end
end

---取消显示技能克制图标
function BattleShowManager:removeSkillCountIcon()
	local roles = self.rolesMap
	for _, role in pairs(roles) do
		local hpObj = role.hpObj
		UICommonUtils.HP_OpenSituationIcon(hpObj, false)
	end
end

---显示技能克制图标
---@param roleId integer 角色id
---@param countNum number 克制系数
function BattleShowManager:showSkillCountIcon(roleId, countNum)
	local roleCtor = self:getRoleController(roleId)
	local hpObj = self:getRoleHpObj(roleId)
	if roleCtor then
		local skillType = 1
		if countNum > 1 then
			skillType = 1
		elseif countNum < 1 then
			skillType = 2
		end
		local needShow = countNum ~= 1
		UICommonUtils.HP_OpenSituationIcon(hpObj, needShow)
		if needShow then
			local path = string.format(Config.SpritePath.SkillCounterIconPath, skillType)
			ResMgr:LoadSpriteAsyncInOwner(path, function(s)
				if s and hpObj then
					UICommonUtils.HP_SetSituationIcon(hpObj, s)
				end
			end, hpObj)
		end
	end
end

-- ---显示目标特效
-- function BattleShowManager:showTargetEffect(data, callback)
-- 	local blockObj = self:getBlockObj(data.blockId)
-- 	local name = "Effect_GeZi_2"
-- 	PoolMgr:Get(string.format(Config.PrefabPath.BattleEffect, name, name), function (effectObj)
-- 		effectObj.transform.position = blockObj.transform.position + Vector3.New(0,0.5,0)
-- 		effectObj:SetActive(true)
-- 		table.insert(self._targetEffectList, effectObj)
-- 		if (callback) then
-- 			callback()
-- 		end
-- 	end)
-- end

---移除目标特效
function BattleShowManager:removeTargetEffect()
	self:clearSkillEffectRangeTimer()
	self:_freeObjects(self._targetEffectList)
	self._targetEffectList = {}
end

---@class TargetEffectedData
---@field blockId integer 地块id
---@field camp BattleCampType 阵营枚举 用来显示不同特效

---显示目标二次选中作用格子特效
---@param data TargetEffectedData
---@param callback function?
function BattleShowManager:showTargetEffectedEffect(data, callback)
	--LuaLogger.ds("BattleShowManager:showTargetEffectedEffect", debug.traceback())
	local blockObj = self:getBlockObj(data.blockId)
	local name
	local enemyEffect = "Effect_Common_JiNengZuoYongGeZi"
	local allyEffect = "Effect_Common_JiNengZuoYongGeZi_02"
	if data.camp == GE.BattleCampType.Enemy then
		name = enemyEffect
	else
		name = allyEffect
	end
	PoolMgr:Get(string.format(Config.PrefabPath.BattleEffect, name, name), function (effectObj)
		effectObj.transform.position = blockObj.transform.position + Vector3.New(0,0.5 + mapCubeOffsetY,0)
		effectObj:SetActive(true)
		table.insert(self._targetEffectList, effectObj)
		if (callback) then
			callback()
		end
	end)
end

---重置战场
function BattleShowManager:resetWholeBattle()
	self:_recreateAllRole()
end

---重新创建所有角色
function BattleShowManager:_recreateAllRole()
	self:_removeAllRole()
	self.rolesMap = {}
	local battleMgr = BattleCore:getBattleMgr()
	local rolesList = battleMgr:getRoleManager():getRolesList()
	for _, role in ipairs(rolesList) do
		-- LuaLogger.ds("BattleShowManager:_recreateAllRole block.id",role.block.id)
		local skinConfig = {}
		if role.isMonster then
			skinConfig = Config.GetCharacterSkinInfo(role.roleConfig.baseSkinID)
		else
			skinConfig = Config.GetCharacterSkinInfo(role.serverData.equipSkin)
		end
		---@type RoleCreateData
		local data = {
			id = role.id,
			blockId = role.block.id,
			image = skinConfig.modelKey,
			modelRate = skinConfig.modelRate,
			modelOffset = skinConfig.modelOffset,
			hpBarOffset = skinConfig.HpBarOffset,
			skillTypeIconOffset = skinConfig.skillTypeIconOffset,
			moveShowType = skinConfig.moveShowType,
			direction = role.direction,
			hp = role:getAttrib(GE.AttribType.Hp),
			maxHp = role:getAttrib(GE.AttribType.MaxHp),
			camp = role.camp,
			buffList = role.buffController:getBuffList(),
			attribute = role.roleConfig.attribute,
			isShow = true,
			isShowEffect = false,
		}
		self:roleCreate(data, function()
			local roleObj = self:getRole(role.id)
            if roleObj ~= nil then
                if (battleMgr:getRoleManager():isActionCompleted(role)) then
                    self:_setRoleColor(roleObj, roleUnactiveColor, 0.5)
                else
                    self:_setRoleColor(roleObj, roleActiveColor, 0)
                end
            else
                BattleCore.ds("BattleShowManager:_recreateAllRole roleObj is nil" .. role.id)
            end
		end)
	end
end

---重置地图数据
function BattleShowManager:resetMapData()
	self.blocksMap = {}
	local battleMgr = BattleCore:getBattleMgr()
	for id, blockObj in pairs(self.blocksObjMap) do
		local block = battleMgr:getBlockById(id)
		self.blocksMap[blockObj] = block
	end
end

---移动视野到指定地块 战报驱动
---@class BlockReportData
---@field blockId integer 地块id
---@field isDoTween boolean 是否使用缓动
---@field progress number? 回调触发进度

---@param data BlockReportData
---@param CB function 回调函数
function BattleShowManager:LookAtBlockReport(data, CB)
	BattleCore.ds("BattleShowManager:lookAtBlockReport camera", data.blockId, data.isDoTween)
	local temp
	if data.isDoTween then
		temp = {
			time = 1
		}
	end
	self:lookAtBlock(data.blockId, temp, function()
		if CB then
			CB()
		end
	end, data.progress)
end

---移动视野
function BattleShowManager:activeCameraFollow(isActive)
	if (not isActive) then
		self:setFollowTarget(nil)
	end
end

---设置跟随目标报告
---@class smoothFollowTargetReportData
---@field blockId number? 					地块id
---@field type FollowTargetType 			追踪类型
---@field isEdge boolean? 				是否需要移动到边缘
---@field data smoothFollowTargetReportData 追踪目标数据

function BattleShowManager:SmoothFollowTargetReport(data, callback)
	local temp = {
		targetPos = self:getBlockObj(data.blockId).transform.position,
		type = data.type or GE.FollowTargetType.Move,
		isEdge = data.isEdge or false
	}
	self:smoothFollowTarget(temp, callback)
end

---@class smoothFollowTargetData
---@field targetPos UnityEngine.Vector3 	目标位置
---@field type FollowTargetType 			追踪类型
---@field isEdge boolean 					是否需要移动到边缘

---用dotween来平滑移动镜头（直接调用或战报调用）
---@param data smoothFollowTargetData
---@param callback function?
function BattleShowManager:smoothFollowTarget(data, callback)
	BattleCore.ds("BattleShowManager:smoothFollowTarget camera", debug.traceback())
	BattleCore.ds("BattleShowManager:smoothFollowTarget data", tablex.dump(data))
	local type = data.type or GE.FollowTargetType.Move
	local camera = self.camera
	local bounds = self.cameraFollowBounds[type]
	local targetPos = data.targetPos
    local targetViewportPosition = camera:WorldToViewportPoint(targetPos)
    local BattleMainPanel = UIMgr:GetUI("BattleMainPanel")
	self._curFollowNeedMove = targetViewportPosition.x < bounds[1] or targetViewportPosition.x > (1 - bounds[2]) or targetViewportPosition.y < bounds[3] or targetViewportPosition.y > (1 - bounds[4])
	--更新跟随框
	if BattleMainPanel then
		BattleMainPanel:focusLineOnSelected(type)
	end
	--防止上次timer清除本次跟随框
	if self.smoothFollowClearTimer then
		DLuaTimer:RemoveTimer(self.smoothFollowClearTimer)
		self.smoothFollowClearTimer = nil
	end
    -- 如果目标超出屏幕区域
	self:showFullMask(true, true)
	local newRootPos = Vector3(targetPos.x, 0.25, targetPos.z)
	BattleCore.ds("BattleShowManager:smoothFollowTarget 是否出界", self._curFollowNeedMove)
    if self._curFollowNeedMove then
		--是否需要移动到边界
		if data.isEdge then
			-- 计算镜头需要移动的位置
			if (targetViewportPosition.x < bounds[1]) then
				targetViewportPosition.x = bounds[1]
			elseif (targetViewportPosition.x > (1 - bounds[2])) then
				targetViewportPosition.x = (1 - bounds[2])
			end
			if (targetViewportPosition.y < bounds[3]) then
				targetViewportPosition.y = bounds[3]
			elseif (targetViewportPosition.y > (1 - bounds[4])) then
				targetViewportPosition.y = (1 - bounds[4])
			end
			-- 修正：使用射线检测获取准确的地面交点 计算修正后的z深度
			local ray = camera:ViewportPointToRay(targetViewportPosition)
			-- LuaLogger.ds("ray", tablex.dump(ray))
			local groundPlane = Plane.New(Vector3.up, -targetPos.y)
			-- LuaLogger.ds("groundPlane", tablex.dump(groundPlane))
			local _, rayEnter = groundPlane:Raycast(ray)
			local edgePos = ray:GetPoint(rayEnter)
			BattleCore.ds("edgePos", tablex.dump(edgePos))
			local direction = targetPos - edgePos
			newRootPos = self.cameraRoot.transform.position + direction
		end
		self._smoothMoveTime = 0.8
		self.cameraRoot.transform:DOLocalMove(newRootPos, self._smoothMoveTime):SetEase(DG.Tweening.Ease.InOutQuad):OnComplete(function()
            self._smoothMoveTime = 0
			self._curFollowNeedMove = false
			self:showFullMask(false, true)
			if callback then
				--清除跟随框
				if BattleMainPanel then
					BattleMainPanel:clearfocusLineSelected()
				end
				callback()
			end
		end):OnUpdate(function()
			self:RefreshCameraMatrix()
		end)
	else
		self:showFullMask(false, true)
		self.smoothFollowClearTimer = self:_DoAfter(0.5, function()
			--清除跟随框
			if BattleMainPanel then
				BattleMainPanel:clearfocusLineSelected()
			end
		end)
		if callback then
			callback()
		end
	end
end

-- 定义镜头追踪函数 update中调用
---@param target UnityEngine.Transform
---@param smoothTime number
function BattleShowManager:smoothFollow(target, smoothTime)
	local camera = self.camera
	local type = self.followTargetType or GE.FollowTargetType.Move
	local bounds = self.cameraFollowBounds[type]
    local targetViewportPosition = camera:WorldToViewportPoint(target.position)
	local velocity = Vector3.zero  -- 定义速度变量
	local BattleMainPanel = UIMgr:GetUI("BattleMainPanel")
    
	local curFollowNeedMove = targetViewportPosition.x < bounds[1] or targetViewportPosition.x > (1 - bounds[2]) or targetViewportPosition.y < bounds[3] or targetViewportPosition.y > (1 - bounds[4])
	if BattleMainPanel then
		BattleMainPanel:focusLineOnSelected(type)
	end
    -- 如果目标超出屏幕区域
    if curFollowNeedMove then
		self.smoothFollowLastTime = os.time()
        -- 计算镜头需要移动的位置
        if (targetViewportPosition.x < bounds[1]) then
			targetViewportPosition.x = bounds[1]
		elseif (targetViewportPosition.x > (1 - bounds[2])) then
			targetViewportPosition.x = (1 - bounds[2])
		end
		if (targetViewportPosition.y < bounds[3]) then
			targetViewportPosition.y = bounds[3]
		elseif (targetViewportPosition.y > (1 - bounds[4])) then
			targetViewportPosition.y = (1 - bounds[4])
		end
		local newRootPos = camera:ViewportToWorldPoint(targetViewportPosition)
		newRootPos.y = 0.25
        -- 使用平滑追踪移动镜头
		local  targetPos = Vector3.SmoothDamp(self.cameraRoot.transform.localPosition, newRootPos, velocity, smoothTime)
		local dis = Vector3.Distance(self.cameraRoot.transform.localPosition, targetPos)
        self.cameraRoot.transform.localPosition = Vector3.SmoothDamp(self.cameraRoot.transform.localPosition, newRootPos, velocity, smoothTime)
		self:RefreshCameraMatrix()
	end
end

function BattleShowManager:rotateVector(vector, angleDegrees)
    local angleRadians = math.rad(angleDegrees)
    local cos = math.cos(angleRadians)
    local sin = math.sin(angleRadians)

    local newX = vector.x * cos - vector.y * sin
    local newY = vector.x * sin + vector.y * cos

    return {x = newX, y = newY}
end

---获取角色Lua类
---@param roleObj UnityEngine.GameObject 角色实例化对象
---@return BattleRole?
function BattleShowManager:getBattleRoleByObj(roleObj)
	if (self.rolesDataMap[roleObj]) then
		local battleMgr = BattleCore:getBattleMgr()
		local role = battleMgr:getRoleManager():getRole(self.rolesDataMap[roleObj].roleId)
		return role
	end
	return nil
end

function BattleShowManager:_freeObjects(objList)
	for _, obj in pairs(objList) do
		PoolMgr.Free(obj)
	end
	-- objList = {}
end

--设置角色TimeLine动画
---@param id number 角色id
---@param timeline string 导演节点标签（如 "Atk", "Start"）或旧的TimeLine名称（用于兼容）
---@param skinConfig table 角色皮肤配置
---@param callBack function 回调函数
function BattleShowManager:setPlayableAsset(id, timeline, skinConfig, callBack)
	local role = self:getRole(id)
	if (not role) or (not role.model) or (not role.model.timelineMgr) then
		BattleCore.ws("BattleShowManager:setPlayableAsset skip, timeline file missing", id, timeline)
		if callBack then
			callBack()
		end
		return
	end
	if (not timeline) or timeline == "" then
		BattleCore.ws("BattleShowManager:setPlayableAsset skip, empty timeline", id)
		if callBack then
			callBack()
		end
		return
	end
	local hasDirectors = role.model.timelineMgr.directors ~= nil and role.model.timelineMgr.directors.Length > 0
	if not hasDirectors then
		BattleCore.ws("BattleShowManager:setPlayableAsset skip, no timeline directors", id, timeline)
		if callBack then
			callBack()
		end
		return
	end
	-- local battleMgr = BattleCore:getBattleMgr()
	-- local battleRole = battleMgr:getRoleManager():getRole(id)
	local hpObj = self:getRoleHpObj(id)
	self:showSceneRoot(false)
	self:showBackground(false)
	local BattleMainPanel = UIMgr:GetUI("BattleMainPanel")
	if BattleMainPanel then
		BattleMainPanel:showMainGroup(false)
	end
	-- self._uiBattleMain.ui:showMainGroup(false)
	self:showEdgesLine(false)
	--特效
	self:SetAllRoleEffectObjActive(false)
	
	-- 新的标签系统	
	role.model.timelineMgr:BindTrackForAllDirectors("model", role.model.roleObj)
	
	role.controller.idleEFX:SetActive(false)
	local originalFogState = UnityEngine.RenderSettings.fog
	UnityEngine.RenderSettings.fog = false
	--玩家cutIn摄像机开启
	role.model.timelineMgr.effectPoint:SetActive(true)
	role.model.timelineMgr.cutInCamera:SetActive(true)
	role.model:PlanarShadowEnable(false)
	--role.model:SetEmotionLookAt(role.model.CameraObj)
	self:hideOtherRole(id)
	if hpObj then
		UICommonUtils.Hp_SetUIRootActive(hpObj, false)
	end
	self:hideEventObj()
	self:setSceneEffectState(false)
	self:setBattleUIFogState(false)
	BattleCore.ds("播放 Timeline:", timeline)
	-- 使用新的标签播放方式
	role.model.timelineMgr:Play(timeline)
	
	-- 使用标签系统设置回调
	role.model.timelineMgr:SetOverCallBack(timeline, function()
		UICommonUtils.Hp_SetUIRootActive(role.hpObj, true)
		role.model.timelineMgr.cutInCamera:SetActive(false)
		role.controller.idleEFX:SetActive(true)
		-- role.controller.intoEFX:SetActive(false)
		self:showSceneRoot(true)
		self:showBackground(true)
		self:showEdgesLine(true)
		--特效
		self:SetAllRoleEffectObjActive(true)
		-- role.model.roleObj.transform.parent.transform:GetComponent("ProgressiveMeshRuntime").enabled = true
		if callBack then
			callBack()
		end
		UnityEngine.RenderSettings.fog = originalFogState
		
		if BattleMainPanel then
			BattleMainPanel:openBtnList()
		end
		-- self:showAllRole()
		self:showOtherRole(self.protectedRoleId)
		self:openEventObj()
		self:setSceneEffectState(true)
		self:setBattleUIFogState(true)
		role.model:PlanarShadowEnable(true)
		--role.model:SetEmotionLookAt(self.cameraObj)	--设置模型的表情朝向
	end)
end

--创建地图特殊格子(事件系统调用)
function BattleShowManager:creatSpecialAreaObj(path, idList, offset, eventId)
	for _, blockId in pairs(idList) do
		PoolMgr:Get(path, function (obj)
			local areaObj = obj
			local blockObj = self:getBlockObj(blockId)
			if blockObj then
				local needPos = Vector3.New(blockObj.transform.position.x + offset[1], blockObj.transform.position.y + offset[2], blockObj.transform.position.z + offset[3])
				areaObj.transform.position = needPos
				if offset[4] then
					areaObj.transform.localScale = Vector3.New(offset[4], offset[4], offset[4])
				end
				areaObj:SetActive(true)

				if eventId then
					if not self._eventObjlist[eventId] then
						self._eventObjlist[eventId] = {}
					end
					table.insert(self._eventObjlist[eventId], areaObj)
				end
			end
		end)
	end
end

--移除事件预制体
function BattleShowManager:removeEventObj(eventId)
	if self._eventObjlist[eventId] then
		self:_freeObjects(self._eventObjlist[eventId])
		self._eventObjlist[eventId] = {} 
	end
end

function BattleShowManager:removeAllEventObj()
	for eventId, objList in pairs(self._eventObjlist) do
		self:_freeObjects(objList)
	end
	self._eventObjlist = {}
end

---移除事件预制体数据
---@class RemoveEventObjReportData
---@field eventId integer 事件id

---移除事件预制体（战报驱动）
---@param data RemoveEventObjReportData 事件数据
function BattleShowManager:RemoveEventObjReport(data, callback)
	BattleCore.ds("BattleShowManager:RemoveEventObjReport", tablex.dump(data))
	self:removeEventObj(data.eventId)
	local battleMgr = BattleCore:getBattleMgr()
	local battleEventMgr = battleMgr:getBattleEventManager()
	battleEventMgr:removeRemovePrefIdList()
	if callback then
		callback()
	end
end

--隐藏所有事件预制体
function BattleShowManager:hideEventObj()
	for eventId, objList in pairs(self._eventObjlist) do
		for _, obj in pairs(objList) do
			obj:SetActive(false)
		end
	end
end

--显示所有事件预制体
function BattleShowManager:openEventObj()
	for eventId, objList in pairs(self._eventObjlist) do
		for _, obj in pairs(objList) do
			obj:SetActive(true)
		end
	end
end

--隐藏其他角色
function BattleShowManager:hideOtherRole(roleId)
	for id, role in pairs(self.rolesMap) do
		self:_showOrHideRole(role, id == roleId)
	end
end

--显示其他角色
function BattleShowManager:showOtherRole(roleId)
	for id, role in pairs(self.rolesMap) do
		self:_showOrHideRole(role, id ~= roleId)
	end
end

--根据列表隐藏其他角色
function BattleShowManager:hideOtherRoleByIdList(roleIdList)
	for id, role in pairs(self.rolesMap) do
		local isShow = tablex.contains(roleIdList, id)
		self:_showOrHideRole(role, isShow)
	end
end

--显示所有角色
function BattleShowManager:showAllRole(hpIsShow)
	for _, role in pairs(self.rolesMap) do
		self:_showOrHideRole(role, true, hpIsShow)
	end
end

--显示所有角色
function BattleShowManager:hideAllRole()
	for _, role in pairs(self.rolesMap) do
		self:_showOrHideRole(role, false)
	end
end

--AVG播放
function BattleShowManager:playAVG(data, callback)
	BattleCore.ds("PlayAVG")
	--隐藏UI
	UIMgr:closeUI("BattleMainPanel")
	self:refreshSelectedCube()

	local plotId = data.id
	local storyConfig = Config.GetStoryArraryInfo(plotId)
	if storyConfig.type == 3 then--战中演出
		local storyMgr = BattleCore:getBattleStoryManager()
		storyMgr:setDialogMode(true)
		storyMgr:initDialogMode(plotId)
		storyMgr:setEndCallbackFunc(function()
			BattleCore.ds("BattleShowManager:playAVG 战中演出结束")
			local clientBattleMgr = ClientBattleManager.getInstance()
			clientBattleMgr:setIsPlayAVGReport(false)
			UIMgr:popUI("BattleMainPanel")
			storyMgr:setDialogMode(false)
			---战斗演出结束后，需要播放战报来创建和移除角色，创建和移除角色会影响攻击范围，故计算所有角色行动范围
			local battleMgr = BattleCore:getBattleMgr()
			battleMgr:setTiming(GE.BattleTiming.PlayAVGEnd)
			---剧情插入的战报需要插入到当前正在播放的战报队列中，否则无法控制战斗流程
			clientBattleMgr:insertReports()
			if (callback) then
				callback()
			end
			local roleMgr = battleMgr:getRoleManager()
			roleMgr:calculateAllRolesActionRange()
			storyMgr:clear()
		end)
	elseif storyConfig.type == 2 then--AVG演出
		UIMgr:popUI("StoryPanel", {storyName = storyConfig.storyArrary[1],callBack = function()
			if storyConfig.storyArrary[2] then
				UIMgr:closeUI("BattleMainPanel")
				UIMgr:popUI("StoryPanel", {storyName = storyConfig.storyArrary[2],callBack = function()
					UIMgr:popUI("BattleMainPanel")
					if (callback) then
						callback()
					end
				end})
			else
				UIMgr:popUI("BattleMainPanel")
				if (callback) then
					callback()
				end
			end
		end})
	end
end

--设置故事已生成角色地块id列表
function BattleShowManager:setStoryRoleBlockIdList(data)
	for cidOrId, blockId in pairs(data) do
		self._storyRoleBlockIdList[blockId] = cidOrId
	end
end

---跳字显示
function BattleShowManager:hitDisplay()
	
end

--设置测试用演出id
function BattleShowManager:SetEnterBattleTestId(id)
	self._enterBattleTestId = id
end

---开始战斗演出 敌人
---@param callback any
function BattleShowManager:PlayStartBattleEnemy(callback)
	local battleMgr = BattleCore:getBattleMgr()
	local levelConfig = battleMgr:getLevelConfig()
	BattleCore.ds("BattleShowManager:PlayStartBattleEnemy levelConfig", tablex.dump(levelConfig))
	local data = levelConfig.timeLine
	local reportData
	if data then
		local battleRoleManager = BattleCore:getBattleRoleMgr()
		local battleRole = battleRoleManager:getRoleByCidNoCamp(data[1])
		if battleRole then
			local battleMgr = BattleCore:getBattleMgr()
			battleMgr:getReporter():packStep()
			local id = battleRole.id
			local skinConfig = battleRole.skinConfig
			reportData = {
				id = id,
				timeline = data[2],
				skinConfig = skinConfig,
				delay = 0,
				name = data[3],
				desc = data[4],
			}
		end
		--boss登场timeline
		self:roleTimeline(reportData, function()
			if callback then
				callback()
			end
		end)
	else
		if callback then
			callback()
		end
	end
end

---角色模型仅绕 Y 轴朝向指定水平方向
---@param modelTransform UnityEngine.Transform
---@param faceDir UnityEngine.Vector3
function BattleShowManager:setRoleModelYRotationByDir(modelTransform, faceDir)
	faceDir.y = 0
	if faceDir.sqrMagnitude < 0.0001 then
		return
	end
	-- 打断布阵创建时 TurnDirection 的 DOLocalRotate，避免刚设完朝向又被 tween 盖掉
	modelTransform:DOKill(false)
	modelTransform.rotation = Quaternion.LookRotation(faceDir.normalized, Vector3.up)
end

---获取战斗演出 roleLight
---@return UnityEngine.GameObject?
function BattleShowManager:getEnterBattleRoleLight()
	return UnityEngine.GameObject.Find("SceneRoot/Directional Light/Role Light")
end

---获取 roleLight 水平朝向的相反方向（角色正面迎光）
---@param roleLight UnityEngine.GameObject?
---@return UnityEngine.Vector3?
function BattleShowManager:getRoleFaceDirOppositeRoleLight(roleLight)
	if not roleLight then
		return nil
	end
	local lightForward = roleLight.transform.forward
	lightForward.y = 0
	if lightForward.sqrMagnitude < 0.0001 then
		return nil
	end
	return -lightForward.normalized
end

---获取战斗演出角色朝向：迎光后再向右偏转
---@param roleLight UnityEngine.GameObject?
---@return UnityEngine.Vector3?
function BattleShowManager:getEnterBattleShowFaceDir(roleLight)
	local faceDir = self:getRoleFaceDirOppositeRoleLight(roleLight)
	if not faceDir then
		return nil
	end
	local rot = Quaternion.Euler(0, enterBattleShowRoleYawOffset, 0) * Quaternion.LookRotation(faceDir, Vector3.up)
	local rotatedFace = rot * Vector3.forward
	rotatedFace.y = 0
	if rotatedFace.sqrMagnitude < 0.0001 then
		return faceDir
	end
	return rotatedFace.normalized
end

---固定 roleLight 的世界X轴旋转为10度，实现俯视效果
---@param roleLight UnityEngine.GameObject?
function BattleShowManager:applyEnterBattleRoleLightRotation(roleLight)
	if not roleLight then
		return
	end
	if not self._originEnterBattleRoleLightEuler then
		self._originEnterBattleRoleLightEuler = roleLight.transform.rotation.eulerAngles
	end
	local euler = self._originEnterBattleRoleLightEuler
	-- ToLua 的 Quaternion.Euler 需传 x,y,z 三个参数，不能传 Vector3
	roleLight.transform.rotation = Quaternion.Euler(
		enterBattleShowRoleLightPitchOffset, euler.y, euler.z)
end

---恢复 roleLight 到原始旋转
function BattleShowManager:restoreEnterBattleRoleLightRotation()
	if not self._originEnterBattleRoleLightEuler then
		return
	end
	local euler = self._originEnterBattleRoleLightEuler
	local roleLight = self:getEnterBattleRoleLight()
	if roleLight and euler then
		roleLight.transform.rotation = Quaternion.Euler(euler.x, euler.y, euler.z)
	end
	self._originEnterBattleRoleLightEuler = nil
end

---准备战斗演出：计算朝向并调整 roleLight（需在改光前计算朝向）
---@param roleLight UnityEngine.GameObject?
---@return UnityEngine.Vector3?
function BattleShowManager:prepareEnterBattleShow(roleLight)
	local faceDir = self:getEnterBattleShowFaceDir(roleLight)
	self:applyEnterBattleRoleLightRotation(roleLight)
	return faceDir
end

---将演出局部偏移转换为世界偏移（相对角色朝向：x 左，z 前）
---@param faceDir UnityEngine.Vector3?
---@param localOffset UnityEngine.Vector3
---@return UnityEngine.Vector3
function BattleShowManager:getShowOffsetInWorld(faceDir, localOffset)
	if not faceDir then
		return localOffset
	end
	faceDir.y = 0
	if faceDir.sqrMagnitude < 0.0001 then
		return localOffset
	end
	faceDir = faceDir.normalized
	local rightDir = Vector3.Cross(Vector3.up, faceDir).normalized
	local leftDir = -rightDir
	return leftDir * localOffset.x + faceDir * localOffset.z
end

---设置战斗入场镜头轨道根节点位置与朝向
---@param anchorPos UnityEngine.Vector3
---@param faceDir UnityEngine.Vector3?
function BattleShowManager:setupEnterBattlePathTransform(anchorPos, faceDir)
	if not self._enterBattlePathObj then
		return
	end
	local pos = Vector3.New(anchorPos.x, 0, anchorPos.z)
	self._enterBattlePathObj.transform.position = pos + Vector3.New(0, mapCubeOffsetY, 0)
	if faceDir then
		faceDir.y = 0
		if faceDir.sqrMagnitude > 0.0001 then
			self._enterBattlePathObj.transform.rotation = Quaternion.LookRotation(faceDir.normalized, Vector3.up)
		end
	end
end

---开始战斗演出,移动角色到指定位置，并播放对应动画
---@param trans UnityEngine.Transform? 相机注视目标（位移锚点）
---@param roleIdList integer[]
---@param blockIdList UnityEngine.Vector3[] 相对锚点、相对朝向的位移列表，x:左 z:前
---@param callBack function
function BattleShowManager:PlayStartBattle(trans, roleIdList, blockIdList, callBack)
	local roleLight = self:getEnterBattleRoleLight()
	local faceDir = self:prepareEnterBattleShow(roleLight)
	local showPosList = {}
	local posCount = 0
	local animName = RoleModelAnimEnum.Start
	local num = 0
	local showList = {}
	local aniFuncList = {}
	local anchorPos = trans and trans.position or Vector3.zero()
	for index, roleId in ipairs(roleIdList) do
		num = num + 1
		--上阵角色数量大于演出地块数量
		if num > tablex.size(blockIdList) then
			-- LuaLogger.ws("BattleShowManager:PlayStartBattle num > blockIdList", num .. "  " .. #blockIdList)
			break
		end
		table.insert(showList, roleId)
		local roleObj = self:getRole(roleId)
		if roleObj and roleObj.model then
			local roleRootTrans = roleObj.root.transform
			local offset = blockIdList[index]
			local roleY = roleRootTrans.position.y
			local worldOffset = self:getShowOffsetInWorld(faceDir, offset)
			local newPos = Vector3.New(anchorPos.x + worldOffset.x, roleY, anchorPos.z + worldOffset.z)
			roleRootTrans.position = newPos
			if faceDir then
				self:setRoleModelYRotationByDir(roleObj.model.transform, faceDir)
			end
			if animName and string.len(animName) > 0 then
				local func = function()
					roleObj.model:PlayAnim(animName)
				end
				table.insert(aniFuncList, func)
			end
			posCount = posCount + 1
			showPosList[posCount] = newPos
		end
	end
	local aniFunc = function()
		for _, func in pairs(aniFuncList) do
			func()
		end
	end
	self:hideEventObj()
	self:showEdgesLine(false)
	self:showEdgesWall(false)
	self:setSceneEffectState(false)
	self:formationRangeSetActive(false)
	self:hideOtherRoleByIdList(showList)
	--关闭所有角色血条
	self:setAllHpDis(false)
	self:setAllBlockTagDis(false)
	
	if posCount == 0 then
		aniFunc()
		self:restoreEnterBattleRoleLightRotation()
		callBack()
	else
		self:BattleVcamPath(trans, callBack, showPosList, aniFunc, faceDir)
	end
end

--- 战斗演出路径播放（开场退场等）
---@param trans UnityEngine.Transform? --注视目标
---@param CB function CB
---@param showPosList UnityEngine.Vector3[] --位置列表
---@param aniFunc function? 演出过程中需要播放动画时的回调函数
---@param faceDir UnityEngine.Vector3? 角色朝向（用于镜头轨道根节点旋转）
function BattleShowManager:BattleVcamPath(trans, CB, showPosList, aniFunc, faceDir)
	--同步位置
	local pos = trans and trans.position or showPosList[1]
	--注视目标
	if trans then
		self._enterBattleVcam.LookAt = trans
	end
	self:setupEnterBattlePathTransform(pos, faceDir)
	--动态调整相机注视点高度 默认为角色脖颈位置
	self._enterBattleVcam:GetCinemachineComponent(Cinemachine.CinemachineCore.Stage.Aim).m_TrackedObjectOffset
		= Vector3.New(0, 0.9 * scaleIndex, 0)
	--随机表现 todo
	local actionList = {
		[1] = {	--平滑旋转
			NeedDollyCart = true,
			pathName = "DollyTrack1"
		},
		[2] = {	--平滑旋转-正对中心拉远 变fov
			NeedDollyCart = true,	--不用虚拟相机的path 用dollycart插件
			pathName = "DollyTrack2"
		},
		-- [5] = {	--人物中心头顶上方-正对人物后退+往下
		-- 	NeedDollyCart = true,	
		-- 	pathName = "DollyTrack3"
		-- },
		[3] = {	--右前方旋转到正面
			NeedDollyCart = true,	
			pathName = "DollyTrack4",
		},
		[4] = {	--再由近拉远
			NeedDollyCart = true,	
			pathName = "DollyTrack5",
		},
	}
	local actionId = math.random(1, #actionList)
	if self._enterBattleTestId then
		actionId = self._enterBattleTestId
		self._enterBattleTestId = nil
	end
	BattleCore.ds("BattleShowManager:BattleVcamPath actionId", actionId)
	--区分表现类型 虚拟相机 trackedDolly or dollycart
	--虚拟相机 trackedDolly 通过直接修改m_Path的m_Position来让他自动过度到目标点 path units方式
	-- dollycart 通过自己绘制曲线来update中修改进度 Normalized方式
	if actionList[actionId].NeedDollyCart then
		self:ClearDollyCart()
		self._pathDollyCart.enabled = true
		self:DollyCartSetPath(actionList[actionId].pathName)
		self:BattleVcamSetPath(nil)
	else
		self._pathDollyCart.enabled = false
		self:BattleVcamSetPath(actionList[actionId].pathName)
		self._enterBattleVcam:GetCinemachineComponent(Cinemachine.CinemachineCore.Stage.Body).m_PathPosition = 0
	end
	--默认fov 60
	self:ChangeEnterBattleFov(60)
	local start = function()
		if aniFunc then
			aniFunc()
		end
		local mainPriority = self.mainVcam:GetComponent(TypeInfo.CinemachineVirtualCamera).Priority
		self._enterBattleVcam.Priority = mainPriority + 1
	end
	if actionId == 1 then
		-- start()
		-- self:_DoAfter(0.1, function()
		-- 	self._enterBattleVcam:GetCinemachineComponent(Cinemachine.CinemachineCore.Stage.Body).m_PathPosition = 1
		-- 	self:_DoAfter(3, function()
		-- 		CB()
		-- 	end)
		-- end)
		ResMgr:LoadCurveLibraryAsyncInOwner(Config.AssetFile.CurveLibrary, function(lib)
			start()
			local curve = lib:GetCurve("EnterBattle1")
			local totalTime = 3
			self:CurveSequence(curve, totalTime, function(progress)
				if progress >= 1 then
					self:ClearCurveSequence()
					CB()
				end
			end)
		end, ResMgr:GetResCarrier())
	elseif actionId == 2 then
		ResMgr:LoadCurveLibraryAsyncInOwner(Config.AssetFile.CurveLibrary, function(lib)
			start()
			local curve = lib:GetCurve("EnterBattle2")
			local key1 = curve.keys[1]	--转折点位
			local fovSwitch1 = false
			local totalTime = 3
			self:CurveSequence(curve, totalTime, function(progress)
				if progress >= key1.time and not fovSwitch1 then
					fovSwitch1 = true
					DG.Tweening.DOVirtual.Float(60, 65, (1 - key1.time) * totalTime, function(v)
						self:ChangeEnterBattleFov(v)
					end)
				end
				if progress >= 1 then
					self:ClearCurveSequence()
					CB()
				end
			end)
		end, ResMgr:GetResCarrier())
	elseif actionId == 5 then
		ResMgr:LoadCurveLibraryAsyncInOwner(Config.AssetFile.CurveLibrary, function(lib)
			start()
			local startFov = 40
			local curve = lib:GetCurve("EnterBattle3")
			local totalTime = 3
			local key1 = curve.keys[1]	--最高点位
			local key2 = curve.keys[2]	--极速下落开始缓动点位
			local fovChange1 = 60
			local fovSwitch1 = false --fov变化标记
			local fovAhead = 0.2 --fov提前变化点位百分比

			local fovChange2 = 20
			local fovSwitch2 = false --fov变化标记
			local fovLast2 = 0.5 --fov变化时间占key1到key2百分比

			local fovChange3 = 60
			local fovSwitch3 = false --fov变化标记
			local fovLast3 = 0.5 --fov变化时间占key1到key2百分比
			self:ChangeEnterBattleFov(startFov)
			self:CurveSequence(curve, totalTime, function(progress)
				--一阶段相机缓速上移 聚焦人脸 最高点前放大fov
				-- if progress >= (key1.time - fovAhead) and not fovSwitch1 then
				-- 	LuaLogger.ds("BattleShowManager:BattleVcamPath fovSwitch1", progress)
				-- 	fovSwitch1 = true
				-- 	DG.Tweening.DOVirtual.Float(startFov, fovChange1, totalTime * fovAhead, function(v)
				-- 		self:ChangeEnterBattleFov(v)
				-- 	end)
				-- --二阶段相机急速下落 fov先变小
				-- elseif progress >= key1.time and not fovSwitch2 then
				-- 	LuaLogger.ds("BattleShowManager:BattleVcamPath fovSwitch2", progress)
				-- 	fovSwitch2 = true
				-- 	DG.Tweening.DOVirtual.Float(fovChange1, fovChange2, totalTime * fovLast2 * (key2.time - key1.time), function(v)
				-- 		self:ChangeEnterBattleFov(v)
				-- 	end)
				-- --二阶段相机继续急速下落 fov后变大
				-- elseif progress >= (key1.time + fovLast3 * (key2.time - key1.time)) and not fovSwitch3 then
				-- 	LuaLogger.ds("BattleShowManager:BattleVcamPath fovSwitch3", progress)
				-- 	fovSwitch3 = true
				-- 	DG.Tweening.DOVirtual.Float(fovChange2, fovChange3, totalTime * fovLast3 * (key2.time - key1.time), function(v)
				-- 		self:ChangeEnterBattleFov(v)
				-- 	end)
				if progress >= 1 then
					self:ClearCurveSequence()
					CB()
				end
			end)
		end, ResMgr:GetResCarrier())
	elseif actionId == 3 then
		ResMgr:LoadCurveLibraryAsyncInOwner(Config.AssetFile.CurveLibrary, function(lib)
			start()
			local curve = lib:GetCurve("EnterBattle4")
			--一段
			self:CurveSequence(curve, 3, function(progress)
				if progress >= 1 then
					self:ClearCurveSequence()
					CB()
				end
			end)
		end, ResMgr:GetResCarrier())
	elseif actionId == 4 then
		ResMgr:LoadCurveLibraryAsyncInOwner(Config.AssetFile.CurveLibrary, function(lib)
			start()
			local curve = lib:GetCurve("EnterBattle5")
			--一段
			self:CurveSequence(curve, 3, function(progress)
				if progress >= 1 then
					self:ClearCurveSequence()
					CB()
				end
			end)
		end, ResMgr:GetResCarrier())
	end
end

function BattleShowManager:ClearDollyCart()
	if self._pathDollyCart then
		self._pathDollyCart.m_Speed = 0
		self._pathDollyCart.m_Position = 0
	end
end

---设置DollyCart的路径
---@param pathString string 路径字符串 
function BattleShowManager:DollyCartSetPath(pathString)
	if pathString then
		local pathObj = self._enterBattlePathObj.transform:Find(pathString)
		local m_Path
		if pathObj then
			m_Path = pathObj:GetComponent("CinemachinePath")
		end
		if m_Path then
			self._pathDollyCart.m_Path = m_Path
		end
	else
		self._pathDollyCart.m_Path = nil
	end
end

---设置虚拟相机路径
---@param pathString string 路径字符串
function BattleShowManager:BattleVcamSetPath(pathString)
	if pathString then
		local pathObj = self._enterBattlePathObj.transform:Find(pathString)
		local m_Path
		if pathObj then
			m_Path = pathObj:GetComponent("CinemachinePath")
		end
		if m_Path then
			self._enterBattleVcam:GetCinemachineComponent(Cinemachine.CinemachineCore.Stage.Body).m_Path = m_Path
		end
	else
		self._enterBattleVcam:GetCinemachineComponent(Cinemachine.CinemachineCore.Stage.Body).m_Path = nil
	end
end

function BattleShowManager:ChangeEnterBattleFov(fov)
	if not self._enterBattleVcam_m_Lens then
		self._enterBattleVcam_m_Lens = self._enterBattleVcam.m_Lens
	end
	self._enterBattleVcam_m_Lens.FieldOfView = fov
	self._enterBattleVcam.m_Lens = self._enterBattleVcam_m_Lens
end

---曲线序列播放
---@param curve UnityEngine.AnimationCurve 曲线
---@param totalTime number 总时间
---@param cb function update回调函数
function BattleShowManager:CurveSequence(curve, totalTime, cb)
	if self.vcamPathUpdate then
		self.vcamPathUpdate = nil
		self.vcamPathUpdateStart = 0
	end
	self.vcamPathUpdateStart = UnityEngine.Time.time
	totalTime = totalTime / Time.timeScale
	self.vcamPathUpdate = function()
		local progress = (UnityEngine.Time.time - self.vcamPathUpdateStart) / totalTime
		self._pathDollyCart.m_Position = curve:Evaluate(progress)
		cb(progress)
	end
end

---清除曲线序列
function BattleShowManager:ClearCurveSequence()
	self.vcamPathUpdate = nil
	self.vcamPathUpdateStart = 0
end

---结束战斗演出,移动角色到指定位置
---@param roleIdList integer[]
---@param blockIdList integer[]
---@param dirList RoleDirectionType[]
---@param callBack function
function BattleShowManager:endPlayEnterBattle(roleIdList, blockIdList, dirList, callBack)
	self:restoreEnterBattleRoleLightRotation()
	for index, roleId in ipairs(roleIdList) do
		local roleObj = self:getRole(roleId)
		if roleObj then
			local dir = dirList[index] or GE.RoleDirectionType.Up
			roleObj.model:TurnDirection(dir)
			local blockId = blockIdList[index]
			local blockObj = self:getBlockObj(blockId)
			if blockObj then
				local pos = blockObj.transform.position
				local rolePos = roleObj.root.transform.position
				local newPos = Vector3.New(pos.x, rolePos.y, pos.z)
				roleObj.root.transform.position = newPos
			end
		end	
	end
	--重新打开所有角色 延迟 防止瞬移
	self._activatedCamListener = function()
		if self._cinemachineBrain.ActiveVirtualCamera == self.mainVcam:GetComponent(TypeInfo.CinemachineVirtualCamera) then
			self:_DoAfter(0.1, function()
				self:showAllRole()
				self:openEventObj()
				self:showEdgesLine(true)
				self:showEdgesWall(true)
				self:setSceneEffectState(true)
				self:formationRangeSetActive(true)
				if callBack then
					callBack()
				end
			end)
			self._activatedCamListener = nil
		end
	end
	local mainPriority = self.mainVcam:GetComponent(TypeInfo.CinemachineVirtualCamera).Priority
	self._enterBattleVcam.Priority = mainPriority - 1

end

---获取入场相机
---@return Cinemachine.CinemachineVirtualCamera
function BattleShowManager:getEnterBattleVcam()
	return self._enterBattleVcam
end

--设置所有角色血条二级显隐
function BattleShowManager:setAllHpDis(bool)
	--所有角色血条
	for _, role in pairs(self.rolesMap) do
		if role.hpObj then
			UICommonUtils.Hp_SetUIRootActive(role.hpObj, bool)
		end
	end
end

--设置所有角色地格提示二级显隐
function BattleShowManager:setAllBlockTagDis(bool)
	--所有角色血条
	for _, obj in pairs(self._blockTagList) do
		UICommonUtils.BlockTag_SetActive(obj, bool)
	end
end

---胜利结束战斗演出,移动角色到指定位置，并播放对应动画
---@param trans UnityEngine.Transform?
---@param roleIdList integer[]
---@param blockIdList UnityEngine.Vector3[]
---@param callBack function
function BattleShowManager:playEndBattle(trans, roleIdList, blockIdList, callBack)
	local roleLight = self:getEnterBattleRoleLight()
	local faceDir = self:prepareEnterBattleShow(roleLight)
	local showPosList = {}
	local posCount = 0
	local animName = RoleModelAnimEnum.Celebrate
	local anchorPos = trans and trans.position or Vector3.zero()
	local aniFuncList = {}
	for index, roleId in ipairs(roleIdList) do
		local roleObj = self:getRole(roleId)
		if roleObj then
			local model = roleObj.model
			if faceDir then
				self:setRoleModelYRotationByDir(model.transform, faceDir)
			end
			model:SetFillColor(roleActiveColor, 0)
			local offset = blockIdList[index]
			local roleY = roleObj.root.transform.position.y
			local worldOffset = self:getShowOffsetInWorld(faceDir, offset)
			local newPos = Vector3.New(anchorPos.x + worldOffset.x, roleY, anchorPos.z + worldOffset.z)
			roleObj.root.transform.position = newPos
			if animName and string.len(animName) > 0 then
				local func = function()
					roleObj.model:PlayAnim(animName)
				end
				table.insert(aniFuncList, func)
			end
			posCount = posCount + 1
			showPosList[posCount] = newPos
		end
	end
	local aniFunc = function()
		for _, func in pairs(aniFuncList) do
			func()
		end
	end
	local BattleMainPanel = UIMgr:GetUI("BattleMainPanel")
	if BattleMainPanel then
		BattleMainPanel:hideBtnList()
	end
	self:setAllHpDis(false)
	self:hideEventObj()
	--特效
	self:SetAllRoleEffectObjActive(false)
	local finishCB = function()
		self:restoreEnterBattleRoleLightRotation()
		if callBack then
			callBack()
		end
	end
	if posCount == 0 then
		aniFunc()
		finishCB()
	else
		self:BattleVcamPath(trans, finishCB, showPosList, aniFunc, faceDir)
	end
end

function BattleShowManager:ShowPreviewHpChange(roleId, dmg, isRepair)
	local controller = self:getRoleController(roleId)
	local hpObj = self:getRoleHpObj(roleId)
	if controller and hpObj then
		UICommonUtils.HP_SetPreviewHp(hpObj, dmg, isRepair, controller)
	end
end

function BattleShowManager:HidePreviewHpChange(roleId)
	local controller = self:getRoleController(roleId)
	local hpObj = self:getRoleHpObj(roleId)
	if controller and hpObj then
		UICommonUtils.HP_CancelPreviewHp(hpObj, controller)
	end
end

---播放角色战斗CV
---@param skinConfig CharacterSkinTable
---@param audioData table?
---@param roleName LocalStrEnum?
function BattleShowManager:PlayBattleAudio(skinConfig, audioData, roleName)
	if audioData and next(audioData) then
		local nowLineId, actionId = DLuaUtil.getUnityRandomIndexLinear(audioData)
		local nowLineConfig = Config.GetScriptLinesInfo(nowLineId)
		if nowLineConfig and nowLineConfig.resource then--有音频
			if self._curPlayAudio then
				AudioMgr:stopVoice(self._curPlayAudio)
				self._curPlayAudio = nil
			end
			if roleName and self._uiBattleMain then
				self._uiBattleMain.ui:ShowRoleAudio(skinConfig, nowLineConfig, roleName, actionId)
			end
			self._curPlayAudio = UICommonUtils.Play2DVoiceByLanguage(skinConfig.CharacterID, nowLineConfig.resource, function()
				if roleName and self._uiBattleMain then
					self._uiBattleMain.ui:HideRoleAudio()
				end
				self._curPlayAudio = nil
            end)
		end
	end
end

--显示场景特效
---@param isShow boolean 是否显示
function BattleShowManager:setSceneEffectState(isShow)
	for _, obj in pairs(self._sceneEffectList) do
		obj:SetActive(isShow)
	end
end


function BattleShowManager:setBattleUIFogState(isShow)
	if not self._battleUIFog then
		return
	end
	self._battleUIFog:SetActive(isShow)
end

---播放子弹额外内容 持续音效、震动等
---@param obj UnityEngine.GameObject 子弹对象
---@param name String 子弹名称
---@param time number 持续时间 若表里shakeSustain为-1 则用实际子弹持续时间
function BattleShowManager:playBulletExtra(obj, name, time)
	local bulletInfo = Config.GetBulletInfo(name)
	if bulletInfo then
		--子弹对应音效
		local soundName = bulletInfo.SoundResource
		local soundPath = string.format(Config.AudioPath.SE, soundName)
		if soundName and soundName ~= "" then
			BattleCore.ds("BattleShowManager:playBulletSound soundPath", soundPath)
			self:_DoAfter(bulletInfo.delay, function()
				local targetVolume = 1
				local fadeInTime = 1
				self:play2DSound(soundPath, targetVolume, nil, nil, 1, nil, nil, obj)
			end)
		end
		--屏幕震动
		if tablex.size(bulletInfo.shakeEffect) > 0 then
			local entryData = bulletInfo.shakeEntry
			local decayData = bulletInfo.shakeDecay
			local sustain = bulletInfo.shakeSustain == -1 and time or bulletInfo.shakeSustain
			ResMgr:LoadCurveLibraryAsyncInOwner(Config.AssetFile.CurveLibrary, function(lib)
				---@type ShakeData
				local data = {
					frequency = bulletInfo.shakeEffect[1],
					amplitude = bulletInfo.shakeEffect[2],
					entryCurve = lib:GetCurve(entryData[1] ~= "" and entryData[1] or "BattleDefaultShakeEntry"),
					entryTime = entryData[2] or 0.3,
					decayCurve = lib:GetCurve(decayData[1] ~= "" and decayData[1] or "BattleDefaultShakeDecay"),
					decayTime = decayData[2] or 0.3,
					sustainTime = sustain or 0.3,
				}
				self:ShakeCameraByDmg(nil, nil, data)
			end, ResMgr:GetResCarrier())
		end
	end
end

--战前战后剧情使用设置战斗场景显影
function BattleShowManager:setBattleSceneActive(isShow)
	self:showSceneRoot(isShow)
	-- self.battleRoot:SetActive(isShow)
	self:showBackground(isShow)
	self:showBattlePRRenderer(isShow)
	self.sceneEdgesLine:SetActive(isShow)
	self.sceneEdgesWall:SetActive(isShow)
	if isShow then
		self:showAllRole(false)
	else
		self:hideAllRole()
	end
	-- if isShow then
	-- 	self._cinemachineBrain:ManualUpdate()
	-- end
end

function BattleShowManager:initCoveScene()
	local root = self.sceneRootObj
	local coveScene = root:GetComponent("CoveScene")
	if IsNull(coveScene) then
		return
	end
	local effectParent = self.cameraObj.transform:Find("effectParent")
	if IsNull(effectParent) then
		return
	end
	coveScene:SetEffectParent(effectParent.gameObject)
	self._coveScene = coveScene
end

function BattleShowManager:WeatherChange(data)
	local weatherId = data.weatherId or 0
	if self._coveScene then
		---@type WeatherParameterTable
		local param = Config.GetWeatherParameterById(weatherId)
		if param == nil then
			return
		end

		local sunDir = Vector3.New(param.angle[1], param.angle[2], param.angle[3])
		local sunLightColor = param.colour
		local sunIntensity = param.illuminance
		local sunShadowStrength = param.shadowStrength
		local roleLightColor = param.roleColour
		local roleIntensity = param.roleIlluminance
		local roleShadowStrength = param.roleShadowStrength
		local volumeType = param.volume
		local showLamp = param.lampOpen
		local effectName = param.effectName
		local cloudOpen = param.cloudOpen
		local t = 0
		local moveTime = 2

		self._coveScene:SetSceneParameters(sunDir, sunLightColor, sunIntensity, sunShadowStrength, roleLightColor,
		roleIntensity, roleShadowStrength, volumeType, showLamp, effectName, cloudOpen, t, moveTime)
	end
end

--刷新战斗摄像机角度
function BattleShowManager:RefreshCameraAngle(isDotween)
	local type = MyPrefs:GetInt(GE.LocalCustomDataKey.BattleCameraAngle, 1)
	local angleData = Config.GetConfigInfo("BattleCameraType")[type]
	local xAngle = angleData[1]
	local yAngle = self.mapAngle and self.mapAngle + angleData[2] or angleData[2]
	if isDotween then
		self:refreshViewRotationXY(xAngle, yAngle, 1)
	else
		self:refreshViewRotationXY(xAngle, yAngle, 0)
	end
end

return BattleShowManager
