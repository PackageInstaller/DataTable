-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/christmasandnewyear/SystemupgradeView.lua

module("logic.extensions.bonus.view.christmasandnewyear.SystemupgradeView", package.seeall)

local SystemupgradeView = class("SystemupgradeView", SummarySubTabView)

function SystemupgradeView:ctor()
	SystemupgradeView.super.ctor(self)
end

function SystemupgradeView:init()
	SystemupgradeView.super.init(self)

	self.petIdCfg = checknumber(self._cfgs[1].background)
end

function SystemupgradeView:unbindEvents()
	SystemupgradeView.super.unbindEvents(self)
end

function SystemupgradeView:bindEvents()
	SystemupgradeView.super.bindEvents(self)
end

function SystemupgradeView:buildUI()
	SystemupgradeView.super.buildUI(self)

	self._con = self:getGo("con")
	self.tableview = self:getGo("tableview")
	self.cell = self:getGo("cell")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function SystemupgradeView:onExit()
	self.role = RoleObjectPool.instance:removeRole(self.role)

	self.scrollList:dispose()
	SystemupgradeView.super.onExit(self)
end

function SystemupgradeView:onEnter()
	SystemupgradeView.super.onEnter(self)
	self.scrollList:reloadData(self._cfgs)
	self:updateUI()
end

function SystemupgradeView:updateUI()
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(self.petIdCfg)

	if not modelCfg[1] then
		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self.role = RoleObjectPool.instance:addRoleToParent(self.role, self.petIdCfg, self._con, scale, nil, true, modelCfg[1], y)
			end
		end
	end
end

function SystemupgradeView:_updateCell(view, cell, data)
	local txt = goutil.findChildTextComponent(cell, "txt")
	local btnGoto = goutil.findChild(cell, "btnGoto")
	local txtTag = goutil.findChildTextComponent(cell, "tag/Text")
	local txtArr = string.split(data.params, "#")

	txtTag.text = txtArr[1]
	txt.text = txtArr[2]

	GameUtil.addClickHandler(btnGoto, GameUtil.handler(self._onJump, self, data))
end

function SystemupgradeView:clearCell(cell)
	local btnGoto = goutil.findChild(cell, "btnGoto")

	GameUtil.rmClickHandler(btnGoto)
end

function SystemupgradeView:buildBtnJump()
	return
end

return SystemupgradeView
