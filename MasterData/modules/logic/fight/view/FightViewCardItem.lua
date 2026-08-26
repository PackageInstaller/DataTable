-- chunkname: @modules/logic/fight/view/FightViewCardItem.lua

module("modules.logic.fight.view.FightViewCardItem", package.seeall)

local FightViewCardItem = class("FightViewCardItem", LuaCompBase)

FightViewCardItem.TagPosForLvs = nil

function FightViewCardItem:ctor(handCardType)
	self.preLv = 0
	self.handCardType = handCardType or FightEnum.CardShowType.Default
end

function FightViewCardItem:init(go)
	self.classComp = FightGameMgr.playMgr:newClass(FightBaseClass)
	self.useSkin = false

	if self.handCardType == FightEnum.CardShowType.HandCard or self.handCardType == FightEnum.CardShowType.Operation or self.handCardType == FightEnum.CardShowType.PlayCard then
		local cardSkin = FightCardDataHelper.getCardSkin()

		if cardSkin then
			self.useSkin = cardSkin
		end
	end

	self.go = go
	self._canvasGroup = go:GetComponent(gohelper.Type_CanvasGroup)
	self.tr = go.transform
	self._lvGOs = self:getUserDataTb_()
	self._lvImgIcons = self:getUserDataTb_()
	self._lvImgComps = self:getUserDataTb_()
	self._starItemCanvas = self:getUserDataTb_()
	self.skillIconBg = self:getUserDataTb_()
	self.attributeBg = self:getUserDataTb_()
	self.highlightEffect = self:getUserDataTb_()

	for i = 0, 4 do
		local lvGO = gohelper.findChild(go, "lv" .. i)
		local lvIcon = gohelper.findChildSingleImage(lvGO, "imgIcon")
		local lvImgComp = gohelper.findChildImage(lvGO, "imgIcon")

		gohelper.setActive(lvGO, true)

		self._lvGOs[i] = lvGO
		self._lvImgIcons[i] = lvIcon
		self._lvImgComps[i] = lvImgComp

		local obj = gohelper.findChild(lvGO, "image")

		self.attributeBg[i] = obj
		obj = gohelper.findChild(lvGO, "bg")
		self.skillIconBg[i] = obj
		self.highlightEffect[i] = gohelper.findChild(lvGO, "#pc_highlighted")

		if self.useSkin == 672802 then
			recthelper.setAnchorX(lvImgComp.transform, 0)
		end
	end

	if not FightViewCardItem.TagPosForLvs then
		FightViewCardItem.TagPosForLvs = {}

		for i = 0, 4 do
			local x, y = recthelper.getAnchor(gohelper.findChild(go, "tag/pos" .. i).transform)

			FightViewCardItem.TagPosForLvs[i] = {
				x,
				y
			}
		end
	end

	self.goTag = gohelper.findChild(go, "tag")
	self.tagCanvas = gohelper.onceAddComponent(self.goTag, typeof(UnityEngine.CanvasGroup))
	self._tagRootTr = gohelper.findChild(go, "tag/tag").transform
	self._tag = gohelper.findChildSingleImage(go, "tag/tag/tagIcon")
	self.tagTransform = self._tag.transform
	self._txt = gohelper.findChildText(go, "Text")
	self._starGO = gohelper.findChild(go, "star")
	self._starCanvas = gohelper.onceAddComponent(self._starGO, typeof(UnityEngine.CanvasGroup))
	self._innerStartGOs = self:getUserDataTb_()
	self._innerStarPreLvGoList = self:getUserDataTb_()
	self._innerStarPreLvGoDict = {}

	for i = 1, FightEnum.MaxSkillCardLv do
		local starObj = gohelper.findChild(go, "star/star" .. i)

		table.insert(self._innerStartGOs, starObj)
		table.insert(self._starItemCanvas, gohelper.onceAddComponent(starObj, typeof(UnityEngine.CanvasGroup)))

		local preLvGo = gohelper.findChild(starObj, "prelv")

		table.insert(self._innerStarPreLvGoList, preLvGo)
		gohelper.setActive(preLvGo, false)

		local lvGoList = {}

		for lv = i + 1, FightEnum.MaxSkillCardLv do
			local lvGo = gohelper.findChild(preLvGo, "pre_" .. lv)

			gohelper.setActive(lvGo, false)
			table.insert(lvGoList, lvGo)

			local image = lvGo:GetComponent(gohelper.Type_Image)

			UISpriteSetMgr.instance:setFightSkillCardSprite(image, "xx1", true)
		end

		table.insert(self._innerStarPreLvGoDict, lvGoList)

		if not self.useSkin then
			if i == 2 then
				recthelper.setAnchorX(starObj.transform, 16)
			elseif i == 3 then
				recthelper.setAnchorX(starObj.transform, 9)
			end
		end
	end

	self._layout = gohelper.findChild(self.go, "layout")

	gohelper.setActive(self._layout, true)

	self._predisplay = gohelper.findChild(go, "layout/predisplay")
	self._predisplayLorentz = gohelper.findChild(go, "layout/predisplay_lorentz")
	self.noCostTips = gohelper.findChild(go, "layout/noCostTips")

	gohelper.setActive(self.noCostTips, false)

	self.baifuzhang_wheel_card = gohelper.findChild(go, "layout/baifuzhang_wheel_card")
	self.baifuzhang_wheel_cardText = gohelper.findChildText(self.baifuzhang_wheel_card, "image_BG/txt_predisplay")
	self._cardAni = gohelper.onceAddComponent(go, typeof(UnityEngine.Animator))
	self._cardAppearEffectRoot = gohelper.findChild(go, "cardAppearEffectRoot")
	self._cardMask = gohelper.findChild(go, "cardmask")
	self._maskList = self:getUserDataTb_()

	for i = 1, 4 do
		table.insert(self._maskList, gohelper.findChild(self._cardMask, "lv" .. i))
	end

	self._resistanceComp = MonoHelper.addLuaComOnceToGo(self.go, FightViewCardItemResistance, self)
	self._loader = self._loader or FightLoaderComponent.New()
	self._countRoot = gohelper.findChild(self.go, "layout/count")
	self._countText = gohelper.findChildText(self.go, "layout/count/#txt_count")

	gohelper.setActive(self._countRoot, false)

	self._abandon = gohelper.findChild(self.go, "layout/abandon")

	gohelper.setActive(self._abandon, false)

	self.goRouge2Double = gohelper.findChild(self.go, "layout/rouge2_double")

	gohelper.setActive(self.goRouge2Double, false)

	self._blockadeTwo = gohelper.findChild(self.go, "#go_enchant_effect")

	gohelper.setActive(self._blockadeTwo, false)

	self._blockadeOne = gohelper.findChild(self.go, "#go_enchant_uneffect")

	gohelper.setActive(self._blockadeOne, false)

	self._precision = gohelper.findChild(self.go, "AccurateEnchant")

	gohelper.setActive(self._precision, false)

	self._precisionEffect = gohelper.findChild(self.go, "AccurateEnchant/effect")

	gohelper.setActive(self._precisionEffect, false)

	self.goLorentzVx = gohelper.findChild(self.go, "#go_lorentz_vx")
	self.goLaMoNaVx = gohelper.findChild(self.go, "#go_lamona_vx")

	self:initSuperimposeNode()

	self.goTopLayout = gohelper.findChild(go, "topLayout")
	self.showASFD = false
	self.goASFD = gohelper.findChild(go, "topLayout/asfd_icon")

	gohelper.setActive(self.goASFD, false)

	self.txtASFDEnergy = gohelper.findChildText(go, "topLayout/asfd_icon/#txt_Num")
	self.goRouge2Double_HandCard = gohelper.findChild(go, "topLayout/rouge_fumo")

	gohelper.setActive(self.goRouge2Double_HandCard, false)

	self.showRouge2Music = true
	self.goRouge2Music = gohelper.findChild(go, "topLayout/rouge_skill")

	gohelper.setActive(self.goRouge2Music, false)

	self.imageRouge2Music = gohelper.findChildImage(go, "topLayout/rouge_skill/#image_icon")
	self.rouge2FuMo = gohelper.findChild(go, "topLayout/rouge_fumo")

	gohelper.setActive(self.rouge2FuMo, false)

	self.goASFDSkill = gohelper.findChild(go, "asfd")
	self.asfdSkillSimage = gohelper.findChildSingleImage(go, "asfd/imgIcon")
	self.asfdNumTxt = gohelper.findChildText(go, "asfd/#txt_Num")
	self.goASFDSkill_2 = gohelper.findChild(go, "asfd2")
	self.asfdNumTxt_2 = gohelper.findChildText(go, "asfd2/#txt_Num")
	self.career2ASDFGoDict = self:getUserDataTb_()
	self.career2ASDFGoDict[FightEnum.Career.Star] = self.goASFDSkill
	self.career2ASDFGoDict[FightEnum.Career.Wood] = self.goASFDSkill_2
	self.career2ASDFTxtDict = self:getUserDataTb_()
	self.career2ASDFTxtDict[FightEnum.Career.Star] = self.asfdNumTxt
	self.career2ASDFTxtDict[FightEnum.Career.Wood] = self.asfdNumTxt_2
	self.goPreDelete = gohelper.findChild(go, "go_predelete")
	self.goPreDeleteNormal = gohelper.findChild(go, "go_predelete/normal")
	self.goPreDeleteUnique = gohelper.findChild(go, "go_predelete/ultimate")
	self.goPreDeleteLeft = gohelper.findChild(go, "go_predelete/Left")
	self.goPreDeleteRight = gohelper.findChild(go, "go_predelete/Right")
	self.goPreDeleteBoth = gohelper.findChild(go, "go_predelete/Both")

	self:resetPreDelete()

	self.goPreDeleteCard = gohelper.findChild(go, "go_predeletecard")

	gohelper.setActive(self.goPreDeleteCard, false)
	self:initLyRedAndBlue()

	self._heatRoot = gohelper.findChild(go, "#go_heat")
	self.goBloodPool = gohelper.findChild(go, "blood_pool")
	self.goTowerAssistRole = gohelper.findChild(go, "#go_towerAssist")
	self.goTowerAssistSmallSkillIcon = gohelper.findChild(self.goTowerAssistRole, "eff")
	self.goTowerAssistBigSkillIcon = gohelper.findChild(self.goTowerAssistRole, "eff2")
	self.go3_7Rouge2FuMo = gohelper.findChild(go, "3_7rouge2fumo")
	self.xingtiTxt = gohelper.findChildText(go, "txt_xingti")
	self.xingtiGo = self.xingtiTxt.gameObject
	self.goHeDuoNieRoot = gohelper.findChild(self.go, "go_heduonie")
	self.alfLoadStatus = FightViewCardItem.AlfLoadStatus.None
	self.useCardCopyLoadStatus = FightViewCardItem.AlfLoadStatus.None

	if self.useSkin then
		local frontBgRoot = gohelper.create2d(go, "skinFrontBg")

		self.frontBgRoot = frontBgRoot

		gohelper.setActive(frontBgRoot, true)
		gohelper.setSibling(frontBgRoot, 6)

		local frontBgNormal = gohelper.create2d(frontBgRoot, "skinFrontBgNormal")
		local frontBgBigSkill = gohelper.create2d(frontBgRoot, "skinFrontBgBigSkill")

		self.frontBgNormal = frontBgNormal
		self.frontBgBigSkill = frontBgBigSkill
		self.imgFrontBgNormal = gohelper.onceAddComponent(frontBgNormal, gohelper.Type_Image)
		self.imgFrontBgBigSkill = gohelper.onceAddComponent(frontBgBigSkill, gohelper.Type_Image)

		UISpriteSetMgr.instance:setFightSkillCardSprite(self.imgFrontBgNormal, "card_dz4", true)
		UISpriteSetMgr.instance:setFightSkillCardSprite(self.imgFrontBgBigSkill, "card_dz", true)
		recthelper.setAnchorY(frontBgNormal.transform, -14)
		recthelper.setAnchorY(frontBgBigSkill.transform, 20)

		if self.useSkin == 672801 then
			local backBgRoot = gohelper.create2d(go, "skinBackBg")

			self.backBgRoot = backBgRoot

			gohelper.setActive(backBgRoot, true)
			gohelper.setSibling(backBgRoot, 0)

			local img = gohelper.onceAddComponent(backBgRoot, gohelper.Type_Image)

			UISpriteSetMgr.instance:setFightSkillCardSprite(img, "card_dz3", true)
		end

		for i = 1, #self._innerStartGOs do
			local obj = self._innerStartGOs[i]
			local transform = obj.transform

			for index = 0, transform.childCount - 1 do
				local child = transform:GetChild(index)
				local childName = child.name
				local img = child:GetComponent(gohelper.Type_Image)

				if img then
					if childName == "light" then
						UISpriteSetMgr.instance:setFightSkillCardSprite(img, "xx1", true)
					elseif childName == "lightblue" then
						UISpriteSetMgr.instance:setFightSkillCardSprite(img, "xx3", true)
					elseif string.sub(childName, 1, 4) == "dark" then
						UISpriteSetMgr.instance:setFightSkillCardSprite(img, "xx2", true)
					end
				end
			end
		end

		for i = 0, 4 do
			gohelper.setActive(self.skillIconBg[i], false)
			gohelper.setActive(self.attributeBg[i], false)
		end
	end

	if PCInputController.instance:getIsUse() then
		local x, y = recthelper.getAnchor(self.goTopLayout.transform)

		recthelper.setAnchor(self.goTopLayout.transform, x, y + 50)
	end

	self.playedHideCardOpenAnim = false
end

function FightViewCardItem:initLyRedAndBlue()
	self.goLyRoot = gohelper.findChild(self.go, "ly_root")

	gohelper.setActive(self.goLyRoot, true)

	local skin = FightDataHelper.entityMgr:getHeroSkin(FightEnum.HeroId.LY)
	local co = skin and lua_fight_sp_card_mask_ly.configDict[skin]

	co = co or lua_fight_sp_card_mask_ly.configList[1]
	self.lyLoader = PrefabInstantiate.Create(self.goLyRoot)

	local resPath = string.format("ui/viewres/fight/%s.prefab", co.path)

	self.lyLoader:startLoad(resPath, self.onLyLoaderDone, self)
end

function FightViewCardItem:onLyLoaderDone()
	self.goRedAndBlue = self.lyLoader:getInstGO()

	gohelper.setActive(self.goRedAndBlue, true)

	self.goLyMask = gohelper.findChild(self.goRedAndBlue, "mask")
	self.goRed = gohelper.findChild(self.goRedAndBlue, "red")
	self.goBlue = gohelper.findChild(self.goRedAndBlue, "green")
	self.goBoth = gohelper.findChild(self.goRedAndBlue, "both")

	self:resetRedAndBlue()
	self:setActiveRed(self.ly_red_active)
	self:setActiveBlue(self.ly_blue_active)
	self:setActiveBoth(self.ly_both_active)
end

function FightViewCardItem:changeTopLayoutAnchorYOffset(offset)
	local curAnchorX, curAnchorY = recthelper.getAnchor(self.goTopLayout.transform)

	self.srcAnchorY = self.srcAnchorY or curAnchorY

	recthelper.setAnchor(self.goTopLayout.transform, curAnchorX, self.srcAnchorY + offset)
end

function FightViewCardItem:initSuperimposeNode()
	self.goSuperimposeRoot = gohelper.findChild(self.go, "superimpose_root")
	self.simageRouge2SkillIcon = gohelper.findChildSingleImage(self.goSuperimposeRoot, "rouge2skill_icon")
	self.goRouge2SkillIcon = self.simageRouge2SkillIcon.gameObject
	self.imageRouge2SkillIcon = self.goRouge2SkillIcon:GetComponent(gohelper.Type_Image)
end

function FightViewCardItem:resetPreDelete()
	gohelper.setActive(self.goPreDeleteNormal, false)
	gohelper.setActive(self.goPreDeleteUnique, false)
	gohelper.setActive(self.goPreDeleteLeft, false)
	gohelper.setActive(self.goPreDeleteRight, false)
	gohelper.setActive(self.goPreDeleteBoth, false)
end

function FightViewCardItem:resetRedAndBlue()
	gohelper.setActive(self.goRedAndBlue, true)
	gohelper.setActive(self.goLyMask, false)
	gohelper.setActive(self.goRed, false)
	gohelper.setActive(self.goBlue, false)
	gohelper.setActive(self.goBoth, false)
end

function FightViewCardItem:addEventListeners()
	self.addEventCb(self, FightController.instance, FightEvent.ASFD_EmitterEnergyChange, self.onEmitterEnergyChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.UpdateBuffActInfo, self.onUpdateBuffActInfo, self)

	if self.handCardType == FightEnum.CardShowType.HandCard or self.handCardType == FightEnum.CardShowType.Operation then
		self.addEventCb(self, FightController.instance, FightEvent.OnClientUnnamedTypeChange, self.onClientUnnamedTypeChange, self)
	end

	if self:checkCanShowHideCardEffect() then
		self.addEventCb(self, FightController.instance, FightEvent.OnAddHideCardBuff, self.onAddHideCardBuff, self)
		self.addEventCb(self, FightController.instance, FightEvent.OnRemoveHideCardBuff, self.OnRemoveHideCardBuff, self)
	end

	if self.handCardType == FightEnum.CardShowType.HandCard or self.handCardType == FightEnum.CardShowType.Operation or self.handCardType == FightEnum.CardShowType.PlayCard then
		self.addEventCb(self, FightController.instance, FightEvent.OnHeDuoNieBuffDataUpdate, self.onHeDuoNieBuffDataUpdate, self)
	end
end

function FightViewCardItem:onHeDuoNieBuffDataUpdate(entityId)
	if entityId ~= self.entityId then
		return
	end

	self:refreshHeDuoNieUI()
end

function FightViewCardItem:onAddHideCardBuff()
	self.playedHideCardOpenAnim = false

	self:refreshCardIcon()
end

function FightViewCardItem:OnRemoveHideCardBuff()
	self:refreshCardIcon()
end

local hideCardVxPrefab = "ui/viewres/fight/fighttower/card_mshboss.prefab"

function FightViewCardItem:refreshHideCardVx()
	if not self:checkCanShowHideCardEffect() then
		return
	end

	if self.goHideCardVx then
		local skillCardLv = FightCardDataHelper.getSkillLv(self.entityId, self.skillId)
		local isBigSkill = skillCardLv == FightEnum.UniqueSkillCardLv
		local hasHideCardVx = isBigSkill and FightModel.instance.bigSkillIcon ~= nil or FightModel.instance.smallSkillIcon ~= nil

		gohelper.setActive(self.goHideCardVx, hasHideCardVx)
		gohelper.setActive(self.goHideCardVxNormal, hasHideCardVx and not isBigSkill)
		gohelper.setActive(self.goHideCardVxBigSkill, hasHideCardVx and isBigSkill)

		if hasHideCardVx and not self.playedHideCardOpenAnim then
			if isBigSkill then
				self.hideCardBigSkillAnim:Play("open")
			else
				self.hideCardNormalAnim:Play("open")
			end

			self.playedHideCardOpenAnim = true
		end
	else
		if self.hideVxLoader then
			return
		end

		self.hideVxLoader = MultiAbLoader.New()

		self.hideVxLoader:addPath(hideCardVxPrefab)
		self.hideVxLoader:startLoad(self.onHideCardVxLoaded, self)
	end
end

FightViewCardItem.HideCardVxGoName = "hideCardVx"

function FightViewCardItem:onHideCardVxLoaded()
	local sourceGo = self.hideVxLoader:getAssetItem(hideCardVxPrefab):GetResource()

	self.goHideCardVx = gohelper.clone(sourceGo, self.go, FightViewCardItem.HideCardVxGoName)
	self.goHideCardVxNormal = gohelper.findChild(self.goHideCardVx, "normal")

	local animGo = gohelper.findChild(self.goHideCardVxNormal, "ani")

	self.hideCardNormalAnim = ZProj.ProjAnimatorPlayer.Get(animGo)
	self.goHideCardVxBigSkill = gohelper.findChild(self.goHideCardVx, "ultimate")
	animGo = gohelper.findChild(self.goHideCardVxBigSkill, "ani")
	self.hideCardBigSkillAnim = ZProj.ProjAnimatorPlayer.Get(animGo)

	self:refreshHideCardVx()
end

function FightViewCardItem:onUpdateBuffActInfo(entityId, buffUid, buffActInfo)
	if buffActInfo.actId ~= FightEnum.BuffActId.NoUseCardEnergyRecordByRound then
		return
	end

	self:refreshXiTiSpecialSkill(self.entityId, self.skillId)
end

function FightViewCardItem:onEmitterEnergyChange()
	if not FightHelper.isASFDSkill(self.skillId) then
		return
	end

	local energy = FightDataHelper.ASFDDataMgr:getEmitterEnergy(FightEnum.EntitySide.MySide)

	for _, txt in pairs(self.career2ASDFTxtDict) do
		txt.text = energy
	end

	if self._disappearFlow and self._disappearFlow.status == WorkStatus.Running then
		return
	end

	if self._dissolveFlow and self._dissolveFlow.status == WorkStatus.Running then
		return
	end

	local goAsfd = self:getGoASFDSkill(self.entityId)

	AudioMgr.instance:trigger(20248003)

	local animator = goAsfd:GetComponent(gohelper.Type_Animator)

	if animator then
		animator:Play("aggrandizement", 0, 0)
	end
end

function FightViewCardItem:resetAllNode()
	local count = self.tr.childCount

	for index = 1, count do
		local child = self.tr:GetChild(index - 1)

		gohelper.setActive(child.gameObject, false)
	end
end

function FightViewCardItem:updateItem(entityId, skillId, cardInfoMO, updateFromType)
	self.entityId = entityId
	self.skillId = skillId
	self._cardInfoMO = cardInfoMO

	self:resetAllNode()
	gohelper.setActive(self.go, true)
	gohelper.setActive(self.goTag, true)
	gohelper.setActive(self.goLyRoot, true)
	gohelper.setActive(self._layout, true)
	gohelper.setActive(self.frontBgRoot, true)
	gohelper.setActive(self.backBgRoot, true)

	self._canvasGroup.alpha = 1
	self.tagCanvas.alpha = 1

	if FightHelper.isBloodPoolSkill(skillId) then
		gohelper.setActive(self.frontBgRoot, false)

		return self:refreshBloodPoolSkill(entityId, skillId, cardInfoMO)
	end

	if FightHelper.isASFDSkill(skillId) then
		gohelper.setActive(self.frontBgRoot, false)

		return self:refreshASFDSkill(entityId, skillId, cardInfoMO)
	end

	if FightHelper.isPreDeleteSkill(skillId) then
		gohelper.setActive(self.frontBgRoot, false)

		return self:refreshPreDeleteSkill(entityId, skillId, cardInfoMO)
	end

	self:_hideAniEffect()
	self:refreshCardIcon()
	self:refreshStar()
	self:refreshTag()
	self:refreshUniqueCover()
	self:_refreshPreDisplay()
	self:showNoCostTips()
	self:_showUpgradeEffect()
	self:_showEnchantsEffect()
	self:_showRouge2EnchantsEffect()
	self:refreshLaMoNaEnchantVx()
	self:_refreshGray()
	self:_refreshASFD()
	self:_refreshRouge2Music()
	self:_refreshPreDeleteArrow()
	self:showCardHeat()
	self:refreshXiTiSpecialSkill(entityId, skillId, cardInfoMO)
	self:refreshSuperimposeIcon()
	self:refreshAssistRoleIcon()
	self:refreshBaiFuZhangWheelCard()
	self:refreshUnnamedUi(updateFromType)
	self:refreshRefrigeratorEffect()
	self:refreshHeDuoNieUI()
	self:refreshEnchantText()
end

function FightViewCardItem:refreshUniqueCover()
	local skillCO = lua_skill.configDict[self.skillId]
	local skillCardLv = FightCardDataHelper.getSkillLv(self.entityId, self.skillId)

	self._txt.text = skillCO.id .. "\nLv." .. skillCardLv

	local coverType = FightConfig.instance:getCoverType(self.skillId, self.entityId)
	local showBigSkillEffect = coverType == FightEnum.CoverType.Unique

	if showBigSkillEffect and not self._uniqueCardEffect then
		local url = ResUrl.getUIEffect(FightPreloadViewWork.ui_dazhaoka)
		local assetItem = FightGameMgr.loaderMgr:getAsset(url).assetItem

		self._uniqueCardEffect = gohelper.clone(assetItem:GetResource(url), self.go)
	end

	gohelper.setActive(self._uniqueCardEffect, not self.useSkin and showBigSkillEffect)
	gohelper.setActive(self.frontBgNormal, not showBigSkillEffect)
	gohelper.setActive(self.frontBgBigSkill, showBigSkillEffect)
end

function FightViewCardItem:refreshBaiFuZhangWheelCard()
	gohelper.setActive(self.baifuzhang_wheel_card, false)

	local skillId = self.skillId

	if skillId == 117351181 or skillId == 117351183 or skillId == 117351191 or skillId == 117351193 then
		gohelper.setActive(self.baifuzhang_wheel_card, true)

		self.baifuzhang_wheel_cardText.text = luaLang("fight_bai_fu_zhang_wheel_6")

		return
	end

	if skillId == 117351182 or skillId == 117351184 or skillId == 117351192 or skillId == 117351194 then
		gohelper.setActive(self.baifuzhang_wheel_card, true)

		self.baifuzhang_wheel_cardText.text = luaLang("fight_bai_fu_zhang_wheel_7")

		return
	end
end

function FightViewCardItem:onClientUnnamedTypeChange()
	self:refreshUnnamedLayer()
end

local HeDuoNieUIPath = "ui/viewres/fight/fightcardheduonieview.prefab"

function FightViewCardItem.GetHeDuoNieUiPath()
	return HeDuoNieUIPath
end

function FightViewCardItem:refreshHeDuoNieUI()
	if self.handCardType ~= FightEnum.CardShowType.HandCard and self.handCardType ~= FightEnum.CardShowType.PlayCard and self.handCardType ~= FightEnum.CardShowType.Operation then
		return
	end

	if not FightHelper.isHeDuoNieSkill(self.skillId) then
		gohelper.setActive(self.goHeDuoNieRoot, false)

		return
	end

	if self.goHeDuoNieUi then
		self:_refreshHeDuoNieUI()
	else
		if self.heDuoNieUiLoader then
			return
		end

		self.heDuoNieUiLoader = MultiAbLoader.New()

		self.heDuoNieUiLoader:addPath(HeDuoNieUIPath)
		self.heDuoNieUiLoader:startLoad(self.onLoadHeDuoNieUiDone, self)
	end
end

function FightViewCardItem:_refreshHeDuoNieUI()
	local entityMo = FightDataHelper.entityMgr:getById(self.entityId)

	if not entityMo then
		gohelper.setActive(self.goHeDuoNieRoot, false)

		return
	end

	local curCount, maxCount, unlock = entityMo:getHeDuoNieBuffData()

	if not curCount then
		gohelper.setActive(self.goHeDuoNieRoot, false)

		return
	end

	local pointParent, parentList

	for count, goParent in pairs(self.heDuoNie_PosRootDict) do
		if count == maxCount then
			pointParent = goParent
			parentList = self.heDuoNie_CountDict[count]

			gohelper.setActive(goParent, true)
		else
			gohelper.setActive(goParent, false)
		end
	end

	if not pointParent then
		logError("赫多涅 卡牌 布局不存在 : " .. tostring(maxCount))
		gohelper.setActive(self.goHeDuoNieRoot, false)

		return
	end

	local heDuoNieMgr = FightDataHelper.tempMgr:getHeDuoNieDataMgr()

	gohelper.setActive(self.goHeDuoNieRoot, true)

	for i = 1, maxCount do
		if parentList[i] then
			local pointItem = self.heDuoNiePointList[i]

			if not pointItem then
				pointItem = self:createHeDuoNiePointItem()
				self.heDuoNiePointList[i] = pointItem
			end

			gohelper.setActive(pointItem.go, true)
			gohelper.setParent(pointItem.go, parentList[i])
			recthelper.setAnchor(pointItem.tr, 0, 0)
			gohelper.setActive(pointItem.goLight, i <= curCount)
			gohelper.setActive(pointItem.goGrey, curCount < i)

			if i <= curCount and not heDuoNieMgr:checkPlayedPointAnim(i) then
				heDuoNieMgr:playedPointAnim(i)
				pointItem.lightAnimator:Play("light", 0, 0)
				AudioMgr.instance:trigger(390028)
			end
		end
	end

	for i = maxCount + 1, #self.heDuoNiePointList do
		local pointItem = self.heDuoNiePointList[i]

		if pointItem then
			gohelper.setActive(pointItem.go, true)
		end
	end

	gohelper.setActive(self.heDuoNie_GoLockBg, not unlock)
	gohelper.setActive(self.heDuoNie_GoUnlockBg, unlock)

	if unlock then
		heDuoNieMgr:tryPlayUnlockAudio()
	end
end

function FightViewCardItem:createHeDuoNiePointItem()
	local pointItem = self:getUserDataTb_()

	pointItem.go = gohelper.cloneInPlace(self.heDuoNie_GoPoint)
	pointItem.tr = pointItem.go:GetComponent(gohelper.Type_RectTransform)
	pointItem.goGrey = gohelper.findChild(pointItem.go, "grey")
	pointItem.goLight = gohelper.findChild(pointItem.go, "light")
	pointItem.lightAnimator = pointItem.goLight:GetComponent(gohelper.Type_Animator)

	return pointItem
end

function FightViewCardItem:onLoadHeDuoNieUiDone()
	local prefab = self.heDuoNieUiLoader:getFirstAssetItem():GetResource()

	self.goHeDuoNieUi = gohelper.clone(prefab, self.goHeDuoNieRoot)
	self.heDuoNieAnimator = ZProj.ProjAnimatorPlayer.Get(self.goHeDuoNieUi)
	self.heDuoNie_GoLockBg = gohelper.findChild(self.goHeDuoNieUi, "root/go_bg/lock")
	self.heDuoNie_GoUnlockBg = gohelper.findChild(self.goHeDuoNieUi, "root/go_bg/unlock")
	self.heDuoNie_PosRootDict = self:getUserDataTb_()

	local rectTrPos = gohelper.findChildComponent(self.goHeDuoNieUi, "root/go_pos", gohelper.Type_RectTransform)
	local childCount = rectTrPos.childCount

	for i = 0, childCount - 1 do
		local child = rectTrPos:GetChild(i)
		local childName = tonumber(child.name)

		if childName then
			self.heDuoNie_PosRootDict[childName] = child.gameObject
		end
	end

	self.heDuoNie_CountDict = {}

	for count, goRoot in pairs(self.heDuoNie_PosRootDict) do
		self.heDuoNie_CountDict[count] = self:buildHeDuoNiePosList(count, goRoot)

		gohelper.setActive(goRoot, false)
	end

	self.heDuoNie_GoPoint = gohelper.findChild(self.goHeDuoNieUi, "root/go_effectPoint")

	gohelper.setActive(self.heDuoNie_GoPoint, false)
	gohelper.setActive(self.heDuoNie_GoPoint, false)

	self.heDuoNiePointList = {}

	self:refreshHeDuoNieUI()
end

function FightViewCardItem:buildHeDuoNiePosList(count, posRoot)
	local posList = self:getUserDataTb_()

	for i = 1, count do
		table.insert(posList, gohelper.findChild(posRoot, i))
	end

	return posList
end

function FightViewCardItem:playHeDuoNieOpenAnim(playCallback, callbackObj)
	self:refreshHeDuoNieUI()

	if not self.heDuoNieAnimator then
		logError("赫多涅 卡牌节点不存在 ?")

		if playCallback then
			playCallback(callbackObj)
		end

		return
	end

	self.heDuoNieAnimator:Play("open", playCallback, callbackObj)
end

local UnnamedUIPath = "ui/viewres/fight/fight3_7nonamecard.prefab"

function FightViewCardItem:refreshUnnamedUi(updateFromType)
	if self.handCardType ~= FightEnum.CardShowType.HandCard and self.handCardType ~= FightEnum.CardShowType.PlayCard and self.handCardType ~= FightEnum.CardShowType.Operation then
		return
	end

	if self._cardInfoMO then
		local unnamedCardData = self._cardInfoMO:getCardData(FightCardInfo_CardData.CardDataKey.Unnamed)

		if not unnamedCardData then
			self:_refreshUnnamedUi(updateFromType)

			return
		end

		if self.goUnnamedUi then
			self:_refreshUnnamedUi(updateFromType)
		else
			if self.unnamedUiLoader then
				return
			end

			self.unnamedUiLoader = MultiAbLoader.New()

			self.unnamedUiLoader:addPath(UnnamedUIPath)
			self.unnamedUiLoader:startLoad(self.onLoadUnnamedUiDone, self)
		end
	end
end

function FightViewCardItem:onLoadUnnamedUiDone()
	local prefab = self.unnamedUiLoader:getFirstAssetItem():GetResource()

	self.goUnnamedRoot = gohelper.findChild(self.go, "noname")
	self.goUnnamedUi = gohelper.clone(prefab, gohelper.findChild(self.goUnnamedRoot, "#go_v3a7_nonamecard"))
	self.goUnnamedLockBg = gohelper.findChild(self.goUnnamedUi, "bg_01")
	self.goUnnamedUnlockBg = gohelper.findChild(self.goUnnamedUi, "bg_03")
	self.unnamedAnimator = ZProj.ProjAnimatorPlayer.Get(self.goUnnamedUi)
	self.unnamedLayerList = {}

	table.insert(self.unnamedLayerList, self:buildUnnamedImageList(gohelper.findChild(self.goUnnamedUi, "top_left")))
	table.insert(self.unnamedLayerList, self:buildUnnamedImageList(gohelper.findChild(self.goUnnamedUi, "top_right")))
	table.insert(self.unnamedLayerList, self:buildUnnamedImageList(gohelper.findChild(self.goUnnamedUi, "bottom_left")))
	table.insert(self.unnamedLayerList, self:buildUnnamedImageList(gohelper.findChild(self.goUnnamedUi, "bottom_right")))
	self:refreshUnnamedUi()
end

function FightViewCardItem:buildUnnamedImageList(go)
	local goList = self:getUserDataTb_()

	for i = 1, 4 do
		table.insert(goList, gohelper.findChild(go, i))
	end

	return goList
end

function FightViewCardItem:_refreshUnnamedUi(updateFromType)
	if not self.goUnnamedUi then
		return
	end

	if self._cardInfoMO then
		local unnamedCardData = self._cardInfoMO:getCardData(FightCardInfo_CardData.CardDataKey.Unnamed)

		if not unnamedCardData then
			gohelper.setActive(self.goUnnamedRoot, false)

			return
		end

		gohelper.setActive(self.goUnnamedRoot, true)

		local unnamedDataMgr = FightDataHelper.tempMgr:getUnnamedDataMgr()

		if not unnamedDataMgr:checkPlayedAnim("open") then
			self:playUnnamedAnim("open")
		end

		local isLock = unnamedCardData.jsonValue.lock

		gohelper.setActive(self.goUnnamedLockBg, isLock)
		gohelper.setActive(self.goUnnamedUnlockBg, not isLock)
		self:refreshUnnamedLayer(updateFromType)

		if not isLock and not unnamedDataMgr:checkPlayedAnim("unlock") and self:playUnnamedAnim("unlock") then
			self:playCardAnim("noname_unlock")
		end
	end
end

function FightViewCardItem:refreshUnnamedLayer(updateFromType)
	if self._cardInfoMO then
		local unnamedCardData = self._cardInfoMO:getCardData(FightCardInfo_CardData.CardDataKey.Unnamed)

		if not self._cardInfoMO then
			return
		end

		local unnamedMgr = FightDataHelper.tempMgr:getUnnamedDataMgr()

		for type, goList in ipairs(self.unnamedLayerList) do
			local severValue = self._cardInfoMO.jsonValue.strengthen[tostring(type)] or 0
			local clientValue = unnamedMgr:getUnnamedTypeValue(type)
			local totalValue = severValue + clientValue

			for i = 1, 4 do
				local active = i <= totalValue

				gohelper.setActive(goList[i], active)

				if active then
					local playAnim = false

					if i <= severValue then
						if unnamedMgr:checkPlayedData(type, i) then
							unnamedMgr:setPlayedData(type, i)

							playAnim = true
						end
					elseif i <= totalValue and unnamedMgr:checkClientPlayedData(type, i) then
						unnamedMgr:setClientPlayedData(type, i)

						playAnim = true
					end

					if playAnim then
						local animator = goList[i]:GetComponent(gohelper.Type_Animator)

						animator:Play("fight3_7nonamecard_effpiece", 0, 0)
					end
				end
			end
		end
	end
end

function FightViewCardItem:tryPlayInsertAnim()
	return
end

function FightViewCardItem:tryStopInsertAnim()
	return
end

function FightViewCardItem:playUnnamedAnim(animName)
	if self.unnamedAnimator and self.unnamedAnimator.isActiveAndEnabled then
		local unnamedDataMgr = FightDataHelper.tempMgr:getUnnamedDataMgr()

		unnamedDataMgr:setPlayedAnim(animName)
		self.unnamedAnimator:Play(animName, self.stopUnnamedAnim, self)

		return true
	end
end

function FightViewCardItem:stopUnnamedAnim()
	if self.unnamedAnimator then
		self.unnamedAnimator:Stop()
	end
end

function FightViewCardItem:_refreshPreDisplay()
	gohelper.setActive(self._predisplay, false)
	gohelper.setActive(self._predisplayLorentz, false)

	if self._cardInfoMO then
		if not self._cardInfoMO then
			return
		end

		if self._cardInfoMO then
			local enchantList = self._cardInfoMO.enchants

			if enchantList then
				for _, v in ipairs(enchantList) do
					if v.enchantId == FightEnum.EnchantedType.Lorenz then
						gohelper.setActive(self._predisplayLorentz, true)

						return
					end
				end
			end

			gohelper.setActive(self._predisplay, true)
		end
	end
end

function FightViewCardItem:showNoCostTips()
	gohelper.setActive(self.noCostTips, false)

	if self.handCardType ~= FightEnum.CardShowType.HandCard and self.handCardType ~= FightEnum.CardShowType.Operation then
		return
	end

	if self._cardInfoMO then
		local entityId = self._cardInfoMO.uid

		if not entityId then
			return
		end

		local skillId = self._cardInfoMO.skillId
		local skillCo = lua_skill.configDict[skillId]

		if not skillCo then
			return
		end

		local entityData = FightDataHelper.entityMgr:getById(entityId)

		if not entityData then
			return
		end

		local isBigSkill = skillCo.isBigSkill == 1
		local noCost = entityData:hasBuffFeature(FightEnum.BuffFeature.SkillNoUseActPoint)

		if isBigSkill then
			noCost = noCost or entityData:hasBuffFeature(FightEnum.BuffType_BigSkillNoUseActPoint)
		end

		gohelper.setActive(self.noCostTips, noCost)
	end
end

function FightViewCardItem:refreshEnchantText()
	local text = gohelper.findChildText(self.go, "enchant_text")

	gohelper.setActive(text.gameObject, false)

	do return end

	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	if not self._cardInfoMO then
		return
	end

	local enchantList = self._cardInfoMO.enchants

	if not enchantList then
		return
	end

	if #enchantList < 1 then
		return
	end

	gohelper.setActive(text.gameObject, true)

	local str = "附魔:"

	for _, v in ipairs(enchantList) do
		str = str .. v.enchantId .. "\n"
	end

	text.text = str
end

function FightViewCardItem:refreshAssistRoleIcon()
	local show = false

	if self.handCardType == FightEnum.CardShowType.Operation or self.handCardType == FightEnum.CardShowType.PlayCard then
		local entityMo = FightDataHelper.entityMgr:getById(self.entityId)

		if entityMo and entityMo:isAssistBoss() and FightDataHelper.paTaMgr:checkIsAssistRole() then
			show = true
		end
	end

	gohelper.setActive(self.goTowerAssistRole, show)

	local isBigSkill = FightCardDataHelper.isBigSkill(self.skillId)

	gohelper.setActive(self.goTowerAssistSmallSkillIcon, not isBigSkill)
	gohelper.setActive(self.goTowerAssistBigSkillIcon, isBigSkill)
end

function FightViewCardItem:refreshSuperimposeIcon()
	gohelper.setActive(self.goSuperimposeRoot, true)

	local isMusicSkill = FightRouge2MusicBehaviourHelper.isRouge2ClothMusicSkill(self.skillId)

	if not isMusicSkill then
		gohelper.setActive(self.goRouge2SkillIcon, false)

		return
	end

	gohelper.setActive(self.goRouge2SkillIcon, true)

	local co = lua_fight_rouge2_music_ball_skill.configDict[self.skillId]

	if not co then
		logError("fight_rouge2_music_ball_skill 表 未找到配置, skillId : " .. tostring(self.skillId))

		co = lua_fight_rouge2_music_ball_skill.configList[1]
	end

	local url = string.format("singlebg/rouge2/backpack/skill/%s.png", co.icon)

	self.simageRouge2SkillIcon:LoadImage(url, self.onLoadRouge2ClothSkillIconDone, self)
end

function FightViewCardItem:onLoadRouge2ClothSkillIconDone()
	self.imageRouge2SkillIcon:SetNativeSize()
end

function FightViewCardItem:refreshCardIcon()
	local skillCO = lua_skill.configDict[self.skillId]
	local skillCardLv = FightCardDataHelper.getSkillLv(self.entityId, self.skillId)

	self.isBigSkillShow = skillCardLv == 4

	for level, lvGO in pairs(self._lvGOs) do
		gohelper.setActive(lvGO, true)
		gohelper.setActiveCanvasGroup(lvGO, skillCardLv == level)
	end

	local targetIconUrl = self:checkCanShowHideCardEffect() and FightModel.instance:getHandCardSkillIcon(self.entityId, skillCO) or ResUrl.getSkillIcon(skillCO.icon)

	for level, one in pairs(self._lvImgIcons) do
		if gohelper.isNil(self._lvImgComps[level].sprite) then
			one:UnLoadImage()
		elseif one.curImageUrl ~= targetIconUrl then
			one:UnLoadImage()
		end

		one:LoadImage(targetIconUrl)
	end

	self:refreshHideCardVx()
end

function FightViewCardItem:checkCanShowHideCardEffect()
	return self.handCardType == FightEnum.CardShowType.HandCard or self.handCardType == FightEnum.CardShowType.Operation
end

FightViewCardItem.attributePrefix = {
	[672802] = "v3a7_skin/attribute_",
	[672801] = "v2a8_skin/attribute_",
	[672803] = "v3a9_skin/attribute_"
}
FightViewCardItem.cardTagWidth = {
	[672802] = 180,
	[672801] = 180,
	[672803] = 180
}
FightViewCardItem.cardTagHeight = {
	[672802] = 64,
	[672801] = 64,
	[672803] = 64
}

function FightViewCardItem:refreshTag()
	local skillCardLv = FightCardDataHelper.getSkillLv(self.entityId, self.skillId)

	if not FightViewCardItem.attributePrefix[self.useSkin] then
		local prefixStr = "attribute_"

		if not FightViewCardItem.cardTagWidth[self.useSkin] then
			local tagWidth = 168

			if not FightViewCardItem.cardTagHeight[self.useSkin] then
				local tagHeight = 56
				local tagUrl = ResUrl.getAttributeIcon(prefixStr .. ((FightCardDataHelper.isSkill3(self._cardInfoMO) or nil) and "skill3"))

				self._tag:UnLoadImage()
				self._tag:LoadImage(tagUrl)
				recthelper.setSize(self.tagTransform, tagWidth, tagHeight)

				local showTagPos = FightViewCardItem.TagPosForLvs[skillCardLv]

				if showTagPos then
					recthelper.setAnchor(self._tagRootTr, showTagPos[1], showTagPos[2])

					if self.useSkin then
						recthelper.setAnchorY(self._tagRootTr, -200)
					end
				end

				gohelper.setActive(self._tag.gameObject, skillCardLv < FightEnum.UniqueSkillCardLv)
			end
		end
	end
end

function FightViewCardItem:showCardHeat()
	if self._cardInfoMO and self._cardInfoMO.heatId and self._cardInfoMO.heatId ~= 0 then
		self:setHeatRootVisible(true)

		if self._heatObj then
			self:_refreshCardHeat()
		elseif not self._loadHeat then
			self._loadHeat = true

			self._loader:loadAsset("ui/viewres/fight/fightheatview.prefab", self._onHeatLoadFinish, self)
		end
	else
		self:setHeatRootVisible(false)
	end
end

function FightViewCardItem:setHeatRootVisible(state)
	gohelper.setActive(self._heatRoot, state)
end

function FightViewCardItem:_refreshCardHeat()
	if self._cardInfoMO and self._cardInfoMO.heatId ~= 0 then
		local heatId = self._cardInfoMO.heatId
		local teamData = FightDataHelper.teamDataMgr.myData
		local data = teamData.cardHeat.values[heatId]

		if data then
			if not FightDataHelper.teamDataMgr.myCardHeatOffset[heatId] then
				self._heatText.text = Mathf.Clamp(data.value + FightDataHelper.teamDataMgr.myCardHeatOffset[heatId], data.lowerLimit, data.upperLimit)
			end
		else
			self._heatText.text = ""
		end
	end
end

function FightViewCardItem:_onHeatLoadFinish(success, loader)
	if not success then
		return
	end

	self._heatObj = gohelper.clone(loader:GetResource(), self._heatRoot)
	self._heatText = gohelper.findChildText(self._heatObj, "heatText")

	self:_refreshCardHeat()
end

function FightViewCardItem:_refreshPreDeleteArrow()
	local isHandCard = self.handCardType == FightEnum.CardShowType.HandCard

	gohelper.setActive(self.goPreDelete, isHandCard)

	if isHandCard then
		gohelper.setActive(self.goPreDeleteBoth, false)
		gohelper.setActive(self.goPreDeleteLeft, false)
		gohelper.setActive(self.goPreDeleteRight, false)

		local co = lua_fight_card_pre_delete.configDict[self.skillId]

		if co then
			local left = co.left > 0
			local right = co.right > 0

			if left and right then
				gohelper.setActive(self.goPreDeleteBoth, true)
			elseif left then
				gohelper.setActive(self.goPreDeleteLeft, true)
			elseif right then
				gohelper.setActive(self.goPreDeleteRight, true)
			end

			gohelper.setActive(self._starGO, false)
		end
	end
end

function FightViewCardItem:_refreshPreDeleteImage(needShowPreDeleteImage)
	local isHandCard = self.handCardType == FightEnum.CardShowType.HandCard

	gohelper.setActive(self.goPreDelete, isHandCard)

	if isHandCard then
		local usUniqueSkill = FightCardDataHelper.isBigSkill(self.skillId)

		gohelper.setActive(self.goPreDeleteNormal, not usUniqueSkill and needShowPreDeleteImage)
		gohelper.setActive(self.goPreDeleteUnique, usUniqueSkill and needShowPreDeleteImage)
	end
end

function FightViewCardItem:refreshPreDeleteSkill(entityId, skillId, cardInfoMO)
	gohelper.setActive(self.goPreDeleteCard, true)
	gohelper.setActive(self.goPreDeleteNormal, false)
	gohelper.setActive(self.goPreDeleteUnique, false)
	self:refreshTag()
	self:_refreshPreDeleteArrow()
end

function FightViewCardItem:refreshBloodPoolSkill(entityId, skillId, cardInfoMO)
	gohelper.setActive(self.goBloodPool, true)
	gohelper.setActive(self.goTag, true)
	gohelper.setActive(self._tag.gameObject, true)

	self.bloodPoolAnimator = self.bloodPoolAnimator or self.goBloodPool:GetComponent(gohelper.Type_Animator)

	if self.handCardType == FightEnum.CardShowType.Operation then
		self.bloodPoolAnimator:Play("open", 0, 0)
		AudioMgr.instance:trigger(20270007)
	else
		self.bloodPoolAnimator:Play("open", 0, 1)
	end

	self._tag:LoadImage(ResUrl.getAttributeIcon("blood_tex2"))

	local showTagPos = FightViewCardItem.TagPosForLvs[1]

	recthelper.setAnchor(self._tagRootTr, showTagPos[1], showTagPos[2])
end

function FightViewCardItem:refreshASFDSkill(entityId, skillId, cardInfoMO)
	local entityMO = FightDataHelper.entityMgr:getById(entityId)
	local career = entityMO and entityMO:getCareer()

	career = career ~= FightEnum.Career.None and career or FightEnum.Career.Star

	for c, go in pairs(self.career2ASDFGoDict) do
		gohelper.setActive(go, c == career)
	end

	gohelper.setActive(self.goTag, true)
	gohelper.setActive(self._tag.gameObject, true)
	self._tag:LoadImage(ResUrl.getAttributeIcon("attribute_asfd"))

	local energy = FightDataHelper.ASFDDataMgr:getEmitterEnergy(FightEnum.EntitySide.MySide)

	for _, txt in pairs(self.career2ASDFTxtDict) do
		txt.text = energy
	end

	local showTagPos = FightViewCardItem.TagPosForLvs[1]

	recthelper.setAnchor(self._tagRootTr, showTagPos[1], showTagPos[2])
end

function FightViewCardItem:getGoASFDSkill(entityId)
	local entityMO = FightDataHelper.entityMgr:getById(entityId)
	local career = entityMO and entityMO:getCareer()
	local go = career and self.career2ASDFGoDict[career]

	go = go or self.career2ASDFGoDict[FightEnum.Career.Star]

	return go
end

function FightViewCardItem:refreshXiTiSpecialSkill(entityId, skillId, cardInfoMO)
	if not FightHelper.isXiTiSpecialSkill(skillId) then
		gohelper.setActive(self.xingtiGo, false)

		return
	end

	gohelper.setActive(self.xingtiGo, true)

	self.xingtiTxt.text = FightASFDHelper.getLastRoundRecordCardEnergy()
end

function FightViewCardItem:updateResistanceByCardInfo(cardInfoMO)
	self._resistanceComp:updateByCardInfo(cardInfoMO)
end

function FightViewCardItem:updateResistanceByBeginRoundOp(fightBeginRoundOp)
	self._resistanceComp:updateByBeginRoundOp(fightBeginRoundOp)
end

function FightViewCardItem:updateResistanceBySkillDisplayMo(displayMo)
	self._resistanceComp:updateBySkillDisplayMo(displayMo)
end

function FightViewCardItem:detectShowBlueStar()
	local var_61_0 = self.entityId

	if self.entityId then
		var_61_0 = self.skillId

		if self.skillId then
			local skillCardLv = FightCardDataHelper.getSkillLv(self.entityId, self.skillId)

			self:showBlueStar(skillCardLv)
		end
	end
end

function FightViewCardItem:showBlueStar(skillCardLv)
	if self._lightBlueObj then
		for i, v in ipairs(self._lightBlueObj) do
			gohelper.setActive(v.blue, false)
			gohelper.setActive(v.dark, true)
		end
	else
		self._lightBlueObj = {}
		self._lightBlueObj[1] = self:getUserDataTb_()
		self._lightBlueObj[1].blue = gohelper.findChild(self._innerStartGOs[1], "lightblue")
		self._lightBlueObj[1].dark = gohelper.findChild(self._innerStartGOs[1], "dark2")
		self._lightBlueObj[2] = self:getUserDataTb_()
		self._lightBlueObj[2].blue = gohelper.findChild(self._innerStartGOs[2], "lightblue")
		self._lightBlueObj[2].dark = gohelper.findChild(self._innerStartGOs[2], "dark3")
	end

	if skillCardLv == 1 or skillCardLv == 2 then
		local entityMO = FightDataHelper.entityMgr:getById(self.entityId)

		if entityMO and entityMO:hasBuffFeature(FightEnum.BuffFeature.SkillLevelJudgeAdd) then
			local tab = self._lightBlueObj[skillCardLv]

			gohelper.setActive(tab.blue, true)
			gohelper.setActive(tab.dark, false)
		end
	end
end

function FightViewCardItem:showPrecisionEffect()
	gohelper.setActive(self._precisionEffect, true)
end

function FightViewCardItem:hidePrecisionEffect()
	gohelper.setActive(self._precisionEffect, false)
end

function FightViewCardItem:refreshRefrigeratorEffect()
	local hasRefrigerator = false

	if self._cardInfoMO and self._cardInfoMO.enchants then
		for i, v in ipairs(self._cardInfoMO.enchants) do
			if v.enchantId == FightEnum.EnchantedType.Refrigerator then
				self.refrigeratorEffect = self.refrigeratorEffect or self.classComp:newClass(FightViewCardItemRefrigeratorEffect, v, self)
				hasRefrigerator = true
			end
		end
	end

	if not hasRefrigerator and self.refrigeratorEffect then
		self.refrigeratorEffect:disposeSelf()

		self.refrigeratorEffect = nil
	end
end

local enchantId2EffectPath = {
	[FightEnum.EnchantedType.Frozen] = "ui/viewres/fight/card_freeze.prefab",
	[FightEnum.EnchantedType.Burn] = "ui/viewres/fight/card_flaring.prefab",
	[FightEnum.EnchantedType.Chaos] = "ui/viewres/fight/card_chaos.prefab",
	[FightEnum.EnchantedType.depresse] = "ui/viewres/fight/card_qmyj.prefab"
}

function FightViewCardItem:_showEnchantsEffect()
	gohelper.setActive(self._abandon, false)
	gohelper.setActive(self._blockadeTwo, false)
	gohelper.setActive(self._blockadeOne, false)
	gohelper.setActive(self._precision, false)
	gohelper.setActive(self._precisionEffect, false)
	gohelper.setActive(self.goLorentzVx, false)
	gohelper.setActive(self.go3_7Rouge2FuMo, false)

	if not self._cardInfoMO then
		return
	end

	local loadPaths = self:_refreshEnchantEffectActive()

	if #loadPaths > 0 then
		self._loader:loadListAsset(loadPaths, self._onEnchantEffectLoaded, self._onEnchantEffectsLoaded, self)
	end

	if self._cardInfoMO.enchants then
		for i, v in ipairs(self._cardInfoMO.enchants) do
			if v.enchantId == FightEnum.EnchantedType.Discard then
				gohelper.setActive(self._abandon, true)
			elseif v.enchantId == FightEnum.EnchantedType.Blockade then
				local handCards = FightDataHelper.handCardMgr.handCard

				if self._cardInfoMO.clientData.custom_playedCard then
					gohelper.setActive(self._blockadeOne, true)
				elseif self._cardInfoMO.clientData.custom_handCardIndex then
					if self._cardInfoMO.clientData.custom_handCardIndex == 1 or self._cardInfoMO.clientData.custom_handCardIndex == #handCards then
						gohelper.setActive(self._blockadeOne, true)
					else
						gohelper.setActive(self._blockadeTwo, true)
					end
				else
					gohelper.setActive(self._blockadeOne, true)
				end
			elseif v.enchantId == FightEnum.EnchantedType.Precision then
				gohelper.setActive(self._precision, true)

				if self._cardInfoMO.clientData.custom_handCardIndex == 1 then
					FightController.instance:dispatchEvent(FightEvent.RefreshHandCardPrecisionEffect)
				end
			elseif v.enchantId == FightEnum.EnchantedType.Lorenz then
				gohelper.setActive(self.goLorentzVx, true)
				self:tryLoadLorentzEnchantVxPrefab()
			elseif v.enchantId == FightEnum.EnchantedType.Degradation then
				gohelper.setActive(self.go3_7Rouge2FuMo, true)
			end
		end
	end
end

function FightViewCardItem:refreshLaMoNaEnchantVx(active)
	if active == nil then
		active = FightCardDataHelper.hasTargetEnchantId(self._cardInfoMO, FightEnum.EnchantedType.Ramona)
	end

	gohelper.setActive(self.goLaMoNaVx, active)

	if not active then
		self.playedLaMoNaOpenAnim = false

		return
	end

	local isBigSkill = FightCardDataHelper.isBigSkill(self.skillId)

	self.goLaMoNaSmall = self.goLaMoNaSmall or gohelper.findChild(self.goLaMoNaVx, "#go_small")
	self.goLaMoNaBig = self.goLaMoNaBig or gohelper.findChild(self.goLaMoNaVx, "#go_big")

	gohelper.setActive(self.goLaMoNaBig, isBigSkill)
	gohelper.setActive(self.goLaMoNaSmall, not isBigSkill)

	if self.handCardType == FightEnum.CardShowType.HandCard and not self.playedLaMoNaOpenAnim then
		self.playedLaMoNaOpenAnim = true

		self:playLaMoNaAnim("open")
	end
end

function FightViewCardItem:tryPlayLaMoNaVx()
	if self.handCardType ~= FightEnum.CardShowType.HandCard then
		return
	end

	local hasLaMoNaEnchantId = FightCardDataHelper.hasTargetEnchantId(self._cardInfoMO, FightEnum.EnchantedType.Ramona)

	if not hasLaMoNaEnchantId then
		self:refreshLaMoNaEnchantVx(false)

		return
	end

	self:refreshLaMoNaEnchantVx(true)
	AudioMgr.instance:trigger(350003)
end

function FightViewCardItem:playLaMoNaAnim(animName)
	local isBigSkill = FightCardDataHelper.isBigSkill(self.skillId)

	if isBigSkill then
		if not self.goLaMoNaBig then
			local go = self.goLaMoNaSmall
			local animator = go and go:GetComponent(gohelper.Type_Animator)

			if animator then
				animator:Play(animName, 0, 0)
			end
		end
	end
end

function FightViewCardItem:tryLoadLorentzEnchantVxPrefab()
	if self.lorentzEnchantVxLoader then
		return
	end

	self.lorentzEnchantVxLoader = PrefabInstantiate.Create(self.goLorentzVx)

	self.lorentzEnchantVxLoader:startLoad("ui/viewres/fight/card_lorentz_fumo.prefab")
end

function FightViewCardItem:setRouge2TreasureRoot(go)
	self.goRouge2Treasure = go
end

function FightViewCardItem:_showRouge2EnchantsEffect(cardInfoMo)
	gohelper.setActive(self.goRouge2Double, false)
	gohelper.setActive(self.goRouge2Double_HandCard, false)
	gohelper.setActive(self.goRouge2Treasure, false)

	local cardInfo = cardInfoMo or self._cardInfoMO

	if not cardInfo then
		return
	end

	local enchants = cardInfo.enchants

	if not enchants then
		return
	end

	for _, v in ipairs(enchants) do
		if v.enchantId == FightEnum.EnchantedType.Rouge2_Treasure then
			if self.goRouge2Treasure then
				gohelper.setActive(self.goRouge2Treasure, true)

				if not self.rouge2TreasureLoader then
					self.rouge2TreasureLoader = PrefabInstantiate.Create(self.goRouge2Treasure)

					self.rouge2TreasureLoader:startLoad("ui/viewres/fight/fight_rouge2/fight_rouge2_treasurecarditem.prefab")
				end
			end
		elseif v.enchantId == FightEnum.EnchantedType.Rouge2_Double then
			if self.handCardType == FightEnum.CardShowType.HandCard then
				gohelper.setActive(self.goRouge2Double, false)
				gohelper.setActive(self.goRouge2Double_HandCard, true)
			else
				gohelper.setActive(self.goRouge2Double, true)
				gohelper.setActive(self.goRouge2Double_HandCard, false)
			end

			if not self.rouge2DoubleLoader then
				self.rouge2DoubleLoader = PrefabInstantiate.Create(self.goRouge2Double)

				self.rouge2DoubleLoader:startLoad("ui/viewres/fight/fight_rouge2/fight_rouge2_treasurecarditem2.prefab")
			end
		end
	end
end

function FightViewCardItem:_refreshEnchantEffectActive()
	self:_hideEnchantsEffect()

	self._enchantsEffect = self._enchantsEffect or {}

	if not self._cardInfoMO.enchants then
		local enchants = {}
		local loadPaths = {}

		for i, v in ipairs(enchants) do
			local enchantId = v.enchantId

			if self._enchantsEffect[enchantId] then
				for index, gameObject in ipairs(self._enchantsEffect[enchantId]) do
					gohelper.setActive(gameObject, true)
				end
			else
				local path = enchantId2EffectPath[enchantId]

				if path then
					table.insert(loadPaths, path)
				end
			end
		end

		return loadPaths
	end
end

function FightViewCardItem:_hideEnchantsEffect()
	if self._enchantsEffect then
		for i, v in pairs(self._enchantsEffect) do
			for index, gameObject in ipairs(v) do
				gohelper.setActive(gameObject, false)
			end
		end
	end
end

function FightViewCardItem:_onEnchantEffectLoaded(success, loader)
	return
end

function FightViewCardItem:_onEnchantEffectsLoaded(fightLoaderList)
	for k, v in pairs(enchantId2EffectPath) do
		if not self._enchantsEffect[k] then
			local loader = fightLoaderList:getAssetItem(v)

			if loader then
				local tarPrefab = loader:GetResource()

				if self._lvGOs then
					self._enchantsEffect[k] = self:getUserDataTb_()

					for level, obj in pairs(self._lvGOs) do
						local clone = gohelper.clone(tarPrefab, gohelper.findChild(obj, "#cardeffect"))

						for index = 0, 4 do
							local lvObj = gohelper.findChild(clone, "lv" .. index)

							gohelper.setActive(lvObj, index == level)
						end

						table.insert(self._enchantsEffect[k], clone)
					end
				end
			end
		end
	end

	self:_refreshEnchantEffectActive()
end

function FightViewCardItem:_showUpgradeEffect()
	if lua_fight_upgrade_show_skillid.configDict[self.skillId] then
		if not self._upgradeEffects then
			self._loader:loadAsset("ui/viewres/fight/card_aggrandizement.prefab", self._onUpgradeEffectLoaded, self)

			return
		end

		for i, v in ipairs(self._upgradeEffects) do
			gohelper.setActive(v, false)
			gohelper.setActive(v, true)
		end
	else
		self:_hideUpgradeEffects()
	end
end

function FightViewCardItem:_hideUpgradeEffects()
	if self._upgradeEffects then
		for i, v in ipairs(self._upgradeEffects) do
			gohelper.setActive(v, false)
		end
	end
end

function FightViewCardItem:_onUpgradeEffectLoaded(success, loader)
	if not success then
		return
	end

	if self._upgradeEffects then
		return
	end

	self._upgradeEffects = self:getUserDataTb_()

	local tarPrefab = loader:GetResource()

	if self._lvGOs and tarPrefab then
		for level, v in pairs(self._lvGOs) do
			local clone = gohelper.clone(tarPrefab, gohelper.findChild(v, "#cardeffect"))

			for index = 0, 4 do
				local lvObj = gohelper.findChild(clone, "lv" .. index)

				gohelper.setActive(lvObj, index == level)
			end

			table.insert(self._upgradeEffects, clone)
		end
	end

	self:_showUpgradeEffect()
end

function FightViewCardItem:showCountPart(count)
	gohelper.setActive(self._countRoot, true)

	self._countText.text = luaLang("multiple") .. count
end

function FightViewCardItem:changeToTempCard()
	gohelper.setActive(self._predisplay, true)
end

function FightViewCardItem:playDeviceRemoveEffect(go, handCardItem, removeDoneCallback, removeDoneCallbackObj)
	if not self.go.activeInHierarchy then
		if removeDoneCallback then
			removeDoneCallback(removeDoneCallbackObj)
		end

		return
	end

	self:setASFDActive(false)
	self:revertASFDSkillAnimator()

	local context = self:getUserDataTb_()

	context.handCardItem = handCardItem

	if not self._playDeviceRemoveCardFlow then
		self._playDeviceRemoveCardFlow = FlowSequence.New()

		self._playDeviceRemoveCardFlow:registerDoneListener(self.doDeviceRemoveDoneCallback, self)
		self._playDeviceRemoveCardFlow:addWork(FightCardDeviceRemoveCardEffect.New())
	else
		self:doDeviceRemoveDoneCallback()
		self._playDeviceRemoveCardFlow:stop()
	end

	self.deviceRemoveDoneCallback = removeDoneCallback
	self.deviceRemoveDoneCallbackObj = removeDoneCallbackObj

	self._playDeviceRemoveCardFlow:start(context)
end

function FightViewCardItem:doDeviceRemoveDoneCallback()
	local callback = self.deviceRemoveDoneCallback
	local callbackObj = self.deviceRemoveDoneCallbackObj

	self.deviceRemoveDoneCallback = nil
	self.deviceRemoveDoneCallbackObj = nil

	if callback then
		self.deviceRemoveDoneCallback(callbackObj)
	end
end

function FightViewCardItem:heDuoNieDisappearCard(disappearCallback, disappearCallbackObj)
	if not self.go.activeInHierarchy then
		if disappearCallback then
			disappearCallback(disappearCallbackObj)
		end

		return
	end

	self:setASFDActive(false)
	self:revertASFDSkillAnimator()

	if not self._heDuoNieDisappearFlow then
		self._heDuoNieDisappearFlow = FlowSequence.New()

		self._heDuoNieDisappearFlow:registerDoneListener(self.doHeDuoNieDisappearDoneCallback, self)
		self._heDuoNieDisappearFlow:addWork(FightCardHeDuoNieDisappearEffect.New())
	else
		self:doHeDuoNieDisappearDoneCallback()
		self._heDuoNieDisappearFlow:stop()
	end

	self.heDuoNieDisappearCallback = disappearCallback
	self.heDuoNieDisappearCallbackObj = disappearCallbackObj

	self._heDuoNieDisappearFlow:start(self)
	AudioMgr.instance:trigger(390029)
end

function FightViewCardItem:doHeDuoNieDisappearDoneCallback()
	local callback = self.heDuoNieDisappearCallback
	local callbackObj = self.heDuoNieDisappearCallbackObj

	self.heDuoNieDisappearCallback = nil
	self.heDuoNieDisappearCallbackObj = nil

	if callback then
		self.heDuoNieDisappearCallback(callbackObj)
	end
end

local HeDuoNieCardRemoveEffectPath = "ui/viewres/fight/card_heduonie.prefab"

function FightViewCardItem:startLoadHeDuoNieCardRemoveEffect(callback, callbackObj)
	if self.goHeDuoNieCardRemoveEffect then
		if callback then
			callback(callbackObj)
		end

		return
	end

	if callback then
		self.heDuoNieCardRemoveEffectLoadCallbackList = self.heDuoNieCardRemoveEffectLoadCallbackList or {}
		self.heDuoNieCardRemoveEffectLoadCallbackObjList = self.heDuoNieCardRemoveEffectLoadCallbackObjList or {}

		table.insert(self.heDuoNieCardRemoveEffectLoadCallbackList, callback)
		table.insert(self.heDuoNieCardRemoveEffectLoadCallbackObjList, callbackObj or 0)
	end

	if self.heDuoNieCardRemoveEffectLoader then
		return
	end

	self.heDuoNieCardRemoveEffectLoader = MultiAbLoader.New()

	self.heDuoNieCardRemoveEffectLoader:addPath(HeDuoNieCardRemoveEffectPath)
	self.heDuoNieCardRemoveEffectLoader:startLoad(self.onLoadHeDuoNieCardRemoveEffectDone, self)
end

function FightViewCardItem:onLoadHeDuoNieCardRemoveEffectDone()
	local assetItem = self.heDuoNieCardRemoveEffectLoader:getFirstAssetItem()
	local prefab = assetItem:GetResource()

	self.goHeDuoNieCardRemoveEffect = gohelper.clone(prefab, self.go)

	gohelper.setActive(self.goHeDuoNieCardRemoveEffect, false)

	if self.heDuoNieCardRemoveEffectLoadCallbackList then
		for i, callback in ipairs(self.heDuoNieCardRemoveEffectLoadCallbackList) do
			callback(self.heDuoNieCardRemoveEffectLoadCallbackObjList[i])
		end
	end

	self:clearHeDuoNieCardRemoveEffectCallbackList()
end

function FightViewCardItem:clearHeDuoNieCardRemoveEffectCallbackList()
	if self.heDuoNieCardRemoveEffectLoadCallbackList then
		tabletool.clear(self.heDuoNieCardRemoveEffectLoadCallbackList)

		self.heDuoNieCardRemoveEffectLoadCallbackList = nil
	end

	if self.heDuoNieCardRemoveEffectLoadCallbackObjList then
		tabletool.clear(self.heDuoNieCardRemoveEffectLoadCallbackObjList)

		self.heDuoNieCardRemoveEffectLoadCallbackObjList = nil
	end
end

function FightViewCardItem:dissolveCard(scale, tarGameObject, dissolveDoneCallback, dissolveDoneCallbackObj)
	if not self.go.activeInHierarchy then
		if dissolveDoneCallback then
			dissolveDoneCallback(dissolveDoneCallbackObj)
		end

		return
	end

	if FightHelper.isASFDSkill(self.skillId) then
		return self:disappearCard(dissolveDoneCallback, dissolveDoneCallbackObj)
	end

	if FightHelper.isPreDeleteSkill(self.skillId) then
		return self:disappearCard(dissolveDoneCallback, dissolveDoneCallbackObj)
	end

	if FightHelper.isBloodPoolSkill(self.skillId) then
		return self:disappearCard(dissolveDoneCallback, dissolveDoneCallbackObj)
	end

	if self._cardInfoMO and self._cardInfoMO.clientData and self._cardInfoMO.clientData.custom_addToRefrigerator then
		return self:addCard2Refrigerator(dissolveDoneCallback, dissolveDoneCallbackObj)
	end

	self:setASFDActive(false)
	self:revertASFDSkillAnimator()

	local context = self:getUserDataTb_()

	context.dissolveScale = scale or 1

	local tab = self:getUserDataTb_()

	tarGameObject = tarGameObject or self.go

	table.insert(tab, tarGameObject)

	context.dissolveSkillItemGOs = tab

	if not self._dissolveFlow then
		self._dissolveFlow = FlowSequence.New()

		self._dissolveFlow:registerDoneListener(self.doDissolveDoneCallback, self)
		self._dissolveFlow:addWork(FightCardDissolveEffect.New())
	else
		self:doDissolveDoneCallback()
		self._dissolveFlow:stop()
	end

	self.dissolveDoneCallback = dissolveDoneCallback
	self.dissolveDoneCallbackObj = dissolveDoneCallbackObj

	self:_hideAllEffect()
	self._dissolveFlow:start(context)
end

function FightViewCardItem:doDissolveDoneCallback()
	local callback = self.dissolveDoneCallback
	local callbackObj = self.dissolveDoneCallbackObj

	self.dissolveDoneCallback = nil
	self.dissolveDoneCallbackObj = nil

	if callback then
		self.dissolveDoneCallback(callbackObj)
	end
end

function FightViewCardItem:disappearCard(disappearCallback, disappearCallbackObj)
	if not self.go.activeInHierarchy then
		if disappearCallback then
			disappearCallback(disappearCallbackObj)
		end

		return
	end

	self:setASFDActive(false)
	self:revertASFDSkillAnimator()

	local context = self:getUserDataTb_()

	context.hideSkillItemGOs = self:getUserDataTb_()

	table.insert(context.hideSkillItemGOs, self.go)

	if not self._disappearFlow then
		self._disappearFlow = FlowSequence.New()

		self._disappearFlow:registerDoneListener(self.doDisappearDoneCallback, self)
		self._disappearFlow:addWork(FightCardDisplayHideAllEffect.New())
	else
		self:doDisappearDoneCallback()
		self._disappearFlow:stop()
	end

	self.disappearCallback = disappearCallback
	self.disappearCallbackObj = disappearCallbackObj

	self._disappearFlow:start(context)
end

function FightViewCardItem:doDisappearDoneCallback()
	local callback = self.disappearCallback
	local callbackObj = self.disappearCallbackObj

	self.disappearCallback = nil
	self.disappearCallbackObj = nil

	if callback then
		self.disappearCallback(callbackObj)
	end
end

function FightViewCardItem:addCard2Refrigerator(dissolveDoneCallback, dissolveDoneCallbackObj)
	self:setASFDActive(false)
	self:revertASFDSkillAnimator()

	local flow = self.classComp:com_registFlowSequence()

	flow:registFinishCallback(self.doDissolveDoneCallback, self)
	flow:registWork(FightCardDissolveByRefrigeratorEffect, self.go)

	self.dissolveDoneCallback = dissolveDoneCallback
	self.dissolveDoneCallbackObj = dissolveDoneCallbackObj

	self:_hideAllEffect()
	flow:start()
end

function FightViewCardItem:revertASFDSkillAnimator()
	if not FightHelper.isASFDSkill(self.skillId) then
		return
	end

	if self.asfdSkillAnimator then
		self.asfdSkillAnimator:Play("open", 0, 0)
	end
end

function FightViewCardItem:playUsedCardDisplay(tipsGO)
	if not self.go.activeInHierarchy then
		return
	end

	if not self._cardDisplayFlow then
		self._cardDisplayFlow = FlowSequence.New()

		self._cardDisplayFlow:addWork(FightCardDisplayEffect.New())
	end

	local context = self:getUserDataTb_()

	context.skillTipsGO = tipsGO
	context.skillItemGO = self.go
	context.cardItem = self

	self._cardDisplayFlow:start(context)
end

function FightViewCardItem:playUsedCardFinish(tipsGO, waitingAreaGO, param)
	if not self.go.activeInHierarchy then
		return
	end

	if not self._cardDisplayEndFlow then
		self._cardDisplayEndFlow = FlowSequence.New()

		self._cardDisplayEndFlow:addWork(FightCardDisplayEndEffect.New())
	end

	local context = self:getUserDataTb_()

	context.skillTipsGO = tipsGO
	context.skillItemGO = self.go
	context.waitingAreaGO = waitingAreaGO
	param = param or {}
	context.param = param
	param.skillId = self.skillId

	self._cardDisplayEndFlow:start(context)
end

function FightViewCardItem:playCardLevelChange(cardData, oldSkillId, failType)
	if not self._cardInfoMO then
		return
	end

	if not self.go.activeInHierarchy then
		return
	end

	self._cardInfoMO = cardData or self._cardInfoMO

	local oldLevel = FightConfig.instance:getSkillLv(oldSkillId)
	local newLevel = FightConfig.instance:getSkillLv(self._cardInfoMO.skillId)

	if not self._cardLevelChangeFlow then
		self._cardLevelChangeFlow = FlowSequence.New()

		self._cardLevelChangeFlow:addWork(FightCardChangeEffect.New())
		self._cardLevelChangeFlow:registerDoneListener(self._onCardLevelChangeFlowDone, self)
	else
		oldLevel = self._cardLevelChangeFlow.status == WorkStatus.Running and self._cardLevelChangeFlow.context and self._cardLevelChangeFlow.context.oldCardLevel or oldLevel

		self._cardLevelChangeFlow:stop()
	end

	local context = self:getUserDataTb_()

	context.skillId = self._cardInfoMO.skillId
	context.entityId = self._cardInfoMO.uid
	context.oldCardLevel = oldLevel
	context.newCardLevel = newLevel
	context.cardItem = self
	context.failType = failType

	self._cardLevelChangeFlow:start(context)

	if oldLevel <= newLevel then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_cardstarup)
	else
		AudioMgr.instance:trigger(20211403)
	end
end

FightViewCardItem.LorentzLvChangeAnimDuration = 1.2

function FightViewCardItem:playCardLevelChange_Lorentz(cardInfoMo)
	self._cardInfoMO = cardInfoMo

	if self.goLorentzLvUp then
		gohelper.setActive(self.goLorentzLvUp, false)
		gohelper.setActive(self.goLorentzLvUp, true)
		AudioMgr.instance:trigger(350022)
		TaskDispatcher.runDelay(self.onLorentzLvChangeDone, self, FightViewCardItem.LorentzLvChangeAnimDuration)

		return
	end

	if self.lorentzLvLoader then
		return
	end

	self.lorentzLvLoader = MultiAbLoader.New()

	self.lorentzLvLoader:addPath("ui/viewres/fight/card_lorentz_lvup.prefab")
	self.lorentzLvLoader:startLoad(self.onLorentzLvLoadDone, self)
end

function FightViewCardItem:onLorentzLvLoadDone()
	local assetItem = self.lorentzLvLoader:getFirstAssetItem()
	local prefab = assetItem:GetResource()

	self.goLorentzLvUp = gohelper.clone(prefab, self.go)

	self:playCardLevelChange_Lorentz(self._cardInfoMO)
end

function FightViewCardItem:onLorentzLvChangeDone()
	self:updateItem(self._cardInfoMO.uid, self._cardInfoMO.skillId, self._cardInfoMO)
	gohelper.setActive(self.goLorentzLvUp, false)
end

function FightViewCardItem:_refreshGray()
	if self._cardInfoMO and self._cardInfoMO.status == FightEnum.CardInfoStatus.STATUS_PLAYSETGRAY then
		gohelper.setActive(self._cardMask, true)

		local entityId = self._cardInfoMO.uid
		local skillId = self._cardInfoMO.skillId
		local skillCardLv = FightCardDataHelper.getSkillLv(entityId, skillId)
		local isBigSkill = FightCardDataHelper.isBigSkill(skillId)

		for i, v in ipairs(self._maskList) do
			if i < 4 then
				gohelper.setActive(v, i == skillCardLv)
			else
				gohelper.setActive(v, isBigSkill)
			end
		end
	else
		gohelper.setActive(self._cardMask, false)
	end
end

function FightViewCardItem:playCardAroundSetGray()
	self:_refreshGray()
end

function FightViewCardItem:playChangeRankFail(failType)
	if self._cardInfoMO then
		self:playCardLevelChange(self._cardInfoMO, self._cardInfoMO.skillId, failType)
	end
end

function FightViewCardItem:_refreshRouge2Music()
	gohelper.setActive(self.goTopLayout, true)

	if not self.showRouge2Music then
		gohelper.setActive(self.goRouge2Music, false)

		return
	end

	local canShowRouge2Music = self.handCardType == FightEnum.CardShowType.HandCard

	if not canShowRouge2Music then
		gohelper.setActive(self.goRouge2Music, false)

		return
	end

	if self._cardInfoMO then
		local musicNote = self._cardInfoMO.musicNote
		local musicType = musicNote and musicNote.type

		if not musicType or musicType == FightEnum.Rouge2MusicType.None then
			gohelper.setActive(self.goRouge2Music, false)

			return
		end

		local co = FightConfig.instance:getRouge2MusicCo(musicType)

		gohelper.setActive(self.goRouge2Music, true)
		UISpriteSetMgr.instance:setFightSprite(self.imageRouge2Music, co.icon1)
	end
end

function FightViewCardItem:setRouge2MusicActive(active)
	self.showRouge2Music = active

	self:_refreshRouge2Music()
end

function FightViewCardItem:setASFDActive(active)
	self.showASFD = active

	self:_refreshASFD()
end

function FightViewCardItem:_refreshASFD()
	gohelper.setActive(self.goTopLayout, true)

	if self.showASFD then
		local showASFD = true

		showASFD = self._cardInfoMO

		if self._cardInfoMO then
			if self._cardInfoMO.energy <= 0 then
				showASFD = false
			end

			gohelper.setActive(self.goASFD, showASFD)

			if showASFD then
				self.txtASFDEnergy.text = self._cardInfoMO.energy
			end
		end
	end
end

function FightViewCardItem:changeEnergy()
	gohelper.setActive(self.goTopLayout, true)

	if self.showASFD then
		local showASFD = true

		showASFD = self._cardInfoMO

		if self._cardInfoMO then
			if self._cardInfoMO.energy <= 0 then
				showASFD = false
			end

			gohelper.setActive(self.goASFD, showASFD)

			if showASFD then
				self.txtASFDEnergy.text = self._cardInfoMO.energy
				self.asfdAnimator = self.asfdAnimator or self.goASFD:GetComponent(gohelper.Type_Animator)

				self.asfdAnimator:Play("add", 0, 0)
			end
		end
	end
end

function FightViewCardItem:_allocateEnergyDone()
	gohelper.setActive(self.goTopLayout, true)

	if self.showASFD then
		local showASFD = true

		showASFD = self._cardInfoMO

		if self._cardInfoMO then
			if self._cardInfoMO.energy <= 0 then
				showASFD = false
			end

			gohelper.setActive(self.goASFD, showASFD)

			if showASFD then
				self.txtASFDEnergy.text = self._cardInfoMO.energy
				self.asfdAnimator = self.asfdAnimator or self.goASFD:GetComponent(gohelper.Type_Animator)

				self.asfdAnimator:Play("open", 0, 0)
			end
		end
	end
end

function FightViewCardItem:hideTopLayout()
	gohelper.setActive(self.goTopLayout, false)
end

function FightViewCardItem:showTopLayout()
	gohelper.setActive(self.goTopLayout, true)
end

function FightViewCardItem:playASFDAnim(animName)
	if self.goASFD.activeSelf then
		self.asfdAnimator = self.asfdAnimator or self.goASFD:GetComponent(gohelper.Type_Animator)

		self.asfdAnimator:Play(animName, 0, 0)
	end
end

function FightViewCardItem:_onCardLevelChangeFlowDone()
	self:updateItem(self._cardInfoMO.uid, self._cardInfoMO.skillId, self._cardInfoMO)
	FightController.instance:dispatchEvent(FightEvent.CardLevelChangeDone, self._cardInfoMO)
	self:detectShowBlueStar()
end

function FightViewCardItem:playCardAni(aniPath, aniname)
	self._cardAniName = aniname or UIAnimationName.Open

	self._loader:loadAsset(aniPath, self._onCardAniLoaded, self)
end

function FightViewCardItem:_onCardAniLoaded(success, loader)
	if not success then
		return
	end

	if not self._cardAniName then
		self:_hideAniEffect()

		return
	end

	self._cardAni.runtimeAnimatorController = loader:GetResource()
	self._cardAni.enabled = true
	self._cardAni.speed = FightModel.instance:getUISpeed()

	SLFramework.AnimatorPlayer.Get(self.go):Play(self._cardAniName, self.onCardAniFinish, self)
end

function FightViewCardItem:onCardAniFinish()
	self:_hideAniEffect()
	self:hideCardAppearEffect()
end

function FightViewCardItem:_hideAniEffect()
	self._cardAniName = nil
	self._cardAni.enabled = false

	gohelper.setActive(gohelper.findChild(self.go, "vx_balance"), false)
end

function FightViewCardItem:playAppearEffect()
	gohelper.setActive(self._cardAppearEffectRoot, true)

	if not self._appearEffect then
		if self._appearEffectLoadStart then
			return
		end

		self._appearEffectLoadStart = true

		self._loader:loadAsset("ui/viewres/fight/card_appear.prefab", self._onAppearEffectLoaded, self)
	else
		self:showAppearEffect()
	end
end

function FightViewCardItem:_onAppearEffectLoaded(success, loader)
	if not success then
		return
	end

	local tarPrefab = loader:GetResource()

	self._appearEffect = gohelper.clone(tarPrefab, self._cardAppearEffectRoot)

	gohelper.addChild(self._cardAppearEffectRoot.transform.parent.parent.gameObject, self._cardAppearEffectRoot)
	self:showAppearEffect()
end

function FightViewCardItem:showAppearEffect()
	local isBigSkill = FightCardDataHelper.isBigSkill(self.skillId)

	gohelper.setActive(gohelper.findChild(self._appearEffect, "nomal_skill"), not isBigSkill)
	gohelper.setActive(gohelper.findChild(self._appearEffect, "ultimate_skill"), isBigSkill)
end

function FightViewCardItem:hideCardAppearEffect()
	gohelper.setActive(self._cardAppearEffectRoot, false)
end

function FightViewCardItem:getASFDScreenPos()
	self.rectTrASFD = self.rectTrASFD or self.goASFD:GetComponent(gohelper.Type_RectTransform)

	return recthelper.uiPosToScreenPos2(self.rectTrASFD)
end

function FightViewCardItem:isDevicePowerCard()
	local skillId = self.skillId

	return FightHelper.checkIsDevicePowerCard(skillId)
end

function FightViewCardItem:setActiveRed(active)
	if gohelper.isNil(self.goRed) then
		self.ly_red_active = active

		return
	end

	gohelper.setActive(self.goRed, active and not self:isDevicePowerCard())
	self:refreshLyMaskActive()
end

function FightViewCardItem:setActiveBlue(active)
	if gohelper.isNil(self.goBlue) then
		self.ly_blue_active = active

		return
	end

	gohelper.setActive(self.goBlue, active and not self:isDevicePowerCard())
	self:refreshLyMaskActive()
end

function FightViewCardItem:setActiveBoth(active)
	if gohelper.isNil(self.goBoth) then
		self.ly_both_active = active

		return
	end

	gohelper.setActive(self.goBoth, active and not self:isDevicePowerCard())
	self:refreshLyMaskActive()
end

function FightViewCardItem:refreshLyMaskActive()
	local var_127_0 = self.goRed.activeInHierarchy

	if not self.goRed.activeInHierarchy then
		var_127_0 = self.goBlue.activeInHierarchy

		if not self.goBlue.activeInHierarchy then
			local showMask = self.goBoth.activeInHierarchy

			gohelper.setActive(self.goLyMask, showMask)
		end
	end
end

function FightViewCardItem:releaseEffectFlow()
	if self._cardLevelChangeFlow then
		self._cardLevelChangeFlow:unregisterDoneListener(self._onCardLevelChangeFlowDone, self)
		self._cardLevelChangeFlow:stop()

		self._cardLevelChangeFlow = nil
	end

	if self._dissolveFlow then
		self._dissolveFlow:stop()

		self._dissolveFlow = nil
	end

	if self._cardDisplayFlow then
		self._cardDisplayFlow:stop()

		self._cardDisplayFlow = nil
	end

	if self._cardDisplayEndFlow then
		self._cardDisplayEndFlow:stop()

		self._cardDisplayEndFlow = nil
	end

	if self._disappearFlow then
		if not gohelper.isNil(self.go) then
			gohelper.onceAddComponent(self.go, gohelper.Type_CanvasGroup).alpha = 1
		end

		self._disappearFlow:stop()

		self._disappearFlow = nil
	end
end

function FightViewCardItem:onDestroy()
	TaskDispatcher.cancelTask(self.onLorentzLvChangeDone, self)
	self.simageRouge2SkillIcon:UnLoadImage()
	self:clearDeviceAnim()

	if self.classComp then
		self.classComp:disposeSelf()

		self.classComp = nil
	end

	if self._loader then
		self._loader:disposeSelf()

		self._loader = nil
	end

	if self.hideVxLoader then
		self.hideVxLoader:dispose()

		self.hideVxLoader = nil
	end

	if self.lyLoader then
		self.lyLoader:dispose()

		self.lyLoader = nil
	end

	if self.lorentzEnchantVxLoader then
		self.lorentzEnchantVxLoader:dispose()

		self.lorentzEnchantVxLoader = nil
	end

	if self.unnamedUiLoader then
		self.unnamedUiLoader:dispose()

		self.unnamedUiLoader = nil
	end

	self:releaseEffectFlow()

	for skillCardLv, lvGO in pairs(self._lvGOs) do
		self._lvImgIcons[skillCardLv]:UnLoadImage()
	end

	self._tag:UnLoadImage()
	self:clearAlfEffect()
	self:clearUseCardCopyEffect()

	if self.heDuoNieUiLoader then
		self.heDuoNieUiLoader:dispose()

		self.heDuoNieUiLoader = nil
	end

	if self.heDuoNieCardRemoveEffectLoader then
		self.heDuoNieCardRemoveEffectLoader:dispose()

		self.heDuoNieCardRemoveEffectLoader = nil
	end

	self:clearHeDuoNieCardRemoveEffectCallbackList()
end

function FightViewCardItem:_hideAllEffect()
	self:_hideUpgradeEffects()
	self:_hideEnchantsEffect()
	gohelper.setActive(self.goPreDelete, false)
end

FightViewCardItem.AlfLoadStatus = {
	Loaded = 3,
	Loading = 2,
	None = 1
}

function FightViewCardItem:tryPlayAlfEffect()
	if not self._cardInfoMO then
		return
	end

	if not FightHeroALFComp.ALFSkillDict[self._cardInfoMO.clientData.custom_fromSkillId] then
		return
	end

	self.showAlfEffectIng = true

	FightController.instance:dispatchEvent(FightEvent.ALF_AddCardEffectAppear, self)

	if self.alfLoadStatus == FightViewCardItem.AlfLoadStatus.Loaded then
		self:_tryPlayAlfEffect()
	elseif self.alfLoadStatus == FightViewCardItem.AlfLoadStatus.Loading then
		-- block empty
	else
		self.alfLoadStatus = FightViewCardItem.AlfLoadStatus.Loading
		self.alfLoader = PrefabInstantiate.Create(self.tr.parent.gameObject)

		local res = FightHeroSpEffectConfig.instance:getAlfCardAddEffect()

		self.alfLoader:startLoad(res, self.onLoadedAlfEffect, self)
	end
end

function FightViewCardItem:onLoadedAlfEffect()
	self.goAlfAddCardEffect = self.alfLoader:getInstGO()
	self.goAlfAddCardAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.goAlfAddCardEffect)
	self.alfLoadStatus = FightViewCardItem.AlfLoadStatus.Loaded

	self:_tryPlayAlfEffect()
end

function FightViewCardItem:_tryPlayAlfEffect()
	if not self.goAlfAddCardAnimatorPlayer then
		return
	end

	gohelper.setActive(self.go, false)
	gohelper.setActive(self.goAlfAddCardEffect, true)
	self.goAlfAddCardAnimatorPlayer:Play("open", self.playAlfCloseAnim, self)
end

function FightViewCardItem:playAlfCloseAnim()
	self.goAlfAddCardAnimatorPlayer:Play("close", self.playAlfCloseAnimDone, self)
	TaskDispatcher.runDelay(self.showCardGo, self, 0.2 / FightModel.instance:getUISpeed())
end

function FightViewCardItem:showCardGo()
	gohelper.setActive(self.go, true)
	self:playCardAni(ViewAnim.FightCardAppear, "fightcard_apper")
end

function FightViewCardItem:playAlfCloseAnimDone()
	gohelper.setActive(self.goAlfAddCardEffect, false)

	self.showAlfEffectIng = false

	FightController.instance:dispatchEvent(FightEvent.ALF_AddCardEffectEnd, self)
end

function FightViewCardItem:showHightLightEffect(bShow)
	if self.highlightEffect then
		for i, v in ipairs(self.highlightEffect) do
			gohelper.setActive(v, bShow)
		end
	end
end

function FightViewCardItem:clearAlfEffect()
	if self.alfLoader then
		self.alfLoader:dispose()

		self.alfLoader = nil
	end

	self.alfLoadStatus = FightViewCardItem.AlfLoadStatus.None
	self.goAlfAddCardEffect = nil

	if self.goAlfAddCardAnimatorPlayer then
		self.goAlfAddCardAnimatorPlayer:Stop()

		self.goAlfAddCardAnimatorPlayer = nil
	end

	if self.rouge2TreasureLoader then
		self.rouge2TreasureLoader:dispose()

		self.rouge2TreasureLoader = nil
	end

	if self.rouge2DoubleLoader then
		self.rouge2DoubleLoader:dispose()

		self.rouge2DoubleLoader = nil
	end

	TaskDispatcher.cancelTask(self.showCardGo, self)
end

function FightViewCardItem:tryPlayUseCardCopyEffect()
	self.showUseCardCopyEffectIng = true

	if self.useCardCopyLoadStatus == FightViewCardItem.AlfLoadStatus.Loaded then
		self:_tryPlayUseCardCopyEffect()
	elseif self.useCardCopyLoadStatus == FightViewCardItem.AlfLoadStatus.Loading then
		-- block empty
	else
		self.useCardCopyLoadStatus = FightViewCardItem.AlfLoadStatus.Loading
		self.useCardCopyLoader = PrefabInstantiate.Create(self.tr.parent.gameObject)

		local res = "ui/viewres/fight/card_alf.prefab"

		self.useCardCopyLoader:startLoad(res, self.onLoadedUseCardCopyEffect, self)
	end
end

function FightViewCardItem:onLoadedUseCardCopyEffect()
	self.goUseCardCopyEffect = self.useCardCopyLoader:getInstGO()
	self.goUseCardCopyAddCardAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.goUseCardCopyEffect)
	self.useCardCopyLoadStatus = FightViewCardItem.AlfLoadStatus.Loaded

	self:_tryPlayUseCardCopyEffect()
end

function FightViewCardItem:_tryPlayUseCardCopyEffect()
	if not self.goUseCardCopyAddCardAnimatorPlayer then
		return
	end

	gohelper.setActive(self.go, false)
	gohelper.setActive(self.goUseCardCopyEffect, true)
	self.goUseCardCopyAddCardAnimatorPlayer:Play("open", self.playUseCardCopyCloseAnim, self)
end

function FightViewCardItem:playUseCardCopyCloseAnim()
	self.goUseCardCopyAddCardAnimatorPlayer:Play("close", self.playUseCardCopyCloseAnimDone, self)
	TaskDispatcher.runDelay(self.showCardGo, self, 0.2 / FightModel.instance:getUISpeed())
end

function FightViewCardItem:playUseCardCopyCloseAnimDone()
	gohelper.setActive(self.goUseCardCopyEffect, false)

	self.showAlfEffectIng = false
end

function FightViewCardItem:clearUseCardCopyEffect()
	if self.useCardCopyLoader then
		self.useCardCopyLoader:dispose()

		self.useCardCopyLoader = nil
	end

	self.useCardCopyLoadStatus = FightViewCardItem.AlfLoadStatus.None
	self.goUseCardCopyEffect = nil

	if self.goUseCardCopyAddCardAnimatorPlayer then
		self.goUseCardCopyAddCardAnimatorPlayer:Stop()

		self.goUseCardCopyAddCardAnimatorPlayer = nil
	end

	TaskDispatcher.cancelTask(self.showCardGo, self)
end

function FightViewCardItem:setPreLv(preLv)
	if self.handCardType == FightEnum.CardShowType.Operation or self.handCardType == FightEnum.CardShowType.HandCard then
		self.preLv = preLv

		self:refreshStar()
	end
end

function FightViewCardItem:refreshStar()
	local skillCardLv = FightCardDataHelper.getSkillLv(self.entityId, self.skillId)
	local showStar = skillCardLv < FightEnum.UniqueSkillCardLv and skillCardLv > 0

	gohelper.setActive(self._starGO, showStar)

	self._starCanvas.alpha = 1

	if not showStar then
		return
	end

	for i, startGO in ipairs(self._innerStartGOs) do
		gohelper.setActive(startGO, i == skillCardLv)

		if self._starItemCanvas[i] then
			self._starItemCanvas[i].alpha = 1
		end

		if i == skillCardLv then
			local preLvGo = self._innerStarPreLvGoList[i]

			if preLvGo then
				gohelper.setActive(preLvGo, self.preLv > 0)

				local lvList = self._innerStarPreLvGoDict[i]

				if lvList then
					for index, lvGo in ipairs(lvList) do
						gohelper.setActive(lvGo, index <= self.preLv)
					end
				end
			end
		end
	end
end

function FightViewCardItem:isDeviceAreaCard()
	return false
end

function FightViewCardItem:isDeviceCard()
	return FightHelper.checkIsDevicePowerCard(self.skillId)
end

function FightViewCardItem:playCardAnim(animName, callback, callbackObj)
	self:doAnimCallback()

	self.animCallback = callback
	self.animCallbackObj = callbackObj
	self.cardAnimName = animName

	self._loader:loadAsset(ViewAnim.FightCardBalance, self.onDefaultAnimLoadDone, self)
end

function FightViewCardItem:onDefaultAnimLoadDone(success, loader)
	if not success then
		self:onCardAnimDone()

		return
	end

	if not self.cardAnimName then
		self:onCardAnimDone()

		return
	end

	self._cardAni.runtimeAnimatorController = loader:GetResource()
	self._cardAni.enabled = true
	self.animatorPlayer = self.animatorPlayer or SLFramework.AnimatorPlayer.Get(self.go)
	self._cardAni.speed = FightModel.instance:getUISpeed()

	if not self.animatorPlayer.isActiveAndEnabled then
		self:onCardAnimDone()

		return
	end

	self.animatorPlayer:Play(self.cardAnimName, self.onCardAnimDone, self)

	self.cardAnimName = nil
end

function FightViewCardItem:onCardAnimDone()
	self._cardAni.enabled = false

	self:doAnimCallback()
end

function FightViewCardItem:doAnimCallback()
	local callback = self.animCallback
	local callbackObj = self.animCallbackObj

	self.animCallback = nil
	self.animCallbackObj = nil

	if callback then
		self.animCallback(callbackObj)
	end
end

local DeviceAnimEventName = "fly"

function FightViewCardItem:playDeviceCardAnim(eventCallback, eventCallbackObj)
	self:initDeviceAnimNodeList()

	local curCareer = self:getCurDeviceAddCareer()

	for career, go in pairs(self.deviceAnimNodeDict) do
		gohelper.setActive(go, career == curCareer)
	end

	self.deviceAnimEventCallback = eventCallback
	self.deviceAnimEventCallbackObj = eventCallbackObj
	self.cardAnimEvent = self.cardAnimEvent or self.go:GetComponent(gohelper.Type_AnimationEventWrap)

	self.cardAnimEvent:AddEventListener(DeviceAnimEventName, self.onTriggerDeviceFlyEvent, self)
	self.playCardAnim(self, "light", self.onPlayDeviceAnimDone, self)

	for _, lvGO in pairs(self._lvGOs) do
		gohelper.setActiveCanvasGroup(lvGO, false)
	end
end

function FightViewCardItem:onTriggerDeviceFlyEvent()
	if self.deviceAnimEventCallback then
		self.deviceAnimEventCallback(self.deviceAnimEventCallbackObj, DeviceAnimEventName)
	end
end

function FightViewCardItem:onPlayDeviceAnimDone()
	if self.deviceAnimNodeDict then
		for _, go in pairs(self.deviceAnimNodeDict) do
			gohelper.setActive(go, false)
		end
	end

	self.cardAnimEvent:RemoveAllEventListener()

	local eventCallback = self.deviceAnimEventCallback
	local eventCallbackObj = self.deviceAnimEventCallbackObj

	self.deviceAnimEventCallback = nil
	self.deviceAnimEventCallbackObj = nil

	if eventCallback then
		self.deviceAnimEventCallback(eventCallbackObj, "finish")
	end

	if self.imgFrontBgNormal then
		SLFramework.UGUI.GuiHelper.SetColor(self.imgFrontBgNormal, "#FFFFFF")
	end

	if self.imgFrontBgBigSkill then
		SLFramework.UGUI.GuiHelper.SetColor(self.imgFrontBgBigSkill, "#FFFFFF")
	end
end

function FightViewCardItem:clearDeviceAnim()
	if self.cardAnimEvent then
		self.cardAnimEvent:RemoveAllEventListener()
	end

	self._cardAni.enabled = false
	self.deviceAnimEventCallback = nil
	self.deviceAnimEventCallbackObj = nil
end

function FightViewCardItem:initDeviceAnimNodeList()
	self.deviceAnimNodeDict = self:getUserDataTb_()

	local careerType = CharacterEnum.CareerType

	self.deviceAnimNodeDict[0] = gohelper.findChild(self.go, "vx_device/node_colorful")
	self.deviceAnimNodeDict[careerType.Yan] = gohelper.findChild(self.go, "vx_device/node_yellow")
	self.deviceAnimNodeDict[careerType.Xing] = gohelper.findChild(self.go, "vx_device/node_blue")
end

function FightViewCardItem:getCurDeviceAddCareer()
	local skillId = self.skillId
	local skillCo = skillId and lua_skill.configDict[skillId]

	if not skillCo then
		return CharacterEnum.CareerType.Xing
	end

	local behaviourId = FightEnum.BehaviourId.AddDevicePower

	for i = 1, FightEnum.MaxBehavior do
		local behavior = skillCo["behavior" .. i]

		if not string.nilorempty(behavior) then
			local array = FightStrUtil.instance:getSplitString2Cache(behavior, true)

			for _, behaviourArray in ipairs(array) do
				if behaviourArray[1] == behaviourId then
					return behaviourArray[2]
				end
			end
		end
	end

	return CharacterEnum.CareerType.Xing
end

return FightViewCardItem
