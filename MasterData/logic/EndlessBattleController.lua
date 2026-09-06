-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/endlessbattle/controller/EndlessBattleController.lua

module("logic.extensions.endlessbattle.controller.EndlessBattleController", package.seeall)

local EndlessBattleController = class("EndlessBattleController", BaseController)

function EndlessBattleController:ctor()
	return
end

function EndlessBattleController:onInit()
	InfiniteFightAgent.instance:addHandler(InfiniteFightAgent.NotifyInfiniteFightEndRes, self._onFightEndRes, self)
	InfiniteFightAgent.instance:setShowChangeSetFunc(GameUtil.handler(self.onShowChagenSet, self))
	self:onReset()
end

function EndlessBattleController:onReset()
	self._defendCount = 0
	self._cacheChangeSetId = 0
end

function EndlessBattleController:onShowChagenSet(changeSetId, msgName)
	if changeSetId ~= nil and changeSetId >= 0 then
		if msgName == "handleNotifyInfiniteFightEndRes" then
			printInfo("无尽试炼设置changeSetId", changeSetId, msgName)
			BattleSettlementModel.instance:setChangeSetId(changeSetId)
		else
			MaterialFacade.instance:popAndShowChangeSetItems(changeSetId)
		end
	end
end

function EndlessBattleController:sendSweepReq()
	InfiniteFightAgent.instance:sendInfiniteSweepReq(self._onSweepRes, self)
end

function EndlessBattleController:_onSweepRes(msg)
	EndlessBattleModel.instance:setDailyState(2)
	GlobalDispatcher:dispatch(GlobalNotify.InfiniteSweepRes)
end

function EndlessBattleController:sendOneKeyReq()
	InfiniteFightAgent.instance:sendInfiniteOneKeyFightReq(self._onOneKeyRes, self)
end

function EndlessBattleController:_onOneKeyRes(msg)
	self._cacheChangeSetId = msg.changeSetId

	print("self._cacheChangeSetId = " .. self._cacheChangeSetId)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	EndlessBattleModel.instance:setOneKeyFightInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.InfiniteOneKeyRes)
end

function EndlessBattleController:showCacheChangeSetId()
	if checknumber(self._cacheChangeSetId) > 0 then
		print("showChangeSetInTemp = " .. self._cacheChangeSetId)
		MaterialController.instance:showChangeSetInTemp(self._cacheChangeSetId)
	end

	self._cacheChangeSetId = 0
end

function EndlessBattleController:infiniteFightInfoReq()
	InfiniteFightAgent.instance:sendInfiniteFightInfoReq(self._onInfiniteFightInfoRes, self, self._errHandler)
end

function EndlessBattleController:_onInfiniteFightInfoRes(msg)
	EndlessBattleModel.instance:setInfiniteFightInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.InfiniteInfoRes)
end

function EndlessBattleController:setInfiniteFightFormReq(simpleForm, handler, handlerObj)
	self._saveHandler = handler
	self._saveHandlerObj = handlerObj

	InfiniteFightAgent.instance:sendSetInfiniteFightFormReq(simpleForm, self._onSetInfiniteFightFormRes, self, self._errHandler)
end

function EndlessBattleController:_onSetInfiniteFightFormRes(msg)
	EndlessBattleModel.instance:setFormation(msg.simpleForm)
	GlobalDispatcher:dispatch(GlobalNotify.SetInfiniteFightFormRes, msg)
	GameUtil.callBack(self._saveHandler, self._saveHandlerObj)
end

function EndlessBattleController:getInfiniteFightFormReq()
	InfiniteFightAgent.instance:sendGetInfiniteFightFormReq(self._onGetInfiniteFightFormRes, self, self._errHandler)
end

function EndlessBattleController:_onGetInfiniteFightFormRes(msg)
	EndlessBattleModel.instance:setFormation(msg.simpleForm)
	GlobalDispatcher:dispatch(GlobalNotify.GetInfiniteFightFormRes, msg)
end

function EndlessBattleController:infiniteFightBuffReq(handler, handlerObj)
	self._buffHandler = handler
	self._buffHandlerObj = handlerObj

	InfiniteFightAgent.instance:sendInfiniteFightBuffReq(self._onInfiniteFightBuffRes, self, self._errHandler)
end

function EndlessBattleController:_onInfiniteFightBuffRes(msg)
	GameUtil.callBack(self._buffHandler, self._buffHandlerObj, msg)
end

function EndlessBattleController:_onFightEndRes(msg)
	print("endlessbattle end")
end

function EndlessBattleController:_errHandler(msg, status)
	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
end

function EndlessBattleController:getDefendCount()
	return self._defendCount or 0
end

function EndlessBattleController:startBattle()
	self._defendCount = 0

	local buffId = EndlessBattleModel.instance:getBuffId()

	BattleFacade.instance:startEndlessBattle()
	InfiniteFightAgent.instance:sendInfiniteStartFightReq(buffId, nil, self, self._errHandler)
	EndlessBattleModel.instance:setBattleFlag(true)
end

function EndlessBattleController:getBattleName()
	print("get endless battlename")

	local curWaveId = EndlessBattleModel.instance:getCurWaveId()

	return string.format("无尽试炼第%d波第%d场次", curWaveId, self._defendCount + 1)
end

function EndlessBattleController:tryNextBattle()
	self._defendCount = checknumber(self._defendCount) + 1

	local curWaveId = EndlessBattleModel.instance:getCurWaveId()
	local cfgs = EndlessBattleConfig.instance:getStageCfgsByWaveId(curWaveId)

	if self._defendCount + 1 <= #cfgs then
		self:reqNextBattle()

		return true
	end

	return false
end

function EndlessBattleController:reqNextBattle()
	InfiniteFightAgent.instance:sendInfiniteContinueFightReq(nil, self, self._onContinueFightError)
end

function EndlessBattleController:_onContinueFightError(msg, status)
	if status == -512 then
		GlobalDispatcher:dispatch(GlobalNotify.StartBattlePassWaiting, 5)
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
end

EndlessBattleController.instance = EndlessBattleController.New()

return EndlessBattleController
