-- chunkname: @modules/logic/partygame/view/common/PartyGameResultView.lua

module("modules.logic.partygame.view.common.PartyGameResultView", package.seeall)

local PartyGameResultView = class("PartyGameResultView", BaseView)

function PartyGameResultView:onInitView()
	self._imagefullbg1 = gohelper.findChildImage(self.viewGO, "#image_fullbg1")
	self._imagefullbg2 = gohelper.findChildImage(self.viewGO, "#image_fullbg2")
	self._gofail = gohelper.findChild(self.viewGO, "root/#go_fail")
	self._txtrank = gohelper.findChildText(self.viewGO, "root/#go_fail/left/#txt_rank")
	self._gosuccess = gohelper.findChild(self.viewGO, "root/#go_success")
	self._txtrank1 = gohelper.findChildText(self.viewGO, "root/#go_success/left/#txt_rank_1")
	self._goperson = gohelper.findChild(self.viewGO, "root/#go_person")
	self._goreward = gohelper.findChild(self.viewGO, "root/#go_reward")
	self._goContent = gohelper.findChild(self.viewGO, "root/#go_reward/scroll_Reward/Viewport/#go_Content")
	self._txtclose = gohelper.findChildText(self.viewGO, "root/#txt_close")
	self._goicon = gohelper.findChild(self.viewGO, "root/#go_icon")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PartyGameResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function PartyGameResultView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function PartyGameResultView:_btncloseOnClick()
	self:closeThis()
end

function PartyGameResultView:_editableInitView()
	self._anim = self.viewGO:GetComponent(gohelper.Type_Animator)
end

function PartyGameResultView:onUpdateParam()
	return
end

function PartyGameResultView:onOpen()
	PartyGameController.instance:KcpEndConnect()
	PartyMatchRpc.instance:sendTriggerPartyResultRequest()

	self.data = self.viewParam

	local rank = self.data.Rank

	if not self.data.Rewards then
		local rewardCount = 0
		local exReward = self.data.ExReward
		local text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("knockout_result_rank_other"), rank)

		if rank <= 3 then
			text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("knockout_result_rank_" .. rank), rank)
		end

		self._txtrank.text = text
		self._txtrank1.text = text

		local isWin = rank == 1

		gohelper.setActive(self._imagefullbg1.gameObject, isWin)
		gohelper.setActive(self._imagefullbg2.gameObject, not isWin)
		gohelper.setActive(self._gosuccess, isWin)
		gohelper.setActive(self._gofail, not isWin)
		gohelper.setActive(self._goreward, rewardCount > 0 or not string.nilorempty(self.exReward))

		self._curGame = PartyGameController.instance:getCurPartyGame()
		self._gameConfig = self._curGame:getGameConfig()
		self._mainPlayerUid = self._curGame:getMainPlayerUid()
		self._spineComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._goperson, CommonPartyGamePlayerSpineComp)

		self._spineComp:initSpine(self._mainPlayerUid)

		if isWin then
			self._spineComp:playAnim("happyLoop", true, false)
		end

		gohelper.setActive(self._btnclose.gameObject, false)
		TaskDispatcher.runDelay(self.showCloseBtn, self, PartyGameEnum.resultCountDownTime)

		local rewardItem = IconMgr.instance:getCommonPropItemIcon(self._goContent)

		rewardItem:setMOValue(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.V3a9PartyGameStoreCoin, rewardCount)

		if not string.nilorempty(exReward) then
			local allData = string.splitToNumber(exReward, "#")
			local exRewardItem = IconMgr.instance:getCommonPropItemIcon(self._goContent)

			exRewardItem:setMOValue(allData[1], allData[2], allData[3])

			local go = gohelper.clone(self._goicon, exRewardItem.go)

			gohelper.setActive(go, true)
			transformhelper.setLocalPos(go.transform, 0, 0, 0)
		end

		local key = isWin and "success_open" or "fail_open"

		if self._anim then
			self._anim:Play(key, 0, 0)

			local var_7_1

			if isWin then
				var_7_1 = AudioEnum3_4.PartyGameCommon.play_ui_wulu_aizila_level_enter or AudioEnum3_4.PartyGameCommon.play_ui_lushang_enemy_occupy
			end
		end

		AudioMgr.instance:trigger(var_7_1)
		PartyGameStatHelper.instance:partySettle(isWin, rank, self.data.PartyId)
	end
end

function PartyGameResultView:showCloseBtn()
	gohelper.setActive(self._btnclose.gameObject, true)
end

function PartyGameResultView:onClose()
	PartyGameController.instance:exitPartyGame()
end

function PartyGameResultView:onDestroyView()
	TaskDispatcher.cancelTask(self.showCloseBtn, self)

	if self._spineComp ~= nil then
		self._spineComp:onDestroy()

		self._spineComp = nil
	end
end

return PartyGameResultView
