-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/view/WLTowerRewardView.lua

module("logic.extensions.waterdraktower.view.WLTowerRewardView", package.seeall)

local WLTowerRewardView = class("WLTowerRewardView", TableViewComponent)

function WLTowerRewardView:ctor()
	WLTowerRewardView.super.ctor(self)
end

function WLTowerRewardView:bindEvents()
	WLTowerRewardView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function WLTowerRewardView:unbindEvents()
	WLTowerRewardView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function WLTowerRewardView:onExit()
	WLTowerRewardView.super.onExit(self)

	self._curViewDatas = nil
	self._specialList = nil
end

function WLTowerRewardView:destroyUI()
	WLTowerRewardView.super.destroyUI(self)
end

function WLTowerRewardView:buildUI()
	WLTowerRewardView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
end

function WLTowerRewardView:onEnter()
	WLTowerRewardView.super.onEnter(self)

	self._curViewDatas, self._specialList = WaterdraktowerModel.instance:getTierPrizePreviewList()
	self._curViewDatas = self._curViewDatas or {}

	self._tableview:ReloadData()
end

function WLTowerRewardView:_getPath()
	return {
		cellPath = "rewardItem",
		viewPath = "rewardListSR"
	}
end

function WLTowerRewardView:_cellSize()
	return 892, 118
end

function WLTowerRewardView:_updateCell(view, cell, data)
	local descTxt = goutil.findChildTextComponent(cell, "descTxt")
	local itemList = {}

	itemList[1] = {
		itemGo = goutil.findChild(cell, "priceIitem_1"),
		itemPos = goutil.findChild(cell, "priceIitem_1/posGo"),
		itemTag = goutil.findChild(cell, "priceIitem_1/tagGo")
	}
	itemList[2] = {
		itemGo = goutil.findChild(cell, "priceIitem_2"),
		itemPos = goutil.findChild(cell, "priceIitem_2/posGo"),
		itemTag = goutil.findChild(cell, "priceIitem_2/tagGo")
	}
	itemList[3] = {
		itemGo = goutil.findChild(cell, "priceIitem_3"),
		itemPos = goutil.findChild(cell, "priceIitem_3/posGo"),
		itemTag = goutil.findChild(cell, "priceIitem_3/tagGo")
	}
	itemList[4] = {
		itemGo = goutil.findChild(cell, "priceIitem_4"),
		itemPos = goutil.findChild(cell, "priceIitem_4/posGo"),
		itemTag = goutil.findChild(cell, "priceIitem_4/tagGo")
	}
	itemList[5] = {
		itemGo = goutil.findChild(cell, "priceIitem_5"),
		itemPos = goutil.findChild(cell, "priceIitem_5/posGo"),
		itemTag = goutil.findChild(cell, "priceIitem_5/tagGo")
	}

	local extraPrizeGo = goutil.findChild(cell, "extraPrizeGo")
	local extraItem = goutil.findChild(extraPrizeGo, "extraItem")

	for i = 1, #itemList do
		if itemList[i] then
			if itemList[i].itemPos then
				MaterialMgr.resetAll(itemList[i].itemPos)
			end

			if itemList[i].itemTag then
				itemList[i].itemTag:SetActive(false)
			end
		end
	end

	MaterialMgr.resetAll(extraItem)

	descTxt.text = langPara("text_wltower_desc_10", data.name, data.tier, data.stage)

	local count = #data.prize

	for i = 1, count do
		if data.prize[i] and itemList[i] then
			MaterialMgr.setCellByCfg(data.prize[i], itemList[i].itemPos)
		end
	end

	if string.nilorempty(data.extraPrize) then
		GameUtil.SetActive(extraPrizeGo, false)
	else
		GameUtil.SetActive(extraPrizeGo, true)
		MaterialMgr.setCellByCfg(data.extraPrize, extraItem)
	end

	if self._specialList and self._specialList[cell.data] and count < #itemList then
		local list = self._specialList[cell.data]

		for i = 1, #list do
			if list[i] and itemList[count + i] then
				MaterialMgr.setCellByCfg(list[i], itemList[count + i].itemPos)

				if itemList[count + i].itemTag then
					itemList[count + i].itemTag:SetActive(true)
				end
			end
		end
	end
end

return WLTowerRewardView
