-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementsparkbossbridgeView.lua

module("logic.extensions.elementspark.view.ElementsparkbossbridgeView", package.seeall)

local ElementsparkbossbridgeView = class("ElementsparkbossbridgeView", ViewComponent)

function ElementsparkbossbridgeView:ctor()
	ElementsparkbossbridgeView.super.ctor(self)
end

function ElementsparkbossbridgeView:unbindEvents()
	ElementsparkbossbridgeView.super.unbindEvents(self)
end

function ElementsparkbossbridgeView:bindEvents()
	ElementsparkbossbridgeView.super.bindEvents(self)
end

function ElementsparkbossbridgeView:buildUI()
	ElementsparkbossbridgeView.super.buildUI(self)
end

function ElementsparkbossbridgeView:onExit()
	ElementsparkbossbridgeView.super.onExit(self)
end

function ElementsparkbossbridgeView:onEnter()
	ElementsparkbossbridgeView.super.onEnter(self)

	self._chunkId = self:getFirstParam()

	local belongMe = ElementSparkModel.instance:getChunlBelongMe(self._chunkId)

	if belongMe then
		UIStateManager.instance:push(ViewName.ElementSparkCampView, self._chunkId)
	else
		local isProtect = ElementSparkModel.instance:getChunkInProtect(self._chunkId)

		if isProtect then
			print("ElementsparkbossbridgeView:地块属于保护期 无法进入boss界面")
		else
			local planId = ElementSparkController.instance:getMapPlanId()
			local chunkCfg = ElementSparkConfig.instance:getMapChunkCfgById(planId, self._chunkId)
			local hasBelongMe, isInprotect = ElementSparkSceneController.instance:_hasChunkBelongMeAround(chunkCfg)

			if hasBelongMe then
				UIStateManager.instance:push(ViewName.ElementSparkBossView, chunkCfg.chunkId)
			elseif isInprotect then
				print("ElementsparkbossbridgeView:相邻地块正处于保护期,暂时无法攻打")
			else
				print("ElementsparkbossbridgeView:己方阵营暂未占领相邻地块,暂时无法攻打")
			end
		end
	end

	self:close()
end

return ElementsparkbossbridgeView
