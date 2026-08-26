-- chunkname: @modules/logic/versionactivity3_9/dungeon/view/map/VersionActivity3_9DungeonMapView.lua

module("modules.logic.versionactivity3_9.dungeon.view.map.VersionActivity3_9DungeonMapView", package.seeall)

local VersionActivity3_9DungeonMapView = class("VersionActivity3_9DungeonMapView", VersionActivityFixedDungeonMapView1)

function VersionActivity3_9DungeonMapView:onInitView()
	VersionActivity3_9DungeonMapView.super.onInitView(self)

	self._gogameenter = gohelper.findChild(self.viewGO, "#go_topright/#go_gameenter")
	self._btnbird = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#go_gameenter/#btn_bird/#btn_click")
	self._btncar = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#go_gameenter/#btn_car/#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity3_9DungeonMapView:addEvents()
	VersionActivity3_9DungeonMapView.super.addEvents(self)
	self._btnbird:AddClickListener(self._btnbirdOnClick, self)
	self._btncar:AddClickListener(self._btncarOnClick, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onRefreshActivityState, self)
end

function VersionActivity3_9DungeonMapView:removeEvents()
	VersionActivity3_9DungeonMapView.super.removeEvents(self)
	self._btnbird:RemoveClickListener()
	self._btncar:RemoveClickListener()
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onRefreshActivityState, self)
end

function VersionActivity3_9DungeonMapView:_onRefreshActivityState()
	self:_refreshAct243Btn()
end

function VersionActivity3_9DungeonMapView:_btnbirdOnClick()
	V3a9BirdController.instance:openBirdMainView(VersionActivity3_9Enum.ActivityId.Bird)
end

function VersionActivity3_9DungeonMapView:_btncarOnClick()
	V3a9RacingCarController.instance:onOpenCarMainView(VersionActivity3_9Enum.ActivityId.Racing)
end

function VersionActivity3_9DungeonMapView:_editableInitView()
	VersionActivity3_9DungeonMapView.super._editableInitView(self)
	gohelper.setActive(self._gogameenter, true)

	self._gobird = gohelper.findChild(self.viewGO, "#go_topright/#go_gameenter/#btn_bird")
	self._gocar = gohelper.findChild(self.viewGO, "#go_topright/#go_gameenter/#btn_car")
	self._gocarreddot = gohelper.findChild(self.viewGO, "#go_topright/#go_gameenter/#btn_car/#go_reddot")

	RedDotController.instance:addRedDot(self._gocarreddot, RedDotEnum.DotNode.V3a9RacingCarEnter)
end

function VersionActivity3_9DungeonMapView:onOpen()
	VersionActivity3_9DungeonMapView.super.onOpen(self)
	self:_refreshAct243Btn()
end

function VersionActivity3_9DungeonMapView:_onUpdateDungeonInfo()
	self:_refreshAct243Btn()
end

function VersionActivity3_9DungeonMapView:_refreshAct243Btn()
	local isShowBirdBtn = V3a9BirdModel.instance:isShowGameEnter()

	gohelper.setActive(self._gobird.gameObject, isShowBirdBtn)

	local isShowRacingCarBtn = V3a9RacingCarModel.instance:isShowGameEnter()

	gohelper.setActive(self._gocar.gameObject, isShowRacingCarBtn)
end

return VersionActivity3_9DungeonMapView
