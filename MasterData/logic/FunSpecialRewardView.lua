-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funarena/view/FunSpecialRewardView.lua

module("logic.extensions.funarena.view.FunSpecialRewardView", package.seeall)

local FunSpecialRewardView = class("FunSpecialRewardView", ViewComponent)

function FunSpecialRewardView:ctor()
	FunSpecialRewardView.super.ctor(self)
end

function FunSpecialRewardView:buildUI()
	FunSpecialRewardView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "top/btnClose")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "top/txtTitle")
	self._scrollerGo = goutil.findChild(self.mainGO, "scrollview")

	local cellGo = goutil.findChild(self.mainGO, "scrollcell")
	local updateCell = GameUtil.handler(self._updateScrollCell, self)
	local clearCell = GameUtil.handler(self._clearScrollCell, self)

	self._scrollList = ScrollerList.create(self._scrollerGo, cellGo, updateCell, clearCell)

	GameUtil.SetActive(cellGo, false)

	self._cellList = {}
end

function FunSpecialRewardView:bindEvents()
	FunSpecialRewardView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
end

function FunSpecialRewardView:unbindEvents()
	FunSpecialRewardView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function FunSpecialRewardView:onEnter()
	FunSpecialRewardView.super.onEnter(self)

	self._activityId = FunArenaModel.instance.activityId
	self._winStreakPrizeCfg = FunArenaConfig.instance:getWinStreakPrizeCfgsById(self._activityId)

	if self._activityId == 0 then
		self:_onClickBtnClose()

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.FunArenaGetInfo, self._onUpdateUI, self)
	self:_onUpdateUI()
end

function FunSpecialRewardView:onExit()
	FunSpecialRewardView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FunArenaGetInfo, self._onUpdateUI, self)

	for _, cell in pairs(self._cellList) do
		for _, itemGo in ipairs(cell._itemGos) do
			MaterialMgr.resetAll(itemGo)
		end

		cell._itemGos = {}

		for _, itemEff in ipairs(cell._itemEffs) do
			UIEffectManager.instance:stopEffect(itemEff)
		end

		cell._itemEffs = {}
	end
end

function FunSpecialRewardView:_onUpdateUI()
	self:_onUpdateScroller()
end

function FunSpecialRewardView:_onClickBtnClose()
	self:close()
end

function FunSpecialRewardView:_onUpdateScroller()
	local dataList = {}
	local winStreakPrizeGainState = FunArenaModel.instance._infoRes.winStreakPrizeGainState
	local bestWinStreakTimes = FunArenaModel.instance._infoRes.bestWinStreakTimes
	local num = 0

	for _, data in pairs(self._winStreakPrizeCfg) do
		local isHasGain = false

		for i = 1, #winStreakPrizeGainState do
			if not winStreakPrizeGainState[i] then
				if winStreakPrizeGainState[i] == data.winStreakTimes then
					isHasGain = true
				end
			end
		end

		local isEnoughTimes = bestWinStreakTimes >= data.winStreakTimes
		local isCanGet = not isHasGain and isEnoughTimes

		if isHasGain then
			data._state = 3
		elseif not isEnoughTimes then
			data._state = 2
		elseif isCanGet then
			num = num + 1
			data._state = 1
		end

		table.insert(dataList, data)
	end

	table.sort(dataList, function(a, b)
		if a._state == b._state then
			return a.winStreakTimes < b.winStreakTimes
		else
			return a._state < b._state
		end
	end)
	self._scrollList:reloadData(dataList)
	self._scrollList:refresh()
end

function FunSpecialRewardView:_updateScrollCell(_, cellModel, data, _)
	if not self._cellList[cellModel] then
		local cell = {}

		self._cellList[cellModel] = cell
		cell._mainGo = cellModel
		cell._btnGet = goutil.findChild(cell._mainGo, "btnGet")
		cell._receivedGo = goutil.findChild(cell._mainGo, "receivedGo")
		cell._noFinishGo = goutil.findChild(cell._mainGo, "noFinishGo")
		cell._txtBtnGet = goutil.findChildTextComponent(cell._mainGo, "btnGet/txt")
		cell._txtTitle = goutil.findChildTextComponent(cell._mainGo, "txtTitle")
		cell._data = data
		cell._itemGos = cell._itemGos or {}
		cell._itemEffs = cell._itemEffs or {}
		cell._itemGos = {}

		if not string.nilorempty(data.prize) then
			local arr = string.split(data.prize, "#")

			for i, str in ipairs(arr) do
				local go = goutil.findChild(cell._mainGo, "item" .. i)

				if go then
					MaterialMgr.setCellByCfg(str, go)
					table.insert(cell._itemGos, go)
				end

				GameUtil.SetActive(go, go ~= nil)
			end
		end

		if cell._txtTitle then
			cell._txtTitle.text = langPara("Fun_SpecialRewardView_Tips_1", data.winStreakTimes)
		end

		local func
		local btnTxt = ""

		if data._state == 3 then
			function func()
				FloatWordMgr.instance:show("该奖励您已领取啦~")
			end

			btnTxt = lang("mail_got")
		elseif data._state == 2 then
			function func()
				FloatWordMgr.instance:show(lang("Fun_SpecialRewardView_Tips_2"))
			end

			btnTxt = lang("spriteladder_non_finish")
		elseif data._state == 1 then
			func = GameUtil.handler(self._onClickBtnGet, self, cell)
			btnTxt = lang("mail_get")
		end

		if cell._txtBtnGet then
			cell._txtBtnGet.text = btnTxt
		end

		GameUtil.SetActive(cell._btnGet, data._state == 1)
		GameUtil.SetActive(cell._noFinishGo, data._state == 2)
		GameUtil.SetActive(cell._receivedGo, data._state == 3)
		GameUtil.addClickHandler(cell._btnGet, func)
	end
end

function FunSpecialRewardView:_clearScrollCell(cellGo)
	return
end

function FunSpecialRewardView:_onClickBtnGet(cell)
	local data = cell._data
	local activityId = self._activityId
	local winStreakTimes = data.winStreakTimes

	FunArenaController.instance:onSendGainWinStreakPrizeReq(activityId, winStreakTimes)
end

return FunSpecialRewardView
