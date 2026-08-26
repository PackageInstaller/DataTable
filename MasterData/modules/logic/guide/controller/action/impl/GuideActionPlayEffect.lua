-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionPlayEffect.lua

module("modules.logic.guide.controller.action.impl.GuideActionPlayEffect", package.seeall)

local GuideActionPlayEffect = class("GuideActionPlayEffect", BaseGuideAction)

function GuideActionPlayEffect:onStart(context)
	GuideActionPlayEffect.super.onStart(self, context)

	local temp = string.split(self.actionParam, "#")

	self._effectRoot = temp[1]
	self._effectPathList = string.split(temp[2], ",")
	self._effectGoList = {}

	local loader = MultiAbLoader.New()

	self._loader = loader

	for i, v in ipairs(self._effectPathList) do
		loader:addPath(v)
	end

	loader:startLoad(self._loadedFinish, self)
	self:onDone(true)
end

function GuideActionPlayEffect:_loadedFinish(multiAbLoader)
	local rootGo = gohelper.find(self._effectRoot)

	for i, v in ipairs(self._effectPathList) do
		local assetItem = self._loader:getAssetItem(v)
		local mainPrefab = assetItem:GetResource(v)

		table.insert(self._effectGoList, gohelper.clone(mainPrefab, rootGo))
	end
end

function GuideActionPlayEffect:onDestroy()
	GuideActionPlayEffect.super.onDestroy(self)

	if self._loader then
		self._loader:dispose()
	end

	if self._effectGoList then
		for i, v in ipairs(self._effectGoList) do
			UnityEngine.GameObject.Destroy(v)
		end
	end
end

return GuideActionPlayEffect
