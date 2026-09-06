-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/view/fmt/KingArenaShowMissionFmtView.lua

module("logic.extensions.kingarena.view.fmt.KingArenaShowMissionFmtView", package.seeall)

local KingArenaShowMissionFmtView = class("KingArenaShowMissionFmtView", MissionFmtView)

function KingArenaShowMissionFmtView:_getCreepCos()
	return {}
end

function KingArenaShowMissionFmtView:_getMonsterCo()
	return self:_getExtParams()
end

function KingArenaShowMissionFmtView:_createExtParams(formations)
	local extParams = self:_getExtParams()

	self:setExtParams(extParams)
end

function KingArenaShowMissionFmtView:_getExtParams()
	local formationMo = KingArenaModel.instance:getFormationMoOfView()
	local simpleForm = CustomFmtController.instance:createFormPb(formationMo)

	return simpleForm.extParams
end

function KingArenaShowMissionFmtView:getTeamAndFormation(creepCfg)
	local formationMo = KingArenaModel.instance:getFormationMoOfView()

	return formationMo:getTeamAndFormation()
end

function KingArenaShowMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
	self:_setHeroSkillEffect()
end

return KingArenaShowMissionFmtView
