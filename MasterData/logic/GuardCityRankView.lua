-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/view/GuardCityRankView.lua

module("logic.extensions.guardcity.view.GuardCityRankView", package.seeall)

local GuardCityRankView = class("GuardCityRankView", ViewComponent)

function GuardCityRankView:ctor()
	GuardCityRankView.super.ctor(self)
end

function GuardCityRankView:buildUI()
	GuardCityRankView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._ranktableGo = self:getGo("rankCol/rankScrollerview")
	self._ranktableCell = self:getGo("rankCol/rankScrollercell")
	self._emptyGo = self:getGo("rankCol/emptyGo")
	self._txtMyRank = self:getTxt("myRank/txtMyRank")
end

function GuardCityRankView:bindEvents()
	GuardCityRankView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function GuardCityRankView:unbindEvents()
	GuardCityRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function GuardCityRankView:onEnter()
	GuardCityRankView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	GlobalDispatcher:addListener(GlobalNotify.PM_GuardCityViewRankRes, self._refreshView, self)

	self._rankTable = ScrollerList.create(self._ranktableGo, self._ranktableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	GuardCityAgent.instance:sendPM_GuardCityViewRankReq(self._activityId)
end

function GuardCityRankView:onExit()
	GuardCityRankView.super.onExit(self)
	self._rankTable:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.PM_GuardCityViewRankRes, self._refreshView, self)
end

function GuardCityRankView:_refreshView()
	local list = GuardCiytModel.instance:getRankInfos()

	self._rankTable:reloadData(list)

	if #list > 0 then
		GameUtil.SetActive(self._emptyGo, false)
	else
		GameUtil.SetActive(self._emptyGo, true)
	end

	self._txtMyRank.text = (GuardCiytModel.instance:getMyRank() > 100 or GuardCiytModel.instance:getMyRank() <= 0) and lang("未上榜") or GuardCiytModel.instance:getMyRank()
end

function GuardCityRankView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgChangeRank = goutil.findChildComponent(go, "imgRank", "UIImageSpriteChange")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "imgIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
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
	txtScore.text = data.score

	local date = GameUtil.time2date(checknumber(data.time / 1000))

	txtTime.text = langPara("%s月%s日 %02d:%02d:%02d", date.month, date.day, date.hour, date.min, date.sec)
end

function GuardCityRankView:_clearCell(cell)
	local go = cell.gameObject

	HeadItemController.instance:resetHeadCell(go)
end

function GuardCityRankView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

return GuardCityRankView
