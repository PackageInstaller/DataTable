-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/util/GridAdaptUtil.lua

module("logic.common.util.GridAdaptUtil", package.seeall)

local GridAdaptUtil = {}

function GridAdaptUtil.isNeedAdjust(max, min)
	local isNeed = false
	local screenH = ViewMgr.instance:getUIHeight()
	local screenW = ViewMgr.instance:getUIWidth()
	local screenAspect = screenW / screenH

	if screenAspect < max and min < screenAspect then
		isNeed = true
	end

	return isNeed
end

function GridAdaptUtil.fixLoopGridCount(loopGridView)
	if not loopGridView then
		return
	end

	local scroll = loopGridView.ScrollRect
	local width = math.ceil(RectTransformUtils.GetWidth(scroll.transform))
	local itemPadding = loopGridView.ItemPadding
	local itemSize = loopGridView.ItemSize
	local maxCount = 0
	local sizeCache = 0

	while sizeCache <= width do
		local needWidth = maxCount > 0 and itemSize.x + itemPadding.x or itemSize.x

		if width >= sizeCache + needWidth then
			maxCount = maxCount + 1
		end

		sizeCache = sizeCache + needWidth
	end

	LoopListUtils.SetGridColumnCountCount(loopGridView, maxCount)
end

return GridAdaptUtil
