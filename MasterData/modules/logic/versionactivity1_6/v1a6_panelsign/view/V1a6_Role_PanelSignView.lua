-- chunkname: @modules/logic/versionactivity1_6/v1a6_panelsign/view/V1a6_Role_PanelSignView.lua

module("modules.logic.versionactivity1_6.v1a6_panelsign.view.V1a6_Role_PanelSignView", package.seeall)

local V1a6_Role_PanelSignView = class("V1a6_Role_PanelSignView", Activity101SignViewBase)

function V1a6_Role_PanelSignView:onInitView()
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_PanelBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/image_LimitTimeBG/#txt_LimitTime")
	self._scrollItemList = gohelper.findChildScrollRect(self.viewGO, "Root/#scroll_ItemList")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_Close")
	self._btnemptyTop = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyTop")
	self._btnemptyBottom = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyBottom")
	self._btnemptyLeft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyLeft")
	self._btnemptyRight = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyRight")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_Role_PanelSignView:addEvents()
	Activity101SignViewBase.addEvents(self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnemptyTop:AddClickListener(self._btnemptyTopOnClick, self)
	self._btnemptyBottom:AddClickListener(self._btnemptyBottomOnClick, self)
	self._btnemptyLeft:AddClickListener(self._btnemptyLeftOnClick, self)
	self._btnemptyRight:AddClickListener(self._btnemptyRightOnClick, self)
end

function V1a6_Role_PanelSignView:removeEvents()
	Activity101SignViewBase.removeEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnemptyTop:RemoveClickListener()
	self._btnemptyBottom:RemoveClickListener()
	self._btnemptyLeft:RemoveClickListener()
	self._btnemptyRight:RemoveClickListener()
end

function V1a6_Role_PanelSignView:_btnCloseOnClick()
	self:closeThis()
end

function V1a6_Role_PanelSignView:_btnemptyTopOnClick()
	self:closeThis()
end

function V1a6_Role_PanelSignView:_btnemptyBottomOnClick()
	self:closeThis()
end

function V1a6_Role_PanelSignView:_btnemptyLeftOnClick()
	self:closeThis()
end

function V1a6_Role_PanelSignView:_btnemptyRightOnClick()
	self:closeThis()
end

function V1a6_Role_PanelSignView:onOpen()
	self._txtLimitTime.text = ""
	self._viewAni = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._viewAni.enabled = true

	self:internal_set_actId(self.viewParam.actId)
	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
	self:internal_onOpen()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
end

function V1a6_Role_PanelSignView:onClose()
	self._viewAni.enabled = false

	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function V1a6_Role_PanelSignView:onDestroyView()
	Activity101SignViewBase._internal_onDestroy(self)
	self._simageTitle:UnLoadImage()
	self._simagePanelBG:UnLoadImage()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function V1a6_Role_PanelSignView:onRefresh()
	self:_refreshList()
	self:_refreshTimeTick()
end

function V1a6_Role_PanelSignView:_refreshTimeTick()
	self._txtLimitTime.text = self:getRemainTimeStr()
end

return V1a6_Role_PanelSignView
