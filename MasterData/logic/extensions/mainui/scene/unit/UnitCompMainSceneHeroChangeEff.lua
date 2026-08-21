-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/unit/UnitCompMainSceneHeroChangeEff.lua

module("logic.extensions.mainui.scene.unit.UnitCompMainSceneHeroChangeEff", package.seeall)

local M = class("UnitCompMainSceneHeroChangeEff", UnitComponentBase)

function M:getEffectPaths()
	return {
		ResName.MainScene_Hero_Change_Eff
	}
end

function M:ctor(componetContainer)
	M.super.ctor(self, componetContainer)

	self._delayTween = {}
	self._resLoaderChangeEff = MultiResLoader.New()

	self:_load()
end

function M:onInit()
	self:onReset()
	self:setEvent(true)
end

function M:OnDestroy()
	M.super.OnDestroy(self)
	self:onReset()
	self:clear()

	self._resLoaderChangeEff = nil
end

function M:isDestroyed()
	if self._unit then
		return self._unit:isDestroyed()
	end

	return true
end

function M:onReset()
	self:setEvent(false)
end

function M:onReuse()
	self:setEvent(true)
end

function M:getIsLoadedFinish()
	return self._isAllFinish
end

function M:getResInst(path)
	if self._resInstChangeEff then
		return self._resInstChangeEff[path]
	end

	return nil
end

function M:clear()
	self._blockChangeEff = nil
	self._isAllFinish = false

	for goInstanceId, tweener in pairs(self._delayTween) do
		tweener:Kill(false)
	end

	self._delayTween = {}

	for path, go in pairs(self._resInstChangeEff or {}) do
		goutil.destroy(go.gameObject)
	end

	self._resInstChangeEff = nil

	if self._resDicChangeEff then
		for _, res in pairs(self._resDicChangeEff) do
			res:Release()
		end
	end

	self._resDicChangeEff = nil

	if self._resLoaderChangeEff then
		self._resLoaderChangeEff:clear()
	end
end

function M:setEvent(add)
	if add then
		self._unit:addInnerEventListener(UnitActionType.MainSceneMeshSetBody, self._handleOnMeshSetBody, self)
		self._unit:addInnerEventListener(UnitActionType.MainSceneMeshShowUp, self._handleOnMeshModelShowUp, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_HERO_CHANGE_EFF, self._handleHeroChangeEff, self)
	else
		self._unit:removeInnerEventListener(UnitActionType.MainSceneMeshSetBody, self._handleOnMeshSetBody, self)
		self._unit:removeInnerEventListener(UnitActionType.MainSceneMeshShowUp, self._handleOnMeshModelShowUp, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_HERO_CHANGE_EFF, self._handleHeroChangeEff, self)
	end
end

function M:_handleOnMeshSetBody(e)
	if self._isAllFinish then
		self:_showChangeHeroEff(false)
	end
end

function M:_handleOnMeshModelShowUp(eventUid, unitActionType, defaultAnimState)
	local show = true

	if self._blockChangeEff then
		show = false
	end

	if self._isAllFinish then
		self:_showChangeHeroEff(show)
	end
end

function M:_handleHeroChangeEff(e, heroId)
	if self._unit:getHeroId() == heroId then
		self:_handleOnMeshModelShowUp(nil, nil, false)
	end
end

function M:setBlockChangeEff(block)
	self._blockChangeEff = block
end

function M:_showChangeHeroEff(show)
	if self._delayTween[ResName.MainScene_Hero_Change_Eff] then
		self._delayTween[ResName.MainScene_Hero_Change_Eff]:Kill(false)

		self._delayTween[ResName.MainScene_Hero_Change_Eff] = nil
	end

	if self:isDestroyed() then
		return
	end

	local eff = self:getResInst(ResName.MainScene_Hero_Change_Eff)

	if eff and not goutil.isNil(eff) then
		if ViewMgr.instance:isOpen(ViewName.MainUIView) then
			goutil.setActive(eff.gameObject, false)

			return
		end

		if not show then
			goutil.setActive(eff.gameObject, false)

			return
		end

		self._delayTween[ResName.MainScene_Hero_Change_Eff] = DoTweenUtil.DelayedCall(0, function()
			local x, y, z = self:getChangeEffSetPos()
			local offSetPos = self:getOffSetPos()

			x, y, z = TransformUtils.InverseTransformPoint(self._unit:getTransform(), x, y, z, 0, 0, 0)

			TransformUtils.SetLocalPosition(eff.transform, x, offSetPos.y, z)
			self:_tmpShow(eff.gameObject, 3)
		end)
	end
end

function M:_tmpShow(go, delayHide)
	local instanceId = go:GetInstanceID()

	if self._delayTween[instanceId] then
		self._delayTween[instanceId]:Kill(false)

		self._delayTween[instanceId] = nil
	end

	goutil.setActive(go, false)
	goutil.setActive(go, true)

	if delayHide and delayHide > 0 then
		self._delayTween[instanceId] = DoTweenUtil.DelayedCall(delayHide, function()
			goutil.setActive(go, false)
		end)
	end
end

function M:getChangeEffSetPos()
	local go = self._unit.meshModel:getInst()
	local find = false
	local x, y, z = 0, 0, 0

	if go then
		for i = 0, go.transform.childCount - 1 do
			if not find then
				local childGo = go.transform:GetChild(i).gameObject
				local _name = childGo.name

				if string.match(_name, "body") then
					local modelTr = self._unit.meshModel:getModelTr()
					local childX, childY, ChildZ = TransformUtils.GetLocalPosition(childGo.transform, 0, 0, 0)

					x, y, z = TransformUtils.TransformPoint(modelTr, childX, childY, ChildZ, 0, 0, 0)
					find = true
				end
			end
		end
	end

	return x, y, z
end

function M:setOffSetPos(x, y, z)
	self._offsetPos = Vector3.New(x, y, z)
end

function M:getOffSetPos()
	return self._offsetPos or Vector3.New(0, 0, 0)
end

function M:_load()
	self._resLoaderChangeEff:setResPaths(self:getEffectPaths())
	self._resLoaderChangeEff:load(self._onAllResLoadedChangeEff, self._onResLoadedChangeEff, self)
end

function M:_onAllResLoadedChangeEff(loader)
	self._isAllFinish = true
end

function M:_onResLoadedChangeEff(res)
	if not res.IsSuccess then
		printError(string.format("资源加载失败:%s", res.ResPath))

		return
	end

	local prefabAsset = res:GetAsset(nil, nil)
	local prefabInst = goutil.cloneAndSetParent(prefabAsset, self._unit:getTransform())

	goutil.setActive(prefabInst.gameObject, false)

	prefabInst.layer = self._unit:getGameObject().layer

	local prefabTr = prefabInst.transform

	Astral.TransformUtil.SetLocalPos(prefabTr, 0, -500, 0)
	Astral.TransformUtil.SetLocalRotation(prefabTr, 0, 0, 0)

	if not self._resDicChangeEff then
		self._resDicChangeEff = {}
	end

	self._resDicChangeEff[res.ResPath] = res

	res:Retain()

	if not self._resInstChangeEff then
		self._resInstChangeEff = {}
	end

	self._resInstChangeEff[res.ResPath] = prefabInst
end

return M
