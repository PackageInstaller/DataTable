-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/setting/AirWorkSettingCondition.lua

module("logic.extensions.airworkshop.flow.defflow.view.setting.AirWorkSettingCondition", package.seeall)

local M = class("AirWorkSettingCondition")

function M:ctor(container)
	self._go = container.gameObject
	self._txtContent = goutil.findChildTextComponent(self._go, "item1/txtContent")
	self._scrollRectGo = goutil.findChild(self._go, "scrollView")
	self._scrollRect = self._scrollRectGo:GetComponent(UIComponentType.ScrollRect)
	self._contentGo = goutil.findChild(self._scrollRectGo, "viewPort/content")
	self._loopList = LoopListHelper.New(self._scrollRectGo)

	self._loopList:InitListView(0, self._updateCell, self)

	self._btnReset = Astral.ButtonAdapter.Get(goutil.findChild(self._go, "btnReset"))
	self._btnSave = Astral.ButtonAdapter.Get(goutil.findChild(self._go, "btnSave"))

	self:_bindEvents()
end

function M:_bindEvents()
	GlobalDispatcher:addEventListener(EventType.AIRWORKSHOP_CONDITION_CHANGE, self._conditionChange, self)
	self._btnReset:AddClickListener(self._onClickBtnReset, self)
	self._btnSave:AddClickListener(self._onClickBtnSave, self)
end

function M:_unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.AIRWORKSHOP_CONDITION_CHANGE, self._conditionChange, self)
	self._btnReset:RemoveClickListener()
	self._btnSave:RemoveClickListener()
end

function M:OnDestroy()
	self:_unbindEvents()
end

function M:onEnter(mapData, newMovePointList)
	self._mapData = mapData
	self._conditionDataOld = self._mapData:getCondition()
	self._moList = {}

	local coList = AirWorkShopConfig.instance:getConfigList(ConfigName.AirStudioWinCondition)

	for i, v in ipairs(coList) do
		if self._conditionDataOld and v.id == self._conditionDataOld.id then
			local mo = {}

			mo.id = v.id
			mo.type = v.type
			mo.params = self._conditionDataOld.params or {}

			table.insert(self._moList, mo)

			break
		end
	end

	if newMovePointList and #newMovePointList > 0 then
		self._moList = {}

		local mo = {}

		mo.id = 1
		mo.type = AirWorkShopEnum.ConditionType.Move
		mo.params = newMovePointList

		table.insert(self._moList, mo)
	end

	if #self._moList == 0 then
		self:_setOriginCondition()
	end

	self:_setData()
end

function M:_setOriginCondition()
	self._moList = {}

	local coList = AirWorkShopConfig.instance:getConfigList(ConfigName.AirStudioWinCondition)

	for i, v in ipairs(coList) do
		local mo = {}

		mo.id = v.id
		mo.type = v.type
		mo.params = {}

		table.insert(self._moList, mo)
	end
end

function M:onExit()
	self._heroId = false
end

function M:_setData()
	printWarn("=====_setData=====", #self._moList)

	self._scrollRect.enabled = true

	local itemCount = #self._moList

	self._loopList:SetListItemCount(itemCount)
	self._loopList:RefreshAllShownItem()

	self._scrollRect.enabled = false
end

function M:_updateCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopList:NewListViewItem("air_workshop_condition_item")
	local itemView = Astral.LuaComponentContainer.Add(item.gameObject, AirWorkSettingConditionItem)
	local mo = self._moList[curIndex]

	itemView:updateData(mo)

	return item
end

function M:_conditionChange(e, param)
	if param.isDelete then
		self:_setOriginCondition()
	else
		self._moList = {}

		local mo = {}

		mo.id = 2
		mo.type = AirWorkShopEnum.ConditionType.Kill
		mo.params = {
			param.heroId
		}

		table.insert(self._moList, mo)
	end

	self:_setData()
end

function M:_saveModify()
	if not self._mapData then
		return
	end

	local newConditionId = 0
	local params = {}

	for i, v in ipairs(self._moList or {}) do
		if #v.params > 0 then
			newConditionId = v.id
			params = v.params
		end
	end

	if newConditionId == 0 then
		self._mapData:setCondition(false)
	else
		local winCondition = BattleExtension_pb.WinConditionNO()

		for i, v in ipairs(params) do
			table.insert(winCondition.params, v)
		end

		winCondition.id = newConditionId

		self._mapData:setCondition(winCondition)
	end
end

function M._sortFun(A, B)
	return A.co.id < B.co.id
end

function M:_onClickBtnReset()
	local bakeMapMO = AirWorkShopDefSceneModel.instance:getBakeMapForLeave()

	AirWorkShopDefSceneUtil.reset2BakeMap(self._mapData, bakeMapMO, AirWorkShopEnum.DefState.LeavePosSet)
	AirWorkShopDefSceneUtil.resetExtraWinCondition2BakeMap(self._mapData, bakeMapMO)
	self:onEnter(self._mapData)
end

function M:_onClickBtnSave()
	self:_saveModify()
	AirWorkShopDefSceneUtil.updateLeaveMapMoWhenSave(self._mapData)
	FloatWordMgr.instance:show(lang("tip_save_success"))
	ViewMgr.instance:close(ViewName.AirWorkShopSettingView)
end

return M
