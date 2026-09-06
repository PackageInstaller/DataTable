-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/view/DefendCarrotMainView.lua

module("logic.extensions.defendcarrot.view.DefendCarrotMainView", package.seeall)

local DefendCarrotMainView = class("DefendCarrotMainView", ViewComponent)

function DefendCarrotMainView:ctor()
	DefendCarrotMainView.super.ctor(self)
end

function DefendCarrotMainView:unbindEvents()
	DefendCarrotMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnFightMat)
	GameUtil.rmClickHandler(self._btnFight)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnExchange)
	GameUtil.rmClickHandler(self._btnUpgrade)
end

function DefendCarrotMainView:bindEvents()
	DefendCarrotMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnFightMat, self._onClickFightMat, self)
	GameUtil.addClickHandler(self._btnFight, self._onClickFight, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnExchange, self._onClickExchange, self)
	GameUtil.addClickHandler(self._btnUpgrade, self._onClickUpgrade, self)
end

function DefendCarrotMainView:buildUI()
	DefendCarrotMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")

	local cellProgress = self:getGo("prize/cell")
	local tabProgress = self:getGo("prize/tableview")

	self._tableviewProgress = ScrollerList.create(tabProgress, cellProgress, GameUtil.handler(self._updateProgressCell, self), GameUtil.handler(self._clearProgressCell, self))
	self._progressBar = self:getSlider("prize/tableview/viewport/content/progressBar")
	self._txtNumPass = self:getTxt("prize/passNum/txtNum")
	self._btnFightMat = self:getGo("btnFightMat")
	self._btnFight = self:getGo("btnFight")
	self._btnRank = self:getGo("btnRank")
	self._btnExchange = self:getGo("btnExchange")
	self._btnUpgrade = self:getGo("btnUpgrade")
	self._txtCurStage = self:getTxt("btnFight/curStage/txt")
	self._txtCurMatStage = self:getTxt("btnFightMat/curStage/txt")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
end

function DefendCarrotMainView:onExit()
	DefendCarrotMainView.super.onExit(self)
	self._tableviewProgress:dispose()
end

function DefendCarrotMainView:onEnter()
	DefendCarrotMainView.super.onEnter(self)

	self._activityId = 517001

	local params = self:getOpenParam()

	if params then
		self._activityId = checknumber(params[1])
	end

	self.addGEvent(self, GlobalNotify.DefendCarrotGetInfo, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.DefendCarrotGainPrize, self._updatePrizes, self)
	self:_updateUIByCfg()
	self:_updateUIByInfo()
	DefendCarrotController.instance:showCI()
	DefendCarrotController.instance:getInfo(self._activityId)

	local key = string.format("%s_%s", self._viewPresentor.viewName, self._activityId)

	GameUtil.doCallbackWhenFirst(key, function()
		GlobalDispatcher:dispatch(GlobalNotify.PushStory, self._curActCfg.stroyId, StoryModel.StoryType.SCCopy)
	end)
end

function DefendCarrotMainView:_updateUIByCfg()
	self._curActCfg = DefendCarrotConfig.instance:getActivityCfg(self._activityId) or {}
	self._prizeCfgs = DefendCarrotConfig.instance:getProgressCfgs(self._activityId) or {}
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._stageCfgs = DefendCarrotConfig.instance:getStageCfgs(self._activityId) or {}
end

function DefendCarrotMainView:_updateUIByInfo()
	self:_updateOtherInfo()
	self:_updatePrizes()
end

function DefendCarrotMainView:_updateOtherInfo()
	self._materialStageId = 0
	self._dailyMaterialTimes = 0
	self._maxStage = 0
	self._maxMatStage = 0

	local info = DefendCarrotModel.instance:getBaseInfo(self._activityId)

	if info then
		self._materialStageId = checknumber(info.materialStageId) or 0
		self._dailyMaterialTimes = checknumber(info.dailyMaterialTimes) or 0

		if not info.stages then
			local stages = {}

			for i, v in ipairs(stages) do
				self._maxStage = math.max(self._maxStage, v.stageId)
			end

			if not info.materialStages then
				for i, v in ipairs(info.materialStages) do
					self._maxMatStage = math.max(self._maxMatStage, v.stageId)
				end
			end
		end
	end

	self._maxStage = math.max(self._maxStage, 1)
	self._txtCurStage.text = string.format("当前第%s/%s关", self._maxStage, #self._stageCfgs)
	self._maxMatStage = math.max(self._maxMatStage, 1)

	local cfg = DefendCarrotConfig.instance:getMaterialClgByStageId(self._activityId, self._maxMatStage)

	self._txtCurMatStage.text = "正常难度"

	if cfg then
		self._txtCurMatStage.text = cfg.stagename or "入门难度"
	end
end

function DefendCarrotMainView:_updatePrizes()
	self._curMaxStageId = 0
	self._gainedPrizeIdMap = {}

	local info = DefendCarrotModel.instance:getBaseInfo(self._activityId)

	if info then
		if not info.gainedPrizeIds then
			do
				local gainedPrizeIds = {}

				for _, id in ipairs(gainedPrizeIds) do
					self._gainedPrizeIdMap[id] = true
				end

				if not info.stages then
					local stages = {}

					self._curMaxStageId = #stages
				end
			end

			local showIndex = -1
			local lastIndex = -1
			local scoreList = {}

			for i, cfg in ipairs(self._prizeCfgs) do
				if checknumber(cfg.stageId) <= self._curMaxStageId then
					if not self._gainedPrizeIdMap[cfg.prizeId] then
						if showIndex <= 0 then
							showIndex = cfg.prizeId
						end
					else
						lastIndex = i
					end
				end

				table.insert(scoreList, checknumber(cfg.stageId))
			end

			if lastIndex <= 0 then
				lastIndex = 1
			end

			if showIndex <= 0 then
				showIndex = lastIndex
			end

			self._tableviewProgress:updateUnderSlider(self._progressBar, self._curMaxStageId, scoreList)
			self._tableviewProgress:reloadData(self._prizeCfgs)
			self._tableviewProgress:MoveCellToBegin(showIndex - 1)

			self._txtNumPass.text = self._curMaxStageId
		end
	end
end

function DefendCarrotMainView:_updateProgressCell(view, cell, data)
	local item = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.setCellByCfg(data.prize, item)

	local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")

	txtNum.text = data.stageId

	if not self._gainedPrizeIdMap[data.prizeId] then
		local isGain = false
		local isMatchGain = not isGain and self._curMaxStageId >= checknumber(data.stageId)
		local btnGet = goutil.findChild(cell.gameObject, "btnGet")

		goutil.setActive(btnGet, isMatchGain)

		local effect = goutil.findChild(cell.gameObject, "effect")

		if isMatchGain then
			self:_playCellEffect(effect)
			GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickGainPrize, self, data.prizeId))
		else
			self:_clearCellEffect(effect)
		end

		local geted = goutil.findChild(cell.gameObject, "geted")

		goutil.setActive(geted, isGain)
	end
end

function DefendCarrotMainView:_clearProgressCell(cell)
	local item = goutil.findChild(cell.gameObject, "item")

	if item then
		MaterialMgr.resetAll(item)
	end

	local btnGet = goutil.findChild(cell.gameObject, "btnGet")

	if btnGet then
		GameUtil.rmClickHandler(btnGet)
	end

	local effect = goutil.findChild(cell.gameObject, "effect")

	if effect then
		self:_clearCellEffect(effect)
	end
end

function DefendCarrotMainView:_onClickGainPrize(prizeId)
	DefendCarrotController.instance:gainPrize(self._activityId, prizeId)
end

function DefendCarrotMainView:_playCellEffect(effGo)
	self:_clearCellEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("prize/tableview/viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScaleXYZ(0.96, 1, 0.87)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function DefendCarrotMainView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function DefendCarrotMainView:_onClickTip()
	local key = self._curActCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function DefendCarrotMainView:_onClickFightMat()
	UIStateManager.instance:push(ViewName.DefendcarrotmaterialView, self._activityId)
end

function DefendCarrotMainView:_onClickFight()
	UIStateManager.instance:push(ViewName.DefendcarrotnormalView, self._activityId)
end

function DefendCarrotMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.DefendCarrotRankView, self._activityId)
end

function DefendCarrotMainView:_onClickUpgrade()
	UIStateManager.instance:push(ViewName.DefendCarrotUpgradeView, self._activityId)
end

function DefendCarrotMainView:_onClickExchange()
	local jumpToStr = self._curActCfg.jumpTo

	GotoMgr.gotoByString(jumpToStr)
end

return DefendCarrotMainView
