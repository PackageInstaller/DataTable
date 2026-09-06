-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/model/LuyngardeModel.lua

module("logic.extensions.luyngarde.model.LuyngardeModel", package.seeall)

local LuyngardeModel = class("LuyngardeModel", BaseModel)

function LuyngardeModel:ctor()
	return
end

function LuyngardeModel:onInit()
	self:onReset()
end

function LuyngardeModel:onReset()
	self._baseInfoMap = {}
	self._chapter2InfoMap = {}
	self._chapter2SimpleRankInfoMap = {}
	self._chapter3InfoMap = {}
	self._chapter4InfoMap = {}
	self._chapter2RankInfoMap = {}
	self._chapter3RankInfoMap = {}
	self._chapter4RankInfoMap = {}
end

function LuyngardeModel:getBaseInfoByActId(actId)
	if not self._baseInfoMap[actId] then
		printInfo("路因嘉德基础数据未初始化")
	end

	return self._baseInfoMap[actId]
end

function LuyngardeModel:getChapter2InfoByActId(actId)
	if not self._chapter2InfoMap[actId] then
		printInfo("路因嘉德第二章节数据未初始化")
	end

	return self._chapter2InfoMap[actId]
end

function LuyngardeModel:getChapter2SimpleRankInfoByActId(actId)
	if not self._chapter2SimpleRankInfoMap[actId] then
		printInfo("路因嘉德第二章节数据未初始化")
	end

	return self._chapter2SimpleRankInfoMap[actId]
end

function LuyngardeModel:getChapter3InfoByActId(actId)
	if not self._chapter3InfoMap[actId] then
		printInfo("路因嘉德第三章节数据未初始化")
	end

	return self._chapter3InfoMap[actId]
end

function LuyngardeModel:getChapter4InfoByActId(actId)
	if not self._chapter4InfoMap[actId] then
		printInfo("路因嘉德第四章节数据未初始化")
	end

	return self._chapter4InfoMap[actId]
end

function LuyngardeModel:getChapter2RankInfo(actId, typeId)
	if self._chapter2RankInfoMap[actId] then
		if not self._chapter2RankInfoMap[actId] then
			printInfo("路因嘉德第二章节排行榜数据未初始化")
		end

		return self._chapter2RankInfoMap[actId]
	end
end

function LuyngardeModel:getChapter3RankInfo(actId)
	if not self._chapter3RankInfoMap[actId] then
		printInfo("路因嘉德第三章节排行榜数据未初始化")
	end

	return self._chapter3RankInfoMap[actId]
end

function LuyngardeModel:getChapter4RankInfo(actId)
	if not self._chapter4RankInfoMap[actId] then
		printInfo("路因嘉德第si章节排行榜数据未初始化")
	end

	return self._chapter4RankInfoMap[actId]
end

function LuyngardeModel:onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._baseInfoMap[info.activityId] = info
end

function LuyngardeModel:onUpgradePet(msg)
	local info = GameUtil.pbToTable(msg)
	local baseInfo = self:getBaseInfoByActId(info.activityId)

	baseInfo.level = info.level
end

function LuyngardeModel:onGetChapter2Info(msg)
	local info = GameUtil.pbToTable(msg)

	self._chapter2InfoMap[info.activityId] = info
end

function LuyngardeModel:onGetChapter2SimpleRankInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._chapter2SimpleRankInfoMap[info.activityId] = info
end

function LuyngardeModel:onGainChapter2Prize(msg)
	local chapter2Info = self:getChapter2InfoByActId(msg.activityId)

	if chapter2Info then
		if not msg.prizeIds then
			if not chapter2Info.gainedPrizeIds then
				local gainedPrizeIds = {}

				for _, id in ipairs(msg.prizeIds) do
					table.insert(gainedPrizeIds, id)
				end

				chapter2Info.gainedPrizeIds = gainedPrizeIds
			end
		end
	end
end

function LuyngardeModel:onGainChapter2KillPrize(msg)
	local chapter2SimpleRankInfo = self:getChapter2SimpleRankInfoByActId(msg.activityId)

	if chapter2SimpleRankInfo then
		chapter2SimpleRankInfo.hadGainKillPrize = true
	end
end

function LuyngardeModel:onGetChapter3Info(msg)
	local info = GameUtil.pbToTable(msg)

	self._chapter3InfoMap[info.activityId] = info
end

function LuyngardeModel:onGetChapter4Info(msg)
	local info = GameUtil.pbToTable(msg)

	self._chapter4InfoMap[info.activityId] = info
end

function LuyngardeModel:onResetChapter4Info(msg)
	local chapter4Info = self:getChapter4InfoByActId(checknumber(msg.activityId))

	chapter4Info.curRoundTimes = 0
	chapter4Info.curRoundLeftHp = -1
end

function LuyngardeModel:onGetChapter2RankInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._chapter2RankInfoMap[info.activityId] = self._chapter2RankInfoMap[info.activityId] or {}
	self._chapter2RankInfoMap[info.activityId][info.typeId] = info
end

function LuyngardeModel:onGetChapter3RankInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._chapter3RankInfoMap[info.activityId] = info
end

function LuyngardeModel:onGetChapter4RankInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._chapter4RankInfoMap[info.activityId] = info
end

function LuyngardeModel:getMatchAreaKillBossRelativeDay(actId)
	local chapter2SimpleRankInfo = self:getChapter2SimpleRankInfoByActId(actId)

	if chapter2SimpleRankInfo and chapter2SimpleRankInfo.killTimeMillis then
		local chapterCfg = LuyngardeConfig.instance:getChapterCfg(actId, 2)
		local timeStampKill = checknumber(chapter2SimpleRankInfo.killTimeMillis) / 1000
		local startTime = GameUtil.string2time(chapterCfg.openTime)
		local relDay = Mathf.Ceil((timeStampKill - startTime) / 86400)
		local prizeCfgs = LuyngardeConfig.instance:getChapter2AreaKillCfgs(actId)

		if relDay > 0 then
			for _, cfg in ipairs(prizeCfgs) do
				if relDay <= cfg.day then
					return cfg.day
				end
			end

			return prizeCfgs[#prizeCfgs].day
		end
	end

	return -1
end

LuyngardeModel.instance = LuyngardeModel.New()

return LuyngardeModel
