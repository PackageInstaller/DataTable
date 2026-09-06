-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenyaolongzunshengzhu/controller/ShenyaolongzunshengzhuController.lua

module("logic.extensions.shenyaolongzunshengzhu.controller.ShenyaolongzunshengzhuController", package.seeall)

local ShenyaolongzunshengzhuController = class("ShenyaolongzunshengzhuController", BaseController)

function ShenyaolongzunshengzhuController:onInit()
	self:onReset()
end

function ShenyaolongzunshengzhuController:onReset()
	self._fmtMo = ShenyaolongzunshengzhuFmtMo.New()
end

function ShenyaolongzunshengzhuController:getCurrActivity()
	return 337001
end

function ShenyaolongzunshengzhuController:sendGetInfo(activityId)
	DivineDragonAryaClgAgent.instance:sendPM_DivineDragonAryaClgGetInfoReq(activityId)
end

function ShenyaolongzunshengzhuController:onGetInfo(msg)
	ShenyaolongzunshengzhuModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ShenyaolongzunshengzhuInfoUpdate)
end

function ShenyaolongzunshengzhuController:sendGetGodRank(activityId)
	DivineDragonAryaClgAgent.instance:sendPM_DivineDragonAryaClgGetGodRankReq(activityId)
end

function ShenyaolongzunshengzhuController:onGetGodRank(msg)
	ShenyaolongzunshengzhuModel.instance:onGetGodRank(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ShenyaolongzunshengzhuRankUpdate)
end

function ShenyaolongzunshengzhuController:sendGetDayRank(activityId)
	DivineDragonAryaClgAgent.instance:sendPM_DivineDragonAryaClgGetDailyRankReq(activityId)
end

function ShenyaolongzunshengzhuController:onGetDayRank(msg)
	ShenyaolongzunshengzhuModel.instance:onGetDayRank(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ShenyaolongzunshengzhuRankUpdate)
end

function ShenyaolongzunshengzhuController:openFmtView(activityId, stageId)
	self._fmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(self._fmtMo)
end

function ShenyaolongzunshengzhuController:sendStartFight(activityId, stageId, simpleForm)
	UIJumper.instance:pushOneStack(ViewName.ShenyaolongzunshengzhumainView, true)
	UIJumper.instance:pushOneStack(ViewName.ShenyaolongzunshengzhustageView, true)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self.onBattleEnd, self))
	DivineDragonAryaClgAgent.instance:sendPM_DivineDragonAryaClgFightReq(activityId, stageId, simpleForm)
end

function ShenyaolongzunshengzhuController:setLastFightInfo(msg)
	self._activityId = msg.activityId
	self._stageId = msg.stageId
	self._isWin = checkbool(msg.win)
	self._curFightTagInfo = GameUtil.pbToTable(msg.curFightTagInfo)

	if self._isWin then
		ShenyaolongzunshengzhuModel.instance:updateStageInfo(self._activityId, msg.stageInfo)
	end

	local info = ShenyaolongzunshengzhuModel.instance:getStageInfo(self._activityId, self._stageId) or {}

	if not info.tagInfo then
		self._lastFightTagInfo = {}
	end
end

function ShenyaolongzunshengzhuController:onBattleEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)

	if self._isWin == false then
		return false
	end

	UIStateManager.instance:push(ViewName.ShenyaolongzunshengzhuresultView, self._activityId, self._lastFightTagInfo, self._curFightTagInfo)

	return true
end

ShenyaolongzunshengzhuController.instance = ShenyaolongzunshengzhuController.New()

return ShenyaolongzunshengzhuController
