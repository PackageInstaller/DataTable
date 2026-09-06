-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mofang/model/MofangModel.lua

module("logic.extensions.mofang.model.MofangModel", package.seeall)

local MofangModel = class("MofangModel", BaseModel)

MofangModel.RewardState = {
	GET = 1,
	LOCK = 0,
	GOT = 2
}

function MofangModel:ctor()
	return
end

function MofangModel:onInit()
	self._hasGainXiaoNuo = true
	self._lvArrCfg = MofangConfig.instance:getLvCfg()
	self._lvlNumMap = {}

	self:updateStageRewardState(0)
end

function MofangModel:onReset()
	self._hasGainXiaoNuo = true
	self._lvlNumMap = {}
end

function MofangModel:getCurNum()
	return MaterialFacade.instance:getMatNumber(MatType.Coin, 6)
end

function MofangModel:isFirstEnterMofangView()
	if not self._isFirstEnterMofangViewInit then
		self._isFirstEnterMofangViewInit = true
		self._isFirstEnterMofangView = GameUtil.isEmptyString(GameUtil.getLocalString(RoleModel.instance:getUserName() .. "_isFirstEnterMofangView")) or false
	end

	return self._isFirstEnterMofangView
end

function MofangModel:setHasEnterMofangView()
	if not self._isFirstEnterMofangView then
		return
	end

	self._isFirstEnterMofangView = false

	GameUtil.setLocalString(RoleModel.instance:getUserName() .. "_isFirstEnterMofangView", "true")
end

function MofangModel:isMax()
	return self:getMaxLv() == self:getCurLv()
end

function MofangModel:getMaxLv()
	local arrCfg = self._lvArrCfg

	return #arrCfg
end

function MofangModel:getUpgradeNeed(lv)
	local arrCfg = self._lvArrCfg
	local len = #arrCfg
	local idx = len < lv + 1 and len or lv + 1

	return arrCfg[idx].lowestTotalExperience
end

function MofangModel:getCurLvAndExp(curNum)
	local curLv = 1
	local curExp = 0
	local curMofangNum = curNum or self:getCurNum()
	local arrCfg = self._lvArrCfg

	for i, v in ipairs(arrCfg) do
		if curMofangNum >= arrCfg[i].lowestTotalExperience then
			curLv = i
			curExp = curMofangNum - arrCfg[i].lowestTotalExperience
		else
			break
		end
	end

	return curLv, curExp
end

function MofangModel:getUpNeedExp(lv)
	local exp = self:getUpgradeNeed(lv)
	local cfg = self:getStageInfo(lv)

	return exp - cfg.lowestTotalExperience
end

function MofangModel:getCurLv(curMofangNum)
	if curMofangNum == nil then
		curMofangNum = self:getCurNum()
	end

	local curLv = 1

	if self._lvlNumMap[curMofangNum] then
		curLv = self._lvlNumMap[curMofangNum]
	else
		local arrCfg = self._lvArrCfg

		for i, v in ipairs(arrCfg) do
			if curMofangNum >= v.lowestTotalExperience then
				curLv = i
			else
				break
			end
		end

		self._lvlNumMap[curMofangNum] = curLv
	end

	return curLv
end

function MofangModel:getOneLowestRewardLv()
	local maxLv = self:getMaxLv()

	for i = 1, maxLv do
		if self:hasAnyReward(i) then
			return i
		end
	end

	return nil
end

function MofangModel:getStageInfo(lv)
	return MofangConfig.instance:getCfgById(lv)
end

function MofangModel:hasRewardBefore(lv)
	local arrCfg = self._lvArrCfg

	lv = lv - 1

	if lv < 1 then
		return false
	end

	if lv > #arrCfg then
		lv = #arrCfg
	end

	for i = 1, lv do
		if self:hasAnyReward(i) then
			return true
		end
	end

	return false
end

function MofangModel:hasRewardAfter(lv)
	local arrCfg = self._lvArrCfg

	lv = lv + 1

	if lv > #arrCfg then
		return false
	end

	if lv < 1 then
		lv = 1
	end

	for i = lv, #arrCfg do
		if self:hasAnyReward(i) then
			return true
		end
	end

	return false
end

function MofangModel:sethasGainXiaoNuo(b)
	self._hasGainXiaoNuo = b

	GlobalDispatcher:dispatch(GlobalNotify.OnGotXiaoNuoStateChange, b)
end

function MofangModel:gethasGainXiaoNuo()
	return self._hasGainXiaoNuo
end

function MofangModel:canGainXiaonuo()
	local b = self:isMax() and not self:gethasGainXiaoNuo()

	printInfo("canGainXiaonuo:" .. tostring(b))

	return b
end

function MofangModel:setHasGotReward(lv)
	self.gainBit = bit.bor(self.gainBit, bit.lshift(1, lv - 1))
	self:getStageInfo(lv).rewardState = MofangModel.RewardState.GOT
end

function MofangModel:updateStageRewardStateForLv()
	self:updateStageRewardState(self.gainBit)
end

function MofangModel:updateStageRewardState(rewardBitInfo)
	printInfo("rewardBitInfo:" .. rewardBitInfo)

	self.gainBit = rewardBitInfo

	local arrCfg = self._lvArrCfg
	local curLv = self:getCurLv()

	for i, v in ipairs(arrCfg) do
		arrCfg[i].rewardState = bit.band(bit.lshift(1, i - 1), rewardBitInfo) > 0 and MofangModel.RewardState.GOT or i <= curLv and MofangModel.RewardState.GET or MofangModel.RewardState.LOCK
	end
end

function MofangModel:updateShenShowRewardState(gainBit)
	if not gainBit then
		error("not shenshou gain bit")

		return
	end

	local cfgs = WuShenConfig.instance:getfuliwushenshouCfgs()

	self._shenShowRewardState = {}

	for k, v in pairs(cfgs) do
		if GameUtil.isBitOpenByDigit(gainBit, checknumber(k)) then
			self._shenShowRewardState[k] = true
		end
	end
end

function MofangModel:hasGotShenShowReward(id)
	if self._shenShowRewardState then
		return self._shenShowRewardState[id]
	end
end

function MofangModel:hasGotAllReward(lv)
	local wsCfg = WuShenConfig.instance:getfuliwushenshouCfgs()[lv]

	if wsCfg then
		return self:hasGotShenShowReward(lv)
	else
		local info = MofangModel.instance:getStageInfo(lv)

		return info.rewardState == MofangModel.RewardState.GOT
	end
end

function MofangModel:hasAnyReward(lv)
	local curLv = self:getCurLv()
	local hasGotReward = self:hasGotAllReward(lv)

	return lv <= curLv and not hasGotReward
end

function MofangModel:setHasGotShenShowReward(id)
	self._shenShowRewardState = self._shenShowRewardState or {}
	self._shenShowRewardState[id] = true
end

local PUZZLE_LIST = {
	1,
	3,
	6,
	9,
	12,
	15,
	18,
	21
}

function MofangModel:getPuzzleList()
	return PUZZLE_LIST
end

function MofangModel:getHasOpenPuzzles()
	if not self._listOpenPuzzle then
		self:_initOpenPuzzleDic()
	end

	return self._listOpenPuzzle
end

function MofangModel:isLastLevel(lv)
	return PUZZLE_LIST[#PUZZLE_LIST] == lv
end

function MofangModel:getOnePuzzleJustOpen()
	local openPuzzles = self:getHasOpenPuzzles()
	local idx = #openPuzzles + 1

	if idx <= #PUZZLE_LIST then
		local lv = PUZZLE_LIST[idx]

		if lv <= self:getCurLv() then
			return lv
		end
	end

	return nil
end

function MofangModel:_initOpenPuzzleDic()
	local str = GameUtil.getLocalString(self:_getOpenPuzzleDicKey())

	if GameUtil.isEmptyString(str) then
		self._listOpenPuzzle = {}
		self._listOpenPuzzleStr = ""
	else
		local list = string.split(str, ",")

		self._listOpenPuzzle = {}

		for i, v in ipairs(list) do
			local id = checknumber(v)

			if id > 0 and not TableUtil.isHad(self._listOpenPuzzle, id) then
				table.insert(self._listOpenPuzzle, id)
			end
		end

		self._listOpenPuzzleStr = str
	end
end

function MofangModel:_getOpenPuzzleDicKey()
	self._openPuzzleDicKey = self._openPuzzleDicKey or RoleModel.instance:getUserName() .. "_openPuzzleDicKey"

	return self._openPuzzleDicKey
end

function MofangModel:isPuzzleOpen(lv)
	local list = self:getHasOpenPuzzles()

	for i, v in ipairs(list) do
		if v == lv then
			return true
		end
	end

	return false
end

function MofangModel:hasAnyPuzzleToPlay()
	return self:getOnePuzzleJustOpen() ~= nil or self:isPuzzleDone() and not self:hasPlayPuzzleDone()
end

function MofangModel:isPuzzleDone()
	local list = self:getHasOpenPuzzles()

	return #list >= #PUZZLE_LIST
end

function MofangModel:hasPlayPuzzleDone()
	return self:isPuzzleDone() and not GameUtil.isEmptyString(self:getPuzzleHasDoneStr())
end

function MofangModel:getPuzzleHasDoneStr()
	self.hasDoneStr = self.hasDoneStr or GameUtil.getLocalString(RoleModel.instance:getUserName() .. "puzzledonekey", self.hasDoneStr)
	self.hasDoneStr = self.hasDoneStr or ""

	return self.hasDoneStr
end

function MofangModel:setPuzzleHasPlayDone()
	if self:isPuzzleDone() then
		self.hasDoneStr = "done"

		GameUtil.setLocalString(RoleModel.instance:getUserName() .. "puzzledonekey", self.hasDoneStr)
		GlobalDispatcher:dispatch(GlobalNotify.OnPuzzleDoGot)
	end
end

function MofangModel:addPuzzle(id)
	if not id or id <= 0 then
		return
	end

	printInfo(string.format("addPuzzle,id:%d", id))

	if not self._listOpenPuzzle then
		self:_initOpenPuzzleDic()
	end

	if self:isPuzzleOpen(lv) then
		printInfo("has already addPuzzle before")

		return
	end

	table.insert(self._listOpenPuzzle, id)

	self._listOpenPuzzleStr = #self._listOpenPuzzle > 1 and self._listOpenPuzzleStr .. "," .. id or "" .. id

	GameUtil.setLocalString(self:_getOpenPuzzleDicKey(), self._listOpenPuzzleStr)
	printInfo("addPuzzle done")
	GlobalDispatcher:dispatch(GlobalNotify.OnPuzzleDoGot)
end

MofangModel.instance = MofangModel.New()

return MofangModel
