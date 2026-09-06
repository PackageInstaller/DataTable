-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/miya/MiyaCountdownView.lua

module("logic.extensions.timelimitedchallenge.view.miya.MiyaCountdownView", package.seeall)

local MiyaCountdownView = class("MiyaCountdownView", ViewComponent)
local Time = UnityEngine.Time

function MiyaCountdownView:buildUI()
	MiyaCountdownView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._txtTitle = self:getTxt("Image/txtTitle")
	self._countDown = self:getGo("Image/countdown")

	self._countDown:SetActive(false)

	self._container = self:getGo("Image").transform
end

function MiyaCountdownView:onExit()
	MiyaCountdownView.super.onExit(self)
	removetimer(self._onTick, self)
	removetimer(self._recycleTopObj, self)
	removetimer(self._startTick, self)
end

function MiyaCountdownView:onEnter()
	MiyaCountdownView.super.onEnter(self)

	local params = self:getOpenParam()

	if not goutil.isNil(self._txtTitle) then
		self._txtTitle.text = params[1]
	end

	self._leftTime = checknumber(params[2])
	self._usedObjs = {}
	self._freeObjs = {}

	settimer(0.2, self._startTick, self)
end

function MiyaCountdownView:_startTick()
	settimer(0, self._onTick, self, true)
end

function MiyaCountdownView:_onTick()
	self._leftTime = self._leftTime - Time.deltaTime

	local temp = math.ceil(self._leftTime)

	if temp ~= self._ceilLeftTime and temp > 0 then
		local obj = self:_createObj(temp)
		local uiText = goutil.findChildTextComponent(obj, "txtCountdown")
		local text = temp > 0 and temp or "开始"

		if uiText then
			uiText.text = text
		else
			imgNum = goutil.findChild(obj, "txtCountdown"):GetComponent(typeof(UIImgNumeralText))

			imgNum:SetText(text)
		end

		self._ceilLeftTime = temp
	end

	if self._leftTime < -0.02 then
		self:close()
		GlobalDispatcher:dispatch(GlobalNotify.MiyaCountdownFinished)
	end
end

function MiyaCountdownView:_createObj(num)
	print("createObj num = " .. num)

	local obj

	if #self._freeObjs > 0 then
		obj = self._freeObjs[1]

		table.remove(self._freeObjs, 1)
	else
		obj = goutil.cloneAndSetParent(self._countDown, self._container, tostring(num))

		Framework.TransformUtil.SetLocalPos(obj.transform, 0, 0, 0)
		Framework.TransformUtil.SetLocalScale(obj.transform, 1, 1, 1)
	end

	obj:SetActive(true)
	settimer(0.57, self._recycleTopObj, self, false)
	table.insert(self._usedObjs, 1, obj)

	return obj
end

function MiyaCountdownView:_recycleTopObj()
	local obj = self._usedObjs[1]

	obj:SetActive(false)
	table.insert(self._freeObjs, obj)
end

return MiyaCountdownView
