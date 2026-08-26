-- chunkname: @modules/logic/abyss/view/AbyssStageDetailsView.lua

module("modules.logic.abyss.view.AbyssStageDetailsView", package.seeall)

local AbyssStageDetailsView = class("AbyssStageDetailsView", BaseView)

function AbyssStageDetailsView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._scrollherogroup = gohelper.findChildScrollRect(self.viewGO, "Left/#scroll_herogroup")
	self._goheroitem = gohelper.findChild(self.viewGO, "Left/#scroll_herogroup/Viewport/Content/#go_heroitem")
	self._gorevive = gohelper.findChild(self.viewGO, "Left/#scroll_herogroup/Viewport/Content/#go_heroitem/txtbg/#go_revive")
	self._gorolebg = gohelper.findChild(self.viewGO, "Left/#scroll_herogroup/Viewport/Content/#go_heroitem/#go_rolebg")
	self._goherobg = gohelper.findChild(self.viewGO, "Left/#scroll_herogroup/Viewport/Content/#go_heroitem/#go_rolebg/#go_herobg")
	self._goroles = gohelper.findChild(self.viewGO, "Left/#scroll_herogroup/Viewport/Content/#go_heroitem/#go_roles")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#scroll_herogroup/Viewport/Content/#go_heroitem/#btn_reset")
	self._btnbuff = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#scroll_herogroup/Viewport/Content/#go_heroitem/#btn_buff")
	self._goadd = gohelper.findChild(self.viewGO, "Left/#scroll_herogroup/Viewport/Content/#go_heroitem/#btn_buff/#go_add")
	self._goline = gohelper.findChild(self.viewGO, "Left/#scroll_herogroup/Viewport/Content/#go_heroitem/#btn_buff/#go_line")
	self._goicon = gohelper.findChild(self.viewGO, "Left/#scroll_herogroup/Viewport/Content/#go_heroitem/#btn_buff/#go_icon")
	self._gounselect = gohelper.findChild(self.viewGO, "Left/#scroll_herogroup/Viewport/Content/#go_heroitem/#go_unselect")
	self._btnchangeteam = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#drop_herogroup/#btn_changeteam")
	self._gochangename = gohelper.findChild(self.viewGO, "Left/#drop_herogroup/#btn_changename")
	self._dropherogroup = gohelper.findChildDropdown(self.viewGO, "Left/#drop_herogroup")
	self._txttitle = gohelper.findChildText(self.viewGO, "Right/Title/#txt_title")
	self._goCareer = gohelper.findChild(self.viewGO, "Right/recommend/carreer/#go_Career")
	self._goCareerItem = gohelper.findChild(self.viewGO, "Right/recommend/carreer/#go_Career/#go_CareerItem")
	self._txtlevel = gohelper.findChildText(self.viewGO, "Right/recommend/level/#txt_level")
	self._gorconditionitem = gohelper.findChild(self.viewGO, "Right/chapterconditions/scroll_info/viewport/content/#go_rconditionitem")
	self._gostar1 = gohelper.findChild(self.viewGO, "Right/chapterconditions/scroll_info/viewport/content/#go_rconditionitem/#go_star1")
	self._gostar2 = gohelper.findChild(self.viewGO, "Right/chapterconditions/scroll_info/viewport/content/#go_rconditionitem/#go_star2")
	self._gostar3 = gohelper.findChild(self.viewGO, "Right/chapterconditions/scroll_info/viewport/content/#go_rconditionitem/#go_star3")
	self._gostar4 = gohelper.findChild(self.viewGO, "Right/chapterconditions/scroll_info/viewport/content/#go_rconditionitem/#go_star4")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_start")
	self._btntuijian = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_tuijian")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._btn_enemy = gohelper.findChildButton(self.viewGO, "Right/Title/#btn_enemy")
	self._btnReadPreset = gohelper.findChildButton(self.viewGO, "Left/#btn_readpreset")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AbyssStageDetailsView:addEvents()
	self._btnchangeteam:AddClickListener(self._btnchangeteamOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btntuijian:AddClickListener(self._btntuijianOnClick, self)
	self._btn_enemy:AddClickListener(self._btn_enemyOnClick, self)
	self._btnReadPreset:AddClickListener(self._btnReadPresetOnClick, self)
	self.addEventCb(self, AbyssController.instance, AbyssEvent.OnResetStage, self._onStageInfoChanged, self)
	self.addEventCb(self, AbyssController.instance, AbyssEvent.OnUpdateStageInfo, self._onStageInfoChanged, self)
	self.addEventCb(self, AbyssController.instance, AbyssEvent.OnSelectStage, self.onSelectStage, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._onModifyHeroGroup, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self._onSnapshotSaveSucc, self)
	self.addEventCb(self, HeroGroupController.instance, AbyssEvent.OnAbyssLastUpdateTimeChange, self._onStageInfoChanged, self)
	self.addEventCb(self, HeroGroupPresetController.instance, HeroGroupPresetEvent.UseHeroGroup, self._onUseHeroGroup, self)
end

function AbyssStageDetailsView:removeEvents()
	self._btnchangeteam:RemoveClickListener()
	self._btnstart:RemoveClickListener()
	self._btntuijian:RemoveClickListener()
	self._btn_enemy:RemoveClickListener()
	self._btnReadPreset:RemoveClickListener()
	self.removeEventCb(self, AbyssController.instance, AbyssEvent.OnResetStage, self._onStageInfoChanged, self)
	self.removeEventCb(self, AbyssController.instance, AbyssEvent.OnUpdateStageInfo, self._onStageInfoChanged, self)
	self.removeEventCb(self, AbyssController.instance, AbyssEvent.OnSelectStage, self.onSelectStage, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._onModifyHeroGroup, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self._onSnapshotSaveSucc, self)
	self.removeEventCb(self, HeroGroupController.instance, AbyssEvent.OnAbyssLastUpdateTimeChange, self._onStageInfoChanged, self)
	self.removeEventCb(self, HeroGroupPresetController.instance, HeroGroupPresetEvent.UseHeroGroup, self._onUseHeroGroup, self)
end

function AbyssStageDetailsView:_onModifyHeroGroup()
	return
end

function AbyssStageDetailsView:_onUseHeroGroup(param)
	if not param or not param.groupId or not param.subId then
		return
	end

	if self.infoMo then
		local stageMo = self.infoMo:getStageInfo(self.curStageId)

		if stageMo:isChallenged() then
			return
		end

		if stageMo then
			if not stageMo.heroGroupSubId then
				local targetSubId = 1
				local targetMo = HeroGroupPresetController.instance:copyPresetToOther(param.groupId, param.subId, HeroGroupPresetEnum.HeroGroupType.Abyss, targetSubId, false)

				if targetMo == nil then
					return
				end

				AbyssController.instance:saveSnapShot(targetMo, targetSubId)
			end
		end
	end
end

function AbyssStageDetailsView:_onSnapshotSaveSucc(snapshotId, snapshotSubId)
	if snapshotId ~= HeroGroupPresetEnum.HeroGroupType.Abyss then
		return
	end

	if not self._stageItemList then
		return
	end

	local actInfo = AbyssModel.instance:getCurInfoMo()

	actInfo:updateHeroUseInfo()

	for _, item in ipairs(self._stageItemList) do
		self:_refreshStageItemHeroInfo(item)
	end
end

function AbyssStageDetailsView:_btn_enemyOnClick()
	EnemyInfoController.instance:openEnemyInfoViewByBattleId(self.episodeConfig.battleId)
end

function AbyssStageDetailsView:_btnReadPresetOnClick()
	if self.infoMo then
		local stageMo = self.infoMo:getStageInfo(self.curStageId)

		if self.infoMo:isChallenged() then
			GameFacade.showToast(ToastEnum.AbyssHeroGroupCannotEdit)

			return
		end

		local heroGroupType = HeroGroupPresetEnum.HeroGroupType.AbyssPreset

		HeroGroupPresetController.instance:openHeroGroupPresetTeamView({
			showType = HeroGroupPresetEnum.ShowType.Copy,
			heroGroupTypeList = {
				heroGroupType
			}
		})
	end
end

function AbyssStageDetailsView:_btnchangeteamOnClick()
	local heroGroupType = HeroGroupPresetEnum.HeroGroupType.Abyss

	if self.infoMo then
		local stageMo = self.infoMo:getStageInfo(self.curStageId)

		if self.infoMo then
			if not self.infoMo.heroGroupSubId then
				local subId = 1

				HeroGroupPresetController.instance:openHeroGroupPresetTeamView({
					subId = subId,
					showType = HeroGroupPresetEnum.ShowType.Fight,
					heroGroupTypeList = {
						heroGroupType
					}
				})
			end
		end
	end
end

function AbyssStageDetailsView:_initFightGroupDrop()
	if not self._dropherogroup then
		return
	end

	local list = {}

	if self.episodeConfig then
		if self.episodeConfig == DungeonEnum.EpisodeType.Abyss then
			local groupList = HeroGroupSnapshotModel.instance:getHeroGroupSnapshotList(HeroGroupPresetEnum.HeroGroupType.Abyss)

			if groupList then
				if not #groupList then
					local num = 4

					for i = 1, num do
						local groupInfo = groupList[i]

						list[i] = HeroGroupPresetHeroGroupNameController.instance:getName(HeroGroupPresetEnum.HeroGroupType.Abyss, groupInfo.groupId)
					end
				end
			end
		else
			for i = 1, 4 do
				list[i] = HeroGroupModel.instance:getCommonGroupName(i)
			end
		end

		if self.infoMo then
			local stageMo = self.infoMo:getStageInfo(self.curStageId)
			local isChallenged = stageMo and stageMo:isChallenged()

			if stageMo then
				if not stageMo.heroGroupSubId then
					local selectIndex = 1

					self._dropherogroup:ClearOptions()
					self._dropherogroup:AddOptions(list)
					self._dropherogroup:SetValue(selectIndex - 1)
					gohelper.setActive(self._btnchangeteam, true)
				end
			end
		end
	end
end

function AbyssStageDetailsView:_groupDropValueChanged(value)
	if not self.curStageId then
		return
	end

	local actInfo = AbyssModel.instance:getCurInfoMo()

	actInfo:updateHeroUseInfo()

	for _, item in ipairs(self._stageItemList) do
		self:_refreshStageItemHeroInfo(item)
	end
end

function AbyssStageDetailsView:_btnstartOnClick()
	if not AbyssModel.instance:isCurActOpen(true) then
		return
	end

	local actId = AbyssModel.instance:getCurActId()
	local stageId = self.curStageId

	AbyssController.instance:startFight(actId, stageId)
end

function AbyssStageDetailsView:_btntuijianOnClick()
	if not self.curStageConfig then
		return
	end

	local episodeId = self.curStageConfig.episodeId
	local actId = AbyssModel.instance:getCurActId()
	local stageId = AbyssConfig.instance:getStageIdByEpisodeId(actId, episodeId)

	AbyssModel.instance:setCurStageId(stageId)

	local stageMo = AbyssModel.instance:getCurStageMo()
	local groupInfo = HeroGroupSnapshotModel.instance:getById(ModuleEnum.HeroGroupSnapshotType.Abyss)

	groupInfo:setSelectIndex(stageMo.heroGroupSubId or 1)

	if stageMo then
		if not stageMo.heroGroupSubId then
			local selectIndex = 1

			HeroGroupModel.instance:setCurGroupId(selectIndex)
			DungeonRpc.instance:sendGetEpisodeHeroRecommendRequest(episodeId, self._receiveRecommend, self)
		end
	end
end

function AbyssStageDetailsView:_receiveRecommend(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	HeroGroupRecommendGroupListModel.instance:setCurEpisodeId(self.episodeConfig.id)
	HeroGroupModel.instance:setBattleAndEpisodeId(self.episodeConfig.battleId, self.episodeConfig.id)
	ViewMgr.instance:openView(ViewName.HeroGroupRecommendView, msg)
end

function AbyssStageDetailsView._btnresetOnClick(param)
	local item = param.item

	AbyssController.instance:tryResetStage(item.stageId)
end

function AbyssStageDetailsView.onBuffItemOnClick(param)
	local item = param.item
	local stageId = item.stageId
	local actId = AbyssModel.instance:getCurActId()
	local stageInfo = AbyssModel.instance:getStageInfoMo(actId, stageId)

	if not stageInfo then
		return
	end

	if stageId ~= AbyssModel.instance:getCurStageId() then
		local target = param.target

		target:switchStage(stageId)
	end

	AbyssController.instance:openBuffSelectView(stageId)
end

function AbyssStageDetailsView:_editableInitView()
	self._stageItemList = {}
	self.imageStartBg = gohelper.findChildImage(self.viewGO, "Right/#btn_start/bg_flow")
	self.txtStart = gohelper.findChildTextMesh(self.viewGO, "Right/#btn_start/txt")

	gohelper.setActive(self._gochangename, false)

	self._dropherogroup.dropDown.enabled = false

	gohelper.setActive(self._goCareerItem, false)
end

function AbyssStageDetailsView:onUpdateParam()
	return
end

function AbyssStageDetailsView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_6.Abyss.play_ui_stage_open)
	self:checkParam()
	self:refreshUI()
end

function AbyssStageDetailsView:checkParam()
	local param = self.viewParam

	if not param or not param.actId then
		logError("新深渊 没有活动数据")

		return
	end

	self.actId = param.actId

	AbyssModel.instance:setCurActId(self.actId)

	local infoMo = AbyssModel.instance:getCurInfoMo()

	self.infoMo = infoMo

	if infoMo then
		self.stageInfoList = infoMo.stageInfoList or {}
	end

	self.stageConfigList = AbyssConfig.instance:getStageConfigListByActId(self.actId)

	if not self.stageConfigList or not next(self.stageConfigList) then
		logError("新深渊 没有关卡配置 actId:" .. tostring(self.actId))

		return
	end

	if param.stageId then
		self.curStageId = param.stageId
	else
		local firstConfig = self.stageConfigList[1]

		self.curStageId = firstConfig.stage
	end

	AbyssModel.instance:setCurStageId(self.curStageId)
end

function AbyssStageDetailsView:refreshUI()
	self:refreshTargetList()
	self:refreshStageList()
	self:refreshRecommendInfo()
end

function AbyssStageDetailsView:switchStage(stageId)
	if self.curStageId == stageId then
		return
	end

	self.curStageId = stageId

	AbyssModel.instance:setCurStageId(stageId)
	self:refreshTargetList()
	self:refreshRecommendInfo()
	self:refreshStageSelectState()
	self:refreshStageInfo()
end

function AbyssStageDetailsView:refreshStageInfo()
	if not self.curStageId then
		return
	end

	if self.infoMo then
		local stageMo = self.infoMo:getStageInfo(self.curStageId)
		local haveChallenge = stageMo and stageMo:isChallenged()

		if haveChallenge then
			if not AbyssEnum.Color.HaveChallenge then
				local color = AbyssEnum.Color.NotChallenge

				if not haveChallenge then
					if not AbyssEnum.TxtParam.StartChallenge then
						local startTitle = AbyssEnum.TxtParam.ReStartChallenge

						SLFramework.UGUI.GuiHelper.SetColor(self.imageStartBg, color)

						self.txtStart.text = luaLang(startTitle)
					end
				end
			end
		end
	end
end

function AbyssStageDetailsView:refreshStageList()
	if not self.stageConfigList then
		return
	end

	gohelper.CreateObjList(self, self.onStageItemCreate, self.stageConfigList, nil, self._goheroitem)
end

function AbyssStageDetailsView:onStageItemCreate(itemGo, stageConfig, index)
	local stageId = stageConfig.stage
	local item = self._stageItemList[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = itemGo
		item.goUnselect = gohelper.findChild(itemGo, "#go_unselect")
		item.goRoles = gohelper.findChild(itemGo, "#go_roles")
		item.goRoleBg = gohelper.findChild(itemGo, "#go_roles/#go_rolebg")
		item.goHeroItem = gohelper.findChild(itemGo, "#go_roles/#go_heroitem")
		item.btnSelect = gohelper.findChildButtonWithAudio(itemGo, "#btn_select")

		item.btnSelect:AddClickListener(self.onStageItemSelectClick, {
			target = self,
			item = item
		})

		item._chipItemList = {}

		local goClipNode = gohelper.findChild(itemGo, "#go_clipNode")

		for i = 1, 3 do
			item._chipItemList[i] = gohelper.findChild(goClipNode, "clip" .. i)
		end

		item._txtcliptitle = gohelper.findChildTextMesh(itemGo, "#go_clipNode/#txt_cliptitle")
		item.goStarLayout = gohelper.findChild(itemGo, "#go_clipNode/#go_starlayout")
		item.goStarGroup = gohelper.findChild(itemGo, "#go_clipNode/#go_starlayout/#go_stargroup")
		item.btn_reset = gohelper.findChildButtonWithAudio(itemGo, "#btn_reset")

		item.btn_reset:AddClickListener(self._btnresetOnClick, {
			target = self,
			item = item
		})

		item.btn_buff = gohelper.findChildButtonWithAudio(itemGo, "#btn_buff")

		item.btn_buff:AddClickListener(self.onBuffItemOnClick, {
			target = self,
			item = item
		})

		item.goAdd = gohelper.findChild(itemGo, "#btn_buff/#go_add")
		item.goLine = gohelper.findChild(itemGo, "#btn_buff/#go_line")
		item.imageBuff = gohelper.findChildImage(itemGo, "#btn_buff/#go_icon")
		item.heroHeadItemList = {}
		item.txtState = gohelper.findChildTextMesh(itemGo, "txtbg/#go_revive")
		self._stageItemList[index] = item
	end

	item.stageId = stageId

	self:_refreshStageItemHeroInfo(item)

	for i, clipGo in ipairs(item._chipItemList) do
		gohelper.setActive(clipGo, i == index)
	end

	gohelper.setActive(item.goUnselect, stageId ~= self.curStageId)
end

function AbyssStageDetailsView.onStageItemSelectClick(param)
	local target = param.target
	local item = param.item

	target:switchStage(item.stageId)
end

function AbyssStageDetailsView:onSelectStage(stageId, pos)
	self:switchStage(stageId)
	AbyssController.instance:openTeamPresetView(stageId, nil, nil, pos)
end

function AbyssStageDetailsView:refreshStageSelectState()
	if not self._stageItemList then
		return
	end

	for _, item in ipairs(self._stageItemList) do
		gohelper.setActive(item.goUnselect, item.stageId ~= self.curStageId)
	end
end

function AbyssStageDetailsView:_onStageInfoChanged(actId, stageId)
	if actId and actId ~= self.actId then
		return
	end

	self.infoMo = AbyssModel.instance:getCurInfoMo()

	if self.infoMo then
		self.stageInfoList = self.infoMo.stageInfoList or {}
	end

	if not self._stageItemList then
		return
	end

	local actInfo = AbyssModel.instance:getCurInfoMo()

	actInfo:updateHeroUseInfo()

	for _, item in ipairs(self._stageItemList) do
		self:_refreshStageItemHeroInfo(item)
	end

	self:refreshTargetList()
end

function AbyssStageDetailsView:_refreshStageItemHeroInfo(item)
	local stageId = item.stageId

	if self.infoMo then
		local stageMo = self.infoMo:getStageInfo(stageId)
		local haveChallenge = stageMo and stageMo:isChallenged()

		gohelper.setActive(item.goRoles, true)
		gohelper.setActive(item.goRoleBg, false)
		gohelper.setActive(item.btn_reset, haveChallenge)

		local tempList = {}

		for i = 1, AbyssEnum.HeroMaxCount do
			local heroId
			local data = {}

			heroId = self:_getPresetHeroId(stageMo, i)
			data.heroId = heroId

			local actInfo = AbyssModel.instance:getCurInfoMo()

			data.isUsed = not haveChallenge and actInfo:isHeroUsed(heroId, stageMo.lastUpdateTime)
			data.heroId = heroId
			data.stageId = stageId
			data.pos = i
			data.isLock = not haveChallenge and AbyssModel.instance:isCurHeroLocked(heroId)
			data.haveChallenge = haveChallenge

			local heroConfig = HeroConfig.instance:getHeroCO(data.heroId)

			logNormal("_refreshStageItemHeroInfo index: " .. i .. " id:" .. data.heroId .. " name:" .. ((heroConfig or nil) and (heroConfig.name or "")) .. " stageId: " .. stageId .. " isUsed: " .. tostring(data.isUsed))

			tempList[i] = data
		end

		gohelper.CreateObjList(self, self.onHeroItemCreate, tempList, nil, item.goHeroItem, AbyssStageHeroEmptyItem, nil, nil)

		if stageMo then
			if not stageMo.star then
				local curStar = 0

				if stageMo then
					if not stageMo.totalStar then
						local maxStar = 0
						local stageConfig = AbyssConfig.instance:getEpisodeConfig(self.actId, stageId)
						local episodeConfig = DungeonConfig.instance:getEpisodeCO(stageConfig.episodeId)

						item._txtcliptitle.text = episodeConfig.name

						self:refreshStarState(item, haveChallenge, curStar, maxStar)

						item.txtState.text = haveChallenge and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("v3a6_abyss_stage_round_desc"), stageMo.round) or luaLang("v3a9_abyss_stage_not_challenged")

						if stageMo then
							if not stageMo.skillId then
								local skillId = 0

								if not skillId or skillId == 0 then
									gohelper.setActive(item.imageBuff.gameObject, false)

									if haveChallenge then
										gohelper.setActive(item.goLine, true)
										gohelper.setActive(item.goAdd, false)
									else
										gohelper.setActive(item.goLine, false)
										gohelper.setActive(item.goAdd, true)
									end
								else
									gohelper.setActive(item.goLine, false)
									gohelper.setActive(item.goAdd, false)

									local skillConfig = AbyssConfig.instance:getSkillConfig(skillId)

									if skillConfig and not string.nilorempty(skillConfig.icon) then
										UISpriteSetMgr.instance:setAbyssSprite(item.imageBuff, "jdsh_" .. skillConfig.icon)
									end

									gohelper.setActive(item.imageBuff.gameObject, true)
								end
							end
						end
					end
				end
			end
		end
	end
end

function AbyssStageDetailsView:refreshStarState(item, haveChallenge, curStar, maxStar)
	local haveStar = maxStar and maxStar > 0

	gohelper.setActive(item.goStarLayout, haveStar)

	if not haveStar then
		return
	end

	self._curStarMaxStar = maxStar

	local starDic = {}

	for i = 1, maxStar do
		starDic[i] = haveChallenge and i <= curStar and 1 or 0
	end

	gohelper.CreateObjList(self, self.onStarItemCreate, starDic, nil, item.goStarGroup)
end

function AbyssStageDetailsView:onStarItemCreate(itemGo, state, index)
	local isFinish = state == 1
	local isFinal = index >= self._curStarMaxStar
	local starLocked = gohelper.findChild(itemGo, "star1")
	local starFinished = gohelper.findChild(itemGo, "star2")
	local starLocked2 = gohelper.findChild(itemGo, "star3")
	local starFinished2 = gohelper.findChild(itemGo, "star4")

	gohelper.setActive(starFinished, isFinish and not isFinal)
	gohelper.setActive(starLocked, not isFinish and not isFinal)
	gohelper.setActive(starFinished2, isFinish and isFinal)
	gohelper.setActive(starLocked2, not isFinish and isFinal)
end

function AbyssStageDetailsView:onHeroItemCreate(item, heroData, index)
	item:setInfo(heroData)
end

function AbyssStageDetailsView:_getPresetHeroId(stageMo, pos)
	if not stageMo or not stageMo.heroGroupSubId then
		return 0
	end

	local snapshotType = ModuleEnum.HeroGroupSnapshotType.Abyss
	local heroGroupMO = HeroGroupSnapshotModel.instance:getHeroGroupInfo(snapshotType, stageMo.heroGroupSubId, true)

	if not heroGroupMO or not heroGroupMO.heroList then
		return 0
	end

	local heroUid = heroGroupMO.heroList[pos]

	if not heroUid or tonumber(heroUid) <= 0 then
		return 0
	end

	local heroMo = HeroModel.instance:getById(heroUid)

	return (heroMo or nil) and (heroMo.heroId or 0)
end

function AbyssStageDetailsView:getCurStageConfig()
	if not self.stageConfigList then
		return nil
	end

	for _, config in ipairs(self.stageConfigList) do
		if config.stage == self.curStageId then
			return config
		end
	end

	return nil
end

function AbyssStageDetailsView:refreshTargetList()
	self.curStageConfig = self:getCurStageConfig()

	if not self.curStageConfig then
		return
	end

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(self.curStageConfig.episodeId)

	if not episodeConfig then
		logError("新深渊 没有战斗关卡数据 stageId:" .. tostring(self.curStageId) .. " episodeId:" .. tostring(self.curStageConfig.episodeId))

		return
	end

	self.episodeConfig = episodeConfig
	self._txttitle.text = episodeConfig.name

	HeroGroupModel.instance:setBattleAndEpisodeId(self.episodeConfig.battleId, self.episodeConfig.id)

	local conditionList = AbyssHelper.getEpisodeConditionDescList(self.curStageConfig.episodeId)

	gohelper.CreateObjList(self, self.onCreateTargetItem, conditionList, nil, self._gorconditionitem)
end

function AbyssStageDetailsView:onCreateTargetItem(itemGo, desc, index)
	local text = gohelper.findChildTextMesh(itemGo, "")
	local starUnlock = gohelper.findChild(itemGo, "#go_star1")
	local starFinish = gohelper.findChild(itemGo, "#go_star2")
	local starUnlock2 = gohelper.findChild(itemGo, "#go_star3")
	local starFinish2 = gohelper.findChild(itemGo, "#go_star4")
	local stageInfo = AbyssModel.instance:getCurStageMo()

	if stageInfo then
		::label_37_0::

		if stageInfo:isChallenged() then
			if stageInfo.star then
				local isFinish = true

				isFinish = index <= stageInfo.star

				local isFinal = stageInfo and index >= stageInfo.totalStar

				text.text = desc

				ZProj.UGUIHelper.SetColorAlpha(text, isFinish and 1 or 0.63)
				gohelper.setActive(starFinish, isFinish and not isFinal)
				gohelper.setActive(starUnlock, not isFinish and not isFinal)
				gohelper.setActive(starFinish2, isFinish and isFinal)
				gohelper.setActive(starUnlock2, not isFinish and isFinal)
			end
		end
	end
end

function AbyssStageDetailsView:refreshRecommendInfo()
	if not self.curStageConfig then
		return
	end

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(self.curStageConfig.episodeId)

	if not episodeConfig then
		return
	end

	self._txtlevel.text = AbyssHelper.getRecommendTeamList(self.curStageConfig.teamRecommend)

	local recommended

	if not string.nilorempty(self.curStageConfig.careerPrefer) then
		recommended = string.splitToNumber(self.curStageConfig.careerPrefer, "#")
	else
		logError("新深渊 关卡推荐属性为空 活动id: " .. tostring(self.curStageConfig.activityId) .. " 关卡id: " .. tostring(self.curStageConfig.stage))

		recommended = {}
	end

	gohelper.CreateObjList(self, self._onRecommendCareerItemShow, recommended, nil, self._goCareerItem, nil, nil, nil, 1)
end

function AbyssStageDetailsView:_onRecommendCareerItemShow(obj, data, index)
	gohelper.setActive(obj, true)

	local icon = gohelper.findChildImage(obj, "")

	UISpriteSetMgr.instance:setHeroGroupSprite(icon, "career_" .. data)
end

function AbyssStageDetailsView:onClose()
	return
end

function AbyssStageDetailsView:onDestroyView()
	if self._stageItemList and next(self._stageItemList) then
		for _, item in ipairs(self._stageItemList) do
			item.btnSelect:RemoveClickListener()

			if item.btn_reset then
				item.btn_reset:RemoveClickListener()
			end

			if item.btn_buff then
				item.btn_buff:RemoveClickListener()
			end
		end

		tabletool.clear(self._stageItemList)
	end
end

return AbyssStageDetailsView
