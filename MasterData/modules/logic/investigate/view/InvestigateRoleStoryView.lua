-- chunkname: @modules/logic/investigate/view/InvestigateRoleStoryView.lua

module("modules.logic.investigate.view.InvestigateRoleStoryView", package.seeall)

local InvestigateRoleStoryView = class("InvestigateRoleStoryView", BaseView)

function InvestigateRoleStoryView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "root/#simage_fullbg")
	self._txttitle = gohelper.findChildText(self.viewGO, "root/#txt_title")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_desc")
	self._txtdec = gohelper.findChildText(self.viewGO, "root/#scroll_desc/viewport/content/#txt_dec")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function InvestigateRoleStoryView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function InvestigateRoleStoryView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function InvestigateRoleStoryView:_btncloseOnClick()
	self:closeThis()
end

function InvestigateRoleStoryView:_editableInitView()
	return
end

function InvestigateRoleStoryView:onUpdateParam()
	return
end

function InvestigateRoleStoryView:onOpen()
	self._id = self.viewParam
	self._config = lua_investigate_info.configDict[self._id]
	self._txttitle.text = self._config.desc
	self._txtdec.text = self._config.conclusionDesc

	self._simagefullbg:LoadImage(self._config.conclusionBg)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Investigate.play_ui_mln_unlock)
end

function InvestigateRoleStoryView:onClose()
	return
end

function InvestigateRoleStoryView:onDestroyView()
	return
end

return InvestigateRoleStoryView
