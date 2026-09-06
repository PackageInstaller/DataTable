-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/model/RankRaceModel.lua

module("logic.extensions.rankrace.model.RankRaceModel", package.seeall)

local RankRaceModel = class("RankRaceModel", BaseListModel)

function RankRaceModel:ctor()
	RankRaceModel.super.ctor(self)
	self:_initData()
end

function RankRaceModel:onInit()
	RankRaceModel.super.onInit(self)
end

function RankRaceModel:onReset()
	RankRaceModel.super.onReset(self)

	self._checkData = nil
	self._limitForm = nil
end

function RankRaceModel:_initData()
	self._checkData = nil
end

function RankRaceModel:setCheckData(_type, data)
	self._checkData = self._checkData or {}
	self._checkData[_type] = self._checkData[_type] or {}
	self._checkData[_type] = data
end

function RankRaceModel:getCheckData(_type, index)
	if not self._checkData then
		return
	end

	if _type then
		if index then
			return self._checkData[_type][index]
		else
			return self._checkData[_type]
		end
	else
		return self._checkData
	end
end

function RankRaceModel:changeCheckData(_type, index, tag)
	if self._checkData and self._checkData[_type] then
		self._checkData[_type][index] = tag
	end
end

function RankRaceModel:setRecordflag(flag)
	self._recordflag = flag
end

function RankRaceModel:getRecordflag()
	return self._recordflag
end

function RankRaceModel:setReportTo(flag)
	self._reportTo = flag
end

function RankRaceModel:getReportTo()
	return self._reportTo
end

function RankRaceModel:_decimal10ToDecimal2(n)
	local t = {}

	for i = RankRaceDeclareView.DeclareCount, 0, -1 do
		t[#t + 1] = math.floor(n / 2^i)
		n = n % 2^i
	end

	return table.concat(t)
end

function RankRaceModel:_decimal2ToData(_bitStr)
	if not _bitStr then
		return
	end

	_bitStr = tostring(_bitStr)

	local data = {}

	for i = #_bitStr - 1, 1, -1 do
		table.insert(data, string.sub(_bitStr, i, i) == "1" and true or false)
	end

	return data
end

function RankRaceModel:_decimal2ToDecimal10(str)
	local _strArray = string.split(str, "-")
	local count = 0
	local sum = 0

	for i = #_strArray, 1, -1 do
		sum = sum + tonumber(_strArray[i]) * math.pow(2, count)
		count = count + 1
	end

	return sum
end

RankRaceModel.instance = RankRaceModel.New()

return RankRaceModel
