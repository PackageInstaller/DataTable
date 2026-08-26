-- chunkname: @modules/logic/scene/summon/comp/SummonSceneSelector.lua

module("modules.logic.scene.summon.comp.SummonSceneSelector", package.seeall)

local SummonSceneSelector = class("SummonSceneSelector", BaseSceneComp)

function SummonSceneSelector:onSceneStart(sceneId, levelId)
	self._curSelectType = nil
	self._curSelectGo = nil

	logNormal("SummonSceneSelector:onSceneStart")
	SummonController.instance:registerCallback(SummonEvent.onSummonTabSet, self._handleSelectScene, self)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, self._onSceneResize, self)
	self:_handleSelectScene()
end

function SummonSceneSelector:onScenePrepared(sceneId, levelId)
	self:_handleSelectScene()
	self:_refreshSelectScene()
end

function SummonSceneSelector:_onSceneResize()
	if self._curSelectType == SummonEnum.ResultType.Equip then
		self._sceneObj.cameraAnim:switchToEquip()
	else
		self._sceneObj.cameraAnim:switchToChar()
	end
end

function SummonSceneSelector:_handleSelectScene()
	local poolId = SummonController.instance:getLastPoolId()

	if not poolId then
		logNormal("LastPoolId is empty, Maybe call from guide.")
	end

	local resultType = SummonMainModel.getResultTypeById(poolId)

	if resultType ~= self._curSelectType then
		self._curSelectType = resultType

		self:_refreshSelectScene()
	end
end

function SummonSceneSelector:_refreshSelectScene()
	local goShow, goHide

	if self._curSelectType == SummonEnum.ResultType.Equip then
		goShow = self._goSceneEquip
		goHide = self._goSceneChar

		self._sceneObj.cameraAnim:switchToEquip()
	else
		goShow = self._goSceneChar
		goHide = self._goSceneEquip

		self._sceneObj.cameraAnim:switchToChar()
	end

	self._sceneObj.bgm:Play(self._curSelectType)

	self._curSelectGo = goShow

	SummonController.instance:resetAnimScale()

	local hideTf = self:getNoSelectedRootGo().transform
	local rootTf = self._sceneObj:getSceneContainerGO().transform

	if not gohelper.isNil(goHide) then
		goHide.transform:SetParent(hideTf, false)
	end

	if not gohelper.isNil(goShow) then
		goShow.transform:SetParent(rootTf, false)
	end
end

function SummonSceneSelector:initEquipSceneGo(assetItem)
	local oldAsstet = self._assetItemEquip

	self._assetItemEquip = assetItem

	self._assetItemEquip:Retain()

	if oldAsstet then
		oldAsstet:Release()
	end
end

function SummonSceneSelector:initCharSceneGo(assetItem)
	local oldAsstet = self._assetItemChar

	self._assetItemChar = assetItem

	self._assetItemChar:Retain()

	if oldAsstet then
		oldAsstet:Release()
	end
end

function SummonSceneSelector:isSceneGOInited(isChar)
	if isChar then
		return not gohelper.isNil(self._goSceneChar)
	else
		return not gohelper.isNil(self._goSceneEquip)
	end
end

function SummonSceneSelector:initSceneGO(isChar)
	local isDirty = false

	if isChar then
		if gohelper.isNil(self._goSceneChar) and self._assetItemChar then
			self._goSceneChar = gohelper.clone(self._assetItemChar:GetResource(), self:getNoSelectedRootGo(), "char_scene_go")
			isDirty = true
		end
	elseif gohelper.isNil(self._goSceneEquip) and self._assetItemEquip then
		self._goSceneEquip = gohelper.clone(self._assetItemEquip:GetResource(), self:getNoSelectedRootGo(), "equip_scene_go")
		isDirty = true
	end

	if isDirty then
		self:_refreshSelectScene()
		self:dispatchEvent(SummonSceneEvent.OnSceneGOInited, isChar)

		if not gohelper.isNil(self._goSceneChar) and not gohelper.isNil(self._goSceneEquip) then
			self:dispatchEvent(SummonSceneEvent.OnSceneAllGOInited)
		end
	end
end

function SummonSceneSelector:getNoSelectedRootGo()
	if not self._goSelectorRoot then
		local SummonSceneRoot = self._sceneObj:getSceneContainerGO()

		self._goSelectorRoot = gohelper.create3d(SummonSceneRoot, "SceneSelector")

		gohelper.setActive(self._goSelectorRoot, false)
	end

	return self._goSelectorRoot
end

function SummonSceneSelector:getEquipSceneGo()
	return self._goSceneEquip
end

function SummonSceneSelector:getCharSceneGo()
	return self._goSceneChar
end

function SummonSceneSelector:getCurSceneGo()
	return self._curSelectGo
end

function SummonSceneSelector:onSceneClose()
	self:onSceneHide()
	gohelper.setActive(self._goSelectorRoot, true)
	gohelper.destroy(self._goSceneEquip)
	gohelper.destroy(self._goSceneChar)
	gohelper.destroy(self._goSelectorRoot)

	self._goSceneEquip = nil
	self._goSelectorRoot = nil
	self._goSceneChar = nil
	self._curSelectGo = nil

	if self._assetItemEquip then
		self._assetItemEquip:Release()

		self._assetItemEquip = nil
	end

	if self._assetItemChar then
		self._assetItemChar:Release()

		self._assetItemChar = nil
	end
end

function SummonSceneSelector:onSceneHide()
	logNormal("onSceneHide")
	SummonController.instance:unregisterCallback(SummonEvent.onSummonTabSet, self._handleSelectScene, self)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, self._onSceneResize, self)
end

return SummonSceneSelector
