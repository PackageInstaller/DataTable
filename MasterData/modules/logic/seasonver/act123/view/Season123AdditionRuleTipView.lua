-- chunkname: @modules/logic/seasonver/act123/view/Season123AdditionRuleTipView.lua

module("modules.logic.seasonver.act123.view.Season123AdditionRuleTipView", package.seeall)

local Season123AdditionRuleTipView = class("Season123AdditionRuleTipView", BaseView)

function Season123AdditionRuleTipView:onInitView()
	self._goitem = gohelper.findChild(self.viewGO, "content/layout/#go_ruleitem")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._itemList = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123AdditionRuleTipView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function Season123AdditionRuleTipView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Season123AdditionRuleTipView:_btncloseOnClick()
	self:closeThis()
end

function Season123AdditionRuleTipView:onOpen()
	local actId = self.viewParam.actId
	local stage = self.viewParam.stage
	local dict = Season123Config.instance:getRuleTips(actId, stage)
	local list = {}

	for id, state in pairs(dict) do
		table.insert(list, id)
	end

	for i = 1, math.max(#list, #self._itemList) do
		local item = self:getOrCreateItem(i)

		self:updateItem(item, list[i])
	end

	NavigateMgr.instance:addEscape(self.viewName, self.closeThis, self)
end

function Season123AdditionRuleTipView:getOrCreateItem(index)
	local item = self._itemList[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._goitem, "item" .. tostring(index))
		item.icon = gohelper.findChildImage(item.go, "mask/icon")
		item.txtTag = gohelper.findChildTextMesh(item.go, "mask/scroll_tag/Viewport/Content/tag")
		self._itemList[index] = item
	end

	return item
end

function Season123AdditionRuleTipView:updateItem(item, ruleId)
	if not ruleId then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	local ruleCo = lua_rule.configDict[ruleId]

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(item.icon, ruleCo.icon)

	item.txtTag.text = ruleCo.desc
end

function Season123AdditionRuleTipView:onClose()
	return
end

return Season123AdditionRuleTipView
