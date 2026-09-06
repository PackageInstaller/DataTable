-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/giftbox/view/GiftBoxPrizeShowView.lua

module("logic.extensions.giftbox.view.GiftBoxPrizeShowView", package.seeall)

local GiftBoxPrizeShowView = class("GiftBoxPrizeShowView", ViewComponent)

GiftBoxPrizeShowView.ItemOffsetY = 25

function GiftBoxPrizeShowView:ctor()
	GiftBoxPrizeShowView.super.ctor(self)
end

function GiftBoxPrizeShowView:unbindEvents()
	GiftBoxPrizeShowView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function GiftBoxPrizeShowView:bindEvents()
	GiftBoxPrizeShowView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function GiftBoxPrizeShowView:buildUI()
	GiftBoxPrizeShowView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local playerRoot = self:getGo("playerRoot")

	self._rewardSliderMo = PlayerSliderMo.New(playerRoot)
	self._boxTableView = self:getGo("prizeTableCol/boxScrollerview")
	self._boxTableCell = self:getGo("prizeTableCol/boxScrollercell")
	self._rewardTableView = goutil.findChildComponent(self._boxTableCell, "rewardList", "UITableGrid")
	self._boxCon = self:getGo("prizeTableCol/boxCon")
end

function GiftBoxPrizeShowView:onExit()
	GiftBoxPrizeShowView.super.onExit(self)
	self._rewardSliderMo:onExit()
end

function GiftBoxPrizeShowView:onEnter()
	GiftBoxPrizeShowView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.handleGB_GiftBoxGainSharePrizeRes, self.refreshUI, self)
	self.addGEvent(self, GlobalNotify.handleGB_GiftBoxGetInfoRes, self.initViewData, self)

	self._actId = self:getFirstParam()

	self:initSlider()

	self._boxTableList = ScrollerList.create(self._boxTableView, self._boxTableCell, GameUtil.handler(self._updateBoxCell, self), GameUtil.handler(self._clearBoxCell, self))

	self._boxTableList:regGetCellSize(GameUtil.handler(self._getBoxCellSize, self))

	self._itemScrollListDic = {}

	GiftBoxAgent.instance:sendGB_GiftBoxGetInfoReq(self._actId)
end

function GiftBoxPrizeShowView:refreshUI()
	self._rewardSliderMo:updatePlayerReward()
	self._boxTableList:reloadData(self._boxPrizeData)
end

function GiftBoxPrizeShowView:initSlider()
	local sliderParam = {}

	sliderParam.view = self
	sliderParam.prizeCfgs = GiftBoxConfig.instance:getGainLuckPrizeCfg(self._actId)

	function sliderParam.getPlayerProgress()
		return GiftBoxModel.instance:getGainMyLuckCount()
	end

	function sliderParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.peopleNum
	end

	function sliderParam.getPrizeByRewardCfg(rewardCfg)
		return rewardCfg.prize
	end

	function sliderParam.isPlayerRewardCanGet(rewardCfg)
		return GiftBoxModel.instance:isCanGetProgressReward(rewardCfg.peopleNum, rewardCfg.prizeId)
	end

	function sliderParam.isPlayerRewardGeted(rewardCfg)
		return GiftBoxModel.instance:isGetedProgressReward(rewardCfg.prizeId)
	end

	function sliderParam.sendGainPlayerPrizeReq(rewardCfg)
		GiftBoxAgent.instance:sendGB_GiftBoxGainSharePrizeReq(self._actId, rewardCfg.prizeId)
	end

	local isSkipAnimation = true

	self._rewardSliderMo:initParam(sliderParam, isSkipAnimation)
	self._rewardSliderMo:onEnter()
	self._rewardSliderMo:updatePlayerReward()
	self._rewardSliderMo:relocation()
end

function GiftBoxPrizeShowView:initViewData()
	self._boxTableCellWeight = GameUtil.getWidth(self._boxTableCell)
	self._boxSizeHeight = GameUtil.getWidth(self._boxCon)
	self._exTableHeight = GameUtil.getHeight(self._boxTableCell) - self._boxSizeHeight
	self._boxPrizeData = {}

	local boxTypeCfgs = GiftBoxConfig.instance:getBoxTypeCfgs(self._actId)

	for i, v in ipairs(boxTypeCfgs) do
		local boxType = v.boxType
		local normalPrizePlanId = GiftBoxConfig.instance:getBoxNormalPrizePlan(boxType)
		local normalPrizeCfgs = GiftBoxConfig.instance:getNormalPrizeCfg(normalPrizePlanId)
		local superPrizeCfg = GiftBoxConfig.instance:getSuperPrizeCfg(v.superPrizePlanId)
		local superDataPrzeInfo = {}

		for i, v in ipairs(superPrizeCfg) do
			local superPrize = GiftBoxModel.instance:getSuperPrizeInfo()

			if not superPrize[v.superPrizePlanId][v.prizeId] then
				table.insert(superDataPrzeInfo, {
					isSuper = true,
					cfg = v,
					isGain = superPrize[v.superPrizePlanId][v.prizeId]
				})
			end
		end

		local superData = {
			isSuper = true,
			cfg = v,
			prize = superDataPrzeInfo
		}

		table.insert(self._boxPrizeData, superData)

		local normalData = {
			isSuper = false,
			cfg = v,
			prize = normalPrizeCfgs
		}

		table.insert(self._boxPrizeData, normalData)
	end

	self:refreshUI()
end

function GiftBoxPrizeShowView:_updateBoxCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtType = goutil.findChildTextComponent(go, "list/img/img/txtType")
	local rewardListGo = goutil.findChild(go, "rewardList")
	local viewPoint = goutil.findChild(go, "rewardList/Viewport")
	local listNameGo = goutil.findChild(go, "list")

	txtType.text = data.isSuper == true and langPara("%s惊喜奖励", data.cfg.name) or langPara("%s必得奖励", data.cfg.name)

	if rewardListGo and self._boxCon then
		local prizeStrArr = data.prize

		if not self._itemScrollListDic[go] then
			local itemScrollList = ScrollerList.create(rewardListGo, self._boxCon, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[go] = self._itemScrollListDic[go]

			self._itemScrollListDic[go]:reloadData(prizeStrArr)
			self._itemScrollListDic[go]:dragNotifyParent()

			local line = math.ceil(#prizeStrArr / self._rewardTableView.numRowsOrCols)

			GameUtil.setHeight(viewPoint, (self._boxSizeHeight + GiftBoxPrizeShowView.ItemOffsetY) * line + self._exTableHeight - GiftBoxPrizeShowView.ItemOffsetY)
			GameUtil.setHeight(listNameGo, (self._boxSizeHeight + GiftBoxPrizeShowView.ItemOffsetY) * line + self._exTableHeight - GiftBoxPrizeShowView.ItemOffsetY)
		end
	end
end

function GiftBoxPrizeShowView:_clearBoxCell(cell)
	local go = cell.gameObject
	local itemScrollList = self._itemScrollListDic[go]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function GiftBoxPrizeShowView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject
	local prizeCon = goutil.findChild(go, "prizeCon")
	local gainGo = goutil.findChild(go, "gainGo")

	GameUtil.SetActive(gainGo, false)

	local cfg

	if data.isSuper then
		cfg = data.cfg

		GameUtil.SetActive(gainGo, data.isGain)
	else
		cfg = data
	end

	MaterialMgr.setCellByCfg(cfg.prize, prizeCon)
end

function GiftBoxPrizeShowView:_clearItemCell(cell)
	local go = cell.gameObject
	local prizeCon = goutil.findChild(go, "prizeCon")

	MaterialMgr.resetAll(prizeCon)
end

function GiftBoxPrizeShowView:_getBoxCellSize(view, idx)
	local count = self:getCountByIndex(idx)
	local line = math.ceil(count / self._rewardTableView.numRowsOrCols)

	return self._boxTableCellWeight, (self._boxSizeHeight + GiftBoxPrizeShowView.ItemOffsetY) * line + self._exTableHeight - GiftBoxPrizeShowView.ItemOffsetY
end

function GiftBoxPrizeShowView:getCountByIndex(idx)
	return #self._boxPrizeData[idx + 1].prize
end

return GiftBoxPrizeShowView
