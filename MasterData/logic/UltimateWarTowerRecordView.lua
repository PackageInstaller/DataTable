-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimateWarTowerRecordView.lua

module("logic.extensions.ultimatewar.view.UltimateWarTowerRecordView", package.seeall)

local UltimateWarTowerRecordView = class("UltimateWarTowerRecordView", ViewComponent)

function UltimateWarTowerRecordView:buildUI()
	UltimateWarTowerRecordView.super.buildUI(self)

	self._rankScrView = self:getGo("rankScrView")
	self._rankScrCell = self:getGo("rankScrCell")
	self._emptyGo = self:getGo("emptyGo")
	self._rankScrollList = ScrollerList.create(self._rankScrView, self._rankScrCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._itemScrCell = self:getGo("itemScrCell")
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrCell, false)

	self._btnClose = self:getGo("leftTop/btnClose")
end

function UltimateWarTowerRecordView:bindEvents()
	UltimateWarTowerRecordView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function UltimateWarTowerRecordView:unbindEvents()
	UltimateWarTowerRecordView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function UltimateWarTowerRecordView:onEnter()
	UltimateWarTowerRecordView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._rankType = UltimateWarEnum.RankType_TowerBoss

	local isInTime = UltimateWarController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._ultimateWarMo = UltimateWarController.instance:getUltimateWarMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarRecordRes, self._onUpdate, self)
	UltimateWarController.instance:sendPM_UltimateWarRecordReq(self._activityId)
	self:_onUpdate()
end

function UltimateWarTowerRecordView:onExit()
	UltimateWarTowerRecordView.super.onExit(self)
	self._rankScrollList:dispose()
end

function UltimateWarTowerRecordView:_onUpdate()
	local recordList = self._ultimateWarMo:getTowerRecordList()

	GameUtil.SetActive(self._emptyGo, #recordList <= 0)
	self._rankScrollList:reloadData(recordList)
end

function UltimateWarTowerRecordView:_updateRankCell(view, cell, record, tag)
	local headInfo = record:getHeadInfo()
	local player = record:getPlayer()
	local damage = record:getDamage()
	local mainGo = cell.gameObject
	local headRoot = goutil.findChild(mainGo, "headRoot")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtPower = goutil.findChildTextComponent(mainGo, "txtPower")
	local txtTime = goutil.findChildTextComponent(mainGo, "txtTime")
	local txtDamage = goutil.findChildTextComponent(mainGo, "txtDamage")
	local btnFmt = goutil.findChild(mainGo, "btnFmt")
	local itemScrView = goutil.findChild(mainGo, "itemScrView")

	txtName.text = headInfo.userName
	txtPower.text = player.zdl
	txtDamage.text = damage

	HeadItemController.instance:setHeadCellByInfo(headRoot, headInfo, true)

	local list = {}
	local petZdlList = player.petZdlList
	local petInfos = player.petInfos

	for i, petInfo in ipairs(petInfos) do
		local petMo = BagPetMo.New()

		petMo:initBaseView(petInfo)

		for i, _petZdl in ipairs(petZdlList or {}) do
			if _petZdl.petId == petInfo.petId then
				petMo._zdl = _petZdl.zdl

				break
			end
		end

		table.insert(list, petMo)
	end

	if not self._itemScrollListDic[mainGo] then
		local itemScrollList = ScrollerList.create(itemScrView, self._itemScrCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

		self._itemScrollListDic[mainGo] = self._itemScrollListDic[mainGo]

		self._itemScrollListDic[mainGo]:reloadData(list)
		self._itemScrollListDic[mainGo]:dragNotifyParent()
		GameUtil.addClickHandler(btnFmt, function()
			self._ultimateWarMo:setRecordSimpleTemp(player)
			self:close()
			UltimateWarController.instance:enterBattleTowerBoss(self._activityId)
		end)
	end
end

function UltimateWarTowerRecordView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local headRoot = goutil.findChild(mainGo, "headRoot")
	local btnFmt = goutil.findChild(mainGo, "btnFmt")

	HeadItemController.instance:resetHeadCell(headRoot)

	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end

	GameUtil.rmClickHandler(btnFmt)
end

function UltimateWarTowerRecordView:_updateItemCell(view, cell, petMo, tag)
	local mainGo = cell.gameObject
	local proxy = MaterialMgr.setCellByData(MatType.Pet, petMo, mainGo)

	if proxy then
		proxy.binder:setCallBack(function()
			CommonTipsMgr.instance:showPetTips(petMo)
		end)
	end
end

function UltimateWarTowerRecordView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return UltimateWarTowerRecordView
