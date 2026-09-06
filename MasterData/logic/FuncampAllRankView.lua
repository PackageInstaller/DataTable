-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/FuncampAllRankView.lua

module("logic.extensions.funcamp.view.FuncampAllRankView", package.seeall)

local FuncampAllRankView = class("FuncampAllRankView", ViewComponent)

function FuncampAllRankView:ctor()
	FuncampAllRankView.super.ctor(self)

	self._choiceTab = 1
end

function FuncampAllRankView:unbindEvents()
	FuncampAllRankView.super.unbindEvents(self)
	self._btnRule:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function FuncampAllRankView:bindEvents()
	FuncampAllRankView.super.bindEvents(self)
	self._btnClose:AddClickListener(function()
		self:close()
	end)
	self._btnRule:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "funcampallrankview")
	end)
end

function FuncampAllRankView:onExit()
	FuncampAllRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FunCampRankTop5Res, self.refreshRankInfo, self)
end

function FuncampAllRankView:buildUI()
	FuncampAllRankView.super.buildUI(self)

	self._tabCell = self:getGo("pagecell")
	self._tabList = self:getGo("pagescrollview")
	self._rankCell = self:getGo("container/cell")
	self._rankList = self:getGo("container/tableview")
	self._goldBarCon = self:getGo("goldBarCon")
	self._myRankGo = self:getGo("container/myRank")
	self._effectGo = self:getGo("effect")
	self._empty = self:getGo("container/empty")
	self._btnRule = self:getBtn("btnRule")
	self._btnClose = self:getBtn("btnClose")
	self._txtTitle = self:getTxt("txtTitle")
	self._myRankTxt = self:getTxt("container/myRank/txtMyRank")
	self._tabScroll = ScrollerList.create(self._tabList, self._tabCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._RankScroll = ScrollerList.create(self._rankList, self._rankCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
end

function FuncampAllRankView:onEnter()
	FuncampAllRankView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.FunCampRankTop5Res, self.refreshRankInfo, self)

	self._tabCfg = CampGameConfig.instance:getBattleGroup()

	self._tabScroll:reloadData(self._tabCfg)

	self.curActId = CampGameConfig.instance:getOpenActivityId()

	if self.curActId < 0 then
		self:colse()

		return
	end

	self:_onClickTab(self._choiceTab)
	self._empty:SetActive(false)
end

function FuncampAllRankView:_updateTabCell(view, cell, data)
	local imgBg = goutil.findChildComponent(cell, "imgBg", "UIChangeGroup")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local click = goutil.findChild(cell, "click")

	if data.campId == self._choiceTab then
		imgBg:SetState(1)
	else
		imgBg:SetState(0)
	end

	GameUtil.asBtn(click):RemoveClickListener()
	GameUtil.asBtn(click):AddClickListener(function()
		self:_onClickTab(data.campId)
	end, self)

	txtName.text = data.name
end

function FuncampAllRankView:_clearTabCell(cell)
	return
end

function FuncampAllRankView:_updateRankCell(view, cell, data)
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtArea = goutil.findChildTextComponent(cell, "txtArea")
	local txtFName = goutil.findChildTextComponent(cell, "txtFName")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local headGo = goutil.findChild(cell, "head")
	local imgRank = goutil.findChildComponent(cell, "imgRank", "UIImageSpriteChange")
	local topThree = data.rank <= 3

	if data.headInfo then
		local proxy = HeadItemController.instance:setHeadCellByInfo(headGo, data.headInfo)

		if proxy then
			proxy:setCallBack(function()
				if data.headInfo.userId then
					self:onHeadClick(data.headInfo.userId, headGo)
				end
			end)
		end
	end

	txtRank.text = data.rank
	txtArea.text = data.areaName
	txtFName.text = data.familyName == "" and "未加入家族" or data.familyName
	txtScore.text = data.personScore
	txtName.text = data.headInfo.userName

	goutil.setActive(imgRank.gameObject, data.rank <= 3)

	if topThree then
		imgRank:SetState(data.rank - 1)
	end
end

function FuncampAllRankView:_clearRankCell(cell)
	return
end

function FuncampAllRankView:refreshRankInfo()
	local info, myRank = FunCampModel.instance:getRankData()

	self._myRankTxt.text = checknumber(myRank) <= 0 and "未上榜" or myRank

	self._RankScroll:reloadData(info)
	self._empty:SetActive(#info == 0)
end

function FuncampAllRankView:_onClickTab(campId)
	self._choiceTab = campId

	self._tabScroll:refresh(self._tabCfg)
	FunCampController.instance:sendPM_CB_GetRankInfoReq(self.curActId, campId)
end

function FuncampAllRankView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

return FuncampAllRankView
