-- chunkname: @modules/logic/assist/model/rpcmo/RoleBadgeRecordMo.lua

module("modules.logic.assist.model.rpcmo.RoleBadgeRecordMo", package.seeall)

local RoleBadgeRecordMo = pureTable("RoleBadgeRecordMo")

function RoleBadgeRecordMo:init(data)
	self.heroUid = data.heroUid

	self:updateWears(data.wears)

	self.badges, self.badgesMap = GameUtil.rpcInfosToListAndMap(data.badges, RoleBadgeMo, "id", self.badgesMap)

	table.sort(self.badges, function(a, b)
		return a.config.sortId > b.config.sortId
	end)
end

function RoleBadgeRecordMo:updateBadge(data)
	if not self.heroUid then
		self.heroUid = data.heroUid
		self.badges = {}
		self.badgesMap = {}

		self:updateWears(data.wears)
	end

	local heroMo = HeroModel.instance:getById(self.heroUid)
	local toastList = {}
	local finish = AssistEnum.BadgeStatus.Finish

	for _, badge in ipairs(data.badges) do
		local badgeMo = self:getBadgeMo(badge.id)

		if not badgeMo then
			badgeMo = RoleBadgeMo.New()
			self.badgesMap[badge.id] = badgeMo
			self.badges[#self.badges + 1] = badgeMo
		end

		local oldStatus = badgeMo.status

		badgeMo:init(badge)

		if badgeMo.status == finish and oldStatus ~= finish then
			local groupCfg = RoleBadgeConfig.instance:getBadgeGroupCo(badgeMo.config.groupId)

			toastList[#toastList + 1] = {
				icon = badgeMo.config.icon,
				name = heroMo and heroMo.config.name,
				title = groupCfg and groupCfg.groupTitle
			}
		end
	end

	RoleBadgeModel.instance:addTostList(toastList)
end

function RoleBadgeRecordMo:updateWears(data)
	self.wears, self.wearsMap = GameUtil.rpcInfosToListAndMap(data, RoleBadgeWearMo, "position", self.wearsMap)
end

function RoleBadgeRecordMo:getBadgeMo(id)
	return self.badgesMap and self.badgesMap[id]
end

function RoleBadgeRecordMo:getWearMo(position)
	return self.wearsMap and self.wearsMap[position]
end

function RoleBadgeRecordMo:getWearPos(badgeId)
	for _, wearMo in ipairs(self.wears) do
		if wearMo.badgeId == badgeId then
			return wearMo.position
		end
	end
end

function RoleBadgeRecordMo:getWearCnt()
	local wearCount = 0

	for _, wearMo in ipairs(self.wears) do
		if wearMo.badgeId ~= 0 then
			wearCount = wearCount + 1
		end
	end

	return wearCount
end

function RoleBadgeRecordMo:getShowBadgeMo(groupId)
	for i = #self.badges, 1, -1 do
		local badgeMo = self.badges[i]
		local config = badgeMo.config

		if config.groupId == groupId then
			return badgeMo
		end
	end
end

function RoleBadgeRecordMo:getFirstEmptyWearPos()
	for i, wearMo in ipairs(self.wears) do
		if wearMo.badgeId == 0 then
			return i
		end
	end

	return #self.wears + 1
end

function RoleBadgeRecordMo:hasNewTag()
	local idList = {}

	for _, badgeMo in ipairs(self.badges) do
		if badgeMo.status == AssistEnum.BadgeStatus.Finish then
			idList[#idList + 1] = badgeMo.id
		end
	end

	if #idList == 0 then
		return false
	end

	return RoleBadgeModel.instance:isRoleBadgeNew(self.heroUid, idList)
end

function RoleBadgeRecordMo:clearNewTag()
	local idList = {}

	for _, badgeMo in ipairs(self.badges) do
		if badgeMo.status == AssistEnum.BadgeStatus.Finish then
			idList[#idList + 1] = badgeMo.id
		end
	end

	RoleBadgeModel.instance:setRoleBadgeOld(self.heroUid, idList)
end

return RoleBadgeRecordMo
