-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/niannianchall/view/NNCFmtRightView.lua

module("logic.extensions.niannianchall.view.lightking.NNCFmtRightView", package.seeall)

local NNCFmtRightView = class("NNCFmtRightView", FormationRightView)

function NNCFmtRightView:_getCurFormation()
	return NianNianChallModel.instance:getFormation()
end

function NNCFmtRightView:updateForbit(data)
	local inTeam = self:getInTeam(data)
	local hasOneHire = self:getHasHireInTeam(data)
	local hasUp = false
	local canNotUp, hasOne = false, false
	local canNotUpWithYuan = self:getYuanLimit(data)
	local supportPetCfg = NianNianChallModel.instance:getSupportPetCfg()
	local isSupportPet = supportPetCfg.raceId == data.raceId

	data:setPetForbit(not inTeam and (hasUp or hasOneHire or canNotUp or hasOne or canNotUpWithYuan or isSupportPet))
end

return NNCFmtRightView
