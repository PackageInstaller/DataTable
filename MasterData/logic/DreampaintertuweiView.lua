-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreampainter/view/DreampaintertuweiView.lua

module("logic.extensions.dreampainter.view.DreampaintertuweiView", package.seeall)

local DreampaintertuweiView = class("DreampaintertuweiView", ViewComponent)
local pageNum = 4

function DreampaintertuweiView:ctor()
	DreampaintertuweiView.super.ctor(self)
end

function DreampaintertuweiView:unbindEvents()
	DreampaintertuweiView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnLeft)
	GameUtil.rmClickHandler(self._btnRight)
end

function DreampaintertuweiView:bindEvents()
	DreampaintertuweiView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnLeft, self._onClickLeft, self)
	GameUtil.addClickHandler(self._btnRight, self._onClickRight, self)
end

function DreampaintertuweiView:buildUI()
	DreampaintertuweiView.super.buildUI(self)

	self._container = self:getGo("container")
	self._firstGo = self:getGo("firstGo")
	self._cell = self:getGo("cell")
	self._btnLeft = self:getGo("btnLeft")
	self._btnRight = self:getGo("btnRight")
	self._txtVoteTimes = self:getTxt("txtTime/txtVoteTimes")
	self._txtDesc = self:getTxt("txtDesc")
	self._txtTime = self:getTxt("txtTime")
	self._items = {}

	GameUtil.SetActive(self._cell, false)

	for i = 1, pageNum do
		local cell = goutil.clone(self._cell, "cell_" .. i)

		GameUtil.SetActive(cell, true)
		goutil.addChildToParent(cell, self._container)
		table.insert(self._items, cell)
	end
end

function DreampaintertuweiView:onExit()
	DreampaintertuweiView.super.onExit(self)
end

function DreampaintertuweiView:onEnter()
	DreampaintertuweiView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())
	self._curPage = 1

	self:_refreshUI()
	DreamPainterController.instance:sendGetInfo(self._activityId)
	self.addGEvent(self, GlobalNotify.DreamPainterInfoUpdate, self._refreshUI, self)
	self.addGEvent(self, GlobalNotify.DreamPainterPageUpdate, self._refreshList, self)

	local cfg = DreamPainterConfig.instance:getCfgById(self._activityId) or {}

	self._txtDesc.text = langPara("活跃度每达到%s时增加1票", cfg.activation)
end

function DreampaintertuweiView:_onClickLeft()
	self._curPage = math.max(1, self._curPage - 1)

	self:_refreshList()
end

function DreampaintertuweiView:_onClickRight()
	self._curPage = math.min(self._totalPage, self._curPage + 1)

	self:_refreshList()
end

function DreampaintertuweiView:_refreshUI()
	local info = DreamPainterModel.instance:getInfo(self._activityId) or {}
	local curPhaseId = checknumber(info.curPhaseId)

	self._curPhaseId = curPhaseId
	self._curPhaseTimes = checknumber(info.curPhaseTimes)

	if not info.phase then
		self._phaseMap = {}

		for i, phase in ipairs(info.phase) do
			local phaseId = phase.phaseId

			self._phaseMap[phaseId] = phase.works
		end

		self._ranks = {}
		self._works = {}

		if not self._phaseMap[curPhaseId] then
			for i, v in ipairs(self._phaseMap[curPhaseId]) do
				local cfg = DreamPainterConfig.instance:getWorksCfgById(self._activityId, v.workId) or {}

				if checknumber(cfg.hide) == 0 then
					table.insert(self._works, v)
					table.insert(self._ranks, v)
				end
			end

			ArraySort.sortOn(self._ranks, "value", ArraySort.bor(ArraySort.DESCENDING, ArraySort.NUMERIC))

			self._works = GameUtil.permuteArray(self._works)
			self._totalPage = math.ceil(#self._works / pageNum)

			self:_refreshList()
			GameUtil.SetActive(self._firstGo, false)
		end
	end
end

function DreampaintertuweiView:_refreshList()
	local info = DreamPainterModel.instance:getInfo(self._activityId) or {}
	local curPhaseId = checknumber(info.curPhaseId)

	self._txtVoteTimes.text = checknumber(info.curPhaseTimes)

	local index = 1 + (self._curPage - 1) * pageNum

	GameUtil.SetActive(self._btnLeft, self._curPage > 1)
	GameUtil.SetActive(self._btnRight, self._curPage < self._totalPage)

	local count = 1

	for i = index, index - 1 + pageNum do
		local cell = self._items[count]
		local data = self._works[i]

		if data then
			GameUtil.SetActive(cell, true)
			self:_updateCell(cell, data)
		else
			GameUtil.SetActive(cell, false)
		end

		count = count + 1
	end
end

function DreampaintertuweiView:_updateCell(cell, info)
	local img = goutil.findChild(cell, "img")
	local btnVote = goutil.findChild(cell, "btnVote")
	local tag = goutil.findChild(cell, "tag")
	local txtTag = goutil.findChildTextComponent(cell, "tag/txt")
	local txtCount = goutil.findChildTextComponent(cell, "count/txtCount")
	local txtPicName = goutil.findChildTextComponent(cell, "txtPicName")
	local txtUserName = goutil.findChildTextComponent(cell, "txtUserName")

	GameUtil.SetActive(tag, false)

	local cfg = DreamPainterConfig.instance:getWorksCfgById(self._activityId, info.workId) or {}

	txtCount.text = info.value
	txtUserName.text = cfg.workerName
	txtPicName.text = cfg.name or ""

	uGuiUtil.setSpriteToImage(img.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("dreampainter", cfg.imgUrl))
	GameUtil.addClickHandler(btnVote, function()
		DreamPainterController.instance:sendPM_DreamPainterVoteReq(self._activityId, self._curPhaseId, info.workId)
	end)
	GameUtil.addClickHandler(img, function()
		UIStateManager.instance:push(ViewName.DreampaintershowView, self._activityId, self._curPhaseId, self._works, info)
	end)
end

return DreampaintertuweiView
