-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pandoracopy/view/PandoraRankView.lua

module("logic.extensions.pandoracopy.view.PandoraRankView", package.seeall)

local PandoraRankView = class("PandoraRankView", TableViewComponent)

function PandoraRankView:ctor()
	PandoraRankView.super.ctor(self)
end

function PandoraRankView:bindEvents()
	PandoraRankView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function PandoraRankView:unbindEvents()
	PandoraRankView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function PandoraRankView:onExit()
	PandoraRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateMoonKingRank, self._updataRankListSR, self)
end

function PandoraRankView:destroyUI()
	PandoraRankView.super.destroyUI(self)
end

function PandoraRankView:buildUI()
	PandoraRankView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")

	local rankListGo = self:getGo("rankListGo")

	self._emptyGo = goutil.findChild(rankListGo, "emptyGo")

	local myRankGo = goutil.findChild(rankListGo, "myRankGo")

	self._myRankTxt = goutil.findChildTextComponent(myRankGo, "myRankTxt")

	self._emptyGo:SetActive(false)

	self._myRankTxt.text = ""
end

function PandoraRankView:onEnter()
	PandoraRankView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdateMoonKingRank, self._updataRankListSR, self)
	self:_updataRankListSR({}, 0)
	MoonKingController.instance:csGetMoonkingRankReq(MoonKingModel.instance.pandoraChanllengeId)
end

function PandoraRankView:_updataRankListSR(rankList, myRank)
	self._curViewDatas = rankList

	if self._curViewDatas == nil or #self._curViewDatas == 0 then
		self._emptyGo:SetActive(true)
	else
		self._emptyGo:SetActive(false)
	end

	self._myRankTxt.text = checknumber(myRank) <= 0 and "未上榜" or tostring(myRank)

	self._tableview:ReloadData()
end

function PandoraRankView:_getPath()
	return {
		cellPath = "rankListGo/rankItem",
		viewPath = "rankListGo/rankListSR"
	}
end

function PandoraRankView:_cellSize()
	return 1140, 108
end

function PandoraRankView:_updateCell(view, cell, data)
	local rankIma = goutil.findChildComponent(cell, "rankIma", "UIImageSpriteChange")
	local rankTxt = goutil.findChildTextComponent(cell, "rankTxt")
	local headGo = goutil.findChild(cell, "headGo")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local familyTxt = goutil.findChildTextComponent(cell, "familyTxt")
	local timerTxt = goutil.findChildTextComponent(cell, "timerTxt")

	if checknumber(data.rank) > 3 then
		rankIma.gameObject:SetActive(false)

		rankTxt.text = tostring(data.rank)
	else
		rankIma.gameObject:SetActive(true)

		rankTxt.text = ""

		rankIma:SetState(checknumber(data.rank) - 1)
	end

	HeadItemController.instance:setHeadCellByInfo(headGo, data.headInfo)

	nameTxt.text = data.headInfo.userName
	familyTxt.text = string.nilorempty(data.familyName) and "无" or data.familyName

	local timer = GameUtil.time2date(data.gainTime / 1000)

	timerTxt.text = string.format(lang("text_timeinfo"), timer.month, timer.day, timer.hour, timer.min, timer.sec)
end

return PandoraRankView
