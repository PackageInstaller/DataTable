-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/companionmall/model/CompanionMallModel.lua

module("logic.extensions.companionmall.model.CompanionMallModel", package.seeall)

local CompanionMallModel = class("CompanionMallModel", BaseModel)

function CompanionMallModel:onInit()
	self:onReset()
end

function CompanionMallModel:onReset()
	self._canOpenMainView = true
	self._canOpenAddressView = true
	self._msgPool = {}
	self._addressPool = {}
	self._addressBookPool = {}
	self._rankInfoPool = {}
	self._activityId = 0
end

function CompanionMallModel:getInfo(activityId)
	return self._msgPool[activityId]
end

function CompanionMallModel:getAddressInfo(activityId)
	return self._addressPool[activityId]
end

function CompanionMallModel:getRankInfo(activityId)
	return self._rankInfoPool[activityId]
end

function CompanionMallModel:onGetInfo(msg)
	local pb = GameUtil.pbToTable(msg)
	local activityId = pb.activityId

	self._msgPool[activityId] = pb
end

function CompanionMallModel:onGainCompanion(msg)
	local pb = GameUtil.pbToTable(msg)
	local activityId = pb.activityId
	local companionId = pb.companionId
	local info = self._msgPool[activityId]

	if info and info.companionInfo then
		for i, v in ipairs(info.companionInfo) do
			if v.companionId == companionId then
				v.hasGainCompanion = true
				v.curGlobalGainCount = checknumber(v.curGlobalGainCount) + 1

				break
			end
		end
	end
end

function CompanionMallModel:onGetAddressInfo(msg)
	local pb = GameUtil.pbToTable(msg)

	self._addressPool[pb.activityId] = {}

	local curAddressInfoList = self._addressPool[pb.activityId]

	self._activityId = pb.activityId

	if pb.addressInfo then
		for i, info in ipairs(pb.addressInfo) do
			table.insert(curAddressInfoList, info)

			self._addressBookPool[info.addressId] = info
		end
	end
end

function CompanionMallModel:onGetRankInfo(msg)
	local pb = GameUtil.pbToTable(msg)

	self._rankInfoPool[pb.activityId] = pb
end

function CompanionMallModel:onCompanionMallPaySuc(msg)
	local pb = GameUtil.pbToTable(msg)
	local activityId = pb.activityId
	local companionId = pb.companionId
	local info = self._msgPool[activityId]

	if info and info.companionInfo then
		for i, v in ipairs(info.companionInfo) do
			if v.companionId == companionId then
				v.curGlobalGainCount = pb.curGlobalGainCount

				break
			end
		end
	end
end

function CompanionMallModel:onSubmitAddressInfo(msg, tempPb)
	local pb = GameUtil.pbToTable(msg.addressInfo)

	if tempPb.addressId == -1 then
		self._addressBookPool[pb.addressId] = pb

		local curAddressInfoList = self._addressPool[self._activityId]

		table.insert(curAddressInfoList, pb)
	else
		for k, addressBookInfo in pairs(self._addressBookPool) do
			if addressBookInfo.addressId == pb.addressId then
				self._addressBookPool[k] = pb

				break
			end
		end
	end
end

function CompanionMallModel:handlePM_CompanionMallDeleteAddressRes(msg)
	self._addressBookPool[msg.addressId] = nil

	local info = self._msgPool[self._activityId]

	if info then
		for i, companionInfo in ipairs(info.companionInfo) do
			if companionInfo.addressId == msg.addressId then
				companionInfo.addressId = 0
			end
		end
	end
end

function CompanionMallModel:handlePM_CompanionMallSelectAddressRes(msg)
	local info = self._msgPool[msg.activityId]

	if info then
		if not msg.companionId then
			local comPanionIdMap = {}

			for i, companionId in ipairs(msg.companionId) do
				comPanionIdMap[companionId] = true
			end

			for i, companionInfo in ipairs(info.companionInfo) do
				if comPanionIdMap[companionInfo.companionId] then
					companionInfo.addressId = msg.addressId
				end
			end
		end
	end
end

function CompanionMallModel:canOpenMainView()
	return self._canOpenMainView
end

function CompanionMallModel:hasOpenMainView()
	self._canOpenMainView = false
end

function CompanionMallModel:canOpenAddressView()
	return self._canOpenAddressView
end

function CompanionMallModel:hasOpenAddressView()
	self._canOpenAddressView = false
end

function CompanionMallModel:isUsingAddress(activityId, addressId)
	local info = self._msgPool[activityId]

	if info.companionInfo then
		for i, info in ipairs(info.companionInfo) do
			if info.addressId == addressId then
				return true
			end
		end
	end
end

function CompanionMallModel:getCurBatchCompanionIdList(activityId, companionId)
	local companionIdList = {}
	local info = self._msgPool[activityId]

	if info.companionInfo then
		local buyPackSerialId = 0

		for i, info in ipairs(info.companionInfo) do
			if info.companionId == companionId then
				buyPackSerialId = checknumber(info.buyPackSerialId)

				break
			end
		end

		if buyPackSerialId > 0 then
			for i, info in ipairs(info.companionInfo) do
				if checknumber(info.buyPackSerialId) == buyPackSerialId then
					table.insert(companionIdList, info.companionId)
				end
			end

			return companionIdList
		end
	end

	table.insert(companionIdList, companionId)

	return companionIdList
end

function CompanionMallModel:getAddressBookInfoById(addressId)
	return self._addressBookPool[addressId]
end

CompanionMallModel.instance = CompanionMallModel.New()

return CompanionMallModel
