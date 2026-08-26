-- chunkname: @modules/logic/summonsimulationpick/view/SummonSimulationPickView.lua

module("modules.logic.summonsimulationpick.view.SummonSimulationPickView", package.seeall)

local SummonSimulationPickView = class("SummonSimulationPickView", BaseView)

function SummonSimulationPickView:onInitView()
	self._scrollresult = gohelper.findChildScrollRect(self.viewGO, "#scroll_result")
	self._btnconfirmselect = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/selected/#btn_confirmselect")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonSimulationPickView:addEvents()
	self._btnconfirmselect:AddClickListener(self._btnconfirmselectOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	SummonSimulationPickController.instance:registerCallback(SummonSimulationEvent.onSelectResult, self.closeThis, self)
	SummonSimulationPickController.instance:registerCallback(SummonSimulationEvent.onSelectItem, self.onItemSelect, self)
end

function SummonSimulationPickView:removeEvents()
	self._btnconfirmselect:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	SummonSimulationPickController.instance:unregisterCallback(SummonSimulationEvent.onSelectResult, self.closeThis, self)
	SummonSimulationPickController.instance:unregisterCallback(SummonSimulationEvent.onSelectItem, self.onItemSelect, self)
end

function SummonSimulationPickView:_btncloseOnClick()
	self:closeThis()
end

function SummonSimulationPickView:_btnconfirmselectOnClick()
	SummonSimulationPickController.instance:selectResult(self._activityId)
end

function SummonSimulationPickView:onItemSelect(selectIndex)
	SummonSimulationPickModel.instance:setCurSelectIndex(selectIndex)
	self:_refreshSelect(selectIndex)
	self:_refreshConfirmBtnState(selectIndex)
end

function SummonSimulationPickView:_editableInitView()
	self.contentGo = gohelper.findChild(self.viewGO, "#scroll_result/Viewport/content")
	self.itemGo = gohelper.findChild(self.viewGO, "#scroll_result/Viewport/content/#go_resultitem")

	gohelper.setActive(self.itemGo, false)

	self._animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)
	self._showItemList = {}
	self._goUnSelect = gohelper.findChild(self.viewGO, "bottom/unselect")
	self._goSelect = gohelper.findChild(self.viewGO, "bottom/selected")
end

function SummonSimulationPickView:onOpen()
	if self.viewParam then
		local param = self.viewParam

		self._activityId = param.activityId
		self._isFromMaterialTipView = param.isFromMaterialTipView
	end

	self.actId = self._activityId

	self:_refreshUI()
end

function SummonSimulationPickView:_refreshUI()
	self._animator:Play(self.NORMAL_ANIMATION, 0, 0)
	self:_refreshHeroInfo()
	self:onItemSelect()
end

function SummonSimulationPickView:_refreshHeroInfo()
	local summonInfo = SummonSimulationPickModel.instance:getActInfo(self._activityId)
	local info = summonInfo.saveHeroIds

	tabletool.clear(self._showItemList)
	gohelper.CreateObjList(self, self.onShowItem, info, self.contentGo, self.itemGo, SummonSimulationPickResultItem, nil, nil)
end

function SummonSimulationPickView:_refreshSelect(selectIndex)
	for index, item in ipairs(self._showItemList) do
		item:setSelect(index == selectIndex)
	end
end

function SummonSimulationPickView:_refreshConfirmBtnState(selectIndex)
	gohelper.setActive(self._goSelect, selectIndex ~= nil)
	gohelper.setActive(self._goUnSelect, selectIndex == nil)
end

function SummonSimulationPickView:onShowItem(item, data, index)
	item:setInfo(data, index)
	table.insert(self._showItemList, item)
end

function SummonSimulationPickView:onCloseFinish()
	if not self._isFromMaterialTipView then
		return
	end

	if not self:_showCommonPropView() then
		SummonController.instance:dispatchEvent(SummonEvent.onSummonResultClose)
	end
end

function SummonSimulationPickView:onDestroyView()
	tabletool.clear(self._showItemList)
end

function SummonSimulationPickView:_showCommonPropView()
	local activityId = self._activityId
	local info = SummonSimulationPickModel.instance:getActInfo(activityId)

	if info.isSelect == false then
		if VirtualSummonScene.instance:isOpen() then
			return false
		end

		return true
	end

	local heroIds = info.saveHeroIds[info.selectIndex]
	local rewards = SummonController.instance:getVirtualSummonResult(heroIds, false, true)

	if rewards == nil then
		return false
	end

	local rewardMos = SummonModel.getRewardList(rewards, true)

	table.sort(rewardMos, SummonModel.sortRewards)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, rewardMos)

	return true
end

return SummonSimulationPickView
