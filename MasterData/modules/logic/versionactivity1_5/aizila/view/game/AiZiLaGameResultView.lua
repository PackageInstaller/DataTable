-- chunkname: @modules/logic/versionactivity1_5/aizila/view/game/AiZiLaGameResultView.lua

module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameResultView", package.seeall)

local AiZiLaGameResultView = class("AiZiLaGameResultView", BaseView)

function AiZiLaGameResultView:onInitView()
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg2")
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg1")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._txtday = gohelper.findChildText(self.viewGO, "content/Title/#txt_day")
	self._txtTitle = gohelper.findChildText(self.viewGO, "content/Title/#txt_Title")
	self._gosuccess = gohelper.findChild(self.viewGO, "content/#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "content/#go_fail")
	self._txtuseTimes = gohelper.findChildText(self.viewGO, "content/roundUse/#txt_useTimes")
	self._txttimes = gohelper.findChildText(self.viewGO, "content/round/#txt_times")
	self._goTips = gohelper.findChild(self.viewGO, "content/Layout/#go_Tips")
	self._txtTips = gohelper.findChildText(self.viewGO, "content/Layout/#go_Tips/#txt_Tips")
	self._scrollItems = gohelper.findChildScrollRect(self.viewGO, "content/Layout/#scroll_Items")
	self._gorewardContent = gohelper.findChild(self.viewGO, "content/Layout/#scroll_Items/Viewport/#go_rewardContent")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AiZiLaGameResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function AiZiLaGameResultView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function AiZiLaGameResultView:_btncloseOnClick()
	if self:isLockOp() then
		return
	end

	AiZiLaGameController.instance:gameResultOver()
end

function AiZiLaGameResultView:_editableInitView()
	self._goodsItemGo = self:getResInst(AiZiLaGoodsItem.prefabPath, self.viewGO)

	gohelper.setActive(self._goodsItemGo, false)
end

function AiZiLaGameResultView:onUpdateParam()
	return
end

function AiZiLaGameResultView:onOpen()
	self._animator = self.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)

	self.addEventCb(self, AiZiLaController.instance, AiZiLaEvent.ExitGame, self.closeThis, self)

	if self.viewContainer then
		NavigateMgr.instance:addEscape(self.viewContainer.viewName, self._btncloseOnClick, self)
	end

	self:_setLockOpTime(1)
	self:refreshUI()

	local isSafe = AiZiLaGameModel.instance:getIsSafe()

	AudioMgr.instance:trigger((isSafe or nil) and (AudioEnum.V1a5AiZiLa.ui_wulu_aizila_safe_away or AudioEnum.V1a5AiZiLa.ui_wulu_aizila_urgent_away))
end

function AiZiLaGameResultView:onClose()
	return
end

function AiZiLaGameResultView:onDestroyView()
	return
end

function AiZiLaGameResultView:playViewAnimator(animName)
	if self._animator then
		self._animator.enabled = true

		self._animator:Play(animName, 0, 0)
	end
end

function AiZiLaGameResultView:refreshUI()
	local isSafe = AiZiLaGameModel.instance:getIsSafe()
	local episodeMO = AiZiLaGameModel.instance:getEpisodeMO()
	local episodeCfg = episodeMO and episodeMO:getConfig()
	local datalist = {}

	if AiZiLaGameModel.instance:getIsFirstPass() and episodeCfg then
		AiZiLaHelper.getItemMOListByBonusStr(episodeCfg.bonus, datalist)
	end

	tabletool.addValues(datalist, AiZiLaGameModel.instance:getResultItemList())
	gohelper.setActive(self._gosuccess, isSafe)
	gohelper.setActive(self._gofail, not isSafe)
	gohelper.setActive(self._goTips, not isSafe and #datalist > 0)
	gohelper.CreateObjList(self, self._onRewardItem, datalist, self._gorewardContent, self._goodsItemGo, AiZiLaGoodsItem)

	if episodeMO then
		if not episodeMO.day then
			local day = 0

			self._txtuseTimes.text = string.format("%sm", math.max(0, (not episodeMO.altitude or nil) and 0))
			self._txttimes.text = math.max(0, episodeMO.actionPoint or 0)

			if episodeCfg then
				self._txtTitle.text = episodeCfg.name or ""
			end

			self._txtday.text = formatLuaLang("v1a5_aizila_day_str", day)

			local roundCfg = AiZiLaConfig.instance:getRoundCo(episodeCfg.activityId, episodeCfg.episodeId, math.max(1, day))

			if not isSafe and roundCfg then
				local lostRate = 1000 - roundCfg.keepMaterialRate

				self._txtTips.text = formatLuaLang("v1a5_aizila_keep_material_rate", lostRate * 0.1 .. "%")
			end
		end
	end
end

function AiZiLaGameResultView:_onRewardItem(cell_component, data, index)
	cell_component:onUpdateMO(data)
end

function AiZiLaGameResultView:_setLockOpTime(lockTime)
	self._lockTime = Time.time + lockTime
end

function AiZiLaGameResultView:isLockOp()
	if self._lockTime and Time.time < self._lockTime then
		return true
	end

	return false
end

return AiZiLaGameResultView
