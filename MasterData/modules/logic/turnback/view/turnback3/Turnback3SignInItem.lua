-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3SignInItem.lua

module("modules.logic.turnback.view.turnback3.Turnback3SignInItem", package.seeall)

local Turnback3SignInItem = class("Turnback3SignInItem", LuaCompBase)

function Turnback3SignInItem:init(go)
	self.go = go
	self._txtday = gohelper.findChildText(self.go, "#txt_day")
	self._gocanget = gohelper.findChild(self.go, "#go_canget")
	self._gohasget = gohelper.findChild(self.go, "#go_hasget")
	self._btncanget = gohelper.findChildButtonWithAudio(self.go, "#go_canget")
	self._btnlatter = gohelper.findChildButtonWithAudio(self.go, "#go_hasget/#btn_latter")
	self._gonexttag = gohelper.findChild(self.go, "#go_TomorrowTag")

	gohelper.setActive(self.go, true)

	self.rewardList = {}
end

function Turnback3SignInItem:addEventListeners()
	TurnbackController.instance.addEventCb(TurnbackController.instance, TurnbackController.instance, TurnbackEvent.RefreshSignInItem, self.refreshItem, self)
	TurnbackController.instance.addEventCb(TurnbackController.instance, TurnbackController.instance, TurnbackEvent.OnSignInReply, self._openRoleTalkView, self)
	self._btncanget:AddClickListener(self._btncangetOnClick, self)
	self._btnlatter:AddClickListener(self._btnlatterOnClick, self)
end

function Turnback3SignInItem:removeEventListeners()
	TurnbackController.instance.removeEventCb(TurnbackController.instance, TurnbackController.instance, TurnbackEvent.RefreshSignInItem, self.refreshItem, self)
	TurnbackController.instance.removeEventCb(TurnbackController.instance, TurnbackController.instance, TurnbackEvent.OnSignInReply, self._openRoleTalkView, self)
	self._btncanget:RemoveClickListener()
	self._btnlatter:RemoveClickListener()

	for index, item in ipairs(self.rewardList) do
		if item.btnClick then
			item.btnClick:RemoveClickListener()
		end
	end
end

function Turnback3SignInItem:initItem(id, prefab)
	self.turnbackId = TurnbackModel.instance:getCurTurnbackId()
	self.id = id
	self._isLastDay = self.id == 7

	local info = TurnbackEnum.SignInSpecialDays[self.turnbackId]

	self._isSpeical = info and info[id]
	self.config = TurnbackConfig.instance:getTurnbackSignInDayCo(self.turnbackId, self.id)
	self.state = TurnbackSignInModel.instance:getSignInStateById(self.id)
	self._txtday.text = "0" .. self.id

	local bonusCo = GameUtil.splitString2(self.config.bonus, true)
	local count = #bonusCo

	self:_initRewardList(count, bonusCo)
	self:_refrshNextTag()
	gohelper.setActive(self._gohasget, self.state == TurnbackEnum.SignInState.HasGet)
	gohelper.setActive(self._gocanget, self.state == TurnbackEnum.SignInState.CanGet)
	gohelper.setActive(self._btncanget.gameObject, self.state == TurnbackEnum.SignInState.CanGet)
	gohelper.setActive(self._btnlatter.gameObject, self.state == TurnbackEnum.SignInState.CanGet or self.state == TurnbackEnum.SignInState.HasGet)
end

function Turnback3SignInItem:_initRewardList(count, bonusCo)
	for i = 1, count do
		local rewardItem = self.rewardList[i]

		if not rewardItem then
			local co = bonusCo[i]
			local type, id, num = co[1], co[2], co[3]
			local config, icon = ItemModel.instance:getItemConfigAndIcon(type, id, true)

			rewardItem = self:getUserDataTb_()
			rewardItem.go = gohelper.findChild(self.go, "reward" .. i)

			if rewardItem.go then
				rewardItem.goIcon = gohelper.findChild(rewardItem.go, "#go_itemicon")
				rewardItem.txtNum = gohelper.findChildText(rewardItem.go, "txt_rewardcount")
				rewardItem.imgbg = gohelper.findChildImage(rewardItem.go, "image_bg")

				if self._isSpeical then
					rewardItem.btnClick = gohelper.findChildButton(rewardItem.go, "#btn_click")

					rewardItem.btnClick:AddClickListener(self._clickItem, self, co)
				end

				if icon then
					rewardItem.itemIcon = IconMgr.instance:getCommonPropItemIcon(rewardItem.goIcon)

					rewardItem.itemIcon:setMOValue(type, id, num, nil, true)
					rewardItem.itemIcon:isShowQuality(false)
					rewardItem.itemIcon:isShowCount(false)
				end

				rewardItem.txtNum.text = "×" .. num

				UISpriteSetMgr.instance:setUiFBSprite(rewardItem.imgbg, "bg_pinjidi_" .. config.rare)
				table.insert(self.rewardList, rewardItem)
			end
		end
	end
end

function Turnback3SignInItem:_clickItem(bonusCo)
	MaterialTipController.instance:showMaterialInfo(bonusCo[1], bonusCo[2])
end

function Turnback3SignInItem:refreshItem()
	self.state = TurnbackSignInModel.instance:getSignInStateById(self.id)

	gohelper.setActive(self._gohasget, self.state == TurnbackEnum.SignInState.HasGet)
	gohelper.setActive(self._gocanget, self.state == TurnbackEnum.SignInState.CanGet)
	gohelper.setActive(self._btncanget.gameObject, self.state == TurnbackEnum.SignInState.CanGet)
	gohelper.setActive(self._btnlatter.gameObject, self.state == TurnbackEnum.SignInState.CanGet or self.state == TurnbackEnum.SignInState.HasGet)
	self:_refrshNextTag()
end

function Turnback3SignInItem:_refrshNextTag()
	local showTag = TurnbackSignInModel.instance:checkShowNextTag(self.id)
	local day, hour, minute = TurnbackModel.instance:getRemainTime()

	gohelper.setActive(self._gonexttag, (day < 1 or nil) and false)
end

function Turnback3SignInItem:_btncangetOnClick()
	if self.state == TurnbackEnum.SignInState.CanGet then
		local turnbackId = TurnbackModel.instance:getCurTurnbackId()

		TurnbackRpc.instance:sendTurnbackSignInRequest(turnbackId, self.id)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_OK)
	end
end

function Turnback3SignInItem:_btnlatterOnClick()
	self:_openRoleTalkView({
		isNormal = true,
		day = self.id
	})
end

function Turnback3SignInItem:_openRoleTalkView(param)
	local day = param.day
	local isNormal = param.isNormal

	ViewMgr.instance:openView(ViewName.Turnback3SignInRoleTalkView, {
		day = day,
		isNormal = isNormal
	})
end

function Turnback3SignInItem:onDestroy()
	return
end

return Turnback3SignInItem
