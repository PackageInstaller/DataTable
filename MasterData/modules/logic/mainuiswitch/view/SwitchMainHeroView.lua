-- chunkname: @modules/logic/mainuiswitch/view/SwitchMainHeroView.lua

module("modules.logic.mainuiswitch.view.SwitchMainHeroView", package.seeall)

local SwitchMainHeroView = class("SwitchMainHeroView", BaseView)
local weatherController = WeatherController.instance

function SwitchMainHeroView:onInitView()
	self._golightspinecontrol = gohelper.findChild(self.viewGO, "#go_lightspinecontrol")
	self._gospinescale = gohelper.findChild(self.viewGO, "#go_spine_scale")
	self._golightspine = gohelper.findChild(self.viewGO, "#go_spine_scale/lightspine/#go_lightspine")
	self._txtanacn = gohelper.findChildText(self.viewGO, "bottom/#txt_ana_cn")
	self._txtanaen = gohelper.findChildText(self.viewGO, "bottom/#txt_ana_en")
	self._gocontentbg = gohelper.findChild(self.viewGO, "bottom/#go_contentbg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SwitchMainHeroView:onOpen()
	self:_showHero()
end

function SwitchMainHeroView:addEvents()
	self.addEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.SwitchUIVisible, self._onSwitchUIVisible, self)
	self.viewContainer:registerCallback(ViewEvent.ToSwitchTab, self._toSwitchTab, self)
end

function SwitchMainHeroView:removeEvents()
	self.removeEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.SwitchUIVisible, self._onSwitchUIVisible, self)
	self.viewContainer:unregisterCallback(ViewEvent.ToSwitchTab, self._toSwitchTab, self)
end

function SwitchMainHeroView:_toSwitchTab(tabContainerId, tabId)
	if tabContainerId == 1 then
		if self.viewContainer:getClassify() == MainSwitchClassifyEnum.Classify.UI then
			if tabId == MainEnum.SwitchType.Scene then
				self:onTabSwitchOpen()
			else
				self:onTabSwitchClose()
			end
		end
	elseif tabContainerId == 3 then
		if tabId == MainSwitchClassifyEnum.Classify.UI then
			self:onTabSwitchOpen()
		else
			self:onTabSwitchClose()
		end
	end
end

function SwitchMainHeroView:_editableInitView()
	self._lightspineparent = gohelper.findChild(self.viewGO, "#go_spine_scale/lightspine")

	gohelper.setActive(self._golightspinecontrol, false)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._cameraAnimator = CameraMgr.instance:getCameraRootAnimator()

	self:_initFrame()
end

function SwitchMainHeroView:_initFrame()
	self._frameBg = nil
	self._frameSpineNode = nil
	self._frameBg = weatherController:getSceneNode("s01_obj_a/Anim/Drawing/s01_xiangkuang_d_back")

	if not self._frameBg then
		logError("_initFrame no frameBg")
	end

	local spineMountPoint = weatherController:getSceneNode("s01_obj_a/Anim/Drawing/spine")

	if spineMountPoint then
		self._frameSpineNode = spineMountPoint.transform
	else
		logError("_initFrame no spineMountPoint")
	end

	gohelper.setActive(self._frameBg, false)

	self._frameSpineNodeX = 3.11
	self._frameSpineNodeY = 0.51
	self._frameSpineNodeZ = 3.09
	self._frameSpineNodeScale = 0.39

	local bgRenderer = self._frameBg:GetComponent(typeof(UnityEngine.Renderer))

	self._frameBgMaterial = UnityEngine.Material.Instantiate(bgRenderer.sharedMaterial)
	bgRenderer.material = self._frameBgMaterial
end

function SwitchMainHeroView:onTabSwitchOpen()
	self:_showHero()
end

function SwitchMainHeroView:_showHero()
	local heroId, skinId = CharacterSwitchListModel.instance:getMainHero()

	if not self._heroId or not self._skinId or heroId ~= self._heroId or skinId ~= self._skinId then
		self:_updateHero(heroId, skinId)

		return
	end

	self:_onLightSpineLoaded()
end

function SwitchMainHeroView:_updateHero(heroId, skinId)
	if gohelper.isNil(self._golightspine) then
		return
	end

	self._lightSpine = self._lightSpine or LightModelAgent.Create(self._golightspine, true)
	self._heroId, self._skinId = heroId, skinId

	local heroConfig = HeroConfig.instance:getHeroCO(heroId)
	local skinCo = SkinConfig.instance:getSkinCo(skinId or heroConfig and heroConfig.skin)

	self._heroPhotoFrameBg = heroConfig.photoFrameBg
	self._heroSkinConfig = skinCo

	self._lightSpine:setResPath(skinCo, self._onLightSpineLoaded, self)
end

function SwitchMainHeroView:_onLightSpineLoaded()
	self:_setLightSpine()
	self._lightSpine:play(StoryAnimName.B_IDLE, true)
end

function SwitchMainHeroView:_setLightSpine()
	self:_setOffset()
	gohelper.setActive(self._golightspine, true)
end

function SwitchMainHeroView:onTabSwitchClose(isClosing)
	gohelper.setActive(self._golightspine, false)
end

function SwitchMainHeroView:_setOffset(isFull)
	if gohelper.isNil(self._golightspine) then
		return
	end

	local offsetParam = SkinConfig.instance:getSkinOffset(self._heroSkinConfig.mainViewOffset)
	local transform = self._golightspine.transform
	local x = tonumber(offsetParam[1])
	local y = tonumber(offsetParam[2])
	local scale = tonumber(offsetParam[3])

	transformhelper.setLocalScale(transform, scale, scale, scale)
	recthelper.setAnchor(transform, isFull and x or x - 1, isFull and y or y + 2.5)
end

function SwitchMainHeroView:_onSwitchUIVisible(visible)
	self:_setOffset(not visible)
end

function SwitchMainHeroView:getLightSpineGo()
	return self._golightspine, self._lightspineparent
end

function SwitchMainHeroView:onClose()
	gohelper.setActive(self._golightspine, false)
end

return SwitchMainHeroView
