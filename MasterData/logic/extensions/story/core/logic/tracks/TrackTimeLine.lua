-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/tracks/TrackTimeLine.lua

module("logic.extensions.story.core.logic.tracks.TrackTimeLine", package.seeall)

local M = class("TrackTimeLine", StoryTrackBase)

function M:_OnInitCtor()
	self.assetUID = nil
	self.instUID = nil
end

function M:OnStoryAwakeInternal()
	local argInfo = self.config:GetArg(StoryArgKeyConst.RefAssets)

	if not argInfo then
		return
	end

	self.assetUID = self.config:GetArgValue(StoryArgKeyConst.RefAssets)
	self.instUID = tostring(argInfo.GUID)

	local assetObj = self.binder:GetBindObject(self.assetUID)

	if assetObj then
		local inst = StoryGameObjectPool.Get(self.assetUID, assetObj)

		inst.name = assetObj.name

		local proxyInst = StoryEngine.StoryGameObjectInstProxy.CreateProxyInstAndSetParent(inst)

		proxyInst.name = self.instUID

		goutil.addChildToParent(proxyInst.proxyTarget, self.binder.BinderRoot.transform)
		StoryUtils.ResetTransform(proxyInst.gameObject)
		self.binder:AddProxyPtr(self.instUID, proxyInst, StoryPtrTag.UnityTimeLineInstance, nil, nil)
		self.binder:SetProxyPtrVisible(self.instUID, false, false)

		local _director = inst:GetComponentInChildren(typeof(UnityEngine.Playables.PlayableDirector), true)

		if _director then
			_director.playOnAwake = false
			_director.initialTime = 0

			_director:Stop()
		end
	end
end

function M:OnStoryEnterInternal()
	self.bindingTarget = nil

	self.binder:SetPtrUsable(self.instUID, true)

	local ptrInfo = self.binder:FindIDPtr(self.instUID)

	if ptrInfo then
		self.bindingTarget = ptrInfo.targetObj
	end
end

function M:OnStoryExitInternal()
	self.binder:SetPtrUsable(self.instUID, false)

	self.bindingTarget = nil
end

function M:OnStoryDestroyInternal()
	local ptrInfo = self.binder:FindIDPtr(self.instUID)

	if ptrInfo and ptrInfo.type == StoryResIDPtrType.GameObject then
		self.binder:RemovePtr(self.instUID)

		local proxyInst = ptrInfo.targetObj

		if proxyInst then
			goutil.destroy(proxyInst.proxyTarget)
		end
	end
end

return M
