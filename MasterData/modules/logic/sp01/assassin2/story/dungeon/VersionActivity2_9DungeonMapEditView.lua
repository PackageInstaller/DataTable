-- chunkname: @modules/logic/sp01/assassin2/story/dungeon/VersionActivity2_9DungeonMapEditView.lua

module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonMapEditView", package.seeall)

local VersionActivity2_9DungeonMapEditView = class("VersionActivity2_9DungeonMapEditView", BaseView)

function VersionActivity2_9DungeonMapEditView:onInitView()
	self._mapScene = self.viewContainer.mapScene
	self._isEditMode = false

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_9DungeonMapEditView:addEvents()
	self.frameHandle = UpdateBeat:CreateListener(self.onFrame, self)

	UpdateBeat:AddListener(self.frameHandle)
end

function VersionActivity2_9DungeonMapEditView:removeEvents()
	if self.frameHandle then
		UpdateBeat:RemoveListener(self.frameHandle)
	end
end

function VersionActivity2_9DungeonMapEditView:onFrame()
	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.Q) then
		self._isEditMode = not self._isEditMode

		if self._isEditMode then
			GameFacade.showToastString("EnterEditMode")
		else
			GameFacade.showToastString("ExitEditMode")
		end
	end

	if not self._isEditMode then
		return
	end

	if not self._mapScene then
		return
	end

	self._mapScene:_brocastAllNodePos()
end

return VersionActivity2_9DungeonMapEditView
