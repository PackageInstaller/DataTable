-- chunkname: @modules/logic/rouge2/map/view/fightsucc/Rouge2_FightSuccessView.lua

module("modules.logic.rouge2.map.view.fightsucc.Rouge2_FightSuccessView", package.seeall)

local Rouge2_FightSuccessView = class("Rouge2_FightSuccessView", BaseView)

function Rouge2_FightSuccessView:onInitView()
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
	self._goFunnyTask = gohelper.findChild(self.viewGO, "right/#go_funnytask")
	self._txtTaskTitle = gohelper.findChildText(self.viewGO, "right/#go_funnytask/level/txt_dec")
	self._goDescList = gohelper.findChild(self.viewGO, "right/#go_funnytask/#go_descList")
	self._txtTaskDesc = gohelper.findChildText(self.viewGO, "right/#go_funnytask/#go_descList/#txt_dec")
	self._imageTaskRare = gohelper.findChildImage(self.viewGO, "right/#go_funnytask/level/#image_rare")
	self._imageTaskLevelBg = gohelper.findChildImage(self.viewGO, "right/#go_funnytask/level/#image_levelbg")
	self._imageTaskLevel = gohelper.findChildImage(self.viewGO, "right/#go_funnytask/level/#image_level")
	self._goMaxDamage = gohelper.findChild(self.viewGO, "right/#go_MaxDamage")
	self._txtMaxDamage = gohelper.findChildText(self.viewGO, "right/#go_MaxDamage/#txt_MaxDamage")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_FightSuccessView:addEvents()
	self._btndata:AddClickListener(self._btndataOnClick, self)
end

function Rouge2_FightSuccessView:removeEvents()
	self._btndata:RemoveClickListener()
end

function Rouge2_FightSuccessView:_btndataOnClick()
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function Rouge2_FightSuccessView:_editableInitView()
	self.bgClick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "bg")

	self.bgClick:AddClickListener(self.onClickBg, self)

	self.spineTr = self._gospine.transform
	self._txtsayCn.text = ""
	self._txtsayEn.text = ""
end

function Rouge2_FightSuccessView:onClickBg()
	if self.uiSpine then
		self.uiSpine:stopVoice()
	end

	self:closeThis()
end

function Rouge2_FightSuccessView:onUpdateParam()
	return
end

function Rouge2_FightSuccessView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_win)
	self:refreshLeft()
	self:refreshRight()
end

function Rouge2_FightSuccessView:refreshLeft()
	self:refreshSpine()
end

function Rouge2_FightSuccessView:refreshRight()
	self:refreshEpisodeInfo()
	self:refreshRougeInfo()
	self:refreshMaxDamage()
end

function Rouge2_FightSuccessView:refreshSpine()
	local randomEntityMo = self:getRandomEntityMo()

	self.skinCO = self:getSkinCo(randomEntityMo)
	self.randomHeroId = randomEntityMo.modelId
	self.randomSkinId = randomEntityMo.skin
	self.spineLoaded = false

	self.uiSpine:setResPath(self.skinCO, self.onSpineLoaded, self)
end

function Rouge2_FightSuccessView:onSpineLoaded()
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

function Rouge2_FightSuccessView:onLive2dCameraLoadedCallback()
	self.uiSpine:setLive2dCameraLoadFinishCallback()

	self._repeatNum = CharacterVoiceEnum.DelayFrame + 1
	self._repeatCount = 0

	TaskDispatcher.cancelTask(self._delayPlayVoice, self)
	TaskDispatcher.runRepeat(self._delayPlayVoice, self, 0, self._repeatNum)
end

function Rouge2_FightSuccessView:_delayPlayVoice()
	self._repeatCount = self._repeatCount + 1

	if self._repeatCount < self._repeatNum then
		return
	end

	self:playSpineVoice()
end

function Rouge2_FightSuccessView:setSkinOffset()
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

function Rouge2_FightSuccessView:playSpineVoice()
	local voiceCOList = HeroModel.instance:getVoiceConfig(self.randomHeroId, CharacterEnum.VoiceType.FightResult, nil, self.randomSkinId)

	voiceCOList = voiceCOList or FightAudioMgr.instance:_getHeroVoiceCOs(self.randomHeroId, CharacterEnum.VoiceType.FightResult, self.randomSkinId)

	if voiceCOList and #voiceCOList > 0 then
		local firstVoiceCO = voiceCOList[1]

		self.uiSpine:playVoice(firstVoiceCO, nil, self._txtsayCn, self._txtsayEn)
	end
end

function Rouge2_FightSuccessView:getRandomEntityMo()
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

function Rouge2_FightSuccessView:getSkinCo(entityMO)
	local skinCO = FightConfig.instance:getSkinCO(entityMO.skin)
	local hasVerticalDrawing = skinCO and not string.nilorempty(skinCO.verticalDrawing)
	local hasLive2d = skinCO and not string.nilorempty(skinCO.live2d)

	if hasVerticalDrawing or hasLive2d then
		return skinCO
	end
end

function Rouge2_FightSuccessView:refreshEpisodeInfo()
	self._episodeId = FightResultModel.instance.episodeId

	local episodeCo = DungeonConfig.instance:getEpisodeCO(self._episodeId)

	self._txtepisodeNameEn.text = episodeCo.name_En
	self._txtepisodeName.text = episodeCo.name
end

function Rouge2_FightSuccessView:refreshRougeInfo()
	self.fightResultInfo = Rouge2_Model.instance:getFightResultInfo()
	self.rougeInfo = Rouge2_Model.instance:getRougeInfo()

	self:refreshFunnyTask()
end

function Rouge2_FightSuccessView:refreshFunnyTask()
	self._funnyTaskIdList = Rouge2_MapConfig.instance:getFunnyTaskIdList(self._episodeId)
	self._hasFunnyTask = self._funnyTaskIdList and #self._funnyTaskIdList > 0

	gohelper.setActive(self._goFunnyTask, self._hasFunnyTask)

	if not self._hasFunnyTask then
		return
	end

	self._level, self._lastTaskId = FightHelper.getRouge2FunnyTaskCurLevelAndTaskIdAndProgress()
	self._lastFunnyTaskCo = Rouge2_MapConfig.instance:getFunnyTaskCofig(self._lastTaskId)
	self._txtTaskTitle.text = Rouge2_MapConfig.instance:getFunnyTaskTitle(self._episodeId)

	self:refreshFunnyTaskList()
	UISpriteSetMgr.instance:setRouge7Sprite(self._imageTaskRare, Rouge2_MapEnum.FunnyTaskLevelBg[self._level])
	UISpriteSetMgr.instance:setRouge7Sprite(self._imageTaskLevel, string.format("%s_2", Rouge2_MapEnum.FunnyTaskLevelIcon[self._level]))
	UISpriteSetMgr.instance:setRouge7Sprite(self._imageTaskLevelBg, string.format("%s_3", Rouge2_MapEnum.FunnyTaskLevelIcon[self._level]))
end

function Rouge2_FightSuccessView:refreshFunnyTaskList()
	local finishTaskList = {}

	for _, taskId in ipairs(self._funnyTaskIdList) do
		local levelName = FightHelper.getTaskLevelAndCost(taskId)
		local level = FightEnum.Rouge2FunnyTaskLevelName2Level[levelName]

		if level <= self._level then
			table.insert(finishTaskList, taskId)
		end
	end

	table.sort(finishTaskList, self._sortFinishFunnyTask)

	local descList = {}

	for _, finishTaskId in ipairs(finishTaskList) do
		local taskCo = Rouge2_MapConfig.instance:getFunnyTaskCofig(finishTaskId)

		if taskCo.isTopic == 1 then
			if not taskCo.fightTaskinfo then
				local desc = taskCo.fightTaskDetail

				if not string.nilorempty(desc) then
					table.insert(descList, desc)
				end
			end
		end
	end

	if self._level <= FightEnum.Rouge2FunnyTaskLevel.C then
		table.insert(descList, luaLang("rouge2_funnytask_fail"))
	end

	gohelper.CreateObjList(self, self._refreshFunnyTaskDesc, descList, self._goDescList, self._txtTaskDesc.gameObject)
	ZProj.UGUIHelper.RebuildLayout(self._goDescList.transform)
end

function Rouge2_FightSuccessView._sortFinishFunnyTask(aTaskId, bTaskId)
	local aLevelName = FightHelper.getTaskLevelAndCost(aTaskId)
	local bLevelName = FightHelper.getTaskLevelAndCost(bTaskId)
	local aLevel = FightEnum.Rouge2FunnyTaskLevelName2Level[aLevelName]
	local bLevel = FightEnum.Rouge2FunnyTaskLevelName2Level[bLevelName]

	return aLevel < bLevel
end

function Rouge2_FightSuccessView:_refreshFunnyTaskDesc(obj, desc, index)
	local txtDesc = obj:GetComponent(gohelper.Type_TextMesh)

	txtDesc.text = desc
end

function Rouge2_FightSuccessView:refreshMaxDamage()
	self._txtMaxDamage.text = Rouge2_BossBattleController.instance:getRoundMaxDamage()
end

function Rouge2_FightSuccessView:onClose()
	self.closeed = true

	TaskDispatcher.cancelTask(self._delayPlayVoice, self)
	TaskDispatcher.cancelTask(self.playAnim, self)

	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)
	end

	FightController.instance:dispatchEvent(FightEvent.OnResultViewClose)
end

function Rouge2_FightSuccessView:onDestroyView()
	self.bgClick:RemoveClickListener()
end

return Rouge2_FightSuccessView
