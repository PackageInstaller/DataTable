-- chunkname: @modules/logic/room/view/critter/summon/RoomCritterSummonView.lua

module("modules.logic.room.view.critter.summon.RoomCritterSummonView", package.seeall)

local RoomCritterSummonView = class("RoomCritterSummonView", BaseView)

function RoomCritterSummonView:onInitView()
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "root/top/#simage_title")
	self._gocritterSub = gohelper.findChild(self.viewGO, "root/right/#go_critterSub")
	self._gocritteritem = gohelper.findChild(self.viewGO, "root/right/#go_critterSub/#go_critteritem")
	self._scrollcritter = gohelper.findChildScrollRect(self.viewGO, "root/right/#go_critterSub/#scroll_critter")
	self._btnrefresh = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#btn_refresh")
	self._btnsummon = gohelper.findChildButtonWithAudio(self.viewGO, "root/bottom/#btn_summon")
	self._simagecurrency = gohelper.findChildSingleImage(self.viewGO, "root/bottom/#btn_summon/currency/#simage_currency")
	self._txtcurrency = gohelper.findChildText(self.viewGO, "root/bottom/#btn_summon/currency/#txt_currency")
	self._btnsummonten = gohelper.findChildButtonWithAudio(self.viewGO, "root/bottom/#btn_summonten")
	self._simagecurrencyten = gohelper.findChildSingleImage(self.viewGO, "root/bottom/#btn_summonten/currency/#simage_currencyten")
	self._txtcurrencyten = gohelper.findChildText(self.viewGO, "root/bottom/#btn_summonten/currency/#txt_currencyten")
	self._goBackBtns = gohelper.findChild(self.viewGO, "root/#go_BackBtns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterSummonView:addEvents()
	self._btnrefresh:AddClickListener(self._btnrefreshOnClick, self)
	self._btnsummon:AddClickListener(self._btnsummonOnClick, self)
	self._btnsummonten:AddClickListener(self._btnsummontenOnClick, self)
end

function RoomCritterSummonView:removeEvents()
	self._btnrefresh:RemoveClickListener()
	self._btnsummon:RemoveClickListener()
	self._btnsummonten:RemoveClickListener()
end

function RoomCritterSummonView:_addEvents()
	self.addEventCb(self, CritterSummonController.instance, CritterSummonEvent.onStartSummon, self._onStartSummon, self)
	self.addEventCb(self, CritterSummonController.instance, CritterSummonEvent.onCloseGetCritter, self._onCloseGetCritter, self)
	self.addEventCb(self, CritterSummonController.instance, CritterSummonEvent.onResetSummon, self._onResetSummon, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._startRefreshSingleCostTask, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._startRefreshSingleCostTask, self)
end

function RoomCritterSummonView:_removeEvents()
	self.removeEventCb(self, CritterSummonController.instance, CritterSummonEvent.onStartSummon, self._onStartSummon, self)
	self.removeEventCb(self, CritterSummonController.instance, CritterSummonEvent.onCloseGetCritter, self._onCloseGetCritter, self)
	self.removeEventCb(self, CritterSummonController.instance, CritterSummonEvent.onResetSummon, self._onResetSummon, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._startRefreshSingleCostTask, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._startRefreshSingleCostTask, self)
end

function RoomCritterSummonView:_btnrefreshOnClick()
	self:_refreshPool()
end

function RoomCritterSummonView:_btnsummonOnClick()
	self:_sendSummonCritter(CritterEnum.Summon.One)
end

function RoomCritterSummonView:_btnsummontenOnClick()
	if self._curTenCount then
		self:_sendSummonCritter(self._curTenCount)
	end
end

function RoomCritterSummonView:_sendSummonCritter(count)
	local toast, name = CritterSummonModel.instance:notSummonToast(self._poolId, count)

	if string.nilorempty(toast) then
		CritterRpc.instance:sendSummonCritterRequest(self._poolId, count)
	else
		GameFacade.showToast(toast, name)
	end
end

function RoomCritterSummonView:_editableInitView()
	self._canvasGroup = self.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._goroot = gohelper.findChild(self.viewGO, "root")
	self._btnsummonGO = self._btnsummon.gameObject
	self._btnsummontenGO = self._btnsummonten.gameObject
end

function RoomCritterSummonView:onUpdateParam()
	return
end

function RoomCritterSummonView:onOpen()
	self:_addEvents()

	self._poolId = CritterSummonModel.instance:getSummonPoolId()
	self._summonCount = CritterSummonModel.instance:getSummonCount()

	gohelper.setActive(self._gocritteritem, false)
	CritterRpc.instance:sendSummonCritterInfoRequest(self.onRefresh, self)
	self:_refreshSingleCost()
end

function RoomCritterSummonView:onClose()
	self:_removeEvents()
end

function RoomCritterSummonView:onDestroyView()
	self._simagecurrency:UnLoadImage()
	self._simagecurrencyten:UnLoadImage()
	self:_stopRefreshSingleCostTask()
end

function RoomCritterSummonView:onRefresh()
	self:_onRefreshCritter()
	self:_startRefreshSingleCostTask()
end

function RoomCritterSummonView:_startRefreshSingleCostTask()
	if not self._hasWaitRefreshSingleCostTask then
		self._hasWaitRefreshSingleCostTask = true

		TaskDispatcher.runDelay(self._onRunRefreshSingleCostTask, self, 0.1)
	end
end

function RoomCritterSummonView:_stopRefreshSingleCostTask()
	self._hasWaitRefreshSingleCostTask = false

	TaskDispatcher.cancelTask(self._onRunRefreshSingleCostTask, self)
end

function RoomCritterSummonView:_onRunRefreshSingleCostTask()
	self._hasWaitRefreshSingleCostTask = false

	self:_refreshSingleCost()
end

function RoomCritterSummonView:_onRefreshCritter()
	CritterSummonModel.instance:setSummonPoolList(self._poolId)

	if CritterSummonModel.instance:isNullPool(self._poolId) then
		self:_refreshPool()
	end
end

function RoomCritterSummonView:_refreshPool()
	if CritterSummonModel.instance:isFullPool(self._poolId) then
		GameFacade.showToast(ToastEnum.RoomCritterPoolNeweast)

		return
	end

	if CritterSummonModel.instance:isNullPool(self._poolId) then
		self:_refreshPoolRequest()
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomCritterPoolRefresh, MsgBoxEnum.BoxType.Yes_No, self._refreshPoolRequest, nil, nil, self)
	end
end

function RoomCritterSummonView:_refreshPoolRequest()
	CritterRpc.instance:sendResetSummonCritterPoolRequest(self._poolId)
end

function RoomCritterSummonView:_refreshSingleCost()
	local cost_icon, str, oneEnough = CritterSummonModel.instance:getPoolCurrency(self._poolId)

	self._simagecurrency:LoadImage(cost_icon)

	self._txtcurrency.text = str

	local critterCount = CritterSummonModel.instance:getPoolCritterCount(self._poolId)

	self._curTenCount = math.min(critterCount, CritterEnum.Summon.Ten)

	local tenIcon, tenstr, tenEnough = CritterSummonModel.instance:getPoolCurrency(self._poolId, self._curTenCount)

	self._simagecurrencyten:LoadImage(tenIcon)

	self._txtcurrencyten.text = tenstr
	tenEnough = tenEnough and critterCount >= self._curTenCount
	oneEnough = oneEnough and critterCount >= CritterEnum.Summon.One

	ZProj.UGUIHelper.SetGrayscale(self._btnsummontenGO, not tenEnough)
	ZProj.UGUIHelper.SetGrayscale(self._btnsummonGO, not oneEnough)
end

function RoomCritterSummonView:_onStartSummon(param)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingHideView)

	local buildingUid = self.viewContainer:getContainerViewBuilding()

	CritterSummonController.instance:openSummonView(buildingUid, param)

	if self._goroot then
		gohelper.setActive(self._goroot, false)
	end
end

function RoomCritterSummonView:_onCloseGetCritter()
	if self._goroot then
		gohelper.setActive(self._goroot, true)
	end

	self:onRefresh()
end

function RoomCritterSummonView:_onResetSummon(poolId)
	self._poolId = poolId

	GameFacade.showToast(ToastEnum.RoomCritterPoolRefresh)
	CritterSummonController.instance:refreshSummon(poolId, self.onRefresh, self)
end

return RoomCritterSummonView
