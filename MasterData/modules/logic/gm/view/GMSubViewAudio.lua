-- chunkname: @modules/logic/gm/view/GMSubViewAudio.lua

module("modules.logic.gm.view.GMSubViewAudio", package.seeall)

local GMSubViewAudio = class("GMSubViewAudio", GMSubViewBase)

function GMSubViewAudio:ctor()
	self.tabName = "音效"
end

function GMSubViewAudio:addLineIndex()
	self.lineIndex = self.lineIndex + 1
end

function GMSubViewAudio:getLineGroup()
	return "L" .. self.lineIndex
end

function GMSubViewAudio:initViewContent()
	if self._inited then
		return
	end

	self.lineIndex = 1

	GMSubViewBase.initViewContent(self)
	self:addTitleSplitLine("音频播放")
	self:addLabel(self:getLineGroup(), "音效")

	self._inpAudio = self:addInputText("L1", "", "音效配置Id")

	self.addButton(self, self:getLineGroup(), "播放", self._onClickAudioPlay, self)
	self.addButton(self, self:getLineGroup(), "停止", self._onClickAudioStop, self)

	self._autoStopToggle = self.addToggle(self, self:getLineGroup(), "播放音效自动关闭上次音效", self._onAutoStopChange, self, {
		fsize = 24
	})
	self._showLogToggle = self.addToggle(self, self:getLineGroup(), "打开日志", self._onShowLogChange, self)

	self:addLineIndex()

	self._inpEvent = self:addInputText(self:getLineGroup(), "", "事件名称")
	self._inpBank = self:addInputText(self:getLineGroup(), "", "bank名称")

	self.addButton(self, self:getLineGroup(), "播放", self._onClickEventPlay, self)
	self.addButton(self, self:getLineGroup(), "停止", self._onClickEventStop, self)

	self._langDrop = self.addDropDown(self, self:getLineGroup(), "语言", nil, self._onLangDropChange, self)

	self:addLineIndex()

	self._inpRtpcName = self:addInputText(self:getLineGroup(), "", "RTPC名称", nil, nil, {
		w = 230
	})
	self._inpRtpcValue = self:addInputText(self:getLineGroup(), "", "RTPC值", nil, nil, {
		w = 200
	})

	self.addButton(self, self:getLineGroup(), "设置", self._onClickSetRtpc, self)

	self._inpSwitchName = self:addInputText(self:getLineGroup(), "", "Switch Group")
	self._inpSwitchValue = self:addInputText(self:getLineGroup(), "", "Switch Value")

	self.addButton(self, self:getLineGroup(), "设置", self._onClickSwitch, self)
	self:addTitleSplitLine("音频资源检查")
	self:addLineIndex()

	self._textCheckAudio2 = self.addButton(self, self:getLineGroup(), "检查音效调用", self._onClickCheckAudioCall, self)[2]

	self:addLabel(self:getLineGroup(), "调用音频数量/GC:", {
		fsize = 30
	})

	self._textCallAudioGCThreshold = self:addInputText(self:getLineGroup(), "10000")

	self.addButton(self, self:getLineGroup(), "检查音效调用(仅章节,活动部分)", self._onClickCheckAudioChapterAndActiviy, self, {
		fsize = 32
	})
	self:addLineIndex()
	self:addLabel(self:getLineGroup(), "章节ID:\n[逗号分隔]", {
		w = 100,
		h = 200,
		fsize = 36
	})

	local defaultStr = PlayerPrefsHelper.getString("checkAudioChatperIdsKey", "")

	self._chatperIdsToCheckAudio = self.addInputText(self, self:getLineGroup(), defaultStr, "", self._onChatperIdsChange, self, {
		w = 500,
		h = 200,
		align = UnityEngine.TextAnchor.UpperLeft
	})

	self:addLabel(self:getLineGroup(), "角色活动:", {
		fsize = 30,
		align = TMPro.TextAlignmentOptions.TopLeft
	})

	defaultStr = PlayerPrefsHelper.getString("checkAudioCharActCfgsKey", "")
	self._charActCfgsToCheckAudio = self.addInputText(self, self:getLineGroup(), defaultStr, "", self._onCharActCfgsChange, self, {
		w = 500,
		h = 200,
		align = UnityEngine.TextAnchor.UpperLeft
	})

	self:addLineIndex()
	self:addLabel(self:getLineGroup(), "音频Id调用:\n[表,字段1,字段2|表，字段]", {
		fsize = 30,
		align = TMPro.TextAlignmentOptions.TopLeft
	})

	defaultStr = PlayerPrefsHelper.getString("checkAudioIdInConfigKey", "")
	self._charAudioIdInConfig = self.addInputText(self, self:getLineGroup(), defaultStr, "", self._CallAudioInConfig, self, {
		w = 600,
		h = 200,
		align = UnityEngine.TextAnchor.UpperLeft
	})
	self._textCheckAudioIdInConfig = self.addButton(self, self:getLineGroup(), "调用配置音效", self._callAudioInConfig, self)[2]

	self:addLineIndex()
	self.addButton(self, self:getLineGroup(), "检查音效配置项", self._onClickCheckAudio1, self)
	self:addLineIndex()
	self.addButton(self, self:getLineGroup(), "检查冗余音效", self._onClickCheckAudioResource, self)
	self:addLabel(self:getLineGroup(), "（检查不在音效表和代码中的音效）", {
		fsize = 30
	})
	self:addLineIndex()
	self.addButton(self, self:getLineGroup(), "检查Bnk文件冗余", self._checkAudioResInSoundbanksInfoXml, self)
	self.addButton(self, self:getLineGroup(), "检查Bnk多语言缺失", self._checkBnkLangInSoundbanksInfoXml, self)
	self:addLabel(self:getLineGroup(), "(扫描本地文件和Soundbanksinfo中音频文件资源)", {
		fsize = 26
	})
	self:addLineIndex()
	self.addButton(self, self:getLineGroup(), "释放音效Bnk", self._onReleaseAudioResource, self)

	self.autoStopPrePlayingId = true
	self.prePlayingId = 0
	self.curLang = GameConfig:GetCurVoiceShortcut()
	self._autoStopToggle.isOn = self.autoStopPrePlayingId
	self._showLogToggle.isOn = GMController.instance:getShowAudioLog()
	self.langList = {}

	local cSharpArr = GameConfig:GetSupportedVoiceShortcuts()
	local length = cSharpArr.Length
	local selectIndex = 0

	for i = 0, length - 1 do
		local lang = cSharpArr[i]

		table.insert(self.langList, lang)

		if lang == self.curLang then
			selectIndex = i
		end
	end

	self._langDrop:ClearOptions()
	self._langDrop:AddOptions(self.langList)
	self._langDrop:SetValue(selectIndex)

	self._inited = true
end

function GMSubViewAudio:_onClickAudioPlay()
	local input = self._inpAudio:GetText()

	if not string.nilorempty(input) then
		local audioId = tonumber(input)

		if audioId then
			if self.autoStopPrePlayingId then
				self:stopPlayingID()
			end

			self.prePlayingId = AudioMgr.instance:trigger(audioId)
		end
	end
end

function GMSubViewAudio:_getVoiceEmitter()
	self._emitter = self._emitter or ZProj.AudioEmitter.Get(self.viewGO)

	return self._emitter
end

function GMSubViewAudio:_onClickAudioStop()
	self:stopPlayingID()
end

function GMSubViewAudio:stopPlayingID()
	AudioMgr.instance:stopPlayingID(self.prePlayingId)
end

function GMSubViewAudio:_onAutoStopChange(param, isOn)
	self.autoStopPrePlayingId = isOn
end

function GMSubViewAudio:_onShowLogChange(param, isOn)
	if GMController.instance:getShowAudioLog() == isOn then
		return
	end

	AudioMgr.GMOpenLog = isOn
	ZProj.AudioManager.Instance.gmOpenLog = isOn

	GMController.instance:setShowAudioLog(isOn)
end

function GMSubViewAudio:_onClickEventPlay()
	local eventName = self._inpEvent:GetText()
	local bankName = self._inpBank:GetText()

	if string.nilorempty(eventName) then
		return
	end

	if string.nilorempty(bankName) then
		return
	end

	self:initAudioEditorTool()

	if self.autoStopPrePlayingId then
		self:stopPlayingID()
	end

	self.prePlayingId = self.audioTool:PlayEvent(eventName, bankName)
end

function GMSubViewAudio:_onClickEventStop()
	self:stopPlayingID()
end

function GMSubViewAudio:initAudioEditorTool()
	self.audioTool = self.audioTool or ZProj.AudioEditorTool.Instance
end

function GMSubViewAudio:_onLangDropChange(index)
	local lang = self.langList[index + 1]

	if lang == self.curLang then
		return
	end

	self.curLang = lang

	self:stopPlayingID()
	self:initAudioEditorTool()
	self.audioTool:SetLanguage(self.curLang)
end

function GMSubViewAudio:_onClickSetRtpc()
	local rtpcName = self._inpRtpcName:GetText()
	local rtpcValue = self._inpRtpcValue:GetText()

	if string.nilorempty(rtpcName) then
		return
	end

	if string.nilorempty(rtpcValue) then
		return
	end

	rtpcValue = tonumber(rtpcValue)

	if not rtpcValue then
		return
	end

	self:initAudioEditorTool()
	self.audioTool:SetRtpc(rtpcName, rtpcValue)
end

function GMSubViewAudio:_onClickSwitch()
	local switchName = self._inpSwitchName:GetText()
	local switchValue = self._inpSwitchValue:GetText()

	if string.nilorempty(switchName) then
		return
	end

	if string.nilorempty(switchValue) then
		return
	end

	self:initAudioEditorTool()
	self.audioTool:SetSwitch(switchName, switchValue)
end

function GMSubViewAudio:_onChatperIdsChange(value)
	PlayerPrefsHelper.setString("checkAudioChatperIdsKey", value)
end

function GMSubViewAudio:_onCharActCfgsChange(value)
	PlayerPrefsHelper.setString("checkAudioCharActCfgsKey", value)
end

function GMSubViewAudio:_onCharAudioIdInConfigKeyChange(value)
	PlayerPrefsHelper.setString("checkAudioIdInConfigKey", value)
end

function GMSubViewAudio:_onClickCheckAudio1()
	logNormal("检查音效配置项--------------------------------")

	self._audioConfigs = {}

	self:_checkAudioConfigs(lua_role_audio, "Y音效表.xlsx export_角色语音")
	self:_checkAudioConfigs(lua_ui_audio, "Y音效表-UI音效表.xlsx export_UI音效")
	self:_checkAudioConfigs(lua_bg_audio, "Y音效表-战斗&场景音效表.xlsx export_背景音乐")
	self:_checkAudioConfigs(lua_fight_audio, "Y音效表-战斗&场景音效表.xlsx export_战斗音效")
	self:_checkAudioConfigs(lua_story_audio, "Y音效表.xlsx export_剧情音效")
	self:_checkAudioConfigs(lua_story_audio_main, "Y剧情配音2.0.xlsx export_主线剧情配音")
	self:_checkAudioConfigs(lua_story_audio_branch, "Y剧情配音2.0.xlsx export_支线剧情配音")
	self:_checkAudioConfigs(lua_story_audio_system, "Y剧情配音2.0.xlsx export_系统剧情配音")
	self:_checkAudioConfigs(lua_story_audio_role, "Y剧情配音2.0.xlsx export_角色语音")
	self:_checkAudioConfigs(lua_story_audio_effect, "Y剧情配音2.0.xlsx export_剧情音效")
	self:_checkAudioConfigs(lua_story_audio_short, "Y剧情配音2.0.xlsx export_短语音")
	self:_checkAudioConfigs(lua_story_role_audio, "Y音效表.xlsx export_剧情配音")
	self:_checkAudioConfigs(lua_effect_audio, "Y音效表-战斗&场景音效表.xlsx export_特效音效")
	self:_checkLowerName(self._audioConfigs)
	logNormal("count = " .. #self._audioConfigs)
	ZProj.AudioManager.Instance:SetErrorCallback(self._onErrorCallback, self)
	TaskDispatcher.runRepeat(self._checkPlayConfigAudio, self, 0.1)
end

function GMSubViewAudio:_checkAudioConfigs(config, sourceExcel)
	for _, co in ipairs(config.configList) do
		if co.id and co.id > 0 and not tabletool.indexOf(self._audioConfigs, co.id) then
			table.insert(self._audioConfigs, co.id)

			self._audioId2Excel = self._audioId2Excel or {}
			self._audioId2Excel[co.id] = sourceExcel
		end
	end
end

function GMSubViewAudio:_checkLowerName(list)
	local result = {}
	local bankErrorDict = {}

	for _, audioId in ipairs(list) do
		local audioCO = AudioConfig.instance:getAudioCOById(audioId)

		if string.lower(audioCO.bankName) ~= audioCO.bankName and not bankErrorDict[audioCO.bankName] then
			bankErrorDict[audioCO.bankName] = true

			table.insert(result, "bank: " .. audioCO.bankName)
		end

		if string.lower(audioCO.eventName) ~= audioCO.eventName then
			table.insert(result, "event: " .. audioCO.eventName)
		end
	end

	if #result > 0 then
		logError("大小写问题：\n" .. table.concat(result, "\n"))
	end
end

function GMSubViewAudio:_checkPlayConfigAudio()
	if self._audioConfigs and #self._audioConfigs > 0 then
		local hasShowToastInFrame = false

		for i = 1, 1000 do
			local audioId = table.remove(self._audioConfigs, #self._audioConfigs)

			if audioId then
				if #self._audioConfigs % 100 == 0 and not hasShowToastInFrame then
					GameFacade.showToast(ToastEnum.IconId, "剩余" .. #self._audioConfigs)

					hasShowToastInFrame = true
				end

				local success = self:_triggerAudio(audioId)

				if not success then
					self._errorAudioId = audioId

					return
				end
			else
				GameFacade.showToast(ToastEnum.IconId, "检查完毕")
				self:_logAudioError()
				ZProj.AudioManager.Instance:SetErrorCallback(nil, nil)
				TaskDispatcher.cancelTask(self._checkPlayConfigAudio, self)

				break
			end
		end
	end
end

function GMSubViewAudio:_triggerAudio(audioId)
	if audioId > 0 and self:_getAudioConfig(audioId) then
		local playingId = AudioMgr.instance:trigger(audioId)

		if playingId > 0 then
			AudioMgr.instance:stopPlayingID(playingId)

			return true
		end
	end
end

function GMSubViewAudio:_getAudioConfig(audioId)
	return AudioConfig.instance:getAudioCOById(audioId)
end

function GMSubViewAudio:_onClickCheckAudioCall()
	self:_CheckAudioCall()
end

function GMSubViewAudio:_CheckAudioCall()
	self._checkAudioTextStr = self._textCheckAudio2.text

	logNormal("检查音效调用--------------------------------")

	self._callAudioIdList = {}

	self:_checkAddConfigCallAudios(lua_character_voice, "audio", "J角色语音表.xlsx export_角色语音")
	self:_checkAddConfigCallAudios(lua_effect_with_audio, "audioId", "T特效音效表.xlsx export_特效音效")
	self:_checkAddConfigCallAudios(lua_fight_voice, {
		"audio_type1",
		"audio_type2",
		"audio_type3",
		"audio_type4",
		"audio_type5",
		"audio_type6",
		"audio_type7",
		"audio_type8",
		"audio_type9",
		"audio_type10"
	}, "J角色语音表.xlsx export_角色战斗语音")
	self:_checkAddConfigCallAudios(lua_guide_step, "audio", "Z指引表.xlsx export_指引步骤")
	self:_checkAddConfigCallAudios(lua_skill_behavior, "audioId", "J技能表.xlsx export_技能效果")
	self:_checkAddConfigCallAudios(lua_skill_buff, {
		"audio",
		"triggerAudio",
		"delAudio"
	}, "J技能表.xlsx export_buff")
	self:_checkAddConfigCallAudios(lua_buff_act, "audioId", "J技能表.xlsx export_基础buff效果")
	self:_checkAddConfigCallAudios(lua_skin_spine_action, "audioId", "P皮肤表.xlsx export_战斗动作表现")
	self:_checkAddConfigCallAudios(lua_chapter_map_element_dialog, "audio", "F副本表.xlsx export_元件对话")
	self:_checkAddConfigCallAudios(lua_battle_dialog, "audioId", "Z战斗喊话表.xlsx export_战斗喊话")
	self:_checkAddConfigCallAudios(lua_fight_debut_show, "audioId", "Z战斗补丁-出场表现表.xlsx export_出场表现")
	self:_checkAddConfigCallAudios(lua_fight_summon_show, "audioId", "Z战斗补丁-召唤表现表.xlsx export_召唤表现")
	self:_checkAddConfigCallAudios(lua_guide_step_addition, "audio", "Z指引表.xlsx export_附加步骤")
	self:_checkAddConfigCallAudios(lua_production_part, "audio", "X小屋.xlsx export_枢纽部件")
	self:_checkAddConfigCallAudios(lua_room_audio_extend, "audioId", "X小屋地块包表.xlsx export_音效拓展")
	self:_checkAddConfigCallAudios(lua_character_shop_voice, "audio", "J角色语音表.xlsx export_商店语音表")
	self:_checkAddConfigCallAudios(lua_explore_dialogue, "audio", "M密室探索表.xlsx export_对话")
	self:_checkAddConfigCallAudios(lua_explore_hero_effect, "audioId", "M密室探索表.xlsx export_角色特效")
	self:_checkAddConfigCallAudios(lua_explore_item, "audioId", "M密室探索表.xlsx export_物品")
	self:_checkAddConfigCallAudios(lua_explore_unit_effect, "audioId", "M密室探索表.xlsx export_元件特效")
	self:_checkAddConfigCallAudios(lua_toast, "audioId", "P飘字表.xlsx export_飘字表")
	self:_checkAddConfigCallAudios(lua_character_limited, {
		"audio",
		"stopAudio"
	}, "J角色限定表现.xlsx export_限定角色表现")
	self:_checkAddConfigCallAudios(lua_chapter_map, "effectAudio", "F副本表.xlsx export_主线地图")
	self:_checkAddConfigCallAudios(lua_bgm_switch, "audio", "B背景音效切换.xlsx export_背景音效切换")
	self:_checkAddConfigCallAudios(lua_fairyland_puzzle_talk, "audioId", "H幻境.xlsx export_幻境对话")
	self:_checkAddConfigCallAudios(lua_fight_buff_layer_effect, {
		"loopEffectAudio",
		"createAudio",
		"destroyEffectAudio"
	}, "Z战斗配置-buff层数特效.xlsx export_buff层数特效")
	self:_checkAddConfigCallAudios(lua_fight_effect_buff_skin, "audio", "Z战斗补丁-被动特效对应皮肤表.xlsx export_释放技能后延迟")
	self:_checkAddConfigCallAudios(lua_magic_circle, {
		"enterAudio",
		"closeAudio"
	}, "S术阵表.xlsx export_法阵")
	self:_checkAddConfigCallAudios(lua_room_building, "placeAudio", "X小屋地块包表.xlsx export_建筑")
	self:_checkAddConfigCallAudios(lua_room_character_interaction, "buildingAudio", "X小屋角色表.xlsx export_角色交互")
	self:_checkAddConfigCallAudios(lua_room_effect, "audioId", "X小屋.xlsx export_特效配置")
	self:_checkAddConfigCallAudios(lua_room_vehicle, {
		"audioTurn",
		"audioTurnAround",
		"audioCrossload",
		"audioWalk",
		"audioStop"
	}, "X小屋地块包表.xlsx export_交通工具")
	self:_checkAddConfigCallAudios(lua_rouge_short_voice, "audioId", "R肉鸽地图表.xlsx export_短语音表")
	self:_checkAddConfigCallAudios(lua_summoned, {
		"enterAudio",
		"closeAudio"
	}, "Z召唤物挂件表.xlsx export_召唤物挂件")
	self:_checkAddAudioEnumCall()
	self:_checkTimelineCall(function()
		self:_checkStoryCall()
	end)
end

function GMSubViewAudio:_checkStoryCall()
	if not SLFramework.FrameworkSettings.IsEditor then
		self._storyLoaded = true

		return
	end

	local storyStepPath = SLFramework.FrameworkSettings.AssetRootDir .. "/configs/story/steps/"
	local allFilePath = SLFramework.FileHelper.GetDirFilePaths(storyStepPath)
	local storyIdList = {}
	local count = allFilePath.Length

	for i = 0, count - 1 do
		local path = allFilePath[i]

		if string.sub(path, -5) == ".json" then
			local storyId = string.getLastNum(path)

			table.insert(storyIdList, storyId)
		end
	end

	self._loadStoryCount = #storyIdList
	self._storyAudioIdDict = {}

	for i, storyId in ipairs(storyIdList) do
		StoryController.instance:initStoryData(storyId, function()
			self:_loadStoryStepConfigCallback(storyId)
		end)
	end
end

function GMSubViewAudio:_checkAddAudioEnumCall()
	local audioEnum = {}

	for key, value in pairs(AudioEnum) do
		if type(value) == "table" then
			for _, v in pairs(value) do
				if type(v) == "number" and v > 500000 then
					self:_tableAddValues(audioEnum, value, "代码调用 AudioEnum." .. key)
				end

				break
			end
		end
	end

	for _, tb in pairs(audioEnum) do
		local audioId = tb[1]
		local source = tb[2]

		if not tabletool.indexOf(self._callAudioIdList, audioId) and tonumber(audioId) then
			table.insert(self._callAudioIdList, audioId)

			self._audioId2CallExcel = self._audioId2CallExcel or {}
			self._audioId2CallExcel[audioId] = source
		end
	end
end

function GMSubViewAudio:_checkAddConfigCallAudios(config, keys, callExcel)
	for _, co in ipairs(config.configList) do
		if type(keys) == "string" then
			local audioId = co[keys]

			if not tabletool.indexOf(self._callAudioIdList, audioId) then
				table.insert(self._callAudioIdList, audioId)

				self._audioId2CallExcel = self._audioId2CallExcel or {}
				self._audioId2CallExcel[audioId] = callExcel
			end
		elseif type(keys) == "table" then
			for _, key in ipairs(keys) do
				local audioId = co[key]

				if not tabletool.indexOf(self._callAudioIdList, audioId) then
					table.insert(self._callAudioIdList, audioId)

					self._audioId2CallExcel = self._audioId2CallExcel or {}
					self._audioId2CallExcel[audioId] = callExcel
				end
			end
		end
	end
end

function GMSubViewAudio:_checkTimelineCall(callback)
	self._timelineLoadedCb = callback
	self._timelienLoader = MultiAbLoader.New()

	local urlList = {}

	for _, skillCO in ipairs(lua_skill.configList) do
		if not string.nilorempty(skillCO.timeline) then
			local path = FightHelper.getRolesTimelinePath(skillCO.timeline)

			if not tabletool.indexOf(urlList, path) then
				local filePath = SLFramework.FrameworkSettings.AssetRootDir .. "/" .. path

				if SLFramework.FileHelper.IsFileExists(filePath) then
					table.insert(urlList, path)
				end
			end
		end
	end

	self._timelienLoader:setPathList(urlList)
	self._timelienLoader:startLoad(self._onLoadTimelineDone, self)
end

function GMSubViewAudio:_onLoadTimelineDone()
	local tlAudioIdDict = {}

	for url, tlAssetItem in pairs(self._timelienLoader:getAssetItemDict()) do
		local jsonArr = FightTLHelper.getTLJsonData(tlAssetItem, url)

		for i = 1, #jsonArr, 2 do
			local tlType = tonumber(jsonArr[i])
			local paramList = jsonArr[i + 1]

			if tlType == 3 then
				local audioId = tonumber(paramList[5])

				if audioId then
					tlAudioIdDict[audioId] = true
					self._audioId2CallExcel = self._audioId2CallExcel or {}

					local timelineName = SLFramework.FileHelper.GetFileName(url, false)

					self._audioId2CallExcel[audioId] = "Timeline " .. timelineName
				end
			elseif tlType == 10 then
				local audioId = tonumber(paramList[1])

				if audioId then
					tlAudioIdDict[audioId] = true
					self._audioId2CallExcel = self._audioId2CallExcel or {}

					local timelineName = SLFramework.FileHelper.GetFileName(url, false)

					self._audioId2CallExcel[audioId] = "Timeline " .. timelineName
				end
			end
		end
	end

	for audioId, _ in pairs(tlAudioIdDict) do
		table.insert(self._callAudioIdList, audioId)
	end

	if self._timelineLoadedCb then
		self._timelineLoadedCb()

		self._timelineLoadedCb = nil
	end
end

function GMSubViewAudio:_beginCallAudiosLoop()
	local dict = {}

	for _, id in ipairs(self._callAudioIdList) do
		dict[id] = true
	end

	self._callAudioIdList = {}

	for id, _ in pairs(dict) do
		table.insert(self._callAudioIdList, id)
	end

	self._totalAudioCount = #self._callAudioIdList

	logNormal("Total audio Id count = " .. self._totalAudioCount)
	ZProj.AudioManager.Instance:SetErrorCallback(self._onErrorCallback, self)

	self._callAudioLoopParams = {
		callAudioPerLoop = 2
	}
	self._callAudioIdx = 1
	self._releaseAudioThreshold = tonumber(self._textCallAudioGCThreshold:GetText()) or 10000
	self._releaseAudioCountNum = 0

	logNormal("Audio GC Per " .. self._releaseAudioThreshold .. " Audio Call")
	TaskDispatcher.runRepeat(self._callAudiosLoopAction, self, 0.01)
end

function GMSubViewAudio:_callAudiosLoopAction()
	if not self._callAudioIdList or #self._callAudioIdList == 0 then
		self:_endCallAudiosLoop()

		return
	end

	for i = 1, self._callAudioLoopParams.callAudioPerLoop do
		local audioId = self._callAudioIdList[self._callAudioIdx]

		self._callAudioIdx = self._callAudioIdx + 1

		if audioId then
			local success = self:_triggerAndStopAudio(audioId)

			self._errorAudioId = nil

			if not success then
				self._errorAudioId = audioId

				return
			end
		else
			self:_endCallAudiosLoop()

			return
		end
	end

	self._textCheckAudio2.text = self._callAudioIdx .. "/" .. self._totalAudioCount
	self._releaseAudioCountNum = self._releaseAudioCountNum + self._callAudioLoopParams.callAudioPerLoop

	if self._releaseAudioCountNum == self._releaseAudioThreshold then
		AudioMgr.instance:clearUnusedBanks()

		self._releaseAudioCountNum = 0

		logNormal("Call Audio Bnk GC, Cur Call Audio Count:" .. self._callAudioIdx)
	end
end

function GMSubViewAudio:_endCallAudiosLoop()
	logNormal("Check Audio Done")
	GameFacade.showToast(ToastEnum.IconId, "检查完毕")
	self:_logAudioError()
	ZProj.AudioManager.Instance:SetErrorCallback(nil, nil)
	TaskDispatcher.cancelTask(self._callAudiosLoopAction, self)
	AudioMgr.instance:clearUnusedBanks()

	self._textCheckAudio2.text = self._checkAudioTextStr
end

function GMSubViewAudio:_triggerAndStopAudio(audioId)
	if audioId > 0 and self:_getAudioConfig(audioId) then
		local playingId = AudioMgr.instance:trigger(audioId)

		if playingId > 0 then
			AudioMgr.instance:stopPlayingID(playingId)

			return true
		end
	end
end

local ErrorMap = {
	[54] = true,
	[52] = true,
	[46] = true
}

function GMSubViewAudio:_onErrorCallback(errorCode, playingId, msg)
	if self._errorAudioId then
		local audioId = self._errorAudioId

		self._errorList = self._errorList or {}

		table.insert(self._errorList, {
			audioId = audioId,
			errorCode = errorCode,
			msg = msg
		})

		local audioCO = AudioConfig.instance:getAudioCOById(audioId)

		if errorCode ~= 0 and not ErrorMap[errorCode] then
			logError("error_" .. errorCode .. " bank:" .. audioCO.bankName .. " evt:" .. audioCO.eventName .. "\n" .. msg)
		end
	end
end

function GMSubViewAudio:_logAudioError()
	if not self._errorList then
		return
	end

	local dict = {}

	for _, one in ipairs(self._errorList) do
		local audioCO = AudioConfig.instance:getAudioCOById(one.audioId)

		if ErrorMap[one.errorCode] then
			dict[one.errorCode] = dict[one.errorCode] or {
				one.msg
			}

			local log

			if self._audioId2Excel then
				if self._audioId2CallExcel then
					local callExcel = self._audioId2CallExcel[one.audioId]

					if self._audioId2Excel then
						if not audioCO then
							logError("没有找到音效配置：" .. one.audioId)
						else
							log = self._audioId2Excel .. " " .. one.audioId .. " " .. audioCO.bankName .. " " .. audioCO.eventName
						end
					elseif callExcel then
						if not audioCO then
							logError("没有找到音效配置：" .. one.audioId)
						else
							log = callExcel .. " " .. one.audioId .. " " .. audioCO.bankName .. " " .. audioCO.eventName
						end
					elseif not audioCO then
						logError("没有找到音效调用源：" .. one.audioId)
					else
						logError("没有设置源配置/调用源名称：" .. one.audioId)
					end

					table.insert(dict[one.errorCode], log)
				end
			end
		end
	end

	for errorCode, list in pairs(dict) do
		local logCount = math.ceil(#list / 100)

		for i = 1, logCount do
			local start = (i - 1) * 100 + 1
			local endi = math.min(i * 100, #list)

			logError("error_" .. errorCode .. " count = " .. #list - 1 .. "\n" .. table.concat(list, "\n", start, endi))
		end
	end

	self._audioId2Excel = nil
	self._audioId2CallExcel = nil
	self._errorList = nil
end

function GMSubViewAudio:_tableAddValues(to, from, source)
	for key, value in pairs(from) do
		to[key] = {
			value,
			source
		}
	end
end

function GMSubViewAudio:_onClickCheckAudioChapterAndActiviy()
	self._checkAudioTextStr = self._textCheckAudio2.text
	self._callAudioIdList = {}

	local storyIdList = {}
	local configListStr = self._charActCfgsToCheckAudio:GetText()
	local configList = string.split(configListStr, "|")

	if not string.nilorempty(configListStr) then
		for i, configParamPair in ipairs(configList) do
			local configParams = string.split(configParamPair, ",")
			local cfgName = configParams[1]
			local fieldName = configParams[2]
			local cfgList = ConfigMgr.instance._configDict[cfgName]

			if not cfgList then
				logError("配置名称错误 " .. cfgName)

				return
			end

			for _, co in ipairs(cfgList.configList) do
				if type(fieldName) == "string" then
					local storyId = co[fieldName]

					if type(storyId) == "string" then
						local storyIds = string.splitToNumber(storyId, "#")

						for _, id in ipairs(storyIds) do
							if id ~= 0 then
								storyIdList[#storyIdList + 1] = id
							end
						end
					elseif storyId ~= 0 then
						storyIdList[#storyIdList + 1] = storyId
					end
				elseif type(fieldName) == "table" then
					for _, key in ipairs(fieldName) do
						local storyId = co[key]

						if storyId ~= 0 then
							storyIdList[#storyIdList + 1] = storyId
						end
					end
				end
			end
		end
	end

	local chatperIdListStr = self._chatperIdsToCheckAudio:GetText()

	if not string.nilorempty(chatperIdListStr) then
		local chatperIdList = string.split(chatperIdListStr, ",")

		for i, chatperId in ipairs(chatperIdList) do
			local episodeCfgList = DungeonConfig.instance:getChapterEpisodeCOList(tonumber(chatperId))

			if episodeCfgList then
				for j, episodeCfg in ipairs(episodeCfgList) do
					if episodeCfg.beforeStory > 0 then
						storyIdList[#storyIdList + 1] = episodeCfg.beforeStory
					end

					if episodeCfg.afterStory > 0 then
						storyIdList[#storyIdList + 1] = episodeCfg.afterStory
					end

					if not string.nilorempty(episodeCfg.story) then
						local storiesParams = string.split(episodeCfg.story, "|")

						for k = 1, #storiesParams do
							local storyParams = storiesParams[i]

							storyParams = string.split(storyParams, "#")

							if storyParams[3] then
								local storyId = tonumber(storyParams[3])

								if storyId and storyId > 0 then
									storyIdList[#storyIdList + 1] = storyId
								end
							end
						end
					end
				end
			else
				logError("未找到章节数据 " .. chatperId)

				return
			end
		end
	end

	self._loadStoryCount = #storyIdList
	self._storyAudioIdDict = {}

	for i, storyId in ipairs(storyIdList) do
		StoryController.instance:initStoryData(storyId, function()
			self:_loadStoryStepConfigCallback(storyId)
		end)
	end
end

function GMSubViewAudio:_loadStoryStepConfigCallback(storyId)
	self._loadStoryCount = self._loadStoryCount - 1

	local storyStepList = StoryStepModel.instance:getStepList()

	for i, stepData in ipairs(storyStepList) do
		local audioList = stepData.audioList

		for j, audioData in ipairs(audioList) do
			if audioData.audio > 0 then
				self._storyAudioIdDict[audioData.audio] = storyId
			end
		end

		local conversationData = stepData.conversation
		local conversationAudioList = conversationData.audios

		for k, conversationAudioId in ipairs(conversationAudioList) do
			if conversationAudioId > 0 then
				self._storyAudioIdDict[conversationAudioId] = storyId
			end
		end
	end

	if self._loadStoryCount == 0 then
		self._audioId2CallExcel = self._audioId2CallExcel or {}

		for audioId, storyId in pairs(self._storyAudioIdDict) do
			self._audioId2CallExcel[audioId] = "剧情" .. storyId

			table.insert(self._callAudioIdList, audioId)
		end

		self:_beginCallAudiosLoop()
	end
end

function GMSubViewAudio:_callAudioInConfig()
	self._audioIdInConfigTextStr = self._charAudioIdInConfig:GetText()
	self._callAudioIdList = {}

	local configsParamStr = string.split(self._audioIdInConfigTextStr, "|")

	for _, configParamStr in ipairs(configsParamStr) do
		local configParam = string.split(configParamStr, ",")
		local cfgName = configParam[1]
		local cfgObj = _G["lua_" .. cfgName]

		if not cfgObj then
			logError("配置名称错误 " .. cfgName)

			return
		end

		table.remove(configParam, 1)

		local fields = configParam

		self:_checkAddConfigCallAudios(cfgObj, fields, cfgName)
	end

	self:_beginCallAudiosLoop()
end

function GMSubViewAudio:_onClickCheckAudioResource()
	logNormal("开始检查冗余音效资源--------------------------------")

	local configEvents = {}
	local audioCODict = AudioConfig.instance:getAudioCO()

	for _, item in pairs(audioCODict) do
		configEvents[item.eventName] = true
	end

	local resourceEvent2Path = {}

	self:_getAudioEventsInResourceDir("Assets/ZResourcesLib/audios/Android", resourceEvent2Path)
	self:_getAudioEventsInResourceDir("Assets/ZResourcesLib/audios/iOS", resourceEvent2Path)
	self:_getAudioEventsInResourceDir("Assets/ZResourcesLib/audios/Mac", resourceEvent2Path)
	self:_getAudioEventsInResourceDir("Assets/ZResourcesLib/audios/Windows", resourceEvent2Path)

	local unUseBnkEventTable = {}

	for eventName, path in pairs(resourceEvent2Path) do
		if not configEvents[eventName] then
			local bnkName = SLFramework.FileHelper.GetFileName(path, false)

			unUseBnkEventTable[bnkName] = unUseBnkEventTable[bnkName] or {}

			local eventList = unUseBnkEventTable[bnkName]

			eventList[#eventList + 1] = eventName
		end
	end

	local logStr = ""
	local unUseEventCount = 0

	for bnkName, eventList in pairs(unUseBnkEventTable) do
		if #eventList > 0 then
			logStr = logStr .. "----------- bnk：" .. bnkName .. " ------------" .. "\n"

			for _, eventName in ipairs(eventList) do
				logStr = logStr .. eventName .. "\n"
				unUseEventCount = unUseEventCount + 1
			end

			logStr = logStr .. "\n"
		end
	end

	if logStr ~= "" then
		local outputFileName = "AudioCheckResult.txt"
		local filePath = string.format("%s/../", UnityEngine.Application.dataPath) .. outputFileName

		SLFramework.FileHelper.WriteTextToPath(filePath, logStr)

		local logPath = string.gsub(UnityEngine.Application.dataPath, "Assets", "") .. outputFileName

		logNormal("共发现 " .. unUseEventCount .. " 个未配置音频 Event，" .. "结果已保存至 " .. logPath)
	else
		logNormal("未发现冗余音频资源")
	end
end

function GMSubViewAudio:_getAudioEventsInResourceDir(dirPath, event2PathTable)
	local allFilePaths = SLFramework.FileHelper.GetDirFilePaths(dirPath)

	for i = 0, allFilePaths.Length - 1 do
		local path = allFilePaths[i]

		if path:match("[.txt]$") then
			local cfgTxt = SLFramework.FileHelper.ReadText(path)

			for eventStr in cfgTxt:gmatch("[^\\]play_[%w_]+") do
				eventStr = eventStr:match("^[%s]*(.-)[%s]*$")
				event2PathTable[eventStr] = path
			end
		end
	end
end

function GMSubViewAudio:_fillAudioBnkWemFilePath(platformName, folderPath, bnkFileDict, wemFileDict)
	local allFilePaths = SLFramework.FileHelper.GetDirFilePaths(folderPath)

	for i = 0, allFilePaths.Length - 1 do
		local path = allFilePaths[i]

		if path:match("[.wem]$") then
			local folder, parentFolder = GMSubViewAudio._getFolderAndParent(path)
			local fileName = SLFramework.FileHelper.GetFileName(path, true)
			local wemId = SLFramework.FileHelper.GetFileName(path, false)

			if folder == platformName then
				wemFileDict[wemId] = fileName
			elseif parentFolder == platformName then
				wemFileDict[wemId] = folder .. "/" .. fileName
			end
		elseif path:match("[.bnk]$") then
			local folder, parentFolder = GMSubViewAudio._getFolderAndParent(path)
			local fileName = SLFramework.FileHelper.GetFileName(path, true)

			if folder == platformName then
				bnkFileDict[fileName] = true
			elseif parentFolder == platformName then
				bnkFileDict[folder .. "/" .. fileName] = true
			end
		end
	end
end

function GMSubViewAudio:_checkAudioResInSoundbanksInfoXml()
	logNormal("开始检查 SoundbanksInfo 冗余音效资源--------------------------------")

	local xmlPath = "Assets/ZResourcesLib/audios/Android/SoundbanksInfo.xml"
	local checkLangMap = {
		zh = true,
		en = true
	}
	local file = io.open(xmlPath, "r")
	local xml = file:read("*a")

	file:close()

	local xmlTree = ResSplitXmlTree:new()
	local parser = ResSplitXml2lua.parser(xmlTree)

	parser:parse(xml)

	local allBnkPathDict = {}
	local allWemDict = {}
	local allBnk2LangDict = {}

	for i, p in pairs(xmlTree.root.SoundBanksInfo.SoundBanks.SoundBank) do
		local language = p._attr.Language
		local bnkName = p.ShortName
		local bnkPath = p.Path:gsub("\\", "/")

		allBnkPathDict[bnkPath] = true

		if checkLangMap[language] then
			allBnk2LangDict[bnkName] = allBnk2LangDict[bnkName] or {}

			local langList = allBnk2LangDict[bnkName]

			langList[#langList + 1] = language
		end
	end

	for i, file in pairs(xmlTree.root.SoundBanksInfo.StreamedFiles.File) do
		local wemId = file._attr.Id

		allWemDict[wemId] = true
	end

	local bnkFilePaths = {}
	local wemFilePaths = {}

	self:_fillAudioBnkWemFilePath("Android", "Assets/ZResourcesLib/audios/Android", bnkFilePaths, wemFilePaths)

	for bnkPath, _ in pairs(allBnkPathDict) do
		if bnkFilePaths[bnkPath] then
			bnkFilePaths[bnkPath] = nil
		end
	end

	for wemId, _ in pairs(allWemDict) do
		if wemFilePaths[wemId] then
			wemFilePaths[wemId] = nil
		end
	end

	local NoExistInXmlBnks = {}
	local NoExistInXmlWems = {}

	for bnkPath, _ in pairs(bnkFilePaths) do
		NoExistInXmlBnks[#NoExistInXmlBnks + 1] = bnkPath
	end

	table.sort(NoExistInXmlBnks, function(a, b)
		return a:sub(1, 1) < b:sub(1, 1)
	end)

	for wemId, path in pairs(wemFilePaths) do
		NoExistInXmlWems[#NoExistInXmlWems + 1] = path
	end

	table.sort(NoExistInXmlWems, function(a, b)
		return a:sub(1, 1) < b:sub(1, 1)
	end)

	local count = #NoExistInXmlBnks + #wemFilePaths

	if count > 0 then
		local logStr = "SoundbanksInfo.xml 中不存在的 Bnk：\n"

		for _, bnkPath in ipairs(NoExistInXmlBnks) do
			logStr = logStr .. "\t" .. bnkPath .. "\n"
		end

		logStr = logStr .. "SoundbanksInfo.xml 中不存在的 Wem:\n"

		for _, wemPath in pairs(wemFilePaths) do
			logStr = logStr .. "\t" .. wemPath .. "\n"
		end

		local outputFileName = "bnkCheckResult.txt"
		local filePath = string.format("%s/../", UnityEngine.Application.dataPath) .. outputFileName

		SLFramework.FileHelper.WriteTextToPath(filePath, logStr)

		local logPath = string.gsub(UnityEngine.Application.dataPath, "Assets", "") .. outputFileName

		logNormal("扫描 SoundbanksInfo.xml 发现 " .. count .. " 个冗余资源，" .. "结果已保存至 " .. logPath)
	else
		logNormal("扫描 SoundbanksInfo.xml 未发现冗余音频资源")
	end
end

function GMSubViewAudio:_checkBnkLangInSoundbanksInfoXml()
	logNormal("开始检查 Bnk 文件多语言缺失--------------------------------")

	local xmlPath = "Assets/ZResourcesLib/audios/Android/SoundbanksInfo.xml"
	local checkLangMap = {
		zh = true,
		en = true
	}
	local file = io.open(xmlPath, "r")
	local xml = file:read("*a")

	file:close()

	local xmlTree = ResSplitXmlTree:new()
	local parser = ResSplitXml2lua.parser(xmlTree)

	parser:parse(xml)

	local allBnk2LangDict = {}

	for i, p in pairs(xmlTree.root.SoundBanksInfo.SoundBanks.SoundBank) do
		local language = p._attr.Language
		local bnkName = p.ShortName
		local bnkPath = p.Path:gsub("\\", "/")

		if checkLangMap[language] then
			allBnk2LangDict[bnkName] = allBnk2LangDict[bnkName] or {}

			local langList = allBnk2LangDict[bnkName]

			langList[#langList + 1] = language
		end
	end

	local langLostBnk = {}

	for bnkName, langList in pairs(allBnk2LangDict) do
		if langList and #langList ~= tabletool.len(checkLangMap) then
			langLostBnk[#langLostBnk + 1] = langLostBnk
		end
	end

	if #langLostBnk > 0 then
		local logStr = ""

		for _, bnkName in ipairs(langLostBnk) do
			local existLangs = allBnk2LangDict[bnkName]

			for lang, _ in pairs(checkLangMap) do
				if not tabletool.indexOf(existLangs, lang) then
					logStr = logStr .. bnkName .. "缺少" .. lang .. " 内容\n"
				end
			end
		end

		local outputFileName = "SoundbanksInfoCheckLangResult.txt"
		local filePath = string.format("%s/../", UnityEngine.Application.dataPath) .. outputFileName

		SLFramework.FileHelper.WriteTextToPath(filePath, logStr)

		local logPath = string.gsub(UnityEngine.Application.dataPath, "Assets", "") .. outputFileName

		logNormal("扫描 SoundbanksInfo.xml 发现 " .. #langLostBnk .. " 个多语言版本缺失的资源，" .. "结果已保存至 " .. logPath)
	else
		logNormal("扫描 SoundbanksInfo.xml 未发现多语言缺失资源")
	end
end

function GMSubViewAudio:_onReleaseAudioResource()
	AudioMgr.instance:clearUnusedBanks()
end

function GMSubViewAudio._getFolderAndParent(filePath)
	local folders = {}

	for folder in filePath:gmatch("[^/]+") do
		table.insert(folders, folder)
	end

	local folderCount = #folders

	if folderCount >= 2 then
		local currentFolder = folders[folderCount - 1]
		local parentFolder = folders[folderCount - 2]

		return currentFolder, parentFolder
	elseif folderCount == 1 then
		return folders[1], nil
	else
		return nil, nil
	end
end

return GMSubViewAudio
