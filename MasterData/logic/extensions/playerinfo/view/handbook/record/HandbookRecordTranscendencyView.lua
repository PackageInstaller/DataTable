-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/record/HandbookRecordTranscendencyView.lua

module("logic.extensions.playerinfo.view.handbook.record.HandbookRecordTranscendencyView", package.seeall)

local M = class("HandbookRecordTranscendencyView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnReturn = self:getBtn("title_view_-878360263")
	self._goRight = self:getGo("handbook_record_transcendency_view_2083300360")
	self._imgCg = self:getBigBg("handbook_record_transcendency_view_-2074340765")
	self._scrollDesc = self:getUIComponent("handbook_record_transcendency_view_-1246107463", UIComponentType.ScrollRect)
	self._txtDesc = self:getText("handbook_record_transcendency_view_1196630005")
	self._txtName = self:getText("handbook_record_transcendency_view_103810389")
	self._txtTime = self:getText("handbook_record_transcendency_view_-1661112789")

	local goScroll = self:getGo("handbook_record_transcendency_view_-1976670793")

	self._loopList = LoopListHelper.New(goScroll)

	self._loopList:InitListView(0, self._onCellUpdate, self)
end

function M:destroyUI()
	self._btnReturn = nil
	self._imgCg = nil
	self._scrollDesc = nil
	self._txtDesc = nil

	self._loopList:Dispose()

	self._loopList = nil
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
end

function M:onEnter()
	self._id2Cell = {}
	self._id2Index = {}

	self:refreshInfo(nil)
	self:refreshEntryTab()
	self:selectFirstUnlockItem()
end

function M:onExit()
	self._id2Cell = nil
	self._id2Index = nil

	self:setLastCell(nil)
	self._imgCg:ClearImage()
	self._loopList:ClearCells()

	self._eventDataLst = nil
end

function M:_onClickReturn()
	self:close()
end

function M:onCellClick(cell)
	if cell:getIsLock() then
		FloatWordMgr.instance:show(lang("tip_clause_not_active"))

		return
	end

	if self:getLastId() and self:getLastId() == cell:getId() then
		return
	end

	if self:getLastCell() then
		self:getLastCell():setIsSelected(false)
	end

	cell:setIsSelected(true)
	self:setLastCell(cell)
	self:refreshInfo(cell:getId())
end

function M:getLastCell()
	return self._id2Cell[self:getLastId()]
end

function M:setLastCell(cell)
	self._lastId = cell and cell:getId() or nil
end

function M:getLastId()
	return self._lastId
end

function M:refreshInfo(cfgId)
	local cgName
	local show = cfgId ~= nil

	if show then
		local index = self._id2Index[cfgId]
		local cfg = self._eventDataLst[index]

		cgName = cfg and cfg.cg or nil

		if not string.nilorempty(cgName) then
			local path = string.format("ui/bigbg/%s.png", cgName)

			self._imgCg:SetImage(path)
		end

		self._txtName.text = cfg.name
		self._txtTime.text = cfg.timeshow
		self._txtDesc.text = cfg.content
	end

	goutil.setActive(self._imgCg.gameObject, show and cgName)
	goutil.setActive(self._scrollDesc.gameObject, show)
	goutil.setActive(self._goRight, show)
end

function M:refreshEntryTab()
	self._eventDataLst = {}

	local ids = HandbookConfig.instance:getRecordIdsTranscendency()

	for _, id in ipairs(ids) do
		local cfg = HandbookConfig.instance:getConfigByKey(ConfigName.GalleryEvent, id)

		if cfg then
			table.insert(self._eventDataLst, cfg)
		end
	end

	self._loopList:SetListItemCount(#self._eventDataLst, true)
	self._loopList:RefreshAllShownItem()
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local data = self._eventDataLst[curIndex]
	local item = self._loopList:NewListViewItem("handbook_record_transcendency_tab")
	local shower = Astral.LuaComponentContainer.Get(item.gameObject, HandbookTranscendencyTabCell)

	if shower == nil then
		shower = Astral.LuaComponentContainer.Add(item.gameObject, HandbookTranscendencyTabCell)
	end

	shower:setHandler(self)
	shower:setData(data)

	local showSelect = self:getLastId() and self:getLastId() == data.id

	shower:setIsSelected(showSelect)

	self._id2Cell[data.id] = shower
	self._id2Index[data.id] = curIndex

	return item
end

function M:selectFirstUnlockItem()
	local cellId

	for index, value in ipairs(self._eventDataLst or {}) do
		if GalleryModel.instance:getIsUnLock(GameEnum.UnlockTypeEnum.Event, value.id) then
			cellId = value.id

			break
		end
	end

	if cellId then
		DoTweenUtil.DelayedCall(0.1, function()
			local cell = self._id2Cell[cellId]

			if cell then
				self:onCellClick(cell)
			end
		end)
	end
end

return M
