-- chunkname: @modules/logic/activity/view/V2a3_Special_SignItem.lua

module("modules.logic.activity.view.V2a3_Special_SignItem", package.seeall)

local V2a3_Special_SignItem = class("V2a3_Special_SignItem", LinkageActivity_Page2RewardBase)

function V2a3_Special_SignItem:onInitView()
	self._txtnum = gohelper.findChildText(self.viewGO, "icon/#txt_num")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "icon/#simage_icon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a3_Special_SignItem:addEvents()
	return
end

function V2a3_Special_SignItem:removeEvents()
	return
end

local split = string.split

function V2a3_Special_SignItem:ctor(...)
	V2a3_Special_SignItem.super.ctor(self, ...)
end

function V2a3_Special_SignItem:onDestroyView()
	V2a3_Special_SignItem.super.onDestroyView(self)
end

function V2a3_Special_SignItem:_editableAddEvents()
	V2a3_Special_SignItem.super._editableInitView(self)
	self._click:AddClickListener(self._onClick, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._OnOpenView, self)
end

function V2a3_Special_SignItem:_editableRemoveEvents()
	self._click:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._OnOpenView, self)
end

function V2a3_Special_SignItem:_editableInitView()
	self._simageiconImg = gohelper.findChildImage(self._simageicon.gameObject, "")
	self._bgImg = gohelper.findChildImage(self.viewGO, "icon/bg")
	self._go_nextday = gohelper.findChild(self.viewGO, "go_nextday")
	self._goCanGet = gohelper.findChild(self.viewGO, "go_canget")
	self._goGet = gohelper.findChild(self.viewGO, "go_hasget")
	self._click = gohelper.getClick(gohelper.findChild(self.viewGO, "clickarea"))
	self._txtnum.text = ""

	self:setActive_goGet(false)
	self:setActive_goCanGet(false)
end

function V2a3_Special_SignItem:onUpdateMO(mo)
	V2a3_Special_SignItem.super.onUpdateMO(self, mo)

	local isClaimed = self:isType101RewardGet()
	local hexColor = isClaimed and "#808080" or "#ffffff"
	local co = self:getNorSignActivityCo()
	local index = self._index
	local rewards = split(co.bonus, "|")
	local rewardCount = #rewards

	assert(rewardCount == 1, string.format("[V2a3_Special_SignItem] rewardCount=%s", tostring(rewardCount)))

	local itemCo = string.splitToNumber(rewards[1], "#")

	mo._itemCo = itemCo

	local c = self:_assetGetViewContainer()
	local resUrl = c:getItemIconResUrl(itemCo[1], itemCo[2])

	GameUtil.loadSImage(self._simageicon, resUrl)
	UIColorHelper.set(self._simageiconImg, hexColor)
	UIColorHelper.set(self._bgImg, hexColor)

	self._txtnum.text = luaLang("multiple") .. itemCo[3]

	self:setActive_goGet(isClaimed)
	self:setActive_goCanGet(self:isType101RewardCouldGet())

	local totalday = self:getType101LoginCount()

	self:setActive_goTmr(totalday + 1 == index)
end

function V2a3_Special_SignItem:setActive_goCanGet(isActive)
	gohelper.setActive(self._goCanGet, isActive)
end

function V2a3_Special_SignItem:setActive_goGet(isActive)
	gohelper.setActive(self._goGet, isActive)
end

function V2a3_Special_SignItem:setActive_goTmr(isActive)
	gohelper.setActive(self._go_nextday, isActive)
end

function V2a3_Special_SignItem:_onClick()
	if not self:isActOnLine() then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	local couldGet = self:isType101RewardCouldGet()

	if couldGet then
		self:sendGet101BonusRequest()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_tags_2000013)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_25050217)

	local mo = self._mo
	local itemCo = mo._itemCo

	MaterialTipController.instance:showMaterialInfo(itemCo[1], itemCo[2])
end

function V2a3_Special_SignItem:_OnOpenView(viewName)
	if viewName == ViewName.RoomBlockPackageGetView then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shenghuo_building_collect_20234002)
	end
end

return V2a3_Special_SignItem
