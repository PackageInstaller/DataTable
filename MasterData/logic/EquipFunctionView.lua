-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/EquipFunctionView.lua

module("logic.extensions.petequip.view.EquipFunctionView", package.seeall)

local EquipFunctionView = class("EquipFunctionView", ViewComponent)
local EQUIP_STRENGTH_INDEX = 1
local EQUIP_TUPO_INDEX = 2

function EquipFunctionView:ctor()
	EquipFunctionView.super.ctor(self)

	self._tabItemList = nil
	self._tabInfos = nil
	self._curIndex = nil
end

function EquipFunctionView:bindEvents()
	EquipFunctionView.super.bindEvents(self)
	self._closeBtn:AddClickListener(function()
		DoubleElevenModel.instance.mainTabIndex = nil

		PetEquipController.instance:setCurrentEquipInfoMo()
		UIStateManager.instance:popByName(self._viewPresentor.viewName)
	end, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "equipfunction")
	end, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
end

function EquipFunctionView:unbindEvents()
	EquipFunctionView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()

	for _, item in pairs(self._entranceItemList or {}) do
		if item and item.itemBtn then
			item.itemBtn:RemoveClickListener()
		end
	end

	GameUtil.rmClickHandler(self._btnOneKey)
end

function EquipFunctionView:onExit()
	EquipFunctionView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.DE_UpdataDoubleElevenRed, self._updataTabItemRedPoint, self)

	for _, item in pairs(self._tabItemList or {}) do
		if item and item.itemGo then
			GameUtil.SetActive(item.itemGo, false)
		end
	end

	self._curIndex = nil
end

function EquipFunctionView:destroyUI()
	EquipFunctionView.super.destroyUI(self)

	for _, item in pairs(self._tabItemList or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self._tabItemList = nil
end

function EquipFunctionView:buildUI()
	EquipFunctionView.super.buildUI(self)

	self._subParentGo = self:getGo("subParentGo")
	self._goldBarCon = self:getGo("goldBarCon")
	self._closeBtn = self:getBtn("closeBtn")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._nameTxt = goutil.findChildTextComponent(self.mainGO, "nameTxt")
	self._timerTxt = goutil.findChildTextComponent(self.mainGO, "timerTxt")
	self._leftBtnTran = self:getGo("leftBtnTran").transform
	self._btnItem = self:getGo("btnItem")

	self._btnItem:SetActive(false)

	self._nameTxt.text = ""
	self._timerTxt.text = ""
	self._btnOneKey = self:getGo("btnOneKey")
end

function EquipFunctionView:onEnter()
	EquipFunctionView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PetEquipCurEquipmentChange, self._onChangeSelectEquipment, self)

	self._nameTxt.text = ""
	self._timerTxt.text = ""
	self._tabItemList = self._tabItemList or {}
	self._curIndex = nil

	local tabId = checknumber(self:getFirstParam())

	if tabId <= 0 then
		tabId = PetEquipController.instance:getEquipFunctionTabIndex()
	end

	self._tabInfos = EquipmentConfig.instance:getEquipFunctionTabCfgs()

	local index = 1

	for i = 1, #self._tabInfos do
		if self._tabInfos[i] and self._tabInfos[i].tabId == tabId then
			index = i

			break
		end
	end

	self:_checkShowView(true)
end

function EquipFunctionView:_checkShowView(isForce)
	local curEquipMo = PetEquipController.instance:getCurrentEquipInfoMo()

	if curEquipMo then
		if curEquipMo:isCanTupo() then
			self:_onClickTabItemBtn(EQUIP_TUPO_INDEX, isForce)
		else
			self:_onClickTabItemBtn(EQUIP_STRENGTH_INDEX, isForce)
		end
	else
		self:_onClickTabItemBtn(EQUIP_STRENGTH_INDEX, isForce)
	end
end

function EquipFunctionView:_createAllTabs()
	for _, item in pairs(self._tabItemList) do
		if item and item.itemGo then
			GameUtil.asBtn(item.itemGo):RemoveClickListener()
			GameUtil.SetActive(item.itemGo, false)
		end
	end

	if self._tabInfos == nil or #self._tabInfos == 0 then
		return
	end

	for i = 1, #self._tabInfos do
		if self._tabItemList[i] == nil or self._tabItemList[i].itemGo == nil then
			self._tabItemList[i] = {}

			local go = UnityEngine.GameObject.Instantiate(self._btnItem, self._leftBtnTran)

			GameUtil.SetActive(go, true)

			self._tabItemList[i] = {
				itemGo = go,
				itemGro = go:GetComponent("UIChangeGroup"),
				pointGo = goutil.findChild(go, "pointGo"),
				nameTxt = goutil.findChildTextComponent(go, "nameTxt"),
				selectGo = goutil.findChild(go, "selectGo"),
				tagGo = goutil.findChild(go, "tagGo"),
				tagTxt = goutil.findChildTextComponent(go, "tagGo/tagTxt")
			}
		end

		GameUtil.SetActive(self._tabItemList[i].itemGo, true)

		self._tabItemList[i].nameTxt.text = self._tabInfos[i].name

		GameUtil.SetActive(self._tabItemList[i].pointGo, false)
		GameUtil.SetActive(self._tabItemList[i].selectGo, false)

		if string.nilorempty(self._tabInfos[i].tag) then
			self._tabItemList[i].tagTxt.text = ""

			GameUtil.SetActive(self._tabItemList[i].tagGo, false)
		else
			GameUtil.SetActive(self._tabItemList[i].tagGo, true)

			self._tabItemList[i].tagTxt.text = self._tabInfos[i].tag
		end

		self._tabItemList[i].itemGro:SetState(1)
		GameUtil.asBtn(self._tabItemList[i].itemGo):AddClickListener(function()
			self:_onClickTabItemBtn(i)
		end)
	end
end

function EquipFunctionView:_onClickTabItemBtn(index, isForce)
	self._curIndex = checknumber(self._curIndex)

	if self._curIndex == index and not isForce then
		return
	end

	if self._tabInfos == nil or self._tabInfos[index] == nil then
		return
	end

	local funcId = self._tabInfos[index].funcId

	if not isForce and funcId > 0 and not FuncOpenController.instance:checkFuncIdOrShowLockTips(funcId) then
		return
	end

	if self._tabItemList[self._curIndex] and self._tabItemList[self._curIndex].itemGro then
		self._tabItemList[self._curIndex].itemGro:SetState(1)
		GameUtil.SetActive(self._tabItemList[self._curIndex].selectGo, false)
	end

	if self._tabItemList[index] and self._tabItemList[index].itemGro then
		self._tabItemList[index].itemGro:SetState(0)
		GameUtil.SetActive(self._tabItemList[index].selectGo, true)
	end

	self._curIndex = index
	self._nameTxt.text = self._tabInfos[index].name
	DoubleElevenModel.instance.mainTabIndex = self._tabInfos[index].tabId

	self:showTabAt(self._subParentGo, self._tabInfos[index].viewName)

	local params = string.split(self._tabInfos[index].params, ":")

	if params and #params >= 2 then
		local actCfg = ActivityDefineConfig.instance:getCfgById(checknumber(params[1]), checknumber(params[2]))

		if actCfg then
			local starTime = GameUtil.string2date(actCfg.startTime)
			local endTime = GameUtil.string2date(actCfg.endTime)

			self._timerTxt.text = string.format("活动时间：%s月%s日 %s:00 -- %s月%s日 %s:00", starTime.month, starTime.day, starTime.hour, endTime.month, endTime.day, endTime.hour)
		end
	end

	if isForce then
		for i = 1, #self._tabInfos do
			if self._tabItemList[i] and self._tabItemList[i].pointGo then
				self:_showSingleRedPoint(i)
			end
		end
	end

	if string.nilorempty(self._tabInfos[index].cost) then
		ViewMgr.instance:close(ViewName.MainTopGoldView)

		return
	end

	local list = string.split(self._tabInfos[index].cost, "#")
	local btnList = {}

	for i = 1, #list do
		table.insert(btnList, {
			showAdd = true,
			id = list[i]
		})
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btnList)
end

function EquipFunctionView:_updataTabItemRedPoint(tabId)
	if self._tabInfos == nil or #self._tabInfos == 0 then
		return
	end

	for i = 1, #self._tabInfos do
		if self._tabInfos[i] and self._tabInfos[i].tabId == tabId and self._tabItemList[i] then
			self:_showSingleRedPoint(i)
		end
	end
end

function EquipFunctionView:_showSingleRedPoint(index)
	if self._tabInfos[index] == nil or self._tabItemList[index] == nil or self._tabItemList[index].pointGo == nil then
		return
	end

	if string.nilorempty(self._tabInfos[index].redIds) then
		GameUtil.SetActive(self._tabItemList[index].pointGo, false)

		return
	end

	local list = string.split(self._tabInfos[index].redIds, "#")

	if list == nil or #list == 0 then
		GameUtil.SetActive(self._tabItemList[index].pointGo, false)

		return
	end

	for _, id in pairs(list or {}) do
		if RedPointModel.instance:isActive(id) then
			GameUtil.SetActive(self._tabItemList[index].pointGo, true)

			return
		end
	end

	GameUtil.SetActive(self._tabItemList[index].pointGo, false)
end

function EquipFunctionView:_onChangeSelectEquipment()
	self:_checkShowView()
end

function EquipFunctionView:_onClickOneKey()
	UIStateManager.instance:push(ViewName.EquipTupoOneKeyView)
end

return EquipFunctionView
