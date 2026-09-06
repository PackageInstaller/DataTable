-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/summerdouble/SummerTaskView.lua

module("logic.extensions.bonus.view.summerdouble.SummerTaskView", package.seeall)

local SummerTaskView = class("SummerTaskView", TableViewComponent)

function SummerTaskView:ctor()
	SummerTaskView.super.ctor(self)

	self._tabTypeList = nil
	self._tabItemList = nil
	self._curTypeIndex = nil
	self._typeCfgList = nil
end

function SummerTaskView:bindEvents()
	SummerTaskView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function SummerTaskView:unbindEvents()
	SummerTaskView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function SummerTaskView:onExit()
	SummerTaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_GETINFORES, self._updataShowListSR, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendEventTaskSummaryGetInfoReq, self)

	self._tabTypeList = nil
	self._curTypeIndex = nil
	self._typeCfgList = nil
end

function SummerTaskView:destroyUI()
	SummerTaskView.super.destroyUI(self)

	for _, item in pairs(self._tabItemList or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self._tabItemList = nil
end

function SummerTaskView:buildUI()
	SummerTaskView.super.buildUI(self)

	self._closeBtn = self:getBtn("viewBgGo/closeBtn")
	self._tabBtnsTran = self:getGo("viewBgGo/tabBtnsTran").transform
	self._tabBtnGo = self:getGo("viewBgGo/tabBtnGo")

	GameUtil.SetActive(self._tabBtnGo, false)
end

function SummerTaskView:onEnter()
	SummerTaskView.super.onEnter(self)

	self._actId = 142007

	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self._updataShowListSR, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendEventTaskSummaryGetInfoReq, self)
	self:_onInitShowUI()
	self:_updataShowListSR()
	self:_sendEventTaskSummaryGetInfoReq()
end

function SummerTaskView:_sendEventTaskSummaryGetInfoReq()
	EventTaskSummaryAgent.instance:sendPM_EventTaskSummaryGetInfoReq(self._actId)
end

function SummerTaskView:_onInitShowUI()
	local types = {
		"sunran",
		"daily",
		"weekly",
		"allTime"
	}
	local names = {
		allTime = "日常任务",
		daily = "每日任务",
		sunran = "成就任务",
		weekly = "每周任务"
	}
	local cfgs = EventTaskSummaryConfig.instance:getTaskCfgs(self._actId)

	self._typeCfgList = {}

	for _, v in pairs(cfgs or {}) do
		if v and checknumber(v.taskId) > 0 then
			local str = string.nilorempty(v.periodType) and "sunran" or v.periodType

			self._typeCfgList[str] = self._typeCfgList[str] or {}
			self._typeCfgList[str][v.type] = self._typeCfgList[str][v.type] or {}

			table.insert(self._typeCfgList[str][v.type], v)
		end
	end

	self._tabTypeList = {}

	local isAdd = false

	for str, typeList in pairs(self._typeCfgList) do
		isAdd = false

		for _, list in pairs(typeList or {}) do
			if list and #list > 0 then
				isAdd = true

				if #list > 1 then
					table.sort(list, function(a, b)
						return a.taskId < b.taskId
					end)
				end
			end
		end

		if isAdd then
			table.insert(self._tabTypeList, str)
		end
	end

	if #self._tabTypeList > 1 then
		table.sort(self._tabTypeList, function(a, b)
			return table.indexof(types, a) < table.indexof(types, b)
		end)
	end

	self._tabItemList = self._tabItemList or {}

	for i = 1, #self._tabTypeList do
		if self._tabItemList[i] == nil or self._tabItemList[i].itemGo == nil then
			self._tabItemList[i] = {}

			local go = UnityEngine.GameObject.Instantiate(self._tabBtnGo, self._tabBtnsTran)

			self._tabItemList[i].itemGo = go
			self._tabItemList[i].itemUIcg = go:GetComponent("UIChangeGroup")
			self._tabItemList[i].redPointGo = goutil.findChild(go, "redpointGo")
			self._tabItemList[i].tabTxt = goutil.findChildTextComponent(go, "tabTxt")
			self._tabItemList[i].nameStr = ""
		else
			GameUtil.asBtn(self._tabItemList[i].itemGo):RemoveClickListener()
		end

		GameUtil.SetActive(self._tabItemList[i].itemGo, true)
		GameUtil.SetActive(self._tabItemList[i].redPointGo, false)
		self._tabItemList[i].itemUIcg:SetState(0)

		self._tabItemList[i].tabTxt.text = names[self._tabTypeList[i]]
		self._tabItemList[i].nameStr = self._tabTypeList[i]

		GameUtil.asBtn(self._tabItemList[i].itemGo):AddClickListener(function()
			self:_onClickTableBtn(i)
		end, self)
	end
end

function SummerTaskView:_updataShowListSR()
	self._allTaskInfos = EventTaskSummaryModel.instance:getTaskInfoMapByActid(self._actId)

	if checknumber(self._curTypeIndex) > 0 then
		if not self._curTypeIndex then
			local typeIndex = 1

			self._curTypeIndex = 0

			self:_onClickTableBtn(typeIndex)
			self:_setTableBtnRedpoint()
		end
	end
end

function SummerTaskView:_onClickTableBtn(index)
	if checknumber(self._curTypeIndex) > 0 and self._curTypeIndex == index then
		return
	end

	self._curViewDatas = {}

	if self._tabItemList[self._curTypeIndex] and self._tabItemList[self._curTypeIndex].itemUIcg then
		self._tabItemList[self._curTypeIndex].itemUIcg:SetState(0)
	end

	self._tabItemList[index].itemUIcg:SetState(1)

	self._curTypeIndex = index

	local cfgList = self._typeCfgList[self._tabItemList[index].nameStr]

	for _, list in pairs(cfgList or {}) do
		local info = self:_getTypeListCurTask(list)

		if info then
			table.insert(self._curViewDatas, info)
		end
	end

	if #self._curViewDatas > 1 then
		table.sort(self._curViewDatas, function(a, b)
			if a.stage == b.stage then
				return a.cfg.taskId < b.cfg.taskId
			end

			return a.stage < b.stage
		end)
	end

	self:reloadData()
end

function SummerTaskView:_getCanGainTaskIdListInCurTab()
	local taskIdList = {}

	if self._tabItemList then
		if self._tabItemList then
			if not self._typeCfgList[self._tabItemList.nameStr] then
				local cfgList

				for _, list in pairs(cfgList or {}) do
					for _, cfg in ipairs(list or {}) do
						if self._allTaskInfos then
							if self._allTaskInfos and not self._allTaskInfos.hasGainPrize and self._allTaskInfos.curProgress >= cfg.maxProgress then
								table.insert(taskIdList, cfg.taskId)
							end
						end
					end
				end

				return taskIdList
			end
		end
	end
end

function SummerTaskView:_getTypeListCurTask(list)
	if list == nil or #list == 0 then
		return nil
	end

	for i = 1, #list do
		if self._allTaskInfos == nil or self._allTaskInfos[list[i].taskId] == nil then
			return {
				curPro = 0,
				stage = 2,
				isHasGain = false,
				cfg = list[i]
			}
		end

		local info = self._allTaskInfos[list[i].taskId]

		if not info.hasGainPrize then
			if info.curProgress >= list[i].maxProgress then
				return {
					stage = 1,
					isHasGain = false,
					cfg = list[i],
					curPro = info.curProgress
				}
			else
				return {
					stage = 2,
					isHasGain = false,
					cfg = list[i],
					curPro = info.curProgress
				}
			end
		end
	end

	local cfg = list[#list]

	return {
		stage = 3,
		isHasGain = true,
		cfg = cfg,
		curPro = (self._allTaskInfos and self._allTaskInfos[cfg.taskId] or nil) and self._allTaskInfos[cfg.taskId].curProgress
	}
end

function SummerTaskView:_setTableBtnRedpoint()
	for _, item in pairs(self._tabItemList or {}) do
		if item and item.redPointGo and not string.nilorempty(item.nameStr) then
			GameUtil.SetActive(item.redPointGo, false)

			for _, cfg in pairs(self._typeCfgList[item.nameStr] or {}) do
				if cfg and checknumber(cfg.taskId) > 0 and self._allTaskInfos and self._allTaskInfos[cfg.taskId] and not self._allTaskInfos[cfg.taskId].hasGainPrize and self._allTaskInfos[cfg.taskId].curProgress >= cfg.maxProgress then
					GameUtil.SetActive(item.redPointGo, true)

					break
				end
			end
		end
	end
end

function SummerTaskView:_getPath()
	return {
		cellPath = "viewBgGo/taskItem",
		viewPath = "viewBgGo/taskListSR"
	}
end

function SummerTaskView:_cellSize()
	return 870, 114
end

function SummerTaskView:_updateCell(view, cell, data)
	local hasGainGo = goutil.findChild(cell, "hasGainGo")
	local noPassGo = goutil.findChild(cell, "noPassGo")
	local receiveBtnGo = goutil.findChild(cell, "receiveBtn")
	local receiveTxt = goutil.findChildTextComponent(receiveBtnGo, "receiveTxt")
	local descTxt = goutil.findChildTextComponent(cell, "descTxt")
	local titleTxt = goutil.findChildTextComponent(cell, "titleTxt")
	local countTxt = goutil.findChildTextComponent(cell, "countTxt")
	local posList = {
		goutil.findChild(cell, "goodsPos1"),
		goutil.findChild(cell, "goodsPos2")
	}

	GameUtil.asBtn(receiveBtnGo):RemoveClickListener()

	for _, go in pairs(posList) do
		MaterialMgr.resetAll(go)
	end

	descTxt.text = data.cfg.desc
	titleTxt.text = data.cfg.title
	countTxt.text = string.format("进度：%s/%s", math.min(data.curPro, data.cfg.maxProgress), data.cfg.maxProgress)

	local goodsList = string.split(data.cfg.prize)

	for i = 1, #goodsList do
		if goodsList[i] and posList[i] then
			MaterialMgr.setCellByCfg(goodsList[i], posList[i])
		end
	end

	if data.stage == 3 then
		GameUtil.SetActive(receiveBtnGo, false)
		GameUtil.SetActive(noPassGo, false)
		GameUtil.SetActive(hasGainGo, true)

		return
	end

	GameUtil.SetActive(hasGainGo, false)

	if data.stage == 1 or not string.nilorempty(data.cfg.jumpTo) then
		GameUtil.SetActive(noPassGo, false)
		GameUtil.SetActive(receiveBtnGo, true)

		receiveTxt.text = data.stage == 1 and "领取" or "前往"
	else
		GameUtil.SetActive(receiveBtnGo, false)
		GameUtil.SetActive(noPassGo, true)
	end

	GameUtil.asBtn(receiveBtnGo):AddClickListener(function()
		if data.stage == 1 then
			EventTaskSummaryAgent.instance:sendPM_EventTaskSummaryGainTaskPrizeReq(self._actId, self:_getCanGainTaskIdListInCurTab())
		else
			ViewAutoShowController.instance:saveCurModalView()
			GotoMgr.gotoByString(data.cfg.jumpTo)
		end
	end, self)
end

function SummerTaskView:_clearTableview(cell)
	local receiveBtnGo = goutil.findChild(cell, "receiveBtn")
	local posList = {
		goutil.findChild(cell, "goodsPos1"),
		goutil.findChild(cell, "goodsPos2")
	}

	GameUtil.asBtn(receiveBtnGo):RemoveClickListener()

	for _, go in pairs(posList) do
		MaterialMgr.resetAll(go)
	end
end

return SummerTaskView
