-- chunkname: @modules/logic/versionactivity1_9/heroinvitation/view/HeroInvitationDungeonMapScene.lua

module("modules.logic.versionactivity1_9.heroinvitation.view.HeroInvitationDungeonMapScene", package.seeall)

local HeroInvitationDungeonMapScene = class("HeroInvitationDungeonMapScene", DungeonMapScene)

function HeroInvitationDungeonMapScene:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_arrow")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroInvitationDungeonMapScene:_setInitPos(tween)
	if not self._mapCfg then
		return
	end

	local mapSceneElements = self.viewContainer.mapSceneElements

	if mapSceneElements._inRemoveElement then
		return
	end

	local elementId = mapSceneElements._inRemoveElementId

	if not elementId then
		local list = DungeonConfig.instance:getMapElements(self._mapCfg.id)

		if list then
			for i, v in ipairs(list) do
				local state = HeroInvitationModel.instance:getInvitationStateByElementId(v.id)

				if state ~= HeroInvitationEnum.InvitationState.TimeLocked and state ~= HeroInvitationEnum.InvitationState.ElementLocked and DungeonMapModel.instance:getElementById(v.id) then
					elementId = v.id

					break
				end
			end
		end
	end

	if elementId then
		DungeonMapModel.instance.directFocusElement = true

		self:_focusElementById(elementId)

		DungeonMapModel.instance.directFocusElement = false
	else
		local posParam = string.splitToNumber(self._mapCfg.initPos, "#")

		self:setScenePosSafety(Vector3(posParam[1], posParam[2], 0), tween)
	end
end

function HeroInvitationDungeonMapScene:_onOpenView(viewName)
	return
end

function HeroInvitationDungeonMapScene:_onCloseView(viewName)
	return
end

return HeroInvitationDungeonMapScene
