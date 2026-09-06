-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhood/view/XiuNuoBrotherhoodMainView.lua

module("logic.extensions.xiunuobrotherhood.view.XiuNuoBrotherhoodMainView", package.seeall)

local XiuNuoBrotherhoodMainView = class("XiuNuoBrotherhoodMainView", ViewComponent)

function XiuNuoBrotherhoodMainView:ctor()
	self._selectViewName = ViewName.XiuNuoBrotherhoodSelectView
end

function XiuNuoBrotherhoodMainView:buildUI()
	XiuNuoBrotherhoodMainView.super.buildUI(self)

	self._btnClose = GameUtil.asBtn(self:getGo("btnClose"))
	self._btnRule = self:getBtn("btnRule")
	self._btnStart = GameUtil.asBtn(self:getGo("btnStart"))
	self._goldBarCon = self:getGo("goldBar")
	self._time = self:getTxt("time/txt")
	self._con = self:getGo("con")
	self._petInfo = self:getBtn("petInfo/btnIntroduce")
	self._petTry = self:getBtn("petInfo/btnSkill")
	self._petRace = self:getGo("petInfo/pointRare")
	self._btnRank = self:getBtn("btnRank")
	self._rankGo = self:getGo("rankItem/item")
	self._tipRank = self:getGo("rankItem")
	self._btnTry = self:getBtn("btnTry")
	self._tryIcon = self:getGo("btnTry/icon")
	self._tryGo = self:getGo("tryItem/item")
	self._tipTry = self:getGo("tryItem")
	self._btnCard = self:getBtn("btnCard")
	self._introText = self:getTxt("txtIntro/txtDesc")
	self._redPointGo = self:getGo("btnStart/redpoint")
	self._txtName = self:getTxt("petInfo/txtName")
end

function XiuNuoBrotherhoodMainView:bindEvents()
	XiuNuoBrotherhoodMainView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._petInfo, self._onClickPetInfo, self)
	GameUtil.addClickHandler(self._petTry, self._onClickPetTry, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnTry, self._onClickTry, self)
	GameUtil.addClickHandler(self._btnCard, self._onClickCard, self)
end

function XiuNuoBrotherhoodMainView:unbindEvents()
	XiuNuoBrotherhoodMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._petInfo)
	GameUtil.rmClickHandler(self._petTry)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnTry)
	GameUtil.rmClickHandler(self._btnCard)
end

function XiuNuoBrotherhoodMainView:onEnter()
	self:initData()

	if not self._activityId then
		FloatWordMgr.instance:show("未在活动时间内")
		self:close()

		return
	end

	self:initView()
	self:_setJumpViewNames()
end

function XiuNuoBrotherhoodMainView:initData()
	self._activityId = XiuNuoBrotherhoodModel.instance:getCurrActId(1)
end

function XiuNuoBrotherhoodMainView:initView()
	self._cfg = XiuNuoBrotherhoodConfig.instance:getActivityCfg(self._activityId)

	XiuNuoBrotherhoodModel.instance:setStageOpen(self._activityId)

	self._introText.text = self._cfg.raceIntro

	MaterialMgr.resetAll(self._petRace)
	MaterialMgr.setCell(MatType.Rare, self._cfg.raceId, self._petRace)

	if self._txtName then
		self._txtName.text = PetSkinConfig.instance:getPetSkinName(self._cfg.raceId)
	end

	GameUtil.SetActive(self._redPointGo, not XiuNuoBrotherhoodModel.instance:getDailyGameStart())
	self:_setTopGoldBar()

	if not goutil.isNil(self._con) then
		RoleObjectPool.instance:addRoleToParent(self._raceCon, self._cfg.raceId, self._con)
	end

	local timeCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.XiuNuoBrotherhood, self._activityId)
	local startTime = GameUtil.string2date(timeCfg.startTime)
	local endTime = GameUtil.string2date(timeCfg.endTime)

	if self._time ~= nil then
		self._time.text = TimeGateController.instance:getActTimeShow(self._activityId)
	end

	MaterialMgr.setIcon(self._tryIcon, MatType.Pet, self._cfg.raceId)

	local collegeId = PetCollegeConfig.instance:raceId2ChallengeId(checknumber(self._cfg.raceId))

	if checknumber(collegeId) > 0 then
		local stageCfgs = PetCollegeConfig.instance:getStageCfg(collegeId)
		local passedStageId = PetCollegeModel.instance:getCurrPassStageId(collegeId)
		local prizeDic = {}

		for k, v in ipairs(stageCfgs) do
			if passedStageId < k then
				local matType, matId, matNum = unpack(string.splitToNumber(v.firstPassPrize, ":"))
				local key = matType .. ":" .. matId

				prizeDic[key] = checknumber(prizeDic[key]) + matNum
			end
		end

		local matStr = ""

		for k, v in pairs(prizeDic) do
			matStr = k .. ":" .. v
		end

		MaterialMgr.setCellByCfg(matStr, self._tryGo)
		GameUtil.SetActive(self._tipTry, not string.nilorempty(matStr))
	else
		GameUtil.SetActive(self._tipTry, false)
	end

	GameUtil.SetActive(self._tipRank, false)
end

function XiuNuoBrotherhoodMainView:onExit()
	MaterialMgr.resetAll(self._tryGo)
	MaterialMgr.resetAll(self._rankGo)
	MaterialMgr.resetAll(self._tryIcon)
	MaterialMgr.resetAll(self._petRace)

	if self._raceCon then
		RoleObjectPool.instance:removeRole(self._raceCon)
	end
end

function XiuNuoBrotherhoodMainView:_onClickClose()
	self:close()
end

function XiuNuoBrotherhoodMainView:_onClickStart()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.XiuNuoBrotherhood)
	UIStateManager.instance:push(self._selectViewName, self._activityId)
end

function XiuNuoBrotherhoodMainView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, self._cfg.ruleKey)
end

function XiuNuoBrotherhoodMainView:_onClickPetInfo()
	PetbookController.instance:openPetinfoView(self._cfg.raceId)
end

function XiuNuoBrotherhoodMainView:_onClickPetTry()
	PetbookController.instance:previewBattle(self._cfg.raceId)
end

function XiuNuoBrotherhoodMainView:_onClickTry()
	GotoMgr.gotoByString("func#149#" .. self._cfg.raceId)
end

function XiuNuoBrotherhoodMainView:_onClickRank()
	GotoMgr.gotoByString("func#608#1#" .. self._cfg.raceId)
end

function XiuNuoBrotherhoodMainView:_onClickCard()
	GotoMgr.gotoByString(self._cfg.funcId)
end

function XiuNuoBrotherhoodMainView:_setTopGoldBar()
	local btn_list = {}

	for i, v in ipairs(self._cfg.showBar) do
		table.insert(btn_list, {
			showAdd = false,
			id = v
		})
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

function XiuNuoBrotherhoodMainView:_setJumpViewNames()
	XiuNuoBrotherhoodModel.instance.instance:setJumpViewNames(ViewName.XiuNuoBrotherhoodMainView, ViewName.XiuNuoBrotherhoodSelectView, ViewName.XiuNuoBrotherhoodGameView)
end

return XiuNuoBrotherhoodMainView
