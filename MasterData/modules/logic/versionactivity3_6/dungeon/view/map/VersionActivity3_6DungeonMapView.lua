-- chunkname: @modules/logic/versionactivity3_6/dungeon/view/map/VersionActivity3_6DungeonMapView.lua

module("modules.logic.versionactivity3_6.dungeon.view.map.VersionActivity3_6DungeonMapView", package.seeall)

local VersionActivity3_6DungeonMapView = class("VersionActivity3_6DungeonMapView", VersionActivityFixedDungeonMapView1)

function VersionActivity3_6DungeonMapView:_editableInitView()
	self._goplay = gohelper.findChild(self.viewGO, "#go_play")
	self._btnPlay = gohelper.findChildButtonWithAudio(self.viewGO, "#go_play/bg")

	self:_showPlayBtn()

	local goreddot = gohelper.findChild(self._goplay, "#go_reddot")

	RedDotController.instance:addRedDot(goreddot, RedDotEnum.DotNode.V3a6YaMi)
	VersionActivity3_6DungeonMapView.super._editableInitView(self)
end

function VersionActivity3_6DungeonMapView:addEvents()
	VersionActivity3_6DungeonMapView.super.addEvents(self)
	self._btnPlay:AddClickListener(self._btnplayOnClick, self)
end

function VersionActivity3_6DungeonMapView:removeEvents()
	VersionActivity3_6DungeonMapView.super.removeEvents(self)
	self._btnPlay:RemoveClickListener()
end

function VersionActivity3_6DungeonMapView:_btnplayOnClick()
	V3a6YaMiController.instance:openMainView(false)
end

function VersionActivity3_6DungeonMapView:onRefreshActivityState(updateActId)
	VersionActivity3_6DungeonMapView.super.onRefreshActivityState(self, updateActId)

	if updateActId == VersionActivity3_6Enum.ActivityId.YaMi then
		self:_showPlayBtn()
	end
end

function VersionActivity3_6DungeonMapView:_showPlayBtn()
	local isOpen = ActivityHelper.isOpen(VersionActivity3_6Enum.ActivityId.YaMi)

	gohelper.setActive(self._goplay, isOpen)

	if isOpen then
		local aniName = "idle"

		if GameUtil.playerPrefsGetNumberByUserId(V3a6YaMiEnum.PrefsKey.UnlockEnterBtn, 0) == 0 then
			aniName = "unlock"

			GameUtil.playerPrefsSetNumberByUserId(V3a6YaMiEnum.PrefsKey.UnlockEnterBtn, 1)
		end

		local anim = self._goplay:GetComponent(typeof(UnityEngine.Animator))

		anim:Play(aniName, 0, 0)
	end
end

function VersionActivity3_6DungeonMapView:_OnUpdateMapElementState(mapId)
	VersionActivity3_6DungeonMapView.super._OnUpdateMapElementState(self, mapId)
	self:_showPlayBtn()
end

return VersionActivity3_6DungeonMapView
