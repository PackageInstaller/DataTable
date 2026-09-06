-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/mainhud/SeasonMainView.lua

module("logic.extensions.season.view.SeasonMainView", package.seeall)

local SeasonMainView = class("SeasonMainView", ViewComponent)

SeasonMainView.GAIN_SHARE_PRIZE_EFFECT_PATH = "fx_ui_tequan/fx_ui_tequan_kuang.prefab"
SeasonMainView.GAIN_SHARE_PRIZE_EFFECT_PATH_2 = "fx_ui_yongzhezhita/fx_ui_yongzhezhita_xuanzhuan.prefab"

function SeasonMainView:ctor()
	SeasonMainView.super.ctor(self)
end

function SeasonMainView:buildUI()
	SeasonMainView.super.buildUI(self)

	self._closeButton = self:getBtn("lefttop/btn_back")
	self._btnMiniMap = self:getBtn("righttop/btnMiniMap")
	self._btnTeamEdit = self:getBtn("teamNode/teamsView/View/btnTeamEdit")
	self._btnTeamEditRed = self:getGo("teamNode/teamsView/View/btnTeamEdit/redpoint")
	self._btnSearch = self:getBtn("righttop/btnSearch")
	self._btnInfo = self:getBtn("righttop/btnInfo")
	self._btnBadge = self:getBtn("rightbottom/btnBadge")
	self._btnCamp = self:getBtn("rightbottom/btnCamp")
	self._btnPassport = self:getBtn("rightbottom/btnPassport")
	self._btnRank = self:getBtn("rightbottom/btnRank")
	self._btnPaint = self:getBtn("rightbottom/btnPaint")
	self._gridOpContainer = self:getGo("gridOpContainer")
	self._btnPassportRP = self:getGo("rightbottom/btnPassport/redpoint")
	self._campRedpoint = self:getGo("rightbottom/btnCamp/redpoint")
	self._btnTeammateInfo = self:getGo("btnTeammateInfo")
	self._btnChat = self:getGo("Nego_Chat")
	self._btnSharePrize = self:getGo("btnSharePrize")
	self._btnSharePrize_effParent = self:getGo("btnSharePrize/effParent")
end

function SeasonMainView:bindEvents()
	SeasonMainView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnMiniMap:AddClickListener(self._onClickMiniMap, self)
	self._btnTeamEdit:AddClickListener(self._onClickTeamEdit, self)
	self._btnSearch:AddClickListener(self._onClickSearch, self)
	self._btnInfo:AddClickListener(self._onClickInfo, self)
	self._btnBadge:AddClickListener(self._onClickBadge, self)
	self._btnCamp:AddClickListener(self._onClickCamp, self)
	self._btnPassport:AddClickListener(self._onClickPassport, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
	self._btnPaint:AddClickListener(self._onClickPaint, self)
	GameUtil.addClickHandler(self._btnChat, self._onClickChat, self)
	GameUtil.addClickHandler(self._btnTeammateInfo, self._onClickTeammateInfo, self)
	GameUtil.addClickHandler(self._btnSharePrize, self._onClickSharePrize, self)
end

function SeasonMainView:unbindEvents()
	SeasonMainView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnMiniMap:RemoveClickListener()
	self._btnTeamEdit:RemoveClickListener()
	self._btnSearch:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnBadge:RemoveClickListener()
	self._btnCamp:RemoveClickListener()
	self._btnPassport:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnPaint:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnChat)
	GameUtil.rmClickHandler(self._btnTeammateInfo)
	GameUtil.rmClickHandler(self._btnSharePrize)
end

function SeasonMainView:destroyUI()
	SeasonMainView.super.destroyUI(self)
end

function SeasonMainView:onEnter()
	SeasonMainView.super.onEnter(self)

	self._userId = RoleModel.instance:getUserId()

	GlobalDispatcher:addListener(GlobalNotify.RedPointUpdate, self._redPointUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewOpen, self._checkOccupiedAnim, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewClose, self._checkOccupiedAnim, self)
	GlobalDispatcher:addListener(GlobalNotify.ApplySeasonPlayOccupiedEffect, self._checkOccupiedAnim, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonFmtTeamInfo, self._campRedPointUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonTotemInfoUpdated, self._campRedPointUpdate, self)
	self.addGEvent(self, GlobalNotify.SeasonServerAddTeam, self._refreshSharePrize, self)
	self.addGEvent(self, GlobalNotify.handlePM_SMGVETeammateTeamInfoRes, self._refreshSharePrize, self)
	self.addGEvent(self, GlobalNotify.handlePM_SMGVEGainTeammateSharePrizeRes, self._refreshSharePrize, self)
	SeasonController.instance:sendGetAllTeamInfo()
	SeasonMainCampController.instance:sendGetTotemInfo(self._userId)
	GameUtil.SetActive(self._btnPassportRP, false)
	GameUtil.SetActive(self._btnTeammateInfo, SeasonModel.instance:getGroupState() == SeasonModel.GVE_GROUP_STATE_GVE)
	GameUtil.SetActive(self._btnSharePrize, SeasonModel.instance:getGroupState() == SeasonModel.GVE_GROUP_STATE_GVE)
	self:_redPointUpdate()
	RedPointController.instance:regRedPoint(self._btnTeamEditRed, 385, 386, 387)
	SeasonController.instance:setOpViewContainer(self._gridOpContainer, self._viewPresentor)
	self:_refreshSharePrize()

	if SeasonModel.instance:getGroupState() == SeasonModel.GVE_GROUP_STATE_GVE then
		SeasonModePvePlusAgent.instance:sendPM_SMGVETeammateTeamInfoReq()
	end
end

function SeasonMainView:onEnterFinished()
	SeasonMainView.super.onEnterFinished(self)
	removetimer(self._realDoCheckOccupiedAnim, self)
	settimer(0.5, self._realDoCheckOccupiedAnim, self, false)
end

function SeasonMainView:onExit()
	SeasonMainView.super.onExit(self)
	removetimer(self._realDoCheckOccupiedAnim, self)
	GlobalDispatcher:removeListener(GlobalNotify.RedPointUpdate, self._redPointUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnViewOpen, self._checkOccupiedAnim, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnViewClose, self._checkOccupiedAnim, self)
	GlobalDispatcher:removeListener(GlobalNotify.ApplySeasonPlayOccupiedEffect, self._checkOccupiedAnim, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonFmtTeamInfo, self._campRedPointUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonTotemInfoUpdated, self._campRedPointUpdate, self)
	RedPointController.instance:unregRedPoint(self._btnTeamEditRed)
	SeasonController.instance:setOpViewContainer(nil, nil)
end

function SeasonMainView:onExitFinished()
	SeasonMainView.super.onExitFinished(self)
end

function SeasonMainView:_redPointUpdate()
	local passportRP = RedPointModel.instance:isActive("c11") or RedPointModel.instance:isActive(379)

	goutil.setActive(self._btnPassportRP, passportRP)
end

function SeasonMainView:_campRedPointUpdate()
	local mainCampRp = SeasonMainCampController.instance:checkMainCampRed()
	local totemRp = SeasonMainCampController.instance:checkTotemMainRed()
	local trainRed = SeasonMainCampController.instance:checkTrainMainRed()

	GameUtil.SetActive(self._campRedpoint, mainCampRp or totemRp or trainRed)
end

function SeasonMainView:_checkOccupiedAnim(view)
	if view and ViewMgr.instance:isNotifyView(view.viewName) then
		return
	end

	removetimer(self._realDoCheckOccupiedAnim, self)
	settimer(0.1, self._realDoCheckOccupiedAnim, self, false)
end

function SeasonMainView:_realDoCheckOccupiedAnim()
	local topView = GlobalModel.instance:getTopView()

	if not topView or not topView:attachToWhichRoot() then
		return
	end

	if topView.viewName == UIStateManager.instance:getRoot() then
		local scene = SceneMgr.instance:getCurScene()

		if scene and scene.gridUnitsMgr and scene.gridUnitsMgr.tryPlayOccupiedEffect then
			scene.gridUnitsMgr:tryPlayOccupiedEffect()
		end
	end
end

function SeasonMainView:_refreshSharePrize()
	if self._prizeEffect then
		UIEffectManager.instance:stopEffect(self._prizeEffect)

		self._prizeEffect = nil
	end

	if not string.nilorempty(SeasonModel.instance:getShareMaterialPackage()) then
		local effParent = self._btnSharePrize_effParent
		local path = SeasonMainView.GAIN_SHARE_PRIZE_EFFECT_PATH_2

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setClipping(effParent:GetComponent(goutil.Type_RectTransform))
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._prizeEffect = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function SeasonMainView:_onClickClose()
	UIJumper.instance:pushOneStack(ViewName.SeasonenterView, true)
	SeasonController.instance:leaveSeasonTilingScene()
end

function SeasonMainView:_onClickMiniMap()
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.eventsAnimation and scene.eventsAnimation:isPlaying() then
		return
	end

	local scene = SceneMgr.instance:getCurScene()

	scene.gridUnitsMgr:aimGrid(false)
	scene.gridUnitsMgr:showLevel(false)
	scene.gridUnitsMgr:clearLastSelect()
	UIStateManager.instance:push(ViewName.SeasonMiniMapView)
end

function SeasonMainView:_onClickTeamEdit()
	local selectTeamId = SeasonTeamsModel.instance:getCurrTeamId()

	SeasonFmtController.instance:showFormationView(selectTeamId)
end

function SeasonMainView:_onClickSearch()
	UIStateManager.instance:push(ViewName.SeasonPlotSearchView)
end

function SeasonMainView:_onClickInfo()
	local scene = SceneMgr.instance:getCurScene()
	local isShowLevelGrid = scene.gridUnitsMgr:isShowLevelGrid()

	scene.gridUnitsMgr:showLevel(not checkbool(isShowLevelGrid))
end

function SeasonMainView:_onClickBadge()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.Season_5)
	UIStateManager.instance:push(ViewName.SeasonBadgeView)
end

function SeasonMainView:_onClickCamp()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.Season_1)
	UIStateManager.instance:push(ViewName.SeasonCampEnterView)
end

function SeasonMainView:_onClickPassport()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.Season_4)
	UIStateManager.instance:push(ViewName.SeasonPassPortTabView)
end

function SeasonMainView:_onClickRank()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.Season_3)

	local seasonId = SeasonModel.instance:getSeasonId()

	UIStateManager.instance:push(ViewName.SeasonRankMainView, seasonId)
end

function SeasonMainView:_onClickPaint()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.Season_2)

	local seasonId = SeasonModel.instance:getSeasonId()

	UIStateManager.instance:push(ViewName.SeasonPaintView, seasonId)
end

function SeasonMainView:_onClickChat()
	ViewMgr.instance:open(ViewName.SeasonChatListView, GameEnum.ChatChannel.Nearby)
end

function SeasonMainView:_onClickTeammateInfo()
	UIStateManager.instance:push(ViewName.SeasonTeamCampEnterView, seasonId)
end

function SeasonMainView:_onClickSharePrize()
	local prizeStr = SeasonModel.instance:getShareMaterialPackage()

	if string.nilorempty(prizeStr) then
		FloatWordMgr.instance:show(lang("暂无奖励可领取"))
	else
		SeasonModePvePlusAgent.instance:sendPM_SMGVEGainTeammateSharePrizeReq()
	end
end

return SeasonMainView
