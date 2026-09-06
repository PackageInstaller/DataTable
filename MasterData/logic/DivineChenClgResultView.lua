-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinechenclg/view/DivineChenClgResultView.lua

module("logic.extensions.divinechenclg.view.DivineChenClgResultView", package.seeall)

local DivineChenClgResultView = class("DivineChenClgResultView", ViewComponent)

function DivineChenClgResultView:ctor()
	DivineChenClgResultView.super.ctor(self)
end

function DivineChenClgResultView:unbindEvents()
	DivineChenClgResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DivineChenClgResultView:bindEvents()
	DivineChenClgResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function DivineChenClgResultView:buildUI()
	DivineChenClgResultView.super.buildUI(self)

	self._titleTxt = self:getTxt("bg/titleTxt")
	self._btnClose = self:getGo("btnClose")
	self._txtTarget = self:getTxt("txtTarget")
	self._txtPassTarget = self:getTxt("txtPassTarget")
	self._emptyTips = self:getGo("emptyTips")

	local tableviewGo = self:getGo("Scrollerview")
	local cellGo = self:getGo("itemCell")

	self._tableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableview:setCenterMode(true)
end

function DivineChenClgResultView:onExit()
	DivineChenClgResultView.super.onExit(self)
	self._tableview:dispose()
end

function DivineChenClgResultView:onEnter()
	DivineChenClgResultView.super.onEnter(self)

	local info = self:getFirstParam()

	self._activityId = info.activityId

	local stageId = info.stageId
	local isWin = info.isWin

	self._isAllPass = info.isAllPass

	if not info.items then
		local items = {}

		self._tableview:reloadData(items)
		goutil.setActive(self._emptyTips, #items == 0)

		local curCriNum = 0

		for _, item in ipairs(items) do
			curCriNum = curCriNum + item.criticalNum
		end

		local extremeStageCfgs = DivineChenClgConfig.instance:getExtremeStageCfgs(self._activityId)
		local curStageCfg = extremeStageCfgs[stageId]
		local isMatch = curCriNum >= curStageCfg.passLimit

		if not isMatch then
			if not GameEnum.ColorConst.Red then
				local showColor = GameEnum.ColorConst.Green

				self._txtTarget.text = string.format("%s (<color=%s>%s</color>/%s)", curStageCfg.targetDesc, showColor, curCriNum, curStageCfg.passLimit)

				local curNum = 0
				local totalNum = 0
				local enemys = BattleModel.instance:getEnemyUnits()

				for k, v in pairs(enemys) do
					if not v.attrs:IsOraclePet() then
						totalNum = totalNum + 1

						if v.attrs:getCurHp() <= 0 then
							curNum = curNum + 1
						end
					end
				end

				local isPass = totalNum <= curNum

				showColor = not isPass and GameEnum.ColorConst.Red or GameEnum.ColorConst.Green
				self._txtPassTarget.text = string.format(" 击败敌阵全部精灵:(<color=%s>%s</color>/%s)", showColor, curNum, totalNum)
				self._titleTxt.text = isWin and "挑战成功" or "挑战失败"
			end
		end
	end
end

function DivineChenClgResultView:_onClickClose()
	if self._isAllPass and ActivityDefineController.instance:isAoqiGodProcessType(self._activityId) then
		AoqiGodController.instance:doHandleChallengeFinishReady(DivineChenClgController.instance:getActivityType(), self._activityId)
		UIStateManager.instance:popByName(ViewName.DivineChenClgMainView)
		UIStateManager.instance:popByName(ViewName.DivineChenClgExtremeView)
	end

	self:close()
	BattleController.instance:endBattle()
end

function DivineChenClgResultView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell.gameObject, "item")
	local txtNum = goutil.findChildTextComponent(cell.gameObject, "num/txt")

	txtNum.text = string.format("超杀：%s", data.criticalNum)

	MaterialMgr.setCellByMo(BagPetsController.instance:getPet(data.petId), item)
end

function DivineChenClgResultView:_clearCell(cell)
	local item = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(item)
end

return DivineChenClgResultView
