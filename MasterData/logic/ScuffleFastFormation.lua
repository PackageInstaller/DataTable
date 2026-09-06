-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/buzhen/ScuffleFastFormation.lua

module("logic.extensions.scuffle.view.buzhen.ScuffleFastFormation", package.seeall)

local ScuffleFastFormation = class("ScuffleFastFormation", FastFormation)

function ScuffleFastFormation:_getCurFormId()
	return ScuffleModel.instance:getCurFormationId()
end

function ScuffleFastFormation:_getPets()
	local pets = ScuffleModel.instance:getAllPets() or {}
end

function ScuffleFastFormation:_getPet(id)
	return ScuffleModel.instance:getPet(id)
end

function ScuffleFastFormation:_getCurFormation()
	return ScuffleModel.instance:getFormation()
end

return ScuffleFastFormation
