-- chunkname: @modules/logic/versionactivity1_4/act130/view/Activity130DungeonChange.lua

module("modules.logic.versionactivity1_4.act130.view.Activity130DungeonChange", package.seeall)

local Activity130DungeonChange = class("Activity130DungeonChange", BaseView)

function Activity130DungeonChange:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity130DungeonChange:addEvents()
	return
end

function Activity130DungeonChange:removeEvents()
	return
end

function Activity130DungeonChange:onUpdateParam()
	return
end

function Activity130DungeonChange:_editableInitView()
	return
end

function Activity130DungeonChange:onOpen()
	self:_addEvents()

	self._changeRoot = gohelper.findChild(self.viewGO, "#go_dungeonchange")

	local path = self.viewContainer:getSetting().otherRes[2]

	self._changeGo = self:getResInst(path, self._changeRoot)
	self._changeAnimator = self._changeGo:GetComponent(typeof(UnityEngine.Animator))
	self._changeAnimatorPlayer = SLFramework.AnimatorPlayer.Get(self._changeGo)

	gohelper.setActive(self._changeRoot, false)
end

function Activity130DungeonChange:onClose()
	return
end

function Activity130DungeonChange:_onNewUnlockChangeLevelScene()
	local newEpisode = Activity130Model.instance:getNewUnlockEpisode()

	if newEpisode > -1 then
		self:_onChangeLevelScene(newEpisode)
	end
end

function Activity130DungeonChange:_onChangeLevelScene(episodeId)
	local curEpisodeId = Activity130Model.instance:getCurEpisodeId()

	if curEpisodeId > 4 and episodeId > 4 then
		return
	end

	if curEpisodeId < 5 and episodeId < 5 then
		return
	end

	local actId = VersionActivity1_4Enum.ActivityId.Role37

	if curEpisodeId < 1 then
		if not Activity130Enum.lvSceneType.Light then
			local curSceneType = Activity130Config.instance:getActivity130EpisodeCo(actId, curEpisodeId).lvscene

			if episodeId < 1 then
				self._toSceneType = Activity130Enum.lvSceneType.Light or Activity130Config.instance:getActivity130EpisodeCo(actId, episodeId).lvscene
			end

			gohelper.setActive(self._changeRoot, true)

			if self._toSceneType == Activity130Enum.lvSceneType.Light then
				self._changeAnimator:Play("to_sun", 0, 0)

				if self._toSceneType ~= curSceneType then
					TaskDispatcher.runDelay(self._startChangeScene, self, 0.17)
				end
			elseif self._toSceneType == Activity130Enum.lvSceneType.Moon then
				self._changeAnimator:Play("to_moon", 0, 0)

				if self._toSceneType ~= curSceneType then
					TaskDispatcher.runDelay(self._startChangeScene, self, 0.17)
				end
			end
		end
	end
end

function Activity130DungeonChange:_startChangeScene()
	self.viewContainer:changeLvScene(self._toSceneType)
	TaskDispatcher.runDelay(self._aniFinished, self, 0.83)
end

function Activity130DungeonChange:_aniFinished()
	gohelper.setActive(self._changeRoot, false)
end

function Activity130DungeonChange:_addEvents()
	return
end

function Activity130DungeonChange:_removeEvents()
	return
end

function Activity130DungeonChange:onDestroyView()
	self:_removeEvents()
end

return Activity130DungeonChange
