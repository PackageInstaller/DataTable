-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/LotteryRandomView.lua

module("logic.extensions.lottery.view.LotteryRandomView", package.seeall)

local LotteryRandomView = class("LotteryRandomView", ViewComponent)

function LotteryRandomView:ctor()
	LotteryRandomView.super.ctor(self)

	self.cellItemList = nil
	self.curViewDatas = nil
end

function LotteryRandomView:bindEvents()
	LotteryRandomView.super.bindEvents(self)
	GameUtil.asBtn(self.clickGo):AddClickListener(self.close, self)
end

function LotteryRandomView:unbindEvents()
	LotteryRandomView.super.unbindEvents(self)
	GameUtil.asBtn(self.clickGo):RemoveClickListener()
end

function LotteryRandomView:buildUI()
	LotteryRandomView.super.buildUI(self)

	self.clickGo = self:getGo("clickGo")
	self.smallViewGo = self:getGo("smallViewGo")
	self.bigViewGo = self:getGo("bigViewGo")
	self.itemGo = self:getGo("itemGo")
	self.tableview = goutil.findChild(self.bigViewGo, "itemListSR"):GetComponent("UITableview")

	self.smallViewGo:SetActive(false)
	self.bigViewGo:SetActive(false)
	self.itemGo:SetActive(false)
	self.tableview:RegisterCallback(function()
		return #self.curViewDatas
	end, function()
		return 100, 100
	end, self.GetCellAtIndex, self)
	self.tableview:RegisterUpdateCellCallback(self.OnCellUpdate)
end

function LotteryRandomView:destroyUI()
	LotteryRandomView.super.destroyUI(self)

	self.curViewDatas = nil
end

function LotteryRandomView:onEnter()
	LotteryRandomView.super.onEnter(self)

	if self.cellItemList and #self.cellItemList > 0 then
		for i = 1, #self.cellItemList do
			if self.cellItemList[i] then
				MaterialMgr.resetAll(self.cellItemList[i])
			end
		end
	end

	if self._viewPresentor._openParam == nil or self._viewPresentor._openParam[1] == nil then
		return
	end

	self.curViewDatas = string.split(self._viewPresentor._openParam[1], ",")

	if self.curViewDatas == nil or #self.curViewDatas == 0 then
		return
	end

	if #self.curViewDatas > 4 then
		self.smallViewGo:SetActive(false)
		self.bigViewGo:SetActive(true)
		self.tableview:ReloadData()
	else
		self.cellItemList = self.cellItemList or {}

		self.bigViewGo:SetActive(false)
		self.smallViewGo:SetActive(true)

		local start = -172

		for i = 1, #self.curViewDatas do
			if self.cellItemList[i] == nil then
				self.cellItemList[i] = UnityEngine.GameObject.Instantiate(self.itemGo, self.smallViewGo.transform)

				self.cellItemList[i]:SetActive(true)
			end

			Framework.TransformUtil.SetLocalPos(self.cellItemList[i].transform, start + (i - 1) * 115, -18, 0)

			local itemStr = MatType.Pet .. ":" .. self.curViewDatas[i] .. ":" .. 1
			local proxy = MaterialMgr.setCellByCfg(itemStr, self.cellItemList[i])

			proxy.binder:setShowName(true)
		end
	end
end

function LotteryRandomView:onEnterFinished()
	return
end

function LotteryRandomView:onExit()
	LotteryRandomView.super.onExit(self)
end

function LotteryRandomView:onExitFinished()
	return
end

function LotteryRandomView:GetCellAtIndex(view, idx)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self.itemGo)

	local data = self.curViewDatas[idx + 1]

	cell.data = idx + 1
	cell.index = idx

	self:UpdateCell(view, cell, data)

	return cell
end

function LotteryRandomView:OnCellUpdate(view, cell)
	local idx = cell.index
	local data = self.curViewDatas[idx + 1]

	cell.data = idx + 1

	self:UpdateCell(view, cell, data)
end

function LotteryRandomView:UpdateCell(view, cell, data)
	MaterialMgr.resetAll(cell)

	local itemStr = MatType.Pet .. ":" .. data .. ":" .. 1
	local proxy = MaterialMgr.setCellByCfg(itemStr, cell)

	proxy.binder:setShowName(true)
end

return LotteryRandomView
