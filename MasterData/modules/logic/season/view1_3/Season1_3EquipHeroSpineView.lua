-- chunkname: @modules/logic/season/view1_3/Season1_3EquipHeroSpineView.lua

module("modules.logic.season.view1_3.Season1_3EquipHeroSpineView", package.seeall)

local Season1_3EquipHeroSpineView = class("Season1_3EquipHeroSpineView", BaseView)

function Season1_3EquipHeroSpineView:onInitView()
	self._gospine = gohelper.findChild(self.viewGO, "#go_normal/left/#go_herocontainer/dynamiccontainer/#go_spine")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season1_3EquipHeroSpineView:addEvents()
	return
end

function Season1_3EquipHeroSpineView:removeEvents()
	return
end

function Season1_3EquipHeroSpineView:_editableInitView()
	self._uiSpine = GuiSpine.Create(self._gospine, true)

	self:createSpine()
end

function Season1_3EquipHeroSpineView:onDestroyView()
	if self._uiSpine then
		self._uiSpine:onDestroy()

		self._uiSpine = nil
	end
end

function Season1_3EquipHeroSpineView:onOpen()
	return
end

function Season1_3EquipHeroSpineView:onClose()
	return
end

function Season1_3EquipHeroSpineView:createSpine()
	local resPath = ResUrl.getRolesCgStory(Activity104Enum.MainRoleSkinPath)

	self._uiSpine:setResPath(resPath, self.onSpineLoaded, self)
end

function Season1_3EquipHeroSpineView:onSpineLoaded()
	self._spineLoaded = true

	if self._uiSpine then
		self._uiSpine:changeLookDir(SpineLookDir.Left)
		self._uiSpine:SetAnimation(BaseSpine.FaceTrackIndex, "idle", true, 0)
	end
end

return Season1_3EquipHeroSpineView
