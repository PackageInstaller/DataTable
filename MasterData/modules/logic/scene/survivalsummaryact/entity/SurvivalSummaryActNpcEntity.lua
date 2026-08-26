-- chunkname: @modules/logic/scene/survivalsummaryact/entity/SurvivalSummaryActNpcEntity.lua

module("modules.logic.scene.survivalsummaryact.entity.SurvivalSummaryActNpcEntity", package.seeall)

local SurvivalSummaryActNpcEntity = class("SurvivalSummaryActNpcEntity", LuaCompBase)

function SurvivalSummaryActNpcEntity.Create(resPath, root, pos, dir)
	if dir == nil then
		dir = math.random(0, 5)
	end

	local go = gohelper.create3d(root, tostring(pos))
	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(pos.q, pos.r)
	local rootTrans = go.transform

	transformhelper.setLocalPos(rootTrans, x, y, z)
	transformhelper.setLocalRotation(rootTrans, 0, dir * 60, 0)

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalSummaryActNpcEntity, resPath)
end

function SurvivalSummaryActNpcEntity:ctor(resPath)
	self.resPath = resPath
end

function SurvivalSummaryActNpcEntity:onStart()
	self.go:GetComponent(typeof(SLFramework.LuaMonobehavier)).enabled = false
end

function SurvivalSummaryActNpcEntity:init(go)
	self.go = go
	self.transform = go.transform

	local asset = SurvivalMapHelper.instance:getBlockRes(self.resPath)

	self.goModel = gohelper.clone(asset, go)

	self:_onResLoadEnd()
end

function SurvivalSummaryActNpcEntity:_onResLoadEnd()
	local trans = self.goModel.transform

	transformhelper.setLocalPos(trans, 0, 0, 0)
	transformhelper.setLocalRotation(trans, 0, 0, 0)
	transformhelper.setLocalScale(trans, 1, 1, 1)
	gohelper.setActive(self.goModel, true)
end

function SurvivalSummaryActNpcEntity:dispose()
	if not gohelper.isNil(self.go) then
		gohelper.destroy(self.go)
	end
end

return SurvivalSummaryActNpcEntity
