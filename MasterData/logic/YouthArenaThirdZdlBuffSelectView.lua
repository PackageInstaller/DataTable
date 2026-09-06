-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdZdlBuffSelectView.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdZdlBuffSelectView", package.seeall)

local YouthArenaThirdZdlBuffSelectView = class("YouthArenaThirdZdlBuffSelectView", ViewComponent)

function YouthArenaThirdZdlBuffSelectView:ctor()
	YouthArenaThirdZdlBuffSelectView.super.ctor(self)
end

function YouthArenaThirdZdlBuffSelectView:buildUI()
	YouthArenaThirdZdlBuffSelectView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tableView = self:getGo("tableview")
	self._tableScrollRect = self._tableView:GetComponent("ScrollRect")
	self._tableCell = self:getGo("tableview/tablecell")
	self._btnSure = self:getGo("btnSure")
	self._empty = self:getGo("empty")
	self._scrollList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function YouthArenaThirdZdlBuffSelectView:bindEvents()
	YouthArenaThirdZdlBuffSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function YouthArenaThirdZdlBuffSelectView:unbindEvents()
	YouthArenaThirdZdlBuffSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function YouthArenaThirdZdlBuffSelectView:onEnter()
	YouthArenaThirdZdlBuffSelectView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._fmtMo = params[1]
	self._mode = checknumber(params[2])
	self._tabIndex = checknumber(params[3])
	self._buffPlanId = checknumber(params[4])
	self._buffMap = self._fmtMo and self._fmtMo:copyModeBuffMap(self._mode) or {}
	self._selectedBuffId = checknumber(self._buffMap[self._tabIndex])
	self._buffIds = {}
	self._buffCfgMap = {}

	for _, cfg in ipairs(YouthArenaThirdConfig.instance:getKnockoutBuffPlanDatas(self._buffPlanId) or {}) do
		local buffId = checknumber(cfg.buffId)

		if buffId > 0 then
			table.insert(self._buffIds, buffId)

			self._buffCfgMap[buffId] = cfg
		end
	end

	if self._buffCfgMap[self._selectedBuffId] == nil then
		self._selectedBuffId = 0
		self._buffMap[self._tabIndex] = 0
	end

	self:_refreshView()
	self:_scrollToSelected()
end

function YouthArenaThirdZdlBuffSelectView:onExit()
	YouthArenaThirdZdlBuffSelectView.super.onExit(self)

	if self._scrollList then
		self._scrollList:dispose()
	end

	self._fmtMo = nil
	self._buffMap = nil
end

function YouthArenaThirdZdlBuffSelectView:_refreshView()
	local hasBuff = #self._buffIds > 0

	GameUtil.SetActive(self._empty, not hasBuff)
	GameUtil.SetActive(self._tableView, hasBuff)
	GameUtil.SetActive(self._btnSure, hasBuff)
	self._scrollList:reloadData(self._buffIds)
	self._scrollList:setCenterMode(true)
end

function YouthArenaThirdZdlBuffSelectView:_scrollToSelected()
	if self._selectedBuffId <= 0 then
		return
	end

	local index = table.indexof(self._buffIds, self._selectedBuffId)

	if checknumber(index) > 0 then
		self._scrollList:MoveCellToCenter(index - 1)
	end
end

function YouthArenaThirdZdlBuffSelectView:_updateCell(view, cell, buffId)
	local cfg = self._buffCfgMap[buffId]
	local selectGo = goutil.findChild(cell, "select")
	local btnGo = goutil.findChild(cell, "btn")
	local buffIcon = goutil.findChild(cell, "BuffIcon")
	local descDrag = Framework.UIDragTrigger.Get(goutil.findChild(cell, "sv"))
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "sv/Viewport/txtDesc")
	local hasTag = goutil.findChild(cell, "hasTag")
	local tagIndex = goutil.findChild(cell, "tagIndex")
	local txtIndex = goutil.findChildTextComponent(cell, "tagIndex/txt")
	local ownerIndex = self._fmtMo and self._fmtMo:findBuffOwner(self._mode, buffId, self._buffMap) or 0
	local showOwner = self._mode == YouthArenaThirdEnum.BattleMode.Three and ownerIndex > 0

	GameUtil.SetActive(selectGo, self._selectedBuffId == buffId)
	GameUtil.SetActive(hasTag, showOwner)
	GameUtil.SetActive(tagIndex, showOwner)

	if txtIndex then
		txtIndex.text = tostring(ownerIndex)
	end

	if cfg then
		txtName.text = cfg.name or ""
		txtDesc.text = cfg.desc or ""

		if string.nilorempty(cfg.icon) then
			uGuiUtil.clearImage(buffIcon)
		else
			uGuiUtil.setSpriteToImage(buffIcon, uGuiUtil.SpriteType.BigBg, string.format("ui/%s.png", cfg.icon))
		end
	end

	descDrag:AddBeginDragListener(self._onDescBeginDrag, self)
	descDrag:AddDragListener(self._onDescDrag, self)
	descDrag:AddEndDragListener(self._onDescEndDrag, self)
	GameUtil.addClickHandler(btnGo, GameUtil.handler(self._onClickBuffCell, self, buffId))
end

function YouthArenaThirdZdlBuffSelectView:_clearCell(cell)
	local btnGo = goutil.findChild(cell, "btn")
	local buffIcon = goutil.findChild(cell, "BuffIcon")
	local descDrag = Framework.UIDragTrigger.Get(goutil.findChild(cell, "sv"))

	descDrag:RemoveBeginDragListener()
	descDrag:RemoveDragListener()
	descDrag:RemoveEndDragListener()
	GameUtil.rmClickHandler(btnGo)
	uGuiUtil.clearImage(buffIcon)
end

function YouthArenaThirdZdlBuffSelectView:_onDescBeginDrag(eventData)
	self._tableScrollRect:OnBeginDrag(eventData)
end

function YouthArenaThirdZdlBuffSelectView:_onDescDrag(eventData)
	self._tableScrollRect:OnDrag(eventData)
end

function YouthArenaThirdZdlBuffSelectView:_onDescEndDrag(eventData)
	self._tableScrollRect:OnEndDrag(eventData)
end

function YouthArenaThirdZdlBuffSelectView:_onClickBuffCell(buffId)
	local ownerIndex = self._fmtMo and self._fmtMo:findBuffOwner(self._mode, buffId, self._buffMap) or 0

	if self._mode == YouthArenaThirdEnum.BattleMode.Three and ownerIndex > 0 and ownerIndex ~= self._tabIndex then
		local function doReplace()
			self._buffMap[ownerIndex] = 0

			self:_selectBuff(buffId)
		end

		TipsFacade.instance:openPopupWindow("提示", langPara("已用于3v3模式-阵型%d，是否替换", ownerIndex), doReplace, nil, "确定", "取消")

		return
	end

	self:_selectBuff(buffId)
end

function YouthArenaThirdZdlBuffSelectView:_selectBuff(buffId)
	self._selectedBuffId = checknumber(buffId)
	self._buffMap[self._tabIndex] = self._selectedBuffId

	self:_refreshView()
end

function YouthArenaThirdZdlBuffSelectView:_onClickSure()
	if self._selectedBuffId <= 0 then
		FloatWordMgr.instance:show(lang("请选择祝福"))

		return
	end

	if self._fmtMo then
		self._fmtMo:applyModeBuffMap(self._mode, self._buffMap)
	end

	self:close()
end

return YouthArenaThirdZdlBuffSelectView
