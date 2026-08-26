-- chunkname: @modules/logic/rouge/dlc/101/controller/RougeDLCController101.lua

module("modules.logic.rouge.dlc.101.controller.RougeDLCController101", package.seeall)

local RougeDLCController101 = class("RougeDLCController101", BaseController)

function RougeDLCController101:openRougeLimiterView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeLimiterView, param, isImmediate)
end

function RougeDLCController101:openRougeLimiterLockedTipsView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeLimiterLockedTipsView, param, isImmediate)
end

function RougeDLCController101:openRougeLimiterOverView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeLimiterOverView, param, isImmediate)
end

function RougeDLCController101:openRougeLimiterBuffView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeLimiterBuffView, param, isImmediate)
end

function RougeDLCController101:openRougeDangerousView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeDangerousView, param, isImmediate)
end

function RougeDLCController101:openRougeLimiterResultView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeLimiterResultView, param, isImmediate)
end

function RougeDLCController101:openRougeFactionLockedTips(param, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeFactionLockedTips, param, isImmediate)
end

function RougeDLCController101:unlockLimiterBuff(buffId)
	local buffCo = RougeDLCConfig101.instance:getLimiterBuffCo(buffId)

	if not buffCo then
		return
	end

	local needEmblem = buffCo.needEmblem
	local curTotalEmblem = RougeDLCModel101.instance:getTotalEmblemCount()

	if curTotalEmblem < needEmblem then
		GameFacade.showToast(ToastEnum.LackEmblem)

		return
	end

	local season = RougeOutsideModel.instance:season()

	RougeOutsideRpc.instance:sendRougeLimiterUnlockBuffRequest(season, buffId)
	AudioMgr.instance:trigger(AudioEnum.UI.UnlockLimiterBuff)
end

function RougeDLCController101:speedupLimiterBuff(buffId)
	local buffCo = RougeDLCConfig101.instance:getLimiterBuffCo(buffId)

	if not buffCo then
		return
	end

	local curTotalEmblem = RougeDLCModel101.instance:getTotalEmblemCount()
	local remainCDRound = RougeDLCModel101.instance:getLimiterBuffCD(buffId)
	local speedupCost = RougeDLCHelper101.getLimiterBuffSpeedupCost(remainCDRound)

	if curTotalEmblem < speedupCost then
		GameFacade.showToast(ToastEnum.LackEmblem)

		return
	end

	local season = RougeOutsideModel.instance:season()

	RougeOutsideRpc.instance:sendRougeLimiterSpeedUpBuffCdRequest(season, buffId)
end

function RougeDLCController101:onGetUnlockLimiterBuffInfo(buffId)
	local buffCo = RougeDLCConfig101.instance:getLimiterBuffCo(buffId)

	if not buffCo then
		return
	end

	local limiterMo = RougeDLCModel101.instance:getLimiterMo()

	limiterMo:updateTotalEmblemCount(-buffCo.needEmblem)
	limiterMo:unlockLimiterBuff(buffId)
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.UpdateBuffState, buffId)
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.UpdateEmblem)
end

function RougeDLCController101:onGetSpeedupLimiterBuffInfo(buffId)
	local buffCo = RougeDLCConfig101.instance:getLimiterBuffCo(buffId)

	if not buffCo then
		return
	end

	local limiterMo = RougeDLCModel101.instance:getLimiterMo()
	local cdRound = limiterMo:getBuffCDRound(buffId)
	local speedupCost = RougeDLCHelper101.getLimiterBuffSpeedupCost(cdRound)

	limiterMo:updateTotalEmblemCount(-speedupCost)
	limiterMo:speedupLimiterBuff(buffId)
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.UpdateBuffState, buffId)
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.UpdateEmblem)
end

function RougeDLCController101:try2SaveLimiterSetting()
	local isDirty = RougeDLCModel101.instance:isModifySelectLimiterGroup()

	if not isDirty then
		return
	end

	local season = RougeOutsideModel.instance:season()
	local limiterClientInfo = RougeDLCModel101.instance:getLimiterClientMo()

	RougeOutsideRpc.instance:sendRougeLimiterSettingSaveRequest(season, limiterClientInfo)
end

RougeDLCController101.instance = RougeDLCController101.New()

LuaEventSystem.addEventMechanism(RougeDLCController101.instance)

return RougeDLCController101
