-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191FightSuccView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191FightSuccView", package.seeall)

local Act191FightSuccView = class("Act191FightSuccView", BaseView)

function Act191FightSuccView:onInitView()
	self._goLeft = gohelper.findChild(self.viewGO, "#go_Left")
	self._simagecharacterbg = gohelper.findChildSingleImage(self.viewGO, "#go_Left/#simage_characterbg")
	self._goSpine = gohelper.findChild(self.viewGO, "#go_Left/spineContainer/#go_Spine")
	self._simagemaskImage = gohelper.findChildSingleImage(self.viewGO, "#go_Left/#simage_maskImage")
	self._txtSayCn = gohelper.findChildText(self.viewGO, "#go_Left/layout/txtSayCn")
	self._txtSayEn = gohelper.findChildText(self.viewGO, "#go_Left/layout/txtSayEn")
	self._goRight = gohelper.findChild(self.viewGO, "#go_Right")
	self._goWin = gohelper.findChild(self.viewGO, "#go_Right/#go_Win")
	self._goFail = gohelper.findChild(self.viewGO, "#go_Right/#go_Fail")
	self._goReward = gohelper.findChild(self.viewGO, "#go_Right/#go_Reward")
	self._txtStage = gohelper.findChildText(self.viewGO, "#go_Right/Stage/#txt_Stage")
	self._goPvp = gohelper.findChild(self.viewGO, "#go_Right/Stage/#go_Pvp")
	self._goHeroItem = gohelper.findChild(self.viewGO, "#go_Right/Stage/#go_Pvp/role/layout/#go_HeroItem")
	self._goPve = gohelper.findChild(self.viewGO, "#go_Right/Stage/#go_Pve")
	self._gobossHpRoot = gohelper.findChild(self.viewGO, "#go_Right/Stage/#go_Pve/#go_bossHpRoot")
	self._gounlimited = gohelper.findChild(self.viewGO, "#go_Right/Stage/#go_Pve/#go_bossHpRoot/fight_act191bosshpview/Root/bossHp/Alpha/bossHp/mask/container/imgHp/#go_unlimited")
	self._imageLevel = gohelper.findChildImage(self.viewGO, "#go_Right/Level/mainTitle/TeamLvl/#image_Level")
	self._btnData = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Right/#btn_Data")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191FightSuccView:addEvents()
	self._btnData:AddClickListener(self._btnDataOnClick, self)
end

function Act191FightSuccView:removeEvents()
	self._btnData:RemoveClickListener()
end

function Act191FightSuccView:onClickModalMask()
	if self._uiSpine then
		self._uiSpine:stopVoice()
	end

	self:closeThis()
end

function Act191FightSuccView:_btnDataOnClick()
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function Act191FightSuccView:_editableInitView()
	self.actId = Activity191Model.instance:getCurActId()
	self._uiSpine = GuiModelAgent.Create(self._goSpine, true)

	self._uiSpine:useRT()
end

function Act191FightSuccView:onOpen()
	self.actInfo = Activity191Model.instance:getActInfo()
	self.gameInfo = self.actInfo:getGameInfo()
	self.nodeInfo = self.actInfo.lastNodeInfo

	if not self.nodeInfo then
		logError("缓存节点信息数据异常")

		return
	end

	self.nodeDetailMo = Act191NodeDetailMO.New()

	self.nodeDetailMo:init(self.nodeInfo.nodeStr)

	self.isWin = self.viewParam

	if self.isWin then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_win)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_lose)
	end

	gohelper.setActive(self._goWin, self.isWin)
	gohelper.setActive(self._goFail, not self.isWin)
	self._simagecharacterbg:LoadImage(ResUrl.getFightQuitResultIcon("bg_renwubeiguang"))
	self._simagemaskImage:LoadImage(ResUrl.getFightResultcIcon("bg_zhezhao"))

	self.mySideMoList = FightDataHelper.entityMgr:getMyNormalList(nil, true)
	self.enemyMoList = FightDataHelper.entityMgr:getEnemyNormalList(nil, true)
	self._randomEntityMO = self:_getRandomEntityMO()

	if self.isWin and self._randomEntityMO then
		self:_setSpineVoice()
		gohelper.setActive(self._goLeft, true)
		recthelper.setAnchorX(self._goRight.transform, 0)
	else
		gohelper.setActive(self._goLeft, false)
		recthelper.setAnchorX(self._goRight.transform, -413)
	end

	self._canPlayVoice = false

	TaskDispatcher.runDelay(self._setCanPlayVoice, self, 0.9)

	local nodeInfoList = self.gameInfo:getStageNodeInfoList(self.nodeInfo.stage)

	for k, v in ipairs(nodeInfoList) do
		if v.nodeId == self.nodeInfo.nodeId then
			local stageCo = Activity191Config.instance:getStageCfg(self.actId, v.stage)

			if stageCo then
				self._txtStage.text = string.format("<#FAB459>%s</color>-%d", stageCo.name, k)
			end

			break
		end
	end

	self.isPvp = Activity191Helper.isPvpBattle(self.nodeDetailMo.type)
	self.isPve = Activity191Helper.isPveBattle(self.nodeDetailMo.type)

	if self.isPvp then
		local titleStr = lua_activity191_const.configDict[Activity191Enum.ConstKey.PvpEpisodeName].value2

		titleStr = GameUtil.setFirstStrSize(titleStr, 70)

		local rankStr = lua_activity191_match_rank.configDict[self.nodeDetailMo.matchInfo.rank].fightLevel

		UISpriteSetMgr.instance:setAct174Sprite(self._imageLevel, "act191_level_" .. string.lower(rankStr))

		for _, mo in ipairs(self.enemyMoList) do
			local go = gohelper.cloneInPlace(self._goHeroItem)
			local simageIcon = gohelper.findChildSingleImage(go, "hero/simage_rolehead")

			if mo.entityType == FightEnum.EntityType.Monster then
				simageIcon:LoadImage(ResUrl.monsterHeadIcon(mo.skin))
			else
				simageIcon:LoadImage(ResUrl.getHeadIconSmall(mo.skin))
			end

			local goDead = gohelper.findChild(go, "go_dead")

			gohelper.setActive(goDead, mo:isStatusDead())
		end

		gohelper.setActive(self._goHeroItem, false)
	elseif self.isPve or self.nodeDetailMo.type == Activity191Enum.NodeType.BattleEvent then
		local fightEventCo = lua_activity191_fight_event.configDict[self.nodeDetailMo.fightEventId]

		UISpriteSetMgr.instance:setAct174Sprite(self._imageLevel, "act191_level_" .. string.lower(fightEventCo.fightLevel))

		local hpGo = self:getResInst(Activity191Enum.PrefabPath.BossHpItem, self._gobossHpRoot)

		MonoHelper.addNoUpdateLuaComOnceToGo(hpGo, Act191BossHpItem)
	end

	self:refreshReward()
	gohelper.setActive(self._goPve, not self.isPvp)
	gohelper.setActive(self._goPvp, self.isPvp)
end

function Act191FightSuccView:onClose()
	self._canPlayVoice = false

	gohelper.setActive(self._goSpine, false)
	Act191StatController.instance:statGameTime(self.viewName)
	FightController.onResultViewClose()
end

function Act191FightSuccView:onDestroyView()
	TaskDispatcher.cancelTask(self._setCanPlayVoice, self)
	self.actInfo:clearLastNodeInfo()
end

function Act191FightSuccView:_getRandomEntityMO()
	local mySideMOList = self.mySideMoList

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
	end
end

function Act191FightSuccView:_setCanPlayVoice()
	self._canPlayVoice = true

	self:_playSpineVoice()
end

function Act191FightSuccView:_setSpineVoice()
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

		recthelper.setAnchor(self._goSpine.transform, offsetX, offsetY)
		transformhelper.setLocalScale(self._goSpine.transform, scale, scale, scale)
	else
		gohelper.setActive(self._goSpine, false)
	end
end

function Act191FightSuccView:_playSpineVoice()
	if not self._canPlayVoice then
		return
	end

	if not self._spineLoaded then
		return
	end

	local voiceCOList = FightAudioMgr.instance:_getHeroVoiceCOs(self._randomEntityMO.modelId, CharacterEnum.VoiceType.FightResult, self._randomEntityMO.skin)

	if voiceCOList and #voiceCOList > 0 then
		local firstVoiceCO = voiceCOList[1]

		self._uiSpine:playVoice(firstVoiceCO, nil, self._txtSayCn, self._txtSayEn)
	end
end

function Act191FightSuccView:_getSkin(mo)
	local skinCO = FightConfig.instance:getSkinCO(mo.skin)
	local hasVerticalDrawing = skinCO and not string.nilorempty(skinCO.verticalDrawing)
	local hasLive2d = skinCO and not string.nilorempty(skinCO.live2d)

	if hasVerticalDrawing or hasLive2d then
		return skinCO
	end
end

function Act191FightSuccView:refreshReward()
	local rewardDic = {}

	if self.isPvp then
		if self.isWin then
			local isAuto = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191].auto
			local rewardKey = isAuto and "autoRewardView" or "rewardView"
			local typeKey = Activity191Enum.NodeType2Key[self.nodeDetailMo.type]
			local matchCo = lua_activity191_pvp_match.configDict[typeKey]
			local rewardList = GameUtil.splitString2(matchCo[rewardKey], true)

			for _, v in ipairs(rewardList) do
				rewardDic[v[1]] = not rewardDic[v[1]] and v[2] or rewardDic[v[1]] + v[2]
			end
		end
	else
		local triggerList = self.actInfo.triggerEffectPushList

		for _, v in ipairs(triggerList) do
			for _, effectId in ipairs(v.effectId) do
				local effectCo = lua_activity191_effect.configDict[effectId]

				if not string.nilorempty(effectCo.itemParam) then
					local rewardList = GameUtil.splitString2(effectCo.itemParam, true)

					for _, reward in ipairs(rewardList) do
						rewardDic[reward[1]] = not rewardDic[reward[1]] and reward[2] or rewardDic[reward[1]] + reward[2]
					end
				end
			end
		end
	end

	for id, count in pairs(rewardDic) do
		local rewardGo = self:getResInst(Activity191Enum.PrefabPath.RewardItem, self._goReward)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(rewardGo, Act191RewardItem)

		item:setData(id, count)
	end

	gohelper.setActive(self._goReward, tabletool.len(rewardDic) ~= 0)
end

return Act191FightSuccView
