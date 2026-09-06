-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lionculture/model/LioncultureModel.lua

module("logic.extensions.lionculture.model.LioncultureModel", package.seeall)

local LioncultureModel = class("LioncultureModel", BaseModel)

function LioncultureModel:ctor()
	return
end

function LioncultureModel:onInit()
	self:onReset()

	self.activityId = 237001
	self.gameLevels = {}
	self.gameFinishs = {}
	self.gameGetPrizes = {}
end

function LioncultureModel:onReset()
	self._lionCultureCustomFmtMo = nil
end

function LioncultureModel:SetGamesData(gamelist)
	for i = 1, #gamelist do
		local data = gamelist[i]
		local gameId = data.gameId

		self.gameLevels[gameId] = checknumber(data.msg)
		self.gameFinishs[gameId] = data.finish
		self.gameGetPrizes[gameId] = data.gainPrize
	end
end

function LioncultureModel:SetGainPrize(gameId)
	self.gameGetPrizes[gameId] = true
end

function LioncultureModel:setActivityId(activityId)
	self._activityId = activityId
end

function LioncultureModel:getRandomSeq(count)
	local seq = {}

	for i = 1, count do
		table.insert(seq, i)
	end

	return GameUtil.permuteArray(seq)
end

function LioncultureModel:getNumBit(num)
	local seq = {}
	local count = LioncultureConfig.instance:getGameIntentionNum()

	for i = 1, count do
		if not GameUtil.isBitOpenByDigit(num, i) then
			table.insert(seq, i)
		end
	end

	return seq
end

function LioncultureModel:setNumBit(index)
	self.gameLevels[2] = GameUtil.setBitByDigit(self.gameLevels[2], index, true)
end

function LioncultureModel:getCustomFmtMoAsLionCulture()
	if self._lionCultureCustomFmtMo == nil then
		self._lionCultureCustomFmtMo = LionCultureCustomFmtMo.New()
	end

	return self._lionCultureCustomFmtMo
end

function LioncultureModel:getPlayerSpineRes()
	return "effect/prefabs/ui/20211028/zhiren_aoqi/zhiren_aoqi-ui_p.prefab"
end

LioncultureModel.instance = LioncultureModel.New()

return LioncultureModel
