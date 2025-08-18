-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataRandReplace.lua

local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResOpActivityRandReplaceDetail = require("ClientData/ResOpActivityRandReplaceDetail")
local ActivityDataRandReplace = Class("ActivityDataRandReplace", ActivityDataBase)

function ActivityDataRandReplace:ctor()
	return
end

function ActivityDataRandReplace:updateClientData(actId)
	self.actId = actId
	self.clientData = ResOpActivityRandReplaceDetail[actId] or {}
end

function ActivityDataRandReplace:updateRoleData(roleData)
	self.randReplaceData = roleData.rand_replace.item
end

function ActivityDataRandReplace:getHeroId(groupId, index)
	if self.clientData[groupId] and self.clientData[groupId][index] then
		return self.clientData[groupId][index].show_hero_id
	end

	return 0
end

function ActivityDataRandReplace:getAllHeroIds(group)
	local newHeroIds = {}

	for index, v in ipairs(self.clientData[group] or {}) do
		table.insert(newHeroIds, {
			index = v.index,
			heroId = v.show_hero_id
		})
	end

	return newHeroIds
end

function ActivityDataRandReplace:getReplaceItems(groupId, index)
	if self.clientData[groupId] and self.clientData[groupId][index] then
		return self.clientData[groupId][index].replace_item
	end

	return {}
end

return ActivityDataRandReplace
