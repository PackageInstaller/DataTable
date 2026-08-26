-- chunkname: @modules/logic/fight/fightcomponent/FightLoaderComponent.lua

module("modules.logic.fight.fightcomponent.FightLoaderComponent", package.seeall)

local FightLoaderComponent = class("FightLoaderComponent", FightBaseClass)

function FightLoaderComponent:loadAsset(url, callback, handle, param)
	local item = self:newClass(FightLoaderItem, url, callback, handle, param)

	item:startLoad()
end

function FightLoaderComponent:loadListAsset(urlList, oneCallback, finishCallback, handle, paramList)
	local item = self:newClass(FightLoaderList, urlList, oneCallback, finishCallback, handle, paramList)

	item:startLoad()
end

return FightLoaderComponent
