-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity_1_2_StoryClueLineWork.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_StoryClueLineWork", package.seeall)

local VersionActivity_1_2_StoryClueLineWork = class("VersionActivity_1_2_StoryClueLineWork", BaseWork)

function VersionActivity_1_2_StoryClueLineWork:ctor(lineTransform, toValue, duration, clueId)
	self._lineTransform = lineTransform
	self._toValue = toValue
	self._duration = duration
	self._clueId = clueId
end

function VersionActivity_1_2_StoryClueLineWork:onStart()
	VersionActivity1_2DungeonController.instance:registerCallback(VersionActivity1_2DungeonEvent.skipLineWork, self._skipLineWork, self)

	self._tweenId = ZProj.TweenHelper.DOWidth(self._lineTransform, self._toValue, self._duration, self._onTweenEnd, self)

	local name

	for i = 1, 4 do
		if VersionActivity_1_2_StoryCollectView._signTypeName[self._clueId] == VersionActivity_1_2_StoryCollectView._signTypeName[i] then
			name = "play_ui_lvhu_clue_write_" .. i
		end
	end

	if name then
		AudioMgr.instance:trigger(AudioEnum.UI[name])
	end
end

function VersionActivity_1_2_StoryClueLineWork:_skipLineWork()
	self:onDone(true)
	recthelper.setWidth(self._lineTransform, self._toValue)
end

function VersionActivity_1_2_StoryClueLineWork:_onTweenEnd()
	self:onDone(true)
end

function VersionActivity_1_2_StoryClueLineWork:clearWork()
	VersionActivity1_2DungeonController.instance:unregisterCallback(VersionActivity1_2DungeonEvent.skipLineWork, self._skipLineWork, self)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

return VersionActivity_1_2_StoryClueLineWork
