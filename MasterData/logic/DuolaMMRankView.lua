-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolamengmeng/view/DuolaMMRankView.lua

module("logic.extensions.duolamengmeng.view.DuolaMMRankView", package.seeall)

local DuolaMMRankView = class("DuolaMMRankView", TableViewComponent)
local RANK_LAST_ORDER = 9999

function DuolaMMRankView:ctor()
	DuolaMMRankView.super.ctor(self)
end

function DuolaMMRankView:buildUI()
	DuolaMMRankView.super.buildUI(self)

	self._closeBtn = self:getBtn("btnClose")
	self._noRankGo = self:getGo("empty")
	self._txtMyRank = self:getTxt("rewardInfoGo/myRank/myRankTxt")
	self.haveRankTxt = self:getTxt("rewardInfoGo/rankRewardCell/txtRank")

	self._noRankGo:SetActive(false)
end

function DuolaMMRankView:_getPath()
	return {
		cellPath = "leftInfoGo/rankCell",
		viewPath = "leftInfoGo/rankListSR"
	}
end

function DuolaMMRankView:bindEvents()
	DuolaMMRankView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function DuolaMMRankView:unbindEvents()
	DuolaMMRankView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function DuolaMMRankView:destroyUI()
	DuolaMMRankView.super.destroyUI(self)
end

function DuolaMMRankView:onEnter()
	DuolaMMRankView.super.onEnter(self)

	local root = GameEnum.RankType.DuolaMM_RANK
	local leaf = 0

	GlobalDispatcher:addListener(GlobalNotify.RankDataGet, self._onRankRes, self)
	RankModel.instance:sendReqRankData(root, leaf)
end

function DuolaMMRankView:onEnterFinished()
	DuolaMMRankView.super.onEnterFinished(self)
end

function DuolaMMRankView:onExit()
	DuolaMMRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.RankDataGet, self._onRankRes, self)
end

function DuolaMMRankView:onExitFinished()
	DuolaMMRankView.super.onExitFinished(self)
end

function DuolaMMRankView:_onRankRes()
	local root = GameEnum.RankType.DuolaMM_RANK
	local leaf = 0

	self._rankMo = RankModel.instance:getRankMo(root, leaf) or {}
	self._rankList = self._rankMo.rankList or {}

	self:_updateJinliList()
	self:_setMyRank()
end

function DuolaMMRankView:_updateJinliList()
	table.sort(self._rankList, function(a, b)
		return checknumber(a.rank) < checknumber(b.rank)
	end)
	self._noRankGo:SetActive(#self._rankList == 0)
	self:updateListData(self._rankList)
end

function DuolaMMRankView:_cellSize()
	return 738, 86
end

function DuolaMMRankView:_setMyRank()
	local size = math.min(RANK_LAST_ORDER, checknumber(self._rankMo.rankSize))

	self.haveRankTxt.text = langPara("前<color=#eb4642>%s</color>/%s名", RANK_LAST_ORDER - size, RANK_LAST_ORDER)

	local rank = self._rankMo.myRank

	self._txtMyRank.text = rank > 0 and (rank > RANK_LAST_ORDER and langPara("%s名之后", RANK_LAST_ORDER) or langPara("<color=#BCDCF6FF>%d</color>", rank)) or "未上榜"
end

function DuolaMMRankView:_updateCell(view, cell, data)
	local rankImg = goutil.findChild(cell, "rankIma"):GetComponent("UIImageSpriteChange")
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtFamily = goutil.findChildTextComponent(cell, "txtFamily")
	local headGo = goutil.findChild(cell, "headGo")
	local timeTxt = goutil.findChildTextComponent(cell, "timeTxt")
	local btnIcon = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnIcon")

	btnIcon:RemoveClickListener()
	btnIcon:AddClickListener(function()
		FriendController.instance:showInfoView(data.headInfo.userId, btnIcon)
	end)
	HeadItemController.instance:setHeadCellByInfo(headGo, data.headInfo)

	data.rank = checknumber(data.rank)

	if data.rank <= 3 then
		rankImg.gameObject:SetActive(true)
		rankImg:SetState(data.rank - 1)

		txtRank.text = ""
	else
		rankImg.gameObject:SetActive(false)

		txtRank.text = data.rank
	end

	local timeTab = GameUtil.time2date(math.floor(data.gainTime / 1000))

	timeTxt.text = string.format("%s月%s日\n%02d:%02d:%02d", timeTab.month, timeTab.day, timeTab.hour, timeTab.min, timeTab.sec)
	txtName.text = data.headInfo.userName
	txtFamily.text = data.familyName
end

function DuolaMMRankView:_clearTableview(cell)
	local headGo = goutil.findChild(cell, "head")

	HeadItemController.instance:resetHeadCell(headGo)
end

return DuolaMMRankView
