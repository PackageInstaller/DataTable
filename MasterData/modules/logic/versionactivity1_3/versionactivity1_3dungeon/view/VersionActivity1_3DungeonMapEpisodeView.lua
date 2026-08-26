-- chunkname: @modules/logic/versionactivity1_3/versionactivity1_3dungeon/view/VersionActivity1_3DungeonMapEpisodeView.lua

module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3DungeonMapEpisodeView", package.seeall)

local VersionActivity1_3DungeonMapEpisodeView = class("VersionActivity1_3DungeonMapEpisodeView", VersionActivity1_3DungeonBaseEpisodeView)

function VersionActivity1_3DungeonMapEpisodeView:_editableInitView()
	VersionActivity1_3DungeonMapEpisodeView.super._editableInitView(self)

	self._txtunlocktime = gohelper.findChildText(self.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#go_hardModeLock/#txt_unlockTime")
	self.goScrollRect = gohelper.findChild(self.viewGO, "#scroll_content")

	recthelper.setAnchorY(self.goScrollRect.transform, -240)
end

function VersionActivity1_3DungeonMapEpisodeView:refreshModeNode()
	VersionActivity1_3DungeonMapEpisodeView.super.refreshModeNode(self)
	self:refreshModeLockText()
end

function VersionActivity1_3DungeonMapEpisodeView:refreshModeLockText()
	local openTimeStamp = VersionActivityConfig.instance:getAct113DungeonChapterOpenTimeStamp(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBeiHard)
	local serverTime = ServerTime.now()

	if serverTime < openTimeStamp then
		local timeStampOffset = openTimeStamp - serverTime
		local day = Mathf.Floor(timeStampOffset / TimeUtil.OneDaySecond)
		local hourSecond = timeStampOffset % TimeUtil.OneDaySecond
		local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)
		local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity1_3Enum.ActivityId.Dungeon]

		if day > 0 then
			local tempStr = actInfoMo:getRemainTimeStr2(timeStampOffset)

			if hour > 0 then
				tempStr = tempStr .. hour .. luaLang("time_hour2")
			end

			self._txtunlocktime.text = string.format(luaLang("seasonmainview_timeopencondition"), tempStr)
		else
			self._txtunlocktime.text = string.format(luaLang("seasonmainview_timeopencondition"), actInfoMo:getRemainTimeStr2(timeStampOffset))
		end

		gohelper.setActive(self._gohardmodelock, true)
		gohelper.setActive(self._gohardmodeNormal, true)
		gohelper.setActive(self._gohardmodeSelect, false)

		return
	end

	local isOpen, unLockEpisodeId = DungeonModel.instance:chapterIsUnLock(self.activityDungeonMo.activityDungeonConfig.hardChapterId)

	if not isOpen then
		local episodeConfig = DungeonConfig.instance:getEpisodeCO(unLockEpisodeId)

		self._txtunlocktime.text = string.format(luaLang("versionactivity1_3_hardlocktip"), "JMP-" .. DungeonConfig.instance:getChapterEpisodeIndexWithSP(episodeConfig.chapterId, unLockEpisodeId))

		gohelper.setActive(self._gohardmodelock, true)
		gohelper.setActive(self._gohardmodeNormal, true)
		gohelper.setActive(self._gohardmodeSelect, false)

		return
	end

	gohelper.setActive(self._gohardmodelock, false)
end

return VersionActivity1_3DungeonMapEpisodeView
