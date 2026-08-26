-- chunkname: @modules/logic/versionactivity/view/VersionActivityDungeonMapEpisodeView.lua

module("modules.logic.versionactivity.view.VersionActivityDungeonMapEpisodeView", package.seeall)

local VersionActivityDungeonMapEpisodeView = class("VersionActivityDungeonMapEpisodeView", VersionActivityDungeonBaseEpisodeView)

function VersionActivityDungeonMapEpisodeView:_editableInitView()
	VersionActivityDungeonMapEpisodeView.super._editableInitView(self)

	self._txtunlocktime = gohelper.findChildText(self.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#go_hardModeLock/#txt_unlockTime")
	self.goScrollRect = gohelper.findChild(self.viewGO, "#scroll_content")

	recthelper.setAnchorY(self.goScrollRect.transform, -240)
end

function VersionActivityDungeonMapEpisodeView:refreshModeNode()
	VersionActivityDungeonMapEpisodeView.super.refreshModeNode(self)
	self:refreshModeLockText()
end

function VersionActivityDungeonMapEpisodeView:refreshModeLockText()
	local openTimeStamp = VersionActivityConfig.instance:getAct113DungeonChapterOpenTimeStamp(VersionActivityEnum.DungeonChapterId.LeiMiTeBeiHard)
	local serverTime = ServerTime.now()

	if serverTime < openTimeStamp then
		local timeStampOffset = openTimeStamp - serverTime
		local day = Mathf.Floor(timeStampOffset / TimeUtil.OneDaySecond)
		local hourSecond = timeStampOffset % TimeUtil.OneDaySecond
		local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)

		if day == 0 and hour == 0 then
			local minuteSecond = hourSecond % TimeUtil.OneHourSecond
			local minute = Mathf.Ceil(minuteSecond / TimeUtil.OneMinuteSecond)

			self._txtunlocktime.text = string.format(luaLang("lei_mi_te_bei_dungeon_time2"), minute)
		else
			self._txtunlocktime.text = string.format(luaLang("lei_mi_te_bei_dungeon_time1"), day, hour)
		end

		gohelper.setActive(self._gohardmodelock, true)
		gohelper.setActive(self._gohardmodeNormal, true)
		gohelper.setActive(self._gohardmodeSelect, false)

		return
	end

	local isOpen, unLockEpisodeId = DungeonModel.instance:chapterIsUnLock(self.activityDungeonMo.activityDungeonConfig.hardChapterId)

	if not isOpen then
		self._txtunlocktime.text = string.format(luaLang("lei_mi_te_bei_dungeon"), DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(unLockEpisodeId))

		gohelper.setActive(self._gohardmodelock, true)
		gohelper.setActive(self._gohardmodeNormal, true)
		gohelper.setActive(self._gohardmodeSelect, false)

		return
	end

	gohelper.setActive(self._gohardmodelock, false)
end

return VersionActivityDungeonMapEpisodeView
