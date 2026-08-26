-- chunkname: @modules/logic/fight/view/FightViewContainer.lua

module("modules.logic.fight.view.FightViewContainer", package.seeall)

local FightViewContainer = class("FightViewContainer", BaseViewContainer)

FightViewContainer.hanCardClass = FightViewHandCard
FightViewContainer.operationClass = FightViewPlayCard
FightViewContainer.playCardClass = FightViewWaitingAreaVersion1

function FightViewContainer:buildViews()
	local fightTechniqueListParam = ListScrollParam.New()

	fightTechniqueListParam.scrollGOPath = "root/#scroll_effecttips"
	fightTechniqueListParam.prefabType = ScrollEnum.ScrollPrefabFromView
	fightTechniqueListParam.prefabUrl = "root/#scroll_effecttips/Viewport/#go_item"
	fightTechniqueListParam.cellClass = FightViewTechniqueCell
	fightTechniqueListParam.scrollDir = ScrollEnum.ScrollDirV
	fightTechniqueListParam.lineCount = 1
	fightTechniqueListParam.cellWidth = 150
	fightTechniqueListParam.cellHeight = 145
	fightTechniqueListParam.cellSpaceH = 0
	fightTechniqueListParam.cellSpaceV = 25.1
	fightTechniqueListParam.startSpace = 0
	self.fightView = FightView.New()
	self.fightViewHandCard = FightViewContainer.hanCardClass.New()
	self.fightViewPlayCard = FightViewContainer.operationClass.New()
	self.waitingArea = nil

	local version = FightModel.instance:getVersion()

	self.waitingArea = version and version >= 1 and FightViewContainer.playCardClass.New() or FightViewWaitingArea.New()
	self.deviceAreaView = FightViewDeviceArea.New()
	self.rightElementLayoutView = FightViewRightElementsLayout.New()
	self.rightBottomElementLayoutView = FightViewRightBottomElementsLayout.New()
	self.viewMgr = FightViewMgr.New()

	local views = {
		self.rightElementLayoutView,
		self.rightBottomElementLayoutView,
		self.fightView,
		FightViewPartVisible.New(),
		self.fightViewHandCard,
		self.fightViewPlayCard,
		self.deviceAreaView,
		FightViewExPoint.New(),
		self.waitingArea,
		FightViewClothSkillMgrView.New(),
		FightViewTips.New(),
		FightViewSkillFrame.New(),
		FightViewTechnique.New(),
		LuaListScrollView.New(FightViewTechniqueListModel.instance, fightTechniqueListParam),
		FightViewDialog.New(),
		FightViewEnemyCard.New(),
		FightHideUIView.New(),
		FightEnemyInfoView.New(),
		FightViewTeachNote.New(),
		FightViewCheckActivityEnd.New(),
		FightIndicatorMgrView.New(),
		FightDreamlandTaskView.New(),
		FightPreDisplayView.New(),
		FightShuZhenView.New(),
		FightPlayerOperateMgr.New(),
		FightViewRougeMgr.New(),
		FightViewAssistBoss.New(),
		FightViewDissolveCard.New(),
		FightViewASFDEnergy.New(),
		FightViewRedAndBlueArea.New(),
		FightViewCounter.New()
	}

	table.insert(views, FightViewBossHpMgr.New())
	table.insert(views, self.viewMgr)
	table.insert(views, FightViewBuffId2Behaviour.New())

	return views
end

function FightViewContainer:openFightFocusView()
	local episodeCo = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if episodeCo and episodeCo.type == DungeonEnum.EpisodeType.Cachot then
		local controller = V1a6_CachotHeroGroupController.instance

		ViewMgr.instance:openView(ViewName.FightFocusView, {
			group = V1a6_CachotHeroGroupModel.instance:getCurGroupMO(),
			setEquipInfo = {
				controller.getFightFocusEquipInfo,
				controller
			}
		})

		return
	end

	if episodeCo and episodeCo.type == DungeonEnum.EpisodeType.Rouge then
		ViewMgr.instance:openView(ViewName.FightFocusView, {
			group = RougeHeroGroupModel.instance:getCurGroupMO(),
			balanceHelper = RougeHeroGroupBalanceHelper
		})

		return
	end

	ViewMgr.instance:openView(ViewName.FightFocusView)
end

function FightViewContainer:setCacheUserData(key, value)
	self.cacheUserDataDict = self.cacheUserDataDict or self:getUserDataTb_()
	self.cacheUserDataDict[key] = value
end

function FightViewContainer:getCacheUserData(key)
	if not self.cacheUserDataDict then
		return
	end

	return self.cacheUserDataDict[key]
end

return FightViewContainer
