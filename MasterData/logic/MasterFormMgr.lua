-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/masterform/view/fmtmgr/MasterFormMgr.lua

module("logic.extensions.masterform.view.fmtmgr.MasterFormMgr", package.seeall)

local MasterFormMgr = class("MasterFormMgr")

MasterFormMgr.FmtType = {
	System = 1,
	Master = 2
}
MasterFormMgr.FmtMoCls = {
	[MasterFormMgr.FmtType.System] = MFSystemFmtMo,
	[MasterFormMgr.FmtType.Master] = MFMasterFmtMo
}

function MasterFormMgr:ctor(periodId)
	self:onReset()

	self._fmtMoPoolMgr = MFFmtMoPoolMgr.New()
	self._periodId = checknumber(periodId)
	self._baseData = MasterFormConfig.instance:getMfBaseData(self._periodId)

	if self._baseData == nil then
		printError("配置为空,请检查")
	end

	self:_initFmtMoLibrary()
end

function MasterFormMgr:onReset()
	self._viewFormResMsg = nil
	self._getBaseInfoResMsg = nil
	self._myFormResMsg = nil
	self._daliyKudoTimes = 0
	self._daliyCommentTimes = 0

	self:_clearAllFmtMoLibrary()
	self:_clearAllFmtMoOfMyAsTemp()
	self:_clearCommentsMap()
	self:_clearFmtCollectInfos()
	self:_clearFmtIdListOfMy()

	if self._fmtMoPoolMgr then
		self._fmtMoPoolMgr:onClear()
	end
end

function MasterFormMgr:handlePM_MasterFormViewFormRes(msg)
	self._viewFormResMsg = msg

	self:_initFmtMoLibraryOfMaster()
end

function MasterFormMgr:handlePM_MasterFormGetMyFormRes(msg)
	self._myFormResMsg = msg

	local fmtType = MasterFormMgr.FmtType.Master
	local fmtId = 0

	self:_clearFmtIdListOfMy()

	for _, v in ipairs(msg.myFormList) do
		fmtId = checknumber(v.formId)

		self:_setFmtCollectInfo(fmtType, fmtId, v.isCollect)

		local fmtMo = self:getFmtMo(fmtType, fmtId)

		if fmtMo then
			self:_addFmtMoInLibraryOfMaster(fmtType, fmtMo:getFmtPlanId(), fmtId, v)
		else
			self:_addFmtMoInLibraryOfMaster(fmtType, -1, fmtId, v)
		end

		table.insert(self._fmtIdListOfMy, fmtId)
	end
end

function MasterFormMgr:handlePM_MasterFormGetCollectionFormRes(msg)
	for _, fmtId in ipairs(msg.sysFormIds) do
		self:_setFmtCollectInfo(MasterFormMgr.FmtType.System, checknumber(fmtId), true)
	end

	local fmtType = MasterFormMgr.FmtType.Master
	local fmtId = 0

	self:_clearFmtCollectInfos()

	for _, v in ipairs(msg.form) do
		fmtId = checknumber(v.formId)

		self:_setFmtCollectInfo(fmtType, fmtId, v.isCollect)

		local fmtMo = self:getFmtMo(fmtType, fmtId)

		if fmtMo then
			self:_addFmtMoInLibraryOfMaster(fmtType, fmtMo:getFmtPlanId(), fmtId, v)
		else
			self:_addFmtMoInLibraryOfMaster(fmtType, -1, fmtId, v)
		end
	end
end

function MasterFormMgr:handlePM_MasterFormgetCommentsRes(msg)
	if self._commentInfosMap == nil then
		self._commentInfosMap = {}
	end

	local fmtId = checknumber(msg.formId)

	self._commentInfosMap[fmtId] = msg.comments
	self._commentInfosMap[fmtId] = {}

	for _, v in ipairs(msg.comments) do
		local info = {}

		info.commentId = v.commentId
		info.headInfo = v.headInfo
		info.content = v.content
		info.kudos = v.kudos
		info.isKudos = v.isKudos
		self._commentInfosMap[fmtId][info.commentId] = info
	end
end

function MasterFormMgr:handlePM_MasterFormKudoFormRes(msg)
	local fmtMo = self:getFmtMo(MasterFormMgr.FmtType.Master, checknumber(msg.formId))

	if fmtMo then
		fmtMo:setIsKudos(true)
		fmtMo:setFmtKudos(fmtMo:getFmtKudos() + 1)
	end

	self:setDaliyKudoTimes(self:getDaliyKudoTimes() + 1)
end

function MasterFormMgr:handlePM_MasterFormKudoCommentRes(msg)
	self:setHasKudoOfComment(checknumber(msg.formId), msg.commentId, true)
	self:setDaliyKudoTimes(self:getDaliyKudoTimes() + 1)
end

function MasterFormMgr:handlePM_MasterFormSubmitFormRes(msg)
	return
end

function MasterFormMgr:handlePM_MasterFormRevokeRes(msg)
	return
end

function MasterFormMgr:handlePM_MasterFormCollectRes(msg)
	local fmtId = checknumber(msg.formId)

	self:_setFmtCollectInfo(msg.type, fmtId, true)
end

function MasterFormMgr:handlePM_MasterFormCancelCollectRes(msg)
	local fmtId = checknumber(msg.formId)

	self:_setFmtCollectInfo(msg.type, fmtId, false)
end

function MasterFormMgr:handlePM_MasterFormGetBaseInfoRes(msg)
	self._getBaseInfoResMsg = msg

	self:setDaliyKudoTimes(self._getBaseInfoResMsg.daliyKudoTimes)
	self:setDaliyCommentTimes(self._getBaseInfoResMsg.daliyCommentTimes)
	self:_clearFmtCollectInfos()

	for _, collect in ipairs(self._getBaseInfoResMsg.collectList) do
		for _, fmtId in ipairs(collect.collectFormIds) do
			fmtId = checknumber(fmtId)

			self:_setFmtCollectInfo(collect.type, fmtId, true)
		end
	end
end

function MasterFormMgr:handlePM_MasterFormCommentRes(msg)
	return
end

function MasterFormMgr:handlePM_MasterFormNotifyCommnetRes(msg)
	self:setDaliyCommentTimes(self:getDaliyCommentTimes() + 1)
end

function MasterFormMgr:handlePM_MasterFormNotifySubmitFormRes(msg)
	return
end

function MasterFormMgr:getPeriodId()
	return self._periodId
end

function MasterFormMgr:isCollect(fmtType, fmtId)
	if self._collectInfos and self._collectInfos[fmtType] then
		return self._collectInfos[fmtType][fmtId] == true
	end

	return false
end

function MasterFormMgr:getFmtIdListAsCollectByType(fmtType)
	local list = {}

	if self._collectInfos and self._collectInfos[fmtType] then
		for fmtId, isCollect in pairs(self._collectInfos[fmtType]) do
			if isCollect then
				table.insert(list, fmtId)
			end
		end
	end

	return list
end

function MasterFormMgr:_setFmtCollectInfo(fmtType, fmtId, isCollect)
	if self._collectInfos == nil then
		self._collectInfos = {}
	end

	if self._collectInfos[fmtType] == nil then
		self._collectInfos[fmtType] = {}
	end

	self._collectInfos[fmtType][fmtId] = isCollect
end

function MasterFormMgr:_clearFmtCollectInfos()
	if self._collectInfos then
		table.clear(self._collectInfos)

		self._collectInfos = nil
	end
end

function MasterFormMgr:getMyThresholds()
	return (self._getBaseInfoResMsg or nil) and (self._getBaseInfoResMsg.thresholds or {})
end

function MasterFormMgr:isFitThresholdOfMe()
	return #self:getMyThresholds() > 0
end

function MasterFormMgr:getDaliyKudoTimes()
	return self._daliyKudoTimes
end

function MasterFormMgr:setDaliyKudoTimes(times)
	self._daliyKudoTimes = times
end

function MasterFormMgr:getDaliyCommentTimes()
	return self._daliyCommentTimes
end

function MasterFormMgr:setDaliyCommentTimes(times)
	self._daliyCommentTimes = times
end

function MasterFormMgr:getTryKudoFmtResultAndTips(fmtType, fmtId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if self:isHasKudoOfFmt(fmtType, fmtId) then
		result = GameEnum.ResultCode.HasSure
		tips = ""
	elseif not self:isFitDaliyKudoTimes() then
		result = GameEnum.ResultCode.IsMaxLimit
		tips = "今日点赞次数已达上限"
	end

	return result, tips
end

function MasterFormMgr:isFitDaliyKudoTimes()
	return self:getLeftDaliyKudoTimes() > 0
end

function MasterFormMgr:getLeftDaliyKudoTimes()
	local maxTimes = MasterFormConfig.instance:getMfCommonValue("DALIY_KUDO_TIMES", true)

	return Mathf.Max(maxTimes - self:getDaliyKudoTimes(), 0)
end

function MasterFormMgr:getTryKudoCommentResultAndTips(fmtId, commentId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if self:isHasKudoOfComment(fmtId, commentId) then
		result = GameEnum.ResultCode.HasSure
		tips = ""
	elseif not self:isFitDaliyKudoTimes() then
		result = GameEnum.ResultCode.IsMaxLimit
		tips = "今日点赞次数已达上限"
	end

	return result, tips
end

function MasterFormMgr:getSubmitCommentResultAndTips(str)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if self:isExDaliyCommentTimes() then
		result = GameEnum.ResultCode.NotEnoughTimes
		tips = "已达评论上限"
	elseif string.nilorempty(str) then
		result = GameEnum.ResultCode.IsNil
		tips = "评论不能为空"
	end

	return result, tips
end

function MasterFormMgr:getLeftDaliyCommentTimes()
	local maxTimes = MasterFormConfig.instance:getMfCommonValue("DALIY_COMMENT_TIMES", true)

	return Mathf.Max(maxTimes - self:getDaliyCommentTimes(), 0)
end

function MasterFormMgr:isExDaliyCommentTimes()
	return self:getLeftDaliyCommentTimes() <= 0
end

function MasterFormMgr:getComments(fmtId)
	return TableUtil.toList(self._commentInfosMap[fmtId] or {})
end

function MasterFormMgr:getCommentInfo(fmtId, commentId)
	return self._commentInfosMap[fmtId] and self._commentInfosMap[fmtId][commentId]
end

function MasterFormMgr:isHasKudoOfComment(fmtId, commentId)
	local info = self:getCommentInfo(fmtId, commentId)

	return checkbool(info and info.isKudos)
end

function MasterFormMgr:setHasKudoOfComment(fmtId, commentId, isHasKudo)
	local info = self:getCommentInfo(fmtId, commentId)

	if info then
		info.isKudos = isHasKudo
	end
end

function MasterFormMgr:_clearCommentsMap()
	if self._commentInfosMap then
		table.clear(self._commentInfosMap)

		self._commentInfosMap = nil
	end
end

function MasterFormMgr:getSubmitFmtResultAndTips(fmtMo)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local petIdList = fmtMo:getFmtPetIdList()
	local petCount = #petIdList

	if petCount <= 0 or petCount > 6 then
		result = GameEnum.ResultCode.NotEnoughNum
		tips = "精灵数量不符"
	elseif string.nilorempty(fmtMo:getFmtName()) then
		result = GameEnum.ResultCode.IsNil
		tips = "阵容名称不能为空"
	elseif string.nilorempty(fmtMo:getFmtDesc()) then
		result = GameEnum.ResultCode.IsNil
		tips = "阵容说明不能为空"
	end

	return result, tips
end

function MasterFormMgr:getGainPrizeCount()
	return (self._myFormResMsg or nil) and (self._myFormResMsg.gainPrizeCount or 0)
end

function MasterFormMgr:getLeftGainPrizeCount(periodId)
	local curCount = self:getGainPrizeCount()
	local baseData = MasterFormConfig.instance:getMfBaseData(periodId)

	if baseData then
		if not baseData.prizeCount then
			local totalCount = 0

			return Mathf.Max(totalCount - curCount, 0)
		end
	end
end

function MasterFormMgr:getFmtMoOfMy(index)
	local fmtId = self:getFmtIdOfMy(index)

	return self:getFmtMo(MasterFormMgr.FmtType.Master, fmtId)
end

function MasterFormMgr:isHasFmtOfMy(index)
	return self:getFmtIdOfMy(index) > 0
end

function MasterFormMgr:getFmtIdOfMy(index)
	return self._fmtIdListOfMy[index] or 0
end

function MasterFormMgr:_clearFmtIdListOfMy()
	if self._fmtIdListOfMy then
		table.clear(self._fmtIdListOfMy)
	end

	self._fmtIdListOfMy = {}
end

function MasterFormMgr:getFmtMoOfMyAsTemp(index)
	if self._fmtMoOfMyAsTemps == nil then
		self._fmtMoOfMyAsTemps = {}
	end

	if self._fmtMoOfMyAsTemps[index] == nil then
		local fmtType = MasterFormMgr.FmtType.Master
		local fmtPlanId = -1
		local fmtId = 0
		local v

		self._fmtMoOfMyAsTemps[index] = self._fmtMoPoolMgr:fetchFmtMo(fmtType, fmtPlanId, fmtId, v)
	end

	return self._fmtMoOfMyAsTemps[index]
end

function MasterFormMgr:_clearFmtMoOfMyAsTemp(index)
	if self._fmtMoOfMyAsTemps and self._fmtMoOfMyAsTemps[index] then
		self._fmtMoPoolMgr:returnFmtMo(self._fmtMoOfMyAsTemps[index])

		self._fmtMoOfMyAsTemps[index] = nil
	end
end

function MasterFormMgr:_clearAllFmtMoOfMyAsTemp()
	if self._fmtMoOfMyAsTemps then
		for index, v in pairs(self._fmtMoOfMyAsTemps) do
			self:_clearFmtMoOfMyAsTemp(index)
		end
	end
end

function MasterFormMgr:isHasKudoOfFmt(fmtType, fmtId)
	local fmtMo = self:getFmtMo(fmtType, fmtId)

	return checkbool(fmtMo and fmtMo:isKudos())
end

function MasterFormMgr:getFmtMo(fmtType, fmtId)
	return self._fmtMoMaps[fmtType][fmtId]
end

function MasterFormMgr:getFmtMoList(fmtType)
	return self._fmtMoLists[fmtType]
end

function MasterFormMgr:_initFmtMoLibrary()
	self._fmtMoMaps = {}

	for _, fmtType in pairs(MasterFormMgr.FmtType) do
		self._fmtMoMaps[fmtType] = {}
	end

	self._fmtMoLists = {}

	for _, fmtType in pairs(MasterFormMgr.FmtType) do
		self._fmtMoLists[fmtType] = {}
	end

	self:_initFmtMoLibraryOfSystem()
	self:_initFmtMoLibraryOfMaster()
end

function MasterFormMgr:_clearAllFmtMoLibrary()
	for _, fmtType in pairs(MasterFormMgr.FmtType) do
		self:_clearFmtMoLibrary(fmtType)
	end
end

function MasterFormMgr:_addFmtMoInLibrary(fmtMo)
	local fmtType = fmtMo:getFmtType()
	local fmtId = fmtMo:getFmtId()

	self:_removeFmtMoInLibrary(fmtType, fmtId)

	self._fmtMoMaps[fmtType][fmtId] = fmtMo

	table.insert(self._fmtMoLists[fmtType], fmtMo)
end

function MasterFormMgr:_addFmtMoInLibraryOfMaster(fmtType, fmtPlanId, fmtId, v)
	local fmtMo = self._fmtMoPoolMgr:fetchFmtMo(fmtType, fmtPlanId, fmtId, v)

	self:_addFmtMoInLibrary(fmtMo)
end

function MasterFormMgr:_removeFmtMoInLibrary(fmtType, fmtId)
	local fmtMo = self:getFmtMo(fmtType, fmtId)

	if fmtMo then
		table.removebyvalue(self._fmtMoLists[fmtType], fmtMo)

		self._fmtMoMaps[fmtType][fmtId] = nil

		self._fmtMoPoolMgr:returnFmtMo(fmtMo)
	end
end

function MasterFormMgr:_initFmtMoLibraryOfSystem()
	local fmtType = MasterFormMgr.FmtType.System

	self:_clearFmtMoLibrary(fmtType)

	for _, sysFmtPlanId in ipairs(self._baseData.sysFmtPlanIds) do
		local sysFmtCfg = MasterFormConfig.instance:getMfSysFmtCfg(sysFmtPlanId)

		for index, sysFmtData in ipairs(sysFmtCfg) do
			local fmtMo = self._fmtMoPoolMgr:fetchFmtMo(fmtType, sysFmtData.sysFmtPlanId, sysFmtData.sysFmtId)

			self:_addFmtMoInLibrary(fmtMo)
		end
	end
end

function MasterFormMgr:_clearFmtMoLibrary(fmtType)
	if self._fmtMoMaps then
		if self._fmtMoLists then
			local fmtMoList = self._fmtMoLists[fmtType]

			if self._fmtMoMaps and fmtMoList then
				local fmtId = 0

				for index, fmtMo in ipairs(fmtMoList) do
					fmtId = fmtMo:getFmtId()

					self._fmtMoPoolMgr:returnFmtMo(fmtMo)

					fmtMoList[index] = nil
					self._fmtMoMaps[fmtId] = nil
				end
			end
		end
	end
end

function MasterFormMgr:_initFmtMoLibraryOfMaster()
	local fmtType = MasterFormMgr.FmtType.Master

	self:_clearFmtMoLibrary(fmtType)

	if self._viewFormResMsg then
		for _, v in ipairs(self._viewFormResMsg.formList) do
			self:_addFmtMoInLibraryOfMaster(fmtType, self._viewFormResMsg.fmtType, checknumber(v.formId), v)
		end
	end
end

return MasterFormMgr
