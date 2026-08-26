-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicFreeCalibrationView.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeCalibrationView", package.seeall)

local VersionActivity2_4MusicFreeCalibrationView = class("VersionActivity2_4MusicFreeCalibrationView", BaseView)

function VersionActivity2_4MusicFreeCalibrationView:onInitView()
	self._gocalibrationlist = gohelper.findChild(self.viewGO, "root/#go_calibrationlist")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4MusicFreeCalibrationView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function VersionActivity2_4MusicFreeCalibrationView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function VersionActivity2_4MusicFreeCalibrationView:_btncloseOnClick()
	self:closeThis()
end

function VersionActivity2_4MusicFreeCalibrationView:onClickModalMask()
	self:closeThis()
end

function VersionActivity2_4MusicFreeCalibrationView:_editableInitView()
	self._itemList = self:getUserDataTb_()

	for i = 1, 3 do
		local item = self:_addItem(i)

		item:onUpdateMO(i)
	end
end

function VersionActivity2_4MusicFreeCalibrationView:_addItem(index)
	local path = self.viewContainer:getSetting().otherRes[1]
	local childGO = self:getResInst(path, self._gocalibrationlist)
	local item = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, VersionActivity2_4MusicFreeCalibrationItem)

	self._itemList[index] = item

	return item
end

function VersionActivity2_4MusicFreeCalibrationView:onUpdateParam()
	return
end

function VersionActivity2_4MusicFreeCalibrationView:onOpen()
	return
end

function VersionActivity2_4MusicFreeCalibrationView:onClose()
	return
end

function VersionActivity2_4MusicFreeCalibrationView:onDestroyView()
	return
end

return VersionActivity2_4MusicFreeCalibrationView
