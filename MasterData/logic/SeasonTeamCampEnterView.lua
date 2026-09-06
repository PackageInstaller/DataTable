-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/teamcampshow/SeasonTeamCampEnterView.lua

module("logic.extensions.season.view.teamcampshow.SeasonTeamCampEnterView", package.seeall)

local SeasonTeamCampEnterView = class("SeasonTeamCampEnterView", ViewComponent)

SeasonTeamCampEnterView.bgEffect = "20221028/jinglingdian/fx_ui_jiesuo02_jinglingdian.prefab"
SeasonTeamCampEnterView.buildViewName = {
	ViewName.SeasonTeamTrainingCourseView,
	ViewName.SeasonTotemPoleOtherView,
	ViewName.SeasonTeamElvenHallView,
	ViewName.SeasonMainCampOtherView
}

function SeasonTeamCampEnterView:ctor()
	SeasonTeamCampEnterView.super.ctor(self)
end

function SeasonTeamCampEnterView:unbindEvents()
	SeasonTeamCampEnterView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)

	for k, v in ipairs(self._btnBuilds) do
		v:RemoveClickListener()
	end
end

function SeasonTeamCampEnterView:bindEvents()
	SeasonTeamCampEnterView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickRule, self)

	for k, v in ipairs(self._btnBuilds) do
		v:AddClickListener(function()
			self:_onClickJumpTo(k)
		end)
	end
end

function SeasonTeamCampEnterView:buildUI()
	SeasonTeamCampEnterView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._txtTitle = self:getTxt("friendName/txtName")
	self._goldBarCon = self:getGo("goldBarCon")
	self._btnBuilds = {}

	for i = 1, 4 do
		self._btnBuilds[i] = self:getBtn(string.format("btn_%d", i))
	end

	self._bg = self:getGo("bg")
end

function SeasonTeamCampEnterView:onExit()
	SeasonTeamCampEnterView.super.onExit(self)
	self:_removeCellEff(self._bg)
end

function SeasonTeamCampEnterView:onEnter()
	SeasonTeamCampEnterView.super.onEnter(self)

	self._teammateId = SeasonModel.instance:getTeammateId()

	self:_refreshView()
	self:_openGoldBarCon()
	self:_playCellEff(self._bg, true, SeasonTeamCampEnterView.bgEffect)

	if self._teammateId <= 0 then
		self:close()
	end

	SeasonMainCampController.instance:sendGetSeasonMainCampInfo(self._teammateId)

	local friendMo = FriendModel.instance:getFriendMo(self._teammateId)

	self._txtTitle.text = friendMo and langPara("%s的营地", friendMo._name) or lang("好友营地")

	GameUtil.SetActive(self._btnTip, false)
end

function SeasonTeamCampEnterView:_playCellEff(go, loop, path)
	if not go then
		return
	end

	self._effs = self._effs or {}

	if loop then
		if self._effs[go] then
			return
		end
	else
		self:_removeCellEff(go)
	end

	local resPath = path

	local function loadCallBack()
		return
	end

	self._effs[go] = UIEffectManager.instance:playEffect(self, resPath, nil, nil, nil, true, nil, nil, loadCallBack)

	self._effs[go]:setParent(go.transform)
	self._effs[go]:setScaleXYZ(1, 0.6, 1)
	self._effs[go]:setLocalPos(0, 0, 0)
end

function SeasonTeamCampEnterView:_removeCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	if self._effs[go] then
		UIEffectManager.instance:stopEffect(self._effs[go])

		self._effs[go] = nil
	end
end

function SeasonTeamCampEnterView:_onClickRule()
	TipsFacade.instance:openRulesView("SeasonCampEnterView")
end

function SeasonTeamCampEnterView:_onClickJumpTo(buildId)
	UIStateManager.instance:push(SeasonTeamCampEnterView.buildViewName[buildId])
end

function SeasonTeamCampEnterView:_openGoldBarCon()
	local btnList = {}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btnList)
end

function SeasonTeamCampEnterView:_refreshView()
	for i, v in ipairs(self._btnBuilds) do
		local lockGo = goutil.findChild(v, "lock")

		goutil.setActive(lockGo, false)
	end
end

return SeasonTeamCampEnterView
