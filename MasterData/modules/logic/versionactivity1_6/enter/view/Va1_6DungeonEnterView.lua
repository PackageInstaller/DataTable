-- chunkname: @modules/logic/versionactivity1_6/enter/view/Va1_6DungeonEnterView.lua

module("modules.logic.versionactivity1_6.enter.view.Va1_6DungeonEnterView", package.seeall)

local Va1_6DungeonEnterView = class("Va1_6DungeonEnterView", VersionActivityEnterBaseSubView)
local bgSpineFolderName = "v1a6_srsj"
local bgSpineName = "srsj"

function Va1_6DungeonEnterView:onInitView()
	self._btnstore = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_store")
	self._txtStoreRemainTime = gohelper.findChildText(self.viewGO, "entrance/#btn_store/#go_time/#txt_time")
	self._txtStoreNum = gohelper.findChildText(self.viewGO, "entrance/#btn_store/normal/#txt_num")
	self._txttime = gohelper.findChildText(self.viewGO, "logo/#txt_time")
	self._txtdec = gohelper.findChildText(self.viewGO, "logo/#txt_dec")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_enter")
	self._goEnterNormal = gohelper.findChild(self.viewGO, "entrance/#btn_enter/normal")
	self._goEnterLocked = gohelper.findChild(self.viewGO, "entrance/#btn_enter/locked")
	self._goEnterFinished = gohelper.findChild(self.viewGO, "entrance/#btn_enter/finished")
	self._gospine = gohelper.findChild(self.viewGO, "#go_spine")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Va1_6DungeonEnterView:addEvents()
	self._btnstore:AddClickListener(self._onClickStoreBtn, self)
	self._btnEnter:AddClickListener(self._onClickMainActivity, self)
end

function Va1_6DungeonEnterView:removeEvents()
	self._btnstore:RemoveClickListener()
	self._btnEnter:RemoveClickListener()
end

function Va1_6DungeonEnterView:_editableInitView()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.refreshUI, self)
	self.addEventCb(self, VersionActivity1_6EnterController.instance, VersionActivity1_6EnterEvent.OnEnterVideoFinished, self.onEnterVideoFinished, self)

	self.goRedDot = gohelper.findChild(self.viewGO, "entrance/#btn_enter/normal/#go_reddot")

	RedDotController.instance:addRedDot(self.goRedDot, RedDotEnum.DotNode.V1a6DungeonEnterBtn)

	self._uiSpine = GuiSpine.Create(self._gospine, true)
	self.actId = VersionActivity1_6Enum.ActivityId.Dungeon

	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshStoreCurrency, self)
end

function Va1_6DungeonEnterView:onOpen()
	Va1_6DungeonEnterView.super.onOpen(self)
	self:refreshRemainTime()
	self:_refreshStoreCurrency()
	self:_initBgSpine()
	self:refreshDesc()
	self:refreshEnterState()
	self:refreshStoreRemainTime()
end

function Va1_6DungeonEnterView:onClose()
	Va1_6DungeonEnterView.super.onClose(self)
end

function Va1_6DungeonEnterView:onUpdateParam()
	self:_refreshStoreCurrency()
	self:refreshRemainTime()
	self:refreshEnterState()
	self:refreshStoreRemainTime()
end

function Va1_6DungeonEnterView:onDestroyView()
	if self._uiSpine then
		self._uiSpine = nil
	end
end

function Va1_6DungeonEnterView:refreshUI()
	self:refreshRemainTime()
	self:refreshEnterState()
	self:refreshStoreRemainTime()
end

function Va1_6DungeonEnterView:refreshDesc()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]

	self._txtdec.text = actInfoMo.config.actDesc
end

function Va1_6DungeonEnterView:refreshEnterState()
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(self.actId)
	local storeStatus = ActivityHelper.getActivityStatusAndToast(VersionActivity1_6Enum.ActivityId.DungeonStore)

	gohelper.setActive(self._goEnterLocked, false)
	gohelper.setActive(self._goEnterNormal, status == ActivityEnum.ActivityStatus.Normal)
	gohelper.setActive(self._goEnterFinished, status == ActivityEnum.ActivityStatus.Expired)
	gohelper.setActive(self._btnstore.gameObject, storeStatus == ActivityEnum.ActivityStatus.Normal)
end

function Va1_6DungeonEnterView:everySecondCall()
	self:refreshUI()
end

function Va1_6DungeonEnterView:_initBgSpine()
	local spineName = bgSpineName
	local resPath = ResUrl.getRolesCgStory(spineName, bgSpineFolderName)

	self._uiSpine:setResPath(resPath, self._onSpineLoaded, self)
end

function Va1_6DungeonEnterView:_onSpineLoaded()
	return
end

function Va1_6DungeonEnterView:_refreshStoreCurrency()
	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a6Dungeon)

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self._txtStoreNum.text = GameUtil.numberDisplay(quantity)
		end
	end
end

function Va1_6DungeonEnterView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	gohelper.setActive(self._txttime, offsetSecond > 0)

	self._txttime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
end

function Va1_6DungeonEnterView:refreshStoreRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity1_6Enum.ActivityId.DungeonStore]
	local endTime = actInfoMo:getRealEndTimeStamp()
	local offsetSecond = endTime - ServerTime.now()

	if offsetSecond > TimeUtil.OneDaySecond then
		local day = Mathf.Floor(offsetSecond / TimeUtil.OneDaySecond)

		self._txtStoreRemainTime.text = day .. "d"

		return
	end

	if offsetSecond > TimeUtil.OneHourSecond then
		local hour = Mathf.Floor(offsetSecond / TimeUtil.OneHourSecond)

		self._txtStoreRemainTime.text = hour .. "h"

		return
	end

	self._txtStoreRemainTime.text = "1h"
end

function Va1_6DungeonEnterView:_onClickMainActivity()
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(self.actId)

	if status ~= ActivityEnum.ActivityStatus.Normal and toastId then
		GameFacade.showToastWithTableParam(toastId, paramList)

		return
	end

	VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView()
end

function Va1_6DungeonEnterView:_onClickStoreBtn()
	VersionActivity1_6EnterController.instance:openStoreView()
end

return Va1_6DungeonEnterView
