-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/view/StrongFmtrankView.lua

module("logic.extensions.handbook.view.StrongFmtrankView", package.seeall)

local StrongFmtrankView = class("StrongFmtrankView", TableViewComponent)

function StrongFmtrankView:_getPath()
	return {
		cellPath = "right/cell",
		viewPath = "right/rankScrollRect"
	}
end

function StrongFmtrankView:unbindEvents()
	StrongFmtrankView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function StrongFmtrankView:bindEvents()
	StrongFmtrankView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
end

function StrongFmtrankView:onExit()
	StrongFmtrankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.RecommendFormGetRank, self.onRefreshUI, self)
end

function StrongFmtrankView:buildUI()
	StrongFmtrankView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._txtTitle = self:getTxt("title/txtTitle")
	self._goEmpty = self:getGo("right/goEmpty")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._txtTip = self:getTxt("right/myRank/txtTip")
	self._txtSubTitle = self:getTxt("right/subTitle/txtTime")
end

function StrongFmtrankView:onEnter()
	StrongFmtrankView.super.onEnter(self)

	self._txtTitle.text = lang("strongfmtrankview__1")
	self._txtTip.text = lang("strongfmtrankview__2")

	GlobalDispatcher:addListener(GlobalNotify.RecommendFormGetRank, self.onRefreshUI, self)
	RecommendFmtController.instance:sendGetRank()
	self:onRefreshUI()
end

function StrongFmtrankView:onRefreshUI()
	self._curViewDatas = RecommendFmtModel.instance.rankInfoList or {}

	local myRank = checknumber(RecommendFmtModel.instance.myRank)

	self._txtMyRank.text = myRank > 0 and myRank or lang("world_Boss_tip9")

	self._goEmpty:SetActive(#self._curViewDatas == 0)
	self:reloadData()
end

function StrongFmtrankView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local imgRank = goutil.findChildComponent(go, "imgRank", typeof(UIImageSpriteChange))
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtFamily = goutil.findChildTextComponent(go, "txtFamily")
	local txtDesc = goutil.findChildTextComponent(go, "txtTime")
	local txtZdl = goutil.findChildTextComponent(go, "txtZdl")
	local btnHead = goutil.findChild(go, "btnHead")

	txtName.text = data.headInfo.userName

	HeadItemController.instance:setHeadCellByInfo(imgIcon, data.headInfo)

	txtRank.text = data.rank
	txtFamily.text = not string.nilorempty(data.familyName) and data.familyName or lang("text_nofamily")
	txtZdl.text = data.zdl

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

	local time = GameUtil.time2date(checknumber(data.time) / 1000)

	txtDesc.text = langPara("text_timeinfo", time.month, time.day, time.hour, time.min, time.sec)
end

function StrongFmtrankView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

return StrongFmtrankView
