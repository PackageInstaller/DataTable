-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/escort/view/EscortReportView.lua

module("logic.extensions.escort.view.EscortReportView", package.seeall)

local EscortReportView = class("EscortReportView", TableViewComponent)

function EscortReportView:ctor()
	EscortReportView.super.ctor(self)
end

function EscortReportView:bindEvents()
	self.viewCloseBtn:AddClickListener(self.close, self)
end

function EscortReportView:unbindEvents()
	self.viewCloseBtn:RemoveClickListener()
end

function EscortReportView:buildUI()
	EscortReportView.super.buildUI(self)

	self.titleNameTxt = goutil.findChildTextComponent(self.mainGO, "viewBgIma/titleNameTxt")
	self.viewCloseBtn = self:getBtn("viewBgIma/viewCloseBtn")
	self.noListGo = self:getGo("viewBgIma/noListGo")

	self.noListGo:SetActive(false)
end

function EscortReportView:onEnterFinished()
	EscortReportView.super.onEnterFinished(self)
end

function EscortReportView:onExitFinished()
	return
end

function EscortReportView:onExit()
	self._curViewDatas = nil

	GlobalDispatcher:removeListener("UpdataEscortReportList", self.UpdataBattleReportList, self)
end

function EscortReportView:destroyUI()
	return
end

function EscortReportView:onEnter()
	EscortReportView.super.onEnter(self)
	EscortModel.instance:SetEscortRedPoint("all", false)
	EscortController.instance:CSConvoyGetChallengeRecordReq()

	local wuziInfo = EscortModel.instance:GetHuowuGoodsInfo()

	self.wuziType = wuziInfo[1] and tonumber(wuziInfo[1]) or 4
	self.wuziId = wuziInfo[2] and tonumber(wuziInfo[2]) or 700

	self:UpdataBattleReportList()
	GlobalDispatcher:addListener("UpdataEscortReportList", self.UpdataBattleReportList, self)
end

function EscortReportView:UpdataBattleReportList()
	self:GetPlayerInfo()

	self._curViewDatas = EscortModel.instance:GetEscortReportList()

	self._tableview:ReloadData()

	if self._curViewDatas and #self._curViewDatas > 0 then
		self.noListGo:SetActive(false)
	else
		self.noListGo:SetActive(true)
	end
end

function EscortReportView:OnMoneyCountChange()
	self.coinCountTxt.text = MaterialModel.instance:getMaterialsNumber(MatType.Coin, 1)

	local num = RoleModel.instance:getPayDiamond() + RoleModel.instance:getPresentDiamond()

	self.diamondCountTxt.text = tostring(num)
end

function EscortReportView:GetPlayerInfo()
	self.ownName = RoleModel.instance:getUserName()
	self.ownLevel = MofangModel.instance:getCurLvAndExp()
	self.ownIconId = RoleModel.instance:getHeadIconId()
	self.ownFrameId = RoleModel.instance:getHeadFrameId()
end

function EscortReportView:_getPath()
	return {
		cellPath = "viewBgIma/itemGo",
		viewPath = "viewBgIma/itemListSR"
	}
end

function EscortReportView:_cellSize()
	return 1100, 115
end

function EscortReportView:_updateCell(view, cell, data)
	local reportTimeTxt = goutil.findChildTextComponent(cell, "reportTimeTxt")
	local wonResultTxt = goutil.findChildTextComponent(cell, "wonResultTxt")
	local wonHeadGo = goutil.findChild(cell, "wonHeadGo")
	local woLevelTxt = goutil.findChildTextComponent(cell, "woLevelIma/woLevelTxt")
	local wonStageIma = goutil.findChildComponent(cell, "wonStageIma", "UIImageSpriteChange")
	local wonNameTxt = goutil.findChildTextComponent(cell, "wonNameTxt")
	local wonPowerTxt = goutil.findChildTextComponent(cell, "wonPowerIma/wonPowerTxt")
	local otherHeadGo = goutil.findChild(cell, "otherHeadGo")
	local otherLevelTxt = goutil.findChildTextComponent(cell, "otherLevelIma/otherLevelTxt")
	local otherStageIma = goutil.findChildComponent(cell, "otherStageIma", "UIImageSpriteChange")
	local otherNameTxt = goutil.findChildTextComponent(cell, "otherNameTxt")
	local otherPowerTxt = goutil.findChildTextComponent(cell, "otherPowerIma/otherPowerTxt")
	local rewardDesTxt = goutil.findChildTextComponent(cell, "rewardDesTxt")
	local rewardGoodsPos = goutil.findChild(cell, "rewardGoodsPos")
	local huifangBtnGo = goutil.findChild(cell, "huifangBtn")

	if data.warTimer > 0 then
		local timeStr = GameUtil.time2date(data.warTimer / 1000)
		local minStr = tostring(timeStr.min)
		local hourStr = tostring(timeStr.hour)

		reportTimeTxt.text = string.format("%s月%s日 %s:%s", timeStr.month, timeStr.day, (timeStr.hour < 10 or nil) and "0" .. timeStr.hour, (timeStr.min < 10 or nil) and "0" .. timeStr.min)
	else
		reportTimeTxt.text = tostring(data.warTimer)
	end

	wonResultTxt.text = data.isWin and "胜利" or "失败"

	HeadItemController.instance:setMyHeadCell(wonHeadGo)

	woLevelTxt.text = tostring(data.ownLevel)
	wonNameTxt.text = self.ownName
	wonPowerTxt.text = "战斗力：" .. data.ownPower

	HeadItemController.instance:setHeadCellByInfo(otherHeadGo, data.headInfo)

	if data.isAtt then
		wonStageIma:SetState(0)
		otherStageIma:SetState(1)
	else
		wonStageIma:SetState(1)
		otherStageIma:SetState(0)
	end

	otherLevelTxt.text = tostring(data.userLevel)
	otherNameTxt.text = data.userName
	otherPowerTxt.text = "战斗力：" .. data.userPower
	rewardDesTxt.text = data.wuziDes

	if data.daiBiNum == 0 then
		rewardDesTxt.alignment = UnityEngine.TextAnchor.MiddleCenter

		rewardGoodsPos:SetActive(false)
	else
		rewardDesTxt.alignment = UnityEngine.TextAnchor.UpperLeft

		rewardGoodsPos:SetActive(true)

		local goodsInfo = string.split(data.wuziStr, ":")
		local hwLua = MaterialMgr.setCell(self.wuziType, self.wuziId, rewardGoodsPos)

		GameUtil.setLocalScale(hwLua.view, 0.8, 0.8, 0.8)
		Framework.TransformUtil.SetLocalPos(hwLua.view.transform, 0, 0, 0)
		hwLua.binder:setNum(data.daiBiNum)
	end

	local index = cell.index

	GameUtil.asBtn(huifangBtnGo):AddClickListener(function()
		UIJumper.instance:saveCurStack()
		EscortController:CSConvoyGetChallengeVideoReq(index)
		self:close()
	end, self)
end

return EscortReportView
