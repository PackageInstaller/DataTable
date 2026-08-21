-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/cell/CareerCell.lua

module("logic.extensions.charactersystem.view.cell.CareerCell", package.seeall)

local M = class("CareerCell")

function M:ctor(container)
	self._go = container.gameObject
	self._registry = ViewElementsRegistry.New(self._go)

	self:_buildUI()
end

function M:_buildUI()
	self._imgCareerDi = self._registry:getImage("career_-1600786498")
	self._imgCareerSign = self._registry:getImage("career_1390243743")
end

function M:setData(heroId)
	self._heroId = heroId

	self:_refreshUI()
end

function M:_refreshUI()
	local heroCO = CharacterConfig.instance:getCharacterItemInfo(self._heroId)

	IconLoader.setSprite(self._imgCareerDi, IconType.Skinlib, CommEnum.ColorType2Icon[heroCO.colorType])
	IconLoader.setSprite(self._imgCareerSign, IconType.Skinlib, CommEnum.Career2Icon[heroCO.career])
end

function M:destroyUI()
	IconLoader.clearSprite(self._imgCareerDi)
	IconLoader.clearSprite(self._imgCareerSign)
end

return M
