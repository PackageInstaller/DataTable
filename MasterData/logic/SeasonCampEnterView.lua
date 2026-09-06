-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonCampEnterView.lua

module("logic.extensions.season.view.SeasonCampEnterView", package.seeall)

local SeasonCampEnterView = class("SeasonCampEnterView", ViewComponent)

SeasonCampEnterView.bgEffect = "20221028/jinglingdian/fx_ui_jiesuo02_jinglingdian.prefab"

function SeasonCampEnterView:ctor()
	SeasonCampEnterView.super.ctor(self)
end

function SeasonCampEnterView:unbindEvents()
	SeasonCampEnterView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)

	for k, v in ipairs(self._btnBuilds) do
		v:RemoveClickListener()
	end
end

function SeasonCampEnterView:bindEvents()
	SeasonCampEnterView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickRule, self)

	for k, v in ipairs(self._btnBuilds) do
		v:AddClickListener(function()
			self:_onClickJumpTo(k)
		end)
	end
end

function SeasonCampEnterView:buildUI()
	SeasonCampEnterView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._txtTitle = self:getTxt("txtTitle")
	self._goldBarCon = self:getGo("goldBarCon")
	self._btnBuilds = {}
	self._redpointList = {}

	for i = 1, 4 do
		self._btnBuilds[i] = self:getBtn(string.format("btn_%d", i))

		local redpoint = self:getGo("btn_" .. i .. "/redpoint")

		GameUtil.SetActive(redpoint, false)
		table.insert(self._redpointList, redpoint)
	end

	self._bg = self:getGo("bg")
end

function SeasonCampEnterView:onExit()
	SeasonCampEnterView.super.onExit(self)
	self:_removeCellEff(self._bg)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonFmtTeamInfo, self.onRefreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonTotemInfoUpdated, self.onRefreshUI, self)
end

function SeasonCampEnterView:onEnter()
	SeasonCampEnterView.super.onEnter(self)

	self._userId = SeasonModel.instance:getTeammateId()

	self:_refreshView()
	self:_openGoldBarCon()
	self:_playCellEff(self._bg, true, SeasonCampEnterView.bgEffect)
	GlobalDispatcher:addListener(GlobalNotify.SeasonFmtTeamInfo, self.onRefreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonTotemInfoUpdated, self.onRefreshUI, self)

	if checknumber(self._userId) > 0 then
		SeasonMainCampController.instance:sendGetTotemInfo(self._userId)
	end

	SeasonController.instance:sendGetAllTeamInfo()
	GameUtil.SetActive(self._btnTip, true)

	self._txtTitle.text = lang("营地")
end

function SeasonCampEnterView:onRefreshUI()
	local campLv = SeasonMainCampModel.instance:getCampLv()
	local isLockMap = {}

	for i, v in ipairs(self._btnBuilds) do
		local unlockLv, jumpto = SeasonMainCampController.instance:getEntranceLockConfig(i)

		isLockMap[i] = unlockLv > campLv
	end

	local trainRed = SeasonMainCampController.instance:checkTrainMainRed()

	GameUtil.SetActive(self._redpointList[1], trainRed and not isLockMap[1])

	local mainCampRed = SeasonMainCampController.instance:checkMainCampRed()

	GameUtil.SetActive(self._redpointList[4], mainCampRed and not isLockMap[4])

	local totemRed = SeasonMainCampController.instance:checkTotemMainRed()

	GameUtil.SetActive(self._redpointList[2], totemRed and not isLockMap[2])
end

function SeasonCampEnterView:_playCellEff(go, loop, path)
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

function SeasonCampEnterView:_removeCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	if self._effs[go] then
		UIEffectManager.instance:stopEffect(self._effs[go])

		self._effs[go] = nil
	end
end

function SeasonCampEnterView:_onClickRule()
	TipsFacade.instance:openRulesView("SeasonCampEnterView")
end

function SeasonCampEnterView:_onClickJumpTo(buildId)
	local unlockLv, jumpTo = SeasonMainCampController.instance:getEntranceLockConfig(buildId)
	local campLv = SeasonMainCampModel.instance:getCampLv()

	if unlockLv <= campLv then
		if not string.nilorempty(jumpTo) then
			GotoMgr.gotoByString(jumpTo)
		end
	else
		TipsFacade.instance:openCommonTips(langPara("主营地%d级解锁", unlockLv))
	end
end

function SeasonCampEnterView:_openGoldBarCon()
	local seasonId = SeasonModel.instance:getSeasonId()
	local config = SeasonMainCampConfig.instance:getMainCampConfig(seasonId)
	local barList = string.split(config.barList or "", "#")
	local btnList = {}

	for i, v in ipairs(barList) do
		table.insert(btnList, {
			showAdd = false,
			id = v
		})
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btnList)
end

function SeasonCampEnterView:_refreshView()
	local campLv = SeasonMainCampModel.instance:getCampLv()

	for i, v in ipairs(self._btnBuilds) do
		local unlockLv, jumpto = SeasonMainCampController.instance:getEntranceLockConfig(i)
		local lockGo = goutil.findChild(v, "lock")

		if unlockLv <= campLv then
			goutil.setActive(lockGo, false)
		else
			goutil.setActive(lockGo, true)
		end
	end
end

return SeasonCampEnterView
