-- chunkname: @modules/logic/activity/view/V2a2_RedLeafFestival_PanelView.lua

module("modules.logic.activity.view.V2a2_RedLeafFestival_PanelView", package.seeall)

local V2a2_RedLeafFestival_PanelView = class("V2a2_RedLeafFestival_PanelView", Activity101SignViewBase)

function V2a2_RedLeafFestival_PanelView:onInitView()
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_PanelBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/image_LimitTimeBG/#txt_LimitTime")
	self._txtDec = gohelper.findChildText(self.viewGO, "Root/image_DecBG/#txt_Dec")
	self._goNormalBG = gohelper.findChild(self.viewGO, "Root/Task/#go_NormalBG")
	self._txtdec = gohelper.findChildText(self.viewGO, "Root/Task/#go_NormalBG/scroll_desc/Viewport/Content/#txt_dec")
	self._txtnum = gohelper.findChildText(self.viewGO, "Root/Task/#go_NormalBG/#txt_num")
	self._simagereward = gohelper.findChildSingleImage(self.viewGO, "Root/Task/#go_NormalBG/#simage_reward")
	self._gocanget = gohelper.findChild(self.viewGO, "Root/Task/#go_canget")
	self._goFinishedBG = gohelper.findChild(self.viewGO, "Root/Task/#go_FinishedBG")
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

function V2a2_RedLeafFestival_PanelView:addEvents()
	Activity101SignViewBase.addEvents(self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnemptyTop:AddClickListener(self._btnemptyTopOnClick, self)
	self._btnemptyBottom:AddClickListener(self._btnemptyBottomOnClick, self)
	self._btnemptyLeft:AddClickListener(self._btnemptyLeftOnClick, self)
	self._btnemptyRight:AddClickListener(self._btnemptyRightOnClick, self)
end

function V2a2_RedLeafFestival_PanelView:removeEvents()
	Activity101SignViewBase.removeEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnemptyTop:RemoveClickListener()
	self._btnemptyBottom:RemoveClickListener()
	self._btnemptyLeft:RemoveClickListener()
	self._btnemptyRight:RemoveClickListener()
end

function V2a2_RedLeafFestival_PanelView:_btnCloseOnClick()
	self:closeThis()
end

function V2a2_RedLeafFestival_PanelView:_btnemptyTopOnClick()
	self:closeThis()
end

function V2a2_RedLeafFestival_PanelView:_btnemptyBottomOnClick()
	self:closeThis()
end

function V2a2_RedLeafFestival_PanelView:_btnemptyLeftOnClick()
	self:closeThis()
end

function V2a2_RedLeafFestival_PanelView:_btnemptyRightOnClick()
	self:closeThis()
end

function V2a2_RedLeafFestival_PanelView:_editableInitView()
	self._txtLimitTime.text = ""

	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
end

function V2a2_RedLeafFestival_PanelView:onOpen()
	self:internal_set_actId(self.viewParam.actId)
	self:internal_onOpen()
	self:_clearTimeTick()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
end

function V2a2_RedLeafFestival_PanelView:onClose()
	self:_clearTimeTick()
end

function V2a2_RedLeafFestival_PanelView:onDestroyView()
	Activity101SignViewBase._internal_onDestroy(self)
	self:_clearTimeTick()
end

function V2a2_RedLeafFestival_PanelView:_clearTimeTick()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function V2a2_RedLeafFestival_PanelView:onRefresh()
	self:_refreshList()
	self:_refreshTimeTick()
end

function V2a2_RedLeafFestival_PanelView:_refreshTimeTick()
	self._txtLimitTime.text = self:getRemainTimeStr()
end

return V2a2_RedLeafFestival_PanelView
