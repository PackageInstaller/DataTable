-- chunkname: @modules/logic/explore/map/unit/ExploreBaseDisplayUnit.lua

module("modules.logic.explore.map.unit.ExploreBaseDisplayUnit", package.seeall)

local ExploreBaseDisplayUnit = class("ExploreBaseDisplayUnit", ExploreBaseUnit)

ExploreBaseDisplayUnit.PairAnim = {
	[ExploreAnimEnum.AnimName.nToA] = ExploreAnimEnum.AnimName.aToN
}

function ExploreBaseDisplayUnit:initComponents()
	self:addComp("clickComp", ExploreUnitClickComp)
	self:addComp("animComp", ExploreUnitAnimComp)
	self:addComp("animEffectComp", ExploreUnitAnimEffectComp)
	self:addComp("uiComp", ExploreUnitUIComp)
	self:addComp("outLineComp", ExploreOutLineComp)
	self:addComp("hangComp", ExploreHangComp)
end

function ExploreBaseDisplayUnit:beginRotate()
	return
end

function ExploreBaseDisplayUnit:endRotate()
	return
end

function ExploreBaseDisplayUnit:doRotate(from, to, rotateTime, endCallBack, endCallObj)
	self._rotateEndCb = endCallBack
	self._rotateEndCallObj = endCallObj

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId, true)
	end

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(from, to, rotateTime, self._onFrameRotate, self._onRotateTweenFinish, self)
end

function ExploreBaseDisplayUnit:_onFrameRotate(value)
	self.mo.unitDir = ExploreHelper.getDir(value)

	self:updateRotationRoot()
	self:onRotation()
end

function ExploreBaseDisplayUnit:_onRotateTweenFinish()
	self._tweenId = nil

	if self._rotateEndCb then
		self._rotateEndCb(self._rotateEndCallObj)
	end

	self._rotateEndCb = nil
	self._rotateEndCallObj = nil

	self:onRotateFinish()
end

function ExploreBaseDisplayUnit:onRotateFinish()
	return
end

function ExploreBaseDisplayUnit:onEnter()
	if self.animComp and self.animComp._curAnim == ExploreAnimEnum.AnimName.exit then
		self.animComp:playAnim(self:getIdleAnim(), true)
	end

	if self.clickComp then
		self.clickComp:setEnable(true)
	end

	ExploreBaseDisplayUnit.super.onEnter(self)
end

function ExploreBaseDisplayUnit:setExit()
	if self:isEnter() then
		self._playedEnter = false

		self.mo:setEnter(false)
		logWarn(string.format("[-]%s:%s退出地图", self.__cname, self.id))

		if self._isEnter == false then
			self:setActive(false)
			self:checkLight()
		else
			if self.clickComp then
				self.clickComp:setEnable(false)
			end

			self:playAnim(ExploreAnimEnum.AnimName.exit)
		end

		self._isEnter = false

		self:checkShowIcon()
		self:onExit()
	else
		logWarn("重复退出" .. self.id .. self.__cname)
	end
end

function ExploreBaseDisplayUnit:playAnim(animName)
	if not self._displayGo or not self:isInFOV() then
		ExploreController.instance:dispatchEvent(ExploreEvent.OnUnitAnimEnd, self.id, animName)
	else
		self.animComp:playAnim(animName)
	end
end

function ExploreBaseDisplayUnit:isPairAnim(preAnim, nowAnim)
	return self.PairAnim[preAnim] == nowAnim or self.PairAnim[nowAnim] == preAnim
end

function ExploreBaseDisplayUnit:onAnimEnd(preAnim, nowAnim)
	if preAnim == ExploreAnimEnum.AnimName.exit then
		self:setActive(false)
		self:_releaseDisplayGo()
		self:checkLight()
	end
end

function ExploreBaseDisplayUnit:onInit()
	return
end

function ExploreBaseDisplayUnit:_setupMO()
	self:setupRes()
	self:setupMO()
	self:updateRotation()
	self:updateRotationRoot()
	self:checkShowIcon()
end

function ExploreBaseDisplayUnit:setupRes()
	self:setResPath(self.mo.showRes)
end

function ExploreBaseDisplayUnit:setResPath(url)
	if not self:isEnter() or self:isInFOV() == false then
		return
	end

	if url == "modules/explore/prefabs/unit/ice.prefab" or url == "" then
		url = nil
	end

	if url and self._resPath ~= url then
		self._resPath = url
		self._assetId = ResMgr.getAbAsset(self._resPath, self._onResLoaded, self, self._assetId)

		if self._assetId then
			self:getMap():addUnitNeedLoadedNum(1)
		end
	elseif url and self._resPath == url and self._displayGo == nil then
		self._assetId = ResMgr.getAbAsset(self._resPath, self._onResLoaded, self, self._assetId)

		if self._assetId then
			self:getMap():addUnitNeedLoadedNum(1)
		end
	else
		self:onResLoaded()
	end
end

function ExploreBaseDisplayUnit:getMap()
	return ExploreController.instance:getMap()
end

function ExploreBaseDisplayUnit:setInteractActive(isActive)
	local status = self.mo:getStatus()

	status = ExploreHelper.setBit(status, ExploreEnum.InteractIndex.ActiveState, isActive)

	self.mo:setStatus(status)
end

function ExploreBaseDisplayUnit:getResPath()
	return self._resPath
end

function ExploreBaseDisplayUnit:_onResLoaded(assetMO)
	if not assetMO.IsLoadSuccess then
		return
	end

	self:_releaseDisplayGo()

	if self:isActive() then
		self._displayGo = assetMO:getInstance(nil, nil, self.go)
		self._displayTr = self._displayGo.transform
		self._rotateRoot = self._displayTr:Find("#go_rotate")

		if self.mo then
			transformhelper.setLocalPos(self._displayTr, self.mo.resPosition[1], self.mo.resPosition[2], self.mo.resPosition[3])
		end

		local compList = self:getCompList()

		for _, comp in ipairs(compList) do
			if comp.setup then
				comp:setup(self._displayGo)
			end
		end

		self:updateRotation()
		self:updateRotationRoot()
		self:onResLoaded()
		self:_checkContainerNeedUpdate()

		if not self._akComp and ExploreConfig.instance:getAssetNeedAkGo(self._resPath) then
			gohelper.addAkGameObject(self.go)

			self._akComp = true
		end

		if not self._playedEnter and self.animComp and self.animComp.haveAnim and self.animComp:haveAnim(ExploreAnimEnum.AnimName.enter) then
			self:markPlayedEnter()
			self.animComp:playAnim(ExploreAnimEnum.AnimName.enter)
		end

		self:setOutLight(self._showOutLine)
	end
end

function ExploreBaseDisplayUnit:_checkContainerNeedUpdate()
	if self.animComp and self.animComp.animator then
		self._luamonoContainer.enabled = true
	end
end

function ExploreBaseDisplayUnit:onMapInit()
	self:markPlayedEnter()
end

function ExploreBaseDisplayUnit:markPlayedEnter()
	self._playedEnter = true
end

function ExploreBaseDisplayUnit:updateRotation()
	if not self._displayTr or not self.mo then
		return
	end

	transformhelper.setLocalRotation(self._displayTr, self.mo.resRotation[1], self.mo.resRotation[2], self.mo.resRotation[3])
end

function ExploreBaseDisplayUnit:getEffectRoot()
	return self._rotateRoot or self._displayTr or self.trans
end

function ExploreBaseDisplayUnit:updateRotationRoot()
	if not self._rotateRoot or not self.mo then
		return
	end

	transformhelper.setLocalRotation(self._rotateRoot, 0, self.mo.unitDir - self.mo.resRotation[2], 0)
end

function ExploreBaseDisplayUnit:onActiveChange(nowActive)
	if nowActive then
		self:playAnim(ExploreAnimEnum.AnimName.nToA)
	else
		self:playAnim(ExploreAnimEnum.AnimName.aToN)
	end

	ExploreBaseDisplayUnit.super.onActiveChange(self, nowActive)
end

function ExploreBaseDisplayUnit:onInteractChange(nowInteract)
	if nowInteract then
		self:playAnim(ExploreAnimEnum.AnimName.uToN)
	else
		self:playAnim(ExploreAnimEnum.AnimName.nToU)
	end

	ExploreBaseDisplayUnit.super.onInteractChange(self, nowInteract)
end

function ExploreBaseDisplayUnit:forceOutLine(isForceOutLight)
	self._isForceOutLight = isForceOutLight

	self:setOutLight(self._showOutLine)
end

function ExploreBaseDisplayUnit:setOutLight(isOutLight)
	if not self._displayGo or not self.outLineComp then
		return
	end

	self.outLineComp:setOutLight(self._isForceOutLight or isOutLight)
end

function ExploreBaseDisplayUnit:onRoleNear()
	ExploreBaseDisplayUnit.super.onRoleNear(self)

	if self.mo.isStrong then
		return
	end

	self:checkShowIcon()
end

function ExploreBaseDisplayUnit:onRoleFar()
	ExploreBaseDisplayUnit.super.onRoleFar(self)

	if self.mo.isStrong then
		return
	end

	self:checkShowIcon()
end

function ExploreBaseDisplayUnit:isCustomShowOutLine()
	return false
end

function ExploreBaseDisplayUnit:checkShowIcon()
	if not self.mo then
		return
	end

	local co = lua_explore_unit.configDict[self.mo.customIconType or self.mo.type]

	if co then
		local showOutLine = false

		if self.mo.isStrong then
			showOutLine = true
		elseif self._roleNear and co.isShow == 1 then
			showOutLine = true
		end

		local canTrigger = self:canTrigger()

		if showOutLine and not canTrigger and not self:isCustomShowOutLine() and not self.mo.isCanMove or not self:isEnter() then
			showOutLine = false
		end

		if not string.nilorempty(co.mapActiveIcon) and self.mo:isInteractActiveState() then
			ExploreMapModel.instance:setSmallMapIconById(self.id, self.mo.nodeKey, co.mapActiveIcon)
		elseif not string.nilorempty(co.mapIcon) or not string.nilorempty(co.mapIcon2) then
			if self.mo.isStrong then
				if not co.mapIcon2 then
					local icon = co.mapIcon

					icon = self:processMapIcon(icon)

					if co.mapIconShow == 1 then
						ExploreMapModel.instance:setSmallMapIconById(self.id, self.mo.nodeKey, icon)
					else
						ExploreMapModel.instance:setSmallMapIconById(self.id, self.mo.nodeKey, canTrigger and icon or nil)
					end
				end
			end
		else
			ExploreMapModel.instance:setSmallMapIconById(self.id, self.mo.nodeKey, nil)
		end

		self._showOutLine = showOutLine

		self:setOutLight(showOutLine)
	end
end

function ExploreBaseDisplayUnit:processMapIcon(icon)
	return icon
end

function ExploreBaseDisplayUnit:hideMapIcon()
	if not self.mo then
		return
	end

	local co = lua_explore_unit.configDict[self.mo.customIconType or self.mo.type]

	if not co or string.nilorempty(co.mapIcon) and string.nilorempty(co.mapIcon2) and string.nilorempty(co.mapActiveIcon) then
		return
	end

	ExploreMapModel.instance:setSmallMapIconById(self.id, self.mo.nodeKey, nil)
end

function ExploreBaseDisplayUnit:onInFOVChange(v)
	self:setActive(v)

	if v then
		self:setupRes()
		TaskDispatcher.cancelTask(self._releaseDisplayGo, self)
	else
		TaskDispatcher.runDelay(self._releaseDisplayGo, self, ExploreConstValue.CHECK_INTERVAL.UnitObjDestory)
	end
end

function ExploreBaseDisplayUnit:setActive(...)
	ExploreBaseDisplayUnit.super.setActive(self, ...)

	if not ... and self.animEffectComp and self.animEffectComp.destoryEffectIfOnce then
		self.animEffectComp:destoryEffectIfOnce()
	end
end

function ExploreBaseDisplayUnit:onNodeChange(preNode, nowNode)
	self:checkLight()
end

function ExploreBaseDisplayUnit:setEmitLight(isNoEmit)
	self._isNoEmitLight = isNoEmit
end

function ExploreBaseDisplayUnit:getIsNoEmitLight()
	return self._isNoEmitLight
end

function ExploreBaseDisplayUnit:checkLight()
	local lightType = self:getLightRecvType()

	if lightType == ExploreEnum.LightRecvType.Photic or lightType == ExploreEnum.LightRecvType.Custom then
		return
	end

	local map = ExploreController.instance:getMap()

	if not map:isInitDone() then
		return
	end

	local mapLight = ExploreController.instance:getMapLight()

	mapLight:updateLightsByUnit(self)
end

function ExploreBaseDisplayUnit:getIdleAnim()
	local mo = self.mo

	if not mo:isInteractEnabled() then
		return ExploreAnimEnum.AnimName.unable
	elseif not mo:isInteractActiveState() then
		return ExploreAnimEnum.AnimName.normal
	else
		return ExploreAnimEnum.AnimName.active
	end
end

function ExploreBaseDisplayUnit:onResLoaded()
	return
end

function ExploreBaseDisplayUnit:_releaseDisplayGo()
	self:clearComp()

	if self._assetId and not self:isRole() then
		self:getMap():addUnitNeedLoadedNum(-1)
	end

	ResMgr.removeCallBack(self._assetId)
	ResMgr.ReleaseObj(self._displayGo)

	self._displayGo = nil
	self._displayTr = nil
	self._rotateRoot = nil
	self._assetId = nil

	self:_checkContainerNeedUpdate()
end

function ExploreBaseDisplayUnit:clearComp()
	local compList = self:getCompList()

	for _, comp in ipairs(compList) do
		if comp.clear then
			comp:clear()
		end
	end
end

function ExploreBaseDisplayUnit:onDestroy()
	self:_releaseDisplayGo()
	TaskDispatcher.cancelTask(self._releaseDisplayGo, self)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId, true)

		self._tweenId = nil
	end
end

return ExploreBaseDisplayUnit
