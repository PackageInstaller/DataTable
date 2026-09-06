-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teachingdungeon/model/TeachingFastFormation.lua

module("logic.extensions.teachingdungeon.model.TeachingFastFormation", package.seeall)

local TeachingFastFormation = class("TeachingFastFormation", FastFormation)

function TeachingFastFormation:_getCurFormId()
	return TeachingDungeonModel.instance:getCurFormationId()
end

function TeachingFastFormation:_getCurFormation()
	return TeachingDungeonModel.instance:getFormation()
end

function TeachingFastFormation:_getPets()
	return TeachingDungeonModel.instance:getAllPets()
end

function TeachingFastFormation:_getPet(id)
	return TeachingDungeonModel.instance:getPet(id)
end

function TeachingFastFormation:getMyCurFormationList()
	return nil
end

TeachingFastFormation.instance = TeachingFastFormation.New()

return TeachingFastFormation
