-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/disorderpower/view/DisOrderPowerLotteryView.lua

module("logic.extensions.disorderpower.view.DisOrderPowerLotteryView", package.seeall)

local DisOrderPowerLotteryView = class("DisOrderPowerLotteryView", ViewComponent)

function DisOrderPowerLotteryView:ctor()
	DisOrderPowerLotteryView.super.ctor(self)
end

function DisOrderPowerLotteryView:buildUI()
	DisOrderPowerLotteryView.super.buildUI(self)

	self._cells = {}
	self._rewardGroupTr = self:getGo("rewardGroup").transform
	self._cellGo = self:getGo("rewardGroup/cell")

	goutil.setActive(self._cellGo, false)
end

function DisOrderPowerLotteryView:bindEvents()
	DisOrderPowerLotteryView.super.bindEvents(self)
end

function DisOrderPowerLotteryView:unbindEvents()
	DisOrderPowerLotteryView.super.unbindEvents(self)
end

function DisOrderPowerLotteryView:onEnter()
	DisOrderPowerLotteryView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._cfgs = DisOrderPowerConfig.instance:getCardCfg(self._activityId)
	self._model = DisOrderPowerModel.instance:GetModel(self._activityId)
	self._cardId = self._model.curCardId

	self:_refreshUI()
	self:_startDraw(self._cardId)
end

function DisOrderPowerLotteryView:onExit()
	DisOrderPowerLotteryView.super.onExit(self)
	removetimer(self._updateTime, self)

	for i, v in ipairs(self._cells) do
		MaterialMgr.clearIcon(self._cells[i].icon)
		MaterialMgr.resetAll(self._cells[i].icon)
	end
end

function DisOrderPowerLotteryView:_onSetUI()
	return
end

function DisOrderPowerLotteryView:_onUpdate()
	return
end

function DisOrderPowerLotteryView:_onRecieveLottery()
	local cardId = self._model.curCardId

	DisOrderPowerController.instance:enterBattleClg(self._activityId, cardId)
end

function DisOrderPowerLotteryView:_refreshUI()
	local columns = 4
	local row_spacing = 140
	local column_spacing = 120

	self._isDrawing = false

	for i = 1, #self._cfgs do
		local cell = self._cells[i]

		if not cell then
			local go = goutil.cloneAndSetParent(self._cellGo, self._rewardGroupTr, "cell_" .. i)

			cell = {
				go = go,
				icon = goutil.findChild(go, "icon"),
				bgItem = goutil.findChild(go, "bgItem"),
				selectGo = goutil.findChild(go, "select"),
				txtLeft = goutil.findChildTextComponent(go, "txtLeft"),
				txtNum = goutil.findChildTextComponent(go, "txtNum"),
				receiveGo = goutil.findChild(go, "receive"),
				btn = Framework.ButtonAdapter.GetFrom(go, "icon"),
				bgRecieve = goutil.findChild(go, "bgRecieve")
			}
			self._cells[i] = cell

			GameUtil.SetActive(self._cells[i].selectGo, false)
		end

		local row = math.floor(i / columns)
		local x, y = GameUtil.getPosWihtRowAndCol(row_spacing, column_spacing, i, 3, columns)

		Framework.TransformUtil.SetLocalPos(self._cells[i].go.transform, x, -y, 0)
		MaterialMgr.clearIcon(self._cells[i].icon)

		local cfg = self._cfgs[i]
		local skinId = cfg.skinId
		local hasGet = table.indexof(self._model.finishCardIds, i) ~= false
		local compIcon = self._cells[i].icon:GetComponent("Image")
		local compBg = self._cells[i].bgRecieve:GetComponent("Image")

		MaterialMgr.setIcon(cell.icon, MatType.PET_SKIN, skinId)

		self._cells[i].txtLeft.text = i

		GameUtil.SetActive(self._cells[i].go, true)
		GameUtil.SetActive(self._cells[i].receiveGo, hasGet)
		GameUtil.SetActive(self._cells[i].bgRecieve, hasGet)

		if hasGet then
			Framework.ColorUtil.SetImageColor(compIcon, "#787878FF")
			Framework.ColorUtil.SetImageColor(compBg, "#787878FF")
		else
			Framework.ColorUtil.SetImageColor(compIcon, "#FFFFFFFF")
			Framework.ColorUtil.SetImageColor(compBg, "#FFFFFFFF")
		end
	end
end

function DisOrderPowerLotteryView:_startDraw(curChallengeCardId)
	self._rewardAnimCells = {}
	self._hitPrizeIndex = 0

	for i = 1, #self._cfgs do
		local cfg = self._cfgs[i]

		if not table.indexof(self._model.finishCardIds, i) ~= false then
			table.insert(self._rewardAnimCells, self._cells[i])

			if cfg.cardId == curChallengeCardId then
				self._hitPrizeIndex = #self._rewardAnimCells
			end
		end
	end

	self._rewardNum = #self._rewardAnimCells

	if self._rewardNum == 1 then
		GameUtil.SetActive(self._rewardAnimCells[1].selectGo, true)
		removetimer(self._endDraw, self)
		settimer(0.5, self._endDraw, self, false)

		return
	end

	self._timer = 0
	self._stepTime = 0.1
	self._totalTimer = self._rewardNum * 5 + (curChallengeCardId + 1)
	self._showIndex = 1
	self._lastShowIndex = self._rewardNum - 1
	self._isDrawing = true
	self._needEndDraw = false

	removetimer(self._updateTime, self)
	settimer(self._stepTime, self._updateTime, self)
end

function DisOrderPowerLotteryView:_endDraw()
	self._isDrawing = false

	DisOrderPowerController.instance:enterBattleClg(self._activityId, self._cardId)
	self:close()
end

function DisOrderPowerLotteryView:_updateTime()
	if self._timer >= self._totalTimer and self._needEndDraw then
		removetimer(self._updateTime, self)

		self._showIndex = self._showIndex - 1

		if self._showIndex < 1 then
			self._showIndex = self._rewardNum or self._showIndex
		end

		removetimer(self._endDraw, self)
		settimer(1, self._endDraw, self, false)
	else
		GameUtil.SetActive(self._rewardAnimCells[self._showIndex].selectGo, true)
		GameUtil.SetActive(self._rewardAnimCells[self._lastShowIndex].selectGo, false)

		self._timer = self._timer + 3
		self._lastShowIndex = self._showIndex

		if self._timer >= self._totalTimer and (self._hitPrizeIndex <= 0 or self._showIndex == self._hitPrizeIndex) then
			self._needEndDraw = true

			return
		end

		self._showIndex = self._showIndex + 1
		self._showIndex = self._showIndex > self._rewardNum and 1 or self._showIndex
	end
end

return DisOrderPowerLotteryView
