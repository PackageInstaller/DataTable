-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetHexGuideView.lua

module("logic.extensions.cutepet.view.CutePetHexGuideView", package.seeall)

local CutePetHexGuideView = class("CutePetHexGuideView", ViewComponent)

function CutePetHexGuideView:ctor()
	CutePetHexGuideView.super.ctor(self)
end

function CutePetHexGuideView:unbindEvents()
	CutePetHexGuideView.super.unbindEvents(self)
end

function CutePetHexGuideView:bindEvents()
	CutePetHexGuideView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btn, self.onBtnClick, self)
end

function CutePetHexGuideView:buildUI()
	CutePetHexGuideView.super.buildUI(self)

	self._btn = self:getGo("btn_1")
end

function CutePetHexGuideView:onExit()
	CutePetHexGuideView.super.onExit(self)
	CutePetController.instance:releaseCamera()
end

function CutePetHexGuideView:onEnter()
	CutePetHexGuideView.super.onEnter(self)
	CutePetController.instance:fixCamera()

	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() == SceneType.CutePet then
		local unit = scene.unitFactory:getUnit(UnitTag.SceneElement, -(1000 + CutePetBuildingType.Guest))

		if unit then
			local pos = unit.hud:getInfoGoPos()

			GameUtil.setAnchoredPos(self._btn, pos.x, pos.y)
		end
	end
end

function CutePetHexGuideView:onBtnClick()
	self:close()
	CutePetController.instance:_onClickGuest()
end

return CutePetHexGuideView
