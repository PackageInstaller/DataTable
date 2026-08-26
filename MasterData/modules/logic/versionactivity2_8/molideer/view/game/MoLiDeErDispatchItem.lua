-- chunkname: @modules/logic/versionactivity2_8/molideer/view/game/MoLiDeErDispatchItem.lua

module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErDispatchItem", package.seeall)

local MoLiDeErDispatchItem = class("MoLiDeErDispatchItem", LuaCompBase)

function MoLiDeErDispatchItem:init(go)
	self.viewGO = go
	self._goItemList = gohelper.findChild(self.viewGO, "#go_ItemList")
	self._goItem = gohelper.findChild(self.viewGO, "#go_ItemList/#go_Item")
	self._simageProp = gohelper.findChildSingleImage(self.viewGO, "#go_ItemList/#go_Item/#simage_Prop")
	self._txtNum = gohelper.findChildText(self.viewGO, "#go_ItemList/#go_Item/#txt_Num")
	self._goAction = gohelper.findChild(self.viewGO, "#go_Action")
	self._goLightBG = gohelper.findChild(self.viewGO, "#go_Action/#go_LightBG")
	self._goLightBgFx = gohelper.findChild(self.viewGO, "#go_Action/#go_LightBG/#go_LightBgFx")
	self._txtActionNum = gohelper.findChildText(self.viewGO, "#go_Action/#txt_ActionNum")
	self._txtActionNumChange = gohelper.findChildText(self.viewGO, "#go_Action/#txt_ActionNum/#txt_ActionNumChange")
	self._goDispatch = gohelper.findChild(self.viewGO, "#go_Dispatch")
	self._goExpand = gohelper.findChild(self.viewGO, "#go_Dispatch/#go_Expand")
	self._goSelectRole = gohelper.findChild(self.viewGO, "#go_Dispatch/#go_Expand/#go_SelectRole")
	self._goSelected = gohelper.findChild(self.viewGO, "#go_Dispatch/#go_Expand/#go_SelectRole/image_HeadBG/#go_Selected")
	self._simageHead = gohelper.findChildSingleImage(self.viewGO, "#go_Dispatch/#go_Expand/#go_SelectRole/image_HeadBG/image/#simage_Head")
	self._goCD = gohelper.findChild(self.viewGO, "#go_Dispatch/#go_Expand/#go_SelectRole/image_HeadBG/#go_CD")
	self._txtTeamDescr = gohelper.findChildText(self.viewGO, "#go_Dispatch/#go_Expand/#txt_TeamDescr")
	self._txtTeamName = gohelper.findChildText(self.viewGO, "#go_Dispatch/#go_Expand/#txt_TeamDescr/#txt_TeamName")
	self._goRole = gohelper.findChild(self.viewGO, "#go_Dispatch/#go_Role")
	self._btnDispatch = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Dispatch/#btn_Dispatch")
	self._btnWithdraw = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Dispatch/#btn_Withdraw")
	self._goBG1 = gohelper.findChild(self.viewGO, "#go_Dispatch/#btn_Dispatch/#go_BG1")
	self._goBG2 = gohelper.findChild(self.viewGO, "#go_Dispatch/#btn_Dispatch/#go_BG2")
	self._goTips = gohelper.findChild(self.viewGO, "#go_Tips")
	self._btnUseItem = gohelper.findChildButton(self.viewGO, "#go_Tips/#btn_Use")
	self._txtTips = gohelper.findChildText(self.viewGO, "#go_Tips/#txt_Tips")
	self._goDispatchTitle = gohelper.findChild(self.viewGO, "#go_Dispatch/#go_DispatchTitle")
	self._goWithdrawTitle = gohelper.findChild(self.viewGO, "#go_Dispatch/#go_Expand/#go_WithdrawTitle")
	self._btnResetSelect = gohelper.findChildButton(self.viewGO, "#btn_ResetSelect")
	self._imageBg = gohelper.findChildImage(self.viewGO, "#go_Dispatch")
	self._imageBgFrame = gohelper.findChildImage(self.viewGO, "#go_Dispatch/image_Frame")
	self._goActionChangeItem = gohelper.findChildText(self.viewGO, "#go_Action/#go_Num/#txt_Num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MoLiDeErDispatchItem:addEventListeners()
	self._btnDispatch:AddClickListener(self._btnDispatchOnClick, self)
	self._btnWithdraw:AddClickListener(self._btnWithdrawOnClick, self)
	self._btnResetSelect:AddClickListener(self._btnResetSelectOnClick, self)
	self._btnUseItem:AddClickListener(self._btnUseItemOnClick, self)
	self.addEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameItemSelect, self.onItemSelect, self)
	self.addEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameTeamSelect, self.onTeamSelect, self)
	self.addEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameOptionSelect, self.onOptionSelect, self)
	self.addEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameUseItem, self.onUseItem, self)
end

function MoLiDeErDispatchItem:removeEventListeners()
	self._btnDispatch:RemoveClickListener()
	self._btnWithdraw:RemoveClickListener()
	self._btnResetSelect:RemoveClickListener()
	self._btnUseItem:RemoveClickListener()
	self.removeEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameItemSelect, self.onItemSelect, self)
	self.removeEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameTeamSelect, self.onTeamSelect, self)
	self.removeEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameOptionSelect, self.onOptionSelect, self)
	self.removeEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.GameUseItem, self.onUseItem, self)
end

function MoLiDeErDispatchItem:_btnDispatchOnClick()
	local actId = MoLiDeErModel.instance:getCurActId()
	local episodeId = MoLiDeErModel.instance:getCurEpisodeId()
	local teamId = MoLiDeErGameModel.instance:getSelectTeamId()
	local optionId = MoLiDeErGameModel.instance:getSelectOptionId()
	local eventId = MoLiDeErGameModel.instance:getSelectEventId()

	MoLiDeErGameController.instance:dispatchTeam(actId, episodeId, eventId, teamId, optionId, eventId)
end

function MoLiDeErDispatchItem:_btnWithdrawOnClick()
	local eventId = MoLiDeErGameModel.instance:getSelectEventId()
	local curGameInfoMo = MoLiDeErGameModel.instance:getCurGameInfo()
	local eventInfo = curGameInfoMo:getEventInfo(eventId)

	if not eventInfo or eventInfo.teamId == nil or eventInfo.teamId == 0 then
		logError("莫莉德尔 角色活动 撤回小队id为空")

		return
	end

	local teamId = eventInfo.teamId

	MoLiDeErGameController.instance:withDrawTeam(teamId)
end

function MoLiDeErDispatchItem:_btnResetSelectOnClick()
	MoLiDeErGameModel.instance:setSelectItemId(nil)

	if self._state == MoLiDeErEnum.DispatchState.Main or self._state == MoLiDeErEnum.DispatchState.Dispatch and self._optionId == nil then
		MoLiDeErGameModel.instance:setSelectTeamId(nil)
	end
end

function MoLiDeErDispatchItem:_btnUseItemOnClick()
	local selectItemId = MoLiDeErGameModel.instance:getSelectItemId()

	if selectItemId == nil then
		return
	end

	local info = MoLiDeErGameModel.instance:getCurGameInfo()

	if info:canEquipUse(selectItemId) == false then
		GameFacade.showToast(ToastEnum.Act194EquipCountNotEnough)

		return
	end

	local actId = MoLiDeErModel.instance:getCurActId()
	local episodeId = MoLiDeErModel.instance:getCurEpisodeId()

	MoLiDeErGameController.instance:useItem(actId, episodeId, selectItemId)
end

function MoLiDeErDispatchItem:_editableInitView()
	self._equipItemList = {}
	self._teamItemList = {}
	self._useActionChangeItemList = {}
	self._unUseActionChangeItemList = {}
	self._expandTeamItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._goSelectRole, MoLiDeErTeamItem)
	self._showItemList = {}

	self:_initState()
end

function MoLiDeErDispatchItem:_initState()
	gohelper.setActive(self._goItem, false)
	gohelper.setActive(self._goRole, false)
	gohelper.setActive(self._goExpand, false)
	gohelper.setActive(self._goTips, false)
	gohelper.setActive(self._goBG2.gameObject, false)
	gohelper.setActive(self._btnResetSelect.gameObject, false)
	gohelper.setActive(self._imageBgFrame.gameObject, true)
	gohelper.setActive(self._goActionChangeItem.transform.parent.gameObject, false)

	self._imageBg.enabled = false
end

function MoLiDeErDispatchItem:setData(state, eventId, optionId)
	self._state = state
	self._eventId = eventId
	self._optionId = optionId

	self:refreshUI()
end

function MoLiDeErDispatchItem:onOptionSelect(optionId)
	self._optionId = optionId
end

function MoLiDeErDispatchItem:refreshUI()
	self:refreshItem()
	self:refreshTeam()
	self:refreshState()
end

function MoLiDeErDispatchItem:refreshState()
	local selectOptionID = self._optionId ~= nil and self._optionId ~= 0

	gohelper.setActive(self._goBG2, selectOptionID and self._selectTeamId ~= nil)

	local canDispatch = self._state == MoLiDeErEnum.DispatchState.Dispatch and selectOptionID

	gohelper.setActive(self._btnDispatch, canDispatch)
	gohelper.setActive(self._txtActionNumChange, canDispatch)
	gohelper.setActive(self._goDispatchTitle, canDispatch)
	gohelper.setActive(self._goAction, canDispatch or self._state == MoLiDeErEnum.DispatchState.Main)

	local canWithdraw = self._state == MoLiDeErEnum.DispatchState.Dispatching and selectOptionID

	gohelper.setActive(self._btnWithdraw, canWithdraw)
	gohelper.setActive(self._goWithdrawTitle, canWithdraw)

	self._imageBg.enabled = self._state == MoLiDeErEnum.DispatchState.Dispatch or self._state == MoLiDeErEnum.DispatchState.Dispatching

	if canDispatch then
		local executionCost = MoLiDeErGameModel.instance:getCurExecutionCost()

		self._txtActionNumChange.text = MoLiDeErHelper.getExecutionCostStr(executionCost)

		gohelper.setActive(self._goLightBgFx, executionCost ~= 0)
	else
		gohelper.setActive(self._goLightBgFx, false)
	end

	self:refreshActionCount()
end

function MoLiDeErDispatchItem:refreshActionCount()
	local gameInfoMo = MoLiDeErGameModel.instance:getCurGameInfo()
	local executionCount = gameInfoMo.leftRoundEnergy
	local previousExecutionCount = gameInfoMo.previousRoundEnergy
	local txtItem = self._goActionChangeItem

	if self._state == MoLiDeErEnum.DispatchState.Main and previousExecutionCount and previousExecutionCount ~= executionCount then
		TaskDispatcher.cancelTask(self.onActionNumChangeEnd, self)

		txtItem.text = MoLiDeErHelper.getExecutionCostStr(executionCount - previousExecutionCount)

		gohelper.setActive(txtItem.transform.parent.gameObject, true)
		TaskDispatcher.runDelay(self.onActionNumChangeEnd, self, 1)

		gameInfoMo.previousRoundEnergy = gameInfoMo.leftRoundEnergy

		AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_gudu_bubble_click)
	else
		gohelper.setActive(txtItem.transform.parent.gameObject, false)
	end

	self._txtActionNum.text = tostring(executionCount)
end

function MoLiDeErDispatchItem:onActionNumChangeEnd()
	TaskDispatcher.cancelTask(self.onActionNumChangeEnd, self)
	gohelper.setActive(self._goActionChangeItem.transform.parent.gameObject, false)
end

function MoLiDeErDispatchItem:refreshItem()
	if self._showItemList and self._showItemList[1] then
		self:refreshItemCount()
		TaskDispatcher.cancelTask(self.refreshItemWithHide, self)

		if self._state ~= MoLiDeErEnum.DispatchState.Main then
			local gameInfo = MoLiDeErGameModel.instance:getCurGameInfo()

			if gameInfo and gameInfo.newFinishEventList and gameInfo.newFinishEventList[1] then
				return
			end
		end

		TaskDispatcher.runDelay(self.refreshItemWithHide, self, MoLiDeErEnum.DelayTime.ItemHideOrAppear)
	else
		self:refreshItemWithHide()
	end
end

function MoLiDeErDispatchItem:refreshItemCount(hideUseFx)
	local gameInfo = MoLiDeErGameModel.instance:getCurGameInfo()

	for _, item in ipairs(self._showItemList) do
		local itemId = item.itemId
		local info = gameInfo:getEquipInfo(itemId)

		if info == nil then
			item:reset()

			return
		end

		item:refreshUI()

		if hideUseFx then
			item:setUseFxState(false)
		end
	end
end

function MoLiDeErDispatchItem:refreshItemWithHide()
	self._showItemList = {}

	local gameInfo = MoLiDeErGameModel.instance:getCurGameInfo()
	local equipInfoList = gameInfo.itemInfos

	if equipInfoList == nil then
		gohelper.setActive(self._goItemList, false)

		return
	end

	local equipCount = #equipInfoList

	if equipCount <= 0 then
		gohelper.setActive(self._goItemList, false)

		return
	end

	local tempList = {}
	local showCount = 0

	for i = 1, equipCount do
		local info = equipInfoList[i]

		if info.quantity > 0 then
			table.insert(tempList, info)

			showCount = showCount + 1
		end
	end

	if showCount <= 0 then
		gohelper.setActive(self._goItemList, false)
		gohelper.setActive(self._goTips, false)

		return
	end

	gohelper.setActive(self._goItemList, true)

	local itemList = self._equipItemList
	local equipItemCount = #itemList

	for i = 1, showCount do
		local item

		if equipItemCount < i then
			local itemGo = gohelper.clone(self._goItem, self._goItemList)

			item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, MoLiDeErEquipItem)

			table.insert(itemList, item)
		else
			item = itemList[i]
		end

		local info = tempList[i]

		item:setActive(true)
		item:setData(info.itemId)
		item:setUseFxState(false)
		table.insert(self._showItemList, item)
	end

	if showCount < equipItemCount then
		for i = showCount + 1, equipItemCount do
			local item = itemList[i]

			item:reset()
		end
	end
end

function MoLiDeErDispatchItem:onUseItem(useItemId)
	if self.viewGO.activeSelf == false then
		return
	end

	local itemList = self._equipItemList
	local equipItemCount = #itemList

	for i = 1, equipItemCount do
		local item = itemList[i]

		if item.viewGO.activeSelf and item.itemId == useItemId then
			item:setUseFxState(true)
			AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_molu_exit_appear)
		end
	end

	local gameInfo = MoLiDeErGameModel.instance:getCurGameInfo()
	local itemInfo = gameInfo:getEquipInfo(useItemId)

	if itemInfo.quantity <= 0 then
		gohelper.setActive(self._goTips, false)
	end

	if self._state == MoLiDeErEnum.DispatchState.Main then
		return
	end

	self:refreshItem()
	self:refreshState()
end

function MoLiDeErDispatchItem:refreshTeam()
	local state = self._state

	if state == MoLiDeErEnum.DispatchState.Dispatching then
		self:refreshDispatchingTeam()
	else
		self:refreshDispatchTeam()
	end
end

function MoLiDeErDispatchItem:refreshDispatchTeam()
	local gameInfo = MoLiDeErGameModel.instance:getCurGameInfo()
	local teamInfoList = gameInfo.teamInfos

	if teamInfoList == nil then
		gohelper.setActive(self._goDispatch, false)

		return
	end

	local teamCount = #teamInfoList

	if teamCount <= 0 then
		gohelper.setActive(self._goDispatch, false)

		return
	end

	local teamItemList = self._teamItemList
	local itemCount = #teamItemList

	for i = 1, teamCount do
		local item

		if itemCount < i then
			local itemGo = gohelper.clone(self._goRole, self._goDispatch)

			gohelper.setSiblingBefore(itemGo, self._btnDispatch.gameObject)

			item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, MoLiDeErTeamItem)

			table.insert(teamItemList, item)
		else
			item = teamItemList[i]
		end

		local info = teamInfoList[i]

		item:setActive(true)
		item:setData(info, self._state)
		item:setSelect(false)
	end

	if teamCount < itemCount then
		for i = teamCount + 1, itemCount do
			local item = teamItemList[i]

			item:setActive(false)
			item:clear()
		end
	end
end

function MoLiDeErDispatchItem:refreshDispatchingTeam()
	for _, item in ipairs(self._teamItemList) do
		item:setActive(false)
	end

	local eventId = MoLiDeErGameModel.instance:getSelectEventId()
	local curGameInfoMo = MoLiDeErGameModel.instance:getCurGameInfo()
	local eventInfo = curGameInfoMo:getEventInfo(eventId)

	if eventInfo then
		self:showTeamTips(true, eventInfo.teamId)
	end
end

function MoLiDeErDispatchItem:onItemSelect(selectItemId)
	self:showItemTips(selectItemId ~= nil, selectItemId)

	self._selectItemId = selectItemId

	if self.viewGO.activeSelf == false then
		return
	end

	self:refreshState()
end

function MoLiDeErDispatchItem:onTeamSelect(selectTeamId)
	if self.viewGO.activeSelf == false then
		return
	end

	self:showTeamTips(selectTeamId ~= nil, selectTeamId)

	if self._state == MoLiDeErEnum.DispatchState.Dispatch then
		for _, item in ipairs(self._teamItemList) do
			item:refreshState()
		end
	end

	self._selectTeamId = selectTeamId

	self:refreshState()
end

function MoLiDeErDispatchItem:showItemTips(active, selectItemId)
	gohelper.setActive(self._goTips, active)
	gohelper.setActive(self._btnResetSelect, active)

	if active == false then
		return
	end

	local itemConfig = MoLiDeErConfig.instance:getItemConfig(selectItemId)
	local canUse = itemConfig.isUse == MoLiDeErEnum.ItemType.Initiative

	gohelper.setActive(self._btnUseItem, canUse)

	local buffConfig = MoLiDeErConfig.instance:getBuffConfig(tonumber(itemConfig.buffId))

	self._txtTips.text = buffConfig.effectDesc
end

function MoLiDeErDispatchItem:setTeamSelect(selectId)
	for _, item in ipairs(self._teamItemList) do
		local isSelect = item.teamId == selectId

		if isSelect then
			gohelper.setSiblingAfter(self._goExpand, item.viewGO)
		end

		item:setSelect(isSelect)
	end
end

function MoLiDeErDispatchItem:showTeamTips(active, selectTeamId)
	gohelper.setActive(self._goExpand, active)

	if self._state == MoLiDeErEnum.DispatchState.Main or self._state == MoLiDeErEnum.DispatchState.Dispatch and self._optionId == nil and self._optionId ~= 0 then
		gohelper.setActive(self._btnResetSelect, active)
	end

	self:setTeamSelect(selectTeamId)

	if active == false then
		return
	end

	local teamConfig = MoLiDeErConfig.instance:getTeamConfig(selectTeamId)

	self._txtTeamName.text = teamConfig.name

	local teamItem = self._expandTeamItem

	teamItem:setActive(true)

	local gameInfo = MoLiDeErGameModel.instance:getCurGameInfo()
	local teamInfo = gameInfo:getTeamInfo(selectTeamId)

	teamItem:setData(teamInfo, self._state)

	local haveBuff = not string.nilorempty(teamConfig.buffId)

	if not haveBuff then
		self._txtTeamDescr.text = ""

		return
	end

	local buffConfig = MoLiDeErConfig.instance:getBuffConfig(tonumber(teamConfig.buffId))

	self._txtTeamDescr.text = buffConfig.effectDesc
end

function MoLiDeErDispatchItem:onDestroy()
	TaskDispatcher.cancelTask(self.onActionNumChangeEnd, self)
	TaskDispatcher.cancelTask(self.refreshItemWithHide, self)
end

return MoLiDeErDispatchItem
