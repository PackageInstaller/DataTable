-- chunkname: @modules/logic/partygame/view/collatingsort/CollatingSortGameViewContainer.lua

module("modules.logic.partygame.view.collatingsort.CollatingSortGameViewContainer", package.seeall)

local CollatingSortGameViewContainer = class("CollatingSortGameViewContainer", SceneGameCommonViewContainer)

function CollatingSortGameViewContainer:getGameView()
	local views = {}

	table.insert(views, CollatingSortGameView.New())

	return views
end

function CollatingSortGameViewContainer:getBallPool()
	if not self._ballPool then
		local maxCount = 116

		self._ballPool = LuaObjPool.New(maxCount, function()
			local itemRes = self:getSetting().otherRes.collatingsort_gameball
			local itemGo = self:getResInst(itemRes)
			local ballItem = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, CollatingSortGameBallItem)

			recthelper.setAnchorX(ballItem.viewGO.transform, 10000)

			return ballItem
		end, function(ballItem)
			gohelper.destroy(ballItem.viewGO)
		end, function(ballItem)
			ballItem:cancelUpdateRotation()
			recthelper.setAnchorX(ballItem.viewGO.transform, 10000)
		end)
	end

	return self._ballPool
end

function CollatingSortGameViewContainer:getEffectPool()
	if not self._effectPool then
		local maxCount = 116

		self._effectPool = LuaObjPool.New(maxCount, function()
			local itemRes = self:getSetting().otherRes.collatingsort_gameeffect

			return (self:getResInst(itemRes))
		end, function(itemGo)
			gohelper.destroy(itemGo)
		end, function(itemGo)
			gohelper.setActive(itemGo, false)
		end)
	end

	return self._effectPool
end

function CollatingSortGameViewContainer:onContainerDestroy()
	if self._ballPool then
		self._ballPool:dispose()

		self._ballPool = nil
	end

	if self._effectPool then
		self._effectPool:dispose()

		self._effectPool = nil
	end
end

return CollatingSortGameViewContainer
