-- chunkname: @modules/logic/gm/model/GMHelpViewBrowseModel.lua

module("modules.logic.gm.model.GMHelpViewBrowseModel", package.seeall)

local GMHelpViewBrowseModel = class("GMHelpViewBrowseModel", ListScrollModel)

GMHelpViewBrowseModel.tabModeEnum = {
	weekWalkRuleView = 5,
	fightTechniqueView = 3,
	helpView = 1,
	fightTechniqueTipView = 4,
	fightGuideView = 2
}

function GMHelpViewBrowseModel:ctor()
	GMHelpViewBrowseModel.super.ctor(self)
end

function GMHelpViewBrowseModel:reInit()
	return
end

function GMHelpViewBrowseModel:getCurrentTabMode()
	return self._currentTabMode
end

function GMHelpViewBrowseModel:setListByTabMode(tabMode)
	if self._currentTabMode and self._currentTabMode == tabMode then
		return
	end

	local list = {}

	if tabMode == GMHelpViewBrowseModel.tabModeEnum.helpView then
		list = self:_getHelpViewList()
	elseif tabMode == GMHelpViewBrowseModel.tabModeEnum.fightGuideView then
		list = self:_getFightGuideList()
	elseif tabMode == GMHelpViewBrowseModel.tabModeEnum.fightTechniqueView then
		list = self:_getFightTechniqueList()
	elseif tabMode == GMHelpViewBrowseModel.tabModeEnum.fightTechniqueTipView then
		list = self:_getFightTechniqueTipList()
	elseif tabMode == GMHelpViewBrowseModel.tabModeEnum.weekWalkRuleView then
		list = self:_getWeekWalkRuleList()
	else
		logError("GMHelpViewBrowseModel错误，tabMode获取列表未定义：" .. tabMode)

		return
	end

	self._currentTabMode = tabMode

	self:setList(list)
	self:onModelUpdate()
end

function GMHelpViewBrowseModel:_getHelpViewList()
	local list = {}

	for _, helpPageCO in ipairs(lua_helppage.configList) do
		if not string.nilorempty(helpPageCO.icon) then
			local iconPath = ResUrl.getHelpItem(helpPageCO.icon, helpPageCO.isCn == 1)
			local iconPathEditor = System.IO.Path.Combine(SLFramework.FrameworkSettings.AssetRootDir, iconPath)

			if SLFramework.FileHelper.IsFileExists(iconPathEditor) then
				table.insert(list, helpPageCO)
			end
		end
	end

	return list
end

function GMHelpViewBrowseModel:_getFightGuideList()
	local list = {}
	local fightGuideLangDir = ResUrl.getFightGuideLangDir()

	self:_fillFightGuideListByDirPath(list, fightGuideLangDir)

	local fightGuideDir = ResUrl.getFightGuideDir()

	self:_fillFightGuideListByDirPath(list, fightGuideDir)

	return list
end

function GMHelpViewBrowseModel:_fillFightGuideListByDirPath(list, dirPath)
	local allLangIconPath = SLFramework.FileHelper.GetDirFilePaths(dirPath)

	if not allLangIconPath then
		return
	end

	for i = 0, allLangIconPath.Length - 1 do
		local path = allLangIconPath[i]
		local iconNameWithoutSuffix = path:match(".+/([^/]+)%.png$")

		if iconNameWithoutSuffix then
			local id = iconNameWithoutSuffix:match("%d+$")

			if id then
				local pageConfig = {}

				pageConfig.id = tonumber(id)
				pageConfig.icon = iconNameWithoutSuffix

				table.insert(list, pageConfig)
			end
		end
	end
end

function GMHelpViewBrowseModel:_getFightTechniqueList()
	local list = {}

	for _, fightTechniqueConfig in ipairs(lua_fight_technique.configList) do
		local pageConfig = {}

		pageConfig.id = fightTechniqueConfig.id
		pageConfig.icon = fightTechniqueConfig.picture1

		table.insert(list, pageConfig)
	end

	return list
end

function GMHelpViewBrowseModel:_getFightTechniqueTipList()
	local list = {}

	for _, fightTechniqueConfig in ipairs(lua_fight_technique.configList) do
		if not string.nilorempty(fightTechniqueConfig.picture2) then
			local pageConfig = {}

			pageConfig.id = fightTechniqueConfig.id
			pageConfig.icon = fightTechniqueConfig.picture2

			table.insert(list, pageConfig)
		end
	end

	return list
end

function GMHelpViewBrowseModel:_getWeekWalkRuleList()
	local list = {}

	for _, ruleConfig in ipairs(lua_weekwalk_rule.configList) do
		local pageConfig = {}

		pageConfig.id = ruleConfig.id
		pageConfig.icon = ruleConfig.icon

		table.insert(list, pageConfig)
	end

	return list
end

GMHelpViewBrowseModel.instance = GMHelpViewBrowseModel.New()

return GMHelpViewBrowseModel
