-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupregress/config/GroupRegressConfig.lua

module("logic.extensions.groupregress.config.GroupRegressConfig", package.seeall)

local GroupRegressConfig = class("GroupRegressConfig", BaseConfig)

function GroupRegressConfig:getNames()
	return {
		"group_regress_activity",
		"group_regress_group_prize"
	}
end

function GroupRegressConfig:handleConfig(name, content)
	if name == "group_regress_activity" then
		self._group_regress_activity = content
	elseif name == "group_regress_group_prize" then
		self._group_regress_group_prize = content
	end
end

function GroupRegressConfig:_safeGet(data, ...)
	local keys = {
		...
	}
	local current = data

	for i = 1, #keys do
		if current and type(current) == "table" then
			current = current[keys[i]]
		else
			current = nil

			break
		end
	end

	return current
end

function GroupRegressConfig:getActivityData(activityId)
	return self:_safeGet(self._group_regress_activity, activityId)
end

function GroupRegressConfig:getGroupPrizeDatas(activityId)
	return self:_safeGet(self._group_regress_group_prize, activityId)
end

function GroupRegressConfig:getGroupPrizeData(activityId, prizeId)
	return self:_safeGet(self._group_regress_group_prize, activityId, prizeId)
end

GroupRegressConfig.instance = GroupRegressConfig.New()

return GroupRegressConfig
