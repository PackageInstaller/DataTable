-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/view/entity/MaLiAnNaSoliderHeroEntity.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.entity.MaLiAnNaSoliderHeroEntity", package.seeall)

local MaLiAnNaSoliderHeroEntity = class("MaLiAnNaSoliderHeroEntity", MaLiAnNaSoliderEntity)

function MaLiAnNaSoliderHeroEntity:init(go)
	MaLiAnNaSoliderHeroEntity.super.init(self, go)

	self._hpGo = gohelper.findChild(go, "hp")
	self._hpGoTr = self._hpGo.transform
	self._txtHp = gohelper.findChildText(go, "hp/#txt_hp")
end

function MaLiAnNaSoliderHeroEntity:initSoliderInfo(soliderMo)
	MaLiAnNaSoliderHeroEntity.super.initSoliderInfo(self, soliderMo)
	gohelper.setActive()
end

function MaLiAnNaSoliderHeroEntity:setHide(isHide)
	local state = MaLiAnNaSoliderHeroEntity.super.setHide(self, isHide)

	if not state then
		return
	end

	if gohelper.isNil(self._hpGo) then
		return false
	end

	gohelper.setActive(self._hpGo, isHide)

	return true
end

function MaLiAnNaSoliderHeroEntity:onUpdate()
	local state = MaLiAnNaSoliderHeroEntity.super.onUpdate(self)

	if state then
		local hp = self._soliderMo:getHp()

		if self._lastHp == nil or self._lastHp ~= hp then
			self._txtHp.text = self._soliderMo:getHp()
			self._lastHp = hp
		end
	end
end

function MaLiAnNaSoliderHeroEntity:_onResLoadEnd()
	MaLiAnNaSoliderHeroEntity.super._onResLoadEnd(self)

	local head = gohelper.findChild(self.goSpine, "mountroot/mounthead")
	local headTr = head.transform
	local x, y, z = transformhelper.getLocalPos(headTr)

	if y <= 0 then
		return
	end

	local pos = self._tr:InverseTransformPoint(headTr.position)

	y = pos.y
	y = pos.y + 40

	transformhelper.setLocalPos(self._hpGoTr, pos.x, pos.y + 40, pos.z)
end

function MaLiAnNaSoliderHeroEntity:getSpineLocalPos()
	return 0, 8, 0
end

return MaLiAnNaSoliderHeroEntity
