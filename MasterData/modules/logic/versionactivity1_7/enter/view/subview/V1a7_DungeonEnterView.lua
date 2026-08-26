-- chunkname: @modules/logic/versionactivity1_7/enter/view/subview/V1a7_DungeonEnterView.lua

module("modules.logic.versionactivity1_7.enter.view.subview.V1a7_DungeonEnterView", package.seeall)

local V1a7_DungeonEnterView = class("V1a7_DungeonEnterView", BaseView)

function V1a7_DungeonEnterView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "logo/#simage_title")
	self._txtdesc = gohelper.findChildText(self.viewGO, "logo/#txt_dec")
	self._gotime = gohelper.findChild(self.viewGO, "logo/timebg")
	self._txttime = gohelper.findChildText(self.viewGO, "logo/timebg/#txt_time")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_enter")
	self._btnFinish = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_Finished")
	self._btnStore = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_store")
	self._btnTask = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_task")
	self._goTaskRedDot = gohelper.findChild(self.viewGO, "entrance/#btn_task/#go_reddot")
	self._txtStoreNum = gohelper.findChildText(self.viewGO, "entrance/#btn_store/normal/#txt_num")
	self._txtStoreTime = gohelper.findChildText(self.viewGO, "entrance/#btn_store/#go_time/#txt_time")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a7_DungeonEnterView:addEvents()
	self._btnStore:AddClickListener(self.onClickStoreBtn, self)
	self._btnEnter:AddClickListener(self.onClickMainActivity, self)
	self._btnTask:AddClickListener(self.onClickTaskBtn, self)
end

function V1a7_DungeonEnterView:removeEvents()
	self._btnStore:RemoveClickListener()
	self._btnEnter:RemoveClickListener()
	self._btnTask:RemoveClickListener()
end

function V1a7_DungeonEnterView:onClickStoreBtn()
	VersionActivity1_7DungeonController.instance:openStoreView()
end

function V1a7_DungeonEnterView:onClickMainActivity()
	VersionActivity1_7DungeonController.instance:openVersionActivityDungeonMapView()
end

function V1a7_DungeonEnterView:onClickTaskBtn()
	VersionActivity1_7DungeonController.instance:openTaskView()
end

function V1a7_DungeonEnterView:_editableInitView()
	self._simagebg:LoadImage("singlebg/v1a7_mainactivity_singlebg/v1a7_enterview_fullbg.png")
	self._simagetitle:LoadImage("singlebg_lang/txt_v1a7_mainactivity_singlebg/v1a7_enterview_title.png")

	self.goEnter = self._btnEnter.gameObject
	self.goFinish = self._btnFinish.gameObject
	self.actId = VersionActivity1_7Enum.ActivityId.Dungeon
	self.actCo = ActivityConfig.instance:getActivityCo(self.actId)
	self.goTaskBg = gohelper.findChild(self.viewGO, "entrance/#btn_task/normal/bg")
	self.goTaskIcon = gohelper.findChild(self.viewGO, "entrance/#btn_task/normal/icon")
	self.goTaskTxt = gohelper.findChild(self.viewGO, "entrance/#btn_task/normal/txt_shop")
	self.animComp = VersionActivitySubAnimatorComp.get(self.viewGO, self)

	RedDotController.instance:addRedDot(self._goTaskRedDot, RedDotEnum.DotNode.V1a7DungeonTask)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshStoreCurrency, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
end

function V1a7_DungeonEnterView:onRefreshActivity(actId)
	if actId ~= self.actId then
		return
	end

	self:refreshBtnStatus()
end

function V1a7_DungeonEnterView:onOpen()
	self:refreshUI()
	self.animComp:playOpenAnim()
	TaskDispatcher.runRepeat(self.everyMinuteCall, self, TimeUtil.OneMinuteSecond)
end

function V1a7_DungeonEnterView:onUpdateParam()
	self:refreshUI()
end

function V1a7_DungeonEnterView:refreshUI()
	self._txtdesc.text = self.actCo.actDesc

	self:refreshBtnStatus()
	self:refreshRemainTime()
	self:refreshStoreCurrency()
end

function V1a7_DungeonEnterView:refreshBtnStatus()
	local status = ActivityHelper.getActivityStatus(self.actId)
	local isNormal = status == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(self.goEnter, isNormal)
	gohelper.setActive(self.goFinish, not isNormal)
	ZProj.UGUIHelper.SetGrayscale(self.goTaskBg, not isNormal)
	ZProj.UGUIHelper.SetGrayscale(self.goTaskIcon, not isNormal)
	ZProj.UGUIHelper.SetGrayscale(self.goTaskTxt, not isNormal)
	gohelper.setActive(self._goTaskRedDot, isNormal)

	local isExpired = status == ActivityEnum.ActivityStatus.Expired

	gohelper.setActive(self._btnTask, not isExpired)
	gohelper.setActive(self._gotime, not isExpired)
end

function V1a7_DungeonEnterView:everyMinuteCall()
	self:refreshRemainTime()
end

function V1a7_DungeonEnterView:refreshStoreCurrency()
	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a7Dungeon)

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self._txtStoreNum.text = GameUtil.numberDisplay(quantity)
		end
	end
end

function V1a7_DungeonEnterView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	self._txttime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
	actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity1_7Enum.ActivityId.DungeonStore]
	self._txtStoreTime.text = actInfoMo:getRemainTimeStr2ByEndTime(true)
end

function V1a7_DungeonEnterView:onClose()
	TaskDispatcher.cancelTask(self.everyMinuteCall, self)
end

function V1a7_DungeonEnterView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagetitle:UnLoadImage()
	self.animComp:destroy()
end

return V1a7_DungeonEnterView
