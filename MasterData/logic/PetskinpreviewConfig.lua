-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petskinpreview/config/PetskinpreviewConfig.lua

module("logic.extensions.petskinpreview.config.PetskinpreviewConfig", package.seeall)

local PetskinpreviewConfig = class("PetskinpreviewConfig", BaseConfig)

function PetskinpreviewConfig:onInit()
	return
end

function PetskinpreviewConfig:getNames()
	return {
		"pet_skin_tab1",
		"pet_skin_tab2"
	}
end

function PetskinpreviewConfig:handleConfig(name, content)
	if name == "pet_skin_tab1" then
		self._pet_skin_tab1 = content
	elseif name == "pet_skin_tab2" then
		self._pet_skin_tab2 = content
	end
end

function PetskinpreviewConfig:getBigTabSortList()
	if self._pet_skin_tab1_sort then
		return self._pet_skin_tab1_sort
	end

	self._pet_skin_tab1_sort = {}

	for i, v in ipairs(self._pet_skin_tab1.dataList or {}) do
		table.insert(self._pet_skin_tab1_sort, v)
	end

	table.sort(self._pet_skin_tab1_sort, function(a, b)
		return a.sortIndex < b.sortIndex
	end)

	return self._pet_skin_tab1_sort
end

function PetskinpreviewConfig:getSmallTabCfg(id)
	return self._pet_skin_tab2[id]
end

function PetskinpreviewConfig:getBigTabCfgBySmallTabIndex(smallTabIndex)
	local bigTabListCfgs = self._pet_skin_tab1.dataList

	for i1, v1 in ipairs(bigTabListCfgs) do
		if v1.childIndex and #v1.childIndex > 0 then
			for i2, smallIndex in ipairs(v1.childIndex) do
				if smallIndex == smallTabIndex then
					return v1
				end
			end
		end
	end

	return bigTabListCfgs[1]
end

PetskinpreviewConfig.instance = PetskinpreviewConfig.New()

return PetskinpreviewConfig
