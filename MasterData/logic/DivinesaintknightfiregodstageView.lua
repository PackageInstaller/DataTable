-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/DivineSaintKnightFireGod/view/DivinesaintknightfiregodstageView.lua

module("logic.extensions.DivineSaintKnightFireGod.view.DivinesaintknightfiregodstageView", package.seeall)

local DivinesaintknightfiregodstageView = class("DivinesaintknightfiregodstageView", ViewComponent)

function DivinesaintknightfiregodstageView:ctor()
	DivinesaintknightfiregodstageView.super.ctor(self)
end

function DivinesaintknightfiregodstageView:unbindEvents()
	DivinesaintknightfiregodstageView.super.unbindEvents(self)
	self._btnClg:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnPos1:RemoveClickListener()
	self._btnPos2:RemoveClickListener()
	self._btnPos3:RemoveClickListener()
end

function DivinesaintknightfiregodstageView:bindEvents()
	DivinesaintknightfiregodstageView.super.bindEvents(self)
	self._btnClg:AddClickListener(self._onClickbtnClg, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnReset:AddClickListener(self._onClickbtnReset, self)
	self._btnPos1:AddClickListener(self._onClickbtnPos1, self)
	self._btnPos2:AddClickListener(self._onClickbtnPos2, self)
	self._btnPos3:AddClickListener(self._onClickbtnPos3, self)
end

function DivinesaintknightfiregodstageView:buildUI()
	DivinesaintknightfiregodstageView.super.buildUI(self)

	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnClg = self:getBtn("btnClg")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnReset = self:getBtn("btnReset")
	self._txtFirstPit = self:getGo("equation/firstPit"):GetComponent(ComponentType.UIImgNumeralText)
	self._txtPos1 = self:getTxt("equation/btnPos1/txt")
	self._txtPos2 = self:getTxt("equation/btnPos2/txt")
	self._txtPos3 = self:getTxt("equation/btnPos3/txt")
	self._txtFirstSign = self:getTxt("equation/firstSign")
	self._txtSecondPit = self:getGo("equation/secondPit"):GetComponent(ComponentType.UIImgNumeralText)
	self._txtThirdPit = self:getGo("equation/thirdPit"):GetComponent(ComponentType.UIImgNumeralText)
	self._txtSecondSign = self:getTxt("equation/secondSign")
	self._txtEquation = self:getGo("equation/equation"):GetComponent(ComponentType.UIImgNumeralText)
	self._btnPos1 = self:getBtn("equation/btnPos1")
	self._btnPos2 = self:getBtn("equation/btnPos2")
	self._btnPos3 = self:getBtn("equation/btnPos3")
	self._txtPosList = {
		self._txtPos1,
		self._txtPos2,
		self._txtPos3
	}
	self._itemGo = self:getGo("rule/item")
	self._txtDesc = self:getTxt("rule/txtDesc")
	self._formationGo = self:getGo("formation")
	self._txtDesc3 = self:getTxt("equation/txtDesc3")
	self._txtDesc2 = self:getTxt("equation/txtDesc2")
	self._txtDesc1 = self:getTxt("equation/txtDesc1")
	self._txtDescList = {
		self._txtDesc1,
		self._txtDesc2,
		self._txtDesc3
	}
	self._firstSymbol = self:getGo("equation/firstSymbol"):GetComponent(ComponentType.UIImageSpriteChange)
	self._thirdSymbol = self:getGo("equation/thirdSymbol"):GetComponent(ComponentType.UIImageSpriteChange)
	self._secondSymbol = self:getGo("equation/secondSymbol"):GetComponent(ComponentType.UIImageSpriteChange)
	self._txtScoreBubble = self:getTxt("bubble/txt")
	self._bubbleGo = self:getGo("bubble")
	self._contentGo = self:getGo("tableview/viewport/content")
	self._lineGo = self:getGo("lineGo")
	self._failedLineGo = self:getGo("equation/failedLine")

	goutil.setActive(self._lineGo, false)
	goutil.setActive(self._failedLineGo, false)
	goutil.setActive(self._bubbleGo, false)
end

function DivinesaintknightfiregodstageView:onExit()
	DivinesaintknightfiregodstageView.super.onExit(self)
	self._scrollerList:dispose()
	removetimer(self._tickTime, self)

	for posId = 1, 9 do
		local go = goutil.findChild(self._formationGo, "cell_" .. posId)
		local icon = goutil.findChild(go, "con")

		MaterialMgr.resetAll(icon)
	end
end

function DivinesaintknightfiregodstageView:onEnter()
	DivinesaintknightfiregodstageView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._actCfg = DivineSaintKnightFireGodConfig.instance:getActCfg(self._activityId)

	self:_createBaseClickTime()

	self._curStageId = DivineSaintKnightFireGodModel.instance:getCurrStageId()

	if DivineSaintKnightFireGodController.instance:isStagePass(self._activityId, self._curStageId) then
		local stageCfgs = DivineSaintKnightFireGodConfig.instance:getStageCfgs(self._activityId)
		local info = DivineSaintKnightFireGodModel.instance:getInfo(self._activityId)
		local passKv = {}

		for i, v in ipairs(info.passStageId) do
			passKv[v] = true
		end

		for i, v in ipairs(stageCfgs) do
			if not passKv[v.stageId] then
				self._curStageId = v.stageId

				break
			end
		end
	end

	self:_onClickTabCell(self._curStageId)
end

function DivinesaintknightfiregodstageView:_updateUI()
	local stageCfgs = DivineSaintKnightFireGodConfig.instance:getStageCfgs(self._activityId)

	self._scrollerList:reloadData(stageCfgs)

	local stageCfg = DivineSaintKnightFireGodConfig.instance:getStageCfg(self._activityId, self._curStageId)

	MaterialMgr.setCellByCfg(stageCfg.prize, self._itemGo)

	local masterCfg = DivineSaintKnightFireGodConfig.instance:getMasterCfg(stageCfg.creepsMasterId)

	self._txtDesc.text = masterCfg.ruleDesc

	self:_updateFormation()
	self:_buildLines(#stageCfgs)
	self:_updateBubble()
end

function DivinesaintknightfiregodstageView:_updateBubble()
	local stime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.DivineSaintKnightFireGod, self._activityId)
	local stageCfg = DivineSaintKnightFireGodConfig.instance:getStageCfg(self._activityId, self._curStageId)

	self._nextWeekAddScore = stageCfg.nextWeekScore[1] - stageCfg.baseScore[1]
	self._targetTime = stime + self._actCfg.nextScoreTime * 86400

	if self._targetTime - ServerTime.now() > 0 then
		settimer(1, self._tickTime, self, true)
	else
		removetimer(self._tickTime, self)
	end

	self:_tickTime()
end

function DivinesaintknightfiregodstageView:_tickTime()
	local leftTime = self._targetTime - ServerTime.now()

	if leftTime > 0 then
		local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(leftTime)

		self._txtScoreBubble.text = leftTime > 86400 and string.format("%s天后每个效果基础点+%s", day, self._nextWeekAddScore) or leftTime > 3600 and string.format("%s小时后每个效果基础点+%s", hour, self._nextWeekAddScore) or leftTime > 60 and string.format("%s分钟后每个效果基础点+%s", min, self._nextWeekAddScore) or string.format("%s秒后每个效果基础点+%s", sec, self._nextWeekAddScore)
	else
		removetimer(self._tickTime, self)

		self._txtScoreBubble.text = string.format("每个效果基础点+%s", self._nextWeekAddScore)
	end
end

function DivinesaintknightfiregodstageView:_buildLines(stageCount)
	local lineCnt = math.floor(stageCount / 2)

	self._lineGos = self._lineGos or {}

	for i = 1, lineCnt do
		local go = self._lineGos[i]

		if not go then
			go = goutil.cloneAndSetParent(self._lineGo, self._contentGo.transform)
			self._lineGos[i] = go
		end

		Framework.TransformUtil.SetLocalScale(go.transform, 1, 1, 1)
		Framework.TransformUtil.SetAnchoredPos(go.transform, -25, -(i - 1) * 284 - 62)
		goutil.setActive(go, true)
	end

	for i = lineCnt + 1, #self._lineGos do
		goutil.setActive(self._lineGo[i], false)
	end
end

function DivinesaintknightfiregodstageView:_updateFormation()
	local stageCfg = DivineSaintKnightFireGodConfig.instance:getStageCfg(self._activityId, self._curStageId)
	local creepsCfgs = DivineSaintKnightFireGodConfig.instance:getCreepsCfgs(stageCfg.creepsMasterId)
	local mainGo = self._formationGo

	for posId = 1, 9 do
		local go = goutil.findChild(mainGo, "cell_" .. posId)
		local icon = goutil.findChild(go, "con")
		local creepsData

		for _, cData in ipairs(creepsCfgs) do
			if cData.posId == posId then
				creepsData = cData

				break
			end
		end

		goutil.setActive(go, creepsData)

		if creepsData then
			local skinId = checknumber(creepsData.faceId)

			if skinId == 0 then
				skinId = creepsData.raceId
			end

			MaterialMgr.setIcon(icon, MatType.Pet, skinId)
		else
			MaterialMgr.resetAll(icon)
		end
	end
end

function DivinesaintknightfiregodstageView:_calBaseScore()
	local stageCfg = DivineSaintKnightFireGodConfig.instance:getStageCfg(self._activityId, self._curStageId)
	local stime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.DivineSaintKnightFireGod, self._activityId)
	local days = GameUtil.getDaysByTimestamp(stime, ServerTime.now())
	local isNextWeek = days >= self._actCfg.nextScoreTime

	self._scores = isNextWeek and stageCfg.nextWeekScore or stageCfg.baseScore
end

function DivinesaintknightfiregodstageView:_updateCell(view, cell, cfg, tag)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local goSelect = goutil.findChild(cell.gameObject, "btn/select")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "btn/txtName")
	local passGo = goutil.findChild(cell.gameObject, "btn/passGo")
	local x = cell.data % 2 == 0 and 122.5 or 41.5

	Framework.TransformUtil.SetAnchoredPos(btn.gameObject.transform, x, 0)

	txtName.text = string.format("第%s关", cfg.stageId)

	goutil.setActive(passGo, DivineSaintKnightFireGodController.instance:isStagePass(self._activityId, cfg.stageId))
	goutil.setActive(goSelect, self._curStageId == cfg.stageId)
	btn:AddClickListener(function()
		self:_onClickTabCell(cfg.stageId)
	end)
end

function DivinesaintknightfiregodstageView:_clearCell(cell)
	return
end

function DivinesaintknightfiregodstageView:_checkFormula()
	local score1 = self._clickTimes[self._curStageId][1] * self._scores[1]
	local score2 = self._clickTimes[self._curStageId][2] * self._scores[2]
	local score3 = self._clickTimes[self._curStageId][3] * self._scores[3]
	local stageCfg = DivineSaintKnightFireGodConfig.instance:getStageCfg(self._activityId, self._curStageId)
	local formatStr = string.gsub(stageCfg.clientFormula, "#", "%%s")
	local evaluateStr = string.format(formatStr, score1, score2, score3)
	local totalScore = self:_evaluate(evaluateStr)
	local equationStr = string.format("%s%s", stageCfg.equationSymbol, stageCfg.equation)

	return (self:_compare(equationStr, totalScore))
end

function DivinesaintknightfiregodstageView:_onClickbtnClg()
	if not self:_checkFormula() then
		FloatWordMgr.instance:show("公式未符合要求，请重新尝试")

		return
	end

	local fmtMo = DivineSaintKnightFireGodModel.instance:getFmtMo(self._activityId)

	fmtMo:initParams(self._activityId, self._curStageId, self._clickTimes[self._curStageId])
	CustomFmtController.instance:showMissionView(fmtMo)

	local params = {
		ruleTitle = "战斗效果"
	}
	local commonRule = {}

	for buffId, times in ipairs(self._clickTimes[self._curStageId]) do
		local buffCfg = DivineSaintKnightFireGodConfig.instance:getBuffCfgByTime(self._activityId, buffId, times)

		table.insert(commonRule, string.format("%s、%s", buffId, buffCfg.desc))
	end

	local commonRuleTxt = table.concat(commonRule, "\n")

	MissionModel.instance:setRuleDesc(commonRuleTxt)
	MissionModel.instance:setRuleParam(params)
end

function DivinesaintknightfiregodstageView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("syshengqiyansen_rule")
end

function DivinesaintknightfiregodstageView:_onClickbtnClose()
	self:close()
end

function DivinesaintknightfiregodstageView:_onClickbtnReset()
	self:_resetClickTime(self._curStageId)
	self:_updateEquationUI()
end

function DivinesaintknightfiregodstageView:_onClickTabCell(stageId)
	if DivineSaintKnightFireGodController.instance:isStagePass(self._activityId, stageId) then
		FloatWordMgr.instance:show("此关卡已通关")

		return
	end

	self._curStageId = stageId

	DivineSaintKnightFireGodModel.instance:setCurrStageId(stageId)
	self._scrollerList:refresh()
	self:_calBaseScore()
	self:_updateEquationUI()
	self:_updateUI()
end

function DivinesaintknightfiregodstageView:_updateEquationUI()
	local stageCfg = DivineSaintKnightFireGodConfig.instance:getStageCfg(self._activityId, self._curStageId)
	local clientFormula = stageCfg.clientFormula
	local arr = {}

	for char in string.gmatch(clientFormula, ".") do
		table.insert(arr, char)
	end

	local result = {}

	for i = 1, #arr do
		if arr[i] ~= "" then
			if i > 1 and string.match(arr[i], "[0-9]") and string.match(arr[i - 1], "[0-9]") then
				result[#result] = result[#result] .. arr[i]
			else
				table.insert(result, arr[i])
			end
		end
	end

	local clientFormulaArr = result

	self._txtFirstPit:SetNum(clientFormulaArr[3])

	self._txtFirstSign.text = clientFormulaArr[4]

	self._txtSecondPit:SetNum(clientFormulaArr[7])

	self._txtSecondSign.text = clientFormulaArr[8]

	self._txtThirdPit:SetNum(clientFormulaArr[11])
	self._txtEquation:SetNum(stageCfg.equation)

	for i, baseScore in ipairs(self._scores) do
		local time = self._clickTimes[self._curStageId][i]

		self._txtPosList[i].text = time * baseScore
	end

	self:_setSymbol(self._firstSymbol, clientFormulaArr[2])
	self:_setSymbol(self._secondSymbol, clientFormulaArr[6])
	self:_setSymbol(self._thirdSymbol, clientFormulaArr[10])
	self:_setBuffDescs()
	self:_setFialdLineState()
end

function DivinesaintknightfiregodstageView:_setFialdLineState()
	goutil.setActive(self._failedLineGo, not self:_checkFormula())
end

function DivinesaintknightfiregodstageView:_setSymbol(comp, symbol)
	local symbols = {
		"+",
		"-",
		"*",
		"/"
	}
	local index = table.indexof(symbols, symbol)

	if index then
		comp:SetState(index - 1)
	end
end

function DivinesaintknightfiregodstageView:_setBuffDescs()
	for i, comp in ipairs(self._txtDescList) do
		local times = self._clickTimes[self._curStageId][i]
		local buffDesc = DivineSaintKnightFireGodConfig.instance:getBuffCfgByTime(self._activityId, i, times).desc

		comp.text = string.format("<color=#ECE0A8FF>当前点击次数：%s次</color>\n效果描述：\n%s", times, buffDesc)
	end
end

function DivinesaintknightfiregodstageView:_evaluate(expression)
	local function compute(op1, operator, op2)
		if operator == "+" then
			return op1 + op2
		elseif operator == "-" then
			return op1 - op2
		elseif operator == "*" then
			return op1 * op2
		elseif operator == "/" then
			return op1 / op2
		end
	end

	local function parse(s)
		s = s:gsub("%s+", "")

		local numbers = {}
		local operators = {}
		local index = 1
		local len = #s

		local function nextNumber()
			local num = ""

			::label_29_0::

			if index <= len then
				if s:sub(index, index):match("%d") or s:sub(index, index) == "." then
					repeat
						num = num .. s:sub(index, index)
						index = index + 1

						goto label_29_0
					until true
				end
			end

			return checknumber(num)
		end

		local function applyLastOperation()
			local op2 = table.remove(numbers)
			local op1 = table.remove(numbers)
			local operator = table.remove(operators)

			table.insert(numbers, compute(op1, operator, op2))
		end

		table.insert(numbers, nextNumber())

		while index <= len do
			local operator = s:sub(index, index)

			index = index + 1

			while #operators > 0 and (operator == "+" or operator == "-") do
				applyLastOperation()
			end

			table.insert(operators, operator)
			table.insert(numbers, nextNumber())
		end

		while #operators > 0 do
			applyLastOperation()
		end

		return numbers[1]
	end

	return parse(expression)
end

function DivinesaintknightfiregodstageView:_compare(expression, value)
	local operator, number = expression:match("([<>]=?)%s*(%d+)")

	number = tonumber(number)

	if not operator or not number then
		printError("Invalid expression ", expression)
	end

	if operator == ">=" then
		return number <= value
	elseif operator == "<=" then
		return value <= number
	elseif operator == ">" then
		return number < value
	elseif operator == "<" then
		return value < number
	elseif operator == "=" then
		return value == number
	else
		printError("Unsupported operator")
	end
end

function DivinesaintknightfiregodstageView:_onClickbtnPos1()
	self:_addClickTime(1)
end

function DivinesaintknightfiregodstageView:_onClickbtnPos2()
	self:_addClickTime(2)
end

function DivinesaintknightfiregodstageView:_onClickbtnPos3()
	self:_addClickTime(3)
end

function DivinesaintknightfiregodstageView:_addClickTime(index)
	if self._clickTimes[self._curStageId][index] >= self._actCfg.buffAddTimesLimit then
		FloatWordMgr.instance:show("已达上限次数")

		return
	end

	self._clickTimes[self._curStageId][index] = self._clickTimes[self._curStageId][index] + 1

	self:_updateEquationUI()
end

function DivinesaintknightfiregodstageView:_resetClickTime(stageId)
	for i = 1, #self._scores do
		self._clickTimes[stageId][i] = 1
	end
end

function DivinesaintknightfiregodstageView:_createBaseClickTime()
	self._clickTimes = DivineSaintKnightFireGodModel.instance:getStageClicTimes(self._activityId)
end

return DivinesaintknightfiregodstageView
