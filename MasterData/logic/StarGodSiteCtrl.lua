-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargod/controller/StarGodSiteCtrl.lua

module("logic.extensions.stargod.controller.StarGodSiteCtrl", package.seeall)

local StarGodSiteCtrl = class("StarGodSiteCtrl", BaseController)

function StarGodSiteCtrl:onInit()
	return
end

function StarGodSiteCtrl:huntStarGod(id)
	StarGodAgent.instance:sendHuntUpStarGodReq(id, 8)
end

function StarGodSiteCtrl:pickStarGod()
	StarGodAgent.instance:sendPickUpAndFusionStarGodReq()
end

function StarGodSiteCtrl:oneKeyHunt()
	local oneKeyHuntNum = checknumber(StarGodConfig.instance:getOtherConfig("ONE_KEY_HUNT_HIGHEST_MESSENGER").value)

	if StarGodModel.instance:isMessengerActive(oneKeyHuntNum) then
		FloatWordMgr.instance:show(lang("stargod_godopen"))

		return
	end

	StarGodAgent.instance:sendOneKeyHuntUpStarGodReq(8)
end

function StarGodSiteCtrl:setAutoCombine(isAuto)
	StarGodAgent.instance:sendSetAutoCombineStarGodStateReq(isAuto)
end

StarGodSiteCtrl.instance = StarGodSiteCtrl.New()

return StarGodSiteCtrl
