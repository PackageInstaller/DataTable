-- chunkname: @modules/logic/commandstation/view/CommandStationMapTimelineAnimView.lua

module("modules.logic.commandstation.view.CommandStationMapTimelineAnimView", package.seeall)

local CommandStationMapTimelineAnimView = class("CommandStationMapTimelineAnimView", BaseView)

function CommandStationMapTimelineAnimView:onInitView()
	self._gotimeGroup = gohelper.findChild(self.viewGO, "#go_TimeAxis/go/timeline/#scroll_timeline/#go_Viewport/#go_timeGroup")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommandStationMapTimelineAnimView:_editableInitView()
	self._isPlayingAnim = nil
end

function CommandStationMapTimelineAnimView:_clearTimelineAnim()
	TaskDispatcher.cancelTask(self._playItemOpen, self)
	TaskDispatcher.cancelTask(self._playItemClose, self)
	TaskDispatcher.cancelTask(self._startDelay, self)
end

function CommandStationMapTimelineAnimView:_checkAnimNotDone(time, isOpen)
	if self._isPlayingAnim then
		return true
	end

	self._isPlayingAnim = true
	self._isOpenTimelineAnim = isOpen

	UIBlockHelper.instance:startBlock("checkAnimNotDone", time, self.viewName)
	TaskDispatcher.cancelTask(self._playAnimDone, self)
	TaskDispatcher.runDelay(self._playAnimDone, self, time)
end

function CommandStationMapTimelineAnimView:_playAnimDone()
	self._isPlayingAnim = false

	CommandStationController.instance:dispatchEvent(CommandStationEvent.TimelineAnimDone, self._isOpenTimelineAnim)
end

function CommandStationMapTimelineAnimView:openTimelineAnim(itemPosMap, contentPosX, timeGroupWidth, delay)
	if itemPosMap == 0 then
		return
	end

	if self:_checkAnimNotDone(CommandStationEnum.TimelineOpenTime + #itemPosMap * CommandStationEnum.TimeItemDelay + (delay or 0), true) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_lushang_zhihuibu_timeline1)
	self:_clearTimelineAnim()

	self._itemPosMap = itemPosMap

	gohelper.setActive(self._gotimeGroup, true)
	recthelper.setAnchorX(self._gotimeGroup.transform, contentPosX)

	for i, v in ipairs(self._itemPosMap) do
		local go = v.go
		local posX = v.posX

		recthelper.setAnchorX(go.transform, posX - timeGroupWidth)
	end

	if delay then
		TaskDispatcher.cancelTask(self._startDelay, self)
		TaskDispatcher.runDelay(self._startDelay, self, delay)
	else
		self:_startDelay()
	end
end

function CommandStationMapTimelineAnimView:_startDelay()
	self._curIndex = #self._itemPosMap

	TaskDispatcher.runRepeat(self._playItemOpen, self, CommandStationEnum.TimeItemDelay)
end

function CommandStationMapTimelineAnimView:_playItemOpen()
	local item = self._itemPosMap[self._curIndex]

	if not item then
		return
	end

	local go = item.go
	local posX = item.posX

	if item.tweenId then
		ZProj.TweenHelper.KillById(item.tweenId)
	end

	item.tweenId = CommandStationController.CustomOutBack(go.transform, CommandStationEnum.TimelineOpenTime, posX, CommandStationEnum.TimeItemWidth, nil, self, nil)
	self._curIndex = self._curIndex - 1

	if self._curIndex <= 0 then
		TaskDispatcher.cancelTask(self._playItemOpen, self)
	end
end

function CommandStationMapTimelineAnimView:closeTimelineAnim(itemPosMap, timeGroupWidth)
	if self:_checkAnimNotDone(CommandStationEnum.TimelineCloseTime + #itemPosMap * CommandStationEnum.TimeItemDelay) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_lushang_zhihuibu_timeline2)
	self:_clearTimelineAnim()

	self._itemPosMap = itemPosMap
	self._timeGroupWidth = timeGroupWidth

	gohelper.setActive(self._gotimeGroup, true)

	if #self._itemPosMap == 0 then
		return
	end

	self._curIndex = 1

	TaskDispatcher.runRepeat(self._playItemClose, self, CommandStationEnum.TimeItemDelay)
end

function CommandStationMapTimelineAnimView:_playItemClose()
	local item = self._itemPosMap[self._curIndex]
	local go = item.go
	local posX = item.posX

	if item.tweenId then
		ZProj.TweenHelper.KillById(item.tweenId)
	end

	item.tweenId = CommandStationController.CustomOutBack(go.transform, CommandStationEnum.TimelineCloseTime, posX - self._timeGroupWidth, CommandStationEnum.TimeItemWidth, nil, self, nil, EaseType.InBack)
	self._curIndex = self._curIndex + 1

	if self._curIndex > #self._itemPosMap then
		TaskDispatcher.cancelTask(self._playItemClose, self)
	end
end

function CommandStationMapTimelineAnimView:onClose()
	self:_clearTimelineAnim()
	TaskDispatcher.cancelTask(self._playAnimDone, self)
end

return CommandStationMapTimelineAnimView
