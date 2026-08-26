-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicFreeInstrumentSetView.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeInstrumentSetView", package.seeall)

local VersionActivity2_4MusicFreeInstrumentSetView = class("VersionActivity2_4MusicFreeInstrumentSetView", BaseView)

function VersionActivity2_4MusicFreeInstrumentSetView:onInitView()
	self._txtinfo = gohelper.findChildText(self.viewGO, "root/#txt_info")
	self._goinstrument = gohelper.findChild(self.viewGO, "root/#go_instrument")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4MusicFreeInstrumentSetView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function VersionActivity2_4MusicFreeInstrumentSetView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function VersionActivity2_4MusicFreeInstrumentSetView:_btncloseOnClick()
	self:closeThis()
end

function VersionActivity2_4MusicFreeInstrumentSetView:onClickModalMask()
	self:closeThis()
end

function VersionActivity2_4MusicFreeInstrumentSetView:_editableInitView()
	self._indexList = tabletool.copy(VersionActivity2_4MusicFreeModel.instance:getInstrumentIndexList())

	self:_initItem()
	self:_updateItems()
end

function VersionActivity2_4MusicFreeInstrumentSetView:_initItem()
	self._itemList = self:getUserDataTb_()

	local list = Activity179Config.instance:getInstrumentSwitchList()

	for i, v in ipairs(list) do
		local path = self.viewContainer:getSetting().otherRes[1]
		local childGO = self:getResInst(path, self._goinstrument)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, VersionActivity2_4MusicFreeInstrumentSetItem)

		self._itemList[i] = item

		item:onUpdateMO(v, self)
	end
end

function VersionActivity2_4MusicFreeInstrumentSetView:_updateItems()
	for i, v in ipairs(self._itemList) do
		v:updateIndex()
	end

	local num = self:_getSelectedNum()
	local numStr = string.format("<color=#C66030>%s</color>/%s", num, 2)

	self._txtinfo.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("MusicInstrumentsSelectedTips"), numStr)
	self._hasSelectedChange = true
end

function VersionActivity2_4MusicFreeInstrumentSetView:addInstrument(id)
	if self:_getSelectedNum() >= VersionActivity2_4MusicEnum.SelectInstrumentNum then
		return
	end

	local index = tabletool.indexOf(self._indexList, 0)

	self._indexList[index] = id

	self:_updateItems()
end

function VersionActivity2_4MusicFreeInstrumentSetView:removeInstrument(id)
	local index = tabletool.indexOf(self._indexList, id)

	if index then
		self._indexList[index] = 0

		self:_updateItems()
	end
end

function VersionActivity2_4MusicFreeInstrumentSetView:_getSelectedNum()
	local num = 0

	for i, v in ipairs(self._indexList) do
		if v ~= 0 then
			num = num + 1
		end
	end

	return num
end

function VersionActivity2_4MusicFreeInstrumentSetView:onOpen()
	return
end

function VersionActivity2_4MusicFreeInstrumentSetView:onClose()
	if not self._hasSelectedChange then
		return
	end

	VersionActivity2_4MusicFreeModel.instance:setInstrumentIndexList(self._indexList)
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.InstrumentSelectChange)
end

function VersionActivity2_4MusicFreeInstrumentSetView:onDestroyView()
	return
end

return VersionActivity2_4MusicFreeInstrumentSetView
