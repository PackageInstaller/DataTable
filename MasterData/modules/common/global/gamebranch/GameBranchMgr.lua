-- chunkname: @modules/common/global/gamebranch/GameBranchMgr.lua

module("modules.common.global.gamebranch.GameBranchMgr", package.seeall)

local sf = string.format
local tonumber = _G.tonumber
local assert = _G.assert
local GameBranchMgr = class("GameBranchMgr")
local s_versionInfo = false

local function _getLatestVersion(out)
	local format = "AudioEnum%s_%s"
	local V = 1
	local A = 5

	out.V = V
	out.A = A

	while V < math.huge do
		while A < 10 do
			local clsName = sf(format, V, A)
			local cls = _G[clsName]

			if not cls then
				local oldA = A

				while A < 10 do
					A = A + 1
					clsName = sf(format, V, A)
					cls = _G[clsName]

					if _G[clsName] then
						break
					end
				end

				if oldA == 0 and not cls then
					return
				end

				if A >= 10 then
					break
				end
			end

			if A == 0 and not cls then
				return
			elseif not cls then
				break
			end

			out.V = V
			out.A = A
			A = A + 1
		end

		V = V + 1
		A = 0
	end
end

function GameBranchMgr:ctor()
	if not s_versionInfo then
		s_versionInfo = {}

		_getLatestVersion(s_versionInfo)
	end

	self._versionInfo = s_versionInfo
end

function GameBranchMgr:init(major, minor)
	major = major or s_versionInfo.V
	minor = minor or s_versionInfo.A

	if tonumber(major) then
		assert(tonumber(major) >= 1)

		minor = minor or 0
	else
		major = s_versionInfo.V
		minor = s_versionInfo.A
	end

	self:_init(major, minor)
end

function GameBranchMgr:_init(major, minor)
	self._versionInfo = {
		V = major,
		A = minor
	}

	if isDebugBuild then
		local msg = sf("<color=#FFFF00>[GameBranchMgr] 当前版本: %s</color>", self:VHyphenA())

		logNormal(msg)
	end
end

function GameBranchMgr:inject()
	local versionFullInfo = self:versionFullInfo()

	self:_module_views(versionFullInfo)
end

function GameBranchMgr:_module_views(versionFullInfo)
	local module_views = require("modules.setting.module_views")

	ActivityController.instance:onModuleViews(versionFullInfo, module_views)
end

function GameBranchMgr:lastVersionInfo()
	local major, minor = self._versionInfo.V, self._versionInfo.A

	return self:getLastVersionInfo(major, minor)
end

function GameBranchMgr:versionFullInfo()
	local curVersionInfo = self._versionInfo
	local lastVersionInfo = self:lastVersionInfo()

	return {
		curV = curVersionInfo.V,
		curA = curVersionInfo.A,
		lastV = lastVersionInfo.V,
		lastA = lastVersionInfo.A
	}
end

function GameBranchMgr:getLastVersionInfo(major, minor)
	if minor <= 0 then
		minor = 9
		major = major - 1
	end

	if major <= 0 then
		major = 1
		minor = 0
	end

	return {
		V = major,
		A = minor
	}
end

function GameBranchMgr:getMajorVer()
	return self._versionInfo.V
end

function GameBranchMgr:getMinorVer()
	return self._versionInfo.A
end

function GameBranchMgr:VHyphenA()
	return self:getMajorVer() .. "-" .. self:getMinorVer()
end

function GameBranchMgr:getVxax()
	return "V" .. self:getMajorVer() .. "a" .. self:getMinorVer()
end

function GameBranchMgr:getvxax()
	return "v" .. self:getMajorVer() .. "a" .. self:getMinorVer()
end

function GameBranchMgr:getVxax_()
	return self:getVxax() .. "_"
end

function GameBranchMgr:getvxax_()
	return self:getvxax() .. "_"
end

function GameBranchMgr:getV_a()
	return self:getMajorVer() .. "_" .. self:getMinorVer()
end

function GameBranchMgr:getv_a()
	return self:getV_a()
end

function GameBranchMgr:V_a(prefix, suffix)
	prefix = prefix or ""
	suffix = suffix or ""

	return prefix .. self:getV_a() .. suffix
end

function GameBranchMgr:v_a(prefix, suffix)
	return self:V_a(prefix, suffix)
end

function GameBranchMgr:Vxax(prefix, suffix)
	prefix = prefix or ""
	suffix = suffix or ""

	return prefix .. self:getVxax() .. suffix
end

function GameBranchMgr:vxax(prefix, suffix)
	prefix = prefix or ""
	suffix = suffix or ""

	return prefix .. self:getvxax() .. suffix
end

function GameBranchMgr:Vxax_(what)
	return self:getVxax_() .. what
end

function GameBranchMgr:vxax_(what)
	return self:getvxax_() .. what
end

function GameBranchMgr:Vxax_ActId(ActivityEnum_Activity_key, defaultEnumValue_ActivityEnum_Activity)
	local e = self:Vxax_(ActivityEnum_Activity_key)
	local actId = ActivityEnum.Activity[e]

	return actId or defaultEnumValue_ActivityEnum_Activity
end

function GameBranchMgr:Vxax_ViewName(ViewName_key, defaultViewName)
	local viewname = self:Vxax_(ViewName_key)

	return _G.ViewName[viewname] or defaultViewName
end

function GameBranchMgr:isVer(major, minor)
	if not major then
		return false
	end

	minor = math.max(0, minor or 0)

	local V = self:getMajorVer()

	if V == major then
		local A = self:getMinorVer()

		return minor <= A
	end

	return major < V
end

function GameBranchMgr:isOnVer(major, minor)
	if not major then
		return false
	end

	minor = math.max(0, minor or 0)

	local V = self:getMajorVer()
	local A = self:getMinorVer()

	return V == major and A == minor
end

function GameBranchMgr:isOnPreVer(major, minor)
	if not major then
		return false
	end

	minor = math.max(0, minor or 0)

	local V = self:getMajorVer()

	if V == major then
		local A = self:getMinorVer()

		return A <= minor
	end

	return V < major
end

function GameBranchMgr:isV1a0()
	return self:isVer(1, 0)
end

function GameBranchMgr:isV1a1()
	return self:isVer(1, 1)
end

function GameBranchMgr:isV1a2()
	return self:isVer(1, 2)
end

function GameBranchMgr:isV1a3()
	return self:isVer(1, 3)
end

function GameBranchMgr:isV1a4()
	return self:isVer(1, 4)
end

function GameBranchMgr:isV1a5()
	return self:isVer(1, 5)
end

function GameBranchMgr:isV1a6()
	return self:isVer(1, 6)
end

function GameBranchMgr:isV1a7()
	return self:isVer(1, 7)
end

function GameBranchMgr:isV1a8()
	return self:isVer(1, 8)
end

function GameBranchMgr:isV1a9()
	return self:isVer(1, 9)
end

function GameBranchMgr:isV2a0()
	return self:isVer(2, 0)
end

function GameBranchMgr:isV2a1()
	return self:isVer(2, 1)
end

function GameBranchMgr:isV2a2()
	return self:isVer(2, 2)
end

function GameBranchMgr:isV2a3()
	return self:isVer(2, 3)
end

function GameBranchMgr:isV2a4()
	return self:isVer(2, 4)
end

function GameBranchMgr:isV2a5()
	return self:isVer(2, 5)
end

function GameBranchMgr:isV2a6()
	return self:isVer(2, 6)
end

function GameBranchMgr:isV2a7()
	return self:isVer(2, 7)
end

function GameBranchMgr:isV2a8()
	return self:isVer(2, 8)
end

function GameBranchMgr:isV2a9()
	return self:isVer(2, 9)
end

function GameBranchMgr:isV3a0()
	return self:isVer(3, 0)
end

function GameBranchMgr:isV3a1()
	return self:isVer(3, 1)
end

function GameBranchMgr:isV3a2()
	return self:isVer(3, 2)
end

function GameBranchMgr:isV3a3()
	return self:isVer(3, 3)
end

function GameBranchMgr:isV3a4()
	return self:isVer(3, 4)
end

function GameBranchMgr:isV3a5()
	return self:isVer(3, 5)
end

function GameBranchMgr:isV3a6()
	return self:isVer(3, 6)
end

function GameBranchMgr:isV3a7()
	return self:isVer(3, 7)
end

function GameBranchMgr:isV3a8()
	return self:isVer(3, 8)
end

function GameBranchMgr:isV3a9()
	return self:isVer(3, 9)
end

function GameBranchMgr:isV4a0()
	return self:isVer(4, 0)
end

function GameBranchMgr:isV4a1()
	return self:isVer(4, 1)
end

function GameBranchMgr:isV4a2()
	return self:isVer(4, 2)
end

function GameBranchMgr:isV4a3()
	return self:isVer(4, 3)
end

function GameBranchMgr:isV4a4()
	return self:isVer(4, 4)
end

function GameBranchMgr:isV4a5()
	return self:isVer(4, 5)
end

function GameBranchMgr:isV4a6()
	return self:isVer(4, 6)
end

function GameBranchMgr:isV4a7()
	return self:isVer(4, 7)
end

function GameBranchMgr:isV4a8()
	return self:isVer(4, 8)
end

function GameBranchMgr:isV4a9()
	return self:isVer(4, 9)
end

function GameBranchMgr:isV5a0()
	return self:isVer(5, 0)
end

function GameBranchMgr:isV5a1()
	return self:isVer(5, 1)
end

function GameBranchMgr:isV5a2()
	return self:isVer(5, 2)
end

function GameBranchMgr:isV5a3()
	return self:isVer(5, 3)
end

function GameBranchMgr:isV5a4()
	return self:isVer(5, 4)
end

function GameBranchMgr:isV5a5()
	return self:isVer(5, 5)
end

function GameBranchMgr:isV5a6()
	return self:isVer(5, 6)
end

function GameBranchMgr:isV5a7()
	return self:isVer(5, 7)
end

function GameBranchMgr:isV5a8()
	return self:isVer(5, 8)
end

function GameBranchMgr:isV5a9()
	return self:isVer(5, 9)
end

function GameBranchMgr:isV6a0()
	return self:isVer(6, 0)
end

function GameBranchMgr:isV6a1()
	return self:isVer(6, 1)
end

function GameBranchMgr:isV6a2()
	return self:isVer(6, 2)
end

function GameBranchMgr:isV6a3()
	return self:isVer(6, 3)
end

function GameBranchMgr:isV6a4()
	return self:isVer(6, 4)
end

function GameBranchMgr:isV6a5()
	return self:isVer(6, 5)
end

function GameBranchMgr:isV6a6()
	return self:isVer(6, 6)
end

function GameBranchMgr:isV6a7()
	return self:isVer(6, 7)
end

function GameBranchMgr:isV6a8()
	return self:isVer(6, 8)
end

function GameBranchMgr:isV6a9()
	return self:isVer(6, 9)
end

function GameBranchMgr:isV7a0()
	return self:isVer(7, 0)
end

function GameBranchMgr:isV7a1()
	return self:isVer(7, 1)
end

function GameBranchMgr:isV7a2()
	return self:isVer(7, 2)
end

function GameBranchMgr:isV7a3()
	return self:isVer(7, 3)
end

function GameBranchMgr:isV7a4()
	return self:isVer(7, 4)
end

function GameBranchMgr:isV7a5()
	return self:isVer(7, 5)
end

function GameBranchMgr:isV7a6()
	return self:isVer(7, 6)
end

function GameBranchMgr:isV7a7()
	return self:isVer(7, 7)
end

function GameBranchMgr:isV7a8()
	return self:isVer(7, 8)
end

function GameBranchMgr:isV7a9()
	return self:isVer(7, 9)
end

function GameBranchMgr:isV8a0()
	return self:isVer(8, 0)
end

function GameBranchMgr:isV8a1()
	return self:isVer(8, 1)
end

function GameBranchMgr:isV8a2()
	return self:isVer(8, 2)
end

function GameBranchMgr:isV8a3()
	return self:isVer(8, 3)
end

function GameBranchMgr:isV8a4()
	return self:isVer(8, 4)
end

function GameBranchMgr:isV8a5()
	return self:isVer(8, 5)
end

function GameBranchMgr:isV8a6()
	return self:isVer(8, 6)
end

function GameBranchMgr:isV8a7()
	return self:isVer(8, 7)
end

function GameBranchMgr:isV8a8()
	return self:isVer(8, 8)
end

function GameBranchMgr:isV8a9()
	return self:isVer(8, 9)
end

function GameBranchMgr:isV9a0()
	return self:isVer(9, 0)
end

function GameBranchMgr:isV9a1()
	return self:isVer(9, 1)
end

function GameBranchMgr:isV9a2()
	return self:isVer(9, 2)
end

function GameBranchMgr:isV9a3()
	return self:isVer(9, 3)
end

function GameBranchMgr:isV9a4()
	return self:isVer(9, 4)
end

function GameBranchMgr:isV9a5()
	return self:isVer(9, 5)
end

function GameBranchMgr:isV9a6()
	return self:isVer(9, 6)
end

function GameBranchMgr:isV9a7()
	return self:isVer(9, 7)
end

function GameBranchMgr:isV9a8()
	return self:isVer(9, 8)
end

function GameBranchMgr:isV9a9()
	return self:isVer(9, 9)
end

GameBranchMgr.instance = GameBranchMgr.New()

return GameBranchMgr
