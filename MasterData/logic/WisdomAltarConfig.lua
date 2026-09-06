-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wisdomaltar/config/WisdomAltarConfig.lua

module("logic.extensions.wisdomaltar.config.WisdomAltarConfig", package.seeall)

local WisdomAltarConfig = class("WisdomAltarConfig", BaseConfig)

function WisdomAltarConfig:getNames()
	return {
		"wisdomaltar",
		"wisdomaltar_config"
	}
end

function WisdomAltarConfig:handleConfig(name, content)
	if name == "wisdomaltar" then
		self._wisdomaltar = content
	elseif name == "wisdomaltar_config" then
		self._wisdomaltarConfig = {}

		for i = 1, #content.dataList do
			local data = content.dataList[i]

			self._wisdomaltarConfig[data.type] = self._wisdomaltarConfig[data.type] or {}

			local datas = self._wisdomaltarConfig[data.type]

			table.insert(datas, data)
		end

		for k, v in pairs(self._wisdomaltarConfig) do
			table.sort(v, function(x, y)
				if x == y then
					return false
				end

				if x.rare > y.rare then
					return true
				end

				if x.rare < y.rare then
					return false
				end

				if x.awakeLevel > y.awakeLevel then
					return true
				end

				if x.awakeLevel < y.awakeLevel then
					return false
				end

				if x.id < y.id then
					return true
				end

				if x.id > y.id then
					return false
				end

				return false
			end)
		end
	end
end

function WisdomAltarConfig:getWisdomaltarCo(type)
	return self._wisdomaltar[type]
end

function WisdomAltarConfig:getWisdomaltarConfigs(type)
	return self._wisdomaltarConfig[type]
end

function WisdomAltarConfig:getWisdomaltarConfigCo(type, id)
	return self._wisdomaltarConfig[type][id]
end

WisdomAltarConfig.instance = WisdomAltarConfig.New()

return WisdomAltarConfig
