-- chunkname: @modules/logic/versionactivity2_4/warmup/config/V2a4_WarmUpConfig.lua

module("modules.logic.versionactivity2_4.warmup.config.V2a4_WarmUpConfig", package.seeall)

local V2a4_WarmUpConfig = class("V2a4_WarmUpConfig", BaseConfig)
local randomseed = math.randomseed
local random = math.random
local sf = string.format
local ti = table.insert
local sfind = string.find
local tonumber = tonumber

function V2a4_WarmUpConfig:actId()
	return ActivityEnum.Activity.V2a4_WarmUp
end

function V2a4_WarmUpConfig:reqConfigNames()
	return {
		"v2a4_warmup_fmt_effect",
		"v2a4_warmup_const",
		"v2a4_warmup_const_mlstring",
		"v2a4_warmup_level",
		"v2a4_warmup_ask_type",
		"v2a4_warmup_dialog_style",
		"v2a4_warmup_dialog_type",
		"v2a4_warmup_dialog",
		"v2a4_warmup_text_info",
		"v2a4_warmup_text_item_list",
		"v2a4_warmup_photo_item_list"
	}
end

local function _fmt_effectCO(id)
	return lua_v2a4_warmup_fmt_effect.configDict[id]
end

local function _constCO(id)
	return lua_v2a4_warmup_const.configDict[id]
end

local function _dialogStyleCO(id)
	return lua_v2a4_warmup_dialog_style.configDict[id]
end

local function _dialogTypeCO(id)
	return lua_v2a4_warmup_dialog_type.configDict[id]
end

local function _dialogCO(id)
	return lua_v2a4_warmup_dialog.configDict[id]
end

local function _nextDialogId(dialogId)
	local CO = _dialogCO(dialogId)

	return (CO or nil) and (CO.nextId or 0)
end

function V2a4_WarmUpConfig:onConfigLoaded(configName, configTable)
	if configName == "v2a4_warmup_dialog" then
		self:__init_v2a4_warmup_dialog(configTable)
	elseif configName == "v2a4_warmup_text_item_list" then
		self:__init_v2a4_warmup_text_item_list(configTable)
	elseif configName == "v2a4_warmup_photo_item_list" then
		self:__init_v2a4_warmup_photo_item_list(configTable)
	end
end

function V2a4_WarmUpConfig:__init_v2a4_warmup_dialog(configTable)
	if isDebugBuild then
		self.__log = {}
	end

	self.__v2a4_warmup_dialog = {}
	self.__prefaceDialogListCO = {}

	local noDepsIdList = {}

	for _, CO in ipairs(lua_v2a4_warmup_dialog.configList) do
		local group = CO.group
		local id = CO.id
		local nextId = CO.nextId

		if isDebugBuild and id == nextId then
			if #self.__log == 0 then
				local srcloc = sf("[V2a4_WarmUpConfig - __init_v2a4_warmup_dialog]: 2.4预热活动_接听电话.xlsx - export_对话内容库")

				ti(self.__log, "[V2a4_WarmUpConfig - __init_v2a4_warmup_dialog] =========== begin")
				ti(self.__log, sf("source: %s", srcloc))
			end

			ti(self.__log, sf("id=%s\tnextId=%s", id, nextId))
		end

		self.__v2a4_warmup_dialog[group] = self.__v2a4_warmup_dialog[group] or {}

		if group == V2a4_WarmUpEnum.DialogType.Preface then
			ti(self.__prefaceDialogListCO, CO)
		end

		if nextId == 0 then
			ti(noDepsIdList, id)
		end
	end

	for _, id in ipairs(noDepsIdList) do
		local CO = configTable.configDict[id]
		local group = CO.group
		local groupList = self.__v2a4_warmup_dialog[group]

		ti(groupList, CO)
	end

	table.sort(self.__prefaceDialogListCO, function(a, b)
		return a.id < b.id
	end)

	if isDebugBuild and #self.__log ~= 0 then
		ti(self.__log, "[V2a4_WarmUpConfig - __init_v2a4_warmup_dialog] =========== end")
		logError(table.concat(self.__log, "\n"))
	end
end

function V2a4_WarmUpConfig:__init_v2a4_warmup_yesno_item_list(srcloc, refList, configTable)
	if isDebugBuild then
		self.__log = {}
	end

	local function _firstFoundError()
		if #self.__log ~= 0 then
			return
		end

		ti(self.__log, "[V2a4_WarmUpConfig - __init_v2a4_warmup_yesno_item_list] =========== begin")
		ti(self.__log, sf("source: %s", srcloc))
	end

	for i, CO in ipairs(configTable.configList) do
		if isDebugBuild and i == 1 then
			local fieldIndex = 1

			while CO["yes" .. fieldIndex] ~= nil do
				if not CO["no" .. fieldIndex] then
					_firstFoundError()
					ti(self.__log, sf("\tno field 'no%s'", fieldIndex))
				end

				fieldIndex = fieldIndex + 1
			end

			while CO["no" .. fieldIndex] ~= nil do
				if not CO["yes" .. fieldIndex] then
					_firstFoundError()
					ti(self.__log, sf("\tno field 'yes%s'", fieldIndex))
				end

				fieldIndex = fieldIndex + 1
			end

			if #self.__log ~= 0 then
				ti(self.__log, "[V2a4_WarmUpConfig - __init_v2a4_warmup_yesno_item_list] =========== end")
				logError(table.concat(self.__log, "\n"))
			end
		end

		local level = CO.level

		refList[level] = refList[level] or {}

		local levelCOList = refList[level]

		ti(levelCOList, CO)
	end
end

function V2a4_WarmUpConfig:__init_v2a4_warmup_text_item_list(configTable)
	self.__v2a4_warmup_text_item_list = {}

	if isDebugBuild then
		local srcloc = sf("[logError] 2.4预热活动_接听电话.xlsx - export_文字型题库集（路人）")

		self:__init_v2a4_warmup_yesno_item_list(srcloc, self.__v2a4_warmup_text_item_list, configTable)
	else
		self:__init_v2a4_warmup_yesno_item_list(nil, self.__v2a4_warmup_text_item_list, configTable)
	end

	self.__v2a4_warmup_text_item_list_yesno_header_count = self:__init_v2a4_warmup_yesno_count(configTable)
end

function V2a4_WarmUpConfig:__init_v2a4_warmup_photo_item_list(configTable)
	self.__v2a4_warmup_photo_item_list = {}

	if isDebugBuild then
		local srcloc = sf("[logError] 2.4预热活动_接听电话.xlsx - export_图片型题库集")

		self:__init_v2a4_warmup_yesno_item_list(srcloc, self.__v2a4_warmup_photo_item_list, configTable)
	else
		self:__init_v2a4_warmup_yesno_item_list(nil, self.__v2a4_warmup_photo_item_list, configTable)
	end

	self.__v2a4_warmup_photo_item_list_yesno_header_count = self:__init_v2a4_warmup_yesno_count(configTable)
end

function V2a4_WarmUpConfig:__init_v2a4_warmup_yesno_count(configTable)
	if not configTable then
		return 0
	end

	local _, CO = next(configTable.configList)

	if not CO then
		return 0
	end

	for i = 1, 1999 do
		if not CO["yes" .. i] then
			return i - 1
		end
	end

	return 0
end

function V2a4_WarmUpConfig:nextDialogCO(dialogId)
	local id = _nextDialogId(dialogId)

	if id <= 0 then
		return
	end

	return _dialogCO(id)
end

function V2a4_WarmUpConfig:dialogCount(dialogId)
	local CO = _dialogCO(dialogId)

	if not CO then
		return 0
	end

	local cnt = 0

	while dialogId > 0 do
		cnt = cnt + 1
		dialogId = _nextDialogId(dialogId)
	end

	return cnt
end

function V2a4_WarmUpConfig:getRandomDialogCO(dialogTypeId)
	if dialogTypeId == V2a4_WarmUpEnum.DialogType.Preface then
		return self.__prefaceDialogListCO[1]
	end

	local groupList = self.__v2a4_warmup_dialog[dialogTypeId]

	if not groupList or #groupList == 0 then
		return nil
	end

	randomseed(os.time())

	local index = random(1, #groupList)

	return groupList[index]
end

function V2a4_WarmUpConfig:prefaceDialogListCO()
	return self.__prefaceDialogListCO
end

function V2a4_WarmUpConfig:getConst(id)
	return _constCO(id).numValue
end

function V2a4_WarmUpConfig:getConstStr(id)
	return lua_v2a4_warmup_const_mlstring.configDict[id].value
end

function V2a4_WarmUpConfig:getLevelCO(levelId)
	return v2a4_warmup_level.configDict[levelId]
end

function V2a4_WarmUpConfig:getDialogStyleCO(dialogTypeId)
	local CO = _dialogTypeCO(dialogTypeId)

	return _dialogStyleCO(CO.style)
end

function V2a4_WarmUpConfig:getTextItemListCO(levelId)
	return self.__v2a4_warmup_text_item_list[levelId] or {}
end

function V2a4_WarmUpConfig:getPhotoItemListCO(levelId)
	return self.__v2a4_warmup_photo_item_list[levelId] or {}
end

function V2a4_WarmUpConfig:getYesMaxCount(e)
	if e == V2a4_WarmUpEnum.AskType.Text then
		return self.__v2a4_warmup_text_item_list_yesno_header_count
	elseif e == V2a4_WarmUpEnum.AskType.Photo then
		return self.__v2a4_warmup_photo_item_list_yesno_header_count
	end

	return 0
end

function V2a4_WarmUpConfig:getYesAndNoMaxCount(e)
	local cnt = self:getYesMaxCount(e)

	return cnt + cnt
end

function V2a4_WarmUpConfig:getDialogCOList(srcloc, dialogId)
	local COList = {}

	self.appendDialogCOList(COList, srcloc, dialogId)

	return COList
end

function V2a4_WarmUpConfig:appendDialogCOList(refCOList, srcloc, dialogId)
	if isDebugBuild then
		self.__debug_stk_overflow = {}
		self.__debug_stk_overflow_loop_cnt = 0
		self.__log = {}
	end

	local CO = _dialogCO(dialogId)

	while CO ~= nil do
		if isDebugBuild then
			local loop = self.__debug_stk_overflow_loop_cnt

			loop = loop + 1

			local curDialogId = CO.id

			if not self.__debug_stk_overflow[curDialogId] then
				self.__debug_stk_overflow[curDialogId] = loop
				self.__debug_stk_overflow_loop_cnt = loop
			else
				ti(self.__log, "[V2a4_WarmUpConfig - getNpcPreTalkCOList] =========== begin")
				ti(self.__log, sf("source: %s", srcloc))
				ti(self.__log, sf("[logError] 2.4预热活动_接听电话.xlsx - export_对话内容库: id=%s", curDialogId))

				for dialogId_, loopIndex in pairs(self.__debug_stk_overflow) do
					if curDialogId == dialogId_ then
						ti(self.__log, sf("%s: %s !!<----- this", loopIndex, dialogId_))
					else
						ti(self.__log, sf("%s: %s", loopIndex, dialogId_))
					end
				end

				ti(self.__log, sf("%s: %s !!<----- error cyclic reference", loop, curDialogId))
				ti(self.__log, "[V2a4_WarmUpConfig - getNpcPreTalkCOList] =========== end")
				logError(table.concat(self.__log, "\n"))

				break
			end
		end

		ti(refCOList, CO)

		CO = _dialogCO(CO.nextId)
	end
end

function V2a4_WarmUpConfig:textInfoCO(id)
	return lua_v2a4_warmup_text_info.configDict[id]
end

function V2a4_WarmUpConfig:textItemListCO(id)
	return lua_v2a4_warmup_text_item_list.configDict[id]
end

function V2a4_WarmUpConfig:getDialogDesc(dialogCO_dialogId)
	if not dialogCO_dialogId then
		return ""
	end

	local CO = type(dialogCO_dialogId) == "number" and _dialogCO(dialogCO_dialogId) or dialogCO_dialogId

	if isDebugBuild then
		local srcloc = sf("[logError] 2.4预热活动_接听电话.xlsx - export_对话内容库: id=%s", CO.id)

		return self:FmtFromCO(srcloc, CO.desc, CO)
	else
		return self:FmtFromCO(nil, CO.desc, CO)
	end
end

function V2a4_WarmUpConfig:getFmtEffectStr(id)
	local CO = _fmt_effectCO(id)
	local handler = CO.handler

	assert(not string.nilorempty(handler))
	self[handler](self, CO.args)
end

function V2a4_WarmUpConfig:fmt_const_strs(strList)
	local res = ""

	if not strList or #strList == 0 then
		return res
	end

	for _, str in ipairs(strList) do
		local id = tonumber(str)

		res = res .. self:getConstStr(id)
	end

	return res
end

function V2a4_WarmUpConfig:getDurationSec()
	return self:getConst(1) or 60
end

function V2a4_WarmUpConfig:getHangonWaitSec()
	return self:getConst(2) or 10
end

function V2a4_WarmUpConfig:getSentenceInBetweenSec()
	return self:getConst(3) or 1
end

local kFmtPrefix = "fmt"
local kFmtSymbol = "▩"

function V2a4_WarmUpConfig:FmtFromCO(srcloc, format, CO)
	if not sfind(format, kFmtSymbol) then
		return format
	end

	if isDebugBuild then
		self.__debug_fillParamsIndexDict = {}
		self.__log = {}

		for fillParamsIndex, sord in string.gmatch(format, "▩([0-9]+)%%([sd])") do
			self.__debug_fillParamsIndexDict[fillParamsIndex] = sord
		end
	end

	local i = 1
	local fieldName = kFmtPrefix .. i
	local fmtId = CO[fieldName]
	local fillParams = {}

	while fmtId ~= nil do
		if fmtId > 0 then
			ti(fillParams, self:getFmtEffectStr(fmtId))

			if isDebugBuild and not self.__debug_fillParamsIndexDict[i] then
				if #self.__log == 0 then
					ti(self.__log, "[V2a4_WarmUpConfig - FmtFromCO] =========== begin")
					ti(self.__log, sf("source: %s", srcloc))
				end

				ti(self.__log, sf("[logError] %s 未找到 ▩%s", fieldName, i))
			end
		end

		fmtId = CO[kFmtPrefix .. i]
	end

	if isDebugBuild and #self.__log ~= 0 then
		ti(self.__log, sf("error fotmat: %s", format))
		ti(self.__log, "[V2a4_WarmUpConfig - FmtFromCO] =========== end")
		logError(table.concat(self.__log, "\n"))
	end

	if #fillParams > 0 then
		return GameUtil.getSubPlaceholderLuaLang(format, fillParams)
	end

	return format
end

V2a4_WarmUpConfig.instance = V2a4_WarmUpConfig.New()

return V2a4_WarmUpConfig
