-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivitySignInPage.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResRandClient = require("ClientData/ResRandClient")
local FlyIconUtils = require("UI/Common/FlyIconUtils")
local UserData = require("Helper/UserData")
local AwardPanel = Class("AwardPanel", UIControls.Panel)
local INDEX_POS = {
	{
		-278,
		-200
	},
	{
		-278,
		-200
	},
	{
		-278,
		-200
	},
	{
		-278,
		-430
	},
	{
		-278,
		-430
	},
	{
		-278,
		-430
	},
	{
		-82,
		-613
	}
}

function AwardPanel:ctor()
	self.txtTitle = UIControls.Label(self, self.mPath .. "/SignInAllAward/TextTitle")
	self.btnClose = UIControls.Button(self, self.mPath .. "/UIClickThrough")

	self.btnClose:addEventClick(self.onHide)

	self.awardPath = self.mPath .. "/SignInAllAward"
	self.showPanel = UIControls.Panel(self, self.awardPath)
	self.items = {}
end

function AwardPanel:onShow(data)
	self.txtTitle:setText(string.format(Lang.get(30116), data.param))

	for _, item in ipairs(self.items) do
		item:destroy()
	end

	local awardData = ResRandClient[data.award]

	for idx, id in ipairs(awardData.show_ids) do
		local fakeItem = BaseObject.GetObject(id, awardData.show_nums[idx])
		local grid = UIControls.getGridChild(fakeItem, self, self.awardPath)

		grid:setVisible(true)

		grid.mDisableWays = true

		grid:setObj(fakeItem)

		self.items[idx] = grid
	end

	self.showPanel:setPosition(INDEX_POS[data.param][1], INDEX_POS[data.param][2])
	self:setVisible(true)
end

function AwardPanel:onHide()
	self:setVisible(false)
end

local DayBtn = Class("DayBtn", UIControls.Button)
local ANIM_INFO = {
	{
		"BtnSignInNml",
		"BtnSignInHigh",
		"BtnSignInDis"
	},
	{
		"BtnSignInNml",
		"BtnSignInHigh",
		"BtnSignInDis"
	},
	{
		"BtnSignInNml",
		"BtnSignInHigh",
		"BtnSignInDis"
	},
	{
		"BtnSignInFiveSixNml",
		"BtnSignInFiveSixHigh",
		"BtnSignInFiveSixDis"
	},
	{
		"BtnSignInFiveSixNml",
		"BtnSignInFiveSixHigh",
		"BtnSignInFiveSixDis"
	},
	{
		"BtnSignInFiveSixNml",
		"BtnSignInFiveSixHigh",
		"BtnSignInFiveSixDis"
	},
	{
		"BtnSignInEndNml",
		"BtnSignInEndHigh",
		"BtnSignInEndDis"
	}
}

function DayBtn:ctor()
	self.btn = UIControls.Button(self, self.mPath)
	self.txtName = UIControls.Label(self, self.mPath .. "/TextName")
	self.txtDay = UIControls.Label(self, self.mPath .. "/TextDay")
	self.txtNum = UIControls.Label(self, self.mPath .. "/TextNun")
	self.imgGet = UIControls.Panel(self, self.mPath .. "/ImgComplete")
	self.itemBgPanel = UIControls.Panel(self, self.mPath .. "/BadgeItemPanel")
	self.imgIconBG = UIControls.Image(self, self.mPath .. "/BadgeItemPanel/Bg")
	self.imgIcon = UIControls.Image(self, self.mPath .. "/BadgeItemPanel/Icon")
	self.imgItemIcon = UIControls.Image(self, self.mPath .. "/Icon")
	self.imgComplete = UIControls.Image(self, self.mPath .. "/ImgComplete")
	self.imgAirplane = UIControls.Image(self, self.mPath .. "/ImgAirplane")

	self.btn:addEventClick(Slot(self.onClick, self))

	self.state = 0
	self.awardNum = 0
end

function DayBtn:setData(data, svrData, state)
	self.data = data
	self.state = state

	self:_setUI(data)
end

function DayBtn:setPlane(isVisible)
	self.imgAirplane:setVisible(isVisible)
end

function DayBtn:_setUI(data)
	local awardData = ResRandClient[data.award]
	local awardId = awardData.show_ids[1]
	local awardNum = awardData.show_nums[1]

	self.awardNum = awardNum

	local item = BaseObject.GetObject(awardId)
	local isArtifact = item:isArtifact()

	if item then
		local itemPath = item:getIconPath()

		self.data = data

		if isArtifact then
			local bgPath = item:getCareerBgIconPath()

			self.itemBgPanel:setVisible(true)
			self.imgItemIcon:setVisible(false)
			self.imgIconBG:setImage(bgPath[1], bgPath[2])
			self.imgIcon:setImage(itemPath[1], itemPath[2])
		else
			self.itemBgPanel:setVisible(false)
			self.imgItemIcon:setVisible(true)
			self.imgItemIcon:setImage(itemPath[1], itemPath[2])
		end

		self.txtNum:setText(ClientUtils.getNumShortStr(awardNum))
		self.txtName:setText(data.desc_name or "")
		self.txtDay:setText(data.param or "")
		self.imgAirplane:setVisible(false)
		self:_resetUI()
	end
end

function DayBtn:_resetUI()
	local data = self.data

	if self.state == 3 then
		self:playStateAnimator(ANIM_INFO[data.param][1])
	elseif self.state == 2 then
		self.imgItemIcon:setImageGray(false)
		self:playStateAnimator(ANIM_INFO[data.param][2])
	else
		self.imgItemIcon:setImageGray(true)
		self:playStateAnimator(ANIM_INFO[data.param][3])
	end
end

function DayBtn:flyCircleGold()
	FlyIconUtils.sendFlyEvent(self.imgItemIcon, Const.MONEY_ID_DIAMOND, self.awardNum)
end

function DayBtn:onClick()
	if self.mEventClick then
		self:mEventClick()
	end
end

local calssNameStr = "ActivitySignInPage"
local ActivitySignInPage = Class(calssNameStr, UIControls.Child)

MixinClass(ActivitySignInPage, ActivityPanelMixin)

function ActivitySignInPage:initUI()
	self.btns = {}
	self.curSelectBtn = nil
	self.awardPanel = AwardPanel(self, "SignInAllAwardPanel")
	self.textTime = UIControls.Label(self, "BgTime/TxtTime")
	self.bgTitle2 = UIControls.Image(self, "BgTitle/BgTitle2")
	self.textTitle2 = UIControls.Label(self, "BgTitle/TextTitle2")

	self.bgTitle2:setVisible(not RegionUtils.isSEA())
	self.textTitle2:setVisible(not RegionUtils.isSEA())
	self.awardPanel:onHide()
end

function ActivitySignInPage:_setData(pageData)
	self:_refreshData()
end

function ActivitySignInPage:_refreshData()
	self.detailData = self.actObj.actData.clientData[1]
	self.svrData = self.actObj.actData.serverData and self.actObj.actData.serverData[1] or {
		progress = 0
	}
	self.totalDay = #self.detailData
	self.btnBuyHandler = nil

	self:_setItems()
end

function ActivitySignInPage:_setItems()
	local actData = self.actObj.actData

	if self.totalDay > 0 then
		for i = 1, self.totalDay do
			if not self.btns[i] then
				self.btns[i] = DayBtn(self, "BtnSignIn" .. i)
				self.btns[i].mEventClick = Slot(self.onCellClick, self)
			end

			local btnState = actData:getAchieveState(1, i)

			self.btns[i]:setData(self.detailData[i], self.svrData, btnState)

			if btnState ~= 3 then
				self.toDayBtn = self.btns[i]
			end
		end

		if self.toDayBtn then
			self.toDayBtn:setPlane(true)
		end
	end
end

function ActivitySignInPage:_onShow()
	for _, btn in ipairs(self.btns) do
		btn:_resetUI()
	end
end

function ActivitySignInPage:onCellClick(sender)
	if sender.state ~= 2 then
		self.awardPanel:onShow(sender.data)
	else
		CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.actObj.opId, sender.data.param, 1), self.actObj.opId)

		self.btnBuyHandler = sender

		self:showStar(sender.data.param)
	end
end

function ActivitySignInPage:showStar(param)
	if tonumber(param) == 5 or tonumber(param) == 7 then
		CurAvatar:tryOpenGameEvaluateDlg("ActivitySignInPage" .. param)
	end
end

function ActivitySignInPage:onActivityDataRefresh(actObj)
	if self.btnBuyHandler then
		self.btnBuyHandler:flyCircleGold()
	end

	self.actObj = actObj

	self:_refreshData()
end

return ActivitySignInPage
