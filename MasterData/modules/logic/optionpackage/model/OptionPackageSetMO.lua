-- chunkname: @modules/logic/optionpackage/model/OptionPackageSetMO.lua

module("modules.logic.optionpackage.model.OptionPackageSetMO", package.seeall)

local OptionPackageSetMO = pureTable("OptionPackageSetMO")

function OptionPackageSetMO:init(packageName, langs, packMOModel)
	self.id = packageName or ""
	self.packName = packageName or ""
	self._packMOModel = packMOModel
	self._lang2IdDict = {}
	self._needDownloadLangs = {}
	self._neddDownLoadDict = {}
	self._allPackLangs = {}

	tabletool.addValues(self._needDownloadLangs, OptionPackageEnum.NeedPackLangList)
	tabletool.addValues(self._allPackLangs, OptionPackageEnum.NeedPackLangList)
	tabletool.addValues(self._allPackLangs, langs)

	for _, lang in ipairs(self._allPackLangs) do
		self._lang2IdDict[lang] = OptionPackageHelper.formatLangPackName(lang, self.packName)
	end

	for _, lang in ipairs(self._needDownloadLangs) do
		self._neddDownLoadDict[lang] = true
	end
end

function OptionPackageSetMO:getPackageMO(lang)
	if self._packMOModel and self._lang2IdDict[lang] then
		return self._packMOModel:getById(self._lang2IdDict[lang])
	end
end

function OptionPackageSetMO:hasLocalVersion()
	for _, lang in ipairs(self._allPackLangs) do
		local voiceMO = self:getPackageMO(lang)

		if voiceMO and voiceMO:hasLocalVersion() then
			return true
		end
	end

	return false
end

function OptionPackageSetMO:getDownloadSize(langs)
	local size = 0
	local localSize = 0

	for _, lang in ipairs(langs) do
		if not self._neddDownLoadDict[lang] then
			local packMO = self:getPackageMO(lang)

			if packMO then
				size = size + packMO.size
				localSize = localSize + packMO.localSize
			end
		end
	end

	for _, needLang in ipairs(self._needDownloadLangs) do
		local packMO = self:getPackageMO(needLang)

		if packMO then
			size = size + packMO.size
			localSize = localSize + packMO.localSize
		end
	end

	return size, localSize
end

function OptionPackageSetMO:isNeedDownload(langs)
	for _, needLang in ipairs(self._needDownloadLangs) do
		if self:_checkDownloadLang(needLang) then
			return true
		end
	end

	if langs and #langs > 0 then
		for _, lang in ipairs(langs) do
			if self:_checkDownloadLang(lang) then
				return true
			end
		end
	end

	return false
end

function OptionPackageSetMO:getDownloadInfoListTb(langs)
	local infoListTb = {}

	for _, lang in ipairs(self._needDownloadLangs) do
		self:_getDownloadInfoTb(lang, infoListTb)
	end

	if langs and #langs > 0 then
		for _, lang in ipairs(langs) do
			if not self._neddDownLoadDict[lang] then
				self:_getDownloadInfoTb(lang, infoListTb)
			end
		end
	end

	return infoListTb
end

function OptionPackageSetMO:_checkDownloadLang(lang)
	local packageMO = self:getPackageMO(lang)

	if packageMO and packageMO:isNeedDownload() then
		return true
	end

	return false
end

function OptionPackageSetMO:_getDownloadInfoTb(lang, getInfoListTb)
	getInfoListTb = getInfoListTb or {}

	local packageMO = self:getPackageMO(lang)

	if packageMO and packageMO:isNeedDownload() then
		local packInfo = packageMO:getPackInfo()

		if packInfo then
			getInfoListTb[packageMO.langPack] = packInfo
		end
	end

	return getInfoListTb
end

return OptionPackageSetMO
