-- chunkname: @modules/logic/scene/survival/entity/SurvivalSpBlockEntity.lua

module("modules.logic.scene.survival.entity.SurvivalSpBlockEntity", package.seeall)

local SurvivalSpBlockEntity = class("SurvivalSpBlockEntity", SurvivalBlockEntity)

function SurvivalSpBlockEntity.Create(unitMo, root)
	local go = gohelper.create3d(root, tostring(unitMo.pos))
	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(unitMo.pos.q, unitMo.pos.r)
	local rootTrans = go.transform

	transformhelper.setLocalPos(rootTrans, x, y, z)
	transformhelper.setLocalRotation(rootTrans, 0, unitMo.dir * 60 + 30, 0)

	if unitMo.co then
		local blockResPath = unitMo:getResPath()
		local blockRes = SurvivalMapHelper.instance:getSpBlockRes(tonumber(unitMo.co.copyIds) or 0, blockResPath)

		if blockRes then
			local blockGo = gohelper.clone(blockRes, go)
			local trans = blockGo.transform

			transformhelper.setLocalPos(trans, 0, 0, 0)
			transformhelper.setLocalRotation(trans, 0, 0, 0)
			transformhelper.setLocalScale(trans, 1, 1, 1)
		else
			logError("加载资源失败！" .. tostring(unitMo.co.copyIds) .. " >> " .. tostring(blockResPath))
		end
	end

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalSpBlockEntity, unitMo)
end

function SurvivalSpBlockEntity:ctor(data)
	self._data = data
end

function SurvivalSpBlockEntity:init(go)
	SurvivalSpBlockEntity.super.init(self, go)

	self._anim = go:GetComponentInChildren(typeof(UnityEngine.Animator))
	self._subType = self._data:getSubType()

	if self._subType == SurvivalEnum.UnitSubType.Block then
		local mapCo = SurvivalMapModel.instance:getCurMapCo()

		mapCo:setWalkByUnitMo(self._data, false)
	end

	self:_onMagmaStatusUpdate()
end

function SurvivalSpBlockEntity:onStart()
	self:_onMagmaStatusUpdate()
end

function SurvivalSpBlockEntity:_onMagmaStatusUpdate()
	if self._subType ~= SurvivalEnum.UnitSubType.Magma then
		return
	end

	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	if self._anim and self._anim.isActiveAndEnabled then
		self._anim:Play("statu" .. sceneMo.sceneProp.magmaStatus)
	end
end

function SurvivalSpBlockEntity:addEventListeners()
	SurvivalSpBlockEntity.super.addEventListeners(self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMagmaStatusUpdate, self._onMagmaStatusUpdate, self)
end

function SurvivalSpBlockEntity:removeEventListeners()
	SurvivalSpBlockEntity.super.removeEventListeners(self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMagmaStatusUpdate, self._onMagmaStatusUpdate, self)
end

function SurvivalSpBlockEntity:tryDestory()
	if self._subType == SurvivalEnum.UnitSubType.Block then
		local mapCo = SurvivalMapModel.instance:getCurMapCo()

		mapCo:setWalkByUnitMo(self._data, true)
		SurvivalMapHelper.instance:addPointEffect(self._data.pos)

		for _, v in ipairs(self._data.exPoints) do
			SurvivalMapHelper.instance:addPointEffect(v)
		end
	end

	gohelper.destroy(self.go)
end

function SurvivalSpBlockEntity:onDestroy()
	SurvivalSpBlockEntity.super.onDestroy(self)
end

return SurvivalSpBlockEntity
