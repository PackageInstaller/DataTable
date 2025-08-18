-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\Beginner\\RookieFocusRedDotChild.lua

local RectTransformType = typeof(UnityEngine.RectTransform)
local RookieFocusRedDotChild = Class("RookieFocusRedDotChild", UIControls.Child)

function RookieFocusRedDotChild:ctor()
	return
end

local PIVOT_VALUE = Vector2(0.5, 0.5)
local MARK_DEFAULT_POS = Vector2(0, 0)

function RookieFocusRedDotChild:focus(uiTransform, noticeInfo, dynamicNew)
	local rect = self:getController():GetComponent(RectTransformType)

	rect.sizeDelta = uiTransform.sizeDelta
	rect.pivot = PIVOT_VALUE
	rect.anchorMin = PIVOT_VALUE
	rect.anchorMax = PIVOT_VALUE
	rect.anchoredPosition = MARK_DEFAULT_POS
end

return RookieFocusRedDotChild
