-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/spine/UnitCompSpineSkin.lua

module("logic.scene.unit.component.spine.UnitCompSpineSkin", package.seeall)

local M = class("UnitCompSpineSkin", UnitComponentBase)

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._dictSkinData = nil
	self._preloadResLoader = nil
end

function M:onInit()
	self._dictSkinData = {}
	self._preloadResLoader = MultiResLoader.New()
	self._spine = self._unit.spine

	self._unit:addInnerEventListener(UnitActionType.SpineLoaded, self._onSpineLoaded, self)
end

function M:onReset()
	self:clearSkin()
end

function M:onDestroy()
	self._unit:removeInnerEventListener(UnitActionType.SpineLoaded, self._onSpineLoaded, self)
	table.clear(self._dictSkinData)

	self._dictSkinData = nil
	self._preloadResLoader = nil
end

function M:setSkin(slotNames, resPath, preloadRes, changeSkin, extraPreloadRes)
	slotNames = slotNames or {}

	local clearRes = string.nilorempty(resPath)

	if not clearRes and self._dictSkinData[resPath] == nil then
		self._dictSkinData[resPath] = {}
	end

	for path, names in pairs(self._dictSkinData) do
		for _, slotName in ipairs(slotNames) do
			local idx = table.indexof(names, slotName)

			if idx and path ~= resPath then
				table.remove(names, idx)
			end

			if not idx and path == resPath then
				table.insert(names, slotName)
			end
		end

		if #names == 0 then
			self._dictSkinData[path] = nil
		end
	end

	if preloadRes == nil then
		preloadRes = true
	end

	if preloadRes then
		self:preloadSkinRes(extraPreloadRes)
	end

	if changeSkin == nil then
		changeSkin = true
	end

	if changeSkin then
		self:_handleChangeSkin()
	end
end

function M:clearSkin()
	self:clearPreloadSkinRes()
	table.clear(self._dictSkinData)
	self:_handleChangeSkin()
end

function M:preloadSkinRes(extraPreloadRes)
	self:clearPreloadSkinRes()

	if self._preloadResLoader then
		local canLoad = false

		for resPath, slotNames in pairs(self._dictSkinData) do
			if #slotNames > 0 then
				self._preloadResLoader:addResPath(resPath)

				canLoad = canLoad or true
			end
		end

		extraPreloadRes = extraPreloadRes or {}

		for _, resPath in ipairs(extraPreloadRes) do
			self._preloadResLoader:addResPath(resPath)

			canLoad = canLoad or true
		end

		if canLoad then
			self._preloadResLoader:load()
		end
	end
end

function M:clearPreloadSkinRes()
	if self._preloadResLoader then
		self._preloadResLoader:clear()
	end
end

function M:_handleChangeSkin()
	local spineGO = self._spine:getInst()

	if spineGO then
		local skinComp = Spine.SpineChangeSkin.Get(spineGO)

		skinComp:ClearSkinData()

		for resPath, slotNames in pairs(self._dictSkinData) do
			skinComp:AddSkinData(slotNames, resPath)
		end

		skinComp:UpdateSkin()
	end
end

function M:_onSpineLoaded()
	self:_handleChangeSkin()
end

return M
