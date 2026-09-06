-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKBattleResultView.lua

module("logic.extensions.teenchampionking.view.TCKBattleResultView", package.seeall)

local TCKBattleResultView = class("TCKBattleResultView", ViewComponent)

function TCKBattleResultView:ctor()
	TCKBattleResultView.super.ctor(self)
end

function TCKBattleResultView:unbindEvents()
	TCKBattleResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function TCKBattleResultView:bindEvents()
	TCKBattleResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function TCKBattleResultView:buildUI()
	TCKBattleResultView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local cellGo = self:getGo("cell")
	local tableviewGo = self:getGo("tableview")

	self._tableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._empty = self:getGo("goEmpty")
end

function TCKBattleResultView:onExit()
	TCKBattleResultView.super.onExit(self)
	self._tableview:dispose()
end

function TCKBattleResultView:onEnter()
	TCKBattleResultView.super.onEnter(self)

	local params = self:getOpenParam()

	if params then
		if not params[1] then
			local curDataList = {}

			self._tableview:reloadData(curDataList)
			goutil.setActive(self._empty, #curDataList <= 0)
			self.addGEvent(self, GlobalNotify.PM_TCKGetVideoRes, self._handleGetBattleVideo, self)
			self.addGEvent(self, GlobalNotify.PM_TCKGetVideoError, self._handleGetBattleVideoError, self)
		end
	end
end

function TCKBattleResultView:_updateCell(view, cellGo, data)
	local cell = self:_clearCell(cellGo)

	GameUtil.addClickHandler(cell.btnVideo, GameUtil.handler(self._onClickPlayVideo, self, data.battleId))
	cell.imgResult:SetState(data.isLeftWin and 0 or 1)

	cell.txtStep.text = data.showTxt
	cell.leftPart.txtZdl.text = data.leftZdl
	cell.leftPart.txtZdl.text = string.format("战力:<color=#20B376FF>%s</color>", data.leftZdl)

	if data.leftHeadInfo then
		HeadItemController.instance:setHeadCellByInfo(cell.leftPart.head, data.leftHeadInfo)

		cell.leftPart.txtName.text = data.leftHeadInfo.userName
	else
		HeadItemController.instance:setMyHeadCell(cell.leftPart.head)

		cell.leftPart.txtName.text = RoleModel.instance:getUserName()
	end

	local addStore = checknumber(data.incScore)

	cell.txtAdd.text = (data.stepId == TeenChampionKingController.EntertainmentStepId or data.stepId == TeenChampionKingController.EntertainmentStartStepId) and string.format("积分:<color=#20B376FF>+%s</color>", addStore) or ""
	cell.rightPart.txtZdl.text = string.format("战力:<color=#20B376FF>%s</color>", data.rightZdl)

	if data.rightHeadInfo then
		HeadItemController.instance:setHeadCellByInfo(cell.rightPart.head, data.rightHeadInfo)

		cell.rightPart.txtName.text = data.rightHeadInfo.userName
	else
		HeadItemController.instance:setMyHeadCell(cell.rightPart.head)

		cell.rightPart.txtName.text = RoleModel.instance:getUserName()
	end
end

function TCKBattleResultView:_clearCell(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.go = cellGo
	cell.btnVideo = goutil.findChild(cell.go, "btnVideo")

	GameUtil.rmClickHandler(cell.btnVideo)

	cell.imgResult = goutil.findChildComponent(cell.go, "imgResult", "UIImageSpriteChange")
	cell.txtStep = goutil.findChildTextComponent(cell.go, "txtStep")
	cell.leftPart = self:_getPlayerPart(goutil.findChild(cell.go, "left"))
	cell.txtAdd = goutil.findChildTextComponent(cell.leftPart.go, "txtAdd")

	HeadItemController.instance:resetHeadCell(cell.leftPart.head)

	cell.rightPart = self:_getPlayerPart(goutil.findChild(cell.go, "right"))

	HeadItemController.instance:resetHeadCell(cell.rightPart.head)

	return cell
end

function TCKBattleResultView:_getPlayerPart(partGo)
	local partCell = {}

	partCell.go = partGo
	partCell.head = goutil.findChild(partCell.go, "head")
	partCell.txtName = goutil.findChildTextComponent(partCell.go, "txtName")
	partCell.txtZdl = goutil.findChildTextComponent(partCell.go, "txtZdl")

	return partCell
end

function TCKBattleResultView:_onClickPlayVideo(battleId)
	if checknumber(battleId) <= 0 then
		TipsFacade.instance:openCommonTips("战斗记录已过期")

		return
	end

	TeenChampionKingController.instance:playBattleVideo(battleId)
end

function TCKBattleResultView:_handleGetBattleVideo(handle)
	UIJumper.instance:clear()
	UIJumper.instance:pushOneStack(ViewName.TeenChampionKingMainView, nil)

	if handle then
		handle()
	end
end

function TCKBattleResultView:_handleGetBattleVideoError(status)
	if status == -526 or status == -47 then
		TipsFacade.instance:openCommonTips("战斗记录已过期")
	end
end

return TCKBattleResultView
