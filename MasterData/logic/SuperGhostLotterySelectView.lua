-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/superghostlottery/view/SuperGhostLotterySelectView.lua

module("logic.extensions.superghostlottery.view.SuperGhostLotterySelectView", package.seeall)

local SuperGhostLotterySelectView = class("SuperGhostLotterySelectView", ViewComponent)

function SuperGhostLotterySelectView:ctor()
	SuperGhostLotterySelectView.super.ctor(self)
end

function SuperGhostLotterySelectView:buildUI()
	SuperGhostLotterySelectView.super.buildUI(self)

	self.txtTitle = self:getTxt("txtTitle")
	self.btnClose = self:getBtn("btnClose")
	self.btnSure = self:getBtn("btnSure")

	local cell = self:getGo("cell")
	local scroll = self:getGo("ScrollView")

	self.scrollList = ScrollerList.create(scroll, cell, GameUtil.handler(self.updateCell, self), GameUtil.handler(self.clearPetCell, self))
end

function SuperGhostLotterySelectView:bindEvents()
	SuperGhostLotterySelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnSure, self._onClickSure, self)
end

function SuperGhostLotterySelectView:unbindEvents()
	SuperGhostLotterySelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnSure)
end

function SuperGhostLotterySelectView:destroyUI()
	SuperGhostLotterySelectView.super.destroyUI(self)
end

function SuperGhostLotterySelectView:onEnter()
	SuperGhostLotterySelectView.super.onEnter(self)

	self.selectItem = nil
	self._activityId = SuperGhostLotteryModel.instance:getCurrActId()
	self._actCfg = SuperGhostLotteryConfig.instance:getActivityCfg(self._activityId)

	local drawInfo = SuperGhostLotteryModel.instance:getDrawInfo()

	self._round = drawInfo.orderId
	self._selectedBigPrizeIds = SuperGhostLotteryModel.instance:getSelectedBigPrizeIds()

	local prizeCfg = SuperGhostLotteryConfig.instance:getPrizeCfgByRound(self._actCfg.prizePlanId, self._round)
	local dataList = {}

	if prizeCfg and prizeCfg[SuperGhostLotteryView.BigPrizeType] then
		for i, bigPrizeCfg in ipairs(prizeCfg[SuperGhostLotteryView.BigPrizeType]) do
			local isSelect = false

			for j, prizeId in ipairs(self._selectedBigPrizeIds) do
				if bigPrizeCfg.prizeId == prizeId then
					isSelect = true
				end
			end

			if not isSelect then
				table.insert(dataList, bigPrizeCfg)
			end
		end
	end

	self.scrollList:reloadData(dataList)
end

function SuperGhostLotterySelectView:onEnterFinished()
	SuperGhostLotterySelectView.super.onEnterFinished(self)
end

function SuperGhostLotterySelectView:onExit()
	SuperGhostLotterySelectView.super.onExit(self)
	self.scrollList:dispose()
end

function SuperGhostLotterySelectView:onExitFinished()
	SuperGhostLotterySelectView.super.onExitFinished(self)
end

function SuperGhostLotterySelectView:clearCell(cell)
	local con = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(con)
	GameUtil.rmClickHandler(cell)
end

function SuperGhostLotterySelectView:updateCell(view, cell, data)
	local imgSelect = goutil.findChild(cell, "imgSelect")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtCount = goutil.findChildTextComponent(cell, "txtCount")
	local item = goutil.findChild(cell, "item")

	GameUtil.SetActive(imgSelect, self.selectItem == data)
	MaterialMgr.setCellByCfg(data.prize, item)

	local matType, cfgId, num = MaterialMgr.getMatParams(data.prize)

	txtName.text = MaterialMgr.getMaterialsName(matType, cfgId)
	txtCount.text = "x" .. num

	GameUtil.addClickHandler(cell, GameUtil.handler(self.onItemClick, self, data))
end

function SuperGhostLotterySelectView:onItemClick(data)
	self.selectItem = data

	self.scrollList:refresh()
end

function SuperGhostLotterySelectView:_onClickSure()
	if self.selectItem then
		SuperGhostLotteryController.instance:sendPM_SuperGhostLotterySelectBigPrizeReq(self._activityId, self.selectItem.prizeId)
		self:close()
	else
		FloatWordMgr.instance:show(lang("请选择奖品"))
	end
end

return SuperGhostLotterySelectView
