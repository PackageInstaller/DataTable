-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolamengmeng/model/DuolaMMmodel.lua

module("logic.extensions.duolamengmeng.model.DuolaMMmodel", package.seeall)

local DuolaMMmodel = class("DuolaMMmodel", BaseModel)

DuolaMMmodel.PIECE_NUM = 3
DuolaMMmodel.CHALLENGE_ID = 6

local SHOW_RULE_KEY = "duolaMM_showRule"

function DuolaMMmodel:ctor()
	return
end

function DuolaMMmodel:onInit()
	self:onReset()
end

function DuolaMMmodel:onReset()
	self._buyGameTime = 0
	self._playGameTime = 0
	self._everEvolvePet = false
	self._hasOpenEvolve = false
	self._hasGetData = false
	self._pieces = {}
	self._clienKey = 0
	self._ranking = nil
end

function DuolaMMmodel:getHasGetData()
	return self._hasGetData
end

function DuolaMMmodel:setHasGetData(torf)
	self._hasGetData = torf
end

function DuolaMMmodel:getBuyGameTime()
	return self._buyGameTime
end

function DuolaMMmodel:setBuyGameTime(num)
	self._buyGameTime = num
end

function DuolaMMmodel:getPlayGameTime()
	return self._playGameTime
end

function DuolaMMmodel:setPlayGameTime(num)
	self._playGameTime = num
end

function DuolaMMmodel:getEverEvolvePet()
	return self._everEvolvePet
end

function DuolaMMmodel:setEverEvolvePet(torf)
	self._everEvolvePet = torf
end

function DuolaMMmodel:getHasOpenEvolve()
	return self._hasOpenEvolve
end

function DuolaMMmodel:setHasOpenEvolve(torf)
	self._hasOpenEvolve = torf
end

function DuolaMMmodel:getGameGainCount(id)
	self._pieces[id] = self._pieces[id] or {}

	return checknumber(self._pieces[id].gameGainCount)
end

function DuolaMMmodel:getBuyCount(id)
	self._pieces[id] = self._pieces[id] or {}

	return checknumber(self._pieces[id].buyCount)
end

function DuolaMMmodel:setPieceInfo(info)
	local id = info.id

	self._pieces[id] = self._pieces[id] or {}
	self._pieces[id].gameGainCount = info.gameGainCount
	self._pieces[id].buyCount = info.buyCount
end

function DuolaMMmodel:getLoginFirstChallenge()
	return (GameUtil.getUserDayData(SHOW_RULE_KEY .. "_" .. LoginModel.instance.userId))
end

function DuolaMMmodel:setLoginFirstChallenge(torf)
	local key = SHOW_RULE_KEY .. "_" .. LoginModel.instance.userId
	local res = GameUtil.getUserDayData(key)

	if res ~= torf then
		GameUtil.saveUserDayData(key, torf)
	end
end

function DuolaMMmodel:getClienKey()
	return self._clienKey
end

function DuolaMMmodel:setClienKey(key)
	self._clienKey = key
end

DuolaMMmodel.instance = DuolaMMmodel.New()

return DuolaMMmodel
