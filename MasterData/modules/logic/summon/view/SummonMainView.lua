-- chunkname: @modules/logic/summon/view/SummonMainView.lua

module("modules.logic.summon.view.SummonMainView", package.seeall)

local SummonMainView = class("SummonMainView", BaseView)

function SummonMainView:onInitView()
	self._goui = gohelper.findChild(self.viewGO, "#go_ui")
	self._godrag = gohelper.findChild(self.viewGO, "#go_ui/#go_drag")
	self._gocategory = gohelper.findChild(self.viewGO, "#go_ui/#go_category")
	self._scrollcategory = gohelper.findChildScrollRect(self.viewGO, "#go_ui/#go_category/#scroll_category")
	self._gonormalRoleCategoryItem = gohelper.findChild(self.viewGO, "#go_ui/#go_category/#scroll_category/Viewport/Content/GameObject/#go_normalRoleCategoryItem")
	self._goequipCategoryItem = gohelper.findChild(self.viewGO, "#go_ui/#go_category/#scroll_category/Viewport/Content/GameObject/#go_equipCategoryItem")
	self._goRoleUpCategoryItem = gohelper.findChild(self.viewGO, "#go_ui/#go_category/#scroll_category/Viewport/Content/GameObject/#go_RoleUpCategoryItem")
	self._btnconvertStore = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/btns/#btn_convertStore")
	self._btnconvertStore2 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/btns/#btn_convertStore2")
	self._btndetail = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/btns/#btn_detail")
	self._btnsummonrecord = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/btns/#btn_summonrecord")
	self._gopoolPackage = gohelper.findChild(self.viewGO, "#go_ui/btns/#go_poolPackage")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_ui/#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonMainView:addEvents()
	self._btnconvertStore:AddClickListener(self._btnconvertStoreOnClick, self)
	self._btnconvertStore2:AddClickListener(self._btnconvert2StoreOnClick, self)
	self._btndetail:AddClickListener(self._btndetailOnClick, self)
	self._btnsummonrecord:AddClickListener(self._btnsummonrecordOnClick, self)
end

function SummonMainView:removeEvents()
	self._btnconvertStore:RemoveClickListener()
	self._btnconvertStore2:RemoveClickListener()
	self._btndetail:RemoveClickListener()
	self._btnsummonrecord:RemoveClickListener()
end

function SummonMainView:_btnconvertStoreOnClick()
	local pool = SummonMainModel.instance:getCurPool()

	StoreController.instance:checkAndOpenStoreView((pool and SummonMainModel.getResultType(pool) == SummonEnum.ResultType.Equip or nil) and StoreEnum.StoreId.SummonEquipExchange)
end

function SummonMainView:_btnconvert2StoreOnClick()
	local pool = SummonMainModel.instance:getCurPool()
	local jumpTab = StoreEnum.StoreId.HighSummon

	StoreController.instance:checkAndOpenStoreView(jumpTab)
end

function SummonMainView:_btndetailOnClick()
	local curPool = SummonMainModel.instance:getCurPool()

	SummonMainController.instance:openSummonDetail(curPool)
end

function SummonMainView:_btnsummonrecordOnClick()
	ViewMgr.instance:openView(ViewName.SummonPoolHistoryView)
end

function SummonMainView:_btnsummonpoolpackageOnClick()
	self:openPackageView(0, 0)

	local curPool = SummonMainModel.instance:getCurPool()
	local var_8_0 = {
		[StatEnum.EventProperties.ViewName] = "SummonMainView",
		[StatEnum.EventProperties.ButtonName] = "packageBtn"
	}

	if curPool then
		var_8_0[StatEnum.EventProperties.PoolName] = curPool.nameCn or ""
	end

	StatController.instance:track(StatEnum.EventName.ButtonClick, var_8_0)
end

function SummonMainView:_editableInitView()
	self._txtrecord = gohelper.findChildTextMesh(self.viewGO, "#go_ui/btns/#btn_summonrecord/txt")
	self._goblackloading = gohelper.findChild(self.viewGO, "#blackloading")
	self._animLoading = self._goblackloading:GetComponent(typeof(UnityEngine.Animator))
	self._animUI = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	SummonMainModel.instance:setFirstTimeSwitch(true)
	gohelper.addUIClickAudio(self._btnconvertStore.gameObject, AudioEnum.UI.play_ui_checkpoint_click)
	gohelper.addUIClickAudio(self._btndetail.gameObject, AudioEnum.UI.play_ui_checkpoint_click)

	self._summonPoolBtnDic = self:getUserDataTb_()
	self._summonPoolBtnLoadDic = {}
	self._summonPoolPackageLoader = PrefabInstantiate.Create(self._gopoolPackage)
end

function SummonMainView:_handleTabSet()
	local tabIndex = SummonMainModel.instance:getCurADPageIndex()

	if tabIndex then
		self:checkCallPreloader()
		self.viewContainer:refreshCurrencyType()
	end

	self._tabIndex = tabIndex

	local curPool = SummonMainModel.instance:getCurPool()
	local result = SummonMainModel.getResultType(curPool)

	if result == SummonEnum.ResultType.Equip then
		self._txtrecord:SetText(luaLang("p_summonpool_equip_record"))
	else
		self._txtrecord:SetText(luaLang("p_summonpool_record"))
	end

	self:checkProgressRewardAndPackage()

	local poolMO = SummonMainModel.instance:getPoolServerMO(curPool.id)

	gohelper.setActive(self._btnconvertStore2.gameObject, (poolMO:isOpening() and SummonEnum.ShowHighStoreById[curPool.id] or nil) and true)
end

function SummonMainView:onItemChanged()
	self.viewContainer:refreshCurrencyType()
end

function SummonMainView:onUpdateParam()
	SummonController.instance:dispatchEvent(SummonEvent.onSummonTabSet)
end

function SummonMainView:onOpen()
	local list = SummonMainModel.instance:getList()

	if not list or #list <= 0 then
		logError("没有卡池")
		TaskDispatcher.runDelay(self.returnToMainScene, self, 2)

		return
	end

	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonTabSet, self._handleTabSet, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, self.checkCallPreloader, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonInfoGot, self.onSummonInfoGot, self)
	self:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, self.viewContainer.refreshHelp, self.viewContainer)
	self.addEventCb(self, SummonController.instance, SummonEvent.summonShowBlackScreen, self.onReceiveShowBlackScreen, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.summonShowExitAnim, self.startExitLoading, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.summonCloseBlackScreen, self.onReceiveCloseBlackScreen, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.summonMainCloseImmediately, self.closeThis, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.onItemChanged, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onItemChanged, self)
	self.addEventCb(self, PayController.instance, PayEvent.PayInfoChanged, self.checkProgressRewardAndPackage, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonPoolPackageRedDotChange, self.onSummonPoolPackageRedDotChange, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.checkSummonPoolPackage, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SetTaskList, self.checkSummonPoolPackage, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.checkSummonPoolPackage, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonPoolPackageProp, self._summonPoolPackageProp, self)
	TaskDispatcher.runRepeat(self.repeatCallCountdown, self, 10)

	if PatFaceModel.instance:getIsPatting() then
		self.viewContainer:hideHomeButton()
	end
end

function SummonMainView:onOpenFinish()
	GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.SummonUI)
end

function SummonMainView:returnToMainScene()
	MainController.instance:enterMainScene(true)
	VirtualSummonScene.instance:close(true)
	ViewMgr.instance:closeView(ViewName.SummonADView)
	ViewMgr.instance:closeView(ViewName.SummonView)
end

function SummonMainView:checkCallPreloader()
	TaskDispatcher.cancelTask(self.delayLoadSceneResPreloader, self)
	TaskDispatcher.runDelay(self.delayLoadSceneResPreloader, self, 1)
end

function SummonMainView:delayLoadSceneResPreloader()
	local curId = SummonMainModel.instance:getCurId()
	local resultType = SummonMainModel.getResultTypeById(curId)
	local isChar = resultType == SummonEnum.ResultType.Char

	VirtualSummonScene.instance:checkNeedLoad(isChar, false)
end

function SummonMainView:onSummonInfoGot()
	local list = SummonMainModel.instance:getList()

	if not list or #list <= 0 then
		logError("返回消息没有卡池")
		TaskDispatcher.runDelay(self.returnToMainScene, self, 1)

		return
	end

	self:checkCurPoolValid()
end

function SummonMainView:onReceiveShowBlackScreen()
	gohelper.setActive(self._goblackloading, true)
	self._animLoading:Play("blackloading_open", 0, 0)

	self._isShowBlackScreen = true

	TaskDispatcher.runDelay(self.afterBlackLoading, self, 0.3)
end

function SummonMainView:afterBlackLoading()
	TaskDispatcher.cancelTask(self.afterBlackLoading, self)
	gohelper.setActive(self._goui, false)
	SummonController.instance:onFirstLoadSceneBlock()
end

function SummonMainView:onReceiveCloseBlackScreen()
	if not gohelper.isNil(self._animLoading) then
		self._animLoading:Play("blackloading_close", 0, 0)
	end

	TaskDispatcher.runDelay(self.afterCloseLoading, self, 0.4)
end

function SummonMainView:afterCloseLoading()
	logNormal("close SummonMainView")
	TaskDispatcher.cancelTask(self.afterCloseLoading, self)
	self:closeThis()
end

function SummonMainView:startExitLoading()
	if not gohelper.isNil(self._animUI) then
		self._animUI:Play(UIAnimationName.Close, 0, 0)
	end

	local inst = self.viewContainer:getCurTabInst()

	if inst and not gohelper.isNil(inst.viewGO) then
		local anim = inst.viewGO:GetComponent(typeof(UnityEngine.Animator))

		if anim then
			anim:Play(UIAnimationName.Close, 0, 0)
		end
	end

	return 0.16
end

function SummonMainView:startExitSummonFadeOut()
	if not gohelper.isNil(self._animUI) then
		self._animUI:Play("out", 0, 0)
	end

	return 0.16
end

function SummonMainView:checkCurPoolValid()
	local curPool = SummonMainModel.instance:getCurPool()
	local tabIndex = SummonMainModel.instance:getCurADPageIndex()

	if not curPool then
		return
	end

	if not SummonMainModel.instance:getById(curPool.id) then
		if SummonMainModel.instance:trySetSelectPoolIndex(1) then
			SummonController.instance:dispatchEvent(SummonEvent.onSummonTabSet)
		end
	elseif tabIndex ~= self._tabIndex then
		SummonController.instance:dispatchEvent(SummonEvent.onSummonTabSet)
	end
end

function SummonMainView:repeatCallCountdown()
	SummonController.instance:dispatchEvent(SummonEvent.onRemainTimeCountdown)
end

function SummonMainView:checkSummonPoolPackage()
	local curPool = SummonMainModel.instance:getCurPool()
	local poolId = curPool.id
	local poolPackageConfigList = SummonConfig.instance:getSummonPoolPackageConfigList(poolId)

	if poolPackageConfigList == nil or next(poolPackageConfigList) == nil then
		gohelper.setActive(self._gopoolPackage, false)

		return
	end

	local poolPackageConfig

	for _, config in ipairs(poolPackageConfigList) do
		if config.packageRecommendSwitch == true and StoreModel.instance:isSummonPoolPackageValid(poolId, config.order) then
			poolPackageConfig = config

			break
		end
	end

	local isEmpty = poolPackageConfig == nil

	gohelper.setActive(self._gopoolPackage, not isEmpty)

	if isEmpty then
		return
	end

	self.poolPackageConfig = poolPackageConfig

	local type = poolPackageConfig.packageEffect

	if not self._summonPoolBtnDic[type] then
		if not self._summonPoolBtnLoadDic[type] then
			self._summonPoolBtnLoadDic[type] = true

			local prefabPath = ResUrl.getSummonPoolPackageItemPath(poolPackageConfig.packageEffect)

			self._summonPoolPackageLoader:startLoad(prefabPath, self.onSummonPoolPackageBtnLoad, self)
		end
	else
		self:refreshSummonPoolState(type)
		self:checkSummonPoolPackageProp()
	end
end

function SummonMainView:checkSummonPoolPackageProp()
	self:_summonPoolPackageProp(self.viewParam.getHeroDic)
end

function SummonMainView:_summonPoolPackageProp(getHeroDic)
	if getHeroDic == nil or next(getHeroDic) == nil then
		return
	end

	local poolId = self.poolPackageConfig.id
	local orderId = self.poolPackageConfig.order

	if not SummonMainModel.instance:isSummonPoolPackageProp(poolId, orderId) and SummonPoolPackageHelper.checkSummonPoolCanProp(poolId, orderId, getHeroDic) then
		SummonMainController.instance:setSummonPoolPackageProp(poolId, orderId, self.openPackageView, self)
	end
end

function SummonMainView:checkProgressRewardAndPackage()
	local curPoolConfig = SummonMainModel.instance:getCurPool()
	local curPool = SummonMainModel.instance:getPoolServerMO(curPoolConfig.id)

	if curPoolConfig and curPoolConfig.type == SummonEnum.Type.CoBranding and curPool and curPool:isOpening() and curPool:isHasProgressReward() then
		SummonRpc.instance:sendGetSummonProgressRewardsRequest(curPool.id, self.checkSummonPoolPackage, self)
	else
		self:checkSummonPoolPackage()
	end
end

function SummonMainView:onSummonPoolPackageRedDotChange(poolId)
	if self.poolPackageConfig and self.poolPackageConfig.id == poolId then
		self:refreshSummonPoolState(self.poolPackageConfig.packageEffect)
	end
end

function SummonMainView:onSummonPoolPackageBtnLoad()
	local poolPackageConfig = self.poolPackageConfig
	local type = poolPackageConfig.packageEffect
	local itemGo = self._summonPoolPackageLoader:getInstGO()

	gohelper.setParent(itemGo, self._gopoolPackage)

	if not string.nilorempty(poolPackageConfig.posOffset) then
		local posParam = string.splitToNumber(poolPackageConfig.posOffset, "#")

		if posParam then
			transformhelper.setLocalPosXY(itemGo.transform, posParam[1] or 0, posParam[2] or 0)
		else
			logError("卡池礼包参数错误 id: " .. tostring(poolPackageConfig.id) .. " 参数: " .. poolPackageConfig.posOffset)
		end
	end

	local item = self:getUserDataTb_()

	item.gameObject = itemGo

	local btnDetail = gohelper.findChildButton(itemGo, "")

	item.btnDetail = btnDetail
	item.gocantget = gohelper.findChild(itemGo, "canget")

	local redDotParent = gohelper.findChild(itemGo, "go_reddot")

	item.redDot = RedDotController.instance:addNotEventRedDot(redDotParent, self.checkSummonPoolRedDot, self, RedDotEnum.Style.NewTag)

	btnDetail:AddClickListener(self._btnsummonpoolpackageOnClick, self)

	self._summonPoolBtnDic[type] = item

	self:refreshSummonPoolState(type)
	self:checkSummonPoolPackageProp()

	self._summonPoolBtnLoadDic[type] = nil
end

function SummonMainView:checkSummonPoolRedDot()
	local poolId = self.poolPackageConfig.id
	local var_33_0 = self._curShowPoolBtnType

	if self._curShowPoolBtnType then
		var_33_0 = self._summonPoolBtnDic

		if self._summonPoolBtnDic then
			local item = self._summonPoolBtnDic[self._curShowPoolBtnType]

			if item and not gohelper.isNil(item.gocantget) then
				gohelper.setActive(item.gocantget, self:_isSummonPoolPackageCangetFlag(poolId))
			end

			if not SummonModel.instance:isSummonPoolPackageRedDotShow(poolId) then
				return true
			end

			return false
		end
	end
end

function SummonMainView:_isSummonPoolPackageCangetFlag(poolId)
	if StoreGoodsTaskController.instance:isHasCanFinishTaskByPoolId(poolId) then
		return true
	end

	return false
end

function SummonMainView:refreshSummonPoolState(type)
	self._curShowPoolBtnType = type

	if self._summonPoolBtnDic and next(self._summonPoolBtnDic) then
		for effectType, item in pairs(self._summonPoolBtnDic) do
			gohelper.setActive(item.gameObject, effectType == type)

			if effectType == type then
				item.redDot:refreshRedDot()
			end
		end
	end
end

function SummonMainView:openPackageView(cmd, resultCode)
	if resultCode == 0 then
		local curPool = SummonMainModel.instance:getCurPool()

		if curPool == nil then
			return
		end

		if self.poolPackageConfig == nil then
			return
		end

		if not SummonModel.instance:isSummonPoolPackageRedDotShow(self.poolPackageConfig.id) then
			SummonModel.instance:setSummonPoolPackageRedDotShow(self.poolPackageConfig.id)
		end

		SummonController.instance:openSummonPoolPackageView(curPool.id, self.poolPackageConfig.order, false)
	end
end

function SummonMainView:onClose()
	TaskDispatcher.cancelTask(self.afterBlackLoading, self)
	TaskDispatcher.cancelTask(self.afterCloseLoading, self)
	TaskDispatcher.cancelTask(self.checkCallPreloader, self)
	TaskDispatcher.cancelTask(self.repeatCallCountdown, self)
	TaskDispatcher.cancelTask(self.returnToMainScene, self)
	self.removeEventCb(self, PayController.instance, PayEvent.PayInfoChanged, self.checkProgressRewardAndPackage, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonPoolPackageRedDotChange, self.onSummonPoolPackageRedDotChange, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.checkSummonPoolPackage, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.SetTaskList, self.checkSummonPoolPackage, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.checkSummonPoolPackage, self)
end

function SummonMainView:onDestroyView()
	for _, item in pairs(self._summonPoolBtnDic) do
		item.btnDetail:RemoveClickListener()

		item.btnDetail = nil
		item.redDot = nil
		item.gameObject = nil
	end

	tabletool.clear(self._summonPoolBtnDic)

	self._summonPoolBtnDic = nil

	if self._summonPoolPackageLoader then
		self._summonPoolPackageLoader:dispose()

		self._summonPoolPackageLoader = nil
	end
end

return SummonMainView
