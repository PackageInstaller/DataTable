-- chunkname: @modules/common/others/LuaListScrollViewWithAnimation.lua

module("modules.common.others.LuaListScrollViewWithAnimation", package.seeall)

local LuaListScrollViewWithAnimation = class("LuaListScrollViewWithAnimation", LuaListScrollView)

function LuaListScrollViewWithAnimation:ctor(scrollModel, listScrollParam, animationDelayTimes)
	LuaListScrollViewWithAnimation.super.ctor(self, scrollModel, listScrollParam)

	self._animationDelayTimes = animationDelayTimes
	self._animationHasPlayed = {}
end

function LuaListScrollViewWithAnimation:_onUpdateCell(cellGO, index)
	LuaListScrollViewWithAnimation.super._onUpdateCell(self, cellGO, index)

	local prefabInstGO = gohelper.findChild(cellGO, LuaListScrollView.PrefabInstName)

	if not prefabInstGO then
		return
	end

	local cellComp = MonoHelper.getLuaComFromGo(prefabInstGO, self._param.cellClass)

	if self._animationDelayTimes then
		if not self._animationDelayTimes then
			return
		end

		if self._animationHasPlayed[cellComp._index] then
			return
		end

		if cellComp.getAnimation then
			local animation, animationName = cellComp:getAnimation()

			if animation and not string.nilorempty(animationName) then
				local canvasGroup = cellComp.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))

				if canvasGroup then
					canvasGroup.alpha = 0
				end
			end
		end
	end
end

function LuaListScrollViewWithAnimation:onUpdateFinish()
	for cellComp, _ in pairs(self._cellCompDict) do
		if self._animationDelayTimes then
			if self._animationDelayTimes and not self._animationHasPlayed[cellComp._index] then
				TaskDispatcher.runDelay(LuaListScrollViewWithAnimation._delayPlayOpenAnimation, cellComp, self._animationDelayTimes)

				self._animationHasPlayed[cellComp._index] = true
			end
		end
	end
end

function LuaListScrollViewWithAnimation._delayPlayOpenAnimation(cellComp)
	if cellComp.getAnimation then
		local animation, animationName = cellComp:getAnimation()

		if animation and not string.nilorempty(animationName) then
			animation:Play(animationName)
		end
	end
end

function LuaListScrollViewWithAnimation:onClose()
	LuaListScrollViewWithAnimation.super.onClose(self)

	for cellComp, _ in pairs(self._cellCompDict) do
		TaskDispatcher.cancelTask(LuaListScrollViewWithAnimation._delayPlayOpenAnimation, cellComp)
	end
end

return LuaListScrollViewWithAnimation
