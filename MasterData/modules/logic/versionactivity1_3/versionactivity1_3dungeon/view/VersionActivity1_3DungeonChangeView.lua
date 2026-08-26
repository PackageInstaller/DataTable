-- chunkname: @modules/logic/versionactivity1_3/versionactivity1_3dungeon/view/VersionActivity1_3DungeonChangeView.lua

module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3DungeonChangeView", package.seeall)

local VersionActivity1_3DungeonChangeView = class("VersionActivity1_3DungeonChangeView", BaseView)

function VersionActivity1_3DungeonChangeView:onInitView()
	self._simagesun = gohelper.findChildSingleImage(self.viewGO, "#simage_sun")
	self._simagemoon = gohelper.findChildSingleImage(self.viewGO, "#simage_moon")
	self._simagesun1 = gohelper.findChildSingleImage(self.viewGO, "Sun/ani/#simage_sun1")
	self._simagesun2 = gohelper.findChildSingleImage(self.viewGO, "Sun/ani/#simage_sun2")
	self._simagemoon1 = gohelper.findChildSingleImage(self.viewGO, "Moon/ani/#simage_moon1")
	self._simagemoon2 = gohelper.findChildSingleImage(self.viewGO, "Moon/ani/#simage_moon2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_3DungeonChangeView:addEvents()
	return
end

function VersionActivity1_3DungeonChangeView:removeEvents()
	return
end

function VersionActivity1_3DungeonChangeView:_editableInitView()
	self._changeAnimatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)

	self._simagesun:LoadImage(ResUrl.getV1A3DungeonIcon("v1a3_dungeon_change_sun_3"))
	self._simagemoon:LoadImage(ResUrl.getV1A3DungeonIcon("v1a3_dungeon_change_moon_3"))
	self._simagesun1:LoadImage(ResUrl.getV1A3DungeonIcon("v1a3_dungeon_change_sun_1"))
	self._simagesun2:LoadImage(ResUrl.getV1A3DungeonIcon("v1a3_dungeon_change_sun_2"))
	self._simagemoon1:LoadImage(ResUrl.getV1A3DungeonIcon("v1a3_dungeon_change_moon_1"))
	self._simagemoon2:LoadImage(ResUrl.getV1A3DungeonIcon("v1a3_dungeon_change_moon_2"))
end

function VersionActivity1_3DungeonChangeView:_changeTime(time)
	AudioMgr.instance:trigger((time == "moon" or nil) and (AudioEnum.VersionActivity1_3.play_ui_molu_night_switch or AudioEnum.VersionActivity1_3.play_ui_molu_daytime_switch))
	self._changeAnimatorPlayer:Play("to_" .. time, self._changeDone, self)
end

function VersionActivity1_3DungeonChangeView:_changeDone()
	self:closeThis()
end

function VersionActivity1_3DungeonChangeView:onUpdateParam()
	self:_changeTime(self.viewParam)
end

function VersionActivity1_3DungeonChangeView:onOpen()
	self:_changeTime(self.viewParam)
end

function VersionActivity1_3DungeonChangeView:onClose()
	return
end

function VersionActivity1_3DungeonChangeView:onDestroyView()
	self._simagesun:UnLoadImage()
	self._simagemoon:UnLoadImage()
	self._simagesun1:UnLoadImage()
	self._simagesun2:UnLoadImage()
	self._simagemoon1:UnLoadImage()
	self._simagemoon2:UnLoadImage()
end

return VersionActivity1_3DungeonChangeView
