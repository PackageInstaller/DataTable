-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originmimengli/view/OriginMiMengLiStageView.lua

module("logic.extensions.originmimengli.view.OriginMiMengLiStageView", package.seeall)

local OriginMiMengLiStageView = class("OriginMiMengLiStageView", ViewComponent)

function OriginMiMengLiStageView:ctor()
	OriginMiMengLiStageView.super.ctor(self)
end

function OriginMiMengLiStageView:unbindEvents()
	OriginMiMengLiStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function OriginMiMengLiStageView:bindEvents()
	OriginMiMengLiStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function OriginMiMengLiStageView:buildUI()
	OriginMiMengLiStageView.super.buildUI(self)

	self._powerPetMo = FightingPowerPetMo.New()
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")

	local goCellStage = self:getGo("stage/cell")
	local goTabStage = self:getGo("stage/tableview")

	self._tableviewStage = ScrollerList.create(goTabStage, goCellStage, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
end

function OriginMiMengLiStageView:onExit()
	OriginMiMengLiStageView.super.onExit(self)
	self._tableviewStage:dispose()
end

function OriginMiMengLiStageView:onEnter()
	OriginMiMengLiStageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginMiMengLiInfoRes, self._updateUIByInfo, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = OriginMiMengLiController.instance:getDefaultActivityId() or 0
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	OriginMiMengLiController.instance:getInfo(self._activityId)
	OriginMiMengLiController.instance:showCI()
end

function OriginMiMengLiStageView:_updateUIByCfg()
	self._actCfg = OriginMiMengLiConfig.instance:getActCfgByActId(self._activityId) or {}
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._stageCfgs = OriginMiMengLiConfig.instance:getAllStageCfgs(self._activityId) or {}
end

function OriginMiMengLiStageView:_updateUIByInfo()
	self._isPassAll = false
	self._curStageId = 0

	local info = OriginMiMengLiModel.instance:getInfo(self._activityId)

	if info then
		self._curStageId = info.passStage or 0
		self._isPassAll = self._curStageId >= #self._stageCfgs
	end

	self._tableviewStage:reloadData(self._stageCfgs)
	self._tableviewStage:MoveCellToBegin((self._isPassAll or nil) and #self._stageCfgs - 1)
end

function OriginMiMengLiStageView:_onClickBtnTip()
	if not self._actCfg.ruleKey then
		TipsFacade.instance:openRulesView(self._actCfg.ruleKey)
	end
end

function OriginMiMengLiStageView:_updateStageCell(view, cell, data)
	local stageId = data.stageId
	local passCount = data.passCount
	local go = cell.gameObject
	local btnFight = goutil.findChild(go, "btnFight")

	GameUtil.addClickHandler(btnFight, GameUtil.handler(self._onClickFight, self, data))

	local txtStage = goutil.findChildTextComponent(go, "stage/txt")
	local txtTips = goutil.findChildTextComponent(go, "tips/txt")

	txtStage.text = langPara("第%s关", stageId)
	txtTips.text = langPara("次数目标：<color={0}>{1}</color>", "#b0f088", passCount)

	local mask = goutil.findChild(go, "mask")
	local markPass = goutil.findChild(go, "mask/pass")
	local markLock = goutil.findChild(go, "mask/markLock")

	if self._isPassAll then
		goutil.setActive(mask, false)
	else
		goutil.setActive(mask, self._curStageId + 1 ~= stageId)
		goutil.setActive(markLock, stageId > self._curStageId + 1)
		goutil.setActive(markPass, stageId < self._curStageId + 1)
	end

	local creepCfgs = OriginMiMengLiConfig.instance:getCreepCfgs(data.creepsMasterId)
	local fmtView = goutil.findChild(go, "fmt/fmtView")

	for posId = 1, fmtView.transform.childCount do
		local fmtCellGo = fmtView.transform:GetChild(posId - 1)
		local fmtIcon = goutil.findChild(fmtCellGo, "icon")

		MaterialMgr.resetAll(fmtIcon)
	end

	for _, cfg in pairs(creepCfgs) do
		local posId = cfg.posId

		if posId < 1 or posId > 9 then
			-- block empty
		else
			local fmtCellGo = fmtView.transform:GetChild(posId - 1)

			if fmtCellGo then
				local fmtIcon = goutil.findChild(fmtCellGo, "icon")

				self._powerPetMo:fromChallengeCreepCo(cfg)

				local petMo = self._powerPetMo:toBaseBagPetMo()
				local proxy = MaterialMgr.setCellByMo(petMo, fmtIcon)

				if proxy then
					proxy.binder:setAutoTips(false)
					proxy:setCallBack(function()
						CommonTipsMgr.instance:showPetTips(petMo)
					end)
				end
			end
		end
	end
end

function OriginMiMengLiStageView:_clearStageCell(cell)
	local go = cell.gameObject
	local btnFight = goutil.findChild(go, "btnFight")

	GameUtil.rmClickHandler(btnFight)

	local fmtView = goutil.findChild(go, "fmt/fmtView")

	for posId = 1, fmtView.transform.childCount do
		local fmtCellGo = fmtView.transform:GetChild(posId - 1)
		local fmtIcon = goutil.findChild(fmtCellGo, "icon")

		MaterialMgr.resetAll(fmtIcon)
	end
end

function OriginMiMengLiStageView:_onClickFight(stageCfg)
	local stageId = stageCfg.stageId

	if not self._isPassAll then
		if stageId > self._curStageId + 1 then
			TipsFacade.instance:openCommonTips(lang("通关上一关开启"))

			return
		elseif stageId < self._curStageId + 1 then
			TipsFacade.instance:openCommonTips(lang("首通全部关卡后可重复挑战"))

			return
		end
	end

	OriginMiMengLiController.instance:showMissionView(self._activityId, stageId)
end

return OriginMiMengLiStageView
