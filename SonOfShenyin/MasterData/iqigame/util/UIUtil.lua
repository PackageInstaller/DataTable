-- chunkname: @IQIGame\\Util\\UIUtil.lua

UIUtil = {}
UGUISide = {
	Bottom = 3,
	BottomLeft = 2,
	Right = 1,
	Top = -3,
	BottomRight = 4,
	TopLeft = -4,
	Left = -1,
	TopRight = -2
}

function UIUtil.ResetTweenIn(gameObject)
	local tweens = gameObject:GetComponentsInChildren(typeof(UITweener))

	for i = 0, tweens.Length - 1 do
		tweens[i]:ResetToBeginning()

		tweens[i].enabled = true
	end
end

function UIUtil.InitSortedComponents(rootUICanvas, gameObject)
	local sortComponents = gameObject:GetComponentsInChildren(typeof(IQIGame.Onigao.Game.SortedComponentOrder), true)

	for i = 0, sortComponents.Length - 1 do
		sortComponents[i].UIRootCanvas = rootUICanvas
	end
end

function UIUtil.CenterPositionOffset(targetObjTransform)
	local p = Vector3.zero

	if targetObjTransform then
		local pivot = targetObjTransform.pivot

		p.x = (pivot.x - 0.5) * targetObjTransform.sizeDelta.x
		p.y = (pivot.y - 0.5) * targetObjTransform.sizeDelta.y
	end

	return p
end

function UIUtil.PlayDefaultAnim(animRoot)
	local animation = animRoot:GetComponent(typeof(UnityEngine.Animation))

	if animation == nil then
		return
	end

	animation:Play()
end

function UIUtil.StopDefaultAnim(animRoot)
	local animation = animRoot:GetComponent(typeof(UnityEngine.Animation))

	if animation == nil then
		return
	end

	animation:Stop()
end

function UIUtil.PlayOrRewindDefaultAnim(animRoot, isReverse)
	local animation = animRoot:GetComponent(typeof(UnityEngine.Animation))

	if animation == nil then
		return
	end

	local enumerator = animation:GetEnumerator()

	while enumerator:MoveNext() do
		local animationState = enumerator.Current

		animationState.time = isReverse and animationState.length or 0
		animationState.speed = isReverse and -1 or 1
	end

	animation:Play()
end

function UIUtil.AdjustUIInScreen(uiCanvas, refTrans, followerTrans, offset, refSide, followerSide)
	if offset == nil then
		offset = Vector2.zero
	end

	if refSide == nil then
		refSide = UGUISide.BottomRight
	end

	if followerSide == nil then
		followerSide = UGUISide.TopLeft
	end

	local canvasScaler = uiCanvas:GetComponent("CanvasScaler")
	local rect = Rect.New(-UnityEngine.Screen.width / 2, -UnityEngine.Screen.height / 2, UnityEngine.Screen.width, UnityEngine.Screen.height)
	local scale = canvasScaler.matchWidthOrHeight == 1 and canvasScaler.referenceResolution.y / UnityEngine.Screen.height or canvasScaler.referenceResolution.x / UnityEngine.Screen.width

	rect = Rect.New(rect.x * scale, rect.y * scale, rect.w * scale, rect.h * scale)

	local offset3 = Vector3(offset.x, offset.y, 0)

	UIUtil.__AnchorTo(followerTrans, followerSide, refTrans, refSide, uiCanvas.transform, offset3)

	local offsetIfInScreen = UIUtil.__GetOffsetIfInScreen(followerTrans, rect, uiCanvas.transform)

	if offsetIfInScreen.x == 0 and offsetIfInScreen.y == 0 then
		return
	end

	if offsetIfInScreen.x ~= 0 and offsetIfInScreen.y ~= 0 then
		refSide = UIUtil.__ConvertSide(refSide, true, true)
		followerSide = UIUtil.__ConvertSide(followerSide, true, true)
	elseif offsetIfInScreen.x ~= 0 then
		refSide = UIUtil.__ConvertSide(refSide, true, false)
		followerSide = UIUtil.__ConvertSide(followerSide, true, false)
	else
		refSide = UIUtil.__ConvertSide(refSide, false, true)
		followerSide = UIUtil.__ConvertSide(followerSide, false, true)
	end

	UIUtil.__AnchorTo(followerTrans, followerSide, refTrans, refSide, uiCanvas.transform, offset3)

	offsetIfInScreen = UIUtil.__GetOffsetIfInScreen(followerTrans, rect, uiCanvas.transform)

	if offsetIfInScreen.x ~= 0 or offsetIfInScreen.y ~= 0 then
		logError("在不遮挡参考节点（如道具图标）的情况下，无论怎么对齐都会超框，请检查UI设计和布局是否会出现这种情况，如果Tips过大，建议使用居中弹窗的形式。")
	end
end

function UIUtil.__ConvertSide(side, convertX, convertY)
	if not convertX and not convertY then
		return side
	end

	if convertX and convertY then
		side = side * -1
	elseif convertX then
		if side == UGUISide.Left or side == UGUISide.TopLeft or side == UGUISide.BottomLeft then
			side = side + 2
		else
			side = side - 2
		end
	elseif convertY then
		if side == UGUISide.Top or side == UGUISide.TopLeft or side == UGUISide.TopRight then
			side = side + 6
		else
			side = side - 6
		end
	end

	return side
end

function UIUtil.__AnchorTo(followerTrans, followerSide, refTrans, refSide, canvasTrans, offset)
	if refTrans == nil or refTrans == followerTrans then
		return
	end

	local followerBounds = UnityEngine.RectTransformUtility.CalculateRelativeRectTransformBounds(canvasTrans, followerTrans)
	local refBounds = UnityEngine.RectTransformUtility.CalculateRelativeRectTransformBounds(canvasTrans, refTrans)
	local followerOffset = UIUtil.__GetBoundsOffset(followerBounds, followerSide)
	local refOffset = UIUtil.__GetBoundsOffset(refBounds, refSide)
	local refCenter = refBounds.center

	followerTrans.anchoredPosition = refCenter - refOffset + followerOffset + offset
end

function UIUtil.__GetBoundsOffset(bounds, side)
	local offset = Vector3.zero

	if side == UGUISide.Bottom then
		offset.y = bounds.extents.y
	elseif side == UGUISide.BottomLeft then
		offset.x = bounds.extents.x
		offset.y = bounds.extents.y
	elseif side == UGUISide.BottomRight then
		offset.x = -bounds.extents.x
		offset.y = bounds.extents.y
	elseif side == UGUISide.Left then
		offset.x = bounds.extents.x
	elseif side == UGUISide.Right then
		offset.x = -bounds.extents.x
	elseif side == UGUISide.Top then
		offset.y = -bounds.extents.y
	elseif side == UGUISide.TopLeft then
		offset.x = bounds.extents.x
		offset.y = -bounds.extents.y
	elseif side == UGUISide.TopRight then
		offset.x = -bounds.extents.x
		offset.y = -bounds.extents.y
	end

	return offset
end

function UIUtil.__GetOffsetIfInScreen(followerTrans, area, canvasTrans)
	local bounds = UnityEngine.RectTransformUtility.CalculateRelativeRectTransformBounds(canvasTrans, followerTrans)

	if area == nil then
		return false
	end

	local delta = Vector2.zero

	if bounds.center.x - bounds.extents.x < area.x then
		delta.x = delta.x + math.abs(bounds.center.x - bounds.extents.x - area.x)
	elseif bounds.center.x + bounds.extents.x > area.w / 2 then
		delta.x = delta.x - math.abs(bounds.center.x + bounds.extents.x - area.w / 2)
	end

	if bounds.center.y - bounds.extents.y < area.y then
		delta.y = delta.y + math.abs(bounds.center.y - bounds.extents.y - area.y)
	elseif bounds.center.y + bounds.extents.y > area.h / 2 then
		delta.y = delta.y - math.abs(bounds.center.y + bounds.extents.y - area.h / 2)
	end

	return delta
end

function UIUtil.GetConfigArr(ParamArr)
	local Arr = {}
	local index = 0

	for i = 1, #ParamArr do
		index = index + 1

		local length = #Arr

		if index % 2 ~= 0 then
			Arr[length + 1] = {}
			Arr[length + 1][1] = ParamArr[index]

			if ParamArr[index + 1] ~= nil then
				Arr[length + 1][2] = ParamArr[index + 1]
			end
		end
	end

	return Arr
end

function UIUtil.GetConfigArrToNumber(ParamArr, tonumber)
	local Arr = {}
	local index = 0

	for i = 1, #ParamArr do
		index = index + 1

		local length = #Arr

		if (i + tonumber - 1) % tonumber == 0 then
			Arr[length + 1] = {}

			for _i = 1, tonumber do
				if ParamArr[index + _i - 1] ~= nil then
					Arr[length + 1][_i] = ParamArr[index + _i - 1]
				end
			end
		end
	end

	return Arr
end

function UIUtil.IsNil(uobj)
	return uobj == nil or uobj:Equals(nil)
end

function UIUtil.ReBuilderLayout(rectTransform)
	UIUtil.reBuilderLayoutTimer = FrameTimer.New(function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(rectTransform)
		UIUtil.reBuilderLayoutTimer:Stop()

		UIUtil.reBuilderLayoutTimer = nil
	end, 1, 1)

	UIUtil.reBuilderLayoutTimer:Start()
end
