-- chunkname: @modules/logic/sp01/odyssey/view/OdysseySuccessView.lua

module("modules.logic.sp01.odyssey.view.OdysseySuccessView", package.seeall)

local OdysseySuccessView = class("OdysseySuccessView", BaseView)

function OdysseySuccessView:onInitView()
	self._click = gohelper.getClick(self.viewGO)
	self._btnData = gohelper.findChildButtonWithAudio(self.viewGO, "btnData")
	self._simagecharacterbg = gohelper.findChildSingleImage(self.viewGO, "#simage_characterbg")
	self._simagemaskImage = gohelper.findChildSingleImage(self.viewGO, "#simage_maskImage")
	self._goroletag = gohelper.findChild(self.viewGO, "txtFbName/#go_roletag")
	self._gonormaltag = gohelper.findChild(self.viewGO, "txtFbName/#go_normaltag")
	self._gospine = gohelper.findChild(self.viewGO, "spineContainer/spine")
	self._uiSpine = GuiModelAgent.Create(self._gospine, true)

	self._uiSpine:useRT()

	self._txtFbName = gohelper.findChildText(self.viewGO, "txtFbName")
	self._gosuit = gohelper.findChild(self.viewGO, "txtFbName/#go_suit")
	self._imageicon = gohelper.findChildImage(self.viewGO, "txtFbName/#go_suit/#image_icon")
	self._goalcontent = gohelper.findChild(self.viewGO, "goalcontent")
	self._goCondition = gohelper.findChild(self.viewGO, "goalcontent/goallist/fightgoal")
	self._goPlatCondition = gohelper.findChild(self.viewGO, "goalcontent/goallist/platinum")
	self._goPlatCondition2 = gohelper.findChild(self.viewGO, "goalcontent/goallist/platinum2")
	self._goconquer = gohelper.findChild(self.viewGO, "#go_conquer")
	self._txtcurRound = gohelper.findChildText(self.viewGO, "#go_conquer/#txt_curRound")
	self._txttotalRound = gohelper.findChildText(self.viewGO, "#go_conquer/#txt_totalRound")
	self._gonewrecordtag = gohelper.findChild(self.viewGO, "#go_conquer/go_newRecord")
	self._goscrollitem = gohelper.findChild(self.viewGO, "scroll/item")
	self._goscrollcontent = gohelper.findChild(self.viewGO, "scroll/viewport/content")
	self._txtSayCn = gohelper.findChildText(self.viewGO, "txtSayCn")
	self._txtSayEn = gohelper.findChildText(self.viewGO, "SayEn/txtSayEn")
	self._rewardList = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseySuccessView:addEvents()
	self._btnData:AddClickListener(self._onClickData, self)
	self._click:AddClickListener(self._onClickClose, self)
end

function OdysseySuccessView:removeEvents()
	self._btnData:RemoveClickListener()
	self._click:RemoveClickListener()
end

function OdysseySuccessView:_onClickData()
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function OdysseySuccessView:_onClickClose()
	if self._uiSpine then
		self._uiSpine:stopVoice()
	end

	self:closeThis()

	local storyId = FightModel.instance:getAfterStory()
	local curChapterConfig = DungeonConfig.instance:getChapterCO(self._curChapterId)
	local noCheckFinish = curChapterConfig and curChapterConfig.type == DungeonEnum.ChapterType.RoleStory or curChapterConfig.id == DungeonEnum.ChapterId.RoleDuDuGu

	if storyId > 0 and (noCheckFinish or not StoryModel.instance:isStoryFinished(storyId)) then
		OdysseySuccessView._storyId = storyId
		OdysseySuccessView._clientFinish = false
		OdysseySuccessView._serverFinish = false

		StoryController.instance:registerCallback(StoryEvent.FinishFromServer, OdysseySuccessView._finishStoryFromServer)

		local param = {}

		param.mark = true
		param.episodeId = DungeonModel.instance.curSendEpisodeId

		StoryController.instance:playStory(storyId, param, function()
			TaskDispatcher.runDelay(OdysseySuccessView.onStoryEnd, nil, 3)

			OdysseySuccessView._clientFinish = true

			OdysseySuccessView.checkStoryEnd()
		end)

		return
	end

	OdysseySuccessView.onStoryEnd()
end

function OdysseySuccessView._finishStoryFromServer(storyId)
	if OdysseySuccessView._storyId == storyId then
		OdysseySuccessView._serverFinish = true

		OdysseySuccessView.checkStoryEnd()
	end
end

function OdysseySuccessView.checkStoryEnd()
	if OdysseySuccessView._clientFinish and OdysseySuccessView._serverFinish then
		OdysseySuccessView.onStoryEnd()
	end
end

function OdysseySuccessView.onStoryEnd()
	OdysseySuccessView._storyId = nil
	OdysseySuccessView._clientFinish = false
	OdysseySuccessView._serverFinish = false

	TaskDispatcher.cancelTask(OdysseySuccessView.onStoryEnd, nil)
	StoryController.instance:unregisterCallback(StoryEvent.FinishFromServer, OdysseySuccessView._finishStoryFromServer)
	FightController.onResultViewClose()
end

function OdysseySuccessView:_editableInitView()
	return
end

function OdysseySuccessView:onUpdateParam()
	return
end

function OdysseySuccessView:onOpen()
	self._randomEntityMO = self:_getRandomEntityMO()

	self._simagecharacterbg:LoadImage(ResUrl.getFightQuitResultIcon("bg_renwubeiguang"))
	self._simagemaskImage:LoadImage(ResUrl.getFightResultcIcon("bg_zhezhao"))

	self._curChapterId = DungeonModel.instance.curSendChapterId

	local fightResultModel = FightResultModel.instance

	self._curEpisodeId = fightResultModel.episodeId
	self._fightParam = FightModel.instance:getFightParam()

	self:_setSuitIfo()
	self:_setSpineVoice()
	NavigateMgr.instance:addEscape(ViewName.OdysseySuccessView, self._onClickClose, self)

	self._canPlayVoice = false

	TaskDispatcher.runDelay(self._setCanPlayVoice, self, 0.9)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_win)
end

function OdysseySuccessView:_setSuitIfo()
	self._resultMO = OdysseyModel.instance:getFightResultInfo()

	local rewardList = self._resultMO:getRewardList()
	local showAddOuterItemList = OdysseyItemModel.instance:getAddOuterItemList()
	local allRewardList = {}

	tabletool.addValues(allRewardList, showAddOuterItemList)
	tabletool.addValues(allRewardList, rewardList)
	gohelper.CreateObjList(self, self._creatItem, allRewardList, self._goscrollcontent, self._goscrollitem)

	self._isConquer = self._resultMO:checkFightTypeIsConquer()

	gohelper.setActive(self._goconquer, self._isConquer)
	gohelper.setActive(self._goalcontent, not self._isConquer)

	self._fighteleCO = OdysseyConfig.instance:getElementFightConfig(self._resultMO:getElementId())
	self._txtFbName.text = self._fighteleCO.title

	if self._isConquer then
		local conquestEle = self._resultMO:getConquestEle()

		gohelper.setActive(self._gonewrecordtag, conquestEle.newFlag)

		self._txtcurRound.text = conquestEle.currWave

		if self._fightParam.monsterGroupIds then
			self._txttotalRound.text = #self._fightParam.monsterGroupIds or 0
		end
	else
		local curChapterConfig = DungeonConfig.instance:getChapterCO(self._curChapterId)
		local conditionText = DungeonConfig.instance:getFirstEpisodeWinConditionText(nil, FightModel.instance:getBattleId())
		local platConditionText = DungeonConfig.instance:getEpisodeAdvancedConditionText(self._curEpisodeId, FightModel.instance:getBattleId())
		local starImage = self._hardMode and "zhuxianditu_kn_xingxing_002" or "zhuxianditu_pt_xingxing_001"

		if string.nilorempty(conditionText) then
			gohelper.setActive(self._goCondition, false)
		else
			gohelper.findChildText(self._goCondition, "condition").text = conditionText

			local star = gohelper.findChildImage(self._goCondition, "star")

			UISpriteSetMgr.instance:setCommonSprite(star, starImage, true)
			SLFramework.UGUI.GuiHelper.SetColor(star, self._hardMode and "#FF4343" or "#F77040")
		end

		if curChapterConfig and curChapterConfig.type == DungeonEnum.ChapterType.Simple then
			gohelper.setActive(self._goPlatCondition, false)
		else
			self:_showPlatCondition(platConditionText, self._goPlatCondition, starImage, DungeonEnum.StarType.Advanced)
		end
	end
end

function OdysseySuccessView:_creatItem(obj, mo, index)
	local item = self._rewardList[index]

	if not item then
		item = self:getUserDataTb_()

		local itemPos = obj

		item.itemGO = self.viewContainer:getResInst(self.viewContainer:getSetting().otherRes[1], itemPos)
		item.itemIcon = MonoHelper.addNoUpdateLuaComOnceToGo(item.itemGO, OdysseyItemIcon)

		if mo.rewardType == OdysseyEnum.ResultRewardType.Item then
			item.itemIcon:initItemInfo(mo.itemType, mo.itemId, mo.count)
		elseif mo.rewardType == OdysseyEnum.ResultRewardType.Exp then
			item.itemIcon:showTalentItem(mo.count)
		elseif mo.rewardType == OdysseyEnum.ResultRewardType.Talent then
			item.itemIcon:showExpItem(mo.count)
		elseif mo.itemType and mo.itemType == OdysseyEnum.RewardItemType.OuterItem then
			local dataParam = {
				type = tonumber(mo.type),
				id = tonumber(mo.id)
			}

			item.itemIcon:initRewardItemInfo(OdysseyEnum.RewardItemType.OuterItem, dataParam, tonumber(mo.addCount))
		end

		table.insert(self._rewardList, item)
	end
end

function OdysseySuccessView:_showPlatCondition(platConditionText, go, starImage, targetStarNum)
	if string.nilorempty(platConditionText) then
		gohelper.setActive(go, false)
	else
		gohelper.setActive(go, true)

		local resultStar = tonumber(FightResultModel.instance.star) or 0

		gohelper.findChildText(go, "condition").text = resultStar < targetStarNum and gohelper.getRichColorText(platConditionText, "#6C6C6B") or gohelper.getRichColorText(platConditionText, "#C4C0BD")

		local star = gohelper.findChildImage(go, "star")
		local starColor = "#87898C"

		if targetStarNum <= resultStar then
			starColor = self._hardMode and "#FF4343" or "#F77040"
		end

		UISpriteSetMgr.instance:setCommonSprite(star, starImage, true)
		SLFramework.UGUI.GuiHelper.SetColor(star, starColor)
	end
end

function OdysseySuccessView:_setCanPlayVoice()
	self._canPlayVoice = true

	self:_playSpineVoice()
end

function OdysseySuccessView:_getRandomEntityMO()
	local mySide1 = FightDataHelper.entityMgr:getMyNormalList()
	local mySide2 = FightDataHelper.entityMgr:getMySubList()
	local mySide3 = FightDataHelper.entityMgr:getMyDeadList()
	local mySideMOList = {}

	tabletool.addValues(mySideMOList, mySide1)
	tabletool.addValues(mySideMOList, mySide2)
	tabletool.addValues(mySideMOList, mySide3)

	for i = #mySideMOList, 1, -1 do
		local entityMO = mySideMOList[i]

		if not self:_getSkin(entityMO) then
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

function OdysseySuccessView:_setSpineVoice()
	if not self._randomEntityMO then
		return
	end

	local skinCO = self:_getSkin(self._randomEntityMO)

	if skinCO then
		self._spineLoaded = false

		self._uiSpine:setImgPos(0)
		self._uiSpine:setResPath(skinCO, function()
			self._spineLoaded = true

			self._uiSpine:setUIMask(true)
			self:_playSpineVoice()
			self._uiSpine:setAllLayer(UnityLayer.UI)
		end, self)

		local offsets, isNil = SkinConfig.instance:getSkinOffset(skinCO.fightSuccViewOffset)

		if isNil then
			offsets, _ = SkinConfig.instance:getSkinOffset(skinCO.characterViewOffset)
			offsets = SkinConfig.instance:getAfterRelativeOffset(504, offsets)
		end

		local scale = tonumber(offsets[3])
		local offsetX = tonumber(offsets[1])
		local offsetY = tonumber(offsets[2])

		recthelper.setAnchor(self._gospine.transform, offsetX, offsetY)
		transformhelper.setLocalScale(self._gospine.transform, scale, scale, scale)
	else
		gohelper.setActive(self._gospine, false)
	end
end

function OdysseySuccessView:_playSpineVoice()
	if not self._canPlayVoice then
		return
	end

	if not self._spineLoaded then
		return
	end

	if self._uiSpine:isLive2D() then
		self._uiSpine:setLive2dCameraLoadFinishCallback(self.onLive2dCameraLoadedCallback, self)

		return
	end

	self:_playVoice()
end

function OdysseySuccessView:onLive2dCameraLoadedCallback()
	self._uiSpine:setLive2dCameraLoadFinishCallback()

	self._repeatNum = CharacterVoiceEnum.DelayFrame + 1
	self._repeatCount = 0

	TaskDispatcher.cancelTask(self._delayPlayVoice, self)
	TaskDispatcher.runRepeat(self._delayPlayVoice, self, 0, self._repeatNum)
end

function OdysseySuccessView:_delayPlayVoice()
	self._repeatCount = self._repeatCount + 1

	if self._repeatCount < self._repeatNum then
		return
	end

	self:_playVoice()
end

function OdysseySuccessView:_playVoice()
	local voiceCOList = HeroModel.instance:getVoiceConfig(self._randomEntityMO.modelId, CharacterEnum.VoiceType.FightResult, nil, self._randomEntityMO.skin)

	voiceCOList = voiceCOList or FightAudioMgr.instance:_getHeroVoiceCOs(self._randomEntityMO.modelId, CharacterEnum.VoiceType.FightResult, self._randomEntityMO.skin)

	if voiceCOList and #voiceCOList > 0 then
		local firstVoiceCO = voiceCOList[1]

		self._uiSpine:playVoice(firstVoiceCO, nil, self._txtSayCn, self._txtSayEn)
	end
end

function OdysseySuccessView:_getSkin(mo)
	local skinCO = FightConfig.instance:getSkinCO(mo.skin)
	local hasVerticalDrawing = skinCO and not string.nilorempty(skinCO.verticalDrawing)
	local hasLive2d = skinCO and not string.nilorempty(skinCO.live2d)

	if hasVerticalDrawing or hasLive2d then
		return skinCO
	end
end

function OdysseySuccessView:onClose()
	self._canPlayVoice = false

	TaskDispatcher.cancelTask(self._setCanPlayVoice, self)
	TaskDispatcher.cancelTask(self._delayPlayVoice, self)
	gohelper.setActive(self._gospine, false)
end

function OdysseySuccessView:onDestroyView()
	OdysseyModel.instance:clearResultInfo()
end

return OdysseySuccessView
