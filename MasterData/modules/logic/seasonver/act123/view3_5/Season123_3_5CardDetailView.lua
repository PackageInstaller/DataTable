-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5CardDetailView.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5CardDetailView", package.seeall)

local Season123_3_5CardDetailView = class("Season123_3_5CardDetailView", BaseView)

function Season123_3_5CardDetailView:ctor(onlyCheck)
	Season123_3_5CardDetailView.super.ctor(self)

	self.onlyCheck = onlyCheck
end

function Season123_3_5CardDetailView:onInitView()
	self.txtDesc = gohelper.findChildTextMesh(self.viewGO, "root/#scroll_desc/Viewport/Content/#txt_desc")
	self.goHas = gohelper.findChild(self.viewGO, "root/card/has")
	self.goCardRoot = gohelper.findChild(self.viewGO, "root/card/has/go_card")
	self.btnCheck = gohelper.findChildButtonWithAudio(self.viewGO, "root/card/has/#btn_check")
	self.btnExchange = gohelper.findChildButtonWithAudio(self.viewGO, "root/card/has/#btn_exchange")
	self.goEmpty = gohelper.findChild(self.viewGO, "root/card/empty")
	self.btnAdd = gohelper.findChildButtonWithAudio(self.viewGO, "root/card/empty/#btn_add")
	self.slot = 1
	self.anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.animEvent = gohelper.onceAddComponent(self.viewGO, gohelper.Type_AnimationEventWrap)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_3_5CardDetailView:addEvents()
	self.animEvent:AddEventListener("switch", self._refreshCard, self)
	self.addClickCb(self, self.btnCheck, self._onClickCheck, self)
	self.addClickCb(self, self.btnExchange, self._onClickExchange, self)
	self.addClickCb(self, self.btnAdd, self._onClickAdd, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.EntryStageChanged, self._onRefresh, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.LocateToStage, self._onRefresh, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._onRefresh, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self._onRefresh, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.HeroGroupIndexChanged, self._onRefresh, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.RecordRspMainCardRefresh, self._onRefresh, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function Season123_3_5CardDetailView:removeEvents()
	self.animEvent:RemoveAllEventListener()
	self:removeClickCb(self.btnCheck)
	self:removeClickCb(self.btnExchange)
	self:removeClickCb(self.btnAdd)
	self.removeEventCb(self, Season123Controller.instance, Season123Event.EntryStageChanged, self._onRefresh, self)
	self.removeEventCb(self, Season123Controller.instance, Season123Event.LocateToStage, self._onRefresh, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._onRefresh, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self._onRefresh, self)
	self.removeEventCb(self, Season123Controller.instance, Season123Event.HeroGroupIndexChanged, self._onRefresh, self)
	self.removeEventCb(self, Season123Controller.instance, Season123Event.RecordRspMainCardRefresh, self._onRefresh, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function Season123_3_5CardDetailView:_editableInitView()
	return
end

function Season123_3_5CardDetailView:_onCloseViewFinish()
	if self.waitRefresh then
		self.waitRefresh = false

		self:_onRefresh()
	end
end

function Season123_3_5CardDetailView:_onClickCheck()
	if not self.equipId or self.equipId == 0 then
		return
	end

	Season123Controller.instance:openSeasonCardDescView(self.equipId)
end

function Season123_3_5CardDetailView:_onClickExchange()
	self:openEquipView()
end

function Season123_3_5CardDetailView:_onClickAdd()
	self:openEquipView()
end

function Season123_3_5CardDetailView:openEquipView()
	local actId = Season123Model.instance:getCurSeasonId()
	local stage = Season123EntryModel.instance:getCurrentStage()
	local param = {
		noShowToast = true,
		actId = actId,
		stage = stage,
		slot = self.slot
	}

	if not Season123Model.instance:isSeasonStagePosUnlock(actId, nil, param.slot, Season123EquipItemListModel.MainCharPos) then
		return
	end

	ViewMgr.instance:openView(Season123Controller.instance:getEquipHeroViewName(), param)
end

function Season123_3_5CardDetailView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Season123.play_fight_ui_uttu_card_slide)
	self:_onRefresh(true)
end

function Season123_3_5CardDetailView:initHeroGroupModel(actId, stage)
	if self.onlyCheck then
		return
	end

	local episodeList = Season123Config.instance:getSeasonEpisodeStageCos(actId, stage)
	local episodeConfig = episodeList[1]

	if not episodeConfig then
		return
	end

	local episodeId = episodeConfig.episodeId
	local dungeonEpisodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local battleId = dungeonEpisodeConfig and dungeonEpisodeConfig.battleId
	local layer = episodeConfig.layer

	Season123Model.instance:setBattleContext(actId, stage, layer, episodeId)
	Season123HeroGroupController.instance:initHeroGroupModel(actId, stage, layer, battleId, episodeId)
end

function Season123_3_5CardDetailView:_onRefresh(force)
	if not force then
		local isTop = ViewHelper.instance:checkViewOnTheTop(self.viewName)

		if not isTop then
			self.waitRefresh = true

			return
		end
	end

	local curStage = Season123EntryModel.instance:getCurrentStage()
	local actId = Season123Model.instance:getCurSeasonId()

	self:initHeroGroupModel(actId, curStage)

	local stageCO = Season123Config.instance:getStageCo(actId, curStage)
	local selectCardList = string.splitToNumber(stageCO.mainEquip, "#")
	local curCardId = Season123EquipController.instance:getCurMainEquipId(self.slot)
	local isEmpty = not curCardId or curCardId == 0
	local isChange = false

	if (#selectCardList == 1 or isEmpty) and curCardId ~= selectCardList[1] then
		isChange = true
		curCardId = selectCardList[1]
	end

	self:setMainCard(curCardId, selectCardList, self.onlyCheck)

	if isChange and not self.onlyCheck then
		Season123EquipHeroController.instance:realEquipItem(actId, curStage, self.slot, tostring(curCardId))
	end
end

function Season123_3_5CardDetailView:setMainCard(curCardId, selectCardList, onlyCheck)
	if self.equipId then
		local isChange = self.equipId ~= curCardId

		self.equipId = curCardId
		self.onlyCheck = onlyCheck
		self.selectCardList = selectCardList

		if isChange then
			AudioMgr.instance:trigger(AudioEnum.Season123.play_fight_ui_uttu_card_slide)
			self.anim:Play("switch", 0, 0)
		else
			self:_refreshCard()
		end
	end
end

function Season123_3_5CardDetailView:_refreshCard()
	self:refreshCard(self.equipId, self.selectCardList, self.onlyCheck)
end

function Season123_3_5CardDetailView:refreshCard(curCardId, selectCardList, onlyCheck)
	local isEmpty = not curCardId or curCardId == 0
	local canExchange = selectCardList and #selectCardList > 1

	if not isEmpty and not canExchange then
		onlyCheck = true
	end

	gohelper.setActive(self.goHas, not isEmpty)
	gohelper.setActive(self.goEmpty, isEmpty)
	gohelper.setActive(self.btnCheck, onlyCheck)
	gohelper.setActive(self.btnExchange, canExchange)

	if canExchange then
		Season123Controller.instance:dispatchEvent(Season123Event.CardDetailSwitch)
	end

	if not isEmpty then
		if not self.cardItem then
			self.cardItem = Season123_3_5CelebrityCardItem.New()

			self.cardItem:init(self.goCardRoot, curCardId, {
				noClick = true
			})
		else
			self.cardItem:reset(curCardId)
		end

		local cardConfig = Season123Config.instance:getSeasonEquipCo(curCardId)

		self.txtDesc.text = cardConfig.scoreTitle
	else
		self.txtDesc.text = luaLang("Season123CardDetailView_EmptyDesc")
	end
end

function Season123_3_5CardDetailView:onClose()
	return
end

function Season123_3_5CardDetailView:onDestroyView()
	if self.cardItem then
		self.cardItem:destroy()

		self.cardItem = nil
	end
end

return Season123_3_5CardDetailView
