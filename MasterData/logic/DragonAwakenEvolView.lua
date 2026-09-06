-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonawaken/view/DragonAwakenEvolView.lua

module("logic.extensions.dragonawaken.view.DragonAwakenEvolView", package.seeall)

local DragonAwakenEvolView = class("DragonAwakenEvolView", ViewComponent)

function DragonAwakenEvolView:ctor()
	DragonAwakenEvolView.super.ctor(self)
end

function DragonAwakenEvolView:unbindEvents()
	DragonAwakenEvolView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnGoto)
end

function DragonAwakenEvolView:bindEvents()
	DragonAwakenEvolView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnGoto, self.close, self)
end

function DragonAwakenEvolView:buildUI()
	DragonAwakenEvolView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnGoto = self:getGo("showDetail/btnGoto")
	self._txtTitle = self:getTxt("showDetail/txtTitle")
	self._txtDesc = self:getTxt("showDetail/txtDesc")
	self._role = self:getGo("showDetail/roleCon/role")
end

function DragonAwakenEvolView:onExit()
	DragonAwakenEvolView.super.onExit(self)
	uGuiUtil.clearImage(self._role)

	local cfg = self:getFirstParam()

	GlobalDispatcher:dispatch(GlobalNotify.StartStory, cfg.plotId)
end

function DragonAwakenEvolView:onEnter()
	DragonAwakenEvolView.super.onEnter(self)

	local cfg = self:getFirstParam()

	if cfg then
		self._txtDesc.text = cfg.evolDesc

		local petcfg = DragonAwakenConfig.instance:getSupportCfgByPhaseId(cfg.activityId, cfg.phaseId)

		if petcfg then
			self._txtTitle.text = petcfg.creepsName

			local skinId = checknumber(petcfg.faceId)

			if skinId <= 0 then
				skinId = petcfg.raceId
			end

			local modelCo = CharacterConfig.instance:getModelCo(skinId)
			local imgUrl = GameUrl.getPetImgUrl(modelCo.cardName)

			uGuiUtil.setSpriteToImage(self._role, uGuiUtil.SpriteType.BigBg, imgUrl, function()
				self._role:GetComponent("Image"):SetNativeSize()

				self._role:GetComponent("Image").raycastTarget = false
			end)
		end
	end
end

return DragonAwakenEvolView
