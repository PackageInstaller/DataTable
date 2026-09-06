-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/neverland/model/NeverLandModel.lua

module("logic.extensions.neverland.model.NeverLandModel", package.seeall)

local NeverLandModel = class("NeverLandModel", BaseModel)

function NeverLandModel:ctor()
	return
end

function NeverLandModel:onInit()
	self:onReset()
end

function NeverLandModel:onReset()
	self.info = {}
	self.rankInfo = {}
	self._neverLandAttackFmtMo = nil
	self._neverLandDefendFmtMo = nil
	self._mode = ""
end

function NeverLandModel:setInfo(msg)
	GameUtil.pbToTable(msg, self.info)
end

function NeverLandModel:getInfo()
	return self.info
end

function NeverLandModel:getBuffInfo()
	return self.info.buffInfos or {}
end

function NeverLandModel:getBuffLevel(buffId)
	local info = self:getBuffInfo()

	if #info <= 0 then
		return 0
	end

	for _, v in ipairs(info) do
		if checknumber(v.buffId) == buffId then
			return checknumber(v.lv)
		end
	end

	return 0
end

function NeverLandModel:getDefendScore()
	return self.info.defenseScore or 0
end

function NeverLandModel:getAttackScore()
	return self.info.attackScore or 0
end

function NeverLandModel:setRankInfo(msg)
	self.rankInfo = {}

	GameUtil.pbToTable(msg, self.rankInfo)
end

function NeverLandModel:getRankInfo()
	if not TableUtil.isTableEmpty(self.rankInfo.rankInfos) then
		table.sort(self.rankInfo.rankInfos, function(a, b)
			return a.rank < b.rank
		end)
	end

	return self.rankInfo.rankInfos
end

function NeverLandModel:getMyRank()
	return checknumber(self.rankInfo.myRank)
end

function NeverLandModel:getChallengeAttackFmtMo(activityId)
	if self._neverLandAttackFmtMo == nil then
		self._neverLandAttackFmtMo = NeverLandAttackFmtMo.New()
	end

	self._neverLandAttackFmtMo:initParams(activityId)

	return self._neverLandAttackFmtMo
end

function NeverLandModel:getChallengeDefendFmtMo(activityId)
	if self._neverLandDefendFmtMo == nil then
		self._neverLandDefendFmtMo = NeverLandDefendFmtMo.New()
	end

	self._neverLandDefendFmtMo:initParams(activityId)

	return self._neverLandDefendFmtMo
end

function NeverLandModel:setChallengeMode(mode)
	self._mode = mode
end

function NeverLandModel:getChallengeModel()
	return self._mode
end

NeverLandModel.instance = NeverLandModel.New()

return NeverLandModel
