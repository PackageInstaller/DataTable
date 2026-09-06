-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonRankRewardView.lua

module("logic.extensions.season.view.SeasonRankRewardView", package.seeall)

local SeasonRankRewardView = class("SeasonRankRewardView", ViewComponent)

function SeasonRankRewardView:ctor()
	SeasonRankRewardView.super.ctor(self)
end

function SeasonRankRewardView:unbindEvents()
	SeasonRankRewardView.super.unbindEvents(self)
	self._btnChanllengeScore:RemoveClickListener()
	self._btnOccupiedScore:RemoveClickListener()
end

function SeasonRankRewardView:bindEvents()
	SeasonRankRewardView.super.bindEvents(self)
	self._btnChanllengeScore:AddClickListener(self._onClickChanllengeScore, self)
	self._btnOccupiedScore:AddClickListener(self._onClickOccupiedScore, self)
end

function SeasonRankRewardView:buildUI()
	SeasonRankRewardView.super.buildUI(self)

	self._goEmpty = self:getGo("empty")
	self._goTable = self:getGo("tableview")
	self._goCell = self:getGo("cell")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._goItem = self:getGo("item")
	self._goMyRank = self:getGo("myRank")
	self._txtMyRank = goutil.findChildTextComponent(self._goMyRank, "txtMyRank")
	self._txtScore = goutil.findChildTextComponent(self._goMyRank, "txtScore")
	self._goRewardView = self:getGo("myRank/rewardView")
	self._goRewardCell = self:getGo("myRank/reward")
	self._rewardView = ScrollerList.create(self._goRewardView, self._goRewardCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._txtTimeTip = self:getTxt("txt")
	self._btnChanllengeScore = self:getBtn("tip/btnChanllengeScore")
	self._btnOccupiedScore = self:getBtn("tip/btnOccupiedScore")
	self._cellToPrizeList = {}
end

function SeasonRankRewardView:onExit()
	SeasonRankRewardView.super.onExit(self)
	self._tableView:dispose()
	self._rewardView:dispose()
	self:_clearCellToPrizeList()
	GlobalDispatcher:removeListener(GlobalNotify.SeasonRankUpdate, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonInfoUpdate, self._refreshView, self)
	SeasonController.instance:unregisterLocalNotify(SeasonController.RefreshViewData, self._requestViewData, self)
	removetimer(self.updateTimer, self)
end

function SeasonRankRewardView:onEnter()
	SeasonRankRewardView.super.onEnter(self)

	local params = self._viewPresentor:getOpenParam()

	if not params or not params[1] then
		return
	end

	self._rankCfg = params[1]

	GlobalDispatcher:addListener(GlobalNotify.SeasonRankUpdate, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonInfoUpdate, self._refreshView, self)
	SeasonController.instance:registerLocalNotify(SeasonController.RefreshViewData, self._requestViewData, self)
	self:_requestViewData(self._rankCfg)
end

function SeasonRankRewardView:_requestViewData(data)
	if not data or not self._rankCfg then
		return
	end

	if data.rankType ~= self._rankCfg.rankType or data.seasonId ~= self._rankCfg.seasonId then
		return
	end

	SeasonController.instance:sendGetRankInfo(data.rankType, data.seasonId, data.zoneId)
end

function SeasonRankRewardView:_refreshView(data)
	if not data or not self._rankCfg then
		return
	end

	if data.rankType ~= self._rankCfg.rankType or data.seasonId ~= self._rankCfg.seasonId then
		return
	end

	self._viewData = data

	self._tableView:reloadData(data.rankData)

	if data.myRank > 0 then
		self._txtMyRank.text = data.myRank or "未上榜"
	end

	self._txtScore.text = data.myScore

	self._rewardView:reloadData(data.myRewardData)

	self._endTime = GameUtil.string2time(data.seasonModeCfg.endTime)

	self:updateTimer()
	settimer(1, self.updateTimer, self)
	goutil.setActive(self._goEmpty, #data.rankData <= 0)
end

function SeasonRankRewardView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	if data.rank > 0 then
		cell.txtRank.text = data.rank or "未上榜"
	end

	cell.txtScore.text = data.score

	local gameMode = SeasonModel.PVE_GAME_MODE_NONE

	gameMode = data.memberInfo and not string.nilorempty(data.memberInfo.userName) and SeasonModel.PVE_GAME_MODE_GVE or SeasonModel.PVE_GAME_MODE_PVE

	if gameMode == SeasonModel.PVE_GAME_MODE_NONE or gameMode == SeasonModel.PVE_GAME_MODE_PVE then
		GameUtil.SetActive(cell.pve, true)
		GameUtil.SetActive(cell.gve, false)

		cell.pve_txtName.text = data.headInfo.userName

		HeadItemController.instance:setHeadCellByInfo(cell.pve_head, data.headInfo, true)
	elseif gameMode == SeasonModel.PVE_GAME_MODE_GVE then
		GameUtil.SetActive(cell.pve, false)
		GameUtil.SetActive(cell.gve, true)

		cell.gve_txtNameMy.text = data.headInfo.userName

		HeadItemController.instance:setHeadCellByInfo(cell.gve_headMy, data.headInfo, true)

		if data.memberInfo then
			cell.gve_txtNameOther.text = data.memberInfo.userName or ""
		end

		HeadItemController.instance:setHeadCellByInfo(cell.gve_headOther, data.memberInfo, true)
	end

	local isRankTop = data.rank > 0 and data.rank <= 3

	goutil.setActive(cell.goImgRank, isRankTop)

	if isRankTop then
		cell.ctrlRankImg:SetState(data.rank - 1)
	end

	local list = ScrollerList.create(cell.goRewardView, self._goItem, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))

	self._cellToPrizeList[cell] = list

	list:reloadData(data.rewardData)
	list:refresh()
end

function SeasonRankRewardView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.ctrlRankImg = goutil.findChildComponent(cell.go, "imgRank", typeof(UIImageSpriteChange))
	cell.txtRank = goutil.findChildTextComponent(cell.go, "txtRank")
	cell.txtScore = goutil.findChildTextComponent(cell.go, "txtScore")
	cell.goImgRank = goutil.findChild(cell.go, "imgRank")
	cell.goRewardView = goutil.findChild(cell.go, "tableview")
	cell.pve = goutil.findChild(cell.go, "playerInfo/pve")
	cell.pve_head = goutil.findChild(cell.go, "playerInfo/pve/head")
	cell.pve_txtName = goutil.findChildTextComponent(cell.go, "playerInfo/pve/txtName")
	cell.gve = goutil.findChild(cell.go, "playerInfo/gve")
	cell.gve_headMy = goutil.findChild(cell.go, "playerInfo/gve/headMy")
	cell.gve_txtNameMy = goutil.findChildTextComponent(cell.go, "playerInfo/gve/txtNameMy")
	cell.gve_headOther = goutil.findChild(cell.go, "playerInfo/gve/headOther")
	cell.gve_txtNameOther = goutil.findChildTextComponent(cell.go, "playerInfo/gve/txtNameOther")

	local list = self._cellToPrizeList[goCell]

	if list then
		list:dispose()
	end

	self._cellToPrizeList[cell] = nil

	HeadItemController.instance:resetHeadCell(cell.pve_head)
	HeadItemController.instance:resetHeadCell(cell.gve_headMy)
	HeadItemController.instance:resetHeadCell(cell.gve_headOther)

	return cell
end

function SeasonRankRewardView:_clearCellToPrizeList()
	for _, v in pairs(self._cellToPrizeList) do
		v:dispose()
	end

	self._cellToPrizeList = {}
end

function SeasonRankRewardView:_updateRewardCell(view, goCell, data)
	local proxy = MaterialMgr.setCellByCfg(data, goCell)

	if proxy then
		proxy.binder:setEffStatus(false)
	end
end

function SeasonRankRewardView:_clearRewardCell(goCell)
	MaterialMgr.resetAll(goCell)
end

function SeasonRankRewardView:_onClickChanllengeScore()
	GlobalDispatcher:dispatch(GlobalNotify.SeasonRankChangeTab, SeasonRankModel.RankType.Challenge)
end

function SeasonRankRewardView:_onClickOccupiedScore()
	GlobalDispatcher:dispatch(GlobalNotify.SeasonRankChangeTab, SeasonRankModel.RankType.Occupied)
end

function SeasonRankRewardView:updateTimer()
	local residue = self._endTime - ServerTime.now()

	if residue > 0 then
		local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(residue)

		self._txtTimeTip.text = day > 0 and string.format("剩余时间: %s天%s时%s分", day, hour, min) or string.format("剩余时间： %s时%s分%s秒", hour, min, sec)
	else
		removetimer(self.updateTimer, self)

		self._txtTimeTip.text = "剩余时间: 已结算"

		return
	end
end

return SeasonRankRewardView
