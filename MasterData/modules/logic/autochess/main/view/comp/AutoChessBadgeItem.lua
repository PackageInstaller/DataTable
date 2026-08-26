-- chunkname: @modules/logic/autochess/main/view/comp/AutoChessBadgeItem.lua

module("modules.logic.autochess.main.view.comp.AutoChessBadgeItem", package.seeall)

local AutoChessBadgeItem = class("AutoChessBadgeItem", LuaCompBase)

AutoChessBadgeItem.ShowType = {
	PvpSettleView = 5,
	MainView = 2,
	CourseView = 3,
	BadgeView = 1,
	RankUpView = 4
}

function AutoChessBadgeItem:init(go)
	self.go = go
	self.goUnlock = gohelper.findChild(go, "root/#go_Unlock")
	self.goProgress = gohelper.findChild(go, "root/#go_Unlock/#go_Progress")
	self.imageProgress = gohelper.findChildImage(go, "root/#go_Unlock/#go_Progress/#image_Progress")
	self.txtProgress = gohelper.findChildText(go, "root/#go_Unlock/#go_Progress/#txt_Progress")
	self.simageBadgeU = gohelper.findChildSingleImage(go, "root/#go_Unlock/#simage_BadgeU")
	self.goStar = gohelper.findChild(go, "root/#go_Unlock/#go_Star")
	self.goLock = gohelper.findChild(go, "root/#go_Lock")
	self.simageBadgeL = gohelper.findChildSingleImage(go, "root/#go_Lock/#simage_BadgeL")
	self.txtUnlock = gohelper.findChildText(go, "root/#go_Lock/#txt_Unlock")
	self.txtName = gohelper.findChildText(go, "root/Name/#txt_Name")
	self.goReward = gohelper.findChild(go, "#go_Reward")
	self.goRewardItem = gohelper.findChild(go, "#go_Reward/Content/#go_RewardItem")
end

function AutoChessBadgeItem:onDestroy()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)
	end

	self.simageBadgeL:UnLoadImage()
	self.simageBadgeU:UnLoadImage()
end

function AutoChessBadgeItem:setData(rankId, score, showType)
	self.actId = Activity182Model.instance:getCurActId()
	self.curScore = score
	self.rankId = rankId
	self.showType = showType
	self.config = lua_auto_chess_rank.configDict[self.actId][rankId]

	if not self.config then
		logError(string.format("段位ID: %s 配置不存在", rankId))

		return
	end

	local lastCo = lua_auto_chess_rank.configDict[self.actId][self.rankId - 1]

	if lastCo then
		self.needScore = lastCo.score or 0
	end

	if showType == AutoChessBadgeItem.ShowType.BadgeView then
		self:showReward()
	elseif showType == AutoChessBadgeItem.ShowType.MainView then
		self:showProgress()
		self:addClick()
	elseif showType == AutoChessBadgeItem.ShowType.PvpSettleView then
		self:showProgress()
	end

	self:refreshNormal()
end

function AutoChessBadgeItem:addClick()
	self.btnClick = gohelper.findButtonWithAudio(self.go)

	self.addClickCb(self, self.btnClick, self.onClick, self)
end

function AutoChessBadgeItem:refreshNormal()
	if self.config.score == 0 then
		self.txtName.text = luaLang("autochess_badgeitem_noget")
	else
		self.unlock = self.needScore <= self.curScore

		if self.unlock then
			self.simageBadgeU:LoadImage(ResUrl.getAutoChessIcon(self.config.icon, "badgeicon"))
		else
			self.simageBadgeL:LoadImage(ResUrl.getAutoChessIcon(self.config.icon, "badgeicon"))

			local txt = luaLang("autochess_badgeitem_unlock")

			self.txtUnlock.text = GameUtil.getSubPlaceholderLuaLangTwoParam(txt, self.curScore, self.needScore)
		end

		self.txtName.text = self.config.name

		gohelper.setActive(self.goUnlock, self.unlock)
		gohelper.setActive(self.goLock, not self.unlock)
	end

	gohelper.setActive(self.simageBadgeU, self.config.score ~= 0)
	gohelper.setActive(self.goStar, self.config.score ~= 0)
end

function AutoChessBadgeItem:showProgress()
	if self.config.score ~= 0 then
		self.imageProgress.fillAmount = self.correctFillAmount(self.curScore / self.config.score)
		self.txtProgress.text = string.format("%d/%d", self.curScore, self.config.score)

		gohelper.setActive(self.goProgress, true)
	end
end

function AutoChessBadgeItem:showReward()
	local list = DungeonConfig.instance:getRewardItems(self.config.reward)

	if #list ~= 0 then
		local actMo = Activity182Model.instance:getActMo()

		for k, v in ipairs(list) do
			local go = gohelper.cloneInPlace(self.goRewardItem, k)
			local hasGet = gohelper.findChild(go, "go_receive")

			gohelper.setActive(hasGet, self.rankId <= actMo.historyInfo.maxRank)

			local cell_component = IconMgr.instance:getCommonItemIcon(go)

			gohelper.setAsFirstSibling(cell_component.go)
			cell_component:setMOValue(v[1], v[2], v[3], nil, true)
			cell_component:setCountFontSize(32)

			local countBg = cell_component:getCountBg()

			recthelper.setAnchorY(countBg.transform, 50)
		end

		gohelper.setActive(self.goReward, true)
		gohelper.setActive(self.goRewardItem, false)
	else
		gohelper.setActive(self.goReward, false)
	end
end

function AutoChessBadgeItem:onClick()
	AutoChessController.instance:statButtonClick(ViewName.AutoChessMainView, "btnBadgeItemOnClick")
	ViewMgr.instance:openView(ViewName.AutoChessBadgeView)
end

function AutoChessBadgeItem:playProgressAnim(changeValue)
	if changeValue == 0 then
		return
	end

	self.changeScore = changeValue

	local startValue = self.curScore - changeValue

	self.tweenId = ZProj.TweenHelper.DOTweenFloat(startValue, self.curScore, 1, self.frameCallback, self.finishCallback, self, nil, EaseType.Linear)
end

function AutoChessBadgeItem:frameCallback(value)
	self.txtProgress.text = self.showType == AutoChessBadgeItem.ShowType.PvpSettleView and (self.changeScore > 0 and string.format("%d/%d<color=#44A847>(+%d)</color>", value, self.config.score, self.changeScore) or string.format("%d/%d<color=#E76C6C>(%d)</color>", value, self.config.score, self.changeScore)) or string.format("%d/%d", value, self.config.score)
	self.imageProgress.fillAmount = self.correctFillAmount(value / self.config.score)
end

function AutoChessBadgeItem:finishCallback()
	self.changeScore = nil
	self.tweenId = nil
end

function AutoChessBadgeItem.correctFillAmount(value)
	if value < 0.5 then
		value = 0.12 + value / 0.5 * 0.38
	elseif value > 0.5 then
		value = 0.5 + (value - 0.5) / 0.5 * 0.38
	end

	return value
end

return AutoChessBadgeItem
