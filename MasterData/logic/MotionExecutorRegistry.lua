-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/motion/MotionExecutorRegistry.lua

module("logic.extensions.spineinterface.motion.MotionExecutorRegistry", package.seeall)

local MotionExecutorRegistry = class("MotionExecutorRegistry")

function MotionExecutorRegistry:ctor(session)
	self._session = session
	self._executors = {}

	self:_registerDefaults()
end

function MotionExecutorRegistry:_registerDefaults()
	self:register(MsEnum.MotionType.PublicParam, self._executeParamMotion)
	self:register(MsEnum.MotionType.SpineParam, self._executeParamMotion)
	self:register(MsEnum.MotionType.SpineAnim, self._executeSpineAnim)
	self:register(MsEnum.MotionType.Event, self._executeEvent)
	self:register(MsEnum.MotionType.BehaviorChange, self._executeBehaviorChange)
	self:register(MsEnum.MotionType.Audio, self._executeAudio)
	self:register(MsEnum.MotionType.BoneFollow, self._executeBoneFollow)
end

function MotionExecutorRegistry:register(motionType, executor)
	if self._executors[motionType] ~= nil then
		printError(string.format("duplicate spineinterface motion executor, motionType = %s", motionType))
	end

	self._executors[motionType] = executor
end

function MotionExecutorRegistry:execute(motionInfo)
	local motionMo = motionInfo.motionMo
	local motionType = motionMo:getMotionType()
	local executor = self._executors[motionType]

	if executor == nil then
		printError(string.format("unsupported spineinterface motionType = %s", motionType))

		motionInfo.blockState = 3

		return
	end

	executor(self, motionInfo)

	local isBlock = motionMo:getMotionParam("isBlock", MsEnum.DataType.Bool)

	motionInfo.blockState = isBlock and 2 or 3
end

function MotionExecutorRegistry:_executeParamMotion(motionInfo)
	local comp = self._session:getOwner()
	local motionMo = motionInfo.motionMo
	local motionType = motionMo:getMotionType()
	local triggerType = motionInfo.triggerType
	local triggerParam = motionInfo.triggerParam
	local paramId

	if motionType == MsEnum.MotionType.PublicParam then
		paramId = motionMo:getMotionParam("publicParamId", MsEnum.DataType.Int)
	elseif motionType == MsEnum.MotionType.SpineParam then
		paramId = motionMo:getMotionParam("spineParamId", MsEnum.DataType.Int)
	end

	local modifyValue = motionMo:getMotionParam("modifyValue")
	local fixValue = motionMo:getMotionParam("fixValue")
	local nextValue = motionMo:getMotionParam("nextValue")
	local value

	if modifyValue ~= nil then
		local paramMo = comp._paramMoMgr:getParamMo(motionType, paramId)

		if paramMo:getDataType() == MsEnum.DataType.Bool then
			printError("modifyValue不允许为bool值")
		else
			local oldParamValue = paramMo:getValue()

			if triggerType == MsEnum.TriggerType_FreeDrag or triggerType == MsEnum.TriggerType_DirDrag then
				local dragVector = comp._pointerInfo:getEventData().delta

				if triggerType == MsEnum.TriggerType_FreeDrag then
					value = oldParamValue + comp._pointerInfo:getDragFreeValue(dragVector, modifyValue)
				elseif triggerParam then
					value = oldParamValue + comp._pointerInfo:getDragDirectionValue(dragVector, triggerParam.angle, modifyValue)
				end
			else
				value = oldParamValue + modifyValue
			end
		end
	elseif fixValue ~= nil then
		value = fixValue
	elseif nextValue ~= nil then
		local paramMo = comp._paramMoMgr:getParamMo(motionType, paramId)
		local dataType = paramMo:getDataType()

		value = paramMo:getValue()

		if dataType == MsEnum.DataType.Bool then
			value = not value
		elseif dataType == MsEnum.DataType.Int or dataType == MsEnum.DataType.Float then
			local dMin = paramMo:getMinOfDefault()
			local dMax = paramMo:getMaxOfDefault()

			if dMin and dMax then
				local offest = Mathf.Abs(dMin)
				local min = dMin + offest
				local max = dMax + offest

				value = (value + offest - min + 1) % (max - min + 1) + min - offest
			else
				value = value + 1
			end
		end
	end

	if motionType == MsEnum.MotionType.PublicParam then
		comp._paramMoMgr:setParamValue(MsEnum.ParamMgrType.Public, paramId, value)
		SpineInterfaceMemoryRuntime.markDirty(comp)
	elseif motionType == MsEnum.MotionType.SpineParam then
		comp._paramMoMgr:setParamValue(MsEnum.ParamMgrType.Spine, paramId, value)
		comp:_markSpineParamHasUpdate(paramId)
	end
end

function MotionExecutorRegistry:_executeSpineAnim(motionInfo)
	local comp = self._session:getOwner()
	local motionMo = motionInfo.motionMo
	local animName = motionMo:getMotionParam("animName")
	local animNames = motionMo:getMotionParam("animNames")

	if animNames and #animNames > 0 then
		animName = animNames[math.random(1, #animNames)]
	end

	local trackIndex = motionMo:getMotionParam("trackIndex", MsEnum.DataType.Int)
	local isKeep = motionMo:getMotionParam("isKeep", MsEnum.DataType.Bool)

	if not string.nilorempty(animName) then
		local isLoop = motionMo:getMotionParam("isLoop", MsEnum.DataType.Bool)
		local isForbidOp = motionMo:getMotionParam("isForbid", MsEnum.DataType.Bool)
		local isFadeIn = motionMo:getMotionParam("isFadeIn", MsEnum.DataType.Bool)
		local spineEventIdList = motionMo:getMotionParam("spineEventIdList")
		local audioId = motionMo:getMotionParam("audioId", MsEnum.DataType.Int)
		local audioTrackIndex = motionMo:getMotionParam("trackIndex", MsEnum.DataType.Int)
		local isFadeOut = motionMo:getMotionParam("isFadeOut", MsEnum.DataType.Bool)
		local showObjs = motionMo:getMotionParam("showObjs")
		local showObjsTicks = motionMo:getMotionParam("showObjsTicks")

		if showObjs and showObjsTicks then
			comp._showObjTimersInfo[animName] = {
				curTimeSec = 0,
				curTicks = 0,
				showObjs = showObjs,
				showObjsTicks = showObjsTicks
			}
		end

		local function completeCallBack()
			if showObjs and showObjsTicks and comp._showObjTimersInfo[animName] and not comp._showObjTimersInfo[animName].isEnd then
				for _, v in ipairs(comp._showObjTimersInfo[animName].showObjs) do
					local obj = goutil.findChild(comp._spineGo, v)

					GameUtil.SetActive(obj, false)
				end

				comp._showObjTimersInfo[animName].isEnd = true
			end

			motionInfo.blockState = 3

			self._session:tryTriggerDoMotionQueue()
		end

		comp:_playSpineAnim(animName, completeCallBack, isLoop, isForbidOp, isFadeIn, (not motionMo:isHaveMotionParam("isFadeOut") or nil) and true, trackIndex, isKeep, spineEventIdList, audioId, audioTrackIndex)

		if isKeep == true then
			SpineInterfaceMemoryRuntime.markDirty(comp)
		end
	elseif isKeep == false then
		comp:_exitTrackKeep(trackIndex)
		SpineInterfaceMemoryRuntime.markDirty(comp)
	end
end

function MotionExecutorRegistry:_executeEvent(motionInfo)
	local motionMo = motionInfo.motionMo
	local eventName = motionMo:getMotionParam("eventName")
	local eventParam = motionMo:getMotionParam("eventParam")

	if not string.nilorempty(eventName) then
		GlobalDispatcher:dispatch(eventName, eventParam)
	else
		printError("意图触发空事件,请检查配置()(m模型骨骼动画交互行为表.xlsx|export_行为配置)")
	end
end

function MotionExecutorRegistry:_executeBehaviorChange(motionInfo)
	motionInfo.state:setIsNeedToNextState(true)
end

function MotionExecutorRegistry:_executeAudio(motionInfo)
	local comp = self._session:getOwner()
	local motionMo = motionInfo.motionMo
	local audioId = motionMo:getMotionParam("audioId", MsEnum.DataType.Int)
	local trackIndex = motionMo:getMotionParam("trackIndex", MsEnum.DataType.Int)

	comp:_playAudio(audioId, trackIndex)
end

function MotionExecutorRegistry:_executeBoneFollow(motionInfo)
	local comp = self._session:getOwner()
	local motionMo = motionInfo.motionMo
	local goName = motionMo:getMotionParam("goName")
	local slotName = motionMo:getMotionParam("slotName")
	local allowMultiple = motionMo:getMotionParam("allowMultiple", MsEnum.DataType.Bool)
	local alwaysVisible = motionMo:getMotionParam("alwaysVisible", MsEnum.DataType.Bool)

	if string.nilorempty(goName) or string.nilorempty(slotName) then
		printError(string.format("骨骼绑定动作错误，缺失重要参数配置，goName或slotName为空，goName: %s, slotName: %s", goName, slotName))
	end

	local go = goutil.findChild(comp._spineGo, goName)

	if not goutil.isNil(go) then
		comp:beginBoneFollow(go, slotName, allowMultiple, alwaysVisible)
	end
end

return MotionExecutorRegistry
