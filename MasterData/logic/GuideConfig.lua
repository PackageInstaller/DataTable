-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/config/GuideConfig.lua

module("logic.extensions.guide.config.GuideConfig", package.seeall)

local GuideConfig = class("GuideConfig", BaseConfig)

function GuideConfig:onInit()
	return
end

function GuideConfig:getNames()
	return {
		"guide"
	}
end

function GuideConfig:handleConfig(name, content)
	if name == "guide" then
		self._guide = content
	end
end

function GuideConfig:getGuideConfig()
	return self._guide
end

function GuideConfig:getGuide(branchId, id)
	if self._guide then
		return self._guide[branchId][id]
	end
end

function GuideConfig:getBranchStartGuideId(branchId)
	if self._guide then
		if not self._guide[branchId] then
			return GuideConst.INVALID_GUIDE_ID
		else
			local guides = self._guide[branchId]
			local isNextIds = {}

			for k, v in pairs(guides) do
				if v.isClose == 1 then
					-- block empty
				elseif v.nextId and v.nextId ~= GuideConst.INVALID_GUIDE_ID then
					isNextIds[v.nextId] = true
				end
			end

			for k, v in pairs(guides) do
				if v.isClose == 1 then
					-- block empty
				elseif not isNextIds[v.guideId] then
					return v.guideId
				end
			end
		end
	end

	return GuideConst.INVALID_GUIDE_ID
end

GuideConfig.instance = GuideConfig.New()

return GuideConfig
