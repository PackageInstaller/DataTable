-- chunkname: @modules/logic/versionactivity2_4/warmup/model/V2a4_WarmUpGachaRoundMO.lua

module("modules.logic.versionactivity2_4.warmup.model.V2a4_WarmUpGachaRoundMO", package.seeall)

local V2a4_WarmUpGachaRoundMO = class("V2a4_WarmUpGachaRoundMO")
local sf = string.format
local ti = table.insert

function V2a4_WarmUpGachaRoundMO:ctor(waveMO, index, CO, isNo, yesOrNoIndex)
	self._index = index
	self._waveMO = waveMO
	self._CO = CO
	self._ansIsYes = not isNo
	self._ansIndex = yesOrNoIndex

	local yesOrNoFieldName = self:yesOrNoFieldName()

	self._yesOrNoDialogId = CO[yesOrNoFieldName]
end

function V2a4_WarmUpGachaRoundMO:index()
	return self._index
end

function V2a4_WarmUpGachaRoundMO:yesOrNoFieldName()
	return (self._ansIsYes and "yes" or "no") .. self._ansIndex
end

function V2a4_WarmUpGachaRoundMO:srcloc()
	local t = self:type()

	if t == V2a4_WarmUpEnum.AskType.Text then
		return sf("[logError]2 .4预热活动_接听电话.xlsx - export_文字型题库集（路人）: id=%s, level=%s, %s=%s", self:cfgId(), self:level(), self:yesOrNoFieldName(), self._yesOrNoDialogId)
	elseif t == V2a4_WarmUpEnum.AskType.Photo then
		return sf("[logError] 2.4预热活动_接听电话.xlsx - export_图片型题库集: id=%s, level=%s, %s=%s", self:cfgId(), self:level(), self:yesOrNoFieldName(), self._yesOrNoDialogId)
	else
		return "[Unknown]"
	end
end

function V2a4_WarmUpGachaRoundMO:getDialogCOList(dialogId)
	local COList = {}

	self:appendDialogCOList(COList, dialogId)

	return COList
end

function V2a4_WarmUpGachaRoundMO:appendDialogCOList(refCOList, dialogId)
	if isDebugBuild then
		V2a4_WarmUpConfig.instance:appendDialogCOList(refCOList, self:srcloc(), dialogId)
	else
		V2a4_WarmUpConfig.instance:appendDialogCOList(refCOList, nil, dialogId)
	end
end

function V2a4_WarmUpGachaRoundMO:getDialogCOList_yesorno()
	return self:getDialogCOList(self._yesOrNoDialogId)
end

function V2a4_WarmUpGachaRoundMO:getDialogCOList_preTalk()
	return self:getDialogCOList(self._CO.preTalk)
end

function V2a4_WarmUpGachaRoundMO:getDialogCOList_passTalk()
	return self:getDialogCOList(self._CO.passTalk)
end

function V2a4_WarmUpGachaRoundMO:getDialogCOList_failTalk()
	return self:getDialogCOList(self._CO.failTalk)
end

function V2a4_WarmUpGachaRoundMO:getDialogCOList_passTalkAllYes()
	return self:getDialogCOList(self._CO.passTalkAllYes)
end

function V2a4_WarmUpGachaRoundMO:getDialogCOList_prefaceAndPreTalk()
	local COList = {}
	local prefaceCOList = V2a4_WarmUpConfig.instance:prefaceDialogListCO()

	for _, CO in ipairs(prefaceCOList or {}) do
		ti(COList, CO)
	end

	self:appendDialogCOList(COList, self._CO.preTalk)

	return COList
end

function V2a4_WarmUpGachaRoundMO:type()
	return self._waveMO:type()
end

function V2a4_WarmUpGachaRoundMO:ansIsYes()
	return self._ansIsYes
end

function V2a4_WarmUpGachaRoundMO:ansIndex()
	return self._ansIndex
end

function V2a4_WarmUpGachaRoundMO:cfgId()
	return self._CO.id
end

function V2a4_WarmUpGachaRoundMO:level()
	return self._CO.level
end

function V2a4_WarmUpGachaRoundMO:imgName()
	return self._CO.imgName
end

function V2a4_WarmUpGachaRoundMO.s_type(t)
	for k, v in pairs(V2a4_WarmUpEnum.AskType) do
		if t == v then
			return k
		end
	end

	return "[V2a4_WarmUpBattleWaveMO - s_type] error !"
end

function V2a4_WarmUpGachaRoundMO:dump(refStrBuf, depth)
	depth = depth or 0

	local tab = string.rep("\t", depth)

	ti(refStrBuf, tab .. sf("index = %s", self._index))
	ti(refStrBuf, tab .. sf("issue id = %s", self:cfgId()))
	ti(refStrBuf, tab .. sf("level = %s", self:level()))
	ti(refStrBuf, tab .. sf("ansIsYes? %s", self:ansIsYes()))
	ti(refStrBuf, tab .. sf("type = %s", V2a4_WarmUpGachaRoundMO.s_type(self:type())))
	ti(refStrBuf, tab .. sf("whichAns? %s(%s)", self:yesOrNoFieldName(), self._yesOrNoDialogId))
	ti(refStrBuf, tab .. sf("preTalk(%s), passTalk(%s), failTalk(%s)", self._CO.preTalk, self._CO.passTalk, self._CO.failTalk))
end

return V2a4_WarmUpGachaRoundMO
