-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/PetskinsourcejumpView.lua

module("logic.extensions.bonus.view.PetskinsourcejumpView", package.seeall)

local PetskinsourcejumpView = class("PetskinsourcejumpView", ViewComponent)

PetskinsourcejumpView.BtnCount = 5

function PetskinsourcejumpView:ctor()
	PetskinsourcejumpView.super.ctor(self)
end

function PetskinsourcejumpView:unbindEvents()
	PetskinsourcejumpView.super.unbindEvents(self)

	for i, v in ipairs(self._jumpBtns) do
		GameUtil.rmClickHandler(v)
	end
end

function PetskinsourcejumpView:bindEvents()
	PetskinsourcejumpView.super.bindEvents(self)

	for i, v in ipairs(self._jumpBtns) do
		GameUtil.addClickHandler(v, GameUtil.handler(self._onClickBtnJump, self, i))
	end
end

function PetskinsourcejumpView:buildUI()
	PetskinsourcejumpView.super.buildUI(self)

	self._jumpBtns = {}

	for i = 1, PetskinsourcejumpView.BtnCount do
		self._jumpBtns[i] = goutil.findChild(self.mainGO, "btnJump" .. i)
	end
end

function PetskinsourcejumpView:onExit()
	PetskinsourcejumpView.super.onExit(self)
end

function PetskinsourcejumpView:onEnter()
	PetskinsourcejumpView.super.onEnter(self)

	local skinStr = self:getFirstParam()

	self._skinIds = string.split(skinStr, "#")
end

function PetskinsourcejumpView:_onClickBtnJump(idx)
	if self._skinIds and self._skinIds[idx] then
		local skinId = checknumber(self._skinIds[idx])

		MaterialMgr.openGetSource(MatType.PET_SKIN, skinId)
	end
end

return PetskinsourcejumpView
