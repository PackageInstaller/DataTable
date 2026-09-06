-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/view/KindergartefacilityView.lua

module("logic.extensions.kindergarten.view.KindergartefacilityView", package.seeall)

local KindergartefacilityView = class("KindergartefacilityView", ViewComponent)

function KindergartefacilityView:ctor()
	KindergartefacilityView.super.ctor(self)
end

function KindergartefacilityView:unbindEvents()
	KindergartefacilityView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnTip)
end

function KindergartefacilityView:bindEvents()
	KindergartefacilityView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function KindergartefacilityView:buildUI()
	KindergartefacilityView.super.buildUI(self)

	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnClose = self:getBtn("btnClose")
	self._goldBarCon = self:getGo("goldBar")
	self._txtTitle = self:getTxt("txtTitle")
	self._btnTip = self:getGo("btnTip")
end

function KindergartefacilityView:onExit()
	KindergartefacilityView.super.onExit(self)
	self._scrollerList:dispose()
end

function KindergartefacilityView:onEnter()
	KindergartefacilityView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.KindergartenUnlockFacilityRes, self._updateUI, self)

	self._activityId = KindergartenModel.instance:getActivityId()
	self._selectIndex = checknumber(self:getFirstParam())

	local roomCfg = KindergartenConfig.instance:getClassRoomCfg(self._activityId, self._selectIndex)

	self._facilityCfgs = KindergartenConfig.instance:getFacilityPlanCfgs(roomCfg.facilityPlanId)
	self._info = KindergartenModel.instance:getInfo(self._activityId)
	self._txtTitle.text = roomCfg.desc

	self:_setTopGoldBar()
	self:_updateUI()
	self:_initView()
end

function KindergartefacilityView:_initView()
	if not KindergartenModel.instance:getFirstIntoCourse(self._activityId) then
		self:_onClickTip()
		KindergartenModel.instance:saveFirstIntoCourse(self._activityId)
	end
end

function KindergartefacilityView:_updateUI()
	self._kindergartenLv = KindergartenController.instance:getGartenLevel(self._activityId)
	self._unlockId = KindergartenController.instance:getFaciltyUnlockId(self._activityId, self._selectIndex)

	local list = {}

	table.insertto(list, self._facilityCfgs)

	list = self:_sortFacilityCfgs(list)

	self._scrollerList:reloadData(list)
end

function KindergartefacilityView:_updateCell(view, cell, cfg, tag)
	local btnUnlock = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnUnlock")
	local txtBtnUnlock = goutil.findChildTextComponent(cell.gameObject, "btnUnlock/txt")
	local txtAddScore = goutil.findChildTextComponent(cell.gameObject, "txtAddScore")
	local cost = goutil.findChild(cell.gameObject, "cost")
	local txtCost = goutil.findChildTextComponent(cost, "txtCost")
	local costCon = goutil.findChild(cost, "txtCost/con")
	local lockTip = goutil.findChild(cell.gameObject, "lockTip")
	local txtLockTip = goutil.findChildTextComponent(lockTip, "txtLockTip")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local imgCon = goutil.findChild(cell.gameObject, "imgCon")
	local imgRes = imgCon:GetComponent(goutil.Type_UIImage)
	local gainGo = goutil.findChild(cell.gameObject, "gainGo")
	local txtClassRoomLevel = goutil.findChildTextComponent(cell.gameObject, "txtClassRoomLevel")
	local matType, id, costNum = MaterialMgr.getMatParams(cfg.cost)
	local isUnlock = KindergartenController.instance:isFacilityUnlock(self._activityId, self._selectIndex, cfg.facilityId)
	local lvLimit = cfg.kindergartenLvLimit > self._kindergartenLv
	local lvLimitTip = ""

	txtName.text = cfg.desc
	txtCost.text = costNum

	MaterialMgr.setIcon(costCon, matType, id)

	local strAddScore = "可分配的"

	if cfg.strengthPoint > 0 then
		strAddScore = strAddScore .. string.format("总体力点+%s ", cfg.strengthPoint)
	end

	if cfg.artPoint > 0 then
		strAddScore = strAddScore .. string.format("总艺术点+%s ", cfg.artPoint)
	end

	if cfg.intellectPoint > 0 then
		strAddScore = strAddScore .. string.format("总智力点+%s ", cfg.intellectPoint)
	end

	txtAddScore.text = strAddScore
	txtBtnUnlock.text = isUnlock and "已激活" or "解锁"

	GameUtil.SetActive(gainGo, isUnlock)
	GameUtil.SetActive(btnUnlock, not isUnlock and cfg.facilityId == self._unlockId + 1)
	GameUtil.SetActive(lockTip, lvLimit)
	GameUtil.SetActive(cost, not lvLimit and not isUnlock and cfg.facilityId == self._unlockId + 1)

	if lvLimit then
		lvLimitTip = string.format("幼儿园达到%s级后可解锁", cfg.kindergartenLvLimit)
		txtLockTip.text = lvLimitTip
	end

	uGuiUtil.setSpriteToImage(imgCon, nil, GameUrl.getBigbgFolderUrl("aoqiyoueryuan", cfg.imgRes), function()
		if imgRes then
			imgRes:SetNativeSize()
		end
	end)
	btnUnlock:AddClickListener(function()
		if isUnlock then
			FloatWordMgr.instance:show("已激活")

			return
		end

		local hasNum = MaterialFacade.instance:getMatNumber(matType, id)

		if hasNum < costNum then
			FloatWordMgr.instance:show("数量不足，去完成成就任务获得吧~")

			return
		end

		if lvLimit then
			FloatWordMgr.instance:show(lvLimitTip)

			return
		end

		KindergartenAgent.instance:sendPM_KindergartenUnlockFacilityReq(self._activityId, self._selectIndex)
	end)

	if not isUnlock and self._facilityCfgs[cfg.facilityId - 1] and self._facilityCfgs[cfg.facilityId - 1].classroomLv ~= cfg.classroomLv or cfg.facilityId == 1 and self._facilityCfgs[cfg.facilityId].classroomLv ~= KindergartenController.instance:getClassRoomLevel(self._activityId, self._selectIndex) then
		txtClassRoomLevel.text = langPara("解锁该设施后，本教室等级可达到%d级", cfg.classroomLv)

		GameUtil.SetActive(txtClassRoomLevel, true)
	else
		GameUtil.SetActive(txtClassRoomLevel, false)
	end
end

function KindergartefacilityView:_clearCell(cell)
	local costCon = goutil.findChild(cell.gameObject, "cost/txtCost/con")
	local imgCon = goutil.findChild(cell.gameObject, "imgCon")

	uGuiUtil.clearImage(imgCon)
	MaterialMgr.resetAll(costCon)
end

function KindergartefacilityView:_sortFacilityCfgs(list)
	local notSortList = {}
	local sortList = {}

	for i, v in ipairs(list) do
		local isUnlock = KindergartenController.instance:isFacilityUnlock(self._activityId, self._selectIndex, v.facilityId)

		if isUnlock then
			table.insert(notSortList, v)
		else
			table.insert(sortList, v)
		end
	end

	table.insertto(sortList, notSortList)

	return sortList
end

function KindergartefacilityView:_onClickbtnClose()
	self:close()
end

function KindergartefacilityView:_onClickTip()
	TipsFacade.instance:openRulesView("kindergarte_course_rule")
end

function KindergartefacilityView:_setTopGoldBar()
	local btn_list = {}
	local activityCfg = KindergartenConfig.instance:getActCfg(self._activityId)
	local arr = string.split(activityCfg.showMat, "#")

	for i, v in ipairs(arr) do
		table.insert(btn_list, {
			showAdd = false,
			id = v
		})
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

return KindergartefacilityView
