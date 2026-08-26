-- chunkname: @modules/logic/battlepass/view/BpInformationView.lua

module("modules.logic.battlepass.view.BpInformationView", package.seeall)

local BpInformationView = class("BpInformationView", BaseView)

function BpInformationView:onInitView()
	self._gofirst = gohelper.findChild(self.viewGO, "content/scrollview/viewport/content/#go_first")
	self._txtfirst = gohelper.findChildText(self.viewGO, "content/scrollview/viewport/content/#go_first/bg/#txt_first")
	self._gocontent = gohelper.findChild(self.viewGO, "content/scrollview/viewport/content/#go_content")
	self._goconversation = gohelper.findChild(self.viewGO, "content/scrollview/viewport/content/#go_conversation")
	self._txtindenthelper = gohelper.findChildText(self.viewGO, "content/scrollview/viewport/content/#txt_indenthelper")
	self._gomask = gohelper.findChild(self.viewGO, "content/#go_mask")
	self._simagepic = gohelper.findChildSingleImage(self.viewGO, "content/#simage_pic")
	self._txttitle1 = gohelper.findChildText(self.viewGO, "content/#txt_title1")
	self._txttitle2 = gohelper.findChildText(self.viewGO, "content/#txt_title2")
	self._txttitleen1 = gohelper.findChildText(self.viewGO, "content/#txt_titleen1")
	self._txttitleen3 = gohelper.findChildText(self.viewGO, "content/#txt_titleen3")
	self._btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "content/pageicon/#btn_next")
	self._btnprevious = gohelper.findChildButtonWithAudio(self.viewGO, "content/pageicon/#btn_previous")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "content/scrollview")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function BpInformationView:addEvents()
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
	self._btnprevious:AddClickListener(self._btnpreviousOnClick, self)
	self._scrollview:AddOnValueChanged(self._onContentScrollValueChanged, self)
end

function BpInformationView:removeEvents()
	self._btnnext:RemoveClickListener()
	self._btnprevious:RemoveClickListener()
	self._scrollview:RemoveOnValueChanged()
end

function BpInformationView:_onContentScrollValueChanged(value)
	gohelper.setActive(self._gomask, self._couldScroll and gohelper.getRemindFourNumberFloat(self._scrollview.verticalNormalizedPosition) > 0)
end

function BpInformationView:_btnnextOnClick()
	return
end

function BpInformationView:_btnpreviousOnClick()
	return
end

function BpInformationView:_editableInitView()
	self._scrollcontent = gohelper.findChild(self._scrollview.gameObject, "viewport/content")

	ZProj.UGUIHelper.RebuildLayout(self._scrollcontent.transform)

	local contentHeight = recthelper.getHeight(self._scrollcontent.transform)

	self._scrollHeight = recthelper.getHeight(self._scrollview.transform)
	self._couldScroll = contentHeight > self._scrollHeight

	gohelper.setActive(self._gomask, self._couldScroll)
	self._simagepic:LoadImage(ResUrl.getBpBg("img_ziliao_juke"))
end

function BpInformationView:onUpdateParam()
	return
end

function BpInformationView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_culture_open)
end

function BpInformationView:onClose()
	return
end

function BpInformationView:onDestroyView()
	self._simagepic:UnLoadImage()
end

return BpInformationView
