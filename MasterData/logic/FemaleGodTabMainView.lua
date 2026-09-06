-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalegod/view/FemaleGodTabMainView.lua

module("logic.extensions.femalegod.view.FemaleGodTabMainView", package.seeall)

local FemaleGodTabMainView = class("FemaleGodTabMainView", TabFrameWorkMainView)

function FemaleGodTabMainView:buildUI()
	FemaleGodTabMainView.super.buildUI(self)

	self._btnExpand = self:getGo("btnExpand")
	self._btnExpandRredPoint = self:getGo("btnExpand/redPoint")
	self._txtTip = self:getTxt("bubble/txtTip")
end

function FemaleGodTabMainView:bindEvents()
	FemaleGodTabMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnExpand, self._onClickBtnExpand, self)
end

function FemaleGodTabMainView:unbindEvents()
	FemaleGodTabMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnExpand)
end

function FemaleGodTabMainView:onEnter()
	FemaleGodTabMainView.super.onEnter(self)

	self._baseData = TabFrameWorkConfig.instance:getFwBaseData(self._frameId)
	self._activityId = checknumber(self._baseData.exPlanParams)
	self._actCfg = FemaleGodConfig.instance:getActivityCfg(self._activityId)
	self._isFirstOpen = true

	local arr = string.split(self._actCfg.inflationMoneyMaterialKey, ":")

	self._expendMoneyMatType = arr[1]
	self._expendMoneyMatId = arr[2]

	RedPointController.instance:regRedPoint(self._btnExpandRredPoint, 676)
	FemaleGodController.instance:sendPM_InflationMoneyGetInfoReq(self._activityId)
end

function FemaleGodTabMainView:_getFrameId()
	return 8
end

function FemaleGodTabMainView:_onSetUI()
	FemaleGodTabMainView.super._onSetUI(self)

	self._txtTip.text = MaterialModel.instance:getMaterialsNumber(self._expendMoneyMatType, self._expendMoneyMatId)
end

function FemaleGodTabMainView:onExit()
	FemaleGodTabMainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._btnExpandRredPoint)
end

function FemaleGodTabMainView:_firstGetReward()
	local info = FemaleGodModel.instance:getInfo(self._activityId)

	if info and not info.hasGainOncePrize and self._isFirstOpen then
		self._isFirstOpen = false

		UIStateManager.instance:push(ViewName.FemaleGodFirstPopView, self._activityId)
	end
end

function FemaleGodTabMainView:_onClickBtnExpand()
	UIStateManager.instance:push(ViewName.FemaleGodClosetView, self._activityId)
end

function FemaleGodTabMainView:_updateHeadTabCell(mainGo, headTabIndex)
	local info = self:_getHeadTabViewInfo(headTabIndex)
	local isUnlock = info.isUnlock
	local data = info.data
	local changeGroup = mainGo:GetComponent(ComponentType.UIChangeGroup)
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local lock = goutil.findChild(mainGo, "lock")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local recTxtName = goutil.findChildTextComponent(mainGo, "rec/txt")

	if not goutil.isNil(redPoint) then
		GameUtil.SetActive(redPoint, false)
		RedPointController.instance:unregRedPoint(redPoint)

		if self:_isNeedRedByExCondAsHeadTab(headTabIndex) then
			GameUtil.SetActive(redPoint, true)
		elseif TabFrameWorkController.instance:isNeedRedAsHeadTab(self._frameId, data.headTabId) then
			GameUtil.SetActive(redPoint, true)
		elseif isUnlock and data.redIdArray then
			RedPointController.instance:regRedPoint(redPoint, unpack(data.redIdArray))
		end
	end

	if changeGroup then
		local isSelected = self._curHeadTabIndex == headTabIndex

		changeGroup:SetState(isSelected and 1 or 0)
	end

	GameUtil.SetActive(lock, not isUnlock)

	if txtName then
		txtName.text = data.tabName or ""
	end

	if recTxtName then
		recTxtName.text = data.exTabParams or ""
	end

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._clickHeadTabCell, self, headTabIndex))
end

function FemaleGodTabMainView:_onItemCountChange()
	self._txtTip.text = MaterialModel.instance:getMaterialsNumber(self._expendMoneyMatType, self._expendMoneyMatId)
end

return FemaleGodTabMainView
