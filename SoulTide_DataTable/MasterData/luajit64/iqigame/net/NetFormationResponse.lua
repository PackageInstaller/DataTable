-- chunkname: @IQIGame\\Net\\NetFormationResponse.lua

function net_formation.notifyFomationUpdate(formation)
	PlayerModule.UpdateFormationTeam(formation)
end

function net_formation.exchangeSoulPrefabResult(code)
	FormationModule.ChooseSoulComplete()
end

function net_formation.changeFormationNameResult(code, name)
	FormationModule.OnChangeNameResponse(name)
end

function net_formation.copyFormationResult(code, fromId, copyToId)
	FormationModule.OnCopyFormation(fromId, copyToId)
end
