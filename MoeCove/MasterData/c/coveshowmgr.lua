require "class"
---@class CoveShowMgr
local CoveShowMgr = class("CoveShowMgr")

--烟雾特效延迟时间
local smokeEffectDelay = 0
--防空特效触发距离(沿飞行朝向，忽略高度和横向)
local airDefenseTriggerDist = 2
local airDefenseGroundY = 0.5

function CoveShowMgr:ctor()
	--LuaLogger.ds("SkillPerfHandler ctor")
	if not self._timerlist then
		self._timerlist = {}
	end
	if not self._poolObjList then
		self._poolObjList = {}
	end
	self._airDefenseEffectMap = {}
end

function CoveShowMgr:Clear()
	for k, v in pairs(self._timerlist) do
		if v ~= 0 then
			DLuaTimer:RemoveTimer(v)
		end
	end
	self._timerlist = {}
	self._airDefenseEffectMap = {}
	-- for k, v in pairs(self._poolObjList) do
	-- 	if not isNull(v) then
	-- 		PoolMgr.Free(v)
	-- 	end
	-- end
	AudioManager.Instance:ClearWithOutBGM()
end

---实例化
---@return CoveShowMgr
function CoveShowMgr.instance()
	if (CoveShowMgr._instance == nil) then
		CoveShowMgr._instance = CoveShowMgr:new()
	end
	return CoveShowMgr._instance
end

function CoveShowMgr:_DoAfter(time, event)
	if time == 0 then
		if event then
			event()
			return
		end
	end
	local tempTimer = DLuaTimer:DoAfter(time, function()
		if (event) then
			event()
		end
	end)
	local num = tablex.size(self._timerlist) + 1
	self._timerlist[num] = tempTimer
	return tempTimer
end

function CoveShowMgr:_DoRepeat(interval, times, event)
	return DLuaTimer:DoRepeat(interval, times, function ()
		if (event) then
			event()
		end
	end)
end

function CoveShowMgr:_stopTimerByIndex(timerIndex)
	if not timerIndex or timerIndex == 0 then
		return
	end
	local timerId = self._timerlist[timerIndex]
	if timerId and timerId ~= 0 then
		DLuaTimer:RemoveTimer(timerId)
		self._timerlist[timerIndex] = 0
	end
end

---寻找射击点位
---@param index table?	角色发射点位list, 角色发射点位index 1为炮口 2为鱼雷发射口 不传则随机射击点位
---@return UnityEngine.Transform
function CoveShowMgr:__findShootPoint(model, index)
	--LuaLogger.ds("__findShootPoint", tablex.dump(index))
	local shootRootsList = model.shootPoints
	local torpedoList = model.shootPoints2
	local targetList
	local targetIndex = 0
	--没配置
	if not index then
		LuaLogger.ws("表里没有配置子弹发射点 随机射击点位  ", model.transform.name)
		local Length = shootRootsList.Length
		if Length == 0 then
			LuaLogger.ws("角色模型没有绑定射击点位 默认用自身位置  ", model.transform.name)
			return model.transform
		else
			targetIndex = math.random(1, Length) - 1
			if shootRootsList[targetIndex] then
				return shootRootsList[targetIndex]
			else
				LuaLogger.ws("角色射击点位为None 默认用自身位置  ", model.transform.name)
				return model.transform
			end
		end
	else
		--有配置
		if index[1] == 1 then
			targetList = shootRootsList
		elseif index[1] == 2 then
			targetList = torpedoList
		end
		local Length = targetList.Length
		--列表为空List
		if Length == 0 then
			LuaLogger.ws("角色模型没有绑定射击点位 默认用自身位置  ", model.transform.name)
			return model.transform
		else
			--超出已有配置范围 随机点位
			if index[2] > Length then
				targetIndex = math.random(1, Length) - 1
				LuaLogger.ws(model.transform.name .. "角色没有对应射击点位  ", index[2])
			else
				targetIndex = index[2] - 1
			end
			--列表数据为None
			if targetList[targetIndex] then
				return targetList[targetIndex]
			else
				LuaLogger.ws("角色射击点位为None 默认用自身位置  ", model.transform.name)
				return model.transform
			end
		end
	end
end

---烟雾特效旋转：只保留Y轴朝向，XZ不倾斜，-Z为朝向
---@param shootRootTrans UnityEngine.Transform
---@return UnityEngine.Quaternion
function CoveShowMgr:__getSmokeRotation(shootRootTrans)
	local shootDir = -shootRootTrans.right
	shootDir.y = 0
	if shootDir.sqrMagnitude > 0.0001 then
		return Quaternion.LookRotation(shootDir.normalized, Vector3.up) * Quaternion.Euler(0, 180, 0)
	end
	return Quaternion.identity
end

---播放烟雾特效
---@param startPos UnityEngine.Vector3
---@param smoke number?
---@param shootRootTrans UnityEngine.Transform
function CoveShowMgr:playSmokeEffect(startPos, smoke, shootRootTrans)
	if smoke then
		self:_DoAfter(smokeEffectDelay, function()
			self:playEffect(startPos, smoke, self:__getSmokeRotation(shootRootTrans))
		end)
	end
end

---寻找受击点位
---@param index number	角色受击点位index
---@return UnityEngine.Transform
---@return boolean	是否是自身位置（没有挂受击点）
function CoveShowMgr:__findHitPoint(model, index)
	-- --LuaLogger.ds("__findHitPoint")
	local hitPointsList = model.hitPoints
	local targetIndex = 0
	local Length = hitPointsList.Length
	if Length == 0 then
		-- LuaLogger.ws("角色没有受击点位 默认用自身位置", model.transform.name)
		return model.transform, true
	end
	if index > Length then
		targetIndex = math.random(1, Length) - 1
		-- LuaLogger.ws("角色没有对应受击点位  ", index)
		-- LuaLogger.ws("随机点位为  ", targetIndex)
	else
		targetIndex = index - 1
	end
	-- --LuaLogger.ds("目标index", targetIndex)
	return hitPointsList[targetIndex]
end

---@param role CoveRole|table
---@return Vector3?
function CoveShowMgr:__getRoleGroundPosByAny(role)
	if not role then
		return nil
	end
	if role.modelObj and not IsNull(role.modelObj) then
		local pos = role.modelObj.transform.position
		return Vector3(pos.x, airDefenseGroundY, pos.z)
	end
	if role.model and role.model.transform then
		local pos = role.model.transform.position
		return Vector3(pos.x, airDefenseGroundY, pos.z)
	end
	return nil
end

---@param targetRole CoveRole|table
---@return number
function CoveShowMgr:__getAirDefenseEffId(targetRole)
	if not targetRole then
		return 0
	end
	if targetRole.skinCfg and targetRole.skinCfg.airDefenseEff and targetRole.skinCfg.airDefenseEff ~= 0 then
		return targetRole.skinCfg.airDefenseEff
	end
	local roleId = targetRole.roleId or targetRole.id
	if roleId and BattleCore and BattleCore.getBattleRoleMgr then
		local battleRoleMgr = BattleCore:getBattleRoleMgr()
		if battleRoleMgr then
			local battleRole = battleRoleMgr:getRole(roleId, true)
			if battleRole then
				return battleRole:getAirDefenseEff()
			end
		end
	end
	return 0
end

---播放防空特效：目标地格海平面，朝向受击者指向攻击者，绑定目标角色
---@param targetRole CoveRole|table
---@param attackerRole CoveRole|table
---@param time number?
---@param targetBlockObj UnityEngine.GameObject?
---@param attackerBlockObj UnityEngine.GameObject?
function CoveShowMgr:tryPlayAirDefenseEffect(targetRole, attackerRole, time, targetBlockObj, attackerBlockObj)
	if not self._airDefenseEffectMap then
		self._airDefenseEffectMap = {}
	end
	if not targetRole then
		-- --LuaLogger.ds("CoveShowMgr:tryPlayAirDefenseEffect 打断: targetRole 为空")
		return
	end
	local targetRoleId = targetRole.roleId or targetRole.id
	if not targetRoleId then
		-- --LuaLogger.ds("CoveShowMgr:tryPlayAirDefenseEffect 打断: targetRoleId 为空", tablex.dump(targetRole))
		return
	end
	if self._airDefenseEffectMap[targetRoleId] then
		-- --LuaLogger.ds("CoveShowMgr:tryPlayAirDefenseEffect 打断: 目标已在播放中", targetRoleId)
		return
	end
	local effectId = self:__getAirDefenseEffId(targetRole)
	if not effectId or effectId == 0 then
		-- --LuaLogger.ds("CoveShowMgr:tryPlayAirDefenseEffect 打断: effectId 无效", targetRoleId, effectId)
		return
	end
	local pos
	if targetBlockObj then
		pos = targetBlockObj.transform.position + Vector3(0, airDefenseGroundY, 0)
	else
		pos = self:__getRoleGroundPosByAny(targetRole)
	end
	if not pos then
		-- --LuaLogger.ds("CoveShowMgr:tryPlayAirDefenseEffect 打断: 目标位置无效", targetRoleId)
		return
	end
	local attackerPos
	if attackerBlockObj then
		attackerPos = attackerBlockObj.transform.position
	else
		attackerPos = self:__getRoleGroundPosByAny(attackerRole)
	end
	if not attackerPos then
		-- --LuaLogger.ds("CoveShowMgr:tryPlayAirDefenseEffect 打断: 攻击者位置无效", targetRoleId, attackerRole and (attackerRole.roleId or attackerRole.id))
		return
	end
	local direction = Vector3(attackerPos.x - pos.x, 0, attackerPos.z - pos.z)
	local baseRotation = Quaternion.identity
	if direction.sqrMagnitude > 0.0001 then
		baseRotation = Quaternion.LookRotation(direction.normalized, Vector3.up)
	end
	local startRotation = baseRotation
	local endRotation = baseRotation * Quaternion.Euler(-45, 0, 0)
	self._airDefenseEffectMap[targetRoleId] = true
	local effectDuration = time or 2
	local parentTransform = (targetRole.modelObj and targetRole.modelObj.transform)
		or (targetRole.model and targetRole.model.transform)
	-- --LuaLogger.ds("CoveShowMgr:tryPlayAirDefenseEffect 播放成功", targetRoleId, effectId, effectDuration, pos)
	self:playEffect(pos, effectId, startRotation, nil, nil, parentTransform, effectDuration, function(obj)
		obj.transform:DORotateQuaternion(endRotation, effectDuration * 0.6):SetEase(DG.Tweening.Ease.Linear)
	end)
	self:_DoAfter(effectDuration, function()
		-- --LuaLogger.ds("CoveShowMgr:tryPlayAirDefenseEffect 解锁", targetRoleId)
		self._airDefenseEffectMap[targetRoleId] = nil
	end)
end

---沿飞行朝向检测目标并播放防空特效
---@param pos Vector3
---@param flyDir Vector3
---@param attackerRole CoveRole|table
---@param pendingTargetMap table<integer, table>
---@param attackerBlockObj UnityEngine.GameObject?
---@param airDefenseDist number?	防空检测距离
---@return boolean
function CoveShowMgr:__tryPlayAirDefenseEffectsByDist(pos, flyDir, attackerRole, pendingTargetMap, attackerBlockObj, airDefenseDist)
	if not pendingTargetMap or not next(pendingTargetMap) then
		-- --LuaLogger.ds("CoveShowMgr:__tryPlayAirDefenseEffectsByDist 打断: pendingTargetMap 为空")
		return false
	end
	airDefenseDist = airDefenseDist or airDefenseTriggerDist
	if flyDir.sqrMagnitude <= 0.0001 then
		-- --LuaLogger.ds("CoveShowMgr:__tryPlayAirDefenseEffectsByDist 打断: flyDir 无效", flyDir)
		return true
	end
	local flyDirNorm = flyDir.normalized
	for roleId, targetInfo in pairs(pendingTargetMap) do
		local targetRole = targetInfo.targetRole
		if not targetRole and targetInfo.targetRoleId and self.getRole then
			targetRole = self:getRole(targetInfo.targetRoleId)
		end
		local targetGroundPos
		local targetBlockObj
		if targetInfo.targetBlockId and self.getBlockObj then
			targetBlockObj = self:getBlockObj(targetInfo.targetBlockId)
			if targetBlockObj then
				targetGroundPos = targetBlockObj.transform.position
			end
		end
		if not targetGroundPos then
			targetGroundPos = self:__getRoleGroundPosByAny(targetRole)
		end
		if not targetGroundPos then
			-- --LuaLogger.ds("CoveShowMgr:__tryPlayAirDefenseEffectsByDist 打断: 目标位置无效, 从pending移除", roleId, targetRole and (targetRole.roleId or targetRole.id))
			pendingTargetMap[roleId] = nil
		else
			local toTarget = Vector3(
				targetGroundPos.x - pos.x,
				0,
				targetGroundPos.z - pos.z
			)
			local forwardDist = Vector3.Dot(toTarget, flyDirNorm)
			if forwardDist <= 0 then
				-- --LuaLogger.ds("CoveShowMgr:__tryPlayAirDefenseEffectsByDist 打断: 已飞过目标, 从pending移除", roleId, "forwardDist=", forwardDist)
				pendingTargetMap[roleId] = nil
			elseif forwardDist < airDefenseDist then
				-- --LuaLogger.ds("CoveShowMgr:__tryPlayAirDefenseEffectsByDist 触发防空", roleId, "forwardDist=", forwardDist, "dist=", airDefenseDist)
				self:tryPlayAirDefenseEffect(targetRole, attackerRole, 2, targetBlockObj, attackerBlockObj)
				pendingTargetMap[roleId] = nil
			end
		end
	end
	return next(pendingTargetMap) ~= nil
end

---舰载机攻击
---@class bombDetail
---@field delay number		炸弹从飞机俯冲开始的延迟

---@class BulletDataPlaneAttackCove
---@field planeName string		飞机
---@field speed number			速度
---@field index number			发射点位index
---@field delay number			延迟时间 秒
---@field hitEffect number		命中特效
---@field hitResult HitResult[]	伤害详情
---@field bombDetail bombDetail[]	曲线度
---@field type PerformancePlaneType	飞机类型
---@field height number		飞机高度
---@field shootPos table		发射点位

---@param data BulletDataPlaneAttack
---@param callback function
function CoveShowMgr:PlaneAttack(data, callback)
	--LuaLogger.ds("CoveShowMgr:PlaneAttack")
	-- --LuaLogger.ds("CoveShowMgr:PlaneAttack data.hitResult:", tablex.dump(data.hitResult))
	local role = data.role
	local model = role._model
	local targetRole = data.target
	local targetModel = targetRole._model
	local targetGroundPos = Vector3(targetRole.modelObj.transform.position.x, 0, targetRole.modelObj.transform.position.z)
	local perfTime = 0
	--第一家飞机随机往左往右 第一架确定之后后续飞机依次左右左右交替
	local randomDirection = UnityEngine.Random.Range(0, 1) == 0 and -1 or 1
	local planeIndex = data.index
	-- local boomNum = 0
	-- local boomNeedNum = 0
	-- local checkEnd = function()
	-- 	if boomNum == boomNeedNum then
	-- 		if callback then
	-- 			self:_DoAfter(1, function()
	-- 				callback()
	-- 			end)
	-- 		end
	-- 	end
	-- end
	if (model) then
		local shootRootTrans = self:__findShootPoint(model, data.shootPos)
		if not shootRootTrans then
			LuaLogger.es("没有找到发射点位")
			-- checkEnd()
			return
		end
		local hitRootTrans, isSelf = self:__findHitPoint(targetModel, 1)
		if not hitRootTrans then
			LuaLogger.es("没有找到受击点位")
			-- checkEnd()
			return
		end
		--飞机 起飞 - 平飞 - 俯冲 - 离场
		PoolMgr:Get(string.format(Config.PrefabPath.BulletPrefab, data.planeName), function (planeObj)
			--起飞音效
			local soundPath = string.format(Config.AudioPath.SE, "plane1")
			local fadeInTime = 1
			local targetVolume = 0.5
			LuaMain:play3DSound(soundPath, targetVolume, nil, nil, 1, fadeInTime, nil, planeObj, 20, 2)
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
				[targetRole.id] = {
					targetRole = targetRole,
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
						local hasPending = self:__tryPlayAirDefenseEffectsByDist(pos, flyDirTakeoff, role, airDefensePendingMap)
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
									local hasPending = self:__tryPlayAirDefenseEffectsByDist(planeObj.transform.position, flyDir, role, airDefensePendingMap)
									if not hasPending then
										airDefensePendingMap = nil
									end
								end
							end)
						end
						flatFlyTween:OnComplete(function()
							--平飞结束 俯冲阶段
							--LuaLogger.ds("CoveShowMgr:PlaneAttack 俯冲")
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
										--未命中 炮弹随机落到水中
										if not hitResult.isHit then
											local randomX = UnityEngine.Random.Range(-0.5,0.5)
											local randomZ = UnityEngine.Random.Range(-0.5,0.5)
											targetPos = targetGroundPos + Vector3(randomX, 0, randomZ)
											hitEffect = 1080 --miss特效
										else
											--若是自身位置 则需要上移
											if isSelf then
												targetPos = targetPos + Vector3(0,0.3,0)
											end
											local randomX = UnityEngine.Random.Range(-0.1,0.1)
											local randomZ = UnityEngine.Random.Range(-0.1,0.1)
											targetPos = targetPos + Vector3(randomX, 0, randomZ)
											hitEffect = data.hitEffect
										end
										local startPos = planeObj.transform.position
										local bezierPoint = self:getBezierPoint(startPos, targetPos, 0.8, Vector3(0, 0.3, 0))
										local speed = 8 * Time.timeScale	--炸弹下落速度
										local totalTime = distance/speed	--子弹位移总时间
										bomb.transform.position = startPos
										bomb:SetActive(false)	--修复第一帧弹头瞬移bug
										local towards = targetPos - startPos
										if towards.sqrMagnitude < 0.0001 then
											towards = Vector3.forward
										end
										local speed2 = towards.magnitude / 0.02
										self:startBezierMove(startPos, {bezierPoint}, targetPos, totalTime,
											function(pos, progress)
												-- 改变炸弹的方向，使其朝向目标位置
												towards = pos - bomb.transform.position
												speed2 = towards.magnitude / 0.02
												bomb.transform:LookAt(pos)
												bomb.transform.position = pos
												bomb:SetActive(true)
											end, 
											function()
												local maxMissTime = 10
												--原有命中逻辑
												local originFunc = function()
													if hitEffect then
														self:playEffect(targetPos, hitEffect, nil)
													end
													if not targetRole:IsDead() and hitResult.isHit then
														self:PlayHitAnim(targetRole)
													end
													PoolMgr.Free(bomb)
												end
												--原本应该命中但角色离开 让炸弹继续下落
												local missFunc = function()
													--LuaLogger.ds("CoveShowMgr:PlaneAttack missFunc")
													local passTime = 0.02 				--刷新间隔
													local times = maxMissTime/passTime
													local currentPosition = bomb.transform.position
													local currentVelocity = towards.normalized * speed2  -- 初始速度向量
													local gravity = - 0.5		--重力
													local groundY = 0		--地面
													local num = tablex.size(self._timerlist) + 1
													--模拟重力
													local timer = self:_DoRepeat(passTime, times, function ()
														--落到水面
														if bomb.transform.position.y <= groundY then
															DLuaTimer:RemoveTimer(self._timerlist[num])
															self:playEffect(bomb.transform.position, 1080, nil)
															PoolMgr.Free(bomb)
															--LuaLogger.ds("CoveShowMgr:PlaneAttack missFunc 落水消失")
														end
														-- 更新位置
														local position = bomb.transform.position
														local velocity = currentVelocity
														velocity.y = velocity.y + gravity * passTime	--重力衰减
														position = position + velocity * passTime
														bomb.transform.position = position
														bomb.transform:LookAt(position + velocity)
													end)
													self._timerlist[num] = timer
												end
						
												if (callback) then
													callback(hitResult.isHit, originFunc, missFunc, bomb, targetRole)
												end
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
										local hasPending = self:__tryPlayAirDefenseEffectsByDist(pos, diveFlyDir, role, airDefensePendingMap)
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
									LuaMain:play3DSound(soundPath, 0.5, nil, nil, 1, fadeOutTime, nil, planeObj, 20, 2)
									self:_DoAfter(fadeOutTime, function()
										PoolMgr.Free(planeObj)
									end)
								end
							)
						end):SetEase(DG.Tweening.Ease.Linear)
					--鱼雷机
					elseif data.type == GE.PerformancePlaneType.TorpedoPlane then
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
									local hasPending = self:__tryPlayAirDefenseEffectsByDist(pos, flyDir, role, airDefensePendingMap)
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
										local bulletName = "pd3"
										--延迟丢雷
										--LuaLogger.ds("CoveShowMgr:PlaneAttack 鱼雷机投雷 delay:", bomb.delay)
										self:_DoAfter(bomb.delay, function()
											PoolMgr:Get(string.format(Config.PrefabPath.BulletPrefab, bulletName), function (torpedoObj)
												bombIndex = bombIndex + 1
												--计算鱼雷终点位置
												local startPos = planeObj.transform.position
												local targetPos = targetGroundPos --目标脚下地面
												--LuaLogger.ds("CoveShowMgr:PlaneAttack 鱼雷机投雷 bombIndex:", bombIndex)
												--LuaLogger.ds("CoveShowMgr:PlaneAttack 鱼雷机投雷 hitResultList:", tablex.dump(hitResultList))
												local hitResult = hitResultList[bombIndex]
												local hitEffect	--命中特效
												--未命中 则鱼雷穿过目标位置随机偏移并向后延伸随机1~2米
												if not hitResult.isHit then
													local randomX = UnityEngine.Random.Range(0.1,0.2)
													local randomX = randomX * (math.random(0,1) == 0 and -1 or 1)
													local randomZ = UnityEngine.Random.Range(0.1,0.2)
													local randomZ = randomZ * (math.random(0,1) == 0 and -1 or 1)
													targetPos = targetPos + Vector3(randomX, 0, randomZ)
												else
													local randomX = UnityEngine.Random.Range(-0.1,0.1)
													local randomZ = UnityEngine.Random.Range(-0.1,0.1)
													targetPos = targetPos + Vector3(randomX, 0, randomZ)
													hitEffect = data.hitEffect
												end
												local startPos = planeObj.transform.position
												torpedoObj.transform.position = startPos
												--鱼雷下落保持水平
												torpedoObj.transform:LookAt(targetPos)
												torpedoObj.transform.eulerAngles = Vector3(0, torpedoObj.transform.eulerAngles.y, 0)
												local groundPos = Vector3(startPos.x, 0, startPos.z)
												local bezierPoint = self:getBezierPoint(startPos, targetPos, 0.2, Vector3(0, 0.3, 0))
												local distance = Vector3.Distance(targetGroundPos , groundPos)
												local speed = 2 * Time.timeScale	--鱼雷下落速度
												local totalTime = distance/speed	--鱼雷下落总时间
												local isfree = false
												self:TorpedoDrop(torpedoObj, startPos, {}, groundPos, targetPos, totalTime, function(velocity)
													local maxMissTime = 3
													local missTimerIndex = 0
													local missFuncStarted = false
													local freeTorpedo = function()
														if isfree then
															return
														end
														self:_stopTimerByIndex(missTimerIndex)
														missTimerIndex = 0
														if torpedoObj and not IsNull(torpedoObj) then
															PoolMgr.Free(torpedoObj)
														end
														isfree = true
													end
													--原本应该命中但角色离开 让鱼雷继续向原有轨迹前进
													local missFunc = function()
														if missFuncStarted or isfree then
															return
														end
														missFuncStarted = true
														--LuaLogger.ds("CoveShowMgr:PlaneAttack 鱼雷 missFunc", velocity)
														local passTime = 0.02 				--刷新间隔
														local times = maxMissTime/passTime
														local num = tablex.size(self._timerlist) + 1
														missTimerIndex = num
														local timer = self:_DoRepeat(passTime, times, function ()
															if isfree or IsNull(torpedoObj) then
																self:_stopTimerByIndex(missTimerIndex)
																missTimerIndex = 0
																return
															end
															local position = torpedoObj.transform.position
															position = position + velocity * passTime
															torpedoObj.transform:LookAt(position)
															torpedoObj.transform.position = position
														end)
														self._timerlist[num] = timer
													end
													local originFunc = function()
														--LuaLogger.ds("CoveShowMgr:PlaneAttack 鱼雷 originFunc")
														if hitResult.isHit then
															if hitEffect then
																self:playEffect(targetPos, hitEffect, nil)
															end
															if not targetRole:IsDead() then
																self:PlayHitAnim(targetRole)
															end
															freeTorpedo()
														else
															missFunc()
														end
													end
							
													if (callback) then
														callback(hitResult.isHit, originFunc, missFunc, torpedoObj, targetRole)
													end
													--超时还没落地 强行销毁鱼雷
													self:_DoAfter(maxMissTime, function()
														freeTorpedo()
													end)
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
---@class BulletDataCove
---@field bulletName string		子弹名
---@field speed number			速度
---@field focus number			中点点位 0~1
---@field curve Vector3			偏移量
---@field index number			发射点位index
---@field delay number			延迟时间 秒
-- -@field roleId integer		角色id
-- -@field blockId number		源地块id
-- -@field targetBlockId number	目标地块id
-- -@field targetRoleId number	目标角色id
---@field role CoveRole			角色
---@field target CoveRole		目标角色
---@field shootEffect number	射击特效
---@field smoke number			烟雾特效
---@field hitEffect number		命中特效
---@field hitResult HitResult	伤害详情
---@field shootPos table		发射点位index

---@param data BulletData
---@param callback function
function CoveShowMgr:shootBullet(data, callback)
	--LuaLogger.ds("CoveShowMgr:shootBullet")
	local role = data.role
	--LuaLogger.ds("CoveShowMgr:shootBullet roleId:", role.id)
	local model = role._model
	local rolePos = role.modelObj.transform.position

	local targetRole = data.target
	local targetModel = targetRole._model
	local targetRolePos = targetRole.modelObj.transform.position
	local perfTime = 0

	if (model) then
		local shootRootTrans = self:__findShootPoint(model, data.shootPos)
		if not shootRootTrans then
			LuaLogger.es("没有找到发射点位")
			return
		end
		local hitRootTrans, isSelf = self:__findHitPoint(targetModel, 1)
		if not hitRootTrans then
			LuaLogger.es("没有找到受击点位")
			return
		end
		--LuaLogger.ds("CoveShowMgr:shootBullet 子弹路径:", string.format(Config.PrefabPath.BulletPrefab, data.bulletName))
		--子弹
		PoolMgr:Get(string.format(Config.PrefabPath.BulletPrefab, data.bulletName), function (bulletObj)
			local startPos = shootRootTrans.position
			local targetPos = hitRootTrans.position
			local hitResult = data.hitResult
			local hitEffect = data.hitEffect	--命中特效
			--miss
			if not hitResult.isHit then
				local randomX = UnityEngine.Random.Range(0.2,0.7)
				local randomX = randomX * (math.random(0,1) == 0 and -1 or 1)
				local randomZ = UnityEngine.Random.Range(0.2,0.7)
				local randomZ = randomZ * (math.random(0,1) == 0 and -1 or 1)
				targetPos = targetRolePos + Vector3(randomX, 0, randomZ)
				hitEffect = 1080	
			else
				--若是自身位置 则需要上移
				if isSelf then
					targetPos = targetPos + Vector3(0,0.3,0)
				end
				local randomX = UnityEngine.Random.Range(-0.1,0.1)
				local randomZ = UnityEngine.Random.Range(-0.1,0.1)
				targetPos = targetPos + Vector3(randomX, 0, randomZ)
			end
			--射击特效
			local shootEffect = data.shootEffect
			print("CoveShowMgr:shootBullet shootEffect 射击特效id", shootEffect)
			if shootEffect then
				self:playEffect(startPos, shootEffect, Quaternion.LookRotation(-shootRootTrans.right, shootRootTrans.up) * Quaternion.Euler(0, 180, 0), nil, nil, shootRootTrans)
			end
			self:playSmokeEffect(startPos, data.smoke, shootRootTrans)
			--子弹起始位置
			bulletObj.transform.position = startPos
			local bezierPoint = self:getBezierPoint(startPos, targetPos, data.focus, data.curve)
			local distance = Vector3.Distance(rolePos, targetRolePos)
			print("CoveShowMgr:shootBullet 距离", distance, data.curve)
			local distCovered = 0
			local currentTimes = 0
			-- --LuaLogger.ds("距离", distance)
			local speed = data.speed * Time.timeScale	--算上整体倍速
			local totalTime = distance/speed	--子弹位移总时间
			--LuaLogger.ds("CoveShowMgr:shootBullet 子弹移动时间: ", totalTime)
			-- totalTime = math.max(totalTime)
			perfTime = totalTime
			local passTime = 0.02 				--刷新间隔
			local times = math.ceil(totalTime/passTime)	--刷新次数
			local towards = targetPos - startPos
			if towards.sqrMagnitude < 0.0001 then
				towards = Vector3.forward
			end
			speed = towards.magnitude / passTime
			--贝赛尔曲线
			local timer = self:_DoRepeat(passTime, times, function ()
				if (bulletObj and bulletObj.transform) then
					currentTimes = currentTimes + 1
					--到达目标点结算
					if (currentTimes == times) then
						local maxMissTime = 5
						--原有逻辑
						local originFunc = function()
							--LuaLogger.ds("CoveShowMgr:shootBullet hitFunc")
							if hitEffect then
								self:playEffect(targetPos, hitEffect, nil)
							end
							if not targetRole:IsDead() and hitResult.isHit then
								self:PlayHitAnim(targetRole)
							end
							PoolMgr.Free(bulletObj)
						end
						--原本应该命中但角色离开 让子弹飞一会儿
						local missFunc = function()
							--LuaLogger.ds("CoveShowMgr:shootBullet missFunc")
							local times = maxMissTime/passTime
							local currentPosition = bulletObj.transform.position
							local currentVelocity = towards.normalized * speed  -- 初始速度向量
							local gravity = - 1		--重力
							local groundY = 0		--地面
							local num = tablex.size(self._timerlist) + 1
							--模拟重力
							local timer = self:_DoRepeat(passTime, times, function ()
								if not IsNull(bulletObj) then
									--落到水面
									if bulletObj.transform.position.y <= groundY then
										--LuaLogger.ds("CoveShowMgr:shootBullet _timerlist 落水", tablex.dump(self._timerlist))
										DLuaTimer:RemoveTimer(self._timerlist[num])
										self._timerlist[num] = 0
										self:playEffect(bulletObj.transform.position, 1080, nil)
										-- --LuaLogger.ds("CoveShowMgr:shootBullet missFunc 落水消失")
										PoolMgr.Free(bulletObj)
									else
										-- 更新位置
										local position = bulletObj.transform.position
										local velocity = currentVelocity
										velocity.y = velocity.y + gravity * passTime	--重力衰减
										position = position + velocity * passTime
										bulletObj.transform.position = position
										bulletObj.transform:LookAt(position + velocity)
										-- --LuaLogger.ds("CoveShowMgr:shootBullet missFunc 位置更新", bulletObj.transform.position)
									end
								end
							end)
							self._timerlist[num] = timer
						end

						if (callback) then
							callback(hitResult.isHit, originFunc, missFunc, bulletObj, targetRole)
						end
					else
						distCovered = (currentTimes / times)
						local nextPos = luautil.getBezier(startPos, bezierPoint, targetPos, distCovered)
						-- 改变子弹的方向，使其朝向目标位置
						bulletObj.transform:LookAt(nextPos)
						towards = nextPos - bulletObj.transform.position
						speed = towards.magnitude / passTime
						bulletObj.transform.position = nextPos
					end
				end
			end)
			self._timerlist[#self._timerlist + 1] = timer
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
function CoveShowMgr:SideAttack(data, callback)
	--LuaLogger.ds("CoveShowMgr:SideAttack")
	local role = data.role
	local model = role._model
	local targetRole = data.target
	local targetModel = targetRole._model
	local targetGroundPos = Vector3(targetRole.modelObj.transform.position.x, 0, targetRole.modelObj.transform.position.z)
	local perfTime = 0
	local fallSpeed = 0.75 --下落速度
	if (model) then
		local shootRootTrans = self:__findShootPoint(model, data.shootPos)
		if not shootRootTrans then
			LuaLogger.es("没有找到发射点位")
			return
		end
		local hitRootTrans, isSelf = self:__findHitPoint(targetModel, 1)
		if not hitRootTrans then
			LuaLogger.es("没有找到受击点位")
			return
		end
		--子弹
		PoolMgr:Get(string.format(Config.PrefabPath.BulletPrefab, data.bulletName), function (bulletObj)
			self:setTorpedoEffect(bulletObj, false)
			bulletObj:SetActive(false)
			local startPos = shootRootTrans.position	--炮口位置
			local secondStartPos	--射击起始位置
			local targetPos = hitRootTrans.position
			local hitResult = data.hitResult
			local hitEffect	--命中特效
			--未命中 没有特效
			if not hitResult.isHit then
			else
				local randomX = UnityEngine.Random.Range(-0.1,0.1)
				local randomZ = UnityEngine.Random.Range(-0.1,0.1)
				targetPos = targetPos + Vector3(randomX, 0, randomZ)
				hitEffect = data.hitEffect
			end
			--射击特效
			local shootEffect = data.shootEffect
			print("CoveShowMgr:SideAttack shootEffect 射击特效id", shootEffect)
			if shootEffect then
				self:playEffect(startPos, shootEffect, Quaternion.LookRotation(-shootRootTrans.right, shootRootTrans.up) * Quaternion.Euler(0, 180, 0), nil, nil, shootRootTrans)
			end
			self:playSmokeEffect(startPos, data.smoke, shootRootTrans)
			--总时间
			local totalTime
			--需要下落 二段流程
			if data.isfall == 1 then
				secondStartPos = Vector3(startPos.x, 0, startPos.z)
				totalTime = Vector3.Distance(startPos, secondStartPos)/(fallSpeed * Time.timeScale) + 
				Vector3.Distance(secondStartPos, targetPos)/(data.speed * Time.timeScale)
			else
				--无需下落
				secondStartPos = startPos
				totalTime = Vector3.Distance(secondStartPos, targetPos)/(data.speed * Time.timeScale)
			end
			perfTime = totalTime
			--射击流程
			local shootfunc = function()
				--子弹起始位置
				bulletObj.transform.position = secondStartPos
				bulletObj:SetActive(true)
				self:setTorpedoEffect(bulletObj, true)
				self:SetTrailEmitting(bulletObj, true)
				local randomx = UnityEngine.Random.Range(data.offsetx[1], data.offsetx[2])
				local randomy = UnityEngine.Random.Range(data.offsety[1], data.offsety[2]) or 0	--y轴偏移
				local curve = Vector3(randomx, 0, 0)
				local focus = UnityEngine.Random.Range(data.focus[1], data.focus[2])
				local bezierPoint = self:getBezierPoint(secondStartPos, targetPos, focus, curve)
				bezierPoint.y = secondStartPos.y + randomy	--贝塞尔曲线高度为设计点位+随机偏移量
				local distance = Vector3.Distance(secondStartPos, targetPos)
				local speed = data.speed * Time.timeScale	--算上整体倍速
				local shootTime = distance/speed	--子弹位移总时间
				-- --LuaLogger.ds("CoveShowMgr:SideAttack 射击流程子弹起始位置", tablex.dump(secondStartPos))
				-- --LuaLogger.ds("CoveShowMgr:SideAttack 射击流程子弹终点位置", tablex.dump(targetPos))
				-- --LuaLogger.ds("CoveShowMgr:SideAttack curve随机x为: ", randomx)
				-- --LuaLogger.ds("CoveShowMgr:SideAttack 随机focus中点为: ", focus)
				-- --LuaLogger.ds("CoveShowMgr:SideAttack 子弹移动时间: ", shootTime)
				local finalVelocity = Vector3.zero
				local lastPosition = bulletObj.transform.position
				local lastTime = Time.time
				--贝赛尔曲线
				ResMgr:LoadCurveLibraryAsyncInOwner(Config.AssetFile.CurveLibrary, function(lib)
					self:startBezierMove(secondStartPos, {bezierPoint}, targetPos, shootTime, 
						function(pos, progress)
							local currentTime = Time.time
							local currentPosition = bulletObj.transform.position
							-- 计算瞬时速度
							local deltaTime = currentTime - lastTime
							if deltaTime > 0.001 then  -- 避免除零
								local calSpeed = (currentPosition - lastPosition) / deltaTime
								finalVelocity = calSpeed.magnitude  > finalVelocity.magnitude and calSpeed or finalVelocity
							end
							lastPosition = currentPosition
							lastTime = currentTime
							-- 改变子弹的方向，使其朝向目标位置
							bulletObj.transform:LookAt(pos)
							--位置
							bulletObj.transform.position = pos
							bulletObj:SetActive(true)
						end, 
						function()
							--结算
							local maxMissTime = 3
							--命中
							local originFunc = function()
								--LuaLogger.ds("CoveShowMgr:SideAttack 子弹 originFunc")
								if hitEffect then
									self:playEffect(targetPos, hitEffect, nil)
								end
								if not targetRole:IsDead() and hitResult.isHit then
									self:PlayHitAnim(targetRole)
								end
								self:TrailEmittingEnd(bulletObj)
							end
							--原本应该命中但角色离开 让子弹继续向原有轨迹前进
							local missFunc = function()
								--LuaLogger.ds("CoveShowMgr:SideAttack 子弹 missFunc", finalVelocity)
								local passTime = 0.02 				--刷新间隔
								local times = maxMissTime/passTime
								local num = tablex.size(self._timerlist) + 1
								local gravity = - 0.3		--重力
								local groundY = 0		--地面
								--加速 落水
								local timer = self:_DoRepeat(passTime, times, function ()
									if bulletObj.transform.position.y <= groundY then
										--LuaLogger.ds("CoveShowMgr:shootBullet _timerlist 落水", tablex.dump(self._timerlist))
										DLuaTimer:RemoveTimer(self._timerlist[num])
										self._timerlist[num] = 0
										self:playEffect(bulletObj.transform.position, 1080, nil)
										-- --LuaLogger.ds("CoveShowMgr:shootBullet missFunc 落水消失")
										self:TrailEmittingEnd(bulletObj)
									else
										-- 更新位置
										local position = bulletObj.transform.position
										local velocity = finalVelocity
										velocity.y = velocity.y + gravity * passTime	--重力衰减
										position = position + velocity * passTime
										bulletObj.transform.position = position
										bulletObj.transform:LookAt(position + velocity)
									end
								end)
								self._timerlist[num] = timer
							end
			
							if (callback) then
								callback(hitResult.isHit, originFunc, missFunc, bulletObj, targetRole)
							end

						end,
						lib:GetCurve("Missile1")
					)
				end, ResMgr:GetResCarrier())
			end
			--下落流程
			local fallfunc = function()
				--LuaLogger.ds("CoveShowMgr:SideAttack 下落流程子弹起始位置", tablex.dump(startPos))
				--LuaLogger.ds("CoveShowMgr:SideAttack 下落流程子弹终点位置", tablex.dump(secondStartPos))
				local distance = Vector3.Distance(secondStartPos, startPos)
				local fallTime = distance/(fallSpeed * Time.timeScale)	--下落时间
				--贝塞尔曲线
				self:startBezierMove(startPos, {}, secondStartPos, fallTime, 
					function(pos, progress)
						--位置
						bulletObj.transform.position = pos
						bulletObj:SetActive(true)
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
function CoveShowMgr:DroneAttack(data, callback)
	--LuaLogger.ds("CoveShowMgr:DroneAttack", tablex.dump(data))
	local roleMgr = BattleCore:getBattleMgr():getRoleManager()
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
			LuaLogger.es("没有找到发射点位")
			return
		end
		local hitRootTrans, isSelf = self:__findHitPoint(targetModel, 1)
		if not hitRootTrans then
			LuaLogger.es("没有找到受击点位")
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
			print("CoveShowMgr:DroneAttack shootEffect 射击特效id", shootEffect)
			if shootEffect then
				self:playEffect(startPos, shootEffect, Quaternion.LookRotation(-shootRootTrans.right, shootRootTrans.up) * Quaternion.Euler(0, 180, 0), nil, nil, shootRootTrans)
			end
			self:playSmokeEffect(startPos, data.smoke, shootRootTrans)
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
					--LuaLogger.ds("CoveShowMgr:DroneAttack 无人机二段冲刺子弹起始位置", tablex.dump(secondStartPos))
					--LuaLogger.ds("CoveShowMgr:DroneAttack 无人机二段冲刺子弹终点位置", tablex.dump(targetPos))
					--LuaLogger.ds("CoveShowMgr:DroneAttack curve随机x为: ", randomx)
					--LuaLogger.ds("CoveShowMgr:DroneAttack 随机focus中点为: ", focus)
					--LuaLogger.ds("CoveShowMgr:DroneAttack 子弹移动时间: ", shootTime)
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
								self:_DoAfter(0.5, function()
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
---@class BulletDataJustHitCove
---@field delay number			延迟时间 秒
---@field shootEffect string	射击特效
---@field smoke number			烟雾特效
---@field hitEffect number		命中特效
---@field hitResult HitResult	伤害详情
---@field index number			子弹索引
---@field dmgDelay number		伤害延迟
---@field shootPos table		射击位置
---@param role CoveRole			角色

---@param data BulletDataJustHitCove
---@param callback function
function CoveShowMgr:justHit(data, callback)
	--LuaLogger.ds("CoveShowMgr:JustHit")
	local role = data.role
	local model = role._model
	local targetRole = data.target
	local targetModel = targetRole._model
	local delay = data.delay or 0
	local perfTime = 0
	if (model) then
		local shootRootTrans = self:__findShootPoint(model, data.shootPos)
		if not shootRootTrans then
			LuaLogger.es("没有找到发射点位")
			return
		end
		local hitRootTrans, isSelf = self:__findHitPoint(targetModel, 1)
		if not hitRootTrans then
			LuaLogger.es("没有找到受击点位")
			return
		end
		local startPos = shootRootTrans.position
		local targetPos = hitRootTrans.position
		local hitResult = data.hitResult
		local hitEffect	--命中特效
		--未命中 炮弹随机落到水中
		if not hitResult.isHit then
			local randomX = UnityEngine.Random.Range(-0.5,0.5)
			local randomZ = UnityEngine.Random.Range(-0.5,0.5)
			targetPos = targetRole.modelObj.transform.position + Vector3(randomX, 0, randomZ)
			hitEffect = 1080 --miss特效
		else
			--若是自身位置 则需要上移
			if isSelf then
				targetPos = targetPos + Vector3(0,0.3,0)
			end
			local randomX = UnityEngine.Random.Range(-0.1,0.1)
			local randomZ = UnityEngine.Random.Range(-0.1,0.1)
			targetPos = targetPos + Vector3(randomX, 0, randomZ)
			hitEffect = data.hitEffect
		end
		--射击特效
		local shootEffect = data.shootEffect
		-- print("CoveShowMgr:JustHit shootEffect 射击特效id", shootEffect)
		if shootEffect then
			self:playEffect(startPos, shootEffect, Quaternion.LookRotation(-shootRootTrans.right, shootRootTrans.up) * Quaternion.Euler(0, 180, 0), nil, nil, shootRootTrans)
		end
		self:playSmokeEffect(startPos, data.smoke, shootRootTrans)
		--延迟播放受击特效
		-- --LuaLogger.ds("CoveShowMgr:JustHit 延迟播放受击特效", data.dmgDelay)
		self:_DoAfter(data.dmgDelay, function()
			--命中
			local originFunc = function()
				print("CoveShowMgr:JustHit hitEffect id", hitEffect)
				if hitEffect then
					self:playEffect(targetPos, hitEffect, nil)
				end
				if hitResult.isHit and not targetRole:IsDead() then
					self:PlayHitAnim(targetRole)
				end
			end
			-- --LuaLogger.ds("CoveShowMgr:JustHit callback", callback)
			if (callback) then
				--LuaLogger.ds("CoveShowMgr:JustHit 执行回调")
				callback(hitResult.isHit, originFunc, nil, nil, targetRole)
			end
		end)
	end
end

---没有伤害数据的纯表现方法 治疗或纯表现用
---@class BulletDataJustEffect
---@field delay number			技能延迟时间 秒
---@field roleId number			角色id
---@field blockId number		源地块id
---@field targetBlockId number?	目标地块id
---@field targetRoleId number?	目标角色id
---@field shootEffect string	射击特效
---@field smoke number			烟雾特效
---@field hitEffect number		命中特效
---@field dmgDelay number		角色伤特效延迟
---@field beeff string			角色被击特效
---@field index number			子弹索引
---@field targetIndex number	单次技能目标索引 用于判断aoe类技能只在第一个角色地块受击时播放特效
---@param skillTargetBlockId number	技能目标地块id
---@param shootPos table		射击位置
---@param targetBlockIdList table	技能生效地块id列表

---@param data BulletDataJustEffect
---@param callback function
function CoveShowMgr:justEffect(data, callback)
	--LuaLogger.ds("CoveShowMgr:JustEffect", tablex.dump(data))
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
			LuaLogger.es("没有找到发射点位")
			return
		end
		local hitRootTrans, isSelf
		if targetModel then
			hitRootTrans, isSelf = self:__findHitPoint(targetModel, 1)
			if not hitRootTrans then
				LuaLogger.es("没有找到受击点位")
				return
			end
		end
		local blockObj = self:getBlockObj(blockid)
		-- local targetBlockObj = self:getBlockObj(targetBlockId)
		local skillTargetBlockObj = self:getBlockObj(skillTargetBlockId)
		local startPos = shootRootTrans.position
		local targetPos = skillTargetBlockObj.transform.position + Vector3(0, 0.5, 0)	--aoe选中地块位置
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
			print("CoveShowMgr:JustEffect shootEffect 射击特效id", shootEffect)
			--攻击特效
			if shootEffect then
				self:playEffect(startPos, shootEffect, Quaternion.LookRotation(-shootRootTrans.right, shootRootTrans.up) * Quaternion.Euler(0, 180, 0), nil, nil, shootRootTrans)
			end
			self:playSmokeEffect(startPos, data.smoke, shootRootTrans)
			--命中地块
			print("CoveShowMgr:JustEffect hitEffect 地块受击特效id", hitEffect)
			if hitEffect then
				self:playEffect(targetPos, hitEffect)
			end
		end
		--延迟播放角色特效 4类型没有子弹数据 为治疗或为纯表现
		if data.targetBlockIdList and tablex.size(data.targetBlockIdList) > 0 then
			for _, id in pairs(data.targetBlockIdList) do
				local blockObj = self:getBlockObj(id)
				--地格地面位置
				local blockObjPos = blockObj.transform.position + Vector3(0, 0.5, 0)
				self:_DoAfter(dmgDelay, function()
					--LuaLogger.ds("CoveShowMgr:JustEffect beEffect 角色受击特效id", beEffect)
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
---@field targetRoleId number	目标角色id
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
function CoveShowMgr:areaAttack(data, callback)
	--LuaLogger.ds("CoveShowMgr:areaAttack", tablex.dump(data))
	local roleId = data.roleId
	local targetRoleId = data.targetRoleId
	local blockid = data.blockId
	local targetBlockId = data.targetBlockId
	local skillTargetBlockId = data.skillTargetBlockId
	local role = self:getRole(roleId)
	local model = role.model
	local targetRole = self:getRole(targetRoleId)
	local targetModel = targetRole.model
	local dmgDelay = data.dmgDelay or 0
	local perfTime = 0

	if (model) then
		local shootRootTrans = self:__findShootPoint(model, data.shootPos)
		if not shootRootTrans then
			LuaLogger.es("没有找到发射点位")
			return
		end
		local hitRootTrans, isSelf = self:__findHitPoint(targetModel, 1)
		if not hitRootTrans then
			LuaLogger.es("没有找到受击点位")
			return
		end
		local blockObj = self:getBlockObj(blockid)
		local targetBlockObj = self:getBlockObj(targetBlockId)
		local skillTargetBlockObj = self:getBlockObj(skillTargetBlockId)
		local startPos = shootRootTrans.position
		local targetPos = skillTargetBlockObj.transform.position + Vector3(0, 0.5, 0)	--aoe选中地块位置
		local roleTargetPos = hitRootTrans.position	--角色受击位置
		--命中选中地块特效
		local hitEffect = data.hitEffect
		--射击特效
		local shootEffect = data.shootEffect
		--受击特效
		local beEffect = data.beeff
		--若是自身位置 则需要上移
		if isSelf then
			roleTargetPos = roleTargetPos + Vector3(0,0.3,0)
		end
		--只有第一个角色受击时播放特效
		if data.targetIndex == 1 then
			print("CoveShowMgr:areaAttack shootEffect 射击特效名称", shootEffect)
			--攻击特效
			if shootEffect then
				self:playEffect(startPos, shootEffect, Quaternion.LookRotation(-shootRootTrans.right, shootRootTrans.up) * Quaternion.Euler(0, 180, 0), nil, nil, shootRootTrans)
			end
			self:playSmokeEffect(startPos, data.smoke, shootRootTrans)
			--命中地块
			print("CoveShowMgr:areaAttack hitEffect 地块受击特效", hitEffect)
			if hitEffect then
				self:playEffect(targetPos, hitEffect, nil, data.hitResult, GE.SkillPerformanceType.AreaAttack)
			end
		end
		--延迟播放角色受击特效+跳字
		self:_DoAfter(dmgDelay, function()
			print("CoveShowMgr:areaAttack hitEffect 角色受击特效id", beEffect)
			self:playEffect(roleTargetPos, beEffect)
			if data.hitResult then
				local hitResult = data.hitResult
				--转换表现类型
				local disType = self:getDisTypeByHitType(hitResult.type, GE.CannonHitToDis)
				--伤害跳字
				if hitResult then
					self:playHitText(hitResult, targetRoleId, roleTargetPos, disType)
				end
			end
		end)
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
---@field targetBlockId number	目标地块id
---@field targetRoleId number	目标角色id
---@field hitEffect number		命中特效
---@field hitResult HitResult[]	伤害详情
---@field bombDetail bombDetail[]	炸弹详情
---@field height number			飞机高度
---@field allPlaneNum number	总计飞机数量
---@field dmgDelay number			飞机类型
---@field area integer[]			飞机速度
---@field skillTargetBlockId number	技能选中目标格子id
---@field targetIndex		单次技能目标索引 用于判断aoe类技能只在第一个角色地块受击时播放特效
---@field shootPos table		射击位置
---@field allTargetList table?	本次技能全部受击目标，用于领机平飞时播放防空特效

---@param data BulletDataPlaneBombing
---@param callback function
function CoveShowMgr:PlaneBombing(data, callback)
	--LuaLogger.ds("CoveShowMgr:PlaneBombing", tablex.dump(data))
	local roleId = data.roleId
	local targetRoleId = data.targetRoleId
	local blockid = data.blockId
	local targetBlockId = data.targetBlockId
	local skillTargetBlockId = data.skillTargetBlockId
	local role = self:getRole(roleId)
	local model = role.model
	local targetRole = self:getRole(targetRoleId)
	local targetModel = targetRole.model
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
			LuaLogger.es("没有找到发射点位")
			return
		end
		local hitRootTrans, isSelf = self:__findHitPoint(targetModel, 1)
		if not hitRootTrans then
			LuaLogger.es("没有找到受击点位")
			return
		end
		--LuaLogger.ds("CoveShowMgr:PlaneBombing")
		--aoe类技能只在第一个角色受击时播放表现
		if data.targetIndex == 1 then
			--飞机 起飞 - 平飞 - 俯冲 - 离场
			PoolMgr:Get(string.format(Config.PrefabPath.BulletPrefab, data.planeName), function (planeObj)
				--起飞音效
				--LuaLogger.ds("CoveShowMgr:PlaneBombing")
				local soundPath = string.format(Config.AudioPath.SE, "plane1")
				local fadeInTime = 1
				local targetVolume = 0.5
				LuaMain:play3DSound(soundPath, targetVolume, nil, nil, 1, fadeInTime, nil, planeObj, 20, 2)
				local blockObj = self:getBlockObj(blockid)
				local targetBlockObj = self:getBlockObj(targetBlockId)
				local skillTargetBlockObj = self:getBlockObj(skillTargetBlockId)
				local startPos = shootRootTrans.position
				local startBlockPos = blockObj.transform.position + Vector3(0, 0.5, 0)	--地毯式轰炸起始地块位置
				local selectedPos = skillTargetBlockObj.transform.position + Vector3(0, 0.5, 0)	--地毯式轰炸选中地块位置
				--LuaLogger.ds("CoveShowMgr:PlaneBombing area", tablex.dump(data.area))
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
				if data.index == 1 then
					airDefensePendingMap = {}
					if data.allTargetList then
						for _, targetInfo in ipairs(data.allTargetList) do
							local pendingTargetRole = self.getRole and self:getRole(targetInfo.targetRoleId) or nil
							airDefensePendingMap[targetInfo.targetRoleId] = {
								targetRoleId = targetInfo.targetRoleId,
								targetBlockId = targetInfo.targetBlockId,
								targetRole = pendingTargetRole,
							}
						end
					else
						airDefensePendingMap[targetRoleId] = {
							targetRoleId = targetRoleId,
							targetBlockId = targetBlockId,
							targetRole = targetRole,
						}
					end
				end
				--贝赛尔曲线 飞机起飞
				--LuaLogger.ds("CoveShowMgr:PlaneBombing")
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
							local hasPending = self:__tryPlayAirDefenseEffectsByDist(pos, flyDirTakeoff, role, airDefensePendingMap, blockObj)
							if not hasPending then
								airDefensePendingMap = nil
							end
						end
					end, 
					--起飞结束
					function()
						local startPos = planeObj.transform.position
						local flyToward = (endPos + offset) - startPos
						local index = (torpedoEnd - takeOffTime)/(1 - takeOffTime)
						local flyEndPos = Vector3(startPos.x + flyToward.x * index, startPos.y, startPos.z + flyToward.z * index)
						local distance = Vector3.Distance(startPos, flyEndPos)
						local speed = data.speed * Time.timeScale	--平飞速度
						local time = distance/speed	--平飞总时间
						local startDroped = false	--是否开始丢鱼雷
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
									local hasPending = self:__tryPlayAirDefenseEffectsByDist(pos, flyDir, role, airDefensePendingMap, blockObj)
									if not hasPending then
										airDefensePendingMap = nil
									end
								end
							end, 
							function()
								--离场
								PoolMgr.Free(planeObj)
								-- if callback then
								-- 	callback()
								-- end
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
									local targetPos = Vector3(startPos.x, 0.5, startPos.z)
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

		--地毯式轰炸只在每个目标的第一家飞机战报里播放伤害
		if data.index == 1 then
			--延迟播放角色受击特效+跳字
			local roleTargetPos = hitRootTrans.position	--角色受击位置
			--若是自身位置 则需要上移
			if isSelf then
				roleTargetPos = roleTargetPos + Vector3(0,0.3,0)
			end
			self:_DoAfter(data.dmgDelay, function()
				if data.hitResult then
					local hitResult = data.hitResult
					--转换表现类型
					local disType = self:getDisTypeByHitType(hitResult.type, GE.CannonHitToDis)
					--伤害跳字
					if hitResult then
						self:playHitText(hitResult, targetRoleId, roleTargetPos, disType)
					end
				end
			end)
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
---@field targetBlockId number	目标地块id
---@field targetRoleId number	目标角色id
---@field shootEffect number	射击炮口特效
---@field smoke number			烟雾特效
---@field hitEffect number		攻击特效
---@field hitResult HitResult	伤害详情
---@field dmgDelay number		角色伤害跳字延迟
---@field beeff number			角色被击特效
---@field index number			子弹索引
---@field targetIndex number	单次技能目标索引 用于判断aoe类技能只在第一个角色地块受击时播放特效
---@field skillTargetBlockId number	技能目标地块id
---@field shootPos table		射击位置

---@param data BulletDataRailAttack
---@param callback function
function CoveShowMgr:RailAttack(data, callback)
	--LuaLogger.ds("CoveShowMgr:RailAttack", tablex.dump(data))
	local roleId = data.roleId
	local targetRoleId = data.targetRoleId
	local blockid = data.blockId
	local targetBlockId = data.targetBlockId
	local skillTargetBlockId = data.skillTargetBlockId
	local role = self:getRole(roleId)
	local model = role.model
	local targetRole = self:getRole(targetRoleId)
	local targetModel = targetRole.model
	local dmgDelay = data.dmgDelay or 0
	local perfTime = 0

	if (model) then
		local shootRootTrans = self:__findShootPoint(model, data.shootPos)
		if not shootRootTrans then
			LuaLogger.es("没有找到发射点位")
			return
		end
		local hitRootTrans, isSelf = self:__findHitPoint(targetModel, 1)
		if not hitRootTrans then
			LuaLogger.es("没有找到受击点位")
			return
		end
		local blockObj = self:getBlockObj(blockid)
		local targetBlockObj = self:getBlockObj(targetBlockId)
		local skillTargetBlockObj = self:getBlockObj(skillTargetBlockId)
		local startPos = shootRootTrans.position
		local targetPos = skillTargetBlockObj.transform.position + Vector3(0, 0.5, 0)	--aoe选中地块位置
		local roleTargetPos = hitRootTrans.position	--角色受击位置
		--定向攻击特效
		local hitEffect = data.hitEffect
		--射击特效
		local shootEffect = data.shootEffect
		--受击特效
		local beEffect = data.beeff
		--若是自身位置 则需要上移
		if isSelf then
			roleTargetPos = roleTargetPos + Vector3(0,0.3,0)
		end
		--只有第一个角色受击时播放特效
		if data.targetIndex == 1 then
			print("CoveShowMgr:RailAttack shootEffect 射击特效名称", shootEffect)
			--攻击特效
			if shootEffect then
				self:playEffect(startPos, shootEffect)
			end
			self:playSmokeEffect(startPos, data.smoke, shootRootTrans)
			--轨道攻击特效 水平方向
			print("CoveShowMgr:RailAttack hitEffect 轨道攻击特效", hitEffect)
			local direction = skillTargetBlockObj.transform.position - blockObj.transform.position
			direction.y = 0
			local rotation = Quaternion.LookRotation(direction)
			local pos = model.transform.position
			if hitEffect then
				self:playEffect(pos, hitEffect, rotation, data.hitResult, GE.SkillPerformanceType.RailAttack)
			end
		end
		--延迟播放角色受击特效+跳字
		self:_DoAfter(dmgDelay, function()
			print("CoveShowMgr:RailAttack beEffect 角色受击特效id", beEffect)
			self:playEffect(roleTargetPos, beEffect)
			if data.hitResult then
				local hitResult = data.hitResult
				--转换表现类型
				local disType = self:getDisTypeByHitType(hitResult.type, GE.CannonHitToDis)
				--伤害跳字
				if hitResult then
					self:playHitText(hitResult, targetRoleId, roleTargetPos, disType)
				end
			end
		end)
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
function CoveShowMgr:TorpedoAttack(data, callback)
	--LuaLogger.ds("CoveShowMgr:TorpedoAttack")
	local role = data.role
	local model = role._model
	local targetRole = data.target
	local targetModel = targetRole._model
	local targetGroundPos = Vector3(targetRole.modelObj.transform.position.x, 0, targetRole.modelObj.transform.position.z)
	local perfTime = 0
	if (model) then
		local shootRootTrans = self:__findShootPoint(model, data.shootPos)
		if not shootRootTrans then
			LuaLogger.es("没有找到发射点位")
			return
		end
		--鱼雷
		--LuaLogger.ds("鱼雷路径", string.format(Config.PrefabPath.BulletPrefab, data.bulletName))
		PoolMgr:Get(string.format(Config.PrefabPath.BulletPrefab, data.bulletName), function (torpedoObj)
			--LuaLogger.ds("torpedoObj", torpedoObj)
			local startPos = shootRootTrans.position	--炮口
			local targetPos = targetGroundPos + Vector3(UnityEngine.Random.Range(-0.1,0.1), 0, UnityEngine.Random.Range(-0.1,0.1))	--目标地面位置
			local hitResult = data.hitResult
			local hitEffect	--命中特效
			-- local toward = targetPos - startPos	--默认方向打到目标脚下地面上
			--未命中 则鱼雷穿过目标位置随机偏移并向后延伸随机1~2米
			if not hitResult.isHit then
				local randomX = UnityEngine.Random.Range(0.2,0.3)
				local randomX = randomX * (math.random(0,1) == 0 and -1 or 1)
				local randomZ = UnityEngine.Random.Range(0.2,0.3)
				local randomZ = randomZ * (math.random(0,1) == 0 and -1 or 1)
				targetPos = targetPos + Vector3(randomX, 0, randomZ)
			else
				local randomX = UnityEngine.Random.Range(-0.1,0.1)
				local randomZ = UnityEngine.Random.Range(-0.1,0.1)
				targetPos = targetPos + Vector3(randomX, 0, randomZ)
				hitEffect = data.hitEffect
			end
			--射击特效
			local shootEffect = data.shootEffect
			print("CoveShowMgr:TorpedoAttack shootEffect 射击特效id", shootEffect)
			if shootEffect then
				self:playEffect(startPos, shootEffect, Quaternion.LookRotation(-shootRootTrans.right, shootRootTrans.up) * Quaternion.Euler(0, 180, 0), nil, nil, shootRootTrans)
			end
			self:playSmokeEffect(startPos, data.smoke, shootRootTrans)
			--鱼雷流程 丢到水中->加速->命中或穿过
			--鱼雷起始位置
			torpedoObj.transform.position = startPos
			torpedoObj.transform:LookAt(targetPos)
			--鱼雷下落保持水平
			torpedoObj.transform.eulerAngles = Vector3(0, torpedoObj.transform.eulerAngles.y, 0)
			--鱼雷丢到水中位置
			-- local groundx = toward.normalized.x * UnityEngine.Random.Range(0.1,0.2)
			-- local groundz = toward.normalized.z * UnityEngine.Random.Range(0.1,0.2)
			-- local groundPos = blockObj.transform.position + Vector3(groundx, 0.2, groundz)
			local groundPos = Vector3(startPos.x, 0, startPos.z)
			local bezierPoint = self:getBezierPoint(startPos, targetPos, 0.2, Vector3(0, 0.3, 0))
			local distance = Vector3.Distance(targetPos , groundPos)
			local speed = 2 * Time.timeScale	--鱼雷下落速度
			local totalTime = distance/speed
			local isfree = false
			self:TorpedoDrop(torpedoObj, startPos, {}, groundPos, targetPos, totalTime, function(velocity)
				local maxMissTime = 3
				local missTimerIndex = 0
				local missFuncStarted = false
				local freeTorpedo = function()
					if isfree then
						return
					end
					self:_stopTimerByIndex(missTimerIndex)
					missTimerIndex = 0
					if torpedoObj and not IsNull(torpedoObj) then
						PoolMgr.Free(torpedoObj)
					end
					isfree = true
				end
				--原本应该命中但角色离开 让鱼雷继续向原有轨迹前进
				local missFunc = function()
					if missFuncStarted or isfree then
						return
					end
					missFuncStarted = true
					--LuaLogger.ds("CoveShowMgr:TorpedoAttack 鱼雷 missFunc", velocity)
					local passTime = 0.02 				--刷新间隔
					local times = maxMissTime/passTime
					local num = tablex.size(self._timerlist) + 1
					missTimerIndex = num
					local timer = self:_DoRepeat(passTime, times, function ()
						if isfree or IsNull(torpedoObj) then
							self:_stopTimerByIndex(missTimerIndex)
							missTimerIndex = 0
							return
						end
						local position = torpedoObj.transform.position
						position = position + velocity * passTime
						torpedoObj.transform:LookAt(position)
						torpedoObj.transform.position = position
					end)
					self._timerlist[num] = timer
				end
				local originFunc = function()
					--LuaLogger.ds("CoveShowMgr:TorpedoAttack 鱼雷 originFunc")
					if hitResult.isHit then
						if hitEffect then
							self:playEffect(targetPos, hitEffect, nil)
						end
						if not targetRole:IsDead() then
							self:PlayHitAnim(targetRole)
						end
						freeTorpedo()
					else
						missFunc()
					end
				end

				if (callback) then
					callback(hitResult.isHit, originFunc, missFunc, torpedoObj, targetRole)
				end
				self:_DoAfter(maxMissTime, function()
					freeTorpedo()
				end)
			end)
		end)
	end
end

--播放受击动画
function CoveShowMgr:PlayHitAnim(targetRole)
	if not targetRole:GetAttackAnimState() then
		targetRole._model:PlayAnim(RoleModelAnimEnum.Hit)
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
function CoveShowMgr:TorpedoDrop(torpedoObj, startPos, bezierList, groundPos, targetPos, totalTime, callback)
	--落水加速
	-- --LuaLogger.ds("CoveShowMgr:TorpedoAttack 鱼雷下落 加速准备" .. "起点: ", startPos)
	-- --LuaLogger.ds("CoveShowMgr:TorpedoAttack 鱼雷下落 加速准备" .. "地面: ", groundPos)
	-- --LuaLogger.ds("CoveShowMgr:TorpedoAttack 鱼雷下落 加速准备" .. "目标点: ", targetPos)
	local nextFunc = function(groundPos, targetPos)
		--开鱼雷特效
		self:setTorpedoEffect(torpedoObj, true)
		self:SetTrailEmitting(torpedoObj, true)
		-- --LuaLogger.ds("CoveShowMgr:TorpedoAttack 落水完成 准备加速")
		local distance = Vector3.Distance(groundPos, targetPos)
		local speed = 1.5 * Time.timeScale
		local totalTime = distance/speed
		-- --LuaLogger.ds("CoveShowMgr:TorpedoAttack 鱼雷加速目标位置: ", targetPos)
		-- --LuaLogger.ds("CoveShowMgr:TorpedoAttack 鱼雷加速起始位置: ", groundPos)
		local finalVelocity = Vector3.zero
		local lastPosition = torpedoObj.transform.position
		local lastTime = Time.time
		torpedoObj.transform:DOMove(targetPos, totalTime):SetEase(DG.Tweening.Ease.InQuad):OnComplete(
			function ()
				if callback then
					callback(finalVelocity)
				end
			end
		):OnUpdate(function()
			local currentTime = Time.time
			local currentPosition = torpedoObj.transform.position
			
			-- 固定时间间隔采样（0.02秒）
			if currentTime - lastTime >= 0.02 then
				local deltaTime = currentTime - lastTime
				if deltaTime > 0.001 then
					local calSpeed = (currentPosition - lastPosition) / deltaTime
					finalVelocity = calSpeed.magnitude  > finalVelocity.magnitude and calSpeed or finalVelocity
					lastPosition = currentPosition
					lastTime = currentTime
				end
			end
		end)
		local soundPath = string.format(Config.AudioPath.SE, "fight_yulei")
		-- --LuaLogger.ds("CoveShowMgr:TorpedoAttack 鱼雷加速音效", soundPath)
		LuaMain:play3DSound(soundPath, 0.5, nil, nil, 1, 0.1, nil, torpedoObj, 20, 2)
	end
	--起始点在水下 需要直接释放
	if startPos.y < 0 then
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
				-- --LuaLogger.ds("CoveShowMgr:TorpedoAttack 落水过程", progress)
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

---设置鱼雷特效
function CoveShowMgr:setTorpedoEffect(obj, isShow)
	local trans = UICommonUtils.FindDeepChild(obj.transform, "Effect")
	if trans then
		trans.gameObject:SetActive(isShow)
	end
end

--清除拖尾
function CoveShowMgr:ClearTrail(obj)
	local trails = self:findComponent(obj, typeof(UnityEngine.TrailRenderer))
	for _, trail in pairs(trails) do
		trail:Clear()
	end
end

--设置拖尾发射状态
function CoveShowMgr:SetTrailEmitting(obj, isEmitting)
	local trails = self:findComponent(obj, typeof(UnityEngine.TrailRenderer))
	for _, trail in pairs(trails) do
		trail.emitting = isEmitting
	end
end

--拖尾类特效结束 需要先隐藏meshrender 然后等待拖尾消失后再显示meshrender 然后free
function CoveShowMgr:TrailEmittingEnd(obj)
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

function CoveShowMgr:findComponent(obj, component, result)
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

--dotween位移
---@class RoleOffsetMoveData
---@field roleId number	角色id
---@field offset number	高度偏移量
---@param data RoleOffsetMoveData
function CoveShowMgr:RoleOffsetMove(data, callback)
	--LuaLogger.ds("CoveShowMgr:RoleOffsetMove", tablex.dump(data))
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
function CoveShowMgr:MissileAttack(data, callback)
	--LuaLogger.ds("CoveShowMgr:MissileAttack", tablex.dump(data))
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
			LuaLogger.es("没有找到发射点位")
			return
		end
		local hitRootTrans, isSelf = self:__findHitPoint(targetModel, 1)
		if not hitRootTrans then
			LuaLogger.es("没有找到受击点位")
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
				targetPos = targetBlockObj.transform.position + Vector3(randomX, 0.5, randomZ)
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
			--LuaLogger.ds("CoveShowMgr:MissileAttack shootEffect 射击特效id", shootEffect)
			if shootEffect then
				self:playEffect(startPos, shootEffect, Quaternion.LookRotation(-shootRootTrans.right, shootRootTrans.up) * Quaternion.Euler(0, 180, 0), nil, nil, shootRootTrans)
			end
			self:playSmokeEffect(startPos, data.smoke, shootRootTrans)
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
							self:_DoAfter(0.5, function()
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

---播放特效
---@param pos Vector3
---@param id number
---@param rotation UnityEngine.Quaternion?
---@param hitResult table?
---@param performanceType integer?
---@param parentTransform UnityEngine.Transform?
---@param time number?
---@param onLoaded fun(obj: UnityEngine.GameObject)?
function CoveShowMgr:playEffect(pos, id, rotation, hitResult, performanceType, parentTransform, time, onLoaded)
	--特效
	if id == 0 or id == "" then
		return
	end
	--LuaLogger.ds("CoveShowMgr:playEffect", pos, id)
	local effectConfig = Config.GetSoundAndEffectInfo(id)
	if not effectConfig then
		LuaLogger.ws("特效配置不存在  ", id)
		return
	end
	local effectName = effectConfig.effectResource
	local effectPath = string.format(Config.PrefabPath.BattleEffect, effectName, effectName)
	local effectDuration = 2
	if type(time) == "number" and time > 0 then
		effectDuration = time
	elseif effectConfig.continuousTime and effectConfig.continuousTime > 0 then
		effectDuration = effectConfig.continuousTime
	end
	PoolMgr:Get(effectPath, function (obj)
		if (obj) then
			--LuaLogger.ds("CoveShowMgr:playEffect", effectPath)
			obj.transform.position = pos
			if parentTransform then
				obj.transform:SetParent(parentTransform)
			end
			if rotation then
				--LuaLogger.ds("CoveShowMgr:playEffect rotation", rotation)
				obj.transform.rotation = rotation
			end
			---@type UnityEngine.ParticleSystem
			local effect1 = obj.transform:Find("Effect")
			if effect1 then
				local particle = effect1:GetComponent("ParticleSystem")
				if particle then
					particle:Simulate(0)
					particle:Play()
				end
			end
			local effect2 = obj.transform:Find("Effect_2")
			if (effect2) then
				---@type UnityEngine.ParticleSystem
				local particle2 = effect2:GetComponent("ParticleSystem")
				if particle2 then
					particle2:Simulate(0)
					particle2:Play()
				end
			end
			if onLoaded then
				onLoaded(obj)
			end
			self:_DoAfter(effectDuration, function()
				if obj then
					obj:SetParent(PoolMgr.objRoot.transform)
					PoolMgr.Free(obj)
				end
			end)
		end
		--特效对应音效
		local soundName = effectConfig.SoundResource
		local soundPath = string.format(Config.AudioPath.SE, soundName)
		if soundName and soundName ~= "" then
			--LuaLogger.ds("CoveShowMgr:playEffect soundPath", soundPath)
			self:_DoAfter(effectConfig.delay, function()
				-- LuaMain:play3DSound(soundPath)
				if obj then
					LuaMain:play3DSound(soundPath, 0.5, nil, nil, 1, 0.1, nil, obj, 20, 2)
				end
			end)
		end
	end)
end

-- function CoveShowMgr:getBezierPointV2(sPos, ePos, middleValue, curve)
-- 	return sPos + (ePos - sPos) * speedValue + Vector2.New(0,0,curveValue)
-- end

---计算三维贝塞尔点位（基于朝向的偏移，包含Y轴）
---@param sPos Vector3 起始点
---@param ePos Vector3 结束点
---@param middleValue number 0 ~ 1 插值比例
---@param curve Vector3 偏移量（x为横向，y为垂直方向，z为前进方向）
function CoveShowMgr:getBezierPoint(sPos, ePos, middleValue, curve)
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
function CoveShowMgr:startBezierMove(startPos, bezierPointList, endPos, totalTime, updateFunc, endFunc, curve)
	if not totalTime or totalTime == 0 then
		endFunc()
		--LuaLogger.ds("CoveShowMgr:startBezierMove", "totalTime is 0,直接结束")
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
	--LuaLogger.ds("贝塞尔点位表", tablex.dump(pointList))
	local timer = self:_DoRepeat(passTime, times, function ()
		currentTimes = currentTimes + 1
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
		--到终点
		if (currentTimes == times) then
			if endFunc then
				endFunc()
			end
		end
	end)
	self._timerlist[#self._timerlist + 1] = timer
end


return CoveShowMgr