-- chunkname: @modules/logic/mainuiswitch/view/MainUISwitchInfoHeroView.lua

module("modules.logic.mainuiswitch.view.MainUISwitchInfoHeroView", package.seeall)

local MainUISwitchInfoHeroView = class("MainUISwitchInfoHeroView", BaseView)

function MainUISwitchInfoHeroView:onInitView()
	self._gospinescaleroot = gohelper.findChild(self.viewGO, "root/#go_spine_scale")
	self._gospineroot = gohelper.findChild(self.viewGO, "root/#go_spine_scale/lightspine")
	self._gospine = gohelper.findChild(self.viewGO, "root/#go_spine_scale/lightspine/#go_lightspine")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainUISwitchInfoHeroView:addEvents()
	self.addEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.PreviewSwitchUIVisible, self._onSwitchUIVisible, self)
end

function MainUISwitchInfoHeroView:removeEvents()
	self.removeEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.PreviewSwitchUIVisible, self._onSwitchUIVisible, self)
end

function MainUISwitchInfoHeroView:_onSwitchUIVisible(visible)
	return
end

function MainUISwitchInfoHeroView:_editableInitView()
	transformhelper.setLocalScale(self._gospineroot.transform, 1, 1, 1)
	recthelper.setAnchor(self._gospineroot.transform, -120, -950)
end

function MainUISwitchInfoHeroView:onOpen()
	self._heroId, self._skinId = CharacterSwitchListModel.instance:getMainHero()
	self._heroSkinConfig = SkinConfig.instance:getSkinCo(self._skinId)

	self:_updateHero()

	local offsets = SkinConfig.instance:getSkinOffset(self._heroSkinConfig.characterViewOffset)
	local scale = tonumber(offsets[3]) * MainUISwitchEnum.MainHeroScale
	local x = tonumber(offsets[1]) * MainUISwitchEnum.MainHeroScale
	local y = tonumber(offsets[2]) * MainUISwitchEnum.MainHeroScale

	CharacterVoiceEnum.setSpineOffset(self._uiSpine, x, y)
	transformhelper.setLocalScale(self._gospine.transform, scale, scale, scale)

	local spineMountPoint = WeatherController.instance:getSceneNode("s01_obj_a/Anim/Drawing/spine")

	if spineMountPoint then
		gohelper.setActive(spineMountPoint, false)
	end
end

function MainUISwitchInfoHeroView:_updateHero()
	self._uiSpine = GuiModelAgent.Create(self._gospine, true)

	self._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.Normal, self.viewName)
	self:_loadSpine()
end

function MainUISwitchInfoHeroView:_loadSpine()
	self._uiSpine:setResPath(self._heroSkinConfig, self._onSpineLoaded, self)
end

function MainUISwitchInfoHeroView:_onSpineLoaded()
	self._spineLoaded = true
end

function MainUISwitchInfoHeroView:onDestroyView()
	if self._uiSpine then
		self._uiSpine:onDestroy()

		self._uiSpine = nil
	end
end

return MainUISwitchInfoHeroView
