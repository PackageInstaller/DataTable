-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclefindtreasure/view/MiraclefindtreasureView.lua

module("logic.extensions.miraclefindtreasure.view.MiraclefindtreasureView", package.seeall)

local MiraclefindtreasureView = class("MiraclefindtreasureView", ViewComponent)

function MiraclefindtreasureView:buildUI()
	MiraclefindtreasureView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnStart = self:getBtn("btnStart")
	self._cells = {}
	self._rewardGroupTr = self:getGo("rewardGroup").transform
	self._cellGo = self:getGo("rewardGroup/cell")

	goutil.setActive(self._cellGo, false)
end

function MiraclefindtreasureView:bindEvents()
	MiraclefindtreasureView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
	self._btnStart:AddClickListener(self._onClickBtnStart, self)
end

function MiraclefindtreasureView:unbindEvents()
	MiraclefindtreasureView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnStart:RemoveClickListener()
end

function MiraclefindtreasureView:onEnter()
	MiraclefindtreasureView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.MiracleFindTreasureAutoNext, self._onClickBtnStart, self)
	self.addGEvent(self, GlobalNotify.MiracleFindTreasureLotteryRes, self._startDraw, self)
	self.addGEvent(self, GlobalNotify.MiracleFindTreasureGetInfoRes, self._refreshUI, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._hideBtn = params[2]

	goutil.setActive(self._btnStart.gameObject, not self._hideBtn)

	self._cfgs = MiraclefindtreasureConfig.instance:getPrizeCfgs(self._activityId)

	if self._cfgs then
		self:_refreshUI()
	else
		self:close()

		return
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

	MiracleFindTreasureAgent.instance:sendPM_MiracleFindTreasureGetInfoReq(self._activityId)
end

function MiraclefindtreasureView:onExit()
	MiraclefindtreasureView.super.onExit(self)
	removetimer(self._updateTime, self)

	for i, v in ipairs(self._cells) do
		MaterialMgr.clearIcon(self._cells[i].icon)
		MaterialMgr.resetAll(self._cells[i].icon)
	end

	UIEffectManager.instance:stopEffect(self._effSelect)

	self._effSelect = nil

	UIEffectManager.instance:stopEffect(self._effRotate)

	self._effRotate = nil
end

function MiraclefindtreasureView:_onClickBtnClose()
	if self._isDrawing then
		FloatWordMgr.instance:show("抽奖中")

		return
	end

	self:close()
end

function MiraclefindtreasureView:_onClickBtnStart()
	if self._isDrawing then
		FloatWordMgr.instance:show("抽奖中")

		return
	end

	local state = MiraclefindtreasureModel.instance:getState(self._activityId)

	if state ~= 2 then
		FloatWordMgr.instance:show("抽奖已结束")

		return
	end

	MiracleFindTreasureAgent.instance:sendPM_MiracleFindTreasureLotteryReq(self._activityId)
end

function MiraclefindtreasureView:_refreshUI()
	local columns = 4
	local row_spacing = 140
	local column_spacing = 105

	self._prizeId2GainCount = {}

	local info = MiraclefindtreasureModel.instance:getInfo(self._activityId)

	for i, v in ipairs(info.prizeInfoList) do
		self._prizeId2GainCount[v.prizeId] = v.gainCount
	end

	self._isDrawing = false

	for i = 1, #self._cfgs do
		local cell = self._cells[i]

		if not cell then
			local go = goutil.cloneAndSetParent(self._cellGo, self._rewardGroupTr, "cell_" .. i)

			cell = {
				go = go,
				icon = goutil.findChild(go, "icon"),
				selectGo = goutil.findChild(go, "select"),
				txtLeft = goutil.findChildTextComponent(go, "txtLeft"),
				txtNum = goutil.findChildTextComponent(go, "txtNum"),
				receiveGo = goutil.findChild(go, "receive"),
				btn = Framework.ButtonAdapter.GetFrom(go, "icon")
			}
			self._cells[i] = cell
		end

		local row = math.floor(i / columns)
		local x, y = GameUtil.getPosWihtRowAndCol(row_spacing, column_spacing, i, 3, columns)

		Framework.TransformUtil.SetLocalPos(self._cells[i].go.transform, x, -y, 0)
		MaterialMgr.clearIcon(self._cells[i].icon)

		local cfg = self._cfgs[i]
		local matStr = cfg.prize
		local matCfg = MaterialMgr.getMatCfgByStr(matStr)
		local matInfo = string.split(matStr, ":")
		local matType = checknumber(matInfo[1])
		local cfgId = checknumber(matInfo[2])
		local matNum = checknumber(matInfo[#matInfo])
		local timeLimit = cfg.timeLimit

		MaterialMgr.setIcon(cell.icon, matType, cfgId)

		if not self._prizeId2GainCount[cfg.prizeId] then
			local gainCount = 0

			cell.txtNum.text = matNum
			cell.txtLeft.text = string.format("剩余：%s/%s", timeLimit - gainCount, timeLimit)

			GameUtil.SetActive(cell.go, true)
			GameUtil.SetActive(cell.selectGo, false)
			goutil.setActive(cell.receiveGo, timeLimit <= gainCount)
			cell.btn:AddClickListener(function()
				if timeLimit - gainCount > 0 then
					CommonTipsMgr.instance:openMaterialTips(cell.btn.gameObject, matType, cfgId)
				end
			end)
		end
	end
end

function MiraclefindtreasureView:_onClickCell(id)
	if not self._cfgs[id] then
		return
	end

	CommonTipsMgr.instance:openTipsByConfStr(self._cells[id].go, self._cfgs[id].prize)
end

function MiraclefindtreasureView:_startDraw(prizeId)
	self._rewardAnimCells = {}
	self._hitPrizeIndex = 0

	for i = 1, #self._cfgs do
		local cfg = self._cfgs[i]

		if not self._prizeId2GainCount[cfg.prizeId] then
			if self._prizeId2GainCount[cfg.prizeId] < cfg.timeLimit then
				table.insert(self._rewardAnimCells, self._cells[i])

				if cfg.prizeId == prizeId then
					self._hitPrizeIndex = #self._rewardAnimCells
				end
			end
		end
	end

	self._rewardNum = #self._rewardAnimCells

	if self._rewardNum == 1 then
		GameUtil.SetActive(self._rewardAnimCells[1].selectGo, true)
		removetimer(self._endDraw, self)
		settimer(1, self._endDraw, self, false)

		return
	end

	self._timer = 0
	self._stepTime = 0.1
	self._totalTimer = self._rewardNum * 5 + (prizeId + 1)
	self._showIndex = 1
	self._lastShowIndex = self._rewardNum - 1
	self._isDrawing = true
	self._needEndDraw = false

	removetimer(self._updateTime, self)
	settimer(self._stepTime, self._updateTime, self)
end

function MiraclefindtreasureView:_endDraw()
	self._isDrawing = false

	MiraclefindtreasureController.instance:showCI()
	self:close()
end

function MiraclefindtreasureView:_updateTime()
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

		self._timer = self._timer + 1
		self._lastShowIndex = self._showIndex

		if self._timer >= self._totalTimer and (self._hitPrizeIndex <= 0 or self._showIndex == self._hitPrizeIndex) then
			self._needEndDraw = true

			return
		end

		self._showIndex = self._showIndex + 1
		self._showIndex = self._showIndex > self._rewardNum and 1 or self._showIndex
	end
end

return MiraclefindtreasureView
