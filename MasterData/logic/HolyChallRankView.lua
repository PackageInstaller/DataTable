-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/view/HolyChallRankView.lua

module("logic.extensions.kingway.view.HolyChallRankView", package.seeall)

local HolyChallRankView = class("HolyChallRankView", TableViewComponent)

function HolyChallRankView:ctor()
	HolyChallRankView.super.ctor(self)
end

function HolyChallRankView:buildUI()
	HolyChallRankView.super.buildUI(self)

	self.viewCloseBtn = self:getBtn("viewCloseBtn")

	local rewardInfoGo = self:getGo("rewardInfoGo")

	self.rewardTimeTxt = goutil.findChildTextComponent(rewardInfoGo, "rewardTimeTxt")
	self.haveRankTxt = goutil.findChildTextComponent(rewardInfoGo, "haveRankGo/haveRankTxt")
	self.haveDesTxt = goutil.findChildTextComponent(rewardInfoGo, "haveRankGo/haveDesTxt")
	self.haveTipsTxt = goutil.findChildTextComponent(rewardInfoGo, "haveRankGo/haveTipsTxt")
	self.noRankTxt = goutil.findChildTextComponent(rewardInfoGo, "noRankGo/noRankTxt")
	self.noDesTxt = goutil.findChildTextComponent(rewardInfoGo, "noRankGo/noDesTxt")
	self.noTipsTxt = goutil.findChildTextComponent(rewardInfoGo, "noRankGo/noTipsTxt")
	self.myRankTxt = goutil.findChildTextComponent(rewardInfoGo, "wdpmTxt/myRankTxt")
	self.nullRankGo = self:getGo("nullRankGo")

	self.nullRankGo:SetActive(false)
end

function HolyChallRankView:bindEvents()
	HolyChallRankView.super.bindEvents(self)
	self.viewCloseBtn:AddClickListener(self.close, self)
end

function HolyChallRankView:unbindEvents()
	HolyChallRankView.super.unbindEvents(self)
	self.viewCloseBtn:RemoveClickListener()
end

function HolyChallRankView:onExit()
	HolyChallRankView.super.onExit(self)

	self._curViewDatas = nil

	RankModel.instance:onReset()
	GlobalDispatcher:removeListener(GlobalNotify.RankDataGet, self._updateRankList, self)
end

function HolyChallRankView:destroyUI()
	HolyChallRankView.super.destroyUI(self)
end

function HolyChallRankView:onEnter()
	HolyChallRankView.super.onEnter(self)

	local stage = 0

	if self._viewPresentor._openParam and self._viewPresentor._openParam[1] then
		stage = checknumber(self._viewPresentor._openParam[1])
	end

	self:_updateRankList()

	local root = GameEnum.RankType.ShengGuangFeiLong
	local leaf = 0

	if not RankModel.instance:getIsDataInit(root, leaf) then
		RankModel.instance:sendReqRankData(root, leaf)
	end

	GlobalDispatcher:addListener(GlobalNotify.RankDataGet, self._updateRankList, self)
end

function HolyChallRankView:_updateRankList()
	local root = GameEnum.RankType.ShengGuangFeiLong
	local leaf = 0
	local rankMo = RankModel.instance:getRankMo(root, leaf) or {}

	self._curViewDatas = rankMo.rankList or {}

	self.nullRankGo:SetActive(self._curViewDatas == nil or #self._curViewDatas == 0)
	self._tableview:ReloadData()

	self.myRankTxt.text = checknumber(rankMo.myRank) > 0 and langPara("第<color=#bcdcf6ff>%s</color>名", checknumber(rankMo.myRank)) or lang("未上榜")

	local size = math.min(1000, checknumber(rankMo.rankSize))

	self.haveRankTxt.text = string.format("前<color=#eb4642>%s</color>/1000名", 1000 - size)
	self.haveTipsTxt.text = string.format("圣光飞龙挑战中 NO.%s 获得", "xxx")
	self.noRankTxt.text = "1000名之后"
	self.noTipsTxt.text = "圣光飞龙挑战通关认证"
end

function HolyChallRankView:_getPath()
	return {
		cellPath = "leftInfoGo/rankCell",
		viewPath = "leftInfoGo/rankListSR"
	}
end

function HolyChallRankView:_cellSize()
	return 738, 96
end

function HolyChallRankView:_updateCell(view, cell, data)
	local rankIma = goutil.findChild(cell, "rankIma"):GetComponent("UIImageSpriteChange")
	local rankTxt = goutil.findChildTextComponent(cell, "rankTxt")
	local headGo = goutil.findChild(cell, "headGo")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local familyTxt = goutil.findChildTextComponent(cell, "familyTxt")
	local timeTxt = goutil.findChildTextComponent(cell, "timeTxt")

	if data.rank <= 3 then
		GameUtil.SetActive(rankIma, true)

		rankTxt.text = ""

		GameUtil.SetActive(rankTxt, false)
		rankIma:SetState(data.rank - 1)
	else
		GameUtil.SetActive(rankIma, false)
		GameUtil.SetActive(rankTxt, true)

		rankTxt.text = tostring(data.rank)
	end

	HeadItemController.instance:setHeadCellByInfo(headGo, data.headInfo)
	GameUtil.addClickHandler(headGo, GameUtil.handler(self.onHeadClick, self, data.headInfo.userId, headGo))

	nameTxt.text = data.headInfo.userName
	familyTxt.text = data.familyName

	local time = GameUtil.time2date(checknumber(data.gainTime) / 1000)

	timeTxt.text = langPara("%d月%d日 %02d:%02d:%02d", time.month, time.day, time.hour, time.min, time.sec)
end

function HolyChallRankView:onHeadClick(userId, go)
	FriendController.instance:showInfoView(userId, go.gameObject, true)
end

return HolyChallRankView
