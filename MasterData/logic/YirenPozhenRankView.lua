-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yirenpozhen/view/YirenPozhenRankView.lua

module("logic.extensions.yirenpozhen.view.YirenPozhenRankView", package.seeall)

local YirenPozhenRankView = class("YirenPozhenRankView", TableViewComponent)

function YirenPozhenRankView:_getPath()
	return {
		cellPath = "right/cell",
		viewPath = "right/rankScrollRect"
	}
end

function YirenPozhenRankView:ctor()
	YirenPozhenRankView.super.ctor(self)
end

function YirenPozhenRankView:buildUI()
	YirenPozhenRankView.super.buildUI(self)

	self._btnClose2 = self:getBtn("btnClose2")
	self._closeButton = self:getBtn("btnClose")
	self._txtTitle = self:getTxt("title/txtTitle")
	self._goEmpty = self:getGo("right/goEmpty")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._txtSubTitle = self:getTxt("right/subTitle/txtTime")
end

function YirenPozhenRankView:bindEvents()
	YirenPozhenRankView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
end

function YirenPozhenRankView:unbindEvents()
	YirenPozhenRankView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function YirenPozhenRankView:destroyUI()
	YirenPozhenRankView.super.destroyUI(self)
end

function YirenPozhenRankView:onEnter()
	YirenPozhenRankView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.HexagramGameRank, self._onRankInfoRes, self)
	TheOutcastChallengeAgent.instance:sendPM_TheOutcastChallengeRankInfoReq()
end

function YirenPozhenRankView:onEnterFinished()
	YirenPozhenRankView.super.onEnterFinished(self)
end

function YirenPozhenRankView:onExit()
	YirenPozhenRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.HexagramGameRank, self._onRankInfoRes, self)
end

function YirenPozhenRankView:onExitFinished()
	YirenPozhenRankView.super.onExitFinished(self)
end

function YirenPozhenRankView:_onRankInfoRes(rankInfo, myRank)
	self._curViewDatas = rankInfo or {}
	myRank = checknumber(myRank)
	self._txtMyRank.text = myRank > 0 and myRank or lang("未上榜")

	self._goEmpty:SetActive(#self._curViewDatas == 0)
	self:reloadData()
end

function YirenPozhenRankView:_updateCell(view, cell, data)
	local txtStage = goutil.findChildTextComponent(cell.gameObject, "txtStage")
	local go = cell.gameObject
	local imgRank = goutil.findChildComponent(go, "imgRank", typeof(UIImageSpriteChange))
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtFamily = goutil.findChildTextComponent(go, "txtFamily")
	local txtDesc = goutil.findChildTextComponent(go, "txtTime")
	local btnHead = goutil.findChild(go, "btnHead")

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

	txtStage.text = data.stageId
end

function YirenPozhenRankView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

return YirenPozhenRankView
