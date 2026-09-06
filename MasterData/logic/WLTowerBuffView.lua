-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/view/WLTowerBuffView.lua

module("logic.extensions.waterdraktower.view.WLTowerBuffView", package.seeall)

local WLTowerBuffView = class("WLTowerBuffView", TableViewComponent)

function WLTowerBuffView:ctor()
	WLTowerBuffView.super.ctor(self)
end

function WLTowerBuffView:bindEvents()
	WLTowerBuffView.super.bindEvents(self)
	self._closeBtn:AddClickListener(function()
		if self._params and self._params.isMainOpen then
			self:close()

			return
		end

		GameUtil.SetActive(self._viewInfoGo, false)
	end, self)
	self._showBtn:AddClickListener(function()
		if self._params and self._params.isMainOpen then
			GameUtil.SetActive(self._downInfoGo, false)
			GameUtil.SetActive(self._viewInfoGo, true)

			return
		end

		GameUtil.SetActive(self._viewInfoGo, true)
	end, self)
end

function WLTowerBuffView:unbindEvents()
	WLTowerBuffView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._showBtn:RemoveClickListener()
end

function WLTowerBuffView:onExit()
	WLTowerBuffView.super.onExit(self)
end

function WLTowerBuffView:destroyUI()
	WLTowerBuffView.super.destroyUI(self)

	self._curViewDatas = nil
end

function WLTowerBuffView:buildUI()
	WLTowerBuffView.super.buildUI(self)

	self._downInfoGo = self:getGo("downInfoGo")
	self._showBtn = self:getBtn("downInfoGo/showBtn")
	self._viewInfoGo = self:getGo("viewInfoGo")
	self._closeBtn = self:getBtn("viewInfoGo/closeBtn")
	self._tipsTxt = self:getTxt("viewInfoGo/tipsTxt")
end

function WLTowerBuffView:onEnter()
	WLTowerBuffView.super.onEnter(self)

	self._params = self:getFirstParam()

	if self._params == nil or self._params.buffPlanId == nil then
		self._params = {
			buffPlanId = 1,
			isMainOpen = true
		}
	end

	local allCfgs = WaterdraktowerConfig.instance:getAllBuffsByPlanId(self._params.buffPlanId)

	self._curViewDatas = {}

	for _, buff in pairs(allCfgs or {}) do
		if buff and buff.raceId and buff.raceId > 0 then
			table.insert(self._curViewDatas, {
				raceId = buff.raceId,
				name = MaterialMgr.getMaterialsName(MatType.Pet, buff.raceId),
				des = buff.des
			})
		end
	end

	if #self._curViewDatas > 1 then
		table.sort(self._curViewDatas, function(a, b)
			return a.raceId < b.raceId
		end)
	end

	if self._params.isMainOpen then
		GameUtil.SetActive(self._downInfoGo, false)
		GameUtil.SetActive(self._viewInfoGo, true)
	else
		GameUtil.SetActive(self._viewInfoGo, false)
		GameUtil.SetActive(self._downInfoGo, true)
	end

	self._tipsTxt.text = lang("text_wltower_desc_14")

	self._tableview:ReloadData()
end

function WLTowerBuffView:_getPath()
	return {
		cellPath = "viewInfoGo/itemGo",
		viewPath = "viewInfoGo/tableview"
	}
end

function WLTowerBuffView:_cellSize()
	return 410, 132
end

function WLTowerBuffView:_updateCell(view, cell, data)
	local goodsGo = goutil.findChild(cell, "goodsGo")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local descTxt = goutil.findChildTextComponent(cell, "descTxt")

	MaterialMgr.resetAll(goodsGo)
	MaterialMgr.setCellByCfg(MatType.Pet .. ":" .. data.raceId, goodsGo)

	nameTxt.text = data.name
	descTxt.text = data.des
end

return WLTowerBuffView
