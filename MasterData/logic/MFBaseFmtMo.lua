-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/masterform/view/fmtmgr/fmtmo/MFBaseFmtMo.lua

module("logic.extensions.masterform.view.fmtmgr.fmtmo.MFBaseFmtMo", package.seeall)

local MFBaseFmtMo = class("MFBaseFmtMo")

function MFBaseFmtMo:ctor()
	return
end

function MFBaseFmtMo:onDispose()
	return
end

function MFBaseFmtMo:onInit(fmtType, fmtPlanId, fmtId)
	self._fmtType = checknumber(fmtType)
	self._fmtPlanId = checknumber(fmtPlanId)
	self._fmtId = checknumber(fmtId)
end

function MFBaseFmtMo:onReset()
	self._fmtType = nil
end

function MFBaseFmtMo:getFmtType()
	return self._fmtType
end

function MFBaseFmtMo:getFmtId()
	return self._fmtId
end

function MFBaseFmtMo:getFmtPlanId()
	return self._fmtPlanId
end

function MFBaseFmtMo:getFmtTagIds()
	printError(">>>> 必须重写")
end

function MFBaseFmtMo:getFmtName()
	printError(">>>> 必须重写")
end

function MFBaseFmtMo:getFmtDesc()
	printError(">>>> 必须重写")
end

function MFBaseFmtMo:getFmtSimpleDesc()
	printError(">>>> 必须重写")
end

function MFBaseFmtMo:getFmtPetIdList()
	printError(">>>> 必须重写")
end

function MFBaseFmtMo:getFmtCompletion()
	printError(">>>> 必须重写")
end

function MFBaseFmtMo:getFmtPetEleAttrs()
	printError(">>>> 必须重写")
end

function MFBaseFmtMo:getFmtPetJobKeyList()
	printError(">>>> 必须重写")
end

function MFBaseFmtMo:getFmtPetJobKeyList()
	printError(">>>> 必须重写")
end

function MFBaseFmtMo:getPetRaceId(petId)
	printError(">>>> 必须重写")
end

function MFBaseFmtMo:getPetName(petId)
	printError(">>>> 必须重写")
end

function MFBaseFmtMo:getPetHolyStripeId(petId)
	printError(">>>> 必须重写")
end

function MFBaseFmtMo:getPetHolyStripeName(petId)
	printError(">>>> 必须重写")
end

function MFBaseFmtMo:getSummonPetRaceId()
	return printError(">>>> 必须重写")
end

function MFBaseFmtMo:getSummonMasterRaceId()
	return printError(">>>> 必须重写")
end

return MFBaseFmtMo
