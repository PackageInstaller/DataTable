-- chunkname: @modules/logic/assist/model/RoleBadgeModel.lua

module("modules.logic.assist.model.RoleBadgeModel", package.seeall)

local RoleBadgeModel = class("RoleBadgeModel", BaseModel)

function RoleBadgeModel:onInit()
	self.badgeInfoMo = nil
	self.newTagCache = nil
	self.waitToastList = {}
end

function RoleBadgeModel:reInit()
	self:onInit()
end

function RoleBadgeModel:setBadgeInfo(info)
	self.badgeInfoMo = GameUtil.rpcInfoToMo(info, RoleBadgeInfoMo, self.badgeInfoMo)
end

function RoleBadgeModel:getBadgeInfo()
	return self.badgeInfoMo
end

function RoleBadgeModel:initLocalCache()
	local newTagCache = GameUtil.playerPrefsGetStringByUserId("RoleBadgeModelCache", "")

	self.newTagCache = string.nilorempty(newTagCache) and {} or cjson.decode(newTagCache)
end

function RoleBadgeModel:isRoleBadgeNew(heroUid, badgeIdList)
	if not self.newTagCache then
		self:initLocalCache()
	end

	local cacheBadgeIdList = self.newTagCache[heroUid]

	if cacheBadgeIdList then
		for _, id in ipairs(badgeIdList) do
			if not tabletool.indexOf(cacheBadgeIdList, id) then
				return true
			end
		end
	else
		return true
	end

	return false
end

function RoleBadgeModel:setRoleBadgeOld(heroUid, badgeIdList)
	if not self.newTagCache then
		self:initLocalCache()
	end

	local cacheBadgeIdList = self.newTagCache[heroUid]
	local addNew = false

	if cacheBadgeIdList then
		for _, id in ipairs(badgeIdList) do
			if not tabletool.indexOf(cacheBadgeIdList, id) then
				cacheBadgeIdList[#cacheBadgeIdList + 1] = id
				addNew = true
			end
		end
	else
		self.newTagCache[heroUid] = badgeIdList
		addNew = true
	end

	if addNew then
		GameUtil.playerPrefsSetStringByUserId("RoleBadgeModelCache", cjson.encode(self.newTagCache))
		AssistController.instance:dispatchEvent(AssistEvent.UpdateNewTag, heroUid)
	end
end

function RoleBadgeModel:addTostList(addList)
	tabletool.addValues(self.waitToastList, addList)
	AssistController.instance:checkToastTrigger()
end

function RoleBadgeModel:onToastFinished()
	tabletool.clear(self.waitToastList)
end

RoleBadgeModel.instance = RoleBadgeModel.New()

return RoleBadgeModel
