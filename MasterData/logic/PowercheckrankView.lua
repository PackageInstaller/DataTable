-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/PowercheckrankView.lua

module("logic.extensions.handbook.view.PowercheckrankView", package.seeall)

local PowercheckrankView = class("PowercheckrankView", TableViewComponent)

function PowercheckrankView:_getPath()
	return {
		cellPath = "right/cell",
		viewPath = "right/rankScrollRect"
	}
end

function PowercheckrankView:unbindEvents()
	PowercheckrankView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function PowercheckrankView:bindEvents()
	PowercheckrankView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
end

function PowercheckrankView:onExit()
	PowercheckrankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.HandBookPowerCheckRank, self.onRefreshUI, self)
end

function PowercheckrankView:buildUI()
	PowercheckrankView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._txtTitle = self:getTxt("title/txtTitle")
	self._goEmpty = self:getGo("right/goEmpty")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._txtTip = self:getTxt("right/myRank/txtTip")
	self._txtSubTitle = self:getTxt("right/subTitle/txtFamily")
	self._tabs = {}

	local tabs = self:getGo("tabGroup")

	for i = 1, 2 do
		local tab = {}
		local go = goutil.findChild(tabs, "tab_" .. i)

		tab.uiChange = go:GetComponent("UIChangeGroup")
		tab.btn = Framework.ButtonAdapter.Get(go)

		tab.btn:AddClickListener(function()
			self:_onClickTab(i)
		end)
		table.insert(self._tabs, tab)
	end
end

function PowercheckrankView:onEnter()
	PowercheckrankView.super.onEnter(self)

	self._raceId = checknumber(self:getFirstParam())

	if self._raceId == 0 then
		return
	end

	local na = MaterialMgr.getMaterialsName(MatType.Pet, self._raceId)

	self._txtTitle.text = langPara("powercheckrankview__title", na)

	GlobalDispatcher:addListener(GlobalNotify.HandBookPowerCheckRank, self.onRefreshUI, self)
	self:_onClickTab(1)
	self:onRefreshUI()
end

function PowercheckrankView:onRefreshUI()
	self._curViewDatas = PowerCheckModel.instance.rankList or {}

	local myRank = checknumber(PowerCheckModel.instance.myRank)

	self._txtMyRank.text = myRank > 0 and myRank or lang("world_Boss_tip9")

	self._goEmpty:SetActive(#self._curViewDatas == 0)
	self:reloadData()
end

function PowercheckrankView:_updateCell(view, cell, data)
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
	txtFamily.text = not string.nilorempty(data.param) and data.param or lang("text_nofamily")
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

function PowercheckrankView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

function PowercheckrankView:_onClickTab(index)
	for i = 1, 2 do
		self._tabs[i].uiChange:SetState(i == index and 1 or 0)
	end

	self._txtTip.text = index == 1 and lang("powercheckrankview__rankall_tips") or lang("powercheckrankview__rank_tips")
	self._txtSubTitle.text = index == 1 and lang("aceteamrankview__3") or lang("channel_league_shortcut")

	PowerCheckController.instance:sendGetRaceZdlRankReq(self._raceId, index)
end

return PowercheckrankView
