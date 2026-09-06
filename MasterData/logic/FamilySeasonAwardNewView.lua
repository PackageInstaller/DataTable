-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FamilySeasonAwardNewView.lua

module("logic.extensions.newfamily.view.war.FamilySeasonAwardNewView", package.seeall)

local FamilySeasonAwardNewView = class("FamilySeasonAwardNewView", TableViewComponent)

function FamilySeasonAwardNewView:ctor()
	FamilySeasonAwardNewView.super.ctor(self)

	self._curViewDatas = nil
end

function FamilySeasonAwardNewView:bindEvents()
	FamilySeasonAwardNewView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function FamilySeasonAwardNewView:unbindEvents()
	FamilySeasonAwardNewView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function FamilySeasonAwardNewView:onExit()
	FamilySeasonAwardNewView.super.onExit(self)
end

function FamilySeasonAwardNewView:destroyUI()
	FamilySeasonAwardNewView.super.destroyUI(self)

	self._curViewDatas = nil
end

function FamilySeasonAwardNewView:buildUI()
	FamilySeasonAwardNewView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
end

function FamilySeasonAwardNewView:onEnter()
	FamilySeasonAwardNewView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])

	local isInTime = FamilyWarController.instance:isInSeasonTimeOfNfsRank(self._seasonId)

	if not isInTime then
		printError(string.format("不在开启期限内( seasonId = %d | export_赛季配置 | j家族赛季榜(新) )", self._seasonId))
		self:close()

		return
	end

	local cfgs = FamilySeasonRankConfig.instance:getNfsRankScoreCfg(self._seasonId)

	self._curViewDatas = {}

	for _, cfg in pairs(cfgs or {}) do
		if cfg and cfg.prize_client and not string.nilorempty(cfg.prize_client) then
			table.insert(self._curViewDatas, {
				rank = cfg.id,
				prizes = string.split(cfg.prize_client, "#"),
				name = cfg.name
			})
		end
	end

	if self._curViewDatas and #self._curViewDatas > 1 then
		table.sort(self._curViewDatas, function(a, b)
			return a.rank < b.rank
		end)
	end

	self._tableview:ReloadData()
end

function FamilySeasonAwardNewView:_getPath()
	return {
		cellPath = "awardItem",
		viewPath = "awardListSR"
	}
end

function FamilySeasonAwardNewView:_cellSize()
	return 694, 102
end

function FamilySeasonAwardNewView:_updateCell(view, cell, data)
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local countTxt = goutil.findChildTextComponent(cell, "countTxt")
	local goodsList = {
		goutil.findChild(cell, "goodsGo_1"),
		goutil.findChild(cell, "goodsGo_2"),
		goutil.findChild(cell, "goodsGo_3"),
		goutil.findChild(cell, "goodsGo_4"),
		goutil.findChild(cell, "goodsGo_5"),
		goutil.findChild(cell, "goodsGo_6")
	}

	for i = 1, #goodsList do
		MaterialMgr.resetAll(goodsList[i])
	end

	nameTxt.text = data.name
	countTxt.text = tostring(data.rank)

	for i = 1, #data.prizes do
		if not string.nilorempty(data.prizes[i]) and goodsList[i] then
			MaterialMgr.setCellByCfg(data.prizes[i], goodsList[i])
		end
	end
end

return FamilySeasonAwardNewView
