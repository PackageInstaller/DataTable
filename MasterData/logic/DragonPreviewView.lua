-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/DragonPreviewView.lua

module("logic.extensions.lottery.view.DragonPreviewView", package.seeall)

local DragonPreviewView = class("DragonPreviewView", TableViewComponent)

function DragonPreviewView:ctor()
	DragonPreviewView.super.ctor(self)

	self._poolCfg = nil
	self._colCount = 6
end

function DragonPreviewView:bindEvents()
	GameUtil.asBtn(self._closeBtn):AddClickListener(self.close, self)
end

function DragonPreviewView:unbindEvents()
	GameUtil.asBtn(self._closeBtn):RemoveClickListener()
end

function DragonPreviewView:destroyUI()
	return
end

function DragonPreviewView:onExit()
	self._poolCfg = nil
	self._curViewDatas = nil
end

function DragonPreviewView:buildUI()
	DragonPreviewView.super.buildUI(self)

	local viewBgGo = self:getGo("viewBgGo")

	self._closeBtn = goutil.findChild(viewBgGo, "closeBtn")
	self._leftDesTxt = goutil.findChildComponent(viewBgGo, "leftInfoGo/leftDesTxt", "Text")
end

function DragonPreviewView:onEnter()
	self._poolCfg = self:getFirstParam()

	if self._poolCfg == nil then
		printError("sr---超神龙召唤   DragonPreviewView:onEnter()      未传参数！！！")

		return
	end

	self._leftDesTxt.text = self._poolCfg.preDesc

	self:_updateViewData()
end

function DragonPreviewView:_updateViewData()
	local allCfgs = DragonConfig.instance:getDragonPrizeCfgs(self._poolCfg.prizePlanId)
	local temp = {}

	for _, cfg in pairs(allCfgs) do
		if cfg and cfg.quality and cfg.quality > 0 then
			if temp[cfg.quality] == nil then
				temp[cfg.quality] = {}
			end

			table.insert(temp[cfg.quality], cfg)
		end
	end

	self._curViewDatas = {}

	for rate, list in pairs(temp) do
		if rate and rate > 0 and #list > 0 then
			table.sort(list, function(a, b)
				return a.id < b.id
			end)
			table.insert(self._curViewDatas, {
				rate = rate,
				petList = list
			})
		end
	end

	if #self._curViewDatas > 1 then
		table.sort(self._curViewDatas, function(a, b)
			return a.rate < b.rate
		end)
	end

	self._tableview:ReloadData()
end

function DragonPreviewView:_getPath()
	return {
		cellPath = "viewBgGo/callItem",
		viewPath = "viewBgGo/callItemSR"
	}
end

function DragonPreviewView:_cellSize(sv, index)
	local petListNum = #self._curViewDatas[index + 1].petList
	local row = math.ceil(petListNum / self._colCount)

	return 640, 42 + row * 116.5 + 15
end

function DragonPreviewView:_updateCell(view, cell, data)
	local rateTxt = goutil.findChildTextComponent(cell, "rateTitle/rateTxt")
	local petListRoot = goutil.findChild(cell, "petList")
	local petItem = goutil.findChild(cell, "item")

	petItem:SetActive(false)

	rateTxt.text = cell.data == 1 and lang("text_dragon_desc_11") or cell.data == 2 and lang("text_dragon_desc_12") or lang("text_dragon_desc_13")

	local childCount = petListRoot.transform.childCount
	local petNum = #data.petList

	for i = 1, childCount do
		local go = petListRoot.transform:GetChild(i - 1).gameObject

		MaterialMgr.resetAll(go)
		go:SetActive(false)
	end

	local width = 110
	local scale = 0.85
	local realWidth = width * scale
	local gap = 15
	local gapY = 23
	local col = childCount + 1
	local row = 1

	while col > self._colCount do
		col = col - self._colCount
		row = row + 1
	end

	while childCount < petNum do
		local go = goutil.clone(petItem, "pet" .. childCount + 1)

		go.transform:SetParent(petListRoot.transform)
		Framework.TransformUtil.SetLocalPos(go.transform, (col - 1) * (realWidth + gap), -(row - 1) * (realWidth + gapY), 0)
		Framework.TransformUtil.SetLocalScale(go.transform, scale, scale, scale)

		childCount = childCount + 1
		col = col + 1

		if col > self._colCount then
			col = 1
			row = row + 1
		end
	end

	for i = 1, petNum do
		local go = petListRoot.transform:GetChild(i - 1).gameObject

		go:SetActive(true)
		MaterialMgr.resetAll(go)
		MaterialMgr.setCellListByCfg(data.petList[i].prize, go)
	end
end

return DragonPreviewView
