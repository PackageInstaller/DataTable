-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vrspace/controller/VRSpaceController.lua

module("logic.extensions.vrspace.controller.VRSpaceController", package.seeall)

local VRSpaceController = class("VRSpaceController", BaseController)

function VRSpaceController:onInit()
	self:onReset()
end

function VRSpaceController:onReset()
	self._vFmtMoMap = {}
	self._rFmtMoMap = {}
end

function VRSpaceController:getDefaultActivityId()
	return 531001
end

function VRSpaceController:sendGetInfo(activityId)
	VRSpaceAgent.instance:sendPM_VRSpaceGetInfoReq(activityId)
end

function VRSpaceController:onGetInfo(msg)
	VRSpaceModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.VR_SPACE_INFO_UPDATE)
end

function VRSpaceController:sendGetRankInfo(activityId)
	VRSpaceAgent.instance:sendPM_VRSpaceGetRankInfoReq(activityId)
end

function VRSpaceController:onGetRankInfo(msg)
	VRSpaceModel.instance:onGetRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.VR_SPACE_RANK_INFO_UPDATE)
end

function VRSpaceController:sendSelectBuff(activityId, buffLv)
	VRSpaceAgent.instance:sendPM_VRSpaceSelectBuffReq(activityId, buffLv)
end

function VRSpaceController:onGetSelectBuff(msg)
	VRSpaceModel.instance:onGetSelectBuff(msg)
	GlobalDispatcher:dispatch(GlobalNotify.VR_SPACE_INFO_UPDATE)
end

function VRSpaceController:sendVConfirm(activityId, mode, stageId, confirm)
	VRSpaceAgent.instance:sendPM_VRSpaceConfirmVirtualResultReq(activityId, mode, stageId, confirm)
end

function VRSpaceController:onGetVConfirm(msg)
	VRSpaceModel.instance:onGetVConfirm(msg, self._willResetReality)

	self._willResetReality = false

	GlobalDispatcher:dispatch(GlobalNotify.VR_SPACE_INFO_UPDATE)
end

function VRSpaceController:sendResetInfo(activityId, mode)
	VRSpaceAgent.instance:sendPM_VRSpaceResetRealityReq(activityId, mode)
end

function VRSpaceController:onGetResetInfo(msg)
	VRSpaceModel.instance:onGetResetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.VR_SPACE_INFO_UPDATE)
end

function VRSpaceController:openRFmtView(activityId, mode, stageId)
	self._rFmtMoMap[activityId] = self._rFmtMoMap[activityId] or {}

	local fanTianFmtMo = self._rFmtMoMap[activityId][mode]

	if not fanTianFmtMo then
		fanTianFmtMo = VRSpaceRFmtMo.New()
		self._rFmtMoMap[activityId][mode] = fanTianFmtMo
	end

	fanTianFmtMo:initParams(activityId, mode, stageId)
	CustomFmtController.instance:showMissionView(fanTianFmtMo)
end

function VRSpaceController:sendStartRFight(activityId, mode, stageId, form_pb)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self.onBattleEndR, self))
	VRSpaceAgent.instance:sendPM_VRSpaceChallengeRealityReq(activityId, mode, stageId, form_pb)
end

function VRSpaceController:onGetRFightMsg(msg)
	self._temActivityId = msg.activityId
	self._temMode = msg.mode
	self._temStageId = msg.stageId
	self._isWin = msg.win
	self._resetReason = checknumber(msg.resetReason)
end

function VRSpaceController:onBattleEndR()
	BattleFacade.instance:registerResultHandler(nil, nil)

	if self._resetReason > 0 then
		local planCfg = VRSpaceConfig.instance:getPlanCfgById(self._temActivityId, self._temMode, 1) or {}
		local stagePlanId = checknumber(planCfg.stagePlanId)
		local cfg = VRSpaceConfig.instance:getStageCfgById(stagePlanId, self._temStageId) or {}
		local virtualPassNum = checknumber(cfg.virtualPassNum)
		local content = langPara("下一关上阵虚影精灵数量要求为：%s只，当前虚影空间精灵已经不满足条件，现为您立即重置所有现实关卡进度，请重新挑战", virtualPassNum)

		TipsFacade.instance:openTipWindowNoX(lang("tip"), content, function()
			BattleController.instance:endBattle()
		end, nil, UnityEngine.TextAnchor.MiddleCenter)

		return true
	end
end

function VRSpaceController:openVFmtView(activityId, mode, stageId)
	self._vFmtMoMap[activityId] = self._vFmtMoMap[activityId] or {}

	local fanTianFmtMo = self._vFmtMoMap[activityId][mode]

	if not fanTianFmtMo then
		fanTianFmtMo = VRSpaceVFmtMo.New()
		self._vFmtMoMap[activityId][mode] = fanTianFmtMo
	end

	fanTianFmtMo:initParams(activityId, mode, stageId)
	CustomFmtController.instance:showMissionView(fanTianFmtMo)
end

function VRSpaceController:sendStartVFight(activityId, mode, stageId, form_pb)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self.onBattleEndV, self))
	VRSpaceAgent.instance:sendPM_VRSpaceChallengeVirtualReq(activityId, mode, stageId, form_pb)
end

function VRSpaceController:onGetVFightMsg(msg)
	local activityId = msg.activityId
	local mode = msg.mode
	local stageId = msg.stageId
	local dieRaceIds = msg.dieRaceIds

	self._temActivityId = activityId
	self._temMode = mode
	self._temStageId = stageId
	self._isWin = msg.win
	self._willResetReality = msg.willResetReality

	local info = VRSpaceModel.instance:getInfo(activityId) or {}

	if not info.modeInfos then
		local modeInfos = {}
		local modeInfo

		for i, v in ipairs(modeInfos) do
			if v.mode == mode then
				modeInfo = v

				break
			end
		end

		self._lastVPetList = nil

		if modeInfo then
			for i, v in ipairs(modeInfo.virtualStageInfos or {}) do
				if stageId == v.stageId then
					self._lastVPetList = self._lastVPetList or {}

					for j, pp in ipairs(v.virtualPetIds or {}) do
						local petMo = MaterialMgr.getModel(MatType.Pet, pp.right)

						if petMo then
							table.insert(self._lastVPetList, petMo.name)
						end
					end
				end
			end
		end

		self._curVPetList = {}

		for i, v in ipairs(dieRaceIds or {}) do
			local name = MaterialMgr.getMaterialsName(MatType.Pet, v)

			table.insert(self._curVPetList, name)
		end
	end
end

function VRSpaceController:onBattleEndV()
	BattleFacade.instance:registerResultHandler(nil, nil)

	if self._isWin == false then
		return false
	end

	local cur = "无"

	if self._curVPetList and #self._curVPetList > 0 then
		cur = table.concat(self._curVPetList, "、")
	end

	local c1 = "没有"
	local c2 = "不会变化"

	if self._willResetReality then
		c1 = "已经"
		c2 = "将被清空"
	end

	local content = langPara("本次挑战产生虚影精灵:%s\n原本的虚影精灵为:%s\n虚影空间内的精灵%s发生变化\n保存本次结果，现实关卡所有通关状态%s\n请问是否保存本次挑战结果?", cur, (self._lastVPetList and #self._lastVPetList > 0 or nil) and table.concat(self._lastVPetList, "、"), c1, c2)

	TipsFacade.instance:openPopupWindow("挑战成功", (self._lastVPetList == nil or nil) and langPara("本次挑战产生虚影精灵:%s\n请问是否保存本次挑战结果?", cur), function()
		self:sendVConfirm(self._temActivityId, self._temMode, self._temStageId, true)
		BattleController.instance:endBattle()
	end, function()
		self:sendVConfirm(self._temActivityId, self._temMode, self._temStageId, false)
		BattleController.instance:endBattle()
	end, nil, nil, UnityEngine.TextAnchor.MiddleCenter)

	return true
end

VRSpaceController.instance = VRSpaceController.New()

return VRSpaceController
