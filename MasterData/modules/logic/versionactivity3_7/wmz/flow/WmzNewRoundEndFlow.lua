-- chunkname: @modules/logic/versionactivity3_7/wmz/flow/WmzNewRoundEndFlow.lua

module("modules.logic.versionactivity3_7.wmz.flow.WmzNewRoundEndFlow", package.seeall)

local Base = WmzFlowSequence
local WmzNewRoundEndFlow = class("WmzNewRoundEndFlow", Base)

function WmzNewRoundEndFlow:ctor(...)
	Base.ctor(self, ...)
end

function WmzNewRoundEndFlow:onStart()
	self:selectTile(nil)

	local isEnddingRound = self:isCompleted()
	local zoneClearCur = self:zoneClearCurAndMax()
	local lastCompletedZoneId = self:zoneIndex2ZoneId(zoneClearCur)
	local curPlayingZoneIndex = self:curPlayingZoneIndex()

	self:onCompleteZone_Titles(zoneClearCur, true)
	self:onCompleteZone_Points(curPlayingZoneIndex, true)
	self:onCompleteZone_Cells(zoneClearCur, true)
	self:onCompleteZone_Tiles(zoneClearCur, true)
	self:_refreshZoneProgress()
	self:addWork(DelayWork.New(WmzConfig.instance:waitDurationSecOnCompletedZone()))

	if isEnddingRound then
		self:setActive_goComplete(true)
		self:addWork(DelayWork.New(WmzConfig.instance:waitDurationSecOnCompletedGame()))
		self:addWork(FunctionWork.New(self.onCompleteGame, self))
	else
		self:addWork(FunctionWork.New(self.selectZone, self, curPlayingZoneIndex))
		self:addWork(DelayWork.New(WmzConfig.instance:focusDurationSec()))
	end
end

return WmzNewRoundEndFlow
