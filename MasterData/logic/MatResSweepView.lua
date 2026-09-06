-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/MatResSweepView.lua

module("logic.extensions.bag.view.MatResSweepView", package.seeall)

local MatResSweepView = class("MatResSweepView", ViewComponent)

function MatResSweepView:ctor()
	MatResSweepView.super.ctor(self)

	self._method = SystemReflexHelp.getMethod("UnityEngine.UI.Dropdown,UnityEngine.UI", "Hide")
end

function MatResSweepView:unbindEvents()
	MatResSweepView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancle)
	self._btn1:RemoveClickListener()
	self._cell_exp.dropdown:RemoveOnValueChanged()
	self._cell_coin.dropdown:RemoveOnValueChanged()
	self._cell_exp.inputField:RemoveOnEndEdit()
	self._cell_coin.inputField:RemoveOnEndEdit()
end

function MatResSweepView:bindEvents()
	MatResSweepView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, GameUtil.handler(self.close, self))
	GameUtil.addClickHandler(self._btnCancle, GameUtil.handler(self.close, self))
	GameUtil.addClickHandler(self._btnSure, GameUtil.handler(self._onClickSure, self))
	self._btn1:AddClickListener(self._onClickBtn1, self)
	self._cell_exp.inputField:AddOnEndEdit(self._onEndEditExp, self)
	self._cell_coin.inputField:AddOnEndEdit(self._onEndEditCoin, self)
	self._cell_exp.dropdown:AddOnValueChanged(self._onValueChangedExp, self)
	self._cell_coin.dropdown:AddOnValueChanged(self._onValueChangedCoin, self)
end

function MatResSweepView:buildUI()
	MatResSweepView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._btnCancle = self:getGo("btnCancle")
	self._btn1 = Framework.ButtonAdapter.GetFrom(self.mainGO, "btnUseTick")
	self._markbtn1 = goutil.findChild(self.mainGO, "btnUseTick/Background/Checkmark")
	self._txt6 = MaterialMgr.findGraphicText(self.mainGO, "curCost/txt6")
	self._cell_exp = self:_buildCell(self:getGo("cell_exp"))
	self._cell_coin = self:_buildCell(self:getGo("cell_coin"))
	self._goldBarCon = self:getGo("goldBarCon")
end

function MatResSweepView:_buildCell(go)
	local cell = {}

	cell.go = go
	cell.goEnough = goutil.findChild(cell.go, "enough")
	cell.goNotEnough = goutil.findChild(cell.go, "not_enough")
	cell.inputField = Framework.InputFieldAdapter.GetFrom(cell.goNotEnough, "inputField")
	cell.dropdown = DropDownAdapter.GetFrom(cell.goNotEnough, "dropdown")
	cell.txtTips = goutil.findChildTextComponent(cell.goNotEnough, "txtTips")
	cell.item = goutil.findChild(cell.go, "item")

	return cell
end

function MatResSweepView:onExit()
	MatResSweepView.super.onExit(self)
	MaterialMgr.resetAll(self._cell_exp.item)
	MaterialMgr.resetAll(self._cell_coin.item)
	self:_hideAllDropdown()
end

function MatResSweepView:onEnter()
	MatResSweepView.super.onEnter(self)

	local params = self:getOpenParam()

	self._needCoinNum = checknumber(params[1])
	self._needExpNum = checknumber(params[2])

	self:_resetView()
	self:_updateTips()
	MaterialMgr.setCellByCfg("4:25:0", self._cell_exp.item)
	MaterialMgr.setCellByCfg("8:1:0", self._cell_coin.item)
	self._cell_exp.dropdown:ClearOptions()
	self._cell_exp.dropdown:AddOptions("选择关卡")

	local lastPassId = -1
	local stageCfgs = MaterialChallengeConfig.instance:getStages(GameEnum.ResCopyType.Exp)

	for i, vCfg in ipairs(stageCfgs) do
		local isPass = MaterialChallengeModel.instance:isStagePassed(vCfg.chapterId, vCfg.stageId)
		local str = not isPass and " <color=#FF0000><size=20>X</size></color>" or ""

		self._cell_exp.dropdown:AddOptions(vCfg.stageName .. str)

		if isPass then
			lastPassId = vCfg.stageId
		elseif lastPassId == -1 then
			lastPassId = vCfg.stageId - 1
		end
	end

	if lastPassId == -1 then
		lastPassId = 0
	end

	self._sweepStageIdExp = lastPassId

	self._cell_exp.dropdown:SetValue(lastPassId)
	self._cell_coin.dropdown:ClearOptions()
	self._cell_coin.dropdown:AddOptions("选择关卡")

	local lastPassCoinId = -1
	local stageCfgsCoin = MaterialChallengeConfig.instance:getStages(GameEnum.ResCopyType.Coin)

	for i, vCfg in ipairs(stageCfgsCoin) do
		local isPass = MaterialChallengeModel.instance:isStagePassed(vCfg.chapterId, vCfg.stageId)
		local str = not isPass and " <color=#FF0000><size=20>X</size></color>" or ""

		self._cell_coin.dropdown:AddOptions(vCfg.stageName .. str)

		if isPass then
			lastPassCoinId = vCfg.stageId
		elseif lastPassCoinId == -1 then
			lastPassCoinId = vCfg.stageId - 1
		end
	end

	if lastPassCoinId == -1 then
		lastPassCoinId = 0
	end

	self._sweepStageIdCoin = lastPassCoinId

	self._cell_coin.dropdown:SetValue(lastPassCoinId)
	self.addGEvent(self, GlobalNotify.OnMaterialCountChange, self._updateTips, self)
	self.addGEvent(self, MaterialChallengeAgent.MCLG_SweepsByTimesRes, self._onMCLG_SweepsByTimesRes, self)

	local btn_list = {
		{
			showAdd = true,
			id = GameEnum.GoldType.Tili
		},
		{
			id = "4:11",
			showAdd = true
		},
		{
			id = "4:12",
			showAdd = true
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list)
end

function MatResSweepView:_onEndEditExp(inputStr)
	local time = checknumber(inputStr)

	time = MathUtil.clamp(time, 0, 99)
	self._sweepTimeExp = time

	self:_calCost()
end

function MatResSweepView:_onEndEditCoin(inputStr)
	local time = checknumber(inputStr)

	time = MathUtil.clamp(time, 0, 99)
	self._sweepTimeCoin = time

	self:_calCost()
end

function MatResSweepView:_onValueChangedExp(value)
	if value == 0 then
		self._sweepStageIdExp = value
	else
		local isPass = MaterialChallengeModel.instance:isStagePassed(GameEnum.ResCopyType.Exp, value)

		if not isPass then
			self._cell_exp.dropdown:SetValue(self._sweepStageIdExp)
			FloatWordMgr.instance:show("挑战未通关")

			return
		else
			self._sweepStageIdExp = value
		end
	end

	self:_calCost()
end

function MatResSweepView:_onValueChangedCoin(value)
	if value == 0 then
		self._sweepStageIdCoin = value
	else
		local isPass = MaterialChallengeModel.instance:isStagePassed(GameEnum.ResCopyType.Coin, value)

		if not isPass then
			self._cell_coin.dropdown:SetValue(self._sweepStageIdCoin)
			FloatWordMgr.instance:show("挑战未通关")

			return
		else
			self._sweepStageIdCoin = value
		end
	end

	self:_calCost()
end

function MatResSweepView:_hideAllDropdown()
	self:_onHideDropdown(self._cell_exp.dropdown)
	self:_onHideDropdown(self._cell_coin.dropdown)
end

function MatResSweepView:_onHideDropdown(dropdown)
	self._method:Call(dropdown.dropdown)
end

function MatResSweepView:_onClickBtn1()
	self._isUseTick = not self._isUseTick

	self:_calCost()
end

function MatResSweepView:_resetView()
	self._isUseTick = true
	self._sweepTimeExp = 0
	self._sweepTimeCoin = 0
	self._sweepStageIdExp = 0
	self._sweepStageIdCoin = 0

	self:_calCost()
end

function MatResSweepView:_calCost()
	self._curTiCost = 0
	self._curTickCostCoin = 0
	self._curTickCostExp = 0
	self._useTickTimeCoin = 0
	self._useTickTimeExp = 0

	if self._sweepStageIdExp > 0 and self._sweepTimeExp > 0 then
		local cfgStage = MaterialChallengeConfig.instance:getStageById(GameEnum.ResCopyType.Exp, self._sweepStageIdExp)

		if self._isUseTick then
			local matType, id, ticketNum = MaterialMgr.getMatParams(cfgStage.ticket)
			local curNum = MaterialMgr.getMatCount(cfgStage.ticket)

			if curNum < self._sweepTimeExp * ticketNum then
				local useTickTime = Mathf.Floor(curNum / ticketNum)

				self._curTickCostExp = useTickTime * ticketNum
				self._curTiCost = self._curTiCost + cfgStage.power * (self._sweepTimeExp - useTickTime)
				self._useTickTimeExp = useTickTime
			else
				self._curTickCostExp = self._sweepTimeExp * ticketNum
				self._useTickTimeExp = self._sweepTimeExp
			end
		else
			self._curTiCost = self._curTiCost + cfgStage.power * self._sweepTimeExp
		end
	end

	if self._sweepStageIdCoin > 0 and self._sweepTimeCoin > 0 then
		local cfgStage = MaterialChallengeConfig.instance:getStageById(GameEnum.ResCopyType.Coin, self._sweepStageIdCoin)

		if self._isUseTick then
			local matType, id, ticketNum = MaterialMgr.getMatParams(cfgStage.ticket)
			local curNum = MaterialMgr.getMatCount(cfgStage.ticket)

			if curNum < self._sweepTimeCoin * ticketNum then
				local useTickTime = Mathf.Floor(curNum / ticketNum)

				self._curTickCostCoin = useTickTime * ticketNum
				self._curTiCost = self._curTiCost + cfgStage.power * (self._sweepTimeCoin - useTickTime)
				self._useTickTimeCoin = useTickTime
			else
				self._curTickCostCoin = self._sweepTimeCoin * ticketNum
				self._useTickTimeCoin = self._sweepTimeCoin
			end
		else
			self._curTiCost = self._curTiCost + cfgStage.power * self._sweepTimeCoin
		end
	end

	self:_updateView()
end

function MatResSweepView:_updateView()
	self._cell_exp.inputField.input.text = self._sweepTimeExp
	self._cell_coin.inputField.input.text = self._sweepTimeCoin

	goutil.setActive(self._markbtn1, self._isUseTick)
	self:_hideAllDropdown()
	self:_updateCostStr()
end

function MatResSweepView:_updateCostStr()
	local str = ""

	if self._curTiCost > 0 then
		if MaterialMgr.getMatCount(GameEnum.GoldType.Tili) >= self._curTiCost then
			if not ColorConst.Green then
				do
					local color = ColorConst.Red

					str = str .. string.format("<quad name=%s|icon size=25 width=1 offsetY=-5/> x <color=#%s>%d</color>", GameEnum.GoldType.Tili, color, self._curTiCost)
				end

				if self._curTickCostExp > 0 and self._sweepStageIdExp > 0 then
					local cfgStage = MaterialChallengeConfig.instance:getStageById(GameEnum.ResCopyType.Exp, self._sweepStageIdExp)
					local matType, id, ticketNum = MaterialMgr.getMatParams(cfgStage.ticket)

					if MaterialMgr.getMatCount(cfgStage.ticket) >= self._curTickCostExp then
						if not ColorConst.Green then
							local color = ColorConst.Red

							str = str .. string.format("<quad name=%s|icon size=25 width=1 offsetY=-5/> x <color=#%s>%d</color>", matType .. ":" .. id, color, self._curTickCostExp)
						end
					end
				end

				if self._curTickCostCoin > 0 and self._sweepStageIdCoin > 0 then
					local cfgStage = MaterialChallengeConfig.instance:getStageById(GameEnum.ResCopyType.Coin, self._sweepStageIdCoin)
					local matType, id, ticketNum = MaterialMgr.getMatParams(cfgStage.ticket)

					if MaterialMgr.getMatCount(cfgStage.ticket) >= self._curTickCostCoin then
						if not ColorConst.Green then
							local color = ColorConst.Red

							str = str .. string.format("<quad name=%s|icon size=25 width=1 offsetY=-5/> x <color=#%s>%d</color>", matType .. ":" .. id, color, self._curTickCostCoin)
						end
					end
				end
			end
		end
	end

	self._txt6.text = str

	goutil.setActive(self._txt6.gameObject, false)
	goutil.setActive(self._txt6.gameObject, true)
end

function MatResSweepView:_updateTips()
	self:_calCost()

	local coinNum = MaterialMgr.getMatCount(GameEnum.GoldType.Coin)

	if coinNum >= self._needCoinNum then
		self._cell_coin.txtTips.text = ""
		self._sweepStageIdCoin = 0

		goutil.setActive(self._cell_coin.goEnough, true)
		goutil.setActive(self._cell_coin.goNotEnough, false)
	else
		self._cell_coin.txtTips.text = string.format("缺少<color=#%s>%d</color>个金币", ColorConst.Red, self._needCoinNum - coinNum)

		goutil.setActive(self._cell_coin.goEnough, false)
		goutil.setActive(self._cell_coin.goNotEnough, true)
	end

	local totalOwnExp = 0
	local expMatId = {
		2,
		3,
		25
	}

	for i, matId in ipairs(expMatId) do
		local cfg = MaterialConfig.instance:getCfgByMatAndId(MatType.Item, matId)
		local addExp = checknumber(cfg.content)
		local ownNum = MaterialModel.instance:getMaterialsNumber(MatType.Item, matId)

		totalOwnExp = totalOwnExp + ownNum * addExp
	end

	if totalOwnExp >= self._needExpNum then
		self._sweepStageIdExp = 0
		self._cell_exp.txtTips.text = ""

		goutil.setActive(self._cell_exp.goEnough, true)
		goutil.setActive(self._cell_exp.goNotEnough, false)
	else
		self._cell_exp.txtTips.text = string.format("缺少<color=#%s>%d</color>点经验值", ColorConst.Red, self._needExpNum - totalOwnExp)

		goutil.setActive(self._cell_exp.goEnough, false)
		goutil.setActive(self._cell_exp.goNotEnough, true)
	end

	self:_updateCostStr()
end

function MatResSweepView:_onClickSure()
	if self._sweepTimeCoin > 0 and self._sweepStageIdCoin > 0 or self._sweepTimeExp > 0 and self._sweepStageIdExp > 0 then
		if self._sweepStageIdCoin > 0 then
			local curCountCoin, maxCountCoin = MaterialChallengeModel.instance:getCostLimitCount(GameEnum.ResCopyType.Coin)
			local leftCountCoin = maxCountCoin - curCountCoin

			if leftCountCoin < self._sweepTimeCoin then
				FloatWordMgr.instance:show(string.format("金币副本最多剩余%s扫荡次数", leftCountCoin))

				return
			end
		end

		if self._sweepStageIdExp > 0 then
			local curCountExp, maxCountExp = MaterialChallengeModel.instance:getCostLimitCount(GameEnum.ResCopyType.Exp)
			local leftCountExp = maxCountExp - curCountExp

			if leftCountExp < self._sweepTimeExp then
				FloatWordMgr.instance:show(string.format("经验副本最多剩余%s扫荡次数", leftCountExp))

				return
			end
		end

		if MaterialMgr.getMatCount(GameEnum.GoldType.Tili) < self._curTiCost then
			FloatWordMgr.instance:show("体力不足")

			return
		end

		if self._sweepTimeCoin > 0 and self._sweepStageIdCoin > 0 then
			local isDoubleTime = ActivityDefineController.instance:isInTimeForMultiplyReward(GameEnum.CampaignType.Material, GameEnum.ResCopyType.Coin)

			local function resFunc(msg)
				MaterialChallengeModel.instance:addChallengeCount(GameEnum.ResCopyType.Coin, #msg.prizes)

				if isDoubleTime then
					MaterialChallengeModel.instance:addChallengeDoubleRewardCount(GameEnum.ResCopyType.Coin, msg.multiplyTimes)
				end
			end

			if self._useTickTimeCoin > 0 then
				MaterialChallengeController.instance:sendMCLG_SweepsByTimesReq(GameEnum.ResCopyType.Coin, self._sweepStageIdCoin, self._useTickTimeCoin, true, resFunc)

				if self._sweepTimeCoin - self._useTickTimeCoin > 0 then
					MaterialChallengeController.instance:sendMCLG_SweepsByTimesReq(GameEnum.ResCopyType.Coin, self._sweepStageIdCoin, self._sweepTimeCoin - self._useTickTimeCoin, false, resFunc)
				end
			else
				MaterialChallengeController.instance:sendMCLG_SweepsByTimesReq(GameEnum.ResCopyType.Coin, self._sweepStageIdCoin, self._sweepTimeCoin, false, resFunc)
			end
		end

		if self._sweepTimeExp > 0 and self._sweepStageIdExp > 0 then
			local isDoubleTime = ActivityDefineController.instance:isInTimeForMultiplyReward(GameEnum.CampaignType.Material, GameEnum.ResCopyType.Exp)

			local function resFunc(msg)
				MaterialChallengeModel.instance:addChallengeCount(GameEnum.ResCopyType.Exp, #msg.prizes)

				if isDoubleTime then
					MaterialChallengeModel.instance:addChallengeDoubleRewardCount(GameEnum.ResCopyType.Exp, msg.multiplyTimes)
				end
			end

			if self._useTickTimeExp > 0 then
				MaterialChallengeController.instance:sendMCLG_SweepsByTimesReq(GameEnum.ResCopyType.Exp, self._sweepStageIdExp, self._useTickTimeExp, true, resFunc)

				if self._sweepTimeExp - self._useTickTimeExp > 0 then
					MaterialChallengeController.instance:sendMCLG_SweepsByTimesReq(GameEnum.ResCopyType.Exp, self._sweepStageIdExp, self._sweepTimeExp - self._useTickTimeExp, false, resFunc)
				end
			else
				MaterialChallengeController.instance:sendMCLG_SweepsByTimesReq(GameEnum.ResCopyType.Exp, self._sweepStageIdExp, self._sweepTimeExp, false, resFunc)
			end
		end
	else
		FloatWordMgr.instance:show("请选择扫荡副本跟扫荡次数")
	end
end

function MatResSweepView:_onMCLG_SweepsByTimesRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("扫荡成功")
		self:_updateTips()
	else
		printInfo("test 请求失败>> 资源副本奖励")
	end
end

return MatResSweepView
