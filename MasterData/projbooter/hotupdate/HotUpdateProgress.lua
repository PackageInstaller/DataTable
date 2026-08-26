-- chunkname: @projbooter/hotupdate/HotUpdateProgress.lua

module("projbooter.hotupdate.HotUpdateProgress", package.seeall)

local HotUpdateProgress = class("HotUpdateMgr")

HotUpdateProgress.NotFixProgress = 0.01
HotUpdateProgress.FixProgress = 1 - HotUpdateProgress.NotFixProgress
HotUpdateProgress.UnzipPer = 0.1
HotUpdateProgress.DownloadPer = 1 - HotUpdateProgress.UnzipPer
HotUpdateProgress.CheckResPer = 0.2
HotUpdateProgress.DownloadResPer = 1 - HotUpdateProgress.CheckResPer
HotUpdateProgress.ShowDetailMsg = true

function HotUpdateProgress:initDownloadSize(hotupdateAllSize, hotupdateCurSize)
	if GameResMgr.IsFromEditorDir or VersionValidator.instance:isInReviewing() and BootNativeUtil.isIOS() then
		HotUpdateProgress.NotFixProgress = 1
	elseif ProjBooter.instance:isUseBigZip() then
		local appVersion = tonumber(BootNativeUtil.getAppVersion())
		local markVersion = ResCheckMgr.instance:GetOutVersion()

		HotUpdateProgress.NotFixProgress = tostring(appVersion) == markVersion and 1 or 0.75
	end

	self._voiceNeedDownloadSize = HotUpdateVoiceMgr.instance:getNeedDownloadSize()
	self._optionPackageNeedDownloadSize = HotUpdateOptionPackageMgr.instance:getNeedDownloadSize()
	self._hotupdateNeedDownloadSize = hotupdateAllSize - hotupdateCurSize

	if self._hotupdateNeedDownloadSize == 0 then
		-- block empty
	end

	self._hotupdateNeedDownloadSize = hotupdateAllSize

	if self._optionPackageNeedDownloadSize == 0 then
		-- block empty
	end

	self._optionPackageNeedDownloadSize = HotUpdateOptionPackageMgr.instance:getTotalSize()

	if self._voiceNeedDownloadSize == 0 then
		-- block empty
	end

	self._voiceNeedDownloadSize = HotUpdateVoiceMgr.instance:getTotalSize()

	logNormal("hotupdate need download size: ", self._hotupdateNeedDownloadSize)
	logNormal("voice need download size: ", self._voiceNeedDownloadSize)
	logNormal("optionPackage need download size: ", self._optionPackageNeedDownloadSize)

	self._totalNeedDownloadSize = self._voiceNeedDownloadSize + self._hotupdateNeedDownloadSize + self._optionPackageNeedDownloadSize
	HotUpdateProgress.FixProgress = 1 - HotUpdateProgress.NotFixProgress
	self._totalNeedDownloadSizeStr = HotUpdateMgr.fixSizeStr(self._totalNeedDownloadSize)
end

function HotUpdateProgress:updateVoiceNeedDownloadSize()
	self._voiceNeedDownloadSize = HotUpdateVoiceMgr.instance:getTotalSize()
	self._totalNeedDownloadSize = self._voiceNeedDownloadSize + self._hotupdateNeedDownloadSize + self._optionPackageNeedDownloadSize

	if self._totalNeedDownloadSize <= 0 then
		HotUpdateProgress.NotFixProgress = 0
	end

	HotUpdateProgress.FixProgress = 1 - HotUpdateProgress.NotFixProgress
	self._totalNeedDownloadSizeStr = HotUpdateMgr.fixSizeStr(self._totalNeedDownloadSize)
end

function HotUpdateProgress:getTotalNeedDownloadSize()
	return self._totalNeedDownloadSize
end

function HotUpdateProgress:getTotalNeedDownloadSizeStr()
	return self._totalNeedDownloadSizeStr
end

function HotUpdateProgress:getHotupdateNeedDownloadSize()
	return self._hotupdateNeedDownloadSize
end

function HotUpdateProgress:getVoiceNeedDownloadSize()
	return self._voiceNeedDownloadSize
end

function HotUpdateProgress:getOptionPackageNeedDownloadSize()
	return self._optionPackageNeedDownloadSize
end

function HotUpdateProgress:setProgressDownloadHotupdate(curSize)
	local curAllSizeStr = HotUpdateMgr.fixSizeStr(curSize)
	local progressMsg = string.format(booterLang("downloading_progress_new"), curAllSizeStr, self:getTotalNeedDownloadSizeStr())
	local totalPer = curSize * HotUpdateProgress.DownloadPer / self._totalNeedDownloadSize

	self:setProgressNotFix(totalPer, progressMsg)
end

function HotUpdateProgress:setProgressUnzipHotupdate(progress)
	local needDownloadSize = HotUpdateMgr.fixSizeStr(self:getHotupdateNeedDownloadSize())
	local progressMsg = string.format(booterLang("unziping_progress_new"), math.floor(100 * progress + 0.5), needDownloadSize, self:getTotalNeedDownloadSizeStr())
	local totalPer = self._hotupdateNeedDownloadSize * (HotUpdateProgress.DownloadPer + progress * HotUpdateProgress.UnzipPer) / self._totalNeedDownloadSize

	self:setProgressNotFix(totalPer, progressMsg)
end

function HotUpdateProgress:setProgressDownloadVoice(curSize, downloadSuccSize, progressMsg)
	if curSize == 0 then
		return
	end

	local curAllSize = self:getHotupdateNeedDownloadSize() + curSize + downloadSuccSize
	local curAllSizeStr = HotUpdateMgr.fixSizeStr(curAllSize)
	local progressMsg = string.format(booterLang("downloading_progress_new"), curAllSizeStr, self:getTotalNeedDownloadSizeStr())
	local totalPer = (curSize * HotUpdateProgress.DownloadPer + downloadSuccSize + self._hotupdateNeedDownloadSize) / self._totalNeedDownloadSize

	self:setProgressNotFix(totalPer, progressMsg)
end

function HotUpdateProgress:setProgressUnzipVoice(progress, nowPackSize, downloadSuccSize, progressMsg)
	local curAllSize = self:getHotupdateNeedDownloadSize() + nowPackSize + downloadSuccSize
	local curAllSizeStr = HotUpdateMgr.fixSizeStr(curAllSize)
	local progressMsg = string.format(booterLang("unziping_progress_new"), math.floor(100 * progress + 0.5), curAllSizeStr, self:getTotalNeedDownloadSizeStr())
	local totalPer = (nowPackSize * (HotUpdateProgress.DownloadPer + progress * HotUpdateProgress.UnzipPer) + downloadSuccSize + self._hotupdateNeedDownloadSize) / self._totalNeedDownloadSize

	self:setProgressNotFix(totalPer, progressMsg)
end

function HotUpdateProgress:setProgressDownloadOptionPackage(curSize, downloadSuccSize, progressMsg)
	if curSize == 0 then
		return
	end

	local curAllSize = self:getHotupdateNeedDownloadSize() + self:getVoiceNeedDownloadSize() + curSize + downloadSuccSize
	local curAllSizeStr = HotUpdateMgr.fixSizeStr(curAllSize)
	local progressMsg = string.format(booterLang("downloading_progress_new"), curAllSizeStr, self:getTotalNeedDownloadSizeStr())
	local totalPer = (curSize * HotUpdateProgress.DownloadPer + downloadSuccSize + self._hotupdateNeedDownloadSize + self._voiceNeedDownloadSize) / self._totalNeedDownloadSize

	self:setProgressNotFix(totalPer, progressMsg)
end

function HotUpdateProgress:setProgressUnzipOptionPackage(progress, nowPackSize, downloadSuccSize, progressMsg)
	local curSize = self:getHotupdateNeedDownloadSize() + self:getVoiceNeedDownloadSize() + nowPackSize + downloadSuccSize
	local curSizeStr = HotUpdateMgr.fixSizeStr(curSize)
	local progressMsg = string.format(booterLang("unziping_progress_new"), math.floor(100 * progress + 0.5), curSizeStr, self:getTotalNeedDownloadSizeStr())
	local totalPer = (nowPackSize * (HotUpdateProgress.DownloadPer + progress * HotUpdateProgress.UnzipPer) + downloadSuccSize + self._hotupdateNeedDownloadSize + self._voiceNeedDownloadSize) / self._totalNeedDownloadSize

	self:setProgressNotFix(totalPer, progressMsg)
end

function HotUpdateProgress:setProgressCheckRes(percent, progressMsg)
	local totalPer = HotUpdateProgress.CheckResPer * percent

	self:setProgressFix(totalPer, progressMsg)
end

function HotUpdateProgress:setProgressDownloadRes(percent, progressMsg)
	local totalPer = HotUpdateProgress.CheckResPer + HotUpdateProgress.DownloadResPer * percent

	self:setProgressFix(totalPer, progressMsg)
end

HotUpdateProgress.tmp = 0

function HotUpdateProgress:setProgressNotFix(percent, detailMsg)
	percent = math.max(percent, HotUpdateProgress.tmp)
	HotUpdateProgress.tmp = percent
	percent = math.min(percent, 1)

	local progressMsg = UnityEngine.Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork and booterLang("downloading_and_unzip_wifi") or booterLang("downloading_and_unzip")

	if HotUpdateProgress.ShowDetailMsg then
		progressMsg = progressMsg .. "\n" .. detailMsg
	end

	BootLoadingView.instance:show(percent * HotUpdateProgress.NotFixProgress, progressMsg)
end

function HotUpdateProgress:setProgressFix(percent, detailMsg)
	detailMsg = detailMsg or ""
	percent = math.min(percent, 1)

	local progressMsg = UnityEngine.Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork and booterLang("downloading_and_unzip_wifi") or booterLang("downloading_and_unzip")

	progressMsg = percent > HotUpdateProgress.CheckResPer and booterLang("res_fixing") or booterLang("res_checking")

	if HotUpdateProgress.ShowDetailMsg then
		progressMsg = progressMsg .. "\n" .. detailMsg
	end

	BootLoadingView.instance:show(HotUpdateProgress.NotFixProgress + percent * HotUpdateProgress.FixProgress, progressMsg)
end

HotUpdateProgress.instance = HotUpdateProgress.New()

return HotUpdateProgress
