-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreampainter/view/DreampainterDispalyView.lua

module("logic.extensions.dreampainter.view.DreampainterDispalyView", package.seeall)

local DreampainterDispalyView = class("DreampainterDispalyView", ViewComponent)
local pageNum = 4

function DreampainterDispalyView:ctor()
	DreampainterDispalyView.super.ctor(self)
end

function DreampainterDispalyView:unbindEvents()
	DreampainterDispalyView.super.unbindEvents(self)
end

function DreampainterDispalyView:bindEvents()
	DreampainterDispalyView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnLeft, self._onClickLeft, self)
	GameUtil.addClickHandler(self._btnRight, self._onClickRight, self)
end

function DreampainterDispalyView:buildUI()
	DreampainterDispalyView.super.buildUI(self)

	self._container = self:getGo("container")
	self._firstGo = self:getGo("firstGo")
	self._cell = self:getGo("cell")
	self._btnLeft = self:getGo("btnLeft")
	self._btnRight = self:getGo("btnRight")
	self._txtVoteTimes = self:getTxt("txtTime/txtVoteTimes")
	self._txtDesc = self:getTxt("txtDesc")
	self._txtTime = self:getTxt("txtTime")
	self._txtVoteTimes.text = ""
	self._txtDesc.text = ""
	self._txtTime.text = ""
	self._items = {}

	GameUtil.SetActive(self._cell, false)

	for i = 1, pageNum do
		local cell = goutil.clone(self._cell, "cell_" .. i)

		GameUtil.SetActive(cell, true)
		goutil.addChildToParent(cell, self._container)
		table.insert(self._items, cell)
	end

	self._firstList = {}

	for i = 1, 3 do
		local cell = goutil.clone(self._cell, "cell_" .. i)

		GameUtil.SetActive(cell, true)

		local posGo = self:getGo("firstGo/pos_" .. i)

		goutil.addChildToParent(cell, posGo)
		GameUtil.setAnchoredPos(cell, 0, 0)
		table.insert(self._firstList, cell)
	end
end

function DreampainterDispalyView:onExit()
	DreampainterDispalyView.super.onExit(self)
end

function DreampainterDispalyView:onEnter()
	DreampainterDispalyView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())
	self._curPage = 1

	self:_refreshUI()
	DreamPainterController.instance:sendGetInfo(self._activityId)
	self.addGEvent(self, GlobalNotify.DreamPainterInfoUpdate, self._refreshUI, self)
	self.addGEvent(self, GlobalNotify.DreamPainterPageUpdate, self._refreshList, self)
end

function DreampainterDispalyView:_onClickLeft()
	self._curPage = math.max(1, self._curPage - 1)

	self:_refreshList()
end

function DreampainterDispalyView:_onClickRight()
	self._curPage = math.min(self._totalPage, self._curPage + 1)

	self:_refreshList()
end

function DreampainterDispalyView:_refreshUI()
	local info = DreamPainterModel.instance:getInfo(self._activityId) or {}
	local curPhaseId = 3
	local curPhaseTimes = checknumber(info.curPhaseTimes)

	self._curPhaseId = curPhaseId

	if not info.phase then
		self._phaseMap = {}

		for i, phase in ipairs(info.phase) do
			local phaseId = phase.phaseId

			self._phaseMap[phaseId] = phase.works
		end

		self._ranks = {}

		if not self._phaseMap[curPhaseId] then
			for i, v in ipairs(self._phaseMap[curPhaseId]) do
				local cfg = DreamPainterConfig.instance:getWorksCfgById(self._activityId, v.workId) or {}

				if checknumber(cfg.hide) == 0 then
					table.insert(self._ranks, v)
				end
			end

			ArraySort.sortOn(self._ranks, "value", ArraySort.bor(ArraySort.DESCENDING, ArraySort.NUMERIC))

			self._works = self._ranks
			self._totalPage = math.ceil(#self._works / pageNum)

			self:_refreshList()
		end
	end
end

function DreampainterDispalyView:_refreshList()
	local index = 1 + (self._curPage - 1) * pageNum

	GameUtil.SetActive(self._btnLeft, self._curPage > 1)
	GameUtil.SetActive(self._btnRight, self._curPage < self._totalPage)
	GameUtil.SetActive(self._container, false)
	GameUtil.SetActive(self._firstGo, false)
	GameUtil.SetActive(self._container, true)

	local count = 1

	for i = index, index - 1 + pageNum do
		local cell = self._items[count]
		local info = self._works[i]

		if info then
			GameUtil.SetActive(cell, true)
			self:_updateCell(cell, info, i)
		else
			GameUtil.SetActive(cell, false)
		end

		count = count + 1
	end
end

function DreampainterDispalyView:_updateCell(cell, info, rank)
	local img = goutil.findChild(cell, "img")
	local btnVote = goutil.findChild(cell, "btnVote")
	local tag = goutil.findChild(cell, "tag")
	local txtTag = goutil.findChildTextComponent(cell, "tag/txt")
	local txtCount = goutil.findChildTextComponent(cell, "count/txtCount")
	local txtPicName = goutil.findChildTextComponent(cell, "txtPicName")
	local txtUserName = goutil.findChildTextComponent(cell, "txtUserName")

	GameUtil.SetActive(tag, false)
	GameUtil.SetActive(btnVote, false)

	local pcfg = DreamPainterConfig.instance:getDreamPainterPrizeByValue(self._activityId, rank)

	if pcfg then
		GameUtil.SetActive(tag, true)

		txtTag.text = pcfg.desc

		GameUtil.setUIImageSpriteIdx(tag, 0)

		if rank > 1 then
			GameUtil.setUIImageSpriteIdx(tag, 1)
		end
	end

	local cfg = DreamPainterConfig.instance:getWorksCfgById(self._activityId, info.workId) or {}

	txtCount.text = info.value
	txtUserName.text = cfg.workerName
	txtPicName.text = cfg.name or ""

	uGuiUtil.setSpriteToImage(img.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("dreampainter", cfg.imgUrl))
	GameUtil.addClickHandler(img, function()
		UIStateManager.instance:push(ViewName.DreampaintershowView, self._activityId, self._curPhaseId, self._works, info, true)
	end)
end

return DreampainterDispalyView
