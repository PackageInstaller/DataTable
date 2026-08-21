-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/handles/StoryHandleSwitchCamera.lua

module("logic.extensions.story.core.logic.handles.StoryHandleSwitchCamera", package.seeall)

local M = class("StoryHandleSwitchCamera")

function M:Handle(cameraUID, binder, cameraHideTags)
	if string.nilorempty(cameraUID) or not binder then
		return
	end

	if not binder:CheckPtrUsable(cameraUID) then
		return
	end

	self:HideAllSceneCamera(binder, cameraHideTags)

	local inst = binder:GetGameObjectInstProxy(cameraUID)

	if not inst then
		return
	end

	goutil.setActive(inst.proxyTarget, true)
	binder:SetPtrActive(cameraUID, true)
end

function M:SetCameraFOV(cameraUID, binder, fov)
	if string.nilorempty(cameraUID) or not binder then
		return
	end

	if not binder:CheckPtrUsable(cameraUID) then
		return
	end

	local inst = binder:GetGameObjectInstProxy(cameraUID)

	if not inst then
		return
	end

	if fov and fov > 0 then
		local vcam = inst.target:GetComponent(ComponentType.CinemachineVirtualCamera)

		CinemachineVirtualCamAdapter.SetVirtualCamFiledOfView(vcam, fov)
	end
end

function M:HideAllSceneCamera(binder, cameraHideTags)
	local formatTag

	if cameraHideTags == nil then
		formatTag = StoryPtrTag.FixCamera .. "|" .. StoryPtrTag.CharacterCamera
	else
		formatTag = table.concat(cameraHideTags, "|")
	end

	local csList = binder:FindIDPtrWithTypeAndFormatTag(StoryResIDPtrType.GameObject, formatTag, "|")

	for i = 0, csList.Count - 1 do
		local item = csList[i]

		if item.isUsable or item.isActive then
			local proxyInst = item and item.targetObj or nil

			if proxyInst then
				goutil.setActive(proxyInst.proxyTarget, false)
				binder:SetPtrActive(item.uid, false)
			end
		end
	end
end

return M
