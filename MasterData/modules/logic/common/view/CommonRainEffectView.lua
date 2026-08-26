-- chunkname: @modules/logic/common/view/CommonRainEffectView.lua

module("modules.logic.common.view.CommonRainEffectView", package.seeall)

local CommonRainEffectView = class("CommonRainEffectView", BaseView)

function CommonRainEffectView:ctor(containerPath)
	CommonRainEffectView.super.ctor(self)

	self._containerPath = containerPath
end

function CommonRainEffectView:onInitView()
	self._goglowcontainer = gohelper.findChild(self.viewGO, self._containerPath)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommonRainEffectView:addEvents()
	return
end

function CommonRainEffectView:removeEvents()
	return
end

function CommonRainEffectView:_editableInitView()
	local glowUrl = "ui/viewres/effect/ui_character_rain.prefab"

	self._effectLoader = MultiAbLoader.New()

	self._effectLoader:addPath(glowUrl)
	self._effectLoader:startLoad(function(multiAbLoader)
		local glowAssetItem = self._effectLoader:getAssetItem(glowUrl)
		local glowPrefab = glowAssetItem:GetResource(glowUrl)

		gohelper.clone(glowPrefab, self._goglowcontainer)
	end)
end

function CommonRainEffectView:onOpen()
	return
end

function CommonRainEffectView:onClose()
	return
end

function CommonRainEffectView:onUpdateParam()
	return
end

function CommonRainEffectView:onDestroyView()
	if self._effectLoader then
		self._effectLoader:dispose()

		self._effectLoader = nil
	end
end

return CommonRainEffectView
