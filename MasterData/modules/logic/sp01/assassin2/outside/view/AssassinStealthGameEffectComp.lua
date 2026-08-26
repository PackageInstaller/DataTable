-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinStealthGameEffectComp.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameEffectComp", package.seeall)

local AssassinStealthGameEffectComp = class("AssassinStealthGameEffectComp", LuaCompBase)

function AssassinStealthGameEffectComp:init(go)
	self.go = go
	self.effectGoDic = self:getUserDataTb_()
	self.showingEffDict = {}

	self:_cancelCheckTask()
end

function AssassinStealthGameEffectComp:playEffect(effectId, finishCb, finishCbObj, finishCbParam, parentObj, pos, blockKey)
	if self.showingEffDict[effectId] then
		return
	end

	local effectName = effectId and effectId ~= 0 and AssassinConfig.instance:getAssassinEffectResName(effectId)

	if not effectName or string.nilorempty(effectName) then
		if finishCb then
			if finishCbObj then
				finishCb(finishCbObj, finishCbParam)
			else
				finishCb(finishCbParam)
			end
		end

		return
	end

	local effectGo = self.effectGoDic[effectName]

	if effectGo then
		if not gohelper.isNil(parentObj) then
			effectGo.transform:SetParent(parentObj.transform)
		end

		if pos then
			transformhelper.setLocalPos(effectGo.transform, pos.x or 0, pos.y or 0, 0)
		end

		gohelper.setActive(effectGo, true)
	else
		effectGo = gohelper.create2d(not gohelper.isNil(parentObj) and parentObj or self.go, effectName)

		if pos then
			transformhelper.setLocalPos(effectGo.transform, pos.x or 0, pos.y or 0, 0)
		end

		self.effectGoDic[effectName] = effectGo

		AssassinStealthGameEffectMgr.instance:getEffectRes(effectName, effectGo)
	end

	local effAudioId = AssassinConfig.instance:getAssassinEffectAudioId(effectId)

	if effAudioId and effAudioId ~= 0 then
		AudioMgr.instance:trigger(effAudioId)
	end

	local duration = AssassinConfig.instance:getAssassinEffectDuration(effectId)

	if duration and duration > 0 then
		if not string.nilorempty(blockKey) then
			AssassinHelper.lockScreen(blockKey, true)
		end

		self._effectCheckDict[effectName] = {
			effectId = effectId,
			startTime = Time.realtimeSinceStartup,
			duration = duration,
			finishCb = finishCb,
			finishCbObj = finishCbObj,
			finishCbParam = finishCbParam,
			blockKey = blockKey
		}
	end

	self.showingEffDict[effectId] = true

	if next(self._effectCheckDict) and not self._checkTaskRunning then
		self._checkTaskRunning = true

		TaskDispatcher.runRepeat(self._checkEffectFinish, self, 0.1)
	end
end

function AssassinStealthGameEffectComp:_checkEffectFinish()
	if not self._effectCheckDict or not next(self._effectCheckDict) then
		self:_cancelCheckTask()

		return
	end

	local removeList = {}
	local now = Time.realtimeSinceStartup

	for effectName, data in pairs(self._effectCheckDict) do
		local existTime = now - data.startTime

		if existTime >= data.duration then
			removeList[#removeList + 1] = effectName
		end
	end

	for _, effectName in ipairs(removeList) do
		local effectGo = self.effectGoDic[effectName]

		gohelper.setActive(effectGo, false)

		local data = self._effectCheckDict[effectName]
		local finishCb = data and data.finishCb

		if finishCb then
			local finishCbObj = data.finishCbObj
			local finishCbParam = data.finishCbParam

			if finishCbObj then
				finishCb(finishCbObj, finishCbParam)
			else
				finishCb(finishCbParam)
			end
		end

		if not string.nilorempty(data and data.blockKey) then
			AssassinHelper.lockScreen(data.blockKey, false)
		end

		self.showingEffDict[data.effectId] = nil
		self._effectCheckDict[effectName] = nil
	end
end

function AssassinStealthGameEffectComp:_cancelCheckTask()
	if self._effectCheckDict then
		for _, data in pairs(self._effectCheckDict) do
			if not string.nilorempty(data.blockKey) then
				AssassinHelper.lockScreen(data.blockKey, false)
			end
		end
	end

	self._effectCheckDict = {}

	TaskDispatcher.cancelTask(self._checkEffectFinish, self)

	self._checkTaskRunning = false
end

function AssassinStealthGameEffectComp:removeEffect(effectId)
	if not self.showingEffDict[effectId] then
		return
	end

	local duration = AssassinConfig.instance:getAssassinEffectDuration(effectId)

	if not duration or duration == 0 then
		local effectName = AssassinConfig.instance:getAssassinEffectResName(effectId)
		local effectGo = self.effectGoDic[effectName]

		gohelper.setActive(effectGo, false)

		self.showingEffDict[effectId] = nil
	end
end

function AssassinStealthGameEffectComp:onDestroy()
	self:_cancelCheckTask()
end

return AssassinStealthGameEffectComp
