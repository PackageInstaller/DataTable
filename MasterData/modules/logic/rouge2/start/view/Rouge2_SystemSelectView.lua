-- chunkname: @modules/logic/rouge2/start/view/Rouge2_SystemSelectView.lua

module("modules.logic.rouge2.start.view.Rouge2_SystemSelectView", package.seeall)

local Rouge2_SystemSelectView = class("Rouge2_SystemSelectView", BaseView)

function Rouge2_SystemSelectView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#btn_Close")
	self._goTeamTips = gohelper.findChild(self.viewGO, "#go_Root/#go_TeamTips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_SystemSelectView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function Rouge2_SystemSelectView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function Rouge2_SystemSelectView:_btnCloseOnClick()
	self:closeThis()
end

function Rouge2_SystemSelectView:_editableInitView()
	NavigateMgr.instance:addEscape(self.viewName, self.closeThis, self)

	self._teamTipsLoader = Rouge2_TeamRecommendTipsLoader.Load(self._goTeamTips, Rouge2_Enum.TeamRecommendTipType.System)
end

function Rouge2_SystemSelectView:onOpen()
	self._careerId = self.viewParam and self.viewParam.careerId
	self._careerId = self._careerId or Rouge2_Model.instance:getCareerId()

	self._teamTipsLoader:initInfo(self._careerId)
	Rouge2_SystemSelectListModel.instance:init(self._careerId)
end

function Rouge2_SystemSelectView:onClose()
	return
end

function Rouge2_SystemSelectView:onDestroyView()
	return
end

return Rouge2_SystemSelectView
