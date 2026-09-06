-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lanternfestival/view/LanternFestivalCollectView.lua

module("logic.extensions.lanternfestival.view.LanternFestivalCollectView", package.seeall)

local LanternFestivalCollectView = class("LanternFestivalCollectView", ViewComponent)

function LanternFestivalCollectView:ctor()
	LanternFestivalCollectView.super.ctor(self)
end

function LanternFestivalCollectView:unbindEvents()
	LanternFestivalCollectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnGotoSource)

	for i, cell in ipairs(self._exchangeCellList) do
		GameUtil.rmClickHandler(cell.btnExchange)
	end
end

function LanternFestivalCollectView:bindEvents()
	LanternFestivalCollectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnGotoSource, self._onClickBtnGotoSource, self)

	for i, cell in ipairs(self._exchangeCellList) do
		local function onClickExchange()
			self:_onClickBtnExchange(i)
		end

		GameUtil.addClickHandler(cell.btnExchange, onClickExchange, self)
	end
end

function LanternFestivalCollectView:buildUI()
	LanternFestivalCollectView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnGotoSource = self:getGo("btnGotoSource")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._costcell = self:getGo("costcell")

	goutil.setActive(self._costcell, false)

	self._exchangeCellList = {}

	for i = 1, 2 do
		local cell = {}

		cell.go = self:getGo("exchange/com_" .. i)
		cell.costItemList = {}

		for j = 1, 6 do
			local costItemCell = {}
			local posGo = goutil.findChild(cell.go, "costList/pos" .. j)

			costItemCell.go = goutil.cloneAndSetParent(self._costcell, posGo.transform, "costcell")
			costItemCell.item = goutil.findChild(costItemCell.go, "item")
			costItemCell.txtNum = goutil.findChildTextComponent(costItemCell.go, "txtNum")

			GameUtil.setAnchoredPos(costItemCell.go, 0, 0)
			goutil.setActive(costItemCell.go, true)
			table.insert(cell.costItemList, costItemCell)
		end

		cell.targetItem = goutil.findChild(cell.go, "targetItem")
		cell.btnExchange = goutil.findChild(cell.go, "btnExchange")
		cell.mark = goutil.findChild(cell.go, "mark")

		table.insert(self._exchangeCellList, cell)
	end
end

function LanternFestivalCollectView:onExit()
	LanternFestivalCollectView.super.onExit(self)

	for i, cell in ipairs(self._exchangeCellList) do
		MaterialMgr.resetAll(cell.targetItem)

		for j, costItemCell in ipairs(cell.costItemList) do
			MaterialMgr.resetAll(costItemCell.item)
		end
	end
end

function LanternFestivalCollectView:onEnter()
	LanternFestivalCollectView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 566001
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	self.addGEvent(self, GlobalNotify.PM_LanternFestivalInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_LanternFestivalExchangeCollectPrizeRes, self._updateUIByInfo, self)
	LanternFestivalController.instance:getInfo(self._activityId)
end

function LanternFestivalCollectView:_updateUIByCfg()
	self._actCfg = LanternFestivalConfig.instance:getActivityCfg(self._activityId)
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._collectPrizeCfgs = LanternFestivalConfig.instance:getCollectionPrizeCfgs(self._activityId) or {}
	self._curShowMatStrMap = {}

	for i, cell in ipairs(self._exchangeCellList) do
		local prizeCfg = self._collectPrizeCfgs[i]

		if prizeCfg then
			cell.go:SetActive(true)

			self._curShowMatStrMap[i] = {}

			if not prizeCfg.cost then
				local costMatStrs = ""

				MaterialMgr.resetAll(cell.targetItem)
				MaterialMgr.setCellByCfg(prizeCfg.prize, cell.targetItem)

				local strAttr = string.split(costMatStrs, "#")

				for j, str in ipairs(strAttr) do
					self._curShowMatStrMap[i][j] = str
				end
			end
		else
			cell.go:SetActive(false)
		end
	end
end

function LanternFestivalCollectView:_updateUIByInfo()
	self._gainStateMap = {}

	local info = LanternFestivalModel.instance:getInfoByActId(self._activityId)

	if info then
		if not info.gainCollectPrizeIds then
			for _, prizeId in ipairs(info.gainCollectPrizeIds) do
				self._gainStateMap[prizeId] = true
			end
		end
	end

	self._matchStateMap = {}

	for i, cell in ipairs(self._exchangeCellList) do
		local isMatch = true

		for j, costItemCell in ipairs(cell.costItemList) do
			MaterialMgr.resetAll(costItemCell.item)

			local matStr = self._curShowMatStrMap[i][j]

			if matStr then
				local matType, matId, matNum = MaterialMgr.getMatParams(matStr)
				local proxy = MaterialMgr.setCellByCfg(matStr, costItemCell.item)

				costItemCell.txtNum.text = string.format("%s/%s", MaterialMgr.getMatCount(matStr), matNum)

				if MaterialMgr.getMatEnough(matStr) then
					proxy.binder:SetGray(false)
					proxy.binder:setAutoTips(true)
					GameUtil.SetGray(costItemCell.item, false)
				else
					proxy.binder:SetGray(true)
					proxy.binder:setAutoTips(false)
					proxy:setCallBack(function()
						MaterialMgr.openGetSourceByStr(matStr)
					end)
					GameUtil.SetGray(costItemCell.item, true)

					isMatch = false
				end

				proxy.binder:setBgActive(false)
				proxy.binder:setNum(0)
			end
		end

		GameUtil.SetGray(cell.btnExchange, false)
		goutil.setActive(cell.btnExchange, not self._gainStateMap[i])
		goutil.setActive(cell.mark, self._gainStateMap[i])

		if not isMatch then
			GameUtil.SetGray(cell.btnExchange, true)
		else
			GameUtil.SetGray(cell.btnExchange, false)
		end

		self._matchStateMap[i] = isMatch
	end
end

function LanternFestivalCollectView:_onClickBtnTip()
	local key = self._actCfg.collectRuleKey

	TipsFacade.instance:openRulesView(key)
end

function LanternFestivalCollectView:_onClickBtnGotoSource()
	local jumpToStr = self._actCfg.gotoCollectItem

	GotoMgr.gotoByString(jumpToStr)
end

function LanternFestivalCollectView:_onClickBtnExchange(index)
	if self._gainStateMap[index] then
		FloatWordMgr.instance:show("该奖励已兑换")

		return
	end

	if not self._matchStateMap[index] then
		FloatWordMgr.instance:show("缺少福字，无法兑换")

		return
	end

	if index > 1 then
		for i = 1, index - 1 do
			local state = self._gainStateMap[i]

			if not state then
				FloatWordMgr.instance:show("请按顺序兑换奖励")

				return
			end
		end
	end

	LanternFestivalController.instance:exchangeCollectPrize(self._activityId, index)
end

return LanternFestivalCollectView
