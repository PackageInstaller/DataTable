-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineisaacclg/view/DivineisaacclgfactoryView.lua

module("logic.extensions.divineisaacclg.view.DivineisaacclgfactoryView", package.seeall)

local DivineisaacclgfactoryView = class("DivineisaacclgfactoryView", ViewComponent)

function DivineisaacclgfactoryView:ctor()
	DivineisaacclgfactoryView.super.ctor(self)
end

function DivineisaacclgfactoryView:unbindEvents()
	DivineisaacclgfactoryView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function DivineisaacclgfactoryView:bindEvents()
	DivineisaacclgfactoryView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function DivineisaacclgfactoryView:buildUI()
	DivineisaacclgfactoryView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._lefttablecellGo = self:getGo("lefttablecell")
	self._lefttableviewGo = self:getGo("lefttableview")
	self._btnClose = self:getBtn("btnClose")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._leftscrollerList = ScrollerList.create(self._lefttableviewGo, self._lefttablecellGo, GameUtil.handler(self._updateLeftCell, self), GameUtil.handler(self._clearLeftCell, self))
end

function DivineisaacclgfactoryView:onExit()
	DivineisaacclgfactoryView.super.onExit(self)
	self._scrollerList:dispose()
	self._leftscrollerList:dispose()
end

function DivineisaacclgfactoryView:onEnter()
	DivineisaacclgfactoryView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineIsaacClgInfoRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.DivineIsaacClgProducePuppetRes, self._updateUI, self)

	local params = self:getOpenParam() or {}

	self._activityId = params[1]
	self._phaseId = params[2]
	self._metalCfgs = DivineisaacclgConfig.instance:getMetalResCfgs()
	self._puppetCfgs = DivineisaacclgConfig.instance:getPuppetCfgs(self._activityId, self._phaseId)

	self:_updateUI()
end

function DivineisaacclgfactoryView:_updateUI()
	self._leftscrollerList:reloadData(self._metalCfgs)
	self._scrollerList:reloadData(self._puppetCfgs)
end

function DivineisaacclgfactoryView:_onClickbtnClose()
	self:close()
end

function DivineisaacclgfactoryView:_updateCell(view, cell, data, tag)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local goIcon = goutil.findChild(cell.gameObject, "icon")
	local metalLayout = goutil.findChild(cell.gameObject, "metal"):GetComponent(ComponentType.UILayoutSingleLine)
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")
	local formula = data.formula
	local formulaArr = string.split(formula, "#")
	local formulaCnt = #formulaArr

	for i = 1, 3 do
		local go = goutil.findChild(metalLayout.gameObject, "item" .. i)

		goutil.setActive(go, i <= formulaCnt)

		if i <= formulaCnt then
			self:_updateMetalItem(go, formulaArr[i])
		end
	end

	local puppetCfg = DivineisaacclgConfig.instance:getClientPuppetCfg(data.puppetId)

	uGuiUtil.setSpriteToImage(goIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(puppetCfg.iconName))

	txtDesc.text = data.buffDesc
	txtNum.text = DivineisaacclgModel.instance:getPuppetNum(self._activityId, data.puppetId)

	metalLayout:Layout()
	btn:AddClickListener(function()
		for i, v in ipairs(formulaArr) do
			local arr = string.split(v, ":")
			local metalId = checknumber(arr[1])
			local metalNum = checknumber(arr[2])
			local hasMetalNum = DivineisaacclgModel.instance:getMetalNum(self._activityId, metalId)

			if hasMetalNum < metalNum then
				FloatWordMgr.instance:show("材料不足，无法打造")

				return
			end
		end

		DivineIsaacClgAgent.instance:sendPM_DivineIsaacClgProducePuppetReq(self._activityId, self._phaseId, data.puppetId)
	end)
end

function DivineisaacclgfactoryView:_updateMetalItem(go, str)
	local goItem = goutil.findChild(go, "item")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local arr = string.split(str, ":")
	local metalId = checknumber(arr[1])
	local metalNum = checknumber(arr[2])
	local hasMetalNum = DivineisaacclgModel.instance:getMetalNum(self._activityId, metalId)
	local metalCfg = DivineisaacclgConfig.instance:getMetalResCfg(metalId)

	MaterialMgr.setCellByCfg(metalCfg.clientMatStr, goItem)

	txtDesc.text = string.format("<color=%s>%s</color>/%s", metalNum <= hasMetalNum and "green" or "#FF8181", hasMetalNum, metalNum)
end

function DivineisaacclgfactoryView:_clearCell(cell)
	local root = goutil.findChild(cell.gameObject, "metal")

	for i = 1, 3 do
		local go = goutil.findChild(root, "item" .. i .. "/item")

		MaterialMgr.resetAll(go)
	end
end

function DivineisaacclgfactoryView:_updateLeftCell(view, cell, data, tag)
	local goItem = goutil.findChild(cell.gameObject, "item")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")

	MaterialMgr.setCellByCfg(data.clientMatStr, goItem)

	txtDesc.text = string.format("x%s", DivineisaacclgModel.instance:getMetalNum(self._activityId, data.metalId))
end

function DivineisaacclgfactoryView:_clearLeftCell(cell)
	local goItem = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(goItem)
end

return DivineisaacclgfactoryView
