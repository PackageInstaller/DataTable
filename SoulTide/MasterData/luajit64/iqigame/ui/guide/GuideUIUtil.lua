-- chunkname: @IQIGame\\UI\\Guide\\GuideUIUtil.lua

GuideUIUtil = {}

function GuideUIUtil.FindObjectAndRefreshCache(guideView, path, offset)
	local pos

	if guideView.cfgSubGuide.UseScenePath then
		if LuaCodeInterface.GameObjIsDestroy(guideView.targetObj) then
			guideView.targetObj = UnityEngine.GameObject.Find(path)
		end

		if guideView.targetObj == nil then
			logError("没有找到GameObject：" .. path)

			return Vector3.zero
		end

		local targetPosition

		if guideView.cfgSubGuide.SceneMountPointId ~= nil then
			targetPosition = getMountPoint(guideView.targetObj.transform, tonumber(guideView.cfgSubGuide.SceneMountPointId)).position
		else
			targetPosition = guideView.targetObj.transform.position
		end

		local screenPosition = UnityEngine.Camera.main:WorldToScreenPoint(targetPosition)
		local canvas = guideView.rootParent.UIController:GetComponent("Canvas")

		pos = canvas.worldCamera:ScreenToWorldPoint(screenPosition)
		pos = inverseTransformPoint(canvas, pos) + offset
	else
		local index = string.find(path, "/", 1)
		local pathObj = string.sub(path, index + 1, #path)

		if guideView.targetUITransform == nil then
			local strUIName = string.sub(path, 1, index - 1)
			local uiName = string.gsub(strUIName, "%(Clone%)", "")

			guideView.targetUITransform = GameEntry.UI:GetUIFormByName(uiName).transform
		end

		if LuaCodeInterface.GameObjIsDestroy(guideView.targetObj) then
			local targetObjTransform = guideView.targetUITransform:Find(pathObj)

			guideView.targetObj = targetObjTransform.gameObject
		end

		local canvas = guideView.targetUITransform.gameObject:GetComponent("Canvas")

		pos = inverseTransformPoint(canvas, guideView.targetObj.transform.position) + offset - UIUtil.CenterPositionOffset(guideView.targetObj.transform)
	end

	return pos
end
