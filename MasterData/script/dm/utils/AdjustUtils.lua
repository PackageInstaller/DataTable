-- chunkname: @/tmp/or_script/lua_compile/dm/utils/AdjustUtils.lua

module("AdjustUtils", package.seeall)

kAdjustType = {
	Left = 4,
	StretchHeight = 32,
	Right = 8,
	StretchWidth = 16,
	Top = 1,
	Bottom = 2
}
AdjustUtilsIgnoreAdjustTag = 666888

local NotchDevices = {
	PBCM10 = {
		top = 0,
		bottom = 0,
		left = 80,
		right = 0
	},
	PACM00 = {},
	PBEM00 = {}
}
local adjustNodeInfoMap = {}
local director = cc.Director:getInstance()
local view = director:getOpenGLView()

if device.platform == "android" then
	if app and app.getDevice then
		if app.getDevice().hasNotchScreen then
			local hasNotch = app.getDevice():hasNotchScreen()

			dump(hasNotch, "hasNotch")

			if hasNotch then
				local safeInsets = app.getDevice():getSafeInsets()

				dump(safeInsets, "safeInsets")

				local list = string.split(safeInsets, ",")

				dump(list, "list")
				view:setSafeAreaInsetOffset(list[1], list[2], list[3], list[4])
			end
		else
			local model = app.getDevice():getModel()

			if NotchDevices[model] then
				local notch = NotchDevices[model]

				if notch.left and notch.right and notch.top and notch.bottom then
					view:setSafeAreaInsetInPixels(notch.left, notch.right, notch.top, notch.bottom)
				else
					local left = app.getDevice():getStatusBarHeight()

					view:setSafeAreaInsetInPixels(left, 0, 0, 0)
				end
			end
		end
	end
else
	local left = -20
	local right = -20
	local safeAreaInset = view:getSafeAreaInset()

	if safeAreaInset.left + left < 0 then
		left = 0
	end

	if safeAreaInset.left + right < 0 then
		right = 0
	end

	view:setSafeAreaInsetOffset(left, right, 0, 0)
end

winSize = director:getWinSize()

local _maxFixedOffestX = 0

if winSize.width / winSize.height > CC_DESIGN_RESOLUTION.maxfixedx then
	_maxFixedOffestX = 0.5 * (winSize.width - CC_DESIGN_RESOLUTION.maxfixedx * winSize.height) + 3
end

safeAreaInset = view:getSafeAreaInset()

local _safeRect = cc.rect(safeAreaInset.left, safeAreaInset.bottom, winSize.width - (safeAreaInset.left + safeAreaInset.right), winSize.height - (safeAreaInset.bottom + safeAreaInset.top))
local _adjustOffset = cc.p((winSize.width - CC_DESIGN_RESOLUTION.width) * 0.5, (winSize.height - CC_DESIGN_RESOLUTION.height) * 0.5)
local isCustomSafeX = cc.UserDefault:getInstance():getBoolForKey("isCustomSafeX")

if isCustomSafeX then
	_safeRect.x = cc.UserDefault:getInstance():getIntegerForKey("customSafeX")
end

local ignorRightSafeAreaAdjust = false

function getAdjustOffset()
	return _adjustOffset
end

function _adjustLayoutSizeByType(node, type)
	local isStretchWidthEnabled = bit.band(type, kAdjustType.StretchWidth) == kAdjustType.StretchWidth
	local isStretchHeightEnabled = bit.band(type, kAdjustType.StretchHeight) == kAdjustType.StretchHeight
	local curSize = node:getContentSize()

	if isStretchWidthEnabled then
		curSize.width = curSize.width + _adjustOffset.x * 2
	end

	if isStretchHeightEnabled then
		curSize.height = curSize.height + _adjustOffset.y * 2
	end

	node:setContentSize(curSize)
end

function getSafeX(safeX)
	return _safeRect.x
end

function getIsAdjust()
	if math.abs(_adjustOffset.x) < 3 and math.abs(_adjustOffset.y) < 3 then
		return false
	end

	return true
end

function getAdjustX()
	if getIsAdjust() then
		return getSafeX()
	end

	return 0
end

function updateAdjustByNewSafeX(safeX)
	for node, type in pairs(adjustNodeInfoMap) do
		if tolua.isnull(node) or node.ignorSafe then
			adjustNodeInfoMap[node] = nil
		else
			local isLeft = bit.band(type, kAdjustType.Left) == kAdjustType.Left
			local isRight = bit.band(type, kAdjustType.Right) == kAdjustType.Right
			local currentPos = cc.p(node:getPosition())
			local offset = safeX - _safeRect.x

			if isLeft then
				currentPos.x = currentPos.x + offset
			elseif isRight then
				currentPos.x = currentPos.x - (ignorRightSafeAreaAdjust and 0 or offset)
			end

			node:setPosition(currentPos)
		end
	end

	_safeRect.x = safeX

	cc.UserDefault:getInstance():setBoolForKey("isCustomSafeX", true)
	cc.UserDefault:getInstance():setIntegerForKey("customSafeX", safeX)
	cc.UserDefault:getInstance():flush()
end

function adjustLayoutByType(node, type)
	if node.isAdjust then
		return
	end

	if not getIsAdjust() then
		return
	end

	local isTop = bit.band(type, kAdjustType.Top) == kAdjustType.Top
	local isBottom = bit.band(type, kAdjustType.Bottom) == kAdjustType.Bottom
	local isLeft = bit.band(type, kAdjustType.Left) == kAdjustType.Left
	local isRight = bit.band(type, kAdjustType.Right) == kAdjustType.Right
	local currentPos = cc.p(node:getPosition())

	if isTop and not isBottom then
		currentPos.y = currentPos.y + _adjustOffset.y
	end

	if isBottom and not isTop then
		currentPos.y = currentPos.y - _adjustOffset.y
	end

	if isLeft and not isRight then
		currentPos.x = currentPos.x - (_adjustOffset.x - _safeRect.x) + _maxFixedOffestX
		adjustNodeInfoMap[node] = type
	end

	if isRight and not isLeft then
		currentPos.x = currentPos.x + (_adjustOffset.x - (ignorRightSafeAreaAdjust and 0 or _safeRect.x)) - _maxFixedOffestX
		adjustNodeInfoMap[node] = type
	end

	node:setPosition(currentPos)
	_adjustLayoutSizeByType(node, type)

	node.isAdjust = true
end

local function _getAdjustType(component)
	local type = 0

	if component:getVerticalEdge() == 1 then
		type = type + kAdjustType.Bottom
	elseif component:getVerticalEdge() == 2 then
		type = type + kAdjustType.Top
	end

	if component:getHorizontalEdge() == 1 then
		type = type + kAdjustType.Left
	elseif component:getHorizontalEdge() == 2 then
		type = type + kAdjustType.Right
	end

	if component:isStretchWidthEnabled() then
		type = type + kAdjustType.StretchWidth
	end

	if component:isStretchHeightEnabled() then
		type = type + kAdjustType.StretchHeight
	end

	return type
end

function adjustLayoutUIByRootNode(node)
	if not getIsAdjust() then
		return
	end

	if node:getTag() == AdjustUtilsIgnoreAdjustTag then
		return
	end

	local component = node:getComponent("__ui_layout")

	if component and (component:getVerticalEdge() > 0 or component:getHorizontalEdge() > 0 or component:isStretchWidthEnabled() or component:isStretchHeightEnabled()) then
		adjustLayoutByType(node, _getAdjustType(component))
	end

	local childs = node:getChildren()

	for i = 1, #childs do
		adjustLayoutUIByRootNode(childs[i])
	end
end

local function _adjustPosForSafeAreaRectForNode(node, type, isIgnor, isForce)
	if not getIsAdjust() then
		return
	end

	local isTop = bit.band(type, kAdjustType.Top) == kAdjustType.Top
	local isBottom = bit.band(type, kAdjustType.Bottom) == kAdjustType.Bottom
	local isLeft = bit.band(type, kAdjustType.Left) == kAdjustType.Left
	local isRight = bit.band(type, kAdjustType.Right) == kAdjustType.Right
	local isStretchWidthEnabled = bit.band(type, kAdjustType.StretchWidth) == kAdjustType.StretchWidth
	local isStretchHeightEnabled = bit.band(type, kAdjustType.StretchHeight) == kAdjustType.StretchHeight
	local currentPos = cc.p(node:getPosition())
	local scale = isIgnor and 1 or -1

	if isLeft then
		currentPos.x = currentPos.x - _safeRect.x * scale
	elseif isRight then
		currentPos.x = currentPos.x + (ignorRightSafeAreaAdjust and not isForce and 0 or _safeRect.x) * scale
	end

	if isTop then
		currentPos.y = currentPos.y + _safeRect.y * scale
	elseif isBottom then
		currentPos.y = currentPos.y - _safeRect.y * scale
	end

	node:setPosition(currentPos)

	local curSize = node:getContentSize()

	if isStretchWidthEnabled then
		curSize.width = curSize.width - _adjustOffset.x * 2 * scale
	end

	if isStretchHeightEnabled then
		curSize.height = curSize.height - _adjustOffset.y * 2 * scale
	end

	node:setContentSize(curSize)
end

function ignorSafeAreaRectForNode(node, type)
	if not type then
		local component = node:getComponent("__ui_layout")

		type = _getAdjustType(component)
	end

	node.ignorSafe = true

	_adjustPosForSafeAreaRectForNode(node, type, true)
end

function addSafeAreaRectForNode(node, type)
	if not type then
		local component = node:getComponent("__ui_layout")

		type = getAdjustType(component)
	end

	if ignorRightSafeAreaAdjust then
		_adjustPosForSafeAreaRectForNode(node, type, false, true)
	end
end

function autoDoLayout(node)
	ccui.Helper:doLayout(node)
end

function getFixOffsetX()
	return _maxFixedOffestX
end
