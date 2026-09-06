-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pigraise/controller/PigraiseController.lua

module("logic.extensions.pigraise.controller.PigraiseController", package.seeall)

local PigraiseController = class("PigraiseController", BaseController)

function PigraiseController:ctor()
	self.agent = AnimalsAgent.instance
end

function PigraiseController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.StartEnterGame, self._onEnterGame, self)
	self:onReset()
end

function PigraiseController:onReset()
	self.agent:reset()

	self._isAddTimerListen = false
	self.curSellCfg = nil
end

function PigraiseController:stopShowCI(changeSetId)
	self.ciList = self.ciList or {}

	if checknumber(changeSetId) > 0 then
		table.insert(self.ciList, checknumber(changeSetId))
		MaterialController.instance:saveChangeSetToTemp(checknumber(changeSetId))
	end
end

function PigraiseController:showCI()
	MaterialController.instance:showChangeSetInTemp(self.ciList)

	self.ciList = {}
end

function PigraiseController:getStateReq(handler, handlerobj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		self.agent:sendPM_AnimalsGetStateReq(self._onGetStateRes, self, self._errorCall)
	end
end

function PigraiseController:_onGetStateRes(msg)
	PigraiseModel.instance:updateAfterGetState(msg)
	self:_callback()
	GlobalDispatcher:dispatch(GlobalNotify.PigRaiseStateUpdate)

	if not self._isAddTimerListen and PigraiseModel.instance:getCurPetInfo() then
		self._isAddTimerListen = true

		ClockMgr.instance:removeListener(ClockMgr.TickHour, self._updatePerHour, self)
		ClockMgr.instance:addListener(ClockMgr.TickHour, self._updatePerHour, self)
		removetimer(self._updateTime, self)
		settimer(1, self._updateTime, self)
		self:getAdventureInfoReq()
	end
end

function PigraiseController:processFeedBackReq(handler, handlerobj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		local id = PigraiseModel.instance:getPigId()

		if id == nil then
			return
		end

		self.agent:sendPM_AnimalsProcessFeedBackReq(id, self._processFeedBackRes, self, self._errorCall)
	end
end

function PigraiseController:_processFeedBackRes(msg)
	PigraiseModel.instance:updateAfterProcessFeedBack(msg)
	self:_callback()
	GlobalDispatcher:dispatch(GlobalNotify.PigRaiseStateUpdate)
end

function PigraiseController:touchReq(handler, handlerobj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		local id = PigraiseModel.instance:getPigId()

		if id == nil then
			return
		end

		self.agent:sendPM_AnimalsTouchReq(id, self._touchRes, self, self._errorCall)
	end
end

function PigraiseController:_touchRes(msg)
	PigraiseModel.instance:updateAfterTouch(msg)
	self:_callback()
	GlobalDispatcher:dispatch(GlobalNotify.PigRaiseStateUpdate)

	local eventInfo = PigraiseModel.instance:getCurEventInfo()

	if eventInfo then
		local ci = msg.changeSetId

		PigraiseController.instance:stopShowCI(ci)
		UIStateManager.instance:push(ViewName.PigraiseeventView, eventInfo)
	end
end

function PigraiseController:oneKeytouchReq(handler, handlerobj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		local id = PigraiseModel.instance:getPigId()

		if id == nil then
			return
		end

		self.agent:sendPM_AnimalsOneKeyTouchReq(id, self._oneKeyTouchRes, self, self._errorCall)
	end
end

function PigraiseController:_oneKeyTouchRes(msg)
	PigraiseModel.instance:updateAfterTouch(msg)
	PigraiseModel.instance:updateAfterOneKeyTouch()
	self:_callback()
	GlobalDispatcher:dispatch(GlobalNotify.PigRaiseStateUpdate)

	local eventInfo = PigraiseModel.instance:getCurEventInfo()

	if eventInfo then
		local ci = msg.changeSetId

		PigraiseController.instance:stopShowCI(ci)
		UIStateManager.instance:push(ViewName.PigraiseeventView, eventInfo)
	end
end

function PigraiseController:feedReq(handler, handlerobj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		local id = PigraiseModel.instance:getPigId()

		if id == nil then
			return
		end

		self.agent:sendPM_AnimalsFeedReq(id, self._feedRes, self, self._errorCall)
	end
end

function PigraiseController:_feedRes(msg)
	PigraiseModel.instance:updateAfterFeed(msg)
	self:_callback()
	GlobalDispatcher:dispatch(GlobalNotify.PigRaiseStateUpdate)

	local eventInfo = PigraiseModel.instance:getCurEventInfo()

	if eventInfo then
		local ci = msg.changeSetId

		PigraiseController.instance:stopShowCI(ci)
		UIStateManager.instance:push(ViewName.PigraiseeventView, eventInfo)
	end
end

function PigraiseController:followReq(isFollow, handler, handlerobj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		local id = PigraiseModel.instance:getPigId()

		if id == nil then
			return
		end

		self.agent:sendPM_AnimalsFollowReq(id, isFollow, self._followRes, self, self._errorCall)
	end
end

function PigraiseController:_followRes(msg)
	PigraiseModel.instance:updateAfterFollow(msg)
	self:_callback()
	GlobalDispatcher:dispatch(GlobalNotify.PigRaiseStateUpdate)
end

function PigraiseController:gainIntimacyPrizeReq(prizeId, handler, handlerobj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		local id = PigraiseModel.instance:getPigId()

		if id == nil then
			return
		end

		PigraiseModel.instance:gainLvPrize(prizeId)
		self.agent:sendPM_AnimalsGainIntimacyPrizeReq(id, prizeId, self._gainIntimacyPrizeRes, self, self._errorCall)
	end
end

function PigraiseController:_gainIntimacyPrizeRes(msg)
	PigraiseModel.instance:updateAfterGainIntimacyPrize(msg)
	self:_callback()
	GlobalDispatcher:dispatch(GlobalNotify.PigRaiseStateUpdate)
end

function PigraiseController:getFeedbackEventReq(handler, handlerobj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		local id = PigraiseModel.instance:getPigId()

		if id == nil then
			return
		end

		self.agent:sendPM_AnimalsGetFeedbackEventReq(id, self._getFeedbackEventRes, self, self._errorCall)
	end
end

function PigraiseController:_getFeedbackEventRes(msg)
	PigraiseModel.instance:updateAfterGetFeedbackEvent(msg)
	self:_callback()
	GlobalDispatcher:dispatch(GlobalNotify.PigRaiseStateUpdate)

	if not PigraiseModel.instance:getCurFeedbackEventInfo() and not self._isCheckOut then
		removetimer(self._checkoutFeedbackEvent, self)
		settimer(60, self._checkoutFeedbackEvent, self, false)
	end
end

function PigraiseController:adoptReq(name, hair, tail, skin, handler, handlerobj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		self.agent:sendPM_AnimalsGinPigReq(name, hair, tail, skin, self._adoptRes, self, self._errorCall)
	end
end

function PigraiseController:_adoptRes(msg)
	PigraiseModel.instance:updateAfterAdopt(msg)

	self.curSellCfg = nil

	local cfgs = PigraiseConfig.instance:getAnimalSellCfgs()

	for k, v in pairs(cfgs) do
		if v and FuncOpenModel.instance:getFuncIsOpen(v.funcId) then
			self.curSellCfg = v

			return
		end
	end

	self:_callback()
end

function PigraiseController:getAdventureInfoReq(handler, handlerobj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		local id = PigraiseModel.instance:getPigId()

		if id == nil then
			return false
		end

		self.agent:sendPM_AnimalsPigAdventureInfoReq(id, self._getAdventureInfoRes, self, self._errorCall)

		return true
	end

	return false
end

function PigraiseController:_getAdventureInfoRes(msg)
	PigraiseModel.instance:updateAfterGetAdventureInfo(msg)
	self:_callback()
	GlobalDispatcher:dispatch(GlobalNotify.PigRaiseAdventureStateUpdate)
end

function PigraiseController:getAdventurePrizeReq(handler, handlerobj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		self.agent:sendPM_AnimalsPigAdventurePrizeReq(self._getAdventurePrizeRes, self, self._errorCall)
	end
end

function PigraiseController:_getAdventurePrizeRes(msg)
	PigraiseModel.instance:updateAfterGetAdventurePrize(msg)
	self:_callback()
	removetimer(self._updateTime, self)
	settimer(1, self._updateTime, self)
	GlobalDispatcher:dispatch(GlobalNotify.PigRaiseAdventureStateUpdate)
end

function PigraiseController:activatePetReq(defineId, handler, handlerobj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		self.agent:sendPM_AnimalsActivateReq(defineId, self._activateRes, self, self._errorCall)
	end
end

function PigraiseController:_activateRes(msg)
	PigraiseModel.instance:updateAfterActivatePet(msg)
	self:_callback()
end

function PigraiseController:takePetReq(id, handler, handlerobj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		self.agent:sendPM_AnimalsTakeReq(id, self._takePetRes, self, self._errorCall)
	end
end

function PigraiseController:_takePetRes(msg)
	PigraiseModel.instance:updateAfterTakePet(msg)
	self:_callback()
end

function PigraiseController:_callback(...)
	local handler = self._handler
	local handlerObj = self._handlerObj

	self._handler = nil
	self._handlerObj = nil

	if handler then
		if handlerObj then
			self._handler(handlerObj, ...)
		else
			handler(...)
		end
	end
end

function PigraiseController:_errorCall()
	self._handler = nil
	self._handlerObj = nil
end

function PigraiseController:_checkIsReqing()
	return false
end

function PigraiseController:_onEnterGame()
	if FuncOpenModel.instance:getFuncIsOpen(100) then
		self:getStateReq()

		self.curSellCfg = nil

		local cfgs = PigraiseConfig.instance:getAnimalSellCfgs()

		for k, v in pairs(cfgs) do
			if v and FuncOpenModel.instance:getFuncIsOpen(v.funcId) then
				self.curSellCfg = v

				return
			end
		end
	end
end

function PigraiseController:_updateTime()
	local isUpdatetime, isUpdatePirze = PigraiseModel.instance:isupdateAdventure()

	if isUpdatetime == nil then
		return
	end

	if isUpdatetime then
		if isUpdatePirze then
			if self._isAfterUpdatePrize then
				PigraiseController.instance:getAdventureInfoReq()

				self._isAfterUpdatePrize = false
			end
		else
			self._isAfterUpdatePrize = true
		end

		PigraiseModel.instance:updateAdventureTime()

		if self._isShowRedPoint then
			self._isShowRedPoint = false

			RedPointController.instance:setRedPointInfo(RedPointModel.ID_PIGRAISE_ADVENTURE, false)
		end
	else
		removetimer(self._updateTime, self)
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_PIGRAISE_ADVENTURE, true)

		self._isShowRedPoint = true
	end
end

function PigraiseController:_updatePerHour(newHour)
	if PigraiseModel.instance:getCurFeedbackEventInfo() then
		return
	end

	local isExist = table.indexof(PigraiseConfig.instance:getFeedbackEventHours(), newHour)

	if isExist then
		self:getFeedbackEventReq()

		self._isCheckOut = false
	end
end

function PigraiseController:_checkoutFeedbackEvent()
	self:getFeedbackEventReq()

	self._isCheckOut = true
end

PigraiseController.instance = PigraiseController.New()

return PigraiseController
