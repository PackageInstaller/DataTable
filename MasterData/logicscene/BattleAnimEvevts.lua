-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/skills/BattleAnimEvevts.lua

module("logicscene.scene.battle.skills.skills.BattleAnimEvevts", package.seeall)

local BattleAnimEvevts = class("BattleAnimEvevts")
local skillEffectLayer = Framework.LayerUtil.NameToLayer("SkillEffects")
local skillEffectLayer_II = Framework.LayerUtil.NameToLayer("SkillEffects3")
local typeAnimation = typeof(UnityEngine.Animation)
local luaMaskSceneObject, maskSceneObject, maskSceneColor

function BattleAnimEvevts.createMaskSceneObject()
	if not maskSceneObject then
		local tf = GlobalModel.instance.groundCamera.transform:Find("SceneMaskColor")

		if tf then
			maskSceneObject = tf.gameObject
		else
			maskSceneObject = UnityEngine.GameObject.New("SceneMaskColor")

			maskSceneObject.transform:SetParent(GlobalModel.instance.groundCamera.transform)
			maskSceneObject:SetActive(false)
		end
	end
end

function BattleAnimEvevts.createLuaMaskSceneObject()
	if not luaMaskSceneObject then
		luaMaskSceneObject = UnityEngine.GameObject.CreatePrimitive(UnityEngine.PrimitiveType.Quad)
		luaMaskSceneObject.name = "luaMaskSceneObject"
		luaMaskSceneObject.layer = SceneLayer.Ground3D_Value

		luaMaskSceneObject.transform:SetParent(GlobalModel.instance.groundCamera.transform)

		luaMaskSceneObject.transform.localScale = Vector3.New(2048, 2048, 1)
		luaMaskSceneObject.transform.localEulerAngles = Vector3.zero
		luaMaskSceneObject.transform.localPosition = Vector3.New(0, 0, 1)

		local mc = luaMaskSceneObject:GetComponent(typeof(UnityEngine.MeshCollider))

		if mc ~= nil then
			UnityEngine.GameObject.DestroyImmediate(mc)
		end

		local renderer = luaMaskSceneObject:GetComponent(typeof(UnityEngine.Renderer))
		local mat = UnityEngine.Material.New(Framework.ShaderCache.Find("aounity/scene/unlit_nofog_transparent"))

		renderer.material = mat
		maskSceneColor = UnityEngine.Color.New(0, 0, 0, 0.75)
		mat.color = maskSceneColor

		luaMaskSceneObject:SetActive(false)
	end

	BattleAnimEvevts.createMaskSceneObject()
end

function BattleAnimEvevts.tryMaskSceneColor(hideObsUnits, time)
	BattleAnimEvevts.createLuaMaskSceneObject()

	if maskSceneObject and maskSceneObject.activeSelf then
		AMFadeObjectColor.StopFade(maskSceneObject)

		local colorId = MaterialUtils.colorId
		local maskStartColor = UnityEngine.Color.New(0, 0, 0, 0.75)
		local maskEndColor = UnityEngine.Color.New(0, 0, 0, 0.75)

		if hideObsUnits then
			maskStartColor.a = 0
		else
			maskEndColor.a = 0
		end

		AMFadeObjectColor.StopFade(luaMaskSceneObject)
		AMFadeObjectColor.StartFade(luaMaskSceneObject, colorId, time, 21, maskStartColor, maskEndColor, false)
		luaMaskSceneObject:SetActive(true)
		maskSceneObject:SetActive(false)
	end
end

function BattleAnimEvevts.setLuaMaskSceneObjectVisible(visible)
	if luaMaskSceneObject then
		luaMaskSceneObject:SetActive(visible or false)
	end
end

function BattleAnimEvevts.onSkipToFrame(unit, deltaTime)
	unit:onPlaySkillAnimSkipToFrame(deltaTime)
end

function BattleAnimEvevts.onPlaySpineAnimation(unit, go, animName, loop, flipX, speed)
	if goutil.isNil(go) then
		return
	end

	if go == unit.go then
		local isIdle = animName == UnitAnimState.Idle

		if isIdle then
			loop = true
		end

		local duration = unit.spine:play(animName, loop, true)

		if unit.attrs:isFrozen() then
			speed = 0
		end

		unit.spine:setPlaySpeed(speed)

		if not isIdle then
			if not loop then
				unit:onPlaySkillAnim(duration)
			else
				unit:onPlaySkillAnim(math.huge)
			end
		else
			unit:onPlaySkillAnim(-1)
		end
	else
		GoUtil.PlaySpineAnim(go, animName, flipX, loop, true, speed)
	end
end

function BattleAnimEvevts.onPlayEffect(unit, effectName, posX, posY, posZ, loop)
	local effect = {}

	effect.path = effectName
	effect.posX = posX
	effect.posY = posY
	effect.posZ = posZ
	effect.loop = loop

	if not checknumber(effectName) then
		unit.battleEffects:playEffect(effect)
	end
end

function BattleAnimEvevts.onActiveEffect(unit, go, loop)
	go:SetActive(true)

	local anims = go:GetComponentsInChildren(typeAnimation, true)

	for i = 0, anims.Length - 1 do
		anims[i].enabled = true

		anims[i]:Play()
	end

	if go ~= unit.go then
		local goname = go.name
		local isLookTgt = string.find(goname, "__looktotarget")
		local rightTeamId = BattleModel.instance:getRightTeamId()

		if not GoUtil.TryMirrorFlipCamera(go, unit.teamId == rightTeamId) and not string.find(goname, "__dontflip") and not isLookTgt then
			if string.find(goname, "_rotateflipx") then
				unit.battleEffects:updateEffectRotateWithFlipX(go)
			else
				unit.battleEffects:updateEffectScaleWithFlipX(go, string.find(goname, "_nagetive"))
			end
		end

		if unit.posRow ~= -1 and not isLookTgt and go.layer ~= skillEffectLayer and go.layer ~= skillEffectLayer_II and string.find(goname, "fx_") and not string.find(goname, "_dontorder") then
			local order = unit:getSortingOrder()
			local comp = go:GetComponent(typeof(AMFollowTarget))

			if comp and comp.target then
				local arr = string.split(comp.target.name, " ") or {}
				local teamId = string.gsub(arr[1], "team", "")

				teamId = checknumber(teamId)

				local id = string.gsub(tostring(arr[2]), "character", "")

				id = checknumber(id)

				local scene = SceneMgr.instance:getCurScene()

				if scene and scene.unitFactory and scene.unitFactory.getAllUnit then
					local units = scene.unitFactory:getAllUnit() or {}

					if not units[teamId] then
						local temp = {}
						local targetUnit = temp[id]

						if targetUnit then
							order = targetUnit:getSortingOrder()
						end
					end
				end
			end

			if order then
				GoUtil.SetSortingOrderGreatZero(go, order)
			end
		end
	end
end

function BattleAnimEvevts.onDeActiveEffect(go)
	local anims = go:GetComponentsInChildren(typeAnimation, true)

	for i = 0, anims.Length - 1 do
		anims[i]:Stop()

		anims[i].enabled = false
	end

	go:SetActive(true)
end

function BattleAnimEvevts.onMove(go, position)
	go.transform.position = position
end

function BattleAnimEvevts.onHurt(effectName, hagPoint, playHit, damege, sound, count)
	local cData = {}

	cData.speed = 0
	cData.radius = 0
	cData.repel = 0
	cData.repalSpeed = 0
	cData.hitFly = 0
	cData.delay = 0
	cData.damage = damege
	cData.isHard = playHit
	cData.count = count
	cData.prefabsPathSound = sound
	cData.hagPoint = hagPoint
	cData.prefabsPathHit = effectName

	return cData
end

function BattleAnimEvevts.onCollision(index, cData)
	local collisionInfo = {}

	collisionInfo.index = index
	collisionInfo.targetType = cData.targetType
	collisionInfo.posX = cData.posStartX
	collisionInfo.posY = cData.posStartY
	collisionInfo.posZ = cData.posStartZ
	collisionInfo.dirX = cData.dirStartX
	collisionInfo.dirY = cData.dirStartY
	collisionInfo.dirZ = cData.dirStartZ
	collisionInfo.speed = cData.speed
	collisionInfo.radius = cData.radius
	collisionInfo.repel = cData.repel
	collisionInfo.repelSpeed = cData.repalSpeed
	collisionInfo.hitfly = cData.hitFly
	collisionInfo.delay = cData.delay
	collisionInfo.damage = cData.damage
	collisionInfo.isHard = cData.isHard
	collisionInfo.isUniqued = cData.isUniqued
	collisionInfo.lockX = cData.lockX
	collisionInfo.lockY = cData.lockY
	collisionInfo.lockZ = cData.lockZ
	collisionInfo.lockRotate = cData.lockRotate
	collisionInfo.count = cData.count
	collisionInfo.damageCount = cData.damageCount
	collisionInfo.height = cData.height
	collisionInfo.spline = cData.spline
	collisionInfo.cData = cData
	collisionInfo.prefabsPath = cData.prefabsPath
	collisionInfo.hitsound = cData.prefabsPathSound
	collisionInfo.sound = cData.soundFly
	collisionInfo.hagPoint = cData.hagPoint
	collisionInfo.lookToTarget = cData.lookToTarget

	if cData.prefabsPathHit and #cData.prefabsPathHit > 0 then
		collisionInfo.hitEffect = {}
		collisionInfo.hitEffect.path = cData.prefabsPathHit
		collisionInfo.hitEffect.hagPoint = cData.hagPoint
		collisionInfo.hitEffect.flipWithRotate = cData.flipWithRotate

		if cData.rotateValid then
			collisionInfo.hitEffect.rx = cData.rx
			collisionInfo.hitEffect.ry = cData.ry
			collisionInfo.hitEffect.rz = cData.rz
		end

		collisionInfo.hitEffect.isHit = true
	end

	return collisionInfo
end

function BattleAnimEvevts.onShowUI(targets, show)
	local scene = SceneMgr.instance:getCurScene()
	local units = scene.unitFactory:getAllUnit()

	for k, v in pairs(units) do
		local sameUnits = v

		for k2, v2 in pairs(sameUnits) do
			if not v2.isSourceMon and not v2:isDead() and not v2.attrs:isCombinedSource() and v2.attrs:checkDoppelgangerVisible() then
				v2.unitUI:setVisible(show or false)
			end
		end
	end
end

function BattleAnimEvevts.onSendMsg(unit, skill, targets, go, msg, param1, param2)
	if msg == "cameramotion" then
		unit:startSkillCameraMotion(go, targets, param1, skill.disableRotationTrack)
	elseif msg == "heti" then
		BattleAnimEvevts.onStartCombine(unit)
	elseif msg == "jieti" then
		BattleAnimEvevts.onStartDisintegrate(unit)
	elseif msg == "OnDistortStart" then
		SceneEffDistortMgr.instance:startDistort(go, unit)
	elseif msg == "OnDistortEnd" then
		SceneEffDistortMgr.instance:stopDistort(go)
	end
end

function BattleAnimEvevts.onSkillWithDraw(skill)
	if maskSceneObject and maskSceneObject.activeSelf then
		maskSceneObject:SetActive(false)
	end

	if skill then
		skill:onSkillWithDraw()
	end
end

function BattleAnimEvevts.onShowNotTargets(unit, targets, show)
	if not targets then
		return
	end

	local cnt = #targets

	if cnt == 0 then
		return
	end

	local scene = SceneMgr.instance:getCurScene()
	local units = scene.unitFactory:getAllUnit()

	for k, v in pairs(units) do
		local sameUnits = v

		for k2, v2 in pairs(sameUnits) do
			if not v2.isSourceMon and v2 ~= unit and not v2.attrs:isDead() then
				local isTarget

				for i = 1, cnt do
					if v2 == targets[i].unit then
						isTarget = true

						break
					end
				end

				if not isTarget then
					v2:setVisible(show)
				end
			end
		end
	end
end

function BattleAnimEvevts.onUIFollowBone(unit, boneName)
	unit.unitUI:onUIFollowBone(boneName)
end

function BattleAnimEvevts.onUIStopFollowBone(unit)
	unit.unitUI:onUIStopFollowBone()
end

function BattleAnimEvevts.onHideSelf(unit, hide)
	unit:hideUIAndShadow(hide)
end

function BattleAnimEvevts.onHideBuffEffects(unit, hide)
	unit:hideBuffEffects(hide)
end

function BattleAnimEvevts.onSkillCamera(unit, targets, cam, hide, fadeUnits, includeTgts)
	if hide then
		BattleAnimEvevts.tweenSkillCameara(unit, targets, hide, includeTgts)

		if fadeUnits then
			BattleAnimEvevts._handleNoTargetBeforeSkillCamearaFinish(unit, targets, true, includeTgts)
		end
	end

	if fadeUnits then
		BattleAnimEvevts.fadeSkillCameara(unit, targets, hide, includeTgts)
	end
end

function BattleAnimEvevts.onSkillCameraFinish(unit, targets, cam, includeTgts, fadeUnits)
	if not fadeUnits then
		includeTgts = nil
	end

	BattleAnimEvevts.tweenSkillCameara(unit, targets, false, includeTgts)

	if fadeUnits then
		BattleAnimEvevts._handleNoTargetBeforeSkillCamearaFinish(unit, targets, false, includeTgts)
	end
end

function BattleAnimEvevts._handleNoTargetBeforeSkillCamearaFinish(unit, targets, ishide, includeTgts)
	if not targets then
		return
	end

	local cnt = #targets

	if cnt == 0 then
		return
	end

	if not includeTgts then
		local scene = SceneMgr.instance:getCurScene()
		local units = scene.unitFactory:getAllUnit()

		for k, v in pairs(units) do
			local sameUnits = v

			for k2, v2 in pairs(sameUnits) do
				if not v2.isSourceMon and v2 ~= unit and (not ishide or not v2.attrs:isDead()) then
					local isTarget

					for i = 1, cnt do
						if v2 == targets[i].unit then
							isTarget = true

							break
						end
					end

					if not isTarget then
						v2:onSkillCamera(ishide)
					end
				end
			end
		end
	else
		local scene = SceneMgr.instance:getCurScene()
		local units = scene.unitFactory:getAllUnit()

		for k, v in pairs(units) do
			local sameUnits = v

			for k2, v2 in pairs(sameUnits) do
				if not v2.isSourceMon and v2 ~= unit and (not ishide or not v2.attrs:isDead()) then
					v2:onSkillCamera(ishide)
				end
			end
		end
	end
end

function BattleAnimEvevts.tweenSkillCameara(unit, targets, ishide, includeTgts)
	if not targets then
		return
	end

	local cnt = #targets

	if cnt == 0 then
		return
	end

	if not includeTgts then
		local scene = SceneMgr.instance:getCurScene()
		local units = scene.unitFactory:getAllUnit()

		for k, v in pairs(units) do
			local sameUnits = v

			for k2, v2 in pairs(sameUnits) do
				if not v2.isSourceMon and v2 ~= unit and (not ishide or not v2.attrs:isDead()) then
					local isTarget

					for i = 1, cnt do
						if v2 == targets[i].unit then
							isTarget = true

							break
						end
					end

					if isTarget then
						v2:onSkillCamera(ishide)
					end
				end
			end
		end
	end

	unit:onSkillCamera(ishide)
end

function BattleAnimEvevts.fadeSkillCameara(unit, targets, hide, includeTgts)
	if not targets then
		return
	end

	local cnt = #targets

	if cnt == 0 then
		return
	end

	local scene = SceneMgr.instance:getCurScene()
	local units = scene.unitFactory:getAllUnit()

	for k, v in pairs(units) do
		local sameUnits = v

		for k2, v2 in pairs(sameUnits) do
			if not v2.isSourceMon and v2 ~= unit and not v2.attrs:isDead() then
				local isTarget

				if not includeTgts then
					for i = 1, cnt do
						if v2 == targets[i].unit then
							isTarget = true

							break
						end
					end
				end

				if not isTarget then
					v2:onFadeSkillCameara(hide)
				end
			end
		end
	end
end

function BattleAnimEvevts.onFadeTargets(unit, targets, time, tgtType, fadeOut)
	if tgtType == 0 then
		if not targets then
			return
		end

		local cnt = #targets

		if cnt == 0 then
			return
		end

		for i = 1, cnt do
			if targets[i].unit ~= unit then
				targets[i].unit:onFadeSkillCameara(fadeOut)
			end
		end
	elseif tgtType == 1 then
		BattleAnimEvevts.fadeSkillCameara(unit, targets, fadeOut)
	else
		BattleAnimEvevts.fadeSkillCameara(unit, targets, fadeOut, true)
	end
end

function BattleAnimEvevts.onFadeTargetsColor(unit, targets, time, tgtType, hideObsUnits)
	BattleAnimEvevts.tryMaskSceneColor(hideObsUnits, time)

	targets = targets or {}

	local cnt = #targets
	local scene = SceneMgr.instance:getCurScene()
	local units = scene.unitFactory:getAllUnit()

	for k, v in pairs(units) do
		local sameUnits = v

		for k2, v2 in pairs(sameUnits) do
			if not v2.isSourceMon and v2 ~= unit and not v2.attrs:isDead() then
				local isTarget
				local objsTargets = v2.posRow > unit.posRow

				for i = 1, cnt do
					if v2 == targets[i].unit then
						isTarget = true

						break
					end
				end

				if not objsTargets then
					for i = 1, cnt do
						objsTargets = v2.posRow > targets[i].unit.posRow

						if objsTargets then
							break
						end
					end
				end

				if not isTarget then
					if objsTargets then
						v2:onFadeColorHide(hideObsUnits, time)
					else
						v2:onTweenColor(hideObsUnits, time)
					end
				end
			end
		end
	end
end

function BattleAnimEvevts.onStartFakeFmt(targets, cam, positions, scales, layer, flip)
	if not targets then
		return
	end

	local cnt = #targets

	if cnt == 0 then
		return
	end

	for i = 1, cnt do
		local unit = targets[i].unit
		local index = (unit.fmtIndex - 1) * 3

		targets[i].unit:onStartFakeFmt(cam, positions[index], positions[index + 1], positions[index + 2], scales[unit.fmtIndex - 1], layer, flip)
	end
end

function BattleAnimEvevts.onStopFakeFmt(targets)
	if not targets then
		return
	end

	local cnt = #targets

	if cnt == 0 then
		return
	end

	for i = 1, cnt do
		targets[i].unit:onStopFakeFmt()
	end
end

function BattleAnimEvevts.onSetTargetPos(targets, cam, x, y, z, scale, layer, flip)
	if not targets then
		return
	end

	local cnt = #targets

	if cnt == 0 then
		return
	end

	for i = 1, cnt do
		targets[i].unit:onStartFakeFmt(cam, x, y, z, scale, layer, flip)
	end
end

function BattleAnimEvevts.onChangeLayer(go, layer)
	Framework.GameObjectUtil.SetLayerRecursively(go, layer)
end

function BattleAnimEvevts.onChangeSortingLayer(unit, go, layer, skillTargets)
	local adjustUnit

	if go == unit.go then
		adjustUnit = unit
	elseif targets then
		for i = 1, #targets do
			if targets[i].unit.go == go then
				adjustUnit = targets[i].unit

				break
			end
		end
	end

	if adjustUnit then
		local order = BattleEffectOrderCtrl.getOrderByPosIndex(unit.posRow)

		if order then
			layer = order + layer
		end

		adjustUnit:setSortingOrder(layer)
	else
		GoUtil.SetSortingOrder(go, layer)
	end
end

function BattleAnimEvevts.onWaitingBulletHit(go, pauseSpine)
	return
end

function BattleAnimEvevts.onHagPointFollowBone(unit, go, follow)
	unit:onHagPointFollowBone(follow)
end

function BattleAnimEvevts.onFmodAudioPlay(evtStr, accable, isCV, callbackHandler, callbackTarget)
	local evtIns = FmodEvtInstance.New()

	evtIns.accable = accable
	evtIns.isCV = isCV

	if not isCV then
		AudioPlayerEx.instance:playEffectByEvtName(evtStr, UnityEngine.Time.timeScale, function(eventInstance)
			evtIns.eventInstance = eventInstance

			if callbackHandler then
				if callbackTarget then
					callbackHandler(callbackTarget, evtIns)
				else
					callbackHandler(evtIns)
				end
			end
		end)
	elseif BattleModel.instance.currRoundNum <= BattleModel.accFModEffRoundLimit then
		SoloAudioMgr.instance:playByEvtName(evtStr, function(eventInstance)
			if eventInstance then
				evtIns.eventInstance = eventInstance

				if callbackHandler then
					if callbackTarget then
						callbackHandler(callbackTarget, evtIns)
					else
						callbackHandler(evtIns)
					end
				end
			end
		end)
	end

	return evtIns
end

function BattleAnimEvevts.onForbidPauseSkill(forbid)
	BattleController.instance:forbidPause(forbid)
end

function BattleAnimEvevts.onLookTarget(targets, go, target)
	if not targets then
		return
	end

	local cnt = #targets

	if cnt == 0 then
		return
	end

	for i = 1, cnt do
		if targets[i].unit.posRow ~= -1 and targets[i].unit.go == target then
			local order = targets[i].unit:getSortingOrder()

			if order then
				GoUtil.SetSortingOrderGreatZero(go, order)
			end

			return
		end
	end
end

function BattleAnimEvevts.onStartCombine(unit)
	local oneCircleCombineResult = unit.oneCircleCombineResult

	if not oneCircleCombineResult then
		return
	end

	local characterView = oneCircleCombineResult.characterView

	BattleModel.instance:updateCharactor(unit.teamId, unit.id, characterView)

	unit.oneCircleCombineResult = nil

	local scene = SceneMgr.instance:getCurScene()

	unit.buffList:removeAll(true)
	scene.unitFactory:updateCharacter(unit.teamId, BattleModel.instance:getBattleId(), characterView)
	unit.attrs:setCombineUnit(true)
	unit.unitUI:updateUIInfo()

	local sourcePetIds = oneCircleCombineResult.sourcePetIds

	for i = 1, #sourcePetIds do
		local sourceUnit = scene.unitFactory:getUnit(unit.teamId, sourcePetIds[i])

		if sourceUnit ~= unit then
			sourceUnit.attrs:setCombinedSource(true)
			sourceUnit:setVisible(false)
			sourceUnit:resetBirthPos()
		end
	end

	UnitCompBattleFlowCommon.handleCharactorResults(oneCircleCombineResult.targetCharacterResults)
	UnitCompBattleFlowCommon.handlePlayerResults(oneCircleCombineResult.targetPlayerResults)
end

function BattleAnimEvevts.onStartDisintegrate(unit)
	local oneCircleDisintegrateResult = unit.oneCircleDisintegrateResult

	if not oneCircleDisintegrateResult then
		return
	end

	unit.oneCircleDisintegrateResult = nil

	unit.attrs:setCombineUnit(false)

	local teamId = unit.teamId
	local scene = SceneMgr.instance:getCurScene()
	local battleId = BattleModel.instance:getBattleId()
	local characterViews = oneCircleDisintegrateResult.characterViews

	for i = 1, #characterViews do
		local disUnit = scene.unitFactory:getUnit(teamId, characterViews[i].id)

		BattleModel.instance:updateCharactor(teamId, characterViews[i].id, characterViews[i])
		disUnit.buffList:removeAll(true)
		scene.unitFactory:updateCharacter(teamId, battleId, characterViews[i])

		if unit ~= disUnit then
			disUnit.attrs:setCombinedSource(false)
			disUnit:setVisible(true)
		end
	end

	unit.unitUI:updateUIInfo()
	UnitCompBattleFlowCommon.handleCharactorResults(oneCircleDisintegrateResult.targetCharacterResults)
	UnitCompBattleFlowCommon.handlePlayerResults(oneCircleDisintegrateResult.targetPlayerResults)
end

return BattleAnimEvevts
