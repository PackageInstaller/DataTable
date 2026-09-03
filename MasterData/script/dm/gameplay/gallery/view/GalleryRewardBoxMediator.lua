-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/view/GalleryRewardBoxMediator.lua

require("dm.gameplay.popup.BaseRewardBoxMediator")

GalleryRewardBoxMediator = class("GalleryRewardBoxMediator", BaseRewardBoxMediator, _M)

function GalleryRewardBoxMediator:initialize()
	super.initialize(self)
end

function GalleryRewardBoxMediator:dispose()
	super.dispose(self)
end

function GalleryRewardBoxMediator:onRegister()
	super.onRegister(self)
end

function GalleryRewardBoxMediator:setupView(data)
	super.setupView(self, data)

	local rewardId = data.rewardId
	local rewards = RewardSystem:getRewardsById(rewardId)

	if rewards then
		self:addRewardIcons(rewards)
	end

	self._sureBtn:setVisible(true)
end
