-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/loading/model/LoadingTipsAndPicsModel.lua

module(..., package.seeall)

local LoadingTipsAndPicsModel = class("LoadingTipsAndPicsModel", BaseModel)

function LoadingTipsAndPicsModel:onInit()
	return
end

function LoadingTipsAndPicsModel:onReset()
	return
end

function LoadingTipsAndPicsModel:getNextTipsCO()
	local tipsList = LoadingConfig.instance:getLoadingTipsList()

	return self:_randomFromList(tipsList)
end

function LoadingTipsAndPicsModel:getNextPicsIndex()
	local picsList = LoadingConfig.instance:getLoadingPicsList()

	return self:_randomFromList(picsList).id
end

function LoadingTipsAndPicsModel:_randomFromList(weightList)
	local totalWeight = 0

	for i = 1, #weightList do
		totalWeight = totalWeight + weightList[i].weight
	end

	local randomWeight = math.random(totalWeight)
	local countWeight = 0

	for i = 1, #weightList do
		countWeight = countWeight + weightList[i].weight

		if randomWeight <= countWeight then
			return weightList[i]
		end
	end
end

LoadingTipsAndPicsModel.instance = LoadingTipsAndPicsModel.New()

return LoadingTipsAndPicsModel
