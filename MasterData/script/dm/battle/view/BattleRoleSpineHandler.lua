-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/BattleRoleSpineHandler.lua

BattleRoleSpineHandler = class("BattleRoleSpineHandler")

BattleRoleSpineHandler:has("_viewContext", {
	is = "rw"
})

function BattleRoleSpineHandler:initialize()
	super.initialize(self)
end

function BattleRoleSpineHandler:_collectTargets(unit, roleFlag)
	local targets = {}
	local performAct = unit:getDataModel():getPerformAct()

	if performAct == nil then
		return targets
	end

	local unitManager = self._viewContext:getValue("BattleUnitManager")
	local skillAction = self._viewContext:getSkillAction(performAct)
	local skillTrgts = skillAction:getTargets()

	for roleId, flags in pairs(skillTrgts) do
		local role = unitManager:getUnitById(roleId)

		if role then
			if roleFlag then
				if table.indexof(flags, roleFlag) then
					targets[roleId] = role
				end
			else
				targets[roleId] = role
			end
		end
	end

	if roleFlag == nil then
		for roleId, flags in pairs(skillTrgts) do
			local role = unitManager:getUnitById(roleId)

			if role then
				targets[roleId] = role
			end
		end

		return targets
	end

	if type(roleFlag) == "string" then
		for roleId, flags in pairs(skillTrgts) do
			local role = unitManager:getUnitById(roleId)

			if role and table.indexof(flags, roleFlag) then
				targets[roleId] = role
			end
		end

		return targets
	end

	if type(roleFlag) == "table" then
		for _, flag in ipairs(roleFlag) do
			for roleId, flags in pairs(skillTrgts) do
				local role = unitManager:getUnitById(roleId)

				if role and table.indexof(flags, flag) then
					targets[roleId] = role
				end
			end
		end

		return targets
	end

	return targets
end

function BattleRoleSpineHandler:_judgeFinalHit(unit)
	local context = self._viewContext
	local finalHit = context:getValue("FinalHit")

	if finalHit == true then
		local battleGround = context:getValue("BattleGroundLayer")
		local final = true
		local skillActions = context:getSkillActions()

		for act, skillAction in pairs(skillActions) do
			local targets = skillAction:getTargets()

			if table.nums(targets) > 0 then
				final = false

				break
			end
		end

		if final then
			local uiLayer = context:getValue("BattleUIMediator")
			local mainMediator = context:getValue("BattleMainMediator")

			uiLayer:setTouchEnabled(false)
			battleGround:slowDown({
				{
					value = 0.1,
					duration = 0.5
				},
				{
					value = 0.2,
					duration = 1
				},
				{
					value = 0.5,
					duration = 1
				}
			})
		end
	end
end

function BattleRoleSpineHandler:spineHandler_Hit(event, params, unit)
	local act = params.act
	local final = params.final
	local force = params.v
	local hurtTag = params.trgt
	local performAct = unit:getDataModel():getPerformAct()
	local targets = self:_collectTargets(unit, hurtTag)

	for id, role in pairs(targets) do
		if not role:isBusyState() then
			local block = role:isBlockByActId(performAct)

			if block then
				act = final == 1 and not role:isLive() and "down" or nil
				force = nil
			end

			if act and act ~= "" and role:switchState(act) then
				role:playSpecialSound(act, performAct)
			end

			role:addActivateNums(performAct)

			if final == 1 then
				role:subActivateNums(performAct)

				local skillAction = self._viewContext:getSkillAction(performAct)
				local flags = hurtTag and {
					hurtTag
				} or skillAction:getTargets()[id]

				if flags then
					for _, flag in ipairs(flags) do
						skillAction:delFlagForRole(id, flag)
					end
				end

				self:_judgeFinalHit()
			end

			if force then
				role:thrown(force)
			end
		end
	end
end

function BattleRoleSpineHandler:spineHandler_Shake(event, params, unit)
	local frameCount = params.dur
	local hurtTag = params.trgt
	local performAct = unit:getDataModel():getPerformAct()
	local targets = self:_collectTargets(unit, hurtTag)

	for id, role in pairs(targets) do
		local block = role:isBlockByActId(performAct)

		if not role:isBusyState() and not block then
			role:shake(frameCount)
		end
	end
end

function BattleRoleSpineHandler:spineHandler_RockScreen(event, params, unit)
	local key, force = params.type, params.force
	local battleGround = self:getViewContext():getValue("BattleGroundLayer")

	battleGround:rock(key, force)
end

function BattleRoleSpineHandler:spineHandler_Sound(event, params, unit)
	local file = params.file
	local rate = params.rate

	unit:playSound(file, rate)
end

function BattleRoleSpineHandler:spineHandler_Voice(event, params, unit)
	local file = params.file
	local rate = params.rate

	unit:playVoice(file, rate)
end

function BattleRoleSpineHandler:spineHandler_Offset(event, params, unit)
	local offset = params.val
	local hurtTag = params.trgt
	local performAct = unit:getDataModel():getPerformAct()
	local targets = self:_collectTargets(unit, hurtTag)

	for id, role in pairs(targets) do
		local block = role:isBlockByActId(performAct)

		if not role:isBusyState() and not block then
			role:offsetPosition(offset.x or 0, offset.y or 0)
		end
	end
end

function BattleRoleSpineHandler:spineHandler_Freeze(event, params, unit)
	local act = params.act
	local frame = params.frame
	local hurtTag = params.trgt
	local performAct = unit:getDataModel():getPerformAct()
	local targets = self:_collectTargets(unit, hurtTag)

	for id, role in pairs(targets) do
		local block = role:isBlockByActId(performAct)

		if not role:isBusyState() and not block then
			role:freezeFrame(act, frame)
		end
	end
end

function BattleRoleSpineHandler:spineHandler_AnimForTrgt(event, params, unit)
	local pos = params.pos
	local layer = params.layer
	local loop = params.loop
	local mcFile = params.anim
	local point = cc.p(pos[1], pos[2])
	local hurtTag = params.trgt
	local targets = self:_collectTargets(unit, hurtTag)

	for id, role in pairs(targets) do
		role:addSolidEffect(mcFile, loop, point, layer, 2)
	end
end

function BattleRoleSpineHandler:spineHandler_Move(event, params, unit)
	local speed = params.v
	local acceleration = params.a
	local time = params.t / 1000

	unit:shiftPosition(speed, acceleration, time)
end

function BattleRoleSpineHandler:spineHandler_TargetMove(event, params, unit)
	local speed = params.v
	local acceleration = params.a
	local time = params.t / 1000
	local hurtTag = params.trgt
	local performAct = unit:getDataModel():getPerformAct()
	local targets = self:_collectTargets(unit, hurtTag)

	for id, role in pairs(targets) do
		local block = role:isBlockByActId(performAct)

		if not role:isBusyState() and not block then
			role:shiftPosition(speed, acceleration, time)
		end
	end
end

function BattleRoleSpineHandler:spineHandler_Shadow(event, params, unit)
	local shadowVisible = params.isShow
	local hurtTag = params.trgt
	local targets = self:_collectTargets(unit, hurtTag)

	for id, role in pairs(targets) do
		role:shadowVisible(shadowVisible)
	end
end

function BattleRoleSpineHandler:spineHandler_FlashScr(event, params, unit)
	local battleGround = self:getViewContext():getValue("BattleGroundLayer")

	battleGround:flashScreen(params.arr, 20)
end

function BattleRoleSpineHandler:spineHandler_SpdLine(event, params, unit)
	local frame = params.dur
	local duration = frame * 0.03333333333333333
	local opLayer = self:getViewContext():getValue("BattleOpLayer")

	opLayer:startSpeedLine(unit:isLeft(), duration)
end

function BattleRoleSpineHandler:spineHandler_TrgtFilm(event, params, unit)
	local hurtTag = params.trgt
	local targets = self:_collectTargets(unit, hurtTag)

	for id, role in pairs(targets) do
		role:onFilmEvent()
	end
end

function BattleRoleSpineHandler:spineHandler_TrgtUnFilm(event, params, unit)
	local hurtTag = params.trgt
	local targets = self:_collectTargets(unit, hurtTag)

	for id, role in pairs(targets) do
		role:onUnFilmEvent()
	end
end

function BattleRoleSpineHandler:spineHandler_Video(event, params, unit)
	local videoId = params.id
	local act = params.act
	local performAct = unit:getDataModel():getPerformAct()

	if act == "prepare" then
		unit:prepareSkillEffect(videoId, performAct, event.animation)
	else
		unit:startSkillEffect(videoId, performAct, event.animation)
	end
end

function BattleRoleSpineHandler:spineHandler_SkillMovie(event, params, unit)
	local movieId = params.id
	local act = params.act
	local performAct = unit:getDataModel():getPerformAct()

	if act == "start" and performAct then
		unit:startSkillMovie(movieId, performAct)
	end
end
