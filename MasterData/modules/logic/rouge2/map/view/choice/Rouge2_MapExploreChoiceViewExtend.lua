-- chunkname: @modules/logic/rouge2/map/view/choice/Rouge2_MapExploreChoiceViewExtend.lua

module("modules.logic.rouge2.map.view.choice.Rouge2_MapExploreChoiceViewExtend", package.seeall)

local Rouge2_MapExploreChoiceViewExtend = class("Rouge2_MapExploreChoiceViewExtend", BaseView)

function Rouge2_MapExploreChoiceViewExtend:onInitView()
	self._goChoiceDesc = gohelper.findChild(self.viewGO, "#go_ChoiceDesc")
	self._txtChoiceDesc = gohelper.findChildText(self.viewGO, "#go_ChoiceDesc/#txt_ChoiceDesc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapExploreChoiceViewExtend:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onChoiceEventChange, self.onChoiceEventChange, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onReceiveChoiceEvent, self.onReceiveChoiceEvent, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onChoiceItemStatusChange, self.onStatusChange, self)
end

function Rouge2_MapExploreChoiceViewExtend:_editableInitView()
	gohelper.setActive(self._goChoiceDesc, false)
	SkillHelper.addHyperLinkClick(self._txtChoiceDesc, self._hyperLinkClickCallback, self)

	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self._choiceDescAnimator = gohelper.onceAddComponent(self._goChoiceDesc, gohelper.Type_Animator)

	self:_initIgnoreViewList()
end

function Rouge2_MapExploreChoiceViewExtend:_initIgnoreViewList()
	self._ignoreViewList = {}

	if Rouge2_MapHelper.CommonIgnoreViewDict then
		for viewName, status in pairs(self._ignoreViewList) do
			if status == true then
				table.insert(self._ignoreViewList, viewName)
			end
		end
	end
end

function Rouge2_MapExploreChoiceViewExtend:onOpenView(viewName)
	if viewName ~= ViewName.Rouge2_MapDiceView or not self:_checkChoiceViewOnTheTop() then
		return
	end

	self._animator.enabled = true

	self._animator:Play("switchout", 0, 0)
end

function Rouge2_MapExploreChoiceViewExtend:onCloseView(viewName)
	if viewName ~= ViewName.Rouge2_MapDiceView or not self:_checkChoiceViewOnTheTop() then
		return
	end

	self._animator.enabled = true

	self._animator:Play("switchin", 0, 0)
end

function Rouge2_MapExploreChoiceViewExtend:_checkChoiceViewOnTheTop()
	return not Rouge2_PopController.instance:isPopping() and ViewHelper.instance:checkViewOnTheTop(self.viewName, self._ignoreViewList)
end

function Rouge2_MapExploreChoiceViewExtend:onReceiveChoiceEvent()
	gohelper.setActive(self._goChoiceDesc, false)
end

function Rouge2_MapExploreChoiceViewExtend:onChoiceEventChange(nodeMo)
	gohelper.setActive(self._goChoiceDesc, false)
end

function Rouge2_MapExploreChoiceViewExtend:onStatusChange(choiceId)
	local choiceCo = Rouge2_MapConfig.instance:getChoiceConfig(choiceId)

	gohelper.setActive(self._goChoiceDesc, choiceCo ~= nil)

	if not choiceCo then
		return
	end

	self._txtChoiceDesc.text = choiceCo.desc

	self._choiceDescAnimator:Play("open", 0, 0)
end

function Rouge2_MapExploreChoiceViewExtend:_hyperLinkClickCallback(itemId)
	itemId = tonumber(itemId)

	local itemCo = Rouge2_BackpackHelper.getItemConfig(itemId)

	if not itemCo then
		return
	end

	local itemType = Rouge2_BackpackHelper.itemId2BagType(itemId)
	local showViewName = Rouge2_BackpackHelper.itemType2ShowViewName(itemType)

	self._isClickHyperLink = true

	ViewMgr.instance:openView(showViewName, {
		viewEnum = Rouge2_MapEnum.ItemDropViewEnum.Drop,
		dataType = Rouge2_Enum.ItemDataType.Config,
		itemList = {
			itemId
		}
	})
end

return Rouge2_MapExploreChoiceViewExtend
