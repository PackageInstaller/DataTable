-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petverify/config/PetVerifyBuffConfig.lua

module("logic.extensions.petverify.config.PetVerifyBuffConfig", package.seeall)

local PetVerifyBuffConfig = class("PetVerifyBuffConfig", BaseConfig)

function PetVerifyBuffConfig:onInit()
	PetVerifyBuffConfig.super.onInit(self)

	self.verify_planCfg = nil
end

function PetVerifyBuffConfig:getNames()
	return {
		"verify_plan",
		"verify_buff"
	}
end

function PetVerifyBuffConfig:handleConfig(name, content)
	if name == "verify_plan" then
		self.verify_planCfg = content
	elseif name == "verify_buff" then
		self.verify_buffCfg = content

		self:sortList(self.verify_buffCfg)
	end
end

function PetVerifyBuffConfig:getPlanCfgById(id)
	return self.verify_planCfg[id] or {}
end

function PetVerifyBuffConfig:getBuffCfgById(id)
	return self.verify_buffCfg[id] or {}
end

function PetVerifyBuffConfig:getBuffListById(id)
	return self.buffMap[id] or {}
end

function PetVerifyBuffConfig:sortList(content)
	local map = {}

	for k, cfg in pairs(content) do
		if k ~= "dataList" then
			local list = {}

			for k, v in pairs(cfg) do
				table.insert(list, v)
			end

			table.sort(list, function(a, b)
				return a.target < b.target
			end)

			map[k] = list
		end
	end

	self.buffMap = map
end

PetVerifyBuffConfig.instance = PetVerifyBuffConfig.New()

return PetVerifyBuffConfig
