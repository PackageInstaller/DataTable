-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/niannianchall/view/NNCFastFormation.lua

module("logic.extensions.niannianchall.view.lightking.NNCFastFormation", package.seeall)

local NNCFastFormation = class("NNCFastFormation", FastSupportFormation)

function NNCFastFormation:_getCurFormation()
	return NianNianChallModel.instance:getFormation()
end

function NNCFastFormation:_getPets()
	return NianNianChallModel.instance:getAllPets()
end

function NNCFastFormation:_getSupportCfgs()
	local supportCfg = NianNianChallModel.instance:getSupportPetCfg()

	if supportCfg then
		return {
			supportCfg
		}
	else
		return {}
	end
end

NNCFastFormation.instance = NNCFastFormation.New()

return NNCFastFormation
