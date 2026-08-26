-- chunkname: @modules/logic/scene/survivalsummaryact/entity/SurvivalSummaryActPlayerEntity.lua

module("modules.logic.scene.survivalsummaryact.entity.SurvivalSummaryActPlayerEntity", package.seeall)

local SurvivalSummaryActPlayerEntity = class("SurvivalSummaryActPlayerEntity", LuaCompBase)

function SurvivalSummaryActPlayerEntity.Create(pos, dir, root)
	local go = gohelper.create3d(root, tostring(pos))
	local param = {
		pos = pos,
		dir = dir
	}

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalSummaryActPlayerEntity, param)
end

function SurvivalSummaryActPlayerEntity:ctor(param)
	self.pos = param.pos
	self.dir = param.dir
end

function SurvivalSummaryActPlayerEntity:init(go)
	self.go = go
	self.trans = go.transform

	local survivalShelterRoleMo = SurvivalShelterModel.instance:getWeekInfo().survivalShelterRoleMo
	local roleRes = survivalShelterRoleMo:getRoleModelRes()
	local scene = SurvivalMapHelper.instance:getScene()
	local asset = scene.preloader:getRes(roleRes)

	self.goModel = gohelper.clone(asset, go)

	self:_onResLoadEnd()
end

function SurvivalSummaryActPlayerEntity:_onResLoadEnd()
	self._anim = gohelper.findChildAnim(self.go, "")

	self:playAnim("idle")

	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(self.pos.q, self.pos.r)

	transformhelper.setLocalPos(self.trans, x, y, z)
	transformhelper.setLocalRotation(self.trans, 0, self.dir * 60, 0)
end

function SurvivalSummaryActPlayerEntity:playAnim(animName)
	self._curAnimName = animName

	if self._anim and self._anim.isActiveAndEnabled then
		self._anim:Play(animName, 0, 0)
	end
end

return SurvivalSummaryActPlayerEntity
