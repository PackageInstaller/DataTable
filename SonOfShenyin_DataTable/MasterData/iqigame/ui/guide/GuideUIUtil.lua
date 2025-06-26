-- chunkname: @IQIGame\\UI\\Guide\\GuideUIUtil.lua

GuideUIUtil = {}

function GuideUIUtil.FindObjectAndRefreshCache(guideView, path, offset)
	local pos

	if guideView.cfgSubGuide.BattleTapGesture then
		local s = string.split(guideView.cfgSubGuide.BattleTapGesture, ",")
		local troopType = tonumber(s[1]) == 0 and BattleModule.attackBattleTroopType or BattleModule.defineBattleTroopType
		local p = tonumber(s[2])

		guideView.targetObj = BattleModule.GetBattleUnitViewByTilePos(troopType, p).skinEntityGo

		if not guideView.targetObj then
			return nil
		end

		local targetPosition

		if guideView.cfgSubGuide.SceneMountPointId ~= nil then
			targetPosition = getMountPoint(guideView.targetObj.transform, tonumber(guideView.cfgSubGuide.SceneMountPointId)).position
		else
			targetPosition = guideView.targetObj.transform.position
		end

		local screenPosition = BattleModule.battleScene.battleCameraCom:WorldToScreenPoint(targetPosition)
		local ve = UGUIUtil.ScreenPointToLocalPointInRectangle(guideView.Image2:GetComponent("RectTransform"), screenPosition, GameEntry.UICamera)

		pos = Vector2.New(ve.x + offset.x, ve.y + offset.y)
	elseif guideView.cfgSubGuide.FindObjWithPath then
		pos = GuideUIUtil.GetPosWithPath(guideView, path, offset)
	else
		pos = GuideUIUtil.GetPosWithUI(guideView, path, offset)
	end

	return pos
end

function GuideUIUtil.GetPosWithUI(guideView, path, offset)
	local index = string.find(path, "/", 1)
	local pathObj = string.sub(path, index + 1, #path)
	local strUIName = string.sub(path, 1, index - 1)
	local uiName = string.gsub(strUIName, "%(Clone%)", "")
	local UIForm = GameEntry.UI:GetUIFormByName(uiName)

	if not UIForm then
		return
	end

	guideView.targetUITransform = GameEntry.UI:GetUIFormByName(uiName).transform

	local targetObjTransform = guideView.targetUITransform:Find(pathObj)

	if not targetObjTransform then
		return
	end

	guideView.targetObj = targetObjTransform.gameObject

	if not guideView.targetObj then
		return
	end

	local canvas = guideView.targetUITransform.gameObject:GetComponent("Canvas")

	return GameEntry.UI:WorldPointToLocalPoint(canvas, guideView.targetObj.transform.position) + offset - UIUtil.CenterPositionOffset(guideView.targetObj.transform)
end

function GuideUIUtil.GetPosWithPath(guideView, path, offset)
	local o = GameObject.Find(path)

	if not o then
		return
	end

	guideView.targetObj = o

	local targetPosition = o.transform.position
	local screenPosition = UnityEngine.Camera.main:WorldToScreenPoint(targetPosition)
	local ve = UGUIUtil.ScreenPointToLocalPointInRectangle(guideView.ParentView.UIController:GetComponent("RectTransform"), screenPosition, GameEntry.UICamera)

	return Vector2.New(ve.x + offset.x, ve.y + offset.y)
end
