-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/eliminateChess/EliminateTeamChessView.lua

module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateTeamChessView", package.seeall)

local EliminateTeamChessView = class("EliminateTeamChessView", BaseView)

function EliminateTeamChessView:onInitView()
	self._viewGO = self.viewGO
	self.viewGO = gohelper.findChild(self._viewGO, "#go_cameraMain/Middle/#go_teamchess")
	self._gostrongHolds = gohelper.findChild(self.viewGO, "#go_strongHolds")
	self._gostrongHold = gohelper.findChild(self.viewGO, "#go_strongHolds/#go_strongHold")
	self._goinfo = gohelper.findChild(self.viewGO, "#go_strongHolds/#go_strongHold/#go_info")
	self._imageslotBGColor = gohelper.findChildImage(self.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#image_slotBGColor")
	self._simageslotBG = gohelper.findChildSingleImage(self.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#simage_slotBG")
	self._imageInfoTextBG = gohelper.findChildImage(self.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#image_InfoTextBG")
	self._txtInfo = gohelper.findChildText(self.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#image_InfoTextBG/#txt_Info")
	self._goEnemyPower = gohelper.findChild(self.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_EnemyPower")
	self._imageEnemyPower = gohelper.findChildImage(self.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_EnemyPower/#image_EnemyPower")
	self._imageEnemyPower2 = gohelper.findChildImage(self.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_EnemyPower/#image_EnemyPower2")
	self._txtEnemyPower = gohelper.findChildText(self.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_EnemyPower/#txt_Enemy_Power")
	self._txtEnemyPower1 = gohelper.findChildText(self.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_EnemyPower/#txt_Enemy_Power1")
	self._goPlayerPower = gohelper.findChild(self.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_PlayerPower")
	self._imagePlayerPower = gohelper.findChildImage(self.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_PlayerPower/#image_PlayerPower")
	self._imagePlayerPower2 = gohelper.findChildImage(self.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_PlayerPower/#image_PlayerPower2")
	self._txtPlayerPower = gohelper.findChildText(self.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_PlayerPower/#txt_Player_Power")
	self._txtPlayerPower1 = gohelper.findChildText(self.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_PlayerPower/#txt_Player_Power1")
	self._goEnemy = gohelper.findChild(self.viewGO, "#go_strongHolds/#go_strongHold/#go_Enemy")
	self._goEnemyWin = gohelper.findChild(self.viewGO, "#go_strongHolds/#go_strongHold/#go_EnemyWin")
	self._goPlayer = gohelper.findChild(self.viewGO, "#go_strongHolds/#go_strongHold/#go_Player")
	self._goPlayerWin = gohelper.findChild(self.viewGO, "#go_strongHolds/#go_strongHold/#go_PlayerWin")
	self._goLine4 = gohelper.findChild(self.viewGO, "#go_strongHolds/#go_strongHold/#go_Line4")
	self._goLine6 = gohelper.findChild(self.viewGO, "#go_strongHolds/#go_strongHold/#go_Line6")
	self._gopower = gohelper.findChild(self.viewGO, "#go_strongHolds/#go_power")
	self._imagechessPower = gohelper.findChildImage(self.viewGO, "#go_strongHolds/#go_power/#image_chessPower")
	self._txtchessPower = gohelper.findChildText(self.viewGO, "#go_strongHolds/#go_power/#image_chessPower/#txt_chessPower")
	self._goHP = gohelper.findChild(self.viewGO, "#go_strongHolds/#go_HP")
	self._btnresult = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_result")
	self._goreslutvx = gohelper.findChild(self.viewGO, "#btn_result/#go_reslut_vx")
	self._goreslutvxloop = gohelper.findChild(self.viewGO, "#btn_result/#go_reslut_vx_loop")
	self._goSlot = gohelper.findChild(self.viewGO, "Bottom/#go_Slot")
	self._goresources = gohelper.findChild(self.viewGO, "Bottom/#go_resources")
	self._goresource = gohelper.findChild(self.viewGO, "Bottom/#go_resources/#go_resource")
	self._imageQuality = gohelper.findChildImage(self.viewGO, "Bottom/#go_resources/#go_resource/#image_Quality")
	self._txtResourceNum = gohelper.findChildText(self.viewGO, "Bottom/#go_resources/#go_resource/#image_Quality/#txt_ResourceNum")
	self._goResourceTips = gohelper.findChild(self.viewGO, "Bottom/#go_ResourceTips")
	self._txtopt = gohelper.findChildText(self.viewGO, "Bottom/#go_ResourceTips/#txt_opt")
	self._goaddResources = gohelper.findChild(self.viewGO, "Bottom/#go_ResourceTips/#go_addResources")
	self._goaddResource = gohelper.findChild(self.viewGO, "Bottom/#go_ResourceTips/#go_addResources/#go_addResource")
	self._btnmask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_mask")
	self._gomask = gohelper.findChild(self.viewGO, "#go_mask")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EliminateTeamChessView:addEvents()
	self._btnresult:AddClickListener(self._btnresultOnClick, self)
	self._btnmask:AddClickListener(self._btnmaskOnClick, self)
end

function EliminateTeamChessView:removeEvents()
	self._btnresult:RemoveClickListener()
	self._btnmask:RemoveClickListener()
end

function EliminateTeamChessView:_btnmaskOnClick()
	self:hideSoliderChessTip()
end

function EliminateTeamChessView:_btnresultOnClick()
	if not self._canClickResult then
		return
	end

	self._canClickResult = false

	EliminateTeamChessController.instance:sendWarChessRoundEndRequest(function()
		self:refreshViewByRoundState()

		self._canClickResult = true
	end, self)
end

function EliminateTeamChessView:setTipViewParent(parent, canvas)
	self._btnmask.transform:SetParent(parent.transform)
	EliminateTeamChessModel.instance:setTipViewParent(parent)

	self._powerParent = gohelper.create2d(parent, "powerParent")

	gohelper.setAsFirstSibling(self._powerParent)

	self._powerParentTr = self._powerParent.transform
end

function EliminateTeamChessView:_editableInitView()
	self._soliderTipView = nil

	self:hideSoliderChessTip()

	self._teamChessViewAni = self._viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._gostrongHolds, true)
	gohelper.setActive(self._gostrongHold, false)
end

function EliminateTeamChessView:onUpdateParam()
	return
end

function EliminateTeamChessView:onOpen()
	self.addEventCb(self, EliminateLevelController.instance, EliminateChessEvent.TeamChessWarInfoInit, self.initInfo, self)
	self.addEventCb(self, EliminateLevelController.instance, EliminateChessEvent.EliminateRoundStateChangeEnd, self.updateViewStateEnd, self)
	self.addEventCb(self, EliminateLevelController.instance, EliminateChessEvent.EliminateRoundStateChange, self.updateViewState, self)
	self.addEventCb(self, EliminateLevelController.instance, EliminateChessEvent.TeamChessViewWatchView, self.updateTeamChessViewWatchState, self)
	self.addEventCb(self, EliminateLevelController.instance, EliminateChessEvent.TeamChessSelectEffectEnd, self.onTeamChessSkillRelease, self)
	self.addEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.TeamChessItemBeginModelUpdated, self.teamChessItemDragBegin, self)
	self.addEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.TeamChessItemDragModelUpdated, self.teamChessItemDrag, self)
	self.addEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.TeamChessItemDragEndModelUpdated, self.teamChessItemDragEnd, self)
	self.addEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.AddStrongholdChess, self.addStrongholdChess, self)
	self.addEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.TeamChessPowerChange, self.teamChessPowerChange, self)
	self.addEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.StrongHoldPowerChange, self.strongHoldPowerChange, self)
	self.addEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.ResourceDataChange, self.resourceDataChange, self)
	self.addEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.TeamChessOnFlowEnd, self.flowEnd, self)
	self.addEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.RemoveStrongholdChess, self.removeStrongholdChess, self)
	self.addEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.StrongHoldSettle, self.strongHoldSettle, self)
	self.addEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.SoliderChessModelClick, self.soliderChessModelClick, self)
	self.addEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.ShowChessView, self.showSoliderChessTip, self)
	self.addEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.StrongHoldPerformReduction, self.strongHoldPerformReduction, self)
	self.addEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.TeamChessUpdateActiveMoveState, self.teamChessUpdateActiveMoveState, self)
	self.addEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.TeamChessGrowUpSkillChange, self.teamChessGrowUpValueChange, self)
	self.addEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.TeamChessOnFlowStart, self.teamChessOnFlowStart, self)
	self:initInfo()
end

function EliminateTeamChessView:onClose()
	return
end

function EliminateTeamChessView:onOpenFinish()
	return
end

function EliminateTeamChessView:initInfo()
	self._canClickResult = true

	self:initSlot()
	self:initStrongHold()
	self:initResource()
	self:refreshViewByRoundState()
end

function EliminateTeamChessView:updateViewState()
	local roundType = EliminateLevelModel.instance:getCurRoundType()
	local isTeamChess = roundType == EliminateEnum.RoundType.TeamChess

	if not isTeamChess and not gohelper.isNil(self._powerParent) then
		gohelper.setActive(self._powerParent, isTeamChess)
	end

	TeamChessUnitEntityMgr.instance:setAllEntityCanClick(isTeamChess)
	TeamChessUnitEntityMgr.instance:setAllEntityCanDrag(isTeamChess)
end

function EliminateTeamChessView:updateViewStateEnd()
	local roundType = EliminateLevelModel.instance:getCurRoundType()
	local isTeamChess = roundType == EliminateEnum.RoundType.TeamChess

	if isTeamChess then
		self:updateResourceDataChange()
		self:refreshAndSortSlot()

		if not gohelper.isNil(self._powerParent) then
			gohelper.setActive(self._powerParent, true)
		end

		self:refreshViewByRoundState()
		self:refreshActiveMoveState()
		self:refreshTotalScoreState()

		for i = 1, #self._strongHoldItems do
			self._strongHoldItems[i]:refreshAni(true)
		end
	end

	if isTeamChess and self._teamChessViewAni then
		self._teamChessViewAni:Play("open")
		TaskDispatcher.runDelay(self.refreshViewActive, self, 0.33)
	end

	EliminateTeamChessController.instance:setStartStepFlow(isTeamChess)
end

function EliminateTeamChessView:refreshViewActive()
	TaskDispatcher.cancelTask(self.refreshViewActive, self)
	EliminateTeamChessController.instance:startSeqStepFlow()
end

function EliminateTeamChessView:updateInfo()
	return
end

function EliminateTeamChessView:initSlot()
	self._slotList = self:getUserDataTb_()

	local slotIds = EliminateTeamChessModel.instance:getSlotIds()
	local path = self.viewContainer:getSetting().otherRes[1]

	for i, slotId in ipairs(slotIds) do
		local itemGO = self:getResInst(path, self._goSlot)
		local slotItem = MonoHelper.addNoUpdateLuaComOnceToGo(itemGO, EliminateTeamChessItem)

		table.insert(self._slotList, slotItem)
		slotItem:setSoliderId(slotId)
	end

	self:refreshAndSortSlot()
end

function EliminateTeamChessView:refreshAndSortSlot()
	if self._slotList == nil or #self._slotList < 1 then
		return
	end

	for i = 1, #self._slotList do
		local slotItem = self._slotList[i]

		slotItem:refreshView()
		slotItem:setChildIndex(i - 1)
	end
end

function EliminateTeamChessView:initStrongHold()
	local strongholds = EliminateTeamChessModel.instance:getStrongholds()

	self._strongHoldItems = self:getUserDataTb_()

	local maxlen = #strongholds

	for i = 1, maxlen do
		local data = strongholds[i]
		local id = data.id
		local strongHold = gohelper.clone(self._gostrongHold, self._gostrongHolds, id)
		local strongHoldItem = MonoHelper.addNoUpdateLuaComOnceToGo(strongHold, EliminateStrongHoldItem)

		strongHoldItem:initData(data, i, maxlen)

		local slotConfig = data:getStrongholdConfig()

		if slotConfig then
			local playerPath = self:_getResPathByCapacity(slotConfig.friendCapacity)
			local playerItemGO = self:getResInst(playerPath, strongHoldItem._goPlayer)
			local enemyPath = self:_getResPathByCapacity(slotConfig.enemyCapacity)
			local enemyItemGO = self:getResInst(enemyPath, strongHoldItem._goEnemy)

			strongHoldItem:initStrongHoldChess(playerItemGO, enemyItemGO, self._gopower, self._goHP)
		end

		gohelper.setActive(strongHold, true)

		self._strongHoldItems[#self._strongHoldItems + 1] = strongHoldItem
	end

	ZProj.UGUIHelper.RebuildLayout(self._gostrongHolds.transform)

	for _, strongHoldItem in ipairs(self._strongHoldItems) do
		if strongHoldItem then
			strongHoldItem:setPowerTrParent(self._powerParentTr)
		end
	end
end

function EliminateTeamChessView:initResource()
	local resources = EliminateTeamChessEnum.ResourceType

	self._resourceItem = self:getUserDataTb_()

	for resourceId, _ in pairs(resources) do
		local item = gohelper.clone(self._goresource, self._goresources, resourceId)
		local resourceImage = gohelper.findChildImage(item, "#image_Quality")
		local resourceNumberText = gohelper.findChildText(item, "#image_Quality/#txt_ResourceNum")
		local ani = item:GetComponent(typeof(UnityEngine.Animator))
		local number = EliminateTeamChessModel.instance:getResourceNumber(resourceId)
		local num = number and number or 0

		UISpriteSetMgr.instance:setV2a2EliminateSprite(resourceImage, EliminateTeamChessEnum.ResourceTypeToImagePath[resourceId], false)
		gohelper.setActive(item, true)

		resourceNumberText.text = num
		self._resourceItem[resourceId] = {
			item = item,
			resourceImage = resourceImage,
			resourceNumberText = resourceNumberText,
			ani = ani
		}
	end
end

function EliminateTeamChessView:_getResPathByCapacity(capacity)
	local otherResPath = self.viewContainer:getSetting().otherRes
	local path = otherResPath[2]

	if capacity > 4 and capacity <= 6 then
		path = otherResPath[3]
	end

	return (capacity > 6 or nil) and otherResPath[7]
end

function EliminateTeamChessView:teamChessItemDragBegin(soliderId, x, y)
	local entity = TeamChessUnitEntityMgr.instance:getEmptyEntity(nil, soliderId)
end

function EliminateTeamChessView:teamChessItemDrag(soliderId, uid, strongHoldId, x, y)
	local checkStrongHoldId = self:_checkStrongHoldInRect(x, y)

	if checkStrongHoldId and strongHoldId and checkStrongHoldId == strongHoldId then
		-- block empty
	end

	self:setStrongHoldSelect(soliderId, checkStrongHoldId)

	local entity = TeamChessUnitEntityMgr.instance:getEmptyEntity(nil, soliderId)

	if entity then
		if uid == nil then
			self:updateViewPositionByEntity(soliderId, EliminateTeamChessEnum.ChessTipType.showDragTip, entity, nil, (checkStrongHoldId or nil) and not EliminateTeamChessModel.instance:strongHoldIsFull(checkStrongHoldId))
		end

		if checkStrongHoldId ~= nil or strongHoldId ~= nil then
			if not EliminateTeamChessEnum.ModeType.Outline then
				local showModel = EliminateTeamChessEnum.ModeType.Normal

				entity:setShowModeType(showModel)
			end
		end
	end

	self:setViewCanvasGroupActive(checkStrongHoldId ~= nil)
end

function EliminateTeamChessView:teamChessItemDragEnd(soliderId, uid, strongHoldId, x, y)
	local checkStrongHoldId = self:_checkStrongHoldInRect(x, y)

	if checkStrongHoldId and strongHoldId and checkStrongHoldId == strongHoldId then
		checkStrongHoldId = nil
	end

	if checkStrongHoldId ~= nil then
		local canPlace = EliminateTeamChessModel.instance:isCanPlaceByStrongHoldRule(checkStrongHoldId, soliderId)

		if canPlace or uid ~= nil then
			EliminateTeamChessController.instance:createPlaceSkill(soliderId, uid, checkStrongHoldId)

			self._placeSkillReleaseSuccess = EliminateTeamChessController.instance:checkAndReleasePlaceSkill()

			if not self._placeSkillReleaseSuccess then
				EliminateTeamChessController.instance:addTempChessAndPlace(soliderId, uid, checkStrongHoldId)

				local tr = self._gostrongHolds.transform
				local height = recthelper.getHeight(tr)
				local width = recthelper.getWidth(tr)

				EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamChessSelectEffectBegin, width, height)
			end
		end
	end

	local entity = TeamChessUnitEntityMgr.instance:getEmptyEntity(nil, soliderId)

	if entity then
		entity:setShowModeType(EliminateTeamChessEnum.ModeType.Normal)
	end

	self:teamChessUpdateActiveMoveState(uid)
	self:setStrongHoldSelect(soliderId, nil)
	self:hideSoliderChessTip()
end

function EliminateTeamChessView:_checkStrongHoldInRect(x, y)
	if self._strongHoldItems == nil then
		return nil
	end

	local strongHoldId

	for _, item in pairs(self._strongHoldItems) do
		if item:checkInPlayerChessRect(x, y) and item._data then
			strongHoldId = item._data.id

			break
		end
	end

	return strongHoldId
end

function EliminateTeamChessView:setStrongHoldSelect(soliderId, strongHoldId)
	if self._strongHoldItems == nil then
		return
	end

	for i = 1, #self._strongHoldItems do
		self._strongHoldItems[i]:setStrongHoldSelect(soliderId, strongHoldId)
	end
end

function EliminateTeamChessView:addStrongholdChess(data, strongholdId, index)
	if self._strongHoldItems == nil then
		return
	end

	for i = 1, #self._strongHoldItems do
		self._strongHoldItems[i]:addStrongholdChess(data, strongholdId, index)
	end

	self:refreshTotalScoreState()
end

function EliminateTeamChessView:removeStrongholdChess(strongholdId, uid, index, teamType)
	if self._strongHoldItems == nil then
		return
	end

	for i = 1, #self._strongHoldItems do
		self._strongHoldItems[i]:removeStrongholdChess(strongholdId, uid, index, teamType)
	end

	self:refreshTotalScoreState()
end

function EliminateTeamChessView:strongHoldSettle(strongholdId)
	if self._strongHoldItems == nil then
		return
	end

	for i = 1, #self._strongHoldItems do
		self._strongHoldItems[i]:strongHoldSettle(strongholdId)
	end
end

function EliminateTeamChessView:strongHoldPerformReduction()
	if self._strongHoldItems == nil then
		return
	end

	for i = 1, #self._strongHoldItems do
		self._strongHoldItems[i]:strongHoldSettleResetShow()
	end
end

function EliminateTeamChessView:teamChessUpdateActiveMoveState(uid)
	if self._strongHoldItems == nil then
		return
	end

	for i = 1, #self._strongHoldItems do
		self._strongHoldItems[i]:teamChessUpdateActiveMoveState(uid)
	end
end

function EliminateTeamChessView:refreshActiveMoveState()
	TeamChessUnitEntityMgr.instance:refreshShowModeStateByTeamType(EliminateTeamChessEnum.TeamChessTeamType.player)
end

function EliminateTeamChessView:teamChessPowerChange(uid, diffValue)
	if self._strongHoldItems == nil then
		return
	end

	for i = 1, #self._strongHoldItems do
		self._strongHoldItems[i]:teamChessPowerChange(uid, diffValue)
	end
end

function EliminateTeamChessView:teamChessGrowUpValueChange(uid, skillId, upValue)
	if self._strongHoldItems == nil then
		return
	end

	for i = 1, #self._strongHoldItems do
		self._strongHoldItems[i]:teamChessGrowUpValueChange(uid, skillId, upValue)
	end
end

function EliminateTeamChessView:strongHoldPowerChange(strongholdId, teamType, diffValue)
	if self._strongHoldItems == nil then
		return
	end

	for i = 1, #self._strongHoldItems do
		self._strongHoldItems[i]:strongHoldPowerChange(strongholdId, teamType, diffValue)
	end

	self:refreshTotalScoreState()
end

function EliminateTeamChessView:resourceDataChange(resourceIdMap)
	for resourceId, _ in pairs(resourceIdMap) do
		if not self._resourceItem or not self._resourceItem[resourceId] then
			return
		end
	end

	self.showAddResourceView(self, self.updateResourceDataChange, self, resourceIdMap)
	self:refreshAndSortSlot()
	self:refreshTotalScoreState()
end

function EliminateTeamChessView:showAddResourceView(cb, cbTarget, resourceMap)
	local num = tabletool.len(resourceMap)
	local index = 1

	if self._addResourceItem == nil then
		self._addResourceItem = self:getUserDataTb_()
	end

	for resourceId, diffValue in pairs(resourceMap) do
		self._txtopt.text = diffValue > 0 and "＋" or "－"

		local item = self._addResourceItem[index]

		if item == nil then
			item = gohelper.clone(self._goaddResource, self._goaddResources, resourceId)

			local resourceImage = gohelper.findChildImage(item, "#image_Quality")
			local resourceNumberText = gohelper.findChildText(item, "#image_Quality/#txt_ResourceNum")

			UISpriteSetMgr.instance:setV2a2EliminateSprite(resourceImage, EliminateTeamChessEnum.ResourceTypeToImagePath[resourceId], false)

			resourceNumberText.text = math.abs(diffValue and diffValue or 0)

			gohelper.setActive(item, true)
			table.insert(self._addResourceItem, {
				item = item,
				resourceImage = resourceImage,
				resourceNumberText = resourceNumberText
			})
		elseif item.resourceImage and item.resourceNumberText then
			UISpriteSetMgr.instance:setV2a2EliminateSprite(item.resourceImage, EliminateTeamChessEnum.ResourceTypeToImagePath[resourceId], false)

			item.resourceNumberText.text = math.abs(diffValue and diffValue or 0)

			gohelper.setActive(item.item, true)
		end

		index = index + 1
	end

	gohelper.setActive(self._goResourceTips, true)
	TaskDispatcher.runDelay(function()
		gohelper.setActive(self._goResourceTips, false)

		for i = 1, #self._addResourceItem do
			gohelper.setActive(self._addResourceItem[i].item, false)
		end

		if cb then
			cb(cbTarget, resourceMap)
		end
	end, nil, EliminateTeamChessEnum.addResourceTipTime)
end

function EliminateTeamChessView:updateResourceDataChange(resourceMap)
	if self._resourceItem == nil then
		return
	end

	if resourceMap ~= nil then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_sources_lit)
	end

	for resourceId, item in pairs(self._resourceItem) do
		local number = EliminateTeamChessModel.instance:getResourceNumber(resourceId)

		if item.resourceNumberText then
			item.resourceNumberText.text = number
		end
	end

	if resourceMap then
		for resourceId, _ in pairs(resourceMap) do
			local item = self._resourceItem[resourceId]

			if item and item.ani then
				item.ani:Play("add", 0, 0)
			end
		end
	end
end

function EliminateTeamChessView:showSoliderChessTip(soliderId, uid, strongholdId, showType, entity, offsetData)
	if self._soliderTipView == nil then
		local tipPath = self.viewContainer:getSetting().otherRes[6]
		local playerItemGO = self:getResInst(tipPath, self._btnmask.gameObject)

		self._soliderTipView = MonoHelper.addNoUpdateLuaComOnceToGo(playerItemGO, EliminateChessTipView)

		self._soliderTipView:setSellCb(self.hideSoliderChessTip, self)
	end

	self._soliderTipView:setChessUidAndStrongHoldId(uid, strongholdId)
	self._soliderTipView:setSoliderIdAndShowType(soliderId, showType)

	if self._soliderTipView then
		self._soliderTipView:updateViewPositionByEntity(entity, offsetData)
	end

	gohelper.setActive(self._btnmask, true)
end

function EliminateTeamChessView:updateViewPositionByEntity(soliderId, showType, entity, offsetData, showAdd)
	if self._soliderTipView == nil or not self._btnmask.gameObject.activeSelf then
		self:showSoliderChessTip(soliderId, nil, nil, showType, entity, offsetData)
	end

	if self._soliderTipView then
		self._soliderTipView:updateViewPositionByEntity(entity, offsetData, showAdd)
	end
end

function EliminateTeamChessView:setViewCanvasGroupActive(active)
	if self._soliderTipView then
		self._soliderTipView:setViewActive(active)
	end
end

function EliminateTeamChessView:hideSoliderChessTip()
	if self._soliderTipView then
		self._soliderTipView:hideView()
	end

	gohelper.setActive(self._btnmask, false)
end

function EliminateTeamChessView:refreshViewByRoundState()
	local roundStepState = EliminateTeamChessModel.instance:getCurTeamRoundStepState()

	gohelper.setActive(self._goSlot, roundStepState == EliminateTeamChessEnum.TeamChessRoundType.player)
	gohelper.setActive(self._goresources, roundStepState == EliminateTeamChessEnum.TeamChessRoundType.player)
	gohelper.setActive(self._btnresult, roundStepState == EliminateTeamChessEnum.TeamChessRoundType.player)

	if self._strongHoldItems == nil then
		return
	end

	for i = 1, #self._strongHoldItems do
		self._strongHoldItems[i]:refreshViewByRoundState(roundStepState)
	end
end

function EliminateTeamChessView:updateTeamChessViewWatchState(state)
	gohelper.setActive(self._goSlot, not state)
	gohelper.setActive(self._goresources, not state)
	gohelper.setActive(self._btnresult, not state)

	if not gohelper.isNil(self._powerParent) then
		gohelper.setActive(self._powerParent, state)
	end

	if not state then
		self:hideSoliderChessTip()
	end

	for i = 1, #self._strongHoldItems do
		self._strongHoldItems[i]:refreshAni(state)
	end
end

function EliminateTeamChessView:soliderChessModelClick(soliderId, uid, strongholdId, showType, entity, offsetData)
	if self._placeSkillReleaseSuccess == nil or self._placeSkillReleaseSuccess then
		self:showSoliderChessTip(soliderId, uid, strongholdId, showType, entity, offsetData)

		return
	end

	local placeSkill = EliminateTeamChessController.instance:getPlaceSkill()

	if placeSkill then
		local state = placeSkill:setSelectSoliderId(uid)

		if state then
			self._placeSkillReleaseSuccess = EliminateTeamChessController.instance:checkAndReleasePlaceSkill()
		end
	end
end

function EliminateTeamChessView:onTeamChessSkillRelease()
	self._placeSkillReleaseSuccess = nil
end

function EliminateTeamChessView:flowEnd()
	local levelId = EliminateLevelModel.instance:getLevelId()
	local count = EliminateTeamChessModel.instance:getAllPlayerSoliderCount()
	local value = string.format("%s_%s", levelId, count)

	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamChessRoundBeginAndPlayerSoliderCount, value)
	self:setClickMaskState(false)
end

function EliminateTeamChessView:teamChessOnFlowStart()
	self:setClickMaskState(true)
end

function EliminateTeamChessView:setClickMaskState(active)
	local result = EliminateTeamChessModel.instance:getWarFightResult()

	if result ~= nil then
		return
	end

	TeamChessUnitEntityMgr.instance:setAllEntityCanClick(not active)
	TeamChessUnitEntityMgr.instance:setAllEntityCanDrag(not active)
	gohelper.setActive(self._gomask.gameObject, active)
end

function EliminateTeamChessView:refreshTotalScoreState()
	local roundState = EliminateTeamChessModel.instance:getCurTeamRoundStepState()

	if roundState == EliminateTeamChessEnum.TeamChessRoundType.player then
		local isShowVx = false

		if not EliminateTeamChessModel.instance:allStrongHoldIsIsFull() then
			local haveEnoughResource = EliminateTeamChessModel.instance:haveEnoughResource()
			local canReleaseSkillAddResource = EliminateTeamChessModel.instance:canReleaseSkillAddResource()

			logNormal("haveEnoughResource", tostring(haveEnoughResource), "canReleaseSkillAddResource", tostring(canReleaseSkillAddResource))

			isShowVx = not haveEnoughResource and not canReleaseSkillAddResource
		end

		gohelper.setActive(self._goreslutvxloop, isShowVx)
	end
end

function EliminateTeamChessView:onDestroyView()
	self._powerParentTr = nil

	if self._powerParent then
		gohelper.destroy(self._powerParent)

		self._powerParent = nil
	end

	TaskDispatcher.cancelTask(self.refreshViewActive, self)

	if self._soliderTipView then
		self._soliderTipView:onDestroy()

		self._soliderTipView = nil
	end
end

return EliminateTeamChessView
