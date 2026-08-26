-- chunkname: @modules/logic/versionactivity2_2/tianshinana/entity/TianShiNaNaHunterEntity.lua

module("modules.logic.versionactivity2_2.tianshinana.entity.TianShiNaNaHunterEntity", package.seeall)

local TianShiNaNaHunterEntity = class("TianShiNaNaHunterEntity", TianShiNaNaUnitEntityBase)

function TianShiNaNaHunterEntity:updateMo(unitMo)
	local arr = string.splitToNumber(unitMo.co.specialData, "#")

	if arr then
		self._range = arr[1] or 0
	end

	TianShiNaNaHunterEntity.super.updateMo(self, unitMo)
end

function TianShiNaNaHunterEntity:onResLoaded()
	local root = gohelper.findChild(self._resGo, "vx_warn")

	gohelper.setActive(root, true)

	if root then
		self._rootAnim = root:GetComponent(typeof(UnityEngine.Animator))
	end

	self:checkActive()
end

function TianShiNaNaHunterEntity:addEventListeners()
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.CubePointUpdate, self.checkActive, self)
end

function TianShiNaNaHunterEntity:removeEventListeners()
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.CubePointUpdate, self.checkActive, self)
end

function TianShiNaNaHunterEntity:willActive()
	for _, point in pairs(TianShiNaNaModel.instance.curPointList) do
		if TianShiNaNaHelper.getMinDis(point.x, point.y, self._unitMo.x, self._unitMo.y) <= self._range then
			return true
		end
	end

	return false
end

function TianShiNaNaHunterEntity:checkActive()
	if not self._rootAnim then
		return
	end

	if not self._unitMo.isActive then
		local isActive = self:willActive()

		if isActive == self._isActive then
			return
		end

		self._isActive = isActive

		if isActive then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TianShiNaNa.play_ui_youyu_warn)
			self._rootAnim:Play("warn_red", 0, 0)
		else
			self._rootAnim:Play("warn_open", 0, 0)
		end
	end
end

return TianShiNaNaHunterEntity
