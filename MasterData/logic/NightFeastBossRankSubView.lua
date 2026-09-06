-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nightfeastbosschallenge/view/NightFeastBossRankSubView.lua

module("logic.extensions.nightfeastbosschallenge.view.NightFeastBossRankSubView", package.seeall)

local NightFeastBossRankSubView = class("NightFeastBossRankSubView", ViewComponent)

function NightFeastBossRankSubView:ctor()
	NightFeastBossRankSubView.super.ctor(self)
end

function NightFeastBossRankSubView:unbindEvents()
	NightFeastBossRankSubView.super.unbindEvents(self)
end

function NightFeastBossRankSubView:bindEvents()
	NightFeastBossRankSubView.super.bindEvents(self)
end

function NightFeastBossRankSubView:buildUI()
	NightFeastBossRankSubView.super.buildUI(self)

	self._ranktableGo = goutil.findChild(self.mainGO, "rankScrollRect")
	self._ranktableCell = goutil.findChild(self.mainGO, "cell")
	self._rankTableList = ScrollerList.create(self._ranktableGo, self._ranktableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._emptyGo = goutil.findChild(self.mainGO, "goEmpty")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "myRank/txtMyRank")
	self._txtMyScore = self:getTxt("myRank/txtMyScore")
end

function NightFeastBossRankSubView:onExit()
	NightFeastBossRankSubView.super.onExit(self)
end

function NightFeastBossRankSubView:onEnter()
	NightFeastBossRankSubView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.NightFeastBossClgGetRankRes, self._handleGetInfo, self)

	self._itemScrollListDic = {}

	local params = self:getOpenParam()

	self._activityId = 510001
	self._bossId = 1
	self._rankPlanId = 1

	if params then
		self._activityId = checknumber(params[1])
		self._bossId = checknumber(params[2])
	end

	NightFeastBossChallengeAgent.instance:sendPM_NightFeastBossClgGetRankReq(self._activityId, self._bossId)
	self:_handleGetInfo()
end

function NightFeastBossRankSubView:_handleGetInfo()
	local myRank = -1
	local myScore = 0
	local rankInfos = {}
	local info = NightFeastBossModel.instance:getRankInfo(self._activityId, self._bossId)

	if info then
		rankInfos = info.rankInfos or {}
		myRank = info.myRank or -1
		myScore = checknumber(info.myMaxDamage)
	end

	self._rankTableList:reloadData(rankInfos)

	if #rankInfos > 0 then
		GameUtil.SetActive(self._emptyGo, false)
	else
		GameUtil.SetActive(self._emptyGo, true)
	end

	self._txtMyRank.text = checknumber(myRank) > 0 and myRank or lang("未上榜")
	self._txtMyScore.text = string.format("我的单次最高伤害：%s", self:_numberToString(myScore))
end

function NightFeastBossRankSubView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgChangeRank = goutil.findChildComponent(go, "imgRank", "UIImageSpriteChange")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtValue = goutil.findChildTextComponent(go, "txtValue")
	local txtDate = goutil.findChildTextComponent(go, "txtDate")
	local txtArea = goutil.findChildTextComponent(go, "txtArea")
	local rankInfo = data
	local time = rankInfo.time

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

	txtName.text = rankInfo.headInfo.userName
	txtValue.text = self:_numberToString(checknumber(rankInfo.value))

	local date = GameUtil.time2date(time / 1000)

	txtDate.text = string.format("%02d.%02d.%02d\n%02d:%02d:%02d", date.year, date.month, date.day, date.hour, date.min, date.sec)
	txtArea.text = rankInfo.headInfo.areaName or ""
end

function NightFeastBossRankSubView:_clearCell(cell)
	local go = cell.gameObject
	local imgIcon = goutil.findChild(go, "imgHeadIcon")

	HeadItemController.instance:resetHeadCell(imgIcon)
end

function NightFeastBossRankSubView:_numberToString(num)
	return num >= 100000000 and string.format("%.2f亿", num / 100000000) or num >= 10000 and string.format("%.2f万", num / 10000) or tostring(num)
end

return NightFeastBossRankSubView
