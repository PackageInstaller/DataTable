-- chunkname: @modules/logic/turnback/view/turnback4/Turnback4RewardItem.lua

module("modules.logic.turnback.view.turnback4.Turnback4RewardItem", package.seeall)

local Turnback4RewardItem = class("Turnback4RewardItem", ListScrollCellExtend)

function Turnback4RewardItem:onInitView()
	self._txtdesc = gohelper.findChildText(self.viewGO, "#txt_desc")
	self._simgebg = gohelper.findChildSingleImage(self.viewGO, "bg")
	self._scrollrewards = gohelper.findChildScrollRect(self.viewGO, "#scroll_rewards")
	self._gorewards = gohelper.findChild(self.viewGO, "#scroll_rewards/Viewport/#go_rewards")
	self._gohasget = gohelper.findChild(self.viewGO, "Btn/#go_hasget")
	self._btnlock = gohelper.findChildButtonWithAudio(self.viewGO, "Btn/#go_lock")
	self._btncanget = gohelper.findChildButtonWithAudio(self.viewGO, "Btn/#btn_canget")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Turnback4RewardItem:addEvents()
	self._btncanget:AddClickListener(self._btncangetOnClick, self)
	self._btnlock:AddClickListener(self._btnLockOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function Turnback4RewardItem:removeEvents()
	self._btncanget:RemoveClickListener()
	self._btnlock:RemoveClickListener()
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish)
end

function Turnback4RewardItem:_btncangetOnClick()
	if self._mo.state ~= TurnbackEnum.SearchState.CanGet then
		return
	end

	self._playRefreshAnim = true

	TurnbackRpc.instance:sendTurnbackReturnRewardRequest(self._turnbackInfoMo.id, self._mo.rewardId)
end

function Turnback4RewardItem:_btnLockOnClick()
	ToastController.instance:showToast(ToastEnum.TurnBackReturnRewardTip)
end

function Turnback4RewardItem:_cangetFinish()
	self._playRefreshAnim = false

	self:onUpdateMO(self._mo)
	TurnbackController.instance:dispatchEvent(TurnbackEvent.OnFinishReturnRewardRefreshAnim)
end

function Turnback4RewardItem:_onCloseViewFinish(viewName)
	if viewName == ViewName.CommonPropView and self._playRefreshAnim then
		self._animator:Play("refresh", 0, 0)
		TaskDispatcher.runDelay(self._cangetFinish, self, 0.2)
		AudioMgr.instance:trigger(AudioEnum3_9.TurnBack.play_ui_shuori_qiyuan_down)
	end
end

function Turnback4RewardItem:_onCurrencyChange()
	return
end

function Turnback4RewardItem:_editableInitView()
	self._gorewarditem = gohelper.findChild(self.viewGO, "#scroll_rewards/Viewport/#go_rewards/#go_rewarditem")
	self._rewardItems = self:getUserDataTb_()

	gohelper.setActive(self._gorewarditem.gameObject, false)

	self._gocanget = gohelper.findChild(self.viewGO, "#canget")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._descAnimator = self._txtdesc.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self._gorefreshvx = gohelper.findChild(self.viewGO, "#txt_desc/#vx_add2")
end

function Turnback4RewardItem:_editableAddEvents()
	return
end

function Turnback4RewardItem:_editableRemoveEvents()
	return
end

function Turnback4RewardItem:_playDescRefershAnim()
	if not self._mo then
		return
	end

	local point = self._turnbackInfoMo:getReturnRewardInfo().vitality or 0
	local needVitality = self._mo.needVitality
	local animName
	local needPoint = needVitality - point

	self._needPoint = needPoint

	self._descAnimator:Play(needPoint <= 0 and "refresh1" or "refresh2", 0, 0)
end

function Turnback4RewardItem:onUpdateMO(mo)
	if not mo then
		return
	end

	if self._mo and self._mo.rewardId ~= mo.rewardId then
		self._playRefreshAnim = true
	end

	self._turnbackInfoMo = TurnbackModel.instance:getCurTurnbackMo()
	self._mo = mo

	if self._playRefreshAnim then
		return
	end

	local needVitality = mo.needVitality
	local title

	if needVitality == 0 then
		local lang = luaLang("return4_reward_getbonus_1")
		local day = self._turnbackInfoMo:getLeaveDay()

		title = GameUtil.getSubPlaceholderLuaLangOneParam(lang, day)
	else
		local curPoint = self._turnbackInfoMo:getReturnRewardInfo().vitality or 0
		local point = needVitality - curPoint

		point = math.max(point, 0)

		if self._needPoint and self._needPoint ~= point then
			self._needPoint = point

			self:_playDescRefershAnim()

			return
		end

		if point <= 0 then
			title = luaLang("return4_reward_getbonus_3")
		else
			local lang = luaLang("return4_reward_getbonus_2")

			title = GameUtil.getSubPlaceholderLuaLangOneParam(lang, point)

			local startIndex, endIndex = string.find(title, "<sprite=")
			local preStr = string.sub(title, 1, startIndex)
			local textInfo = self._txtdesc:GetTextInfo(title)
			local preLen = GameUtil.utf8len(preStr)
			local characterInfo = textInfo.characterInfo[preLen]
			local startBL = characterInfo.bottomLeft

			recthelper.setAnchorX(self._gorefreshvx.transform, startBL.x)
		end

		self._needPoint = point
	end

	if not string.nilorempty(title) then
		self._txtdesc.text = title
	end

	self:_refreshRewards()
	self:_refreshState()
end

function Turnback4RewardItem:_refreshRewards()
	local rewards = self._mo.bonus

	if rewards then
		for i, v in ipairs(rewards) do
			local item = self:_getRewardItem(i)
			local materialType = v[1]
			local materialId = v[2]
			local count = v[3]
			local isReceive = self._mo.state == TurnbackEnum.SearchState.HasGet

			item.iconItem:setMOValue(materialType, materialId, count, nil, true)
			item.iconItem:isShowCount(v[1] ~= MaterialEnum.MaterialType.Hero and not isReceive)
			item.iconItem:setCountFontSize(45)
			item.iconItem:showStackableNum2()
			item.iconItem:hideEquipLvAndCount()
			item.iconItem:customOnClickCallback(self._ItemOnClick, self, v)
			gohelper.setActive(item.gocanget, false)
			gohelper.setActive(item.goreceive, isReceive)
		end
	end

	if rewards then
		if not #rewards then
			local count = 0

			for i, item in ipairs(self._rewardItems) do
				gohelper.setActive(item.go, i <= count)
			end
		end
	end
end

function Turnback4RewardItem:_ItemOnClick(info)
	if self._mo.state ~= TurnbackEnum.SearchState.CanGet then
		MaterialTipController.instance:showMaterialInfo(info[1], info[2])

		return
	end

	self:_btncangetOnClick()
end

function Turnback4RewardItem:_getRewardItem(index)
	local item = self._rewardItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._gorewarditem)
		item.itemParent = gohelper.findChild(item.go, "go_icon")
		item.gocanget = gohelper.findChild(item.go, "go_canget")
		item.goreceive = gohelper.findChild(item.go, "go_receive")
		item.iconItem = IconMgr.instance:getCommonItemIcon(item.itemParent)
		self._rewardItems[index] = item
	end

	return item
end

function Turnback4RewardItem:_refreshState()
	local isCanGet = self._mo.state == TurnbackEnum.SearchState.CanGet
	local isHasGet = self._mo.state == TurnbackEnum.SearchState.HasGet
	local isNotFinish = self._mo.state == TurnbackEnum.SearchState.NotFinish

	gohelper.setActive(self._gocanget.gameObject, isCanGet)
	gohelper.setActive(self._btncanget.gameObject, isCanGet)
	gohelper.setActive(self._gohasget.gameObject, isHasGet)
	gohelper.setActive(self._btnlock.gameObject, isNotFinish)

	local bg = "turnback3/return4_rewardview_panelbg0" .. (isHasGet and "2" or "1")

	self._simgebg:LoadImage(ResUrl.getTurnbackIcon(bg))
end

function Turnback4RewardItem:onDestroyView()
	TaskDispatcher.cancelTask(self._cangetFinish, self)
	self._simgebg:UnLoadImage()
end

return Turnback4RewardItem
