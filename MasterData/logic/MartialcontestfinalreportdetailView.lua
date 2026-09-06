-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialcontestfinalreportdetailView.lua

module("logic.extensions.martialcontest.view.MartialcontestfinalreportdetailView", package.seeall)

local MartialcontestfinalreportdetailView = class("MartialcontestfinalreportdetailView", ViewComponent)

function MartialcontestfinalreportdetailView:unbindEvents()
	MartialcontestfinalreportdetailView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function MartialcontestfinalreportdetailView:bindEvents()
	MartialcontestfinalreportdetailView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function MartialcontestfinalreportdetailView:onExit()
	MartialcontestfinalreportdetailView.super.onExit(self)

	for _, v in ipairs(self._pointHeads) do
		MaterialMgr.resetAll(v)
	end

	self._pointHeads = nil

	self._scrollerListLeft:dispose()
	self._scrollerListRight:dispose()
end

function MartialcontestfinalreportdetailView:buildUI()
	MartialcontestfinalreportdetailView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._players = self:getGo("players")
	self._threeFormsGo = self:getGo("tableview/viewport/threeForms")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "txtTime")
	self._buffcellGo = self:getGo("buffcell")
	self._tableviewleftGo = self:getGo("tableviewleft")
	self._tableviewrightGo = self:getGo("tableviewright")
	self._scrollerListLeft = ScrollerList.create(self._tableviewleftGo, self._buffcellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._scrollerListRight = ScrollerList.create(self._tableviewrightGo, self._buffcellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtEmptyRightGo = self:getGo("txtEmptyRight")
	self._txtEmptyLeftGo = self:getGo("txtEmptyLeft")
end

function MartialcontestfinalreportdetailView:onEnter()
	MartialcontestfinalreportdetailView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.MCFinalsResultRes, self._onMCFinalsResultRes, self)
	self.addGEvent(self, GlobalNotify.PM_MCGetBattleVideoRes, self._viewVideo, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._stepId = params[2]
	self._groupId = params[3]
	self._pointHeads = {}

	MartialContestAgent.instance:sendPM_MCFinalsResultReq(self._activityId, self._stepId, self._groupId)
end

function MartialcontestfinalreportdetailView:_onClickVideo(battleId)
	print("click battleId = " .. battleId)
	UIJumper.instance:saveCurStack()
	MartialContestAgent.instance:sendPM_MCGetBattleVideoReq(battleId)
end

function MartialcontestfinalreportdetailView:_viewVideo(handle)
	if handle then
		handle()
	end
end

function MartialcontestfinalreportdetailView:_onMCFinalsResultRes(msg)
	self._formIdx = 0

	GameUtil.updateCells(self._players, {
		msg.playerA,
		msg.playerB
	}, self._updateOnePlayer, self)
	GameUtil.updateCells(self._threeFormsGo, msg.battles or {}, self._updateOneForms, self, true)

	local stepCfg = MartialContestConfig.instance:getStepCfg(msg.activityId, msg.stepId)
	local date = GameUtil.string2date(stepCfg.startTime)

	self._txtTime.text = string.format("%02d月%02d日  %02d:%02d", date.month, date.day, date.hour, date.min)

	self._scrollerListLeft:reloadData(msg.buffIdsA)
	self._scrollerListRight:reloadData(msg.buffIdsB)
	goutil.setActive(self._txtEmptyLeftGo, #msg.buffIdsA == 0)
	goutil.setActive(self._txtEmptyRightGo, #msg.buffIdsB == 0)
end

function MartialcontestfinalreportdetailView:_updateOnePlayer(cell, data)
	local pointHead = goutil.findChild(cell, "pointHead")
	local txtUserName = goutil.findChildTextComponent(cell, "txtUserName")
	local headInfo = data.headInfo

	HeadItemController.instance:setHeadCellByInfo(pointHead, headInfo)

	txtUserName.text = headInfo.userName

	table.insert(self._pointHeads, pointHead)
end

function MartialcontestfinalreportdetailView:_updateOneForms(cell, data)
	self._formIdx = self._formIdx + 1

	local leftForm = goutil.findChild(cell, "leftForm")
	local rightForm = goutil.findChild(cell, "rightForm")
	local btnVideo = Framework.ButtonAdapter.GetFrom(cell, "btnVideo")

	self._isLeft = true

	self:_updateOneForm(leftForm, self._formIdx, data.teamARaceIds, data.isTeamAWin, data.teamAZdl)

	self._isLeft = false

	self:_updateOneForm(rightForm, self._formIdx, data.teamBRaceIds, not data.isTeamAWin, data.teamBZdl)
	btnVideo:AddClickListener(function()
		self:_onClickVideo(data.battleId)
	end)
end

function MartialcontestfinalreportdetailView:_updateOneForm(cell, formId, raceIds, isWin, power)
	local txtTotalForce = goutil.findChildTextComponent(cell, "txtTotalForce")
	local txtTeam = goutil.findChildTextComponent(cell, "txtTeam")
	local pets = goutil.findChild(cell, "formations")
	local txtWin = goutil.findChild(cell, "txtWin")
	local txtFail = goutil.findChild(cell, "txtFail")

	goutil.setActive(txtWin, isWin)
	goutil.setActive(txtFail, not isWin)

	txtTeam.text = "队伍" .. formId
	txtTotalForce.text = power

	GameUtil.updateCells(pets, raceIds, self._updateOnePet, self)
end

function MartialcontestfinalreportdetailView:_updateOnePet(cell, raceId)
	local txtForce = goutil.findChildTextComponent(cell, "force/txtForce")
	local pointPet = goutil.findChild(cell, "pointPet")

	MaterialMgr.resetAll(pointPet)

	txtForce.text = "0"

	if raceId then
		local proxy = MaterialMgr.setCell(MatType.Pet, raceId, pointPet)

		table.insert(self._pointHeads, pointPet)

		if proxy then
			proxy.binder:setClickCallBack(function()
				CommonTipsMgr.instance:showMaxLvlPetTips(raceId)
			end)
			proxy.binder:setIconDirection(self._isLeft)
		end
	end
end

function MartialcontestfinalreportdetailView:_updateCell(view, cell, buffId, tag)
	local btnIcon = Framework.ButtonAdapter.Get(cell.gameObject)

	uGuiUtil.clearImage(btnIcon.gameObject)

	local buffCfg = MartialContestConfig.instance:getFinalsBuffCfg(self._activityId, buffId)
	local spriteName = GameUrl.getExpEventUrl(buffCfg.icon)

	uGuiUtil.setSpriteToImage(btnIcon.gameObject, nil, spriteName)
	btnIcon:AddClickListener(function()
		local data = MartialContestConfig.instance:getBuffTipSimpleData(self._activityId, buffCfg.buffId)

		CommonTipsMgr.instance:openBuffTipView(data, cell.gameObject)
	end)
end

function MartialcontestfinalreportdetailView:_clearCell(cell)
	uGuiUtil.clearImage(cell.gameObject)
end

return MartialcontestfinalreportdetailView
