-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscollector/controller/GoddesscollectorController.lua

module("logic.extensions.goddesscollector.controller.GoddesscollectorController", package.seeall)

local GoddesscollectorController = class("GoddesscollectorController", BaseController)

GoddesscollectorController.PM_GoddessCollectorVerifyPetsRes = "GoddesscollectorController.PM_GoddessCollectorVerifyPetsRes"
GoddesscollectorController.PM_GoddessCollectorGainPrizeRes = "GoddesscollectorController.PM_GoddessCollectorGainPrizeRes"
GoddesscollectorController.PM_GoddessCollectorGetInfoRes = "GoddesscollectorController.PM_GoddessCollectorGetInfoRes"

function GoddesscollectorController:ctor()
	return
end

function GoddesscollectorController:onInit()
	GlobalDispatcher:addListener(GoddessCollectorAgent.PM_GoddessCollectorVerifyPetsRes, self._PM_GoddessCollectorVerifyPetsRes, self)
	GlobalDispatcher:addListener(GoddessCollectorAgent.PM_GoddessCollectorGainPrizeRes, self._PM_GoddessCollectorGainPrizeRes, self)
	GlobalDispatcher:addListener(GoddessCollectorAgent.PM_GoddessCollectorGetInfoRes, self._PM_GoddessCollectorGetInfoRes, self)
	GlobalDispatcher:addListener("opengoddesscollectornewpetsview", self._onOpenGoddessCollectorNewPetsView, self)
	self:onReset()
end

function GoddesscollectorController:onReset()
	self._needPlayVerifyAnim = false
	self._isPlayVarifyAnim = false
end

function GoddesscollectorController:_PM_GoddessCollectorVerifyPetsRes(status, msg)
	if status == 0 then
		self._needPlayVerifyAnim = false

		local petIds = GoddesscollectorModel.instance:getVerifyPetInfos()
		local oldScore = GoddesscollectorModel.instance:getVerifyCurrSore()

		if oldScore < msg.curScore then
			self._needPlayVerifyAnim = true
		end

		if not self._needPlayVerifyAnim then
			FloatWordMgr.instance:show("积分无变化，当前积分为" .. msg.curScore)
		end

		GoddesscollectorModel.instance:verifyPetsRes(msg)
	end

	GlobalDispatcher:dispatch(GoddesscollectorController.PM_GoddessCollectorVerifyPetsRes, status, msg)
end

function GoddesscollectorController:_PM_GoddessCollectorGainPrizeRes(status, msg)
	if status == 0 then
		GoddesscollectorModel.instance:gainPrizeRes(msg.prizeType, msg.prizeId)
	end

	GlobalDispatcher:dispatch(GoddesscollectorController.PM_GoddessCollectorGainPrizeRes, status, msg)
end

function GoddesscollectorController:_PM_GoddessCollectorGetInfoRes(status, msg)
	if status == 0 then
		GoddesscollectorModel.instance:setInfo(msg)
	end

	GlobalDispatcher:dispatch(GoddesscollectorController.PM_GoddessCollectorGetInfoRes, status, msg)
end

function GoddesscollectorController:needPlayVerifyAnim()
	return self._needPlayVerifyAnim
end

function GoddesscollectorController:isPlayVarifyAnim()
	return self._isPlayVarifyAnim
end

function GoddesscollectorController:setIsVerifyAnim(flag)
	self._isPlayVarifyAnim = flag
end

function GoddesscollectorController:getPersonRankInfo(rank)
	local rankList = GoddesscollectorModel.instance:getRankInfos()
	local time, area

	for i, v in ipairs(rankList) do
		if rankList[i].rank == rank then
			area = rankList[i].headInfo.areaName
			time = rankList[i].time

			break
		end
	end

	return time
end

function GoddesscollectorController:_onOpenGoddessCollectorNewPetsView(params)
	UIStateManager.instance:push(ViewName.GoddessCollectorNewPetsView, params and params[1])
end

GoddesscollectorController.instance = GoddesscollectorController.New()

return GoddesscollectorController
