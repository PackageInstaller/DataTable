-- chunkname: @modules/logic/optionpackage/model/OptionPackageMO.lua

module("modules.logic.optionpackage.model.OptionPackageMO", package.seeall)

local OptionPackageMO = pureTable("OptionPackageMO")

function OptionPackageMO:init(packageName, lang)
	self.packeName = packageName or ""
	self.lang = lang or ""
	self.id = OptionPackageHelper.formatLangPackName(self.lang, self.packeName)
	self.langPack = OptionPackageHelper.formatLangPackName(self.lang, self.packeName)
	self.nameLangId = "langtype_" .. self.lang
	self.size = 0
	self.localSize = 0
	self.localVersion = 0
	self.latestVersion = 0
	self.download_url = ""
	self.download_url_bak = ""
	self.download_res = {}
	self.downloadResList = {
		names = {},
		hashs = {},
		orders = {},
		lengths = {}
	}
	self._landPackInfo = nil
end

function OptionPackageMO:setLocalVersion(localVersion)
	self.localVersion = localVersion
end

function OptionPackageMO:setPackInfo(packInfo)
	self._landPackInfo = packInfo

	local latest_ver = packInfo.latest_ver

	if latest_ver then
		local temp = string.splitToNumber(latest_ver, ".")

		latest_ver = temp[2] or 0
	end

	self.latestVersion = latest_ver or 0
	self.download_url = packInfo.download_url
	self.download_url_bak = packInfo.download_url_bak
	self.download_res = {}

	tabletool.addValues(self.download_res, packInfo.res)

	if packInfo.res then
		local totalSize = 0
		local names, hashs, orders, lengths = {}, {}, {}, {}

		for _, one in ipairs(packInfo.res) do
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

function OptionPackageMO:getPackInfo()
	return self._landPackInfo
end

function OptionPackageMO:setLocalSize(localSize)
	self.localSize = localSize
end

function OptionPackageMO:isNeedDownload()
	return self:getStatus() ~= OptionPackageEnum.UpdateState.AlreadyLatest
end

function OptionPackageMO:getStatus()
	if self.latestVersion <= 0 then
		return OptionPackageEnum.UpdateState.NotDownload
	end

	if self.localVersion >= self.latestVersion or not self.download_res or #self.download_res < 1 then
		return OptionPackageEnum.UpdateState.AlreadyLatest
	end

	return OptionPackageController.instance:getPackItemState(self.id, self.latestVersion)
end

function OptionPackageMO:hasLocalVersion()
	if self.localVersion and self.localVersion > 0 then
		return true
	end

	return false
end

return OptionPackageMO
