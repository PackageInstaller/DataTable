-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/PetskillsuccessView.lua

module("logic.extensions.bag.view.PetskillsuccessView", package.seeall)

local PetskillsuccessView = class("PetskillsuccessView", ViewComponent)

function PetskillsuccessView:ctor()
	PetskillsuccessView.super.ctor(self)
end

function PetskillsuccessView:buildUI()
	PetskillsuccessView.super.buildUI(self)

	self._txtSkillUp = self:getTxt("txtSkillUp")
	self._btnClose = self:getBtn("levelup")
end

function PetskillsuccessView:bindEvents()
	PetskillsuccessView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function PetskillsuccessView:unbindEvents()
	PetskillsuccessView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function PetskillsuccessView:destroyUI()
	PetskillsuccessView.super.destroyUI(self)
end

function PetskillsuccessView:onEnter()
	PetskillsuccessView.super.onEnter(self)

	self._params = self:getOpenParam()[1]

	self:_refresh()
end

function PetskillsuccessView:onEnterFinished()
	PetskillsuccessView.super.onEnterFinished(self)
end

function PetskillsuccessView:onExit()
	PetskillsuccessView.super.onExit(self)
end

function PetskillsuccessView:onExitFinished()
	PetskillsuccessView.super.onExitFinished(self)
end

function PetskillsuccessView:_refresh()
	self._txtSkillUp.text = langPara("技能【%s】成功升级到 <color=#20B376FF>%s级</color>", self._params.skillName, self._params.skillLevel)
end

return PetskillsuccessView
