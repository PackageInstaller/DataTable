-- chunkname: @modules/logic/gm/GMTool__AccountDummper.lua

local getGlobal = _G.getGlobal
local GMTool = _G.getGlobal("Partial_GMTool")
local sf = string.format
local ti = table.insert
local tc = table.concat
local Input = UnityEngine.Input
local KeyCode = UnityEngine.KeyCode
local Time = _G.Time
local M = {}

local function _getPlatformName()
	local res = ""

	if SLFramework.FrameworkSettings.IsEditor then
		res = "UnityEditor"
	elseif BootNativeUtil.isAndroid() then
		res = "Android"
	elseif BootNativeUtil.isIOS() then
		res = "iOS"
	elseif BootNativeUtil.isWindows() then
		res = "Windows"
	elseif BootNativeUtil.isMacOS() then
		res = "Mac OS"
	end

	return res
end

local function _getServerTimeStr()
	local serverTs = ServerTime.now()
	local utc = ServerTime.GetUTCOffsetStr()
	local dt = os.date("!*t", serverTs + ServerTime.serverUtcOffset())

	return (sf("(%s) %04d-%02d-%02d %02d:%02d:%02d (%s)", serverTs, dt.year, dt.month, dt.day, dt.hour, dt.min, dt.sec, utc))
end

local function _getClientTimeStr()
	local clientTs = os.time()
	local dt = os.date("!*t", os.time())
	local clientUtcOffset = os.difftime(os.time(), os.time(dt))
	local utc = sf("UTC%+d", clientUtcOffset / 3600)

	return (sf("(%s) %s (%s)", clientTs, os.date("%Y-%m-%d %H:%M:%S", clientTs), utc))
end

function M:onClear()
	self._unscaledTime = 0
	self._keyCodeDownCount = 0

	return self
end

local kNeedkeyCodeDownCount = 2
local kInternal = 0.25

function M:onUpdate()
	local unscaledDeltaTime = Time.unscaledDeltaTime

	if Input.GetKeyDown(KeyCode.LeftControl) then
		local delta = self._unscaledTime - unscaledDeltaTime
		local ok = delta < kInternal

		if ok then
			self._keyCodeDownCount = self._keyCodeDownCount + 1
		end

		if self._keyCodeDownCount >= kNeedkeyCodeDownCount then
			self:onClear()
			self:_work()

			return
		end

		if not ok then
			self:onClear()

			self._keyCodeDownCount = 1
		end
	end

	self._unscaledTime = self._unscaledTime + unscaledDeltaTime
end

local kYellow = "#FFFF00"
local kGreen = "#00FF00"
local kWhite = "#FFFFFF"

function M:_work()
	local playerinfo = getGlobal("PlayerModel") and PlayerModel.instance:getPlayinfo() or {}
	local account = GMTool.util.setColorDesc(LoginModel.instance.channelUserId, kYellow)
	local uid = GMTool.util.setColorDesc(playerinfo.userId, kYellow)
	local userName = GMTool.util.setColorDesc(playerinfo.userName, kYellow)
	local serverName = GMTool.util.setColorDesc(LoginModel.instance.serverName, kYellow)
	local serverId = GMTool.util.setColorDesc(LoginModel.instance.serverId, kYellow)
	local platform = GMTool.util.setColorDesc(_getPlatformName(), kYellow)
	local curLanguage = GMTool.util.setColorDesc(LangSettings.instance:getCurLangShortcut(), kYellow)
	local curRegion = GMTool.util.setColorDesc(SettingsModel.instance:getRegionShortcut(), kYellow)
	local serverTime = GMTool.util.setColorDesc(_getServerTimeStr(), kYellow)
	local clientTime = GMTool.util.setColorDesc(_getClientTimeStr(), kYellow)
	local viewNameList = GMTool._input:_getOpeningViewNameList()
	local sb = {}

	ti(sb, "=============== Player Info ================")
	ti(sb, "account: " .. account)
	ti(sb, "uid/userId/playerId/roleId: " .. uid)
	ti(sb, "serverName: " .. serverName)
	ti(sb, "serverId: " .. serverId)
	ti(sb, "userName: " .. userName)
	ti(sb, "platform: " .. platform)
	ti(sb, "curLanguage: " .. curLanguage)
	ti(sb, "curRegion: " .. curRegion)
	ti(sb, "serverTime: " .. serverTime)
	ti(sb, "clientTime: " .. clientTime)

	for i, viewName in ipairs(viewNameList or {}) do
		if i == 1 then
			ti(sb, "dump view infos ========================= Begin")
		end

		local setting = ViewMgr.instance:getSetting(viewName)
		local name = GMTool.util.setColorDesc(viewName or "<Unknown>", kYellow)

		if setting then
			local path = GMTool.util.setColorDesc(setting.mainRes or "None", kGreen)
			local indexStr = "[" .. tostring(i) .. "]"

			indexStr = i == 1 and GMTool.util.setColorDesc(indexStr, kWhite) or indexStr

			ti(sb, "\t" .. indexStr .. " " .. name .. ": " .. path)

			if i == #viewNameList then
				ti(sb, "dump view infos ========================= End")
			end
		end
	end

	local msg = tc(sb, "\n")

	logError(msg)
	GMTool.util.saveClipboard(msg:gsub("%b<>", ""))
end

GMTool._accountDummper = M:onClear()

return {}
