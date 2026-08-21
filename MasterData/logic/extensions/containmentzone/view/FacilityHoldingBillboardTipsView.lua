-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/view/FacilityHoldingBillboardTipsView.lua

module("logic.extensions.containmentzone.view.FacilityHoldingBillboardTipsView", package.seeall)

local M = class("FacilityHoldingBillboardTipsView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnClose = self:getBtn("facility_holding_billboard_tips_1675834648")
	self._btnCancel = self:getBtn("facility_holding_billboard_tips_-1019055209")
	self._btnConfirm = self:getBtn("facility_holding_billboard_tips_-1903178854")
	self._billBoardItemRoot = self:getGo("facility_holding_billboard_tips_-775356529")
	self._txtSelectCount = self:getText("facility_holding_billboard_tips_-1607589176")
	self._infoCellCollection = LocalReusableCollection.New(BillboardItemCell, 12)
end

function M:destroyUI()
	self._btnClose = nil
	self._btnCancel = nil
	self._btnConfirm = nil
	self._billBoardItemRoot = nil
	self._infoCellCollection = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
end

function M:onEnter()
	local info = self:getFirstParam()

	self._billBoardMaxCount = ContainmentConfig.instance:getConstByKey("BillboardCount")
	self._billBoardTable = {}
	self._lastBillBoardVal = 0
	self._protomerId = 0
	self.roomId = info and info.roomId or 1101

	local roomInfo = ContainmentModel.instance:getRoomInfoById(self.roomId)

	if roomInfo == nil then
		self.canSet = false
	else
		self._protomerId = roomInfo:getProtomerId()
		self.canSet = self._protomerId > 0
	end

	if self._protomerId > 0 then
		local protomerInfo = ContainmentModel.instance:getProtomerInfo(self.roomId)

		self._billBoardTable = protomerInfo:getBillBoardActiveTable()
		self._lastBillBoardVal = protomerInfo:getBillBoard()
	end

	self:_updateBillBoardShow()
end

function M:onExit()
	self._billBoardMaxCount = nil
	self._billBoardTable = nil
	self._selectMark = nil
	self._newSelectMark = nil
	self._nowBillBoardVal = nil
	self._lastBillBoardVal = nil
	self.canSet = nil
	self._protomerId = nil

	self._infoCellCollection:clearAllInstance()
end

function M:_onClickClose()
	self:close()
end

function M:_onClickConfirm()
	if not self.canSet then
		printWarn("房间未解锁，或未设置原体，不响应操作，roomId = ", self.roomId)
		self:close()

		return
	end

	self._nowBillBoardVal = 0

	if #self._selectMark > 0 then
		self._newSelectMark = {}

		for i = 1, 32 do
			self._newSelectMark[i] = 0
		end

		for index, value in ipairs(self._selectMark) do
			local binIndex = 32 - value

			self._newSelectMark[binIndex] = 1
		end

		self._nowBillBoardVal = ContainmentModel.instance:bin2decimal(self._newSelectMark)
	end

	printWarn(string.format("修改行为十进制[%d]->[%d]", self._lastBillBoardVal, self._nowBillBoardVal))

	if self._lastBillBoardVal ~= self._nowBillBoardVal then
		printWarn("行为发生变更，需要通知服务器")
		ContainmentZoneAgent.instance:sendChangeBillboardRequest(self._protomerId, self._nowBillBoardVal)
	else
		printWarn("行为未发生变更，无需通知服务器")
	end

	self:close()
end

function M:_updateSelectText()
	self._txtSelectCount.text = string.format("（%d/%d）", #self._selectMark, self._billBoardMaxCount)
end

function M:_updateBillBoardShow()
	local count = self._billBoardTable and #self._billBoardTable or 0

	self._selectMark = {}

	if count > 0 then
		for index, value in ipairs(self._billBoardTable) do
			self._selectMark[index] = 32 - value
		end
	end

	if self._infoCellCollection then
		self._infoCellCollection:clearAllInstance()
	end

	for i = 0, ContainmentEnum.billBoardCount - 1 do
		local billBoardId = i
		local prefab = self:getPrefab(ResName.Room_facility_holding_facility_holding_billboard_item)
		local cellBehavior = self._infoCellCollection:createInstance(prefab)

		goutil.addChildToParent(cellBehavior.mainGO, self._billBoardItemRoot)
		cellBehavior:setId(billBoardId)
		cellBehavior:setHandler(self)
		cellBehavior:setHint(ContainmentUtil.getBillBoardName(self._protomerId, billBoardId))
		cellBehavior:setIcon(self._protomerId, billBoardId)

		count = #self._selectMark

		if count > 0 then
			for selectIndex, value in ipairs(self._selectMark) do
				if i == value then
					cellBehavior:setSelect(true)
					cellBehavior:setSelectNum(selectIndex)
				end
			end
		end
	end

	self:_updateSelectText()
end

function M:onBillBoardItemClick(billBoardItem)
	if not self.canSet then
		FloatWordMgr.instance:show("不能选择行为，房间未解锁，或未放置隐秘原体")

		return
	end

	local itemId = billBoardItem:getId()
	local itemReadySelected = not billBoardItem:getIsSelected()
	local selectCount = #self._selectMark

	if itemReadySelected and selectCount > 0 then
		local _conflictIndex = false
		local _conflictId = itemId % 2 == 0 and itemId + 1 or itemId - 1

		for index, _id in ipairs(self._selectMark) do
			if not _conflictIndex and _id == _conflictId then
				printWarn(string.format("选中[%s]%s 与[%s]%s 冲突，将顶掉冲突使用选中项", itemId, ContainmentUtil.getBillBoardName(self._protomerId, itemId), _conflictId, ContainmentUtil.getBillBoardName(self._protomerId, _conflictId)))

				_conflictIndex = index
			end
		end

		if _conflictIndex then
			self._selectMark[_conflictIndex] = itemId

			billBoardItem:setSelect(true)
			billBoardItem:setSelectNum(_conflictIndex)

			local _conflictGo = self._billBoardItemRoot.transform:GetChild(_conflictId).gameObject
			local _conflictItem = Astral.SimpleLuaComponentContainer.Get(_conflictGo, BillboardItemCell)

			_conflictItem:setSelect(false)

			return
		end
	end

	if itemReadySelected and selectCount >= self._billBoardMaxCount then
		FloatWordMgr.instance:show(string.format(lang("tip_house_protomer_billboard_max"), self._billBoardMaxCount))

		return
	end

	if itemReadySelected then
		local nowIndex = selectCount + 1

		self._selectMark[nowIndex] = itemId

		billBoardItem:setSelect(true)
		billBoardItem:setSelectNum(nowIndex)
	else
		self._newSelectMark = {}

		local index = 1

		billBoardItem:setSelect(false)

		for _, value in ipairs(self._selectMark) do
			if value ~= itemId then
				self._newSelectMark[index] = value

				local otherGo = self._billBoardItemRoot.transform:GetChild(value).gameObject
				local otherItem = Astral.SimpleLuaComponentContainer.Get(otherGo, BillboardItemCell)

				otherItem:setSelectNum(index)

				index = index + 1
			end
		end

		self._selectMark = self._newSelectMark
	end

	self:_updateSelectText()
end

return M
