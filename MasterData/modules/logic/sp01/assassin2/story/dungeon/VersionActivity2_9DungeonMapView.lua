-- chunkname: @modules/logic/sp01/assassin2/story/dungeon/VersionActivity2_9DungeonMapView.lua

module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonMapView", package.seeall)

local VersionActivity2_9DungeonMapView = class("VersionActivity2_9DungeonMapView", VersionActivityFixedDungeonMapView)

function VersionActivity2_9DungeonMapView:_editableInitView()
	VersionActivity2_9DungeonMapView.super._editableInitView(self)

	self._topRightAnimator = gohelper.onceAddComponent(self._gotopright, gohelper.Type_Animator)
end

function VersionActivity2_9DungeonMapView:addEvents()
	VersionActivity2_9DungeonMapView.super.addEvents(self)
	self.addEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnActivityDungeonMoChange, self.onActivityDungeonMoChange, self)
end

function VersionActivity2_9DungeonMapView:showBtnUI()
	VersionActivity2_9DungeonMapView.super.showBtnUI(self)
	gohelper.setActive(self._goswitchmodecontainer, false)
	self._topRightAnimator:Play("open")
end

function VersionActivity2_9DungeonMapView:hideBtnUI()
	VersionActivity2_9DungeonMapView.super.hideBtnUI(self)
	gohelper.setActive(self._goswitchmodecontainer, false)
	self._topRightAnimator:Play("close")
end

function VersionActivity2_9DungeonMapView:refreshMask()
	local isAttachedEpisode = VersionActivity2_9DungeonHelper.isAttachedEpisode(self.activityDungeonMo.episodeId)

	gohelper.setActive(self._simagenormalmask.gameObject, not isAttachedEpisode)
	gohelper.setActive(self._simagehardmask.gameObject, isAttachedEpisode)
end

function VersionActivity2_9DungeonMapView:onActivityDungeonMoChange()
	self:refreshMask()
end

return VersionActivity2_9DungeonMapView
