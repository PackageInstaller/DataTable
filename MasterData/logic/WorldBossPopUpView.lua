-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldboss/view/WorldBossPopUpView.lua

module("logic.extensions.worldboss.view.WorldBossPopUpView", package.seeall)

local WorldBossPopUpView = class("WorldBossPopUpView", ViewComponent)

function WorldBossPopUpView:ctor()
	WorldBossPopUpView.super.ctor(self)
end

function WorldBossPopUpView:buildUI()
	WorldBossPopUpView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._iconClose = self._btnClose.gameObject:GetComponent("UIImageSpriteChange")
	self._main = self:getGo("main")
	self._btnGoChallenge = self:getBtn("btnGoChallenge")
	self._txtGoChallenge = self:getGo("btnGoChallenge/txt"):GetComponent("Text")
end

function WorldBossPopUpView:bindEvents()
	WorldBossPopUpView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
	self._btnGoChallenge:AddClickListener(self._onClickBtnGoChallenge, self)
end

function WorldBossPopUpView:unbindEvents()
	WorldBossPopUpView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnGoChallenge:RemoveClickListener()
end

function WorldBossPopUpView:destroyUI()
	WorldBossPopUpView.super.destroyUI(self)
end

function WorldBossPopUpView:onEnter()
	WorldBossPopUpView.super.onEnter(self)

	local _todayBossId = WorldBossController.instance:getTodayBossId()

	if _todayBossId then
		local _enemyTeamInfo = WorldBossController.instance:getEnemyTeamInfo(_todayBossId)

		if _enemyTeamInfo then
			self._iconClose:SetState(_enemyTeamInfo.nameId)
			uGuiUtil.setSpriteToImage(self._main, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgPngUrl("worldboss/" .. _enemyTeamInfo.popBg))
		end
	end
end

function WorldBossPopUpView:onEnterFinished()
	WorldBossPopUpView.super.onEnterFinished(self)
end

function WorldBossPopUpView:onExit()
	WorldBossPopUpView.super.onExit(self)
end

function WorldBossPopUpView:onExitFinished()
	WorldBossPopUpView.super.onExitFinished(self)
end

function WorldBossPopUpView:_onClickBtnClose()
	self:close()
end

function WorldBossPopUpView:_onClickBtnGoChallenge()
	TaskController.instance:foreceClearState()
	self:close()
	WorldBossController.instance:goToWorldBoss()
end

return WorldBossPopUpView
