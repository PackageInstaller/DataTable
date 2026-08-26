-- chunkname: @modules/logic/enemyinfo/view/EnemyInfoEnterView.lua

module("modules.logic.enemyinfo.view.EnemyInfoEnterView", package.seeall)

local EnemyInfoEnterView = class("EnemyInfoEnterView", BaseViewExtended)

function EnemyInfoEnterView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function EnemyInfoEnterView:addEvents()
	return
end

function EnemyInfoEnterView:removeEvents()
	return
end

function EnemyInfoEnterView:_editableInitView()
	self.simageRightBg = gohelper.findChildSingleImage(self.viewGO, "bg_container/#simage_rightbg")

	self.simageRightBg:LoadImage("singlebg/dungeon/bg_battledetail.png")

	self.trTabContainer = gohelper.findChildComponent(self.viewGO, "#go_tab_container", gohelper.Type_Transform)

	for i = 0, self.trTabContainer.childCount - 1 do
		local tr = self.trTabContainer:GetChild(i)

		gohelper.setActive(tr.gameObject, false)
	end
end

function EnemyInfoEnterView:initHandleDict()
	if self.tabEnum2HandleFunc then
		return
	end

	self.tabEnum2HandleFunc = {
		[EnemyInfoEnum.TabEnum.Normal] = self.refreshNormal,
		[EnemyInfoEnum.TabEnum.WeekWalk] = self.refreshWeekWalk,
		[EnemyInfoEnum.TabEnum.WeekWalk_2] = self.refreshWeekWalk_2,
		[EnemyInfoEnum.TabEnum.Season123] = self.refreshSeason,
		[EnemyInfoEnum.TabEnum.BossRush] = self.refreshBossRush,
		[EnemyInfoEnum.TabEnum.Act191] = self.refreshNormal
	}
end

function EnemyInfoEnterView:onOpen()
	local enemyInfoMo = self.enemyInfoMo

	enemyInfoMo:setTabEnum(self.viewParam.tabEnum)
	self:initHandleDict()

	local handleFunc = self.tabEnum2HandleFunc[enemyInfoMo.tabEnum]

	handleFunc = handleFunc or self.refreshNormal

	handleFunc(self)
end

function EnemyInfoEnterView:refreshNormal()
	local enemyInfoMo = self.enemyInfoMo

	enemyInfoMo:setShowLeftTab(false)
	enemyInfoMo:updateBattleId(self.viewParam.battleId)
end

function EnemyInfoEnterView:refreshWeekWalk()
	self.tabView = self:createTabView(EnemyInfoWeekWalkTabView)

	self.tabView:onOpen()
end

function EnemyInfoEnterView:refreshWeekWalk_2()
	self.tabView = self:createTabView(EnemyInfoWeekWalk_2TabView)

	self.tabView:onOpen()
end

function EnemyInfoEnterView:refreshSeason()
	local enemyInfoMo = self.enemyInfoMo

	if self.viewParam.showLeftTab then
		enemyInfoMo:setShowLeftTab(true)

		self.tabView = self:createTabView(EnemyInfoSeason123TabView)

		self.tabView:onOpen()
	else
		enemyInfoMo:setShowLeftTab(false)
		enemyInfoMo:updateBattleId(self.viewParam.battleId)
	end
end

function EnemyInfoEnterView:refreshBossRush()
	local enemyInfoMo = self.enemyInfoMo

	enemyInfoMo:setShowLeftTab(false)

	local activityId = self.viewParam.activityId
	local stage = self.viewParam.stage
	local layer = self.viewParam.layer
	local co = lua_activity128_episode.configDict[activityId][stage][layer]
	local episodeCo = DungeonConfig.instance:getEpisodeCO(co.episodeId)

	enemyInfoMo:updateBattleId(episodeCo.battleId)
end

function EnemyInfoEnterView:createTabView(viewCls)
	local view = viewCls.New()

	view:__onInit()

	view.viewGO = self.viewGO
	view.viewContainer = self.viewContainer
	view.tabParentView = self
	view.viewName = self.viewName

	view:onInitView()
	view:addEvents()

	view.layoutMo = self.layoutMo
	view.enemyInfoMo = self.enemyInfoMo
	view.viewParam = self.viewParam

	return view
end

function EnemyInfoEnterView:onClose()
	if self.tabView then
		self.tabView:onClose()
	end
end

function EnemyInfoEnterView:onDestroyView()
	if self.tabView then
		self.tabView:removeEvents()
		self.tabView:onDestroyView()
		self.tabView:__onDispose()
	end

	self.simageRightBg:UnLoadImage()
end

return EnemyInfoEnterView
