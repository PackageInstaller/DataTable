-- chunkname: @modules/logic/sodache/view/outside/SodacheHandbookView.lua

module("modules.logic.sodache.view.outside.SodacheHandbookView", package.seeall)

local SodacheHandbookView = class("SodacheHandbookView", BaseView)

function SodacheHandbookView:onInitView()
	self._goTabItem = gohelper.findChild(self.viewGO, "Tab/#go_TabItem")
	self._scrollCard = gohelper.findChildScrollRect(self.viewGO, "#scroll_Card")
	self._goCardInfo = gohelper.findChild(self.viewGO, "Right/#go_CardInfo")
	self._goMonsterInfo = gohelper.findChild(self.viewGO, "Right/#go_MonsterInfo")
	self._goEmpty = gohelper.findChild(self.viewGO, "Right/#go_Empty")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

local switchEvt = "switch content"
local freshEvt = "refresh content"

function SodacheHandbookView:_btnTabOnClick(type)
	if self.type == type then
		return
	end

	if self.type then
		self.tabItemMap[self.type].anim:Play("unselect", 0, 0)
	end

	self.type = type

	self.tabItemMap[self.type].anim:Play("select", 0, 0)
	self.animScroll:Play("refresh", 0, 0)
end

function SodacheHandbookView:_editableInitView()
	self.cardInfo = MonoHelper.addNoUpdateLuaComOnceToGo(self._goCardInfo, SodacheCardInfoRight)
	self.animScroll = gohelper.findChildAnim(self.viewGO, "#scroll_Card")
	self.animScrollEvent = self.animScroll.gameObject:GetComponent(gohelper.Type_AnimationEventWrap)

	self.animScrollEvent:AddEventListener(switchEvt, self._onSwitchEnd, self)

	self.animRight = gohelper.findChildAnim(self.viewGO, "Right")
	self.animRightEvent = self.animRight.gameObject:GetComponent(gohelper.Type_AnimationEventWrap)

	self.animRightEvent:AddEventListener(freshEvt, self._onFreshEnd, self)

	local typeList = {
		SodacheEnum.HandBookSubType.Supplies,
		SodacheEnum.HandBookSubType.Adventure,
		SodacheEnum.HandBookSubType.Ammo,
		SodacheEnum.HandBookSubType.Offering
	}

	self.tabItemMap = {}

	for _, type in ipairs(typeList) do
		local item = self:getUserDataTb_()
		local go = gohelper.cloneInPlace(self._goTabItem)

		item.anim = gohelper.findComponentAnim(go)

		local txtName = gohelper.findChildText(go, "node_card/txt_itemcn")

		txtName.text = luaLang("sodachehandbook_subType" .. tostring(type))

		local btnTab = gohelper.findChildButtonWithAudio(go, "btn_Tab")

		self.addClickCb(self, btnTab, self._btnTabOnClick, self, type)

		self.tabItemMap[type] = item
	end

	gohelper.setActive(self._goTabItem, false)
	self:buildScroll()
end

function SodacheHandbookView:onOpen()
	self.addEventCb(self, SodacheController.instance, SodacheEvent.OnClickHandbookItem, self.onClickItem, self)
	self:_btnTabOnClick(SodacheEnum.HandBookSubType.Supplies)
end

function SodacheHandbookView:onDestroyView()
	self.animScrollEvent:RemoveEventListener(switchEvt)
	self.animRightEvent:RemoveEventListener(freshEvt)
end

function SodacheHandbookView:onClickItem(handbookCfg)
	if self.handbookCfg == handbookCfg then
		return
	end

	self.handbookCfg = handbookCfg

	local index = self.modelInst:getIndex(handbookCfg)

	self.modelInst:selectCell(index, true)
	self.animRight:Play("refresh", 0, 0)
end

function SodacheHandbookView:_onSwitchEnd()
	local handbookCfgList = SodacheConfig.instance:getHandBookCfgList(self.type)

	self.modelInst:setList(handbookCfgList)

	local handbookCfg = handbookCfgList[1]

	self:onClickItem(handbookCfg, true)
end

function SodacheHandbookView:_onFreshEnd()
	if self.handbookCfg then
		self.cardInfo:setData(SodacheCardMo.Create(self.handbookCfg.eleId))

		if self._goEmpty.activeInHierarchy then
			gohelper.setActive(self._goEmpty, false)
			gohelper.setActive(self._goCardInfo, true)
		end
	end
end

function SodacheHandbookView:buildScroll()
	self.modelInst = ListScrollModel.New()

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_Card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#scroll_Card/Viewport/Content/CardItem"
	scrollParam.cellClass = SodacheHandbookItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.cellWidth = 230
	scrollParam.cellHeight = 300
	scrollParam.lineCount = 4
	scrollParam.startSpace = 15
	scrollParam.cellSpaceV = 20
	self.scrollView = LuaListScrollExtend.New(self.modelInst, scrollParam)

	self:addChildView(self.scrollView)
end

return SodacheHandbookView
