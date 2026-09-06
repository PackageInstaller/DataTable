-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/copy/sphere/SphereGameMainCopyOfTourArenaView.lua

module("logic.extensions.tourarena.view.copy.sphere.SphereGameMainCopyOfTourArenaView", package.seeall)

local SphereGameMainCopyOfTourArenaView = class("SphereGameMainCopyOfTourArenaView", ViewComponent)

function SphereGameMainCopyOfTourArenaView:buildUI()
	local gameParent = self:getGo("main/spheregame")

	self._sphereGame = SphereGameCopyOfTourArena.New()

	self._sphereGame:buildUI(gameParent)

	self._btnClose = self:getBtn("topLeft/btnClose")
	self._roleGo = self:getGo("role")
	self._goldBar = self:getGo("goldBarCon")
end

function SphereGameMainCopyOfTourArenaView:destroyUI()
	self._sphereGame:destroyUI()
end

function SphereGameMainCopyOfTourArenaView:bindEvents()
	self._sphereGame:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function SphereGameMainCopyOfTourArenaView:unbindEvents()
	self._sphereGame:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function SphereGameMainCopyOfTourArenaView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.onSGClickGameOver, self._onClickGameOver, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._stagePlanId = checknumber(params[2])
	self._stageId = checknumber(params[3])
	self._finfishCallBack = params[4]

	self._sphereGame:onEnter(self._activityId, self._stagePlanId, self._stageId)
	self:_setGoldBar()
end

function SphereGameMainCopyOfTourArenaView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.onSGClickGameOver, self._onClickGameOver, self)
	self._sphereGame:onExit()
end

function SphereGameMainCopyOfTourArenaView:_onClickGameOver(info)
	if info == nil then
		info = {}
		info.isPass = false
		info.gameScore = 0
	end

	GameUtil.callBack(self._finfishCallBack, info)
	self:close()
end

function SphereGameMainCopyOfTourArenaView:_onClickClose()
	local text = lang("makecake_tip9")

	local function okFunc()
		local info = {}

		info.isPass = false
		info.gameScore = 0

		GlobalDispatcher:dispatch(GlobalNotify.onSGClickGameOver, info)
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc, nil, lang("confirm"), lang("cancel"))
end

function SphereGameMainCopyOfTourArenaView:_showRoleModel()
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

function SphereGameMainCopyOfTourArenaView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function SphereGameMainCopyOfTourArenaView:_setGoldBar()
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

return SphereGameMainCopyOfTourArenaView
