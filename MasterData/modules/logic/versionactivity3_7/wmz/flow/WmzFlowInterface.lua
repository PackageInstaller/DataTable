-- chunkname: @modules/logic/versionactivity3_7/wmz/flow/WmzFlowInterface.lua

module("modules.logic.versionactivity3_7.wmz.flow.WmzFlowInterface", package.seeall)

local WmzFlowInterface = class("WmzFlowInterface")

function WmzFlowInterface:isCompleted(...)
	return self.dragContext:isCompleted(...)
end

function WmzFlowInterface:getGroupListByGroupId(...)
	return self.viewContainer:getGroupListByGroupId(...)
end

function WmzFlowInterface:setRound(...)
	self.viewContainer:setRound(...)
end

function WmzFlowInterface:zoneClearCurAndMax(...)
	return self.viewContainer:zoneClearCurAndMax(...)
end

function WmzFlowInterface:zoneIndex2ZoneId(...)
	return self.viewContainer:zoneIndex2ZoneId(...)
end

function WmzFlowInterface:curPlayingZoneIndex(...)
	return self.viewContainer:curPlayingZoneIndex(...)
end

function WmzFlowInterface:curPlayingZoneId(...)
	return self.viewContainer:curPlayingZoneId(...)
end

function WmzFlowInterface:onCompleteGame(...)
	self.viewObj:onCompleteGame(...)
end

function WmzFlowInterface:onCompleteZone_Titles(...)
	self.viewObj:onCompleteZone_Titles(...)
end

function WmzFlowInterface:onCompleteZone_Points(...)
	self.viewObj:onCompleteZone_Points(...)
end

function WmzFlowInterface:onCompleteZone_Cells(...)
	self.viewObj:onCompleteZone_Cells(...)
end

function WmzFlowInterface:onCompleteZone_Tiles(...)
	self.viewObj:onCompleteZone_Tiles(...)
end

function WmzFlowInterface:setActive_goComplete(...)
	self.viewObj:setActive_goComplete(...)
end

function WmzFlowInterface:selectZone(...)
	self.viewObj:selectZone(...)
end

function WmzFlowInterface:selectTile(...)
	self.viewObj:selectTile(...)
end

function WmzFlowInterface:_refreshZoneProgress(...)
	self.viewObj:_refreshZoneProgress(...)
end

return WmzFlowInterface
