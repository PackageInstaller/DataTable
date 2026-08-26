-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicFreeNoteView.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeNoteView", package.seeall)

local VersionActivity2_4MusicFreeNoteView = class("VersionActivity2_4MusicFreeNoteView", BaseView)

function VersionActivity2_4MusicFreeNoteView:onInitView()
	self._gomusic1 = gohelper.findChild(self.viewGO, "root/right/#go_music1")
	self._gomusic2 = gohelper.findChild(self.viewGO, "root/right/#go_music2")
	self._goinstruments = gohelper.findChild(self.viewGO, "root/right/bottom/#go_instruments")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4MusicFreeNoteView:addEvents()
	return
end

function VersionActivity2_4MusicFreeNoteView:removeEvents()
	return
end

function VersionActivity2_4MusicFreeNoteView:_editableInitView()
	return
end

function VersionActivity2_4MusicFreeNoteView:_initNoteList()
	self._noteList = self:getUserDataTb_()

	for i = 1, 2 do
		self:_addNoteListItem(i)
	end

	self:_updateNoteListItem()
end

function VersionActivity2_4MusicFreeNoteView:_addNoteListItem(index)
	local path = self.viewContainer:getSetting().otherRes[2]
	local childGO = self:getResInst(path, self["_gomusic" .. index], "note_" .. tostring(index))
	local item = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, VersionActivity2_4MusicFreeNoteListItem)

	table.insert(self._noteList, index, item)
	item:initNoteItemList(self._addNoteItem, self)
end

function VersionActivity2_4MusicFreeNoteView:_updateNoteListItem()
	local list = VersionActivity2_4MusicFreeModel.instance:getInstrumentIndexList()

	for i, v in ipairs(self._noteList) do
		v:onUpdateMO(list[i])
	end
end

function VersionActivity2_4MusicFreeNoteView:_addNoteItem(go)
	local path = self.viewContainer:getSetting().otherRes[3]
	local childGO = self:getResInst(path, go)

	return (MonoHelper.addNoUpdateLuaComOnceToGo(childGO, VersionActivity2_4MusicFreeNoteItem))
end

function VersionActivity2_4MusicFreeNoteView:_initInstruments()
	self._instrumentList = self:getUserDataTb_()

	local list = Activity179Config.instance:getInstrumentNoSwitchList()

	for i, v in ipairs(list) do
		local item = self:_addInstrumentItem(i)

		item:onUpdateMO(v)
	end
end

function VersionActivity2_4MusicFreeNoteView:_addInstrumentItem(index)
	local path = self.viewContainer:getSetting().otherRes[4]
	local childGO = self:getResInst(path, self._goinstruments, "instrument_" .. tostring(index))
	local item = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, VersionActivity2_4MusicFreeInstrumentItem)

	table.insert(self._instrumentList, index, item)

	return item
end

function VersionActivity2_4MusicFreeNoteView:onUpdateParam()
	return
end

function VersionActivity2_4MusicFreeNoteView:onOpen()
	self.addEventCb(self, VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.InstrumentSelectChange, self._onInstrumentSelectChange, self)
	self:_initNoteList()
	self:_initInstruments()
end

function VersionActivity2_4MusicFreeNoteView:_onInstrumentSelectChange()
	self:_updateNoteListItem()
end

function VersionActivity2_4MusicFreeNoteView:onClose()
	return
end

function VersionActivity2_4MusicFreeNoteView:onDestroyView()
	return
end

return VersionActivity2_4MusicFreeNoteView
