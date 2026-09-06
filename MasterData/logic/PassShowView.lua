-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/PassShowView.lua

module("logic.extensions.legend.view.PassShowView", package.seeall)

local PassShowView = class("PassShowView", ViewComponent)

function PassShowView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._roleGo = self:getGo("role")
	self._txtDesc = self:getTxt("txtDesc")
end

function PassShowView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function PassShowView:unbindEvents()
	self._closeButton:RemoveClickListener()
end

function PassShowView:onEnter()
	local param = self:getFirstParam()

	if not param then
		return
	end

	self._param = param
	self._txtDesc.text = param.desc

	self:_loadRole(param.raceId)
end

function PassShowView:onExit()
	self:_removeRole()
end

function PassShowView:_onClickClose()
	local callback = self._param.callback

	self:close()

	if callback then
		callback()
	end
end

function PassShowView:_loadRole(raceId)
	if not raceId or raceId == 0 then
		return
	end

	local cfg = CharacterConfig.instance:getPetCo(raceId)

	if not cfg then
		return
	end

	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(checknumber(cfg.faceIds))
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_removeRole()

	local isAuto = true
	local callback

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, cfg.faceIds, self._roleGo, scale, callback, isAuto, x, y)
end

function PassShowView:_removeRole()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

return PassShowView
