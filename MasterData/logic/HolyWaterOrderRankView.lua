-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holywaterorder/view/HolyWaterOrderRankView.lua

module("logic.extensions.holywaterorder.view.HolyWaterOrderRankView", package.seeall)

local HolyWaterOrderRankView = class("HolyWaterOrderRankView", ViewComponent)

function HolyWaterOrderRankView:ctor()
	HolyWaterOrderRankView.super.ctor(self)
end

function HolyWaterOrderRankView:buildUI()
	HolyWaterOrderRankView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTab1 = self:getBtn("btnTab1")
	self._btnTab2 = self:getBtn("btnTab2")
	self._imgSelectedTab1 = self:getGo("btnTab1/imgSelected")
	self._imgSelectedTab2 = self:getGo("btnTab2/imgSelected")
	self._colorChange1 = self:getGo("btnTab1/txtName"):GetComponent(ComponentType.UITextColorChange)
	self._colorChange2 = self:getGo("btnTab2/txtName"):GetComponent(ComponentType.UITextColorChange)
	self._goEmpty = self:getGo("right/goEmpty")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._tableCell = self:getGo("right/tablecell")
	self._tableview = self:getGo("right/tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function HolyWaterOrderRankView:bindEvents()
	HolyWaterOrderRankView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTab1:AddClickListener(self._onClickTab1, self)
	self._btnTab2:AddClickListener(self._onClickTab2, self)
end

function HolyWaterOrderRankView:unbindEvents()
	HolyWaterOrderRankView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTab1:RemoveClickListener()
	self._btnTab2:RemoveClickListener()
end

function HolyWaterOrderRankView:onEnter()
	HolyWaterOrderRankView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.HolyWaterOrderDailyRankRes, self._onDailyRankRes, self)
	GlobalDispatcher:addListener(GlobalNotify.HolyWaterOrderActivityRankRes, self._onActivityRankRes, self)
	goutil.setActive(self._goEmpty, false)

	self._activityId = self:getFirstParam()
	self._isSendReqTab1 = false
	self._isSendReqTab2 = false

	self:_onClickTab1()
end

function HolyWaterOrderRankView:onExit()
	HolyWaterOrderRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.HolyWaterOrderDailyRankRes, self._onDailyRankRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.HolyWaterOrderActivityRankRes, self._onActivityRankRes, self)
	self._scrollList:dispose()
end

function HolyWaterOrderRankView:_onClickTab1()
	goutil.setActive(self._imgSelectedTab1, true)
	goutil.setActive(self._imgSelectedTab2, false)
	self._colorChange1:SetState(0)
	self._colorChange2:SetState(1)

	if not self._isSendReqTab1 then
		self._isSendReqTab1 = true

		HolyWaterOrderAgent.instance:sendPM_HolyWaterOrderDailyRankReq(self._activityId)
	else
		self:_updateDailyRank()
	end
end

function HolyWaterOrderRankView:_onClickTab2()
	goutil.setActive(self._imgSelectedTab1, false)
	goutil.setActive(self._imgSelectedTab2, true)
	self._colorChange1:SetState(1)
	self._colorChange2:SetState(0)

	if not self._isSendReqTab2 then
		self._isSendReqTab2 = true

		HolyWaterOrderAgent.instance:sendPM_HolyWaterOrderActivityRankReq(self._activityId)
	else
		self:_updateActivityRank()
	end
end

function HolyWaterOrderRankView:_onDailyRankRes()
	self:_updateDailyRank()
end

function HolyWaterOrderRankView:_onActivityRankRes()
	self:_updateActivityRank()
end

function HolyWaterOrderRankView:_updateDailyRank()
	local myRank = HolyWaterOrderModel.instance:getDailyMyRank()
	local list = HolyWaterOrderModel.instance:getDailyRanks()
	local count = #list

	self._txtMyRank.text = myRank == -1 and "未上榜" or myRank

	goutil.setActive(self._goEmpty, count == 0)
	printInfo("test 上榜人数 _updateDailyRank", #list)
	self._scrollList:reloadData(list)
end

function HolyWaterOrderRankView:_updateActivityRank()
	local myRank = HolyWaterOrderModel.instance:getActivityMyRank()
	local list = HolyWaterOrderModel.instance:getActivityRanks()
	local count = #list

	self._txtMyRank.text = myRank == -1 and "未上榜" or myRank

	goutil.setActive(self._goEmpty, count == 0)
	printInfo("test 上榜人数 _updateActivityRank", #list)
	self._scrollList:reloadData(list)
end

function HolyWaterOrderRankView:_updateCell(view, cell, data, tag)
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtArea = goutil.findChildTextComponent(cell, "txtArea")
	local txtStar = goutil.findChildTextComponent(cell, "txtStar")
	local txtTime = goutil.findChildTextComponent(cell, "txtTime")
	local imgRankChange = goutil.findChild(cell, "imgRank"):GetComponent(ComponentType.UIImageSpriteChange)
	local imgIcon = goutil.findChild(cell, "imgIcon")

	if data.rank > 0 and data.rank < 4 then
		goutil.setActive(imgRankChange.gameObject, true)
		goutil.setActive(txtRank.gameObject, false)
		imgRankChange:SetState(data.rank - 1)
	else
		goutil.setActive(imgRankChange.gameObject, false)
		goutil.setActive(txtRank.gameObject, true)

		txtRank.text = data.rank
	end

	txtName.text = data.headInfo.userName
	txtArea.text = data.headInfo.areaName
	txtStar.text = data.value

	local timestamp = math.floor(checknumber(data.time) / 1000)

	txtTime.text = os.date("%Y.%m.%d %H:%M:%S", timestamp)

	local proxy = HeadItemController.instance:setHeadCellByInfo(imgIcon, data.headInfo)

	if proxy then
		proxy:setCallBack(function()
			FriendController.instance:showInfoView(data.headInfo.userId, imgIcon)
		end)
	end
end

function HolyWaterOrderRankView:clearCell(cell)
	local imgIcon = goutil.findChild(cell, "imgIcon")

	HeadItemController.instance:resetHeadCell(imgIcon)
end

return HolyWaterOrderRankView
