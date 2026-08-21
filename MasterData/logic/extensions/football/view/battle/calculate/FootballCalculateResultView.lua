-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/football/view/battle/calculate/FootballCalculateResultView.lua

module("logic.extensions.football.view.battle.calculate.FootballCalculateResultView", package.seeall)

local FootballCalculateResultView = class("FootballCalculateResultView", IBattleCustomCalculateView)

FootballCalculateResultView.Url_View = ResName.Pvp_result_root

function FootballCalculateResultView:build(mainGO)
	self._resLoader = PrefabLoader.Get(mainGO)

	self._resLoader:load(FootballCalculateResultView.Url_View, self._onLoaded, self)
end

function FootballCalculateResultView:destroy()
	self:onExit()

	if self.mainGO then
		self:unbindEvents()
		self:destroyUI()
	end

	self._resLoader:clear()

	self._resLoader = false
end

function FootballCalculateResultView:_onLoaded()
	self.mainGO = self._resLoader:getInst()

	self:buildUI()
	self:bindEvents()
	self:onEnter()
end

function FootballCalculateResultView:buildUI()
	self._leftPlayerItem = Astral.LuaComponentContainer.Add(goutil.findChild(self.mainGO, "player"), FootballCalculateResultItem)
	self._rightPlayerItem = Astral.LuaComponentContainer.Add(goutil.findChild(self.mainGO, "enemy"), FootballCalculateResultItem)
	self._txtScore = goutil.findChildTextComponent(self.mainGO, "txtScore")
	self._btnAgain = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "btnAgain"))
	self._btnReturn = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "btnReturn"))
end

function FootballCalculateResultView:destroyUI()
	self._leftPlayerItem:destroy()
	self._rightPlayerItem:destroy()

	self._leftPlayerItem = false
	self._rightPlayerItem = false
	self._btnAgain = false
	self._btnReturn = false
	self._txtScore = false
end

function FootballCalculateResultView:bindEvents()
	self._btnAgain:AddClickListener(self._onClickAgain, self)
	self._btnReturn:AddClickListener(self._onClickReturn, self)
end

function FootballCalculateResultView:unbindEvents()
	self._btnAgain:RemoveClickListener()
	self._btnReturn:RemoveClickListener()
end

function FootballCalculateResultView:onEnter()
	local battleModel = BattleMgr.instance:getModel()
	local settingModel = BattleMgr.instance:getSettingModel()
	local operateTeamId = battleModel:getOperateGameTeamId()
	local teamInfoMOList = settingModel:getTeamInfoMOList()

	for _, teamInfoMO in ipairs(teamInfoMOList) do
		if teamInfoMO.teamId == operateTeamId then
			self._leftPlayerItem:setUserInfoMO(teamInfoMO:getLeaderUserInfoMO())
		else
			self._rightPlayerItem:setUserInfoMO(teamInfoMO:getLeaderUserInfoMO())
		end
	end

	self._txtScore.text = string.format("<color=#F7931E>%s</color>:<color=#C1272D>%s</color>", FootballModel.instance:getTeamScore(self._leftPlayerItem:getTeamId()), FootballModel.instance:getTeamScore(self._rightPlayerItem:getTeamId()))
end

function FootballCalculateResultView:onExit()
	return
end

function FootballCalculateResultView:_onClickAgain()
	FootballModel.instance:setRestart(true)
	BattleCalculateViewFacade.instance:resetAllView()
	BattleDispatcher:dispatchEvent(BattleEventType.ON_CALCULATE_FINISH)
end

function FootballCalculateResultView:_onClickReturn()
	local isWin = BattleCalculateModel.instance:isWin()

	if isWin then
		BattleDispatcher:dispatchEvent(BattleEventType.ON_CALCULATE_SWITCH_NEXT_PAGE)
	else
		BattleCalculateViewFacade.instance:resetAllView()
		BattleDispatcher:dispatchEvent(BattleEventType.ON_CALCULATE_FINISH)
	end
end

return FootballCalculateResultView
