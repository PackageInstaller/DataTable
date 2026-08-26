-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicFreeTrackView.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeTrackView", package.seeall)

local VersionActivity2_4MusicFreeTrackView = class("VersionActivity2_4MusicFreeTrackView", BaseView)

function VersionActivity2_4MusicFreeTrackView:onInitView()
	self._gotranscribelist = gohelper.findChild(self.viewGO, "root/left/scroll_transcribelist/viewport/#go_transcribe_list")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4MusicFreeTrackView:addEvents()
	return
end

function VersionActivity2_4MusicFreeTrackView:removeEvents()
	return
end

function VersionActivity2_4MusicFreeTrackView:_editableInitView()
	self:_initTrackList()
end

function VersionActivity2_4MusicFreeTrackView:_initTrackList()
	self._trackList = self:getUserDataTb_()

	local list = VersionActivity2_4MusicFreeModel.instance:getTrackList()

	for i, v in ipairs(list) do
		self:_addTrack(v)
	end

	self:_selectedTrackItem(1)
end

function VersionActivity2_4MusicFreeTrackView:_addTrack(mo)
	local index = mo.index
	local path = self.viewContainer:getSetting().otherRes[1]
	local childGO = self:getResInst(path, self._gotranscribelist, "track_" .. tostring(index))
	local item = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, VersionActivity2_4MusicFreeTrackItem)

	self._trackList[index] = item

	item:onUpdateMO(mo)
end

function VersionActivity2_4MusicFreeTrackView:onUpdateParam()
	return
end

function VersionActivity2_4MusicFreeTrackView:onOpen()
	self.addEventCb(self, VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.ClickTrackItem, self._onClickTrackItem, self)
	self.addEventCb(self, VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.UpdateTrackList, self._onUpdateTrackList, self)
	self.addEventCb(self, VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.ActionStatusChange, self._onActionStatusChange, self)
end

function VersionActivity2_4MusicFreeTrackView:_onActionStatusChange()
	self:_onUpdateTrackList()
end

function VersionActivity2_4MusicFreeTrackView:_onUpdateTrackList()
	local list = VersionActivity2_4MusicFreeModel.instance:getTrackList()

	for i, v in ipairs(self._trackList) do
		v:onUpdateMO(list[i])
	end
end

function VersionActivity2_4MusicFreeTrackView:_onClickTrackItem(index)
	self:_selectedTrackItem(index)
end

function VersionActivity2_4MusicFreeTrackView:_selectedTrackItem(index)
	VersionActivity2_4MusicFreeModel.instance:setSelectedTrackIndex(index)

	for k, v in pairs(self._trackList) do
		v:updateSelected()
	end
end

function VersionActivity2_4MusicFreeTrackView:onClose()
	return
end

function VersionActivity2_4MusicFreeTrackView:onDestroyView()
	return
end

return VersionActivity2_4MusicFreeTrackView
