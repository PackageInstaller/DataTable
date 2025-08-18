-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\Lang.lua

local Lang = {}
local self = Lang

function Lang.init()
	self.inited = true

	if NO_CSHARP then
		return
	end

	if not RegionUtils or not RegionUtils.hasAbilityLocalization() then
		return
	end

	local curLanguage = Framework.Tools.LuaToolkit.GetCurLanguage()

	if curLanguage == RegionConst.LANGUAGE_CHF then
		curLanguage = RegionConst.LANGUAGE_CHS
	end

	local resPath = Framework.Tools.LuaToolkit.GetLuaLanguagePath(curLanguage)
	local status, res = pcall(require, resPath)

	if status then
		self.resTrans = res
	end

	if not IS_PUBLISH_VERSION then
		self.onFail = self.onFailDev
	end
end

function Lang.get(strId, values)
	if self.resTrans == nil then
		return "LANGUAGE_NOT_SUPPORTED"
	end

	if values then
		local translateInfo = self.resTrans[strId]

		if translateInfo and translateInfo.trans_strs then
			local transStr = ""

			for i = 1, #translateInfo.trans_strs do
				transStr = transStr .. translateInfo.trans_strs[i]

				if translateInfo.values_pos and translateInfo.values_pos[i] then
					transStr = transStr .. values[translateInfo.values_pos[i]]
				end
			end

			return transStr
		end
	elseif self.resTrans[strId] then
		return self.resTrans[strId]
	end

	return self.onFail(strId)
end

function Lang.getRes()
	return self.resTrans
end

function Lang.onFailDev(strId)
	return "ERR:" .. strId
end

function Lang.onFail(strId)
	return " "
end

self.init()

return Lang
