-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FamilySeasonAwardView.lua

module("logic.extensions.newfamily.view.war.FamilySeasonAwardView", package.seeall)

local FamilySeasonAwardView = class("FamilySeasonAwardView", TableViewComponent)

function FamilySeasonAwardView:ctor()
	FamilySeasonAwardView.super.ctor(self)

	self._curViewDatas = nil
end

function FamilySeasonAwardView:bindEvents()
	FamilySeasonAwardView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function FamilySeasonAwardView:unbindEvents()
	FamilySeasonAwardView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function FamilySeasonAwardView:onExit()
	FamilySeasonAwardView.super.onExit(self)
end

function FamilySeasonAwardView:destroyUI()
	FamilySeasonAwardView.super.destroyUI(self)

	self._curViewDatas = nil
end

function FamilySeasonAwardView:buildUI()
	FamilySeasonAwardView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
end

function FamilySeasonAwardView:onEnter()
	FamilySeasonAwardView.super.onEnter(self)

	local param = self:getFirstParam()
	local allCfgs = FamilyWarConfig.instance:getFamilySeasonPrizeCfgs(checknumber(param))

	self._curViewDatas = {}

	for _, cfg in pairs(allCfgs or {}) do
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

function FamilySeasonAwardView:_getPath()
	return {
		cellPath = "awardItem",
		viewPath = "awardListSR"
	}
end

function FamilySeasonAwardView:_cellSize()
	return 694, 102
end

function FamilySeasonAwardView:_updateCell(view, cell, data)
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

return FamilySeasonAwardView
