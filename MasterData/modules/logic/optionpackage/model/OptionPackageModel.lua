-- chunkname: @modules/logic/optionpackage/model/OptionPackageModel.lua

module("modules.logic.optionpackage.model.OptionPackageModel", package.seeall)

local OptionPackageModel = class("OptionPackageModel", BaseModel)

function OptionPackageModel:ctor()
	self._setMOModel = BaseModel.New()
	self._packMOModel = BaseModel.New()
	self._initialized = false
	self._voiceLangsDict = {}

	OptionPackageModel.super.ctor(self)
end

function OptionPackageModel:onInit()
	if not HotUpdateVoiceMgr then
		return
	end

	self._initialized = true

	if not OptionPackageEnum.PackageNameList then
		local supportLangList = self:getSupportVoiceLangs()

		if not HotUpdateVoiceMgr.ForceSelect then
			local defaultVoiceLang = GameConfig:GetDefaultVoiceShortcut()

			for _, lang in ipairs(supportLangList) do
				local tempLangs = {}

				self._voiceLangsDict[lang] = tempLangs

				table.insert(tempLangs, lang)

				for forecLang, flag in pairs(HotUpdateVoiceMgr.ForceSelect) do
					if not tabletool.indexOf(tempLangs, forecLang) then
						table.insert(tempLangs, forecLang)
					end
				end

				if not tabletool.indexOf(tempLangs, defaultVoiceLang) then
					table.insert(tempLangs, defaultVoiceLang)
				end
			end

			local setMOList = {}

			for _, packageName in ipairs(OptionPackageEnum.PackageNameList) do
				local setMO = OptionPackageSetMO.New()

				setMO:init(packageName, supportLangList, self._packMOModel)
				table.insert(setMOList, setMO)
			end

			local packMOList = {}

			self._setMOModel:setList(setMOList)
			self._packMOModel:setList(packMOList)
		end
	end
end

function OptionPackageModel:getSupportVoiceLangs()
	if not self._supportVoiceLangList then
		self._supportVoiceLangList = {}

		if HotUpdateVoiceMgr then
			local voiceList = HotUpdateVoiceMgr.instance:getSupportVoiceLangs()

			tabletool.addValues(self._supportVoiceLangList, HotUpdateVoiceMgr)
		end
	end

	return self._supportVoiceLangList
end

function OptionPackageModel:reInit()
	self._localPackSetNameList = nil
end

function OptionPackageModel:setOpenInfo(info)
	for langPack, packInfo in pairs(info) do
		local packMO = self:getPackageMO(langPack)

		if packMO then
			packMO:setLangInfo(packInfo)
		end
	end
end

function OptionPackageModel:getPackageMO(packName)
	return self._packMOModel:getById(packName)
end

function OptionPackageModel:getPackageMOList()
	return self._packMOModel:getList()
end

function OptionPackageModel:addPackageMO(mo)
	self._packMOModel:addAtLast(mo)
end

function OptionPackageModel:addPackageMOList(moList)
	self._packMOModel:addList(moList)
end

function OptionPackageModel:getPackageSetMO(package)
	return self._setMOModel:getById(package)
end

function OptionPackageModel:getPackageSetMOList()
	return self._setMOModel:getList()
end

function OptionPackageModel:setDownloadProgress(packName, curSize, allSize)
	local packMO = self:getPackageMO(packName)

	if packMO then
		packMO:setLocalSize(curSize)
	end
end

function OptionPackageModel:updateLocalVersion(packName)
	local packMO = self:getPackageMO(packName)

	if packMO then
		local localVersion = OptionPackageController.instance:getLocalVersionInt(packName)

		packMO:setLocalVersion(localVersion)
	end
end

function OptionPackageModel:onDownloadSucc(packName)
	self:updateLocalVersion(packName)
end

function OptionPackageModel:onDeleteVoicePack(packName)
	self:updateLocalVersion(packName)
end

function OptionPackageModel:getNeedVoiceLangList(lang)
	lang = lang or GameConfig:GetCurVoiceShortcut()

	return self._voiceLangsDict[lang] or self._voiceLangsDict[GameConfig:GetDefaultVoiceShortcut()]
end

function OptionPackageModel:addLocalPackSetName(packSetName)
	if not self._initialized then
		return
	end

	if not OptionPackageEnum.HasPackageNameDict[packSetName] then
		return
	end

	local packSetNameList = HotUpdateOptionPackageMgr.instance:getPackageNameList()

	if not tabletool.indexOf(packSetNameList, packSetName) then
		table.insert(packSetNameList, packSetName)
		HotUpdateOptionPackageMgr.instance:savePackageNameList(packSetNameList)
	end
end

function OptionPackageModel:saveLocalPackSetName()
	if not self._initialized then
		return
	end

	local packSetNameList = self:_getLocalSetNameList()
	local setMOList = self:getPackageSetMOList()

	for _, setMO in ipairs(setMOList) do
		local packSetName = setMO.packName

		if setMO:hasLocalVersion() and not tabletool.indexOf(packSetNameList, packSetName) then
			table.insert(packSetNameList, packSetName)
		end
	end

	HotUpdateOptionPackageMgr.instance:savePackageNameList(packSetNameList)
end

function OptionPackageModel:_getLocalSetNameList()
	self._localPackSetNameList = self._localPackSetNameList or HotUpdateOptionPackageMgr.instance:getPackageNameList() or {}

	return self._localPackSetNameList
end

OptionPackageModel.instance = OptionPackageModel.New()

return OptionPackageModel
