-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\MiniGameMixin.lua

local ResClimbTowerLevel = require("ClientData/ResClimbTowerLevel")
local ResClimbTowerBigAward = require("ClientData/ResClimbTowerBigAward")
local UserData = require("Helper/UserData")
local ResMiniGameMisc = require("ClientData/ResMiniGameMisc")
local MiniGameMixin = {}

function MiniGameMixin:initMiniGameMixin(baseData, syncData)
	if self:miniGameEnable() then
		self:initMiniGameData(syncData.other)
	end
end

function MiniGameMixin:initCheckMiniGameMixin(...)
	if self:miniGameEnable() then
		self:checkAllHasBigAwardCanGet()
		self:checkMainEnterRed()
		self:checkHaveNewTypeMiniGame()
	end
end

function MiniGameMixin:destroyMiniGameMixin(...)
	return
end

function MiniGameMixin:postinitMiniGameMixin(baseData, syncData)
	return
end

function MiniGameMixin:miniGameEnable()
	return Const.MINI_GAME_OPEN and Const.MINI_GAME_CHANNELS[ChannelUtil.getSubChannelID()] ~= nil
end

function MiniGameMixin:forbidWorldChannel()
	return self:miniGameEnable() and ClientUtils.getServerTime() - CurAvatar.roleCreateTick <= 604800
end

function MiniGameMixin:initMiniGameData(otherData)
	self.miniGameData = {}

	for type, v in pairs(Const.MINI_GAME_TYPE) do
		local data = {}

		data.chapter = 1
		data.stage = 0
		data.bigAward = {}
		data.stageAward = {}
		self.miniGameData[type] = data
	end

	for i, data in pairs(otherData.relaxing_games.data) do
		local copyData = utils.deepcopy(data)

		if copyData.chapter == 0 then
			copyData.chapter = 1
		end

		local stageAward = ClientUtils.getBitsDictFromByteString(data.stage_award)
		local bigAward = ClientUtils.getBitsDictFromByteString(data.big_award)

		copyData.bigAward = bigAward
		copyData.stageAward = stageAward
		self.miniGameData[copyData.type] = copyData
	end

	self.firstSelectGameType = otherData.relaxing_games.first_type or 0
end

function MiniGameMixin:getPassChapterAndStage(type)
	return self.miniGameData[type].chapter, self.miniGameData[type].stage
end

function MiniGameMixin:getChapterAndStage(type)
	local gameData = self.miniGameData[type]
	local chapter = gameData.chapter
	local stage = gameData.stage

	if chapter == 0 then
		chapter = 1
	end

	if stage == #ResClimbTowerLevel[chapter] then
		if chapter < #ResClimbTowerLevel then
			chapter = chapter + 1
			stage = 1
		end
	else
		stage = stage + 1
	end

	return chapter, stage
end

function MiniGameMixin:isPassChapterAndStage(type, chapter, stage)
	local gameData = self.miniGameData[type] or {}
	local passChapter = gameData.chapter or 1
	local passChapter, passStage = passChapter, gameData.stage or 0

	return chapter < passChapter or chapter == passChapter and stage <= passStage
end

function MiniGameMixin:checkBeginnerTrigger(type)
	local chapter, stage = CurAvatar:getChapterAndStage(type)

	BeginnerManager.onTrigger(Const.BEGINNER_TRIGGER_MINI_GAME, {
		type,
		chapter,
		stage
	})
end

function MiniGameMixin:checkPassGame(type)
	local gameData = self.miniGameData[type] or {}
	local chapter = gameData.chapter or 0
	local stage = gameData.stage or 0

	if chapter ~= 0 and chapter == #ResClimbTowerLevel and stage == #ResClimbTowerLevel[chapter] then
		return true
	end

	return false
end

function MiniGameMixin:checkAllHasBigAwardCanGet()
	local isHave = false

	for type, v in pairs(Const.MINI_GAME_TYPE) do
		if self:checkHasBigAwardByType(type) then
			isHave = true
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_MINI_GAME, isHave)

	return isHave
end

function MiniGameMixin:checkHasBigAwardByType(type)
	local passChapter, passStage = self:getPassChapterAndStage(type)

	for i, data in ipairs(ResClimbTowerBigAward) do
		local needPassStage = data.pass_stage
		local chapter = needPassStage[1]
		local stage = needPassStage[2]
		local isPass = chapter < passChapter or chapter == passChapter and stage <= passStage

		if isPass and not self.miniGameData[type].bigAward[i] then
			return true
		end
	end

	return false
end

function MiniGameMixin:checkShowMainEnter()
	if self:miniGameEnable() then
		local isPassFirstGame = self:checkPassGame(self.firstSelectGameType)

		if not isPassFirstGame then
			local conditionId = ResMiniGameMisc[1] and ResMiniGameMisc[1].main_enter_condition or nil

			if conditionId and ConditionLimitManager.inLimitState(conditionId) or conditionId == nil then
				return true
			end
		end
	end

	return false
end

function MiniGameMixin:checkMainEnterRed()
	local isShow = false

	if self:checkShowMainEnter() and self.firstSelectGameType and self.firstSelectGameType ~= 0 then
		local chapter, stage = self:getChapterAndStage(self.firstSelectGameType)
		local conditionId = ResClimbTowerLevel[chapter][stage].condition_id

		if not ConditionLimitManager.inLimitState(conditionId) then
			isShow = true
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_MINI_GAME_MAIN_MENU, isShow)

	return isShow
end

function MiniGameMixin:checkHaveNewTypeMiniGame()
	local isHave = false

	if not self:checkShowMainEnter() then
		local alreadyPlayStr = UserData.loadCommonData("MiniGamePlayType" .. self.uid)
		local alreadyPlay = ClientUtils.string2Table(alreadyPlayStr)

		for type, info in pairs(Const.MINI_GAME_INFO) do
			if not alreadyPlay[type] then
				RedDotManager.setKeyState(UIConst.RD_HINT_MINI_GAME, true)

				isHave = true
			end
		end
	end

	return isHave
end

function MiniGameMixin:checkHideCloseBtn()
	if self:miniGameEnable() then
		if CurAvatar:mainStageStatePassed(1, 1, 1) then
			return false
		end

		local limitClose = ResMiniGameMisc[1] and ResMiniGameMisc[1].limit_close_stage or {
			1,
			3
		}
		local chapter = limitClose[1]
		local stage = limitClose[2]

		if self.firstSelectGameType and self.firstSelectGameType ~= 0 then
			if not self:isPassChapterAndStage(self.firstSelectGameType, chapter, stage) then
				return true
			end
		else
			return true
		end
	end

	return false
end

function MiniGameMixin:onRelaxingGamePassResp(type, chapter, stage)
	local typeIndex = Const.MINI_GAME_TYPE_DIC[type]

	if not self.miniGameData[typeIndex] then
		self.miniGameData[typeIndex] = {}
	end

	self.miniGameData[typeIndex].chapter = chapter
	self.miniGameData[typeIndex].stage = stage

	self:checkAllHasBigAwardCanGet()
	self:checkMainEnterRed()

	local mainDlg = UIManager.tryGetUI("miniGameMainDlg")

	if mainDlg then
		mainDlg:refreshPanel()
	end

	UIManager.getUI("miniGameShowAwardDlg", true):setData(typeIndex)
end

function MiniGameMixin:onRelaxingGameChooseFirstGameResp(type)
	self.firstSelectGameType = Const.MINI_GAME_TYPE_DIC[type]
end

function MiniGameMixin:onRelaxingGameGetBigAwardResp(id, type)
	local typeIndex = Const.MINI_GAME_TYPE_DIC[type]

	if not self.miniGameData[typeIndex] then
		self.miniGameData[typeIndex] = {}
	end

	if not self.miniGameData[typeIndex].bigAward then
		self.miniGameData[typeIndex].bigAward = {}
	end

	self.miniGameData[typeIndex].bigAward[id] = true

	self:checkAllHasBigAwardCanGet()

	local infoDlg = UIManager.tryGetUI("miniGameInfoDlg")

	if infoDlg then
		infoDlg:refreshBigAwardPanel()
	end

	local mainDlg = UIManager.tryGetUI("miniGameMainDlg")

	if mainDlg then
		mainDlg:refreshPanel()
	end
end

return MiniGameMixin
