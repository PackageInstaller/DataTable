-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holylight/model/HolyLightCustomFmtMo.lua

module("logic.extensions.holylight.model.HolyLightCustomFmtMo", package.seeall)

local HolyLightCustomFmtMo = class("HolyLightCustomFmtMo", ICustomFmtMo)

function HolyLightCustomFmtMo:onReset()
	HolyLightCustomFmtMo.super.onReset(self)

	self.isShowBtnCutePet = false
end

function HolyLightCustomFmtMo:updateCfg(activityId, masterId)
	self._activityId = activityId
	self._masterId = masterId
	self._holyLightMgr = HolyLightController.instance:getHolyLightMgr(self._activityId)
	self._masterData = HolyLightConfig.instance:getHlMasterData(self._activityId, self._masterId)

	local masterPetMoList = self._holyLightMgr:getMasterPetMoList(self._masterId)
	local dataList = {}

	for _, petMo in ipairs(masterPetMoList) do
		local petId = petMo:getId()
		local data = HolyLightConfig.instance:getHlCreepsDataById(self._activityId, masterId, petId)

		table.insert(dataList, data)
	end

	self._creepsDataList = dataList
end

function HolyLightCustomFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.WinDesc
	self.validatorDescStr = self._masterData.missionDesc

	self:setFormCondition(self._masterData.formCondition)
	self:initPetList()
end

function HolyLightCustomFmtMo:initFightHandler()
	local function handler()
		local simpleForm = self:getCurSimpleForm()

		HolyLightController.instance:sendPM_HolyLightChallengeReq(self._activityId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function HolyLightCustomFmtMo:initPetList()
	self:clearAllPetList()

	local petIdList = self._holyLightMgr:getMyPetIdList()

	for _, petId in ipairs(petIdList) do
		self:addPetToList(self._holyLightMgr:getMyPetMo(petId))
	end
end

function HolyLightCustomFmtMo:getMonsterConfigList()
	return self._creepsDataList
end

function HolyLightCustomFmtMo:getFmtInfoConfig()
	return self._masterData
end

function HolyLightCustomFmtMo:onClickCloseBtn(handler)
	HolyLightCustomFmtMo.super.onClickCloseBtn(self, handler)
	UIJumper.instance:clear()
end

return HolyLightCustomFmtMo
