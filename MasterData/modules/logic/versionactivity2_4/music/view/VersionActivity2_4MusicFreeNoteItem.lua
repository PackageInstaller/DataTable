-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicFreeNoteItem.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeNoteItem", package.seeall)

local VersionActivity2_4MusicFreeNoteItem = class("VersionActivity2_4MusicFreeNoteItem", ListScrollCellExtend)

function VersionActivity2_4MusicFreeNoteItem:onInitView()
	self._imagecir = gohelper.findChildImage(self.viewGO, "#image_cir")
	self._txtnum = gohelper.findChildText(self.viewGO, "#txt_num")
	self._goclick = gohelper.findChild(self.viewGO, "#go_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4MusicFreeNoteItem:addEvents()
	return
end

function VersionActivity2_4MusicFreeNoteItem:removeEvents()
	return
end

function VersionActivity2_4MusicFreeNoteItem:_editableInitView()
	self._clickEffect = gohelper.findChild(self.viewGO, "#click")

	MonoHelper.addNoUpdateLuaComOnceToGo(self._goclick, VersionActivity2_4MusicTouchComp, {
		callback = self._onClickDown,
		callbackTarget = self
	})
end

function VersionActivity2_4MusicFreeNoteItem:_onClickDown()
	local audioId = self._parentView:getNoteAudioId(self._index)

	if audioId == nil then
		return
	end

	AudioMgr.instance:trigger(audioId)
	gohelper.setActive(self._clickEffect, false)
	gohelper.setActive(self._clickEffect, true)

	if not VersionActivity2_4MusicFreeModel.instance:isRecording() then
		return
	end

	VersionActivity2_4MusicFreeModel.instance:addNote(audioId)
end

function VersionActivity2_4MusicFreeNoteItem:_editableAddEvents()
	return
end

function VersionActivity2_4MusicFreeNoteItem:_editableRemoveEvents()
	return
end

function VersionActivity2_4MusicFreeNoteItem:onUpdateMO(mo, parentView)
	self._index = mo
	self._parentView = parentView

	UISpriteSetMgr.instance:setMusicSprite(self._imagecir, "v2a4_bakaluoer_freenote_" .. VersionActivity2_4MusicEnum.NoteIcon[self._index])
end

function VersionActivity2_4MusicFreeNoteItem:onSelect(isSelect)
	return
end

function VersionActivity2_4MusicFreeNoteItem:onDestroyView()
	return
end

return VersionActivity2_4MusicFreeNoteItem
