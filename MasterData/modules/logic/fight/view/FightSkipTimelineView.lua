-- chunkname: @modules/logic/fight/view/FightSkipTimelineView.lua

module("modules.logic.fight.view.FightSkipTimelineView", package.seeall)

local FightSkipTimelineView = class("FightSkipTimelineView", BaseView)

function FightSkipTimelineView:onInitView()
	self._btnskip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btns/#go_btnright/#btn_skip")
end

function FightSkipTimelineView:addEvents()
	self._btnskip:AddClickListener(self._btnskipOnClick, self)
end

function FightSkipTimelineView:removeEvents()
	self._btnskip:RemoveClickListener()
end

function FightSkipTimelineView:_btnskipOnClick()
	FightController.instance:dispatchEvent(FightEvent.SkipAppearTimeline)
end

function FightSkipTimelineView:onOpen()
	self._timeline = self.viewParam

	if FightSkipTimelineView.getState(self._timeline) == 0 then
		FightSkipTimelineView.setState(self._timeline, 1)
		gohelper.setActive(self.viewGO, false)
	else
		gohelper.setActive(self.viewGO, true)

		self._canSkip = true
	end

	NavigateMgr.instance:addEscape(ViewName.FightSkipTimelineView, self._onEscBtnClick, self)
end

function FightSkipTimelineView:_onEscBtnClick()
	if self._canSkip then
		FightController.instance:dispatchEvent(FightEvent.SkipAppearTimeline)
	end
end

function FightSkipTimelineView.getState(timeline)
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.SkipAppearTimeline .. timeline, 0)
end

function FightSkipTimelineView.setState(timeline, value)
	return PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.SkipAppearTimeline .. timeline, value or 1)
end

function FightSkipTimelineView:onClose()
	return
end

function FightSkipTimelineView:onDestroyView()
	return
end

return FightSkipTimelineView
