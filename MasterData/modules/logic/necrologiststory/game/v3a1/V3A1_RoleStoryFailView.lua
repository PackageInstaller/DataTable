-- chunkname: @modules/logic/necrologiststory/game/v3a1/V3A1_RoleStoryFailView.lua

module("modules.logic.necrologiststory.game.v3a1.V3A1_RoleStoryFailView", package.seeall)

local V3A1_RoleStoryFailView = class("V3A1_RoleStoryFailView", BaseView)

function V3A1_RoleStoryFailView:onInitView()
	self.btnExit = gohelper.findChildButtonWithAudio(self.viewGO, "root/btn/#btn_quitgame")
	self.btnReplay = gohelper.findChildButtonWithAudio(self.viewGO, "root/btn/#btn_restart")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3A1_RoleStoryFailView:addEvents()
	self.addClickCb(self, self.btnExit, self.onClickBtnExit, self)
	self.addClickCb(self, self.btnReplay, self.onClickBtnReplay, self)
end

function V3A1_RoleStoryFailView:removeEvents()
	self:removeClickCb(self.btnExit)
	self:removeClickCb(self.btnReplay)
end

function V3A1_RoleStoryFailView:_editableInitView()
	return
end

function V3A1_RoleStoryFailView:onClickModalMask()
	return
end

function V3A1_RoleStoryFailView:onClickBtnExit()
	local storyId = self.roleStoryId
	local gameMO = NecrologistStoryModel.instance:getGameMO(storyId)

	gameMO:setIsExitGame(true)
	NecrologistStoryController.instance:closeGameView(self.roleStoryId)
	self:closeThis()
end

function V3A1_RoleStoryFailView:onClickBtnReplay()
	self:closeThis()
end

function V3A1_RoleStoryFailView:onOpen()
	self.roleStoryId = self.viewParam.roleStoryId

	self:resetProgress()
end

function V3A1_RoleStoryFailView:resetProgress()
	local storyId = self.roleStoryId
	local gameMO = NecrologistStoryModel.instance:getGameMO(storyId)

	gameMO:resetProgressByFail()
end

function V3A1_RoleStoryFailView:onDestroyView()
	return
end

return V3A1_RoleStoryFailView
