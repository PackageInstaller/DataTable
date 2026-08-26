-- chunkname: @modules/logic/room/controller/RoomLayoutController.lua

module("modules.logic.room.controller.RoomLayoutController", package.seeall)

local RoomLayoutController = class("RoomLayoutController", BaseController)

function RoomLayoutController:onInit()
	self:clear()
end

function RoomLayoutController:reInit()
	self:clear()
end

function RoomLayoutController:clear()
	return
end

function RoomLayoutController:addConstEvents()
	self.addEventCb(self, RoomController.instance, RoomEvent.OnLateInitDone, self._onEnterRoomDone, self)
	self.addEventCb(self, RoomController.instance, RoomEvent.OnSwitchModeDone, self._onEnterRoomDone, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.UpdateRoomLevel, self._onUpateRoomLevel, self)
end

function RoomLayoutController:_onEnterRoomDone()
	if self._lastSwitchbuildDegree and RoomController.instance:isObMode() then
		local lastBonus = RoomConfig.instance:getBuildBonusByBuildDegree(self._lastSwitchbuildDegree)
		local buildDegree = RoomMapModel.instance:getAllBuildDegree()
		local curBonus = RoomConfig.instance:getBuildBonusByBuildDegree(buildDegree)

		self._lastSwitchbuildDegree = nil

		if lastBonus ~= curBonus then
			self:dispatchEvent(RoomEvent.UISwitchLayoutPlanBuildDegree)
		end
	end
end

function RoomLayoutController:_onUpateRoomLevel()
	local openLevel = CommonConfig.instance:getConstNum(ConstEnum.RoomLayoutPlanOpen) or 0

	if openLevel == RoomModel.instance:getRoomLevel() then
		self:sendGetRoomPlanInfoRpc()
	end
end

function RoomLayoutController:isOpen(isShowToast)
	local openLevel = CommonConfig.instance:getConstNum(ConstEnum.RoomLayoutPlanOpen) or 0

	if openLevel <= RoomModel.instance:getRoomLevel() then
		return true
	end

	if isShowToast == true then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanNotOpen, openLevel)
	end

	return false
end

function RoomLayoutController:openView()
	local isCanOpen = false

	if self:isOpen(true) then
		if RoomController.instance:isObMode() then
			self:updateObInfo()
		end

		RoomLayoutListModel.instance:init()
		ViewMgr.instance:openView(ViewName.RoomLayoutView)

		isCanOpen = true
	end

	return isCanOpen
end

function RoomLayoutController:openCopyTips(planInfo)
	local titleStr = luaLang("room_layoutplan_copy_tips_title")

	self._openTipsParam = {
		showBuy = true,
		titleStr = titleStr
	}

	self:_onOpenTips(planInfo)
end

function RoomLayoutController:openTips(planId, uiWorldPos, offsetWidth, offsetHeight)
	local layoutMO = RoomLayoutModel.instance:getById(planId)

	if not layoutMO then
		return
	end

	local var_10_0 = {
		uiWorldPos = uiWorldPos,
		offsetWidth = offsetWidth,
		offsetHeight = offsetHeight
	}

	var_10_0.titleStr = formatLuaLang("room_layoutplan_look_details", layoutMO.name or "")
	self._openTipsParam = var_10_0

	if layoutMO:isHasBlockBuildingInfo() then
		self:_onOpenTips(layoutMO)
	elseif planId == RoomEnum.LayoutUsedPlanId then
		self:updateObInfo()
		self:_onOpenTips(layoutMO)
	else
		self._waitingOpenPlanId = planId
		self._waitingOpenWorldPos = uiWorldPos

		RoomRpc.instance:sendGetRoomPlanDetailsRequest(planId)
	end
end

function RoomLayoutController:_onOpenTips(layoutMO)
	self._waitingOpenPlanId = nil

	local param = self._openTipsParam

	self._openTipsParam = nil

	RoomLayoutItemListModel.instance:init(layoutMO.infos, layoutMO.buildingInfos)

	if RoomLayoutItemListModel.instance:getCount() <= 0 then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanMapNothing)

		return
	end

	local viewName = ViewName.RoomLayoutItemTips

	if not ViewMgr.instance:isOpen(viewName) then
		local viewSetting = ViewMgr.instance:getSetting(viewName)

		if viewSetting then
			viewSetting.bgBlur = RoomController.instance:isVisitMode() and ViewMgr.instance:isOpen(RoomLayoutCreateTipsView) and 1 or nil
		end
	end

	ViewMgr.instance:openView(viewName, param)
end

function RoomLayoutController:openBgSelectView(uiWorldPos, offsetWidth, offsetHeight)
	local layoutMO = RoomLayoutListModel.instance:getSelectMO()

	RoomLayoutBgResListModel.instance:init(layoutMO and layoutMO:getCoverId())
	ViewMgr.instance:openView(ViewName.RoomLayoutBgSelectView, {
		uiWorldPos = uiWorldPos,
		offsetWidth = offsetWidth,
		offsetHeight = offsetHeight
	})
end

function RoomLayoutController:openCreateTipsView(titleStr, isSelect, isShowSetlect, yesCallback, callbockObj)
	local param = {
		titleStr = titleStr,
		isSelect = isSelect,
		isShowSetlect = isShowSetlect,
		yesCallback = yesCallback,
		callbockObj = callbockObj
	}

	ViewMgr.instance:openView(ViewName.RoomLayoutCreateTipsView, param)
end

function RoomLayoutController:openRenameView()
	ViewMgr.instance:openView(ViewName.RoomLayoutRenameView)
end

function RoomLayoutController:openCopyView(playerName)
	local tinfo = self:_getObPlanInfo()

	if tinfo == nil then
		return
	end

	local maxCount = RoomMapBlockModel.instance:getMaxBlockCount(RoomModel.instance:getRoomLevel())

	if maxCount < tinfo.blockCount then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanMax)

		return
	end

	self._tempCopyPlayerName = playerName

	if tinfo.changeColorCount and tinfo.changeColorCount > 0 then
		local costItem = UnlockVoucherConfig.instance:getRoomColorConst(UnlockVoucherEnum.ConstId.RoomBlockColorReformCostItem, "#", true)
		local costItemType = costItem[1]
		local costItemId = costItem[2]
		local hasQuantity = ItemModel.instance:getItemQuantity(costItemType, costItemId)

		if hasQuantity < tinfo.changeColorCount then
			GameFacade.showToast(ToastEnum.CopyLayoutNotEnoughBlockReformCost)

			return
		end

		GameFacade.showMessageBox(MessageBoxIdDefine.ConfirmCopyLayoutCostItem, MsgBoxEnum.BoxType.Yes_No, self._confirmCopy, nil, nil, self, nil, nil, tinfo.changeColorCount)
	else
		self:_confirmCopy()
	end
end

function RoomLayoutController:_confirmCopy()
	local tinfo = self:_getObPlanInfo()

	if tinfo == nil then
		return
	end

	local defaultName = RoomLayoutModel.instance:findDefaultName()
	local param = {
		yesBtnNotClose = true,
		planInfo = tinfo,
		defaultName = defaultName,
		yesCallback = self._onYesCopyViewCallback,
		callbockObj = self,
		playerName = self._tempCopyPlayerName
	}

	ViewMgr.instance:openView(ViewName.RoomLayoutCopyView, param)
end

RoomLayoutController.COPY_SHARE_CODE_WORD_TEST_RPC = "RoomLayoutController.COPY_SHARE_CODE_WORD_TEST_RPC"

function RoomLayoutController:_onYesCopyViewCallback(name)
	UIBlockMgr.instance:startBlock(RoomLayoutController.COPY_SHARE_CODE_WORD_TEST_RPC)
	ChatRpc.instance:sendWordTestRequest(name, self._onCopyWordTestReply, self)
	RoomLayoutModel.instance:setVisitCopyName(name)
end

function RoomLayoutController:_onCopyWordTestReply(cmd, resultCode, msg)
	UIBlockMgr.instance:endBlock(RoomLayoutController.COPY_SHARE_CODE_WORD_TEST_RPC)

	if resultCode == 0 then
		ViewMgr.instance:closeView(ViewName.RoomLayoutCopyView)
		self:openView()
	end
end

function RoomLayoutController:_getObPlanInfo(gameMode)
	local obInfo = RoomModel.instance:getInfoByMode(gameMode or RoomModel.instance:getGameMode())

	if not obInfo then
		return
	end

	return RoomLayoutHelper.createInfoByObInfo(obInfo)
end

function RoomLayoutController:updateObInfo()
	local info = self:_getObPlanInfo(RoomEnum.GameMode.Ob)

	if info then
		info.id = RoomEnum.LayoutUsedPlanId

		RoomLayoutModel.instance:updateRoomPlanInfoReply(info)
	end
end

function RoomLayoutController:sendGetRoomPlanInfoRpc()
	if self:isOpen() then
		RoomRpc.instance:sendGetRoomPlanInfoRequest()
	end
end

function RoomLayoutController:sendCreateRpc(layoutMO, isSelect)
	local coverId = layoutMO:getCoverId()

	if layoutMO:isEmpty() then
		layoutMO:setName(RoomLayoutModel.instance:findDefaultName())
	else
		local useMO = RoomLayoutModel.instance:getById(RoomEnum.LayoutUsedPlanId)

		coverId = useMO and useMO:getCoverId() or coverId
	end

	RoomRpc.instance:sendSetRoomPlanRequest(layoutMO.id, coverId, layoutMO:getName())

	if isSelect and layoutMO.id ~= RoomEnum.LayoutUsedPlanId then
		self:sendSwitchRoomPlanRequest(layoutMO.id)
	end
end

function RoomLayoutController:sendSwitchRoomPlanRequest(planId)
	if planId ~= RoomEnum.LayoutUsedPlanId then
		self._hasSwitchPlan = true

		RoomRpc.instance:sendSwitchRoomPlanRequest(RoomEnum.LayoutUsedPlanId, planId, self._onObSwitchPlanReplay, self)
	end
end

function RoomLayoutController:_onObSwitchPlanReplay(cmd, resultCode, msg)
	local isHas = self._hasSwitchPlan

	self._hasSwitchPlan = false

	if resultCode == 0 then
		if isHas then
			if not RoomEnum.Toast.LayoutPlanSaveAndUse then
				local toastId = RoomEnum.Toast.LayoutPlanUse

				GameFacade.showToast(toastId)

				self._lastSwitchbuildDegree = RoomMapModel.instance:getAllBuildDegree()

				self:_swicthPlanCritterRequest()
				RoomController.instance:enterRoom(RoomEnum.GameMode.Ob, nil, nil, nil, nil, nil, true)
			end
		end
	end
end

function RoomLayoutController:_swicthPlanCritterRequest()
	if CritterModel.instance:isCritterUnlock() then
		CritterRpc.instance:sendCritterGetInfoRequest()
	end

	ManufactureController.instance:getManufactureServerInfo()
end

function RoomLayoutController:sendVisitCopyRpc(layoutMO, isSelect)
	local visitParam = RoomModel.instance:getVisitParam()
	local planId = layoutMO.id
	local coverId = layoutMO:getCoverId()
	local name = RoomLayoutModel.instance:getVisitCopyName()

	if isSelect and planId ~= RoomEnum.LayoutUsedPlanId then
		self._visitsWitchPlanId = planId
	end

	if isSelect or planId == RoomEnum.LayoutUsedPlanId then
		local curMO = RoomLayoutModel.instance:getById(RoomEnum.LayoutUsedPlanId)

		if curMO then
			self._lastSwitchbuildDegree = curMO.buildingDegree
		end
	end

	if RoomController.instance:isVisitShareMode() then
		RoomRpc.instance:sendUseRoomShareRequest(visitParam.shareCode, planId, coverId, name, self._onVisitCopyReply, self)
	else
		RoomRpc.instance:sendCopyOtherRoomPlanRequest(visitParam.userId, planId, coverId, name, self._onVisitCopyReply, self)
	end
end

function RoomLayoutController:_onVisitCopyReply(cmd, resultCode, msg)
	local witchPlanId = self._visitsWitchPlanId

	self._visitsWitchPlanId = nil

	if resultCode == 0 then
		RoomLayoutModel.instance:clearNeedRpcGet()

		if witchPlanId then
			self._hasSwitchPlan = true

			RoomRpc.instance:sendSwitchRoomPlanRequest(RoomEnum.LayoutUsedPlanId, witchPlanId, self._onVisitSwitchPlanReplay, self)
		end

		if RoomController.instance:isVisitMode() then
			local openViews = {
				{
					viewName = ViewName.RoomLayoutView
				}
			}

			self:_swicthPlanCritterRequest()
			RoomController.instance:enterRoom(RoomEnum.GameMode.Ob, nil, nil, nil, openViews, nil, true)
		end
	end
end

function RoomLayoutController:_onVisitSwitchPlanReplay(cmd, resultCode, msg)
	local isHas = self._hasSwitchPlan

	self._hasSwitchPlan = false

	if resultCode == 0 then
		if isHas then
			if not RoomEnum.Toast.LayoutPlanSaveAndUse then
				local toastId = RoomEnum.Toast.LayoutPlanUse

				GameFacade.showToast(toastId)
			end
		end
	end
end

function RoomLayoutController:copyShareCodeTxt(txtStr)
	if not string.nilorempty(txtStr) then
		ZProj.UGUIHelper.CopyText(txtStr)
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanCopyShareCodeTxt)
	end
end

RoomLayoutController.GET_SHARE_CODE_RPC = "RoomLayoutController.GET_SHARE_CODE_RPC"

function RoomLayoutController:sendGetShareCodeRpc(shareCode)
	UIBlockMgr.instance:startBlock(RoomLayoutController.GET_SHARE_CODE_RPC)
	RoomRpc.instance:sendGetRoomShareRequest(shareCode, self._getGetRoomShareReply, self)
end

function RoomLayoutController:_getGetRoomShareReply(cmd, resultCode, msg)
	UIBlockMgr.instance:endBlock(RoomLayoutController.GET_SHARE_CODE_RPC)

	if resultCode == 0 then
		local param = {
			userId = msg.shareUserId,
			shareCode = msg.shareCode
		}
		local obInfo = msg

		RoomController.instance:enterRoom(RoomEnum.GameMode.VisitShare, nil, obInfo, param, nil, nil, true)
	end
end

function RoomLayoutController:sendSetRoomPlanNameRpc(id, nameStr)
	RoomRpc.instance:sendSetRoomPlanNameRequest(id, nameStr, self._onSetRoomPlanNameReply, self)
end

function RoomLayoutController:_onSetRoomPlanNameReply(cmd, resultCode, msg)
	if resultCode == 0 then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanRename)
		ViewMgr.instance:closeView(ViewName.RoomLayoutRenameView)
	end
end

function RoomLayoutController:getRoomPlanInfoReply(msg)
	RoomLayoutModel.instance:rpcGetFinish()
	RoomLayoutModel.instance:setRoomPlanInfoReply(msg)
	self:updateObInfo()
	RoomLayoutListModel.instance:init()

	if msg.infos then
		for _, info in ipairs(msg.infos) do
			if string.nilorempty(info.name) then
				RoomRpc.instance:sendSetRoomPlanNameRequest(info.id, formatLuaLang("room_layoutplan_default_name", ""))
			end
		end
	end
end

function RoomLayoutController:getRoomPlanDestailsReply(msg)
	RoomLayoutModel.instance:updateRoomPlanInfoReply(msg.info)

	if msg.info.id == self._waitingOpenPlanId then
		local layoutMO = RoomLayoutModel.instance:getById(msg.info.id)

		self:_onOpenTips(layoutMO, self._waitingOpenWorldPos)
	end
end

function RoomLayoutController:setRoomPlanReply(msg)
	local info = self:_getObPlanInfo() or {}

	info.id = msg.id
	info.coverId = msg.coverId
	info.name = msg.name
	info.shareCode = msg.shareCode or ""

	local isNull = RoomLayoutModel.instance:getById(msg.id) == nil

	RoomLayoutModel.instance:updateRoomPlanInfoReply(info)

	if self._hasSwitchPlan ~= true then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanSave)
	end

	if isNull then
		RoomLayoutListModel.instance:init()
		RoomLayoutListModel.instance:setSelect(msg.id)
		self:dispatchEvent(RoomEvent.UISelectLayoutPlanItem)
	else
		RoomLayoutListModel.instance:refreshList()
	end
end

function RoomLayoutController:setRoomPlanNameReply(msg)
	local mo = RoomLayoutModel.instance:getById(msg.id)

	if mo then
		mo.name = msg.name
	end

	RoomLayoutListModel.instance:refreshList()
end

function RoomLayoutController:setRoomPlanCoverReply(msg)
	local mo = RoomLayoutModel.instance:getById(msg.id)

	if mo then
		mo.coverId = msg.coverId
	end
end

function RoomLayoutController:useRoomPlanReply(msg)
	return
end

function RoomLayoutController:switchRoomPlanReply(msg)
	local infos = msg.infos
	local tRoomLayoutModel = RoomLayoutModel.instance

	for i = 1, #infos do
		tRoomLayoutModel:updateRoomPlanInfoReply(infos[i])
	end
end

function RoomLayoutController:deleteRoomPlanReply(msg)
	local mo = RoomLayoutModel.instance:getById(msg.id)

	if mo then
		RoomLayoutModel.instance:remove(mo)
		RoomLayoutListModel.instance:init()
		RoomLayoutListModel.instance:setSelect(msg.id)
		self:dispatchEvent(RoomEvent.UISelectLayoutPlanItem)
	end

	GameFacade.showToast(RoomEnum.Toast.LayoutPlanDelete)
end

function RoomLayoutController:copyOtherRoomPlanReply(msg)
	RoomLayoutModel.instance:updateRoomPlanInfoReply(msg)

	if not msg.buildDegree or not msg.blockCount then
		local info = self:_getObPlanInfo()

		if info then
			info.id = msg.id

			RoomLayoutModel.instance:updateRoomPlanInfoReply(info)
		end
	end

	RoomLayoutListModel.instance:init()
	RoomLayoutModel.instance:clearNeedRpcGet()

	if self._hasSwitchPlan ~= true then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanCopy)
	end
end

function RoomLayoutController:useRoomShareReply(msg)
	RoomLayoutModel.instance:updateRoomPlanInfoReply(msg)
	RoomLayoutModel.instance:setCanUseShareCount(msg.canUseShareCount)
	RoomLayoutListModel.instance:init()
end

function RoomLayoutController:shareRoomPlanReply(msg)
	RoomLayoutModel.instance:updateRoomPlanInfoReply(msg)
	RoomLayoutModel.instance:setCanShareCount(msg.canShareCount)
	RoomLayoutListModel.instance:init()
end

function RoomLayoutController:deleteRoomShareReply(msg)
	local var_45_0 = {
		shareCode = "",
		id = msg.id
	}

	var_45_0.useCount = msg.useCount or 0

	RoomLayoutModel.instance:updateRoomPlanInfoReply(var_45_0)
	RoomLayoutListModel.instance:init()
end

RoomLayoutController.instance = RoomLayoutController.New()

return RoomLayoutController
