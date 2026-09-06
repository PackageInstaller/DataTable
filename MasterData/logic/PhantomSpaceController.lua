-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/phantomspace/controller/PhantomSpaceController.lua

module("logic.extensions.phantomspace.controller.PhantomSpaceController", package.seeall)

local PhantomSpaceController = class("PhantomSpaceController", BaseController)

PhantomSpaceController.clg_mode = {
	Nightmare = 1,
	Endless = 2,
	Normal = 0
}
PhantomSpaceController.endless_page_num = 20

function PhantomSpaceController:onInit()
	self:onReset()
end

function PhantomSpaceController:onReset()
	self._isShowAlert = false
	self._temStageKey = nil
	self._viewName = nil
	self._fmtMoMap = {}
	self._enemyFmtMoMap = {}
	self._endlessFmtMoMap = {}
	self._endlessFirstFmtMoMap = {}
end

function PhantomSpaceController:getDefaultActivityId()
	return 516001
end

function PhantomSpaceController:sendGetInfo(activityId)
	PhantomSpaceAgent.instance:sendPM_PhantomSpaceGetInfoReq(activityId)
end

function PhantomSpaceController:onGetInfo(msg)
	PhantomSpaceModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PHANTOM_SPACE_INFO_UPDATE)
end

function PhantomSpaceController:sendGetRankInfo(activityId, mode)
	PhantomSpaceAgent.instance:sendPM_PhantomSpaceGetRankInfoReq(activityId, mode)
end

function PhantomSpaceController:onGetRankInfo(msg)
	PhantomSpaceModel.instance:onGetRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PHANTOM_SPACE_INFO_UPDATE)
end

function PhantomSpaceController:sendResetInfo(activityId, mode, buffLv, stageId)
	local req = PhantomSpaceExtension_pb.PM_PhantomSpaceStageKey()

	req.activityId = activityId
	req.mode = mode

	if buffLv then
		req.buffLv = buffLv
	end

	req.stageId = stageId

	PhantomSpaceAgent.instance:sendPM_PhantomSpaceResetReq(req)
end

function PhantomSpaceController:onResetInfo(msg)
	PhantomSpaceModel.instance:onResetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PHANTOM_SPACE_INFO_UPDATE)
end

function PhantomSpaceController:sendFight(activityId, mode, buffLv, stageId, formPb)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self.onBattleEnd, self))

	local req = PhantomSpaceExtension_pb.PM_PhantomSpaceStageKey()

	req.activityId = activityId
	req.mode = mode

	if buffLv then
		req.buffLv = buffLv
	end

	req.stageId = stageId

	PhantomSpaceAgent.instance:sendPM_PhantomSpaceChallengeReq(req, formPb)
end

function PhantomSpaceController:onFight(msg)
	return
end

function PhantomSpaceController:onGetFighMsg(msg)
	PhantomSpaceModel.instance:onGetFighMsg(msg)

	self._isShowAlert = false

	if msg.win and self._viewName and msg.stageKey and not msg:HasField("phantomMonster") then
		local list = PhantomSpaceConfig.instance:getStageListCfgById(msg.stageKey.activityId, checknumber(msg.stageKey.mode)) or {}

		if msg.stageKey.stageId >= #list then
			if msg.stageKey.mode == 1 then
				self._isShowAlert = true
				self._temStageKey = GameUtil.pbToTable(msg.stageKey)
			else
				UIJumper.instance:removeTopState(self._viewName)
			end
		end
	end
end

function PhantomSpaceController:onBattleEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)

	if self._isShowAlert then
		local buffLv = checknumber(self._temStageKey.buffLv)
		local buffCfg = PhantomSpaceConfig.instance:getBuffCfgById(self._temStageKey.activityId, buffLv + 1)

		if buffCfg then
			local itemName = MaterialMgr.getMaterialsNameByCfg(buffCfg.buffPrize)
			local content = langPara("恭喜通关本难度所有关卡，\n现为您开启下一难度挑战【%s】\n挑战成功可获得%s,争夺竞技王排行！", buffCfg.desc, itemName)

			TipsFacade.instance:openTipWindowNoX(lang("tip"), content, function()
				BattleController.instance:endBattle()
			end)
		else
			return false
		end
	end

	return self._isShowAlert
end

function PhantomSpaceController:openNorFmtView(activityId, mode, buffLv, stageId, viewName)
	self._viewName = viewName

	local phantomNorFmtMo = self._fmtMoMap[activityId]

	if not phantomNorFmtMo then
		phantomNorFmtMo = PhantomSpaceNorFmtMo.New()
		self._fmtMoMap[activityId] = phantomNorFmtMo
	end

	phantomNorFmtMo:initParams(activityId, mode, buffLv, stageId)
	CustomFmtController.instance:showMissionView(phantomNorFmtMo)
end

function PhantomSpaceController:openEnemyFmtView(activityId, mode, buffLv, stageId, viewName)
	self._viewName = viewName

	local phantomNorFmtMo = self._enemyFmtMoMap[activityId]

	if not phantomNorFmtMo then
		phantomNorFmtMo = PhantomSpaceEnemyFmtMo.New()
		self._enemyFmtMoMap[activityId] = phantomNorFmtMo
	end

	phantomNorFmtMo:initParams(activityId, mode, buffLv, stageId)
	CustomFmtController.instance:showMissionView(phantomNorFmtMo)
end

function PhantomSpaceController:openEndlessFmtView(activityId, stageId, viewName)
	self._viewName = viewName

	local phantomFmtMo = self._endlessFmtMoMap[activityId]

	if not phantomFmtMo then
		phantomFmtMo = PhantomSpaceEndlessFmtMo.New()
		self._endlessFmtMoMap[activityId] = phantomFmtMo
	end

	phantomFmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(phantomFmtMo)
end

function PhantomSpaceController:openEndlessFirstFmtView(activityId, stageId, viewName)
	self._viewName = viewName

	local phantomFmtMo = self._endlessFirstFmtMoMap[activityId]

	if not phantomFmtMo then
		phantomFmtMo = PhantomSpaceEndlessFirstFmtMo.New()
		self._endlessFirstFmtMoMap[activityId] = phantomFmtMo
	end

	phantomFmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(phantomFmtMo)
end

function PhantomSpaceController:sendPM_PhantomSpaceGetEndlessInfoReq(activityId, pageStartStageId, pageSize)
	PhantomSpaceAgent.instance:sendPM_PhantomSpaceGetEndlessInfoReq(activityId, pageStartStageId, pageSize)
end

function PhantomSpaceController:handlePM_PhantomSpaceGetEndlessInfoRes(msg)
	PhantomSpaceModel.instance:handlePM_PhantomSpaceGetEndlessInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PhantomSpaceGetEndlessInfoRes)
end

function PhantomSpaceController:sendPM_PhantomSpaceChallengeEndlessReq(activityId, stageId, form)
	PhantomSpaceAgent.instance:sendPM_PhantomSpaceChallengeEndlessReq(activityId, stageId, form)
end

function PhantomSpaceController:handlePM_PhantomSpaceChallengeEndlessRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PhantomSpaceChallengeEndlessRes)
end

function PhantomSpaceController:sendPM_PhantomSpaceResetEndlessReq(activityId, stageId)
	PhantomSpaceAgent.instance:sendPM_PhantomSpaceResetEndlessReq(activityId, stageId)
end

function PhantomSpaceController:handlePM_PhantomSpaceResetEndlessRes(msg)
	PhantomSpaceModel.instance:handlePM_PhantomSpaceResetEndlessRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PhantomSpaceResetEndlessRes)
end

function PhantomSpaceController:handlePM_Notify_PhantomSpaceEndlessChallengeResult(msg)
	PhantomSpaceModel.instance:handlePM_Notify_PhantomSpaceEndlessChallengeResult(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_Notify_PhantomSpaceEndlessChallengeResult)
end

function PhantomSpaceController:getPageAndIndex(stageId)
	local pageNum = 1
	local index = stageId

	if stageId > PhantomSpaceController.endless_page_num - 1 then
		pageNum = math.ceil((stageId + 1) / PhantomSpaceController.endless_page_num)
		index = stageId - (pageNum - 1) * PhantomSpaceController.endless_page_num
	end

	return pageNum, index
end

function PhantomSpaceController:getEndlessStageCpreepsForm(activityId)
	local formData = {}
	local endlessStageCfg = PhantomSpaceConfig.instance:getStageCfgById(activityId, PhantomSpaceController.clg_mode.Endless, 1)
	local creepsMasterId = endlessStageCfg.creepsMasterId

	formData.isCfg = true
	formData.cfg = PhantomSpaceConfig.instance:getCreeps(creepsMasterId)
	formData.stageId = 0

	return formData
end

PhantomSpaceController.instance = PhantomSpaceController.New()

return PhantomSpaceController
