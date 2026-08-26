-- chunkname: @modules/logic/versionactivity1_5/sportsnews/view/SportsNewsPaperView.lua

module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsPaperView", package.seeall)

local SportsNewsPaperView = class("SportsNewsPaperView", BaseView)

function SportsNewsPaperView:onInitView()
	self._txtcontent = gohelper.findChildText(self.viewGO, "#txt_content")
	self._btnstartbtn = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_startbtn")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SportsNewsPaperView:addEvents()
	self._btnstartbtn:AddClickListener(self._btnstartbtnOnClick, self)
end

function SportsNewsPaperView:removeEvents()
	self._btnstartbtn:RemoveClickListener()
end

function SportsNewsPaperView:_btnstartbtnOnClick()
	local actId = self.viewParam.actId
	local key = SportsNewsModel.instance:getFirstHelpKey(actId)

	PlayerPrefsHelper.setString(key, "watched")
	self:closeThis()
	HelpController.instance:showHelp(HelpEnum.HelpId.SportsNews)
end

function SportsNewsPaperView:_editableInitView()
	return
end

function SportsNewsPaperView:onUpdateParam()
	return
end

function SportsNewsPaperView:onOpen()
	return
end

function SportsNewsPaperView:onClose()
	return
end

function SportsNewsPaperView:onClickModalMask()
	self:closeThis()
end

function SportsNewsPaperView:onDestroyView()
	return
end

return SportsNewsPaperView
