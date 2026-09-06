-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/global/facade/GlobalFacade.lua

module("logic.extensions.global.facade.GlobalFacade", package.seeall)

local GlobalFacade = class("GlobalFacade", BaseFacade)

function GlobalFacade:enterCity(toSceneId, fromSceneId, bornX, bornY)
	if TaskFacade.instance:isTesting() then
		local function enterscenefunc()
			CityModel.instance.toSceneId = toSceneId
			CityModel.instance.fromSceneId = fromSceneId

			local posX = bornX
			local posY = bornY

			CityModel.instance.toScenePosX = nil
			CityModel.instance.toScenePosY = nil

			if not posX or not posY then
				posX, posY = SceneConfig.instance:getBornPoint(toSceneId, fromSceneId)
			end

			CityController.instance:onEnterCity(toSceneId, posX, posY)
			removetimer(enterscenefunc)
		end

		settimer(0.01, enterscenefunc)
	else
		SceneFacade.instance:enterCity(toSceneId, fromSceneId, bornX, bornY)
	end
end

function GlobalFacade:enterCityFromThisScene(toSceneId, fromSceneId)
	local scene = SceneMgr.instance:getCurScene()
	local fromSceneId = 0

	if scene then
		fromSceneId = scene:getSceneId()
	end

	CityModel.instance.toScenePosX = nil
	CityModel.instance.toScenePosY = nil

	self:enterCity(toSceneId, fromSceneId)
end

function GlobalFacade:onSceneUnLock(sceneId)
	GlobalController.instance:onSceneUnLock(sceneId)
end

GlobalFacade.instance = GlobalFacade.New()

return GlobalFacade
