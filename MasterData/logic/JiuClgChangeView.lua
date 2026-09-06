-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jiuclg/view/JiuClgChangeView.lua

module("logic.extensions.jiuclg.view.JiuClgChangeView", package.seeall)

local JiuClgChangeView = class("JiuClgChangeView", ViewComponent)

function JiuClgChangeView:ctor()
	JiuClgChangeView.super.ctor(self)
end

function JiuClgChangeView:buildUI()
	JiuClgChangeView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")
	self._txtSure = self:getTxt("btnSure/txt")
	self.scrollerGo1 = self:getGo("tableview1")
	self.cellGo1 = self:getGo("tableview1/tablecell")
	self._empty1 = self:getGo("tableview1/empty")
	self._scrollList1 = ScrollerList.create(self.scrollerGo1, self.cellGo1, GameUtil.handler(self._updateCell1, self), GameUtil.handler(self._clearCell1, self))

	self._scrollList1:setCenterMode(true)

	self.scrollerGo2 = self:getGo("tableview2")
	self.cellGo2 = self:getGo("tableview2/tablecell")
	self._empty2 = self:getGo("tableview2/empty")
	self._scrollList2 = ScrollerList.create(self.scrollerGo2, self.cellGo2, GameUtil.handler(self._updateCell2, self), GameUtil.handler(self._clearCell2, self))

	self._scrollList2:setCenterMode(true)
end

function JiuClgChangeView:bindEvents()
	JiuClgChangeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function JiuClgChangeView:unbindEvents()
	JiuClgChangeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function JiuClgChangeView:onEnter()
	JiuClgChangeView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._phaseId = params[2]
	self._stageId = params[3]
	self._selectIndex = 0

	self:_initDefaultList()
	self:_reloadDataList()
	self.addGEvent(self, GlobalNotify.JiuClgExtremeFightConfirmRes, self._handleJiuClgExtremeFightConfirmRes, self)
end

function JiuClgChangeView:onExit()
	JiuClgChangeView.super.onExit(self)
	self._scrollList1:dispose()
	self._scrollList2:dispose()
end

function JiuClgChangeView:_handleJiuClgExtremeFightConfirmRes(status)
	local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	if isAoqiGodProcessType then
		local activityType = JiuClgController.instance:getActivityType()

		AoqiGodController.instance:doHandleChallengeFinishReady(activityType, self._activityId)
	end

	self:close()
end

function JiuClgChangeView:_onClickSure()
	local lockRaces = {}
	local nameList = {}

	for i, v in ipairs(self._lockPetList) do
		table.insert(lockRaces, v.raceId)

		local name = MaterialMgr.getMaterialsName(MatType.Pet, v.raceId)

		table.insert(nameList, name)
	end

	local text = langPara("是否确认锁定%s？确定后锁定精灵将不可上阵", table.concat(nameList, ","))

	local function okFunc()
		local activityId = self._activityId
		local confirmNum = JiuClgModel.instance:getExtremeConfirmNum(activityId)
		local save = true

		JiuClgAgent.instance:sendPM_JiuClgExtremeFightConfirmReq(activityId, confirmNum, save, lockRaces)
	end

	TipsFacade:openPopupWindow(lang("tip"), text, okFunc)
end

function JiuClgChangeView:_updateCell1(view, cell, data, tag)
	local btn = goutil.findChild(cell, "btn")
	local icon = goutil.findChild(cell, "btn/icon")
	local selectGo = goutil.findChild(cell, "btn/select")

	MaterialMgr.setIcon(icon, MatType.PET_SKIN, data.raceId)
	goutil.setActive(selectGo, data.isSelect)

	local index = cell.index + 1

	GameUtil.addClickHandler(btn, function()
		self:_selectPet(index)
	end)
end

function JiuClgChangeView:_clearCell1(cell)
	local btn = goutil.findChild(cell, "btn")
	local icon = goutil.findChild(cell, "btn/icon")

	GameUtil.rmClickHandler(btn)
	MaterialMgr.clearIcon(icon)
end

function JiuClgChangeView:_updateCell2(view, cell, data, tag)
	local btn = goutil.findChild(cell, "btn")
	local icon = goutil.findChild(cell, "btn/icon")
	local selectGo = goutil.findChild(cell, "btn/select")

	MaterialMgr.setIcon(icon, MatType.PET_SKIN, data.raceId)
	goutil.setActive(selectGo, data.isSelect)

	local index = cell.index + 1

	GameUtil.addClickHandler(btn, function()
		self:_changePet(index)
	end)
end

function JiuClgChangeView:_clearCell2(cell)
	local btn = goutil.findChild(cell, "btn")
	local icon = goutil.findChild(cell, "btn/icon")

	GameUtil.rmClickHandler(btn)
	MaterialMgr.clearIcon(icon)
end

function JiuClgChangeView:_initDefaultList()
	self._posList = JiuClgController.instance:getExtremePosList()
	self._allPetList = {}

	for i, petId in ipairs(self._posList) do
		if petId > 0 then
			local info = {}

			info.petId = petId

			local petMo = BagPetsController.instance:getPet(petId)

			info.raceId = petMo.raceId
			info.isSelect = false

			table.insert(self._allPetList, info)
		end
	end

	local needLockCount = JiuClgModel.instance:getExtremeNeedLockCount(self._activityId)

	self._lockPetList = {}
	self._leftPetList = {}

	for i, v in ipairs(self._allPetList) do
		if i <= needLockCount then
			table.insert(self._lockPetList, v)
		else
			table.insert(self._leftPetList, v)
		end
	end

	self:_printInfo()
end

function JiuClgChangeView:_printInfo()
	for i, v in ipairs(self._allPetList) do
		print("test 所有精灵JiuClgChangeView:_allPetList", i, v.petId)
	end

	for i, v in ipairs(self._lockPetList) do
		print("test 所有精灵JiuClgChangeView:_lockPetList", i, v.petId)
	end

	for i, v in ipairs(self._leftPetList) do
		print("test 所有精灵JiuClgChangeView:_leftPetList", i, v.petId)
	end
end

function JiuClgChangeView:_reloadDataList()
	printInfo("test _reloadDataList", #self._lockPetList, #self._leftPetList)
	self._scrollList1:reloadData(self._lockPetList)
	self._scrollList2:reloadData(self._leftPetList)
	goutil.setActive(self._empty1, #self._lockPetList <= 0)
	goutil.setActive(self._empty2, #self._leftPetList <= 0)
end

function JiuClgChangeView:_selectPet(index)
	printInfo("test JiuClgChangeView:_selectPet1", self._selectIndex, index)

	if index > 0 and self._selectIndex == index then
		return
	end

	local isSelect = false

	for i, v in ipairs(self._lockPetList) do
		if index == i then
			v.isSelect = not v.isSelect
			isSelect = v.isSelect
		else
			v.isSelect = false
		end
	end

	self._scrollList1:reloadData(self._lockPetList)

	for i, v in ipairs(self._leftPetList) do
		v.isSelect = isSelect
	end

	self._scrollList2:reloadData(self._leftPetList)

	self._selectIndex = isSelect and index or 0

	printInfo("test JiuClgChangeView:_selectPet2", self._selectIndex, isSelect)
	goutil.setActive(self._empty1, #self._lockPetList <= 0)
	goutil.setActive(self._empty2, #self._leftPetList <= 0)
end

function JiuClgChangeView:_changePet(index)
	printInfo("test JiuClgChangeView:_changePet1", self._selectIndex, index)

	if self._selectIndex > 0 then
		printInfo("test JiuClgChangeView:_changePet2", self._selectIndex, index)

		self._lockPetList[self._selectIndex].petId = self._leftPetList[index].petId
		self._lockPetList[self._selectIndex].raceId = self._leftPetList[index].raceId
		self._leftPetList[index].petId = self._lockPetList[self._selectIndex].petId
		self._leftPetList[index].raceId = self._lockPetList[self._selectIndex].raceId

		for i, v in ipairs(self._lockPetList) do
			v.isSelect = false
		end

		for i, v in ipairs(self._leftPetList) do
			v.isSelect = false
		end

		self._scrollList1:reloadData(self._lockPetList)
		self._scrollList2:reloadData(self._leftPetList)
		goutil.setActive(self._empty1, #self._lockPetList <= 0)
		goutil.setActive(self._empty2, #self._leftPetList <= 0)

		self._selectIndex = 0
	else
		TipsFacade.instance:openCommonTips("请先选中需要交换的精灵")
	end
end

return JiuClgChangeView
