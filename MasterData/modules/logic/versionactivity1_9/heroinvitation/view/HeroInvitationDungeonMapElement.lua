-- chunkname: @modules/logic/versionactivity1_9/heroinvitation/view/HeroInvitationDungeonMapElement.lua

module("modules.logic.versionactivity1_9.heroinvitation.view.HeroInvitationDungeonMapElement", package.seeall)

local HeroInvitationDungeonMapElement = class("HeroInvitationDungeonMapElement", DungeonMapElement)

function HeroInvitationDungeonMapElement:setFinishAndDotDestroy()
	if not self._wenhaoGo then
		self._waitFinishAndDotDestroy = true

		return
	end

	UIBlockHelper.instance:startBlock("DungeonMapSceneTweenPos", 1.6, ViewName.HeroInvitationDungeonMapView)
	self:setWenHaoAnim("finish")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementdisappear)
end

function HeroInvitationDungeonMapElement:_wenHaoAnimDone()
	if self._wenhaoAnimName == "finish" then
		self._sceneElements:onRemoveElementFinish()

		if self:getElementId() == 311114 then
			TaskDispatcher.runDelay(self.delayFinish, self, 1)
		end
	end
end

function HeroInvitationDungeonMapElement:delayFinish()
	ViewMgr.instance:openView(ViewName.HeroInvitationView)
end

function HeroInvitationDungeonMapElement:_onResLoaded()
	HeroInvitationDungeonMapElement.super._onResLoaded(self)

	if self._waitFinishAndDotDestroy then
		self._waitFinishAndDotDestroy = false

		self:setFinishAndDotDestroy()
	end
end

function HeroInvitationDungeonMapElement:onDestroy()
	TaskDispatcher.cancelTask(self.delayFinish, self)
	HeroInvitationDungeonMapElement.super.onDestroy(self)
end

return HeroInvitationDungeonMapElement
