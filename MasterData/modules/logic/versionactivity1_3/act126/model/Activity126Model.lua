-- chunkname: @modules/logic/versionactivity1_3/act126/model/Activity126Model.lua

module("modules.logic.versionactivity1_3.act126.model.Activity126Model", package.seeall)

local Activity126Model = class("Activity126Model", BaseModel)

function Activity126Model:onInit()
	self.spStatus = {}
end

function Activity126Model:reInit()
	self.isInit = nil
	self._showDailyId = nil
	self.spStatus = {}
end

function Activity126Model:updateInfo(msg)
	self.isInit = true
	self.activityId = msg.activityId
	self.spStatus = {}

	for i, v in ipairs(msg.spStatus) do
		local mo = UserDungeonSpStatusMO.New()

		mo:init(v)

		self.spStatus[mo.episodeId] = mo
	end

	self.starProgress = msg.starProgress
	self.progressStr = msg.progressStr
	self.horoscope = msg.horoscope
	self.getHoroscope = msg.getHoroscope

	self:_initList("starProgress", msg, "Act126StarMO")
	self:_initList("getProgressBonus", msg)
	self:_initMap("buffs", msg)
	self:_initMap("spBuffs", msg)
	self:_initList("dreamCards", msg)
end

function Activity126Model:getDailyPassNum()
	local num = 0

	for i, v in ipairs(lua_activity126_episode_daily.configList) do
		local episodeId = v.id
		local statusMo = self.spStatus[episodeId]

		if statusMo and (statusMo.status <= 0 or statusMo.status == 3) then
			break
		end

		local episodeMO = DungeonModel.instance:getEpisodeInfo(episodeId)

		if not episodeMO then
			break
		end

		num = num + episodeMO.todayPassNum
	end

	return num
end

function Activity126Model:getRemainNum()
	local num = self:getDailyPassNum()
	local totalNum = 1
	local remainNum = math.max(0, totalNum - num)

	return remainNum, totalNum
end

function Activity126Model:getOpenDailyEpisodeList()
	local list = {}

	for i, v in ipairs(lua_activity126_episode_daily.configList) do
		local episodeId = v.id
		local statusMo = self.spStatus[episodeId]

		if statusMo and (statusMo.status <= 0 or statusMo.status == 3) then
			break
		end

		local episodeMO = DungeonModel.instance:getEpisodeInfo(episodeId)

		if not episodeMO then
			break
		end

		table.insert(list, episodeMO)
	end

	local len = #list

	if len == #lua_activity126_episode_daily.configList then
		local episodeMO = list[len]
		local statusMo = self.spStatus[episodeMO.episodeId]

		if statusMo.status ~= 2 then
			return {
				list[len]
			}, false
		end

		return list, true
	end

	return {
		list[len]
	}, false
end

function Activity126Model:changeShowDailyId(id)
	self._showDailyId = id

	PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityDungeon1_3DailyEpisode), id)
end

function Activity126Model:getShowDailyId()
	local list, isAll = self:getOpenDailyEpisodeList()

	if not isAll then
		return list[1].episodeId
	end

	self._showDailyId = self._showDailyId or PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityDungeon1_3DailyEpisode), 0)

	if self._showDailyId and self._showDailyId > 0 then
		return self._showDailyId
	end

	return list[1].episodeId
end

function Activity126Model:updateHoroscope(value)
	self.horoscope = value
end

function Activity126Model:receiveHoroscope()
	return self.horoscope
end

function Activity126Model:updateGetHoroscope(value)
	self.getHoroscope = value
end

function Activity126Model:receiveGetHoroscope()
	return self.getHoroscope
end

function Activity126Model:updateStarProgress(msg)
	self.horoscope = nil
	self.progressStr = msg.progressStr

	self:_initList("starProgress", msg, "Act126StarMO")
end

function Activity126Model:getStarNum()
	local num = 0

	for i, v in ipairs(self.starProgress) do
		num = num + v.num
	end

	return num
end

function Activity126Model:getStarProgressStr()
	return self.progressStr
end

function Activity126Model:hasBuff(id)
	return self.buffs[id] or self.spBuffs[id]
end

function Activity126Model:hasDreamCard(id)
	if not self.spBuffs then
		return
	end

	for k, v in pairs(self.spBuffs) do
		local buffConfig = lua_activity126_buff.configDict[k]

		if buffConfig and buffConfig.dreamlandCard == id then
			return true
		end
	end
end

function Activity126Model:updateGetProgressBonus(msg)
	self:_initList("getProgressBonus", msg)
end

function Activity126Model:updateBuffInfo(msg)
	self:_initMap("buffs", msg)
	self:_initMap("spBuffs", msg)
	self:_initList("dreamCards", msg)
end

function Activity126Model:_initList(key, msg, class)
	local list = {}
	local srcList = msg[key]

	for i, v in ipairs(srcList) do
		if class then
			local cls = _G[class]
			local mo = cls.New()

			mo:init(v)

			list[i] = mo
		else
			list[i] = v
		end
	end

	self[key] = list
end

function Activity126Model:_initMap(key, msg)
	local list = {}
	local srcList = msg[key]

	for i, v in ipairs(srcList) do
		list[v] = v
	end

	self[key] = list
end

Activity126Model.instance = Activity126Model.New()

return Activity126Model
