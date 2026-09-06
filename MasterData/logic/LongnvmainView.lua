-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/longnv/LongnvmainView.lua

module("logic.extensions.timelimitedchallenge.view.longnv.LongnvmainView", package.seeall)

local LongnvmainView = class("LongnvmainView", TimeLimitedMainView)

function LongnvmainView:unbindEvents()
	LongnvmainView.super.unbindEvents(self)
	self._btnStart:RemoveClickListener()
	self._btnGift:RemoveClickListener()
	self.btnSweep:RemoveClickListener()
end

function LongnvmainView:bindEvents()
	LongnvmainView.super.bindEvents(self)
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._btnGift:AddClickListener(self._onClickJump, self)
	self.btnSweep:AddClickListener(self._onClickSweep, self)
end

function LongnvmainView:buildUI()
	LongnvmainView.super.buildUI(self)

	self._challengeId = 16
	self._btnStart = self:getBtn("Button")
	self.btnSweep = self:getBtn("btnSweep")
	self._model = self:getGo("model")
	self._redImgPoint = self:getGo("Button/imgPoint")
	self._shopGo = self:getGo("shop")
	self._btnGift = self:getBtn("shop/btnShop")
	self._itemGift = self:getGo("shop/item")
	self.limited = self:getGo("limited")
	self.item = self:getGo("item")
	self.txtLimited = self:getTxt("limited/txtNum")
end

function LongnvmainView:onExit()
	LongnvmainView.super.onExit(self)

	self._role = RoleObjectPool.instance:removeRole(self._role)

	MaterialMgr.resetAll(self._itemGift)
	MaterialMgr.resetAll(self._pointRankItem)
	MaterialMgr.resetAll(self.item)
	GlobalDispatcher:removeListener(GlobalNotify.PM_LongnvInfoRes, self.onRefreshUI, self)
	UIEffectManager.instance:stopEffect(self._pmEff)
	UIEffectManager.instance:stopEffect(self._pmEff2)
end

function LongnvmainView:onEnter()
	LongnvmainView.super.onEnter(self)
	LongnvController.instance:recordRedPoint()
	GlobalDispatcher:addListener(GlobalNotify.PM_LongnvInfoRes, self.onRefreshUI, self)
	LongnvController.instance:sendGetInfo()
	self:onRefreshUI()
	GameUtil.doCallbackWhenFirst("LongnvmainView_20210810", function()
		self:_onClickRule()
	end)

	local effPath = "fx_ui_longnvtiaozhan/fx_ui_longnvtiaozhan_1.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setScale(1)

	local effPath = "fx_ui_longnvtiaozhan/fx_ui_longnvtiaozhan_2.prefab"

	self._pmEff2 = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff2:setParent(self.mainGO.transform)
	self._pmEff2:setScale(1)
end

function LongnvmainView:_onClickJump()
	local gotoStr = LongnvConfig.instance:getCommonValue("JUMP_FUNC_ID")

	if not string.nilorempty(gotoStr) then
		GotoMgr.gotoByString(gotoStr)
	end
end

function LongnvmainView:onRefreshUI()
	local isPassChallenge = LongnvModel.instance.isPassChallenge
	local spaceGained = LongnvModel.instance.spaceGained
	local total = checknumber(LongnvConfig.instance:getCommonValue("SPACE_LIMIT"))
	local left = math.max(0, total - spaceGained)

	self.txtLimited.text = langPara("<color=#20b376>%s</color>/%s", left, total)

	GameUtil.SetActive(self.limited, true)

	if isPassChallenge then
		GameUtil.SetActive(self.limited, false)
		GameUtil.SetActive(self._btnStart, false)
		GameUtil.SetActive(self.btnSweep, true)
	else
		GameUtil.SetActive(self._btnStart, true)
		GameUtil.SetActive(self.btnSweep, false)
	end

	local rankPrize = LongnvConfig.instance:getCommonValue("RANK_PRIZE")
	local prizeCfg = LongnvConfig.instance:getCommonValue("CHALLENGE_PRIZE")
	local petRankThreshold = checknumber(LongnvConfig.instance:getCommonValue("RANK_SIZE"))

	self._tipRank.gameObject:SetActive(petRankThreshold > LongnvModel.instance.rankSize)

	self._txtTipRank.text = string.format("前%s名\n可获得", petRankThreshold)

	MaterialMgr.setCellByCfg(rankPrize, self._pointRankItem)
	MaterialMgr.setCellByCfg(prizeCfg, self.item)

	local itemJump = LongnvConfig.instance:getCommonValue("JUMP_ITEM")

	if not string.nilorempty(itemJump) then
		MaterialMgr.setCellByCfg(itemJump, self._itemGift)
	end
end

function LongnvmainView:_onClickRank()
	UIStateManager.instance:push(ViewName.LightKingRankView, self._challengeId)
end

function LongnvmainView:_onClickSweep()
	local isCanSweep = LongnvModel.instance.isCanSweep

	if isCanSweep then
		LongnvController.instance:sendSweep()
	else
		TipsFacade.instance:openCommonTips(lang("请明天再来扫荡吧！"))
	end
end

function LongnvmainView:_onClickStart()
	local spaceGained = LongnvModel.instance.spaceGained
	local total = checknumber(LongnvConfig.instance:getCommonValue("SPACE_LIMIT"))
	local left = math.max(0, total - spaceGained)
	local isPassPreChallenge = LongnvModel.instance.isPassPreChallenge

	if isPassPreChallenge then
		local times = LongnvConfig.instance:getCommonValue("OPEN_TIME")

		if not string.nilorempty(times) then
			local arr = string.split(times, ",")
			local timeshow = {}
			local isOutTime = true

			for i, v in ipairs(arr or {}) do
				local tt = string.split(v, "#")

				table.insert(timeshow, tt[1] .. "-" .. tt[2])

				if GameUtil.checkIsInTimePeriod(tt[1], tt[2], true) then
					isOutTime = false

					UIStateManager.instance:push(ViewName.LongnvtowerView)

					break
				end
			end

			if isOutTime then
				TipsFacade.instance:openCommonTips(lang("每天早上9点到次日5点开放挑战！"))
			end
		else
			UIStateManager.instance:push(ViewName.LongnvtowerView)
		end
	else
		UIStateManager.instance:push(ViewName.LongnvreelView)
	end
end

return LongnvmainView
