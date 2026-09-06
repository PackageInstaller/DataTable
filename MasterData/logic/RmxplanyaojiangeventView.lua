-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanyaojiangeventView.lua

module("logic.extensions.richmanxplan.view.RmxplanyaojiangeventView", package.seeall)

local RmxplanyaojiangeventView = class("RmxplanyaojiangeventView", ViewComponent)

RmxplanyaojiangeventView.TxtItemSpace = 105

function RmxplanyaojiangeventView:ctor()
	RmxplanyaojiangeventView.super.ctor(self)
end

function RmxplanyaojiangeventView:unbindEvents()
	RmxplanyaojiangeventView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
	self._btnReduce:RemoveClickListener()
	self._btnBlockClick:RemoveClickListener()
end

function RmxplanyaojiangeventView:bindEvents()
	RmxplanyaojiangeventView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnStart:AddClickListener(self._onClickbtnStart, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnAdd:AddClickListener(self._onClickbtnAdd, self)
	self._btnReduce:AddClickListener(self._onClickbtnReduce, self)
	self._btnBlockClick:AddClickListener(self._onClickblockClick, self)
end

function RmxplanyaojiangeventView:buildUI()
	RmxplanyaojiangeventView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnStart = self:getBtn("btnStart")
	self._btnTip = self:getBtn("btnTip")
	self._btnAdd = self:getBtn("btnAdd")
	self._btnReduce = self:getBtn("btnReduce")
	self._txtMul = self:getTxt("txts/txtMul")
	self._txtCost = self:getTxt("txts/txtCost")
	self._gridGo = self:getGo("grid")
	self._gridsGo = self:getGo("grids")
	self._txtMat = self:getTxt("matCell/txtMat")
	self._layout = self._gridsGo:GetComponent(ComponentType.UILayoutSingleLine)
	self._blockClickGo = self:getGo("blockClick")
	self._btnBlockClick = self:getBtn("blockClick")

	goutil.setActive(self._gridGo, false)

	self._grisItems = {}

	for i = 1, 6 do
		local go = goutil.cloneAndSetParent(self._gridGo, self._gridsGo.transform)
		local goTxtNum = goutil.findChild(go, "txtNum")
		local maskTr = goutil.findChild(go, "mask").transform
		local txtItems = {}

		goutil.setActive(go, true)
		goutil.setActive(goTxtNum, false)

		for j = 1, 5 do
			local txtGo = goutil.cloneAndSetParent(goTxtNum, maskTr)

			goutil.setActive(txtGo, true)
			table.insert(txtItems, {
				posY = 0,
				txtNum = txtGo:GetComponent(ComponentType.UIImgNumeralText),
				transform = txtGo.transform
			})
		end

		self._grisItems[i] = {
			txtItems = txtItems
		}
	end

	self._layout:Layout()
end

function RmxplanyaojiangeventView:onExit()
	RmxplanyaojiangeventView.super.onExit(self)
	removetimer(self._updateItems, self)

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end

	if self._endEffectHandler then
		UIEffectManager.instance:stopEffect(self._endEffectHandler)

		self._endEffectHandler = nil
	end
end

function RmxplanyaojiangeventView:onEnter()
	RmxplanyaojiangeventView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.RichManXPlanEventRes, self._onRichManXPlanEventRes, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._event = params[2]
	self._score = RichmanxplanModel.instance:getScore(self._activityId)
	self._eventCfg = RichmanxplanConfig.instance:getDrawEventCfg(self._activityId, self._event.eventId)
	self._multipleLimit = self._eventCfg.multipleLimit
	self._curMultiple = 1
	self._isPlaying = false
	self._finish = false

	self:_initTxts()
	self:_updateUI()
	self:_blockClick(false)
	self:_setEffect()
end

function RmxplanyaojiangeventView:_updateUI()
	self:_updateCost()
	self:_updateMat()
end

function RmxplanyaojiangeventView:_onClickbtnClose()
	if self._isPlaying then
		return
	end

	RichManXPlanAgent.instance:sendPM_RichManXPlanEventReq(self._activityId, true)
end

function RmxplanyaojiangeventView:_onClickbtnStart()
	if self._isPlaying then
		return
	end

	if self._score < self._curMultiple * self._eventCfg.cost then
		FloatWordMgr.instance:show("货币不足")

		return
	end

	local t = {
		multiple = self._curMultiple
	}

	RichManXPlanAgent.instance:sendPM_RichManXPlanEventReq(self._activityId, false, GameUtil.jsonToString(t))
end

function RmxplanyaojiangeventView:_onClickbtnTip()
	local ruleKey = RichmanxplanConfig.instance:getRuleKey(self._activityId, "yaojiangRule")

	TipsFacade.instance:openRulesView(ruleKey)
end

function RmxplanyaojiangeventView:_onClickbtnAdd()
	if self._isPlaying or self._finish then
		return
	end

	self._curMultiple = self._curMultiple + 1
	self._curMultiple = math.min(self._multipleLimit, self._curMultiple)

	self:_updateCost()
end

function RmxplanyaojiangeventView:_onClickbtnReduce()
	if self._isPlaying or self._finish then
		return
	end

	self._curMultiple = self._curMultiple - 1
	self._curMultiple = math.max(1, self._curMultiple)

	self:_updateCost()
end

function RmxplanyaojiangeventView:_updateCost()
	self._txtMul.text = self._curMultiple
	self._txtCost.text = self._curMultiple * self._eventCfg.cost
end

function RmxplanyaojiangeventView:_onRichManXPlanEventRes(msg)
	self._gainPrizeNum = 0

	if msg.isEnd then
		self._finish = true
		self._score = self._score - self._curMultiple * self._eventCfg.cost

		self:_updateCost()

		local params = GameUtil.jsonToTable(msg.resultParam)

		if params.prizeNumber then
			self._gainPrizeNum = params.prizeNumber

			local str = tostring(params.prizeNumber)
			local numArray = {}

			for i = 1, #str do
				local num = tonumber(string.sub(str, i, i))

				table.insert(numArray, num)
			end

			self._valueList = numArray

			self:_playAnims()
		else
			self:close()
		end
	end
end

function RmxplanyaojiangeventView:_playAnims()
	self:_blockClick(true)

	self._isPlaying = true
	self._animCount = #self._valueList
	self._finishAnimCount = 0
	self._moveDatas = {}

	settimer(0, self._updateItems, self, true)

	for i, v in ipairs(self._valueList) do
		self:_playAnim(i, v)
	end
end

function RmxplanyaojiangeventView:_playAnim(index, value)
	local item = self._grisItems[index]

	if item then
		local speed = math.random(50, 70)
		local data = {
			needStopSpeed = 5,
			isFinish = false,
			runTime = 0,
			needSlowTime = 3,
			slowTime = 3,
			speed = speed,
			curSpeed = speed,
			lastNum = item.lastNum,
			txtItems = item.txtItems,
			value = value
		}

		table.insert(self._moveDatas, data)
	else
		self:_finishAnim()
	end
end

function RmxplanyaojiangeventView:_finishAnim()
	self._finishAnimCount = self._finishAnimCount + 1

	if self._finishAnimCount >= self._animCount then
		self:_playFinishEffect()
		removetimer(self._updateItems, self)
	end
end

function RmxplanyaojiangeventView:_initTxts()
	for i, item in ipairs(self._grisItems) do
		local midIdx = math.ceil(#item.txtItems / 2)
		local lastNum = 0

		for j, v in ipairs(item.txtItems) do
			local y = -(j - midIdx) * RmxplanyaojiangeventView.TxtItemSpace
			local num = (9 + (j - midIdx)) % 9

			if num == 0 then
				num = 9
			end

			v.txtNum:SetNum(num)

			v.curNum = num
			v.posY = y
			lastNum = num

			Framework.TransformUtil.SetAnchoredPos(v.transform, 0, y)
		end

		item.lastNum = lastNum
	end
end

function RmxplanyaojiangeventView:_updateItems()
	local detal = Time.deltaTime

	for _, data in ipairs(self._moveDatas) do
		if not data.isFinish then
			data.runTime = data.runTime + detal

			for _, v in ipairs(data.txtItems) do
				v.posY = data.curSpeed * 1 + v.posY

				Framework.TransformUtil.SetAnchoredPos(v.transform, 0, v.posY)

				if data.curSpeed <= data.needStopSpeed and v.curNum == data.value and math.abs(v.posY) <= 5 then
					data.curSpeed = 0
					data.isFinish = true

					self:_finishAnim()

					return
				end

				if v.posY > 145 then
					data.lastNum = data.lastNum + 1

					if data.lastNum > 9 then
						data.lastNum = 0
					end

					v.curNum = data.lastNum

					v.txtNum:SetNum(data.lastNum)

					local minPosy = 9999

					for _, d in ipairs(data.txtItems) do
						if minPosy > d.posY then
							minPosy = d.posY
						end
					end

					v.posY = minPosy - RmxplanyaojiangeventView.TxtItemSpace
				end
			end

			if data.curSpeed > data.needStopSpeed and data.runTime >= data.needSlowTime then
				data.curSpeed = data.speed - data.speed * (data.runTime - data.slowTime)
			end
		end
	end
end

function RmxplanyaojiangeventView:_updateMat()
	self._txtMat.text = self._score
end

function RmxplanyaojiangeventView:_playFinishEffect()
	local effName = "20240531/dafuweng/fx_ui_chaopiao2_dfw.prefab"

	self._endEffectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, false, nil, function()
		self._score = self._score + self._gainPrizeNum

		self:_updateMat()
		self:_onEffectEnd()
	end)

	self._endEffectHandler:setEffTime(1.2)
	self._endEffectHandler:setParent(self.mainGO.transform)
	self._endEffectHandler:setScale(1)
	self._endEffectHandler:setLocalPos(0, 0, 0)
end

function RmxplanyaojiangeventView:_onEffectEnd()
	if self._gainPrizeNum > 0 then
		local rateValue = RichmanxplanModel.instance:getBuffRate(self._activityId)
		local totalGain = math.ceil(self._gainPrizeNum * self._curMultiple * (1 + rateValue))
		local content = string.format("恭喜本次摇奖格获得资金x%s", totalGain)

		TipsFacade.instance:openTipWindowNoX("提示", content, function()
			self:_blockClick(false)
			self:close()
		end)
	else
		self:_blockClick(false)
		self:close()
	end
end

function RmxplanyaojiangeventView:_blockClick(isNeedBlock)
	goutil.setActive(self._blockClickGo, isNeedBlock)
end

function RmxplanyaojiangeventView:_onClickblockClick()
	FloatWordMgr.instance:show("正在摇奖中")
end

function RmxplanyaojiangeventView:_setEffect()
	local effName = "20240531/dafuweng/fx_ui_tongyongfenwei_dfw.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self.mainGO.transform)
	self._effectHandler:setScale(1)
	self._effectHandler:setLocalPos(0, 0, 0)
end

return RmxplanyaojiangeventView
