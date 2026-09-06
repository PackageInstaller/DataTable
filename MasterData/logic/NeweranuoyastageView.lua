-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/neweranuoya/view/NeweranuoyastageView.lua

module("logic.extensions.neweranuoya.view.NeweranuoyastageView", package.seeall)

local NeweranuoyastageView = class("NeweranuoyastageView", ViewComponent)

function NeweranuoyastageView:ctor()
	NeweranuoyastageView.super.ctor(self)
end

function NeweranuoyastageView:unbindEvents()
	NeweranuoyastageView.super.unbindEvents(self)

	for i, v in ipairs(self._stageItems) do
		v.btn:RemoveClickListener()
		v.btnNum:RemoveClickListener()
	end

	self._btnReset:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function NeweranuoyastageView:bindEvents()
	NeweranuoyastageView.super.bindEvents(self)

	for i, v in ipairs(self._stageItems) do
		v.btn:AddClickListener(function()
			self:_onClickCell(i)
		end)
		v.btnNum:AddClickListener(function()
			self:_onClickBtnNum(i)
		end)
	end

	self._btnReset:AddClickListener(self._onClickbtnReset, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
end

function NeweranuoyastageView:buildUI()
	NeweranuoyastageView.super.buildUI(self)
	self:_buildStageCells()

	self._btnReset = self:getBtn("btnReset")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._tableviewGo1 = self:getGo("reward1/tableview")
	self._tablecellGo1 = self:getGo("reward1/tablecell")
	self._tableviewGo2 = self:getGo("reward2/tableview")
	self._tablecellGo2 = self:getGo("reward2/tablecell")
	self._scrollerList1 = ScrollerList.create(self._tableviewGo1, self._tablecellGo1, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._scrollerList2 = ScrollerList.create(self._tableviewGo2, self._tablecellGo2, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._stageeffectGo = self:getGo("stageeffect")
end

function NeweranuoyastageView:_buildStageCells()
	self._stageItems = {}

	for i = 1, 4 do
		local go = goutil.findChild(self.mainGO, "cell" .. i)
		local btnGo = goutil.findChild(go, "btn")
		local btnNumGo = goutil.findChild(go, "num")

		self._stageItems[i] = {
			go = go,
			txtNum = goutil.findChildTextComponent(go, "num/txtNum"),
			btn = Framework.ButtonAdapter.Get(btnGo),
			selectGo = goutil.findChild(go, "select"),
			numGo = goutil.findChild(go, "num"),
			btnNum = Framework.ButtonAdapter.Get(btnNumGo),
			gouGo = goutil.findChild(go, "gou")
		}
	end
end

function NeweranuoyastageView:onExit()
	NeweranuoyastageView.super.onExit(self)
	self._scrollerList1:dispose()
	self._scrollerList2:dispose()

	if self._effectHandlerReset then
		UIEffectManager.instance:stopEffect(self._effectHandlerReset)

		self._effectHandlerReset = nil
	end

	if self._effectHandlerRoadBase then
		UIEffectManager.instance:stopEffect(self._effectHandlerRoadBase)

		self._effectHandlerRoadBase = nil
	end
end

function NeweranuoyastageView:onEnter()
	NeweranuoyastageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.NewEraNuoYaResetFloorRes, self._onNewEraNuoYaResetFloorRes, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._clgType = params[2]

	self:_udpateUI()
	NeweranuoyaController.instance:openItemGetViewWithCI()
	self:_playStageRoadBaseEffect()
end

function NeweranuoyastageView:_initFloorAndStage()
	local info = NeweranuoyaModel.instance:getInfo(self._activityId)

	if self._clgType == NeweranuoyaController.ClgType.Normal then
		if info.maxPassCommonStageId > 0 then
			local stageCfg = NeweranuoyaConfig.instance:getNormalStageCfg(self._activityId, info.maxPassCommonStageId)
			local nextStageCfg = NeweranuoyaConfig.instance:getNormalStageCfg(self._activityId, info.maxPassCommonStageId + 1)

			self._curFloorId = stageCfg.floorId

			if nextStageCfg and nextStageCfg.floorId ~= stageCfg.floorId then
				self._curFloorId = nextStageCfg.floorId
			end

			self._curStageId = info.maxPassCommonStageId
		else
			self._curFloorId = 1
			self._curStageId = 0
		end
	elseif self._clgType == NeweranuoyaController.ClgType.Extreme then
		for i, v in ipairs(info.NewEraNuoyaExtFloorInfos) do
			local stageCfgs = NeweranuoyaConfig.instance:getExtStageCfgs(self._activityId, v.floorId)

			self._curFloorId = v.floorId
			self._curStageId = v.maxPassStageId

			if v.maxPassStageId < #stageCfgs then
				break
			end
		end
	end
end

function NeweranuoyastageView:_onNewEraNuoYaResetFloorRes()
	self:_playResetEffect()
	self:_udpateUI()
end

function NeweranuoyastageView:_onClickbtnClose()
	self:close()
end

function NeweranuoyastageView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("neweranuoyamain")
end

function NeweranuoyastageView:_onClickBtnNum(idx)
	if not self._stageCfgs or not self._stageCfgs[idx] then
		return
	end

	UIStateManager.instance:push(ViewName.NeweranuoyabuffView, self._activityId, self._curFloorId, self._stageCfgs[idx].stageId)
end

function NeweranuoyastageView:_onClickCell(idx)
	if not self._stageCfgs or not self._stageCfgs[idx] then
		return
	end

	local nextStageId = 0

	if self._clgType == NeweranuoyaController.ClgType.Normal then
		local info = NeweranuoyaModel.instance:getInfo(self._activityId)
		local stageCfg = self._stageCfgs[idx]

		if NeweranuoyaModel.instance:isNormalStagePass(self._activityId, stageCfg.stageId) then
			FloatWordMgr.instance:show("关卡已通过")

			return
		end

		if stageCfg.stageId > 1 then
			local prePass = NeweranuoyaModel.instance:isNormalStagePass(self._activityId, stageCfg.stageId - 1)

			if not prePass then
				FloatWordMgr.instance:show("请通关前置关卡")

				return
			end
		end

		nextStageId = stageCfg.stageId
	elseif self._clgType == NeweranuoyaController.ClgType.Extreme then
		local stageCfgs = NeweranuoyaConfig.instance:getExtStageCfgs(self._activityId, self._curFloorId)
		local stageCfg = stageCfgs[(self._curFloorId > 1 or nil) and 5 - idx]

		if NeweranuoyaModel.instance:isExtStagePass(self._activityId, self._curFloorId, stageCfg.stageId) then
			local stageInfo = NeweranuoyaModel.instance:getExtStageFloorInfo(self._activityId, self._curFloorId, stageCfg.stageId)
			local floorInfo = NeweranuoyaModel.instance:getFloorInfo(self._activityId, self._curFloorId, stageCfg.stageId)

			if not stageInfo.banRaceIdToIsDead then
				local jobIdToBuffNum = stageInfo.jobIdToBuffNum

				UIStateManager.instance:push(ViewName.NeweranuoyaresultView, false, self._activityId, stageInfo.banRaceIdToIsDead, jobIdToBuffNum)

				return
			end
		end

		if stageCfg.stageId > 1 then
			local prePass = NeweranuoyaModel.instance:isExtStagePass(self._activityId, self._curFloorId, stageCfg.stageId - 1)

			if not prePass then
				FloatWordMgr.instance:show("请通关前置关卡")

				return
			end
		end

		nextStageId = stageCfg.stageId
	end

	local fmtMo = NeweranuoyaModel.instance:getFmtMo()

	fmtMo:initParams(self._activityId, self._clgType, self._curFloorId, nextStageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function NeweranuoyastageView:_onClickbtnReset()
	local floorInfo = NeweranuoyaModel.instance:getFloorInfo(self._activityId, self._curFloorId)

	if floorInfo.maxPassStageId <= 0 then
		FloatWordMgr.instance:show("无需重置")

		return
	end

	local floorInfo2 = NeweranuoyaModel.instance:getFloorInfo(self._activityId, 2)
	local cfgs = NeweranuoyaConfig.instance:getExtStageCfgs(self._activityId, 2)
	local floorIds = {
		self._curFloorId
	}

	if floorInfo2.maxPassStageId >= #cfgs then
		floorIds = {
			1,
			2
		}
	end

	local text = "是否重置所有关卡，重置后所有关卡回到初始状态"

	TipsFacade.instance:openPopupWindow("提示", text, function()
		NewEraNuoYaAgent.instance:sendPM_NewEraNuoYaResetFloorReq(self._activityId, floorIds)
	end)
end

function NeweranuoyastageView:_udpateUI()
	self:_initFloorAndStage()

	local stageCfgs

	if self._clgType == NeweranuoyaController.ClgType.Normal then
		stageCfgs = NeweranuoyaConfig.instance:getNormalStageShowCfgs(self._activityId, self._curFloorId)
	elseif self._clgType == NeweranuoyaController.ClgType.Extreme then
		stageCfgs = NeweranuoyaConfig.instance:getExtStageShowCfgs(self._activityId, self._curFloorId)
	end

	self._stageCfgs = stageCfgs

	for i, v in ipairs(stageCfgs) do
		self:_updateCell(i, v)
	end

	self:_updateArrows()

	local prizesCfg1 = NeweranuoyaConfig.instance:getFloorPrizeCfgs(self._activityId, 1, self._clgType)
	local prizesCfg2 = NeweranuoyaConfig.instance:getFloorPrizeCfgs(self._activityId, 2, self._clgType, true)

	self._scrollerList1:reloadData(prizesCfg1)
	self._scrollerList2:reloadData(prizesCfg2)
	goutil.setActive(self._btnReset.gameObject, self._clgType == NeweranuoyaController.ClgType.Extreme)
	self:_playStageRoadEffect()
end

function NeweranuoyastageView:_updateCell(idx, stageCfg)
	local item = self._stageItems[idx]
	local isExt = self._clgType == NeweranuoyaController.ClgType.Extreme
	local isSelect = stageCfg.stageId == self._curStageId + 1
	local num = 0

	goutil.setActive(item.selectGo, isSelect)
	goutil.setActive(item.gouGo, stageCfg.stageId <= self._curStageId)

	if isExt then
		local stageInfo = NeweranuoyaModel.instance:getExtStageFloorInfo(self._activityId, self._curFloorId, stageCfg.stageId)

		for i, v in ipairs(stageInfo.jobIdToBuffNum or {}) do
			num = num + 1
		end

		item.txtNum.text = num
	end

	goutil.setActive(item.numGo, num > 0)
end

function NeweranuoyastageView:_updateArrows()
	return
end

function NeweranuoyastageView:_updateRewardCell(view, cell, prizeCfg, tag)
	local goCon = goutil.findChild(cell.gameObject, "con")
	local goGain = goutil.findChild(cell.gameObject, "gain")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local isGain = NeweranuoyaModel.instance:isPrizeGain(self._activityId, self._clgType, prizeCfg.floorId, prizeCfg.stageId)

	goutil.setActive(goGain, isGain)

	txtName.text = prizeCfg.prizeName

	MaterialMgr.setCellByCfg(prizeCfg.prize, goCon)
end

function NeweranuoyastageView:_clearRewardCell(cell)
	local goCon = goutil.findChild(cell.gameObject, "con")

	MaterialMgr.resetAll(goCon)
end

function NeweranuoyastageView:_playResetEffect()
	local effName = "20251121/nuoyatiaozhan/shijianhuisu/fx_ui_nytz_shijianhuisu.prefab"

	self._effectHandlerReset = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, false)

	self._effectHandlerReset:setParent(self.mainGO.transform)
	self._effectHandlerReset:setScale(1)
	self._effectHandlerReset:setLocalPos(0, 0, 0)
end

function NeweranuoyastageView:_playStageRoadBaseEffect()
	local effName = "20251121/nuoyatiaozhan/luxianliudong/fx_ui_nytz_luxianliudong.prefab"

	self._effectHandlerRoadBase = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandlerRoadBase:setParent(self.mainGO.transform)
	self._effectHandlerRoadBase:setScale(1)
	self._effectHandlerRoadBase:setLocalPos(0, 0, 0)
end

function NeweranuoyastageView:_playStageRoadEffect()
	if self._effectHandlerRoad then
		UIEffectManager.instance:stopEffect(self._effectHandlerRoad)
	end

	self._effectHandlerRoad = UIEffectManager.instance:playEffect(self, self._curFloorId == NeweranuoyaController.Floor.One and "20251121/nuoyatiaozhan/luxianliudong/fx_ui_nytz_luxianliudong_yellow.prefab" or "20251121/nuoyatiaozhan/luxianliudong/fx_ui_nytz_luxianliudong_blue.prefab", nil, 0, 0, true)

	self._effectHandlerRoad:setParent(self.mainGO.transform)
	self._effectHandlerRoad:setScale(1)
	self._effectHandlerRoad:setLocalPos(0, 0, 0)
end

return NeweranuoyastageView
