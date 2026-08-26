-- chunkname: @modules/logic/versionactivity1_3/common/Stat1_3Controller.lua

module("modules.logic.versionactivity1_3.common.Stat1_3Controller", package.seeall)

local Stat1_3Controller = class("Stat1_3Controller")

function Stat1_3Controller:trackUnlockBuff(msg)
	local needCheckBuffIdList = {}

	for _, buffId in ipairs(msg.buffs) do
		table.insert(needCheckBuffIdList, buffId)
	end

	for _, buffId in ipairs(msg.spBuffs) do
		table.insert(needCheckBuffIdList, buffId)
	end

	local lastEpisodeId = 0
	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei)

	for i = #episodeList, 1, -1 do
		local config = episodeList[i]
		local dungeonMo = config and DungeonModel.instance:getEpisodeInfo(config.id) or nil

		if dungeonMo and dungeonMo.star > 0 then
			lastEpisodeId = config.id

			break
		end
	end

	for _, buffId in ipairs(needCheckBuffIdList) do
		if not Activity126Model.instance:hasBuff(buffId) then
			local buffConfig = lua_activity126_buff.configDict[buffId]

			if buffConfig then
				if not buffConfig.name then
					local buffName = ""

					if string.nilorempty(buffName) then
						logError(string.format("not found buffId : %s name", buffId))
					end

					StatController.instance:track(StatEnum.EventName.UnlockBuff, {
						[StatEnum.EventProperties.BuffName] = buffName,
						[StatEnum.EventProperties.PlotProgress3] = tostring(lastEpisodeId)
					})
				end
			end
		end
	end
end

Stat1_3Controller.BristleFailReasonEnum = {
	[0] = "",
	"生命值为0",
	"触碰即死陷阱",
	"玩家没有任何格子走",
	"战斗失败",
	"卡邦克鲁跟扣血怪物交互",
	"回合上限"
}

function Stat1_3Controller:bristleStatStart()
	self.bristleStartTime = ServerTime.now()
	self.bristleUseRead = false
end

function Stat1_3Controller:bristleMarkUseRead()
	self.bristleUseRead = true
end

function Stat1_3Controller:bristleStatSuccess()
	self:bristleStatEnd(StatEnum.Result.Success)
end

function Stat1_3Controller:bristleStatFail()
	self:bristleStatEnd(StatEnum.Result.Fail)
end

function Stat1_3Controller:bristleStatAbort()
	self:bristleStatEnd(StatEnum.Result.Abort)
end

function Stat1_3Controller:bristleStatReset()
	self:bristleStatEnd(StatEnum.Result.Reset)
	self:bristleStatStart()
end

function Stat1_3Controller:bristleStatEnd(result)
	if not self.bristleStartTime then
		return
	end

	if self.waitingRpc then
		return
	end

	self.useTime = ServerTime.now() - self.bristleStartTime
	self.mapId = Va3ChessGameModel.instance:getMapId()
	self.round = Va3ChessGameModel.instance:getRound()

	if result == StatEnum.Result.Abort or result == StatEnum.Result.Reset then
		self.round = self.round - 1
	end

	self.goalNum = Va3ChessGameModel.instance:getFinishGoalNum()
	self.episodeId = Va3ChessModel.instance:getEpisodeId()
	self.hp = Va3ChessGameModel.instance:getHp()

	if result == StatEnum.Result.Fail then
		local var_8_0 = Stat1_3Controller.BristleFailReasonEnum[Va3ChessGameModel.instance:getFailReason() or 0]

		if not Stat1_3Controller.BristleFailReasonEnum[Va3ChessGameModel.instance:getFailReason() or 0] then
			self.failReason = ""
		end
	else
		self.failReason = ""
	end

	self.result = result
	self.recordBristleUseRead = self.bristleUseRead
	self.waitingRpc = true
	self.bristleStartTime = nil

	Activity122Rpc.instance:sendGetActInfoRequest(VersionActivity1_3Enum.ActivityId.Act304, self._onReceive122Msg, self)
end

function Stat1_3Controller:_onReceive122Msg()
	local episodeMo = Activity122Model.instance:getEpisodeData(self.episodeId)

	if episodeMo then
		if not episodeMo.totalCount then
			local challengesNum = 0

			self.waitingRpc = false

			StatController.instance:track(StatEnum.EventName.ExitBristle, {
				[StatEnum.EventProperties.UseTime] = self.useTime,
				[StatEnum.EventProperties.EpisodeId] = tostring(self.episodeId),
				[StatEnum.EventProperties.ChallengesNum] = challengesNum,
				[StatEnum.EventProperties.RoundNum] = self.round,
				[StatEnum.EventProperties.GoalNum] = self.goalNum,
				[StatEnum.EventProperties.HearthValue] = self.hp,
				[StatEnum.EventProperties.Result] = self.result,
				[StatEnum.EventProperties.FailReason] = self.failReason,
				[StatEnum.EventProperties.UseRead] = self.recordBristleUseRead
			})
		end
	end
end

Stat1_3Controller.JiaLaBoNaFailReasonEnum = {
	[Va3ChessEnum.FailReason.None] = "",
	[Va3ChessEnum.FailReason.Battle] = "战斗失败",
	[Va3ChessEnum.FailReason.CanNotMove] = "无路可走",
	[Va3ChessEnum.FailReason.MaxRound] = "精力为0",
	[Va3ChessEnum.FailReason.FailInteract] = "触发失败元件"
}

function Stat1_3Controller:jiaLaBoNaStatStart()
	self.jiaLaBoNaStartTime = ServerTime.now()
	self.jiaLaBoNaUseRead = false
end

function Stat1_3Controller:jiaLaBoNaMarkUseRead()
	self.jiaLaBoNaUseRead = true
end

function Stat1_3Controller:jiaLaBoNaStatSuccess()
	self:jiaLaBoNaStatEnd(StatEnum.Result.Success)
end

function Stat1_3Controller:jiaLaBoNaStatFail()
	self:jiaLaBoNaStatEnd(StatEnum.Result.Fail)
end

function Stat1_3Controller:jiaLaBoNaStatAbort()
	self:jiaLaBoNaStatEnd(StatEnum.Result.Abort)
end

function Stat1_3Controller:jiaLaBoNaStatReset()
	self:jiaLaBoNaStatEnd(StatEnum.Result.Reset)
end

function Stat1_3Controller:jiaLaBoNaStatEnd(result)
	if not self.jiaLaBoNaStartTime then
		return
	end

	if self.waitingRpc then
		return
	end

	self.useTime = ServerTime.now() - self.jiaLaBoNaStartTime
	self.mapId = Va3ChessGameModel.instance:getMapId()
	self.round = Va3ChessGameModel.instance:getRound()

	if result == StatEnum.Result.Abort or result == StatEnum.Result.Reset then
		self.round = self.round - 1
	end

	self.goalNum = Va3ChessGameModel.instance:getFinishGoalNum()
	self.episodeId = Va3ChessModel.instance:getEpisodeId()
	self.hp = Va3ChessGameModel.instance:getHp()

	if result == StatEnum.Result.Fail then
		local var_16_0 = Stat1_3Controller.JiaLaBoNaFailReasonEnum[Va3ChessGameModel.instance:getFailReason() or 0]

		if not Stat1_3Controller.JiaLaBoNaFailReasonEnum[Va3ChessGameModel.instance:getFailReason() or 0] then
			self.failReason = ""
		end
	else
		self.failReason = ""
	end

	self.result = result
	self.recordJiaLaBoNaUseRead = self.jiaLaBoNaUseRead
	self.waitingRpc = true
	self.jiaLaBoNaStartTime = nil

	Activity120Rpc.instance:sendGetActInfoRequest(VersionActivity1_3Enum.ActivityId.Act306, self._onReceive120Msg, self)
end

function Stat1_3Controller:_onReceive120Msg()
	local episodeMo = Activity120Model.instance:getEpisodeData(self.episodeId)

	if episodeMo then
		if not episodeMo.totalCount then
			local challengesNum = 0

			self.waitingRpc = false

			StatController.instance:track(StatEnum.EventName.ExitGalaBona, {
				[StatEnum.EventProperties.UseTime] = self.useTime,
				[StatEnum.EventProperties.EpisodeId] = tostring(self.episodeId),
				[StatEnum.EventProperties.ChallengesNum] = challengesNum,
				[StatEnum.EventProperties.RoundNum] = self.round,
				[StatEnum.EventProperties.GoalNum] = self.goalNum,
				[StatEnum.EventProperties.HearthValue] = self.hp,
				[StatEnum.EventProperties.Result] = self.result,
				[StatEnum.EventProperties.FailReason] = self.failReason,
				[StatEnum.EventProperties.UseRead] = self.recordJiaLaBoNaUseRead
			})
		end
	end
end

function Stat1_3Controller:armPuzzleStatStart()
	self.puzzleStartTime = ServerTime.now()
end

function Stat1_3Controller:puzzleStatAbort()
	self:puzzleStatEnd(StatEnum.Result.Abort)
end

function Stat1_3Controller:puzzleStatSuccess()
	self:puzzleStatEnd(StatEnum.Result.Success)
end

function Stat1_3Controller:puzzleStatReset()
	self:puzzleStatEnd(StatEnum.Result.Reset)
	self:armPuzzleStatStart()
end

function Stat1_3Controller:puzzleStatEnd(result)
	if not self.puzzleStartTime then
		return
	end

	local episodeCo = ArmPuzzlePipeModel.instance:getEpisodeCo()

	if episodeCo then
		if not episodeCo.episodeId then
			local mapId = ""

			StatController.instance:track(StatEnum.EventName.ExitSokoban, {
				[StatEnum.EventProperties.UseTime] = ServerTime.now() - self.puzzleStartTime,
				[StatEnum.EventProperties.MapId] = tostring(mapId),
				[StatEnum.EventProperties.Result] = result
			})

			self.puzzleStartTime = nil
		end
	end
end

Stat1_3Controller.instance = Stat1_3Controller.New()

return Stat1_3Controller
