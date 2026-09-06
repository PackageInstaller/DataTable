-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetStarViewNew.lua

module("logic.extensions.bag.view.stack.PetStarViewNew", package.seeall)

local PetStarViewNew = class("PetStarViewNew", ViewComponent)

function PetStarViewNew:ctor()
	PetStarViewNew.super.ctor(self)
end

function PetStarViewNew:destroyUI()
	PetStarViewNew.super.destroyUI(self)
end

function PetStarViewNew:onExitFinished()
	PetStarViewNew.super.onExitFinished(self)
end

function PetStarViewNew:onEnterFinished()
	PetStarViewNew.super.onEnterFinished(self)
end

function PetStarViewNew:unbindEvents()
	PetStarViewNew.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function PetStarViewNew:bindEvents()
	PetStarViewNew.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function PetStarViewNew:onExit()
	PetStarViewNew.super.onExit(self)
end

function PetStarViewNew:buildUI()
	PetStarViewNew.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._stars = {}

	local stars = goutil.findChild(self.mainGO, "stars")

	for i = 1, CharacterConfig.MAX_STAR_COUNT do
		table.insert(self._stars, goutil.findChild(stars, i))
	end
end

function PetStarViewNew:onEnter()
	PetStarViewNew.super.onEnter(self)
end

function PetStarViewNew:_onClickClose()
	self:close()
end

return PetStarViewNew
