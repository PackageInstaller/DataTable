-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightrui/view/SaintKnightRuiMainView.lua

module("logic.extensions.saintknightrui.view.SaintKnightRuiMainView", package.seeall)

local SaintKnightRuiMainView = class("SaintKnightRuiMainView", ViewComponent)

function SaintKnightRuiMainView:ctor()
	SaintKnightRuiMainView.super.ctor(self)
end

function SaintKnightRuiMainView:buildUI()
	SaintKnightRuiMainView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._btnGo1 = self:getBtn("btn1")
	self._btnGo2 = self:getBtn("btn2")
	self._btnGo3 = self:getBtn("btn3")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._txtName = self:getTxt("petInfo/txtName")
	self._rare = self:getGo("petInfo/rare")
	self._txtTime = self:getTxt("nodeTxt/txtTime")
	self._goldBarCon = self:getGo("goldBarCon")
	self._itemGo = self:getGo("keyItem/item")
	self._iconCoin = self:getGo("btnChallenge/iconCoin")
	self._txtCoin = self:getTxt("btnChallenge/txtCoin")
	self._roleGo = self:getGo("role")
	self._redPoint = self:getGo("btnChallenge/redPoint")
end

function SaintKnightRuiMainView:bindEvents()
	SaintKnightRuiMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnChallenge:AddClickListener(self._onClickChallenge, self)
	self._btnGo1:AddClickListener(self._onClickGo1, self)
	self._btnGo2:AddClickListener(self._onClickGo2, self)
	self._btnGo3:AddClickListener(self._onClickGo3, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
	self._btnInfo:AddClickListener(self._onClickInfo, self)
end

function SaintKnightRuiMainView:unbindEvents()
	SaintKnightRuiMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
	self._btnGo1:RemoveClickListener()
	self._btnGo2:RemoveClickListener()
	self._btnGo3:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
end

function SaintKnightRuiMainView:onEnter()
	SaintKnightRuiMainView.super.onEnter(self)

	self._activityId = SaintKnightRuiModel.instance:getActivityId()
	self._cfgActivity = SaintKnightRuiConfig.instance:getActivityCfg(self._activityId)
	self._raceId = self._cfgActivity.skinId

	RedPointController.instance:regRedPoint(self._redPoint, RedPointModel.ID_SAINTKNIGHT_RUI_GAME, RedPointModel.ID_DarkDragonKnife)
	SaintKnightRuiController.instance:playAnim(self._cfgActivity.animPath)

	self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, self._raceId)

	MaterialMgr.setCell(MatType.Rare, self._raceId, self._rare)
	self:_setTime()
	self:_setGoldBarCon()
	self:_setItem()
	self:_showRoleModel()
end

function SaintKnightRuiMainView:onExit()
	SaintKnightRuiMainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redPoint)
	MaterialMgr.resetAll(self._rare)
	MaterialMgr.resetAll(self._itemGo)
	MaterialMgr.clearIcon(self._iconCoin)
	self:_resetRoleModel()
end

function SaintKnightRuiMainView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "saintknightruirule")
end

function SaintKnightRuiMainView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.SaintKnightRuiChallengeView)
end

function SaintKnightRuiMainView:_onClickGo1()
	GotoMgr.gotoByString(self._cfgActivity.getTo)
	SurveyController.instance:reportBehavior(SurveyBehaviorID.SAINTKNIGHTRUI_2)
end

function SaintKnightRuiMainView:_onClickGo2()
	GotoMgr.gotoByString(self._cfgActivity.puyTo)
end

function SaintKnightRuiMainView:_onClickGo3()
	GotoMgr.gotoByString(self._cfgActivity.rankTo)
	SurveyController.instance:reportBehavior(SurveyBehaviorID.SAINTKNIGHTRUI_1)
end

function SaintKnightRuiMainView:_onClickSkill()
	UIJumper.instance:pushOneStack(self._viewPresentor.viewName, true)
	BattleFacade.instance:sendPreviewPetBattle(self._raceId, self._raceId)
end

function SaintKnightRuiMainView:_onClickInfo()
	PetbookController.instance:openPetinfoView(self._raceId)
end

function SaintKnightRuiMainView:_setTime()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.SaintKnightRui, self._activityId)
	local startDate = GameUtil.time2date(startTime)
	local endDate = GameUtil.time2date(endTime)

	self._txtTime.text = string.format("活动时间：%02d.%02d-%02d.%02d", startDate.month, startDate.day, endDate.month, endDate.day)
end

function SaintKnightRuiMainView:_setGoldBarCon()
	local matMo = string.splitToNumber(self._cfgActivity.prize, ":")
	local name = matMo[1] .. ":" .. matMo[2]
	local objList = {
		{
			showAdd = false,
			id = name
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
end

function SaintKnightRuiMainView:_setItem()
	MaterialMgr.setCellByCfg(self._cfgActivity.res, self._itemGo)

	local matType, id = MaterialMgr.getMatParams(self._cfgActivity.prize)

	MaterialMgr.setIcon(self._iconCoin, matType, id)

	self._txtCoin.text = MaterialModel.instance:getMaterialsNumber(matType, id)
end

function SaintKnightRuiMainView:_showRoleModel()
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

function SaintKnightRuiMainView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

return SaintKnightRuiMainView
