-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraiderrankView.lua

module("logic.extensions.treasureraider.view.TreasureraiderrankView", package.seeall)

local TreasureraiderrankView = class("TreasureraiderrankView", ViewComponent)

function TreasureraiderrankView:ctor()
	TreasureraiderrankView.super.ctor(self)
end

function TreasureraiderrankView:unbindEvents()
	TreasureraiderrankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function TreasureraiderrankView:bindEvents()
	TreasureraiderrankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function TreasureraiderrankView:buildUI()
	TreasureraiderrankView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._goEmpty = self:getGo("rankCol/empty")
	self._goTable = self:getGo("rankCol/tableview")
	self._goCell = self:getGo("rankCol/cell")
	self._rankList = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._goItem = self:getGo("rankCol/item")
	self._goMyRank = self:getGo("rankCol/myRank")
	self._txtMyRank = goutil.findChildTextComponent(self._goMyRank, "txtMyRank")
	self._txtScore = goutil.findChildTextComponent(self._goMyRank, "txtScore")
	self._goRewardView = self:getGo("rankCol/myRank/rewardView")
	self._goRewardCell = self:getGo("rankCol/myRank/reward")
	self._rewardList = ScrollerList.create(self._goRewardView, self._goRewardCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._cellToPrizeList = {}
end

function TreasureraiderrankView:onExit()
	TreasureraiderrankView.super.onExit(self)
	TreasureRaiderController.instance:unregisterLocalNotify(TreasureRaiderController.RankAfterGetInfo, self._refreshView, self)
	self._rankList:dispose()
	self._rewardList:dispose()
	self:_clearCellToPrizeList()
end

function TreasureraiderrankView:onEnter()
	TreasureraiderrankView.super.onEnter(self)
	TreasureRaiderController.instance:registerLocalNotify(TreasureRaiderController.RankAfterGetInfo, self._refreshView, self)

	self._txtScore.text = "0"
	self._activityId = checknumber(self:getFirstParam())

	GameUtil.SetActive(self._goEmpty, true)
	self:_initPrizeConfigs()
	self:_requestData()
end

function TreasureraiderrankView:_initPrizeConfigs()
	local rankPrizes = TreasureRaiderConfig.instance:getRankPrizeConfigs()

	self._rankPrizeConfigs = {}

	for k, v in pairs(rankPrizes) do
		if checknumber(k) > 0 then
			table.insert(self._rankPrizeConfigs, v)
		end
	end

	ArraySort.sortOn(self._rankPrizeConfigs, "rightTop")
end

function TreasureraiderrankView:_getPrizeConfigByRank(order)
	if order > 0 then
		for i = 1, #self._rankPrizeConfigs - 1 do
			local cfg = self._rankPrizeConfigs[i]

			if order <= cfg.rightTop then
				return cfg
			end
		end

		return self._rankPrizeConfigs[#self._rankPrizeConfigs]
	end

	return nil
end

function TreasureraiderrankView:_requestData()
	RichManAgent.instance:sendPM_RichManGetRankReq(self._activityId)
end

function TreasureraiderrankView:_refreshView(data)
	if data.activityId == self._activityId then
		self:_updateMyRank(data)
		GameUtil.SetActive(self._goEmpty, data.rankSize <= 0)
		self._rankList:reloadData(data.rankList)
	end
end

function TreasureraiderrankView:_updateMyRank(data)
	if data.myRank > 0 then
		self._txtMyRank.text = data.myRank or lang("未上榜")
	end

	self._txtScore.text = data.myScore

	local var_11_0 = self:_getPrizeConfigByRank(data.myRank or 0)

	if not var_11_0 then
		var_11_0 = {}

		local prizeConfig = var_11_0

		self._rewardList:reloadData((not string.nilorempty(prizeConfig.prize) or nil) and string.split(prizeConfig.prize, "#"))
	end
end

function TreasureraiderrankView:_updateRankCell(view, goCell, data, tag)
	local cell = self:_clearRankCell(goCell)

	if data.rank > 0 then
		cell.txtRank.text = data.rank or lang("未上榜")
	end

	cell.txtScore.text = data.totalDamage
	cell.txtName.text = data.headInfo.userName

	local proxy = HeadItemController.instance:setHeadCellByInfo(cell.goHead, data.headInfo)

	if proxy then
		proxy:setCallBack(function()
			FriendController.instance:showInfoView(data.headInfo.userId, proxy)
		end)
	end

	local isRankTop = data.rank > 0 and data.rank <= 3

	GameUtil.SetActive(cell.goImgRank, isRankTop)

	if isRankTop then
		cell.ctrlRankImg:SetState(data.rank - 1)
	end

	local list = ScrollerList.create(cell.goRewardView, self._goItem, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))

	self._cellToPrizeList[cell] = list

	local prizeConfig = self:_getPrizeConfigByRank(data.rank) or {}

	list:reloadData((not string.nilorempty(prizeConfig.prize) or nil) and string.split(prizeConfig.prize, "#"))
end

function TreasureraiderrankView:_clearRankCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.ctrlRankImg = goutil.findChildComponent(cell.go, "imgRank", typeof(UIImageSpriteChange))
	cell.txtRank = goutil.findChildTextComponent(cell.go, "txtRank")
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.txtScore = goutil.findChildTextComponent(cell.go, "txtScore")
	cell.goHead = goutil.findChild(cell.go, "head")
	cell.goImgRank = goutil.findChild(cell.go, "imgRank")
	cell.goRewardView = goutil.findChild(cell.go, "tableview")

	local list = self._cellToPrizeList[goCell]

	if list then
		list:dispose()
	end

	self._cellToPrizeList[cell] = nil

	HeadItemController.instance:resetHeadCell(cell.goHead)

	return cell
end

function TreasureraiderrankView:_clearCellToPrizeList()
	for _, v in pairs(self._cellToPrizeList) do
		v:dispose()
	end

	self._cellToPrizeList = {}
end

function TreasureraiderrankView:_updateRewardCell(view, goCell, data)
	MaterialMgr.resetAll(goCell)

	local proxy = MaterialMgr.setCellByCfg(data, goCell)

	if proxy then
		proxy.binder:setEffStatus(false)
	end
end

function TreasureraiderrankView:_clearRewardCell(goCell)
	MaterialMgr.resetAll(goCell)
end

return TreasureraiderrankView
