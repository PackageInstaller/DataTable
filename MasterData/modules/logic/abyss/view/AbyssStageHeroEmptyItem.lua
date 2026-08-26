-- chunkname: @modules/logic/abyss/view/AbyssStageHeroEmptyItem.lua

module("modules.logic.abyss.view.AbyssStageHeroEmptyItem", package.seeall)

local AbyssStageHeroEmptyItem = class("AbyssStageHeroEmptyItem", LuaCompBase)

function AbyssStageHeroEmptyItem:init(go)
	self.viewGO = go
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")
	self._goadd = gohelper.findChild(self.viewGO, "#go_add")
	self._gohero = gohelper.findChild(self.viewGO, "#go_hero")
	self._simageheroicon = gohelper.findChildSingleImage(self.viewGO, "#go_hero/#simage_heroicon")
	self._imageheroicon = gohelper.findChildImage(self.viewGO, "#go_hero/#simage_heroicon")
	self._imagecareer = gohelper.findChildImage(self.viewGO, "#go_hero/#image_career")
	self.btn_modify = gohelper.findChildButton(self.viewGO, "")
	self._uiEffectComp = ZProj.UIEffectsCollection.Get(self.viewGO)

	self._uiEffectComp:SetGray(false)

	self._animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AbyssStageHeroEmptyItem:_editableInitView()
	self.lastUseState = AbyssEnum.HeroState.Empty
end

function AbyssStageHeroEmptyItem:addEventListeners()
	self.btn_modify:AddClickListener(self.onModifyClick, self)
	self.addEventCb(self, AbyssController.instance, AbyssEvent.OnAbyssRecommendHeroRemove, self._onRecommentHeroRemove, self)
end

function AbyssStageHeroEmptyItem:onModifyClick()
	local data = self.data

	if not data then
		return
	end

	if data.haveChallenge then
		GameFacade.showToast(ToastEnum.AbyssHeroGroupCannotEdit)

		return
	end

	AbyssController.instance:dispatchEvent(AbyssEvent.OnSelectStage, data.stageId, data.pos)
end

function AbyssStageHeroEmptyItem:removeEventListeners()
	self.btn_modify:RemoveClickListener()
	self.removeEventCb(self, AbyssController.instance, AbyssEvent.OnAbyssRecommendHeroRemove, self._onRecommentHeroRemove, self)
end

function AbyssStageHeroEmptyItem:_onRecommentHeroRemove(param)
	if param.pos == self.data.pos and param.stageId == self.data.stageId then
		self.recommendRemoveParam = param
	end
end

function AbyssStageHeroEmptyItem:setInfo(data)
	TaskDispatcher.cancelTask(self._onAnimPlayFinish, self)

	self.data = data

	local heroId

	if self.recommendRemoveParam then
		logNormal("AbyssStageHeroEmptyItem:setRecommendRemoveParam" .. "stageId: " .. data.stageId .. " pos: " .. data.pos .. " heroUid: " .. data.heroId)

		heroId = self.recommendRemoveParam.heroId
		self.recommendRemoveParam = nil

		self._animator:Play("death", 0, 0)
		gohelper.setActive(self._gohero, true)
		self:refreshUI(heroId)
		TaskDispatcher.runDelay(self._onAnimPlayFinish, self, 1)

		return
	else
		logNormal("AbyssStageHeroEmptyItem:setInfo" .. "stageId: " .. data.stageId .. " pos: " .. data.pos .. " heroUid: " .. data.heroId)

		heroId = data.heroId
	end

	local haveChallenge = data.haveChallenge
	local isLock = data.isLock

	if data.isUsed or isLock then
		if not AbyssEnum.HeroState.IsUsed then
			local state = AbyssEnum.HeroState.NoUsed
			local curStageId = AbyssModel.instance:getCurStageId()
			local needShowHideAnim = self.lastHeroId ~= nil and self.lastUseState ~= AbyssEnum.HeroState.Empty and (self.lastHeroId ~= data.heroId or self.lastUseState ~= state or self.lastHeroId == data.heroId and state == AbyssEnum.HeroState.IsUsed and curStageId == data.stageId)

			if not data.isUsed then
				local needHide = isLock
				local showHideAnim = needShowHideAnim and needHide
				local isEmpty = heroId == nil or heroId == AbyssEnum.HeroState.Empty

				gohelper.setActive(self._goempty, (isEmpty or needHide) and haveChallenge)
				gohelper.setActive(self._goadd, (isEmpty or needHide) and not haveChallenge)
				gohelper.setActive(self._gohero, not isEmpty and not needHide)

				if haveChallenge == false then
					logNormal("pos: " .. data.pos .. " heroId:" .. heroId .. " state: " .. state .. " needShowHideAnim: " .. tostring(needShowHideAnim) .. " showHideAnim: " .. tostring(showHideAnim) .. " isEmpty: " .. tostring(isEmpty) .. " needHide: " .. tostring(needHide))
				end

				if showHideAnim then
					self._animator:Play("death", 0, 0)
					gohelper.setActive(self._gohero, true)
					TaskDispatcher.runDelay(self._onAnimPlayFinish, self, 1)
				elseif self.lastHeroId == nil and heroId ~= 0 and not showHideAnim or self.lastHeroId ~= data.heroId and state == AbyssEnum.HeroState.NoUsed or self.lastHeroId == data.heroId and self.lastUseState == AbyssEnum.HeroState.IsUsed and state == AbyssEnum.HeroState.NoUsed then
					self._animator:Play("in", 0, 0)
				end

				self.lastHeroId = heroId
				self.lastUseState = state

				if isEmpty then
					return
				end

				self:refreshUI(heroId)
			end
		end
	end
end

function AbyssStageHeroEmptyItem:refreshUI(heroId)
	local careerId
	local heroMo = HeroModel.instance:getByHeroId(heroId)

	if heroMo then
		local skinConfig = SkinConfig.instance:getSkinCo(heroMo.skin)

		self._simageheroicon:LoadImage(ResUrl.getHeadIconSmall(skinConfig.headIcon))

		careerId = heroMo.config.career
	else
		local heroConfig = HeroConfig.instance:getHeroCO(heroId)

		self._simageheroicon:LoadImage(ResUrl.getHeadIconSmall(heroConfig.skinId))

		careerId = heroConfig.career
	end

	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. tostring(careerId), nil)
end

function AbyssStageHeroEmptyItem:_onAnimPlayFinish()
	TaskDispatcher.cancelTask(self._onAnimPlayFinish, self)

	local data = self.data
	local heroId = data.heroId
	local haveChallenge = data.haveChallenge
	local isLock = data.isLock

	if not data.isUsed then
		local needHide = isLock
		local isEmpty = heroId == nil or heroId == AbyssEnum.HeroState.Empty

		gohelper.setActive(self._goempty, (isEmpty or needHide) and haveChallenge)
		gohelper.setActive(self._goadd, (isEmpty or needHide) and not haveChallenge)
		gohelper.setActive(self._gohero, not isEmpty and not needHide)
		self._animator:Play("in", 0, 1)
	end
end

function AbyssStageHeroEmptyItem:onDestroy()
	TaskDispatcher.cancelTask(self._onAnimPlayFinish, self)
	self._simageheroicon:UnLoadImage()
end

return AbyssStageHeroEmptyItem
