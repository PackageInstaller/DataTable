-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/title/view/TitleView.lua

module("logic.extensions.title.view.TitleView", package.seeall)

local TitleView = class("TitleView", ViewComponent)
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
local TimeLimitFilterType = {
	isNoLimit = 1,
	isLimit = 2,
	none = 0
}

function TitleView:ctor()
	TitleView.super.ctor(self)
end

function TitleView:bindEvents()
	self._btnPutOn:AddClickListener(self._onClickPutOn, self)
	self._btnTakeOff:AddClickListener(self._onClickTakeOff, self)
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

	for i, v in ipairs(self.timeFilterArr) do
		GameUtil.addClickHandler(v.go, GameUtil.handler(self.onSwitchSpineFilterClick, self, v.filterId))
	end
end

function TitleView:unbindEvents()
	self._btnPutOn:RemoveClickListener()
	self._btnTakeOff:RemoveClickListener()
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

	for i, v in ipairs(self.timeFilterArr) do
		GameUtil.rmClickHandler(v.go)
	end
end

function TitleView:buildUI()
	local goRoot = self:getGo("root")

	self._goCell = goutil.findChild(goRoot, "Cell")
	self._goCellTip = goutil.findChild(goRoot, "cellTip")

	self._goCell:SetActive(false)
	self._goCellTip:SetActive(false)

	self._sv = goutil.findChild(goRoot, "Scrl"):GetComponent("UITableviewForLua")
	self._btnPutOn = self:getBtn("root/btnPutOn")
	self._btnTakeOff = self:getBtn("root/btnTakeOff")
	self._toolbar = self:getGo("root/toolbar")
	self._inputSearch = self:getInput("root/toolbar/inputSeach")
	self._btnClear = self:getGo("root/toolbar/inputSeach/btnClear")
	self._btnFilter = self:getGo("root/toolbar/btnFilter")
	self._btnSort = self:getGo("root/toolbar/btnSort")
	self._toolPanel = self:getGo("root/toolPanel")
	self._btnHide = self:getGo("root/toolPanel/btnHide")
	self._sortPanel = self:getGo("root/toolPanel/sortPanel")
	self._filterPanel = self:getGo("root/toolPanel/filterPanel")
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

	self.timeFilterArr = {}

	for _, filterId in pairs(TimeLimitFilterType) do
		local cell = {}

		cell.go = goutil.findChild(self._filterPanel, "content/timeLimit/filter/Cell" .. filterId)

		if cell.go then
			cell.change = cell.go:GetComponent("UIChangeGroup")
			cell.filterId = filterId

			table.insert(self.timeFilterArr, cell)
		end
	end
end

function TitleView:destroyUI()
	return
end

function TitleView:onEnter()
	self._sv:RegisterCallback(self._getSvNum, self._getSvItemSize, self._setupCell, self)
	self:_refreshState()
	goutil.setActive(self._toolPanel, false)
	self:_refresh()
	TitleModel.instance:updateOwnedList()
	GlobalDispatcher:addListener(GlobalNotify.TitleUpdate, self._refresh, self)
end

function TitleView:_refresh(id)
	self._arrOwnedTitles = self:_getOwnedTitles()
	self._arrOtherTitles = self:_getOtherTitles()
	self._ownNum = #self._arrOwnedTitles
	self._tipIndex = self._ownNum
	self._svItemNum = self._ownNum + #self._arrOtherTitles + 1
	self._curSelectId = id or self:_getCurTitleId()

	local info = TitleModel.instance:getInfoById(self._curSelectId)
	local state = GameEnum.TitleState.NONE

	if info ~= nil then
		state = info.state
	end

	goutil.setActive(self._btnPutOn.gameObject, state == GameEnum.TitleState.OWN)
	goutil.setActive(self._btnTakeOff.gameObject, state == GameEnum.TitleState.ON)
	self._sv:ReloadData()
end

function TitleView:onEnterFinished()
	return
end

function TitleView:onExit()
	self._sv:Travel(self._clearSvStage, self, true)
	self._sv:UnRegisterAllCallbacks()
	GlobalDispatcher:removeListener(GlobalNotify.TitleUpdate, self._refresh, self)
	GlobalDispatcher:dispatch(GlobalNotify.TitleUpdate, TitleModel.instance:getCurTitleId())
end

function TitleView:onExitFinished()
	return
end

function TitleView:_getSvNum()
	return self._svItemNum
end

function TitleView:_getSvItemSize(sv, index)
	if index == self._tipIndex then
		return 432, 50
	else
		return 432, 100
	end
end

function TitleView:_setupCell(view, idx)
	if idx == self._tipIndex then
		local cell = view:DequeueCellByTag(1)

		cell = cell or view:AddChild(self._goCellTip, 1)

		return cell
	else
		local cell = view:DequeueCellByTag(0)

		cell = cell or view:AddChild(self._goCell, 0)

		local info
		local isOwned = false

		if idx > self._tipIndex then
			info = self._arrOtherTitles[idx - self._ownNum]
		else
			info = self._arrOwnedTitles[idx + 1]
			isOwned = true
		end

		local goIcon = goutil.findChild(cell.gameObject, "icon")
		local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
		local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
		local bgChange = goutil.findChild(cell.gameObject, "ImgBg"):GetComponent("UIImageSpriteChange")
		local goMask = goutil.findChild(cell.gameObject, "mask")
		local goTimeLimit = goutil.findChild(cell.gameObject, "imgTip")
		local goSelected = goutil.findChild(cell.gameObject, "imgSelected")
		local btn = Framework.ButtonAdapter.Get(bgChange.gameObject)
		local goRedpoint = goutil.findChild(cell.gameObject, "imgRedpoint")
		local txtTime = goutil.findChildTextComponent(cell.gameObject, "txtTime")

		goIcon:GetComponent("UIImageSpriteChange"):ChangeSprite(info.icon)

		txtName.text = info.titleName
		txtDesc.text = info.titleDesc

		bgChange:SetState(info.quality)
		goMask:SetActive(not isOwned)
		goSelected:SetActive(self._curSelectId == info.titleId)
		goTimeLimit:SetActive(false)
		goutil.setActive(txtTime.gameObject, info.overdueTime and info.overdueTime ~= -1)

		if info.overdueTime and info.overdueTime ~= -1 then
			local timeData = GameUtil.time2date(info.overdueTime / 1000)

			txtTime.text = string.format("到期时间:%d.%d.%d", timeData.year, timeData.month, timeData.day)
		end

		goRedpoint:SetActive(TitleModel.instance:getRedActive(info.titleId))

		if self._curSelectId == info.titleId then
			goRedpoint:SetActive(false)
			TitleModel.instance:updateRedPoint(info.titleId, false)
		end

		uGuiUtil.setGoGrayState(goIcon, not isOwned)
		btn:RemoveClickListener()

		if isOwned then
			btn:AddClickListener(function()
				goRedpoint:SetActive(false)
				GlobalDispatcher:dispatch(GlobalNotify.TitleUpdate, self._curSelectId == info.titleId and TitleModel.instance:getCurTitleId() or info.titleId)
			end)
		end

		return cell
	end
end

function TitleView:_onClickPutOn(titleId)
	TitleAgent.instance:sendPM_WearTitleReq(self._curSelectId, function()
		FloatWordMgr.instance:show("装备成功")
	end)
end

function TitleView:_onClickTakeOff()
	TitleAgent.instance:sendPM_WearTitleReq(0, function()
		FloatWordMgr.instance:show("卸下成功")
	end)
end

function TitleView:_clearSvStage(cell)
	return
end

function TitleView:_checkSearchStr(checkStr)
	local searchStr = self._inputSearch:GetText()

	if GameUtil.isEmptyString(searchStr) then
		return true
	else
		return string.find(checkStr, searchStr)
	end
end

function TitleView:_checkGainState(titleId)
	if self._curGainFilterType == GainFilterType.none then
		return true
	else
		local info = TitleModel.instance:getInfoById(titleId)
		local isOwned = TitleModel.instance:isOwned(info)

		return isOwned and self._curGainFilterType == GainFilterType.gain or not isOwned and self._curGainFilterType == GainFilterType.noGain
	end
end

function TitleView:_checkLimitState(ValidPeriodType)
	if self._curTimeFilterType == TimeLimitFilterType.none then
		return true
	else
		local isLimit = checknumber(ValidPeriodType) ~= 0

		return isLimit and self._curTimeFilterType == TimeLimitFilterType.isLimit or not isLimit and self._curTimeFilterType == TimeLimitFilterType.isNoLimit
	end
end

function TitleView:_getOwnedTitles()
	local infos = TitleModel.instance:getOwnedTitles()
	local list = {}

	for _, info in ipairs(infos) do
		if self:_checkGainState(info.titleId) and self:_checkSearchStr(info.titleName) and self:_checkLimitState(info.ValidPeriodType) then
			table.insert(list, info)
		end
	end

	local sortDir = ArraySort.NONE
	local sortKey = "titleId"

	if self._curSortDir == SortDir.disorder then
		sortKey = "titleId"
		sortDir = ArraySort.NUMERIC
	elseif self._curSortDir == SortDir.decline then
		sortDir = ArraySort.DESCENDING
		sortKey = "gainTime"
	else
		sortDir = ArraySort.NUMERIC
		sortKey = "gainTime"
	end

	ArraySort.sortOn(list, sortKey, sortDir)

	return list
end

function TitleView:_getOtherTitles()
	local infos = TitleModel.instance:getOtherTitles()
	local list = {}

	for _, info in ipairs(infos) do
		if self:_checkGainState(info.titleId) and self:_checkSearchStr(info.titleName) and self:_checkLimitState(info.ValidPeriodType) then
			table.insert(list, info)
		end
	end

	local sortKey = "titleId"

	ArraySort.sortOn(list, sortKey, self._curSortDir == SortDir.disorder and ArraySort.NUMERIC or self._curSortDir == SortDir.decline and ArraySort.DESCENDING or ArraySort.NUMERIC)

	return list
end

function TitleView:_getCurTitleId()
	local curTitleId = TitleModel.instance:getCurTitleId()
	local curSelectId = -1
	local ownList = self:_getOwnedTitles()

	for _, info in ipairs(ownList) do
		if info.titleId == curTitleId then
			curSelectId = curTitleId
		end
	end

	return curSelectId
end

function TitleView:_refreshState()
	self._curSortId = SortType.gain
	self._curSortDir = SortDir.decline
	self._curGainFilterType = GainFilterType.none
	self._curTimeFilterType = TimeLimitFilterType.none
	self._inputSearch.input.text = ""
end

function TitleView:_onFilterClick()
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

	for _, cell in ipairs(self.timeFilterArr) do
		if cell.filterId == self._curTimeFilterType then
			cell.change:SetState(0)
		else
			cell.change:SetState(1)
		end
	end
end

function TitleView:_onSortClick()
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

function TitleView:_onClearClick()
	self._inputSearch.input.text = ""
end

function TitleView:_onHideClick()
	goutil.setActive(self._toolPanel, false)
end

function TitleView:_onSearchTextChanged()
	self:_refresh()
end

function TitleView:onSwitchSortClick(sortId)
	if self._curSortId ~= sortId then
		self._curSortId = sortId
		self._curSortDir = SortDir.decline
	else
		self._curSortDir = self._curSortDir + 1

		if self._curSortDir > SortDir.decline then
			self._curSortDir = SortDir.disorder
		end
	end

	for _, cell in ipairs(self.switchSortArr) do
		if cell.sortId == self._curSortId then
			cell.sortChange:SetState(self._curSortDir)
		else
			cell.sortChange:SetState(SortDir.disorder)
		end
	end

	self:_refresh()
end

function TitleView:onSwitchGainFilterClick(filterId)
	self._curGainFilterType = self._curGainFilterType ~= filterId and filterId or GainFilterType.none

	for _, cell in ipairs(self.gainFilterArr) do
		if cell.filterId == self._curGainFilterType then
			cell.change:SetState(0)
		else
			cell.change:SetState(1)
		end
	end

	self:_refresh()
end

function TitleView:onSwitchSpineFilterClick(filterId)
	self._curTimeFilterType = self._curTimeFilterType ~= filterId and filterId or TimeLimitFilterType.none

	for _, cell in ipairs(self.timeFilterArr) do
		if cell.filterId == self._curTimeFilterType then
			cell.change:SetState(0)
		else
			cell.change:SetState(1)
		end
	end

	self:_refresh()
end

return TitleView
