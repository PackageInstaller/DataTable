-- chunkname: @projbooter/reschecker/ResCheckMgr.lua

module("modules.reschecker.ResCheckMgr", package.seeall)

local ResCheckMgr = class("ResCheckMgr")
local ResChecker = SLFramework.ResChecker

function ResCheckMgr:ctor()
	self._loaclHashPath = SLFramework.FrameworkSettings.PersistentResRootDir .. "/localhash"
	self._outVersionPath = SLFramework.ResChecker.OutVersionPath
	self._outMassVersionPath = SLFramework.ResChecker.OutVersionPath .. "_mass"
end

function ResCheckMgr:DeleteLocalhashFile()
	SLFramework.FileHelper.DeleteFile(self._loaclHashPath)
end

function ResCheckMgr:DeleteOutVersion()
	SLFramework.FileHelper.DeleteFile(self._outVersionPath)
	SLFramework.FileHelper.DeleteFile(self._outMassVersionPath)
end

function ResCheckMgr:GetOutVersion()
	return ProjBooter.instance:isUseBigZip() and SLFramework.FileHelper.ReadText(self._outVersionPath) or SLFramework.FileHelper.ReadText(self._outMassVersionPath)
end

function ResCheckMgr:startCheck(cb, cbObj)
	self.cb = cb
	self.cbObj = cbObj

	ResChecker.Instance:InitResInfoConfig(self._onInitResInfoFinish, self)
end

function ResCheckMgr:_onInitResInfoFinish()
	local allLocalLang = self:getAllLocalLang()
	local useDLC, allDLCLocalLang = self:getDLCInfo(allLocalLang)

	self._allDLCLocalLang = allDLCLocalLang
	self._allLocalLang = allLocalLang

	local appVersion = tonumber(BootNativeUtil.getAppVersion())
	local markVersion = self:GetOutVersion()

	if ProjBooter.instance:isUseBigZip() then
		SLFramework.FileHelper.DeleteFile(self._outMassVersionPath)

		if tostring(appVersion) == markVersion then
			logNormal("ResCheckMgr pass, is not first init")
			self:doCallBack(true)

			return
		end
	else
		SLFramework.FileHelper.DeleteFile(self._outVersionPath)

		if tostring(appVersion) == markVersion and SLFramework.FileHelper.IsFileExists(self._loaclHashPath) then
			logNormal("ResCheckMgr pass, is not first init")
			self:checkLocalHash()

			return
		end
	end

	self:DeleteLocalhashFile()
	SLFramework.TimeWatch.Instance:Start()

	self.eventDispatcher = SLFramework.GameLuaEventDispatcher.Instance

	self.eventDispatcher:AddListener(self.eventDispatcher.ResChecker_Finish, self.onCheckFinish, self)
	self.eventDispatcher:AddListener(self.eventDispatcher.ResChecker_Progress, self.onCheckProgress, self)
	logNormal("ResCheckMgr:startCheck, allLocalLang = " .. table.concat(allLocalLang, ",") .. " useDLC = " .. tostring(useDLC) .. " allDLCLocalLang = " .. table.concat(allDLCLocalLang, ","))
	SLFramework.ResChecker.Instance:CheckAllRes()
end

function ResCheckMgr:onCheckProgress(doneFileNum, allFileNum)
	logNormal("ResCheckMgr:onCheckProgress, 检查进度 doneFileNum = " .. doneFileNum .. " allFileNum = " .. allFileNum)

	local percent = doneFileNum / allFileNum
	local progressMsg = string.format(booterLang("rescheker"), doneFileNum, allFileNum)

	HotUpdateProgress.instance:setProgressCheckRes(percent, doneFileNum .. "/" .. allFileNum)
end

function ResCheckMgr:onCheckFinish(allPass, allSize)
	if not ProjBooter.instance:isUseBigZip() then
		self:markLastCheckAppVersion()
	end

	allSize = tonumber(tostring(allSize))

	logNormal("ResCheckMgr:onCheckFinish:allPass = " .. tostring(allPass) .. " #allSize = " .. allSize .. " #cost time: " .. SLFramework.TimeWatch.Instance:Watch() .. " s")

	if allPass then
		self:doCallBack(true)
	elseif UnityEngine.Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork then
		self:doCallBack()
	else
		local args = {}

		args.title = booterLang("hotupdate")

		local msg = booterLang("hotupdate_info")

		args.content = string.format(msg, HotUpdateMgr.instance:_fixSizeStr(allSize))
		args.leftMsg = booterLang("exit")
		args.leftCb = self._quitGame
		args.leftCbObj = self
		args.rightMsg = booterLang("download")
		args.rightCb = self.doCallBack
		args.rightCbObj = self

		BootMsgBox.instance:show(args)
	end
end

function ResCheckMgr:doCallBack(allPass, diffList, skipCheck)
	if self.eventDispatcher then
		self.eventDispatcher:RemoveListener(self.eventDispatcher.ResChecker_Finish)
		self.eventDispatcher:RemoveListener(self.eventDispatcher.ResChecker_Progress)
	end

	if allPass then
		self:markLastCheckAppVersion()

		if skipCheck then
			if self.cb then
				self.cb(self.cbObj, true)
			end
		else
			self._fakeProgress = 0
			self._fakeProgressTimer = Timer.New(function()
				self:_updateFakeProgress()
			end, 0.1, 20)

			self._fakeProgressTimer:Start()
		end
	elseif self.cb then
		self.cb(self.cbObj, allPass, diffList)
	end
end

function ResCheckMgr:_updateFakeProgress()
	self._fakeProgress = self._fakeProgress + 0.1

	HotUpdateProgress.instance:setProgressDownloadRes(self._fakeProgress)

	if self._fakeProgress >= 1 then
		self._fakeProgressTimer:Stop()

		self._fakeProgressTimer = nil

		if self.cb then
			self.cb(self.cbObj, true)
		end
	end
end

function ResCheckMgr:markLastCheckAppVersion()
	logNormal("ResCheckMgr:markLastCheckAppVersion")

	local appVersion = BootNativeUtil.getAppVersion()

	if ProjBooter.instance:isUseBigZip() then
		SLFramework.FileHelper.WriteTextToPath(self._outVersionPath, appVersion)
	else
		SLFramework.FileHelper.WriteTextToPath(self._outMassVersionPath, appVersion)
	end
end

function ResCheckMgr:checkLocalHash()
	SLFramework.ResChecker.Instance:CheckAllResFast()

	local dlcTypeList = self:getAllLocalResBigType()
	local allSize = SLFramework.ResChecker.Instance:GetUnmatchResSize(dlcTypeList)

	allSize = tonumber(tostring(allSize))

	if allSize > 0 then
		logNormal(allSize .. "文件大小不一致，需要重新下载")
		self:doCallBack(false)
	else
		logNormal("所有文件都一致，不需要重新下载")
		self:doCallBack(true, nil, true)
	end
end

function ResCheckMgr:_quitGame()
	logNormal("ResCheckMgr:_quitGame, 退出游戏！")
	ProjBooter.instance:quitGame()
end

function ResCheckMgr:getAllLocalLang()
	local optionalUpdateInst = SLFramework.GameUpdate.OptionalUpdate.Instance

	optionalUpdateInst:Init()

	local langShortcuts = {}
	local supportLangList = HotUpdateVoiceMgr.instance:getSupportVoiceLangs()
	local defaultLang = GameConfig:GetDefaultVoiceShortcut()
	local curLang = GameConfig:GetCurVoiceShortcut()
	local packageTypeList = HotUpdateOptionPackageMgr.instance:getLangPackageNameList()

	for i = 1, #supportLangList do
		local lang = supportLangList[i]
		local default = lang == defaultLang
		local isCurLang = lang == curLang
		local localVersion = optionalUpdateInst:GetLocalVersion(lang)
		local hasLocalVersion = not string.nilorempty(localVersion)

		if default or (ProjBooter.instance:isUseBigZip() == false or nil) and tabletool.indexOf(packageTypeList, lang) ~= nil or isCurLang or HotUpdateVoiceMgr.ForceSelect[lang] then
			table.insert(langShortcuts, lang)
		end
	end

	return langShortcuts
end

function ResCheckMgr:getDLCInfo(allLocalLang)
	local packageTypeList = HotUpdateOptionPackageMgr.instance:getPackageNameList()
	local allDLCPackKey = {}

	for i, packageType in ipairs(packageTypeList) do
		table.insert(allDLCPackKey, HotUpdateOptionPackageMgr.instance:formatLangPackName("res", packageType))
		table.insert(allDLCPackKey, HotUpdateOptionPackageMgr.instance:formatLangPackName("media", packageType))

		for n, lang in ipairs(allLocalLang) do
			table.insert(allDLCPackKey, HotUpdateOptionPackageMgr.instance:formatLangPackName(lang, packageType))
		end
	end

	if not tabletool.indexOf(allDLCPackKey, "res-HD") then
		if BootNativeUtil.isWindows() then
			table.insert(allDLCPackKey, "res-HD")
		else
			local optionalUpdateInst = SLFramework.GameUpdate.OptionalUpdate.Instance
			local localVersion = optionalUpdateInst:GetLocalVersion("res-HD")
			local hasLocalVersion = not string.nilorempty(localVersion)

			if hasLocalVersion then
				table.insert(allDLCPackKey, "res-HD")
			end
		end
	end

	return #allDLCPackKey > 0, allDLCPackKey
end

function ResCheckMgr:getAllLocalResBigType()
	local allLocalLang = self:getAllLocalLang()
	local _, allDLCLocalLang = self:getDLCInfo(allLocalLang)
	local allList = {
		SLFramework.ResChecker.KEY_BASE_RES
	}

	tabletool.addValues(allList, allLocalLang)
	tabletool.addValues(allList, allDLCLocalLang)

	return allList
end

ResCheckMgr.instance = ResCheckMgr.New()

return ResCheckMgr
