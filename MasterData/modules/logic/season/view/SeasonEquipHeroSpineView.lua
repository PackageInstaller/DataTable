-- chunkname: @modules/logic/season/view/SeasonEquipHeroSpineView.lua

module("modules.logic.season.view.SeasonEquipHeroSpineView", package.seeall)

local SeasonEquipHeroSpineView = class("SeasonEquipHeroSpineView", BaseView)

function SeasonEquipHeroSpineView:onInitView()
	self._gospine = gohelper.findChild(self.viewGO, "#go_normal/left/#go_herocontainer/dynamiccontainer/#go_spine")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SeasonEquipHeroSpineView:addEvents()
	return
end

function SeasonEquipHeroSpineView:removeEvents()
	return
end

function SeasonEquipHeroSpineView:_editableInitView()
	self._uiSpine = GuiSpine.Create(self._gospine, true)

	self:createSpine()
end

function SeasonEquipHeroSpineView:onDestroyView()
	if self._uiSpine then
		self._uiSpine:onDestroy()

		self._uiSpine = nil
	end
end

function SeasonEquipHeroSpineView:onOpen()
	return
end

function SeasonEquipHeroSpineView:onClose()
	return
end

function SeasonEquipHeroSpineView:createSpine()
	local resPath = ResUrl.getRolesCgStory(Activity104Enum.MainRoleSkinPath)

	self._uiSpine:setResPath(resPath, self.onSpineLoaded, self)
end

function SeasonEquipHeroSpineView:onSpineLoaded()
	self._spineLoaded = true

	if self._uiSpine then
		self._uiSpine:changeLookDir(SpineLookDir.Left)
		self._uiSpine:SetAnimation(BaseSpine.FaceTrackIndex, "idle", true, 0)
	end
end

return SeasonEquipHeroSpineView
