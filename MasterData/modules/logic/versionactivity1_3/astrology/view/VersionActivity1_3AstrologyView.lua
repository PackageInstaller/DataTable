-- chunkname: @modules/logic/versionactivity1_3/astrology/view/VersionActivity1_3AstrologyView.lua

module("modules.logic.versionactivity1_3.astrology.view.VersionActivity1_3AstrologyView", package.seeall)

local VersionActivity1_3AstrologyView = class("VersionActivity1_3AstrologyView", BaseView)

function VersionActivity1_3AstrologyView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageFullBGCut = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBGCut")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "#simage_Title")
	self._goRight = gohelper.findChild(self.viewGO, "#go_Right")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")
	self._goplate = gohelper.findChild(self.viewGO, "#go_plate")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_3AstrologyView:addEvents()
	return
end

function VersionActivity1_3AstrologyView:removeEvents()
	return
end

function VersionActivity1_3AstrologyView:_editableInitView()
	self._simageFullBG:LoadImage(ResUrl.getV1a3AstrologySinglebg("v1a3_astrology_fullbg2"))
	VersionActivity1_3AstrologyModel.instance:initData()
end

function VersionActivity1_3AstrologyView:onUpdateParam()
	return
end

function VersionActivity1_3AstrologyView:onOpen()
	self:_updateResultBg()
	self.addEventCb(self, Activity126Controller.instance, Activity126Event.onUpdateProgressReply, self._onUpdateProgressReply, self, LuaEventSystem.High)
	self.addEventCb(self, VersionActivity1_3AstrologyController.instance, VersionActivity1_3AstrologyEvent.adjustPreviewAngle, self._adjustPreviewAngle, self)
	self.addEventCb(self, Activity126Controller.instance, Activity126Event.onResetProgressReply, self._onResetProgressReply, self)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_astrology_open)
end

function VersionActivity1_3AstrologyView:_onResetProgressReply()
	self:_updateResultBg()
end

function VersionActivity1_3AstrologyView:_adjustPreviewAngle()
	self:_updateResultBg()
end

function VersionActivity1_3AstrologyView:_updateResultBg()
	local resultId = VersionActivity1_3AstrologyModel.instance:getQuadrantResult()
	local resultConfig = Activity126Config.instance:getHoroscopeConfig(VersionActivity1_3Enum.ActivityId.Act310, resultId)

	if not resultConfig then
		return
	end

	self._simageFullBGCut:LoadImage(string.format("singlebg/v1a3_astrology_singlebg/%s.png", resultConfig.resultIcon))
end

function VersionActivity1_3AstrologyView:_onUpdateProgressReply()
	VersionActivity1_3AstrologyModel.instance:initData()
end

function VersionActivity1_3AstrologyView:onClose()
	self._simageFullBGCut:UnLoadImage()
end

function VersionActivity1_3AstrologyView:onDestroyView()
	self._simageFullBG:UnLoadImage()
end

return VersionActivity1_3AstrologyView
