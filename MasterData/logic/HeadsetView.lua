-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/headitem/view/HeadsetView.lua

module("logic.extensions.headitem.view.HeadsetView", package.seeall)

local HeadsetView = class("HeadsetView", ViewComponent)

HeadsetView.HEAD_MALE = 1
HeadsetView.HEAD_FEMALE = 2

local SortType = {
	gain = 1
}
local SortDir = {
	ascend = 1,
	disorder = 0,
	decline = 2
}
local GainFilterType = {
	noGain = 2,
	gain = 1,
	none = 0
}
local SpineFilterType = {
	isSpine = 2,
	isNoSpine = 1,
	none = 0
}

function HeadsetView:ctor()
	HeadsetView.super.ctor(self)
end

function HeadsetView:buildUI()
	HeadsetView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnHeadIcon = self:getGo("btnHeadIcon")
	self.btnHeadKuang = self:getGo("btnHeadKuang")
	self.btnChatKuang = self:getGo("btnChatKuang")
	self.btnNameKuang = self:getGo("btnNameKuang")
	self.tableview = self:getGo("tableview")
	self.headIconCell = self:getGo("headIconCell")
	self.headKuangCell = self:getGo("headKuangCell")
	self.chatKuangCell = self:getGo("chatKuangCell")
	self.nameKuangCell = self:getGo("nameKuangCell")
	self._toolbar = self:getGo("toolbar")
	self._inputSearch = self:getInput("toolbar/inputSeach")
	self._btnClear = self:getGo("toolbar/inputSeach/btnClear")
	self._btnFilter = self:getGo("toolbar/btnFilter")
	self._btnSort = self:getGo("toolbar/btnSort")
	self._toolPanel = self:getGo("toolPanel")
	self._btnHide = self:getGo("toolPanel/btnHide")
	self._sortPanel = self:getGo("toolPanel/sortPanel")
	self._filterPanel = self:getGo("toolPanel/filterPanel")
	self.btnMore = self:getGo("btnMore")
	self.scrollerView = ScrollerList.create(self.tableview, {
		self.headIconCell,
		self.headKuangCell,
		self.chatKuangCell,
		self.nameKuangCell
	}, GameUtil.handler(self._upateCell, self), GameUtil.handler(self.clearCell, self))

	self.scrollerView:regGetTagByIdx(GameUtil.handler(self.getCellTag, self))

	self.groupArr = {}
	self.switchSortArr = {}

	for _, sortId in pairs(SortType) do
		local cell = {}

		cell.go = goutil.findChild(self._sortPanel, "content/Cell" .. sortId)

		if cell.go then
			cell.sortChange = goutil.findChildComponent(cell.go, "ImgSort", "UIImageSpriteChange")
			cell.sortId = sortId

			table.insert(self.switchSortArr, cell)
		end
	end

	self.gainFilterArr = {}

	for _, filterId in pairs(GainFilterType) do
		local cell = {}

		cell.go = goutil.findChild(self._filterPanel, "content/gain/filter/Cell" .. filterId)

		if cell.go then
			cell.change = cell.go:GetComponent("UIChangeGroup")
			cell.filterId = filterId

			table.insert(self.gainFilterArr, cell)
		end
	end

	self.spineFilterArr = {}

	for _, filterId in pairs(SpineFilterType) do
		local cell = {}

		cell.go = goutil.findChild(self._filterPanel, "content/spine/filter/Cell" .. filterId)

		if cell.go then
			cell.change = cell.go:GetComponent("UIChangeGroup")
			cell.filterId = filterId

			table.insert(self.spineFilterArr, cell)
		end
	end
end

function HeadsetView:bindEvents()
	HeadsetView.super.bindEvents(self)
	self:addBtnGroup(self.btnHeadIcon)
	self:addBtnGroup(self.btnHeadKuang)
	self:addBtnGroup(self.btnChatKuang)
	self:addBtnGroup(self.btnNameKuang)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnMore, self.onMoreClick, self)
	GameUtil.addClickHandler(self._btnFilter, self._onFilterClick, self)
	GameUtil.addClickHandler(self._btnSort, self._onSortClick, self)
	GameUtil.addClickHandler(self._btnClear, self._onClearClick, self)
	GameUtil.addClickHandler(self._btnHide, self._onHideClick, self)
	self._inputSearch:AddOnValueChanged(self._onSearchTextChanged, self)

	for i, v in ipairs(self.switchSortArr) do
		GameUtil.addClickHandler(v.go, GameUtil.handler(self.onSwitchSortClick, self, v.sortId))
	end

	for i, v in ipairs(self.gainFilterArr) do
		GameUtil.addClickHandler(v.go, GameUtil.handler(self.onSwitchGainFilterClick, self, v.filterId))
	end

	for i, v in ipairs(self.spineFilterArr) do
		GameUtil.addClickHandler(v.go, GameUtil.handler(self.onSwitchSpineFilterClick, self, v.filterId))
	end
end

function HeadsetView:unbindEvents()
	HeadsetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnMore)

	for i, v in ipairs(self.groupArr) do
		GameUtil.rmClickHandler(v)
	end

	GameUtil.rmClickHandler(self._btnFilter)
	GameUtil.rmClickHandler(self._btnSort)
	GameUtil.rmClickHandler(self._btnClear)
	GameUtil.rmClickHandler(self._btnHide)
	self._inputSearch:RemoveOnValueChanged()

	for i, v in ipairs(self.switchSortArr) do
		GameUtil.rmClickHandler(v.go)
	end

	for i, v in ipairs(self.gainFilterArr) do
		GameUtil.rmClickHandler(v.go)
	end

	for i, v in ipairs(self.spineFilterArr) do
		GameUtil.rmClickHandler(v.go)
	end
end

function HeadsetView:destroyUI()
	HeadsetView.super.destroyUI(self)
end

function HeadsetView:onEnter()
	HeadsetView.super.onEnter(self)
	self:onBtnGroupClick(1)
	HeadItemController.instance:sendGetInfo(GameUtil.handler(self.firstEnter, self))
	BattleStartAnimController.instance:sendPM_LoadAllUniquePropsReq()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.refreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.ChatFrameChange, self.refreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.LoadAllUniquePropsRes, self._onLoadAllUniquePropsRes, self)
	GlobalDispatcher:addListener(GlobalNotify.UseUniquePropRes, self._onUseUniquePropRes, self)
	GlobalDispatcher:addListener(GlobalNotify.NotifyUniquePropChangeRes, self._onNotifyUniquePropChangeRes, self)
end

function HeadsetView:onEnterFinished()
	HeadsetView.super.onEnterFinished(self)
end

function HeadsetView:onExit()
	HeadsetView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ON_HEAD_ITEM_CHANGE, self.refreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.ChatFrameChange, self.refreshUI, self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self.refreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.LoadAllUniquePropsRes, self._onLoadAllUniquePropsRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.UseUniquePropRes, self._onUseUniquePropRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.NotifyUniquePropChangeRes, self._onNotifyUniquePropChangeRes, self)
	self.scrollerView:dispose()

	self.selectIdx = nil
end

function HeadsetView:onExitFinished()
	HeadsetView.super.onExitFinished(self)
end

function HeadsetView:addBtnGroup(btn)
	table.insert(self.groupArr, btn)

	local idx = #self.groupArr

	GameUtil.addClickHandler(btn, GameUtil.handler(self.onBtnGroupClick, self, idx))
end

function HeadsetView:onBtnGroupClick(idx)
	if self.selectIdx == idx then
		return
	end

	self.selectIdx = idx

	goutil.setActive(self._toolbar, self.selectIdx == 1 or self.selectIdx == 2)
	goutil.setActive(self._toolPanel, false)

	for i, btn in ipairs(self.groupArr) do
		if i == idx then
			GameUtil.setUIGroupIdx(btn, 1)
		else
			GameUtil.setUIGroupIdx(btn, 0)
		end
	end

	self:_refreshState()
	self:refreshUI()
end

function HeadsetView:_onLoadAllUniquePropsRes()
	if self.selectIdx == 4 then
		self:refreshUI()
	end
end

function HeadsetView:_onUseUniquePropRes()
	if self.selectIdx == 4 then
		self:refreshUI()
	end
end

function HeadsetView:_onNotifyUniquePropChangeRes()
	if self.selectIdx == 4 then
		self:refreshUI()
	end
end

function HeadsetView:firstEnter()
	GlobalDispatcher:addListener(GlobalNotify.ON_HEAD_ITEM_CHANGE, self.refreshUI, self)
	self:_refreshState()
	self:refreshUI()
end

function HeadsetView:refreshUI()
	local list

	if self.selectIdx == 1 then
		list = self:_getHeadIconDataList()
	elseif self.selectIdx == 2 then
		list = self:_getHeadFrameDataList()
	elseif self.selectIdx == 3 then
		list = self:_getChatBubbleDataList()
	elseif self.selectIdx == 4 then
		list = self:_getNameFrameDataList()
	end

	self.scrollerView:reloadData(list)
end

function HeadsetView:_checkIsOnline(notOnlineState)
	return checknumber(notOnlineState) == 0 or not BootstrapPjaqGameConfigMgr.isReview and checknumber(notOnlineState) == 2
end

function HeadsetView:_checkDefaultIcon(iconId)
	if RoleModel.instance:getGender() == 0 then
		return iconId ~= HeadsetView.HEAD_MALE
	else
		return iconId ~= HeadsetView.HEAD_FEMALE
	end
end

function HeadsetView:_checkSearchStr(checkStr)
	local searchStr = self._inputSearch:GetText()

	if GameUtil.isEmptyString(searchStr) then
		return true
	else
		return string.find(checkStr, searchStr)
	end
end

function HeadsetView:_checkGainState(isOwn)
	if self._curGainFilterType == GainFilterType.none then
		return true
	else
		return isOwn and self._curGainFilterType == GainFilterType.gain or not isOwn and self._curGainFilterType == GainFilterType.noGain
	end
end

function HeadsetView:_checkSpineState(isSpine)
	local checkIsSpine = checknumber(isSpine) == 1

	if self._curSpineFilterType == SpineFilterType.none then
		return true
	else
		return checkIsSpine and self._curSpineFilterType == SpineFilterType.isSpine or not checkIsSpine and self._curSpineFilterType == SpineFilterType.isNoSpine
	end
end

function HeadsetView:_getHeadIconDataList()
	local tmp = HeadItemConfig.instance:getAllHeadIconList()
	local list = {}

	for i, v in ipairs(tmp) do
		local isOwn = HeadItemModel.instance:getHeadIconInfo(v.id)

		if self:_checkIsOnline(v.notOnline) and self:_checkDefaultIcon(v.id) and self:_checkSearchStr(v.name) and self:_checkGainState(isOwn) and self:_checkSpineState(v.isSpine) then
			table.insert(list, v)
		end
	end

	local sortDir = ArraySort.NONE

	if self._curSortDir == SortDir.ascend then
		sortDir = ArraySort.NUMERIC
	elseif self._curSortDir == SortDir.decline then
		sortDir = ArraySort.DESCENDING
	end

	ArraySort.sortOn(list, {
		function(a)
			local info = HeadItemModel.instance:getHeadIconInfo(a.id)

			if info then
				return 0
			else
				return 1
			end
		end,
		"sortValue"
	}, {
		ArraySort.NUMERIC,
		sortDir
	})

	return list
end

function HeadsetView:_getHeadFrameDataList()
	local list = {}
	local tmp = HeadItemConfig.instance:getAllHeadFrameList()

	for i, v in ipairs(tmp) do
		local isOwn = HeadItemModel.instance:getHeadFrameInfo(v.id)

		if self:_checkIsOnline(v.notOnline) and self:_checkSearchStr(v.name) and self:_checkGainState(isOwn) and self:_checkSpineState(v.isSpine) then
			table.insert(list, v)
		end
	end

	local sortDir = ArraySort.NONE

	if self._curSortDir == SortDir.ascend then
		sortDir = ArraySort.NUMERIC
	elseif self._curSortDir == SortDir.decline then
		sortDir = ArraySort.DESCENDING
	end

	ArraySort.sortOn(list, {
		function(a)
			local info = HeadItemModel.instance:getHeadFrameInfo(a.id)

			if info then
				return 0
			else
				return 1
			end
		end,
		"sortValue"
	}, {
		ArraySort.NUMERIC,
		sortDir
	})

	return list
end

function HeadsetView:_getChatBubbleDataList()
	local list = {}
	local tmp = ChatConfig.instance:getChatBubbleCfgs()

	for i, v in ipairs(tmp) do
		if v.notOnline ~= 1 then
			table.insert(list, v)
		end
	end

	local vipLv = RoleModel.instance:getVipLvl()

	ArraySort.sortOn(list, {
		function(data)
			if data.bubbleId > 1 then
				local num = MaterialModel.instance:getMaterialsNumber(MatType.Bubble, data.bubbleId)

				if data.defaultByVip then
					if data.vipLevel > vipLv then
						return 1
					else
						return 0
					end
				elseif num > 0 then
					return 0
				else
					return 1
				end
			else
				return 0
			end
		end,
		"bubbleId"
	})

	return list
end

function HeadsetView:_getNameFrameDataList()
	local list = {}
	local tmp = BattleStartAnimConfig.instance:getNameFrameCfgList()

	for i, v in ipairs(tmp) do
		if v.notOnline ~= 1 then
			table.insert(list, v)
		end
	end

	return list
end

function HeadsetView:getCellTag(data, idx)
	return self.selectIdx
end

function HeadsetView:_upateCell(view, cell, data, tag)
	if tag == 1 then
		self:updateHead(view, cell, data)
	elseif tag == 2 then
		self:updateFrame(view, cell, data)
	elseif tag == 3 then
		self:updateChat(view, cell, data)
	elseif tag == 4 then
		self:updateName(view, cell, data)
	end
end

function HeadsetView:updateHead(view, cell, data)
	local icon = goutil.findChild(cell, "icon")
	local imgState = goutil.findChild(cell, "imgState")
	local imgLock = goutil.findChild(cell, "imgLock")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local goTime = goutil.findChild(cell, "txtTime")
	local txtTime = goutil.findChildTextComponent(cell, "txtTime")

	GameUtil.addClickHandler(cell, GameUtil.handler(self.onHeadIconClick, self, data))
	GameUtil.SetActive(goTime, false)
	MaterialMgr.resetAll(icon)

	local proxy = MaterialMgr.setCell(MatType.HeadIcon, data.id, icon)

	txtName.text = data.name

	local info = HeadItemModel.instance:getHeadIconInfo(data.id)

	GameUtil.SetActive(imgLock, false)

	if info then
		if info.isWear then
			GameUtil.SetActive(imgState, true)
			GameUtil.setUIImageSpriteIdx(imgState, 1)
		else
			GameUtil.SetActive(imgState, false)
		end

		local overTime = checknumber(info.overdueTime)

		if overTime > 0 then
			local timeRemain = overTime / 1000 - ServerTime.now()

			if timeRemain > 0 then
				txtTime.text = langPara("还剩%s天过期", math.ceil(timeRemain / 86400))

				GameUtil.SetActive(goTime, true)
			end
		end

		GameUtil.setUITextColorIdx(txtName, 1)

		if proxy then
			proxy.binder:setBgActive(false)
			proxy.binder:SetGray(false)
		end
	else
		GameUtil.SetActive(imgLock, true)
		GameUtil.SetActive(imgState, false)
		GameUtil.setUIImageSpriteIdx(imgState, 0)
		GameUtil.setUITextColorIdx(txtName, 0)

		if proxy then
			proxy.binder:setBgActive(false)
			proxy.binder:SetGray(true)
		end
	end
end

function HeadsetView:updateFrame(view, cell, data)
	local icon = goutil.findChild(cell, "icon")
	local imgState = goutil.findChild(cell, "imgState")
	local imgLock = goutil.findChild(cell, "imgLock")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local goTime = goutil.findChild(cell, "txtTime")
	local txtTime = goutil.findChildTextComponent(cell, "txtTime")

	GameUtil.addClickHandler(cell, GameUtil.handler(self.onHeadFrameClick, self, data))
	GameUtil.SetActive(goTime, false)
	MaterialMgr.resetAll(icon)

	local proxy = MaterialMgr.setCell(MatType.HeadFrame, data.id, icon)

	txtName.text = data.name

	GameUtil.SetActive(imgState, false)

	local info = HeadItemModel.instance:getHeadFrameInfo(data.id)

	GameUtil.SetActive(imgLock, false)

	if info then
		if info.isWear then
			GameUtil.SetActive(imgState, true)
			GameUtil.setUIImageSpriteIdx(imgState, 1)
		else
			GameUtil.SetActive(imgState, false)
		end

		local overTime = checknumber(info.overdueTime)

		if overTime > 0 then
			local timeRemain = overTime / 1000 - ServerTime.now()

			if timeRemain > 0 then
				txtTime.text = langPara("还剩%s天过期", math.ceil(timeRemain / 86400))

				GameUtil.SetActive(goTime, true)
			end
		end

		GameUtil.setUITextColorIdx(txtName, 1)

		if proxy then
			proxy.binder:setBgActive(false)
			proxy.binder:SetGray(false)
		end
	else
		GameUtil.SetActive(imgLock, true)
		GameUtil.SetActive(imgState, false)
		GameUtil.setUIImageSpriteIdx(imgState, 0)
		GameUtil.setUITextColorIdx(txtName, 0)

		if proxy then
			proxy.binder:setBgActive(false)
			proxy.binder:SetGray(true)
		end
	end
end

function HeadsetView:updateChat(view, cell, data)
	local icon = goutil.findChild(cell.gameObject, "icon")

	MaterialMgr.resetAll(icon)

	local proxy = MaterialMgr.setCell(MatType.Bubble, data.bubbleId, icon)

	if proxy then
		proxy.binder:setBgActive(false)
	end

	goutil.findChildTextComponent(cell.gameObject, "txtName").text = data.bubbleName

	local lock = goutil.findChild(cell.gameObject, "imgLock")
	local imgState = goutil.findChildComponent(cell.gameObject, "imgState", "UIImageSpriteChange")
	local num = MaterialModel.instance:getMaterialsNumber(MatType.Bubble, data.bubbleId)

	if data.bubbleId > 1 then
		if data.defaultByVip then
			local vipLv = RoleModel.instance:getVipLvl()

			goutil.setActive(lock, vipLv < data.vipLevel)
			imgState:SetState(vipLv < data.vipLevel and 0 or 1)
			goutil.setActive(imgState.gameObject, vipLv < data.vipLevel or NewChatModel.instance:getChatBubbleId() == data.bubbleId)

			if proxy then
				proxy.binder:setGray(vipLv < data.vipLevel)
			end
		else
			imgState:SetState(num)
			goutil.setActive(imgState.gameObject, num == 0 or NewChatModel.instance:getChatBubbleId() == data.bubbleId)
			goutil.setActive(lock, num == 0)

			if proxy then
				proxy.binder:setGray(num == 0)
			end
		end
	else
		imgState:SetState(1)
		goutil.setActive(imgState.gameObject, NewChatModel.instance:getChatBubbleId() == 1)
		goutil.setActive(lock, false)

		if proxy then
			proxy.binder:setGray(false)
		end
	end

	GameUtil.addClickHandler(cell, GameUtil.handler(self.onChatFrameClick, self, data))
end

function HeadsetView:updateName(view, cell, data)
	local icon = goutil.findChild(cell.gameObject, "icon")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local lock = goutil.findChild(cell.gameObject, "imgLock")
	local imgState = goutil.findChildComponent(cell.gameObject, "imgState", "UIImageSpriteChange")

	uGuiUtil.clearImage(icon)
	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getIconFolderUrl("nameframe", data.icon))

	txtName.text = data.name

	local state = BattleStartAnimModel.instance:getState(MatType.NameFrame, data.id)

	goutil.setActive(lock, state == BattleStartAnimModel.Lock)

	local isUsing = state == BattleStartAnimModel.Using

	imgState:SetState(isUsing and 1 or 0)
	goutil.setActive(imgState.gameObject, state ~= BattleStartAnimModel.Unuse)
	uGuiUtil.setGoGrayState(icon, state == BattleStartAnimModel.Lock)
	GameUtil.addClickHandler(cell, GameUtil.handler(self.onNameFrameClick, self, data, state))
end

function HeadsetView:onHeadIconClick(data)
	UIStateManager.instance:push(ViewName.HeadalertView, MatType.HeadIcon, data)
end

function HeadsetView:onHeadFrameClick(data)
	UIStateManager.instance:push(ViewName.HeadalertView, MatType.HeadFrame, data)
end

function HeadsetView:onChatFrameClick(data)
	UIStateManager.instance:push(ViewName.HeadalertView, MatType.Bubble, data)
end

function HeadsetView:onNameFrameClick(data, state)
	if state == BattleStartAnimModel.Unuse then
		UniquePropAgent.instance:sendPM_UseUniquePropReq(MatType.NameFrame, data.id)
	elseif state == BattleStartAnimModel.Using then
		-- block empty
	else
		printInfo("test HeadsetView:onNameFrameClick", state)
		UIStateManager.instance:push(ViewName.HeadalertView, MatType.NameFrame, data)
	end
end

function HeadsetView:onMoreClick()
	TipsFacade.instance:openCommonTips(lang("敬请期待"))
end

function HeadsetView:clearCell(cell)
	local icon = goutil.findChild(cell, "icon")

	MaterialMgr.resetAll(icon)
	uGuiUtil.clearImage(icon)
end

function HeadsetView:_onFilterClick()
	goutil.setActive(self._toolPanel, true)
	goutil.setActive(self._sortPanel, false)
	goutil.setActive(self._filterPanel, true)

	for _, cell in ipairs(self.gainFilterArr) do
		if cell.filterId == self._curGainFilterType then
			cell.change:SetState(0)
		else
			cell.change:SetState(1)
		end
	end

	for _, cell in ipairs(self.spineFilterArr) do
		if cell.filterId == self._curSpineFilterType then
			cell.change:SetState(0)
		else
			cell.change:SetState(1)
		end
	end
end

function HeadsetView:_onSortClick()
	goutil.setActive(self._toolPanel, true)
	goutil.setActive(self._sortPanel, true)
	goutil.setActive(self._filterPanel, false)

	for _, cell in ipairs(self.switchSortArr) do
		if cell.sortId == self._curSortId then
			cell.sortChange:SetState(self._curSortDir)
		else
			cell.sortChange:SetState(SortDir.disorder)
		end
	end
end

function HeadsetView:_onClearClick()
	self._inputSearch.input.text = ""
end

function HeadsetView:_onHideClick()
	goutil.setActive(self._toolPanel, false)
end

function HeadsetView:_onSearchTextChanged()
	if self.selectIdx == 1 or self.selectIdx == 2 then
		self:refreshUI()
	end
end

function HeadsetView:onSwitchSortClick(sortId)
	if self._curSortId ~= sortId then
		self._curSortId = sortId
	elseif self._curSortDir == SortDir.ascend then
		self._curSortDir = SortDir.decline
	elseif self._curSortDir == SortDir.decline then
		self._curSortDir = SortDir.ascend
	end

	for _, cell in ipairs(self.switchSortArr) do
		if cell.sortId == self._curSortId then
			cell.sortChange:SetState(self._curSortDir)
		else
			cell.sortChange:SetState(SortDir.disorder)
		end
	end

	if self.selectIdx == 1 or self.selectIdx == 2 then
		self:refreshUI()
	end
end

function HeadsetView:onSwitchGainFilterClick(filterId)
	self._curGainFilterType = self._curGainFilterType ~= filterId and filterId or GainFilterType.none

	for _, cell in ipairs(self.gainFilterArr) do
		if cell.filterId == self._curGainFilterType then
			cell.change:SetState(0)
		else
			cell.change:SetState(1)
		end
	end

	if self.selectIdx == 1 or self.selectIdx == 2 then
		self:refreshUI()
	end
end

function HeadsetView:onSwitchSpineFilterClick(filterId)
	self._curSpineFilterType = self._curSpineFilterType ~= filterId and filterId or SpineFilterType.none

	for _, cell in ipairs(self.spineFilterArr) do
		if cell.filterId == self._curSpineFilterType then
			cell.change:SetState(0)
		else
			cell.change:SetState(1)
		end
	end

	if self.selectIdx == 1 or self.selectIdx == 2 then
		self:refreshUI()
	end
end

function HeadsetView:_refreshState()
	self._curSortId = SortType.gain
	self._curSortDir = SortDir.decline
	self._curGainFilterType = GainFilterType.none
	self._curSpineFilterType = SpineFilterType.none
	self._inputSearch.input.text = ""
end

return HeadsetView
