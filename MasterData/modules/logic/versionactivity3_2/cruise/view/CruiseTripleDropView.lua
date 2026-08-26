-- chunkname: @modules/logic/versionactivity3_2/cruise/view/CruiseTripleDropView.lua

module("modules.logic.versionactivity3_2.cruise.view.CruiseTripleDropView", package.seeall)

local CruiseTripleDropView = class("CruiseTripleDropView", BaseView)

function CruiseTripleDropView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._txttime = gohelper.findChildText(self.viewGO, "root/go_time/go_deadline/#txt_time")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "root/go_desc/#scroll_desc")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/go_desc/#scroll_desc/Viewport/#txt_desc")
	self._gotip = gohelper.findChild(self.viewGO, "root/go_desc/#go_tip")
	self._txttipdesc = gohelper.findChildText(self.viewGO, "root/go_desc/#go_tip/#txt_tipdesc")
	self._txtexpcount = gohelper.findChildText(self.viewGO, "root/go_count/go_exp/#txt_expcount")
	self._txtcoincount = gohelper.findChildText(self.viewGO, "root/go_count/go_coin/#txt_coincount")
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_jump")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CruiseTripleDropView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
end

function CruiseTripleDropView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnjump:RemoveClickListener()
end

function CruiseTripleDropView:_addSelfEvents()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onCheckActState, self)
end

function CruiseTripleDropView:_removeSelfEvents()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onCheckActState, self)
end

function CruiseTripleDropView:_onCheckActState()
	local actId = VersionActivity3_2Enum.ActivityId.CruiseTripleDrop
	local status = ActivityHelper.getActivityStatus(actId)

	if status == ActivityEnum.ActivityStatus.Expired then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end
end

function CruiseTripleDropView:_btncloseOnClick()
	self:closeThis()
end

function CruiseTripleDropView:_btnjumpOnClick()
	self:closeThis()
	GameFacade.jump(JumpEnum.JumpView.BpView)
end

function CruiseTripleDropView:_editableInitView()
	self:_addSelfEvents()

	self._txttime.text = ""
end

function CruiseTripleDropView:onUpdateParam()
	return
end

function CruiseTripleDropView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_2.Cruise.play_ui_tangren_yuanxiao_open)
	RedDotRpc.instance:sendShowRedDotRequest(RedDotEnum.DotNode.CruiseTripleDropBtn, false)

	self._actId = VersionActivity3_2Enum.ActivityId.CruiseTripleDrop

	ActivityBeginnerController.instance:setFirstEnter(self._actId)

	self._config = ActivityConfig.instance:getActivityCo(self._actId)

	self:_refreshTimeTick()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
	self:_refresh()
end

function CruiseTripleDropView:_refreshTimeTick()
	self._txttime.text = ActivityModel.getRemainTimeStr(self._actId)
end

function CruiseTripleDropView:_refresh()
	local controlCos = Activity217Config.instance:getControlCos(self._actId)
	local limitExp = Activity217Model.instance:getExpEpisodeCount(self._actId)
	local limitCoin = Activity217Model.instance:getCoinEpisodeCount(self._actId)

	self._txtexpcount.text = string.format("%s/%s", limitExp, controlCos[Activity217Enum.ActType.MultiExp].limit)
	self._txtcoincount.text = string.format("%s/%s", limitCoin, controlCos[Activity217Enum.ActType.MultiCoin].limit)
end

function CruiseTripleDropView:onClose()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function CruiseTripleDropView:onDestroyView()
	self:_removeSelfEvents()
end

return CruiseTripleDropView
