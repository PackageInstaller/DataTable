-- chunkname: @modules/logic/versionactivity2_5/act186/view/Activity186SignItem.lua

module("modules.logic.versionactivity2_5.act186.view.Activity186SignItem", package.seeall)

local Activity186SignItem = class("Activity186SignItem", ListScrollCellExtend)

function Activity186SignItem:onInitView()
	self.txtIndex = gohelper.findChildTextMesh(self.viewGO, "txtIndex")
	self.goTomorrow = gohelper.findChild(self.viewGO, "#go_TomorrowTag")
	self.goNormal = gohelper.findChild(self.viewGO, "#go_normal")
	self.goCanget = gohelper.findChild(self.viewGO, "#go_canget")
	self.goCangetCookies1 = gohelper.findChild(self.viewGO, "#go_canget/cookies1")
	self.goCangetCookies2 = gohelper.findChild(self.viewGO, "#go_canget/cookies2")
	self.goHasget = gohelper.findChild(self.viewGO, "#go_hasget")
	self.btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "btnClick")
	self.canvasGroup = gohelper.findChildComponent(self.viewGO, "#go_rewards", gohelper.Type_CanvasGroup)
	self.rewardList = {}
	self.hasgetCookiesAnim = gohelper.findChildComponent(self.viewGO, "#go_hasget/cookies/ani", gohelper.Type_Animator)
	self.hasgetHookAnim = gohelper.findChildComponent(self.viewGO, "#go_hasget/gou/go_hasget", gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity186SignItem:addEvents()
	self.btnClick:AddClickListener(self.onClickBtn, self)
end

function Activity186SignItem:removeEvents()
	self.btnClick:RemoveClickListener()
end

function Activity186SignItem:_editableInitView()
	return
end

function Activity186SignItem:initActId(actId)
	self.act186Id = actId
end

function Activity186SignItem:onClickBtn()
	if not self._mo then
		return
	end

	local status = Activity186SignModel.instance:getSignStatus(self._mo.activityId, self.act186Id, self._mo.id)

	if status == Activity186Enum.SignStatus.Canget then
		Activity101Rpc.instance:sendGet101BonusRequest(self._mo.activityId, self._mo.id)
	elseif status == Activity186Enum.SignStatus.None then
		GameFacade.showToast(ToastEnum.NorSign)
	else
		ViewMgr.instance:openView(ViewName.Activity186GameBiscuitsView, {
			config = self._mo,
			act186Id = self.act186Id
		})
	end
end

function Activity186SignItem:onUpdateMO(mo)
	self._mo = mo

	if not mo then
		gohelper.setActive(self.viewGO, false)

		return
	end

	gohelper.setActive(self.viewGO, true)
	self:refreshView()
end

function Activity186SignItem:refreshView()
	local index = self._mo.id
	local totalday = ActivityType101Model.instance:getType101LoginCount(self._mo.activityId)

	gohelper.setActive(self.goTomorrow, index == totalday + 1)

	local status = Activity186SignModel.instance:getSignStatus(self._mo.activityId, self.act186Id, index)

	if self.status then
		local isChangeStatus = self.status ~= status

		gohelper.setActive(self.goNormal, status == Activity186Enum.SignStatus.None)
		gohelper.setActive(self.goCanget, status == Activity186Enum.SignStatus.Canplay or status == Activity186Enum.SignStatus.Canget)
		gohelper.setActive(self.goCangetCookies1, status == Activity186Enum.SignStatus.Canplay)
		gohelper.setActive(self.goCangetCookies2, status == Activity186Enum.SignStatus.Canget)
		gohelper.setActive(self.goHasget, status == Activity186Enum.SignStatus.Hasget)

		self.txtIndex.text = status == Activity186Enum.SignStatus.Hasget and string.format("<color=#6A372C>Day %s</color>", index) or string.format("Day %s", index)
		self.canvasGroup.alpha = status == Activity186Enum.SignStatus.Hasget and 0.5 or 1

		self:refreshReward(status)

		if status == Activity186Enum.SignStatus.Hasget then
			if isChangeStatus then
				self.hasgetCookiesAnim:Play("open")
				self.hasgetHookAnim:Play("go_hasget_in")
			else
				self.hasgetCookiesAnim:Play("opened")
				self.hasgetHookAnim:Play("go_hasget_idle")
			end
		end

		self.status = status
	end
end

function Activity186SignItem:refreshReward(status)
	local rewards = GameUtil.splitString2(self._mo.bonus, true)

	for i = 1, math.max(#rewards, #self.rewardList) do
		self:updateRewardItem(self:getOrCreateRewardItem(i), rewards[i], status)
	end
end

function Activity186SignItem:getOrCreateRewardItem(index)
	local item = self.rewardList[index]

	if not item then
		local go = gohelper.findChild(self.viewGO, "#go_rewards/#go_reward" .. index)

		if not go then
			return
		end

		item = self:getUserDataTb_()
		item.go = go
		item.goIcon = gohelper.findChild(go, "go_icon")
		self.rewardList[index] = item
	end

	return item
end

function Activity186SignItem:updateRewardItem(item, data, status)
	if not item then
		return
	end

	if not data then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	item.itemIcon = item.itemIcon or IconMgr.instance:getCommonPropItemIcon(item.goIcon)

	item.itemIcon:setMOValue(data[1], data[2], data[3])
	item.itemIcon:setScale(0.7)
	item.itemIcon:setCountFontSize(46)
	item.itemIcon:setHideLvAndBreakFlag(true)
	item.itemIcon:hideEquipLvAndBreak(true)

	local param = {
		actId = self._mo.activityId,
		index = self._mo.id,
		status = status,
		itemCo = data,
		selfitem = self
	}

	item.itemIcon:customOnClickCallback(Activity186SignItem.onClickItemIcon, param)
end

function Activity186SignItem.onClickItemIcon(param)
	local actId = param.actId

	if not ActivityModel.instance:isActOnLine(actId) then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	local itemCo = param.itemCo

	MaterialTipController.instance:showMaterialInfo(itemCo[1], itemCo[2])
end

function Activity186SignItem:onDestroyView()
	return
end

return Activity186SignItem
