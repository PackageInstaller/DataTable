-- chunkname: @modules/ugui/UIColorHelper.lua

module("modules.ugui.UIColorHelper", package.seeall)

local UIColorHelper = {}

UIColorHelper.PressColor = GameUtil.parseColor("#C8C8C8")

function UIColorHelper.setUIPressState(graphicCompArray, oriColorMap, isPress, pressColor, pressAlpha)
	if not graphicCompArray then
		return
	end

	local iter = graphicCompArray:GetEnumerator()

	while iter:MoveNext() do
		local color

		if isPress then
			local pressAlpha = pressAlpha or 0.85

			color = oriColorMap and oriColorMap[iter.Current] * pressAlpha or pressColor or UIColorHelper.PressColor
			color.a = iter.Current.color.a
		else
			color = oriColorMap and oriColorMap[iter.Current] or Color.white
		end

		iter.Current.color = color
	end
end

function UIColorHelper.setGameObjectPressState(viewObj, go, press)
	if not viewObj.pressGoContainer or not viewObj.pressGoContainer[go] then
		viewObj.pressGoContainer = viewObj.pressGoContainer or viewObj:getUserDataTb_()
		viewObj.pressGoContainer[go] = {}

		local images = go:GetComponentsInChildren(gohelper.Type_Image, true)

		viewObj.pressGoContainer[go].images = images

		local tmps = go:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		viewObj.pressGoContainer[go].tmps = tmps
		viewObj.pressGoContainer[go].compColor = {}

		local iter = images:GetEnumerator()

		while iter:MoveNext() do
			viewObj.pressGoContainer[go].compColor[iter.Current] = iter.Current.color
		end

		iter = tmps:GetEnumerator()

		while iter:MoveNext() do
			viewObj.pressGoContainer[go].compColor[iter.Current] = iter.Current.color
		end
	end

	if viewObj.pressGoContainer[go] then
		UIColorHelper.setUIPressState(viewObj.pressGoContainer[go].images, viewObj.pressGoContainer[go].compColor, press, nil, 0.7)
		UIColorHelper.setUIPressState(viewObj.pressGoContainer[go].tmps, viewObj.pressGoContainer[go].compColor, press, nil, 0.7)
	end
end

function UIColorHelper.set(imageOrTextCmp, hexColor)
	SLFramework.UGUI.GuiHelper.SetColor(imageOrTextCmp, hexColor)
end

function UIColorHelper.setGray(imageOrTextGo, isGray)
	ZProj.UGUIHelper.SetGrayscale(imageOrTextGo, isGray and true or false)
end

return UIColorHelper
