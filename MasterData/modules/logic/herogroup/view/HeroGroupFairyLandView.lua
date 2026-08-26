-- chunkname: @modules/logic/herogroup/view/HeroGroupFairyLandView.lua

module("modules.logic.herogroup.view.HeroGroupFairyLandView", package.seeall)

local HeroGroupFairyLandView = class("HeroGroupFairyLandView", BaseView)

function HeroGroupFairyLandView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroGroupFairyLandView:addEvents()
	self.addEventCb(self, self.viewContainer, HeroGroupEvent.SwitchBalance, self._onSwitchBalance, self)
	self.addEventCb(self, self.viewContainer, HeroGroupEvent.BeforeEnterFight, self.beforeEnterFight, self)
	self.addEventCb(self, Activity126Controller.instance, Activity126Event.selectDreamLandCard, self._selectDreamLandCard, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.SwitchReplay, self._switchReplay, self)
end

function HeroGroupFairyLandView:removeEvents()
	self.removeEventCb(self, self.viewContainer, HeroGroupEvent.SwitchBalance, self._onSwitchBalance, self)
end

function HeroGroupFairyLandView:beforeEnterFight()
	if self._isSpEpisode then
		return
	end

	local fightParam = FightModel.instance:getFightParam()

	if self._taskConfig and self._cardConfig then
		Activity126Rpc.instance:sendEnterFightRequest(VersionActivity1_3Enum.ActivityId.Act310, self._cardConfig.id, fightParam.episodeId)

		return
	end

	local episode_config = DungeonConfig.instance:getEpisodeCO(fightParam.episodeId)
	local chapterId = episode_config.chapterId
	local chapterConfig = DungeonConfig.instance:getChapterCO(chapterId)

	if chapterConfig.actId == VersionActivity1_3Enum.ActivityId.Dungeon then
		Activity126Rpc.instance:sendEnterFightRequest(VersionActivity1_3Enum.ActivityId.Act310, 0, fightParam.episodeId)

		return
	end
end

function HeroGroupFairyLandView:_setTaskCo()
	local fightParam = FightModel.instance:getFightParam()
	local episode_config = DungeonConfig.instance:getEpisodeCO(fightParam.episodeId)

	if not episode_config or episode_config.type == DungeonEnum.EpisodeType.Sp then
		self._isSpEpisode = true

		return
	end

	self._taskConfig = HeroGroupFairyLandView.getDreamLandTask()
	self._useDreamCard = self._taskConfig and not string.nilorempty(self._taskConfig.dreamCards)
	self._cardConfig = self:_getFirstCard()

	if self._cloneGo then
		gohelper.destroy(self._cloneGo)

		self._cloneGo = nil
	end

	if self._btnclick then
		self._btnclick:RemoveClickListener()

		self._btnclick = nil
	end

	if self._effectLoader then
		self._effectLoader:dispose()

		self._effectLoader = nil
	end

	if self._taskConfig and self._cardConfig then
		self:_adjustHerogroupPos()
		self:_initFairyLandCard()
	else
		local gofairylandcard = gohelper.findChild(self.viewGO, "#go_fairylandcard")

		gohelper.setActive(gofairylandcard, false)
		self:resetUIPos()
	end

	for i = 1, 4 do
		local item = gohelper.findChild(self._containerAnimator.gameObject, "hero/item" .. i)

		if item then
			local anchorPos = recthelper.rectToRelativeAnchorPos(self._objs[i].posGo.transform.position, self._containerAnimator.transform)

			recthelper.setAnchor(item.transform, anchorPos.x, anchorPos.y)
		end
	end
end

function HeroGroupFairyLandView:_onSwitchBalance()
	if self._animator then
		self._animator:Play("switch", 0, 0)
	end
end

function HeroGroupFairyLandView:resetUIPos()
	self._isSetUI = false

	for i = 1, 4 do
		recthelper.setAnchorX(self._objs[i].bgGo.transform, self._objs[i].bgX)
		recthelper.setAnchorX(self._objs[i].posGo.transform, self._objs[i].posX)
	end

	recthelper.setWidth(self._replayframe.transform, self._replayframeWidth)
	recthelper.setAnchorX(self._replayframe.transform, self._replayframeX)
	recthelper.setAnchorX(self._tip.transform, self._tipX)
end

function HeroGroupFairyLandView:_adjustHerogroupPos()
	if self._isSetUI then
		return
	end

	self._isSetUI = true
	self._containerAnimator.enabled = false

	local offsetX = -130

	for i = 1, 4 do
		recthelper.setAnchorX(self._objs[i].bgGo.transform, self._objs[i].bgX + offsetX)
		recthelper.setAnchorX(self._objs[i].posGo.transform, self._objs[i].posX + offsetX)
	end

	recthelper.setWidth(self._replayframe.transform, 1340)
	recthelper.setAnchorX(self._replayframe.transform, -60)
	recthelper.setAnchorX(self._tip.transform, -156)
end

function HeroGroupFairyLandView.getDreamLandTask()
	local fightParam = FightModel.instance:getFightParam()
	local episode_config = DungeonConfig.instance:getEpisodeCO(fightParam.episodeId)
	local chapterId = episode_config.chapterId
	local chapterConfig = DungeonConfig.instance:getChapterCO(chapterId)

	if chapterConfig.actId ~= VersionActivity1_3Enum.ActivityId.Dungeon then
		return
	end

	local battleId = DungeonConfig.instance:getEpisodeBattleId(fightParam.episodeId)

	for i, v in ipairs(lua_activity126_dreamland.configList) do
		if string.find(v.battleIds, battleId) then
			return v
		end
	end
end

function HeroGroupFairyLandView:_initFairyLandCard()
	self:_loadEffect()
end

function HeroGroupFairyLandView:_loadEffect()
	self._effectUrl = "ui/viewres/herogroup/herogroupviewfairylandcard.prefab"
	self._effectLoader = MultiAbLoader.New()

	self._effectLoader:addPath(self._effectUrl)
	self._effectLoader:startLoad(self._effectLoaded, self)
end

function HeroGroupFairyLandView:_effectLoaded(effectLoader)
	local gofairylandcard = gohelper.findChild(self.viewGO, "#go_fairylandcard")

	gohelper.setActive(gofairylandcard, true)

	local assetItem = effectLoader:getAssetItem(self._effectUrl)
	local effectPrefab = assetItem:GetResource(self._effectUrl)
	local go = gohelper.clone(effectPrefab, gofairylandcard)

	self._cloneGo = go
	self._goflag = gohelper.findChild(go, "#go_fairylandcard/fairylandcard/image_story")

	gohelper.setActive(self._goflag, self._useDreamCard)

	self._animator = go:GetComponent(typeof(UnityEngine.Animator))
	self._gofairylandcard = gohelper.findChild(self.viewGO, "#go_fairylandcard/#go_fairylandcard")
	self._txtcardname = gohelper.findChildText(go, "#go_fairylandcard/fairylandcard/cardnamebg/#txt_cardname")
	self._imagecard = gohelper.findChildImage(go, "#go_fairylandcard/fairylandcard/#image_card")
	self._btnclick = gohelper.findChildButtonWithAudio(go, "#go_fairylandcard/#btn_click")

	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self:_updateDreamLandCardInfo()
end

function HeroGroupFairyLandView:_btnclickOnClick()
	if self._isReplay then
		return
	end

	VersionActivity1_3BuffController.instance:openFairyLandView({
		self._taskConfig,
		self._cardConfig
	})
end

function HeroGroupFairyLandView:_editableInitView()
	local herogroupcontain = gohelper.findChild(self.viewGO, "herogroupcontain")

	self._containerAnimator = herogroupcontain:GetComponent(typeof(UnityEngine.Animator))
	self._objs = {}

	for i = 1, 4 do
		self._objs[i] = self:getUserDataTb_()
		self._objs[i].bgGo = gohelper.findChild(self.viewGO, "herogroupcontain/hero/bg" .. i)
		self._objs[i].posGo = gohelper.findChild(self.viewGO, "herogroupcontain/area/pos" .. i)
		self._objs[i].bgX = recthelper.getAnchorX(self._objs[i].bgGo.transform)
		self._objs[i].posX = recthelper.getAnchorX(self._objs[i].posGo.transform)
	end

	self._replayframe = gohelper.findChild(self.viewGO, "#go_container/#go_replayready/#simage_replayframe")
	self._replayframeWidth = recthelper.getWidth(self._replayframe.transform)
	self._replayframeX = recthelper.getAnchorX(self._replayframe.transform)
	self._tip = gohelper.findChild(self.viewGO, "#go_container/#go_replayready/tip")
	self._tipX = recthelper.getAnchorX(self._tip.transform)

	self:_setTaskCo()

	if self._taskConfig and not self._cardConfig then
		GameFacade.showToast(ToastEnum.Activity126_tip11)
	end
end

function HeroGroupFairyLandView:onOpen()
	self:_setTaskDes()
end

function HeroGroupFairyLandView:_setTaskDes()
	local goTask = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_task")

	if not self._taskConfig then
		gohelper.setActive(goTask, false)

		return
	end

	local txtTask = gohelper.findChildText(self.viewGO, "#go_container/#scroll_info/infocontain/#go_task/#go_taskitem/taskitembg/#txt_task")

	txtTask.text = self._taskConfig.desc

	gohelper.setActive(goTask, true)
end

function HeroGroupFairyLandView:_switchReplay(replay)
	if not self._taskConfig then
		return
	end

	if self._animator then
		self._animator:Play("switch", 0, 0)
	end

	self._isReplay = replay

	TaskDispatcher.cancelTask(self._doSwitchReplay, self)

	if self._isReplay then
		TaskDispatcher.runDelay(self._doSwitchReplay, self, 0.16)
	end
end

function HeroGroupFairyLandView:_doSwitchReplay()
	if self._isReplay then
		local heroGroupMo = HeroGroupModel.instance:getReplayParam()

		if not heroGroupMo then
			return
		end

		local exInfos = heroGroupMo.exInfos
		local id = exInfos and exInfos[1]

		if not id then
			return
		end

		local config = lua_activity126_dreamland_card.configDict[id]

		if not config then
			return
		end

		self:_selectDreamLandCard(config)
	end
end

function HeroGroupFairyLandView:_selectDreamLandCard(dreamlandCardConfig)
	self._cardConfig = dreamlandCardConfig

	self:_updateDreamLandCardInfo()
end

function HeroGroupFairyLandView:_updateDreamLandCardInfo()
	if not self._cardConfig or not self._imagecard then
		return
	end

	UISpriteSetMgr.instance:setV1a3FairyLandCardSprite(self._imagecard, "v1a3_fairylandcard_" .. self._cardConfig.id - 2130000)

	local skillId = self._cardConfig.skillId
	local skillConfig = lua_skill.configDict[skillId]

	self._txtcardname.text = skillConfig and skillConfig.name
end

function HeroGroupFairyLandView:_getFirstCard()
	if not self._useDreamCard then
		local id = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityDungeon1_3SelectedDreamCard), 0)
		local config = lua_activity126_dreamland_card.configDict[id]

		if config then
			return config
		end
	end

	for i, v in ipairs(lua_activity126_dreamland_card.configList) do
		if self:_hasDreamCard(v.id) then
			return v
		end
	end
end

function HeroGroupFairyLandView:_hasDreamCard(id)
	if self._taskConfig and self._useDreamCard then
		return string.find(self._taskConfig.dreamCards, id)
	end

	return Activity126Model.instance:hasDreamCard(id)
end

function HeroGroupFairyLandView:onClose()
	if self._btnclick then
		self._btnclick:RemoveClickListener()
	end

	if self._animator then
		self._animator.enabled = true

		self._animator:Play("close", 0, 0)
	end

	TaskDispatcher.cancelTask(self._doSwitchReplay, self)
end

function HeroGroupFairyLandView:onDestroyView()
	if self._cloneGo then
		gohelper.destroy(self._cloneGo)

		self._cloneGo = nil
	end

	if self._effectLoader then
		self._effectLoader:dispose()
	end
end

return HeroGroupFairyLandView
