-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinelongyan/view/DivinelongyanpowerstageView.lua

module("logic.extensions.divinelongyan.view.DivinelongyanpowerstageView", package.seeall)

local DivinelongyanpowerstageView = class("DivinelongyanpowerstageView", ViewComponent)

function DivinelongyanpowerstageView:ctor()
	DivinelongyanpowerstageView.super.ctor(self)
end

function DivinelongyanpowerstageView:unbindEvents()
	DivinelongyanpowerstageView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function DivinelongyanpowerstageView:bindEvents()
	DivinelongyanpowerstageView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
end

function DivinelongyanpowerstageView:buildUI()
	DivinelongyanpowerstageView.super.buildUI(self)

	self._fmtCellGo = self:getGo("fmtCell")
	self._fmtconGo = self:getGo("fmtcon")
	self._fmtCellItems = {}
	self._singleLine = self:getGo("fmtcon"):GetComponent(ComponentType.UILayoutSingleLine)
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "txtTime/txt")
	self._txtTip = self:getTxt("tipsCol/txt")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
end

function DivinelongyanpowerstageView:onExit()
	DivinelongyanpowerstageView.super.onExit(self)

	for k, mainGo in pairs(self._fmtCellItems) do
		local fmtView = goutil.findChild(mainGo, "fmt/fmtView")

		for posId = 1, fmtView.transform.childCount do
			local go = fmtView.transform:GetChild(posId - 1)
			local icon = goutil.findChild(go, "icon")

			MaterialMgr.resetAll(icon)
		end
	end
end

function DivinelongyanpowerstageView:onEnter()
	DivinelongyanpowerstageView.super.onEnter(self)

	self._activityId = DivinelongyanModel.instance:getActivityId()
	self._actCfg = DivinelongyanConfig.instance:getActCfg(self._activityId)

	self:_setActTime()
	self:_setRule()
	self:_initStageCfgs()
	self:_updateUI()
end

function DivinelongyanpowerstageView:_initStageCfgs()
	local stime = ActivityDefineController.instance:getStartTimeAndEndTime(DivinelongyanController.instance:getActivityType(), self._activityId)
	local day = math.ceil((ServerTime.now() - stime) / 86400)
	local maxDay = DivinelongyanConfig.instance:getPowerStageCfgMaxDay(self._activityId)
	local curDay = day % maxDay

	if curDay == 0 then
		curDay = maxDay
	end

	self._stageCfgs = DivinelongyanConfig.instance:getPowerStageCfgs(self._activityId, curDay)
end

function DivinelongyanpowerstageView:_updateUI()
	self._info = DivinelongyanModel.instance:getInfo(self._activityId)

	if not self._info then
		return
	end

	self._powerStageFinishIds = {}

	for i, v in ipairs(self._info.powerStageFinishIds or {}) do
		self._powerStageFinishIds[v] = true
	end

	goutil.setActive(self._fmtCellGo, false)

	for i, v in ipairs(self._stageCfgs) do
		self._fmtCellItems[i] = self._fmtCellItems[i] or goutil.cloneAndSetParent(self._fmtCellGo, self._fmtconGo.transform)

		local mainGo = self._fmtCellItems[i]

		goutil.setActive(mainGo, true)
		self:_updateFmtCell(mainGo, v)
	end

	self._singleLine:Layout()
end

function DivinelongyanpowerstageView:_updateFmtCell(mainGo, stageCfg)
	local isPass = self._powerStageFinishIds[stageCfg.stageId]
	local creepsMasterId = stageCfg.creepsMasterId
	local creepsCfgs = DivinelongyanConfig.instance:getCreepsCfgs(creepsMasterId)
	local fmt = goutil.findChild(mainGo, "fmt")
	local fmtView = goutil.findChild(mainGo, "fmt/fmtView")
	local btnClg = goutil.findChild(mainGo, "btnClg")
	local goPass = goutil.findChild(mainGo, "pass")
	local map = {}

	for _, cData in ipairs(creepsCfgs) do
		map[cData.posId] = cData
	end

	for posId = 1, fmtView.transform.childCount do
		local go = fmtView.transform:GetChild(posId - 1)
		local icon = goutil.findChild(go, "icon")
		local creepsData = map[posId]

		if creepsData then
			local petMo = FightingPowerPetMo.New()

			petMo:fromChallengeCreepCo(creepsData, creepsCfgs)

			local proxy = MaterialMgr.setCellByMo(petMo, icon)

			if proxy then
				proxy.binder:setClickCallBack(function()
					CommonTipsMgr.instance:showPetTips(petMo)
				end)
			end
		else
			MaterialMgr.resetAll(icon)
		end
	end

	goutil.setActive(goPass, isPass)
	goutil.setActive(btnClg.gameObject, not isPass)
	GameUtil.addClickHandler(btnClg, GameUtil.handler(self._onClickBtnClg, self, stageCfg))
end

function DivinelongyanpowerstageView:_onClickBtnClg(stageCfg)
	DivinelongyanController.instance:enterMission(self._activityId, GameEnum.DivineLongyanClgType.Power, stageCfg.creepsMasterId, stageCfg.stageId)
end

function DivinelongyanpowerstageView:_setActTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function DivinelongyanpowerstageView:_setRule()
	self._txtTip.text = self._actCfg.powerStageRuleDesc
end

function DivinelongyanpowerstageView:_onClickbtnClose()
	self:close()
end

function DivinelongyanpowerstageView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("divinelongyanpowerstageview_rule")
end

return DivinelongyanpowerstageView
