-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/companionmall/controller/CompanionMallController.lua

module("logic.extensions.companionmall.controller.CompanionMallController", package.seeall)

local CompanionMallController = class("CompanionMallController", BaseController)

function CompanionMallController:onInit()
	self:onReset()
end

function CompanionMallController:onReset()
	self.tabIdx = nil
	self.secTabIdx = nil
	self._activityId = 0
end

function CompanionMallController:getDefaultActId()
	return 492001
end

function CompanionMallController:getInTimeActId()
	return ActivityDefineController.instance:getActivityIdByType(492)
end

function CompanionMallController:getActId()
	return self._activityId
end

function CompanionMallController:setActId(activityId)
	self._activityId = activityId
end

function CompanionMallController:sendGetInfo(activityId)
	CompanionMallAgent.instance:sendPM_CompanionMallGetInfoReq(activityId)
end

function CompanionMallController:onGetInfo(msg)
	CompanionMallModel.instance:onGetInfo(msg)

	self._activityId = self:setActId(msg.activityId)

	self:updateRedpointInfo(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.COMPANION_MALL_GET_INFO)
	GlobalDispatcher:dispatch("onFirstGotoCompanionMallMainView")
end

function CompanionMallController:sendGainCompanion(activityId, companionId)
	CompanionMallAgent.instance:sendPM_CompanionMallGainCompanionReq(activityId, companionId)
end

function CompanionMallController:onGainCompanion(msg)
	CompanionMallModel.instance:onGainCompanion(msg)
	self:updateRedpointInfo(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.COMPANION_MALL_GAIN_OK)
end

function CompanionMallController:sendGetAddressInfo(activityId)
	CompanionMallAgent.instance:sendPM_CompanionMallGetAddressInfoReq(activityId)
end

function CompanionMallController:onGetAddressInfo(msg)
	CompanionMallModel.instance:onGetAddressInfo(msg)
	self:updateRedpointInfo(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.COMPANION_MALL_GET_INFO)
	GlobalDispatcher:dispatch(GlobalNotify.COMPANION_MALL_ADRESS_INFO)
end

function CompanionMallController:sendSubmitAddressInfo(activityId, addressId, recipientName, phoneNumber, address, province, city, district)
	local addressInfo_pb = CompanionMallExtension_pb.PM_CompanionMallAddressBook()

	addressInfo_pb.addressId = addressId
	addressInfo_pb.recipientName = recipientName
	addressInfo_pb.phoneNumber = phoneNumber .. ""
	addressInfo_pb.address = address
	addressInfo_pb.province = province
	addressInfo_pb.city = city
	addressInfo_pb.district = district
	self._temp_addressInfo_pb = addressInfo_pb

	CompanionMallAgent.instance:sendPM_CompanionMallSubmitOrModifyAddressReq(activityId, addressInfo_pb)
end

function CompanionMallController:onSubmitAddressInfo(msg)
	CompanionMallModel.instance:onSubmitAddressInfo(msg, self._temp_addressInfo_pb)
	self:updateRedpointInfo(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.COMPANION_MALL_GET_INFO)
	GlobalDispatcher:dispatch(GlobalNotify.PM_CompanionMallSubmitOrModifyAddressRes, msg.addressInfo.addressId)
end

function CompanionMallController:sendGetRankInfo(activityId, companionId)
	CompanionMallAgent.instance:sendPM_CompanionMallGetRankInfoReq(activityId, companionId)
end

function CompanionMallController:onGetRankInfo(msg)
	CompanionMallModel.instance:onGetRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.COMPANION_MALL_RANK_INFO)
end

function CompanionMallController:sendPM_CompanionMallDeleteAddressReq(activityId, addressId)
	CompanionMallAgent.instance:sendPM_CompanionMallDeleteAddressReq(activityId, addressId)
end

function CompanionMallController:handlePM_CompanionMallDeleteAddressRes(msg)
	CompanionMallModel.instance:handlePM_CompanionMallDeleteAddressRes(msg)
	self:updateRedpointInfo(self._activityId)
	GlobalDispatcher:dispatch(GlobalNotify.PM_CompanionMallDeleteAddressRes)
end

function CompanionMallController:sendPM_CompanionMallSelectAddressReq(activityId, companionId_i32_Ary, addressId)
	CompanionMallAgent.instance:sendPM_CompanionMallSelectAddressReq(activityId, companionId_i32_Ary, addressId)
end

function CompanionMallController:handlePM_CompanionMallSelectAddressRes(msg)
	CompanionMallModel.instance:handlePM_CompanionMallSelectAddressRes(msg)
	self:updateRedpointInfo(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.PM_CompanionMallSelectAddressRes)
end

function CompanionMallController:onCompanionMallPaySuc(msg)
	CompanionMallModel.instance:onCompanionMallPaySuc(msg)

	local activityId = msg.activityId

	self:sendGetInfo(activityId)
end

function CompanionMallController:updateRedpointInfo(activityId)
	local info = CompanionMallModel.instance:getInfo(activityId) or {}

	if not info.companionInfo then
		local companionInfoList = {}
		local hasAddressRedPointGroupMap = {}
		local hasGetRimRedPointGroupMap = {}

		for i, v in ipairs(companionInfoList) do
			local hasGainCompanion = v.hasGainCompanion
			local hasSubmitAddress = v.addressId ~= 0
			local hasFinishAll = v.hasBuyCompanion
			local hasAddressRedPoint = hasFinishAll and hasGainCompanion and not hasSubmitAddress
			local hasGetRimRedPoint = hasFinishAll and not hasGainCompanion
			local addRessRedPointName = string.format("%do%d", RedPointModel.ID_COMPANIONMALL_ADDRESS, v.companionId)
			local getRimRedPointName = string.format("%do%d", RedPointModel.ID_COMPANIONMALL_GET_RIM, v.companionId)

			RedPointController.instance:setRedPointInfo(addRessRedPointName, hasAddressRedPoint)
			RedPointController.instance:setRedPointInfo(getRimRedPointName, hasGetRimRedPoint)

			local itemCfg = CompanionMallConfig.instance:getItemCfgById(activityId, v.companionId)

			if itemCfg then
				local groupId = checknumber(itemCfg.packGroupId)

				if groupId > 0 then
					if hasAddressRedPoint then
						hasAddressRedPointGroupMap[groupId] = true
					end

					if hasGetRimRedPoint then
						hasGetRimRedPointGroupMap[groupId] = true
					end
				end
			end
		end

		local groupIdList = CompanionMallConfig.instance:getItemGroupIds(activityId)

		for _, groupId in ipairs(groupIdList) do
			local groupRedPointName = string.format("%do%d", RedPointModel.ID_COMPANIONMALL_ADDRESS_PACK, groupId)

			RedPointController.instance:setRedPointInfo(groupRedPointName, false)

			local getRimGroupRedPointName = string.format("%do%d", RedPointModel.ID_COMPANIONMALL_GET_RIM_PACK, groupId)

			RedPointController.instance:setRedPointInfo(getRimGroupRedPointName, false)
		end

		for groupId, value in pairs(hasAddressRedPointGroupMap) do
			if value == true then
				local groupRedPointName = string.format("%do%d", RedPointModel.ID_COMPANIONMALL_ADDRESS_PACK, groupId)

				RedPointController.instance:setRedPointInfo(groupRedPointName, true)

				local getRimGroupRedPointName = string.format("%do%d", RedPointModel.ID_COMPANIONMALL_GET_RIM_PACK, groupId)

				RedPointController.instance:setRedPointInfo(getRimGroupRedPointName, true)
			end
		end
	end
end

function CompanionMallController:getCurCanGainCompanionId(activityId)
	local itemCfgs = CompanionMallConfig.instance:getItemCfgs(activityId)
	local actInfo = CompanionMallModel.instance:getInfo(activityId) or {}

	if not actInfo.companionInfo then
		local companionInfoList = {}
		local hasComMap = {}
		local hasFinishMap = {}

		for i, v in ipairs(companionInfoList) do
			hasComMap[v.companionId] = checkbool(v.hasGainCompanion)
			hasFinishMap[v.companionId] = checkbool(v.hasBuyCompanion)

			if not checkbool(hasComMap[v.companionId]) and hasFinishMap[v.companionId] and not v.hasSubmitAddress then
				return v.companionId
			end
		end

		return 0
	end
end

function CompanionMallController:getCurCompanionId(activityId)
	local itemCfgs = CompanionMallConfig.instance:getItemCfgs(activityId)
	local actInfo = CompanionMallModel.instance:getInfo(activityId) or {}

	if not actInfo.companionInfo then
		local companionInfoList = {}
		local hasComMap = {}
		local hasFinishMap = {}
		local companionId = 1

		for i, v in ipairs(companionInfoList) do
			hasComMap[v.companionId] = checkbool(v.hasGainCompanion)
			hasFinishMap[v.companionId] = checkbool(v.hasBuyCompanion)

			local hasSubmitAddress = v.addressId ~= 0
			local canSaveAddress = checkbool(hasComMap[v.companionId]) and checkbool(hasFinishMap[v.companionId]) and not hasSubmitAddress

			if canSaveAddress then
				return v.companionId
			end
		end

		return companionId
	end
end

function CompanionMallController:getAddressIdByCompanionId(activityId, companionId)
	local info = CompanionMallModel.instance:getInfo(activityId)
	local companionInfoList = info.companionInfo

	for i, companionInfo in ipairs(companionInfoList) do
		if companionInfo.companionId == companionId then
			return companionInfo.addressId
		end
	end
end

CompanionMallController.instance = CompanionMallController.New()

return CompanionMallController
