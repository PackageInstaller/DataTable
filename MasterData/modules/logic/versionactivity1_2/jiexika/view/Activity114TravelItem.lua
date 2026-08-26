-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114TravelItem.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114TravelItem", package.seeall)

local Activity114TravelItem = class("Activity114TravelItem", LuaCompBase)

function Activity114TravelItem:ctor(go, index)
	self:__onInit()

	self.go = go
	self.index = index
	self._golock = gohelper.findChild(self.go, "go_lock")
	self._gonormal = gohelper.findChild(self.go, "normal")
	self._name = gohelper.findChildTextMesh(self._gonormal, "name")
	self._nameEn = gohelper.findChildTextMesh(self._gonormal, "name/nameEn")
	self._gopoint = gohelper.findChild(self._gonormal, "point/go_point")
	self._goselect = gohelper.findChild(self.go, "go_select")
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "btn_click")
	self._selectAnim = SLFramework.AnimatorPlayer.Get(self._goselect)

	self:addEventListeners()
	self:onInitView()
end

function Activity114TravelItem:addEventListeners()
	self.addClickCb(self, self._btnclick, self._btnclickOnClick, self)
end

function Activity114TravelItem:_btnclickOnClick()
	if self._eventStatu ~= Activity114Enum.TravelStatus.Normal then
		if self._eventStatu == Activity114Enum.TravelStatus.EventBlock or self._eventStatu == Activity114Enum.TravelStatus.EventEnd then
			GameFacade.showToast(ToastEnum.Act114TravelEnd)
		end

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_travel_circle)
	gohelper.setActive(self._goselect, true)
	self._selectAnim:Stop()
	self._selectAnim:Play(UIAnimationName.Open, self.showMsgBox, self)
	UIBlockMgr.instance:startBlock("Activity114TravelItem")
end

function Activity114TravelItem:showMsgBox()
	UIBlockMgr.instance:endBlock("Activity114TravelItem")
	self:onTravel()
end

function Activity114TravelItem:onTravel()
	if Activity114Model.instance:isEnd() then
		Activity114Controller.instance:alertActivityEndMsgBox()

		return
	end

	Activity114Rpc.instance:travelRequest(Activity114Model.instance.id, self.index)
end

function Activity114TravelItem:cancelTravel()
	gohelper.setActive(self._goselect, false)
end

function Activity114TravelItem:onInitView()
	local co = Activity114Config.instance:getTravelCoList(Activity114Model.instance.id)[self.index]

	self.co = co
	self._name.text = co.place
	self._nameEn.text = co.placeEn

	local mo = Activity114Model.instance.unLockTravelDict[self.index]
	local lock = not mo

	gohelper.setActive(self._golock, lock)
	gohelper.setActive(self._gonormal, not lock)
	gohelper.setActive(self._goselect, false)
	gohelper.setActive(self._gopoint, false)
	gohelper.setActive(self._btnclick.gameObject, not lock)

	self._eventStatu = Activity114Enum.TravelStatus.Normal

	if lock then
		self._eventStatu = Activity114Enum.TravelStatus.TravelLock

		return
	end

	local events = string.splitToNumber(co.events, "#")
	local nowTimes = mo.times

	self.points = {}

	for i = 1, #events do
		local type = 1

		if nowTimes < i and mo.isBlock ~= 1 then
			type = 1

			local eventCo = Activity114Config.instance:getEventCoById(Activity114Model.instance.id, events[i])

			if eventCo.config.isCheckEvent == 1 then
				type = eventCo.config.disposable == 1 and 6 or 7
			end
		elseif i < nowTimes or i == nowTimes and mo.isBlock ~= 1 then
			type = 2
		elseif i == nowTimes and mo.isBlock == 1 then
			type = 3
		elseif nowTimes < i and mo.isBlock == 1 then
			type = 4
		end

		self:_createPoint(i, type)
	end

	if mo.isBlock == 1 then
		self._eventStatu = Activity114Enum.TravelStatus.EventBlock
	else
		local eventId = events[mo.times + 1]

		if not eventId then
			self._eventStatu = Activity114Enum.TravelStatus.EventEnd
		elseif not Activity114Model.instance.unLockEventDict[eventId] then
			self._eventStatu = Activity114Enum.TravelStatus.EventLock
		end
	end

	if co.residentEvent > 0 then
		if self._eventStatu ~= Activity114Enum.TravelStatus.Normal then
			self._eventStatu = Activity114Enum.TravelStatus.Normal

			local i = #self.points + 1

			self:_createPoint(i, 5)
		end
	elseif mo.hasSpecialEvent and co.specialEvents > 0 then
		self._eventStatu = Activity114Enum.TravelStatus.Normal
	end

	if not Activity114Model.instance:getIsPlayUnLock(Activity114Enum.EventType.Travel, mo.travelId) then
		gohelper.setActive(self._golock, true)
		self:playUnlockEffect()
	end
end

function Activity114TravelItem:_createPoint(index, type)
	self.points[index] = self:getUserDataTb_()
	self.points[index].go = gohelper.cloneInPlace(self._gopoint, "Point")
	self.points[index].anim = self.points[index].go:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self.points[index].go, true)

	for i = 1, 7 do
		local typeGo = gohelper.findChild(self.points[index].go, "type" .. i)

		gohelper.setActive(typeGo, type == i)
	end
end

function Activity114TravelItem:playUnlockEffect()
	for i = 1, #self.points do
		self.points[i].anim:Play(UIAnimationName.Unlock, 0, 0)
	end

	local animatorPlayer = SLFramework.AnimatorPlayer.Get(self.go)

	animatorPlayer:Stop()
	animatorPlayer:Play(UIAnimationName.Unlock, self.playUnlockEffectFinish, self)
	Activity114Model.instance:setIsPlayUnLock(Activity114Enum.EventType.Travel, self.index)
end

function Activity114TravelItem:playUnlockEffectFinish()
	gohelper.setActive(self._golock, false)
end

function Activity114TravelItem:onDestroy()
	UIBlockMgr.instance:endBlock("Activity114TravelItem")

	if self.points then
		for i = 1, #self.points do
			gohelper.destroy(self.points[i].go)
		end
	end

	self:__onDispose()
end

return Activity114TravelItem
