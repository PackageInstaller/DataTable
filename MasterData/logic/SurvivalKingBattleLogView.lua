-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalking/view/SurvivalKingBattleLogView.lua

module("logic.extensions.survivalking.view.SurvivalKingBattleLogView", package.seeall)

local SurvivalKingBattleLogView = class("SurvivalKingBattleLogView", ViewComponent)

function SurvivalKingBattleLogView:ctor()
	SurvivalKingBattleLogView.super.ctor(self)
end

function SurvivalKingBattleLogView:unbindEvents()
	SurvivalKingBattleLogView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function SurvivalKingBattleLogView:bindEvents()
	SurvivalKingBattleLogView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function SurvivalKingBattleLogView:buildUI()
	SurvivalKingBattleLogView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local cellGo = self:getGo("tableview/tablecell")
	local tableviewGo = self:getGo("tableview")

	self._tableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._empty = self:getGo("goEmpty")
end

function SurvivalKingBattleLogView:onExit()
	SurvivalKingBattleLogView.super.onExit(self)
	self._tableview:dispose()
end

function SurvivalKingBattleLogView:onEnter()
	SurvivalKingBattleLogView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 529001
	end

	self.addGEvent(self, GlobalNotify.SurvivalKingGetBattleRecord, self._handleGetInfo, self)
	self:_handleGetInfo()
	SurvivalKingController.instance:getBattleRecord(self._activityId)
end

function SurvivalKingBattleLogView:_updateCell(view, cell, data)
	local txtStep = goutil.findChildTextComponent(cell.gameObject, "txtStep")
	local sessionId = checknumber(data.sessionId)
	local sessionCfg = SurvivalKingConfig.instance:getSessionCfg(self._activityId, sessionId)

	txtStep.text = sessionCfg and (sessionCfg.sessionName or "") or ""

	local btnVideo = goutil.findChild(cell.gameObject, "btnVideo")

	GameUtil.addClickHandler(btnVideo, GameUtil.handler(self._onClickPlayVideo, self, data.recordId))

	local imgResult = goutil.findChildComponent(cell.gameObject, "imgResult", "UIImageSpriteChange")

	imgResult:SetState(data.isWin and 0 or 1)

	local leftPart = self:_getPlayerPart(goutil.findChild(cell.gameObject, "left"))

	leftPart.txtHp.text = not data.isWin and "<color=#eb4642>0%</color>" or string.format("<color=#20b376>%d%%</color>", data.myLeftHp * 100)

	local buffCfg = self:_getBuffCfg(data, "my")

	if buffCfg then
		goutil.setActive(leftPart.itemBuff, true)

		leftPart.txtNameBuff.text = buffCfg.name

		local iconPath = string.format("%s.png", buffCfg.iconUrl)

		uGuiUtil.setSpriteToImage(leftPart.itemBuff, uGuiUtil.SpriteType.BigBg, iconPath)
	else
		leftPart.txtNameBuff.text = "未使用"

		goutil.setActive(leftPart.itemBuff, false)
	end

	HeadItemController.instance:setMyHeadCell(leftPart.head)

	leftPart.txtName.text = RoleModel.instance:getUserName()

	local rightPart = self:_getPlayerPart(goutil.findChild(cell.gameObject, "right"))
	local opUserId = checknumber(data.opHeadInfo.userId)

	if opUserId <= 0 then
		rightPart.empty:SetActive(true)
		rightPart.info:SetActive(false)

		rightPart.txtHp.text = "<color=#eb4642>0%</color>"
	else
		rightPart.empty:SetActive(false)
		rightPart.info:SetActive(true)
		HeadItemController.instance:setHeadCellByInfo(rightPart.head, data.opHeadInfo)

		rightPart.txtName.text = data.opHeadInfo.userName
		rightPart.txtHp.text = data.isWin and "<color=#eb4642>0%</color>" or string.format("<color=#20b376>%d%%</color>", data.opLeftHp * 100)
	end

	local opBuffCfg = self:_getBuffCfg(data, "op")

	if opBuffCfg then
		goutil.setActive(rightPart.itemBuff, true)

		rightPart.txtNameBuff.text = opBuffCfg.name

		local iconPath = string.format("%s.png", opBuffCfg.iconUrl)

		uGuiUtil.setSpriteToImage(rightPart.itemBuff, uGuiUtil.SpriteType.BigBg, iconPath)
	else
		rightPart.txtNameBuff.text = "未使用"

		goutil.setActive(rightPart.itemBuff, false)
	end

	goutil.setActive(btnVideo, opUserId > 0)
end

function SurvivalKingBattleLogView:_clearCell(cell)
	local btnVideo = goutil.findChild(cell.gameObject, "btnVideo")

	GameUtil.rmClickHandler(btnVideo)

	local leftPart = self:_getPlayerPart(goutil.findChild(cell.gameObject, "left"))
	local rightPart = self:_getPlayerPart(goutil.findChild(cell.gameObject, "right"))

	HeadItemController.instance:resetHeadCell(leftPart.head)
	HeadItemController.instance:resetHeadCell(rightPart.head)
	uGuiUtil.clearImage(leftPart.itemBuff)
	uGuiUtil.clearImage(rightPart.itemBuff)
end

function SurvivalKingBattleLogView:_handleGetInfo()
	local curDataList = {}
	local recordinfo = SurvivalKingModel.instance:getBattleRecordInfo(self._activityId)

	if recordinfo then
		if not recordinfo.logItems then
			for i, v in ipairs(recordinfo.logItems) do
				table.insert(curDataList, v)
			end

			ArraySort.sortOn(curDataList, {
				function(a)
					return a.sessionId
				end
			}, {
				ArraySort.DESCENDING
			})
		end
	end

	self._tableview:reloadData(curDataList)
	goutil.setActive(self._empty, #curDataList <= 0)
end

function SurvivalKingBattleLogView:_getPlayerPart(partGo)
	local partCell = {}

	partCell.go = partGo
	partCell.txtHp = goutil.findChildTextComponent(partCell.go, "txtHp")
	partCell.empty = goutil.findChild(partCell.go, "empty")
	partCell.info = goutil.findChild(partCell.go, "info")
	partCell.head = goutil.findChild(partCell.go, "info/head")
	partCell.txtName = goutil.findChildTextComponent(partCell.go, "info/txtName")
	partCell.itemBuff = goutil.findChild(partCell.go, "info/buff/item")
	partCell.txtNameBuff = goutil.findChildTextComponent(partCell.go, "info/buff/txtName")

	return partCell
end

function SurvivalKingBattleLogView:_onClickPlayVideo(recordId)
	if checknumber(recordId) <= 0 then
		TipsFacade.instance:openCommonTips("战斗记录已过期")

		return
	end

	SurvivalKingController.instance:getBattleDetail(self._activityId, recordId)
end

function SurvivalKingBattleLogView:_getBuffCfg(data, side)
	local buffId = side == "my" and checknumber(data.myEffectBuffId) or checknumber(data.opEffectBuffId)

	if buffId > 0 then
		return SurvivalKingConfig.instance:getBuffCfgById(self._activityId, buffId)
	end

	return nil
end

return SurvivalKingBattleLogView
