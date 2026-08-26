-- chunkname: @modules/logic/character/view/recommed/CharacterRecommedHeroView.lua

module("modules.logic.character.view.recommed.CharacterRecommedHeroView", package.seeall)

local CharacterRecommedHeroView = class("CharacterRecommedHeroView", BaseView)

function CharacterRecommedHeroView:onInitView()
	self._gospine = gohelper.findChild(self.viewGO, "left/hero/#go_spine")
	self._gospineroot = gohelper.findChild(self.viewGO, "left/hero")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterRecommedHeroView:addEvents()
	self.addEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnCutHeroAnimCB, self._refreshHero, self)
	self.addEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnJumpView, self._onJumpView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenViewCallBack, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.ReOpenWhileOpen, self.onOpenViewCallBack, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseViewCallBack, self)
end

function CharacterRecommedHeroView:removeEvents()
	self.removeEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnCutHeroAnimCB, self._refreshHero, self)
	self.removeEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnJumpView, self._onJumpView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenViewCallBack, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.ReOpenWhileOpen, self.onOpenViewCallBack, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseViewCallBack, self)
end

function CharacterRecommedHeroView:_editableInitView()
	transformhelper.setLocalScale(self._gospine.transform, 1, 1, 1)
	recthelper.setAnchor(self._gospine.transform, -200, -1174)
end

function CharacterRecommedHeroView:onOpen()
	self._borrowSpine = false

	if self.viewParam.uiSpine then
		self._uiSpine = self.viewParam.uiSpine

		if self._uiSpine._go then
			self._spineGo = self._uiSpine._go.transform.parent
			self._rootParent = self._spineGo.transform.parent
			self._borrowSpine = true
		else
			self._uiSpine = nil
		end
	end

	self:_refreshHero(self.viewParam.heroId)
end

function CharacterRecommedHeroView:onUpdateParam()
	self:_refreshHero(self.viewParam.heroId)
end

function CharacterRecommedHeroView:_showSpine(isShow)
	if self._borrowSpine then
		if not self._spineGo then
			return
		end

		local x, y

		if isShow then
			gohelper.addChildPosStay(self._gospineroot, self._spineGo)
			self._uiSpine:setModelVisible(true)
			gohelper.setActive(self._spineGo, true)

			y = 0
			x = -69

			if not self._uiSpine._curModel._curBodyName then
				self._uiSpine:playSpecialMotion(self._uiSpine._curModel._curBodyName)
			end
		else
			if not self._rootParent then
				return
			end

			gohelper.addChildPosStay(self._rootParent, self._spineGo)

			y = -1174
			x = -69
		end

		recthelper.setAnchor(self._spineGo.transform, x, y)
		transformhelper.setLocalScale(self._spineGo.transform, 1, 1, 1)
	end

	gohelper.setActive(self._gospineroot, isShow)
end

function CharacterRecommedHeroView:onOpenViewCallBack(viewName)
	if viewName == ViewName.HeroGroupPresetEditView then
		gohelper.setActive(self._gospineroot, false)
	elseif viewName == ViewName.CharacterView then
		self:_showSpine(false)
		self:closeThis()
	end
end

function CharacterRecommedHeroView:onCloseViewCallBack(viewName)
	if viewName == ViewName.HeroGroupPresetEditView then
		gohelper.setActive(self._gospineroot, true)
	end
end

function CharacterRecommedHeroView:_onJumpView(type)
	if type == CharacterRecommedEnum.JumpView.Rank then
		self:_showSpine(false)
	end
end

function CharacterRecommedHeroView:_refreshHero(heroId)
	if self._heroId == heroId then
		self:_showSpine(true)

		return
	end

	self._heroId = heroId
	self._heroRecommendMo = CharacterRecommedModel.instance:getHeroRecommendMo(heroId)
	self._heroSkinConfig = self._heroRecommendMo:getHeroSkinConfig()

	self:_updateHero()
	self:_setHeroTransform()
end

function CharacterRecommedHeroView:_setHeroTransform()
	local offsets = SkinConfig.instance:getSkinOffset(self._heroSkinConfig.characterViewOffset)
	local scale = tonumber(offsets[3])

	if self._spineGo then
		CharacterVoiceEnum.setSpineOffset(self._uiSpine, tonumber(offsets[1]), tonumber(offsets[2]))
		transformhelper.setLocalScale(self._uiSpine._go.transform, scale, scale, scale)
	else
		CharacterVoiceEnum.setSpineOffset(self._uiSpine, tonumber(offsets[1]) - 69, tonumber(offsets[2]))
		transformhelper.setLocalScale(self._gospine.transform, scale, scale, scale)
	end
end

function CharacterRecommedHeroView:_updateHero()
	self._isNeedDestory = false

	if self._uiSpine then
		self._uiSpine:onDestroy()
		self._uiSpine:stopVoice()

		local go = self._uiSpine._go

		self._uiSpine = nil
		self._uiSpine = GuiModelAgent.Create(go, true)
	else
		self._uiSpine = GuiModelAgent.Create(self._gospine, true)

		self._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.Normal, self.viewName)

		self._isNeedDestory = true
	end

	self:_loadSpine()
end

function CharacterRecommedHeroView:_loadSpine()
	self._uiSpine:setResPath(self._heroSkinConfig, self._onSpineLoaded, self)
end

function CharacterRecommedHeroView:_onSpineLoaded()
	self._spineLoaded = true

	self:_showSpine(true)
end

function CharacterRecommedHeroView:onClose(isClosing)
	if not isClosing then
		self:_showSpine(false)
	end
end

function CharacterRecommedHeroView:onDestroyView()
	if self._uiSpine and self._isNeedDestory then
		self._uiSpine:onDestroy()

		self._uiSpine = nil
	end
end

return CharacterRecommedHeroView
