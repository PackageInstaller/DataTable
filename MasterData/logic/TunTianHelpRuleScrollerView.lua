-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tuntianhelp/view/TunTianHelpRuleScrollerView.lua

module("logic.extensions.tuntianhelp.view.TunTianHelpRuleScrollerView", package.seeall)

local TunTianHelpRuleScrollerView = class("TunTianHelpRuleScrollerView", ViewComponent)

function TunTianHelpRuleScrollerView:buildUI()
	TunTianHelpRuleScrollerView.super.buildUI(self)

	local ruleScrollerview = goutil.findChild(self.mainGO, "ruleCol/ruleScrollerview")
	local ruleScrollercell = goutil.findChild(self.mainGO, "ruleCol/ruleScrollercell")

	self._ruleScrollList = ScrollerList.create(ruleScrollerview, ruleScrollercell, GameUtil.handler(self._updateRuleCell, self), GameUtil.handler(self._clearRuleCell, self))
	self._customInput = UICustomInput.Get(self.mainGO)
end

function TunTianHelpRuleScrollerView:bindEvents()
	TunTianHelpRuleScrollerView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function TunTianHelpRuleScrollerView:unbindEvents()
	TunTianHelpRuleScrollerView.super.unbindEvents(self)
	self._customInput:RemoveListener()
end

function TunTianHelpRuleScrollerView:onEnter()
	TunTianHelpRuleScrollerView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._rulePlanId = checknumber(params[1])

	if self._rulePlanId <= 0 then
		local text = "缺失rulePlanId"

		local function func()
			self:close()
		end

		local btnText = "确定"
		local alignment = UnityEngine.TextAnchor.MiddleCenter

		TipsFacade.instance:openTipWindow("提示", text, func, btnText, alignment)

		return
	end

	self:_onSetUI()
	self:_onUpdate()
end

function TunTianHelpRuleScrollerView:onExit()
	TunTianHelpRuleScrollerView.super.onExit(self)
	self:_onClearRuleCol()
end

function TunTianHelpRuleScrollerView:_onSetUI()
	return
end

function TunTianHelpRuleScrollerView:_onUpdate()
	self:_onUpdateRuleColUI()
end

function TunTianHelpRuleScrollerView:_onUpdateRuleColUI()
	local dataList = TunTianHelpConfig.instance:getTthRuleDataList(self._rulePlanId)

	self._ruleScrollList:reloadData(dataList)
end

function TunTianHelpRuleScrollerView:_onClearRuleCol()
	self._ruleScrollList:dispose()
end

function TunTianHelpRuleScrollerView:_updateRuleCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local imgRule = goutil.findChild(mainGo, "imgRule")
	local txtRule = goutil.findChildTextComponent(mainGo, "txtRule")
	local path = data.picturePath
	local bgGo = imgRule

	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/bigbg/%s.png", path)

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		uGuiUtil.clearImage(bgGo)
	end

	txtRule.text = data.desc
end

function TunTianHelpRuleScrollerView:_clearRuleCell(cell)
	local mainGo = cell.gameObject
	local imgRule = goutil.findChild(mainGo, "imgRule")

	uGuiUtil.clearImage(imgRule)
end

function TunTianHelpRuleScrollerView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

return TunTianHelpRuleScrollerView
