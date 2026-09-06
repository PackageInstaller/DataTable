-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/util/SimpleSpineCtrl.lua

module("logic.extensions.spineinterface.util.SimpleSpineCtrl", package.seeall)

local SimpleSpineCtrl = class("SimpleSpineCtrl")

function SimpleSpineCtrl:ctor()
	self._spineLoadHelp = SpineLoadHelp.New()
end

function SimpleSpineCtrl:onInit(spineGo)
	if goutil.isNil(spineGo) then
		printError("错误：spine为空")
	end

	self._spineGo = spineGo

	self._spineLoadHelp:onLoad(spineGo)
end

function SimpleSpineCtrl:onClear()
	if self._spineLoadHelp then
		for skeletonIndex, skeleton in ipairs(self._spineLoadHelp:getSkeletonList()) do
			local animationState = self._spineLoadHelp:getAnimationState(skeletonIndex)

			if animationState then
				animationState:ClearTracks()
			end
		end
	end

	self._spineGo = nil

	self._spineLoadHelp:onUnLoad()
end

function SimpleSpineCtrl:playAnimation(params)
	if self._spineGo == nil then
		return
	end

	local animName = params.animName
	local trackIndex = self:_checkValue(params.trackIndex, 0)
	local isLoop = self:_checkValue(params.isLoop, false)
	local isFadeIn = self:_checkValue(params.isFadeIn, false)
	local isFadeOut = self:_checkValue(params.isFadeOut, true)
	local isLastFrameHold = self:_checkValue(params.isLastFrameHold, false)
	local startCallBack = params.startCallBack
	local completeCallBack = params.completeCallBack
	local endCallBack = params.endCallBack
	local eventCallBack = params.eventCallBack
	local interruptCallBack = params.interruptCallBack
	local disposeCallBack = params.disposeCallBack
	local skeletonList = self._spineLoadHelp:getSkeletonList()
	local validSkeletonCount = 0
	local delegateCounts = {}

	for skIndex, skeleton in ipairs(skeletonList) do
		local skeletonDataAsset = self._spineLoadHelp:getSkeletonDataAsset(skIndex)
		local skeletonData = skeletonDataAsset and skeletonDataAsset:GetAnimationStateData().SkeletonData
		local animation = skeletonData and skeletonData:FindAnimation(animName)

		if animation ~= nil then
			validSkeletonCount = validSkeletonCount + 1
		end
	end

	for skIndex, skeleton in ipairs(skeletonList) do
		local skeletonDataAsset = self._spineLoadHelp:getSkeletonDataAsset(skIndex)
		local animationStateData = skeletonDataAsset and skeletonDataAsset:GetAnimationStateData()
		local skeletonData = animationStateData and animationStateData.SkeletonData
		local animation = skeletonData and skeletonData:FindAnimation(animName)

		if animation ~= nil then
			local animationState = self._spineLoadHelp:getAnimationState(skIndex)
			local defaultMix = animationStateData.DefaultMix
			local trackEntry

			if isFadeIn then
				animationState:SetEmptyAnimation(trackIndex, defaultMix)

				trackEntry = animationState:SetAnimation(trackIndex, animName, isLoop)
				trackEntry.MixDuration = defaultMix
			else
				trackEntry = animationState:SetAnimation(trackIndex, animName, isLoop)
				trackEntry.MixDuration = 0
			end

			local onStart

			function onStart(_trackEntry)
				_trackEntry.Start = _trackEntry.Start - onStart

				self:_handleDelegate(SpineEnum.DelegateType_Start, startCallBack, delegateCounts, validSkeletonCount, _trackEntry)
			end

			trackEntry.Start = trackEntry.Start + onStart

			local onComplete

			function onComplete(_trackEntry)
				_trackEntry.Complete = _trackEntry.Complete - onComplete

				if not isLoop and not isLastFrameHold then
					if isFadeOut then
						if not defaultMix then
							local mixDuration = 0

							animationState:AddEmptyAnimation(trackIndex, mixDuration, 0)
						end
					end
				end

				self:_handleDelegate(SpineEnum.DelegateType_Complete, completeCallBack, delegateCounts, validSkeletonCount, _trackEntry)
			end

			trackEntry.Complete = trackEntry.Complete + onComplete

			local onEnd

			function onEnd(_trackEntry)
				_trackEntry.End = _trackEntry.End - onEnd

				self:_handleDelegate(SpineEnum.DelegateType_End, endCallBack, delegateCounts, validSkeletonCount, _trackEntry)
			end

			trackEntry.End = trackEntry.End + onEnd

			local onEvent

			function onEvent(_trackEntry, event)
				_trackEntry.Event = _trackEntry.Event - onEvent

				self:_handleDelegate(SpineEnum.DelegateType_Event, eventCallBack, delegateCounts, validSkeletonCount, _trackEntry, event)
			end

			trackEntry.Event = trackEntry.Event + onEvent

			local onInterrupt

			function onInterrupt(_trackEntry)
				_trackEntry.Interrupt = _trackEntry.Interrupt - onInterrupt

				self:_handleDelegate(SpineEnum.DelegateType_Interrupt, interruptCallBack, delegateCounts, validSkeletonCount, _trackEntry)
			end

			trackEntry.Interrupt = trackEntry.Interrupt + onInterrupt

			local onDispose

			function onDispose(_trackEntry)
				_trackEntry.Dispose = _trackEntry.Dispose - onDispose

				self:_handleDelegate(SpineEnum.DelegateType_Dispose, disposeCallBack, delegateCounts, validSkeletonCount, _trackEntry)
			end

			trackEntry.Dispose = trackEntry.Dispose + onDispose
		end
	end
end

function SimpleSpineCtrl:_handleDelegate(delegateType, callback, countTable, validSkeletonCount, ...)
	local count = (countTable[delegateType] or 0) + 1

	countTable[delegateType] = count

	local isFinial = validSkeletonCount <= count

	GameUtil.callBack(callback, isFinial, ...)
end

function SimpleSpineCtrl:pauseAnim()
	self:setTimeScale(0)
end

function SimpleSpineCtrl:resumeAnim()
	self:setTimeScale(1)
end

function SimpleSpineCtrl:setTimeScale(value)
	local list = self._spineLoadHelp:getCompList()

	if list then
		for _, comp in ipairs(list) do
			comp.timeScale = value
		end
	end
end

function SimpleSpineCtrl:changeSkin(skinName)
	if string.nilorempty(skinName) then
		return
	end

	local skeletonList = self._spineLoadHelp:getSkeletonList()

	for skeletonIndex, skeleton in ipairs(skeletonList) do
		local isFindSkin = skeleton.Data:FindSkin(skinName) ~= nil

		if isFindSkin == true then
			skeleton:SetSkin(skinName)
			skeleton:SetSlotsToSetupPose()

			local animationState = self._spineLoadHelp:getAnimationState(skeletonIndex)

			animationState:Apply(skeleton)
		end
	end
end

function SimpleSpineCtrl:getSkinNameList()
	local skeletonList = self._spineLoadHelp:getSkeletonList()
	local skinList = {}

	for _, skeleton in ipairs(skeletonList) do
		local skinItems = SystemReflexHelp.getItemsOfSpineExposedListSkins(skeleton.Data.Skins)

		for i = 0, skinItems.Length - 1 do
			local skin = skinItems[i]
			local skinName = SystemReflexHelp.getNameOfSkin(skin)

			table.insert(skinList, skinName)
		end
	end

	return skinList
end

function SimpleSpineCtrl:getSpineGo()
	return self._spineGo
end

function SimpleSpineCtrl:_checkValue(value, default)
	if value then
		return value
	else
		return default
	end
end

return SimpleSpineCtrl
