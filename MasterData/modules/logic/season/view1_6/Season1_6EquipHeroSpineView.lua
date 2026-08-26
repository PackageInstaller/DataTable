-- chunkname: @modules/logic/season/view1_6/Season1_6EquipHeroSpineView.lua

module("modules.logic.season.view1_6.Season1_6EquipHeroSpineView", package.seeall)

local Season1_6EquipHeroSpineView = class("Season1_6EquipHeroSpineView", BaseView)

function Season1_6EquipHeroSpineView:onInitView()
	self._gospine = gohelper.findChild(self.viewGO, "#go_normal/left/#go_herocontainer/dynamiccontainer/#go_spine")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season1_6EquipHeroSpineView:addEvents()
	return
end

function Season1_6EquipHeroSpineView:removeEvents()
	return
end

function Season1_6EquipHeroSpineView:_editableInitView()
	self._uiSpine = GuiSpine.Create(self._gospine, true)

	self:createSpine()
end

function Season1_6EquipHeroSpineView:onDestroyView()
	if self._uiSpine then
		self._uiSpine:onDestroy()

		self._uiSpine = nil
	end
end

function Season1_6EquipHeroSpineView:onOpen()
	return
end

function Season1_6EquipHeroSpineView:onClose()
	return
end

function Season1_6EquipHeroSpineView:createSpine()
	local resPath = ResUrl.getRolesCgStory(Activity104Enum.MainRoleSkinPath)

	self._uiSpine:setResPath(resPath, self.onSpineLoaded, self)
end

function Season1_6EquipHeroSpineView:onSpineLoaded()
	self._spineLoaded = true

	if self._uiSpine then
		self._uiSpine:changeLookDir(SpineLookDir.Left)
		self._uiSpine:SetAnimation(BaseSpine.FaceTrackIndex, "idle", true, 0)
	end
end

return Season1_6EquipHeroSpineView
