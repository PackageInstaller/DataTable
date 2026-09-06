-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemixixi/view/DivineMiXiXiView.lua

module("logic.extensions.divinemixixi.view.DivineMiXiXiView", package.seeall)

local DivineMiXiXiView = class("DivineMiXiXiView", FireDimensionView)

function DivineMiXiXiView:ctor()
	DivineMiXiXiView.super.ctor(self)
end

function DivineMiXiXiView:unbindEvents()
	DivineMiXiXiView.super.unbindEvents(self)
end

function DivineMiXiXiView:bindEvents()
	DivineMiXiXiView.super.bindEvents(self)
end

function DivineMiXiXiView:buildUI()
	DivineMiXiXiView.super.buildUI(self)

	self._sprintGo = self:getGo("con")
	self._buffRoot = self:getGo("buffRoot")
	self._btns = {}
	self._items = {}

	for i = 1, 3 do
		self._btns[i] = self:getBtn("btn" .. tostring(i))

		local item = {}

		item.txtName = self:getTxt(string.format("btn%d/txtName", i))
		item.prizeGo = self:getGo(string.format("btn%d/item", i))
		item.txtDesc = MaterialMgr.findGraphicText(self.mainGO, string.format("btn%d/item/txt", i))
		item.lock = self:getGo(string.format("btn%d/lock", i))
		item.pass = self:getGo(string.format("btn%d/pass", i))
		item.redPoint = self:getGo(string.format("btn%d/redpoint", i))

		table.insert(self._items, item)
	end
end

function DivineMiXiXiView:onExit()
	DivineMiXiXiView.super.onExit(self)
	self:_resetRoleModel()
end

function DivineMiXiXiView:onEnter()
	DivineMiXiXiView.super.onEnter(self)

	if self._cfgActivity then
		SignInBuffController.instance:addCommonSignInBuffView(self._buffRoot, self._viewPresentor, self._activityId)
	end

	self:_showRoleModel()
end

function DivineMiXiXiView:_playEffect()
	return
end

function DivineMiXiXiView:_getMainEffect()
	return FireDimensionViewPresentor.Effect1
end

function DivineMiXiXiView:_showRoleModel()
	local curFaceId = self._raceId
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._sprintGo, scale, nil, true, x, y)
end

function DivineMiXiXiView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function DivineMiXiXiView:_onFireDimensionClgInfoRes()
	DivineMiXiXiView.super._onFireDimensionClgInfoRes(self)
end

return DivineMiXiXiView
