-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/EndlessbuyskinView.lua

module("logic.extensions.infinitefuture.view.EndlessbuyskinView", package.seeall)

local EndlessbuyskinView = class("EndlessbuyskinView", ViewComponent)

function EndlessbuyskinView:ctor()
	EndlessbuyskinView.super.ctor(self)
end

function EndlessbuyskinView:unbindEvents()
	EndlessbuyskinView.super.unbindEvents(self)
	self._btnGo:RemoveClickListener()
	self._skillBtn:RemoveClickListener()
	self._introduceBtn:RemoveClickListener()
end

function EndlessbuyskinView:bindEvents()
	EndlessbuyskinView.super.bindEvents(self)
	self._btnGo:AddClickListener(function()
		GotoMgr.gotoByString(self.curGoto)
	end, self)
	self._skillBtn:AddClickListener(function()
		PetbookController.instance:previewBattle(self.curPetId, self.curSkinId)
	end, self)
	self._introduceBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.PetskinView, PetskinView.TYPE_SHOP, self.curSkinId)
	end, self)
end

function EndlessbuyskinView:buildUI()
	EndlessbuyskinView.super.buildUI(self)

	self._btnGo = self:getBtn("btnGo")
	self._skillBtn = self:getBtn("petInfo/btnSkill")
	self._introduceBtn = self:getBtn("petInfo/btnInfo")
	self._sprintRareGo = self:getGo("petInfo/rare")
	self._sprintGo = self:getGo("con")
	self._receiveGo = self:getGo("receive")
end

function EndlessbuyskinView:onExit()
	EndlessbuyskinView.super.onExit(self)
end

function EndlessbuyskinView:onEnter()
	EndlessbuyskinView.super.onEnter(self)

	self.curGoto = InfinitefutureConfig.instance:getCommonCfg("challenge_skin_func")
	self.curPetId = checknumber(InfinitefutureConfig.instance:getCommonCfg("challenge_pet"))
	self.curSkinId = checknumber(InfinitefutureConfig.instance:getCommonCfg("challenge_skin"))

	local isGet = PetskinController.instance:checkHasForeverSkinBySkinId(self.curSkinId)

	self._receiveGo:SetActive(isGet)
	self:_showSpriteRawInfo()
end

function EndlessbuyskinView:_showSpriteRawInfo()
	local x, y, scale = 0, 0, 1

	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)
	self._roleModel = RoleObjectPool.instance:addRoleToParent(self._roleModel, self.curSkinId, self._sprintGo, scale, nil, true, x, y)
end

return EndlessbuyskinView
