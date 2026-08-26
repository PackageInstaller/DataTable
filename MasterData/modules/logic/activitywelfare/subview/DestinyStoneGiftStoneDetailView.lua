-- chunkname: @modules/logic/activitywelfare/subview/DestinyStoneGiftStoneDetailView.lua

module("modules.logic.activitywelfare.subview.DestinyStoneGiftStoneDetailView", package.seeall)

local DestinyStoneGiftStoneDetailView = class("DestinyStoneGiftStoneDetailView", BaseView)

function DestinyStoneGiftStoneDetailView:onInitView()
	self._root = gohelper.findChild(self.viewGO, "root")
	self._animRoot = self._root:GetComponent(typeof(UnityEngine.Animator))
	self._goeffect = gohelper.findChild(self.viewGO, "root/effectItem")
	self._imgstone = gohelper.findChildImage(self.viewGO, "root/#go_stone/#simage_stone")
	self._goEquip = gohelper.findChild(self.viewGO, "root/#go_stone/#equip")
	self._goreshapeVX = gohelper.findChild(self.viewGO, "root/#go_stone/#reshape")
	self._simagereshape = gohelper.findChildSingleImage(self.viewGO, "root/#go_stone/#reshape/#simage_stone")
	self._simagestoneName = gohelper.findChildSingleImage(self.viewGO, "root/#simage_reshapeTitle")
	self._imagestoneName = gohelper.findChildImage(self.viewGO, "root/#simage_reshapeTitle")
	self._imageicon = gohelper.findChildImage(self.viewGO, "root/#image_icon")
	self._txtstonename = gohelper.findChildText(self.viewGO, "root/#txt_stonename")
	self._gostone = gohelper.findChild(self.viewGO, "root/#go_stone")
	self._simagestone = gohelper.findChildSingleImage(self.viewGO, "root/#go_stone/#simage_stone")
	self._gounlocktips2 = gohelper.findChild(self.viewGO, "root/btn/#go_unlocktips_2")
	self._gounlocktips3 = gohelper.findChild(self.viewGO, "root/btn/#go_unlocktips_3")
	self._gounlocktips4 = gohelper.findChild(self.viewGO, "root/btn/#go_unlocktips_4")
	self._gopoint = gohelper.findChild(self.viewGO, "root/point/#go_point")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._goreshape = gohelper.findChild(self.viewGO, "root/#go_reshape")
	self._btnreshape = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_reshape/#btn_reshape")
	self._goreshapeselect = gohelper.findChild(self._btnreshape.gameObject, "selected")
	self._goreshapeunselect = gohelper.findChild(self._btnreshape.gameObject, "unselect")
	self._goreshapeeffect = gohelper.findChild(self.viewGO, "root/#go_reshapeeffect")
	self._goreshapeItem = gohelper.findChild(self.viewGO, "root/#go_reshapeeffect/#scroll_reshape")
	self._reshapeAnim = self._goreshape:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DestinyStoneGiftStoneDetailView:addEvents()
	self._btnreshape:AddClickListener(self._btnreshapeOnClick, self)
end

function DestinyStoneGiftStoneDetailView:removeEvents()
	self._btnreshape:RemoveClickListener()
end

function DestinyStoneGiftStoneDetailView:_btnreshapeOnClick()
	self._isShowReshape = not self._isShowReshape

	self:_showReshape(true)
end

function DestinyStoneGiftStoneDetailView:_editableInitView()
	self._effectItems = self:getUserDataTb_()
	self._pointItems = self:getUserDataTb_()
	self._effectitemPrefab = gohelper.findChild(self._goeffect, "#scroll_effect")

	for i = 1, CharacterDestinyEnum.EffectItemCount do
		local item = self:_getEffectItem(i)

		gohelper.setActive(item.root, true)
	end

	self:_initReshapeItem()
end

function DestinyStoneGiftStoneDetailView:_getEffectItem(index)
	local item = self._effectItems[index]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.findChild(self._goeffect, index)

		item.go = go
		item.root = gohelper.clone(self._effectitemPrefab, go)
		item.lockicon = gohelper.findChildImage(item.root, "Viewport/Content/#go_decItem/#txt_dec/#go_lockicon")
		item.unlockicon = gohelper.findChildImage(item.root, "Viewport/Content/#go_decItem/#txt_dec/#go_unlockicon")
		item.txt = gohelper.findChildText(item.root, "Viewport/Content/#go_decItem/#txt_dec")
		item.gounlock = gohelper.findChild(item.root, "Viewport/Content/#go_decItem/#unlock")
		item.canvasgroup = item.root:GetComponent(typeof(UnityEngine.CanvasGroup))
		self._effectItems[index] = item
	end

	return item
end

function DestinyStoneGiftStoneDetailView:_initReshapeItem()
	gohelper.setActive(self._goreshapeItem, false)

	self._reshapeItems = self:getUserDataTb_()

	for index = 1, 5 do
		local item = self._reshapeItems[index]

		if not item then
			item = self:getUserDataTb_()

			local root = gohelper.findChild(self._goreshapeeffect, index)
			local go = gohelper.clone(self._goreshapeItem, root, "item" .. index)

			item.go = root
			item.descTxt = gohelper.findChildText(go, "Viewport/Content/#go_reshapeItem")
			item.titleTxt = gohelper.findChildText(go, "Viewport/Content/#go_reshapeItem/title")
			item.cg = root:GetComponent(typeof(UnityEngine.CanvasGroup))
			self._reshapeItems[index] = item

			gohelper.setActive(go, true)
		end
	end
end

function DestinyStoneGiftStoneDetailView:onOpen()
	self._heroId = self.viewParam.heroId
	self._heroMO = HeroModel.instance:getByHeroId(self._heroId)
	self._stoneId = self.viewParam.stoneId
	self._stoneMo = self.viewParam.stoneMo
	self._type = self.viewParam.type
	self._isShowReshape = false

	self:_refresh()
	gohelper.setActive(self._root, true)
end

function DestinyStoneGiftStoneDetailView:_refresh()
	if self._stoneMo then
		gohelper.setActive(self._goEquip, self._stoneMo)
		self:_refreshSkillDesc()
		self:_refreshStoneItem()
		self:_refreshTips()
	end
end

function DestinyStoneGiftStoneDetailView:_refreshSkillDesc()
	local lvCos = CharacterDestinyConfig.instance:getDestinyFacetCo(self._stoneId)

	for i, item in ipairs(self._effectItems) do
		local co = lvCos[i]

		item.skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(item.txt.gameObject, SkillDescComp)

		item.skillDesc:updateInfo(item.txt, co.desc, self._heroId)
		item.skillDesc:setTipParam(0, Vector2(300, 100))

		if self._stoneMo then
			local isUnlock = true

			isUnlock = self._heroMO

			if self._heroMO then
				isUnlock = self._stoneMo.isUnlock

				if self._stoneMo.isUnlock then
					if i > self._heroMO.destinyStoneMo.rank then
						isUnlock = false
					end

					local color = item.txt.color

					color.a = isUnlock and 1 or 0.43
					item.txt.color = color

					if isUnlock then
						local color = item.unlockicon.color

						color.a = isUnlock and 1 or 0.43
						item.unlockicon.color = color
					else
						local color = item.lockicon.color

						color.a = isUnlock and 1 or 0.43
						item.lockicon.color = color
					end

					gohelper.setActive(item.lockicon.gameObject, not isUnlock)
					gohelper.setActive(item.unlockicon.gameObject, isUnlock)
				end
			end
		end
	end
end

function DestinyStoneGiftStoneDetailView:_refreshStoneItem()
	local conusmeCo = CharacterDestinyConfig.instance:getDestinyFacetConsumeCo(self._stoneId)
	local icon = ResUrl.getDestinyIcon(conusmeCo.icon)

	self._txtstonename.text = conusmeCo.name

	self._simagestone:LoadImage(icon)
	self._simagereshape:LoadImage(icon)

	local tenp = CharacterDestinyEnum.SlotTend[conusmeCo.tend]
	local tendIcon = tenp.TitleIconName

	UISpriteSetMgr.instance:setUiCharacterSprite(self._imageicon, tendIcon)

	self._txtstonename.color = GameUtil.parseColor(tenp.TitleColor)

	if self._stoneMo then
		if self._stoneMo then
			if not Color.white then
				self._imgstone.color = Color(0.5, 0.5, 0.5, 1)

				local isReshapeStone = conusmeCo and conusmeCo.type == CharacterDestinyEnum.StoneType.Reshape

				gohelper.setActive(self._goreshape, isReshapeStone)
				gohelper.setActive(self._goreshapeVX, isReshapeStone)
				gohelper.setActive(self._txtstonename.gameObject, not isReshapeStone)
				gohelper.setActive(self._simagestoneName.gameObject, isReshapeStone)

				if isReshapeStone then
					local resName = self._stoneMo.stoneId

					self._simagestoneName:LoadImage(ResUrl.getTxtDestinyIcon(resName), function()
						self._imagestoneName:SetNativeSize()
					end)
				end

				gohelper.setActive(self._goeffect, true)
				gohelper.setActive(self._goreshapeeffect, false)
				self:_refreshStoneReshape()
			end
		end
	end
end

function DestinyStoneGiftStoneDetailView:_showReshape(isPlayAnim)
	gohelper.setActive(self._goreshapeselect, self._isShowReshape)
	gohelper.setActive(self._goreshapeunselect, not self._isShowReshape)
	TaskDispatcher.cancelTask(self._showReshapeEffect, self)

	if isPlayAnim then
		self._reshapeAnim:Play(CharacterDestinyEnum.SlotViewAnim.Switch, 0, 0)

		if self._isShowReshape then
			if not CharacterDestinyEnum.StoneViewAnim.Switch_reshape then
				local animName = CharacterDestinyEnum.StoneViewAnim.Switch_normal

				self._animRoot:Play(animName, 0, 0)
				TaskDispatcher.runDelay(self._showReshapeEffect, self, 0.16)
			end
		end
	else
		self:_showReshapeEffect()
	end
end

function DestinyStoneGiftStoneDetailView:_showReshapeEffect()
	gohelper.setActive(self._goeffect, not self._isShowReshape)
	gohelper.setActive(self._goreshapeeffect, self._isShowReshape)
end

function DestinyStoneGiftStoneDetailView:_refreshStoneReshape(isPlayAnim)
	local descList = {}
	local cos = CharacterDestinyConfig.instance:getSkillExlevelCos(self._stoneId)

	if cos then
		for _, co in pairs(cos) do
			if not string.nilorempty(co.desc) then
				descList[co.skillLevel] = co.desc
			end
		end
	end

	if self._heroMO then
		local destinyStoneMo = self._heroMO.destinyStoneMo
		local isEquipReshapeAttr = destinyStoneMo and destinyStoneMo:getEquipReshapeStoneCo(self._stoneMo) ~= nil
		local var_15_1 = self._stoneMo

		if self._stoneMo then
			var_15_1 = self._stoneMo.isUnlock

			if self._stoneMo.isUnlock then
				local isUnlock = isEquipReshapeAttr

				for i = 1, #descList do
					local item = self._reshapeItems[i]
					local lang = luaLang("character_destinystone_reshape_lv")

					item.titleTxt.text = GameUtil.getSubPlaceholderLuaLangOneParam(lang, i)
					item.skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(item.descTxt.gameObject, SkillDescComp)

					item.skillDesc:updateInfo(item.descTxt, descList[i], self._heroMO.heroId)
					item.skillDesc:setTipParam(0, Vector2(300, 100))

					item.cg.alpha = isUnlock and 1 or 0.43
				end

				for i = 1, #self._reshapeItems do
					gohelper.setActive(self._reshapeItems[i].go, i <= #descList)
				end
			end
		end
	end
end

function DestinyStoneGiftStoneDetailView:_refreshTips()
	gohelper.setActive(self._gounlocktips2, self._type == DestinyStoneGiftPickChoiceEnum.HeroStoneType.OwnHeroStoneLocked)
	gohelper.setActive(self._gounlocktips3, self._type == DestinyStoneGiftPickChoiceEnum.HeroStoneType.NotOwnHeroStone)
	gohelper.setActive(self._gounlocktips4, self._type == DestinyStoneGiftPickChoiceEnum.HeroStoneType.OwnHeroStoneMax)
end

function DestinyStoneGiftStoneDetailView:onClose()
	return
end

function DestinyStoneGiftStoneDetailView:onDestroyView()
	self._simagestone:UnLoadImage()
	self._simagereshape:UnLoadImage()
end

return DestinyStoneGiftStoneDetailView
