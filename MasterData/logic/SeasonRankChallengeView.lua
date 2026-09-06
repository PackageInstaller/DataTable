-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonRankChallengeView.lua

module("logic.extensions.season.view.SeasonRankChallengeView", package.seeall)

local SeasonRankChallengeView = class("SeasonRankChallengeView", ViewComponent)

function SeasonRankChallengeView:ctor()
	SeasonRankChallengeView.super.ctor(self)
end

function SeasonRankChallengeView:unbindEvents()
	SeasonRankChallengeView.super.unbindEvents(self)
end

function SeasonRankChallengeView:bindEvents()
	SeasonRankChallengeView.super.bindEvents(self)
end

function SeasonRankChallengeView:buildUI()
	SeasonRankChallengeView.super.buildUI(self)

	self._goEmpty = self:getGo("empty")
	self._goTable = self:getGo("tableview")
	self._goCell = self:getGo("cell")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._goItem = self:getGo("item")
	self._goMyRank = self:getGo("myRank")
	self._txtMyRank = goutil.findChildTextComponent(self._goMyRank, "txtMyRank")
	self._txtScore = goutil.findChildTextComponent(self._goMyRank, "txtScore")
	self._txtTime = goutil.findChildTextComponent(self._goMyRank, "txtTime")
end

function SeasonRankChallengeView:onExit()
	SeasonRankChallengeView.super.onExit(self)
	self._tableView:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.SeasonRankUpdate, self._refreshView, self)
	SeasonController.instance:unregisterLocalNotify(SeasonController.RefreshViewData, self._requestViewData, self)
end

function SeasonRankChallengeView:onEnter()
	SeasonRankChallengeView.super.onEnter(self)

	local params = self._viewPresentor:getOpenParam()

	if not params or not params[1] then
		return
	end

	self._rankCfg = params[1]

	GlobalDispatcher:addListener(GlobalNotify.SeasonRankUpdate, self._refreshView, self)
	SeasonController.instance:registerLocalNotify(SeasonController.RefreshViewData, self._requestViewData, self)
	self:_requestViewData(self._rankCfg)
end

function SeasonRankChallengeView:_requestViewData(data)
	if not data or not self._rankCfg then
		return
	end

	if data.rankType ~= self._rankCfg.rankType or data.seasonId ~= self._rankCfg.seasonId then
		return
	end

	SeasonController.instance:sendGetRankInfo(data.rankType, data.seasonId, data.zoneId)
end

function SeasonRankChallengeView:_refreshView(data)
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

	if data.myOtherData > 0 then
		local times = math.ceil(data.myOtherData / 1000)
		local hour, min = math.modf(times / 3600)

		min = math.floor(min * 60)
		sec = times % 60
		self._txtTime.text = string.format("%d:%02d:%02d", hour, min, sec)
	else
		self._txtTime.text = "--:--:--"
	end

	goutil.setActive(self._goEmpty, #data.rankData <= 0)
end

function SeasonRankChallengeView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	if data.rank > 0 then
		cell.txtRank.text = data.rank or "未上榜"
	end

	cell.txtScore.text = data.score
	cell.txtName.text = data.headInfo.userName

	local times = math.ceil(data.otherData / 1000)
	local hour, min = math.modf(times / 3600)

	min = math.floor(min * 60)
	sec = times % 60
	cell.txtTime.text = string.format("%d:%02d:%02d", hour, min, sec)

	local proxy = HeadItemController.instance:setHeadCellByInfo(cell.goHead, data.headInfo)

	if proxy then
		proxy:setCallBack(function()
			FriendController.instance:showInfoView(data.headInfo.userId, proxy)
		end)
	end

	local isRankTop = data.rank > 0 and data.rank <= 3

	goutil.setActive(cell.goImgRank, isRankTop)

	if isRankTop then
		cell.ctrlRankImg:SetState(data.rank - 1)
	end
end

function SeasonRankChallengeView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.ctrlRankImg = goutil.findChildComponent(cell.go, "imgRank", typeof(UIImageSpriteChange))
	cell.txtRank = goutil.findChildTextComponent(cell.go, "txtRank")
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.txtScore = goutil.findChildTextComponent(cell.go, "txtScore")
	cell.txtTime = goutil.findChildTextComponent(cell.go, "txtTime")
	cell.goHead = goutil.findChild(cell.go, "head")
	cell.goImgRank = goutil.findChild(cell.go, "imgRank")

	GameUtil.rmClickHandler(cell.goHead)

	return cell
end

return SeasonRankChallengeView
