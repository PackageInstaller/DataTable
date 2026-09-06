-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wudiclg/view/WuDiClgExtDetailView.lua

module("logic.extensions.wudiclg.view.WuDiClgExtDetailView", package.seeall)

local WuDiClgExtDetailView = class("WuDiClgExtDetailView", ViewComponent)

function WuDiClgExtDetailView:buildUI()
	WuDiClgExtDetailView.super.buildUI(self)

	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")

	local detailScrollerview = goutil.findChild(self.mainGO, "detailCol/detailScrollerview")
	local detailScrollercell = goutil.findChild(self.mainGO, "detailCol/detailScrollercell")

	self._petScrollercell = goutil.findChild(self.mainGO, "detailCol/petScrollercell")
	self._detailScrollList = ScrollerList.create(detailScrollerview, detailScrollercell, GameUtil.handler(self._updateDetailCell, self), GameUtil.handler(self._clearDetailCell, self))

	GameUtil.SetActive(self._petScrollercell, false)

	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
end

function WuDiClgExtDetailView:bindEvents()
	WuDiClgExtDetailView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function WuDiClgExtDetailView:unbindEvents()
	WuDiClgExtDetailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function WuDiClgExtDetailView:onEnter()
	WuDiClgExtDetailView.super.onEnter(self)

	self._activityId = WuDiClgController.instance:getActivityId()
	self._activityType = WuDiClgController.instance:getActivityType()

	local isInTime = WuDiClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actData = WuDiClgConfig.instance:getWdcActData(self._activityId)

	self.addGEvent(self, GlobalNotify.WuDiClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.WuDiClgExtremeFightConfirmRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.WuDiClgResetExtremeClgRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.WuDiClgGainExtremePrizeRes, self._onUpdate, self)
	self:_onUpdate()
end

function WuDiClgExtDetailView:onExit()
	WuDiClgExtDetailView.super.onExit(self)
	self:_clearDetailColUI()
end

function WuDiClgExtDetailView:_onUpdate()
	local cfg = WuDiClgConfig.instance:getWdcExtStageCfg(self._activityId)

	self._detailScrollList:reloadData(cfg)
end

function WuDiClgExtDetailView:_clearDetailColUI()
	self._detailScrollList:dispose()
end

function WuDiClgExtDetailView:_updateDetailCell(view, cell, data, tag)
	local stageId = data.stageId
	local mainGo = cell.gameObject
	local txtStage = goutil.findChildTextComponent(mainGo, "txtStage")
	local petScrollerview = goutil.findChild(mainGo, "petScrollerview")
	local noRecord = goutil.findChild(mainGo, "noRecord")

	txtStage.text = string.format("第%s关", stageId)

	local parentTran = petScrollerview.transform
	local childGo = self._petScrollercell
	local children = GameUtil.getChildren(parentTran)
	local infoList = WuDiClgModel.instance:getAttackInfoListOfExtStage(stageId)
	local length = #infoList

	for idx, info in ipairs(infoList) do
		local mainGo = children[idx]

		if mainGo == nil then
			mainGo = goutil.cloneAndSetParent(childGo, parentTran, string.format("%s_%s", childGo.name, idx))
		end

		self:_updatePetCell(mainGo, info)
	end

	for idx = 1, parentTran.childCount do
		local mainGo = parentTran:GetChild(idx - 1)

		GameUtil.SetActive(mainGo, idx <= length)
	end

	GameUtil.SetActive(noRecord, length <= 0)
end

function WuDiClgExtDetailView:_clearDetailCell(cell)
	local mainGo = cell.gameObject
	local petScrollerview = goutil.findChild(mainGo, "petScrollerview")
	local parentTran = petScrollerview.transform

	for idx = 1, parentTran.childCount do
		local go = parentTran:GetChild(idx - 1)

		self:_clearPetCell(go)
	end
end

function WuDiClgExtDetailView:_updatePetCell(mainGo, info)
	local raceId = info.raceId
	local groupAttackCount = info.groupAttackCount
	local item = goutil.findChild(mainGo, "item")
	local txtCount = goutil.findChildTextComponent(mainGo, "txtCount")

	txtCount.text = string.format("群攻：%s", groupAttackCount)

	local proxy = MaterialMgr.setCell(MatType.Pet, raceId, item)

	if proxy then
		local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, 1, 1, 0)

		local function func()
			CommonTipsMgr.instance:showPetTips(tmpMo, true)
		end

		proxy.binder:setClickCallBack(func)
	end
end

function WuDiClgExtDetailView:_clearPetCell(mainGo)
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function WuDiClgExtDetailView:_onClickBtnSure()
	self:close()
end

return WuDiClgExtDetailView
