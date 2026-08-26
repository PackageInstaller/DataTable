-- chunkname: @modules/logic/character/view/CharacterDefaultDestinyView.lua

module("modules.logic.character.view.CharacterDefaultDestinyView", package.seeall)

local CharacterDefaultDestinyView = class("CharacterDefaultDestinyView", BaseView)

function CharacterDefaultDestinyView:onInitView()
	self._godestiny = gohelper.findChild(self.viewGO, "anim/layout/auxiliary/#go_destiny")
	self._gostone = gohelper.findChild(self.viewGO, "anim/layout/auxiliary/#go_destiny/#go_stone")
	self._txtdestiny = gohelper.findChildText(self.viewGO, "anim/layout/auxiliary/#go_destiny/#txt_destiny")
	self._imagestone = gohelper.findChildSingleImage(self.viewGO, "anim/layout/auxiliary/#go_destiny/#go_stone/#image_stone")
	self._btndestiny = gohelper.findChildButtonWithAudio(self.viewGO, "anim/layout/auxiliary/#go_destiny/#btn_destiny")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterDefaultDestinyView:addEvents()
	self._btndestiny:AddClickListener(self._btndestinyOnClick, self)
end

function CharacterDefaultDestinyView:removeEvents()
	self._btndestiny:RemoveClickListener()
end

function CharacterDefaultDestinyView:_btndestinyOnClick()
	if not self:_isOwnHero() then
		return
	end

	if not CharacterDestinyModel.instance:isOpenDestinySystem(true) then
		return
	end

	CharacterDestinyController.instance:openCharacterDestinySlotView(self.heroMo)

	if self:_isShowDestinyReddot() then
		HeroRpc.instance:setHeroRedDotReadRequest(self.heroMo.heroId, 2)
	end
end

function CharacterDefaultDestinyView:_editableInitView()
	self._gostonelock = gohelper.findChild(self.viewGO, "anim/layout/auxiliary/#go_destiny/#go_stone/#go_lock")
	self._gostoneunlock = gohelper.findChild(self.viewGO, "anim/layout/auxiliary/#go_destiny/#go_stone/#level")
	self._txtstonelevel = gohelper.findChildText(self.viewGO, "anim/layout/auxiliary/#go_destiny/#go_stone/#txt_level")
	self._gostoneLevelmax = gohelper.findChild(self.viewGO, "anim/layout/auxiliary/#go_destiny/#go_stone/#level/#max")
	self._godestinyreddot = gohelper.findChild(self.viewGO, "anim/layout/auxiliary/#go_destiny/#go_destinyreddot")
	self._goreshape = gohelper.findChild(self.viewGO, "anim/layout/auxiliary/#go_destiny/#go_stone/#reshape")

	gohelper.setActive(self._gostone, true)

	self._animDestiny = self._godestiny:GetComponent(typeof(UnityEngine.Animator))
end

function CharacterDefaultDestinyView:_isOwnHero()
	if not self.viewContainer:isOwnHero() then
		return
	end

	if self.heroMo:isOtherPlayerHero() then
		return
	end

	return true
end

function CharacterDefaultDestinyView:playOpenAnim()
	local isOtherPlayerHero = self.heroMo:isOtherPlayerHero()

	if isOtherPlayerHero then
		return
	end

	self:_playDestinyAnim("open")
end

function CharacterDefaultDestinyView:onOpen()
	self.heroMo = self.viewParam

	self:refreshUI(self.heroMo)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.HeroUpdatePush, self._onRefreshDestinySystem, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self._onRefreshDestinySystem, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self._onRefreshDestinySystem, self)
end

function CharacterDefaultDestinyView:refreshUI(heroMo)
	self.heroMo = heroMo

	self:_onRefreshDestinySystem()
end

function CharacterDefaultDestinyView:onUpdateParam()
	self:onOpen()
end

function CharacterDefaultDestinyView:onClose()
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.HeroUpdatePush, self._onRefreshDestinySystem, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self._onRefreshDestinySystem, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self._onRefreshDestinySystem, self)
end

function CharacterDefaultDestinyView:_onRefreshDestinySystem()
	local isActive = self.heroMo:isHasDestinySystem()
	local isOpen = self.heroMo:isCanOpenDestinySystem()
	local destinyStoneMo = self.heroMo.destinyStoneMo

	if isOpen then
		if not self._stoneLevel then
			self._stoneLevel = self:getUserDataTb_()

			for i = 1, 4 do
				local go = gohelper.findChild(self._gostone, "#level/level" .. i)
				local item = self:getUserDataTb_()

				item.canvasgroup = go:GetComponent(typeof(UnityEngine.CanvasGroup))

				table.insert(self._stoneLevel, item)
			end
		end

		if destinyStoneMo then
			if not destinyStoneMo.rank then
				do
					local rank = 0
					local isMaxRank = rank == destinyStoneMo.maxRank

					self._txtstonelevel.text = CharacterDestinyEnum.RomanNum[rank]

					for i, item in ipairs(self._stoneLevel) do
						item.canvasgroup.alpha = i <= rank and 1 or 0.3
					end

					gohelper.setActive(self._gostoneLevelmax.gameObject, isMaxRank)
				end

				if destinyStoneMo.curUseStoneId ~= 0 then
					local _, icon = destinyStoneMo:getCurStoneNameAndIcon()

					self._imagestone:LoadImage(icon)
				end

				if isActive then
					local heroType = self.heroMo:getHeroType()

					if not CharacterDestinyEnum.SlotTitle[heroType] then
						local title = CharacterDestinyEnum.SlotTitle[1]

						self._txtdestiny.text = luaLang(title)
					end
				end

				local isEquipReshape = destinyStoneMo:isEquipReshape() ~= nil

				gohelper.setActive(self._godestiny, isActive)
				gohelper.setActive(self._gostoneunlock, isOpen)
				gohelper.setActive(self._gostonelock, not isOpen)
				gohelper.setActive(self._imagestone.gameObject, isOpen and destinyStoneMo:isUnlockSlot() and destinyStoneMo.curUseStoneId ~= 0)
				gohelper.setActive(self._txtstonelevel.gameObject, isOpen)
				gohelper.setActive(self._godestinyreddot, self:_isShowDestinyReddot())
				gohelper.setActive(self._goreshape, isEquipReshape)
			end
		end
	end
end

function CharacterDefaultDestinyView:_isShowDestinyReddot()
	if not self:_isOwnHero() or self.heroMo:isTrial() then
		return
	end

	if self.heroMo and self.heroMo.destinyStoneMo then
		return self.heroMo:isCanOpenDestinySystem() and self.heroMo.destinyStoneMo:getRedDot() < 3
	end
end

function CharacterDefaultDestinyView:_playDestinyAnim(animName)
	if self._animDestiny then
		self._animDestiny:Play(animName, 0, 0)
	end
end

function CharacterDefaultDestinyView:onDestroyView()
	self._imagestone:UnLoadImage()
end

return CharacterDefaultDestinyView
