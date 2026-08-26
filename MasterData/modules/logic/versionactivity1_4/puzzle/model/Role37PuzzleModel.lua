-- chunkname: @modules/logic/versionactivity1_4/puzzle/model/Role37PuzzleModel.lua

module("modules.logic.versionactivity1_4.puzzle.model.Role37PuzzleModel", package.seeall)

local Role37PuzzleModel = class("Role37PuzzleModel", BaseModel)

function Role37PuzzleModel:onInit()
	return
end

function Role37PuzzleModel:clear()
	self.puzzleCfg = nil
	self.maxStep = nil
	self.maxOper = nil
	self.operGroupId = nil
	self.operGroupCfg = nil
	self.operGroupList = nil
	self.matchList = nil
	self.operList = nil
	self.recordList = nil
	self.controllRecords = nil
	self.isSucess = nil
end

function Role37PuzzleModel:setPuzzleId(_puzzleId)
	self.puzzleId = _puzzleId

	self:initCfg()
	self:initParam()
end

function Role37PuzzleModel:initCfg()
	self.puzzleCfg = Activity130Config.instance:getActivity130DecryptCo(Activity130Enum.ActivityId.Act130, self.puzzleId)
	self.maxStep = self.puzzleCfg.maxStep
	self.maxOper = self.puzzleCfg.maxOper
	self.operGroupId = self.puzzleCfg.operGroupId
	self.operGroupCfg = Activity130Config.instance:getOperGroup(Activity130Enum.ActivityId.Act130, self.operGroupId)
	self.operGroupList = {}

	local operGroupCfg = Activity130Config.instance:getOperGroup(Activity130Enum.ActivityId.Act130, self.operGroupId)

	for k, v in pairs(operGroupCfg) do
		table.insert(self.operGroupList, v)
	end

	table.sort(self.operGroupList, function(a, b)
		return a.operType < b.operType
	end)

	self.matchList = string.splitToNumber(self.puzzleCfg.answer, "|")
end

function Role37PuzzleModel:initParam()
	self.operList = {}
	self.recordList = {}

	PuzzleRecordListModel.instance:clearRecord()

	self.controllRecords = {}

	self:initVariable()
	self:setCurErrorIndex(0)

	self.isSucess = false
end

function Role37PuzzleModel:initVariable()
	self.maxDis = 8
	self.remainDis = self.maxDis
	self.passDay = 1
	self.handleBa = 0
	self.maxHandle = 6
	self.curPos = 1
	self.maxPos = 7
	self.routeBaList = {
		12,
		0,
		0,
		0,
		0,
		0,
		0
	}
	self.leftBank = {
		1,
		2,
		3
	}
	self.rightBank = {}
	self.boat = {}
	self.curBank = self.leftBank
	self.moveCnt = 0
end

function Role37PuzzleModel:_addRecord(operType, operIndex)
	local resultDesc = self:getResultDesc(operType, operIndex)

	table.insert(self.recordList, resultDesc)
end

function Role37PuzzleModel:_directAddRecord(desc, needUpdate)
	needUpdate = needUpdate or false

	table.insert(self.recordList, desc)

	if needUpdate then
		self:_updateRecord()
	end
end

function Role37PuzzleModel:_repelaceRecord(desc)
	self.recordList[#self.recordList] = desc

	self:_updateRecord()
end

function Role37PuzzleModel:_updateRecord()
	PuzzleRecordListModel.instance:setRecordList(self.recordList)
end

function Role37PuzzleModel:addOption(option, pos, isRollback)
	if self.curErrorIndex ~= 0 and not isRollback then
		if self.curErrorIndex == 999 then
			GameFacade.showToastString(luaLang("v1a4_role37_puzzle_monkeybanana_not_enough"))
		else
			GameFacade.showToastString(luaLang("v1a4_role37_puzzle_error_tip"))
		end

		return
	end

	if self.operList[pos] then
		self:repleaceOption(option, pos)

		return
	end

	if tabletool.len(self.operList) >= self.maxOper then
		GameFacade.showToastString(luaLang("v1a4_role37_puzzle_oper_full"))

		return
	end

	self.operList[pos] = option

	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.AddOption, pos)
	self:recalculate()

	if not isRollback then
		table.insert(self.controllRecords, {
			Role37PuzzleEnum.ControlType.Add,
			pos
		})
	end

	self:checkReply()
end

function Role37PuzzleModel:exchangeOption(a, b, isRollback)
	if not self.operList[b] then
		self:moveOption(a, b)

		return
	end

	self.operList[a] = self.operList[b]
	self.operList[b] = self.operList[a]

	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.ExchangeOption, a, b)
	self:recalculate()

	if not isRollback then
		table.insert(self.controllRecords, {
			Role37PuzzleEnum.ControlType.Exchange,
			b,
			a
		})
	end

	self:checkReply()
end

function Role37PuzzleModel:removeOption(pos, isRollback)
	local operType = self.operList[pos]

	self.operList[pos] = nil

	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.RemoveOption, pos)
	self:recalculate()

	if not isRollback then
		table.insert(self.controllRecords, {
			Role37PuzzleEnum.ControlType.Remove,
			operType,
			pos
		})
	end

	self:checkReply()
end

function Role37PuzzleModel:repleaceOption(option, pos, isRollback)
	local oldOption = self.operList[pos]

	self.operList[pos] = option

	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.RepleaceOption, option, pos)
	self:recalculate()

	if not isRollback then
		table.insert(self.controllRecords, {
			Role37PuzzleEnum.ControlType.Repleace,
			oldOption,
			pos
		})
	end

	self:checkReply()
end

function Role37PuzzleModel:moveOption(from, to, isRollback)
	self.operList[to] = self.operList[from]
	self.operList[from] = nil

	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.MoveOption, from, to)
	self:recalculate()

	if not isRollback then
		table.insert(self.controllRecords, {
			Role37PuzzleEnum.ControlType.Move,
			to,
			from
		})
	end

	self:checkReply()
end

function Role37PuzzleModel:rollBack()
	if #self.controllRecords == 0 then
		return
	end

	local lastRecord = self.controllRecords[#self.controllRecords]
	local operateType = lastRecord[1]

	self.controllRecords[#self.controllRecords] = nil

	if operateType == Role37PuzzleEnum.ControlType.Add then
		self:removeOption(lastRecord[2], true)
	elseif operateType == Role37PuzzleEnum.ControlType.Exchange then
		self:exchangeOption(lastRecord[2], lastRecord[3], true)
	elseif operateType == Role37PuzzleEnum.ControlType.Remove then
		self:addOption(lastRecord[2], lastRecord[3], true)
	elseif operateType == Role37PuzzleEnum.ControlType.Repleace then
		self:repleaceOption(lastRecord[2], lastRecord[3], true)
	elseif operateType == Role37PuzzleEnum.ControlType.Move then
		self:moveOption(lastRecord[2], lastRecord[3], true)
	end
end

function Role37PuzzleModel:reset()
	self:initParam()
	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.Reset)
end

function Role37PuzzleModel:recalculate()
	self:initVariable()

	self.recordList = {}

	local operCnt = tabletool.len(self.operList)

	if operCnt == 0 then
		if self.curErrorIndex ~= 0 then
			self:setCurErrorIndex(0)
			Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.ErrorOperChange, self.curErrorIndex)
		end
	else
		local offset = 0

		for i = 1, operCnt do
			local operType = self.operList[i + offset]

			while operType == nil do
				offset = offset + 1
				operType = self.operList[i + offset]
			end

			local result = self:RunLogic(operType, offset + i)

			if result then
				self:_addRecord(operType, offset + i)
			else
				break
			end
		end
	end

	self:_updateRecord()
end

function Role37PuzzleModel:getOperList()
	return self.operList
end

function Role37PuzzleModel:getFirstGapIndex()
	local len = tabletool.len(self.operList)

	for i = 1, len do
		if not self.operList[i] then
			return i
		end
	end

	return len + 1
end

function Role37PuzzleModel:RunLogic(option, operIndex)
	if self.puzzleId == Role37PuzzleEnum.PuzzleId.SnailMove then
		self:_snailMove(option, operIndex)

		return true
	elseif self.puzzleId == Role37PuzzleEnum.PuzzleId.MonkeyBanana then
		return self:_monkeyBanana(option, operIndex)
	elseif self.puzzleId == Role37PuzzleEnum.PuzzleId.WolfSheepDish then
		return self:_wolfSheepDish(option, operIndex)
	else
		return true
	end
end

function Role37PuzzleModel:_snailMove(option)
	if option == Role37PuzzleEnum.OperType.One then
		self.remainDis = self.remainDis - 3

		if self.remainDis < 0 then
			self.remainDis = 0
		end
	elseif option == Role37PuzzleEnum.OperType.Two then
		self.remainDis = self.remainDis + 2

		if self.remainDis > self.maxDis then
			self.remainDis = self.maxDis
		end
	elseif option == Role37PuzzleEnum.OperType.Three then
		self.passDay = self.passDay + 1
	end
end

function Role37PuzzleModel:_monkeyBanana(option, operIndex)
	local errorOper = 0

	if option == Role37PuzzleEnum.OperType.One then
		local canPick = self.maxHandle - self.handleBa
		local remain = self.routeBaList[self.curPos] - canPick

		if remain < 0 then
			self.handleBa = self.handleBa + self.routeBaList[self.curPos]
			self.routeBaList[self.curPos] = 0
		else
			self.handleBa = self.maxHandle
			self.routeBaList[self.curPos] = remain
		end
	elseif option == Role37PuzzleEnum.OperType.Two then
		if self.curPos + 3 <= self.maxPos then
			self.curPos = self.curPos + 3

			local remainBa = self.handleBa - 3

			self.handleBa = remainBa >= 0 and remainBa or 0
		else
			errorOper = operIndex

			self:_directAddRecord(luaLang("v1a4_role37_puzzle_monkeybanana_arrive_destination"))
		end
	elseif option == Role37PuzzleEnum.OperType.Four then
		local dif = self.curPos - 1

		self.curPos = 1
		self.handleBa = self.handleBa - dif

		if self.handleBa < 0 then
			self.handleBa = 0
		end
	elseif option == Role37PuzzleEnum.OperType.Five then
		self.routeBaList[self.curPos] = self.routeBaList[self.curPos] + self.handleBa
		self.handleBa = 0
	end

	if self.curErrorIndex ~= errorOper then
		self:setCurErrorIndex(errorOper)
		Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.ErrorOperChange, self.curErrorIndex)
	end

	return self.curErrorIndex == 0
end

function Role37PuzzleModel:_wolfSheepDish(option, operIndex)
	local errorOper = 0

	if option == Role37PuzzleEnum.OperType.One or option == Role37PuzzleEnum.OperType.Two or option == Role37PuzzleEnum.OperType.Three then
		local index = tabletool.indexOf(self.curBank, Role37PuzzleEnum.AnimalRules[option])

		if index and #self.boat == 0 then
			table.remove(self.curBank, index)

			self.boat[1] = Role37PuzzleEnum.AnimalRules[option]
			self.lastPick = self.curBank
		else
			errorOper = operIndex

			if not index then
				self:_directAddRecord(luaLang("v1a4_role37_puzzle_animal_pick_fault"))
			else
				self:_directAddRecord(luaLang("v1a4_role37_puzzle_animal_boat_full"), false)
			end
		end
	elseif option == Role37PuzzleEnum.OperType.Four then
		self.curBank = self.leftBank

		if #self.rightBank == 2 and math.abs(self.rightBank[2] - self.rightBank[1]) == 1 then
			errorOper = operIndex

			self:_directAddRecord(luaLang("v1a4_role37_puzzle_animal_eat"), false)
		end
	elseif option == Role37PuzzleEnum.OperType.Five then
		self.curBank = self.rightBank

		if #self.leftBank == 2 and math.abs(self.leftBank[2] - self.leftBank[1]) == 1 then
			errorOper = operIndex

			self:_directAddRecord(luaLang("v1a4_role37_puzzle_animal_eat"), false)
		end
	elseif option == Role37PuzzleEnum.OperType.Six and self.boat[1] then
		table.insert(self.curBank, self.boat[1])

		self.boat[1] = nil

		if self.lastPick and self.lastPick ~= self.curBank then
			self.lastPick = nil
			self.moveCnt = self.moveCnt + 1
		end
	end

	if self.curErrorIndex ~= errorOper then
		self:setCurErrorIndex(errorOper)
		Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.ErrorOperChange, self.curErrorIndex)
	end

	return self.curErrorIndex == 0
end

function Role37PuzzleModel:getBankDesc(bank)
	local str = ""

	for _, v in ipairs(bank) do
		local temp = luaLang(Role37PuzzleEnum.AnimalStr[v])

		str = str .. temp
	end

	if bank == self.leftBank then
		if not string.nilorempty(str) then
			str = formatLuaLang("v1a4_role37_puzzle_leftbank_leave", str) .. ","
		end
	elseif bank == self.rightBank then
		if not string.nilorempty(str) then
			str = formatLuaLang("v1a4_role37_puzzle_rightbank_leave", str) .. ","
		end
	elseif not string.nilorempty(str) then
		str = formatLuaLang("v1a4_role37_puzzle_boat_leave", str) .. ","
	end

	return str
end

function Role37PuzzleModel:getSortError5()
	local result = ""
	local index1 = tabletool.indexOf(self.operList, 1)
	local index2 = tabletool.indexOf(self.operList, 2)
	local index4 = tabletool.indexOf(self.operList, 4)
	local index5 = tabletool.indexOf(self.operList, 5)
	local index6 = tabletool.indexOf(self.operList, 6)

	if index1 ~= 5 then
		result = result .. " " .. self.operGroupCfg[1].name
	end

	if index2 > 3 then
		result = result .. " " .. self.operGroupCfg[2].name
	end

	if index4 == 1 or index4 == 5 or math.abs(index4 - index1) == 1 then
		result = result .. " " .. self.operGroupCfg[4].name
	end

	if not self.operList[index5 - 1] or self.operList[index5 - 1] ~= 2 then
		result = result .. " " .. self.operGroupCfg[5].name
	end

	if index6 == 1 or index6 == 5 then
		result = result .. " " .. self.operGroupCfg[6].name
	end

	return result
end

function Role37PuzzleModel:getSortError7()
	local result = ""
	local index1 = tabletool.indexOf(self.operList, 1)
	local index2 = tabletool.indexOf(self.operList, 2)
	local index3 = tabletool.indexOf(self.operList, 3)
	local index4 = tabletool.indexOf(self.operList, 4)
	local index5 = tabletool.indexOf(self.operList, 5)
	local index6 = tabletool.indexOf(self.operList, 6)
	local index7 = tabletool.indexOf(self.operList, 7)

	if math.abs(index1 - index2) == 1 then
		result = result .. " " .. self.operGroupCfg[1].name
	end

	if math.abs(index2 - index1) ~= math.abs(index3 - index5) then
		result = result .. " " .. self.operGroupCfg[2].name
	end

	if math.abs(index5 - index3) < 4 then
		result = result .. " " .. self.operGroupCfg[3].name
	end

	if index4 == 1 or index4 > 3 then
		result = result .. " " .. self.operGroupCfg[4].name
	end

	if math.abs(index5 - index3) == 1 then
		result = result .. " " .. self.operGroupCfg[5].name
	end

	if math.abs(index6 - index7) ~= 1 then
		result = result .. " " .. self.operGroupCfg[6].name
	end

	if index6 < index7 then
		result = result .. " " .. self.operGroupCfg[7].name
	end

	return result
end

function Role37PuzzleModel:getResultDesc(operType, operIndex)
	local operDesc = self.operGroupCfg[operType].operDesc .. ","

	if self.puzzleId == Role37PuzzleEnum.PuzzleId.SnailMove then
		local tag = {
			self.remainDis,
			self.passDay
		}

		return GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_snailmove_result"), tag)
	elseif self.puzzleId == Role37PuzzleEnum.PuzzleId.SortByRules5 then
		local optionName = self.operGroupCfg[operType].name
		local tag = {
			optionName,
			operIndex
		}

		return GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_sortbyrules_result"), tag)
	elseif self.puzzleId == Role37PuzzleEnum.PuzzleId.MonkeyBanana then
		local resultDesc
		local startCnt = self.routeBaList[1]
		local midCnt = self.routeBaList[4]
		local remainDis = self.maxPos - self.curPos

		if startCnt > 0 and midCnt > 0 then
			local tag = {
				remainDis,
				self.handleBa,
				startCnt,
				midCnt
			}

			resultDesc = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_monkeybanana_result1"), tag)
		elseif startCnt > 0 and midCnt == 0 then
			local tag = {
				remainDis,
				self.handleBa,
				startCnt
			}

			resultDesc = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_monkeybanana_result2"), tag)
		elseif startCnt == 0 and midCnt > 0 then
			local tag = {
				remainDis,
				self.handleBa,
				midCnt
			}

			resultDesc = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_monkeybanana_result3"), tag)
		else
			local tag = {
				remainDis,
				self.handleBa
			}

			resultDesc = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_monkeybanana_result4"), tag)
		end

		return operDesc .. resultDesc
	elseif self.puzzleId == Role37PuzzleEnum.PuzzleId.SortByRules7 then
		local optionName = self.operGroupCfg[operType].name
		local tag = {
			optionName,
			operIndex
		}

		return GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_sortbyrules_result"), tag)
	elseif self.puzzleId == Role37PuzzleEnum.PuzzleId.WolfSheepDish then
		local bankDesc = self.curBank == self.leftBank and luaLang("v1a4_role37_puzzle_animal_leftbank") .. "," or luaLang("v1a4_role37_puzzle_animal_rightbank") .. ","
		local leftBankDesc = self:getBankDesc(self.leftBank)
		local rightBankDesc = self:getBankDesc(self.rightBank)
		local boatDesc = self:getBankDesc(self.boat)
		local moveCntDesc = string.format(luaLang("v1a4_role37_puzzle_animal_movecnt"), self.moveCnt)

		return operDesc .. bankDesc .. leftBankDesc .. boatDesc .. rightBankDesc .. moveCntDesc
	elseif self.puzzleId == Role37PuzzleEnum.PuzzleId.Final then
		local optionName = self.operGroupCfg[operType].name
		local tag = {
			optionName,
			operIndex
		}

		return GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_sortbyrules_result"), tag)
	end

	return ""
end

function Role37PuzzleModel:checkReply()
	local operCnt = tabletool.len(self.operList)

	if self.puzzleId == Role37PuzzleEnum.PuzzleId.SnailMove then
		local offset = 0
		local lastOper = 3
		local errorOper = 0

		for i = 1, operCnt do
			local oper = self.operList[i + offset]

			while oper == nil do
				offset = offset + 1
				oper = self.operList[i + offset]
			end

			local operDif = oper - lastOper

			if operDif == 0 then
				if oper == 3 then
					self:_repelaceRecord(luaLang("v1a4_role37_puzzle_snailmove_updown"))
				else
					self:_repelaceRecord(luaLang("v1a4_role37_puzzle_snailmove_single"))
				end

				errorOper = i + offset

				break
			elseif operDif == 2 then
				self:_repelaceRecord(luaLang("v1a4_role37_puzzle_snailmove_down"))

				errorOper = i + offset

				break
			elseif operDif == -1 then
				if oper == 1 then
					self:_repelaceRecord(luaLang("v1a4_role37_puzzle_snailmove_single"))
				elseif oper == 2 then
					self:_repelaceRecord(luaLang("v1a4_role37_puzzle_snailmove_up"))
				end

				errorOper = i + offset

				break
			else
				errorOper = 0
			end

			lastOper = oper
		end

		if self.curErrorIndex ~= errorOper then
			self:setCurErrorIndex(errorOper)
			Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.ErrorOperChange, self.curErrorIndex)
		end

		if self.remainDis == 0 and self.passDay == 6 then
			self:Finish(true)

			return
		end
	elseif self.puzzleId == Role37PuzzleEnum.PuzzleId.SortByRules5 then
		local passList = {}
		local errorOper = 0

		for pos, value in pairs(self.operList) do
			if passList[value] then
				self:_repelaceRecord(luaLang("v1a4_role37_puzzle_sortbyrules_only"))

				errorOper = pos

				break
			else
				passList[value] = 1
				errorOper = 0
			end
		end

		if self.curErrorIndex ~= errorOper then
			self:setCurErrorIndex(errorOper)
			Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.ErrorOperChange, self.curErrorIndex)
		end

		if operCnt == 5 and self.curErrorIndex == 0 then
			local str = self:getSortError5()

			if string.nilorempty(str) then
				self:Finish(true)

				return
			else
				local extraTip = string.format(luaLang("v1a4_role37_puzzle_sortbyrules_error"), str)

				self:_directAddRecord(extraTip, true)
			end
		end
	elseif self.puzzleId == Role37PuzzleEnum.PuzzleId.MonkeyBanana then
		if self.curPos == 7 then
			if self.handleBa >= 3 then
				self:Finish(true)

				return
			else
				self:setCurErrorIndex(999)
				self:_directAddRecord(luaLang("v1a4_role37_puzzle_monkeybanana_not_enough"), true)
			end
		end
	elseif self.puzzleId == Role37PuzzleEnum.PuzzleId.SortByRules7 then
		local passList = {}
		local errorOper = 0

		for pos, value in pairs(self.operList) do
			if passList[value] then
				self:_repelaceRecord(luaLang("v1a4_role37_puzzle_sortbyrules_only"))

				errorOper = pos

				break
			else
				passList[value] = 1
				errorOper = 0
			end
		end

		if self.curErrorIndex ~= errorOper then
			self:setCurErrorIndex(errorOper)
			Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.ErrorOperChange, self.curErrorIndex)
		end

		if operCnt == 7 and self.curErrorIndex == 0 then
			local str = self:getSortError7()

			if string.nilorempty(str) then
				self:Finish(true)

				return
			else
				local extraTip = string.format(luaLang("v1a4_role37_puzzle_sortbyrules_error"), str)

				self:_directAddRecord(extraTip, true)
			end
		end
	elseif self.puzzleId == Role37PuzzleEnum.PuzzleId.WolfSheepDish then
		if #self.rightBank == 3 then
			if self.moveCnt > 5 then
				GameFacade.showToastString(luaLang("v1a4_role37_puzzle_animal_movecnt_notenough"))

				return
			end

			self:Finish(true)

			return
		end
	elseif self.puzzleId == Role37PuzzleEnum.PuzzleId.Final and operCnt == 10 and self:matchOperList() then
		self:Finish(true)

		return
	end

	if self.puzzleCfg.puzzleType == Role37PuzzleEnum.PuzzleType.Logic and self:isOperateFull() then
		self:Finish(false)

		return
	end
end

function Role37PuzzleModel:matchOperList()
	local result = true

	for k, v in ipairs(self.matchList) do
		if self.operList[k] ~= v then
			result = false

			break
		end
	end

	return result
end

function Role37PuzzleModel:Finish(isSucess)
	self.isSucess = isSucess

	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.PuzzleResult, isSucess)
end

function Role37PuzzleModel:isOperateFull()
	return tabletool.len(self.operList) >= self.maxStep
end

function Role37PuzzleModel:getResult()
	return self.isSucess
end

function Role37PuzzleModel:getPuzzleCfg()
	return self.puzzleCfg
end

function Role37PuzzleModel:getOperGroupCfg()
	return self.operGroupCfg
end

function Role37PuzzleModel:getOperGroupList()
	return self.operGroupList
end

function Role37PuzzleModel:getShapeImage(operType)
	return self.operGroupCfg[operType].shapeImg
end

function Role37PuzzleModel:getMaxOper()
	return self.maxOper
end

function Role37PuzzleModel:setCurErrorIndex(index)
	self.curErrorIndex = index

	if index ~= 0 then
		self.errorCnt = self.errorCnt + 1
	end
end

function Role37PuzzleModel:getCurErrorIndex()
	return self.curErrorIndex
end

function Role37PuzzleModel:setErrorCnt(cnt)
	self.errorCnt = cnt
end

function Role37PuzzleModel:getErrorCnt()
	return self.errorCnt
end

function Role37PuzzleModel:getOperAudioId(operType)
	return self.operGroupCfg[operType].audioId
end

Role37PuzzleModel.instance = Role37PuzzleModel.New()

return Role37PuzzleModel
