-- chunkname: @modules/logic/season/view3_0/Season3_0EquipHeroSpineView.lua

module("modules.logic.season.view3_0.Season3_0EquipHeroSpineView", package.seeall)

local Season3_0EquipHeroSpineView = class("Season3_0EquipHeroSpineView", BaseView)

function Season3_0EquipHeroSpineView:onInitView()
	self._gospine = gohelper.findChild(self.viewGO, "#go_normal/left/#go_herocontainer/dynamiccontainer/#go_spine")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season3_0EquipHeroSpineView:addEvents()
	return
end

function Season3_0EquipHeroSpineView:removeEvents()
	return
end

function Season3_0EquipHeroSpineView:_editableInitView()
	self._uiSpine = GuiSpine.Create(self._gospine, true)

	self:createSpine()
end

function Season3_0EquipHeroSpineView:onDestroyView()
	if self._uiSpine then
		self._uiSpine:onDestroy()

		self._uiSpine = nil
	end
end

function Season3_0EquipHeroSpineView:onOpen()
	return
end

function Season3_0EquipHeroSpineView:onClose()
	return
end

function Season3_0EquipHeroSpineView:createSpine()
	local resPath = ResUrl.getRolesCgStory(Activity104Enum.MainRoleSkinPath)

	self._uiSpine:setResPath(resPath, self.onSpineLoaded, self)
end

function Season3_0EquipHeroSpineView:onSpineLoaded()
	self._spineLoaded = true

	if self._uiSpine then
		self._uiSpine:changeLookDir(SpineLookDir.Left)
		self._uiSpine:SetAnimation(BaseSpine.FaceTrackIndex, "idle", true, 0)
	end
end

return Season3_0EquipHeroSpineView
