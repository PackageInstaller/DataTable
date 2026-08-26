-- chunkname: @modules/logic/gm/view/GMSubViewCommon.lua

module("modules.logic.gm.view.GMSubViewCommon", package.seeall)

local GMSubViewCommon = class("GMSubViewCommon", GMSubViewBase)

function GMSubViewCommon:ctor()
	self.tabName = "其他"
end

require("tolua.reflection")
tolua.loadassembly("UnityEngine.UI")

local type_linetype = tolua.findtype("UnityEngine.UI.InputField+LineType")
local MultiLineSubmit = System.Enum.Parse(type_linetype, "MultiLineSubmit")
local MultiLineNewline = System.Enum.Parse(type_linetype, "MultiLineNewline")

function GMSubViewCommon:initViewContent()
	if self._inited then
		return
	end

	GMSubViewBase.initViewContent(self)
	self:addTitleSplitLine("日志上传")
	self.addButton(self, "L-1", "上传此次运行日志文件", self._onClickUploadCurLog, self)
	self.addButton(self, "L-1", "上传上次运行日志文件", self._onClickUploadLastLog, self)
	self.addButton(self, "L-1", "输出加载资源", self._onClickResourceCollector, self)
	self:addTitleSplitLine("服务端GM多行输入")

	self._gmInput = self:addInputText("L0", "", "GM ...", nil, nil, {
		w = 1000,
		h = 500
	})
	self._gmInput.inputField.lineType = MultiLineNewline

	self._gmInput:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewMultiServerGM, ""))
	self.addButton(self, "L0", "发送", self._onClickOk, self)
	self:addTitleSplitLine("检查")
	self.addButton(self, "L1", "资源完整性验证", self._onClickCheckMD5, self)
	self.addButton(self, "L1", "配置描述Tag检测", self._onClickCheckSkillTag, self)
	self.addButton(self, "L1", "扫描无用配置", self._onClickCheckUnuseConfig, self)

	self._langDrop = self.addDropDown(self, "L1", "UI多语言", nil, self._onLangDropChange, self)

	self.addButton(self, "L1.2", "多语言文本查找", self._onClickLangTxtSearch, self)
	self:addTitleSplitLine("BGM")
	self.addButton(self, "L2", "显示BGM播放进度", self._onClickBGMProgress, self)
	self.addButton(self, "L2", "视频资源列表", self._onClickVideoList, self)
	self:addTitleSplitLine("剧情")

	self._inpClearStoryValue = self:addInputText("L3", "", "剧情id", nil, nil, {
		w = 1000
	})

	self.addButton(self, "L3", "重置剧情", self._onClickClearStory, self)

	self._inpFinishStoryValue = self:addInputText("L4", "", "剧情id", nil, nil, {
		w = 1000
	})

	self.addButton(self, "L4", "完成剧情", self._onClickFinishStory, self)
	self.addButton(self, "L5", "监听按键", self._onClickListenKeyboard, self)
	self:addTitleSplitLine("内置浏览器")

	self._inpUrl = self:addInputText("L6", "", "url", nil, nil, {
		w = 1000
	})

	self.addButton(self, "L6", "打开链接", self._onClickOpenWebView, self)

	self.recordUserToggle = self:addToggle("L6", "携带用\n户信息", nil, nil, {
		fsize = 20
	})

	self:addTitleSplitLine("按键")

	self._switchKeyToggle = self.addToggle(self, "L7", "切换按键功能", self._switchKeyInput, self, {
		fsize = 40
	})
	self._switchKeyToggle.isOn = UnityEngine.PlayerPrefs.GetInt("PCInputSwitch", 0) == 1
	self.langList = {}
	self.langShortCutList = {}
	self.curUILang = LangSettings.instance:getCurLang()

	local selectIndex = 0
	local index = 0

	for lang, shortcut in pairs(LangSettings.shortcutTab) do
		table.insert(self.langList, lang)
		table.insert(self.langShortCutList, shortcut)

		if lang == self.curUILang then
			selectIndex = index
		end

		index = index + 1
	end

	self._langDrop:ClearOptions()
	self._langDrop:AddOptions(self.langShortCutList)
	self._langDrop:SetValue(selectIndex)
end

function GMSubViewCommon:_onClickUploadCurLog()
	SendWeWorkFileHelper.SendCurLogFile()
end

function GMSubViewCommon:_onClickUploadLastLog()
	SendWeWorkFileHelper.SendLastLogFile()
end

function GMSubViewCommon:_onClickOpenWebView()
	local url = self._inpUrl:GetText()

	if string.nilorempty(url) then
		return
	end

	WebViewController.instance:openWebView(url, self.recordUserToggle.isOn)
end

function GMSubViewCommon:removeEvents()
	GMSubViewCommon.super.removeEvents(self)
	TaskDispatcher.cancelTask(self._tickListenKeyboard, self)
end

function GMSubViewCommon:_onClickOk()
	local text = self._gmInput:GetText()

	if string.nilorempty(text) then
		return
	end

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewMultiServerGM, text)

	local lineList = string.split(text, "\n")

	for _, line in ipairs(lineList) do
		line = string.trim(line)

		if not string.nilorempty(line) then
			GMRpc.instance:sendGMRequest(line)
		end
	end
end

function GMSubViewCommon:_onClickCheckMD5()
	MessageBoxController.instance:showMsgBoxByStr("正在验证资源完整性", MsgBoxEnum.BoxType.Yes)

	self.eventDispatcher = SLFramework.GameLuaEventDispatcher.Instance

	self.eventDispatcher:AddListener(self.eventDispatcher.ResChecker_Finish, self._onResCheckFinish, self)
	SLFramework.ResChecker.Instance:CheckAllRes()
end

function GMSubViewCommon:_onResCheckFinish(pass)
	local dlcTypeList = ResCheckMgr.instance:getAllLocalResBigType()
	local allSize = SLFramework.ResChecker.Instance:GetUnmatchResSize(dlcTypeList)

	allSize = tonumber(tostring(allSize))

	local msg = allSize == 0 and "验证通过" or "资源完整性验证失败！！请查看日志"

	self.eventDispatcher:RemoveListener(self.eventDispatcher.ResChecker_Finish)

	self.eventDispatcher = nil

	MessageBoxController.instance:showSystemMsgBoxByStr(msg, MsgBoxEnum.BoxType.Yes)
end

function GMSubViewCommon:_onClickBGMProgress()
	local value = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewBGMProgress, 0)

	if value == 0 then
		GameFacade.showToast(ToastEnum.IconId, "show bgm progress")
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewBGMProgress, 1)
	else
		GameFacade.showToast(ToastEnum.IconId, "hide bgm progress")
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewBGMProgress, 0)
	end
end

function GMSubViewCommon:_onClickVideoList()
	ViewMgr.instance:openView(ViewName.GMVideoList)
end

function GMSubViewCommon:_onClickClearRougeStories()
	for i, v in ipairs(lua_rouge_story_list.configList) do
		local storyList = string.splitToNumber(v.storyIdList, "#")

		for _, id in ipairs(storyList) do
			GMRpc.instance:sendGMRequest(string.format("delete story %s", id))
		end
	end

	StoryRpc.instance:sendGetStoryRequest()
end

function GMSubViewCommon:_onClickFinishRougeStories()
	for i, v in ipairs(lua_rouge_story_list.configList) do
		local storyList = string.splitToNumber(v.storyIdList, "#")

		for _, id in ipairs(storyList) do
			StoryRpc.instance:sendUpdateStoryRequest(id, -1, 0)
		end
	end

	StoryRpc.instance:sendGetStoryRequest()
end

function GMSubViewCommon:_onClickClearStory()
	local storyList = string.splitToNumber(self._inpClearStoryValue:GetText(), "#")

	for _, id in ipairs(storyList) do
		GMRpc.instance:sendGMRequest(string.format("delete story %s", id))
	end

	StoryRpc.instance:sendGetStoryRequest()
end

function GMSubViewCommon:_onClickFinishStory()
	local storyList = string.splitToNumber(self._inpFinishStoryValue:GetText(), "#")

	for _, id in ipairs(storyList) do
		StoryRpc.instance:sendUpdateStoryRequest(id, -1, 0)
	end

	StoryRpc.instance:sendGetStoryRequest()
end

function GMSubViewCommon:_onClickListenKeyboard()
	if not self._keyCodes then
		self._keyCodeStrs = {}
		self._keyCodes = {}

		local KeyCodeEnum = UnityEngine.KeyCode

		for keyCodeInt = 8, 329 do
			local keyCode = KeyCodeEnum.IntToEnum(keyCodeInt)

			if keyCode then
				local keyCodeStr = keyCode:ToString()

				table.insert(self._keyCodes, keyCode)
				table.insert(self._keyCodeStrs, keyCodeStr)
			end
		end
	end

	TaskDispatcher.cancelTask(self._tickListenKeyboard, self)
	TaskDispatcher.runRepeat(self._tickListenKeyboard, self, 0.01)
	GameFacade.showToast(ToastEnum.IconId, "请按下键盘，按键码将复制到粘贴板")
end

local Input = UnityEngine.Input

function GMSubViewCommon:_tickListenKeyboard()
	if Input.anyKey then
		for i, keyCode in ipairs(self._keyCodes) do
			if Input.GetKey(keyCode) then
				local pressKeyStr = self._keyCodeStrs[i]

				logError(pressKeyStr)
				GameFacade.showToast(ToastEnum.IconId, pressKeyStr)
				ZProj.GameHelper.SetSystemBuffer(pressKeyStr)

				break
			end
		end
	end
end

function GMSubViewCommon:_onClickCheckSkillTag()
	local allNames = {}

	for _, co in ipairs(lua_skill_eff_desc.configList) do
		if allNames[co.name] and co.name ~= "？？？" then
			logError(string.format("技能Tag 重复 [%s] %d -> %d", co.name, co.id, allNames[co.name]))
		end

		allNames[co.name] = co.id
	end

	FightConfig.instance:setGetDescFlag(true)
	self:_checkDescHaveTag(allNames, "skill_effect", "desc")
	self:_checkDescHaveTag(allNames, "skill_buff", "desc", self._isCheckBuff)
	self:_checkDescHaveTag(allNames, "skill_eff_desc", "desc")
	self:_checkDescHaveTag(allNames, "equip_skill", "baseDesc")
	self:_checkDescHaveTag(allNames, "rule", "desc")
	self:_checkDescHaveTag(allNames, "rouge_desc", "desc")
	FightConfig.instance:setGetDescFlag(false)
end

function GMSubViewCommon:_onClickCheckUnuseConfig()
	local allConfig = {}

	for i, setting in ipairs(ModuleMgr.instance._moduleSettingList) do
		local configs = setting.config

		if configs then
			for _, name in ipairs(configs) do
				local config = _G[name]

				if config then
					local reqConfigNames = config.instance:reqConfigNames()

					if reqConfigNames then
						for __, value in ipairs(reqConfigNames) do
							allConfig[value] = true
						end
					end
				end
			end
		end
	end

	local jsonPath = SLFramework.FrameworkSettings.AssetRootDir .. "/configs/excel2json/"
	local allJson = SLFramework.FileHelper.GetDirFilePaths(jsonPath)
	local str = ""
	local count = allJson.Length

	for i = 0, count - 1 do
		local path = allJson[i]

		if not string.find(path, ".meta") then
			local fileName = SLFramework.FileHelper.GetFileName(path, false)
			local configName = string.gsub(fileName, "json_", "")

			if not allConfig[configName] then
				str = str .. fileName .. "\n"
			end
		end
	end

	logError(str)
end

function GMSubViewCommon:_isCheckBuff(buffCo)
	if buffCo and buffCo.isNoShow == 1 then
		return false
	end

	return true
end

function GMSubViewCommon:_checkDescHaveTag(allNames, configName, fieldName, checkFunc)
	local cls = _G["lua_" .. configName]

	if not cls then
		logError(configName .. "配置不存在 !!!!!!!!!!!!!")

		return
	end

	for _, co in ipairs(cls.configList) do
		local str = co[fieldName]

		if checkFunc and not checkFunc(self, co) or str:find("不外显") then
			-- block empty
		elseif type(str) == "string" then
			string.gsub(str, "%[(.-)%]", function(val)
				if not allNames[val] then
					logError(string.format("%s.%s id:%s tag不存在 ->  %s\n%s", configName, fieldName, co[1], val, str))
				end

				return val
			end)
			string.gsub(str, "【(.-)】", function(val)
				if not allNames[val] then
					logError(string.format("%s.%s id:%s tag不存在 ->  %s\n%s", configName, fieldName, co[1], val, str))
				end

				return val
			end)
		else
			logError(configName .. "." .. fieldName .. "配置字段不存在 !!!!!!!!!!!!!")

			break
		end
	end
end

function GMSubViewCommon:_onClickLangTxtSearch(index)
	ViewMgr.instance:openView(ViewName.GMLangTxtView)
end

function GMSubViewCommon:_onLangDropChange(index)
	local lang = self.langList[index + 1]

	if lang == self.curUILang then
		return
	end

	local old = GameConfig:GetCurLangType()

	LangSettings.instance:SetCurLangType(self.langShortCutList[index + 1], self._onChangeLangTxtType2, self)
end

function GMSubViewCommon:_onChangeLangTxtType2()
	local curLang = GameConfig:GetCurLangShortcut()
	local lanIndex = GameLanguageMgr.instance:getStoryIndexByShortCut(curLang)

	GameLanguageMgr.instance:setLanguageTypeByStoryIndex(lanIndex)
	PlayerPrefsHelper.setNumber("StoryTxtLanType", lanIndex - 1)
	SettingsController.instance:changeLangTxt()
end

function GMSubViewCommon:_switchKeyInput(parem, isOn)
	UnityEngine.PlayerPrefs.SetInt("PCInputSwitch", isOn and 1 or 0)
	UnityEngine.PlayerPrefs.Save()
	PCInputController.instance:Switch()
end

function GMSubViewCommon:_onClickResourceCollector()
	SLFramework.ResourceCollector.ExportCollectInfo("")
end

return GMSubViewCommon
