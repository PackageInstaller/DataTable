-- chunkname: @modules/logic/rouge2/map/view/dice/Rouge2_MapDiceChoiceView.lua

module("modules.logic.rouge2.map.view.dice.Rouge2_MapDiceChoiceView", package.seeall)

local Rouge2_MapDiceChoiceView = class("Rouge2_MapDiceChoiceView", BaseView)

function Rouge2_MapDiceChoiceView:onInitView()
	self._goChoice = gohelper.findChild(self.viewGO, "root/#go_Choice")
	self._btnShowChoice = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_Choice/#btn_ShowChoice")
	self._goChoiceContainer = gohelper.findChild(self.viewGO, "root/#go_Choice/#go_ChoiceContainer")
	self._btnHideChoice = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_Choice/#go_ChoiceContainer/#btn_HideChoice")
	self._goChoiceType1 = gohelper.findChild(self.viewGO, "root/#go_Choice/#go_ChoiceContainer/#go_ChoiceType1")
	self._goChoicePos1 = gohelper.findChild(self.viewGO, "root/#go_Choice/#go_ChoiceContainer/#go_ChoiceType1/#go_ChoicePos1")
	self._goChoiceType2 = gohelper.findChild(self.viewGO, "root/#go_Choice/#go_ChoiceContainer/#go_ChoiceType2")
	self._txtExploreChoiceDesc = gohelper.findChildText(self.viewGO, "root/#go_Choice/#go_ChoiceContainer/#go_ChoiceType2/#txt_ExploreChoiceDesc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapDiceChoiceView:addEvents()
	self._btnShowChoice:AddClickListener(self._btnShowChoiceOnClick, self)
	self._btnHideChoice:AddClickListener(self._btnHideChoiceOnClick, self)
end

function Rouge2_MapDiceChoiceView:removeEvents()
	self._btnShowChoice:RemoveClickListener()
	self._btnHideChoice:RemoveClickListener()
end

function Rouge2_MapDiceChoiceView:_btnShowChoiceOnClick()
	self._expand = true

	self:refreshChoiceVisible()
end

function Rouge2_MapDiceChoiceView:_btnHideChoiceOnClick()
	self._expand = false

	self:refreshChoiceVisible()
end

function Rouge2_MapDiceChoiceView:_editableInitView()
	SkillHelper.addHyperLinkClick(self._txtExploreChoiceDesc)

	self._expand = false
	self._isChoiceEvent = false
	self._eventType2HandleFuncMap = {}
	self._eventType2HandleFuncMap[Rouge2_MapEnum.EventType.StoryChoice] = self._refreshChoice_Story
	self._eventType2HandleFuncMap[Rouge2_MapEnum.EventType.HighHardFight] = self._refreshChoice_Story
	self._eventType2HandleFuncMap[Rouge2_MapEnum.EventType.Reward] = self._refreshChoice_Story
	self._eventType2HandleFuncMap[Rouge2_MapEnum.EventType.Rest] = self._refreshChoice_Story
	self._eventType2HandleFuncMap[Rouge2_MapEnum.EventType.Strengthen] = self._refreshChoice_Story
	self._eventType2HandleFuncMap[Rouge2_MapEnum.EventType.ExploreChoice] = self._refreshChoice_Explore
	self._eventType2RootMap = self:getUserDataTb_()
	self._eventType2RootMap[Rouge2_MapEnum.EventType.StoryChoice] = self._goChoiceType1
	self._eventType2RootMap[Rouge2_MapEnum.EventType.HighHardFight] = self._goChoiceType1
	self._eventType2RootMap[Rouge2_MapEnum.EventType.Reward] = self._goChoiceType1
	self._eventType2RootMap[Rouge2_MapEnum.EventType.Rest] = self._goChoiceType1
	self._eventType2RootMap[Rouge2_MapEnum.EventType.Strengthen] = self._goChoiceType1
	self._eventType2RootMap[Rouge2_MapEnum.EventType.ExploreChoice] = self._goChoiceType2
	self._goIconRootList = self:getUserDataTb_()

	table.insert(self._goIconRootList, self._goChoiceType1)
	table.insert(self._goIconRootList, self._goChoiceType2)
end

function Rouge2_MapDiceChoiceView:onUpdateParam()
	return
end

function Rouge2_MapDiceChoiceView:onOpen()
	self:refreshInfo()
	self:refreshChoice()
end

function Rouge2_MapDiceChoiceView:refreshInfo()
	self._checkResInfo = self.viewParam and self.viewParam.checkResInfo
	self._fromType = self._checkResInfo and self._checkResInfo:getFromType()
	self._nodeId = self._checkResInfo and self._checkResInfo:getNodeId()
	self._isNodeValid = self._nodeId and self._nodeId ~= 0
	self._isChoiceDice = self._fromType == Rouge2_MapEnum.InteractFromType.Event and self._isNodeValid
	self._nodeMo = self._isChoiceDice and Rouge2_MapModel.instance:getNode(self._nodeId)

	if not self._nodeMo then
		self._expand = false
		self._isChoiceEvent = false

		return
	end

	self._eventMo = self._nodeMo and self._nodeMo.eventMo
	self._eventCo = self._nodeMo and self._nodeMo:getEventCo()
	self._eventId = self._eventCo and self._eventCo.id
	self._eventType = self._eventCo and self._eventCo.type
	self._isChoiceEvent = Rouge2_MapHelper.isChoiceEvent(self._eventType)
	self._expand = self._expand and self._isChoiceEvent

	if self._isChoiceEvent then
		self._choiceId = self._eventMo:getCurSelectChoiceId()
		self._choiceIdList = self._eventMo:getChoiceIdList()
		self._choiceIndex = self._choiceIdList and tabletool.indexOf(self._choiceIdList, self._choiceId)
		self._curCheckRate = self._eventMo:getChoiceCheckRate(self._choiceId)
		self._choiceIndex = self._choiceIndex or 1
		self._curCheckRate = self._curCheckRate or 0
		self._choiceCo = Rouge2_MapConfig.instance:getChoiceConfig(self._choiceId)
	end
end

function Rouge2_MapDiceChoiceView:refreshChoice()
	gohelper.setActive(self._goChoice, self._isChoiceEvent)
	self:refreshChoiceVisible()

	if not self._isChoiceEvent then
		return
	end

	self:_activeChoiceRoot(self._eventType)

	local handle = self._eventType2HandleFuncMap[self._eventType]

	if not handle then
		logError(string.format("肉鸽检定界面选项缺少显示方法 eventId = %s, eventType = %s", self._eventId, self._eventType))

		return
	end

	handle(self)
end

function Rouge2_MapDiceChoiceView:_activeChoiceRoot(targetEventType)
	for _, goRoot in pairs(self._goIconRootList) do
		gohelper.setActive(goRoot, false)
	end

	local gotTargetRoot = targetEventType and self._eventType2RootMap[targetEventType]

	gohelper.setActive(gotTargetRoot, true)
end

function Rouge2_MapDiceChoiceView:_refreshChoice_Story()
	if not self._storyChoiceItem then
		local goChoiceItem = self:getResInst(Rouge2_Enum.ResPath.MapChoiceItem, self._goChoicePos1, "choiceItem")

		self._storyChoiceItem = MonoHelper.addNoUpdateLuaComOnceToGo(goChoiceItem, Rouge2_MapNodeChoiceItem)
	end

	self._storyChoiceItem:update(self._choiceId, self._nodeMo, self._choiceIndex, self._curCheckRate)
end

function Rouge2_MapDiceChoiceView:_refreshChoice_Explore()
	if self._choiceCo then
		Rouge2_ItemDescHelper.buildAndSetDesc(self._txtExploreChoiceDesc, self._choiceCo)
	end
end

function Rouge2_MapDiceChoiceView:refreshChoiceVisible()
	gohelper.setActive(self._goChoiceContainer, self._expand)
	gohelper.setActive(self._btnShowChoice.gameObject, not self._expand)
end

function Rouge2_MapDiceChoiceView:onClose()
	return
end

function Rouge2_MapDiceChoiceView:onDestroyView()
	if self._storyChoiceItem then
		self._storyChoiceItem:destroy()

		self._storyChoiceItem = nil
	end
end

return Rouge2_MapDiceChoiceView
