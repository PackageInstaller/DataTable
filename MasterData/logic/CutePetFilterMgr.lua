-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/controller/CutePetFilterMgr.lua

module("logic.extensions.cutepet.controller.CutePetFilterMgr", package.seeall)

local CutePetFilterMgr = class("CutePetFilterMgr")

CutePetFilterMgr.TYPE_CUTEPETVIEW = 1
CutePetFilterMgr.TYPE_CUTESELECT = 2
CutePetFilterMgr.TYPE_ASSISTSELECT = 3
CutePetFilterMgr.TYPE_TRAVEL = 4
CutePetFilterMgr.TYPE_COMMUNITY = 5
CutePetFilterMgr.TYPE_PRESETBUDDY = 6
CutePetFilterMgr.TYPE_PRESETSELECTMATCH = 7
CutePetFilterMgr.MAX_PET_JOB_INDEX = 33

function CutePetFilterMgr:ctor()
	return
end

function CutePetFilterMgr:openFilterViewByType(presentor, type, pos, sizeDelta, callback)
	UIStateManager.instance:open(ViewName.CutePetFilterView, pos, sizeDelta, presentor, type, GameUtil.handler(callback, type))
end

function CutePetFilterMgr:checkIsMatch(type, cfg, id)
	local mo = CutePetModel.instance:getCutePeMo(id)

	if mo then
		-- block empty
	else
		return true
	end

	local data = self:getFilterData(type)
	local rareList = data.rareSelectList
	local typeList = data.typeSelectList
	local talentList = data.talentSelectList
	local raceList = data.raceSelectList
	local jobList = data.jobSelectList
	local talentTypeList = data.talentTypeSelectList
	local talentCfg = CutePetConfig.instance:getTalentCfg(mo.initialTalent)
	local raceName = ""
	local jobName = ""
	local isMatchYuan = false

	if not string.nilorempty(talentCfg.petValidator) then
		local strSpilt = string.split(talentCfg.petValidator, "$")

		if strSpilt[1] == "RaceType" then
			raceName = strSpilt[2]
		elseif strSpilt[1] == "Job" then
			jobName = strSpilt[2]
		elseif strSpilt[1] == "StrengthenRaceType" then
			raceName = strSpilt[2]
			isMatchYuan = ItemFilter.checkIsMatch(raceList, GameEnum.RaceType.Yuan)
		end
	end

	local racdIdx = GameEnum.Races[raceName]
	local jobIdx = GameEnum.JobZh[jobName]
	local talentTypeIdx = self:getTalentAttrTypeByName(talentCfg.talentType)

	return ItemFilter.checkIsMatch(rareList, mo.curQuality) and (ItemFilter.checkIsMatch(raceList, racdIdx) or isMatchYuan) and ItemFilter.checkIsMatch(jobList, jobIdx) and ItemFilter.checkIsMatch(typeList, mo.config.type) and ItemFilter.checkIsMatch(talentList, talentCfg.grade) and ItemFilter.checkIsMatch(talentTypeList, talentTypeIdx)
end

function CutePetFilterMgr:checkIsMatchByRaceId(type, raceId)
	local cutePetCfg = CutePetConfig.instance:getCutePetById(raceId)
	local data = self:getFilterData(type)
	local typeList = data.typeSelectList

	return ItemFilter.checkIsMatch(typeList, cutePetCfg.type)
end

function CutePetFilterMgr:resetDataByType(type)
	local data = self:getFilterData(type)

	self:resetData(data)
end

function CutePetFilterMgr:resetData(data)
	if data then
		data.rareSelectList = data.rareSelectList or {}
		data.rareActiveList = data.rareActiveList or {}
		data.rareClickAble = data.rareClickAble or {}
		data.typeSelectList = data.typeSelectList or {}
		data.typeActiveList = data.typeActiveList or {}
		data.typeClickAble = data.typeClickAble or {}
		data.talentSelectList = data.talentSelectList or {}
		data.talentActiveList = data.talentActiveList or {}
		data.talentClickAble = data.talentClickAble or {}
		data.raceSelectList = data.raceSelectList or {}
		data.raceActiveList = data.raceActiveList or {}
		data.raceClickAble = data.raceClickAble or {}
		data.jobSelectList = data.jobSelectList or {}
		data.jobActiveList = data.jobActiveList or {}
		data.jobClickAble = data.jobClickAble or {}
		data.talentTypeSelectList = data.talentTypeSelectList or {}
		data.talentTypeActiveList = data.talentTypeActiveList or {}
		data.talentTypeClickAble = data.talentTypeClickAble or {}

		for i = 1, 5 do
			data.rareSelectList[i] = false
			data.rareActiveList[i] = true
			data.rareClickAble[i] = true
		end

		for i = 1, 4 do
			data.typeSelectList[i] = false
			data.typeActiveList[i] = true
			data.typeClickAble[i] = true
		end

		for i = 1, 5 do
			data.talentSelectList[i] = false
			data.talentActiveList[i] = true
			data.talentClickAble[i] = true
		end

		for i = 1, 7 do
			data.raceSelectList[i] = false
			data.raceActiveList[i] = true
			data.raceClickAble[i] = true
		end

		for i = 1, CutePetFilterMgr.MAX_PET_JOB_INDEX do
			data.jobSelectList[i] = false
			data.jobActiveList[i] = true
			data.jobClickAble[i] = true
		end

		for i = 1, 37 do
			data.talentTypeSelectList[i] = false
			data.talentTypeActiveList[i] = true
			data.talentTypeClickAble[i] = true
		end
	end

	return data
end

function CutePetFilterMgr:getFilterData(type)
	self.all_filter_list = self.all_filter_list or {}

	if self.all_filter_list[type] == nil then
		local data = {}

		self:resetData(data)

		self.all_filter_list[type] = data
	end

	return self.all_filter_list[type]
end

function CutePetFilterMgr:resetAll()
	self.all_filter_list = {}
end

function CutePetFilterMgr:getTalentAttrTypeByName(name)
	if self.attrNameMap == nil then
		self.attrNameMap = {}

		local cnt = #GameEnum.HolyStripeAttrTypeName

		for i = 1, cnt do
			local key = GameEnum.HolyStripeAttrTypeName[i]

			self.attrNameMap[key] = i
		end
	end

	return checknumber(self.attrNameMap[name])
end

CutePetFilterMgr.instance = CutePetFilterMgr.New()

return CutePetFilterMgr
