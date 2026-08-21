-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/unit/UnitCompHeroMaterial.lua

module("logic.extensions.mainui.scene.unit.UnitCompHeroMaterial", package.seeall)

local M = class("UnitCompHeroMaterial", UnitComponentBase)

function M:getAddMaterialPath()
	return {
		ResName.MainScene_Hero_Change_Mat
	}
end

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._matSwitcher = nil
	self._factorIdRimColor = UnityEngine.Shader.PropertyToID("_RimColor")
	self._factorIdRimScale = UnityEngine.Shader.PropertyToID("_RimScale")
	self._factorIdRimPower = UnityEngine.Shader.PropertyToID("_RimPower")
	self._resLoaderMat = MultiResLoader.New()

	self:_loadMat()
end

function M:onInit()
	self:onReset()
	self:setEvent(true)
end

function M:onDestroy()
	self:onReset()
	self:setEvent(false)

	if self._addMatRim then
		self._addMatRim:DOKill(false)
	end

	self._addMatRim = nil

	if self._resDicMat then
		for _, res in pairs(self._resDicMat) do
			res:Release()
		end
	end

	self._resDicMat = nil

	if self._resLoaderMat then
		self._resLoaderMat:clear()
	end

	self._matSwitcher = nil
end

function M:isDestroyed()
	if self._unit then
		return self._unit:isDestroyed()
	end

	return true
end

function M:onReset()
	self:setEvent(false)
	self:clear()
end

function M:onReuse()
	self:setEvent(true)
end

function M:clear()
	if not goutil.isNil(self._addMatRim) then
		self._addMatRim:DOKill(false)
	end
end

function M:setEvent(add)
	if add then
		self._unit:addInnerEventListener(UnitActionType.MeshModelLoaded, self._handleOnMeshModelLoaded, self)
		self._unit:addInnerEventListener(UnitActionType.MainSceneMeshShowUp, self._handleOnMeshModelShowUp, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_HERO_CHANGE_EFF, self._handleHeroChangeEff, self)
	else
		self._unit:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._handleOnMeshModelLoaded, self)
		self._unit:removeInnerEventListener(UnitActionType.MainSceneMeshShowUp, self._handleOnMeshModelShowUp, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_HERO_CHANGE_EFF, self._handleHeroChangeEff, self)
	end
end

function M:setBlockChangeEff(block)
	self._blockChangeEff = block
end

function M:_handleOnMeshModelLoaded()
	self:clear()

	local go = self._unit.meshModel:getInst()

	if go and not goutil.isNil(go) then
		self._matSwitcher = MaterialSwitcher.Get(go)

		local find = false

		if self._unit:getPointId() == MainPerformEnum.ElementPointAdjutant then
			local cfg = MainPerformConfig.instance:getLandLadyRConfig(self._unit:getModelId())

			if cfg then
				find = true

				self._matSwitcher:SetGameObjectExclude(go, cfg.noEnterMatEffNode or {})
			end
		end

		if not find then
			self._matSwitcher:SetGameObject(go)
		end
	end
end

function M:_handleOnMeshModelShowUp(eventUid, unitActionType, defaultAnimState)
	if self._blockChangeEff then
		return
	end

	if not ViewMgr.instance:isOpen(ViewName.CharacterDepotMainViewNew) then
		return
	end

	local duration = 0.4666666666666667

	self:_tryAddMat()
	self._addMatRim:DOKill(false)
	self._addMatRim:SetColor(self._factorIdRimColor, Astral.ColorUtil.ParseColor("#9DB5D1"))
	self._addMatRim:SetFloat(self._factorIdRimPower, 0.5)
	self._addMatRim:DOFloat(4, self._factorIdRimPower, duration)
	self._addMatRim:DOColor(Astral.ColorUtil.ParseColor("#9DB5D100"), self._factorIdRimColor, duration):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):OnComplete(function()
		if self._matSwitcher then
			self._matSwitcher:ResumeOriginalMaterial()
		end
	end, self)
end

function M:_handleHeroChangeEff(e, heroId)
	if self._unit:getHeroId() == heroId then
		self:_handleOnMeshModelShowUp()
	end
end

function M:getResInst(path)
	if self._resDicMat then
		return self._resDicMat[path]:GetAsset(nil, nil)
	end

	return nil
end

function M:getMatSwitcher()
	return self._matSwitcher
end

function M:_tryAddMat()
	if not self._isAllFinish then
		return false
	end

	if not self._addMatRim then
		self._addMatRim = self:getResInst(ResName.MainScene_Hero_Change_Mat)
	end

	local body = self._unit.meshModel:getInst()

	if body and not goutil.isNil(body) and self._matSwitcher then
		self._matSwitcher:AddSharedMaterial(self._addMatRim)

		return true
	end

	return false
end

function M:_loadMat()
	self._resLoaderMat:setResPaths(self:getAddMaterialPath())
	self._resLoaderMat:load(self._onAllResLoadedMat, self._onResLoadedMat, self)
end

function M:_onAllResLoadedMat(loader)
	self._isAllFinish = true
end

function M:_onResLoadedMat(res)
	if not res.IsSuccess then
		printError(string.format("资源加载失败:%s", res.ResPath))

		return
	end

	if not self._resDicMat then
		self._resDicMat = {}
	end

	self._resDicMat[res.ResPath] = res

	res:Retain()
end

return M
