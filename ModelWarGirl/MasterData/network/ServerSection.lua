-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Network\\ServerSection.lua

local LuaToolkit = Framework.Tools.LuaToolkit
local HttpHelper = require("Network/HttpHelper")
local OpenServerConst = require("Network/OpenServerConst")
local EventConst = require("EventConst")
local UserData = require("Helper/UserData")
local SDKConst = require("SDK/SDKConst")
local ResponseCode = SDKConst.ResponseCode
local ServerSection = {}
local self = ServerSection
local STATE_INIT = 0
local STATE_BUSY = 1
local STATE_DONE = 2
local SectionData = {}

function SectionData.create(section, data)
	if data == nil then
		return nil
	end

	local tokenData = data[OpenServerConst.SECTION_TOKEN]
	local entryData = data[OpenServerConst.SECTION_ENTRY]
	local locationData = data[OpenServerConst.SECTION_LOCATION]
	local recommendSection = data[OpenServerConst.SECTION_RECOMMEND]

	if tokenData and entryData and locationData and recommendSection then
		local sectionInfo = {}

		sectionInfo.section = section
		sectionInfo.tokenData = tokenData
		sectionInfo.entryData = entryData
		sectionInfo.roleLevel, sectionInfo.roleName = SectionData._getMaxLevelRole(entryData)
		sectionInfo.recommendSection = recommendSection

		return sectionInfo
	else
		return nil
	end
end

function SectionData._getMaxLevelRole(entryData)
	local roleList = entryData and entryData.recent

	if not roleList then
		return -1, nil
	end

	local maxLevel = -1
	local roleName

	for i, roleData in ipairs(roleList) do
		local level = roleData.level

		if level and maxLevel < level then
			roleName = roleData.name
			maxLevel = level
		end
	end

	return maxLevel, roleName
end

function ServerSection.init()
	self.sections = nil

	if ChannelUtil.isSteam() then
		self.sections = Const.STEAM_SECTIONS
	else
		self.sections = Const.SEA_SECTIONS
	end

	self._stateDict = {}
	self._data = {}

	for i, section in ipairs(self.sections) do
		self._stateDict[section] = STATE_INIT
	end
end

function ServerSection.setData(reqData)
	self._reqData = reqData
end

function ServerSection.request(callback)
	self._callback = callback

	if not RegionUtils.isSEA or self._reqData == nil then
		ServerSection._doCallback(false)

		return
	end

	local stateDict = self._stateDict
	local urlDict = self._getUrls(self.sections)

	self._sendRequest(urlDict)
end

function ServerSection.getRecommendSection()
	return self._recommendSection
end

function ServerSection.getDefaultSection()
	return self._defaultSection
end

function ServerSection.getTokenData(section)
	local sectionInfo = self._data[section]

	return sectionInfo and sectionInfo.tokenData
end

function ServerSection._getUrls(sections)
	local UrlConfig = require("Network/UrlConfig")
	local spMarkRaw = LuaToolkit.GetPatchSPMark()
	local urlDict = UrlConfig.getSectionOpenUrls(spMarkRaw, sections, UrlConfig.Const.ACCOUNT_ENTRY)

	return urlDict
end

function ServerSection._sendRequest(urlDict)
	local strData = ClientUtils.table2String(self._reqData)
	local sent = false

	for section, url in pairs(urlDict) do
		if self._stateDict[section] == STATE_INIT then
			self._stateDict[section] = STATE_BUSY

			HttpHelper.post(url, strData, Slot(self._onResponse, section))

			sent = true
		end
	end

	if not sent then
		self._doCallback()
	end
end

function ServerSection._onResponse(section, responseCode, dataString)
	local sectionInfo

	if responseCode == ResponseCode.SUCC then
		local data = ClientUtils.string2Table(dataString)

		sectionInfo = SectionData.create(section, data)
	end

	self._setData(section, sectionInfo)

	if self._isNotBusy() then
		self._allConnected = self._areAllConnected()

		self._decide()
		self._doCallback()
	end
end

function ServerSection._setData(section, sectionInfo)
	if sectionInfo then
		self._stateDict[section] = STATE_DONE
		self._data[section] = sectionInfo
	else
		self._stateDict[section] = STATE_INIT
	end
end

function ServerSection._decide()
	local recommend = ServerSection._getRecommendSection()
	local default

	if self._allConnected then
		local roleList = ServerSection._getRoleList()

		if #roleList == 0 then
			default = recommend
		else
			local recommendLevel = -1

			for _, roleData in ipairs(roleList) do
				if roleData[3] == recommend then
					recommendLevel = roleData[1]
				end
			end

			local maxData = roleList[1]

			if maxData[1] == recommendLevel then
				default = recommend
			else
				default = maxData[3]
			end
		end
	end

	self._recommendSection = recommend
	self._defaultSection = default
end

function ServerSection._isNotBusy()
	for section, state in pairs(self._stateDict) do
		if state == STATE_BUSY then
			return false
		end
	end

	return true
end

function ServerSection._areAllConnected()
	for section, state in pairs(self._stateDict) do
		if state ~= STATE_DONE then
			return false
		end
	end

	return true
end

local function _compareFirst(a, b)
	return b[1] < a[1]
end

function ServerSection._getRoleList()
	local roles = {}

	for section, sectionInfo in pairs(self._data) do
		if sectionInfo.roleLevel >= 0 then
			table.insert(roles, {
				sectionInfo.roleLevel,
				sectionInfo.roleName,
				section
			})
		end
	end

	table.sort(roles, _compareFirst)

	return roles
end

function ServerSection._getRecommendSection()
	for section, sectionInfo in pairs(self._data) do
		local recommend = sectionInfo.recommendSection

		if recommend then
			return recommend
		end
	end

	return nil
end

function ServerSection._doCallback(...)
	local callback = self._callback

	self._callback = nil

	if callback then
		callback(...)
	end

	EventCenter.sendEvent(EventConst.SERVER_SECTION_CHANGED)
end

local SERVER_SECTION_KEY = "_SERVER_SECTION"
local _serverSection = UserData.loadCommonDataWithDefualt(SERVER_SECTION_KEY, nil)

function ServerSection.getSection()
	if ChannelUtil.isSteam() then
		return Const.STEAM_SECTIONS[1]
	end

	if not VersionUtils.isSectionEnabled() then
		return Const.SEA_SECTIONS[1]
	end

	if _serverSection and Const.SEA_SECTION_NAME[_serverSection] then
		return _serverSection
	end

	return nil
end

function ServerSection.setSection(mark)
	UserData.saveCommonData(SERVER_SECTION_KEY, mark)
	UserData.save()

	_serverSection = mark

	local UrlConfig = require("Network/UrlConfig")

	UrlConfig.updateUrls()
end

self.init()

return ServerSection
