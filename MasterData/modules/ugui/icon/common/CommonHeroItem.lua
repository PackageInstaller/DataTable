-- chunkname: @modules/ugui/icon/common/CommonHeroItem.lua

module("modules.ugui.icon.common.CommonHeroItem", package.seeall)

local CommonHeroItem = class("CommonHeroItem", ListScrollCell)

function CommonHeroItem:init(go)
	self.go = go
	self._btnClick = gohelper.getClick(go)
	self._lvObj = gohelper.findChild(go, "lv")
	self._lvTxt = gohelper.findChildText(go, "lv/lvltxt")
	self._lvTxtEn = gohelper.findChildText(go, "lv/lv")
	self._nameCnTxt = gohelper.findChildText(go, "namecn")
	self._nameEnTxt = gohelper.findChildText(go, "nameen")
	self._newObj = gohelper.findChild(go, "new")
	self._gofavor = gohelper.findChild(go, "favor")
	self._rankObj = gohelper.findChild(go, "rankobj")
	self._rankObjEmpty = gohelper.findChild(go, "verticalList/lvnum/rankobj_empty") or gohelper.findChild(go, "rankobj")
	self._breakObj = gohelper.findChild(go, "breakobj")
	self._maskgray = gohelper.findChild(go, "maskgray")
	self._cardIcon = gohelper.findChild(go, "mask/charactericon") or gohelper.findChild(go, "charactericon")
	self._careerIcon = gohelper.findChildImage(go, "career")
	self._injury1 = gohelper.findChild(go, "deephurt")
	self._gohurtcn = gohelper.findChild(go, "deephurt/hurtcn")
	self._gohurten = gohelper.findChild(go, "deephurt/hurten")
	self._txthurtcn = gohelper.findChildTextMesh(go, "deephurt/hurtcn")
	self._txthurten = gohelper.findChildTextMesh(go, "deephurt/hurten")
	self._gorestrict = gohelper.findChild(go, "restrict")
	self._selectframe = gohelper.findChild(go, "selectframe")
	self._injuryselectframe = gohelper.findChild(go, "injuryselectframe")
	self._front = gohelper.findChildImage(go, "mask/front") or gohelper.findChildImage(go, "front")
	self._gobuff = gohelper.findChild(go, "#go_buff")
	self._imagebuff = gohelper.findChildImage(go, "#go_buff/#image_buff") or gohelper.findChildImage(go, "#image_buff")
	self._simagebufftuan = gohelper.findChildSingleImage(go, "#go_buff/#simage_bufftuan") or gohelper.findChildSingleImage(go, "#simage_bufftuan")
	self._goheroitemreddot = gohelper.findChild(go, "#go_heroitemreddot")
	self._goexskill = gohelper.findChild(go, "#go_exskill")
	self._imageexskill = gohelper.findChildImage(go, "#go_exskill/#image_exskill")
	self._inteam = gohelper.findChild(go, "inteam")
	self._current = gohelper.findChild(go, "current")
	self._aid = gohelper.findChild(go, "aid")
	self._gochoose = gohelper.findChild(go, "#go_choose")
	self._go1st = gohelper.findChild(go, "#go_choose/#go_1st")
	self._go2nd = gohelper.findChild(go, "#go_choose/#go_2nd")
	self._go3rd = gohelper.findChild(go, "#go_choose/#go_3rd")
	self._goeffect = gohelper.findChild(go, "effect")
	self._gorareEffect1 = gohelper.findChild(go, "effect/r")
	self._gorareEffect2 = gohelper.findChild(go, "effect/sr")
	self._gorareEffect3 = gohelper.findChild(go, "effect/ssr")
	self._goTrialTag = gohelper.findChild(go, "trialTag")
	self._txtTrialTag = gohelper.findChildTextMesh(go, "trialTag/#txt_trialTag")
	self._goTrialRepeat = gohelper.findChild(go, "trialRepeat")
	self._txttrialRepeat = gohelper.findChildText(go, "trialRepeat/repeatcn")
	self._animRepeat = self._goTrialRepeat:GetComponent(typeof(UnityEngine.Animator))

	self:_initObj()

	self._commonHeroCard = CommonHeroCard.create(self._cardIcon, self.__cname)
	self._goSeasonMask = gohelper.findChild(go, "seasonmask")
	self._goCenterTxt = gohelper.findChild(go, "centerTxt")
	self._txtCenterTxt = gohelper.findChildTextMesh(go, "centerTxt/txtcn")
	self.goLost = gohelper.findChild(go, "lost")
	self.rootAnim = gohelper.findChildAnim(go, "")
end

function CommonHeroItem:_initObj()
	if self._view then
		if not self._view.viewContainer then
			local c = self.viewContainer

			self._sp = CharacterSpNameLvRank.s_create(self, gohelper.findChild(self.go, "sp"), c):bindName0(self._nameCnTxt):bindName0En(self._nameEnTxt):simpleBindSpNameWithBg():bindLv0(CharacterLv.s_create(self, self._lvObj, c)):bindRank0(CharacterRank.s_create(self, self._rankObj, c))

			if self._rankObjEmpty ~= self._rankObj then
				self._sp:rank0():bindRankEmpty(CharacterRank.s_create(self, self._rankObjEmpty, c))
			end

			self._hideFavor = false

			if self._breakObj then
				self._breakImgs = {}

				for i = 1, 6 do
					self._breakImgs[i] = gohelper.findChildImage(self._breakObj, "break" .. tostring(i))
				end
			end

			self._rareEffectGOs = self:getUserDataTb_()

			table.insert(self._rareEffectGOs, self._gorareEffect1)
			table.insert(self._rareEffectGOs, self._gorareEffect2)
			table.insert(self._rareEffectGOs, self._gorareEffect3)

			for k, v in ipairs(self._rareEffectGOs) do
				gohelper.setActive(v, false)
			end

			self._callback = nil
			self._callbackObj = nil

			gohelper.setActive(self._injury1, false)
			gohelper.setActive(self._gorestrict, false)
			gohelper.setActive(self._selectframe, false)
			gohelper.setActive(self._injuryselectframe, false)
			gohelper.setActive(self._gobuff, false)
			gohelper.setActive(self._inteam, false)
			gohelper.setActive(self._current, false)
			gohelper.setActive(self._aid, false)
			gohelper.setActive(self._gochoose, false)
			self:setRankObjActive(true)
			gohelper.setActive(self._goTrialTag, false)
			gohelper.setActive(self._goTrialRepeat, false)
			gohelper.setActive(self._goCenterTxt, false)

			self.injuryAnim = self._injury1:GetComponent(typeof(UnityEngine.Animator))
			self.exSkillFillAmount = {
				0.2,
				0.4,
				0.6,
				0.79,
				1
			}

			self:isShowSeasonMask(false)
			self:setTrialRepeatCn(luaLang("p_commonheroitemnew_repeat"))
		end
	end
end

function CommonHeroItem:addClickListener(callback, callbackObj)
	self._callback = callback
	self._callbackObj = callbackObj
end

function CommonHeroItem:addClickDownListener(callback, callbackObj)
	self._clickDownCallback = callback
	self._clickDownCallbackObj = callbackObj
end

function CommonHeroItem:addClickUpListener(callback, callbackObj)
	self._clickUpCallback = callback
	self._clickUpCallbackObj = callbackObj
end

function CommonHeroItem:addEventListeners()
	self._btnClick:AddClickListener(self._onItemClick, self)
	self._btnClick:AddClickDownListener(self._onItemClickDown, self)
	self._btnClick:AddClickUpListener(self._onItemClickUp, self)
end

function CommonHeroItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
	self._btnClick:RemoveClickUpListener()
	self._btnClick:RemoveClickDownListener()
end

function CommonHeroItem:_onItemClick()
	if self._callback then
		if self._callbackObj then
			self._callback(self._callbackObj, self._mo)
		else
			self._callback(self._mo)
		end
	end
end

function CommonHeroItem:_onItemClickDown()
	if self._clickDownCallback and self._clickDownCallbackObj then
		self._clickDownCallback(self._clickDownCallbackObj)
	end
end

function CommonHeroItem:_onItemClickUp()
	if self._clickUpCallback and self._clickUpCallbackObj then
		self._clickUpCallback(self._clickUpCallbackObj)
	end
end

function CommonHeroItem:setKeepAnim()
	self.rootAnim.keepAnimatorStateOnDisable = true
end

function CommonHeroItem:setLevel(level, heroId)
	local showLevel

	self._sp:setLv(heroId and heroId == self._mo.heroId and level or self._mo.level)
end

function CommonHeroItem:setTrialTxt(txt)
	if txt then
		gohelper.setActive(self._goTrialTag, true)

		self._txtTrialTag.text = txt
	else
		gohelper.setActive(self._goTrialTag, false)
	end
end

function CommonHeroItem:setBalanceLv(level)
	local showLv, showRank = HeroConfig.instance:getShowLevel(level)

	self._sp:setLv(showLv)
	self._sp:setLvColor("#bfdaff")
	self:_fillStarContent(self._mo.config.rare, showRank, true)
end

function CommonHeroItem:setTrialRepeat(isRepeat)
	gohelper.setActive(self._goTrialRepeat, isRepeat)
end

function CommonHeroItem:setRepeatAnimFinish()
	if not self._goTrialRepeat.activeSelf then
		return
	end

	self._animRepeat:Play(UIAnimationName.Open, 0, 1)
end

function CommonHeroItem:getIsRepeat()
	return self._goTrialRepeat.activeSelf
end

function CommonHeroItem:hideFavor(hide)
	self._hideFavor = hide
end

function CommonHeroItem:onUpdateMO(mo)
	self._mo = mo

	local level = CharacterModel.instance:getFakeLevel(self._mo.heroId) or mo.level
	local showLv, showRank = HeroConfig.instance:getShowLevel(level)

	self._sp:onUpdateMO({
		heroId = self._mo.heroId,
		level = showLv,
		rank = showRank
	}):simpleAutoSet(mo:getHeroName())
	self._sp:setLvColor("#E9E9E9")

	if self._newObj then
		gohelper.setActive(self._newObj, mo.isNew)
	end

	if self._gofavor then
		gohelper.setActive(self._gofavor, mo.isFavor and not self._hideFavor)
	end

	if self._breakObj then
		self:_fillBreakContent(mo.exSkillLevel)
	end

	self:_fillStarContent(mo.config.rare, mo.rank)
	self:updateHero()
	self:_updateExSkill()
end

function CommonHeroItem:setAdventureBuff(buffId)
	return
end

function CommonHeroItem:setHeroGroupType()
	self._heroGroupType = true
end

function CommonHeroItem:updateHero()
	if self._heroGroupType then
		UISpriteSetMgr.instance:setHeroGroupSprite(self._front, "bg_pz00" .. tostring(CharacterEnum.Color[self._mo.config.rare]))
	else
		UISpriteSetMgr.instance:setCommonSprite(self._front, "bg_pz00" .. tostring(CharacterEnum.Color[self._mo.config.rare]))
		self:_showRareEffect(CharacterEnum.Color[self._mo.config.rare])
	end

	UISpriteSetMgr.instance:setCommonSprite(self._careerIcon, "lssx_" .. tostring(self._mo.config.career))

	local heroSkin = HeroModel.instance:getByHeroId(self._mo.heroId)
	local skinConfig = SkinConfig.instance:getSkinCo(self._mo.skin or heroSkin.skin)

	if not skinConfig then
		logError("找不到皮肤配置, id: " .. tostring(heroSkin.skin))

		return
	end

	self._commonHeroCard:onUpdateMO(skinConfig)
end

function CommonHeroItem:_updateExSkill()
	if self._mo.exSkillLevel <= 0 then
		gohelper.setActive(self._goexskill, false)

		return
	end

	gohelper.setActive(self._goexskill, true)

	self._imageexskill.fillAmount = self.exSkillFillAmount[self._mo.exSkillLevel] or 1
end

function CommonHeroItem:setExSkillActive(active)
	gohelper.setActive(self._goexskill, active)
end

function CommonHeroItem:_showRareEffect(rare)
	for i = 1, 3 do
		gohelper.setActive(self._rareEffectGOs[i], rare - 3 == i)
	end
end

function CommonHeroItem:setEffectVisible(value)
	gohelper.setActive(self._goeffect, value)
end

function CommonHeroItem:setInjuryTxtVisible(value)
	gohelper.setActive(self._injury1, value)
end

function CommonHeroItem:setInjury(injury)
	gohelper.setActive(self._injury1, injury)
	self:setDamage(injury)
end

function CommonHeroItem:setInjuryText(textCn, textEn)
	if self._txthurtcn then
		self._txthurtcn.text = textCn
	end

	if self._txthurten then
		self._txthurten.text = textEn
	end
end

function CommonHeroItem:setDamage(injury)
	ZProj.UGUIHelper.SetGrayscale(self._careerIcon.gameObject, injury)
	ZProj.UGUIHelper.SetGrayscale(self._front.gameObject, injury)

	self._isInjury = injury

	if injury then
		if not CommonHeroHelper.instance:getGrayState(self._mo.config.id) then
			TaskDispatcher.runDelay(self.onInjuryAnimFinished, self, 0.5)

			self.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.8, self.setGrayFactor, nil, self)

			CommonHeroHelper.instance:setGrayState(self._mo.config.id, true)
		else
			self._commonHeroCard:setGrayFactor(1)
			self._commonHeroCard:setGrayScale(true)
			self:onInjuryAnimFinished()
		end
	else
		if self.tweenid then
			ZProj.TweenHelper.KillById(self.tweenid)
			TaskDispatcher.cancelTask(self.onInjuryAnimFinished, self)
		end

		self._commonHeroCard:setGrayScale(false)
	end
end

function CommonHeroItem:setRestrict(isRestrict)
	gohelper.setActive(self._gorestrict, isRestrict)

	self._isInjury = false
	self._isRestrict = isRestrict

	gohelper.setActive(self._gohurtcn, not isRestrict)
	gohelper.setActive(self._gohurten, not isRestrict)
end

function CommonHeroItem:isRestrict()
	return self._isRestrict
end

function CommonHeroItem:setGrayFactor(value)
	self._commonHeroCard:setGrayFactor(value)
end

function CommonHeroItem:onInjuryAnimFinished()
	self.injuryAnim:Play(UIAnimationName.Idle, 0, 1)
end

function CommonHeroItem:setSelect(select)
	if self._isRestrict then
		gohelper.setActive(self._injuryselectframe, false)
		gohelper.setActive(self._selectframe, false)

		return
	end

	if self._isInjury then
		gohelper.setActive(self._injuryselectframe, select)
	else
		gohelper.setActive(self._selectframe, select)
	end
end

function CommonHeroItem:setSelectFrameSize(width, height, x, y)
	local trans = self._selectframe.transform

	recthelper.setAnchor(trans, x, y)
	recthelper.setWidth(trans, width)
	recthelper.setHeight(trans, height)
end

function CommonHeroItem:setLevelContentShow(isShow)
	self._sp:setActiveLvOnly(isShow)
end

function CommonHeroItem:setNameContentShow(isShow)
	self._sp:setActiveNameOnly(isShow)
end

function CommonHeroItem:setRedDotShow(show)
	if self._mo.isNew then
		show = false
	end

	gohelper.setActive(self._goheroitemreddot, show)
end

function CommonHeroItem:setInteam(value)
	gohelper.setActive(self._inteam, false)
	gohelper.setActive(self._current, false)
	gohelper.setActive(self._aid, false)

	if value == 1 then
		gohelper.setActive(self._inteam, true)
	elseif value == 2 then
		gohelper.setActive(self._current, true)
	elseif value == 3 then
		gohelper.setActive(self._aid, true)
	end
end

function CommonHeroItem:setChoose(value)
	gohelper.setActive(self._gochoose, value)
	gohelper.setActive(self._go1st, false)
	gohelper.setActive(self._go2nd, false)
	gohelper.setActive(self._go3rd, false)

	if value == 1 then
		gohelper.setActive(self._go1st, true)
	elseif value == 2 then
		gohelper.setActive(self._go2nd, true)
	elseif value == 3 then
		gohelper.setActive(self._go3rd, true)
	end
end

function CommonHeroItem:setNewShow(isShow)
	if self._newObj then
		gohelper.setActive(self._newObj, isShow)
	end
end

function CommonHeroItem:isShowSeasonMask(isShow)
	if gohelper.isNil(self._goSeasonMask) then
		return
	end

	gohelper.setActive(self._goSeasonMask, isShow)
end

function CommonHeroItem:_fillBreakContent(value)
	for i = 1, 6 do
		if i <= value then
			SLFramework.UGUI.GuiHelper.SetColor(self._breakImgs[i], "#d7a93d")
		else
			SLFramework.UGUI.GuiHelper.SetColor(self._breakImgs[i], "#626467")
		end
	end
end

function CommonHeroItem:_fillStarContent(rare, rank, isBalance)
	self:_fillStarContentColor(rare, rank, isBalance and "#a9c7f1" or "#F6F3EC")
end

function CommonHeroItem:_fillStarContentColor(rare, rank, color)
	self._sp:setRankColor(rank, color)
end

function CommonHeroItem:_setTranScale(paramName, scaleX, scaleY, scaleZ)
	if not self[paramName] then
		return
	end

	transformhelper.setLocalScale(self[paramName].transform, scaleX or 1, scaleY or 1, scaleZ or 1)
end

function CommonHeroItem:_setTxtPos(paramName, posX, posY)
	if not self[paramName] then
		return
	end

	recthelper.setAnchor(self[paramName].transform, posX, posY)
end

function CommonHeroItem:_setTxtSizeScale(paramName, ratioX, ratioY)
	if not self[paramName] then
		return
	end

	local sizeX = self[paramName].transform.sizeDelta.x * ratioX
	local sizeY = self[paramName].transform.sizeDelta.y * ratioY

	self[paramName].transform.sizeDelta = Vector2(sizeX, sizeY)
end

function CommonHeroItem:setRankObjActive(active)
	self._sp:setActiveRankOnly(active)
end

function CommonHeroItem:setCenterTxt(txt)
	if txt then
		gohelper.setActive(self._goCenterTxt, true)

		self._txtCenterTxt.text = txt
	else
		gohelper.setActive(self._goCenterTxt, false)
	end
end

function CommonHeroItem:setLost(isLost)
	gohelper.setActive(self.goLost, isLost)
	self:setDamage(isLost)
end

function CommonHeroItem:onDestroy()
	if self._simagebufftuan then
		self._simagebufftuan:UnLoadImage()

		self._simagebufftuan = nil
	end

	self._callback = nil
	self._callbackObj = nil
	self._careerIcon = nil
	self._front = nil
	self._frame = nil

	TaskDispatcher.cancelTask(self.onInjuryAnimFinished, self)

	if self.tweenid then
		ZProj.TweenHelper.KillById(self.tweenid)
	end

	GameUtil.onDestroyViewMember(self, "_sp")
end

function CommonHeroItem:_setTxtWidth(paramName, width)
	if not self[paramName] then
		return
	end

	recthelper.setWidth(self[paramName].transform, width or 0)
end

function CommonHeroItem:setStyle_HeroGroupEdit()
	if not self._sp:mo() then
		self._sp:regSetStyleAfterSetData(self.setStyle_HeroGroupEdit, self)

		return
	end

	self._sp:setScaleHeroName(1.25, 1.25)
	self._sp:setScaleHeroSpName(1.25, 1.25)
	self._sp:setScaleLv(1.25, 1.25)
	self._sp:setScaleRank(0.22, 0.22)

	local bOldPattern = self._sp:bOldPattern()

	if bOldPattern then
		self._sp:setPosNameCn(0.55, 68.9)
		self._sp:setPosNameEn(0.55, 41.1)
		self._sp:setPosLv(1.7, 82)
		self._sp:setPosRank(1.7, -107.7)
	end

	self._sp:setSizeScaleNameCn(0.8, 1)
end

function CommonHeroItem:setStyle_SeasonPickAssist()
	if not self._sp:mo() then
		self._sp:regSetStyleAfterSetData(self.setStyle_SeasonPickAssist, self)

		return
	end

	self._sp:setWidthNameCn(205)
	self._sp:setScaleHeroName(1, 1)
	self._sp:setScaleLv(1, 1)
	self._sp:setScaleRank(0.18, 0.18)

	local bOldPattern = self._sp:bOldPattern()

	if bOldPattern then
		self._sp:setPosLv(1.7, 178.6)
		self._sp:setPosRank(2, -37)
		self._sp:setPosNameCn(0.55, 153.4)
		self._sp:setPosNameEn(0.55, 124.3)
	end

	self:_setTxtPos("_goexskill", 1.7, -170)
end

function CommonHeroItem:setStyle_RougePickAssist()
	if not self._sp:mo() then
		self._sp:regSetStyleAfterSetData(self.setStyle_RougePickAssist, self)

		return
	end

	self._sp:setWidthNameCn(205)
	self._sp:setScaleHeroName(1, 1)
	self._sp:setScaleLv(1, 1)
	self._sp:setScaleRank(0.2, 0.2)
end

function CommonHeroItem:setStyle_CharacterBackpack()
	if not self._sp:mo() then
		self._sp:regSetStyleAfterSetData(self.setStyle_CharacterBackpack, self)

		return
	end

	self._sp:setWidthNameCn(205)
	self._sp:setScaleHeroName(1, 1)
	self._sp:setScaleLv(1, 1)
	self._sp:setScaleRank(0.18, 0.18)

	local bOldPattern = self._sp:bOldPattern()

	if bOldPattern then
		self._sp:setPosNameCn(0.99, 68.9)
		self._sp:setPosNameEn(1.1, 42.29)
		self._sp:setPosLv(2.02, 75)
		self._sp:setPosRank(1.06, -127.22)
	end
end

function CommonHeroItem:setStyle_SurvivalHeroGroupEdit()
	if not self._sp:mo() then
		self._sp:regSetStyleAfterSetData(self.setStyle_SurvivalHeroGroupEdit, self)

		return
	end

	self:setStyle_HeroGroupEdit()
end

function CommonHeroItem:setTrialRepeatCn(txt)
	if not string.nilorempty(txt) then
		self._txttrialRepeat.text = txt
	end
end

return CommonHeroItem
