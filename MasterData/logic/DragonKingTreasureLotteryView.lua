-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonkingtreasure/view/DragonKingTreasureLotteryView.lua

module("logic.extensions.dragonkingtreasure.view.DragonKingTreasureLotteryView", package.seeall)

local DragonKingTreasureLotteryView = class("DragonKingTreasureLotteryView", ViewComponent)

function DragonKingTreasureLotteryView:ctor()
	DragonKingTreasureLotteryView.super.ctor(self)
end

function DragonKingTreasureLotteryView:buildUI()
	DragonKingTreasureLotteryView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnStart = self:getBtn("btnStart")
	self._btnPre = self:getGo("btnPre")
	self._btnNext = self:getGo("btnNext")
	self._imgStarChange = goutil.findChildComponent(self.mainGO, "btnStart", "UIImageSpriteChange")
	self._txtShow = self:getTxt("btnStart/txtShow")
	self._txtTitle = self:getTxt("txtTitle")
	self._cells = {}

	for i = 1, 8 do
		local cell = {}

		cell.go = self:getGo("rewardGroup/cell" .. i)
		cell.race = cell.go:GetComponent("UIImageSpriteChange")
		cell.icon = goutil.findChild(cell.go, "icon")
		cell.rxtNum = goutil.findChildTextComponent(cell.go, "txtNum")
		cell.eff = goutil.findChild(cell.go, "eff")
		cell.btn = self:getBtn("rewardGroup/cell" .. i)
		cell.gain = goutil.findChild(cell.go, "gain")
		self._cells[i] = cell
	end

	self._txtTips = self:getTxt("txtTips")
end

function DragonKingTreasureLotteryView:bindEvents()
	DragonKingTreasureLotteryView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
	self._btnStart:AddClickListener(self._onClickBtnStart, self)
	GameUtil.addClickHandler(self._btnPre, self._onClickPre, self)
	GameUtil.addClickHandler(self._btnNext, self._onClickNext, self)

	for i = 1, 8 do
		self._cells[i].btn:AddClickListener(function()
			self:_onClickCell(i)
		end, self)
	end
end

function DragonKingTreasureLotteryView:unbindEvents()
	DragonKingTreasureLotteryView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnPre)
	GameUtil.rmClickHandler(self._btnNext)

	for i = 1, 8 do
		self._cells[i].btn:RemoveClickListener()
	end
end

function DragonKingTreasureLotteryView:destroyUI()
	DragonKingTreasureLotteryView.super.destroyUI(self)
end

function DragonKingTreasureLotteryView:onEnter()
	DragonKingTreasureLotteryView.super.onEnter(self)

	JackpotModel.instance.isDrawing = false
	self.actId = JackpotModel.instance:getCurrActId()

	if self.actId then
		JackpotController.instance:registerLocalNotify(JackpotModel.UpdateDrawInfos, self._onGetUpdateDrawInfos, self)
		JackpotController.instance:registerLocalNotify(JackpotModel.DrawSuccessed, self._startDraw, self)
		JackpotAgent.instance:sendGetJackpotDrawInfoReq(self.actId)

		self._actCfg = JackpotConfig.instance:getActCfgById(self.actId)
		self._poolCfg = JackpotConfig.instance:getPoolCfg(self._actCfg.jackpot)
		self._maxOrder = JackpotConfig.instance:getMaxOrder(self.actId)
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
	self._isShow = self:getFirstParam()

	GameUtil.SetActive(self._txtShow, self._isShow)

	if self._isShow == true then
		self._imgStarChange:SetState(1)
	else
		self._imgStarChange:SetState(0)
	end

	if self._isShow == true then
		self._txtTitle.text = lang("奖励预览")

		GameUtil.SetActive(self._btnPre, true)
		GameUtil.SetActive(self._btnNext, true)
	else
		self._txtTitle.text = lang("龙王秘宝")

		GameUtil.SetActive(self._btnPre, false)
		GameUtil.SetActive(self._btnNext, false)
	end
end

function DragonKingTreasureLotteryView:onEnterFinished()
	DragonKingTreasureLotteryView.super.onEnterFinished(self)
end

function DragonKingTreasureLotteryView:onExit()
	DragonKingTreasureLotteryView.super.onExit(self)
	removetimer(self._updateTime, self)

	for i = 1, 8 do
		MaterialMgr.clearIcon(self._cells[i].icon)
		MaterialMgr.resetAll(self._cells[i].icon)
	end

	JackpotController.instance:unregisterLocalNotify(JackpotModel.UpdateDrawInfos, self._onGetUpdateDrawInfos, self)
	JackpotController.instance:unregisterLocalNotify(JackpotModel.DrawSuccessed, self._startDraw, self)
	UIEffectManager.instance:stopEffect(self._effSelect)

	self._effSelect = nil

	UIEffectManager.instance:stopEffect(self._effRotate)

	self._effRotate = nil

	TimeCapsuleController.instance:showCI()
end

function DragonKingTreasureLotteryView:onExitFinished()
	DragonKingTreasureLotteryView.super.onExitFinished(self)
end

function DragonKingTreasureLotteryView:_onClickBtnClose()
	if self._isDrawing then
		FloatWordMgr.instance:show("抽奖中")

		return
	end

	self:close()
end

function DragonKingTreasureLotteryView:_onClickBtnStart()
	if self._isShow == true then
		FloatWordMgr.instance:show("浏览中")

		return
	end

	if self._isDrawing then
		FloatWordMgr.instance:show("抽奖中")

		return
	end

	JackpotController.instance:sendJackpotDrawReq(self.actId, true)
end

function DragonKingTreasureLotteryView:_refreshUI()
	self._indexList = {}

	local rewardTypeToBg = {
		4,
		3,
		2
	}

	self._selectOrderId = self._selectOrderId or 1
	self._cfgs = self._poolCfg[self._selectOrderId]
	self._isDrawing = false

	for i = 1, 8 do
		GameUtil.SetActive(self._cells[i].go, false)
		MaterialMgr.clearIcon(self._cells[i].icon)

		local matStr = self._cfgs[i].reward
		local matCfg = MaterialMgr.getMatCfgByStr(matStr)
		local matInfo = string.split(matStr, ":")
		local matType = checknumber(matInfo[1])
		local cfgId = checknumber(matInfo[2])
		local matNum = checknumber(matInfo[#matInfo])

		MaterialMgr.setIcon(self._cells[i].icon, matType, cfgId)

		self._cells[i].rxtNum.text = matNum

		self._cells[i].race:SetState(rewardTypeToBg[self._cfgs[i].type] or 0)
		GameUtil.SetActive(self._cells[i].eff, false)
		GameUtil.SetActive(self._cells[i].go, true)
		GameUtil.SetActive(self._cells[i].gain, (false or nil) and true)

		if self._isShow or not self._drawInfo.datas[i] then
			table.insert(self._indexList, i)
		end
	end

	self._txtTips.text = langPara("当前第%d轮，共%d轮，达到最后一轮时将无限循环此奖池", math.min(self._drawInfo.orderId, self._maxOrder), self._maxOrder)
	self._txtShow.text = self._selectOrderId == self._drawInfo.orderId and langPara("预览界面\n第%d轮(当前)", self._selectOrderId) or langPara("预览界面\n第%d轮", self._selectOrderId)
end

function DragonKingTreasureLotteryView:_onClickCell(id)
	if not self._cfgs[id] then
		return
	end

	CommonTipsMgr.instance:openTipsByConfStr(self._cells[id].go, self._cfgs[id].reward)
end

function DragonKingTreasureLotteryView:_startDraw(matchIndex)
	self._matchIndex = matchIndex
	self._timer = 0
	self._stepTime = 0.1

	local step = 0

	for i, v in ipairs(self._indexList) do
		if v <= matchIndex then
			step = step + 1
		end
	end

	self._totalTimer = #self._indexList * 5 + step
	self._showIndex = 1
	self._lastShowIndex = #self._indexList
	self._isDrawing = true

	removetimer(self._updateTime, self)
	settimer(self._stepTime, self._updateTime, self)
end

function DragonKingTreasureLotteryView:_endDraw()
	self._isDrawing = false

	JackpotModel.instance:drwaAnimEnd(self._matchIndex)

	self._matchIndex = nil

	self:close()
end

function DragonKingTreasureLotteryView:_updateTime()
	if self._timer >= self._totalTimer then
		removetimer(self._updateTime, self)

		self._showIndex = self._showIndex - 1

		if self._showIndex < 1 then
			self._showIndex = #self._indexList or self._showIndex
		end

		if self._effRotate and self._effRotate.effGo then
			self._effRotate.effGo.transform:SetParent(self._cells[self._indexList[self._showIndex]].eff.transform)
			GameUtil.setLocalPos(self._effRotate.effGo.transform, 0, 0, 0)
			GameUtil.setLocalScale(self._effRotate.effGo.transform, 1, 1, 1)
			GameUtil.SetActive(self._effRotate.effGo, true)
		end

		removetimer(self._endDraw, self)
		settimer(1, self._endDraw, self, false)
	else
		GameUtil.SetActive(self._cells[self._indexList[self._showIndex]].eff, true)
		GameUtil.SetActive(self._cells[self._indexList[self._lastShowIndex]].eff, false)

		if self._effSelect and self._effSelect.effGo then
			self._effSelect.effGo.transform:SetParent(self._cells[self._indexList[self._showIndex]].eff.transform)
			GameUtil.setLocalPos(self._effSelect.effGo.transform, 0, 0, 0)
			GameUtil.setLocalScale(self._effSelect.effGo.transform, 1, 1, 1)
			GameUtil.SetActive(self._effSelect.effGo, true)
		end

		self._timer = self._timer + 1
		self._lastShowIndex = self._showIndex
		self._showIndex = self._showIndex + 1
		self._showIndex = self._showIndex > #self._indexList and 1 or self._showIndex
	end
end

function DragonKingTreasureLotteryView:_onClickPre()
	self._selectOrderId = math.max(1, self._selectOrderId - 1)

	self:_refreshUI()
end

function DragonKingTreasureLotteryView:_onClickNext()
	self._selectOrderId = math.min(self._selectOrderId + 1, self._maxOrder)

	self:_refreshUI()
end

function DragonKingTreasureLotteryView:_onGetUpdateDrawInfos()
	self._drawInfo = JackpotModel.instance:getDrawInfo()
	self._selectOrderId = self._drawInfo.orderId

	self:_refreshUI()
end

return DragonKingTreasureLotteryView
