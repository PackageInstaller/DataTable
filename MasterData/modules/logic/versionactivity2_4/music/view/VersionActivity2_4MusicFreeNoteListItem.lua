-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicFreeNoteListItem.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeNoteListItem", package.seeall)

local VersionActivity2_4MusicFreeNoteListItem = class("VersionActivity2_4MusicFreeNoteListItem", ListScrollCellExtend)

function VersionActivity2_4MusicFreeNoteListItem:onInitView()
	self._btnchangebtn = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_changebtn")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#btn_changebtn/#image_icon")
	self._imagenullicon = gohelper.findChildImage(self.viewGO, "#btn_changebtn/#image_nullicon")
	self._txtname = gohelper.findChildText(self.viewGO, "#btn_changebtn/#txt_name")
	self._scrollmusiclist1 = gohelper.findChildScrollRect(self.viewGO, "#scroll_musiclist1")
	self._goimageFrame = gohelper.findChild(self.viewGO, "#scroll_musiclist1/viewport/#go_image_Frame")
	self._gocontent = gohelper.findChild(self.viewGO, "#scroll_musiclist1/viewport/#go_content")
	self._goempty = gohelper.findChild(self.viewGO, "#scroll_musiclist1/#go_empty")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4MusicFreeNoteListItem:addEvents()
	self._btnchangebtn:AddClickListener(self._btnchangebtnOnClick, self)
end

function VersionActivity2_4MusicFreeNoteListItem:removeEvents()
	self._btnchangebtn:RemoveClickListener()
end

function VersionActivity2_4MusicFreeNoteListItem:_btnchangebtnOnClick()
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicFreeInstrumentSetView()
end

function VersionActivity2_4MusicFreeNoteListItem:_editableInitView()
	return
end

function VersionActivity2_4MusicFreeNoteListItem:_editableAddEvents()
	return
end

function VersionActivity2_4MusicFreeNoteListItem:_editableRemoveEvents()
	return
end

function VersionActivity2_4MusicFreeNoteListItem:initNoteItemList(addNoteItem, noteView)
	self._addNoteItem = addNoteItem
	self._noteView = noteView

	for i = 1, 7 do
		local item = self._addNoteItem(self._noteView, self._gocontent)

		item:onUpdateMO(i, self)
	end
end

function VersionActivity2_4MusicFreeNoteListItem:onUpdateMO(instrumentId)
	self._instrumentId = instrumentId

	if self._instrumentId then
		self._instrumentConfig = lua_activity179_instrument.configDict[self._instrumentId] or nil
	end

	if self._instrumentConfig then
		self._txtname.text = self._instrumentConfig.name or luaLang("MusicFreeNoInstrument")
	end

	gohelper.setActive(self._gocontent, self._instrumentConfig ~= nil)
	gohelper.setActive(self._imageicon, self._instrumentConfig ~= nil)
	gohelper.setActive(self._goempty, self._instrumentConfig == nil)
	gohelper.setActive(self._goimageFrame, self._instrumentConfig ~= nil)
	gohelper.setActive(self._imagenullicon, self._instrumentConfig == nil)

	if self._instrumentConfig then
		UISpriteSetMgr.instance:setMusicSprite(self._imageicon, "v2a4_bakaluoer_freeinstrument_" .. self._instrumentConfig.icon)
	end
end

function VersionActivity2_4MusicFreeNoteListItem:getNoteAudioId(index)
	if self._instrumentId == 0 then
		return
	end

	local config = Activity179Config.instance:getNoteConfig(self._instrumentId, index)

	return config and config.resource
end

function VersionActivity2_4MusicFreeNoteListItem:onSelect(isSelect)
	return
end

function VersionActivity2_4MusicFreeNoteListItem:onDestroyView()
	return
end

return VersionActivity2_4MusicFreeNoteListItem
