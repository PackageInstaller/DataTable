-- chunkname: @modules/logic/season/view1_2/Season1_2AdditionRuleTipView.lua

module("modules.logic.season.view1_2.Season1_2AdditionRuleTipView", package.seeall)

local Season1_2AdditionRuleTipView = class("Season1_2AdditionRuleTipView", BaseView)

function Season1_2AdditionRuleTipView:onInitView()
	self._goitem = gohelper.findChild(self.viewGO, "content/layout/#go_ruleitem")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._itemList = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season1_2AdditionRuleTipView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function Season1_2AdditionRuleTipView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Season1_2AdditionRuleTipView:_btncloseOnClick()
	self:closeThis()
end

function Season1_2AdditionRuleTipView:onOpen()
	local actId = self.viewParam.actId
	local list = SeasonConfig.instance:getRuleTips(actId)

	for i = 1, math.max(#list, #self._itemList) do
		local item = self:getOrCreateItem(i)

		self:updateItem(item, list[i])
	end
end

function Season1_2AdditionRuleTipView:getOrCreateItem(index)
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

function Season1_2AdditionRuleTipView:updateItem(item, ruleId)
	if not ruleId then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	local ruleCo = lua_rule.configDict[ruleId]

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(item.icon, ruleCo.icon)

	item.txtTag.text = ruleCo.desc
end

function Season1_2AdditionRuleTipView:onClose()
	return
end

return Season1_2AdditionRuleTipView
