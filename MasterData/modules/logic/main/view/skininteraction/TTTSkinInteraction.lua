-- chunkname: @modules/logic/main/view/skininteraction/TTTSkinInteraction.lua

module("modules.logic.main.view.skininteraction.TTTSkinInteraction", package.seeall)

local TTTSkinInteraction = class("TTTSkinInteraction", BaseSkinInteraction)

function TTTSkinInteraction:_onInit()
	self._tvOff = false
	self._closeEffectList = nil
end

function TTTSkinInteraction:isPlayingVoice()
	return self._tvOff
end

function TTTSkinInteraction:onCloseFullView()
	self:_openTv()
end

function TTTSkinInteraction:_onClick(pos)
	if not self:_checkPosInBound(pos) then
		return
	end

	self._lightSpine = self._view._lightSpine

	local closeProb = CommonConfig.instance:getConstNum(ConstEnum.TTTCloseTv) / 100

	if not self._tvOff and closeProb > math.random() then
		local go = self._lightSpine:getSpineGo()

		self._tvOff = true

		TaskDispatcher.cancelTask(self._hideCloseEffects, self)

		self._closeEffectList = self._closeEffectList or self._view:getUserDataTb_()

		local mountroot = gohelper.findChild(go, "mountroot")
		local transform = mountroot.transform
		local childCount = transform.childCount

		for i = 1, childCount do
			local child = transform:GetChild(i - 1)

			for j = 1, child.childCount do
				local effectGo = child:GetChild(j - 1)

				if string.find(effectGo.name, "close") then
					gohelper.setActive(effectGo.gameObject, true)

					self._closeEffectList[i] = effectGo.gameObject
				else
					gohelper.setActive(effectGo.gameObject, false)
				end
			end
		end

		if self._lightSpine then
			self._lightSpine:stopVoice()
		end

		return
	end

	if self:_openTv() then
		return
	end

	self:_clickDefault(pos)
end

function TTTSkinInteraction:_openTv()
	if self._tvOff then
		self._tvOff = false

		local go = self._lightSpine:getSpineGo()

		TaskDispatcher.cancelTask(self._hideCloseEffects, self)
		TaskDispatcher.runDelay(self._hideCloseEffects, self, 0.2)

		local mountroot = gohelper.findChild(go, "mountroot")
		local transform = mountroot.transform
		local childCount = transform.childCount

		for i = 1, childCount do
			local child = transform:GetChild(i - 1)

			for j = 1, child.childCount do
				local effectGo = child:GetChild(j - 1)

				if not string.find(effectGo.name, "close") then
					gohelper.setActive(effectGo.gameObject, true)
				end
			end
		end

		return true
	end
end

function TTTSkinInteraction:_hideCloseEffects()
	for i, v in pairs(self._closeEffectList) do
		gohelper.setActive(v, false)
	end
end

function TTTSkinInteraction:_onDestroy()
	TaskDispatcher.cancelTask(self._hideCloseEffects, self)

	self._closeEffectList = nil
	self._lightSpine = nil
end

return TTTSkinInteraction
