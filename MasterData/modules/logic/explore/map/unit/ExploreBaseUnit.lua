-- chunkname: @modules/logic/explore/map/unit/ExploreBaseUnit.lua

module("modules.logic.explore.map.unit.ExploreBaseUnit", package.seeall)

local ExploreBaseUnit = class("ExploreBaseUnit", BaseUnitSpawn)
local Type_LuaMonobehavier = typeof(SLFramework.LuaMonobehavier)

function ExploreBaseUnit:ctor(parentGo, name)
	local go = gohelper.create3d(parentGo, name)

	self.trans = go.transform

	self:init(go)

	self._hasInteract = false
	self._isEnter = false

	self:onInit()

	self._luamonoContainer = go:GetComponent(Type_LuaMonobehavier)

	self:_checkContainerNeedUpdate()
end

function ExploreBaseUnit:isRole()
	return false
end

function ExploreBaseUnit:canMove()
	return false
end

function ExploreBaseUnit:onEnter()
	return
end

function ExploreBaseUnit:onUpdateCount(count, totalCount)
	return
end

function ExploreBaseUnit:setupMO()
	return
end

function ExploreBaseUnit:doFix()
	return
end

function ExploreBaseUnit:onTriggerDone()
	return
end

function ExploreBaseUnit:onTrigger()
	return
end

function ExploreBaseUnit:onCancelTrigger()
	return
end

function ExploreBaseUnit:onRoleEnter(nowNode, preNode)
	return
end

function ExploreBaseUnit:onRoleStay()
	return
end

function ExploreBaseUnit:onRoleLeave()
	return
end

function ExploreBaseUnit:onExit()
	return
end

function ExploreBaseUnit:onRelease()
	return
end

function ExploreBaseUnit:onDestroy()
	return
end

function ExploreBaseUnit:isMoving()
	return false
end

function ExploreBaseUnit:_checkContainerNeedUpdate()
	return
end

function ExploreBaseUnit:onLightDataChange(lightMO)
	if self.lightComp then
		self.lightComp:onLightDataChange(lightMO)
	end
end

function ExploreBaseUnit:onStatusChange(changeBit)
	if ExploreHelper.getBit(changeBit, ExploreEnum.InteractIndex.InteractEnabled) > 0 then
		self:onInteractChange(self.mo:isInteractEnabled())
	end

	if ExploreHelper.getBit(changeBit, ExploreEnum.InteractIndex.ActiveState) > 0 then
		local isActive = self.mo:isInteractActiveState()

		self:onActiveChange(isActive)

		if self.mo then
			self.mo:activeStateChange(isActive)
		end
	end
end

function ExploreBaseUnit:onStatus2Change(preStatuInfo, nowStatuInfo)
	return
end

function ExploreBaseUnit:onInteractChange(nowInteract)
	return
end

function ExploreBaseUnit:onActiveChange(nowActive)
	return
end

function ExploreBaseUnit:onNodeChange(preNode, nowNode)
	return
end

function ExploreBaseUnit:onRoleNear()
	self._roleNear = true
end

function ExploreBaseUnit:onRoleFar()
	self._roleNear = false
end

function ExploreBaseUnit:onMapInit()
	return
end

function ExploreBaseUnit:onHeroInitDone()
	return
end

function ExploreBaseUnit:setData(mo)
	self.mo = mo
	self.id = mo.id
	self.go.name = self.__cname .. mo.id

	self:setPosByNode(mo.nodePos)

	if self.mo:isEnter() then
		self:setEnter()
	else
		self:setExit()
	end

	self:_setupMO()
end

function ExploreBaseUnit:getExploreUnitMO()
	return self.mo
end

function ExploreBaseUnit:setTmpData(mo)
	self.mo = mo
	self.id = mo.id
	self.go.name = self.__cname .. mo.id

	self:setPosByNode(mo.nodePos, true)
	self:_setupMO()
end

function ExploreBaseUnit:_setupMO()
	self:setupMO()
end

function ExploreBaseUnit:tryTrigger(clientOnly)
	if self.mo:isInteractEnabled() and self._isEnter then
		self:onTrigger()
		ExploreMapTriggerController.instance:triggerUnit(self, clientOnly)

		return self:needInteractAnim()
	end
end

function ExploreBaseUnit:needInteractAnim()
	return false
end

function ExploreBaseUnit:cancelTrigger()
	self:onCancelTrigger()
	ExploreMapTriggerController.instance:cancelTrigger(self)
end

function ExploreBaseUnit:getHasInteract()
	return self.mo:isInteractDone()
end

function ExploreBaseUnit:setName(value)
	self.go.name = value
end

function ExploreBaseUnit:setParent(tran)
	self.trans:SetParent(tran)
end

function ExploreBaseUnit:getPos()
	return self.position
end

function ExploreBaseUnit:getUnitType()
	if self.mo then
		return self.mo.type
	end
end

function ExploreBaseUnit:needUpdateHeroPos()
	return false
end

function ExploreBaseUnit:getFixItemId()
	return nil
end

function ExploreBaseUnit:canTrigger()
	local var_43_0 = self.mo

	if self.mo then
		var_43_0 = self.mo:isInteractEnabled()
		var_43_0 = var_43_0 and not self.mo:isInteractFinishState() and self:isEnter()
	end

	return var_43_0
end

function ExploreBaseUnit:isInteractActiveState()
	if self.mo then
		return self.mo:isInteractActiveState()
	end

	return false
end

function ExploreBaseUnit:setPos(pos, notDispatchEvent)
	if gohelper.isNil(self.go) == false then
		transformhelper.setPos(self.trans, -999999, 0, -99999)

		pos.y = 10

		local isHit, hitInfo = UnityEngine.Physics.Raycast(pos, Vector3.down, nil, Mathf.Infinity, ExploreHelper.getNavigateMask())

		pos.y = isHit and hitInfo.point.y or self.trans.position.y
		self.position = pos

		transformhelper.setPos(self.trans, self.position.x, self.position.y, self.position.z)

		local node = ExploreHelper.posToTile(pos)

		if node ~= self.nodePos then
			local preNode = self.nodePos

			self.nodePos = node

			if self.mo then
				self.mo:updatePos(node)
			end

			self.nodeMO = ExploreMapModel.instance:getNode(ExploreHelper.getKey(self.nodePos))

			if notDispatchEvent ~= true then
				ExploreController.instance:dispatchEvent(ExploreEvent.OnUnitNodeChange, self, self.nodePos, preNode)
			end

			self:onNodeChange(preNode, self.nodePos)
		end
	end
end

function ExploreBaseUnit:removeFromNode()
	local preNode = self.nodePos

	self.nodePos = nil

	if self.mo then
		self.mo:removeFromNode()
	end

	self.nodeMO = nil

	ExploreController.instance:dispatchEvent(ExploreEvent.OnUnitNodeChange, self, false, preNode)
	self:onNodeChange(preNode, self.nodePos)
end

function ExploreBaseUnit:isPassLight()
	return self:getLightRecvType() == ExploreEnum.LightRecvType.Photic
end

function ExploreBaseUnit:getLightRecvType()
	return (self.mo.isPhotic or nil) and (ExploreEnum.LightRecvType.Photic or ExploreEnum.LightRecvType.Barricade)
end

function ExploreBaseUnit:getLightRecvDirs()
	return nil
end

function ExploreBaseUnit:onLightChange(lightMO, isEnter)
	return
end

function ExploreBaseUnit:onLightEnter(lightMO)
	return
end

function ExploreBaseUnit:onLightExit()
	return
end

function ExploreBaseUnit:onRotation()
	return
end

function ExploreBaseUnit:setInFOV(v)
	if self:isEnter() and self._isInFOV ~= v then
		self._isInFOV = v

		self:onInFOVChange(v)
	end
end

function ExploreBaseUnit:isInFOV()
	return self._isInFOV or false
end

function ExploreBaseUnit:onInFOVChange(v)
	return
end

function ExploreBaseUnit:updateSceneY(y)
	if y then
		self.position.y = y
	else
		self.position.y = 10

		local isHit, hitInfo = UnityEngine.Physics.Raycast(self.position, Vector3.down, nil, Mathf.Infinity, ExploreHelper.getNavigateMask())

		self.position.y = isHit and hitInfo.point.y or self.trans.position.y
	end

	transformhelper.setPos(self.trans, self.position.x, self.position.y, self.position.z)
end

function ExploreBaseUnit:setScale(v)
	transformhelper.setLocalScale(self.trans, v, v, v)
end

function ExploreBaseUnit:setRotate(x, y, z)
	transformhelper.setLocalRotation(self.trans, x, y, z)
end

function ExploreBaseUnit:setPosByNode(node, notDispatchEvent)
	self:setPos(ExploreHelper.tileToPos(node), notDispatchEvent)
end

function ExploreBaseUnit:isEnter()
	return self._isEnter
end

function ExploreBaseUnit:isActive()
	return self.go.activeSelf
end

function ExploreBaseUnit:isEnable()
	return self:isActive()
end

function ExploreBaseUnit:setActive(value)
	gohelper.setActive(self.go, value)
end

function ExploreBaseUnit:setEnter()
	if not self:isEnter() then
		self._isEnter = true

		self.mo:setEnter(true)

		if isDebugBuild then
			logWarn(string.format("[+]%s:%s进入地图", self.__cname, self.id))
		end

		self:setActive(true)
		self:onEnter()
	end
end

function ExploreBaseUnit:setExit()
	if self:isEnter() then
		self._isEnter = false

		self.mo:setEnter(false)

		if isDebugBuild then
			logWarn(string.format("[-]%s:%s退出地图", self.__cname, self.id))
		end

		self:setActive(false)
		self:onExit()
	else
		logWarn("重复退出" .. self.id .. self.__cname)
	end
end

function ExploreBaseUnit:destroy()
	self:onDestroy()
	gohelper.destroy(self.go)

	self.trans = nil
	self.mo = nil
	self.go = nil
end

return ExploreBaseUnit
