-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0EquipHeroSpineView.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0EquipHeroSpineView", package.seeall)

local Season123_2_0EquipHeroSpineView = class("Season123_2_0EquipHeroSpineView", BaseView)

function Season123_2_0EquipHeroSpineView:onInitView()
	self._gospine = gohelper.findChild(self.viewGO, "#go_normal/left/#go_herocontainer/dynamiccontainer/#go_spine")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_0EquipHeroSpineView:addEvents()
	return
end

function Season123_2_0EquipHeroSpineView:removeEvents()
	return
end

function Season123_2_0EquipHeroSpineView:_editableInitView()
	self._uiSpine = GuiSpine.Create(self._gospine, true)

	self:createSpine()
end

function Season123_2_0EquipHeroSpineView:onDestroyView()
	if self._uiSpine then
		self._uiSpine:onDestroy()

		self._uiSpine = nil
	end
end

function Season123_2_0EquipHeroSpineView:onOpen()
	return
end

function Season123_2_0EquipHeroSpineView:onClose()
	return
end

function Season123_2_0EquipHeroSpineView:createSpine()
	local resPath = ResUrl.getRolesCgStory(Activity104Enum.MainRoleSkinPath)

	self._uiSpine:setResPath(resPath, self.onSpineLoaded, self)
end

function Season123_2_0EquipHeroSpineView:onSpineLoaded()
	self._spineLoaded = true

	if self._uiSpine then
		self._uiSpine:changeLookDir(SpineLookDir.Left)
		self._uiSpine:SetAnimation(BaseSpine.FaceTrackIndex, "idle", true, 0)
	end
end

return Season123_2_0EquipHeroSpineView
