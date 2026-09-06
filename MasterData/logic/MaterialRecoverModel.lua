-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialrecover/model/MaterialRecoverModel.lua

module("logic.extensions.materialrecover.model.MaterialRecoverModel", package.seeall)

local MaterialRecoverModel = class("MaterialRecoverModel", BaseModel)

function MaterialRecoverModel:onInit()
	self:onReset()
end

function MaterialRecoverModel:onReset()
	self._resRecoverInfos = nil
end

function MaterialRecoverModel:setAllRecoverInfos(infos)
	self._resRecoverInfos = {}

	local funcMap = {}

	for i = 1, #infos do
		local info = {}

		info.funType = infos[i].funType
		info.price = infos[i].price
		info.state = infos[i].state
		info.sumMp = self:_modifyPrize(infos[i].state, infos[i].sumMp)

		table.insert(self._resRecoverInfos, info)

		funcMap[info.funType] = true
	end

	local allDefines = MaterialRecoverConfig.instance:getAllRecoverDefines()

	for i = 1, #allDefines do
		if not funcMap[allDefines[i].id] then
			local info = {}

			info.funType = allDefines[i].id
			info.isEmpty = true

			table.insert(self._resRecoverInfos, info)
		end
	end
end

function MaterialRecoverModel:getAllRecoverInfos()
	return self._resRecoverInfos
end

function MaterialRecoverModel:onGainMaterialRecover(funType, state)
	if self._resRecoverInfos then
		for i = 1, #self._resRecoverInfos do
			if self._resRecoverInfos[i].funType == funType then
				self._resRecoverInfos[i].state = state
				self._resRecoverInfos[i].sumMp = self:_modifyPrize(state, self._resRecoverInfos[i].sumMp)

				return
			end
		end
	end
end

function MaterialRecoverModel:_modifyPrize(state, sumMp)
	local prize = sumMp or ""
	local awards = string.split(prize, "#")
	local percent = 0

	if state == 0 then
		percent = MaterialRecoverConfig.instance:getRecoverPerfectPercent()
	elseif state == 1 then
		percent = MaterialRecoverConfig.instance:getRecoverPerfectPercent() - MaterialRecoverConfig.instance:getRecoverNormalPercent()
	end

	local result = ""

	for i = 1, #awards do
		local data = awards[i]
		local arr = string.split(data, ":")
		local matType = checknumber(arr[1])
		local matId = checknumber(arr[2])
		local matNum = checknumber(arr[3])

		matNum = math.ceil(matNum * percent / 100)

		if i ~= 1 then
			result = result .. "#"
		end

		result = result .. matType .. ":" .. matId .. ":" .. matNum
	end

	return result
end

MaterialRecoverModel.instance = MaterialRecoverModel.New()

return MaterialRecoverModel
