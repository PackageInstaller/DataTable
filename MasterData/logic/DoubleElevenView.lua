-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doubleeleven/view/DoubleElevenView.lua

module("logic.extensions.doubleeleven.view.DoubleElevenView", package.seeall)

local DoubleElevenView = class("DoubleElevenView", ViewComponent)

function DoubleElevenView:ctor()
	DoubleElevenView.super.ctor(self)

	self._tabItemList = nil
	self._tabInfos = nil
end

function DoubleElevenView:bindEvents()
	DoubleElevenView.super.bindEvents(self)
	self._closeBtn:AddClickListener(function()
		DoubleElevenModel.instance.mainTabIndex = nil
		DoubleElevenModel.instance.crSubTabIndex = nil

		UIStateManager.instance:popByName(self._viewPresentor.viewName)
	end, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "doubleeleven")
	end, self)
end

function DoubleElevenView:unbindEvents()
	DoubleElevenView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()

	for _, item in pairs(self._entranceItemList or {}) do
		if item and item.itemBtn then
			item.itemBtn:RemoveClickListener()
		end
	end
end

function DoubleElevenView:onExit()
	DoubleElevenView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.DE_UpdataDoubleElevenRed, self._updataTabItemRedPoint, self)

	for _, item in pairs(self._tabItemList or {}) do
		if item and item.itemGo then
			GameUtil.SetActive(item.itemGo, false)
		end
	end
end

function DoubleElevenView:destroyUI()
	DoubleElevenView.super.destroyUI(self)

	for _, item in pairs(self._tabItemList or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self._tabItemList = nil
end

function DoubleElevenView:buildUI()
	DoubleElevenView.super.buildUI(self)

	self._subParentGo = self:getGo("subParentGo")
	self._goldBarCon = self:getGo("goldBarCon")
	self._closeBtn = self:getBtn("closeBtn")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._viewNameTxt = goutil.findChildTextComponent(self.mainGO, "viewNameTxt")
	self._timerTxt = goutil.findChildTextComponent(self.mainGO, "timerTxt")
	self._leftBtnTran = self:getGo("leftBtnTran").transform
	self._btnItem = self:getGo("btnItem")

	self._btnItem:SetActive(false)

	self._timerTxt.text = ""
end

function DoubleElevenView:onEnter()
	DoubleElevenView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.DE_UpdataDoubleElevenRed, self._updataTabItemRedPoint, self)

	local index = math.max(checknumber(DoubleElevenModel.instance.mainTabIndex), 1)

	if index == 1 and checknumber(self:getFirstParam()) > 1 then
		self._tabInfos, self._curIndex = DoubleElevenModel.instance:getDoubleElevenTabList(self:getFirstParam())
	else
		self._tabInfos, self._curIndex = DoubleElevenModel.instance:getDoubleElevenTabList(index, true)
	end

	self._viewNameTxt.text = "双十一商城"
	self._timerTxt.text = ""
	self._tabItemList = self._tabItemList or {}

	self:_createAllTabs()
end

function DoubleElevenView:_createAllTabs()
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
				tagGo = goutil.findChild(go, "tagGo"),
				tagTxt = goutil.findChildTextComponent(go, "tagGo/tagTxt")
			}
		end

		self._tabItemList[i].itemGo:SetActive(true)

		self._tabItemList[i].nameTxt.text = self._tabInfos[i].tabName

		self._tabItemList[i].pointGo:SetActive(false)

		if string.nilorempty(self._tabInfos[i].tagName) then
			self._tabItemList[i].tagTxt.text = ""

			GameUtil.SetActive(self._tabItemList[i].tagGo, false)
		else
			GameUtil.SetActive(self._tabItemList[i].tagGo, true)

			self._tabItemList[i].tagTxt.text = self._tabInfos[i].tagName
		end

		self._tabItemList[i].itemGro:SetState(0)
		GameUtil.asBtn(self._tabItemList[i].itemGo):AddClickListener(function()
			self:_onClickTabItemBtn(i)
		end)
	end

	self:_onClickTabItemBtn(self._curIndex, true)
end

function DoubleElevenView:_onClickTabItemBtn(index, isForce)
	if self._curIndex == index and not isForce then
		return
	end

	if self._tabInfos == nil or self._tabInfos[index] == nil then
		return
	end

	if not isForce and self._tabInfos[index].funcId > 0 and not FuncOpenController.instance:checkFuncIdOrShowLockTips(self._tabInfos[index].funcId) then
		return
	end

	if self._tabItemList[self._curIndex] and self._tabItemList[self._curIndex].itemGro then
		self._tabItemList[self._curIndex].itemGro:SetState(0)
	end

	if self._tabItemList[index] and self._tabItemList[index].itemGro then
		self._tabItemList[index].itemGro:SetState(1)
	end

	self._curIndex = index
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

	for i = 1, #self._tabInfos do
		if self._tabItemList[i] and self._tabItemList[i].pointGo then
			self:_showSingleRedPoint(i)
		end
	end
end

function DoubleElevenView:_updataTabItemRedPoint(tabId)
	if self._tabInfos == nil or #self._tabInfos == 0 then
		return
	end

	for i = 1, #self._tabInfos do
		if self._tabInfos[i] and self._tabInfos[i].tabId == tabId and self._tabItemList[i] then
			self:_showSingleRedPoint(i)
		end
	end
end

function DoubleElevenView:_showSingleRedPoint(index)
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

return DoubleElevenView
