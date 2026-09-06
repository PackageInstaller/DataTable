-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewhandwelfareprivilegeView.lua

module("logic.extensions.newhandwelfare.view.NewhandwelfareprivilegeView", package.seeall)

local NewhandwelfareprivilegeView = class("NewhandwelfareprivilegeView", ViewComponent)

function NewhandwelfareprivilegeView:ctor()
	NewhandwelfareprivilegeView.super.ctor(self)
end

function NewhandwelfareprivilegeView:unbindEvents()
	NewhandwelfareprivilegeView.super.unbindEvents(self)
end

function NewhandwelfareprivilegeView:bindEvents()
	NewhandwelfareprivilegeView.super.bindEvents(self)
end

function NewhandwelfareprivilegeView:buildUI()
	NewhandwelfareprivilegeView.super.buildUI(self)

	self._cellsconGo = self:getGo("cellscon")
	self._cellGo = self:getGo("cell")
	self._txtLeftTime = self:getTxt("leftTime/txt")

	goutil.setActive(self._cellGo, false)

	self._cellGos = {}
	self._layoutComp = self._cellsconGo:GetComponent(ComponentType.UILayoutSingleLine)
end

function NewhandwelfareprivilegeView:onExit()
	NewhandwelfareprivilegeView.super.onExit(self)
	removetimer(self._onTicking, self)

	for k, v in pairs(self._cellGos) do
		self:_clearCell(v)
	end
end

function NewhandwelfareprivilegeView:onEnter()
	NewhandwelfareprivilegeView.super.onEnter(self)
	self.addGEvent(self, NewhandwelfareController.NewHandWelfareGetInfoRes, self._updateTime, self)

	self._periodId = NewhandwelfareModel.instance:getPeriodId()

	if self._periodId <= 0 then
		printError("没有开启的新手福利期数")

		return
	end

	NewHandWelfareAgent.instance:sendNewHandWelfareGetInfoReq()
	self:_updateTime()
	self:_onTicking()
	self:_buildJumpCells()
	self:_updateCells()
end

function NewhandwelfareprivilegeView:_updateTime()
	self._endTime = NewhandwelfareModel.instance:getNewHandPlayerEndTime()

	settimer(1, self._onTicking, self, true)
	self:_onTicking()
end

function NewhandwelfareprivilegeView:_onTicking()
	local leftTime = Mathf.Max(self._endTime - ServerTime.now(), 0)

	self._txtLeftTime.text = GameUtil.FormatTimeWordsNoSec(leftTime)

	if leftTime <= 0 then
		leftTime = 0

		removetimer(self._onTicking, self)
	end
end

function NewhandwelfareprivilegeView:_buildJumpCells()
	local cfgs = NewhandwelfareConfig.instance:getPrivilegeViewCfgs()

	for i, v in ipairs(cfgs) do
		local go = self._cellGos[i]

		if not go then
			go = goutil.cloneAndSetParent(self._cellGo, self._cellsconGo.transform)
			self._cellGos[i] = go

			goutil.setActive(go, true)
		end
	end

	self._layoutComp:Layout()
end

function NewhandwelfareprivilegeView:_updateCells()
	local cfgs = NewhandwelfareConfig.instance:getPrivilegeViewCfgs()

	for i, v in ipairs(cfgs) do
		local go = self._cellGos[i]

		self:_updateCell(go, v)
	end
end

function NewhandwelfareprivilegeView:_updateCell(cell, cfg)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local icon = goutil.findChild(cell.gameObject, "icon")

	txtName.text = cfg.tabName

	local spriteName = GameUrl.getBigbgPngUrl(cfg.iconPath)

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, spriteName, function()
		icon:GetComponent(goutil.Type_UIImage):SetNativeSize()
	end)
	btn:AddClickListener(function()
		GotoMgr.gotoByString(cfg.jumpTo)

		if not ViewSetting.instance:isFullScreen(self._viewPresentor.viewName) then
			self:close()
		end
	end)
end

function NewhandwelfareprivilegeView:_clearCell(cell)
	local icon = goutil.findChild(cell.gameObject, "icon")

	uGuiUtil.clearImage(icon)
end

return NewhandwelfareprivilegeView
