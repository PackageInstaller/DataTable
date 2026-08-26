-- chunkname: @modules/logic/rouge/map/view/fightsucc/RougeFightSuccessView.lua

module("modules.logic.rouge.map.view.fightsucc.RougeFightSuccessView", package.seeall)

local RougeFightSuccessView = class("RougeFightSuccessView", BaseView)

function RougeFightSuccessView:onInitView()
	self._gospineContainer = gohelper.findChild(self.viewGO, "left/#go_spineContainer")
	self._gospine = gohelper.findChild(self.viewGO, "left/#go_spineContainer/#go_spine")
	self.uiSpine = GuiModelAgent.Create(self._gospine, true)

	self.uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.Normal, self.viewName)
	self.uiSpine:useRT()
	self.uiSpine:setImgPos(0)

	self._txtsayCn = gohelper.findChildText(self.viewGO, "left/layout/txtSayCn")
	self._txtsayEn = gohelper.findChildText(self.viewGO, "left/layout/txtSayEn")
	self._btndata = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_data")
	self._txtepisodeNameEn = gohelper.findChildText(self.viewGO, "right/#txt_episodeNameEn")
	self._txtepisodeName = gohelper.findChildText(self.viewGO, "right/#txt_episodeName")
	self._txtexp = gohelper.findChildText(self.viewGO, "right/rouge/exp/#txt_exp")
	self._sliderprogress = gohelper.findChildSlider(self.viewGO, "right/rouge/exp/#slider_progress")
	self._txtaddexp = gohelper.findChildText(self.viewGO, "right/rouge/exp/#slider_progress/#txt_addexp")
	self._imageAddExp = gohelper.findChildImage(self.viewGO, "right/rouge/exp/#slider_progress/#image_addexp")
	self._txtlv = gohelper.findChildText(self.viewGO, "right/rouge/exp/#txt_lv")
	self._imagefaction = gohelper.findChildImage(self.viewGO, "right/rouge/exp/faction/#image_faction")
	self._goheroitem = gohelper.findChild(self.viewGO, "right/rouge/role/layout/#go_heroitem")
	self._sliderhp = gohelper.findChildSlider(self.viewGO, "right/rouge/role/layout/heroitem/#slider_hp")
	self._simagerolehead = gohelper.findChildSingleImage(self.viewGO, "right/rouge/role/layout/heroitem/hero/#simage_rolehead")
	self._godead = gohelper.findChild(self.viewGO, "right/rouge/role/layout/heroitem/#go_dead")
	self._txtcollectionnum = gohelper.findChildText(self.viewGO, "right/rouge/reward/collection/#txt_collectionnum")
	self._txtcoinnum = gohelper.findChildText(self.viewGO, "right/rouge/reward/coin/#txt_coinnum")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeFightSuccessView:addEvents()
	self._btndata:AddClickListener(self._btndataOnClick, self)
end

function RougeFightSuccessView:removeEvents()
	self._btndata:RemoveClickListener()
end

function RougeFightSuccessView:_btndataOnClick()
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function RougeFightSuccessView:_editableInitView()
	self.rectTrImageAddExp = self._imageAddExp:GetComponent(gohelper.Type_RectTransform)
	self.sliderRectTr = self._sliderprogress:GetComponent(gohelper.Type_RectTransform)
	self.sliderWidth = recthelper.getWidth(self.sliderRectTr)
	self.bgClick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "bg")

	self.bgClick:AddClickListener(self.onClickBg, self)

	self.spineTr = self._gospine.transform
	self._txtsayCn.text = ""
	self._txtsayEn.text = ""

	gohelper.setActive(self._goheroitem, false)
end

function RougeFightSuccessView:onClickBg()
	if self.uiSpine then
		self.uiSpine:stopVoice()
	end

	self:closeThis()
end

function RougeFightSuccessView:onUpdateParam()
	return
end

function RougeFightSuccessView:onOpen()
	self:refreshLeft()
	self:refreshRight()
end

function RougeFightSuccessView:refreshLeft()
	self:refreshSpine()
end

function RougeFightSuccessView:refreshRight()
	self:refreshEpisodeInfo()
	self:refreshRougeInfo()
end

function RougeFightSuccessView:refreshSpine()
	local randomEntityMo = self:getRandomEntityMo()

	self.skinCO = self:getSkinCo(randomEntityMo)
	self.randomHeroId = randomEntityMo.modelId
	self.randomSkinId = randomEntityMo.skin
	self.spineLoaded = false

	self.uiSpine:setResPath(self.skinCO, self.onSpineLoaded, self)
end

function RougeFightSuccessView:onSpineLoaded()
	if self.closeed then
		return
	end

	self.spineLoaded = true

	self.uiSpine:setUIMask(true)
	self.uiSpine:setAllLayer(UnityLayer.UI3D)
	self:setSkinOffset()

	if self.uiSpine:isLive2D() then
		self.uiSpine:setLive2dCameraLoadFinishCallback(self.onLive2dCameraLoadedCallback, self)

		return
	end

	self:playSpineVoice()
end

function RougeFightSuccessView:onLive2dCameraLoadedCallback()
	self.uiSpine:setLive2dCameraLoadFinishCallback()

	self._repeatNum = CharacterVoiceEnum.DelayFrame + 1
	self._repeatCount = 0

	TaskDispatcher.cancelTask(self._delayPlayVoice, self)
	TaskDispatcher.runRepeat(self._delayPlayVoice, self, 0, self._repeatNum)
end

function RougeFightSuccessView:_delayPlayVoice()
	self._repeatCount = self._repeatCount + 1

	if self._repeatCount < self._repeatNum then
		return
	end

	self:playSpineVoice()
end

function RougeFightSuccessView:setSkinOffset()
	local offsets, isNil = SkinConfig.instance:getSkinOffset(self.skinCO.fightSuccViewOffset)

	if isNil then
		offsets, _ = SkinConfig.instance:getSkinOffset(self.skinCO.characterViewOffset)
		offsets = SkinConfig.instance:getAfterRelativeOffset(504, offsets)
	end

	local scale = tonumber(offsets[3])
	local offsetX = tonumber(offsets[1])
	local offsetY = tonumber(offsets[2])

	CharacterVoiceEnum.setSpineOffset(self.uiSpine, tonumber(offsets[1]), tonumber(offsets[2]))
	transformhelper.setLocalScale(self.spineTr, scale, scale, scale)
end

function RougeFightSuccessView:playSpineVoice()
	local voiceCOList = HeroModel.instance:getVoiceConfig(self.randomHeroId, CharacterEnum.VoiceType.FightResult, nil, self.randomSkinId)

	voiceCOList = voiceCOList or FightAudioMgr.instance:_getHeroVoiceCOs(self.randomHeroId, CharacterEnum.VoiceType.FightResult, self.randomSkinId)

	if voiceCOList and #voiceCOList > 0 then
		local firstVoiceCO = voiceCOList[1]

		self.uiSpine:playVoice(firstVoiceCO, nil, self._txtsayCn, self._txtsayEn)
	end
end

function RougeFightSuccessView:getRandomEntityMo()
	local mySide1 = FightDataHelper.entityMgr:getMyNormalList()
	local mySide2 = FightDataHelper.entityMgr:getMySubList()
	local mySide3 = FightDataHelper.entityMgr:getMyDeadList()
	local mySideMOList = {}

	tabletool.addValues(mySideMOList, mySide1)
	tabletool.addValues(mySideMOList, mySide2)
	tabletool.addValues(mySideMOList, mySide3)

	for i = #mySideMOList, 1, -1 do
		local entityMO = mySideMOList[i]

		if not self:getSkinCo(entityMO) then
			table.remove(mySideMOList, i)
		end
	end

	local noMonsterMOList = {}

	tabletool.addValues(noMonsterMOList, mySideMOList)

	for i = #noMonsterMOList, 1, -1 do
		local entityMO = mySideMOList[i]
		local voice_list = FightAudioMgr.instance:_getHeroVoiceCOs(entityMO.modelId, CharacterEnum.VoiceType.FightResult)

		if voice_list and #voice_list > 0 then
			if entityMO:isMonster() then
				table.remove(noMonsterMOList, i)
			end
		else
			table.remove(noMonsterMOList, i)
		end
	end

	if #noMonsterMOList > 0 then
		return noMonsterMOList[math.random(#noMonsterMOList)]
	elseif #mySideMOList > 0 then
		return mySideMOList[math.random(#mySideMOList)]
	else
		logError("没有角色")
	end
end

function RougeFightSuccessView:getSkinCo(entityMO)
	local skinCO = FightConfig.instance:getSkinCO(entityMO.skin)
	local hasVerticalDrawing = skinCO and not string.nilorempty(skinCO.verticalDrawing)
	local hasLive2d = skinCO and not string.nilorempty(skinCO.live2d)

	if hasVerticalDrawing or hasLive2d then
		return skinCO
	end
end

function RougeFightSuccessView:refreshEpisodeInfo()
	local episodeId = FightResultModel.instance.episodeId
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	self._txtepisodeNameEn.text = episodeCo.name_En
	self._txtepisodeName.text = episodeCo.name
end

function RougeFightSuccessView:refreshRougeInfo()
	self.fightResultInfo = RougeModel.instance:getFightResultInfo()
	self.rougeInfo = RougeModel.instance:getRougeInfo()
	self.season = self.rougeInfo.season

	self:refreshStyle()
	self:refreshLv()
	self:refreshHero()
	self:refreshDrop()
end

function RougeFightSuccessView:refreshStyle()
	local style = self.rougeInfo.style
	local styleCo = lua_rouge_style.configDict[self.season][style]

	UISpriteSetMgr.instance:setRouge2Sprite(self._imagefaction, string.format("%s_light", styleCo.icon))
end

function RougeFightSuccessView:refreshLv()
	local curLv = self.rougeInfo.teamLevel
	local curExp = self.rougeInfo.teamExp
	local addExp = self.fightResultInfo.addExp
	local nextLvCo = lua_rouge_level.configDict[self.season][curLv + 1]

	if not nextLvCo then
		gohelper.setActive(self._txtaddexp.gameObject, false)

		nextLvCo = lua_rouge_level.configDict[self.season][curLv]

		local needExp = lua_rouge_level.configDict[self.season][curLv].exp

		self:_refreshLv(curLv, needExp, needExp)
		self._sliderprogress:SetValue(1)
		recthelper.setWidth(self.rectTrImageAddExp, 0)

		return
	end

	gohelper.setActive(self._txtaddexp.gameObject, true)

	local needExp = nextLvCo.exp

	self:_refreshLv(curLv, addExp, needExp)
	self._sliderprogress:SetValue(curExp / needExp)
	recthelper.setWidth(self.rectTrImageAddExp, 0)

	self._txtaddexp.text = "+" .. addExp
	self.startLv = curLv
	self.curExp = curExp
	self.addExp = addExp

	TaskDispatcher.runDelay(self.playAnim, self, RougeMapEnum.WaitSuccAnimDuration)
end

function RougeFightSuccessView:playAnim()
	local Lv, startRate, endRate, newCurExp, nextLvNeedExp = self:calculateParam(self.startLv, self.curExp, self.addExp)

	self.endLv = Lv
	self.newCurExp = newCurExp
	self.nextLvNeedExp = nextLvNeedExp
	self.tweenId = ZProj.TweenHelper.DOTweenFloat(startRate, endRate, RougeMapEnum.ExpAddDuration, self.onFrame, self.doneCallback, self)
end

function RougeFightSuccessView:onFrame(value)
	local curLv = Mathf.Floor(value)
	local co = lua_rouge_level.configDict[self.season][curLv + 1]
	local needExp = co.exp
	local rate = value - curLv
	local curExp = Mathf.Ceil(rate * needExp)

	self:_refreshLv(curLv, curExp, needExp)

	if curLv ~= self.startLv then
		self._sliderprogress:SetValue(0)
	end

	recthelper.setWidth(self.rectTrImageAddExp, rate * self.sliderWidth)
end

function RougeFightSuccessView:doneCallback()
	self:_refreshLv(self.endLv, self.newCurExp, self.nextLvNeedExp)

	local rate = self.newCurExp / self.nextLvNeedExp

	recthelper.setWidth(self.rectTrImageAddExp, rate * self.sliderWidth)

	self.tweenId = nil
end

function RougeFightSuccessView:_refreshLv(lv, curExp, needExp)
	self._txtlv.text = "Lv." .. lv
	self._txtexp.text = string.format("%s/%s", curExp, needExp)
end

function RougeFightSuccessView:calculateParam(curLv, curExp, addExp)
	local nextLv = curLv + 1
	local co = lua_rouge_level.configDict[self.season][nextLv]
	local needExp = co.exp
	local startRate, endRate, newCurExp

	startRate = curLv + curExp / needExp

	if addExp + curExp < needExp then
		return curLv, startRate, curLv + (addExp + curExp) / needExp, addExp + curExp, needExp
	end

	if addExp + curExp == needExp then
		local nextCo = lua_rouge_level.configDict[self.season][nextLv + 1]

		if not nextCo then
			return curLv + 1, startRate, nextLv - 0.01, co.exp, co.exp
		else
			return curLv + 1, startRate, nextLv, 0, nextCo.exp
		end
	end

	curLv = curLv + 1
	addExp = addExp - (needExp - curExp)

	while addExp > 0 do
		local nextCo = lua_rouge_level.configDict[self.season][curLv + 1]

		if not nextCo then
			return curLv, startRate, curLv - 0.01, needExp, needExp
		end

		needExp = nextCo.exp

		if addExp < nextCo.exp then
			return curLv, startRate, curLv + addExp / needExp, addExp, needExp
		elseif addExp == needExp then
			nextCo = lua_rouge_level.configDict[self.season][curLv + 2]

			if not lua_rouge_level.configDict[self.season][curLv + 2] then
				return curLv + 1, startRate, curLv + 1 - 0.01, needExp, needExp
			else
				return curLv + 1, startRate, curLv + 1, 0, nextCo.exp
			end
		else
			addExp = addExp - needExp
			curLv = curLv + 1
		end
	end

	logError("Something unexpected has happened")

	return curLv, startRate, curLv, addExp, needExp
end

function RougeFightSuccessView:refreshHero()
	for _, hero in ipairs(self.fightResultInfo.battleHeroList) do
		local heroId = hero.heroId

		if heroId ~= 0 then
			local go = gohelper.cloneInPlace(self._goheroitem)
			local heroItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, RougeFightSuccessHeroItem)

			heroItem:refreshHero(hero)
		end
	end
end

function RougeFightSuccessView:refreshDrop()
	self._txtcollectionnum.text = self.fightResultInfo.dropSelectNum
	self._txtcoinnum.text = self.fightResultInfo.addCoin

	TaskDispatcher.runDelay(self.playRewardAudio, self, RougeMapEnum.WaitSuccPlayAudioDuration)
end

function RougeFightSuccessView:playRewardAudio()
	AudioMgr.instance:trigger(AudioEnum.UI.FightSuccReward)
end

function RougeFightSuccessView:onClose()
	self.closeed = true

	TaskDispatcher.cancelTask(self._delayPlayVoice, self)
	TaskDispatcher.cancelTask(self.playAnim, self)
	TaskDispatcher.cancelTask(self.playRewardAudio, self)

	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)
	end

	FightController.instance:dispatchEvent(FightEvent.OnResultViewClose)
end

function RougeFightSuccessView:onDestroyView()
	self.bgClick:RemoveClickListener()
end

return RougeFightSuccessView
