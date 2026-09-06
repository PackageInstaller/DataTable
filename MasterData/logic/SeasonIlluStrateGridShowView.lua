-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonIlluStrateGridShowView.lua

module("logic.extensions.season.view.SeasonIlluStrateGridShowView", package.seeall)

local SeasonIlluStrateGridShowView = class("SeasonIlluStrateGridShowView", SeasonBaseGridShowView)

function SeasonIlluStrateGridShowView:ctor()
	SeasonIlluStrateGridShowView.super.ctor(self)
end

function SeasonIlluStrateGridShowView:unbindEvents()
	SeasonIlluStrateGridShowView.super.unbindEvents(self)
end

function SeasonIlluStrateGridShowView:bindEvents()
	SeasonIlluStrateGridShowView.super.bindEvents(self)
end

function SeasonIlluStrateGridShowView:buildUI()
	SeasonIlluStrateGridShowView.super.buildUI(self)

	local icon = self:getGo("icon")

	self._iconChange = GameUtil.getUIImageSpriteChange(icon)
	self._iconImage = icon:GetComponent(goutil.Type_UIImage)
end

function SeasonIlluStrateGridShowView:onExit()
	SeasonIlluStrateGridShowView.super.onExit(self)
end

function SeasonIlluStrateGridShowView:onEnter()
	SeasonIlluStrateGridShowView.super.onEnter(self)
	self:_updateIcon()
end

function SeasonIlluStrateGridShowView:_updateIcon()
	local params = self:getFirstParam()
	local evtConfig = params.evtConfig
	local sprite = self:_getGridSprite(evtConfig)

	if sprite then
		self._iconImage.sprite = sprite
	else
		self._iconChange:SetState(evtConfig.eventType)
	end
end

function SeasonIlluStrateGridShowView:_getGridSprite(evtConfig)
	local scene = SceneMgr.instance:getCurScene()

	if not evtConfig or not scene or not scene.eventsData then
		return
	end

	local gridEvt = scene.eventsData:getEventUnit(evtConfig.x, evtConfig.y)

	if not gridEvt then
		return
	end

	return gridEvt:getIconSprite()
end

return SeasonIlluStrateGridShowView
