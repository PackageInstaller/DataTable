-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godgemconsume/view/GodgemconsumerankView.lua

module("logic.extensions.godgemconsume.view.GodgemconsumerankView", package.seeall)

local GodgemconsumerankView = class("GodgemconsumerankView", TableViewComponent)

function GodgemconsumerankView:ctor()
	GodgemconsumerankView.super.ctor(self)
end

function GodgemconsumerankView:unbindEvents()
	GodgemconsumerankView.super.unbindEvents(self)
	self._Close:RemoveClickListener()
end

function GodgemconsumerankView:bindEvents()
	GodgemconsumerankView.super.bindEvents(self)
	self._Close:AddClickListener(self._onClickClose, self)
end

function GodgemconsumerankView:buildUI()
	GodgemconsumerankView.super.buildUI(self)

	self._Close = self:getBtn("Close")
	self._goEmpty = self:getGo("right/goEmpty")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._txtRankTip = goutil.findChildTextComponent(self.mainGO, "right/myRank/txtTip")
end

function GodgemconsumerankView:onExit()
	GodgemconsumerankView.super.onExit(self)
	GlobalDispatcher:removeListener(GodGemAccConsumeAgent.PM_GGACGetRankInfoRes, self._PM_GGACGetRankInfoRes, self)
end

function GodgemconsumerankView:onEnter()
	GodgemconsumerankView.super.onEnter(self)
	GlobalDispatcher:addListener(GodGemAccConsumeAgent.PM_GGACGetRankInfoRes, self._PM_GGACGetRankInfoRes, self)

	self._activityId = GodgemconsumeModel.instance:getCurrActivityId()

	GodGemAccConsumeAgent.instance:sendPM_GGACGetRankInfoReq(self._activityId)
	self:_updateView()
end

function GodgemconsumerankView:_onClickClose()
	self:close()
end

function GodgemconsumerankView:_updateView()
	self:_setMyRank()

	self._curViewDatas = GodgemconsumeModel.instance:getRankInfos()

	self:reloadData()
	goutil.setActive(self._goEmpty, not self._curViewDatas or #self._curViewDatas <= 0)

	self._txtRankTip.text = GodgemconsumeConfig.instance:getCommonValue("RANK_DESC")
end

function GodgemconsumerankView:_setMyRank()
	local myRank = GodgemconsumeModel.instance:getMyRank()

	self._txtMyRank.text = myRank > 0 and myRank or lang("未上榜")
end

function GodgemconsumerankView:_PM_GGACGetRankInfoRes(status)
	if status == 0 then
		self:_updateView()
	end
end

function GodgemconsumerankView:_getPath()
	return {
		cellPath = "right/rankCell",
		viewPath = "right/rankListView"
	}
end

function GodgemconsumerankView:_updateCell(view, cell, data)
	local imgIcon = goutil.findChild(cell, "imgIcon")
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtServer = goutil.findChildTextComponent(cell, "txtServer")
	local txtPassTime = goutil.findChildTextComponent(cell, "txtPassTime")
	local imgChangeImgRank = goutil.findChild(cell, "imgRank"):GetComponent(ComponentType.UIImageSpriteChange)
	local proxy = HeadItemController.instance:setHeadCellByInfo(imgIcon, data.headInfo)

	if proxy then
		proxy:setCallBack(function()
			if data.headInfo.userId then
				self:onHeadClick(data.headInfo.userId, imgIcon)
			end
		end)
	end

	local rank = data.rank
	local isTop3 = rank > 0 and rank <= 3

	goutil.setActive(imgChangeImgRank.gameObject, isTop3)

	if isTop3 then
		txtRank.text = ""

		imgChangeImgRank:SetState(data.rank - 1)
	else
		txtRank.text = data.rank
	end

	txtName.text = data.headInfo.userName
	txtServer.text = data.areaName
	txtPassTime.text = self:_formatTimeStr(data.time)
end

function GodgemconsumerankView:_clearTableview(cell)
	local imgIcon = goutil.findChild(cell, "imgIcon")

	HeadItemController.instance:resetHeadCell(imgIcon)
end

function GodgemconsumerankView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

function GodgemconsumerankView:_formatTimeStr(time)
	local date = GameUtil.time2date(math.floor(time / 1000))

	return string.format("%s月%s日 %s:%s:%s", date.month, date.day, date.hour, date.min, date.sec)
end

return GodgemconsumerankView
