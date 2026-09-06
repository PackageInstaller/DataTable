-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/model/ContractModel.lua

module("logic.extensions.contract.model.ContractModel", package.seeall)

local ContractModel = class("ContractModel", BaseModel)

function ContractModel:ctor()
	return
end

function ContractModel:onInit()
	self:onReset()
end

function ContractModel:onReset()
	self._contractInfoList = {}
	self._tempSkills = {}
	self._selfSelect = {}
end

function ContractModel:onGetPetAllContractInfoRes(msg)
	self._contractInfoList = GameUtil.pbToTable(msg.contractInfo) or {}
end

function ContractModel:getContractInfoMap()
	local map = {}

	if self._contractInfoList then
		for i, v in ipairs(self._contractInfoList) do
			map[v.contractGroupId] = v
		end
	end

	return map
end

function ContractModel:onMakeContractRes(msg)
	local tempInfo = msg.contractInfo

	for i, v in ipairs(self._contractInfoList) do
		if v.contractGroupId == tempInfo.contractGroupId then
			v.curContractSkillId = tempInfo.curContractSkillId
			v.tempContractSkillId = tempInfo.tempContractSkillId

			return
		end
	end

	local newContractInfo = GameUtil.pbToTable(tempInfo)

	table.insert(self._contractInfoList, newContractInfo)
end

function ContractModel:onCancelContractRes(msg)
	return
end

function ContractModel:onResetContractSkillRes(msg)
	return
end

function ContractModel:onConfirmContractSkillRes(msg)
	return
end

function ContractModel:onPetSingleContractInfo(msg)
	for i, v in ipairs(self._contractInfoList) do
		if v.contractGroupId == msg.contractGroupId then
			v.curContractSkillId = msg.curContractSkillId
			v.tempContractSkillId = msg.tempContractSkillId

			return
		end
	end

	local newContractInfo = GameUtil.pbToTable(msg)

	table.insert(self._contractInfoList, newContractInfo)
end

function ContractModel:getSingleContractInfo(contractGroupId)
	for i, v in ipairs(self._contractInfoList) do
		if v.contractGroupId == contractGroupId then
			return v
		end
	end
end

function ContractModel:getSkillIdByGroupId(contractGroupId)
	for i, v in ipairs(self._contractInfoList) do
		if v.contractGroupId == contractGroupId then
			return v.curContractSkillId
		end
	end

	return 0
end

function ContractModel:onGetNewContractSkillInfo(msg)
	self._tempSkills = GameUtil.pbToTable(msg.tempSkills) or {}
	self._selfSelect = GameUtil.pbToTable(msg.selfSelect) or {}
end

function ContractModel:getSelfSelectInfo(raceId)
	for i, v in ipairs(self._selfSelect) do
		if v.raceId == raceId then
			return v
		end
	end

	return nil
end

function ContractModel:onContractSkillSelfSelect(msg)
	local tb = GameUtil.pbToTable(msg) or {}

	if not tb.selfSelect then
		local newSelectInfo = {}

		self:addContractSkillSelfSelectCount(newSelectInfo)
	end
end

function ContractModel:addContractSkillSelfSelectCount(newSelectInfo)
	local isFind = false

	for i, v in ipairs(self._selfSelect) do
		if v.raceId == newSelectInfo.raceId then
			self._selfSelect[i] = newSelectInfo
			isFind = true

			break
		end
	end

	if not isFind then
		table.insert(self._selfSelect, newSelectInfo)
	end
end

function ContractModel:getNewTempSkill(petId)
	for i, v in ipairs(self._tempSkills) do
		if v.summonedPetId == petId then
			return v
		end
	end

	return nil
end

function ContractModel:onDelNewContractSkill(petId)
	for i, v in ipairs(self._tempSkills) do
		if v.summonedPetId == petId then
			table.remove(self._tempSkills, i)

			break
		end
	end
end

function ContractModel:addNewTempSkill(msg)
	local tb = GameUtil.pbToTable(msg) or {}

	if not tb.tempSkill then
		local newSkillInfo = {}
		local isFind = false

		for i, v in ipairs(self._tempSkills) do
			if v.summonedPetId == newSkillInfo.summonedPetId then
				v.tempContractSkillId = newSkillInfo.tempContractSkillId
				isFind = true

				break
			end
		end

		if not isFind then
			table.insert(self._tempSkills, newSkillInfo)
		end

		if not tb.selfSelect then
			local newSelectInfo = {}

			self:addContractSkillSelfSelectCount(newSelectInfo)
		end
	end
end

ContractModel.instance = ContractModel.New()

return ContractModel
