-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/warriortower/view/WarriormaintowerView.lua

module("logic.extensions.warriortower.view.WarriormaintowerView", package.seeall)

local WarriormaintowerView = class("WarriormaintowerView", ViewComponent)

function WarriormaintowerView:ctor()
	WarriormaintowerView.super.ctor(self)
end

function WarriormaintowerView:buildUI()
	WarriormaintowerView.super.buildUI(self)

	self._closeButton = self:getBtn("topLeft/btnClose")
	self._btnHelp = self:getBtn("topLeft/btnHelp")
	self.cells = {}

	for key, towerId in pairs(WTowerModel.TowerType) do
		self.cells[towerId] = {}

		local btnGo = goutil.findChild(self.mainGO, "btn" .. key)

		self.cells[towerId].btn = Framework.ButtonAdapter.Get(btnGo)
		self.cells[towerId].redpoint = goutil.findChild(btnGo, "redPoint")
	end
end

function WarriormaintowerView:bindEvents()
	WarriormaintowerView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnHelp:AddClickListener(self._onClickBtnHelp, self)
end

function WarriormaintowerView:unbindEvents()
	WarriormaintowerView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnHelp:RemoveClickListener()
end

function WarriormaintowerView:destroyUI()
	WarriormaintowerView.super.destroyUI(self)
end

function WarriormaintowerView:onEnter()
	WarriormaintowerView.super.onEnter(self)
	self:refresh()
end

function WarriormaintowerView:onEnterFinished()
	WarriormaintowerView.super.onEnterFinished(self)
end

function WarriormaintowerView:onExit()
	WarriormaintowerView.super.onExit(self)

	self.fromBranch = false

	for i, v in pairs(self.cells) do
		v.btn:RemoveClickListener()
	end
end

function WarriormaintowerView:refresh()
	for key, towerId in pairs(WTowerModel.TowerType) do
		self.cells[towerId].btn:AddClickListener(function()
			self:_onClickBtn(towerId)
		end)

		local lock = goutil.findChild(self.mainGO, "btn" .. key .. "/lock")
		local unlock = WTowerController.instance:getIfTowerUnlock(towerId)

		goutil.setActive(lock, not unlock)

		local GoOpenTime = goutil.findChild(self.mainGO, "btn" .. key .. "/txtOpen")

		goutil.setActive(GoOpenTime, not unlock)

		local txtOpen = goutil.findChildTextComponent(self.mainGO, "btn" .. key .. "/txtOpen")
		local openTime = WTowerConfig.instance:getDicCfg(towerId).periods
		local str = ""

		for k, v in pairs(openTime) do
			if str ~= "" then
				str = str .. ","
			end

			str = str .. GameUtil.getChineseNumber(v)
		end

		txtOpen.text = string.format("每周\n%s开放", str)

		local canGetBonus = WTowerController.instance:getIfCanGetBonus(towerId)

		goutil.setActive(self.cells[towerId].redpoint, unlock and (canGetBonus or RedPointModel.instance:isActive(RedPointModel.ID_PETDISPATCH)))

		local GoTxtLevel = goutil.findChild(self.mainGO, "btn" .. key .. "/txtLevel")

		goutil.setActive(GoTxtLevel, unlock)

		local txtLevel = goutil.findChildTextComponent(self.mainGO, "btn" .. key .. "/txtLevel")
		local curLevel = WTowerModel.instance:getCurLevel(towerId)
		local maxLevel = WTowerConfig.instance:getCfgCount(towerId)

		if maxLevel < curLevel then
			curLevel = maxLevel
		end

		txtLevel.text = tostring(curLevel) .. "层"
	end
end

function WarriormaintowerView:_onClickBtn(type)
	if WTowerController.instance:getIfTowerUnlock(type) then
		WTowerController.instance:openBranchTower(type)
	else
		FloatWordMgr.instance:show("还没解锁哦")
	end
end

function WarriormaintowerView:onExitFinished()
	WarriormaintowerView.super.onExitFinished(self)
end

function WarriormaintowerView:_onClickClose()
	self:close()
end

function WarriormaintowerView:_onClickBtnHelp()
	UIStateManager.instance:push(ViewName.RulesView, "warriormaintower")
end

return WarriormaintowerView
