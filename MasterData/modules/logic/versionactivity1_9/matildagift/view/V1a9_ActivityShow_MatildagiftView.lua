-- chunkname: @modules/logic/versionactivity1_9/matildagift/view/V1a9_ActivityShow_MatildagiftView.lua

module("modules.logic.versionactivity1_9.matildagift.view.V1a9_ActivityShow_MatildagiftView", package.seeall)

local V1a9_ActivityShow_MatildagiftView = class("V1a9_ActivityShow_MatildagiftView", BaseView)

function V1a9_ActivityShow_MatildagiftView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_PanelBG")
	self._simageEnvelope = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Envelope")
	self._simageRole = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Role")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Title")
	self._simageLOGO = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_LOGO")
	self._simagetxt = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_txt")
	self._simageName = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Name")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/LimitTime/#txt_LimitTime")
	self._btnGet = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_Get")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a9_ActivityShow_MatildagiftView:addEvents()
	self._btnGet:AddClickListener(self._btnGetOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self.onRefresh, self)
end

function V1a9_ActivityShow_MatildagiftView:removeEvents()
	self._btnGet:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self.onRefresh, self)
end

function V1a9_ActivityShow_MatildagiftView:_btnGetOnClick()
	V1a9_MatildaGiftModel.instance:onGetBonus()
end

function V1a9_ActivityShow_MatildagiftView:_btnCloseOnClick()
	self:closeThis()
end

function V1a9_ActivityShow_MatildagiftView:_editableInitView()
	self._imgGet = gohelper.findChild(self.viewGO, "Root/#btn_Get")
	self._txtGetCn = gohelper.findChildText(self.viewGO, "Root/#btn_Get/cn")
	self._txtGetEn = gohelper.findChildText(self.viewGO, "Root/#btn_Get/en")
	self._VXGetBtn = gohelper.findChild(self._imgGet, "vx_geteffect")
end

function V1a9_ActivityShow_MatildagiftView:onUpdateParam()
	return
end

function V1a9_ActivityShow_MatildagiftView:onOpen()
	local parentGO = self.viewParam.parent

	if parentGO then
		gohelper.addChild(parentGO, self.viewGO)
	end

	self:onRefresh()
	self:_refreshTimeTick()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
	AudioMgr.instance:trigger(AudioEnum.main_ui.play_ui_task_page)
end

function V1a9_ActivityShow_MatildagiftView:onClose()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function V1a9_ActivityShow_MatildagiftView:onDestroyView()
	return
end

function V1a9_ActivityShow_MatildagiftView:onRefresh()
	local couldGet = V1a9_MatildaGiftModel.instance:couldGet()
	local cntxt = couldGet and "v1a9_matildagiftview_claim_cn" or "v1a9_matildagiftview_claimed_cn"
	local entxt = couldGet and "v1a9_matildagiftview_claim_en" or "v1a9_matildagiftview_claimed_en"

	ZProj.UGUIHelper.SetGrayscale(self._imgGet, not couldGet)

	self._txtGetCn.text = luaLang(cntxt)
	self._txtGetEn.text = luaLang(entxt)

	gohelper.setActive(self._VXGetBtn, couldGet)
end

function V1a9_ActivityShow_MatildagiftView:_refreshTimeTick()
	local actId = V1a9_MatildaGiftModel.instance:getMatildagiftActId()

	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(actId)
end

return V1a9_ActivityShow_MatildagiftView
