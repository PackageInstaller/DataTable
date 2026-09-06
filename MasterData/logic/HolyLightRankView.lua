-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holylight/view/HolyLightRankView.lua

module("logic.extensions.holylight.view.HolyLightRankView", package.seeall)

local HolyLightRankView = class("HolyLightRankView", ViewComponent)

function HolyLightRankView:ctor()
	HolyLightRankView.super.ctor(self)
end

function HolyLightRankView:buildUI()
	HolyLightRankView.super.buildUI(self)

	self._closeBtn = goutil.findChild(self.mainGO, "closeBtn")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyRank")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	self._rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")
	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
end

function HolyLightRankView:bindEvents()
	HolyLightRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._closeBtn, self.close, self)
end

function HolyLightRankView:unbindEvents()
	HolyLightRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._closeBtn)
end

function HolyLightRankView:destroyUI()
	HolyLightRankView.super.destroyUI(self)
end

function HolyLightRankView:onEnter()
	HolyLightRankView.super.onEnter(self)

	self._activityId = HolyLightController.instance:getActivityId()

	if self._activityId <= 0 then
		TipsFacade.instance:openTipWindowNoX("提示", "不在活动范围内", function()
			self:close()
		end, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.HolyLightGetRankRes, self._onUpdate, self)
	HolyLightController.instance:sendPM_HolyLightGetRankReq(self._activityId)
end

function HolyLightRankView:onExit()
	HolyLightRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.HolyLightGetRankRes, self._onUpdate, self)
	self:_onClearRankCol()
end

function HolyLightRankView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function HolyLightRankView:_onUpdateData()
	self._rankMsg = HolyLightModel.instance:getRankMsg()
end

function HolyLightRankView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateRankColUI()
end

function HolyLightRankView:_onUpdatePlaneUI()
	local myRank = self._rankMsg.myRank

	self._txtMyRank.text = myRank > 0 and myRank or "未上榜"
end

function HolyLightRankView:_onUpdateRankColUI()
	local infoList = self._rankMsg.rankList

	self._rankScrollList:reloadData(infoList)

	local idx = 0
	local isMotion = true

	self._rankScrollList:MoveCellInView(idx, isMotion)
	GameUtil.SetActive(self._emptyGo, #infoList <= 0)
end

function HolyLightRankView:_onClearRankCol()
	self._rankScrollList:dispose()
end

function HolyLightRankView:_updateRankCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local imgIcon = goutil.findChild(mainGo, "imgIcon")
	local btnIcon = goutil.findChild(mainGo, "btnIcon")
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtLevel = goutil.findChildTextComponent(mainGo, "txtLevel")
	local txtTime = goutil.findChildTextComponent(mainGo, "txtTime")
	local txtArea = goutil.findChildTextComponent(mainGo, "txtArea")
	local txtProgress = goutil.findChildTextComponent(mainGo, "txtProgress")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)

	txtRank.text = info.rank

	local isTop3 = checknumber(info.rank) <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(info.rank - 1)
	end

	txtName.text = info.headInfo.userName
	txtArea.text = info.areaName
	txtProgress.text = info.value

	local date = GameUtil.time2date(info.timeStamp / 1000)

	txtTime.text = string.format("%02d.%02d %02d:%02d", date.month, date.day, date.hour, date.min)

	HeadItemController.instance:setHeadCellByInfo(imgIcon, info.headInfo)

	local function callBack()
		FriendController.instance:showInfoView(info.headInfo.userId, imgIcon)
	end

	GameUtil.addClickHandler(btnIcon, callBack)
end

function HolyLightRankView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local imgIcon = goutil.findChild(mainGo, "imgIcon")
	local btnIcon = goutil.findChild(mainGo, "btnIcon")

	HeadItemController.instance:resetHeadCell(imgIcon)
	GameUtil.rmClickHandler(btnIcon)
end

return HolyLightRankView
