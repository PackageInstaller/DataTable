-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mimengli/controller/MiMengLiController.lua

module("logic.extensions.mimengli.controller.MiMengLiController", package.seeall)

local MiMengLiController = class("MiMengLiController", BaseController)

function MiMengLiController:onInit()
	self:onReset()
end

function MiMengLiController:onReset()
	self._norFmtMo = MiMengLiNorFmtMo.New()
	self._bossFmtMo = MiMengLiBossFmtMo.New()
	self._tempChangeSetId = nil
end

function MiMengLiController:getActivityId()
	return 417001
end

function MiMengLiController:sendGetInfo(activityId)
	MiMengLiClgAgent.instance:sendPM_MiMengLiClgGetInfoReq(activityId)
end

function MiMengLiController:onGetInfo(msg)
	MiMengLiModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MiMengLi_Clg_Info_Update)
end

function MiMengLiController:sendSelectPets(activityId, petId_i32_Ary)
	MiMengLiClgAgent.instance:sendPM_MiMengLiClgSelectPetReq(activityId, petId_i32_Ary)
end

function MiMengLiController:onSelectPets(msg)
	MiMengLiModel.instance:onSelectPets(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MiMengLi_Clg_Info_Update)
	GlobalDispatcher:dispatch(GlobalNotify.MiMengLi_Clg_Pet_Select_OK)
end

function MiMengLiController:sendSelectTag(activityId, selectedTagType_i32_Ary)
	MiMengLiClgAgent.instance:sendPM_MiMengLiClgStageSelectTagReq(activityId, selectedTagType_i32_Ary)
end

function MiMengLiController:onSelectTag(msg)
	MiMengLiModel.instance:onSelectTag(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MiMengLi_Clg_Info_Update)
end

function MiMengLiController:sendConfirm(activityId, confirmNum, save)
	MiMengLiClgAgent.instance:sendPM_MiMengLiClgConfirmReq(activityId, confirmNum, save)
end

function MiMengLiController:onConfirm(msg)
	MiMengLiModel.instance:onConfirm(msg)

	self._tempChangeSetId = msg.changeSetId

	MaterialController.instance:saveChangeSetToTemp(self._tempChangeSetId)
	GlobalDispatcher:dispatch(GlobalNotify.MiMengLi_Clg_Info_Update)
end

function MiMengLiController:tryShowChangeSet()
	if self._tempChangeSetId then
		MaterialController.instance:showChangeSetInTemp(self._tempChangeSetId)

		self._tempChangeSetId = nil
	end
end

function MiMengLiController:sendResetChallenge(activityId)
	MiMengLiClgAgent.instance:sendPM_MiMengLiClgResetClgReq(activityId)
end

function MiMengLiController:onResetChallenge(msg)
	MiMengLiModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MiMengLi_Clg_Info_Update)
end

function MiMengLiController:sendBuyShopGoods(activityId, skip, goodsId, petId, fromTag2Tag_pb)
	MiMengLiClgAgent.instance:sendPM_MiMengLiClgBuyNUseShopGoodsReq(activityId, skip, goodsId, petId, fromTag2Tag_pb)
end

function MiMengLiController:onBuyShopGoods(msg)
	MiMengLiModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MiMengLi_Clg_Info_Update)
end

function MiMengLiController:openBossFmtView(activityId, stageId)
	self._bossFmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(self._bossFmtMo)
end

function MiMengLiController:sendStartBossFight(activityId, form_pb_Ary)
	MiMengLiClgAgent.instance:sendPM_MiMengLiClgStageBossFightReq(activityId, form_pb_Ary)
end

function MiMengLiController:handleBossFightRes(msg)
	local btlResultList = msg.btlResult

	BattleController.instance:viewUserFightMonsterBtlResultWithList(btlResultList)

	local win = msg.win

	if win then
		MiMengLiModel.instance:onGetInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.MiMengLi_Clg_Info_Update)
	end
end

function MiMengLiController:openNorFmtView(activityId, stageId)
	self._norFmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(self._norFmtMo)
end

function MiMengLiController:sendStartNorFight(activityId, form_pb)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onNorBattleEnd, self, activityId))
	MiMengLiClgAgent.instance:sendPM_MiMengLiClgStageNormalFightReq(activityId, form_pb)
end

function MiMengLiController:handleFightRes(msg)
	MiMengLiModel.instance:handleFightRes(msg)
end

function MiMengLiController:_onNorBattleEnd(activityId)
	BattleFacade.instance:registerResultHandler(nil, nil)

	local pb = MiMengLiModel.instance:getFightPb(activityId)

	if pb and pb.win then
		local info = MiMengLiModel.instance:getInfo(activityId) or {}

		UIStateManager.instance:push(ViewName.MimenglinorresultlView, pb)

		return true
	end

	return false
end

MiMengLiController.instance = MiMengLiController.New()

return MiMengLiController
