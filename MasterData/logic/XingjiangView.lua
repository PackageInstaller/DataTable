-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/view/XingjiangView.lua

module("logic.extensions.xingjiang.view.XingjiangView", package.seeall)

local XingjiangView = class("XingjiangView", ViewComponent)
local PageIndex

function XingjiangView:ctor()
	XingjiangView.super.ctor(self)
end

function XingjiangView:unbindEvents()
	XingjiangView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnTry:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnPetVerify:RemoveClickListener()
end

function XingjiangView:bindEvents()
	XingjiangView.super.bindEvents(self)
	self._closeButton:AddClickListener(function()
		PageIndex = nil

		self:close()
	end, self)
	self._btnTry:AddClickListener(function()
		FuncOpenController.instance:openFunc(149, XingJiangModel.instance.curPetId)
	end, self)
	self._btnTip:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "starCrimson_rule")
	end, self)
	self._btnPetVerify:AddClickListener(function()
		PetAwakenVerificationController.instance:gotoPetAwakenByKey("xingjiangview")
	end, self)
end

function XingjiangView:buildUI()
	XingjiangView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._btnTry = self:getBtn("btnTry")
	self._btnTip = self:getBtn("btnTip")
	self._container = self:getGo("container")
	self._openDate = self:getTxt("time/txt")
	self._btnPetVerify = self:getBtn("btnPetVerify")
	self._petVerifyRed = self:getGo("btnPetVerify/redPoint")
	self._goldBarCon = self:getGo("goldBarCon")
	self._tabs = {}

	for i = 1, 4 do
		local tab = {}
		local name = "btnTab" .. i
		local go = self:getGo(name)

		tab.btn = self:getBtn(name)

		tab.btn:AddClickListener(function()
			self:_onClickTab(i)
		end)

		tab.selected = goutil.findChild(go, "selected")
		tab.redPoint = goutil.findChild(go, "imgPoint")

		table.insert(self._tabs, tab)
	end
end

function XingjiangView:onExit()
	XingjiangView.super.onExit(self)
	PetAwakenVerificationController.instance:unRegRedAboutPetAwken(self._petVerifyRed)
end

function XingjiangView:onEnter()
	XingjiangView.super.onEnter(self)

	local curPage = self:getFirstParam()

	curPage = curPage and curPage or PageIndex or 1

	self:_onClickTab(curPage)

	self._openDate.text = TimeGateController.instance:getActTimeShow(XingJiangModel.instance.curActId)

	local objList = {
		{
			showAdd = true,
			id = GameEnum.GoldType.GodDiamondCoin
		},
		{
			id = "4:136",
			showAdd = true
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
	PetAwakenVerificationController.instance:regRedAboutPetAwken(self._petVerifyRed, "xingjiangview")
end

function XingjiangView:_onClickTab(index)
	if index == 1 then
		self:showTabAt(self._container, ViewName.XjlotteryView)
	elseif index == 2 then
		self:showTabAt(self._container, ViewName.XjchallengeView)
		GameUtil.saveUserDayData("ID_XINGJIANGPK", "1")
	elseif index == 3 then
		self:showTabAt(self._container, ViewName.XjtaskView)
	elseif index == 4 then
		self:showTabAt(self._container, ViewName.XjshopView)
	end

	for i = 1, 4 do
		self._tabs[i].selected:SetActive(i == index)
	end

	local isClickDay = GameUtil.getUserDayData("ID_XINGJIANGPK") == nil

	self._tabs[2].redPoint:SetActive(isClickDay)

	PageIndex = index
end

return XingjiangView
