-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasurenew/view/TreasurenewView.lua

module("logic.extensions.treasurenew.view.TreasurenewView", package.seeall)

local TreasurenewView = class("TreasurenewView", ViewComponent)

function TreasurenewView:ctor()
	TreasurenewView.super.ctor(self)
end

function TreasurenewView:buildUI()
	TreasurenewView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnStart = self:getBtn("btnStart")
	self._cells = {}

	for i = 1, 8 do
		local cell = {}

		cell.go = self:getGo("rewardGroup/cell" .. i)
		cell.race = cell.go:GetComponent("UIImageSpriteChange")
		cell.icon = goutil.findChild(cell.go, "icon")
		cell.rxtNum = goutil.findChildTextComponent(cell.go, "txtNum")
		cell.eff = goutil.findChild(cell.go, "eff")
		cell.btn = self:getBtn("rewardGroup/cell" .. i)
		self._cells[i] = cell
	end
end

function TreasurenewView:bindEvents()
	TreasurenewView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
	self._btnStart:AddClickListener(self._onClickBtnStart, self)

	for i = 1, 8 do
		self._cells[i].btn:AddClickListener(function()
			self:_onClickCell(i)
		end, self)
	end
end

function TreasurenewView:unbindEvents()
	TreasurenewView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnStart:RemoveClickListener()

	for i = 1, 8 do
		self._cells[i].btn:RemoveClickListener()
	end
end

function TreasurenewView:destroyUI()
	TreasurenewView.super.destroyUI(self)
end

function TreasurenewView:onEnter()
	TreasurenewView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureAutoNext, self._onClickBtnStart, self)

	self._cfgs = TreasureNewModel.instance:getCurTurnTableCfgs()

	if self._cfgs then
		self:_refreshUI()
	else
		self:close()
	end

	local effResPath = "fx_ui_wuwangmibao/fx_ui_wuwangmibao_xuanzhong.prefab"

	self._effSelect = UIEffectManager.instance:playEffect(self, effResPath, nil, 0, 0, true, false, nil, function(target, eff)
		eff.effGo.transform:SetParent(nil)
		GameUtil.SetActive(eff.effGo, false)

		eff.hideEffWhileNotOnTop = false
	end)
	effResPath = "fx_ui_wuwangmibao/fx_ui_wuwangmibao_xuanzhuan.prefab"
	self._effRotate = UIEffectManager.instance:playEffect(self, "fx_ui_wuwangmibao/fx_ui_wuwangmibao_xuanzhuan.prefab", nil, 0, 0, true, false, nil, function(target, eff)
		eff.effGo.transform:SetParent(nil)
		GameUtil.SetActive(eff.effGo, false)

		eff.hideEffWhileNotOnTop = false
	end)
end

function TreasurenewView:onEnterFinished()
	TreasurenewView.super.onEnterFinished(self)
end

function TreasurenewView:onExit()
	TreasurenewView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.TreasureAutoNext, self._onClickBtnStart, self)
	removetimer(self._updateTime, self)

	for i = 1, 8 do
		MaterialMgr.clearIcon(self._cells[i].icon)
		MaterialMgr.resetAll(self._cells[i].icon)
	end

	UIEffectManager.instance:stopEffect(self._effSelect)

	self._effSelect = nil

	UIEffectManager.instance:stopEffect(self._effRotate)

	self._effRotate = nil

	TimeCapsuleController.instance:showCI()
end

function TreasurenewView:onExitFinished()
	TreasurenewView.super.onExitFinished(self)
end

function TreasurenewView:_onClickBtnClose()
	if self._isDrawing then
		FloatWordMgr.instance:show("抽奖中")

		return
	end

	self:close()
end

function TreasurenewView:_onClickBtnStart()
	if self._isDrawing then
		FloatWordMgr.instance:show("抽奖中")

		return
	end

	local function handler()
		local matchId = TreasureNewModel.instance:getMatchIndex()

		self:_startDraw(matchId)
	end

	TreasureNewController.instance:sendPrizeReq(handler, self)
end

function TreasurenewView:_refreshUI()
	self._isDrawing = false

	for i = 1, 8 do
		GameUtil.SetActive(self._cells[i].go, false)
		MaterialMgr.clearIcon(self._cells[i].icon)

		local matStr = self._cfgs[i].prize
		local matCfg = MaterialMgr.getMatCfgByStr(matStr)
		local matInfo = string.split(matStr, ":")
		local matType = checknumber(matInfo[1])
		local cfgId = checknumber(matInfo[2])
		local matNum = checknumber(matInfo[#matInfo])

		MaterialMgr.setIcon(self._cells[i].icon, matType, cfgId)

		self._cells[i].rxtNum.text = matNum

		self._cells[i].race:SetState(matCfg.quality or 0)
		GameUtil.SetActive(self._cells[i].eff, false)
		GameUtil.SetActive(self._cells[i].go, true)
	end
end

function TreasurenewView:_onClickCell(id)
	if not self._cfgs[id] then
		return
	end

	CommonTipsMgr.instance:openTipsByConfStr(self._cells[id].go, self._cfgs[id].prize)
end

function TreasurenewView:_startDraw(matchIndex)
	self._timer = 0
	self._stepTime = 0.1
	self._totalTimer = 40 + (matchIndex + 1)
	self._showIndex = 1
	self._lastShowIndex = 7
	self._isDrawing = true

	removetimer(self._updateTime, self)
	settimer(self._stepTime, self._updateTime, self)
end

function TreasurenewView:_endDraw()
	self._isDrawing = false

	self:close()
end

function TreasurenewView:_updateTime()
	if self._timer >= self._totalTimer then
		removetimer(self._updateTime, self)

		self._showIndex = self._showIndex - 1
		self._showIndex = self._showIndex < 1 and 8 or self._showIndex

		if self._effRotate and self._effRotate.effGo then
			self._effRotate.effGo.transform:SetParent(self._cells[self._showIndex].eff.transform)
			GameUtil.setLocalPos(self._effRotate.effGo.transform, 0, 0, 0)
			GameUtil.setLocalScale(self._effRotate.effGo.transform, 1, 1, 1)
			GameUtil.SetActive(self._effRotate.effGo, true)
		end

		removetimer(self._endDraw, self)
		settimer(1, self._endDraw, self, false)
	else
		GameUtil.SetActive(self._cells[self._showIndex].eff, true)
		GameUtil.SetActive(self._cells[self._lastShowIndex].eff, false)

		if self._effSelect and self._effSelect.effGo then
			self._effSelect.effGo.transform:SetParent(self._cells[self._showIndex].eff.transform)
			GameUtil.setLocalPos(self._effSelect.effGo.transform, 0, 0, 0)
			GameUtil.setLocalScale(self._effSelect.effGo.transform, 1, 1, 1)
			GameUtil.SetActive(self._effSelect.effGo, true)
		end

		self._timer = self._timer + 1
		self._lastShowIndex = self._showIndex
		self._showIndex = self._showIndex + 1
		self._showIndex = self._showIndex > 8 and 1 or self._showIndex
	end
end

return TreasurenewView
