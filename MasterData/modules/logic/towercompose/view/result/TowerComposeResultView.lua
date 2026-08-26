-- chunkname: @modules/logic/towercompose/view/result/TowerComposeResultView.lua

module("modules.logic.towercompose.view.result.TowerComposeResultView", package.seeall)

local TowerComposeResultView = class("TowerComposeResultView", BaseView)

function TowerComposeResultView:onInitView()
	self._goresult = gohelper.findChild(self.viewGO, "go_result")
	self._goroot = gohelper.findChild(self.viewGO, "go_result/root")
	self._gobg = gohelper.findChild(self.viewGO, "go_result/root/#go_bg")
	self._gobossPosContent = gohelper.findChild(self.viewGO, "go_result/root/left/boss/#go_bossPosContent")
	self._gobossPos = gohelper.findChild(self.viewGO, "go_result/root/left/boss/#go_bossPosContent/#go_bossPos")
	self._txttitle = gohelper.findChildText(self.viewGO, "go_result/root/left/title/#txt_title")
	self._imagelevel = gohelper.findChildImage(self.viewGO, "go_result/root/left/enemyInfo/#image_level")
	self._txtlevel = gohelper.findChildText(self.viewGO, "go_result/root/left/enemyInfo/#txt_level")
	self._txtrecordnum = gohelper.findChildText(self.viewGO, "go_result/root/left/record/#txt_recordnum")
	self._gonewrecord = gohelper.findChild(self.viewGO, "go_result/root/left/record/#go_newrecord")
	self._goplayerHead = gohelper.findChild(self.viewGO, "go_result/root/left/Player/#go_playerHead")
	self._simageplayerHead = gohelper.findChildSingleImage(self.viewGO, "go_result/root/left/Player/#go_playerHead/#simage_playerHead")
	self._txtplayerName = gohelper.findChildText(self.viewGO, "go_result/root/left/Player/#txt_playerName")
	self._txttime = gohelper.findChildText(self.viewGO, "go_result/root/left/Player/#txt_time")
	self._txtplayerUid = gohelper.findChildText(self.viewGO, "go_result/root/left/Player/#txt_playerUid")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "go_result/#go_herogroupcontain/#btn_close")
	self._btnData = gohelper.findChildButtonWithAudio(self.viewGO, "go_result/#go_herogroupcontain/#btn_Data")
	self._gonormalPlane = gohelper.findChild(self.viewGO, "go_result/#go_herogroupcontain/#go_normalPlane")
	self._gonormalTargetList = gohelper.findChild(self.viewGO, "go_result/#go_herogroupcontain/#go_normalTargetList/#go_skill")
	self._btnClose1 = gohelper.findChildButtonWithAudio(self.viewGO, "go_result/#go_herogroupcontain2/#btn_close1")
	self._goTargetList1 = gohelper.findChild(self.viewGO, "go_result/#go_herogroupcontain2/go_team1")
	self._goPlane1 = gohelper.findChild(self.viewGO, "go_result/#go_herogroupcontain2/go_team1/layout/#go_plane1")
	self._btnData1 = gohelper.findChildButtonWithAudio(self.viewGO, "go_result/#go_herogroupcontain2/go_team1/#btn_Data")
	self._goTargetList2 = gohelper.findChild(self.viewGO, "go_result/#go_herogroupcontain2/go_team2")
	self._goPlane2 = gohelper.findChild(self.viewGO, "go_result/#go_herogroupcontain2/go_team2/layout/#go_plane2")
	self._btnData2 = gohelper.findChildButtonWithAudio(self.viewGO, "go_result/#go_herogroupcontain2/go_team2/#btn_Data")
	self._goFinish = gohelper.findChild(self.viewGO, "goFinish")
	self._btnSave = gohelper.findChildButtonWithAudio(self.viewGO, "go_result/#go_herogroupcontain2/#btn_save")
	self._goSaved = gohelper.findChild(self.viewGO, "go_result/#go_herogroupcontain2/#go_saved")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerComposeResultView:addEvents()
	self._btnClose:AddClickListener(self._onCloseClick, self)
	self._btnClose1:AddClickListener(self._onCloseClick, self)
	self._btnData:AddClickListener(self._onbtnDataClick, self)
	self._btnData1:AddClickListener(self._onbtnData1Click, self)
	self._btnData2:AddClickListener(self._onbtnData2Click, self)
	self._btnSave:AddClickListener(self._onSaveClick, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.UpdateRecordReply, self.onUpdateRecordReply, self)
end

function TowerComposeResultView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnClose1:RemoveClickListener()
	self._btnData:RemoveClickListener()
	self._btnData1:RemoveClickListener()
	self._btnData2:RemoveClickListener()
	self._btnSave:RemoveClickListener()
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.UpdateRecordReply, self.onUpdateRecordReply, self)
end

function TowerComposeResultView:_onCloseClick()
	if not self._canClick then
		if self._popupFlow then
			local workList = self._popupFlow:getWorkList()
			local curWork = workList[self._popupFlow._curIndex]

			if curWork then
				curWork:onDone(true)
			end
		end

		return
	end

	if self:checkCurScoreHigher() then
		GameFacade.showOptionMessageBox(MessageBoxIdDefine.TowerComposeCurScoreHighTip, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, self.sendUpdateRecordAndCloseView, nil, nil, self)
	else
		self:sendUpdateRecordAndCloseView()
	end
end

function TowerComposeResultView:sendUpdateRecordAndCloseView()
	if not self.hasSendUpdateRecord and self._towerEpisodeCo.plane == TowerComposeEnum.PlaneType.Twice then
		TowerComposeRpc.instance:sendTowerComposeUpdateRecordRequest(self._themeId, false)

		self.hasSendUpdateRecord = true
	end

	self:closeThis()
end

function TowerComposeResultView:_onbtnDataClick()
	local atkStat = TowerComposeModel.instance:getAtkStat(1)

	FightStatModel.instance:setAtkStatInfo(atkStat)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function TowerComposeResultView:_onbtnData1Click()
	local hasStat = TowerComposeModel.instance:isPanelHasStat(2)
	local atkStat = TowerComposeModel.instance:getAtkStat(1)

	FightStatModel.instance:setAtkStatInfo(atkStat, hasStat)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function TowerComposeResultView:_onbtnData2Click()
	local atkStat = TowerComposeModel.instance:getAtkStat(2)

	FightStatModel.instance:setAtkStatInfo(atkStat)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function TowerComposeResultView:_onSaveClick()
	if self.hasSendUpdateRecord then
		return
	end

	local param = {}

	param.operateType = TowerComposeEnum.TeamOperateType.Save
	param.themeId = self._themeId

	TowerComposeController.instance:openTowerComposeSaveView(param)
end

function TowerComposeResultView:_editableInitView()
	self._slotItems = self:getUserDataTb_()

	self:_addSelfEvents()
end

function TowerComposeResultView:_addSelfEvents()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function TowerComposeResultView:_removeSelfEvents()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function TowerComposeResultView:onUpdateParam()
	return
end

function TowerComposeResultView:onOpen()
	self.fightParam = TowerComposeModel.instance:getRecordFightParam()
	self._themeId, self._layerId = self.fightParam.themeId, self.fightParam.layerId
	self._towerEpisodeCo = TowerComposeConfig.instance:getEpisodeConfig(self._themeId, self._layerId)
	self._slotMapCo = TowerComposeConfig.instance:getModSlotNumMap(self._themeId)
	self._bodyModItems = self:getUserDataTb_()
	self._wordModItems = self:getUserDataTb_()
	self._envModItems = self:getUserDataTb_()
	self._resultScoreStateItems = self:getUserDataTb_()
	self.hasSendUpdateRecord = false
	self.isUpdateRecord = false

	self:_refreshUI()
	self:autoSaveRecord()
end

function TowerComposeResultView:_refreshUI()
	self:_refreshInfo()

	local waitNamePlateToastList = AchievementToastModel.instance:getWaitNamePlateToastList()

	if not waitNamePlateToastList or #waitNamePlateToastList == 0 then
		self:_startFlow()
	end
end

function TowerComposeResultView:_refreshInfo()
	self:_refreshResult()
	self:_refreshBoss()
	self:_refreshPlayerInfo()
	self:_refreshHeroGroup()
end

function TowerComposeResultView:_startFlow()
	if self._popupFlow then
		self._popupFlow:destroy()

		self._popupFlow = nil
	end

	self._popupFlow = FlowSequence.New()

	self._popupFlow:addWork(TowerBossResultShowFinishWork.New(self._goFinish, AudioEnum.Tower.play_ui_fight_explore))
	self._popupFlow:addWork(TowerBossResultShowResultWork.New(self._goresult, AudioEnum.Tower.play_ui_fight_card_flip, self.onResultShowCallBack, self))
	self._popupFlow:registerDoneListener(self._onAllFinish, self)
	self._popupFlow:start()
end

function TowerComposeResultView:onResultShowCallBack()
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_complete)
end

function TowerComposeResultView:_refreshResult()
	local towerEpisodeCo = TowerComposeConfig.instance:getEpisodeConfig(self._themeId, self._layerId)

	self._txttitle.text = towerEpisodeCo.name

	local bossLevel = TowerComposeModel.instance:getThemePlaneLevel(self._themeId)

	self._txtlevel.text = string.format("Lv.%d", bossLevel)

	local bossLvCo = TowerComposeConfig.instance:getBossLevelCo(towerEpisodeCo.episodeId, bossLevel)

	UISpriteSetMgr.instance:setTower2Sprite(self._imagelevel, "tower_new_level_" .. string.lower(bossLvCo.levelReq))

	self.bossInfoMo = TowerComposeModel.instance:getBossSettleInfo()

	gohelper.setActive(self._gonewrecord, self.bossInfoMo.newFlag)

	self._txtrecordnum.text = 0

	TaskDispatcher.runDelay(self.showScoreAnim, self, 0.3)
end

function TowerComposeResultView:showScoreAnim()
	self.scoreTweenId = ZProj.TweenHelper.DOTweenFloat(0, self.bossInfoMo.curScore, 0.3, self.onScoreFrameCallback, self.onScoreTweenDone, self, nil, EaseType.Linear)
end

function TowerComposeResultView:onScoreFrameCallback(value)
	self._txtrecordnum.text = string.format("%d", value)
end

function TowerComposeResultView:onScoreTweenDone()
	if self.scoreTweenId then
		ZProj.TweenHelper.KillById(self.scoreTweenId)

		self.scoreTweenId = nil
	end

	self._txtrecordnum.text = self.bossInfoMo.curScore
end

function TowerComposeResultView:_refreshBoss()
	self._bossSpineList = self:getUserDataTb_()

	local themeCo = TowerComposeConfig.instance:getThemeConfig(self._themeId)
	local spineOffsetList = string.splitToNumber(themeCo.spineOffset, "#")
	local spineOderLayerList = string.splitToNumber(themeCo.orderLayer, "|")

	recthelper.setAnchor(self._gobossPosContent.transform, spineOffsetList[1], spineOffsetList[2])
	transformhelper.setLocalScale(self._gobossPosContent.transform, spineOffsetList[3], spineOffsetList[3], spineOffsetList[3])

	local modOffsetList = GameUtil.splitString2(themeCo.modOffset, true)

	self._bossSkinCos = {}

	local bossMonsterGroupId = themeCo.monsterGroupId
	local monsterIdList = FightStrUtil.instance:getSplitToNumberCache(lua_monster_group.configDict[bossMonsterGroupId].monster, "#")

	for _, monsterId in ipairs(monsterIdList) do
		local monsterCo = lua_monster.configDict[monsterId]
		local skinCo = lua_monster_skin.configDict[monsterCo.skinId]

		table.insert(self._bossSkinCos, skinCo)
	end

	local planeId = TowerComposeModel.instance:getCurSelectPlaneId()
	local curBossSkinCoList = TowerComposeModel.instance:getPlaneBossSkinCoList(self._themeId, planeId, self._bossSkinCos)

	for index, bossSkinCo in ipairs(curBossSkinCoList) do
		local guiBossSpine = self._bossSpineList[index]

		if not guiBossSpine then
			guiBossSpine = {
				index = index,
				pos = gohelper.clone(self._gobossPos, self._gobossPosContent, "pos_" .. index)
			}
			guiBossSpine.comp = MonoHelper.addNoUpdateLuaComOnceToGo(guiBossSpine.pos, TowerComposeThemeSpineComp)
			self._bossSpineList[index] = guiBossSpine
		end

		guiBossSpine.bossSkinCo = bossSkinCo

		gohelper.setActive(guiBossSpine.pos, true)

		local param = {
			bossSkinCo = bossSkinCo,
			index = index,
			modOffsetList = modOffsetList
		}

		guiBossSpine.comp:refreshSpine(param)
	end

	for _, guiBossSpine in ipairs(self._bossSpineList) do
		guiBossSpine.pos.transform:SetSiblingIndex(spineOderLayerList[guiBossSpine.index])
	end

	for index = #self._bossSkinCos + 1, #self._bossSpineList do
		gohelper.setActive(self._bossSpineList[index].pos, false)
	end
end

function TowerComposeResultView:_refreshPlayerInfo()
	local playerInfo = PlayerModel.instance:getPlayinfo()

	self._liveHeadIcon = self._liveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(self._simageplayerHead)

	self._liveHeadIcon:setLiveHead(playerInfo.portrait)

	self._txtplayerUid = playerInfo.userId
	self._txtplayerName.text = playerInfo.name
	self._txttime.text = ServerTime.timestampToString(ServerTime.now())
end

function TowerComposeResultView:_refreshHeroGroup()
	if self._towerEpisodeCo.plane == TowerComposeEnum.PlaneType.Once then
		self:_refreshHeroGroup1()
	elseif self._towerEpisodeCo.plane == TowerComposeEnum.PlaneType.Twice then
		self:_refreshHeroGroup2()
	else
		self:closeThis()
	end
end

function TowerComposeResultView:_refreshHeroGroup1()
	self:_refreshSlot1()
	self:_refreshTarget1()
	self:refreshSaveRecordUI()
end

function TowerComposeResultView:_refreshSlot1()
	local planeId = self._towerEpisodeCo.plane

	if not self._slotItems[planeId] then
		self._slotItems[planeId] = TowerComposeResultSlotItem.New()

		self._slotItems[planeId]:init(self._gonormalPlane, self._themeId, planeId)
	end

	self._slotItems[planeId]:refresh()
end

function TowerComposeResultView:_refreshTarget1()
	self:refreshBodySlotMod(self._gonormalTargetList, 1)
	self:refreshWordSlotMod(self._gonormalTargetList, 1)
	self:refreshEnvSlotMod(self._gonormalTargetList, 1)
end

function TowerComposeResultView:refreshBodySlotMod(targetGO, index)
	self._bodyModItems[index] = self._bodyModItems[index] or self:getUserDataTb_()

	local themeMo = TowerComposeModel.instance:getThemeMo(self._themeId)
	local planeMo = themeMo:getPlaneMo(index)
	local count = self._slotMapCo[TowerComposeEnum.ModType.Body]
	local root = gohelper.findChild(targetGO, "layout/grid_1")
	local slots = {}

	for slotId = 1, count do
		local modId = planeMo:getEquipModId(TowerComposeEnum.ModType.Body, slotId)

		if modId > 0 then
			table.insert(slots, modId)
		end
	end

	gohelper.setActive(root, #slots > 0)

	if #slots > 0 then
		for i = 1, #slots do
			if not self._bodyModItems[index][i] then
				local bodyItem = gohelper.findChild(targetGO, "layout/grid_1/go_item1")

				gohelper.setActive(bodyItem, false)

				local go = gohelper.cloneInPlace(bodyItem, "bodySlot" .. i)

				self._bodyModItems[index][i] = TowerComposeResultSlotBodyModItem.New()

				self._bodyModItems[index][i]:init(go)
			end

			self._bodyModItems[index][i]:refresh(slots[i])
		end
	end
end

function TowerComposeResultView:refreshWordSlotMod(targetGO, index)
	self._wordModItems[index] = self._wordModItems[index] or self:getUserDataTb_()

	local themeMo = TowerComposeModel.instance:getThemeMo(self._themeId)
	local planeMo = themeMo:getPlaneMo(index)
	local count = self._slotMapCo[TowerComposeEnum.ModType.Word]
	local root = gohelper.findChild(targetGO, "layout/grid_2")
	local slots = {}

	for slotId = 1, count do
		local modId = planeMo:getEquipModId(TowerComposeEnum.ModType.Word, slotId)

		if modId > 0 then
			table.insert(slots, modId)
		end
	end

	gohelper.setActive(root, #slots > 0)

	if #slots > 0 then
		for i = 1, #slots do
			if not self._wordModItems[index][i] then
				local bodyItem = gohelper.findChild(targetGO, "layout/grid_2/go_item2")

				gohelper.setActive(bodyItem, false)

				local go = gohelper.cloneInPlace(bodyItem, "wordSlot" .. i)

				self._wordModItems[index][i] = TowerComposeResultSlotWordModItem.New()

				self._wordModItems[index][i]:init(go)
			end

			self._wordModItems[index][i]:refresh(slots[i])
		end
	end
end

function TowerComposeResultView:refreshEnvSlotMod(targetGO, index)
	local themeMo = TowerComposeModel.instance:getThemeMo(self._themeId)
	local planeMo = themeMo:getPlaneMo(index)
	local root = gohelper.findChild(targetGO, "layout/environment/#btn_environment")
	local modId = planeMo:getEquipModId(TowerComposeEnum.ModType.Env, 1)

	gohelper.setActive(root, modId > 0)

	if modId > 0 then
		if not self._envModItems[index] then
			self._envModItems[index] = TowerComposeResultSlotEnvModItem.New()

			self._envModItems[index]:init(root)
		end

		self._envModItems[index]:refresh(modId)
	end
end

function TowerComposeResultView:_refreshHeroGroup2()
	self:_refreshSlot2()
	self:_refreshTarget2()
	self:_refreshPlaneScoreState()
	self:refreshSaveRecordUI()
end

function TowerComposeResultView:_refreshSlot2()
	for planeId = 1, 2 do
		if not self._slotItems[planeId] then
			self._slotItems[planeId] = TowerComposeResultSlotItem.New()

			self._slotItems[planeId]:init(self["_goPlane" .. planeId], self._themeId, planeId)
		end

		self._slotItems[planeId]:refresh()
	end
end

function TowerComposeResultView:_refreshTarget2()
	for i = 1, 2 do
		self:refreshBodySlotMod(self["_goTargetList" .. i], i)
		self:refreshWordSlotMod(self["_goTargetList" .. i], i)
		self:refreshEnvSlotMod(self["_goTargetList" .. i], i)

		local hasStat = TowerComposeModel.instance:isPanelHasStat(i)
		local entityMO = TowerComposeModel.instance:getLastEntityMO()

		gohelper.setActive(self["_btnData" .. i].gameObject, hasStat and entityMO)
	end
end

function TowerComposeResultView:_refreshPlaneScoreState()
	local themeMo = TowerComposeModel.instance:getThemeMo(self._themeId)

	for planeId = 1, 2 do
		local scoreStateItem = self._resultScoreStateItems[planeId]
		local targetGO = self["_goTargetList" .. planeId]

		if not scoreStateItem then
			scoreStateItem = {
				goSucc = gohelper.findChild(targetGO, "layout/result/success"),
				txtRecordNum = gohelper.findChildText(targetGO, "layout/result/success/#txt_recordnum"),
				gonewRecord = gohelper.findChild(targetGO, "layout/result/success/#go_newrecord"),
				goFail = gohelper.findChild(targetGO, "layout/result/fail")
			}
			self._resultScoreStateItems[planeId] = scoreStateItem
		end

		local planeData = self.bossInfoMo:getPlaneSettleData(planeId)

		if planeData then
			scoreStateItem.txtRecordNum.text = planeData.score or 0
		end

		gohelper.setActive(scoreStateItem.goSucc, planeData and planeData.result == TowerComposeEnum.FightResult.Win)
		gohelper.setActive(scoreStateItem.goFail, planeData and (planeData.result == TowerComposeEnum.FightResult.Fail or planeData.result == TowerComposeEnum.FightResult.None))
		gohelper.setActive(scoreStateItem.gonewRecord, planeData and planeData.newFlag)
	end
end

function TowerComposeResultView:checkCurScoreHigher()
	if self._towerEpisodeCo.plane ~= TowerComposeEnum.PlaneType.Twice then
		return false
	end

	local themeMo = TowerComposeModel.instance:getThemeMo(self._themeId)
	local curFightRecordData = self.bossInfoMo:getRecordData()

	if not curFightRecordData or curFightRecordData.createTime == 0 then
		return false
	end

	if themeMo.hasSavedRecord then
		local recordInfoData = themeMo:getBossRecordInfoData()

		if recordInfoData then
			if not recordInfoData.bossMo.curScore then
				local recordScore = 0

				return recordScore < self.bossInfoMo.curScore
			end
		end
	end

	return false
end

function TowerComposeResultView:autoSaveRecord()
	local themeMo = TowerComposeModel.instance:getThemeMo(self._themeId)
	local recordInfoData = themeMo:getBossRecordInfoData()
	local settleRecordData = self.bossInfoMo:getRecordData()

	if (not themeMo.hasSavedRecord or not recordInfoData) and settleRecordData and not self.hasSendUpdateRecord and self._towerEpisodeCo.plane == TowerComposeEnum.PlaneType.Twice then
		TowerComposeRpc.instance:sendTowerComposeUpdateRecordRequest(self._themeId, true)
	end
end

function TowerComposeResultView:onUpdateRecordReply(msg)
	self.isUpdateRecord = msg.record and tonumber(msg.record.createTime) > 0
	self.hasSendUpdateRecord = true

	if self.isUpdateRecord then
		GameFacade.showToast(ToastEnum.TowerComposeRecordSaved)
		self:refreshSaveRecordUI()
	end
end

function TowerComposeResultView:refreshSaveRecordUI()
	local isTwoPlane = self._towerEpisodeCo.plane == TowerComposeEnum.PlaneType.Twice

	if not isTwoPlane then
		gohelper.setActive(self._btnSave.gameObject, false)
		gohelper.setActive(self._goSaved, false)
	else
		local curFightRecordData = self.bossInfoMo:getRecordData()
		local isFirstPlaneSucc = self.bossInfoMo:isFirstPlaneSucc()

		gohelper.setActive(self._btnSave.gameObject, curFightRecordData and isFirstPlaneSucc and not self.isUpdateRecord)
		gohelper.setActive(self._goSaved, curFightRecordData and isFirstPlaneSucc and self.isUpdateRecord)
	end
end

function TowerComposeResultView:onClose()
	TowerComposeModel.instance:setLastEntityMO(nil)
	FightController.onResultViewClose()
	TaskDispatcher.cancelTask(self.showScoreAnim, self)
	self:onScoreTweenDone()
end

function TowerComposeResultView:_onAllFinish()
	self._canClick = true
end

function TowerComposeResultView:_onCloseViewFinish(viewName)
	if viewName == ViewName.AchievementNamePlateUnlockView then
		self:_startFlow()
	end
end

function TowerComposeResultView:onDestroyView()
	self:_removeSelfEvents()

	if self._slotItems then
		for _, slotItem in pairs(self._slotItems) do
			slotItem:destroy()
		end
	end

	if self._bodyModItems then
		for _, bodyMods in pairs(self._bodyModItems) do
			for _, bodyMod in pairs(bodyMods) do
				bodyMod:destroy()
			end
		end

		self._bodyModItems = nil
	end

	if self._wordModItems then
		for _, wordMods in pairs(self._wordModItems) do
			for _, wordMod in pairs(wordMods) do
				wordMod:destroy()
			end
		end

		self._wordModItems = nil
	end

	if self._envModItems then
		for _, envMod in pairs(self._envModItems) do
			envMod:destroy()
		end

		self._envModItems = nil
	end

	if self._popupFlow then
		self._popupFlow:destroy()

		self._popupFlow = nil
	end

	self.bossInfoMo:cleanPlaneAtkStatsMap()
end

return TowerComposeResultView
