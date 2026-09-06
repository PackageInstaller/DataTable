-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elfkingpath/controller/ElfKingPathController.lua

module("logic.extensions.elfkingpath.controller.ElfKingPathController", package.seeall)

local ElfKingPathController = class("ElfKingPathController", BaseController)

function ElfKingPathController:onInit()
	self:onReset()
end

function ElfKingPathController:onReset()
	self.ciList = nil
	self._fmtMo = nil
	self._curShowInHUD = true
	self._isCurStageFirstPass = false
	self._isCurStageAllPass = false

	GuideController.instance:setViewVar("elf_king_path", nil)
	GuideController.instance:setViewVar("elf_king_path_battle", nil)
end

function ElfKingPathController:getInfo()
	ElfKingPathAgent.instance:sendPM_ElfKingPathInfoReq()
end

function ElfKingPathController:handleGetInfo(msg)
	ElfKingPathModel.instance:handlePM_ElfKingPathInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ElfKingPathInfoRes)
end

function ElfKingPathController:startChallenge(form_pb, stageId, sonStageId)
	ElfKingPathAgent.instance:sendPM_ElfKingPahtClgReq(form_pb, stageId, sonStageId)
end

function ElfKingPathController:handleNotifyChallenge(msg)
	ElfKingPathModel.instance:handleNotifyChallenge(msg)

	local stageId = msg.stageId

	self._isCurStageAllPass = false

	if ElfKingPathModel.instance:isStagePassed(stageId) then
		self._isCurStageAllPass = true
	end

	self:saveCurEnterStageId(stageId)

	self._isCurStageFirstPass = false

	if msg.isWin then
		self.ciList = msg.changeSetId

		MaterialController.instance:saveChangeSetToTemp(self.ciList)

		if msg.changeSetId > 0 then
			self._isCurStageFirstPass = true
		end
	end
end

function ElfKingPathController:showCI()
	MaterialController.instance:showChangeSetInTemp(self.ciList)

	self.ciList = {}
end

function ElfKingPathController:showBossMissionView(stageId, sonStageId)
	self._fmtMo = self._fmtMo or ElfKingPathFmtMo.New()

	if self._fmtMo then
		self._fmtMo:initParams(stageId, sonStageId)
		CustomFmtController.instance:showMissionView(self._fmtMo)
	end
end

function ElfKingPathController:saveCurEnterStageId(stageId)
	self._curEnterStageId = stageId
end

function ElfKingPathController:getCurEnterStageId()
	return self._curEnterStageId
end

function ElfKingPathController:processGuideData(guideId, isReset)
	if not guideId or guideId <= 0 then
		return
	end

	local list = {}

	if isReset then
		table.insert(list, {
			cid = 1,
			bid = guideId
		})
		GuideModel.instance:updateSvrGuideData(guideId, 1, true)
	else
		table.insert(list, {
			cid = -1,
			bid = guideId
		})
		GuideModel.instance:updateSvrGuideData(guideId, -1)
	end

	GuideController.instance:sendToSave(list)

	if LoginModel.instance.userId then
		UnityEngine.PlayerPrefs.SetString("guideInfos_" .. LoginModel.instance.userId, "")
	end

	GuideModel.instance._currGuides = {}
	GuideModel.instance._branSequeces = {}

	GuideController.instance:loadGuideInit(GuideModel.instance.svrGuideList)
end

function ElfKingPathController:finishGuideData(inputGuideIds)
	local guideIds = {}

	for _, gid in pairs(inputGuideIds) do
		if checknumber(gid) > 0 then
			table.insert(guideIds, gid)
		end
	end

	if #guideIds <= 0 then
		return
	end

	local list = {}

	for _, guideId in pairs(guideIds) do
		table.insert(list, {
			cid = -1,
			bid = guideId
		})
		GuideModel.instance:updateSvrGuideData(guideId, -1)
	end

	GuideController.instance:sendToSave(list)
end

function ElfKingPathController:isCurStageFirstPass()
	return self._isCurStageFirstPass
end

function ElfKingPathController:isCurStageAllPass()
	return self._isCurStageAllPass
end

function ElfKingPathController:resetIsCurStageFirstPass()
	self._isCurStageFirstPass = false
end

function ElfKingPathController:resetIsCurStageAllPass()
	self._isCurStageAllPass = false
end

ElfKingPathController.instance = ElfKingPathController.New()

return ElfKingPathController
