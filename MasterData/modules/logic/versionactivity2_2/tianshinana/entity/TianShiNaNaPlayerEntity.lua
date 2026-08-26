-- chunkname: @modules/logic/versionactivity2_2/tianshinana/entity/TianShiNaNaPlayerEntity.lua

module("modules.logic.versionactivity2_2.tianshinana.entity.TianShiNaNaPlayerEntity", package.seeall)

local TianShiNaNaPlayerEntity = class("TianShiNaNaPlayerEntity", TianShiNaNaUnitEntityBase)

function TianShiNaNaPlayerEntity:onMoving()
	if not self.trans then
		return
	end

	local localPos = self:getLocalPos()

	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.PlayerMove, localPos)
end

function TianShiNaNaPlayerEntity:updatePosAndDir()
	TianShiNaNaPlayerEntity.super.updatePosAndDir(self)
	self:onMoving()
end

function TianShiNaNaPlayerEntity:onResLoaded()
	self._anim = self._resGo:GetComponent(typeof(UnityEngine.Animator))
end

function TianShiNaNaPlayerEntity:reAdd()
	if self._anim then
		self._anim:Play("open", 0, 1)
	end
end

function TianShiNaNaPlayerEntity:playCloseAnim()
	if self._anim then
		self._anim:Play("close", 0, 0)
	end
end

return TianShiNaNaPlayerEntity
