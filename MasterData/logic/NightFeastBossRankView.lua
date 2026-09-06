-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nightfeastbosschallenge/view/NightFeastBossRankView.lua

module("logic.extensions.nightfeastbosschallenge.view.NightFeastBossRankView", package.seeall)

local NightFeastBossRankView = class("NightFeastBossRankView", ViewComponent)

function NightFeastBossRankView:ctor()
	NightFeastBossRankView.super.ctor(self)
end

function NightFeastBossRankView:buildUI()
	NightFeastBossRankView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._ranktableGo = goutil.findChild(self.mainGO, "right/rankScrollRect")
	self._ranktableCell = goutil.findChild(self.mainGO, "right/cell")
	self._emptyGo = goutil.findChild(self.mainGO, "right/goEmpty")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "right/myRank/txtMyRank")
end

function NightFeastBossRankView:bindEvents()
	NightFeastBossRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function NightFeastBossRankView:unbindEvents()
	NightFeastBossRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function NightFeastBossRankView:onEnter()
	NightFeastBossRankView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	self.addGEvent(self, GlobalNotify.NightFeastBossClgGetRankRes, self._refreshView, self)

	self._rankTable = ScrollerList.create(self._ranktableGo, self._ranktableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	NightFeastBossChallengeAgent.instance:sendPM_NightFeastBossClgGetRankReq(self._activityId)
end

function NightFeastBossRankView:onExit()
	NightFeastBossRankView.super.onExit(self)
	self._rankTable:dispose()
end

function NightFeastBossRankView:_refreshView()
	local rankInfos = NightFeastBossModel.instance:getRankInfos(self._activityId)

	self._rankTable:reloadData(rankInfos)

	if #rankInfos > 0 then
		GameUtil.SetActive(self._emptyGo, false)
	else
		GameUtil.SetActive(self._emptyGo, true)
	end

	local myRank = NightFeastBossModel.instance:getMyRank(self._activityId)

	self._txtMyRank.text = (myRank > 100 or myRank <= 0) and lang("未上榜") or myRank
end

function NightFeastBossRankView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgChangeRank = goutil.findChildComponent(go, "imgRank", "UIImageSpriteChange")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtArea = goutil.findChildTextComponent(go, "txtArea")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local txtTime = goutil.findChildTextComponent(go, "txtTime")

	txtRank.text = data.rank

	GameUtil.SetActive(imgChangeRank, data.rank <= 3 and data.rank > 0)

	if data.rank <= 3 and data.rank > 0 then
		imgChangeRank:SetState(data.rank - 1)
		GameUtil.SetActive(imgChangeRank, true)
		GameUtil.SetActive(txtRank, false)
	else
		GameUtil.SetActive(imgChangeRank, false)
		GameUtil.SetActive(txtRank, true)
	end

	local proxy = HeadItemController.instance:setHeadCellByInfo(imgIcon, data.headInfo)

	if proxy then
		proxy:setCallBack(function()
			if data.headInfo.userId then
				self:onHeadClick(data.headInfo.userId, imgIcon)
			end
		end)
	end

	txtName.text = data.headInfo.userName
	txtArea.text = data.headInfo.areaName or ""
	txtScore.text = checknumber(data.value)

	local date = GameUtil.time2date(checknumber(data.time / 1000))

	txtTime.text = langPara("%s月%s日 %02d:%02d:%02d", date.month, date.day, date.hour, date.min, date.sec)
end

function NightFeastBossRankView:_clearCell(cell)
	local go = cell.gameObject

	HeadItemController.instance:resetHeadCell(go)
end

function NightFeastBossRankView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

return NightFeastBossRankView
