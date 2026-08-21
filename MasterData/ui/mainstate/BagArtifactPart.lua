-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\BagArtifactPart.lua

local UIControls = UIControls
local CommonSortPanel = require("UI/Common/CommonSortPanel")
local FILTER_BADGE = 1
local FILTER_RELIC = 2
local ONCE_SELL_MAX = 64
local strClassName = "BagArtifactPart"
local BagArtifactPart = Class(strClassName, UIControls.Child)

function BagArtifactPart:ctor()
	self:initUI()
end

local ARTIFACT_SORT_MAP = {
	{
		name = "quality",
		text = Lang.get(372)
	},
	{
		name = "career",
		hide = 1,
		text = Lang.get(374)
	},
	{
		name = "id",
		hide = 1,
		text = Lang.get(30334)
	},
	{
		name = "enhanceLevel",
		text = Lang.get(920)
	}
}
local ARTIFACT_SELL_FILTER_MAP = {
	{
		title = Lang.get(372),
		data = {
			{
				Lang.get(3633),
				"quality",
				1
			},
			{
				Lang.get(30445),
				"quality",
				2
			},
			{
				Lang.get(30446),
				"quality",
				3
			},
			{
				Lang.get(30447),
				"quality",
				4
			},
			{
				Lang.get(30448),
				"quality",
				5
			}
		}
	},
	{
		title = Lang.get(920),
		data = {
			{
				Lang.get(30449),
				"enhanceLevel",
				{
					0,
					6
				}
			},
			{
				Lang.get(30450),
				"enhanceLevel",
				{
					7,
					12
				}
			},
			{
				Lang.get(30451),
				"enhanceLevel",
				{
					13,
					18
				}
			},
			{
				Lang.get(30452),
				"enhanceLevel",
				{
					19,
					24
				}
			},
			{
				Lang.get(30453),
				"enhanceLevel",
				{
					25,
					30
				}
			}
		}
	}
}

function BagArtifactPart:initUI()
	self.cells = {}
	self.gidGridDic = {}
	self.cellGidDic = {}
	self.scroll = UIControls.ScrollViewLoopV(self, "ItemListScroll")

	self.scroll:addEventCellChanged(self.onCellChanged)

	self.scrollRelic = UIControls.ScrollViewLoopV(self, "ItemListScrollRelic")

	self.scrollRelic:addEventCellChanged(self.onRelicCellChanged)

	self.imgNone = UIControls.Image(self, "ImgNone")
	self.btnBadge = UIControls.Button(self, "BgTab/BtnBadge")

	self.btnBadge:setEnable(false)

	self.btnRelic = UIControls.Button(self, "BgTab/BtnRelic")

	self.btnBadge:addEventClick(self.onClickPart)
	self.btnRelic:addEventClick(self.onClickPart)

	local relicRD = UIControls.RedDot(self, "BgTab/BtnRelic/IconNew")

	relicRD:addHint({
		UIConst.RD_HINT_BAG_RELIC
	})

	self.mode = FILTER_BADGE
	self.btnBagAdd = UIControls.Button(self, "TabFunPanel/BtnBagAdd", "Text")

	self.btnBagAdd:addEventClick(self.onBtnBagClick)
	self.btnBagAdd:setText(CurAvatar:getArtifactCount() .. "/" .. CurAvatar:getBagSize(Const.BAG_TYPE_ARTIFACT))

	self.btnSell = UIControls.Button(self, "TabFunPanel/BtnSell", "Text")

	self.btnSell:addEventClick(self.onBtnSellClick)
	self.btnSell:setVisible(false)

	self.panelItemSell = UIControls.Panel(self, "ItemSellPanel")
	self.btnChoose = UIControls.Button(self, "ItemSellPanel/BtnChoose")

	self.btnChoose:addEventClick(self.onBtnChooseClick)

	self.btnSellConfirm = UIControls.Button(self, "ItemSellPanel/BtnSell", "TextNum")

	self.btnSellConfirm:addEventClick(self.onSellConfirmClick)

	self.txtSellGold = UIControls.Label(self, "ItemSellPanel/IconGold/TextNum")
	self.sortPanel = CommonSortPanel(self, "TabFunPanel")
	self.sortPanel.mEventDataListChanged = Slot(self.updateSort, self)

	self.sortPanel:initSortInfo(ARTIFACT_SORT_MAP)

	self.filterConfig = ClientUtils.getFilterConfig({
		{
			1
		},
		{
			1
		}
	})
end

function BagArtifactPart:onBtnBagClick()
	CurAvatar:openBagGridAddDlg(Const.BAG_TYPE_ARTIFACT)
end

function BagArtifactPart:onRelicCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = UIControls.RelicGridLoop(sender, "System/Common/Grid/GridRelicItem", newIdx)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	targetCell.inBag = true
	self.cells[newIdx] = targetCell

	targetCell:setObj(self.items[newIdx])
end

function BagArtifactPart:onSellConfirmClick()
	if self.sellArtifactList and #self.sellArtifactList > 0 then
		if #self.sellArtifactList > ONCE_SELL_MAX then
			local rpcCount = math.ceil(#self.sellArtifactList / ONCE_SELL_MAX)
			local rpcTable = {}

			for idx = 1, rpcCount do
				local artifacrSellPack = {}
				local startIdx = (idx - 1) * ONCE_SELL_MAX + 1
				local endIdx = idx * ONCE_SELL_MAX

				for artifactIdx = startIdx, endIdx do
					table.insert(artifacrSellPack, self.sellArtifactList[artifactIdx])
				end

				rpcTable[idx] = artifacrSellPack
			end

			for _, data in ipairs(rpcTable) do
				RPC.artifactSell(data)
			end
		else
			RPC.artifactSell(self.sellArtifactList)
		end
	else
		MsgManager.notice(Lang.get(30454))
	end
end

function BagArtifactPart:refreshBagBlankNum()
	self.btnBagAdd:setText(CurAvatar:getArtifactCount() .. "/" .. CurAvatar:getBagSize(Const.BAG_TYPE_ARTIFACT))
end

function BagArtifactPart:onBtnSellClick()
	self.panelItemSell:changeVisible()

	local btnText = self.panelItemSell:getVisible() and Lang.get(7) or Lang.get(528)

	self.btnSell:setText(btnText)

	if not self.panelItemSell:getVisible() then
		self:clearSellArtifactList()
	end

	self:refreshItemSellPanel()
end

function BagArtifactPart:onBtnChooseClick()
	local siftBoxDlg = UIManager.getUI("siftBoxDlg", true)

	if siftBoxDlg then
		siftBoxDlg:initFilterInfo(ARTIFACT_SELL_FILTER_MAP, self.filterConfig, Slot(self.filterCallBack, self))
		siftBoxDlg:setTitle(Lang.get(1050))
	end
end

function BagArtifactPart:onClickPart(sender)
	if sender == self.btnBadge then
		self:_refreshMode(FILTER_BADGE)
	else
		self:_refreshMode(FILTER_RELIC)
	end
end

function BagArtifactPart:_refreshMode(mode)
	self.mode = mode

	self.btnBadge:setEnable(self.mode ~= FILTER_BADGE)
	self.btnRelic:setEnable(self.mode ~= FILTER_RELIC)
	self:refreshData()
end

function BagArtifactPart:refreshData()
	if not CurAvatar then
		return
	end

	if self.panelItemSell:getVisible() then
		self:onBtnSellClick()
	end

	if self.mode == FILTER_BADGE then
		self.items = CurAvatar:getAllArtifacts(nil, true)

		self:refreshBagBlankNum()
	else
		self.items = CurAvatar:getAllRelics(nil, true)
	end

	self.sortPanel:sortByCurConfig(self.items)
end

function BagArtifactPart:updateSort(items)
	self.items = items

	self:updateScroll()
end

function BagArtifactPart:updateScroll()
	if #self.items == 0 then
		self.imgNone:setVisible(true)
		self.scroll:setVisible(false)
		self.scrollRelic:setVisible(false)
		self.sortPanel:setVisible(false)
	else
		self.imgNone:setVisible(false)
		self.sortPanel:setVisible(self.mode == FILTER_BADGE)

		if self.mode == FILTER_BADGE then
			self.scrollRelic:setVisible(false)
			self.scroll:setVisible(true)
			self.scroll:setTotalCount(#self.items)
		else
			local list = {}
			local lastCanLvUpIdx = 0

			for i = 1, #self.items do
				local item = self.items[i]

				if CurAvatar:relicCanLvUp(item) then
					lastCanLvUpIdx = lastCanLvUpIdx + 1

					table.insert(list, lastCanLvUpIdx, item)
				else
					table.insert(list, item)
				end
			end

			self.items = list

			self.scroll:setVisible(false)
			self.scrollRelic:setVisible(true)
			self.scrollRelic:setTotalCount(#self.items)
		end
	end
end

function BagArtifactPart:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = UIControls.ArtifactGridLoop(sender, "System/Common/Grid/GridBadgeItem", newIdx)
		targetCell.mTipsConfig = CurAvatar.commonArtifactTipsFuncItem

		targetCell.btnSensor:clearEventClick()
		targetCell.btnSensor:addEventClick(Slot(self.onGridClickOrSel, self))

		targetCell.inBag = true
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	targetCell:setObj(self.items[newIdx])
	targetCell.imgSelect:setVisible(self:checkIsBeSelect(targetCell.object.gid))

	if self.cellGidDic[targetCell] then
		self.gidGridDic[self.cellGidDic[targetCell]] = nil
	end

	self.cellGidDic[targetCell] = self.items[newIdx].gid
	self.gidGridDic[self.items[newIdx].gid] = targetCell
end

function BagArtifactPart:onGridClickOrSel(sender, btn)
	if self.panelItemSell:getVisible() then
		self:artifactSellSelct(btn.mParent.object.gid, not btn.mParent.imgSelect:getVisible())
	else
		btn.mParent:onGridClick(btn)
	end
end

function BagArtifactPart:artifactSellSelct(gid, isSelect)
	if not self.sellArtifactList then
		self.sellArtifactList = {}
	end

	if CurAvatar.bagArtifacts[gid].inWearing then
		MsgManager.notice(Lang.get(30455))

		return
	end

	if isSelect then
		table.insert(self.sellArtifactList, gid)
	else
		for idx, selGid in ipairs(self.sellArtifactList) do
			if selGid == gid then
				table.remove(self.sellArtifactList, idx)

				break
			end
		end
	end

	if self.gidGridDic[gid] then
		self.gidGridDic[gid].imgSelect:setVisible(isSelect)
	end

	self:refreshItemSellPanel()
end

function BagArtifactPart:checkIsBeSelect(gid)
	if self.sellArtifactList then
		for idx, selGid in ipairs(self.sellArtifactList) do
			if selGid == gid then
				return true
			end
		end

		return false
	end

	return false
end

function BagArtifactPart:refreshItemSellPanel()
	if not self.sellArtifactList then
		self.sellArtifactList = {}
	end

	self.btnSellConfirm:setText("(" .. #self.sellArtifactList .. ")")

	local sellGold = 0

	for _, gid in ipairs(self.sellArtifactList) do
		local artifactGold = CurAvatar.bagArtifacts[gid].resData.sell[1].num

		sellGold = sellGold + artifactGold
	end

	self.txtSellGold:setText(sellGold)
end

function BagArtifactPart:clearSellArtifactList()
	if self.sellArtifactList then
		for idx = #self.sellArtifactList, 1, -1 do
			if self.gidGridDic[self.sellArtifactList[idx]] then
				self.gidGridDic[self.sellArtifactList[idx]].imgSelect:setVisible(false)
			else
				for _, artifactGrid in pairs(self.cells) do
					if artifactGrid.object.gid == self.sellArtifactList[idx] then
						artifactGrid.imgSelect:setVisible(false)
					end
				end
			end

			table.remove(self.sellArtifactList, idx)
		end

		self:refreshItemSellPanel()

		self.gidGridDic = {}
		self.cellGidDic = {}

		self.scroll:setTotalCount(#self.items)
	end
end

function BagArtifactPart:filterCallBack(checkFilterFunc, _filterConfig)
	self.checkFilterFunc = checkFilterFunc
	self.filterConfig = _filterConfig

	self:clearSellArtifactList()

	if self.checkFilterFunc then
		for _, artifact in ipairs(self.items) do
			if self.checkFilterFunc(artifact) and not artifact.inWearing then
				self:artifactSellSelct(artifact.gid, true)
			end
		end
	end

	local siftBoxDlg = UIManager.getUI("siftBoxDlg", nil, false)

	if siftBoxDlg then
		siftBoxDlg:setVisible(false)
	end
end

function BagArtifactPart:onPartClose()
	self.checkFilterFunc = nil
	self.filterConfig = ClientUtils.getFilterConfig({
		{
			1
		},
		{
			1
		}
	})
	self.sellArtifactList = nil
end

return BagArtifactPart
