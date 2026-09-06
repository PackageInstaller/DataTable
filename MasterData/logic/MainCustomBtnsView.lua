-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/MainCustomBtnsView.lua

module("logic.extensions.mainui.view.MainCustomBtnsView", package.seeall)

local MainCustomBtnsView = class("MainCustomBtnsView", ViewComponent)

CustomBtnsId = {
	EscortView = 1,
	SeckillZone = 3,
	WorldBoss = 2
}

local CustomBtnsParam = {
	[CustomBtnsId.EscortView] = {
		iconNum = 0,
		pointNum = 0,
		isStartShow = false
	}
}

function MainCustomBtnsView:ctor()
	MainCustomBtnsView.super.ctor(self)

	self.customBtnsItem = nil
	self.customOpensItem = nil
	self.btnsTimerList = nil
	self.opensTimerList = nil
	self.isDownTime = false
end

function MainCustomBtnsView:bindEvents()
	return
end

function MainCustomBtnsView:unbindEvents()
	return
end

function MainCustomBtnsView:destroyUI()
	MainCustomBtnsView.super.destroyUI(self)

	for _, item in pairs(self.customBtnsItem or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self.customBtnsItem = nil

	for _, item in pairs(self.customOpensItem or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self.customOpensItem = nil
	self.btnsTimerList = nil
	self.opensTimerList = nil
	self.isDownTime = false
end

function MainCustomBtnsView:onEnter()
	self:InitStartItems()
	GlobalDispatcher:addListener("UpdataCustomBtnsItem", self.ShowOrHideBtnsItem, self)
	GlobalDispatcher:addListener("UpdataCustomBtnsPoint", self.UpdataCustomBtnsPoint, self)
	GlobalDispatcher:dispatch(GlobalNotify.EnterMainCustom)
end

function MainCustomBtnsView:onExit()
	removetimer(self.CalculationSurplusTime, self)

	self.isDownTime = false
	self.btnsTimerList = nil
	self.opensTimerList = nil

	GlobalDispatcher:removeListener("UpdataCustomBtnsItem", self.ShowOrHideBtnsItem, self)
	GlobalDispatcher:removeListener("UpdataCustomBtnsPoint", self.UpdataCustomBtnsPoint, self)
end

function MainCustomBtnsView:buildUI()
	self.customOpensGo = self:getGo("customOpens")
	self.opensGoLayout = self.customOpensGo:GetComponent("UILayoutSingleLine")
	self.openItemsGo = goutil.findChild(self.customOpensGo, "openItems")

	goutil.setActive(self.openItemsGo, false)

	self.customBtnsGo = self:getGo("customBtns")
	self.btnsGoLayout = self.customBtnsGo:GetComponent("UILayoutSingleLine")
	self.imaBtnGo = goutil.findChild(self.customBtnsGo, "imaBtn")

	goutil.setActive(self.imaBtnGo, false)
end

function MainCustomBtnsView:InitStartItems()
	self.customBtnsItem = self.customBtnsItem or {}

	for id, info in pairs(CustomBtnsParam or {}) do
		if info then
			local isShow = info.isStartShow
			local supTime = 0

			if id == CustomBtnsId.EscortView then
				isShow, endTime = EscortModel.instance:IsPickupEscort()
				supTime = endTime - ServerTime.now()
			end

			self:ShowOrHideBtnsItem(isShow, id, supTime)
		end
	end
end

function MainCustomBtnsView:ShowOrHideBtnsItem(isShow, btnsId, ...)
	if not isShow then
		if self.customBtnsItem[btnsId] then
			goutil.setActive(self.customBtnsItem[btnsId].itemGo, false)

			if self.btnsTimerList and self.btnsTimerList[btnsId] then
				self.btnsTimerList[btnsId] = nil
			end

			self.btnsGoLayout:Layout()
		end

		return
	end

	if self.customBtnsItem[btnsId] == nil then
		self.customBtnsItem[btnsId] = self:CreatBtnsItem(btnsId)
	end

	goutil.setActive(self.customBtnsItem[btnsId].itemGo, true)
	self.btnsGoLayout:Layout()

	local param = {
		...
	}

	if param then
		if not param[1] then
			local timer = -1
			local isShowRed = false

			if btnsId == CustomBtnsId.EscortView then
				self.customBtnsItem[btnsId].nameTxt.text = timer and timer > 0 and self:_getTimeStrBySec(timer, false, true) or "护送"

				GameUtil.asBtn(self.customBtnsItem[btnsId].itemGo):AddClickListener(function()
					ViewMgr.instance:open(ViewName.EscortGoods)
				end, self)

				isShowRed = EscortModel.instance:GetEscortRedPoint("escortmain")
			end

			self:UpdataCustomBtnsPoint(btnsId, isShowRed)

			if timer and timer > 0 then
				self.btnsTimerList = self.btnsTimerList or {}
				self.btnsTimerList[btnsId] = timer

				if not self.isDownTime then
					self:CalculationSurplusTime()
				end
			end
		end
	end
end

function MainCustomBtnsView:CreatBtnsItem(btnsId)
	if btnsId == nil or CustomBtnsParam == nil then
		return
	end

	local info = CustomBtnsParam[btnsId]
	local itemLua = self.customBtnsItem[btnsId]

	if itemLua == nil then
		local btnGo = goutil.cloneAndSetParent(self.imaBtnGo, self.customBtnsGo.transform)

		btnGo.name = "btnsGo_" .. btnsId
		itemLua = {
			itemGo = btnGo,
			iconIma = btnGo:GetComponent("UIImageSpriteChange"),
			pointIma = goutil.findChildComponent(btnGo, "pointIma", "UIImageSpriteChange"),
			nameTxt = goutil.findChildTextComponent(btnGo, "nameTxt")
		}
	end

	local num = 0

	if info and info.iconNum then
		num = info.iconNum
	end

	itemLua.iconIma:SetState(num)

	if info and info.pointNum then
		num = info.pointNum
	end

	itemLua.pointIma:SetState(num)

	if info and not string.nilorempty(info.nameStr) then
		itemLua.nameTxt.text = info.nameStr
	end

	itemLua.pointIma.gameObject:SetActive(info.isShowPoint)

	return itemLua
end

function MainCustomBtnsView:UpdataCustomBtnsPoint(btnsId, isShow)
	if self.customBtnsItem == nil or self.customBtnsItem[btnsId] == nil then
		return
	end

	if self.customBtnsItem[btnsId].pointIma then
		self.customBtnsItem[btnsId].pointIma.gameObject:SetActive(isShow)
	end
end

function MainCustomBtnsView:CalculationSurplusTime()
	if (self.btnsTimerList == nil or next(self.btnsTimerList) == nil) and (self.opensTimerList == nil or next(self.opensTimerList) == nil) then
		self.isDownTime = false

		removetimer(self.CalculationSurplusTime, self)

		return
	end

	self.isDownTime = true

	for id, value in pairs(self.btnsTimerList or {}) do
		if id == CustomBtnsId.EscortView then
			local isPick, endTime = EscortModel.instance:IsPickupEscort()

			if not isPick or endTime <= 0 then
				self:ShowOrHideBtnsItem(false, id)
			else
				local supTime = endTime - ServerTime.now()

				self.customBtnsItem[id].nameTxt.text = self:_getTimeStrBySec(supTime, false, true)
			end
		elseif value and value > 0 then
			self.btnsTimerList[id] = value - 1
		else
			self:ShowOrHideBtnsItem(false, id)
		end
	end

	settimer(1, self.CalculationSurplusTime, self, true)
end

function MainCustomBtnsView:_getTimeStrBySec(timer, isReduce, isHour)
	local hour = math.floor(timer / 3600)
	local min = math.floor((timer - hour * 3600) / 60)
	local sec = timer - hour * 3600 - min * 60

	sec = sec < 1 and 0 or sec

	local minStr = min > 9 and tostring(min) or "0" .. min
	local secStr = sec > 9 and tostring(sec) or "0" .. sec

	return isReduce and (hour > 0 and string.format("%s:%s", hour, minStr) or isHour and string.format("%s:%s:%s", hour, minStr, secStr) or string.format("%s:%s", minStr, secStr)) or (hour > 0 or isHour) and string.format("%s:%s:%s", hour, minStr, secStr) or string.format("%s:%s", minStr, secStr)
end

return MainCustomBtnsView
