-- chunkname: @modules/logic/sp01/odyssey/rpc/OdysseyRpc.lua

module("modules.logic.sp01.odyssey.rpc.OdysseyRpc", package.seeall)

local OdysseyRpc = class("OdysseyRpc", BaseRpc)

function OdysseyRpc:onInit()
	return
end

function OdysseyRpc:reInit()
	return
end

function OdysseyRpc:sendOdysseyGetInfoRequest(callback, callbackObj)
	local req = OdysseyModule_pb.OdysseyGetInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function OdysseyRpc:onReceiveOdysseyGetInfoReply(resultCode, msg)
	if resultCode == 0 then
		OdysseyModel.instance:onReceiveOdysseyGetInfoReply(msg.info)
	end
end

function OdysseyRpc:onReceiveOdysseyUpdateInfoPush(resultCode, msg)
	if resultCode == 0 then
		OdysseyModel.instance:onReceiveOdysseyGetInfoReply(msg.info, true)
	end
end

function OdysseyRpc:sendOdysseyMapSetCurrElementRequest(elementId)
	local req = OdysseyModule_pb.OdysseyMapSetCurrElementRequest()

	req.eleId = elementId

	return self:sendMsg(req)
end

function OdysseyRpc:onReceiveOdysseyMapSetCurrElementReply(resultCode, msg)
	if resultCode == 0 then
		OdysseyDungeonModel.instance:setCurInElementId(msg.eleId)
	end
end

function OdysseyRpc:sendOdysseyMapInteractRequest(elementId, optionParam)
	local req = OdysseyModule_pb.OdysseyMapInteractRequest()

	req.eleId = elementId

	if optionParam.optionId and optionParam.optionId > 0 then
		req.optionParam.optionId = optionParam.optionId
	end

	return self:sendMsg(req)
end

function OdysseyRpc:onReceiveOdysseyMapInteractReply(resultCode, msg)
	if resultCode == 0 then
		local finishElementId = msg.element.id

		OdysseyDungeonModel.instance:updateElementInfo(msg.element)
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnElementFinish, finishElementId)
	end
end

function OdysseyRpc:onReceiveOdysseyMapUpdateElementPush(resultCode, msg)
	if resultCode == 0 then
		OdysseyDungeonModel.instance:addNewElement(msg.updates)
		OdysseyDungeonModel.instance:setAllElementInfo(msg.updates)
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnUpdateElementPush, true)
		OdysseyController.instance:dispatchEvent(OdysseyEvent.OnRefreshReddot)
	end
end

function OdysseyRpc:onReceiveOdysseyUpdateLevelPush(resultCode, msg)
	if resultCode == 0 then
		OdysseyModel.instance:updateHeroLevel(msg)
		OdysseyController.instance:dispatchEvent(OdysseyEvent.RefreshHeroInfo)
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnRewardGet)
		OdysseyController.instance:dispatchEvent(OdysseyEvent.OnRefreshReddot)
	end
end

function OdysseyRpc:onReceiveOdysseyMapUpdatePush(resultCode, msg)
	if resultCode == 0 then
		OdysseyDungeonModel.instance:setMapInfo(msg.maps)
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnMapUpdate)
		OdysseyController.instance:dispatchEvent(OdysseyEvent.OnRefreshReddot)
	end
end

function OdysseyRpc:sendOdysseyFightMercenarySetDropRequest(type, suitId)
	local req = OdysseyModule_pb.OdysseyFightMercenarySetDropRequest()

	req.type = type
	req.suitId = suitId

	return self:sendMsg(req)
end

function OdysseyRpc:onReceiveOdysseyFightMercenarySetDropReply(resultCode, msg)
	if resultCode == 0 then
		OdysseyModel.instance:updateMercenaryTypeSuit(msg.type, msg.suitId)
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.RefreshMercenarySuit)
	end
end

function OdysseyRpc:sendOdysseyFightMercenaryRefreshRequest()
	local req = OdysseyModule_pb.OdysseyFightMercenaryRefreshRequest()

	return self:sendMsg(req)
end

function OdysseyRpc:onReceiveOdysseyFightMercenaryRefreshReply(resultCode, msg)
	if resultCode == 0 then
		OdysseyModel.instance:updateMercenaryNextRefreshTime(msg.nextRefTime)
	end
end

function OdysseyRpc:onReceiveOdysseyFightMercenaryUpdatePush(resultCode, msg)
	if resultCode == 0 then
		OdysseyModel.instance:setMercenaryInfo(msg.info)
	end
end

function OdysseyRpc:sendOdysseyBagUpdateItemNewFlagRequest(uidList)
	local req = OdysseyModule_pb.OdysseyBagUpdateItemNewFlagRequest()

	for index, uid in ipairs(uidList) do
		table.insert(req.uidList, uid)
	end

	return self:sendMsg(req)
end

function OdysseyRpc:onReceiveOdysseyBagUpdateItemNewFlagReply(resultCode, msg)
	if resultCode == 0 then
		OdysseyItemModel.instance:cleanHasClickItemState()
		OdysseyItemModel.instance:refreshItemInfo(msg.items)
		OdysseyController.instance:dispatchEvent(OdysseyEvent.OnRefreshReddot)
	end
end

function OdysseyRpc:onReceiveOdysseyBagGetItemPush(resultCode, msg)
	if resultCode == 0 then
		OdysseyItemModel.instance:updateItemInfo(msg.items, true)
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnRewardGet)
		OdysseyController.instance:dispatchEvent(OdysseyEvent.OnRefreshReddot)
	end
end

function OdysseyRpc:sendOdysseyTalentNodeLevelUpRequest(nodeId, callback, callbackObj)
	local req = OdysseyModule_pb.OdysseyTalentNodeLevelUpRequest()

	req.nodeId = nodeId

	return self:sendMsg(req, callback, callbackObj)
end

function OdysseyRpc:onReceiveOdysseyTalentNodeLevelUpReply(resultCode, msg)
	if resultCode == 0 then
		OdysseyTalentModel.instance:updateTalentNode(msg.node)
		OdysseyTalentModel.instance:buildTalentTypeNodeMap()
		OdysseyTalentModel.instance:setNodeChild()
		OdysseyController.instance:dispatchEvent(OdysseyEvent.RefreshTalent)
	end
end

function OdysseyRpc:sendOdysseyTalentNodeLevelDownRequest(nodeId)
	local req = OdysseyModule_pb.OdysseyTalentNodeLevelDownRequest()

	req.nodeId = nodeId

	return self:sendMsg(req)
end

function OdysseyRpc:onReceiveOdysseyTalentNodeLevelDownReply(resultCode, msg)
	if resultCode == 0 then
		OdysseyTalentModel.instance:updateTalentNode(msg.node)
		OdysseyTalentModel.instance:buildTalentTypeNodeMap()
		OdysseyTalentModel.instance:setNodeChild()
		OdysseyController.instance:dispatchEvent(OdysseyEvent.RefreshTalent)
	end
end

function OdysseyRpc:sendOdysseyTalentAllResetRequest()
	local req = OdysseyModule_pb.OdysseyTalentAllResetRequest()

	return self:sendMsg(req)
end

function OdysseyRpc:onReceiveOdysseyTalentAllResetReply(resultCode, msg)
	if resultCode == 0 then
		OdysseyTalentModel.instance:resetTalentData()
		OdysseyTalentModel.instance:updateTalentInfo(msg.info)
		OdysseyController.instance:dispatchEvent(OdysseyEvent.ResetTalent)
	end
end

function OdysseyRpc:onReceiveOdysseyTalentPointUpdatePush(resultCode, msg)
	if resultCode == 0 then
		OdysseyTalentModel.instance:setCurTalentPoint(msg.point, msg.reason)
		OdysseyController.instance:dispatchEvent(OdysseyEvent.RefreshTalent)
	end
end

function OdysseyRpc:sendOdysseyTalentCassandraTreeChoiceRequest(subId, level)
	local req = OdysseyModule_pb.OdysseyTalentCassandraTreeChoiceRequest()

	req.subId = subId
	req.level = level

	return self:sendMsg(req)
end

function OdysseyRpc:onReceiveOdysseyTalentCassandraTreeChoiceReply(resultCode, msg)
	OdysseyTalentModel.instance:setCassandraTreeInfoStr(msg.cassandraTree)
	OdysseyTalentModel.instance:setTrialCassandraTreeInfo()
	OdysseyController.instance:dispatchEvent(OdysseyEvent.TrialTalentTreeChange)
end

function OdysseyRpc:sendOdysseyTalentCassandraTreeCancelRequest(subId, level)
	local req = OdysseyModule_pb.OdysseyTalentCassandraTreeCancelRequest()

	req.subId = subId
	req.level = level

	return self:sendMsg(req)
end

function OdysseyRpc:onReceiveOdysseyTalentCassandraTreeCancelReply(resultCode, msg)
	OdysseyTalentModel.instance:setCassandraTreeInfoStr(msg.cassandraTree)
	OdysseyTalentModel.instance:setTrialCassandraTreeInfo()
	OdysseyController.instance:dispatchEvent(OdysseyEvent.TrialTalentTreeChange)
end

function OdysseyRpc:sendOdysseyTalentCassandraTreeResetRequest()
	local req = OdysseyModule_pb.OdysseyTalentCassandraTreeResetRequest()

	return self:sendMsg(req)
end

function OdysseyRpc:onReceiveOdysseyTalentCassandraTreeResetReply(resultCode, msg)
	OdysseyTalentModel.instance:setCassandraTreeInfoStr(msg.cassandraTree)
	OdysseyTalentModel.instance:setTrialCassandraTreeInfo()
	OdysseyController.instance:dispatchEvent(OdysseyEvent.TrialTalentTreeReset)
end

function OdysseyRpc:sendOdysseyFightReligionDiscloseRequest(religionId)
	local req = OdysseyModule_pb.OdysseyFightReligionDiscloseRequest()

	req.religionId = religionId

	return self:sendMsg(req)
end

function OdysseyRpc:onReceiveOdysseyFightReligionDiscloseReply(resultCode, msg)
	if resultCode == 0 then
		OdysseyModel.instance:setReligionInfo(msg.member)
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.RefreshReligionMembers)
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.CreateNewElement, true)
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.ShowExposeEffect, msg.member.religionId)
	end
end

function OdysseyRpc:onReceiveOdysseyFightReligionMemberUpdatePush(resultCode, msg)
	if resultCode == 0 then
		OdysseyModel.instance:setReligionInfo(msg.member)
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.RefreshReligionMembers)
	end
end

function OdysseyRpc:sendOdysseyHotfixRequest(params, callback, callbackObj)
	local req = OdysseyModule_pb.OdysseyHotfixRequest()

	req.params = params

	return self:sendMsg(req, callback, callbackObj)
end

function OdysseyRpc:onReceiveOdysseyHotfixReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function OdysseyRpc:onReceiveOdysseyHotfixPush(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function OdysseyRpc:sendOdysseyFormSaveRequest(form, callback, callbackObj)
	local req = OdysseyModule_pb.OdysseyFormSaveRequest()
	local requestForm = req.form

	requestForm.clothId = form.clothId

	for _, info in ipairs(form.heroes) do
		table.insert(requestForm.heroes, info)
	end

	requestForm.no = form.no

	for _, suitInfo in ipairs(form.suits) do
		table.insert(requestForm.suits, suitInfo)
	end

	self:sendMsg(req, callback, callbackObj)
end

function OdysseyRpc:onReceiveOdysseyFormSaveReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local form = msg.form

	OdysseyHeroGroupModel.instance:updateFormInfo(form)
end

function OdysseyRpc:sendOdysseyFormSwitchRequest(formNo, callback, callbackObj)
	local req = OdysseyModule_pb.OdysseyFormSwitchRequest()

	req.formNo = formNo

	self:sendMsg(req, callback, callbackObj)
end

function OdysseyRpc:onReceiveOdysseyFormSwitchReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local form = msg.form

	OdysseyHeroGroupModel.instance:updateFormInfo(form)
end

function OdysseyRpc:onReceiveOdysseyFightSettlePush(resultCode, msg)
	if resultCode == 0 then
		OdysseyModel.instance:setFightResultInfo(msg)
		AssassinController.instance:dispatchEvent(AssassinEvent.EnableLibraryToast, false)
	end
end

OdysseyRpc.instance = OdysseyRpc.New()

return OdysseyRpc
