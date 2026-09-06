-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarycake/view/spheregame/SphereGameMainView.lua

module("logic.extensions.anniversarycake.view.spheregame.SphereGameMainView", package.seeall)

local SphereGameMainView = class("SphereGameMainView", ViewComponent)

function SphereGameMainView:buildUI()
	local gameParent = self:getGo("main/spheregame")

	self._sphereGame = SphereGame.New()

	self._sphereGame:buildUI(gameParent)

	self._btnClose = self:getBtn("topLeft/btnClose")
	self._roleGo = self:getGo("role")
	self._goldBar = self:getGo("goldBarCon")
end

function SphereGameMainView:destroyUI()
	self._sphereGame:destroyUI()
end

function SphereGameMainView:bindEvents()
	self._sphereGame:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function SphereGameMainView:unbindEvents()
	self._sphereGame:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function SphereGameMainView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.onSGClickGameOver, self._onClickGameOver, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._stagePlanId = checknumber(params[2])
	self._stageId = checknumber(params[3])
	self._finfishCallBack = params[4]

	self._sphereGame:onEnter(self._activityId, self._stagePlanId, self._stageId)
	self:_setGoldBar()
end

function SphereGameMainView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.onSGClickGameOver, self._onClickGameOver, self)
	self._sphereGame:onExit()
end

function SphereGameMainView:_onClickGameOver()
	self:close()
end

function SphereGameMainView:_onClickClose()
	local text = lang("makecake_tip9")

	local function okFunc()
		self:close()
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc, nil, lang("confirm"), lang("cancel"))
end

function SphereGameMainView:_showRoleModel()
	local curFaceId = 10287
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._roleGo, scale, nil, true, x, y)
end

function SphereGameMainView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function SphereGameMainView:_setGoldBar()
	local cfg = MakeCakeConfig.instance:getActivityCfg(self._activityId)

	if cfg == nil then
		return
	end

	local matMo = string.splitToNumber(cfg.addPipeCost, ":")
	local name = matMo[1] .. ":" .. matMo[2]
	local objList = {
		{
			showAdd = false,
			id = name
		}
	}

	MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, objList)
end

return SphereGameMainView
