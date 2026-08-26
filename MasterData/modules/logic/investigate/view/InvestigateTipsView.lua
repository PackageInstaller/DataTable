-- chunkname: @modules/logic/investigate/view/InvestigateTipsView.lua

module("modules.logic.investigate.view.InvestigateTipsView", package.seeall)

local InvestigateTipsView = class("InvestigateTipsView", BaseView)

function InvestigateTipsView:onInitView()
	self._simagewindowbg = gohelper.findChildSingleImage(self.viewGO, "root/#simage_windowbg")
	self._simagepic = gohelper.findChildSingleImage(self.viewGO, "root/#simage_pic")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_desc")
	self._txtdec = gohelper.findChildText(self.viewGO, "root/#scroll_desc/viewport/content/#txt_dec")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function InvestigateTipsView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function InvestigateTipsView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function InvestigateTipsView:_btncloseOnClick()
	self:closeThis()
end

function InvestigateTipsView:_editableInitView()
	return
end

function InvestigateTipsView:onUpdateParam()
	return
end

function InvestigateTipsView:onOpen()
	self._elementId = self.viewParam.elementId
	self._fragmentId = self.viewParam.fragmentId
	self._isRecheck = self.viewParam.isRecheck

	local config = lua_chapter_map_fragment.configDict[self._fragmentId]

	self._txtdec.text = config.content

	local clueInfo = InvestigateConfig.instance:getInvestigateClueInfoByElement(self._elementId)

	if clueInfo then
		self._simagepic:LoadImage(clueInfo.mapRes)
	end

	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, false)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Investigate.play_ui_molu_jlbn_open)
end

function InvestigateTipsView:onClose()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, true)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Investigate.play_ui_shuori_dreamsong_receive_open)
end

function InvestigateTipsView:onCloseFinish()
	if self._isRecheck then
		DungeonController.instance:onAgainOpenRecheckView(self._elementId)

		return
	end

	InvestigateController.instance:dispatchEvent(InvestigateEvent.ShowGetEffect)
end

function InvestigateTipsView:onDestroyView()
	return
end

return InvestigateTipsView
