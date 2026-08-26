-- chunkname: @modules/logic/settings/model/SettingsVoicePackageItemMo.lua

module("modules.logic.settings.model.SettingsVoicePackageItemMo", package.seeall)

local SettingsVoicePackageItemMo = pureTable("SettingsVoicePackageItemMo")

function SettingsVoicePackageItemMo:ctor()
	self.size = 0
	self.localSize = 0
	self.lang = ""
	self.nameLangId = ""
	self.localVersion = 0
	self.latestVersion = 0
	self.download_url = ""
	self.download_url_bak = ""
	self.downloadResList = {
		names = {},
		hashs = {},
		orders = {},
		lengths = {}
	}
end

function SettingsVoicePackageItemMo:setLang(lang, localVersion)
	self.lang = lang
	self.nameLangId = "langtype_" .. lang
	self.localVersion = localVersion
end

function SettingsVoicePackageItemMo:setLangInfo(langInfo)
	local latest_ver = langInfo.latest_ver

	if latest_ver then
		local temp = string.splitToNumber(latest_ver, ".")

		latest_ver = temp[2] or 0
	end

	self.latestVersion = latest_ver or 0
	self.download_url = langInfo.download_url
	self.download_url_bak = langInfo.download_url_bak

	if langInfo.res then
		local totalSize = 0
		local names, hashs, orders, lengths = {}, {}, {}, {}

		for _, one in ipairs(langInfo.res) do
			table.insert(names, one.name)
			table.insert(hashs, one.hash)
			table.insert(orders, one.order)
			table.insert(lengths, one.length)

			totalSize = totalSize + one.length
		end

		self.downloadResList.names = names
		self.downloadResList.hashs = hashs
		self.downloadResList.orders = orders
		self.downloadResList.lengths = lengths
		self.size = totalSize
	end
end

function SettingsVoicePackageItemMo:setLocalSize(localSize)
	self.localSize = localSize
end

function SettingsVoicePackageItemMo:getStatus()
	if GameResMgr.IsFromEditorDir then
		return SettingsVoicePackageController.AlreadyLatest
	end

	if self.lang == GameConfig:GetDefaultVoiceShortcut() then
		return SettingsVoicePackageController.AlreadyLatest
	end

	if not ProjBooter.instance:isUseBigZip() then
		local size = OptionPackageDownloadMgr.instance:GetUnmatchResSize(self.lang)

		return size > 0
	end

	if self.localVersion and self.localVersion > 0 then
		return SettingsVoicePackageController.AlreadyLatest
	end

	return SettingsVoicePackageController.instance:getPackItemState(self.lang, self.latestVersion)
end

function SettingsVoicePackageItemMo:hasLocalFile()
	if not ProjBooter.instance:isUseBigZip() then
		return HotUpdateOptionPackageMgr.instance:checkHasPackage(self.lang)
	end

	if self.lang == GameConfig:GetDefaultVoiceShortcut() then
		return SettingsVoicePackageController.AlreadyLatest
	end

	if self.localVersion and self.localVersion > 0 then
		return SettingsVoicePackageController.AlreadyLatest
	end

	return false
end

function SettingsVoicePackageItemMo:needDownload()
	if GameResMgr.IsFromEditorDir then
		return false
	end

	if self.lang == GameConfig:GetDefaultVoiceShortcut() then
		return false
	end

	if not ProjBooter.instance:isUseBigZip() then
		local size = OptionPackageDownloadMgr.instance:GetUnmatchResSize(self.lang)

		return size > 0
	end

	if self.localVersion and self.localVersion > 0 then
		return false
	end

	local state = self:getStatus()

	return state ~= SettingsVoicePackageController.AlreadyLatest
end

function SettingsVoicePackageItemMo:getLeftSizeMBorGB()
	local leftSize = not ProjBooter.instance:isUseBigZip() and OptionPackageDownloadMgr.instance:GetUnmatchResSize(self.lang) or math.max(0, self.size - self.localSize)
	local denominator = 1073741824
	local ret = leftSize / denominator
	local units = "GB"

	if ret < 0.1 then
		denominator = 1048576
		ret = leftSize / 1048576
		units = "MB"

		if leftSize / 1048576 < 0.01 then
			ret = 0.01
		end
	end

	return ret, math.max(0.01, self.size / denominator), units
end

function SettingsVoicePackageItemMo:getLeftSizeMBNum()
	local leftSize = not ProjBooter.instance:isUseBigZip() and OptionPackageDownloadMgr.instance:GetUnmatchResSize(self.lang) or math.max(0, self.size - self.localSize)
	local denominator = 1048576
	local ret = leftSize / denominator

	if ret < 0.01 then
		ret = 0.01
	end

	return ret
end

function SettingsVoicePackageItemMo:isCurVoice()
	return self.lang == GameConfig:GetCurVoiceShortcut()
end

return SettingsVoicePackageItemMo
