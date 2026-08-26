-- chunkname: @modules/logic/main/view/XRAnSkinInteractionView.lua

module("modules.logic.main.view.XRAnSkinInteractionView", package.seeall)

local XRAnSkinInteractionView = class("XRAnSkinInteractionView", BaseView)

function XRAnSkinInteractionView:onInitView()
	self._gocontentroot = gohelper.findChild(self.viewGO, "#go_contentroot")
	self._goconversation = gohelper.findChild(self.viewGO, "#go_contentroot/#go_conversation")
	self._gohead = gohelper.findChild(self.viewGO, "#go_contentroot/#go_conversation/#go_head")
	self._goheadgrey = gohelper.findChild(self.viewGO, "#go_contentroot/#go_conversation/#go_head/#go_headgrey")
	self._simagehead = gohelper.findChildSingleImage(self.viewGO, "#go_contentroot/#go_conversation/#go_head/#simage_head")
	self._goname = gohelper.findChild(self.viewGO, "#go_contentroot/#go_conversation/#go_name")
	self._txtnamecn = gohelper.findChildText(self.viewGO, "#go_contentroot/#go_conversation/#go_name/namelayout/#txt_namecn")
	self._txtnameen = gohelper.findChildText(self.viewGO, "#go_contentroot/#go_conversation/#go_name/namelayout/#txt_nameen")
	self._gocontents = gohelper.findChild(self.viewGO, "#go_contentroot/#go_conversation/#go_contents")
	self._txtcontent1 = gohelper.findChildText(self.viewGO, "#go_contentroot/#go_conversation/#go_contents/go_normalcontent/Viewport/#txt_content1")
	self._txtcontent2 = gohelper.findChildText(self.viewGO, "#go_contentroot/#go_conversation/#go_contents/go_normalcontent/Viewport/#txt_content2")
	self._goPoint = gohelper.findChild(self.viewGO, "#go_Point")
	self._btnpoint = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Point/#btn_point")
	self._goOptions = gohelper.findChild(self.viewGO, "#go_Options")
	self._btnoption1 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Options/#btn_option1")
	self._btnoption2 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Options/#btn_option2")
	self._goFeather = gohelper.findChild(self.viewGO, "#go_Feather")
	self._btncontent = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_content")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function XRAnSkinInteractionView:addEvents()
	self._btnpoint:AddClickListener(self._btnpointOnClick, self)
	self._btnoption1:AddClickListener(self._btnoption1OnClick, self)
	self._btnoption2:AddClickListener(self._btnoption2OnClick, self)
	self._btncontent:AddClickListener(self._btncontentOnClick, self)
end

function XRAnSkinInteractionView:removeEvents()
	self._btnpoint:RemoveClickListener()
	self._btnoption1:RemoveClickListener()
	self._btnoption2:RemoveClickListener()
	self._btncontent:RemoveClickListener()
end

function XRAnSkinInteractionView:_btnpointOnClick()
	return
end

function XRAnSkinInteractionView:_btnoption1OnClick()
	return
end

function XRAnSkinInteractionView:_btnoption2OnClick()
	return
end

function XRAnSkinInteractionView:_btncontentOnClick()
	return
end

function XRAnSkinInteractionView:_editableInitView()
	gohelper.setActive(self._goPoint, false)
	gohelper.setActive(self._goFeather, false)
	gohelper.setActive(self._goOptions, false)
end

function XRAnSkinInteractionView:onUpdateParam()
	return
end

function XRAnSkinInteractionView:onOpen()
	self.addEventCb(self, StoryController.instance, StoryEvent.Start, self._onStart, self)
end

function XRAnSkinInteractionView:_onStart()
	self:closeThis()
end

function XRAnSkinInteractionView:onClose()
	return
end

function XRAnSkinInteractionView:onDestroyView()
	return
end

return XRAnSkinInteractionView
