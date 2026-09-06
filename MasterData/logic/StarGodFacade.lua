-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargod/facade/StarGodFacade.lua

module(..., package.seeall)

local StarGodFacade = class("StarGodFacade", BaseFacade)

function StarGodFacade:enterStarGod()
	if not StarGodModel.instance:isDataInited() then
		StarGodAgent.instance:sendLoadStarGodReq()
	end
end

function StarGodFacade:getStarGod(id, info)
	StarGodModel.instance:getStarGod(id, info)
end

StarGodFacade.instance = StarGodFacade.New()

return StarGodFacade
