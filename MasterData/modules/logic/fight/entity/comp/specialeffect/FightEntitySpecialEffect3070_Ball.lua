-- chunkname: @modules/logic/fight/entity/comp/specialeffect/FightEntitySpecialEffect3070_Ball.lua

module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffect3070_Ball", package.seeall)

local FightEntitySpecialEffect3070_Ball = class("FightEntitySpecialEffect3070_Ball", FightBaseClass)

function FightEntitySpecialEffect3070_Ball:onConstructor(entity)
	self._entity = entity

	self:com_registFightEvent(FightEvent.SetBuffEffectVisible, self._onSetBuffEffectVisible)
	self:com_registFightEvent(FightEvent.OnBuffUpdate, self._onBuffUpdate)
	self:com_registFightEvent(FightEvent.OnSkillPlayStart, self._onSkillPlayStart)
	self:com_registFightEvent(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish)
	self:com_registFightEvent(FightEvent.BeforeEnterStepBehaviour, self._onBeforeEnterStepBehaviour)
	self:com_registFightEvent(FightEvent.BeforeDeadEffect, self._onBeforeDeadEffect)
	self:initVar()
end

function FightEntitySpecialEffect3070_Ball:initVar()
	self._ballEffectList = {}
	self._ballEffectUid = {}
	self._buffUid2Effect = self:getUserDataTb_()
	self._ballDestroyPath = {}
	self._ballLine = {}
	self._uid2BallTween = {}
end

FightEntitySpecialEffect3070_Ball.BallPositionLimit3 = {
	{
		0.54,
		0.39,
		0
	},
	{
		-0.75,
		1.64,
		0
	},
	{
		0.7,
		2.45,
		0
	}
}
FightEntitySpecialEffect3070_Ball.BallPositionLimit4 = {
	{
		0.54,
		0.39,
		0
	},
	{
		-0.75,
		1.64,
		0
	},
	{
		1.05,
		1.53,
		0
	},
	{
		0.7,
		2.45,
		0
	}
}

local defaultEffect = "default"
local _ballEffectPath = {
	{
		[defaultEffect] = {
			"v1a3_jialabona/jianabona_bd_r_01",
			"v1a3_jialabona/jianabona_bd_01",
			"v1a3_jialabona/jianabona_bd_r_02"
		},
		[307003] = {
			"v2a0_jialabona/jialabona_bd_r_01",
			"v2a0_jialabona/jialabona_bd_01",
			"v2a0_jialabona/jialabona_bd_r_02"
		}
	},
	{
		[defaultEffect] = {
			"v1a3_jialabona/jianabona_bd_h_01",
			"v1a3_jialabona/jianabona_bd_01",
			"v1a3_jialabona/jianabona_bd_h_02"
		},
		[307003] = {
			"v2a0_jialabona/jialabona_bd_h_01",
			"v2a0_jialabona/jialabona_bd_01",
			"v2a0_jialabona/jialabona_bd_h_02"
		}
	},
	{
		[defaultEffect] = {
			"v1a3_jialabona/jianabona_bd_b_01",
			"v1a3_jialabona/jianabona_bd_01",
			"v1a3_jialabona/jianabona_bd_b_02"
		},
		[307003] = {
			"v2a0_jialabona/jialabona_bd_b_01",
			"v2a0_jialabona/jialabona_bd_01",
			"v2a0_jialabona/jialabona_bd_b_02"
		}
	}
}
local _ballSpeed = 4.5
local _waitDestroyEffectDelay = 0.25
local _beforeCreateBallDelay = 0
local _beforeBallMoveDelay = 0.1
local _beforeShowLineDelay = 0
local _effectScale = 0.8

FightEntitySpecialEffect3070_Ball.buffTypeId2EffectPath = {
	[307001211] = _ballEffectPath[1],
	[307001212] = _ballEffectPath[1],
	[307001111] = _ballEffectPath[2],
	[307001112] = _ballEffectPath[2],
	[307001311] = _ballEffectPath[3],
	[307001312] = _ballEffectPath[3]
}

local _lineLenght = Vector3.Distance(Vector3.New(-1.2, 1, 0), Vector3.zero) * 1.1
local _temporaryEffectDuration = 1

function FightEntitySpecialEffect3070_Ball:_getPosArr()
	return self._ballPosition
end

function FightEntitySpecialEffect3070_Ball:_initPosArr(buffId)
	if not self._ballPosition then
		local buffConfig = lua_skill_buff.configDict[buffId]
		local buffTypeConfig = lua_skill_bufftype.configDict[buffConfig.typeId]
		local limitNum = string.split(buffTypeConfig.includeTypes, "#")[2]

		self._ballPosition = LuaUtil.deepCopy(FightEntitySpecialEffect3070_Ball["BallPositionLimit" .. limitNum])

		if self._entity:isEnemySide() then
			for i, v in ipairs(self._ballPosition) do
				self._ballPosition[i][1] = -self._ballPosition[i][1]
			end
		end

		return self._ballPosition
	end
end

function FightEntitySpecialEffect3070_Ball:_getFirstPos()
	if self._firstPos then
		return self._firstPos
	end

	self._firstPos = Vector3.New(self:_getPosArr()[1][1], self:_getPosArr()[1][2], self:_getPosArr()[1][3])

	return self._firstPos
end

function FightEntitySpecialEffect3070_Ball:_ballShowEffect()
	if self._showEffectWrap then
		self._showEffectWrap:setActive(false)
		self._showEffectWrap:setActive(true)
	else
		self._showEffectWrap = self._entity.effect:addGlobalEffect(self._curEffectPath[2])

		FightRenderOrderMgr.instance:onAddEffectWrap(self._entity.id, self._showEffectWrap)
		self._showEffectWrap:setEffectScale(_effectScale)
	end

	local x, y, z = FightHelper.getEntityStandPos(self._entity:getMO())

	self._showEffectWrap:setLocalPos(x + self:_getPosArr()[1][1], y + self:_getPosArr()[1][2], z + self:_getPosArr()[1][3])
end

function FightEntitySpecialEffect3070_Ball:_ballDestroyEffect(effectPath, buffUid)
	local destroyEffectWrap = self._entity.effect:addGlobalEffect(effectPath, nil, _temporaryEffectDuration)
	local tarEffect = self._buffUid2Effect[buffUid]
	local tarPosX, tarPosY, tarPosZ = transformhelper.getPos(tarEffect.containerTr)

	destroyEffectWrap:setWorldPos(tarPosX, tarPosY, tarPosZ)
	destroyEffectWrap:setEffectScale(_effectScale)
	FightRenderOrderMgr.instance:onAddEffectWrap(self._entity.id, destroyEffectWrap)
end

function FightEntitySpecialEffect3070_Ball:_hideBallLineEffect()
	for i, v in ipairs(self._ballLine) do
		local lineEffect = self._ballLine[i]

		lineEffect:setActive(false, "FightEntitySpecialEffect3070_Ball_ball")
	end
end

function FightEntitySpecialEffect3070_Ball:_createNewBallLine()
	local entityMO = self._entity:getMO()

	for i, effectWrap in ipairs(self._ballEffectList) do
		local lineEffect = self._ballLine[i]

		if not lineEffect then
			local curBallPos = self:_getPosArr()[i]
			local nextBallPos = self:_getPosArr()[i + 1]
			local lineEffectPath = entityMO and lua_fight_jia_la_bo_na_line.configDict[entityMO.skin].lineEffect

			lineEffect = self._entity.effect:addHangEffect(lineEffectPath, ModuleEnum.SpineHangPointRoot, nil, nil, self:_getFirstPos())
			self._ballLine[i] = lineEffect

			if i == 1 then
				FightRenderOrderMgr.instance:onAddEffectWrap(self._entity.id, lineEffect)
			else
				lineEffect:setRenderOrder(FightRenderOrderMgr.MinSpecialOrder * FightEnum.OrderRegion + 9)
			end

			if nextBallPos then
				local _distance = Vector3.Distance(Vector3.New(curBallPos[1], curBallPos[2], curBallPos[3]), Vector3.New(nextBallPos[1], nextBallPos[2], nextBallPos[3]))

				transformhelper.setLocalScale(lineEffect.containerTr, _distance / _lineLenght, 1, 1)
			end
		end
	end
end

function FightEntitySpecialEffect3070_Ball:_showBallLineEffect()
	for i, effectWrap in ipairs(self._ballEffectList) do
		local curBallPos = self:_getPosArr()[i]
		local nextBallPos = self:_getPosArr()[i + 1]
		local lineEffect = self._ballLine[i]
		local nextEffectWrap = self._ballEffectList[i + 1]

		if nextEffectWrap then
			lineEffect:setActive(true, "FightEntitySpecialEffect3070_Ball_ball")

			local offsetX = nextBallPos[1] - curBallPos[1]
			local offsetY = nextBallPos[2] - curBallPos[2]
			local offsetZ = nextBallPos[3] - curBallPos[3]

			lineEffect:setLocalPos(curBallPos[1] + offsetX / 2, curBallPos[2] + offsetY / 2, curBallPos[3] + offsetZ / 2)

			local offset_pos = Vector3.New(offsetX, offsetY, 0)
			local rotation = Quaternion.FromToRotation(Vector3.left, offset_pos).eulerAngles.z

			transformhelper.setLocalRotation(lineEffect.containerTr, 0, 0, rotation)
		else
			lineEffect:setActive(false, "FightEntitySpecialEffect3070_Ball_ball")
		end
	end
end

function FightEntitySpecialEffect3070_Ball:_createNewball()
	local effectWrap = self._entity.effect:addHangEffect(self._curEffectPath[1], ModuleEnum.SpineHangPointRoot, nil, nil, self:_getFirstPos())
	local tarPos = self:_getFirstPos()

	effectWrap:setLocalPos(tarPos.x, tarPos.y, tarPos.z)
	FightRenderOrderMgr.instance:onAddEffectWrap(self._entity.id, effectWrap)
	table.insert(self._ballEffectList, 1, effectWrap)
	table.insert(self._ballEffectUid, 1, self._curBuffUid)

	self._buffUid2Effect[self._curBuffUid] = effectWrap
	self._ballDestroyPath[effectWrap.uniqueId] = self._curEffectPath[3]

	effectWrap:setEffectScale(_effectScale)

	local entityMO = self._entity:getMO()
	local audio = entityMO and lua_fight_jia_la_bo_na_ball_audio.configDict[entityMO.skin].createBallAudio

	FightAudioMgr.instance:playAudio(audio)

	return effectWrap
end

function FightEntitySpecialEffect3070_Ball:_showNewball()
	for i, v in ipairs(self._ballEffectList) do
		v:setActive(true, "FightEntitySpecialEffect3070_Ball_NewBall")
	end
end

function FightEntitySpecialEffect3070_Ball:_onBuffUpdate(targetId, effectType, buffId, buffUid)
	if targetId ~= self._entity.id then
		return
	end

	local buffConfig = lua_skill_buff.configDict[buffId]
	local entityMO = self._entity:getMO()

	if not entityMO then
		return
	end

	local ballConfig = lua_fight_jia_la_bo_na_ball.configDict[entityMO.skin]

	if not ballConfig then
		return
	end

	ballConfig = ballConfig[buffConfig.typeId]

	if not ballConfig then
		return
	end

	if effectType == FightEnum.EffectType.BUFFADD then
		self._curBuffUid = buffUid
		self._curEffectPath = {
			ballConfig.ballEffect,
			ballConfig.createBallEffect,
			ballConfig.destroyBallEffect
		}

		self:_initPosArr(buffId)
		self:_releaseBallTween()

		self._newBall = self:_createNewball()

		self._newBall:setActive(false, "FightEntitySpecialEffect3070_Ball_NewBall")
		self:_createNewBallLine()

		self._aniFlow = FlowSequence.New()

		self._aniFlow:addWork(FunctionWork.New(self._hideBallLineEffect, self))

		if self._resetPlayingDestroyEffect then
			self._aniFlow:addWork(WorkWaitSeconds.New(_waitDestroyEffectDelay / FightModel.instance:getSpeed()))
		end

		self._resetPlayingDestroyEffect = nil

		self._aniFlow:addWork(WorkWaitSeconds.New(_beforeCreateBallDelay / FightModel.instance:getSpeed()))
		self._aniFlow:addWork(FunctionWork.New(self._ballShowEffect, self))
		self._aniFlow:addWork(FunctionWork.New(self._showNewball, self))
		self._aniFlow:addWork(WorkWaitSeconds.New(_beforeBallMoveDelay / FightModel.instance:getSpeed()))

		local ballMoveFlow = FlowParallel.New()

		for i = 1, #self._ballEffectList do
			local effectWrap = self._ballEffectList[i]

			if effectWrap and i > 1 then
				local pos = self:_getPosArr()[i]
				local transform = effectWrap.containerTr
				local startX, startY = transformhelper.getLocalPos(transform)
				local dis = Mathf.Sqrt(Mathf.Pow(startX - pos[1], 2) + Mathf.Pow(startY - pos[2], 2))
				local flyTime = dis / _ballSpeed / FightModel.instance:getSpeed()
				local buffUid = self._ballEffectUid[i]

				self._uid2BallTween[buffUid] = self._uid2BallTween[buffUid] or {}

				local data = self:getUserDataTb_()

				data.transform = transform
				data.flyTime = flyTime
				data.x = pos[1]
				data.y = pos[2]
				data.index = i
				data.effectWrap = effectWrap

				table.insert(self._uid2BallTween[buffUid], data)
			end
		end

		for k, list in pairs(self._uid2BallTween) do
			local sequence = FlowSequence.New()

			for index, data in ipairs(list) do
				local flow = FlowParallel.New()
				local tempTab = self:getUserDataTb_()

				table.insert(tempTab, data.effectWrap)
				table.insert(tempTab, data.index)
				flow:addWork(FunctionWork.New(self._refreshBallOrder, self, tempTab))
				flow:addWork(TweenWork.New({
					type = "DOLocalMoveX",
					tr = data.transform,
					to = data.x,
					t = data.flyTime,
					ease = EaseType.OutQuart
				}))
				flow:addWork(TweenWork.New({
					type = "DOLocalMoveY",
					tr = data.transform,
					to = data.y,
					t = data.flyTime,
					ease = EaseType.OutQuart
				}))
				sequence:addWork(flow)
			end

			ballMoveFlow:addWork(sequence)
		end

		self._aniFlow:addWork(ballMoveFlow)
		self._aniFlow:addWork(WorkWaitSeconds.New(_beforeShowLineDelay / FightModel.instance:getSpeed()))
		self._aniFlow:addWork(FunctionWork.New(self._showBallLineEffect, self))
		self._aniFlow:addWork(FunctionWork.New(self._clearBallTweenData, self))
		self._aniFlow:start()
	elseif effectType == FightEnum.EffectType.BUFFDEL then
		for i = #self._ballEffectUid, 1, -1 do
			if self._ballEffectUid[i] == buffUid then
				self._uid2BallTween[buffUid] = nil

				local effect = table.remove(self._ballEffectList, i)

				table.remove(self._ballEffectUid, i)
				self._entity.effect:removeEffect(effect)
				self:_ballDestroyEffect(self._ballDestroyPath[effect.uniqueId], buffUid)

				self._playingDestroyEffect = true

				self:com_registTimer(self._resetPlayingDestroyEffect, 0.3)

				local audio = entityMO and lua_fight_jia_la_bo_na_ball_audio.configDict[entityMO.skin].destroyBallAudio

				FightAudioMgr.instance:playAudio(audio)

				break
			end
		end
	end
end

function FightEntitySpecialEffect3070_Ball:_refreshBallOrder(data)
	local effectWrap = data[1]
	local index = data[2]

	FightRenderOrderMgr.instance:onRemoveEffectWrap(self._entity.id, effectWrap)

	if index <= 2 then
		FightRenderOrderMgr.instance:onAddEffectWrap(self._entity.id, effectWrap)
	else
		effectWrap:setRenderOrder(FightRenderOrderMgr.MinSpecialOrder * FightEnum.OrderRegion + 10)
	end
end

function FightEntitySpecialEffect3070_Ball:_clearBallTweenData()
	self._uid2BallTween = {}
end

function FightEntitySpecialEffect3070_Ball:_resetPlayingDestroyEffect()
	self._playingDestroyEffect = nil
end

function FightEntitySpecialEffect3070_Ball:_onBeforeEnterStepBehaviour()
	if FightDataHelper.stateMgr.dealingCrash then
		self:_releaseEffect()
		self:initVar()
	end

	local entityMO = self._entity:getMO()

	if entityMO then
		local buffDic = entityMO:getBuffDic()

		for i, v in pairs(buffDic) do
			self:_onBuffUpdate(self._entity.id, FightEnum.EffectType.BUFFADD, v.buffId, v.uid)
		end
	end
end

function FightEntitySpecialEffect3070_Ball:_onSetBuffEffectVisible(entityId, state, sign)
	if self._entity.id == entityId then
		if self._ballEffectList then
			for i, v in ipairs(self._ballEffectList) do
				v:setActive(state, sign or "FightEntitySpecialEffect3070_Ball")
			end
		end

		if self._ballLine then
			for i, v in ipairs(self._ballLine) do
				v:setActive(state, sign or "FightEntitySpecialEffect3070_Ball")
			end
		end
	end
end

function FightEntitySpecialEffect3070_Ball:_playMoveAudio()
	if tabletool.len(self._uid2BallTween) > 0 then
		local entityMO = self._entity:getMO()
		local audio = entityMO and lua_fight_jia_la_bo_na_ball_audio.configDict[entityMO.skin].moveBallAudio

		FightAudioMgr.instance:playAudio(audio)
	end
end

function FightEntitySpecialEffect3070_Ball:_onSkillPlayStart(entity)
	self:_onSetBuffEffectVisible(entity.id, false, "FightEntitySpecialEffect3070_Ball_PlaySkill")
end

function FightEntitySpecialEffect3070_Ball:_onSkillPlayFinish(entity)
	self:_onSetBuffEffectVisible(entity.id, true, "FightEntitySpecialEffect3070_Ball_PlaySkill")
end

function FightEntitySpecialEffect3070_Ball:_releaseBallTween()
	if self._aniFlow then
		self._aniFlow:stop()

		self._aniFlow = nil
	end
end

function FightEntitySpecialEffect3070_Ball:_releaseBallEffect()
	if self._ballEffectList then
		for k, v in pairs(self._ballEffectList) do
			self._entity.effect:removeEffect(v)
			FightRenderOrderMgr.instance:onRemoveEffectWrap(self._entity.id, v)
		end
	end

	self._ballEffectList = nil
	self._ballEffectUid = nil

	if self._showEffectWrap then
		self._entity.effect:removeEffect(self._showEffectWrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(self._entity.id, self._showEffectWrap)

		self._showEffectWrap = nil
	end
end

function FightEntitySpecialEffect3070_Ball:_releaseBallLineEffect()
	if self._ballLine then
		for k, v in pairs(self._ballLine) do
			self._entity.effect:removeEffect(v)
			FightRenderOrderMgr.instance:onRemoveEffectWrap(self._entity.id, v)
		end
	end

	self._ballLine = nil
end

function FightEntitySpecialEffect3070_Ball:_onBeforeDeadEffect(entityId)
	if entityId == self._entity.id then
		self:_releaseEffect()
	end
end

function FightEntitySpecialEffect3070_Ball:_releaseEffect()
	self:_releaseBallTween()
	self:_releaseBallEffect()
	self:_releaseBallLineEffect()
end

function FightEntitySpecialEffect3070_Ball:onDestructor()
	self:_releaseEffect()
end

return FightEntitySpecialEffect3070_Ball
