-- chunkname: @modules/common/utils/GoHelperExtend.lua

module("modules.common.utils.GoHelperExtend", package.seeall)

local gohelper = gohelper

gohelper.Type_UIClickAudio = typeof(ZProj.UIClickAudio)
gohelper.Type_CanvasGroup = typeof(UnityEngine.CanvasGroup)
gohelper.Type_TMPInputField = typeof(TMPro.TMP_InputField)
gohelper.Type_Animator = typeof(UnityEngine.Animator)
gohelper.Type_LimitedScrollRect = typeof(ZProj.LimitedScrollRect)
gohelper.Type_RectTransform = typeof(UnityEngine.RectTransform)
gohelper.Type_Transform = typeof(UnityEngine.Transform)
gohelper.Type_ParticleSystem = typeof(UnityEngine.ParticleSystem)
gohelper.Type_ParticleSpeedModify = typeof(ZProj.ParticleSpeedModify)
gohelper.Type_AnimationEventWrap = typeof(ZProj.AnimationEventWrap)
gohelper.Type_Animation = typeof(UnityEngine.Animation)
gohelper.Type_TMP_SubMeshUI = typeof(TMPro.TMP_SubMeshUI)
gohelper.Type_RectMask2D = typeof(UnityEngine.UI.RectMask2D)
gohelper.Type_GridLayoutGroup = typeof(UnityEngine.UI.GridLayoutGroup)
gohelper.Type_ContentSizeFitter = typeof(UnityEngine.UI.ContentSizeFitter)
gohelper.Type_MeshRender = typeof(UnityEngine.MeshRenderer)
gohelper.Type_Render = typeof(UnityEngine.Renderer)
gohelper.Type_Spine_SkeletonAnimation = typeof(Spine.Unity.SkeletonAnimation)
gohelper.Type_Spine_SkeletonGraphic = typeof(Spine.Unity.SkeletonGraphic)
gohelper.Type_UIFollower = typeof(ZProj.UIFollower)
gohelper.Type_ListScrollView = typeof(SLFramework.UGUI.ListScrollView)
gohelper.Type_MixScrollView = typeof(SLFramework.UGUI.MixScrollView)

local ButtonWrap = SLFramework.UGUI.ButtonWrap
local UIClickListener = SLFramework.UGUI.UIClickListener
local GameHelper = ZProj.GameHelper
local UIDragListener = SLFramework.UGUI.UIDragListener
local ZProj_TextMeshInputFieldWrap = ZProj.TextMeshInputFieldWrap
local ZProj_ScrollbarWrap = ZProj.ScrollbarWrap
local ZProj_DropdownWrap = ZProj.DropdownWrap
local ZProj_TMPDropdownWrap = ZProj.TMPDropdownWrap

function gohelper.addUIClickAudio(go, audioId)
	audioId = audioId or AudioEnum.UI.UI_Common_Click

	local uiClickAudio = gohelper.onceAddComponent(go, gohelper.Type_UIClickAudio)

	uiClickAudio.audioId = audioId
end

function gohelper.removeUIClickAudio(go)
	local uiClickAudio = gohelper.onceAddComponent(go, gohelper.Type_UIClickAudio)

	uiClickAudio.audioId = 0
end

function gohelper.findChildButtonWithAudio(go, childPath, audioId)
	local buttonWrap = ButtonWrap.GetWithPath(go, childPath)

	if buttonWrap then
		gohelper.addUIClickAudio(buttonWrap.gameObject, audioId)
	end

	return buttonWrap
end

function gohelper.findButtonWithAudio(go, audioId)
	local buttonWrap = ButtonWrap.Get(go)

	if buttonWrap then
		gohelper.addUIClickAudio(buttonWrap.gameObject, audioId)
	end

	return buttonWrap
end

function gohelper.findChildClickWithAudio(go, childPath, audioId)
	local listener = UIClickListener.GetWithPath(go, childPath)

	if listener and audioId then
		gohelper.addUIClickAudio(listener.gameObject, audioId)
	end

	return listener
end

function gohelper.findChildAnim(go, path)
	local child = gohelper.findChild(go, path)

	if child then
		return child:GetComponent(gohelper.Type_Animator)
	end
end

function gohelper.findComponentAnim(go)
	if gohelper.isNil(go) then
		logError("gohelper.findComponentAnimator: go is nil")

		return nil
	end

	return go:GetComponent(gohelper.Type_Animator)
end

function gohelper.getClickWithAudio(go, audioId)
	local listener = UIClickListener.Get(go)

	if listener and audioId then
		gohelper.addUIClickAudio(listener.gameObject, audioId)
	end

	return listener
end

function gohelper.getClickWithDefaultAudio(go)
	return gohelper.getClickWithAudio(go, AudioEnum.UI.UI_Common_Click)
end

function gohelper.findChildClickWithDefaultAudio(go, childPath)
	return gohelper.findChildClickWithAudio(go, childPath, AudioEnum.UI.UI_Common_Click)
end

function gohelper.findChildTextMeshInputField(go, childPath)
	return ZProj_TextMeshInputFieldWrap.GetWithPath(go, childPath)
end

function gohelper.findChildDropdown(go, childPath)
	return ZProj_DropdownWrap.GetWithPath(go, childPath) or ZProj_TMPDropdownWrap.GetWithPath(go, childPath)
end

function gohelper.findChildScrollbar(go, childPath)
	return ZProj_ScrollbarWrap.GetWithPath(go, childPath)
end

function gohelper.findChildUIMesh(go, path)
	if string.nilorempty(path) then
		return go:GetComponent(typeof(UIMesh))
	end

	local child = gohelper.findChild(go, path)

	if child then
		return child:GetComponent(typeof(UIMesh))
	end
end

function gohelper.findChildUIDragListener(go, path)
	if string.nilorempty(path) then
		return UIDragListener.Get(go)
	else
		return UIDragListener.GetWithPath(go, path)
	end
end

function gohelper.setActiveCanvasGroup(go_canvasGroup, isActive)
	GameHelper.SetActiveCanvasGroup(go_canvasGroup, isActive)
end

function gohelper.setActiveCanvasGroupNoAnchor(go_canvasGroup, isActive)
	if gohelper.isNil(go_canvasGroup) then
		return
	end

	go_canvasGroup.alpha = isActive and 1 or 0
	go_canvasGroup.interactable = not not isActive
	go_canvasGroup.blocksRaycasts = not not isActive
end

function gohelper.getRichColorText(text, color)
	return string.format("<color=%s>%s</color>", color, text)
end

function gohelper.getRemindFourNumberFloat(value)
	return value - value % 0.0001
end

function gohelper.activateExtend()
	return
end

function gohelper.CreateObjList(class, callback, data, parent_obj, model_obj, component, start_index, end_index, offsetNum)
	if gohelper.isNil(parent_obj) and not gohelper.isNil(model_obj) then
		parent_obj = model_obj.transform.parent.gameObject
	end

	local modelIsChild
	local data_len = #data
	local parent_transform = parent_obj.transform

	start_index = start_index or 1
	end_index = end_index or data_len
	offsetNum = offsetNum or 0

	if start_index > 1 then
		for i = 1, start_index - 1 do
			local child_obj

			if data[i] then
				child_obj = parent_transform.childCount >= i + offsetNum and parent_transform:GetChild(i - 1 + offsetNum).gameObject

				if child_obj == model_obj then
					gohelper.setActive(child_obj, false)

					offsetNum = offsetNum + 1
					modelIsChild = child_obj

					break
				end
			end
		end
	end

	for i = start_index, end_index do
		local child_obj

		if data[i] then
			child_obj = parent_transform.childCount >= i + offsetNum and parent_transform:GetChild(i - 1 + offsetNum).gameObject or gohelper.clone(model_obj, parent_obj, i)

			if child_obj == model_obj then
				gohelper.setActive(child_obj, false)

				offsetNum = offsetNum + 1
				modelIsChild = child_obj
				child_obj = parent_transform.childCount >= i + offsetNum and parent_transform:GetChild(i - 1 + offsetNum).gameObject or gohelper.clone(model_obj, parent_obj, i)
			end

			gohelper.setActive(child_obj, true)

			if callback then
				if component then
					callback(class, MonoHelper.addNoUpdateLuaComOnceToGo(child_obj, component), data[i], i)
				else
					callback(class, child_obj, data[i], i)
				end
			end
		else
			end_index = i - 1

			break
		end
	end

	start_index = end_index + 1 + offsetNum
	start_index = end_index + 1 + offsetNum < 1 and 1 or start_index

	for i = start_index, parent_transform.childCount do
		local child = parent_transform:GetChild(i - 1)
		local child_obj = child and child.gameObject

		if child_obj then
			gohelper.setActive(child_obj, false)
		end
	end

	if modelIsChild then
		modelIsChild.transform:SetSiblingIndex(parent_transform.childCount - 1)
	end
end

function gohelper.CreateNumObjList(parent_obj, model_obj, count, callback, callbackObj)
	local parent_transform = parent_obj.transform
	local child_num = parent_transform.childCount
	local offsetNum = 0

	for i = 1, child_num do
		if parent_transform:GetChild(i - 1).gameObject == model_obj then
			offsetNum = offsetNum + 1

			gohelper.setAsFirstSibling(model_obj)
			gohelper.setActive(model_obj, false)

			break
		end
	end

	child_num = child_num - offsetNum

	local max_num = child_num <= count and count or child_num

	for i = 1, max_num do
		local child_obj

		if i <= count then
			child_obj = i <= child_num and parent_transform:GetChild(i - 1 + offsetNum).gameObject or gohelper.clone(model_obj, parent_obj, i)

			gohelper.setActive(child_obj, true)

			if callback then
				callback(callbackObj, child_obj, i)
			end
		else
			child_obj = i <= child_num and parent_transform:GetChild(i - 1 + offsetNum).gameObject

			if child_obj then
				gohelper.setActive(child_obj, false)
			end
		end
	end
end

function gohelper.removeComponent(go, componentType)
	GameHelper.RemoveComponent(go, componentType)
end

function gohelper.enableAkListener(go, enable)
	if enable then
		ZProj.AudioHelper.EnableAkListener(go)
	else
		ZProj.AudioHelper.DisableAkListener(go)
	end
end

function gohelper.addAkGameObject(go)
	ZProj.AudioHelper.AddAkGameObject(go)
end

function gohelper.fitScreenOffset(rectTransform)
	ZProj.UGUIHelper.RebuildLayout(rectTransform)

	local root = ViewMgr.instance:getUIRoot().transform
	local screenRightX = recthelper.getWidth(root)
	local screenTopY = recthelper.getHeight(root)
	local screenTopY = screenRightX / screenTopY < 1.7777777777777777 and 1080 or screenTopY
	local childMinX, childMaxX, childMinY, childMaxY
	local graphics = rectTransform.gameObject:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic))

	if graphics then
		local iter = graphics:GetEnumerator()

		while iter:MoveNext() do
			local rectChild = iter.Current.gameObject:GetComponent(typeof(UnityEngine.RectTransform))
			local uiRectChild = root:InverseTransformPoint(rectChild.position)
			local childLeftX = uiRectChild.x - rectChild.pivot.x * recthelper.getWidth(rectChild)
			local childRightX = uiRectChild.x + (1 - rectChild.pivot.x) * recthelper.getWidth(rectChild)
			local childTopY = uiRectChild.y + (1 - rectChild.pivot.y) * recthelper.getHeight(rectChild)
			local childBottomY = uiRectChild.y - rectChild.pivot.y * recthelper.getHeight(rectChild)

			childMinX = childMinX or childLeftX

			if childLeftX < childMinX then
				childMinX = childLeftX
			end

			childMaxX = childMaxX or childRightX

			if childMaxX < childRightX then
				childMaxX = childRightX
			end

			childMinY = childMinY or childBottomY

			if childBottomY < childMinY then
				childMinY = childBottomY
			end

			childMaxY = childMaxY or childTopY

			if childMaxY < childTopY then
				childMaxY = childTopY
			end
		end
	end

	local halfScreenWidth = screenRightX / 2
	local halfScreenHeight = screenTopY / 2
	local corrected = false

	if childMinX < -halfScreenWidth then
		corrected = true

		recthelper.setAnchorX(rectTransform, recthelper.getAnchorX(rectTransform) - (childMinX + halfScreenWidth))
	elseif halfScreenWidth < childMaxX then
		corrected = true

		recthelper.setAnchorX(rectTransform, recthelper.getAnchorX(rectTransform) - (childMaxX - halfScreenWidth))
	end

	if childMinY < -halfScreenHeight then
		corrected = true

		recthelper.setAnchorY(rectTransform, recthelper.getAnchorY(rectTransform) - (childMinY + halfScreenHeight))
	elseif halfScreenHeight < childMaxY then
		corrected = true

		recthelper.setAnchorY(rectTransform, recthelper.getAnchorY(rectTransform) - (childMaxY - halfScreenHeight))
	end

	return corrected
end

function gohelper.addChildPosStay(parentGO, childGO)
	if gohelper.isNil(childGO) then
		return
	end

	if gohelper.isNil(parentGO) then
		childGO.transform:SetParent(nil, true)
	else
		childGO.transform:SetParent(parentGO.transform, true)
	end
end

function gohelper.addBoxCollider2D(go, size)
	local box = gohelper.onceAddComponent(go, typeof(UnityEngine.BoxCollider2D))

	box.enabled = true
	box.size = size or Vector2(1.5, 1.5)

	return box
end

function gohelper.fitScrollItemOffset(viewGO, contentGO, itemGO, scrollDir)
	local rootTrans = ViewMgr.instance:getUIRoot().transform
	local viewTrans = viewGO:GetComponent(typeof(UnityEngine.RectTransform))
	local uiViewTrans = rootTrans:InverseTransformPoint(viewTrans.position)
	local viewTotalScale = transformhelper.getLocalScale(viewGO.transform) * gohelper.getTotalParentScale(viewGO)
	local viewLeftX = uiViewTrans.x - viewTrans.pivot.x * recthelper.getWidth(viewTrans) * viewTotalScale
	local viewRightX = uiViewTrans.x + (1 - viewTrans.pivot.x) * recthelper.getWidth(viewTrans) * viewTotalScale
	local viewTopY = uiViewTrans.y + (1 - viewTrans.pivot.y) * recthelper.getHeight(viewTrans) * viewTotalScale
	local viewBottomY = uiViewTrans.y - viewTrans.pivot.y * recthelper.getHeight(viewTrans) * viewTotalScale
	local childMinX, childMaxX, childMinY, childMaxY, moveOffset = 100000, -100000, 100000, -100000, 0
	local graphics = itemGO:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic))

	if graphics then
		local iter = graphics:GetEnumerator()

		while iter:MoveNext() do
			local currentGo = iter.Current.gameObject

			if currentGo:GetComponent(gohelper.Type_ParticleSystem) == nil then
				local rectChild = currentGo:GetComponent(typeof(UnityEngine.RectTransform))
				local childTotalScale = transformhelper.getLocalScale(currentGo.transform) * gohelper.getTotalParentScale(currentGo)
				local uiRectChild = rootTrans:InverseTransformPoint(rectChild.position)
				local childLeftX = uiRectChild.x - rectChild.pivot.x * recthelper.getWidth(rectChild) * childTotalScale
				local childRightX = uiRectChild.x + (1 - rectChild.pivot.x) * recthelper.getWidth(rectChild) * childTotalScale
				local childTopY = uiRectChild.y + (1 - rectChild.pivot.y) * recthelper.getHeight(rectChild) * childTotalScale
				local childBottomY = uiRectChild.y - rectChild.pivot.y * recthelper.getHeight(rectChild) * childTotalScale

				childMinX = math.min(childMinX, childLeftX)
				childMaxX = math.max(childMaxX, childRightX)
				childMinY = math.min(childMinY, childBottomY)
				childMaxY = math.max(childMaxY, childTopY)
			end
		end
	end

	if scrollDir == ScrollEnum.ScrollDirH then
		if childMinX < viewLeftX then
			moveOffset = viewLeftX - childMinX
		end

		if viewRightX < childMaxX then
			moveOffset = viewRightX - childMaxX
		end
	elseif scrollDir == ScrollEnum.ScrollDirV then
		if childMinY < viewBottomY then
			moveOffset = viewBottomY - childMinY
		end

		if viewTopY < childMaxY then
			moveOffset = viewTopY - childMaxY
		end
	end

	return moveOffset / gohelper.getTotalParentScale(contentGO)
end

function gohelper.getTotalParentScale(itemGO)
	local parentGO = itemGO.transform.parent.gameObject
	local totalParentScale = transformhelper.getLocalScale(parentGO.transform)

	while parentGO.transform.parent.gameObject.name ~= "UIRoot" do
		parentGO = parentGO.transform.parent.gameObject
		totalParentScale = totalParentScale * transformhelper.getLocalScale(parentGO.transform)
	end

	return totalParentScale
end

function gohelper.isMouseOverGo(goOrComp, screenPos)
	if not goOrComp then
		return false
	end

	local trans = goOrComp.transform
	local width = recthelper.getWidth(trans)
	local height = recthelper.getHeight(trans)

	screenPos = screenPos or GamepadController.instance:getMousePosition()

	local touchPos = recthelper.screenPosToAnchorPos(screenPos, trans)
	local pivot = trans.pivot

	if touchPos.x >= -width * pivot.x and touchPos.x <= width * (1 - pivot.x) and touchPos.y <= height * (1 - pivot.y) and touchPos.y >= -height * pivot.y then
		return true
	end

	return false
end

function gohelper.removeEffectNode(go)
	if not go then
		return
	end

	local performanceLevel = GameGlobalMgr.instance:getScreenState():getLocalQuality()
	local removeH = performanceLevel == ModuleEnum.Performance.Middle or performanceLevel == ModuleEnum.Performance.Low
	local removeM = performanceLevel == ModuleEnum.Performance.Low

	if removeH or removeM then
		gohelper._deleteLodNode(go.transform, removeH, removeM)
	end
end

function gohelper._deleteLodNode(effectTr, removeH, removeM)
	local childCount = effectTr.childCount

	for i = childCount - 1, 0, -1 do
		local childTr = effectTr:GetChild(i)

		if removeH and string.find(childTr.name, "^h_") then
			gohelper.destroy(childTr.gameObject)
		elseif removeM and string.find(childTr.name, "^m_") then
			gohelper.destroy(childTr.gameObject)
		else
			gohelper._deleteLodNode(childTr, removeH, removeM)
		end
	end
end

function gohelper.getParent(tr, depth)
	local temp = tr

	for i = 1, depth do
		if not temp then
			return
		end

		temp = temp.parent
	end

	return temp
end

function gohelper.getUIScreenWidth()
	local go = UnityEngine.GameObject.Find("UIRoot/POPUP_TOP")

	if go then
		return recthelper.getWidth(go.transform)
	end

	local scale = 1080 / UnityEngine.Screen.height

	return (math.floor(UnityEngine.Screen.width * scale + 0.5))
end

function gohelper.setParent(go, parent, worldPositionStays)
	go.transform:SetParent(parent.transform, worldPositionStays)
end

return gohelper
