-- chunkname: @modules/logic/rouge2/common/model/Rouge2_LeaderInfoMO.lua

module("modules.logic.rouge2.common.model.Rouge2_LeaderInfoMO", package.seeall)

local Rouge2_LeaderInfoMO = pureTable("Rouge2_LeaderInfoMO")

function Rouge2_LeaderInfoMO:init(info)
	self.mainCareerId = info.mainCareerId
	self.careerId = info.careerId
	self.revivalCoin = info.revivalCoin
	self.equipActiveSkill = info.equipActiveSkill
	self.equipActiveSkillMap = Rouge2_BuffHelper.listToMap(info.equipActiveSkill)
	self.isTransfer = self.mainCareerId ~= self.careerId
	self.careerCo = self.careerId ~= 0 and Rouge2_CareerConfig.instance:getCareerConfig(self.careerId)
	self.consumeAttrNum = info.consumeAttrNum or 0
	self.summonTalentPoint = info.summonTalentPoint
	self.summonTalentIdList = info.summonTalentId
	self.summonTalentIdMap = info.summonTalentId and Rouge2_BuffHelper.listToMap(info.summonTalentId)
	self.systemTeamId = info.systemTeamId or Rouge2_Enum.UnselectTeamSystemId

	self:initAttrDropIdList(info.attrDropStr)
end

function Rouge2_LeaderInfoMO:initAttrDropIdList(attrDropStr)
	self.attrDropIdMap = {}
	self.attrId2DropIdList = {}
	self.dropId2ItemList = {}
	self.itemId2DropIdMap = {}

	local attrDropList = GameUtil.splitString2(attrDropStr, true)

	if not attrDropList then
		return
	end

	for _, attrDropInfo in ipairs(attrDropList) do
		local dropId = attrDropInfo[1]
		local itemUid = attrDropInfo[2]

		self.dropId2ItemList[dropId] = self.dropId2ItemList[dropId] or {}

		table.insert(self.dropId2ItemList[dropId], itemUid)

		if not self.itemId2DropIdMap[itemUid] then
			self.itemId2DropIdMap[itemUid][dropId] = true
			self.itemId2DropIdMap[itemUid] = self.itemId2DropIdMap[itemUid]

			local dropCo = Rouge2_AttributeConfig.instance:getAttrDropConfig(dropId)

			if dropCo then
				if not dropCo.attr then
					local attrId = 0

					self.attrId2DropIdList[attrId] = self.attrId2DropIdList[attrId] or {}

					table.insert(self.attrId2DropIdList[attrId], dropId)

					self.attrDropIdMap[dropId] = true
				end
			end
		end
	end
end

function Rouge2_LeaderInfoMO:getMainCareerId()
	return self.mainCareerId
end

function Rouge2_LeaderInfoMO:getCareerId()
	return self.careerId
end

function Rouge2_LeaderInfoMO:getCareerConfig()
	return self.careerCo
end

function Rouge2_LeaderInfoMO:getRevivalCoin()
	return self.revivalCoin
end

function Rouge2_LeaderInfoMO:updateRevivalCoin(revivalCoin)
	self.revivalCoin = revivalCoin or 0
end

function Rouge2_LeaderInfoMO:getEquipActiveSkillMap()
	return self.equipActiveSkillMap
end

function Rouge2_LeaderInfoMO:getEquipActiveSkill(index)
	return (self.equipActiveSkill or nil) and (self.equipActiveSkill[index] or 0)
end

function Rouge2_LeaderInfoMO:isActiveSkillInUse(skillUid)
	return self.equipActiveSkillMap and self.equipActiveSkillMap[skillUid] ~= nil
end

function Rouge2_LeaderInfoMO:getConsumeAttrNum()
	return self.consumeAttrNum
end

function Rouge2_LeaderInfoMO:getTalentPoint()
	return self.summonTalentPoint or 0
end

function Rouge2_LeaderInfoMO:isTalentActive(talentId)
	return self.summonTalentIdMap and self.summonTalentIdMap[talentId] ~= nil
end

function Rouge2_LeaderInfoMO:getActiveTalentIds()
	return self.summonTalentIdList
end

function Rouge2_LeaderInfoMO:getSystemTeamId()
	return self.systemTeamId
end

function Rouge2_LeaderInfoMO:updateSystemTeamId(systemTeamId)
	self.systemTeamId = systemTeamId or Rouge2_Enum.UnselectTeamSystemId
end

function Rouge2_LeaderInfoMO:isGetAttrDrop(dropId)
	return self.attrDropIdMap and self.attrDropIdMap[dropId] == true
end

function Rouge2_LeaderInfoMO:getDropNum()
	return self.attrDropIdMap and tabletool.len(self.attrDropIdMap) or 0
end

function Rouge2_LeaderInfoMO:getAttrDropItemList(dropId)
	return self.dropId2ItemList and self.dropId2ItemList[dropId]
end

function Rouge2_LeaderInfoMO:getAttrDropIdList(attrId)
	return self.attrId2DropIdList and self.attrId2DropIdList[attrId]
end

function Rouge2_LeaderInfoMO:getItemDropIdMap(itemId)
	return self.itemId2DropIdMap and self.itemId2DropIdMap[itemId]
end

return Rouge2_LeaderInfoMO
