-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightrui/view/SaintKnightRuiChallengeView.lua

module("logic.extensions.saintknightrui.view.SaintKnightRuiChallengeView", package.seeall)

local SaintKnightRuiChallengeView = class("SaintKnightRuiChallengeView", ViewComponent)

function SaintKnightRuiChallengeView:ctor()
	SaintKnightRuiChallengeView.super.ctor(self)
end

function SaintKnightRuiChallengeView:buildUI()
	SaintKnightRuiChallengeView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnPowerUp = self:getBtn("btnPower")
	self._redPoint = self:getGo("btnPower/redPoint")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._txtName = self:getTxt("petInfo/txtName")
	self._rare = self:getGo("petInfo/rare")
	self._roleGo = self:getGo("role")
	self._txtTimes = self:getTxt("btnChanllge/txtTimes")
	self._btns = {}

	for i = 1, 4 do
		self._btns[i] = self:getBtn(string.format("chapter%d", i))
	end

	self._tablecellGo = self:getGo("rewarditem")
	self._tableviewGo1 = self:getGo("chapter1/rewardView")
	self._tableviewGo2 = self:getGo("chapter2/rewardView")
	self._tableviewGo3 = self:getGo("chapter3/rewardView")
	self._tableviewGo4 = self:getGo("chapter4/rewardView")
	self._scrollerList1 = ScrollerList.create(self._tableviewGo1, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._scrollerList2 = ScrollerList.create(self._tableviewGo2, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._scrollerList3 = ScrollerList.create(self._tableviewGo3, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._scrollerList4 = ScrollerList.create(self._tableviewGo4, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function SaintKnightRuiChallengeView:bindEvents()
	SaintKnightRuiChallengeView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
	self._btnInfo:AddClickListener(self._onClickInfo, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnPowerUp:AddClickListener(self._onClickPowerUp, self)

	for i, v in ipairs(self._btns) do
		v:AddClickListener(function()
			self:_onClickBtnChapter(i)
		end)
	end
end

function SaintKnightRuiChallengeView:unbindEvents()
	SaintKnightRuiChallengeView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnPowerUp:RemoveClickListener()

	for i, v in ipairs(self._btns) do
		v:RemoveClickListener()
	end
end

function SaintKnightRuiChallengeView:onEnter()
	SaintKnightRuiChallengeView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.SaintKnightRuiGetInfo, self._onGetInfoRes, self)

	self._activityId = SaintKnightRuiModel.instance:getActivityId()
	self._challengePlanId = SaintKnightRuiModel.instance:getChallengePlanId()
	self._cfgActivity = SaintKnightRuiConfig.instance:getActivityCfg(self._activityId)
	self._raceId = self._cfgActivity.skinId

	RedPointController.instance:regRedPoint(self._redPoint, RedPointModel.ID_SAINTKNIGHT_RUI_GAME, RedPointModel.ID_DarkDragonKnife)
	SaintKnightRuiController.instance:playStoryInChallengeView(self._cfgActivity.storyId1)
	self:_setPetInfo()
	self:_initRewards()
	self:_sendRequest()
end

function SaintKnightRuiChallengeView:onExit()
	SaintKnightRuiChallengeView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SaintKnightRuiGetInfo, self._onGetInfoRes, self)
	RedPointController.instance:unregRedPoint(self._redPoint)
end

function SaintKnightRuiChallengeView:_onClickSkill()
	UIJumper.instance:pushOneStack(ViewName.SaintKnightRuiMainView, true)
	UIJumper.instance:pushOneStack(self._viewPresentor.viewName, true)
	BattleFacade.instance:sendPreviewPetBattle(self._raceId, self._raceId)
end

function SaintKnightRuiChallengeView:_onClickInfo()
	PetbookController.instance:openPetinfoView(self._raceId)
end

function SaintKnightRuiChallengeView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "saintknightruirule")
end

function SaintKnightRuiChallengeView:_onClickPowerUp()
	RedPointController.instance:saveUserDayRedPoint(RedPointModel.ID_SAINTKNIGHT_RUI_GAME)
	SaintKnightRuiController.instance:playStoryInGameView(self._cfgActivity.storyId2)
	FuncOpenController.instance:openFunc(FuncConst.DarkDragonGame)
end

function SaintKnightRuiChallengeView:_onClickBtnChapter(stageId)
	UIStateManager.instance:push(ViewName.SaintKnightRuiLevelView, stageId)
end

function SaintKnightRuiChallengeView:_onGetInfoRes()
	self:_updateView()
end

function SaintKnightRuiChallengeView:_sendRequest()
	SaintKnightRuiAgent.instance:sendPM_SaintKnightRuiGetInfoReq(self._activityId)
end

function SaintKnightRuiChallengeView:_setPetInfo()
	self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, self._raceId)

	MaterialMgr.setCell(MatType.Rare, self._raceId, self._rare)
end

function SaintKnightRuiChallengeView:_showRoleModel()
	local curFaceId = self._raceId
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._roleGo, scale, nil, true, x, y)
end

function SaintKnightRuiChallengeView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function SaintKnightRuiChallengeView:_updateView()
	local curCount = SaintKnightRuiModel.instance:getPlayCount()
	local maxCount = self._cfgActivity.challengeDailyTimes
	local isEmpty = maxCount <= curCount

	self._txtTimes.text = isEmpty and string.format("<color=#%s>%d</color>/%d", ColorConst.Red, 0, maxCount) or string.format("%d/%d", maxCount - curCount, maxCount)
end

function SaintKnightRuiChallengeView:_updateCell(view, cell, data, tag)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function SaintKnightRuiChallengeView:_clearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function SaintKnightRuiChallengeView:_initRewards()
	local prizeList1 = self:_getPrizeList(1)
	local prizeList2 = self:_getPrizeList(2)
	local prizeList3 = self:_getPrizeList(3)
	local prizeList4 = self:_getPrizeList(4)

	self._scrollerList1:reloadData(prizeList1)
	self._scrollerList2:reloadData(prizeList2)
	self._scrollerList3:reloadData(prizeList3)
	self._scrollerList4:reloadData(prizeList4)
end

function SaintKnightRuiChallengeView:_getPrizeList(stageId)
	local cfg = SaintKnightRuiConfig.instance:getStateInfoCfg(self._challengePlanId, stageId)

	if cfg then
		return MaterialMgr.changeItemStrArr(cfg.prize)
	else
		return {}
	end
end

return SaintKnightRuiChallengeView
