-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/companionmall/view/CompanionMallBoxRankView.lua

module("logic.extensions.companionmall.view.CompanionMallBoxRankView", package.seeall)

local CompanionMallBoxRankView = class("CompanionMallBoxRankView", ViewComponent)

function CompanionMallBoxRankView:ctor()
	CompanionMallBoxRankView.super.ctor(self)
end

function CompanionMallBoxRankView:buildUI()
	CompanionMallBoxRankView.super.buildUI(self)

	self._ranktableGo = goutil.findChild(self.mainGO, "rankScrollRect")
	self._ranktableCell = goutil.findChild(self.mainGO, "cell")
	self._rankTableList = ScrollerList.create(self._ranktableGo, self._ranktableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._emptyGo = goutil.findChild(self.mainGO, "goEmpty")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "myRank/txtMyRank")
	self._txtMyTime = self:getTxt("myRank/txtMyTime")
end

function CompanionMallBoxRankView:bindEvents()
	CompanionMallBoxRankView.super.bindEvents(self)
end

function CompanionMallBoxRankView:unbindEvents()
	CompanionMallBoxRankView.super.unbindEvents(self)
end

function CompanionMallBoxRankView:destroyUI()
	CompanionMallBoxRankView.super.destroyUI(self)
end

function CompanionMallBoxRankView:onEnter()
	CompanionMallBoxRankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.COMPANION_MALL_RANK_INFO, self._refreshView, self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._companionId = checknumber(params[2])

	CompanionMallController.instance:sendGetRankInfo(self._activityId, self._companionId)
end

function CompanionMallBoxRankView:onExit()
	CompanionMallBoxRankView.super.onExit(self)
	self._rankTableList:dispose()
end

function CompanionMallBoxRankView:_refreshView()
	local rankInfo = CompanionMallModel.instance:getRankInfo(self._activityId)
	local myRank = rankInfo.myRank
	local myTime = rankInfo.myTime

	if not rankInfo.recordList then
		self._rankTableList:reloadData(rankInfo.recordList)

		if #rankInfo.recordList > 0 then
			GameUtil.SetActive(self._emptyGo, false)
		else
			GameUtil.SetActive(self._emptyGo, true)
		end

		self._txtMyRank.text = checknumber(myRank) > 0 and myRank or lang("未上榜")

		if checknumber(myTime) > 0 then
			local time = GameUtil.time2date(checknumber(myTime) / 1000)

			self._txtMyTime.text = string.format("%d.%d.%d %02d:%02d:%02d", time.year, time.month, time.day, time.hour, time.min, time.sec)
		else
			self._txtMyTime.text = lang("未达成")
		end
	end
end

function CompanionMallBoxRankView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgChangeRank = goutil.findChildComponent(go, "imgRank", "UIImageSpriteChange")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtTime = goutil.findChildTextComponent(go, "txtTime")
	local txtArea = goutil.findChildTextComponent(go, "txtArea")
	local rankInfo = data

	txtRank.text = rankInfo.rank

	GameUtil.SetActive(imgChangeRank, rankInfo.rank <= 3 and rankInfo.rank > 0)

	if rankInfo.rank <= 3 and rankInfo.rank > 0 then
		imgChangeRank:SetState(rankInfo.rank - 1)
		GameUtil.SetActive(imgChangeRank, true)
		GameUtil.SetActive(txtRank, false)
	else
		GameUtil.SetActive(imgChangeRank, false)
		GameUtil.SetActive(txtRank, true)
	end

	HeadItemController.instance:setHeadCellByInfo(imgIcon, rankInfo.headInfo, true)

	local time = GameUtil.time2date(checknumber(rankInfo.time) / 1000)

	txtName.text = rankInfo.headInfo.userName
	txtTime.text = string.format("%d.%d.%d %02d:%02d:%02d", time.year, time.month, time.day, time.hour, time.min, time.sec)
	txtArea.text = rankInfo.headInfo.areaName
end

function CompanionMallBoxRankView:_clearCell(cell)
	local go = cell.gameObject

	HeadItemController.instance:resetHeadCell(go)
end

return CompanionMallBoxRankView
