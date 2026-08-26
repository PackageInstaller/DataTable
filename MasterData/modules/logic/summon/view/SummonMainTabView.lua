-- chunkname: @modules/logic/summon/view/SummonMainTabView.lua

module("modules.logic.summon.view.SummonMainTabView", package.seeall)

local SummonMainTabView = class("SummonMainTabView", BaseView)

function SummonMainTabView:onInitView()
	self._goui = gohelper.findChild(self.viewGO, "#go_ui")
	self._godrag = gohelper.findChild(self.viewGO, "#go_ui/#go_drag")
	self._gocategory = gohelper.findChild(self.viewGO, "#go_ui/#go_category")
	self._scrollcategory = gohelper.findChildScrollRect(self.viewGO, "#go_ui/#go_category/#scroll_category")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_ui/#go_lefttop")
	self._gosummonmaincategoryitem = gohelper.findChild(self.viewGO, "#go_ui/#go_category/#scroll_category/Viewport/Content/#go_summonmaincategoryitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonMainTabView:addEvents()
	return
end

function SummonMainTabView:removeEvents()
	return
end

function SummonMainTabView:_editableInitView()
	self._tabItems = {}
end

function SummonMainTabView:onDestroyView()
	for _, item in pairs(self._tabItems) do
		gohelper.setActive(item.go, true)
		item.component:onDestroyView()
		gohelper.destroy(item.go)
	end

	self._tabItems = nil
end

function SummonMainTabView:onOpen()
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonTabSet, self._handleTabSet, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.guideScrollShowEquipPool, self._guideScrollShowEquipPool, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonInfoGot, self.refreshUI, self)
	self:refreshUI()
	self:setOpenFlag()
	SummonController.instance:dispatchEvent(SummonEvent.onSummonTabSet)
end

function SummonMainTabView:_guideScrollShowEquipPool()
	self._scrollcategory.verticalNormalizedPosition = 0
end

function SummonMainTabView:onClose()
	self:killTween()
	SummonMainModel.instance:releaseViewData()
end

function SummonMainTabView:refreshUI()
	local datas = SummonMainCategoryListModel.instance:getList()
	local parseUISet = {}
	local index = self:refreshTabGroupByType(datas, SummonEnum.ResultType.Char, 1, parseUISet)

	index = self:refreshTabGroupByType(datas, SummonEnum.ResultType.Equip, index, parseUISet)

	ZProj.UGUIHelper.RebuildLayout(self._scrollcategory.content.transform)

	for _, item in pairs(self._tabItems) do
		if not parseUISet[item] then
			gohelper.setActive(item.go, false)
			item.component:cleanData()
		end
	end
end

function SummonMainTabView:refreshTabGroupByType(datas, resultType, startIndex, parseSet)
	local index = startIndex

	for i, data in ipairs(datas) do
		if SummonMainModel.getResultType(data.originConf) == resultType then
			local item = self:getOrCreateItem(index)

			gohelper.setActive(item.go, true)
			gohelper.setAsLastSibling(item.go)
			item.component:onUpdateMO(data)

			parseSet[item] = true
			index = index + 1
		end
	end

	return index
end

function SummonMainTabView:setOpenFlag()
	local curId = SummonMainModel.instance:getCurId()

	if curId and SummonMainModel.instance.flagModel then
		SummonMainModel.instance.flagModel:cleanFlag(curId)
	end
end

function SummonMainTabView:getOrCreateItem(index)
	local item = self._tabItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._gosummonmaincategoryitem, "tabitem_" .. tostring(index))
		item.rect = item.go.transform
		item.component = MonoHelper.addNoUpdateLuaComOnceToGo(item.go, SummonMainCategoryItem)
		item.component.viewGO = item.go

		item.component:onInitView()
		item.component:addEvents()
		item.component:customAddEvent()

		self._tabItems[index] = item
	end

	return item
end

SummonMainTabView.TweenTimeCategory = 0.1

function SummonMainTabView:_handleTabSet(forceNoAnim)
	local tabIndex = SummonMainModel.instance:getCurADPageIndex()

	if tabIndex then
		local isFirstTimeEnter = self._tabIndex == nil

		self._tabIndex = tabIndex

		self.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 3, tabIndex)
		self:refreshUI()
		self:scrollToCurTab(isFirstTimeEnter, forceNoAnim)
		logNormal(string.format("set summon pool to [%s]", SummonMainModel.instance:getCurId()))
	end
end

function SummonMainTabView:scrollToCurTab(isFirstTimeEnter, forceNoAnim)
	local curPool = SummonMainModel.instance:getCurPool()
	local curItem
	local curIndex = 0

	for i, item in pairs(self._tabItems) do
		local data = item.component:getData()

		if data and data.originConf.id == curPool.id then
			curItem = item
			curIndex = i - 1

			break
		end
	end

	if not curItem then
		return
	end

	local contentHeight = recthelper.getHeight(self._scrollcategory.content.transform)
	local itemAnchorY = recthelper.getAnchorY(curItem.rect)

	if contentHeight <= 0 then
		return
	end

	local originNormPos = self._scrollcategory.verticalNormalizedPosition
	local newNormPos = 1 - curIndex / (#self._tabItems - 1)

	if isFirstTimeEnter or forceNoAnim then
		self._scrollcategory.verticalNormalizedPosition = newNormPos
	else
		self:killTween()

		self._tweenIdCategory = ZProj.TweenHelper.DOTweenFloat(originNormPos, newNormPos, SummonMainTabView.TweenTimeCategory, self.onTweenCategory, self.onTweenFinishCategory, self)
	end
end

function SummonMainTabView:onTweenCategory(value)
	if not gohelper.isNil(self._scrollcategory) then
		self._scrollcategory.verticalNormalizedPosition = value
	end
end

function SummonMainTabView:onTweenFinishCategory()
	self:killTween()
end

function SummonMainTabView:killTween()
	if self._tweenIdCategory then
		ZProj.TweenHelper.KillById(self._tweenIdCategory)

		self._tweenIdCategory = nil
	end
end

return SummonMainTabView
