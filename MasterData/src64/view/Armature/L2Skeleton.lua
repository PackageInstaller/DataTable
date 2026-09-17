SP_ANIMATION_START = 0
SP_ANIMATION_END = 2
SP_ANIMATION_COMPLETE = 3
SP_ANIMATION_EVENT = 5
L2Skeleton = class("L2Skeleton", function()
	return cc.Node:create()
end)
L2Skeleton.jsonFilePath = nil
L2Skeleton.atlasFilePath = nil
L2Skeleton.clothesFilePath = nil

function L2Skeleton.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = L2Skeleton.new()

	var_2_0:initL2Skeleton(arg_2_1, arg_2_2, arg_2_3, 1, arg_2_4)

	return var_2_0
end

function L2Skeleton:retain()
	cc.Ref.retain(self)

	self._datarefcount = self._datarefcount + 1

	if self.skeletonData then
		self.skeletonData:retain()
	end
end

function L2Skeleton:release()
	cc.Ref.release(self)

	self._datarefcount = self._datarefcount - 1

	if self.skeletonData then
		self.skeletonData:release()
	end
end

function L2Skeleton:setScale(arg_5_1, arg_5_2)
	arg_5_2 = arg_5_2 or arg_5_1
	self._scaleX = arg_5_1
	self._scaleY = arg_5_2

	self.skeletonAnimation:setScale(arg_5_1, arg_5_2)
end

function L2Skeleton:getAnimationName(arg_6_1)
	if arg_6_1 then
		return self.skeletonAnimation:getAnimationName(arg_6_1)
	else
		return self.skeletonAnimation:getAnimationName()
	end
end

function L2Skeleton:setSpeedScale(arg_7_1)
	self.skeletonAnimation:setTimeScale(arg_7_1)
end

function L2Skeleton:setOpacity(arg_8_1)
	self._opacity = arg_8_1

	self.skeletonAnimation:setOpacity(arg_8_1)
end

function L2Skeleton:setAniVisible(arg_9_1)
	self.skeletonAnimation:setVisible(arg_9_1)
end

function L2Skeleton:pauseAni()
	self.skeletonAnimation:pause()
	self:pause()
end

function L2Skeleton:resumeAni()
	self.skeletonAnimation:resume()
	self:resume()
end

function L2Skeleton:initL2Skeleton(arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	self:initDownload()

	self.skeletonData = nil
	self.jsonFilePath = arg_12_1
	self.atlasFilePath = arg_12_2
	self.clothesFilePath = arg_12_3
	self.scale = arg_12_4 or 1
	self.isremovecache = arg_12_5
	self._datarefcount = 0
	self._nowjsonFilePath = nil
	self._nowatlasFilePath = nil
	self._nowclothesFilePath = nil
	self.lastAniName = nil
	self.lastAniCycled = nil
	self.idle = false
	self._eventhandlers = {}
	self._timescale = 1
	self._scaleX = 1
	self._scaleY = 1
	self._opacity = 255
	self.lockPlay = false
	self.shader = false
	self._showloadingani = false

	self:registerScriptHandler(function(arg_13_0)
		if arg_13_0 == "enter" then
			self._datarefcount = self._datarefcount + 1

			if self.skeletonData then
				self.skeletonData:retain()
			end
		elseif arg_13_0 == "exit" then
			if self._datarefcount > 0 then
				self._datarefcount = self._datarefcount - 1

				if self.skeletonData then
					self.skeletonData:release()
				end
			end

			if self.skeletonAnimation then
				self.skeletonAnimation:removeFromParent()

				self.skeletonAnimation = nil
			end

			if self.isremovecache then
				SpineCacheManager:removeSpineDataForKey(self._nowjsonFilePath, self._nowatlasFilePath, self._nowclothesFilePath)
			end
		end
	end)
end

function L2Skeleton.resetL2Skeleton(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	arg_14_0.jsonFilePath = arg_14_1
	arg_14_0.atlasFilePath = arg_14_2
	arg_14_0.clothesFilePath = arg_14_3
	arg_14_0.scale = arg_14_4 or 1
	arg_14_0.lastAniName = nil
	arg_14_0.lastAniCycled = nil
	arg_14_0.lockPlay = false
	arg_14_0.shader = false
	arg_14_0._eventhandlers = {}
	arg_14_0._timescale = 1
	arg_14_0._scaleX = 1
	arg_14_0._scaleY = 1
	arg_14_0._opacity = 255
end

function L2Skeleton.lock(arg_15_0)
	arg_15_0.lockPlay = true
end

function L2Skeleton.unlock(arg_16_0)
	arg_16_0.lockPlay = false
end

function L2Skeleton:play(arg_17_1, arg_17_2, arg_17_3)
	if self.lockPlay then
		return
	end

	if arg_17_2 == nil then
		arg_17_2 = true
	end

	if arg_17_3 == nil then
		arg_17_3 = true
	end

	self.skeletonAnimation:setAnimation(0, arg_17_1, arg_17_2)

	self.lastAniName = arg_17_1
	self.lastAniCycled = arg_17_2
end

function L2Skeleton:addAnimation(arg_18_1, arg_18_2)
	if arg_18_2 == nil then
		arg_18_2 = true
	end

	self.skeletonAnimation:addAnimation(0, arg_18_1, arg_18_2)

	if self.lastAniName ~= nil then
		self.skeletonAnimation:setMix(self.lastAniName, arg_18_1, 0.1)
	end

	self.lastAniName = arg_18_1
	self.lastAniCycled = arg_18_2
end

function L2Skeleton:clearAnimation(arg_19_1)
	if arg_19_1 then
		self.skeletonAnimation:clearTrack(arg_19_1)
	else
		self.skeletonAnimation:clearTracks()
	end
end

function L2Skeleton:registerListener(arg_20_1, arg_20_2)
	self._eventhandlers[arg_20_1] = arg_20_2

	self.skeletonAnimation:registerSpineEventHandler(arg_20_2, arg_20_1)
end

function L2Skeleton:unregisterListner(arg_21_1)
	self._eventhandlers[arg_21_1] = nil

	self.skeletonAnimation:unregisterSpineEventHandler(arg_21_1)
end

function L2Skeleton.getAnimation(arg_22_0)
	return arg_22_0
end

function L2Skeleton:refreshSkeleton()
	self:checkResource({
		json = self.jsonFilePath,
		atlas = self.atlasFilePath
	})
end

function L2Skeleton:drawSkeleton()
	if self.skeletonAnimation then
		self:removeChild(self.skeletonAnimation)

		self.skeletonAnimation = nil
	end

	if self.skeletonData then
		self.skeletonData:release(self._datarefcount)

		if self.isremovecache then
			SpineCacheManager:removeSpineDataForKey(self._nowjsonFilePath, self._nowatlasFilePath, self._nowclothesFilePath)
		end
	end

	self.skeletonData = SpineCacheManager:addSpineData(self.jsonFilePath, self.atlasFilePath, self.clothesFilePath)

	self.skeletonData:retain(self._datarefcount)

	self.skeletonAnimation = sp.SkeletonAnimation:create(self.skeletonData:getData())

	self:addChild(self.skeletonAnimation)

	self._nowjsonFilePath = self.jsonFilePath
	self._nowatlasFilePath = self.atlasFilePath
	self._nowclothesFilePath = self.clothesFilePath
end

function L2Skeleton:setSlotTexture(arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	if not self.skeletonAnimation then
		return
	end

	arg_25_4 = arg_25_4 or 1

	self.skeletonAnimation:setSlotTexture(arg_25_1, arg_25_2, arg_25_3, arg_25_4, self.skeletonData:getData())
end

function L2Skeleton:setColor(arg_26_1)
	if not arg_26_1 then
		return
	end

	self.skeletonAnimation:setColor(arg_26_1)
end

function L2Skeleton:setBlendFunc(arg_27_1)
	self.skeletonAnimation:setBlendFunc(arg_27_1)
end

function L2Skeleton:playHitEffect(arg_28_1)
	self.skeletonAnimation:playHitEffect(arg_28_1)
end

function L2Skeleton:setTimeScale(arg_29_1)
	self._timescale = arg_29_1

	self.skeletonAnimation:setTimeScale(arg_29_1)
end

function L2Skeleton:getTimeScale()
	return self.skeletonAnimation:getTimeScale()
end

function L2Skeleton:getRootPosition()
	return self.skeletonAnimation:getRootPosition()
end

function L2Skeleton:shaderDark()
	if not self.shader then
		require("controller.l2utils"):shaderDarkNode(self.skeletonAnimation)

		self.shader = true
	end
end

function L2Skeleton:unshaderDark()
	if self.shader then
		require("controller.l2utils"):recoverShader(self.skeletonAnimation)

		self.shader = false
	end
end

function L2Skeleton:changeClothes(arg_34_1)
	self.clothesFilePath = arg_34_1

	if arg_34_1 then
		self.skeletonAnimation:changeClothes()
	else
		self.skeletonAnimation:changeClothes(arg_34_1)
	end
end

function L2Skeleton:isAnimationExist(arg_35_1)
	return self.skeletonAnimation:isAnimationExist(arg_35_1)
end

function L2Skeleton:getBoundingBox()
	return self.skeletonAnimation:getBoundingBox()
end

require("controller.filedownloader.download_node_utils"):addDownloadInterface(L2Skeleton, "Spine")

function L2Skeleton.showLoadingAni(arg_37_0, arg_37_1)
	arg_37_0._showloadingani = arg_37_1
end

function L2Skeleton:onDownloadProcessing()
	if not self._showloadingani then
		return
	end

	if self._loadingani then
		self._loadingani:setVisible(true)
		self._loadingani:play()

		return
	end

	self._loadingani = require("view.Sprite.LoadingSprite"):create()

	self._loadingani:setPosition(cc.p(0, 80))
	self:addChild(self._loadingani)
end

function L2Skeleton:onDownloadComplete(arg_39_1)
	if not arg_39_1 then
		return
	end

	if self._loadingani then
		self._loadingani:stop()
		self._loadingani:setVisible(false)
	end

	self.jsonFilePath = arg_39_1.json
	self.atlasFilePath = arg_39_1.atlas

	self:drawSkeleton()

	if self.lastAniName then
		self:play(self.lastAniName, self.lastAniCycled)
	end

	self:setTimeScale(self._timescale)
	self:setScale(self._scaleX, self._scaleY)
	self:setOpacity(self._opacity)

	if next(self._eventhandlers) then
		for iter_39_0, iter_39_1 in pairs(self._eventhandlers) do
			self.skeletonAnimation:registerSpineEventHandler(iter_39_1, iter_39_0)
		end
	end
end
