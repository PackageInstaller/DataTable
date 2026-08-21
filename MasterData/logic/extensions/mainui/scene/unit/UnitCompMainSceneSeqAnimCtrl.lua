-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/unit/UnitCompMainSceneSeqAnimCtrl.lua

module("logic.extensions.mainui.scene.unit.UnitCompMainSceneSeqAnimCtrl", package.seeall)

local M = class("UnitCompMainSceneSeqAnimCtrl", UnitComponentBase)

M.StateType = {
	LoopFallBack = "idle",
	End = "end",
	Loop = "loop",
	Start = "start",
	Change = "change"
}

function M:ctor(unit)
	M.super.ctor(self, unit)
end

function M:onInit()
	self:onReset()
	self:setEvent(true)
end

function M:onDestroy()
	self:onReset()
	self:setEvent(false)

	self._prefixMap = nil
end

function M:onReset()
	self:setEvent(false)
end

function M:onReuse()
	self:setEvent(true)
end

function M:isDestroyed()
	if self._unit then
		return self._unit:isDestroyed()
	end

	return true
end

function M:getStatusLog()
	return ""
end

function M:setEvent(add)
	if add then
		self._unit:addInnerEventListener(UnitActionType.MeshModelLoaded, self._handleOnMeshModelLoaded, self)
		self._unit:addInnerEventListener(UnitActionType.AnimationEvent, self._handleAnimationEvent, self)
		self._unit:addInnerEventListener(UnitActionType.MainSceneHeroAniPlay, self._handleHeroAniPlay, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_HERO_SEQ_ANIM_PLAY, self._handleSeqAnimPlay, self)
	else
		self._unit:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._handleOnMeshModelLoaded, self)
		self._unit:removeInnerEventListener(UnitActionType.AnimationEvent, self._handleAnimationEvent, self)
		self._unit:removeInnerEventListener(UnitActionType.MainSceneHeroAniPlay, self._handleHeroAniPlay, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_HERO_SEQ_ANIM_PLAY, self._handleSeqAnimPlay, self)
	end
end

function M:_handleOnMeshModelLoaded()
	self._curPlayingPrefix = nil
	self._prefixMap = {}

	local animationPlayer = self._unit.meshModel:getAnimationPlayer()
	local allAniNames = {}

	animationPlayer:GetAnimationNamesLua(allAniNames)

	for _, _name in ipairs(allAniNames) do
		local prefix = MainScenePerformUtil.getAnimPrefix(_name)

		if not string.nilorempty(prefix) then
			if not self._prefixMap[prefix] then
				self._prefixMap[prefix] = {}
			end

			self._prefixMap[prefix][_name] = _name
		end
	end

	if Astral.OSDef.isEditor then
		TableUtil.dump(self._prefixMap)
	end
end

function M:_handleAnimationEvent(eventUid, unitActionType, eventName, animationName)
	if eventName == AnimationEventName.Complete then
		-- block empty
	end
end

function M:_handleHeroAniPlay(eventUid, unitActionType, animState)
	self._curPlayingPrefix = MainScenePerformUtil.getAnimPrefix(animState, true)

	if string.nilorempty(self._curPlayingPrefix) then
		printError(string.format("角色[%s][%s]动画[%s]命名不包含前缀", self._unit:getPointId(), self._unit:getHeroId(), animState))
	end
end

function M:_handleSeqAnimPlay(e, info)
	if info.heroId ~= self._unit:getHeroId() then
		return
	end

	self:seqAnimPlay(info.prefix, info.mixDuration)
end

function M:seqAnimPlay(prefix, mixDuration)
	local orgPrefix = self:getCurPrefix()

	self._curPlayingPrefix = prefix

	if self:isDestroyed() then
		return
	end

	if not self._unit.animClip:getIsLoadedFinish() then
		return
	end

	if orgPrefix then
		if orgPrefix == prefix then
			if self._unit.meshModel:getCurAnimState() == MainPerformEnum.AnimFullName.ChangeShow and self:canCancelChangeShow(prefix) then
				self:playAnimState(self:getAnimState(prefix, M.StateType.Loop, M.StateType.LoopFallBack), 0, true)
			end

			self:refreshAnimStep(prefix)
		else
			local playState

			playState = self:getAnimState(orgPrefix, prefix)

			if not playState then
				playState = self:getAnimState(orgPrefix, M.StateType.End)
				playState = playState or self:getAnimState(prefix, M.StateType.Start, M.StateType.Loop, M.StateType.LoopFallBack)
			end

			self:playAnimState(playState, mixDuration)
			self:refreshAnimStep(prefix)
		end
	else
		local playState = self:getAnimState(prefix, M.StateType.Loop, M.StateType.LoopFallBack)

		self:playAnimState(playState, 0)
		self:refreshAnimStep(prefix)
	end
end

function M:refreshCurPrefix(forcePrefix)
	local curPrefix = self:getCurPrefix()

	if not string.nilorempty(forcePrefix) then
		curPrefix = forcePrefix
	end

	if not string.nilorempty(curPrefix) then
		local playState = self:getAnimState(curPrefix, M.StateType.Loop, M.StateType.LoopFallBack)

		self:playAnimState(playState, 0)
		self:refreshAnimStep(curPrefix)

		return playState
	end

	return false
end

function M:hardSetPlay(prefix, stateType, mixDuration, isForceRestart)
	local success = false
	local playState = self:getAnimState(prefix, stateType)

	if playState then
		self:playAnimState(playState, mixDuration, isForceRestart)
		self:refreshAnimStep(prefix)

		self._curPlayingPrefix = prefix
		success = true
	end

	return success
end

function M:canCancelChangeShow(prefix)
	local canCancel = true

	if prefix == MainPerformEnum.AnimPrefix.XiangQing then
		return false
	end

	return canCancel
end

function M:getCurPrefix()
	return self._curPlayingPrefix
end

function M:isMatchRegStrInPrefixMap(prefix, matchRegStr)
	local isMatch = false

	if string.nilorempty(matchRegStr) then
		return isMatch
	end

	if self._prefixMap and self._prefixMap[prefix] then
		for animState, _ in pairs(self._prefixMap[prefix]) do
			if not isMatch and string.match(animState, matchRegStr) then
				isMatch = true
			end
		end
	else
		printWarn(string.format("[%s][%s]无法在prefixMap中找到prefix[%s]", self._unit:getPointId(), self._unit:getHeroId(), prefix))
	end

	return isMatch
end

function M:getAnimState(prefix, stateType, stateTypeFallBack, stateTypeFallBack2)
	local animState

	if not self._prefixMap or not self._prefixMap[prefix] then
		local logStr = string.format("[%s][%s] 没有前缀[%s]的动作", self._unit:getPointId(), self._unit:getHeroId(), prefix)

		if Astral.OSDef.isEditor then
			ToolTipsMgr.showCharacterTopToast(logStr, nil, 2)
			TableUtil.dump(self._prefixMap)
		else
			printError(logStr)
		end

		if prefix == MainPerformEnum.AnimPrefix.XiangQing then
			prefix = MainPerformEnum.AnimPrefix.Shafa
		else
			return
		end
	end

	local map = self._prefixMap[prefix]
	local tmpName = string.format("%s_%s", prefix, stateType)

	animState = map[tmpName]

	if not animState and map[MainPerformEnum.AnimFullNameFallBack[tmpName]] then
		animState = map[MainPerformEnum.AnimFullNameFallBack[tmpName]]
	end

	if not animState and stateTypeFallBack then
		tmpName = string.format("%s_%s", prefix, stateTypeFallBack)
		animState = map[tmpName]

		if not animState and map[MainPerformEnum.AnimFullNameFallBack[tmpName]] then
			animState = map[MainPerformEnum.AnimFullNameFallBack[tmpName]]
		end

		if not animState and stateTypeFallBack2 then
			tmpName = string.format("%s_%s", prefix, stateTypeFallBack2)
			animState = map[tmpName]

			if not animState and map[MainPerformEnum.AnimFullNameFallBack[tmpName]] then
				animState = map[MainPerformEnum.AnimFullNameFallBack[tmpName]]
			end
		end
	end

	return animState
end

function M:playAnimState(animState, mixDuration, isForceRestart)
	local animationPlayer = self._unit.meshModel:getAnimationPlayer()

	if not animationPlayer or goutil.isNil(animationPlayer) then
		return
	end

	if string.nilorempty(animState) then
		return
	end

	if not animationPlayer:ContainsAnimation(animState) then
		printError(string.format("角色[%s]不包含动作[%s]", self._unit:getHeroId(), animState))

		return
	end

	if isForceRestart == nil then
		isForceRestart = true
	end

	self._unit.meshModel:playFullNameAni(animState, mixDuration, isForceRestart)
end

function M:refreshAnimStep(prefix)
	local animStepStr = self:getAnimState(prefix, M.StateType.Loop, M.StateType.LoopFallBack)

	self._unit.animCtrl:setAnimStepStr(animStepStr)
end

return M
