-- chunkname: @modules/logic/season/view3_0/Season3_0AdditionRuleTipView.lua

module("modules.logic.season.view3_0.Season3_0AdditionRuleTipView", package.seeall)

local Season3_0AdditionRuleTipView = class("Season3_0AdditionRuleTipView", BaseView)

function Season3_0AdditionRuleTipView:onInitView()
	self._goitem = gohelper.findChild(self.viewGO, "content/layout/#go_ruleitem")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._itemList = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season3_0AdditionRuleTipView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function Season3_0AdditionRuleTipView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Season3_0AdditionRuleTipView:_btncloseOnClick()
	self:closeThis()
end

function Season3_0AdditionRuleTipView:onOpen()
	local actId = self.viewParam.actId
	local list = SeasonConfig.instance:getRuleTips(actId)

	for i = 1, math.max(#list, #self._itemList) do
		local item = self:getOrCreateItem(i)

		self:updateItem(item, list[i])
	end
end

function Season3_0AdditionRuleTipView:getOrCreateItem(index)
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

function Season3_0AdditionRuleTipView:updateItem(item, ruleId)
	if not ruleId then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	local ruleCo = lua_rule.configDict[ruleId]

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(item.icon, ruleCo.icon)

	item.txtTag.text = ruleCo.desc
end

function Season3_0AdditionRuleTipView:onClose()
	return
end

return Season3_0AdditionRuleTipView
