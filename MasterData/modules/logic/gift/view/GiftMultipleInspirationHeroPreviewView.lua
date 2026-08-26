-- chunkname: @modules/logic/gift/view/GiftMultipleInspirationHeroPreviewView.lua

module("modules.logic.gift.view.GiftMultipleInspirationHeroPreviewView", package.seeall)

local GiftMultipleInspirationHeroPreviewView = class("GiftMultipleInspirationHeroPreviewView", BaseView)

function GiftMultipleInspirationHeroPreviewView:onInitView()
	self._txtTips = gohelper.findChildText(self.viewGO, "pickchoice/TipsBG/tip/#txt_Tips")
	self._imageicon = gohelper.findChildImage(self.viewGO, "pickchoice/TipsBG/tip/#image_icon")
	self._txtTips1 = gohelper.findChildText(self.viewGO, "pickchoice/TipsBG/tip/#txt_Tips1")
	self._goheroitem = gohelper.findChild(self.viewGO, "#go_heroitem")
	self._scrollhero = gohelper.findChildScrollRect(self.viewGO, "#scroll_hero")
	self._gohas = gohelper.findChild(self.viewGO, "#scroll_hero/Viewport/Content/#go_has")
	self._gohasroot = gohelper.findChild(self.viewGO, "#scroll_hero/Viewport/Content/#go_has/#go_hasroot")
	self._golock = gohelper.findChild(self.viewGO, "#scroll_hero/Viewport/Content/#go_lock")
	self._txtlocked = gohelper.findChildText(self.viewGO, "#scroll_hero/Viewport/Content/#go_lock/title/#txt_locked")
	self._golockroot = gohelper.findChild(self.viewGO, "#scroll_hero/Viewport/Content/#go_lock/#go_lockroot")
	self._scrollcareer = gohelper.findChildScrollRect(self.viewGO, "#scroll_career")
	self._goitem = gohelper.findChild(self.viewGO, "#scroll_career/viewport/content/#go_item")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

local kAnimEvt = "switch"

function GiftMultipleInspirationHeroPreviewView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.animationEvent:AddEventListener(kAnimEvt, self._onSwitchEnd, self)
end

function GiftMultipleInspirationHeroPreviewView:removeEvents()
	self._btnclose:RemoveClickListener()
	self.animationEvent:RemoveEventListener(kAnimEvt)
end

function GiftMultipleInspirationHeroPreviewView:_btncloseOnClick()
	self:closeThis()
end

function GiftMultipleInspirationHeroPreviewView:_editableInitView()
	self._tabItemList = {}
	self.animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)
	self.animationEvent = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_AnimationEventWrap)
	self._scrollCareerRect = gohelper.findChildComponent(self.viewGO, "#scroll_career", typeof(UnityEngine.UI.ScrollRect))
end

function GiftMultipleInspirationHeroPreviewView:onUpdateParam()
	return
end

function GiftMultipleInspirationHeroPreviewView:onOpen()
	self.animator:Play("open", 0, 0)
	self:checkParam()
	self:refreshUI()
	AudioMgr.instance:trigger(AudioEnum3_10.SummonProgress.play_ui_langchao_page_open)
end

function GiftMultipleInspirationHeroPreviewView:checkParam()
	if not self.viewParam or not self.viewParam.itemId then
		return
	end

	self._itemId = self.viewParam.itemId
	self._itemConfig = ItemConfig.instance:getItemCo(self._itemId)
	self._effectParam = {}
end

function GiftMultipleInspirationHeroPreviewView:refreshUI()
	self:refreshInspirationTab()
end

local enable_move_min = 5

function GiftMultipleInspirationHeroPreviewView:refreshInspirationTab()
	local rewardParam = self:_getItemEffectParam(tonumber(self._itemConfig.effect))

	self._rewardParamList = rewardParam

	gohelper.CreateObjList(self, self.onCreateTabItem, rewardParam, nil, self._goitem)
	self:onSelectTab(1, true)

	local rewardCount = #self._rewardParamList

	self._scrollCareerRect.vertical = rewardCount > enable_move_min
end

function GiftMultipleInspirationHeroPreviewView:onCreateTabItem(itemGo, data, index)
	local item = self:getUserDataTb_()

	item.itemGo = itemGo
	item.goNormal = gohelper.findChild(itemGo, "#go_normal")
	item.goSelect = gohelper.findChild(itemGo, "#go_select")
	item.txtNormalName = gohelper.findChildTextMesh(itemGo, "#go_normal/txt")
	item.txtSelectName = gohelper.findChildTextMesh(itemGo, "#go_select/txt")
	item.btnClick = gohelper.findChildButton(itemGo, "#btn_clickarea")
	item.simageNormal = gohelper.findChildSingleImage(itemGo, "#go_normal/icon")
	item.simageSelect = gohelper.findChildSingleImage(itemGo, "#go_select/icon")

	local clickParam = {}

	clickParam.target = self
	clickParam.index = index

	item.btnClick:AddClickListener(self.onClickTab, clickParam)

	local reward = self._rewardParamList[index]
	local itemConfig, iconPath = ItemModel.instance:getItemConfigAndIcon(reward[1], reward[2])

	item.txtNormalName.text = itemConfig.name
	item.txtSelectName.text = itemConfig.name

	item.simageNormal:LoadImage(iconPath)
	item.simageSelect:LoadImage(iconPath)
	table.insert(self._tabItemList, item)
end

function GiftMultipleInspirationHeroPreviewView.onClickTab(param)
	local target = param.target
	local index = param.index

	target:onSelectTab(index)
end

function GiftMultipleInspirationHeroPreviewView:onSelectTab(index, isOpen)
	if index == self._curTabIndex then
		return
	end

	self._curTabIndex = index

	self:_refreshTabSelect()

	if isOpen then
		self:_onSwitchEnd()
	else
		AudioMgr.instance:trigger(AudioEnum3_10.SummonProgress.play_ui_langchao_switch_prop)
		self.animator:Play("switch", 0, 0)
	end
end

function GiftMultipleInspirationHeroPreviewView:_onSwitchEnd()
	self:refreshHero()
end

function GiftMultipleInspirationHeroPreviewView:_refreshTabSelect()
	for index, item in ipairs(self._tabItemList) do
		gohelper.setActive(item.goNormal, index ~= self._curTabIndex)
		gohelper.setActive(item.goSelect, index == self._curTabIndex)
	end
end

function GiftMultipleInspirationHeroPreviewView:_getItemEffectParam(effectId)
	return (DungeonConfig.instance:getRewardItems(effectId))
end

function GiftMultipleInspirationHeroPreviewView:refreshHero()
	local reward = self._rewardParamList[self._curTabIndex]
	local itemConfig = ItemConfig.instance:getItemConfig(reward[1], reward[2])
	local heroList = string.splitToNumber(itemConfig.effect, "#")
	local haveHeroIds = {}
	local noHaveHeroIds = {}

	for _, heroId in ipairs(heroList) do
		local heroMo = HeroModel.instance:getByHeroId(heroId)

		if heroMo ~= nil then
			table.insert(haveHeroIds, heroId)
		else
			table.insert(noHaveHeroIds, heroId)
		end
	end

	local showHaveHero = next(haveHeroIds)
	local showNoHaveHero = next(noHaveHeroIds)

	gohelper.setActive(self._gohas, showHaveHero)
	gohelper.setActive(self._golock, showNoHaveHero)

	if showHaveHero then
		gohelper.CreateObjList(self, self.onCreateHeroItem, haveHeroIds, self._gohasroot, self._goheroitem, GiftMultipleInspirationHeroItem)
	end

	if showNoHaveHero then
		gohelper.CreateObjList(self, self.onCreateHeroItem, noHaveHeroIds, self._golockroot, self._goheroitem, GiftMultipleInspirationHeroItem)
	end
end

function GiftMultipleInspirationHeroPreviewView:onCreateHeroItem(item, heroId, index)
	item:onUpdateMO(heroId)
end

function GiftMultipleInspirationHeroPreviewView:onClose()
	self.animator:Play("close", 0, 0)
end

function GiftMultipleInspirationHeroPreviewView:onDestroyView()
	if self._tabItemList and next(self._tabItemList) then
		for _, item in ipairs(self._tabItemList) do
			item.btnClick:RemoveClickListener()
			item.simageNormal:UnLoadImage()
			item.simageSelect:UnLoadImage()
		end
	end

	tabletool.clear(self._tabItemList)

	self._tabItemList = nil
end

return GiftMultipleInspirationHeroPreviewView
