-- chunkname: @modules/logic/gm/view/GMToolView2.lua

module("modules.logic.gm.view.GMToolView2", package.seeall)

local GMToolView2 = class("GMToolView2", BaseView)

function GMToolView2:onInitView()
	self._inpDumpHierarchy = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/item16/inpText")
	self._btnDumpHierarchy = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item16/btnDumpHierarchy")
	self._btnHierarchy = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item16/btnHierarchy")
	self._btnSkillPreview = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item9/btnSkillPreview")
	self._btnVersion = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item17/btnVersion")
	self._btnHardware = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item17/btnHardware")
	self._sliderRenderScale = gohelper.findChildSlider(self.viewGO, "viewport/content/item19/Slider")
	self._txtRenderScale = gohelper.findChildText(self.viewGO, "viewport/content/item19/Text")
	self._btnForbidFightEffect = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item26/Button1")
	self._btnCancelForbidFightEffect = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item26/Button2")
	self._btnTest1 = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item27/Button1")
	self._btnTest2 = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item27/Button2")
	self._textCheckAudio2 = gohelper.findChildText(self.viewGO, "viewport/content/item47/btnCheckAudio2/Text")
	self._textCallAudioGCThreshold = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/item47/InputField")
	self._inpTestAudio = gohelper.findChildInputField(self.viewGO, "viewport/content/testAudio1/inpTextAudio")
	self._inpBeginTestAudio = gohelper.findChildInputField(self.viewGO, "viewport/content/testAudio1/inpTextAudioBegin")
	self._inpEndTestAudio = gohelper.findChildInputField(self.viewGO, "viewport/content/testAudio1/inpTextAudioEnd")
	self._btnLoadTestAudio = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/testAudio2/btnLoadTestAudio")
	self._btnUnloadTestAudio = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/testAudio2/btnUnloadTestAudio")
	self._visualToggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item48/visualToggle")
	self._visualToggle.isOn = GMController.instance:getVisualInteractive()
	self._textSizeToggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item48/textSizeToggle")
	self._textSizeToggle.isOn = GMController.instance:getTextSizeActive()
	self._dropActivity = gohelper.findChildDropdown(self.viewGO, "viewport/content/versionactivity/activityDropdown")
	self._dropActivityStatus = gohelper.findChildDropdown(self.viewGO, "viewport/content/versionactivity/activityStatusDropdown")
	self._btnChangeActivity = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/versionactivity1/btnChangeActivity")
	self._btnResetActivity = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/versionactivity1/btnResetActivity")
	self._btnEnterActivity = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/versionactivity2/btnEnterActivity")
	self._btnResetActivityUnlockAnim = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/versionactivity2/btnResetUnlockAnim")
	self._btnEnterDialogue = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item51/Button")
	self._inputDialogue = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/item51/dialogueInput")
	self._startEditV1a5HoleBtn = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item52/startEditV1a5HoleBtn")
	self._endEditV1a5HoleBtn = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item52/endEditV1a5HoleBtn")

	local goOnekeyFightSucc = gohelper.cloneInPlace(self._btnHardware.gameObject, "btnOnekeyFightSucc")

	recthelper.setAnchorX(goOnekeyFightSucc.transform, 210)

	gohelper.findChildText(goOnekeyFightSucc, "Text").text = "战斗胜利"
	self._btnOnekeyFightSucc = gohelper.getClick(goOnekeyFightSucc)
end

function GMToolView2:addEvents()
	self._AddClickListener(self, self._btnDumpHierarchy, self._onClickBtnDumpHierarchy, self)
	self._AddClickListener(self, self._btnHierarchy, self._onClickBtnHierarchy, self)
	self._AddClickListener(self, self._btnSkillPreview, self._onClickBtnSkillPreview, self)
	self._AddClickListener(self, self._btnVersion, self._onClickBtnVersion, self)
	self._AddClickListener(self, self._btnHardware, self._onClickBtnHardware, self)
	self._AddOnValueChanged(self, self._sliderRenderScale, self._onRenderScaleChange, self)
	self._AddClickListener(self, self._btnForbidFightEffect, self._onClickForbidFightEffect, self)
	self._AddClickListener(self, self._btnCancelForbidFightEffect, self._onClickCancelForbidFightEffect, self)
	self._AddClickListener(self, self._btnTest1, self._onClickTest1, self)
	self._AddClickListener(self, self._btnTest2, self._onClickTest2, self)
	self._AddClickListener(self, self._btnLoadTestAudio, self._onClickLoadTestAudio, self)
	self._AddClickListener(self, self._btnUnloadTestAudio, self._onClickUnloadTestAudio, self)
	self._AddOnValueChanged(self, self._visualToggle, self._onVisualToggleValueChange, self)
	self._AddOnValueChanged(self, self._textSizeToggle, self._onTextSizeToggleValueChange, self)
	self._AddClickListener(self, self._btnChangeActivity, self._onClickChangeActivityBtn, self)
	self._AddClickListener(self, self._btnResetActivity, self._onClickResetActivityBtn, self)
	self._AddClickListener(self, self._btnEnterActivity, self._onClickEnterActivity, self)
	self._AddClickListener(self, self._btnResetActivityUnlockAnim, self._onClickResetActivityUnlockAim, self)
	self._AddOnValueChanged(self, self._dropActivity, self._onActivityDropValueChange, self)
	self._AddOnValueChanged(self, self._dropActivityStatus, self._onActivityStatusDropValueChange, self)
	self._AddClickListener(self, self._btnOnekeyFightSucc, self._onClickOnekeyFightSucc, self)
	self._AddClickListener(self, self._btnEnterDialogue, self._onClickEnterDialogue, self)
	self._AddClickListener(self, self._startEditV1a5HoleBtn, self._onClickStartEditV1a5HoleBtn, self)
	self._AddClickListener(self, self._endEditV1a5HoleBtn, self._onClickEndEditV1a5HoleBtn, self)
end

function GMToolView2:removeEvents()
	self:_RemoveClickListener(self._btnDumpHierarchy)
	self:_RemoveClickListener(self._btnHierarchy)
	self:_RemoveClickListener(self._btnSkillPreview)
	self:_RemoveClickListener(self._btnVersion)
	self:_RemoveClickListener(self._btnHardware)
	self:_RemoveOnValueChanged(self._sliderRenderScale)
	self:_RemoveClickListener(self._btnForbidFightEffect)
	self:_RemoveClickListener(self._btnCancelForbidFightEffect)
	self:_RemoveClickListener(self._btnTest1)
	self:_RemoveClickListener(self._btnTest2)
	self:_RemoveClickListener(self._btnLoadTestAudio)
	self:_RemoveClickListener(self._btnUnloadTestAudio)
	self:_RemoveOnValueChanged(self._visualToggle)
	self:_RemoveOnValueChanged(self._textSizeToggle)
	self:_RemoveClickListener(self._btnChangeActivity)
	self:_RemoveClickListener(self._btnResetActivity)
	self:_RemoveOnValueChanged(self._dropActivity)
	self:_RemoveOnValueChanged(self._dropActivityStatus)
	self:_RemoveClickListener(self._btnEnterActivity)
	self:_RemoveClickListener(self._btnResetActivityUnlockAnim)
	self:_RemoveClickListener(self._btnOnekeyFightSucc)
	self:_RemoveClickListener(self._btnEnterDialogue)
	self:_RemoveClickListener(self._startEditV1a5HoleBtn)
	self:_RemoveClickListener(self._endEditV1a5HoleBtn)
end

function GMToolView2:_AddClickListener(btn, callback, cbObj)
	if btn then
		btn:AddClickListener(callback, cbObj)
	end
end

function GMToolView2:_RemoveClickListener(btn)
	if btn then
		btn:RemoveClickListener()
	end
end

function GMToolView2:_AddOnValueChanged(slider, callback, cbObj)
	if slider then
		slider:AddOnValueChanged(callback, cbObj)
	end
end

function GMToolView2:_RemoveOnValueChanged(slider)
	if slider then
		slider:RemoveOnValueChanged()
	end
end

function GMToolView2:onDestroyView()
	return
end

function GMToolView2:onOpen()
	local value = CameraMgr.instance:getRenderScale() or 1

	self._sliderRenderScale:SetValue(value)

	self._txtRenderScale.text = string.format("RenderScale\n%.2f", value)

	self:initActivityDrop()
	self:initActivityEnterFunc()
end

function GMToolView2:initActivityDrop()
	local version = ActivityLiveMgr.instance:getLiveMgrVersion()
	local enumInstance = _G[string.format("VersionActivity%sEnum", version)]

	if not enumInstance then
		logError("GMToolView2 initActivityDrop getLiveMgrVersion error version:" .. tostring(version))

		return
	end

	local activityEnumList = {
		enumInstance.ActivityId
	}

	self.activityIdList = {}
	self.activityShowStrList = {}

	local allActList = {}

	tabletool.addValues(allActList, enumInstance.ActivityId)

	self.activityAll = {
		[string.format("%sall", version)] = allActList
	}

	for _, activityEnum in ipairs(activityEnumList) do
		for _, actId in pairs(activityEnum) do
			if type(actId) == "table" then
				for _, v in pairs(actId) do
					table.insert(self.activityIdList, v)
				end
			else
				table.insert(self.activityIdList, actId)
			end
		end
	end

	for _, activityId in ipairs(self.activityIdList) do
		local activityConfig = lua_activity.configDict[activityId]

		table.insert(self.activityShowStrList, ((activityConfig or nil) and (activityConfig.name or "")) .. string.format("(%s)", activityId))
	end

	for k, v in pairs(self.activityAll) do
		table.insert(self.activityIdList, 1, k)
		table.insert(self.activityShowStrList, 1, k)
	end

	self.statusList = {
		ActivityEnum.ActivityStatus.Normal,
		ActivityEnum.ActivityStatus.NotOpen,
		ActivityEnum.ActivityStatus.Expired,
		ActivityEnum.ActivityStatus.NotUnlock,
		ActivityEnum.ActivityStatus.NotOnLine
	}
	self.statusShowStrList = {
		"正常开启状态",
		"未达到开启时间",
		"活动已结束",
		"活动未解锁",
		"活动已下线"
	}
	self.selectActivityIndex = 1
	self.selectStatusIndex = 1

	if self._dropActivity then
		self._dropActivity:ClearOptions()
		self._dropActivityStatus:ClearOptions()
		self._dropActivity:AddOptions(self.activityShowStrList)
		self._dropActivityStatus:AddOptions(self.statusShowStrList)
	end
end

function GMToolView2:onOpenFinish()
	self.isOpenFinish = true
end

function GMToolView2:onClose()
	ZProj.AudioManager.Instance:SetErrorCallback(nil, nil)
	TaskDispatcher.cancelTask(self._checkCallAudiosLoop, self)
end

function GMToolView2:_checkLowerName(list)
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

function GMToolView2:_checkAudioConfigs(config, sourceExcel)
	for _, co in ipairs(config.configList) do
		if co.id and co.id > 0 and not tabletool.indexOf(self._audioConfigs, co.id) then
			table.insert(self._audioConfigs, co.id)

			self._audioId2Excel = self._audioId2Excel or {}
			self._audioId2Excel[co.id] = sourceExcel
		end
	end
end

function GMToolView2:_onClickLoadTestAudio()
	local audioName = self._inpTestAudio:GetText() or ""
	local beginIndexText = self._inpBeginTestAudio:GetText() or ""
	local endIndexText = self._inpEndTestAudio:GetText() or ""

	self:_testAudioParseParam(true, audioName, beginIndexText, endIndexText)
end

function GMToolView2:_onClickUnloadTestAudio()
	local audioName = self._inpTestAudio:GetText() or ""
	local beginIndexText = self._inpBeginTestAudio:GetText() or ""
	local endIndexText = self._inpEndTestAudio:GetText() or ""

	self:_testAudioParseParam(false, audioName, beginIndexText, endIndexText)
end

function GMToolView2:_testAudioParseParam(isLoad, audioName, strBeginIndex, strEndIndex)
	if string.nilorempty(audioName) then
		return
	end

	local platform = SLFramework.FrameworkSettings.CurPlatformName
	local assetRootDir = SLFramework.FrameworkSettings.AssetRootDir
	local audioParentDir = string.format("%s/audios/%s", assetRootDir, platform)
	local numBegin = tonumber(strBeginIndex)

	if numBegin then
		local numEnd = tonumber(strEndIndex)

		if not numEnd or numEnd < numBegin then
			numEnd = numBegin
		end

		self:_multiLoadOrUnloadAudio(audioName, numBegin, numEnd, audioParentDir, isLoad)
	else
		local audioNameWithSuffix = self:_getAudioNameWithSuffix(audioName)

		self:_singleLoadOrUnloadAudio(audioNameWithSuffix, audioParentDir, isLoad, true)
	end
end

function GMToolView2:_getAudioNameWithSuffix(audioName, index)
	local audioNameWithSuffix = string.format("%s.bnk", audioName)

	return (index or nil) and string.format("%s_%s.bnk", audioName, index)
end

function GMToolView2:_singleLoadOrUnloadAudio(audioNameWithSuffix, audioParentDir, isLoad, isGC)
	local audioEditorPath = string.format("%s/%s", audioParentDir, audioNameWithSuffix)
	local lang = AudioMgr.instance:getCurLang()
	local audioEditorPathWithLang = string.format("%s/%s/%s", audioParentDir, lang, audioNameWithSuffix)

	if SLFramework.FileHelper.IsFileExists(audioEditorPath) or SLFramework.FileHelper.IsFileExists(audioEditorPathWithLang) then
		if isLoad then
			ZProj.AudioManager.Instance:LoadBank(audioNameWithSuffix)
			logNormal("加载音频---" .. audioNameWithSuffix)
		else
			ZProj.AudioManager.Instance:UnloadBank(audioNameWithSuffix)
			logNormal("卸载音频---" .. audioNameWithSuffix)

			if isGC then
				GameGCMgr.instance:dispatchEvent(GameGCEvent.AudioGC, self)
			end
		end
	else
		local platform = SLFramework.FrameworkSettings.CurPlatformName
		local errLog = string.format("音频文件：%s 不存在，平台：%s，语言：%s", audioNameWithSuffix, platform, lang)

		logError(errLog)
	end
end

function GMToolView2:_multiLoadOrUnloadAudio(audioName, numBegin, numEnd, audioParentDir, isLoad)
	for i = numBegin, numEnd do
		local audioNameWithSuffix = self:_getAudioNameWithSuffix(audioName, i)

		self:_singleLoadOrUnloadAudio(audioNameWithSuffix, audioParentDir, isLoad, false)
	end

	if not isLoad then
		GameGCMgr.instance:dispatchEvent(GameGCEvent.AudioGC, self)
	end
end

function GMToolView2:_onClickBtnDumpHierarchy()
	self:closeThis()

	local maxDepth = 100
	local inpText = self._inpDumpHierarchy:GetText()

	maxDepth = not string.nilorempty(inpText) and tonumber(inpText) or maxDepth

	local rootGameObjects = SLFramework.GameObjectHelper.GetRootGameObjects()
	local infoList = {}

	for i = 0, rootGameObjects.Length - 1 do
		local rootGO = rootGameObjects[i]

		self:_dumpGOSelf(rootGO.transform, infoList, 0)
		self:_dumpChildren(rootGO.transform, infoList, 1, maxDepth)
	end

	local hierarchyInfoStr = table.concat(infoList, "\n")

	logError("\n" .. hierarchyInfoStr)
	ZProj.GameHelper.SetSystemBuffer(hierarchyInfoStr)
	GameFacade.showToast(ToastEnum.IconId, "Hierarchy信息已复制到粘贴板")
end

function GMToolView2:_onClickBtnHierarchy()
	self:closeThis()
	ViewMgr.instance:openView(ViewName.HierarchyView)
end

function GMToolView2:_dumpGOSelf(tr, infoList, depth)
	local str = ""

	for i = 1, depth do
		str = str .. " - "
	end

	str = str .. "[" .. tr.name .. "]" .. (tr.gameObject.activeSelf and " √" or " ×")

	if tr:GetComponent(typeof(UnityEngine.RectTransform)) then
		local anchorX = self:_getIntOrFloat2Str(tr.anchoredPosition.x)
		local anchorY = self:_getIntOrFloat2Str(tr.anchoredPosition.y)

		str = str .. string.format(" rectPos(%s,%s)", anchorX, anchorY)

		local canvasGroup = tr:GetComponent(typeof(UnityEngine.CanvasGroup))

		if canvasGroup then
			local alpha = self:_getIntOrFloat2Str(canvasGroup.alpha)

			str = str .. string.format(" canvasGroup.alpha(%s)", alpha)
		end
	else
		local posX = self:_getIntOrFloat2Str(tr.localPosition.x)
		local posY = self:_getIntOrFloat2Str(tr.localPosition.y)
		local posZ = self:_getIntOrFloat2Str(tr.localPosition.z)

		str = str .. string.format(" pos(%s,%s,%s)", posX, posY, posZ)
	end

	if tr.localScale.x == tr.localScale.y and tr.localScale.x == tr.localScale.z then
		if tr.localScale.x ~= 1 then
			local scaleX = self:_getIntOrFloat2Str(tr.localScale.x)

			str = str .. string.format(" scale(%s)", scaleX)
		end
	else
		local scaleX = self:_getIntOrFloat2Str(tr.localScale.x)
		local scaleY = self:_getIntOrFloat2Str(tr.localScale.y)
		local scaleZ = self:_getIntOrFloat2Str(tr.localScale.z)

		str = str .. string.format(" scale(%s,%s,%s)", scaleX, scaleY, scaleZ)
	end

	table.insert(infoList, str)
end

function GMToolView2:_getIntOrFloat2Str(num)
	local numPrecision2 = math.floor(num * 100 + 0.5) / 100

	if numPrecision2 % 1 == 0 then
		return tostring(numPrecision2)
	elseif numPrecision2 % 0.1 == 0 then
		return string.format("%.1f", numPrecision2)
	else
		return string.format("%.2f", numPrecision2)
	end
end

function GMToolView2:_dumpChildren(tr, infoList, depth, maxDepth)
	for i = 0, tr.childCount - 1 do
		local child = tr:GetChild(i)

		self:_dumpGOSelf(child, infoList, depth)

		if depth < maxDepth - 1 then
			self:_dumpChildren(child, infoList, depth + 1, maxDepth)
		end
	end
end

function GMToolView2:_onClickBtnSkillPreview()
	SkillEditorMgr.instance:start()
end

function GMToolView2:_onClickBtnVersion()
	local gameId = SDKMgr.instance:getGameId()
	local appVersion = BootNativeUtil.getAppVersion()
	local hotUpdateVersion = SLFramework.GameUpdate.HotUpdateInfoMgr.LocalResVersionStr
	local str1 = "gameId=" .. gameId .. "  type=" .. type(gameId)
	local str2 = "appVersion=" .. appVersion .. "  type=" .. type(appVersion)
	local str3 = "hotUpdateVersion=" .. hotUpdateVersion .. "  type=" .. type(hotUpdateVersion)

	logError(str1)
	logError(str2)
	logError(str3)
	MessageBoxController.instance:showMsgBoxByStr(str1 .. "\n" .. str2 .. "\n" .. str3)
end

local gradeStrDict = {
	[ModuleEnum.Performance.High] = "高配",
	[ModuleEnum.Performance.Middle] = "中配",
	[ModuleEnum.Performance.Low] = "低配"
}

function GMToolView2:_onClickBtnHardware()
	local deviceName = UnityEngine.SystemInfo.deviceModel
	local cpuName = BootNativeUtil.getCpuName()
	local gpuName = UnityEngine.SystemInfo.graphicsDeviceName
	local memory = UnityEngine.SystemInfo.systemMemorySize
	local grade, by = HardwareUtil.getPerformanceGrade()
	local gradeStr = gradeStrDict[grade]
	local str1 = "设备名: " .. (deviceName or "nil")
	local str2 = "CPU: " .. (cpuName or "nil")
	local str3 = "GPU: " .. (gpuName or "nil")
	local str4 = "Memory: " .. (memory or "nil")
	local str5 = "硬件分级：" .. gradeStr .. " by " .. by
	local str6 = "设备DPI：" .. UnityEngine.Screen.dpi
	local str7 = "分辨率：" .. UnityEngine.Screen.currentResolution:ToString()

	logError(str1)
	logError(str2)
	logError(str3)
	logError(str4)
	logError(str5)
	logError(str6)
	logError(str7)
	MessageBoxController.instance:showMsgBoxByStr(str1)
	MessageBoxController.instance:showMsgBoxByStr(str2 .. "\n" .. str3)
	MessageBoxController.instance:showMsgBoxByStr(str4 .. "\n" .. str5)
	MessageBoxController.instance:showMsgBoxByStr(str6 .. "\n" .. str7)
end

function GMToolView2:_onRenderScaleChange(param, value)
	CameraMgr.instance:setRenderScale(value)

	self._txtRenderScale.text = string.format("RenderScale\n%.2f", value)
end

function GMToolView2:_onClickForbidFightEffect()
	FightEffectPool.isForbidEffect = true
end

function GMToolView2:_onClickCancelForbidFightEffect()
	FightEffectPool.isForbidEffect = nil
end

function GMToolView2:_onClickTest1()
	logError("test1")
	logError("战斗速度：" .. FightModel.instance:getSpeed())
	logError("Unity速度：" .. Time.timeScale)
end

function GMToolView2:_onClickTest2()
	logError("test2")
	System.GC.Collect(2, System.GCCollectionMode.Forced, true, true)
end

function GMToolView2:_onVisualToggleValueChange(param, value)
	if not self.isOpenFinish then
		return
	end

	GMController.instance:setVisualInteractive(value)
	GMController.instance:getVisualInteractiveMgr():tryStart()
end

function GMToolView2:_onTextSizeToggleValueChange(param, value)
	if not self.isOpenFinish then
		return
	end

	GMController.instance:setTextSizeActive(value)
	GMController.instance:getVisualInteractiveMgr():tryStart()
end

function GMToolView2:_onClickChangeActivityBtn()
	local activityId = self.activityIdList[(not self.selectActivityIndex or nil) and 1]

	if self.activityAll[activityId] then
		for k, v in pairs(self.activityAll[activityId]) do
			self:_changeActivityInfo(v)
		end

		return
	end

	self:_changeActivityInfo(activityId)
end

function GMToolView2:_changeActivityInfo(activityId)
	local status = self.statusList[(not self.selectStatusIndex or nil) and 1]
	local activityInfo = ActivityModel.instance:getActivityInfo()[activityId]
	local existStatus = ActivityHelper.getActivityStatus(activityId)

	if existStatus == status then
		return
	end

	local now = ServerTime.now() * 1000
	local maxTime = TimeUtil.maxDateTimeStamp * 1000

	activityInfo.config = self:copyConfig(activityInfo.config)

	if status == ActivityEnum.ActivityStatus.Normal then
		activityInfo.startTime = now - 1
		activityInfo.endTime = maxTime
		activityInfo.config.openId = 0
		activityInfo.online = true
	elseif status == ActivityEnum.ActivityStatus.NotOpen then
		activityInfo.startTime = maxTime
	elseif status == ActivityEnum.ActivityStatus.Expired then
		activityInfo.startTime = now - 1
		activityInfo.endTime = activityInfo.startTime
	elseif status == ActivityEnum.ActivityStatus.NotUnlock then
		activityInfo.startTime = now - 1
		activityInfo.endTime = maxTime
		activityInfo.config.openId = activityId
		OpenModel.instance._unlocks[activityId] = false
	elseif status == ActivityEnum.ActivityStatus.NotOnLine then
		activityInfo.startTime = now - 1
		activityInfo.endTime = maxTime
		activityInfo.config.openId = 0
		activityInfo.online = false
	end

	ActivityController.instance:dispatchEvent(ActivityEvent.RefreshActivityState, activityId)
end

function GMToolView2:copyConfig(co)
	local newCo = {}
	local fields = {
		logoName = 9,
		name = 3,
		banner = 13,
		actDesc = 5,
		desc = 14,
		openId = 17,
		tabButton = 25,
		logoType = 8,
		isRetroAcitivity = 21,
		confirmCondition = 11,
		achievementGroupPath = 22,
		achievementGroup = 19,
		tabBgmId = 26,
		showCenter = 15,
		param = 16,
		redDotId = 18,
		storyId = 20,
		tabBgPath = 24,
		typeId = 7,
		actTip = 6,
		activityBonus = 23,
		tabName = 2,
		id = 1,
		joinCondition = 10,
		displayPriority = 12,
		nameEn = 4
	}

	for key, value in pairs(fields) do
		newCo[key] = co[key]
	end

	return newCo
end

function GMToolView2:_onClickResetActivityBtn()
	ActivityRpc.instance:sendGetActivityInfosRequest()
end

function GMToolView2:_onActivityDropValueChange(index)
	self.selectActivityIndex = index + 1
end

function GMToolView2:_onActivityStatusDropValueChange(index)
	self.selectStatusIndex = index + 1
end

function GMToolView2:_onClickResetActivityUnlockAim()
	PlayerPrefsHelper.deleteKey(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PlayedActUnlockAnimationKey))

	VersionActivityBaseController.instance.playedActUnlockAnimationList = nil
end

function GMToolView2:_onClickEnterActivity()
	local activityId = self.activityIdList[(not self.selectActivityIndex or nil) and 1]
	local enterFunc = self._activityEnterFuncMap[activityId]

	if not enterFunc then
		return
	end

	local funcParams = self._activityEnterFuncParamsMap[activityId]

	enterFunc(funcParams.obj, funcParams.params)
end

function GMToolView2:initActivityEnterFunc()
	self._activityEnterFuncMap = {
		[11304] = Activity1_3ChessController.openMapView,
		[12204] = LoperaController.openLoperaMainView
	}
	self._activityEnterFuncParamsMap = {
		[11304] = {
			params = 1,
			obj = Activity1_3ChessController
		},
		[12204] = {
			obj = LoperaController.instance
		}
	}
end

function GMToolView2:_onClickOnekeyFightSucc()
	self:closeThis()
	GMRpc.instance:sendGMRequest("set fight 1")
end

function GMToolView2:_onClickEnterDialogue()
	local dialogueId = self._inputDialogue:GetText()

	dialogueId = tonumber(dialogueId)

	if not dialogueId then
		return
	end

	if lua_tip_dialog.configDict[dialogueId] then
		TipDialogController.instance:openTipDialogView(dialogueId)

		return
	end

	local dialogueCo = DialogueConfig.instance:getDialogueCo(dialogueId)

	if not dialogueCo then
		GameFacade.showToastString("对话id不存在，请检查配置")
	end

	DialogueController.instance:enterDialogue(dialogueId)
end

function GMToolView2:_onClickStartEditV1a5HoleBtn()
	local mapViewContainer = ViewMgr.instance:getContainer(ViewName.VersionActivity1_5DungeonMapView)

	if not mapViewContainer then
		ToastController.instance:showToastWithString("请先打开1.5副本界面")

		return
	end

	if not mapViewContainer:isOpenFinish() then
		ToastController.instance:showToastWithString("请等待1.5副本界面打开完成")

		return
	end

	self.holeEditView = EditorV1a5DungeonHoleView.start(mapViewContainer)

	self:closeThis()
end

return GMToolView2
