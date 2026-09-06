-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/comp/SpineLoadHelp.lua

module("logic.extensions.spineinterface.comp.SpineLoadHelp", package.seeall)

local SpineLoadHelp = class("SpineLoadHelp")

function SpineLoadHelp:ctor()
	self._compType = nil
	self._spineGo = nil
	self._skeletonList = {}
	self._skeletonGraphicList = {}
	self._skeletonAnimationList = {}
end

function SpineLoadHelp:onLoad(spineGo)
	self:onUnLoad()

	self._spineGo = spineGo
	self._compType = nil

	local list = self._spineGo:GetComponentsInChildren(typeof(Spine.Unity.SkeletonGraphic), true)

	if list.Length > 0 then
		self._compType = SpineEnum.CompType_SkeletonGraphic

		for i = 0, list.Length - 1 do
			local skeletonGraphic = list[i]

			table.insert(self._skeletonGraphicList, skeletonGraphic)
		end

		for _, skeletonGraphic in ipairs(self._skeletonGraphicList) do
			table.insert(self._skeletonList, skeletonGraphic.Skeleton)
		end
	else
		self._compType = SpineEnum.CompType_SkeletonAnimation

		local list = self._spineGo:GetComponentsInChildren(typeof(Spine.Unity.SkeletonAnimation), true)

		for i = 0, list.Length - 1 do
			local skeletonAnimation = list[i]

			table.insert(self._skeletonAnimationList, skeletonAnimation)
		end

		for _, skeletonAnimation in ipairs(self._skeletonAnimationList) do
			table.insert(self._skeletonList, skeletonAnimation.Skeleton)
		end
	end
end

function SpineLoadHelp:onUnLoad()
	self._spineGo = nil
	self._compType = nil

	table.clear(self._skeletonList)
	table.clear(self._skeletonGraphicList)
	table.clear(self._skeletonAnimationList)
end

function SpineLoadHelp:getCompType()
	return self._compType
end

function SpineLoadHelp:getSkeletonList()
	return self._skeletonList
end

function SpineLoadHelp:getCompList()
	if self._compType == SpineEnum.CompType_SkeletonGraphic then
		return self._skeletonGraphicList
	elseif self._compType == SpineEnum.CompType_SkeletonAnimation then
		return self._skeletonAnimationList
	end
end

function SpineLoadHelp:getSkeletonIndex(skeleton)
	local skeletonIndex = 0

	for i, v in ipairs(self._skeletonList) do
		if v == skeleton then
			skeletonIndex = i

			break
		end
	end

	return skeletonIndex
end

function SpineLoadHelp:getSkeletonDataAsset(skeletonIndex)
	local skeletonDataAsset

	if self._compType == SpineEnum.CompType_SkeletonGraphic then
		local skeletonGraphic = self._skeletonGraphicList[skeletonIndex]

		skeletonDataAsset = skeletonGraphic and skeletonGraphic.SkeletonDataAsset
	elseif self._compType == SpineEnum.CompType_SkeletonAnimation then
		local skeletonAnimation = self._skeletonAnimationList[skeletonIndex]

		skeletonDataAsset = skeletonAnimation and skeletonAnimation.SkeletonDataAsset
	end

	return skeletonDataAsset
end

function SpineLoadHelp:getAnimationState(skeletonIndex)
	local animationState

	if self._compType == SpineEnum.CompType_SkeletonGraphic then
		local skeletonGraphic = self._skeletonGraphicList[skeletonIndex]

		animationState = skeletonGraphic and skeletonGraphic.AnimationState
	elseif self._compType == SpineEnum.CompType_SkeletonAnimation then
		local skeletonAnimation = self._skeletonAnimationList[skeletonIndex]

		animationState = skeletonAnimation and skeletonAnimation.AnimationState
	end

	return animationState
end

function SpineLoadHelp:allInitialize(overwrite)
	if self._compType == SpineEnum.CompType_SkeletonGraphic then
		for _, skeletonGraphic in ipairs(self._skeletonGraphicList) do
			skeletonGraphic:Initialize(true)
		end
	elseif self._compType == SpineEnum.CompType_SkeletonAnimation then
		for _, skeletonAnimation in ipairs(self._skeletonAnimationList) do
			skeletonAnimation:Initialize(true)
		end
	end
end

return SpineLoadHelp
