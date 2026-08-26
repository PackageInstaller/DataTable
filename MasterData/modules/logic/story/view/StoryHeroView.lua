-- chunkname: @modules/logic/story/view/StoryHeroView.lua

module("modules.logic.story.view.StoryHeroView", package.seeall)

local StoryHeroView = class("StoryHeroView", BaseView)

function StoryHeroView:onInitView()
	self._goroles = gohelper.findChild(self.viewGO, "#go_roles")
	self._rootImage = self.viewGO:GetComponent(gohelper.Type_Image)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoryHeroView:addEvents()
	return
end

function StoryHeroView:removeEvents()
	return
end

function StoryHeroView:_addEvent()
	self.addEventCb(self, StoryController.instance, StoryEvent.OnChangeHeroRoot, self._onChangeHeroRoot, self)
	self.addEventCb(self, StoryController.instance, StoryEvent.RefreshHero, self._onUpdateHero, self)
	self.addEventCb(self, StoryController.instance, StoryEvent.RefreshView, self._refreshView, self)
	self.addEventCb(self, StoryController.instance, StoryEvent.AllStepFinished, self._storyFinished, self)
	self.addEventCb(self, StoryController.instance, StoryEvent.Finish, self._clearItems, self)
end

function StoryHeroView:_removeEvent()
	self.removeEventCb(self, StoryController.instance, StoryEvent.OnChangeHeroRoot, self._onChangeHeroRoot, self)
	self.removeEventCb(self, StoryController.instance, StoryEvent.RefreshHero, self._onUpdateHero, self)
	self.removeEventCb(self, StoryController.instance, StoryEvent.RefreshView, self._refreshView, self)
	self.removeEventCb(self, StoryController.instance, StoryEvent.AllStepFinished, self._storyFinished, self)
	self.removeEventCb(self, StoryController.instance, StoryEvent.Finish, self._clearItems, self)
end

function StoryHeroView:_onChangeHeroRoot(rootGo)
	if not self._initPosX then
		self._initPosX, self._initPosY = transformhelper.getLocalPos(self._goroles.transform)
	end

	if not rootGo then
		self._goroles.transform:SetParent(self.viewGO.transform)
		transformhelper.setLocalScale(self._goroles.transform, 1, 1, 1)
		transformhelper.setLocalPosXY(self._goroles.transform, self._initPosX, self._initPosY, 0)

		return
	end

	self._goroles.transform:SetParent(rootGo.transform)
	transformhelper.setLocalScale(self._goroles.transform, 1, 1, 1)
	transformhelper.setLocalPosXY(self._goroles.transform, 0, 0, 0)
end

function StoryHeroView:_editableInitView()
	self._blitEff = StoryViewMgr.instance:getStoryBlitEff()
	self._heros = {}

	self:_loadRes()
end

local normalMatPath = "spine/spine_ui_default.mat"
local darkMatPath = "spine/spine_ui_dark.mat"
local screenSplitRolesPrefabPath = ResUrl.getStoryBgEffect("v3a6_stencil_roles")
local screenSplitLeftStencilRef = 10
local screenSplitRightStencilRef = 30
local screenSplitStencilComp = 3
local screenSplitStencilOp = 0
local screenSplitRoleCount = 2
local stencilPropName = "_Stencil"
local stencilCompPropName = "_StencilComp"
local stencilOpPropName = "_StencilOp"

function StoryHeroView:_loadRes()
	self._matLoader = MultiAbLoader.New()

	self._matLoader:addPath(normalMatPath)
	self._matLoader:addPath(darkMatPath)
	self._matLoader:addPath(screenSplitRolesPrefabPath)
	self._matLoader:startLoad(self._onResLoaded, self)
end

function StoryHeroView:_onResLoaded()
	local norMat = self._matLoader:getAssetItem(normalMatPath)

	if norMat then
		self._normalMat = UnityEngine.Material.Instantiate(norMat:GetResource(normalMatPath))
	else
		logError("Resource is not found at path : " .. normalMatPath)
	end

	local darkMat = self._matLoader:getAssetItem(darkMatPath)

	if darkMat then
		self._darkMat = UnityEngine.Material.Instantiate(darkMat:GetResource(darkMatPath))
	else
		logError("Resource is not found at path : " .. darkMatPath)
	end

	local screenSplitRolesPrefab = self._matLoader:getAssetItem(screenSplitRolesPrefabPath)

	if screenSplitRolesPrefab then
		self._screenSplitRolesPrefab = screenSplitRolesPrefab:GetResource(screenSplitRolesPrefabPath)
	else
		logError("Resource is not found at path : " .. screenSplitRolesPrefabPath)
	end

	self:_resetHeroMat()
end

function StoryHeroView:_resetHeroMat()
	if not self._heroCo then
		return
	end

	for k, v in pairs(self._heroCo) do
		if self:_isHeroDark(k) then
			if not self._darkMat then
				local mat = self._normalMat

				if self._heros[v.heroIndex] then
					local hasBottomEffect = StoryModel.instance:hasBottomEffect()

					self._heros[v.heroIndex]:setHeroMat(mat, hasBottomEffect)
				end
			end
		end
	end
end

function StoryHeroView:_isHeroDark(key)
	for _, v in pairs(self._stepCo.conversation.showList) do
		if v == key - 1 then
			return false
		end
	end

	return true
end

function StoryHeroView:onUpdateParam()
	return
end

function StoryHeroView:onOpen()
	self:_addEvent()
end

function StoryHeroView:onClose()
	self:_removeEvent()
end

function StoryHeroView:_onUpdateHero(param)
	if #param.branches > 0 then
		StoryController.instance:openStoryBranchView(param.branches)
	end

	if param.stepType ~= StoryEnum.StepType.Normal then
		for _, v in pairs(self._heros) do
			v:stopVoice()
		end

		return
	end

	self._stepCo = StoryStepModel.instance:getStepListById(param.stepId)

	if self._stepCo.bg.transType ~= StoryEnum.BgTransType.DarkFade and self._stepCo.bg.transType ~= StoryEnum.BgTransType.WhiteFade then
		self:_updateHeroList(self._stepCo.heroList)
	end

	local bgCo = self._stepCo.bg

	if bgCo.transType == StoryEnum.BgTransType.ScreenSplit and bgCo.effType == StoryEnum.BgEffectType.EnterSplitScreen then
		self._splitScreen = true
		self._rootImage.enabled = false

		self:_ensureScreenSplitRolesGo()
	elseif bgCo.transType == StoryEnum.BgTransType.ScreenSplitExit and bgCo.effType == StoryEnum.BgEffectType.ExitSplitScreen then
		self._splitScreen = false
		self._rootImage.enabled = true

		self:_resetScreenSplitRolesParent()
	end
end

function StoryHeroView:_refreshView()
	TaskDispatcher.cancelTask(self._playShowHero, self)
	self:_updateHeroList(self._stepCo.heroList)
end

function StoryHeroView:_storyFinished()
	if not StoryController.instance._hideStartAndEndDark then
		return
	end

	self:_updateHeroList({})
end

function StoryHeroView:_updateHeroList(param)
	local needFadeOut = false
	local needFadeIn = false
	local hasHeroLeave = false

	self._blitEff:SetKeepCapture(true)

	if self._heroCo then
		if #self._heroCo == 0 and #param == 0 then
			needFadeIn = false
			needFadeOut = false
		else
			local hasSame = false

			for _, v in pairs(param) do
				for _, hero in pairs(self._heroCo) do
					if hero.heroIndex == v.heroIndex then
						hasSame = true

						break
					end
				end
			end

			if hasSame then
				needFadeIn = false
				needFadeOut = false
			else
				needFadeIn = true
				needFadeOut = true
			end
		end
	else
		needFadeOut = false
		needFadeIn = true
		self._heroCo = {}
	end

	if self._preStepTransBg then
		self._preStepTransBg = false
		needFadeOut = true
		needFadeIn = true
	else
		local preStepIds = StoryModel.instance:getPreSteps(self._stepCo.id)

		if preStepIds and #preStepIds > 0 then
			local preStepMo = StoryStepModel.instance:getStepListById(preStepIds[1])
			local preStepBg = preStepMo and preStepMo.bg
			local bgCo = self._stepCo.bg

			if preStepBg and bgCo and (bgCo.offset[1] ~= preStepBg.offset[1] or bgCo.offset[2] ~= preStepBg.offset[2]) then
				self._preStepTransBg = true
			end
		end
	end

	for _, curV in pairs(self._heroCo) do
		local has = true

		for _, lastV in pairs(param) do
			if lastV.heroIndex == curV.heroIndex then
				has = false

				break
			end
		end

		if has then
			hasHeroLeave = true
		end
	end

	self._heroCo = param

	local del = {}

	for index, hero in pairs(self._heros) do
		local show = false

		for _, co in pairs(self._heroCo) do
			if co.heroIndex == index then
				show = true
			end
		end

		if not show then
			hero:hideHero()
			table.insert(del, index)
		end
	end

	for _, v in pairs(del) do
		self._heros[v] = nil
	end

	if needFadeOut then
		StoryModel.instance:enableClick(false)

		if hasHeroLeave then
			TaskDispatcher.runDelay(self._playShowHero, self, 1)
		else
			TaskDispatcher.runDelay(self._playShowHero, self, 0.5)
		end
	elseif hasHeroLeave then
		StoryModel.instance:enableClick(false)
		TaskDispatcher.runDelay(self._playShowHero, self, 0.5)
	else
		self:_playShowHero()
	end

	local bgCo = self._stepCo.bg

	if bgCo.transType == StoryEnum.BgTransType.ScreenSplit then
		self._splitScreen = true
		self._rootImage.enabled = false

		self:_setScreenSplitStencil()
		self:_setScreenSplitRolesParent()
	end

	if self._splitScreen and bgCo.transType ~= StoryEnum.BgTransType.ScreenSplit and bgCo.transType ~= StoryEnum.BgTransType.Keep then
		self._splitScreen = false
		self._rootImage.enabled = true

		self:_restoreScreenSplitStencil()
		self:_resetScreenSplitRolesParent()
	end

	StoryModel.instance:setNeedFadeIn(needFadeIn)
	StoryModel.instance:setNeedFadeOut(needFadeOut)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshConversation)
end

function StoryHeroView:_ensureScreenSplitRolesGo()
	if self._screenSplitRolesGo and not gohelper.isNil(self._screenSplitRolesGo) then
		gohelper.setActive(self._screenSplitRolesGo, true)

		return true
	end

	if not self._screenSplitRolesPrefab then
		return false
	end

	self._screenSplitRolesGo = gohelper.clone(self._screenSplitRolesPrefab, self._goroles)

	gohelper.setActive(self._screenSplitRolesGo, true)

	return true
end

function StoryHeroView:_resetScreenSplitRolesParent()
	if self._screenSplitRolesGo and not gohelper.isNil(self._screenSplitRolesGo) then
		gohelper.setActive(self._screenSplitRolesGo, false)
	end
end

function StoryHeroView:_setScreenSplitRolesParent()
	if not self._stepCo or not self._stepCo.bg then
		self:_resetScreenSplitRolesParent()

		return
	end

	if self._stepCo.bg.transType ~= StoryEnum.BgTransType.ScreenSplit then
		self:_resetScreenSplitRolesParent()

		return
	end

	if not self:_ensureScreenSplitRolesGo() then
		return
	end

	local movedHeroIndex = {}
	local movedCount = 0

	for _, heroCo in ipairs(self._heroCo or {}) do
		if movedCount >= screenSplitRoleCount then
			break
		end

		local heroItem = self._heros[heroCo.heroIndex]

		if heroItem and heroItem._heroSpineGo and not gohelper.isNil(heroItem._heroSpineGo) then
			movedHeroIndex[heroCo.heroIndex] = true
			movedCount = movedCount + 1

			self:_setHeroSpineParent(heroItem, self._screenSplitRolesGo)
		end
	end

	for heroIndex, heroItem in pairs(self._heros) do
		if not movedHeroIndex[heroIndex] then
			self:_setHeroSpineParent(heroItem, heroItem._heroGo)
		end
	end

	gohelper.setActive(self._screenSplitRolesGo, movedCount > 0)
end

function StoryHeroView:_recordScreenSplitStencil(material)
	if gohelper.isNil(material) then
		return
	end

	self._screenSplitStencilData = self._screenSplitStencilData or {}

	if self._screenSplitStencilData[material] then
		return
	end

	local data = {}

	if material:HasProperty(stencilPropName) then
		data.stencil = material:GetFloat(stencilPropName)
	end

	if material:HasProperty(stencilCompPropName) then
		data.stencilComp = material:GetFloat(stencilCompPropName)
	end

	if material:HasProperty(stencilOpPropName) then
		data.stencilOp = material:GetFloat(stencilOpPropName)
	end

	if next(data) then
		self._screenSplitStencilData[material] = data
	end
end

function StoryHeroView:_setScreenSplitStencilOnMaterial(material, stencilRef)
	if gohelper.isNil(material) then
		return
	end

	self:_recordScreenSplitStencil(material)

	if material:HasProperty(stencilPropName) then
		material:SetFloat(stencilPropName, stencilRef)
	end

	if material:HasProperty(stencilCompPropName) then
		material:SetFloat(stencilCompPropName, screenSplitStencilComp)
	end

	if material:HasProperty(stencilOpPropName) then
		material:SetFloat(stencilOpPropName, screenSplitStencilOp)
	end
end

function StoryHeroView:_restoreScreenSplitStencil()
	if not self._screenSplitStencilData then
		return
	end

	for material, data in pairs(self._screenSplitStencilData) do
		if not gohelper.isNil(material) then
			if data.stencil ~= nil and material:HasProperty(stencilPropName) then
				material:SetFloat(stencilPropName, data.stencil)
			end

			if data.stencilComp ~= nil and material:HasProperty(stencilCompPropName) then
				material:SetFloat(stencilCompPropName, data.stencilComp)
			end

			if data.stencilOp ~= nil and material:HasProperty(stencilOpPropName) then
				material:SetFloat(stencilOpPropName, data.stencilOp)
			end
		end
	end

	self._screenSplitStencilData = nil
end

function StoryHeroView:_setScreenSplitStencilOnHero(heroItem, isRight)
	if not heroItem then
		return
	end

	if isRight then
		if not screenSplitRightStencilRef then
			local stencilRef = screenSplitLeftStencilRef
			local heroSkeletonGraphic = heroItem._heroSkeletonGraphic

			if heroSkeletonGraphic and heroSkeletonGraphic.material then
				local material = heroSkeletonGraphic.material

				self:_setScreenSplitStencilOnMaterial(material, stencilRef)

				return
			end

			local heroSpineGo = heroItem._heroSpineGo

			if not heroSpineGo or gohelper.isNil(heroSpineGo) then
				return
			end

			local cubctrl = heroSpineGo:GetComponent(typeof(ZProj.CubismController))

			if cubctrl then
				for i = 0, cubctrl.InstancedMaterials.Length - 1 do
					local material = cubctrl.InstancedMaterials[i]

					self:_setScreenSplitStencilOnMaterial(material, stencilRef)
				end
			end
		end
	end
end

function StoryHeroView:_setScreenSplitStencil()
	if not self._stepCo or not self._stepCo.bg then
		return
	end

	if self._stepCo.bg.transType ~= StoryEnum.BgTransType.ScreenSplit then
		return
	end

	if not self._heroCo or #self._heroCo <= 0 then
		return
	end

	local firstHeroCo = self._heroCo[1]

	if not firstHeroCo then
		local firstHeroIndex

		for heroListIndex, heroCo in pairs(self._heroCo) do
			if type(heroListIndex) == "number" and (not firstHeroIndex or heroListIndex < firstHeroIndex) then
				firstHeroIndex = heroListIndex
				firstHeroCo = heroCo
			end
		end
	end

	if not firstHeroCo then
		return
	end

	local firstHero = self._heros[firstHeroCo.heroIndex]

	self:_setScreenSplitStencilOnHero(firstHero, false)

	local secondHeroCo = self._heroCo[2]

	if secondHeroCo then
		local secondHero = self._heros[secondHeroCo.heroIndex]

		self:_setScreenSplitStencilOnHero(secondHero, true)
	end
end

function StoryHeroView:_playShowHero()
	local hasNewHero = false

	if not self._stepCo.conversation.audios[1] then
		local conAudioId = 0

		for k, v in pairs(self._heroCo) do
			if self:_isHeroDark(k) then
				if not self._darkMat then
					local mat = self._normalMat
					local hasBottomEffect = StoryModel.instance:hasBottomEffect()

					if not self._heros[v.heroIndex] then
						hasNewHero = true

						local heroItem = StoryHeroItem.New()

						self._heros[v.heroIndex] = heroItem

						heroItem:init(self._goroles, v)
						heroItem:buildHero(v, mat, hasBottomEffect, self._onHeroBuildFinished, self, conAudioId)
					else
						self._heros[v.heroIndex]:resetHero(v, mat, hasBottomEffect, conAudioId)
					end
				end
			end
		end

		if not hasNewHero then
			local stepId = StoryModel.instance:getCurStepId()
			local stepCo = StoryStepModel.instance:getStepListById(stepId)

			if stepCo.conversation.type ~= StoryEnum.ConversationType.IrregularShake then
				StoryModel.instance:enableClick(true)
			end
		end

		StoryController.instance:dispatchEvent(StoryEvent.OnHeroShowed)
	end
end

function StoryHeroView:_onHeroBuildFinished()
	self:_onEnableClick()
end

function StoryHeroView:_onEnableClick()
	if StoryModel.instance:isTextShowing() then
		return
	end

	StoryModel.instance:enableClick(true)
end

function StoryHeroView:_clearItems()
	self:_restoreScreenSplitStencil()

	for _, v in pairs(self._heros) do
		v:onDestroy()
	end

	self._heros = {}
end

function StoryHeroView:onDestroyView()
	TaskDispatcher.cancelTask(self._playShowHero, self)
	ViewMgr.instance:closeView(ViewName.StoryView, true)
	ViewMgr.instance:closeView(ViewName.StoryLeadRoleSpineView, true)

	if self._screenSplitRolesGo and not gohelper.isNil(self._screenSplitRolesGo) then
		gohelper.destroy(self._screenSplitRolesGo)

		self._screenSplitRolesGo = nil
	end

	self:_clearItems()
	self._blitEff:SetKeepCapture(false)

	if self._matLoader then
		self._matLoader:dispose()

		self._matLoader = nil
	end
end

return StoryHeroView
