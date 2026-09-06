-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/controller/FamilyHonorController.lua

module("logic.extensions.newfamily.controller.FamilyHonorController", package.seeall)

local FamilyHonorController = class("FamilyHonorController", BaseController)

function FamilyHonorController:ctor()
	self._sendTaskId = nil
	self._familyId = nil
	self._sokStr = nil
end

function FamilyHonorController:onInit()
	FamilyHonorController.super.onInit(self)
	self:onReset()
end

function FamilyHonorController:onReset()
	FamilyHonorController.super.onReset(self)

	self._sendTaskId = nil
	self._familyId = nil
	self._sokStr = nil
	self._isOpenChat = nil
end

function FamilyHonorController:_TickDailyRefreshData()
	if ViewMgr.instance:isOpen(ViewName.FamilyHonor) then
		-- block empty
	end
end

function FamilyHonorController:csRequestFamilyMedalGetMedalListReq()
	FamilyMedalAgent.instance:sendPM_FamilyMedalGetMedalListReq()
end

function FamilyHonorController:scPushFamilyMedalGetMedalList(msg)
	FamilyHonorModel.instance:scPushFamilyMedalGetMedalList(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataNewFamilyHonorInfo)
end

function FamilyHonorController:csRequestFamilyMedalSetMedalWallReq()
	local honorList = FamilyHonorModel.instance:getCacheHonorInfo()
	local isChange = false
	local req = FamilyMedalExtension_pb.PM_FamilyMedalSetMedalWallReq()
	local arr = {}

	for _, info in pairs(honorList or {}) do
		if info and info.defineId and checknumber(info.defineId) > 0 then
			isChange = true

			local medalList = req.medalList:add()

			medalList.defineId = info.defineId
			medalList.wallId = info.wallId

			if info.wallId > 0 then
				medalList.positionX = info.positionX
				medalList.positionY = info.positionY
			end

			table.insert(arr, medalList)
		end
	end

	if isChange == false then
		FloatWordMgr.instance:show("勋章墙编辑保存成功！")

		return
	end

	FamilyMedalAgent.instance:sendPM_FamilyMedalSetMedalWallReq(arr)
end

function FamilyHonorController:scPushFamilyMedalSetMedalWall(msg)
	FloatWordMgr.instance:show("勋章墙编辑保存成功！")
	self:csRequestFamilyMedalGetMedalListReq()
end

function FamilyHonorController:csRequestFamilyMedalViewRankReq()
	FamilyMedalAgent.instance:sendPM_FamilyMedalViewRankReq()
end

function FamilyHonorController:scPushFamilyMedalViewRank(msg)
	if msg == nil or msg.infoList == nil then
		return
	end

	GlobalDispatcher:dispatch(GlobalNotify.UpdataNewFamilyHonorRank, msg.myRank)
	RankModel.instance:setRankData(msg, GameEnum.RankType.FamilyTeamPlay, 5)
	GlobalDispatcher:dispatch(GlobalNotify.RankDataGet)
end

function FamilyHonorController:openFamilyMedalgetChatMedals(familyId, sokStr)
	if self._isOpenChat then
		FloatWordMgr.instance:show(lang("tip_try_again"))

		return
	end

	if familyId == nil or checknumber(familyId) <= 0 or string.nilorempty(sokStr) then
		return
	end

	self._familyId = nil
	self._sokStr = nil

	local info = FamilyHonorModel.instance:getFamilyMedalgetChatMedals(familyId, sokStr)

	self._isOpenChat = true

	if info == nil or info.medalList == nil then
		self:csRequestFamilyMedalgetChatMedalsReq(familyId, sokStr)

		return
	end

	self:_openFamilyHonorExhibitView(info, familyId)
end

function FamilyHonorController:csRequestFamilyMedalgetChatMedalsReq(familyId, sokStr)
	self._familyId = familyId
	self._sokStr = sokStr

	FamilyMedalAgent.instance:sendPM_FamilyMedalgetChatMedalsReq(familyId, sokStr)
end

function FamilyHonorController:scPushFamilyMedalgetChatMedals(msg)
	self._isOpenChat = false

	if msg == nil or msg.medalList == nil then
		return
	end

	FamilyHonorModel.instance:scPushFamilyMedalgetChatMedals(msg, self._familyId, self._sokStr)
	self:_openFamilyHonorExhibitView(msg, self._familyId)

	self._familyId = nil
	self._sokStr = nil
end

function FamilyHonorController:_openFamilyHonorExhibitView(info, familyId)
	self._isOpenChat = false

	if info == nil or info.medalList == nil or familyId == nil then
		return
	end

	local params = {}

	params.familyId = familyId
	params.familyName = info.familyName
	params.chiefName = info.chiefName
	params.honorList = info.medalList

	UIStateManager.instance:push(ViewName.FamilyHonorExhibit, params)
end

function FamilyHonorController:csRequestFamilyTaskInfoReq()
	FamilyTaskAgent.instance:sendPM_FamilyTaskInfoReq()
end

function FamilyHonorController:scPushFamilyTaskInfo(msg)
	FamilyHonorModel.instance:scPushFamilyTaskInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataNewFamilyTask, 0)
end

function FamilyHonorController:csRequestFamilyTaskGainPrizeReq(taskIds)
	FamilyTaskAgent.instance:sendPM_FamilyTaskGainPrizeReq(taskIds)
end

function FamilyHonorController:scPushFamilyTaskGainPrize(list)
	self:csRequestFamilyTaskInfoReq()
end

FamilyHonorController.instance = FamilyHonorController.New()

return FamilyHonorController
