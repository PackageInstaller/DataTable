-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicFreeImmerseView.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeImmerseView", package.seeall)

local VersionActivity2_4MusicFreeImmerseView = class("VersionActivity2_4MusicFreeImmerseView", BaseView)

function VersionActivity2_4MusicFreeImmerseView:onInitView()
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4MusicFreeImmerseView:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function VersionActivity2_4MusicFreeImmerseView:removeEvents()
	self._btnclick:RemoveClickListener()
end

function VersionActivity2_4MusicFreeImmerseView:_btnclickOnClick()
	self:closeThis()
end

function VersionActivity2_4MusicFreeImmerseView:_editableInitView()
	return
end

function VersionActivity2_4MusicFreeImmerseView:onUpdateParam()
	return
end

function VersionActivity2_4MusicFreeImmerseView:onOpen()
	return
end

function VersionActivity2_4MusicFreeImmerseView:onClose()
	return
end

function VersionActivity2_4MusicFreeImmerseView:onDestroyView()
	return
end

return VersionActivity2_4MusicFreeImmerseView
