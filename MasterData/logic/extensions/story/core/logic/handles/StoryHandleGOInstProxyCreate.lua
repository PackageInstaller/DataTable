-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/handles/StoryHandleGOInstProxyCreate.lua

module("logic.extensions.story.core.logic.handles.StoryHandleGOInstProxyCreate", package.seeall)

local M = class("StoryHandleGOInstProxyCreate")

function M:Handle(tag, assetUID, instUID, binder)
	if string.nilorempty(assetUID) then
		printError("StoryHandleGOInstProxyCreate Error：assetUID is nil")

		return nil
	end

	if not binder then
		printError("StoryHandleGOInstProxyCreate Error：binder is nil")

		return nil
	end

	local sourceAsset = binder:GetBindObject(assetUID)

	if goutil.isNil(sourceAsset) then
		printError("StoryHandleGOInstProxyCreate Error: binder not exist asset", assetUID, instUID)

		return nil
	end

	local gobj = StoryGameObjectPool.Get(assetUID, sourceAsset)
	local proxyInst = StoryEngine.StoryGameObjectInstProxy.CreateProxyInstAndSetParent(gobj)

	proxyInst.gameObject.name = instUID

	proxyInst.proxyTarget.transform:SetParent(binder.BinderRoot.transform)
	StoryUtils.ResetTransform(proxyInst.proxyTarget)

	local element = binder.referenceAsset:GetBind(assetUID)

	binder:AddProxyPtr(instUID, proxyInst, tag, nil, element)
	GameUtils.setLayerByName(proxyInst.gameObject, SceneLayer.Unit, true)

	return proxyInst
end

return M
