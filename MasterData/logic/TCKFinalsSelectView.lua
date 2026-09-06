-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKFinalsSelectView.lua

module("logic.extensions.teenchampionking.view.TCKFinalsSelectView", package.seeall)

local TCKFinalsSelectView = class("TCKFinalsSelectView", ViewComponent)

function TCKFinalsSelectView:ctor()
	TCKFinalsSelectView.super.ctor(self)
end

function TCKFinalsSelectView:unbindEvents()
	TCKFinalsSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function TCKFinalsSelectView:bindEvents()
	TCKFinalsSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function TCKFinalsSelectView:buildUI()
	TCKFinalsSelectView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._goTableview = self:getGo("tableview")
	self._goTablecell = self:getGo("tableview/tablecell")
	self._tableview = ScrollerList.create(self._goTableview, self._goTablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function TCKFinalsSelectView:onExit()
	TCKFinalsSelectView.super.onExit(self)
	self._tableview:dispose()
end

function TCKFinalsSelectView:onEnter()
	TCKFinalsSelectView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_TCKStepChange, self._onStepChange, self)

	local params = self:getOpenParam()

	self._activityId = params and checknumber(params[1]) or 501001

	if params then
		self._playerInfos = params[2] or {}
	end

	if params then
		self._rankInfoMap = params[3] or {}
	end

	self._selectId = params and checknumber(params[4]) or 1

	if #self._playerInfos == 0 then
		self:close()

		return
	end

	self._tableview:reloadData(self._playerInfos)
	self:_onStepChange()
end

function TCKFinalsSelectView:_updateCell(view, cell, data)
	local head = goutil.findChild(cell.gameObject, "head")
	local btn = goutil.findChild(cell.gameObject, "btn")
	local txtTag = goutil.findChildTextComponent(cell.gameObject, "tag/txt")
	local tagChange = goutil.findChildComponent(cell.gameObject, "tag", "UIImageSpriteChange")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtZone = goutil.findChildTextComponent(cell.gameObject, "txtZone")
	local txtZdl = goutil.findChildTextComponent(cell.gameObject, "txtZdl")
	local txtScore = goutil.findChildTextComponent(cell.gameObject, "txtScore")

	txtName.text = data.headInfo.headInfo.userName
	txtZone.text = string.format("%s-%s", data.areaId, data.headInfo.headInfo.areaName)
	txtZdl.text = string.format("战力：<color=#20b376>%s</color>", data.zdl)
	txtScore.text = string.format("当前积分：<color=#20b376>%s</color>", data.headInfo.score)

	GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickSelect, self, data))
	HeadItemController.instance:setHeadCellByInfo(head, data.headInfo.headInfo, true)

	local playerId = checknumber(data.headInfo.headInfo.userId)
	local rank = self._rankInfoMap[playerId]

	if rank then
		txtTag.text = string.format("预测排名：%d", rank)

		tagChange:SetState(1)
	else
		txtTag.text = "未预测排名"

		tagChange:SetState(0)
	end
end

function TCKFinalsSelectView:_clearCell(cell)
	local head = goutil.findChild(cell.gameObject, "head")
	local btn = goutil.findChild(cell.gameObject, "btn")

	HeadItemController.instance:resetHeadCell(head)
	GameUtil.rmClickHandler(btn)
end

function TCKFinalsSelectView:_onClickSelect(data)
	local playerId = checknumber(data.headInfo.headInfo.userId)
	local oldRank = self._rankInfoMap[playerId]

	if oldRank then
		local text = string.format("是否将预测排名从%s切换成%s", oldRank, self._selectId)

		TipsFacade.instance:openPopupWindow("提示", text, function()
			self._rankInfoMap[playerId] = self._selectId

			self:_changeRank()
		end)
	else
		self._rankInfoMap[playerId] = self._selectId

		self:_changeRank()
	end
end

function TCKFinalsSelectView:_changeRank()
	local guessPlayerIds = {}

	for i = 1, #self._playerInfos do
		guessPlayerIds[i] = 0
	end

	for playerId, rank in pairs(self._rankInfoMap) do
		guessPlayerIds[rank] = playerId
	end

	TeenChampionKingController.instance:changeGuessRank(self._activityId, guessPlayerIds)
	self:close()
	FloatWordMgr.instance:show("修改成功")
end

function TCKFinalsSelectView:_onStepChange()
	local info = TeenChampionKingModel.instance:getGlobalInfo(self._activityId)
	local curStepCfg = TeenChampionKingConfig.instance:getStepCfgByStepId(self._activityId, (info or nil) and info.curStepId)

	if not (curStepCfg and curStepCfg.canGuss) then
		self:close()
	end
end

return TCKFinalsSelectView
