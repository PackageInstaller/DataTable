-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/model/FormationSetDefenseModel.lua

module("logic.extensions.formation.model.FormationSetDefenseModel", package.seeall)

local FormationSetDefenseModel = class("FormationSetDefenseModel", BaseModel)

function FormationSetDefenseModel:onInit()
	self:onReset()
end

function FormationSetDefenseModel:onReset()
	self:clear()
end

function FormationSetDefenseModel:checkModify(tabType)
	local oriPositionsList = self:getOriDefenseFmtPositions(tabType)

	if not oriPositionsList then
		return false
	end

	local positionsList = self:getDefenseFmtPositions(tabType)

	if not positionsList then
		return false
	end

	if #oriPositionsList ~= #positionsList then
		return true
	end

	for _, ori in ipairs(oriPositionsList) do
		for _, now in ipairs(positionsList) do
			if ori.index == now.index then
				if not ori.formationMo or not now.formationMo then
					return true
				end

				for pos = 1, 9 do
					if now.formationMo:GetPosition(pos) ~= ori.formationMo:GetPosition(pos) then
						return true
					end
				end

				break
			end
		end
	end

	return false
end

function FormationSetDefenseModel:setDefenseFmtPositions(tabType, positionsList)
	self._fmtPositionsList[tabType] = positionsList
end

function FormationSetDefenseModel:getDefenseFmtPositions(tabType)
	return self._fmtPositionsList[tabType]
end

function FormationSetDefenseModel:setOriDefenseFmtPositions(tabType, positionsList)
	self._oriPositionsList[tabType] = positionsList
end

function FormationSetDefenseModel:getOriDefenseFmtPositions(tabType)
	return self._oriPositionsList[tabType]
end

function FormationSetDefenseModel:setCurrIndex(tabType, index)
	self._curTabType = tabType
	self._curIndex = index
end

function FormationSetDefenseModel:getCurrIndex()
	return self._curTabType, self._curIndex
end

function FormationSetDefenseModel:clear()
	self._fmtPositionsList = {}
	self._oriPositionsList = {}
	self._curTabType = -1
	self._curIndex = -1
end

FormationSetDefenseModel.instance = FormationSetDefenseModel.New()

return FormationSetDefenseModel
