-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/free/AirWorkShopFreeLevelSelectView.lua

module("logic.extensions.airworkshop.view.free.AirWorkShopFreeLevelSelectView", package.seeall)

local M = class("AirWorkShopFreeLevelSelectView", ViewComponent)

function M:buildUI()
	self._canvasGroup = goutil.addComponentOnce(self.mainGO, ComponentType.CanvasGroup)
	self._goPanelMatch = self:getGo("free_mode_level_select_view_-1386081091")
	self._cellLevelMatch = Astral.SimpleLuaComponentContainer.Add(self:getGo("0&select_level_item_-4960105"), AirWorkShopSelectLevelCell)

	self._cellLevelMatch:setClickCheckFunction(self._onClickRandomMatch, self)
	self._cellLevelMatch:setSelect(true)

	self._btnRefreshMatch = self:getBtn("free_mode_level_select_view_-1214351133")
	self._goPanelEndless = self:getGo("free_mode_level_select_view_28410314")
	self._rectTrEndlessLife = self:getUIComponent("free_mode_level_select_view_1561088221", UIComponentType.RectTransform)

	goutil.setActive(self._rectTrEndlessLife.gameObject, true)

	self._endlessLife = {
		self:getGo("free_mode_level_select_view_-2145803127"),
		self:getGo("free_mode_level_select_view_2116042705"),
		self:getGo("free_mode_level_select_view_607242548")
	}
	self._btnGiveUpEndless = self:getBtn("free_mode_level_select_view_962460883")
	self._scrollEndless = self:getUIComponent("free_mode_level_select_view_1133917051", UIComponentType.ScrollRect)
	self._loopListEndless = LoopListHelper.New(self._scrollEndless.gameObject)

	self._loopListEndless:InitListView(0, self._onCellEndlessUpdate, self)
end

function M:destroyUI()
	self._loopListEndless:Dispose()

	self._loopListEndless = nil
end

function M:bindEvents()
	self._btnRefreshMatch:AddClickListener(self._onClickRefreshMatch, self)
	self._btnGiveUpEndless:AddClickListener(self._onClickGiveUpEndless, self)
end

function M:unbindEvents()
	self._btnRefreshMatch:RemoveClickListener()
	self._btnGiveUpEndless:RemoveClickListener()
end

function M:onEnter()
	self._canvasGroup.interactable = true

	self:setEvent(true)

	local info = self:getFirstParam() or {}

	self._airPlayType = info.airPlayType
	self._cfgId = info.id
	self._isEndless = info.airPlayType == AirAtkExtension_pb.AirPlayType.ENDLESS

	goutil.setActive(self._goPanelEndless, self._isEndless)
	goutil.setActive(self._goPanelMatch, not self._isEndless)

	if self._isEndless then
		local infoMo = AirWorkShopFreeModel.instance:getEndlessPlayerInfoMo()

		if Astral.OSDef.isEditor then
			TableUtil.dump(infoMo)
			printWarn(infoMo:getStatusMsg())
		end

		self:_refreshEndlessLife(infoMo:getCurLife())

		self._endlessLevelNOLst = {}

		TableUtil.addRange(self._endlessLevelNOLst, infoMo:getRecordLst() or {})

		if infoMo:getMatchLevelNO() and infoMo:getMatchLevelNO().mapId and tonumber(infoMo:getMatchLevelNO().mapId) > 0 then
			self._waitReMatchEndless = false

			table.insert(self._endlessLevelNOLst, infoMo:getMatchLevelNO())
		else
			self._waitReMatchEndless = true
		end

		self:_refreshEndlessLst()

		if self._waitReMatchEndless then
			AirWorkShopAtkAgent.instance:sendEndlessMatchRequest()
		end
	else
		self._cellLevelMatch:setActive(false)
		AirWorkShopAtkAgent.instance:sendFreeMatchRequest(self._airPlayType)
	end

	local cfg = AirWorkShopConfig.instance:getConfigByKey(ConfigName.AirAtkFree, self._cfgId)

	self:localNotify(EventType.INNER_TITLE_CHANGE_EVENT, cfg and cfg.name or "")
end

function M:onExit()
	self:setEvent(false)
	removetimer(self._refreshScrollToNew, self)

	self._canvasGroup.interactable = false
end

function M:_backSelf(isQuick, reasonStr)
	self._canvasGroup.interactable = false

	if Astral.OSDef.isEditor and not string.nilorempty(reasonStr) then
		printWarn(reasonStr)
	end

	if isQuick then
		ViewMgr.instance:close(ViewName.AirWorkShopFreeLevelSelectView, true, WindowType.WindowCloseReasonType.QuickCloseType, false)
	else
		self:back()
	end
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_FREE_MATCH_REPLY, self._handleOnFreeMatchReply, self)
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_FREE_ENDLESS_MATCH_REPLY, self._handleOnFreeEndlessMatchReply, self)
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_FREE_ENDLESS_GIVE_UP_REPLY, self._handleOnFreeEndlessGiveUpReply, self)
	else
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_FREE_MATCH_REPLY, self._handleOnFreeMatchReply, self)
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_FREE_ENDLESS_MATCH_REPLY, self._handleOnFreeEndlessMatchReply, self)
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_FREE_ENDLESS_GIVE_UP_REPLY, self._handleOnFreeEndlessGiveUpReply, self)
	end
end

function M:_handleOnFreeMatchReply(e, status, LevelNO)
	if status ~= 0 then
		self:_backSelf(true, string.format("自由匹配返回stataus=%s", status))

		return
	end

	if self._isEndless then
		return
	end

	self._cellLevelMatch:setActive(LevelNO)

	if LevelNO then
		self._cellLevelMatch:updateData(LevelNO)
		self._cellLevelMatch:setBtnCheckStatus(AirWorkShopEnum.BtnStatus.Check)
		self._cellLevelMatch:setStateNormal(self._airPlayType)
		self._cellLevelMatch:playOpenAni()
	end
end

function M:_handleOnFreeEndlessMatchReply(e, levelNO)
	self._waitReMatchEndless = false

	if not self._isEndless then
		return
	end

	table.insert(self._endlessLevelNOLst, levelNO)
	self:_refreshEndlessLst()
end

function M:_handleOnFreeEndlessGiveUpReply(e)
	self:back()
end

function M:_onClickRefreshMatch()
	if not self._isEndless then
		local content = lang("tip_air_free_mode_rematch")
		local dialog = Dialog.showMessage(lang("tip_title"), content)

		dialog:setConfirmListener(function()
			AirWorkShopAtkAgent.instance:sendFreeMatchRequest(self._airPlayType)
		end, self)
	end
end

function M:_onClickGiveUpEndless()
	local content = lang("tip_air_give_up_free_endless")
	local dialog = Dialog.showMessage(lang("tip_title"), content)

	dialog:setConfirmListener(function()
		AirWorkShopAtkAgent.instance:sendEndlessGiveUpRequest()
	end, self)
end

function M:_onClickRandomMatch(mapId)
	printWarn(string.format("自由匹配 %s %s", self._airPlayType, mapId))
	AirWorkShopAtkAgent.instance:sendFreeStartRequest(self._airPlayType, mapId)
end

function M:_onClickEndlessStart()
	local info = AirWorkShopFreeModel.instance:getEndlessPlayerInfoMo()

	if not info:getIsWin() then
		local content = lang("tip_air_revive_free_endless")
		local dialog = Dialog.showMessage(lang("tip_title"), content)

		dialog:setConfirmListener(function()
			if info:getCurLife() <= 0 then
				ToolTipsMgr.showCharacterTopToast(lang("tip_air_free_endless_life_not_enough"), CommEnum.CharacterTopToastIcon.Fail, 1)
			else
				AirWorkShopAtkAgent.instance:sendEndlessStartRequest()
			end
		end, self)

		return
	end

	AirWorkShopAtkAgent.instance:sendEndlessStartRequest()
end

function M:_refreshScrollToNew()
	self._scrollEndless.horizontalNormalizedPosition = 1
end

function M:_refreshEndlessLife(life)
	for index, go in ipairs(self._endlessLife or {}) do
		goutil.setActive(go, index <= life)
	end
end

function M:_refreshEndlessLst()
	local len = self._endlessLevelNOLst and #self._endlessLevelNOLst or 0

	if len > 0 then
		self._loopListEndless:SetListItemCount(len, true)
		self._loopListEndless:RefreshAllShownItem()
		settimer(0, self._refreshScrollToNew, self, false)
	else
		self._loopListEndless:ClearCells()
	end
end

function M:_onCellEndlessUpdate(curIndex)
	curIndex = curIndex + 1

	local data = self._endlessLevelNOLst[curIndex]
	local prefabName = "select_level_item"
	local item = self._loopListEndless:NewListViewItem(prefabName)
	local shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, AirWorkShopSelectLevelCell)

	shower:updateData(data)

	local isFinished = true
	local btnStatus = AirWorkShopEnum.BtnStatus.Check
	local selected = true

	if curIndex == #self._endlessLevelNOLst then
		if not self._waitReMatchEndless and AirWorkShopFreeModel.instance:getEndlessCurIsWin() then
			isFinished = false
		elseif not AirWorkShopFreeModel.instance:getEndlessCurIsWin() then
			isFinished = false
		end
	end

	if isFinished then
		shower:setClickCheckFunction(nil, nil)

		btnStatus = nil
		selected = false
	else
		shower:setClickCheckFunction(self._onClickEndlessStart, self)

		btnStatus = AirWorkShopFreeModel.instance:getEndlessCurIsWin() and AirWorkShopEnum.BtnStatus.Check or AirWorkShopEnum.BtnStatus.ReviveCheck
	end

	shower:setIsFinished(isFinished)
	shower:setBtnCheckStatus(btnStatus)
	shower:setSelect(selected)
	shower:setStateEndless(curIndex)

	return item
end

return M
