-- chunkname: @modules/logic/dungeon/view/rolestory/BaseRoleStoryView.lua

module("modules.logic.dungeon.view.rolestory.BaseRoleStoryView", package.seeall)

local BaseRoleStoryView = class("BaseRoleStoryView", UserDataDispose)

function BaseRoleStoryView:ctor(parentGO)
	self:__onInit()

	self.parentGO = parentGO
	self.isShow = false

	self:onInit()
end

function BaseRoleStoryView:_loadPrefab()
	if self._loader then
		return
	end

	if not self.resPathList then
		return
	end

	local allResPath = {}

	for k, v in pairs(self.resPathList) do
		table.insert(allResPath, v)
	end

	self._abLoader = MultiAbLoader.New()

	self._abLoader:setPathList(allResPath)
	self._abLoader:startLoad(self._onLoaded, self)
end

function BaseRoleStoryView:_onLoaded()
	local assetItem = self._abLoader:getAssetItem(self.resPathList.mainRes)
	local mainPrefab = assetItem:GetResource(self.resPathList.mainRes)

	self.viewGO = gohelper.clone(mainPrefab, self.parentGO, self.viewName)

	if not self.viewGO then
		return
	end

	self:onInitView()
	self:addEvents()

	if self.isShow then
		self:show(true)
	else
		self:hide(true)
	end
end

function BaseRoleStoryView:getResInst(resPath, parentGO, name)
	local assetItem = self._abLoader:getAssetItem(resPath)

	if assetItem then
		local prefab = assetItem:GetResource(resPath)

		if prefab then
			return gohelper.clone(prefab, parentGO, name)
		else
			logError(self.__cname .. " prefab not exist: " .. resPath)
		end
	else
		logError(self.__cname .. " resource not load: " .. resPath)
	end

	return nil
end

function BaseRoleStoryView:show(force)
	if self.isShow and not force then
		return
	end

	self.isShow = true

	if not self.viewGO then
		self:_loadPrefab()

		return
	end

	gohelper.setActive(self.viewGO, true)
	self:onShow()
end

function BaseRoleStoryView:hide(force)
	if not self.isShow and not force then
		return
	end

	self.isShow = false

	if not self.viewGO then
		return
	end

	gohelper.setActive(self.viewGO, false)
	self:onHide()
end

function BaseRoleStoryView:destory()
	self:removeEvents()
	self:onDestroyView()

	if self._abLoader then
		self._abLoader:dispose()

		self._abLoader = nil
	end

	if self.viewGO then
		gohelper.destroy(self.viewGO)

		self.viewGO = nil
	end

	self:__onDispose()
end

function BaseRoleStoryView:onInit()
	return
end

function BaseRoleStoryView:onInitView()
	return
end

function BaseRoleStoryView:addEvents()
	return
end

function BaseRoleStoryView:removeEvents()
	return
end

function BaseRoleStoryView:onShow()
	return
end

function BaseRoleStoryView:onHide()
	return
end

function BaseRoleStoryView:onDestroyView()
	return
end

return BaseRoleStoryView
