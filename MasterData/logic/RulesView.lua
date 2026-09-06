-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rules/view/RulesView.lua

module("logic.extensions.rules.view.RulesView", package.seeall)

local RulesView = class("RulesView", FlyTweenBase)

function RulesView:bindEvents()
	self._closeBtn:AddClickListener(self._onClickClose, self)
end

function RulesView:unbindEvents()
	self._closeBtn:RemoveClickListener()
end

function RulesView:buildUI()
	self._txtTitle = self:getTxt("txtTitle")
	self._contentView = self:getGo("View"):GetComponent("ScrollRect")
	self._viewportSize = self._contentView.viewport.rect.height
	self._content = self._contentView.content
	self._txtRules = self:getTxt("View/Viewport/Content/txtRules")
	self._closeBtn = self:getBtn("btnClose")
end

function RulesView:destroyUI()
	RulesView.super.destroyUI(self)
end

function RulesView:onEnter()
	self._txtTitle.text = "规则说明"

	local key = self:getFirstParam()
	local ruleCo = RulesConfig.instance:getRuleCo(key)

	if not ruleCo then
		if enableDebug then
			self._txtRules.text = string.format("策划请配置 export_说明规则  in  s说明规则.xlsx :  %s", tostring(key))
		end

		return
	end

	local title = tostring(ruleCo.title or 0)

	if not title or title == "0" or #title == 0 then
		title = lang("tip")
	end

	self._txtTitle.text = title
	self._txtRules.text = "<color=#466887>" .. ruleCo.rules .. "</color>"
	self._txtRules.fontSize = 24

	local x, y = Framework.TransformUtil.GetAnchoredPos(self._txtRules.transform, nil, nil)
	local preHeight = self._txtRules.preferredHeight
	local sizeDelta = self._content.sizeDelta

	sizeDelta.y = math.abs(y) * 2 + preHeight
	self._content.sizeDelta = sizeDelta
	self._contentView.enabled = sizeDelta.y > self._viewportSize

	Framework.TransformUtil.SetLocalPos(self._content.transform, 0, 0, 0)
	self:_resetFlyTween()

	local params = self:getOpenParam()

	if params and params[2] then
		local targetGo = params[2]

		self:_setUIFlyTweenParam({
			endPosition = GameUtil.getPos(targetGo),
			reset = function()
				return
			end
		})
	end
end

function RulesView:onEnterFinished()
	RulesView.super.onEnterFinished(self)
end

function RulesView:onExitFinished()
	RulesView.super.onExitFinished(self)
	GlobalDispatcher:dispatch(GlobalNotify.RULES_VIEW_EXIT)
end

function RulesView:_onClickClose()
	local function closeCallback()
		self:close()
	end

	self:_doCloseCallback(closeCallback)
end

return RulesView
