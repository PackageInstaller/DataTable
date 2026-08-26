-- chunkname: @modules/logic/versionactivity1_4/act133/view/Activity133ListItem.lua

module("modules.logic.versionactivity1_4.act133.view.Activity133ListItem", package.seeall)

local Activity133ListItem = class("Activity133ListItem", ListScrollCellExtend)

function Activity133ListItem:onInitView()
	self._imageitem = gohelper.findChildImage(self.viewGO, "#image_item")
	self._golock = gohelper.findChild(self.viewGO, "#image_item/lockbg")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "#scroll_reward"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self._gocontent = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/Content")
	self._goitem = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/Content/#go_item")
	self._btnfix = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_fix")
	self._goFixIcon = gohelper.findChild(self.viewGO, "bottom/#btn_fix/icon")
	self._goCanFix = gohelper.findChild(self.viewGO, "bottom/#btn_fix/icon1")
	self._btncheck = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_check")
	self._btnchecking = gohelper.findChildButtonWithAudio(self.viewGO, "bg_checking/#btn_checking")
	self._imgcost = gohelper.findChildImage(self.viewGO, "bottom/cost/txt/#simage_icon")
	self._txtcost = gohelper.findChildText(self.viewGO, "bottom/cost/txt")
	self._gochecking = gohelper.findChild(self.viewGO, "bottom/#go_checking")
	self._gocost = gohelper.findChild(self.viewGO, "bottom/cost")
	self._gobuyed = gohelper.findChild(self.viewGO, "bottom/buyed")
	self._txttitle = gohelper.findChildText(self.viewGO, "bottom/buyed/#txt_title")
	self._gocheckbg = gohelper.findChild(self.viewGO, "bg_checking")
	self._golockbg = gohelper.findChild(self.viewGO, "bg_lockedmask")
	self._goreddot = gohelper.findChild(self.viewGO, "bottom/#btn_fix/icon/#go_reddot")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._unlockAniTime = 1

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity133ListItem:addEvents()
	self._btnfix:AddClickListener(self._btnfixOnClick, self)
	self._btncheck:AddClickListener(self._btncheckOnClick, self)
	self._btnchecking:AddClickListener(self._btncheckingOnClick, self)
	self.addEventCb(self, Activity133Controller.instance, Activity133Event.OnUpdateInfo, self._refreshStatus, self)
	self.addEventCb(self, Activity133Controller.instance, Activity133Event.OnGetBonus, self._refreshStatus, self)
end

function Activity133ListItem:removeEvents()
	self._btnfix:RemoveClickListener()
	self._btncheck:RemoveClickListener()
	self._btnchecking:RemoveClickListener()
	self.removeEventCb(self, Activity133Controller.instance, Activity133Event.OnUpdateInfo, self._refreshStatus, self)
	self.removeEventCb(self, Activity133Controller.instance, Activity133Event.OnGetBonus, self._refreshStatus, self)
end

function Activity133ListItem:_btnfixOnClick()
	local havenum = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Act133).quantity

	if havenum >= tonumber(self.targetNum) then
		self._animator.speed = 1

		UIBlockMgr.instance:startBlock("Activity133ListItem")
		self._animator:Play(UIAnimationName.Unlock, 0, 0)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_qiutu_list_maintain)
		self._animator:Update(0)
		TaskDispatcher.runDelay(self._onItemFixAniFinish, self, self._unlockAniTime)
	else
		GameFacade.showToast(ToastEnum.DiamondBuy, self.costName)
	end
end

function Activity133ListItem:_onItemFixAniFinish()
	UIBlockMgr.instance:endBlock("Activity133ListItem")
	Activity133Rpc.instance:sendAct133BonusRequest(self.actId, self.id)
end

function Activity133ListItem:_btncheckOnClick()
	self._view:selectCell(self._index, true)
end

function Activity133ListItem:_btncheckingOnClick()
	self._view:selectCell(self._index, false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
	Activity133Controller.instance:dispatchEvent(Activity133Event.OnSelectCheckNote)
end

function Activity133ListItem:_editableInitView()
	self._itemList = {}
	self._isfix = false
end

function Activity133ListItem:onUpdateMO(mo)
	self.mo = mo

	self:_refreshUI()
	self:_checkRedDot()
end

function Activity133ListItem:_checkRedDot()
	local havenum = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Act133).quantity

	self._canGet = havenum >= tonumber(self.targetNum)

	gohelper.setActive(self._goFixIcon, not self._canGet)
	gohelper.setActive(self._goCanFix, self._canGet)
end

function Activity133ListItem:_refreshUI()
	local config = self.mo.config

	self.actId = config.activityId
	self.id = config.id
	self.iconid = config.icon

	UISpriteSetMgr.instance:setV1a4ShiprepairSprite(self._imageitem, tostring(config.icon))

	local costs = string.splitToNumber(config.needTokens, "#")
	local costType = costs[1]
	local costId = costs[2]
	local costQuantity = costs[3]
	local costCo = ItemModel.instance:getItemConfig(costType, costId)

	self.targetNum = costQuantity

	if costCo then
		self.costName = costCo.name or ""
	end

	local costConfig, costIcon = ItemModel.instance:getItemConfigAndIcon(costType, costId)
	local id = costConfig.icon
	local str = string.format("%s_1", id)

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imgcost, str)

	self._txtcost.text = self.targetNum
	self._txttitle.text = config.title

	local bonus = GameUtil.splitString2(config.bonus, true)

	for i, value in ipairs(bonus) do
		local item = self._itemList[i]

		if not item then
			item = self:getUserDataTb_()
			item.go = gohelper.cloneInPlace(self._goitem)

			gohelper.setActive(item.go, true)

			item.icon = IconMgr.instance:getCommonPropItemIcon(item.go)
			item.goget = gohelper.findChild(item.go, "get")

			gohelper.setAsLastSibling(item.goget)
			gohelper.setActive(item.goget, false)
			table.insert(self._itemList, item)
		end

		item.icon:setMOValue(value[1], value[2], value[3], nil, true)
		item.icon:SetCountLocalY(45)
		item.icon:SetCountBgHeight(30)
		item.icon:setCountFontSize(36)
	end

	self:_refreshStatus()
end

function Activity133ListItem:_refreshStatus()
	local isfix = Activity133Model.instance:checkBonusReceived(self.mo.id)

	gohelper.setActive(self._btnfix.gameObject, not isfix)
	gohelper.setActive(self._btncheck.gameObject, isfix)
	gohelper.setActive(self._golock, not isfix)
	gohelper.setActive(self._golockbg, not isfix)
	gohelper.setActive(self._gocost, not isfix)
	gohelper.setActive(self._gobuyed, isfix)

	for _, item in pairs(self._itemList) do
		gohelper.setActive(item.goget, isfix)

		if isfix then
			item.icon:setAlpha(0.45, 0.8)
		else
			item.icon:setAlpha(1, 1)
		end
	end
end

function Activity133ListItem:getAnimator()
	return self._animator
end

function Activity133ListItem:onSelect(isSelect)
	gohelper.setActive(self._btncheck.gameObject, not isSelect)
	gohelper.setActive(self._gochecking, isSelect)
	gohelper.setActive(self._gocheckbg, isSelect)

	if isSelect then
		Activity133Controller.instance:dispatchEvent(Activity133Event.OnSelectCheckNote, self.mo)
	end
end

function Activity133ListItem:onDestroyView()
	return
end

return Activity133ListItem
