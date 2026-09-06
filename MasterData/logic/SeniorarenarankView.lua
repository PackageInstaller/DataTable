-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showoff/view/SeniorarenarankView.lua

module("logic.extensions.showoff.view.SeniorarenarankView", package.seeall)

local SeniorarenarankView = class("SeniorarenarankView", ViewComponent)

function SeniorarenarankView:ctor()
	SeniorarenarankView.super.ctor(self)
end

function SeniorarenarankView:unbindEvents()
	SeniorarenarankView.super.unbindEvents(self)
end

function SeniorarenarankView:bindEvents()
	SeniorarenarankView.super.bindEvents(self)
end

function SeniorarenarankView:buildUI()
	SeniorarenarankView.super.buildUI(self)

	self._goEmpty = self:getGo("goEmpty")
	self._myRank = self:getGo("myRank")
	self._txtMyRank = self:getTxt("myRank/txtMyRank")
	self._tableview = self:getGo("tableview")
	self._rankcell = self:getGo("rankcell")
	self._scrollList = ScrollerList.create(self._tableview, self._rankcell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function SeniorarenarankView:onExit()
	SeniorarenarankView.super.onExit(self)
	self._scrollList:dispose()
end

function SeniorarenarankView:onEnter()
	SeniorarenarankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.RankDataGet, self._refreshUI, self)
	SeniorArenaController.instance:reqRankData()
end

function SeniorarenarankView:_refreshUI()
	local info = RankModel.instance:getRankMo(GameEnum.RankType.SeniorArena, 0) or {}

	if not info.rankList then
		local infoList = {}

		GameUtil.SetActive(self._goEmpty, #infoList == 0)
		self._scrollList:reloadData(infoList)

		local rank = checknumber(info.myRank)

		self._txtMyRank.text = rank <= 0 and lang("未上榜") or rank
	end
end

function SeniorarenarankView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgChangeRank = goutil.findChildComponent(go, "imgRank", "UIImageSpriteChange")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local head = goutil.findChild(go, "imgIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtFightPower = goutil.findChildTextComponent(go, "txtFightPower")
	local btnDef = goutil.findChild(go, "btnDef")
	local rankInfo = data

	txtRank.text = rankInfo.rank

	GameUtil.SetActive(imgChangeRank, rankInfo.rank <= 3 and rankInfo.rank > 0)

	if rankInfo.rank <= 3 and rankInfo.rank > 0 then
		imgChangeRank:SetState(rankInfo.rank - 1)
		GameUtil.SetActive(imgChangeRank, true)
		GameUtil.SetActive(txtRank, false)
	else
		GameUtil.SetActive(imgChangeRank, false)
		GameUtil.SetActive(txtRank, true)
	end

	local proxy = HeadItemController.instance:setHeadCellByInfo(head, rankInfo.headInfo, true)

	txtName.text = rankInfo.headInfo.userName
	txtFightPower.text = rankInfo.score

	GameUtil.addClickHandler(btnDef, GameUtil.handler(self._onClickDef, self, data))
end

function SeniorarenarankView:_clearCell(cell)
	local head = goutil.findChild(cell, "imgIcon")

	HeadItemController.instance:resetHeadCell(head)
end

function SeniorarenarankView:_onClickDef(mo)
	if not mo or not mo.headInfo then
		return
	end

	SeniorArenaController.instance:openOtherDefendFormsView(mo.headInfo.userId, mo)
end

return SeniorarenarankView
