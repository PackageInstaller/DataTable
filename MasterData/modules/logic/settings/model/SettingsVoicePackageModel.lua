-- chunkname: @modules/logic/settings/model/SettingsVoicePackageModel.lua

module("modules.logic.settings.model.SettingsVoicePackageModel", package.seeall)

local SettingsVoicePackageModel = class("SettingsVoicePackageModel", BaseModel)

function SettingsVoicePackageModel:onInit()
	if not HotUpdateVoiceMgr then
		return
	end

	self:updateVoiceList(true)
end

function SettingsVoicePackageModel:updateVoiceList(noCheck)
	local resList = {}

	self._packInfoDic = {}

	local supportLangList = self:getSupportVoiceLangs(noCheck)

	table.insert(supportLangList, "res-HD")

	local defaultLang = GameConfig:GetDefaultVoiceShortcut()

	for i = 1, #supportLangList do
		local lang = supportLangList[i]
		local localVersion = SettingsVoicePackageController.instance:getLocalVersionInt(lang)
		local newResItem = SettingsVoicePackageItemMo.New()

		newResItem:setLang(lang, localVersion)

		if lang == defaultLang then
			table.insert(resList, 1, newResItem)
		else
			table.insert(resList, newResItem)
		end

		self._packInfoDic[newResItem.lang] = newResItem
	end

	SettingsVoicePackageListModel.instance:setList(resList)
end

function SettingsVoicePackageModel:getSupportVoiceLangs(noCheck)
	local supportLangList = HotUpdateVoiceMgr.instance:getSupportVoiceLangs()
	local needKrJp = false

	if not noCheck and LangSettings.instance:isOverseas() == false then
		local forceNeedKrJpActivityId = tonumber(CommonConfig.instance:getConstStr(ConstEnum.ForceNeedKrJpActivityId))

		if forceNeedKrJpActivityId == 1 then
			needKrJp = true
		end

		local roleList = string.splitToNumber(CommonConfig.instance:getConstStr(ConstEnum.S01SpRole), "#")

		for _, heroId in ipairs(roleList) do
			if HeroModel.instance:getByHeroId(heroId) then
				needKrJp = true

				break
			end
		end
	end

	if needKrJp then
		if not tabletool.indexOf(supportLangList, LangSettings.shortcutTab[LangSettings.jp]) then
			table.insert(supportLangList, LangSettings.shortcutTab[LangSettings.jp])
		end

		if not tabletool.indexOf(supportLangList, LangSettings.shortcutTab[LangSettings.kr]) then
			table.insert(supportLangList, LangSettings.shortcutTab[LangSettings.kr])
		end
	end

	return supportLangList
end

function SettingsVoicePackageModel:getPackInfo(packName)
	return self._packInfoDic[packName]
end

function SettingsVoicePackageModel:getPackLangName(packName)
	local info = self:getPackInfo(packName)

	if info then
		return luaLang(info.nameLangId)
	else
		return ""
	end
end

function SettingsVoicePackageModel:setDownloadProgress(packName, curSize, allSize)
	local packInfo = self:getPackInfo(packName)

	if packInfo then
		packInfo:setLocalSize(curSize)
	end
end

function SettingsVoicePackageModel:onDownloadSucc(packName)
	local packInfo = self:getPackInfo(packName)

	if packInfo then
		local localVersion = SettingsVoicePackageController.instance:getLocalVersionInt(packName)

		packInfo:setLang(packName, localVersion)
	end
end

function SettingsVoicePackageModel:onDeleteVoicePack(packName)
	local packInfo = self:getPackInfo(packName)

	if packInfo then
		local localVersion = SettingsVoicePackageController.instance:getLocalVersionInt(packName)

		packInfo:setLang(packName, localVersion)
	end
end

function SettingsVoicePackageModel:getLocalVoiceTypeList()
	local typeList = {}

	for lang, v in pairs(self._packInfoDic) do
		if v:hasLocalFile() then
			table.insert(typeList, lang)
		end
	end

	return typeList
end

function SettingsVoicePackageModel:clearNeedDownloadSize(packName)
	local packInfo = self:getPackInfo(packName)

	if packInfo then
		packInfo:setLocalSize(0)
	end
end

SettingsVoicePackageModel.instance = SettingsVoicePackageModel.New()

return SettingsVoicePackageModel
