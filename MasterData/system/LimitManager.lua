-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\LimitManager.lua

local ResLimit = require("ClientData/ResLimit")
local LimitManager = {}

GLDeclare("LimitManager", LimitManager)

function LimitManager.checkConditionOK(limitId)
	local config = ResLimit[limitId]

	if config == nil then
		return false
	end

	local limitType = config.parse_type

	if limitType == 1 then
		local artifactCnt = CurAvatar:getArtifactNumById(config.limit_param1)

		return artifactCnt >= config.limit_param2
	elseif limitType == 2 then
		return CurAvatar:isRelicsUpToLevel(config.limit_param1, config.limit_param2)
	elseif limitType == 6 or limitType == 7 or limitType == 8 or limitType == 10 then
		return BaseObject.checkHasObject(BaseObject.GetObject(config.limit_param1, 1))
	elseif limitType == 3 then
		return not BaseObject.checkHasObject(BaseObject.GetObject(config.limit_param1, 1))
	elseif limitType == 11 then
		local haveNum = CurAvatar:getItemNumById(config.limit_param1)

		return haveNum < config.limit_param2
	elseif limitType == 13 then
		local haveNum = CurAvatar:getItemNumById(config.limit_param1)

		if haveNum > 0 then
			return false
		end

		return not CurAvatar:hasGetSkinByHeroAndSkinId(config.limit_param2, config.limit_param3)
	end

	return true
end

return LimitManager
