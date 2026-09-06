-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/model/ScenariocopyFastFormation.lua

module("logic.extensions.scenariocopy.model.ScenariocopyFastFormation", package.seeall)

local ScenariocopyFastFormation = class("ScenariocopyFastFormation", FastFormation)

function ScenariocopyFastFormation:_getCurFormId()
	return ScenariocopyModel.instance:getCurFormationId()
end

function ScenariocopyFastFormation:_getCurFormation()
	return ScenariocopyModel.instance:getFormation()
end

function ScenariocopyFastFormation:_changePosition(pos, value)
	self.position = self.position or {}
	self.position[pos] = value
end

function ScenariocopyFastFormation:_setPositionFinish()
	self:_getCurFormation():setPositionForce(self.position)
end

function ScenariocopyFastFormation:_getPets()
	return ScenariocopyModel.instance:getAllPets()
end

function ScenariocopyFastFormation:_getPet(id)
	return ScenariocopyModel.instance:getPet(id)
end

function ScenariocopyFastFormation:clean(fixedPosDic)
	ScenariocopyFastFormation.super.clean(self, fixedPosDic)
end

function ScenariocopyFastFormation:setPetAtFixedPos(posList, finalList)
	local supportCfgs = ScenariocopyModel.instance:getSupportCfgs()
	local idToPosMap = {}
	local notIncludePet = {}

	for k, v in pairs(supportCfgs) do
		if v.isFixedPos == true then
			idToPosMap[v.creepsId] = v.posId

			local mo = self:_getPet(v.creepsId)

			if table.indexof(finalList, mo) == false then
				table.insert(notIncludePet, mo)
			end
		end
	end

	if #notIncludePet > 0 then
		local count = 1

		for i = 1, 9 do
			if finalList[i] == nil then
				finalList[i] = notIncludePet[count]
				count = count + 1

				if count > #notIncludePet then
					break
				end
			end
		end
	end

	for i, v in pairs(finalList) do
		if idToPosMap[v.petId] ~= nil and posList[i] ~= idToPosMap[v.petId] then
			for j, pos in ipairs(posList) do
				if pos == idToPosMap[v.petId] then
					posList[i], posList[j] = posList[j], posList[i]

					break
				end
			end
		end
	end

	for i, v in ipairs(posList) do
		local pet = finalList[i]

		if pet then
			self:_changePosition(v, pet.petId)
		else
			self:_changePosition(v, 0)
		end
	end
end

ScenariocopyFastFormation.instance = ScenariocopyFastFormation.New()

return ScenariocopyFastFormation
