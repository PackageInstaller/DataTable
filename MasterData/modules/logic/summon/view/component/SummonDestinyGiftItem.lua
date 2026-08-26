-- chunkname: @modules/logic/summon/view/component/SummonDestinyGiftItem.lua

module("modules.logic.summon.view.component.SummonDestinyGiftItem", package.seeall)

local SummonDestinyGiftItem = class("SummonDestinyGiftItem", UserDataDispose)

function SummonDestinyGiftItem:ctor(summonBtnGroupList, referenceGo, summonPoolId)
	self:__onInit()

	if not gohelper.isNil(referenceGo) and summonBtnGroupList ~= nil and next(summonBtnGroupList) then
		self._summonBtnGroupList = summonBtnGroupList
		self._referenceGo = referenceGo
		self._parentGo = referenceGo.transform.parent.gameObject
		self._summonId = summonPoolId
		self._summonBtnGroupStatusDic = {}

		for index, groupGo in ipairs(self._summonBtnGroupList) do
			if not gohelper.isNil(groupGo) then
				self._summonBtnGroupStatusDic[index] = groupGo.activeSelf
			end
		end

		self._prefabLoader = PrefabInstantiate.Create(self._parentGo)

		local poolConfig = SummonConfig.instance:getSummonPool(summonPoolId)
		local summonInfallibleConfig = SummonConfig.instance:getSummonInfallibleConfig(poolConfig.infallibleItemId)

		self.summonInfallibleConfig = summonInfallibleConfig

		self._prefabLoader:startLoad(summonInfallibleConfig.prefabPath, self.handleInstanceLoaded, self)
	end
end

function SummonDestinyGiftItem:handleInstanceLoaded()
	if self._prefabLoader and self._summonId then
		local itemGo = self._prefabLoader:getInstGO()

		if not gohelper.isNil(self._referenceGo) then
			local siblingIndex = self._referenceGo.transform:GetSiblingIndex()

			itemGo.transform:SetSiblingIndex(siblingIndex + 1)
		end

		self:init(itemGo)
		self:addEvents()
		self:refreshUI()
	end
end

function SummonDestinyGiftItem:init(go)
	self.itemGo = go
	self._btnrabbit = gohelper.findChildButtonWithAudio(self.itemGo, "root/#btn_rabbit")
	self._gocanuse = gohelper.findChild(self.itemGo, "root/#btn_rabbit/#go_canuse")
	self._gousing = gohelper.findChild(self.itemGo, "root/#btn_rabbit/#go_using")
	self._goselected = gohelper.findChild(self.itemGo, "root/#go_selected")
	self._btnsummon1 = gohelper.findChildButtonWithAudio(self.itemGo, "root/summonbtns/summon1/#btn_summon1")
	self._simagecurrency1 = gohelper.findChildSingleImage(self.itemGo, "root/summonbtns/summon1/currency/#simage_currency1")
	self._txtcurrency11 = gohelper.findChildText(self.itemGo, "root/summonbtns/summon1/currency/#txt_currency1_1")
	self._txtcurrency12 = gohelper.findChildText(self.itemGo, "root/summonbtns/summon1/currency/#txt_currency1_2")
	self._gosummonbtn = gohelper.findChild(self.itemGo, "root/summonbtns")
	self._btnsummon10 = gohelper.findChildButtonWithAudio(self.itemGo, "root/summonbtns/summon10/#btn_summon10")
	self._simagecurrency10 = gohelper.findChildSingleImage(self.itemGo, "root/summonbtns/summon10/currency/#simage_currency10")
	self._txtcurrency101 = gohelper.findChildText(self.itemGo, "root/summonbtns/summon10/currency/#txt_currency10_1")
	self._txtcurrency102 = gohelper.findChildText(self.itemGo, "root/summonbtns/summon10/currency/#txt_currency10_2")

	if self._editableInitView then
		self:_editableInitView()
	end

	self.isInit = true
end

function SummonDestinyGiftItem:addEvents()
	self._btnrabbit:AddClickListener(self._btnrabbitOnClick, self)
	self._btnsummon1:AddClickListener(self._btnsummon1OnClick, self)
	self._btnsummon10:AddClickListener(self._btnsummon10OnClick, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonInfallibleStatusChange, self.refreshUI, self)
	self.addEventCb(self, PayController.instance, PayEvent.PayFinished, self.refreshUI, self)
end

function SummonDestinyGiftItem:removeEvents()
	self._btnrabbit:RemoveClickListener()
	self._btnsummon1:RemoveClickListener()
	self._btnsummon10:RemoveClickListener()
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonInfallibleStatusChange, self.refreshUI, self)
	self.removeEventCb(self, PayController.instance, PayEvent.PayFinished, self.refreshUI, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCustomPickViewClose, self)
end

function SummonDestinyGiftItem:_btnrabbitOnClick()
	local co = SummonConfig.instance:getSummonPool(self._summonId)

	if co.type == SummonEnum.Type.StrongCustomOnePick or co.type == SummonEnum.Type.CustomPick then
		local isPick = SummonCustomPickModel.instance:isCustomPickOver(self._summonId)

		if not isPick then
			self:openSelectView()

			return
		end
	end

	self:tryUseItem()
end

function SummonDestinyGiftItem:tryUseItem()
	local poolInfo = SummonMainModel.instance:getPoolServerMO(self._summonId)

	if not poolInfo then
		return
	end

	local itemId = self.summonInfallibleConfig.id
	local count = ItemModel.instance:getItemCount(itemId)

	if count <= 0 then
		return
	end

	local isUnused = poolInfo.infallibleItemStatus == SummonEnum.InfallibleItemState.Unused

	if not isUnused then
		return
	end

	SummonController.instance:useInfallibleItem(self._summonId, itemId, 1, self.onUseInfallibleItem, self)
end

function SummonDestinyGiftItem:openSelectView()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	ViewMgr.instance:openView(ViewName.SummonCustomPickChoice, {
		poolId = curPool.id
	})
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCustomPickViewClose, self)
end

function SummonDestinyGiftItem:onCustomPickViewClose(viewName)
	if viewName == ViewName.SummonCustomPickChoice then
		self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCustomPickViewClose, self)

		local isPick = SummonCustomPickModel.instance:isCustomPickOver(self._summonId)

		if isPick then
			self:tryUseItem()
		end
	end
end

function SummonDestinyGiftItem:onUseInfallibleItem(cmd, resultCode)
	if resultCode ~= 0 then
		return
	end

	SummonMainModel.instance:setSummonInfallibleState(self._summonId, SummonEnum.InfallibleItemState.Using)
end

function SummonDestinyGiftItem:_btnsummon1OnClick()
	local poolInfo = SummonMainModel.instance:getPoolServerMO(self._summonId)

	if not poolInfo then
		return
	end

	local isUnused = poolInfo.infallibleItemStatus == SummonEnum.InfallibleItemState.Unused

	if isUnused then
		return
	end

	SummonMainController.instance:startInfallibleSummon(self._summonId)
end

function SummonDestinyGiftItem:_btnsummon10OnClick()
	return
end

function SummonDestinyGiftItem:_editableInitView()
	gohelper.setActive(self._btnsummon1, true)
	gohelper.setActive(self._btnsummon10, false)

	self._btnUseAnimator = gohelper.findChildComponent(self._btnrabbit.gameObject, "", gohelper.Type_Animator)
	self._btnSummonAnimator = gohelper.findChildComponent(self._gosummonbtn.gameObject, "", gohelper.Type_Animator)
	self._selectAnimator = gohelper.findChildComponent(self._goselected.gameObject, "", gohelper.Type_Animator)
end

function SummonDestinyGiftItem:refreshUI(status)
	if not self.isInit then
		return
	end

	local poolInfo = SummonMainModel.instance:getPoolServerMO(self._summonId)

	if not poolInfo then
		self:setSummonBtnGroupState(true)
		gohelper.setActive(self.itemGo, false)

		return
	end

	local itemId = self.summonInfallibleConfig.id
	local count = ItemModel.instance:getItemCount(itemId)
	local showBtnGroup = false
	local isUsing = poolInfo.infallibleItemStatus == SummonEnum.InfallibleItemState.Using

	showBtnGroup = poolInfo.infallibleItemStatus == SummonEnum.InfallibleItemState.Unused and count > 0 or isUsing

	gohelper.setActive(self.itemGo, showBtnGroup)
	self:setSummonBtnGroupState(not isUsing)

	if not showBtnGroup then
		return
	end

	gohelper.setActive(self._gocanuse, not isUsing)
	gohelper.setActive(self._gousing, isUsing)
	gohelper.setActive(self._gousing, isUsing)
	gohelper.setActive(self._gosummonbtn, isUsing)
	gohelper.setActive(self._goselected, isUsing)

	if isUsing and status and status == SummonEnum.InfallibleItemState.Using then
		self._selectAnimator:Play("in2", 0, 0)
		AudioMgr.instance:trigger(AudioEnum3_4.SummonDestinyGift.useItem)
	else
		self._selectAnimator:Play("in1", 0, 0)
	end

	self._btnSummonAnimator:Play("in", 0, 0)
	self._btnUseAnimator:Play("in", 0, 0)
end

function SummonDestinyGiftItem:setSummonBtnGroupState(active)
	if self._summonBtnGroupList and next(self._summonBtnGroupList) then
		for index, groupGo in ipairs(self._summonBtnGroupList) do
			if not gohelper.isNil(groupGo) then
				gohelper.setActive(groupGo, active)
			end
		end
	end
end

function SummonDestinyGiftItem:dispose()
	tabletool.clear(self._summonBtnGroupList)
	tabletool.clear(self._summonBtnGroupStatusDic)
	self:removeEvents()
	self:__onDispose()
end

return SummonDestinyGiftItem
