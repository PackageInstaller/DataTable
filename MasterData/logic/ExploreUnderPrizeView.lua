-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/view/ExploreUnderPrizeView.lua

module("logic.extensions.exploreunder.view.ExploreUnderPrizeView", package.seeall)

local ExploreUnderPrizeView = class("ExploreUnderPrizeView", ViewComponent)

function ExploreUnderPrizeView:buildUI()
	ExploreUnderPrizeView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._tableGo = self:getGo("tableview")
	self._itemGo = self:getGo("tablecell")
	self._itemScrollercell = self:getGo("itemScrollercell")
	self._tableview = ScrollerList.create(self._tableGo, self._itemGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)
end

function ExploreUnderPrizeView:bindEvents()
	ExploreUnderPrizeView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function ExploreUnderPrizeView:unbindEvents()
	ExploreUnderPrizeView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function ExploreUnderPrizeView:onEnter()
	ExploreUnderPrizeView.super.onEnter(self)

	local actId = ExploreUnderModel.instance:getActId()
	local actCfg = ExploreUnderConfig.instance:getActfg(actId)

	self._levelCfgs = ExploreUnderConfig.instance:getLevelCfgs(actCfg.levelPlanId)
	self._curLevel = ExploreUnderModel.instance:getCurLevel()

	if ExploreUnderModel.instance:getIsAllPass() then
		self._curLevel = self._curLevel + 1
	end

	local dataList = {}
	local temId = 0

	for i, v in ipairs(self._levelCfgs) do
		if self._curLevel > v.level then
			table.insert(dataList, v)
		else
			temId = temId + 1

			table.insert(dataList, temId, v)
		end
	end

	self._tableview:reloadData(dataList)
end

function ExploreUnderPrizeView:onExit()
	ExploreUnderPrizeView.super.onExit(self)
	self._tableview:dispose()
end

function ExploreUnderPrizeView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	cell.txtDes.text = langPara("成功探索第%s层秘境", data.level)

	goutil.setActive(cell.goNotFinish, data.level >= self._curLevel)
	goutil.setActive(cell.goFinish, data.level < self._curLevel)

	if cell.itemScrollerview and self._itemScrollercell and not string.nilorempty(data.passPrize) then
		local prizeStrArr = string.split(data.passPrize, "#")

		if not self._itemScrollListDic[cell.go] then
			local itemScrollList = ScrollerList.create(cell.itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[cell.go] = self._itemScrollListDic[cell.go]

			self._itemScrollListDic[cell.go]:reloadData(prizeStrArr)
			self._itemScrollListDic[cell.go]:dragNotifyParent()
		end
	end
end

function ExploreUnderPrizeView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.txtDes = goutil.findChildTextComponent(cell.go, "imgDes/txt")
	cell.goNotFinish = goutil.findChild(cell.go, "state/txtNotFinish")
	cell.goFinish = goutil.findChild(cell.go, "state/txtReceived")
	cell.itemScrollerview = goutil.findChild(cell.go, "itemScrollerview")

	local itemScrollList = self._itemScrollListDic[cell.go]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[cell.go] = nil
	end

	return cell
end

function ExploreUnderPrizeView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function ExploreUnderPrizeView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return ExploreUnderPrizeView
