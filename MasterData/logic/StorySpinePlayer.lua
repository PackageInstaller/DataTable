-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StorySpinePlayer.lua

module("logic.extensions.story.view.StorySpinePlayer", package.seeall)

local StorySpinePlayer = class("StorySpinePlayer")

function StorySpinePlayer:ctor()
	return
end

function StorySpinePlayer:setSpine(skeletonAnimation, actions, flipX)
	self._skeletonAnimation = skeletonAnimation
	self._actions = actions
	self._allAnims = nil

	if self._skeletonAnimation and self._skeletonAnimation.Skeleton then
		self._spineEventHandler = goutil.addComponentOnce(skeletonAnimation.gameObject, typeof(Spine.SpineActionEventHandler))
		self._skeletonAnimation.Skeleton.FlipX = flipX

		self:_start()
	end
end

function StorySpinePlayer:_start()
	if self._skeletonAnimation then
		if not self._actions or #self._actions == 0 then
			self:_playAnim("idle", true)

			self._currAction = nil
			self._actionCount = nil
		else
			self._currAction = 1
			self._actionCount = #self._actions

			self._spineEventHandler:AddActionEventListener(self._onSpineEvent, self)
			self:_playAnim(self._actions[self._currAction], self._currAction == self._actionCount)
		end
	end
end

function StorySpinePlayer:resetAnim(animState)
	if self.needResetOnStart and self._skeletonAnimation and self._skeletonAnimation.AnimationName == animState and self._skeletonAnimation.AnimationName ~= "idle" then
		self._skeletonAnimation.AnimationName = nil
	end
end

function StorySpinePlayer:stop()
	self._actions = nil
	self.disableForceAnim = nil
	self._currAction = nil
	self._actionCount = nil
	self._skeletonAnimation = nil
	self._spineEventHandler = nil
	self._allAnims = nil
end

function StorySpinePlayer:_playAnim(animState, loop)
	if not self._allAnims then
		local animNames = GoUtil.GetAllSpineAnimNames(self._skeletonAnimation.gameObject)

		if animNames then
			self._allAnims = {}

			for i = 0, animNames.Length - 1 do
				self._allAnims[animNames[i]] = true
			end
		end
	end

	if not self._allAnims[animState] then
		animState = "idle"
	end

	animState = string.gsub(animState, "\r", "")
	animState = string.gsub(animState, "\n", "")
	animState = string.gsub(animState, " ", "")

	if self._skeletonAnimation then
		if self._skeletonAnimation.AnimationName == "idle" and animState == "idle" then
			return
		end

		if not self.disableForceAnim and self._currAction == 1 and self._actions and #self._actions > 0 then
			local skelComps = GameUtil.getSpineAnimsComps(self._skeletonAnimation.gameObject)

			if skelComps then
				GameUtil.clearSpineAnimsState(skelComps)
				GameUtil.playSpineAnimsNoFlipX(skelComps, animState, loop, true)
			end
		else
			GameUtil.setSpineAnimsWithGo(self._skeletonAnimation.gameObject, animState, loop)
		end
	end
end

function StorySpinePlayer:_onSpineEvent(actionName, eventName, eventParam)
	if self._skeletonAnimation and self._actions and self._currAction and self._actionCount and actionName == self._actions[self._currAction] and eventName == UnitSpineEvent.ActionComplete and self._currAction < self._actionCount then
		self._currAction = self._currAction + 1

		self:_playAnim(self._actions[self._currAction], self._currAction == self._actionCount)
	end
end

return StorySpinePlayer
