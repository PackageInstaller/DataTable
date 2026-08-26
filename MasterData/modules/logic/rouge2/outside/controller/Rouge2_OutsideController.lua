-- chunkname: @modules/logic/rouge2/outside/controller/Rouge2_OutsideController.lua

module("modules.logic.rouge2.outside.controller.Rouge2_OutsideController", package.seeall)

local Rouge2_OutsideController = class("Rouge2_OutsideController", BaseController)

function Rouge2_OutsideController:onGetOutsideInfo(info)
	Rouge2_TalentModel.instance:updateInfo(info)
end

function Rouge2_OutsideController:openRougeFinishView(state, endId)
	local param = {}

	param.state = state
	param.endId = endId

	ViewMgr.instance:openView(ViewName.Rouge2_FinishView, param)
end

function Rouge2_OutsideController:openRougeResultView()
	ViewMgr.instance:openView(ViewName.Rouge2_ResultView)
end

function Rouge2_OutsideController:openRougeSettlementView()
	ViewMgr.instance:openView(ViewName.Rouge2_SettlementView)
end

function Rouge2_OutsideController:openRougeSettlementUnlockView(param)
	ViewMgr.instance:openView(ViewName.Rouge2_SettlementUnlockView, param)
end

function Rouge2_OutsideController:openRougeResultFinalView(param)
	ViewMgr.instance:openView(ViewName.Rouge2_ResultFinalView, param)
end

function Rouge2_OutsideController:activeTalent(talentId)
	Rouge2OutsideRpc.instance:sendRouge2ActiveGeniusRequest(talentId)
end

function Rouge2_OutsideController:openAlchemyView(isFromAlchemyView)
	if Rouge2_AlchemyModel.instance:haveAlchemyInfo() then
		self:openAlchemyEnterView(isFromAlchemyView)
	else
		self:openAlchemyMainView()
	end
end

function Rouge2_OutsideController:openAlchemyEnterView(isFromAlchemyView)
	local viewParam = {
		isFromAlchemyView = isFromAlchemyView
	}

	ViewMgr.instance:openView(ViewName.Rouge2_AlchemyEnterView, viewParam)
end

function Rouge2_OutsideController:openAlchemyMainView()
	ViewMgr.instance:openView(ViewName.Rouge2_AlchemyMainView)
end

function Rouge2_OutsideController:openAlchemySelectView(param)
	ViewMgr.instance:openView(ViewName.Rouge2_AlchemyListView, param)
end

function Rouge2_OutsideController:onAlchemySuccess(alchemyInfo, spEventNum, returnMaterial, subExtraEffect, mainUpdateEffect)
	Rouge2_AlchemyModel.instance:updateInfo(alchemyInfo)
	self:dispatchEvent(Rouge2_OutsideEvent.onAlchemySuccess)

	local viewParam = {}

	viewParam.state = Rouge2_OutsideEnum.AlchemySuccessViewState.Success
	viewParam.spEventNum = spEventNum
	viewParam.returnMaterial = returnMaterial
	viewParam.subExtraEffect = subExtraEffect
	viewParam.mainUpdateEffect = mainUpdateEffect

	self:clearFlow()

	self.alchemySuccessFlow = FlowSequence.New()

	self.alchemySuccessFlow:addWork(Rouge2_WaitAlchemySuccessFxDoneWork.New(viewParam))
	self.alchemySuccessFlow:registerDoneListener(self.onEndFlowDone, self)
	self.alchemySuccessFlow:start()

	self._hasCleanRedDotTask = false
end

function Rouge2_OutsideController:onEndFlowDone()
	self:clearFlow()
end

function Rouge2_OutsideController:clearFlow()
	if self.endFlow then
		self.endFlow:destroy()

		self.endFlow = nil
	end
end

function Rouge2_OutsideController:openAlchemySuccessView(viewParam)
	ViewMgr.instance:openView(ViewName.Rouge2_AlchemySuccessView, viewParam)
end

function Rouge2_OutsideController:tryClearCurFormula()
	local msgId = MessageBoxIdDefine.Rouge2_Clear_CurFormula

	GameFacade.showMessageBox(msgId, MsgBoxEnum.BoxType.Yes_No, self.realSendClear, nil, nil, self, nil, nil)
end

function Rouge2_OutsideController:realSendClear()
	Rouge2OutsideRpc.instance:sendRouge2CancelAlchemyRequest()
end

function Rouge2_OutsideController:onAlchemyCancelReply(alchemyInfo)
	Rouge2_AlchemyModel.instance:updateInfo(alchemyInfo)
	GameFacade.showToast(ToastEnum.Rouge2FormulaClear)
	self:dispatchEvent(Rouge2_OutsideEvent.onAlchemyCancel)
end

function Rouge2_OutsideController:openRougeCollectionFilterView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.Rouge2_CollectionFilterView, param, isImmediate)
end

function Rouge2_OutsideController:openFavoriteMainView(param, isImmediate, callback, callbackObj)
	Rouge2OutsideRpc.instance:sendRouge2GetUnlockCollectionsRequest(function(cmd, resultCode)
		if resultCode ~= 0 then
			logError("sendRouge2GetUnlockCollectionsRequest error  code: " .. resultCode)

			return
		end

		ViewMgr.instance:openView(ViewName.Rouge2_FavoriteCollectionView, param, isImmediate)

		if callback then
			callback(callbackObj)
		end
	end)
end

function Rouge2_OutsideController:openReviewView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.Rouge2_ResultReportView, param, isImmediate)
end

function Rouge2_OutsideController:openMaterialListView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.Rouge2_MaterialListView, param, isImmediate)
end

function Rouge2_OutsideController:openCollectionCollectView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.Rouge2_CollectionCollectView, param, isImmediate)
end

Rouge2_OutsideController.UIMaskName = "Rouge2_OutsideController"
Rouge2_OutsideController.ForceCloseMaskDelayTime = 3

function Rouge2_OutsideController:lockScreen(lock, time)
	if lock then
		time = time and Rouge2_OutsideController.ForceCloseMaskDelayTime + time or Rouge2_OutsideController.ForceCloseMaskDelayTime

		TaskDispatcher.runDelay(self.forceCloseLock, self, time)
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock(Rouge2_OutsideController.UIMaskName)
		logNormal("肉鸽2 开始锁屏")
	else
		TaskDispatcher.cancelTask(self.forceCloseLock, self)
		UIBlockMgrExtend.setNeedCircleMv(true)
		UIBlockMgr.instance:endBlock(Rouge2_OutsideController.UIMaskName)
		logNormal("肉鸽2 结束锁屏")
	end
end

function Rouge2_OutsideController:forceCloseLock()
	logError("肉鸽开始场景 事件出现表现超时 已强制关闭遮罩")
	self:_lockScreen(false)
end

function Rouge2_OutsideController.buildSingleInfo(uid, showRedDot)
	return {
		time = 0,
		id = uid,
		value = showRedDot and 1 or 0
	}
end

function Rouge2_OutsideController:setRedDotState(defineId, infoList)
	local reddotItemInfo = {
		replaceAll = true,
		defineId = defineId,
		infos = infoList
	}
	local redDotInfos = {
		reddotItemInfo
	}

	RedDotModel.instance:updateRedDotInfo(redDotInfos)

	local refreshlist = {}
	local ids = RedDotModel.instance:_getAssociateRedDots(defineId)

	for _, id in pairs(ids) do
		refreshlist[id] = true
	end

	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, refreshlist)
end

function Rouge2_OutsideController:addShowRedDot(type, uid)
	Rouge2_OutsideModel.instance:addTempLocalDataList(type, uid)
	self:delayClearRedDot()
end

function Rouge2_OutsideController:delayClearRedDot()
	if not self._hasCleanRedDotTask then
		self._hasCleanRedDotTask = true

		TaskDispatcher.runDelay(self._onRunClearRedDot, self, 0.5)
	end
end

function Rouge2_OutsideController:_onRunClearRedDot()
	TaskDispatcher.cancelTask(self._onRunClearRedDot, self)
	Rouge2_OutsideModel.instance:saveTempLocalDataList()
	self:dispatchEvent(Rouge2_OutsideEvent.OnClearRedDot)
	Rouge2_OutsideModel.instance:clearTempLocalDataList()

	self._hasCleanRedDotTask = false
end

function Rouge2_OutsideController:isCareerUnlock()
	return Rouge2_OutSideConfig.instance:isCareerUnlock()
end

function Rouge2_OutsideController:checkNewPass()
	local passCollectionList = Rouge2_OutsideModel.instance:getNewPassCollectionList()

	if passCollectionList and next(passCollectionList) then
		for _, collectionId in ipairs(passCollectionList) do
			local config = Rouge2_OutSideConfig.getItemConfig(collectionId)

			if not config then
				logError("肉鸽2 不存在的造物 id: " .. collectionId)
			elseif config.isDisplay ~= nil and config.isDisplay ~= 0 then
				local param = {}

				param.displayType = Rouge2_OutsideEnum.ResultFinalDisplayType.Result

				Rouge2_OutsideController.instance:openCollectionCollectView(param)

				return true
			end
		end
	end

	return false
end

function Rouge2_OutsideController:checkNewUnlock()
	local unlockCollectionList = Rouge2_OutsideModel.instance:getNewUnlockCollectionList()
	local unlockFormulaList = Rouge2_AlchemyModel.instance:getNewUnlockFormula()

	if unlockCollectionList and #unlockCollectionList > 0 or unlockFormulaList and #unlockFormulaList > 0 then
		Rouge2_ViewHelper.openRouge2UnlockInfoView()

		return true
	end

	return false
end

function Rouge2_OutsideController:tryOpenActivityUpdateTips()
	local actId = Rouge2_Model.instance:getCurActId()

	if not ActivityModel.instance:isActOnLine(actId) then
		return
	end

	local hasTips, openMajorVersion, openMinorVersion = self:checkHasNewUpdateTips()

	if not hasTips then
		return
	end

	local saveStr = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.Rouge2ActivityUpdateTips, "")
	local saveVersionList = string.splitToNumber(saveStr, "#")

	if not saveVersionList[1] then
		if not saveVersionList[2] then
			local saveMinorVersion = 0
			local canOpen = false

			canOpen = saveVersionList[1] == openMajorVersion and saveMinorVersion < openMinorVersion or saveVersionList[1] < openMajorVersion

			if canOpen then
				if GuideController.instance:isAnyGuideRunning() then
					GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Rouge2ActivityUpdateTips, openMajorVersion .. "#" .. openMinorVersion)

					return
				end

				ViewMgr.instance:openView(ViewName.Rouge2_ActivityUpdateTipsView)
				GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Rouge2ActivityUpdateTips, openMajorVersion .. "#" .. openMinorVersion)

				return true
			end
		end
	end
end

function Rouge2_OutsideController:checkHasNewUpdateTips()
	local updateVersionCo = Rouge2_OutSideConfig.instance:getConstConfigById(Rouge2_Enum.OutSideConstId.ActivityUpdateVersion)
	local updateVersionStr = updateVersionCo and updateVersionCo.value

	if string.nilorempty(updateVersionStr) then
		return
	end

	local updateVersion = string.splitToNumber(updateVersionStr, "#")

	if not updateVersion[1] then
		local openMajorVersion = 0

		if not updateVersion[2] then
			local openMinorVersion = 0
			local hasTips = GameBranchMgr.instance:isVer(openMajorVersion, openMinorVersion)

			return hasTips, openMajorVersion, openMinorVersion
		end
	end
end

Rouge2_OutsideController.instance = Rouge2_OutsideController.New()

return Rouge2_OutsideController
