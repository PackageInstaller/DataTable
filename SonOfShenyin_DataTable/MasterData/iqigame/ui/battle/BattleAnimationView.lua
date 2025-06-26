-- chunkname: @IQIGame\\UI\\Battle\\BattleAnimationView.lua

local BattleAnimationView = {}

function BattleAnimationView.New(animations)
	local o = Clone(BattleAnimationView)

	o:Initialize(animations)

	return o
end

function BattleAnimationView:Initialize(animations)
	self.animations = animations

	self:InitDelegates()
	self:OnAddListeners()
end

function BattleAnimationView:InitDelegates()
	function self.delegatePlayBattleUIAnimation(name)
		self:PlayBattleUIAnimation(name)
	end

	function self.delegateOnTimelineStopped(playableDirector)
		self:OnTimelineCompleted(playableDirector)
	end
end

function BattleAnimationView:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.PlayBattleUIAnimation, self.delegatePlayBattleUIAnimation)

	for _, animation in pairs(self.animations) do
		animation.stopped = animation.stopped + self.delegateOnTimelineStopped
	end
end

function BattleAnimationView:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.PlayBattleUIAnimation, self.delegatePlayBattleUIAnimation)

	for _, playableDirector in pairs(self.animations) do
		playableDirector.stopped = playableDirector.stopped - self.delegateOnTimelineStopped
	end
end

function BattleAnimationView:Dispose()
	self:OnRemoveListeners()
	self:StopAllAnimations()
end

function BattleAnimationView:OnTimelineCompleted(completePlayableDirector)
	for uiAnimationName, playableDirector in pairs(self.animations) do
		if playableDirector == completePlayableDirector then
			EventDispatcher.Dispatch(EventID.BattleUIAnimationComplete, uiAnimationName)

			break
		end
	end
end

function BattleAnimationView:PlayBattleUIAnimation(name)
	self.animations[name].gameObject:SetActive(true)
	self.animations[name]:Play()
end

function BattleAnimationView:StopAllAnimations()
	for _, playableDirector in pairs(self.animations) do
		playableDirector:Stop()
		playableDirector.gameObject:SetActive(false)
	end
end

return BattleAnimationView
