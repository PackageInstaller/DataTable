-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicFreeInstrumentItem.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeInstrumentItem", package.seeall)

local VersionActivity2_4MusicFreeInstrumentItem = class("VersionActivity2_4MusicFreeInstrumentItem", ListScrollCellExtend)

function VersionActivity2_4MusicFreeInstrumentItem:onInitView()
	self._imageicon = gohelper.findChildImage(self.viewGO, "#image_icon")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._imagecir = gohelper.findChildImage(self.viewGO, "#image_cir")
	self._goclick = gohelper.findChild(self.viewGO, "#go_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4MusicFreeInstrumentItem:addEvents()
	return
end

function VersionActivity2_4MusicFreeInstrumentItem:removeEvents()
	return
end

function VersionActivity2_4MusicFreeInstrumentItem:_editableInitView()
	self._clickEffect = gohelper.findChild(self.viewGO, "#click")

	MonoHelper.addNoUpdateLuaComOnceToGo(self._goclick, VersionActivity2_4MusicTouchComp, {
		callback = self._onClickDown,
		callbackTarget = self
	})
end

function VersionActivity2_4MusicFreeInstrumentItem:_onClickDown()
	local audioId = self:getNoteAudioId(1)

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

function VersionActivity2_4MusicFreeInstrumentItem:getNoteAudioId(index)
	local config = Activity179Config.instance:getNoteConfig(self._mo.id, index)

	return config and config.resource
end

function VersionActivity2_4MusicFreeInstrumentItem:_editableAddEvents()
	return
end

function VersionActivity2_4MusicFreeInstrumentItem:_editableRemoveEvents()
	return
end

function VersionActivity2_4MusicFreeInstrumentItem:onUpdateMO(mo)
	self._mo = mo
	self._txtname.text = mo.name

	UISpriteSetMgr.instance:setMusicSprite(self._imagecir, "v2a4_bakaluoer_freeinstrument_dianji_" .. mo.icon)
	UISpriteSetMgr.instance:setMusicSprite(self._imageicon, "v2a4_bakaluoer_freeinstrument_" .. mo.icon)
end

function VersionActivity2_4MusicFreeInstrumentItem:onSelect(isSelect)
	return
end

function VersionActivity2_4MusicFreeInstrumentItem:onDestroyView()
	return
end

return VersionActivity2_4MusicFreeInstrumentItem
