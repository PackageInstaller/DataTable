-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/model/MazeChapter.lua

require("dm.gameplay.maze.model.MazeTreasure")
require("dm.gameplay.maze.model.MazeTeam")

local MazeOptionFactory = require("dm.gameplay.maze.model.MazeOptionFactory")

MazeChapter = class("MazeChapter", objectlua.Object, _M)

MazeChapter:has("_chapterType", {
	is = "rw"
})
MazeChapter:has("_enterTime", {
	is = "rw"
})
MazeChapter:has("_money", {
	is = "rw"
})
MazeChapter:has("_lastValueId", {
	is = "rw"
})
MazeChapter:has("_chapterId", {
	is = "rw"
})
MazeChapter:has("_valueId", {
	is = "rw"
})
MazeChapter:has("_chapterCount", {
	is = "rw"
})
MazeChapter:has("_optionCount", {
	is = "rw"
})
MazeChapter:has("_showOptions", {
	is = "rw"
})
MazeChapter:has("_leftOptions", {
	is = "rw"
})
MazeChapter:has("_nextChapterIds", {
	is = "rw"
})
MazeChapter:has("_treasures", {
	is = "rw"
})
MazeChapter:has("_team", {
	is = "rw"
})
MazeChapter:has("_teamBuff", {
	is = "rw"
})
MazeChapter:has("_isNeedSelecgChapter", {
	is = "rw"
})
MazeChapter:has("_bossStep", {
	is = "rw"
})
MazeChapter:has("_delTreasure", {
	is = "rw"
})
MazeChapter:has("_suspectPointList", {
	is = "rw"
})
MazeChapter:has("_finalSuspects", {
	is = "rw"
})
MazeChapter:has("_skill", {
	is = "rw"
})
MazeChapter:has("_gold", {
	is = "rw"
})
MazeChapter:has("_buffData", {
	is = "rw"
})

function MazeChapter:initialize(mazesys)
	super.initialize(self)

	self._treasures = {}
	self._showOptions = {}
	self._serverOptions = {}
	self._suspectPointList = {}
	self._finalSuspects = {}
	self._mazeSystem = mazesys
end

function MazeChapter:syncDelData(data)
	if GameConfigs.mazeDebugMode then
		dump(data, "要删除的页签数据")
	end

	local deldata = data

	if deldata == 1 then
		self._mazeSystem:gameOver()
		self._mazeSystem:setMazeState(1)

		return
	end

	if deldata.showOptions then
		for k, v in pairs(deldata.showOptions) do
			local optionObj = self._showOptions[k]

			if v == 1 then
				self._showOptions[k] = nil
				self._isNeedSelecgChapter = self:getDataOptionCount(self._showOptions) == 0
			elseif optionObj:isTypeHeroShop() then
				if v.heroes then
					for kk, vv in pairs(v.heroes) do
						optionObj:delHero(kk)
					end
				end
			elseif optionObj:isTypeItemShop() then
				if v.items then
					for kk, vv in pairs(v.items) do
						optionObj:delTreasure(kk)
					end
				end
			elseif optionObj:isTypeItemBox_1To1() or optionObj:isTypeItemBox_2To1() or optionObj:isTypeItemBox_3To1() or optionObj:isTypeItemBox_2Time() then
				print("删除一个宝物")
			end
		end
	end

	if deldata.treasures then
		for k, v in pairs(deldata.treasures) do
			if self._treasures[k] then
				dump(self._treasures[k], "使用了宝物")

				self._delTreasure = self._treasures[k]
				self._treasures[k] = nil
			else
				self._delTreasure = nil
			end
		end
	else
		self._delTreasure = nil
	end

	if deldata.teamBuffs then
		for k, v in pairs(deldata.teamBuffs) do
			if v == 1 then
				self._teamBuff[k] = nil
			end
		end

		dump(self._teamBuff, "选择后的buff列表")
	end
end

function MazeChapter:getMazeType()
	return self._chapterType
end

function MazeChapter:syncData(data)
	if GameConfigs.mazeDebugMode then
		-- block empty
	end

	local curdata = data

	if data.type then
		self._chapterType = data.type
	end

	if data.gold then
		self._gold = data.gold
	end

	if curdata.team then
		self._mazeSystem:setHaveMaster(true)
		self._mazeSystem._player._mazeTeam:syncData(curdata.team, self._mazeSystem)
	else
		self._mazeSystem:setHaveMaster(false)
	end

	if curdata.teamBuffs then
		self._teamBuff = curdata.teamBuffs
	end

	if curdata.enterTime then
		self._enterTime = curdata.enterTime
	end

	if curdata.money then
		self._money = curdata.money
	end

	if curdata.lastValueId then
		self._lastValueId = curdata.lastValueId
	end

	if curdata.chapterId then
		self._chapterId = curdata.chapterId
	end

	if curdata.valueId then
		self._valueId = curdata.valueId
	end

	if curdata.chapterCount then
		self._chapterCount = curdata.chapterCount
	end

	if curdata.optionCount then
		self._optionCount = curdata.optionCount
	end

	if curdata.treasures then
		for k, v in pairs(curdata.treasures) do
			local treasures = MazeTreasure:new()

			treasures:syncData(v)

			self._treasures[k] = treasures
		end
	end

	if curdata.attrEffectManager and curdata.attrEffectManager.effects then
		local effect = curdata.attrEffectManager.effects.PANSLAB

		if effect and effect.ALL then
			self._buffData = effect.ALL
		end
	end

	if curdata.skill then
		self._skill = curdata.skill

		local skillconfig = ConfigReader:getDataByNameIdAndKey("PansLabList", curdata.eventId, "SpecialSkill")

		if skillconfig then
			self._skill.desc = Strings:get(skillconfig.desc)
		end
	end

	if curdata.suspectPoint then
		for k, v in pairs(curdata.suspectPoint) do
			self._suspectPointList[k] = v
		end
	end

	if curdata.finalSuspects then
		for k, v in pairs(curdata.finalSuspects) do
			self._finalSuspects[k] = v
		end
	end

	if curdata.showOptions then
		if GameConfigs.mazeDebugMode then
			dump(curdata.showOptions, "服务器更新页签数据")
		end

		self._isNeedSelecgChapter = self:getDataOptionCount(curdata.showOptions) == 0

		local isdif = false

		for k, v in pairs(self._showOptions) do
			if v._type == "MasterCure" then
				for kk, vv in pairs(curdata.showOptions) do
					if vv.leftTimes then
						v:syncData(vv)

						if vv.leftTimes >= 1 then
							isdif = true
						end
					end
				end
			end
		end

		for k, v in pairs(curdata.showOptions) do
			if v.questionStatus and self._showOptions[k] then
				self._showOptions[k]:syncData(v)

				isdif = true
			end
		end

		if (self:getOptionsCount() - self:getDataOptionCount(curdata.showOptions) == 1 or self:getOptionsCount() == 0) and not isdif then
			self._showOptions = {}
		else
			for k, v in pairs(curdata.showOptions) do
				for kk, vv in pairs(v) do
					if kk == "heroList" and self._showOptions[k] ~= nil and self:getDataOptionCount(curdata.showOptions) == 1 and self._showOptions[k]._heroList then
						self._showOptions[k]._heroList = vv
						isdif = true

						return
					end
				end
			end

			for k, v in pairs(curdata.showOptions) do
				for kk, vv in pairs(v) do
					if kk == "itemList" and self._showOptions[k] ~= nil and self:getDataOptionCount(curdata.showOptions) == 1 and self._showOptions[k]._itemList then
						self._showOptions[k]._itemList = vv
						isdif = true

						return
					end
				end
			end

			for k, v in pairs(self._showOptions) do
				if v._type == "HeroUp" then
					for kk, vv in pairs(curdata.showOptions) do
						if vv.count then
							v:syncUpCount(vv)

							isdif = true

							return
						end
					end
				end
			end

			for k, v in pairs(curdata.showOptions) do
				self._showOptions[k]:syncData(v)
			end
		end

		if GameConfigs.mazeDebugMode then
			-- block empty
		end

		self:updateAllOption(curdata.showOptions)

		if GameConfigs.mazeDebugMode then
			print("当前页签数量--->", self:getOptionsCount())
		end
	end

	if curdata.nextChapterIds then
		self._nextChapterIds = curdata.nextChapterIds
	end

	if curdata.leftOptions then
		self._leftOptions = curdata.leftOptions

		local count = self:showBossStep(curdata.leftOptions)

		self._bossStep = count

		print("距离boss--->", count)
	end

	if curdata.showOptions and curdata.leftOptions and table.nums(curdata.showOptions) == 0 and table.nums(curdata.leftOptions) == 0 then
		self._isNeedSelecgChapter = true
		self._nextChapterIds = ConfigReader:getDataByNameIdAndKey("PansLabChapter", curdata.chapterId, "NextChapter")
	end
end

function MazeChapter:setShowOptions(value)
	self._serverOptions = value
end

function MazeChapter:updateRefshOption(data)
	self:updateAllOption(data)
end

function MazeChapter:updateAllOption(data)
	for k, v in pairs(data) do
		local optionObj = MazeOptionFactory.createNewOption(v.type, v)

		if optionObj then
			self._showOptions[k] = optionObj
		end
	end
end

function MazeChapter:getShowOption()
	local checkSuc = true
	local serverOptions = self._serverOptions
	local showOptions = self._showOptions

	if table.nums(showOptions) == table.nums(serverOptions) then
		for k, v in pairs(serverOptions) do
			if showOptions[k] and showOptions[k]._optionId ~= v.optionId then
				checkSuc = false

				break
			end
		end
	else
		checkSuc = false
	end

	if not checkSuc then
		self:updateAllOption(self._serverOptions)

		return self:getClientShowOption()
	else
		return self:getClientShowOption()
	end
end

function MazeChapter:getClientShowOption()
	local result = {}

	for k, v in pairs(self._showOptions) do
		if (k == "0" or k == "1" or k == "2") and not v:isTypeBoss() then
			result[k] = v
		end
	end

	if table.nums(result) <= 0 then
		for k, v in pairs(self._showOptions) do
			if k == "0" or k == "1" or k == "2" then
				result[k] = v
			end
		end
	end

	return result
end

function MazeChapter:delOptionByIndex(index)
	if self._showOptions[index] then
		self._showOptions[index] = nil
	end
end

function MazeChapter:getOptionsCount()
	local count = 0

	for k, v in pairs(self._showOptions) do
		count = count + 1
	end

	return count
end

function MazeChapter:getDataOptionCount(data)
	local count = 0

	for k, v in pairs(data) do
		count = count + 1
	end

	return count
end

function MazeChapter:showBossStep(data)
	local count = 0

	for k, v in pairs(data) do
		if v.type == "Boss" then
			count = k
		end
	end

	return count
end
