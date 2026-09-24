-- chunkname: @modules/logic/versionactivity4_0/concertlimit/model/MusicGameModel.lua

module("modules.logic.versionactivity4_0.concertlimit.model.MusicGameModel", package.seeall)

local MusicGameModel = class("MusicGameModel", BaseModel)

function MusicGameModel:onInit()
	self:reInit()
end

function MusicGameModel:reInit()
	self._mainBlockLines = {}
	self._branchBlockLines = {}
	self._disturbBlockLines = {}
	self._blockMap = {}
	self._selectedBlockLines = {}
	self._resetCount = 30
end

function MusicGameModel:clearGameData()
	self:reInit()
end

function MusicGameModel:getBlockMap()
	if not self._blockMap or #self._blockMap == 0 then
		local line, row = self:getMapLineAndRowCount()

		for y = 1, line do
			self._blockMap[y] = {}

			for x = 1, row do
				self._blockMap[y][x] = MusicGameBlockMO.New()

				self._blockMap[y][x]:init(x, y)
			end
		end

		local blockLine = self:getMainBlockLines()

		if blockLine then
			self:setMainBlockLinesType()
			self:getBranchBlockLines()
			self:setBranchBlockLinesType()
			self:getDisturbBlockLines()
			self:setDisturbBlockLinesType()
			self:setOtherBlockType()
		else
			self._resetCount = self._resetCount - 1

			if self._resetCount > 0 then
				self:resetBlockMap()
			end
		end
	end

	return self._blockMap
end

function MusicGameModel:resetBlockMap()
	self:reInit()
	self:getBlockMap()
end

function MusicGameModel:getMapLineAndRowCount()
	local sizeStr = MusicGameConfig.instance:getConstValue(MusicGameEnum.ConstId.MapSize)
	local counts = string.splitToNumber(sizeStr, "#")

	return counts[1], counts[2]
end

function MusicGameModel:getStartMainPos()
	local isGuideFinished = GuideModel.instance:isGuideFinish(MusicGameEnum.GuideId)

	if not isGuideFinished then
		return 8, 8
	end

	local line, row = self:getMapLineAndRowCount()
	local posX = math.random(1, row)
	local posY = math.random(1, line)

	return posX, posY
end

function MusicGameModel:getMainBlockLineLength()
	local lineStr = MusicGameConfig.instance:getConstValue(MusicGameEnum.ConstId.MainPathLength)
	local lengths = string.splitToNumber(lineStr, "#")

	return (math.random(lengths[1], lengths[2]))
end

function MusicGameModel:getMainBlockLines()
	local line, row = self:getMapLineAndRowCount()
	local lineLength = self:getMainBlockLineLength()
	local dirs = {}
	local sameDirCount = 0

	if not self._mainBlockLines or #self._mainBlockLines == 0 then
		local function getNextBlockLine(x, y)
			if not self._blockMap[y] or not self._blockMap[y][x] then
				return
			end

			self._blockMap[y][x]:setType(MusicGameEnum.BlockType.Main)

			if self._blockMap[y - 1] and self._blockMap[y - 1][x] then
				self._blockMap[y - 1][x]:setType(MusicGameEnum.BlockType.NoDisturb)
			end

			if self._blockMap[y + 1] and self._blockMap[y + 1][x] then
				self._blockMap[y + 1][x]:setType(MusicGameEnum.BlockType.NoDisturb)
			end

			if self._blockMap[y][x - 1] then
				self._blockMap[y][x - 1]:setType(MusicGameEnum.BlockType.NoDisturb)
			end

			if self._blockMap[y][x + 1] then
				self._blockMap[y][x + 1]:setType(MusicGameEnum.BlockType.NoDisturb)
			end

			if #self._mainBlockLines > 1 then
				local dir = MusicGameEnum.Direction.Up

				if y - self._mainBlockLines[#self._mainBlockLines].y > 0 then
					dir = MusicGameEnum.Direction.Down
				elseif y - self._mainBlockLines[#self._mainBlockLines].y < 0 then
					dir = MusicGameEnum.Direction.Up
				elseif x - self._mainBlockLines[#self._mainBlockLines].x > 0 then
					dir = MusicGameEnum.Direction.Right
				elseif x - self._mainBlockLines[#self._mainBlockLines].x < 0 then
					dir = MusicGameEnum.Direction.Left
				end

				sameDirCount = dir == dirs[#dirs] and sameDirCount + 1 or 0

				table.insert(dirs, dir)
			end

			table.insert(self._mainBlockLines, self._blockMap[y][x])

			if #self._mainBlockLines >= lineLength then
				return
			end

			local upValue = self:_couldReach(x, y - 1, MusicGameEnum.BlockType.Main) and y or 0

			if self:_couldReach(x, y + 1, MusicGameEnum.BlockType.Main) then
				if not (line - y) then
					local downValue = 0
					local leftValue = self:_couldReach(x - 1, y, MusicGameEnum.BlockType.Main) and x or 0

					if self:_couldReach(x + 1, y, MusicGameEnum.BlockType.Main) then
						if not (row - x) then
							local rightValue = 0
							local maxSameDirCount = MusicGameConfig.instance:getConstNumberValue(MusicGameEnum.ConstId.MaxSameDirCount)

							if maxSameDirCount <= sameDirCount then
								if dirs[#dirs] == MusicGameEnum.Direction.Up then
									upValue = 0
								elseif dirs[#dirs] == MusicGameEnum.Direction.Down then
									downValue = 0
								elseif dirs[#dirs] == MusicGameEnum.Direction.Left then
									leftValue = 0
								elseif dirs[#dirs] == MusicGameEnum.Direction.Right then
									rightValue = 0
								end
							end

							if dirs and #dirs > 2 then
								local hasOppositeDir = false
								local lastYDir

								if dirs[#dirs] == MusicGameEnum.Direction.Left then
									for i = #dirs - 1, 1, -1 do
										if not lastYDir and (dirs[i] == MusicGameEnum.Direction.Up or dirs[i] == MusicGameEnum.Direction.Down) then
											lastYDir = dirs[i]
										end

										if dirs[i] == MusicGameEnum.Direction.Right then
											hasOppositeDir = true

											break
										end
									end

									if hasOppositeDir then
										if lastYDir == MusicGameEnum.Direction.Up then
											downValue = 0
										elseif lastYDir == MusicGameEnum.Direction.Down then
											upValue = 0
										end
									end
								elseif dirs[#dirs] == MusicGameEnum.Direction.Right then
									rightValue = 0
								end
							end

							local dir = MusicGameUtil.getRandomIndex({
								upValue,
								rightValue,
								downValue,
								leftValue
							})

							if upValue + downValue + leftValue + rightValue <= 0 then
								return
							end

							if dir == MusicGameEnum.Direction.Up then
								getNextBlockLine(x, y - 1)
							elseif dir == MusicGameEnum.Direction.Right then
								getNextBlockLine(x + 1, y)
							elseif dir == MusicGameEnum.Direction.Down then
								getNextBlockLine(x, y + 1)
							elseif dir == MusicGameEnum.Direction.Left then
								getNextBlockLine(x - 1, y)
							end
						end
					end
				end
			end
		end

		local startX, startY = self:getStartMainPos()

		getNextBlockLine(startX, startY)
	end

	if lineLength > #self._mainBlockLines then
		return nil
	end

	return self._mainBlockLines
end

function MusicGameModel:_couldReach(x, y, type)
	if not self._blockMap[y] or not self._blockMap[y][x] then
		return false
	end

	if type <= self._blockMap[y][x].type then
		return false
	end

	return true
end

function MusicGameModel:setMainBlockLinesType()
	local length = #self._mainBlockLines

	if length <= 0 then
		return
	end

	self._mainBlockLines[1]:setNoteType(MusicGameEnum.BlockNoteType.Do)

	if length <= 1 then
		return
	end

	self._mainBlockLines[length]:setNoteType(MusicGameEnum.BlockNoteType.Doi)

	if length <= 2 then
		return
	end

	local randomGroups = MusicGameUtil.getRandomSplitGroups(length - 2, MusicGameEnum.MusicNoteCount - 2)

	for index = 1, length - 2 do
		local type = MusicGameEnum.BlockNoteType.Do
		local blockMo = self._mainBlockLines[index + 1]
		local count = 0

		for i = 1, #randomGroups do
			if index <= count + randomGroups[i] then
				type = i + MusicGameEnum.BlockNoteType.Do

				break
			else
				count = count + randomGroups[i]
			end
		end

		self._blockMap[blockMo.y][blockMo.x]:setNoteType(type)
	end
end

function MusicGameModel:getBranchBlockLines()
	if not self._branchBlockLines or #self._branchBlockLines == 0 then
		self._branchBlockLines = {}

		local posStr = MusicGameConfig.instance:getConstValue(MusicGameEnum.ConstId.BranchStartPoint)
		local rangeStrs = string.split(posStr, "|")

		for _, rangeStr in ipairs(rangeStrs) do
			local range = string.splitToNumber(rangeStr, "#")
			local startIndex = math.random(range[1], range[2])
			local startBlockMo = self._mainBlockLines[startIndex]

			if startBlockMo then
				self:_genBranchBlockLine(startBlockMo)
			end
		end
	end

	return self._branchBlockLines
end

function MusicGameModel:getBranchBlockLineLength()
	local lengthStr = MusicGameConfig.instance:getConstValue(MusicGameEnum.ConstId.BranchLength)
	local lengths = string.splitToNumber(lengthStr, "#")

	return (math.random(lengths[1] + 1, lengths[2] + 1))
end

function MusicGameModel:_genBranchBlockLine(startBlockMo)
	local lineLength = self:getBranchBlockLineLength()
	local branchLine = {}

	local function getNextBlockLine(x, y)
		if not self._blockMap[y] or not self._blockMap[y][x] then
			return
		end

		self._blockMap[y][x]:setType(MusicGameEnum.BlockType.Branch)

		if self._blockMap[y - 1] and self._blockMap[y - 1][x] then
			self._blockMap[y - 1][x]:setType(MusicGameEnum.BlockType.NoDisturb)
		end

		if self._blockMap[y + 1] and self._blockMap[y + 1][x] then
			self._blockMap[y + 1][x]:setType(MusicGameEnum.BlockType.NoDisturb)
		end

		if self._blockMap[y][x - 1] then
			self._blockMap[y][x - 1]:setType(MusicGameEnum.BlockType.NoDisturb)
		end

		if self._blockMap[y][x + 1] then
			self._blockMap[y][x + 1]:setType(MusicGameEnum.BlockType.NoDisturb)
		end

		table.insert(branchLine, self._blockMap[y][x])

		if #branchLine >= lineLength then
			return
		end

		local upValue = self:_couldReach(x, y - 1, MusicGameEnum.BlockType.Branch) and 1 or 0
		local downValue = self:_couldReach(x, y + 1, MusicGameEnum.BlockType.Branch) and 1 or 0
		local leftValue = self:_couldReach(x - 1, y, MusicGameEnum.BlockType.Branch) and 1 or 0
		local rightValue = self:_couldReach(x + 1, y, MusicGameEnum.BlockType.Branch) and 1 or 0

		if upValue + downValue + leftValue + rightValue <= 0 then
			return
		end

		local dir = MusicGameUtil.getRandomIndex({
			upValue,
			rightValue,
			downValue,
			leftValue
		})
		local nextX, nextY = x, y

		if dir == MusicGameEnum.Direction.Up then
			nextY = y - 1
		elseif dir == MusicGameEnum.Direction.Right then
			nextX = x + 1
		elseif dir == MusicGameEnum.Direction.Down then
			nextY = y + 1
		elseif dir == MusicGameEnum.Direction.Left then
			nextX = x - 1
		end

		getNextBlockLine(nextX, nextY)
	end

	getNextBlockLine(startBlockMo.x, startBlockMo.y)
	table.insert(self._branchBlockLines, branchLine)

	return branchLine
end

function MusicGameModel:setBranchBlockLinesType()
	for _, branchLine in ipairs(self._branchBlockLines) do
		local length = #branchLine

		if length > 1 then
			branchLine[length]:setNoteType(MusicGameEnum.BlockNoteType.Doi)
		end

		if length > 2 then
			local startNodeType = branchLine[1].noteType
			local groupCount = MusicGameEnum.MusicNoteCount - startNodeType - 1
			local randomGroups = MusicGameUtil.getRandomSplitGroups(length - 2, groupCount)

			for index = 2, length - 1 do
				local type = startNodeType
				local count = 0
				local blockMo = branchLine[index]

				for i = 1, #randomGroups do
					if index - 1 <= count + randomGroups[i] then
						type = startNodeType + i - 1

						break
					else
						count = count + randomGroups[i]
					end
				end

				self._blockMap[blockMo.y][blockMo.x]:setNoteType(type)
			end
		end
	end
end

function MusicGameModel:getDisturbBlockLines()
	local lineLength = self:getDisturbBlockLineLength()
	local randomBlocks = {}

	for y = 1, #self._blockMap do
		for x = 1, #self._blockMap[y] do
			local blockMo = self._blockMap[y][x]

			if blockMo.type == MusicGameEnum.BlockType.Random then
				table.insert(randomBlocks, blockMo)
			end
		end
	end

	if #randomBlocks == 0 then
		return
	end

	local function getNextBlockLine(x, y)
		if not self._blockMap[y] or not self._blockMap[y][x] then
			return
		end

		self._blockMap[y][x]:setType(MusicGameEnum.BlockType.Disturb)
		table.insert(self._disturbBlockLines, self._blockMap[y][x])

		if #self._disturbBlockLines >= lineLength then
			return
		end

		local upValue = self:_couldReach(x, y - 1, MusicGameEnum.BlockType.Disturb) and 1 or 0
		local downValue = self:_couldReach(x, y + 1, MusicGameEnum.BlockType.Disturb) and 1 or 0
		local leftValue = self:_couldReach(x - 1, y, MusicGameEnum.BlockType.Disturb) and 1 or 0
		local rightValue = self:_couldReach(x + 1, y, MusicGameEnum.BlockType.Disturb) and 1 or 0

		if upValue + downValue + leftValue + rightValue <= 0 then
			return
		end

		local dir = MusicGameUtil.getRandomIndex({
			upValue,
			rightValue,
			downValue,
			leftValue
		})
		local nextX, nextY = x, y

		if dir == MusicGameEnum.Direction.Up then
			nextY = y - 1
		elseif dir == MusicGameEnum.Direction.Right then
			nextX = x + 1
		elseif dir == MusicGameEnum.Direction.Down then
			nextY = y + 1
		elseif dir == MusicGameEnum.Direction.Left then
			nextX = x - 1
		end

		getNextBlockLine(nextX, nextY)
	end

	local startBlockMo = randomBlocks[math.random(1, #randomBlocks)]

	getNextBlockLine(startBlockMo.x, startBlockMo.y)

	return self._disturbBlockLines
end

function MusicGameModel:setDisturbBlockLinesType()
	local length = #self._disturbBlockLines

	if length <= 0 then
		return
	end

	self._disturbBlockLines[1]:setNoteType(MusicGameEnum.BlockNoteType.Do)

	if length <= 1 then
		return
	end

	self._disturbBlockLines[length]:setNoteType(MusicGameEnum.BlockNoteType.Doi)

	if length <= 2 then
		return
	end

	local randomGroups = MusicGameUtil.getRandomSplitGroups(length - 2, MusicGameEnum.MusicNoteCount - 2)

	for index = 1, length - 2 do
		local type = MusicGameEnum.BlockNoteType.Do
		local blockMo = self._disturbBlockLines[index + 1]
		local count = 0

		for i = 1, #randomGroups do
			if index <= count + randomGroups[i] then
				type = i + MusicGameEnum.BlockNoteType.Do

				break
			else
				count = count + randomGroups[i]
			end
		end

		self._blockMap[blockMo.y][blockMo.x]:setNoteType(type)
	end
end

function MusicGameModel:getDisturbBlockLineLength()
	local lengthStr = MusicGameConfig.instance:getConstValue(MusicGameEnum.ConstId.DisturbLength)
	local lengths = string.splitToNumber(lengthStr, "#")

	return (math.random(lengths[1], lengths[2]))
end

function MusicGameModel:setOtherBlockType()
	for y = 1, #self._blockMap do
		for x = 1, #self._blockMap[y] do
			if self._blockMap[y][x].type == MusicGameEnum.BlockType.Random then
				local startIndex, endIndex = self:getRandomNoteTypeRange()

				self._blockMap[y][x]:setNoteType(math.random(startIndex, endIndex))
			end

			if self._blockMap[y][x].type == MusicGameEnum.BlockType.NoDisturb then
				local startIndex, endIndex = self:getRandomNoteTypeRange()

				self._blockMap[y][x]:setNoteType(math.random(startIndex, endIndex))
			end
		end
	end
end

function MusicGameModel:getRandomNoteTypeRange()
	local startIndex = 1
	local endIndex = MusicGameEnum.MusicNoteCount
	local dotTop = self:isNoteTypeDoReachTop()
	local doiTop = self:isNoteTypeDoiReachTop()

	if dotTop then
		startIndex = startIndex + 1
	end

	if doiTop then
		endIndex = endIndex - 1
	end

	return startIndex, endIndex
end

function MusicGameModel:isNoteTypeDoReachTop()
	local count = 0

	for y = 1, #self._blockMap do
		for x = 1, #self._blockMap[y] do
			if self._blockMap[y][x].noteType == MusicGameEnum.BlockNoteType.Do then
				count = count + 1

				if count >= 5 then
					return true
				end
			end
		end
	end

	return false
end

function MusicGameModel:isNoteTypeDoiReachTop()
	local count = 0

	for y = 1, #self._blockMap do
		for x = 1, #self._blockMap[y] do
			if self._blockMap[y][x].noteType == MusicGameEnum.BlockNoteType.Doi then
				count = count + 1

				if count >= 5 then
					return true
				end
			end
		end
	end

	return false
end

function MusicGameModel:getMapBlockDataByPos(x, y)
	if self._blockMap[y] and self._blockMap[y][x] then
		return self._blockMap[y][x]
	end

	return nil
end

function MusicGameModel:getBlockDataById(blockId)
	local line, row = self:getMapLineAndRowCount()

	for y = 1, line do
		if not self._blockMap[y] then
			return nil
		end

		for x = 1, row do
			local block = self._blockMap[y][x]

			if block and block.id == blockId then
				return block
			end
		end
	end

	return nil
end

function MusicGameModel:getSelectedBlockLines()
	return self._selectedBlockLines
end

function MusicGameModel:backSelectedBlockLines()
	if #self._selectedBlockLines > 0 then
		table.remove(self._selectedBlockLines, #self._selectedBlockLines)

		if #self._selectedBlockLines == 1 then
			self._selectedBlockLines = {}
		end
	end
end

function MusicGameModel:addSelectedBlockLines(blockId)
	local couldConnect = self:isBlockCouldConnect(blockId)

	if not couldConnect then
		return
	end

	self._selectedBlockLines = self._selectedBlockLines or {}

	table.insert(self._selectedBlockLines, blockId)
end

function MusicGameModel:isBlockCouldConnect(blockId)
	if not self._selectedBlockLines or #self._selectedBlockLines < 1 then
		return true
	end

	local hasConnect = self:isSelectedBlockLines(blockId)

	if hasConnect then
		return false
	end

	local lastBlockId = self._selectedBlockLines[#self._selectedBlockLines]
	local lastBlockMo = self:getBlockDataById(lastBlockId)

	if not lastBlockMo then
		return false
	end

	local curBlockMo = self:getBlockDataById(blockId)

	if not curBlockMo then
		return false
	end

	if lastBlockMo.noteType > curBlockMo.noteType then
		return false
	end

	return true
end

function MusicGameModel:clearSelectedBlockLines()
	self._selectedBlockLines = {}
end

function MusicGameModel:isSelectedBlockLines(blockId)
	if not self._selectedBlockLines or #self._selectedBlockLines < 1 then
		return false
	end

	return (LuaUtil.tableContains(self._selectedBlockLines, blockId))
end

function MusicGameModel:getBlockConnects(blockId)
	local isSelected = self:isSelectedBlockLines(blockId)

	if not isSelected then
		return nil, nil
	end

	for i = 1, #self._selectedBlockLines do
		if self._selectedBlockLines[i] == blockId then
			return self._selectedBlockLines[i - 1], self._selectedBlockLines[i + 1]
		end
	end

	return nil, nil
end

function MusicGameModel:getGameScoreMulti()
	local isFirstShow = self:isFirstShow()
	local ctrlCo = MusicGameConfig.instance:getCtrlCo()

	if not ctrlCo then
		return 1
	end

	if isFirstShow then
		if not ctrlCo.magnificationRate then
			return 1
		end
	end
end

function MusicGameModel:getGameScoreLv(score)
	local lvCos = MusicGameConfig.instance:getLevelCos()

	if not lvCos then
		return 1
	end

	for i = #lvCos, 1, -1 do
		if score >= lvCos[i].score then
			return lvCos[i].level
		end
	end

	return 1
end

function MusicGameModel:getMaxScore()
	local lvCos = MusicGameConfig.instance:getBonusCos()

	if not lvCos then
		return 0
	end

	return lvCos[#lvCos].coinNum
end

function MusicGameModel:getCurScore()
	local score = 0
	local connectLength = #self._selectedBlockLines

	if connectLength > 0 then
		local baseScore = MusicGameConfig.instance:getConstNumberValue(MusicGameEnum.ConstId.BaseScore)
		local extraStr = MusicGameConfig.instance:getConstValue(MusicGameEnum.ConstId.ComboScore)
		local extraScores = string.splitToNumber(extraStr, "#")

		if not extraScores or #extraScores < 2 then
			logError(string.format("please check const Value %s config and it cause score error!", MusicGameEnum.ConstId.ComboScore))

			return 0
		end

		score = baseScore * connectLength + math.floor(connectLength / extraScores[1]) * extraScores[2]
	end

	return score
end

function MusicGameModel:isFirstShow()
	local actId = VersionActivity4_0Enum.ActivityId.ConcertMusicGame

	return (GuessGameModel.instance:isFirstShow(actId))
end

function MusicGameModel:getTotalScore()
	local actId = VersionActivity4_0Enum.ActivityId.ConcertMusicGame

	return (GuessGameModel.instance:getTotalScore(actId))
end

function MusicGameModel:isRewardLock(rewardId)
	local actId = VersionActivity4_0Enum.ActivityId.ConcertMusicGame

	return (GuessGameModel.instance:isRewardLock(rewardId, actId))
end

function MusicGameModel:isRewardGet(rewardId)
	local actId = VersionActivity4_0Enum.ActivityId.ConcertMusicGame

	return (GuessGameModel.instance:isRewardGet(rewardId, actId))
end

function MusicGameModel:isRewardCanGet(rewardId)
	local actId = VersionActivity4_0Enum.ActivityId.ConcertMusicGame

	return (GuessGameModel.instance:isRewardCanGet(rewardId, actId))
end

function MusicGameModel:showScoreTipReddot(actId)
	actId = actId or VersionActivity4_0Enum.ActivityId.ConcertMusicGame

	local musicGameScoreTip = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.MusicGameScoreShow), "")
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()

	if isExpire then
		return false
	end

	local isUnlock = actInfoMo:isOnline() and actInfoMo:isOpen()

	if not isUnlock then
		return false
	end

	local isFirstShow = self:isFirstShow()

	if not isFirstShow then
		return false
	end

	local totalScore = self:getTotalScore()
	local maxScore = self:getMaxScore()

	if maxScore <= totalScore then
		return false
	end

	if LuaUtil.isEmptyStr(musicGameScoreTip) then
		return true
	end

	local time = tonumber(musicGameScoreTip)
	local isSameDay = TimeUtil.isSameDay(time - TimeDispatcher.DailyRefreshSecond, ServerTime.now() - TimeDispatcher.DailyRefreshSecond)

	return not isSameDay
end

MusicGameModel.instance = MusicGameModel.New()

return MusicGameModel
