-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/unit/UnitCompMainHeroXinMao.lua

module("logic.extensions.mainui.scene.unit.UnitCompMainHeroXinMao", package.seeall)

local M = class("UnitCompMainHeroXinMao", UnitComponentBase)

function M:ctor(componetContainer)
	M.super.ctor(self, componetContainer)
end

function M:onInit()
	self:onReset()
	self:setEvent(true)
end

function M:OnDestroy()
	M.super.OnDestroy(self)
	self:onReset()

	self._xinMao = nil
end

function M:isDestroyed()
	if self._unit then
		return self._unit:isDestroyed()
	end

	return true
end

function M:onReset()
	self:setEvent(false)
	removetimer(self.refreshXinMaoShow, self)
end

function M:onReuse()
	self:setEvent(true)
end

function M:setEvent(add)
	if add then
		self._unit:addInnerEventListener(UnitActionType.MeshModelLoaded, self._handleOnMeshModelLoaded, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_HERO_ACTIVE_CHANGE, self._handleOnActiveChange, self)
	else
		self._unit:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._handleOnMeshModelLoaded, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_HERO_ACTIVE_CHANGE, self._handleOnActiveChange, self)
	end
end

function M:setJudgeAirtightTime(judgeAirtightTime)
	self._judgeAirtightTime = judgeAirtightTime
end

function M:_handleOnMeshModelLoaded()
	local modelId = self._unit:getModelId()
	local animationPlayer = self._unit.meshModel:getAnimationPlayer()

	if animationPlayer and not goutil.isNil(animationPlayer) then
		self._xinMao = Astral.SimpleLuaComponentContainer.Add(animationPlayer.gameObject, UnitCompHeroXinMao)

		self._xinMao:setJudgeAirtightTime(self._judgeAirtightTime)
		self._xinMao:setInfo(modelId, animationPlayer)
	end
end

function M:_handleOnActiveChange(e, pointId, heroId, active)
	if self:isDestroyed() then
		return
	end

	if self._unit:getPointId() ~= pointId then
		return
	end

	if not self._xinMao then
		return
	end

	if active then
		removetimer(self.refreshXinMaoShow, self)
		self._xinMao:setXinMaoShow(false)
		settimer(0, self.refreshXinMaoShow, self, false)
	end
end

function M:refreshXinMaoShow()
	if self:isDestroyed() then
		return
	end

	if self._xinMao then
		self._xinMao:refreshXinMaoShow()
	end
end

return M
