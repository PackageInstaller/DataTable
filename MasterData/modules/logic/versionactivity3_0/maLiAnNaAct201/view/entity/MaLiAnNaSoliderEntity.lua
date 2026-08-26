-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/view/entity/MaLiAnNaSoliderEntity.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.entity.MaLiAnNaSoliderEntity", package.seeall)

local MaLiAnNaSoliderEntity = class("MaLiAnNaSoliderEntity", LuaCompBase)

function MaLiAnNaSoliderEntity:ctor()
	return
end

function MaLiAnNaSoliderEntity:init(go)
	self._go = go
	self._tr = go.transform
end

function MaLiAnNaSoliderEntity:getGo()
	return self._go
end

function MaLiAnNaSoliderEntity:initSoliderInfo(soliderMo)
	self._soliderMo = soliderMo

	if self._soliderMo == nil or self._go == nil then
		logError("_go or soliderMo is nil")

		return
	end

	self._go.name = string.format("solider_%s", self._soliderMo:getId())

	self:_updateLocalPos()
	self:showModel()
	self:setVisible(true, true)
end

function MaLiAnNaSoliderEntity:getSoliderMo()
	return self._soliderMo
end

function MaLiAnNaSoliderEntity:onUpdate()
	if Activity201MaLiAnNaGameController.instance:getPause() then
		return false
	end

	if self._soliderMo == nil and not self._isVisible then
		return false
	end

	self:_updateLocalPos()
	self:_updateModelDirByMoveDir()

	return true
end

function MaLiAnNaSoliderEntity:_updateModelDirByMoveDir()
	if self._soliderMo == nil or self.goSpineTr == nil then
		return false
	end

	local moveDirX, _ = self._soliderMo:getMoveDir()
	local x = moveDirX > 0 and -1 or 1

	if self._lastScaleX == nil or self._lastScaleX ~= x then
		local scaleX, scaleY, scaleZ = transformhelper.getLocalScale(self.goSpineTr)

		transformhelper.setLocalScale(self.goSpineTr, math.abs(scaleX) * x, scaleY, scaleZ)

		self._lastScaleX = x

		return true
	end
end

function MaLiAnNaSoliderEntity:_updateLocalPos()
	if self._soliderMo == nil and self._tr == nil then
		return
	end

	local x, y = self._soliderMo:getLocalPos()

	transformhelper.setLocalPosXY(self._tr, x, y)
end

function MaLiAnNaSoliderEntity:setVisible(isVisible, force)
	if self._isVisible == isVisible and not force then
		return false
	end

	if gohelper.isNil(self._go) then
		return false
	end

	self._isVisible = isVisible

	gohelper.setActive(self._go, self._isVisible)

	return true
end

function MaLiAnNaSoliderEntity:setHide(isHide)
	if self._isHideMode == isHide then
		return false
	end

	if gohelper.isNil(self.goSpine) then
		return false
	end

	self._isHideMode = isHide

	gohelper.setActive(self.goSpine, self._isHideMode)

	return true
end

function MaLiAnNaSoliderEntity:isVisible()
	return self._isVisible
end

function MaLiAnNaSoliderEntity:clear()
	self._soliderMo = nil

	self:setVisible(false, true)
end

function MaLiAnNaSoliderEntity:onTriggerEnter(other)
	if self._soliderMo == nil then
		return
	end

	local otherObj = other.gameObject
	local otherComp = MonoHelper.getLuaComFromGo(otherObj, MaLiAnNaSoliderEntity)

	if otherComp ~= nil then
		local otherSoliderMo = otherComp:getSoliderMo()
		local otherCamp = otherSoliderMo:getCamp()
		local myCamp = self._soliderMo:getCamp()

		if otherCamp ~= myCamp then
			Activity201MaLiAnNaGameController.instance:soliderBattle(self._soliderMo, otherSoliderMo)
		else
			local otherState = otherSoliderMo:getCurState()
			local myState = self._soliderMo:getCurState()

			if myState == Activity201MaLiAnNaEnum.SoliderState.Moving and (otherState == Activity201MaLiAnNaEnum.SoliderState.Attack or otherState == Activity201MaLiAnNaEnum.SoliderState.StopMove) then
				otherSoliderMo:setRecordSolider(self._soliderMo)
				otherSoliderMo:changeRecordSoliderState(true)
			end

			if otherState == Activity201MaLiAnNaEnum.SoliderState.Moving then
				otherSoliderMo:changeRecordSoliderState(false)
			end
		end
	end
end

function MaLiAnNaSoliderEntity:onTriggerExit(other)
	if self._soliderMo == nil then
		return
	end

	local otherObj = other.gameObject
	local otherComp = MonoHelper.getLuaComFromGo(otherObj, MaLiAnNaSoliderEntity)

	if otherComp ~= nil then
		local otherSoliderMo = otherComp:getSoliderMo()
		local otherCamp = otherSoliderMo:getCamp()
		local myCamp = self._soliderMo:getCamp()

		if otherCamp ~= myCamp then
			Activity201MaLiAnNaGameController.instance:soliderBattle(self._soliderMo, otherSoliderMo)
		else
			local otherState = otherSoliderMo:getCurState()
			local myState = self._soliderMo:getCurState()

			if myState == Activity201MaLiAnNaEnum.SoliderState.Moving and (otherState == Activity201MaLiAnNaEnum.SoliderState.Attack or otherState == Activity201MaLiAnNaEnum.SoliderState.StopMove) then
				otherSoliderMo:setRecordSolider(self._soliderMo)
				otherSoliderMo:changeRecordSoliderState(true)
			end

			if otherState == Activity201MaLiAnNaEnum.SoliderState.Moving then
				otherSoliderMo:changeRecordSoliderState(false)
			end
		end
	end
end

function MaLiAnNaSoliderEntity:getResPath()
	local config = self._soliderMo:getConfig()

	return config.resource
end

function MaLiAnNaSoliderEntity:showModel()
	if not gohelper.isNil(self.goSpine) then
		return
	end

	if self._loader then
		return
	end

	self._loader = PrefabInstantiate.Create(self._go)

	local path = self:getResPath()

	if string.nilorempty(path) then
		return
	end

	self._loader:startLoad(path, self._onResLoadEnd, self)
end

function MaLiAnNaSoliderEntity:_onResLoadEnd()
	local go = self._loader:getInstGO()
	local trans = go.transform

	self.goSpine = go
	self.goSpineTr = go.transform
	self._skeletonAnim = self.goSpine:GetComponent(gohelper.Type_Spine_SkeletonGraphic)

	local scale = self:getScale()

	transformhelper.setLocalScale(trans, scale, scale, scale)
	gohelper.addChild(self._tr.gameObject, self.goSpine)

	local x, y, z = self:getSpineLocalPos()

	transformhelper.setLocalPos(trans, x, y, z)
	transformhelper.setLocalRotation(trans, 0, 0, 0)
	self:setVisible(true)

	local name = self:getAnimName()

	if not string.nilorempty(name) then
		self:play(name)
	end
end

function MaLiAnNaSoliderEntity:getAnimName()
	if self._soliderMo == nil then
		return nil
	end

	local config = self._soliderMo:getConfig()

	return (config or nil) and (config.animation or nil)
end

function MaLiAnNaSoliderEntity:play(animState)
	if self._skeletonAnim == nil then
		return
	end

	self._skeletonAnim.raycastTarget = false

	if self._skeletonAnim:HasAnimation(animState) then
		self._skeletonAnim:PlayAnim(animState, true, true)
	else
		local spineName = gohelper.isNil(self.goSpine) and "nil" or self.goSpine.name

		logError(string.format("animName:%s  goName:%s  Animation Name not exist ", animState, spineName))
	end

	if not self._soliderMo:isHero() then
		self._skeletonAnim.freeze = true
	end
end

function MaLiAnNaSoliderEntity:getSpineLocalPos()
	return 0, 2.5, 0
end

function MaLiAnNaSoliderEntity:getScale()
	if self._soliderMo then
		local config = self._soliderMo:getConfig()

		if config and config.scale then
			return config.scale
		end
	end

	return Activity201MaLiAnNaEnum.MaLiAnNaSoliderEntityDefaultScale
end

function MaLiAnNaSoliderEntity:onDestroy()
	self:clear()

	if self._loader ~= nil then
		self._loader:onDestroy()

		self._loader = nil
	end

	self.goSpine = nil
	self.goSpineTr = nil

	if self._go then
		gohelper.destroy(self._go)

		self._go = nil
	end
end

return MaLiAnNaSoliderEntity
