-- chunkname: @modules/logic/college/view/other/CollegeBuildingBubbleEggBase.lua

module("modules.logic.college.view.other.CollegeBuildingBubbleEggBase", package.seeall)

local CollegeBuildingBubbleEggBase = class("CollegeBuildingBubbleEggBase")

function CollegeBuildingBubbleEggBase:setRoot(bubbleUI, roleRoot)
	self._bubbleUI = bubbleUI
	self._roleRoot = roleRoot
end

function CollegeBuildingBubbleEggBase:canTrigger()
	return false
end

function CollegeBuildingBubbleEggBase:beginTrigger()
	return
end

function CollegeBuildingBubbleEggBase:endTrigger()
	return
end

function CollegeBuildingBubbleEggBase:clear()
	self._bubbleUI = nil
	self._roleRoot = nil
end

return CollegeBuildingBubbleEggBase
