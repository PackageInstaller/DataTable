-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/warriortower/facade/WTowerFacade.lua

module("logic.extensions.warriortower.facade.WTowerFacade", package.seeall)

local WTowerFacade = class("WTowerFacade", BaseFacade)

WTowerFacade.isNeedShowGuide = false

function WTowerFacade:ctor()
	return
end

function WTowerFacade:setNeedShowGuide(isNeed)
	print("setNeedShowGuide")

	WTowerFacade.isNeedShowGuide = isNeed
end

function WTowerFacade:getNeedShowGuide()
	return WTowerFacade.isNeedShowGuide
end

function WTowerFacade:setExpPoolSelectPet(petId)
	self.petId = petId
end

function WTowerFacade:getExpPoolSelectPet()
	return checknumber(self.petId)
end

WTowerFacade.instance = WTowerFacade.New()

return WTowerFacade
