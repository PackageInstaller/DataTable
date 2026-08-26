-- chunkname: @modules/logic/versionactivity3_2/cruise/model/Activity218/Activity218GameRecordMo.lua

module("modules.logic.versionactivity3_2.cruise.model.Activity218.Activity218GameRecordMo", package.seeall)

local Activity218GameRecordMo = pureTable("Activity218GameRecordMo")

function Activity218GameRecordMo:parseJson(str)
	self.dataDic = not string.nilorempty(str) and cjson.decode(str) or {}
	self.dataDic.notWinCount = self.dataDic.notWinCount or 0
end

function Activity218GameRecordMo:getNotWinCount()
	return self.dataDic.notWinCount
end

function Activity218GameRecordMo:setNotWinCount(value)
	self.dataDic.notWinCount = value
end

function Activity218GameRecordMo:toJson()
	return (cjson.encode(self.dataDic))
end

return Activity218GameRecordMo
