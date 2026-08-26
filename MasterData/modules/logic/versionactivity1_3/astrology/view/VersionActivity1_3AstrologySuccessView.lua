-- chunkname: @modules/logic/versionactivity1_3/astrology/view/VersionActivity1_3AstrologySuccessView.lua

module("modules.logic.versionactivity1_3.astrology.view.VersionActivity1_3AstrologySuccessView", package.seeall)

local VersionActivity1_3AstrologySuccessView = class("VersionActivity1_3AstrologySuccessView", BaseView)

function VersionActivity1_3AstrologySuccessView:onInitView()
	self._goSuccess = gohelper.findChild(self.viewGO, "#go_Success")
	self._simageSuccessBG = gohelper.findChildSingleImage(self.viewGO, "#go_Success/#simage_SuccessBG")
	self._simageSuccessCircleDec = gohelper.findChildSingleImage(self.viewGO, "#go_Success/#simage_SuccessCircleDec")
	self._simageSuccessTitle = gohelper.findChildSingleImage(self.viewGO, "#go_Success/#simage_SuccessTitle")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_3AstrologySuccessView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function VersionActivity1_3AstrologySuccessView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function VersionActivity1_3AstrologySuccessView:_btncloseOnClick()
	self:closeThis()
end

function VersionActivity1_3AstrologySuccessView:_editableInitView()
	self._simageSuccessBG:LoadImage(ResUrl.getV1a3AstrologySinglebg("v1a3_astrology_successtitlebg"))
	TaskDispatcher.cancelTask(self._onAminDone, self)
	TaskDispatcher.runDelay(self._onAminDone, self, 3.5)
end

function VersionActivity1_3AstrologySuccessView:_onAminDone()
	self:closeThis()
end

function VersionActivity1_3AstrologySuccessView:onUpdateParam()
	return
end

function VersionActivity1_3AstrologySuccessView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_astrology_success)
end

function VersionActivity1_3AstrologySuccessView:onClose()
	TaskDispatcher.cancelTask(self._onAminDone, self)
end

function VersionActivity1_3AstrologySuccessView:onDestroyView()
	self._simageSuccessBG:UnLoadImage()
end

return VersionActivity1_3AstrologySuccessView
