-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/reward/RankSubView.lua

module("logic.extensions.scuffle.view.reward.RankSubView", package.seeall)

local RankSubView = class("RankSubView", TableViewComponent)

function RankSubView:buildUI(parentGo)
	self.mainGO = parentGo

	RankSubView.super.buildUI(self)

	self._scroll = self:getScrollRect("tableview")
end

function RankSubView:bindEvents()
	RankSubView.super.bindEvents(self)
end

function RankSubView:unbindEvents()
	RankSubView.super.unbindEvents(self)
end

function RankSubView:onEnter()
	RankSubView.super.onEnter(self)

	self._curSeasonId = ScuffleController.instance:getCurSeasonId()
	self._isFirst = true
end

function RankSubView:onExit()
	RankSubView.super.onExit(self)
end

function RankSubView:show()
	self.mainGO:SetActive(true)
	self:_resetTopPos()

	if self._isFirst then
		self._isFirst = false

		self:_updateRankList()
	end
end

function RankSubView:hide()
	self.mainGO:SetActive(false)
end

function RankSubView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "tableview"
	}
end

function RankSubView:_updateCell(view, cell, data)
	local goContent = goutil.findChild(cell, "tableview/viewport/content")
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local imgRank = goutil.findChild(cell, "imgRank")

	if #data.ranks == 1 and data.ranks[1] == 1 then
		goutil.setActive(imgRank, true)
		goutil.setActive(txtRank.gameObject, false)
	else
		goutil.setActive(imgRank, false)
		goutil.setActive(txtRank.gameObject, true)

		if data.ranks == 1 then
			txtRank.text = data.ranks[1] or string.format("%d - %d 名", data.ranks[1], data.ranks[2])
		end
	end

	local arrProxy = MaterialMgr.setCellListByCfg(data.cfg.prize, goContent)

	for i, v in ipairs(arrProxy) do
		Framework.TransformUtil.SetLocalScale(v.view.transform, 0.7, 0.7, 0.7)
	end
end

function RankSubView:_clearTableview(cell)
	return
end

function RankSubView:_resetTopPos()
	self._scroll.scrollRect.verticalNormalizedPosition = 1
end

function RankSubView:_updateRankList()
	local cfgs = ScuffleConfig.instance:getRankPrizeCfgs(self._curSeasonId)
	local list = {}
	local preCfg

	for i, v in pairs(cfgs) do
		local element = {}

		element.cfg = v

		if i == 1 then
			element.ranks = {
				v.rightTop
			}
		else
			local startNum = cfgs[i - 1].rightTop + 1

			element.ranks = v.rightTop - startNum == 0 and {
				v.rightTop
			} or {
				startNum,
				v.rightTop
			}
		end

		table.insert(list, element)
	end

	printInfo("test _updateRankList", #list)
	self:updateListData(list)
end

return RankSubView
