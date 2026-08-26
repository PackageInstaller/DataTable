-- chunkname: @modules/logic/fight/view/FightTopRightView.lua

module("modules.logic.fight.view.FightTopRightView", package.seeall)

local FightTopRightView = class("FightTopRightView", FightBaseView)

function FightTopRightView:onInitView()
	self.topRightBtnRoot = gohelper.findChild(self.viewGO, "root/btns")
end

function FightTopRightView:addEvents()
	return
end

function FightTopRightView:removeEvents()
	return
end

function FightTopRightView:onOpen()
	self:checkAddSurvivalBtn()
	self:com_openSubView(FightAutoBtnView, gohelper.findChild(self.topRightBtnRoot, "btnAuto"))
	self:showSystemFightTask()
	self:showSkipBattleBtn()
end

function FightTopRightView:showSkipBattleBtn()
	local episodeId = FightDataHelper.fieldMgr.episodeId

	if not DungeonModel.instance:hasPassLevel(episodeId) then
		return
	end

	if not FightDataHelper.fieldMgr:isDungeonType(DungeonEnum.EpisodeType.SystemFightManual) then
		return
	end

	local config = lua_fight_direct_switch_battle_when_end.configDict[FightDataHelper.fieldMgr.battleId]

	if not config then
		return
	end

	local url = "ui/viewres/fight/fightskipbattlebtn.prefab"

	self:com_loadAsset(url, self.onSkipBattleBtnLoaded)
end

function FightTopRightView:onSkipBattleBtnLoaded(success, assetItem)
	if not success then
		return
	end

	local resObj = assetItem:GetResource()
	local obj = gohelper.clone(resObj, self.topRightBtnRoot)

	gohelper.setAsFirstSibling(obj)

	local click = gohelper.getClickWithDefaultAudio(obj)

	self:com_registClick(click, self.onClickSkipBattle)
end

function FightTopRightView:onClickSkipBattle()
	FightDataHelper.tempMgr.isSkipBattle = true

	FightRpc.instance:sendEndFightRequest(true)
	FightGameMgr.restartMgr:directSwitchBattle()
end

function FightTopRightView:checkAddSurvivalBtn()
	local isSurvival = FightDataHelper.fieldMgr:isShelter() or FightDataHelper.fieldMgr:isSurvival()

	if not isSurvival then
		return
	end

	local url = "ui/viewres/fight/fightsurvivalbagbtnview.prefab"

	self.survivalBtnLoader = PrefabInstantiate.Create(self.topRightBtnRoot)

	self.survivalBtnLoader:startLoad(url, self.onSurvivalBtnLoaded, self)
end

function FightTopRightView:onSurvivalBtnLoaded()
	local btnGo = self.survivalBtnLoader:getInstGO()

	gohelper.setAsFirstSibling(btnGo)

	self.survivalClick = gohelper.getClickWithDefaultAudio(btnGo)

	self.survivalClick:AddClickListener(self.onClickCollection, self)
end

function FightTopRightView:onClickCollection()
	ViewMgr.instance:openView(ViewName.SurvivalEquipOverView)
end

function FightTopRightView:showSystemFightTask()
	local episodeId = FightDataHelper.fieldMgr.episodeId
	local config = lua_teaching_episode.configDict[episodeId]

	if not config then
		return
	end

	if string.nilorempty(config.battleTasks) then
		return
	end

	local parentRoot = self.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.SystemFightTask)
	local url = "ui/viewres/teaching/teachingfighttargetview.prefab"

	self.taskView = self:com_openSubView(FightTeachingFightTaskView, url, parentRoot, config)

	self.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.SystemFightTask)
end

function FightTopRightView:onClose()
	if self.survivalBtnLoader then
		self.survivalBtnLoader:dispose()

		self.survivalBtnLoader = nil
	end

	if self.survivalClick then
		self.survivalClick:RemoveClickListener()

		self.survivalClick = nil
	end
end

function FightTopRightView:onDestroyView()
	return
end

return FightTopRightView
