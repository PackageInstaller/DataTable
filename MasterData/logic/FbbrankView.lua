-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fbbchallenge/view/FbbrankView.lua

module("logic.extensions.fbbchallenge.view.FbbrankView", package.seeall)

local FbbrankView = class("FbbrankView", TableViewComponent)

function FbbrankView:_getPath()
	return {
		cellPath = "right/rankCell",
		viewPath = "right/rankListView"
	}
end

function FbbrankView:unbindEvents()
	FbbrankView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function FbbrankView:bindEvents()
	FbbrankView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
end

function FbbrankView:onExit()
	FbbrankView.super.onExit(self)
	GlobalDispatcher:removeListener(TimedChallengeAgent.PM_TimedChallengeGetPetRankRes, self._onPetRankRes, self)
end

function FbbrankView:buildUI()
	FbbrankView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._goEmpty = self:getGo("right/goEmpty")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._txtTip = self:getTxt("right/myRank/txtTip")
	self._txtTip.text = FbbchallengeConfig.instance:getDefineValue("RANK_TIP")
end

function FbbrankView:onEnter()
	FbbrankView.super.onEnter(self)
	GlobalDispatcher:addListener(TimedChallengeAgent.PM_TimedChallengeGetPetRankRes, self._onPetRankRes, self)

	local challengeId = FbbchallengeConfig.instance:getDefineValue("CHALLENGE_ID", true)

	TimedChallengeAgent.instance:sendPM_TimedChallengeGetPetRankReq(challengeId)
end

function FbbrankView:_onPetRankRes(status, msg)
	if status == 0 then
		self._curViewDatas = msg.infoList or {}

		local myRank = checknumber(msg.myRank)

		self._txtMyRank.text = myRank > 0 and myRank or lang("未上榜")

		self._goEmpty:SetActive(#self._curViewDatas == 0)
		self:reloadData()
	end
end

function FbbrankView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local imgRank = goutil.findChildComponent(go, "imgRank", typeof(UIImageSpriteChange))
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "imgIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtFamily = goutil.findChildTextComponent(go, "txtFamily")
	local txtDesc = goutil.findChildTextComponent(go, "txtPassTime")
	local btnHead = goutil.findChild(go, "btnIcon")

	txtName.text = data.headInfo.userName

	HeadItemController.instance:setHeadCellByInfo(imgIcon, data.headInfo)

	txtRank.text = data.rank
	txtFamily.text = not string.nilorempty(data.familyName) and data.familyName or lang("无")

	local rank = checknumber(data.rank)
	local isTop3 = rank <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end

	if data.headInfo.userId then
		GameUtil.addClickHandler(btnHead, GameUtil.handler(self.onHeadClick, self, data.headInfo.userId, btnHead))
	end

	local time = GameUtil.time2date(checknumber(data.gainTime) / 1000)

	txtDesc.text = langPara("%d月%d日 %02d:%02d:%02d", time.month, time.day, time.hour, time.min, time.sec)
end

function FbbrankView:_clearTableview(cell)
	local imgIcon = goutil.findChild(cell.gameObject, "imgIcon")

	MaterialMgr.resetAll(imgIcon)
end

function FbbrankView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

return FbbrankView
