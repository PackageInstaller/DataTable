-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/view/OriMatGameSeasonPrizeView.lua

module("logic.extensions.orimatgame.view.OriMatGameSeasonPrizeView", package.seeall)

local OriMatGameSeasonPrizeView = class("OriMatGameSeasonPrizeView", ViewComponent)

function OriMatGameSeasonPrizeView:buildUI()
	OriMatGameSeasonPrizeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtTips = self:getTxt("tips/txt")

	local taskScrCell = self:getGo("taskCol/scrCell")
	local taskScrView = self:getGo("taskCol/scrView")

	self._itemScrCell = self:getGo("taskCol/itemScrCell")
	self._taskScrollerList = ScrollerList.create(taskScrView, taskScrCell, GameUtil.handler(self._updateTaskCell, self), GameUtil.handler(self._clearTaskCell, self))
	self._itemScrollerListDic = {}

	GameUtil.SetActive(self._itemScrCell, false)
end

function OriMatGameSeasonPrizeView:bindEvents()
	OriMatGameSeasonPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function OriMatGameSeasonPrizeView:unbindEvents()
	OriMatGameSeasonPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function OriMatGameSeasonPrizeView:onEnter()
	OriMatGameSeasonPrizeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])
	self._subMo = OriMatGameController.instance:getSubMo(self._seasonId)
	self._seasonData = OriMatGameConfig.instance:getSeasonData(self._seasonId)
	self._prizePlanId = self._seasonData.prizePlanId
	self._prizeCfgs = OriMatGameConfig.instance:getPrizeCfgs(self._prizePlanId)

	self.addGEvent(self, GlobalNotify.HandlePM_OriginMaterialGameInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_OriginMaterialGameGainPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_OriginMaterialGameOneKeyGainPrizeRes, self._onUpdate, self)
	self:_onUpdate()
end

function OriMatGameSeasonPrizeView:onExit()
	OriMatGameSeasonPrizeView.super.onExit(self)
	self:_onClearTaskColUI()
end

function OriMatGameSeasonPrizeView:_handlePM_OriginMaterialGameOneKeyGainPrizeRes()
	OriMatGameController.instance:sendPM_OriginMaterialGameInfoReq(self._seasonId)
end

function OriMatGameSeasonPrizeView:_onUpdate()
	self._txtTips.text = string.format("本赛季累计最高波次：%s", self._subMo:getTotalWaveNum())

	self:_onUpdateTaskColUI()
end

function OriMatGameSeasonPrizeView:_onUpdateTaskColUI()
	local infoList = {}

	for _, data in ipairs(self._prizeCfgs) do
		local info = {}

		info.prizeId = data.prizeId
		info.state = self._subMo:getPrizeState(data.prizeId)

		table.insert(infoList, info)
	end

	table.sort(infoList, function(a, b)
		if a.state == b.state then
			return a.prizeId < b.prizeId
		end

		return a.state < b.state
	end)
	self._taskScrollerList:reloadData(infoList)
end

function OriMatGameSeasonPrizeView:_onClearTaskColUI()
	self._taskScrollerList:dispose()
end

function OriMatGameSeasonPrizeView:_updateTaskCell(view, cell, info, tag)
	local prizeId = info.prizeId
	local state = info.state
	local data = OriMatGameConfig.instance:getPrizeCfg(self._prizePlanId, info.prizeId)
	local mainGo = cell.gameObject
	local tagNotEnough = goutil.findChild(mainGo, "tagNotEnough")
	local btnReceive = goutil.findChild(mainGo, "btnReceive")
	local btnGoto = goutil.findChild(mainGo, "btnGoto")
	local receivedGo = goutil.findChild(mainGo, "receivedGo")
	local txtProgress = goutil.findChildTextComponent(mainGo, "txtProgress")
	local txtDesc = MaterialMgr.findGraphicText(mainGo, "txtDesc")

	if goutil.isNil(txtDesc) then
		txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	end

	local itemScrView = goutil.findChild(mainGo, "itemScrView")

	txtProgress.text = data.totalWaveNum

	local prizeStrArr = string.split(data.prize, "#")

	if not self._itemScrollerListDic[mainGo] then
		local scrollerList = ScrollerList.create(itemScrView, self._itemScrCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

		self._itemScrollerListDic[mainGo] = self._itemScrollerListDic[mainGo]

		self._itemScrollerListDic[mainGo]:reloadData(prizeStrArr)
		self._itemScrollerListDic[mainGo]:dragNotifyParent()
		GameUtil.SetActive(btnReceive, state == GameEnum.PrizeState.IsCanGet)
		GameUtil.SetActive(receivedGo, state == GameEnum.PrizeState.IsHasGain)
		GameUtil.SetActive(tagNotEnough, state == GameEnum.PrizeState.IsNotEnough)
		GameUtil.addClickHandler(btnReceive, function()
			local result = GameEnum.ResultCode.Success
			local tips = ""

			if self._subMo:isHasGainPrize(prizeId) then
				result = GameEnum.ResultCode.Error
				tips = "已领取"
			elseif not self._subMo:isEnoughPrize(prizeId) then
				result = GameEnum.ResultCode.Error
				tips = "未满足要求"
			end

			FloatWordMgr.instance:show(tips)

			if result ~= GameEnum.ResultCode.Success then
				return
			end

			OriMatGameController.instance:sendPM_OriginMaterialGameGainPrizeReq(self._seasonId)
		end)
	end
end

function OriMatGameSeasonPrizeView:_clearTaskCell(cell)
	local mainGo = cell.gameObject
	local btnReceive = goutil.findChild(mainGo, "btnReceive")
	local itemScrollerList = self._itemScrollerListDic[mainGo]

	if itemScrollerList then
		itemScrollerList:dispose()

		self._itemScrollerListDic[mainGo] = nil
	end

	GameUtil.rmClickHandler(btnReceive)
end

function OriMatGameSeasonPrizeView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.setCellByCfg(prizeStr, item)
end

function OriMatGameSeasonPrizeView:_clearItemCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

return OriMatGameSeasonPrizeView
