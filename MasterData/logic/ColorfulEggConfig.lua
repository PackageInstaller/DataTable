-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/colorfuleggs/config/ColorfulEggConfig.lua

module("logic.extensions.colorfuleggs.config.ColorfulEggConfig", package.seeall)

local ColorfulEggConfig = class("ColorfulEggConfig", BaseConfig)

function ColorfulEggConfig:getNames()
	return {
		"colorfuleggs"
	}
end

function ColorfulEggConfig:handleConfig(name, content)
	if name == "colorfuleggs" then
		self._colorfuleggs = content
		self._afterEgge = {}
		self._taskDepencies = {}

		for i = 1, #self._colorfuleggs.dataList do
			local data = self._colorfuleggs.dataList[i]

			if data.t_preEgg > 0 then
				self._afterEgge[data.t_preEgg] = self._afterEgge[data.t_preEgg] or {}

				local eggs = self._afterEgge[data.t_preEgg]

				table.insert(eggs, data.id)
			end

			if data.taskId > 0 then
				self._taskDepencies[data.taskId] = self._taskDepencies[data.taskId] or {}

				local eggs = self._taskDepencies[data.taskId]

				table.insert(eggs, data.id)
			end
		end
	end
end

function ColorfulEggConfig:getDataList()
	return self._colorfuleggs.dataList
end

function ColorfulEggConfig:getColorfulEggCo(id)
	return self._colorfuleggs[id]
end

function ColorfulEggConfig:getAfterColorfulEggs(id)
	return self._afterEgge[id]
end

function ColorfulEggConfig:getTaskDepencies(id)
	return self._taskDepencies[id]
end

ColorfulEggConfig.instance = ColorfulEggConfig.New()

return ColorfulEggConfig
