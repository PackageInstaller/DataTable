-- chunkname: @modules/logic/turnback/view/new/view/TurnbackNewSignInItem.lua

module("modules.logic.turnback.view.new.view.TurnbackNewSignInItem", package.seeall)

local TurnbackNewSignInItem = class("TurnbackNewSignInItem", LuaCompBase)

function TurnbackNewSignInItem:init(go)
	self.go = go
	self._txtday = gohelper.findChildText(self.go, "group/txt_day")
	self._gocanget = gohelper.findChild(self.go, "#go_canget")
	self._gohasget = gohelper.findChild(self.go, "#go_hasget")
	self._btncanget = gohelper.findChildButtonWithAudio(self.go, "#btn_click")
	self._btnlatter = gohelper.findChildButtonWithAudio(self.go, "#btn_latter")
	self.canvasgroup = gohelper.findChild(self.go, "group"):GetComponent(typeof(UnityEngine.CanvasGroup))
	self.rewardList = {}
end

function TurnbackNewSignInItem:addEventListeners()
	TurnbackController.instance.addEventCb(TurnbackController.instance, TurnbackController.instance, TurnbackEvent.RefreshSignInItem, self.refreshItem, self)
	self._btncanget:AddClickListener(self._btncangetOnClick, self)
	self._btnlatter:AddClickListener(self._btnlatterOnClick, self)
end

function TurnbackNewSignInItem:removeEventListeners()
	TurnbackController.instance.removeEventCb(TurnbackController.instance, TurnbackController.instance, TurnbackEvent.RefreshSignInItem, self.refreshItem, self)
	self._btncanget:RemoveClickListener()
	self._btnlatter:RemoveClickListener()

	if self._isLastDay then
		self.btndetail:RemoveClickListener()
	end
end

function TurnbackNewSignInItem:initItem(id)
	self.turnbackId = TurnbackModel.instance:getCurTurnbackId()
	self.id = id
	self._isLastDay = self.id == 7
	self.config = TurnbackConfig.instance:getTurnbackSignInDayCo(self.turnbackId, self.id)
	self.state = TurnbackSignInModel.instance:getSignInStateById(self.id)

	if not self._isLastDay then
		self._txtday.text = "0" .. self.id

		local bonusCo = GameUtil.splitString2(self.config.bonus, true)

		for i = 1, 2 do
			local rewardItem = self.rewardList[i]

			if not rewardItem then
				rewardItem = self:getUserDataTb_()
				rewardItem.go = gohelper.findChild(self.go, "group/reward" .. i)
				rewardItem.goIcon = gohelper.findChild(rewardItem.go, "rewardicon")
				rewardItem.txtNum = gohelper.findChildText(rewardItem.go, "#txt_num")

				local co = bonusCo[i]
				local type, id, num = co[1], co[2], co[3]
				local config, icon = ItemModel.instance:getItemConfigAndIcon(type, id, true)

				if icon then
					rewardItem.itemIcon = IconMgr.instance:getCommonPropItemIcon(rewardItem.goIcon)

					rewardItem.itemIcon:setMOValue(type, id, num, nil, true)
					rewardItem.itemIcon:isShowQuality(false)
					rewardItem.itemIcon:isShowCount(false)
				end

				rewardItem.txtNum.text = num

				table.insert(self.rewardList, rewardItem)
			end
		end
	else
		self.btndetail = gohelper.findChildButtonWithAudio(self.go, "group/dec3")

		self.btndetail:AddClickListener(self._btndetailOnClick, self)
	end

	self.canvasgroup.alpha = self.state == TurnbackEnum.SignInState.HasGet and 0.5 or 1

	gohelper.setActive(self._gohasget, self.state == TurnbackEnum.SignInState.HasGet)
	gohelper.setActive(self._gocanget, self.state == TurnbackEnum.SignInState.CanGet)
	gohelper.setActive(self._btncanget.gameObject, self.state == TurnbackEnum.SignInState.CanGet)
	gohelper.setActive(self._btnlatter.gameObject, self.state == TurnbackEnum.SignInState.CanGet or self.state == TurnbackEnum.SignInState.HasGet)
end

function TurnbackNewSignInItem:refreshItem()
	self.state = TurnbackSignInModel.instance:getSignInStateById(self.id)
	self.canvasgroup.alpha = self.state == TurnbackEnum.SignInState.HasGet and 0.5 or 1

	gohelper.setActive(self._gohasget, self.state == TurnbackEnum.SignInState.HasGet)
	gohelper.setActive(self._gocanget, self.state == TurnbackEnum.SignInState.CanGet)
	gohelper.setActive(self._btncanget.gameObject, self.state == TurnbackEnum.SignInState.CanGet)
	gohelper.setActive(self._btnlatter.gameObject, self.state == TurnbackEnum.SignInState.CanGet or self.state == TurnbackEnum.SignInState.HasGet)
end

function TurnbackNewSignInItem:_btncangetOnClick()
	if self.state == TurnbackEnum.SignInState.CanGet then
		local turnbackId = TurnbackModel.instance:getCurTurnbackId()

		TurnbackRpc.instance:sendTurnbackSignInRequest(turnbackId, self.id)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_OK)
	end
end

function TurnbackNewSignInItem:_btndetailOnClick()
	ViewMgr.instance:openView(ViewName.TurnbackNewShowRewardView, {
		bonus = self.config.bonus
	})
end

function TurnbackNewSignInItem:_btnlatterOnClick()
	if self.id == 1 then
		ViewMgr.instance:openView(ViewName.TurnbackNewLatterView, {
			isNormal = false,
			notfirst = true,
			day = self.id
		})
	else
		ViewMgr.instance:openView(ViewName.TurnbackNewLatterView, {
			isNormal = true,
			day = self.id
		})
	end
end

function TurnbackNewSignInItem:_btnclickOnClick()
	ViewMgr.openView(ViewName.TurnbackLatterView, self.id)
end

function TurnbackNewSignInItem:onDestroy()
	return
end

return TurnbackNewSignInItem
