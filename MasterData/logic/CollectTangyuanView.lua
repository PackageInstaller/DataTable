-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collecttangyuan/view/CollectTangyuanView.lua

module("logic.extensions.collecttangyuan.view.CollectTangyuanView", package.seeall)

local CollectTangyuanView = class("CollectTangyuanView", TableViewComponent)

function CollectTangyuanView:ctor()
	CollectTangyuanView.super.ctor(self)

	self._curInfosList = nil
	self._itemEffsList = nil
end

function CollectTangyuanView:bindEvents()
	CollectTangyuanView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(self._onClickBtnTips, self)
	self._blessBtn:AddClickListener(self._onClickBless, self)
end

function CollectTangyuanView:unbindEvents()
	CollectTangyuanView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._blessBtn:RemoveClickListener()
end

function CollectTangyuanView:onExit()
	CollectTangyuanView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataCollectTangyuanInfo, self._updataShowItemListSR, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataCollectTangyuanTask, self._updataShowTaskInfo, self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)

		self._pmEff = nil
	end

	for _, eff in pairs(self._itemEffsList or {}) do
		if eff then
			UIEffectManager.instance:stopEffect(eff)
		end
	end

	self._itemEffsList = nil
	self._curViewDatas = nil
	self._curInfosList = nil
end

function CollectTangyuanView:destroyUI()
	CollectTangyuanView.super.destroyUI(self)
end

function CollectTangyuanView:buildUI()
	CollectTangyuanView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._blessBtn = self:getBtn("blessBtn")
	self._blessTxt = self:getTxt("blessBtn/blessTxt")
	self._redpointGo = self:getGo("blessBtn/redpointGo")
	self._timeTxt = self:getTxt("timeGo/timeTxt")
	self._clipRect = self:getGo("itemListSR/Viewport"):GetComponent(goutil.Type_RectTransform)
	self._timeTxt.text = ""

	GameUtil.SetActive(self._redpointGo, false)
end

function CollectTangyuanView:onEnter()
	CollectTangyuanView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataCollectTangyuanInfo, self._updataShowItemListSR, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataCollectTangyuanTask, self._updataShowTaskInfo, self)

	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.CollectTangyuan)

	self._actCfg = CollectTangyuanConfig.instance:getCollectTangyuanActivityId((cfg or nil) and (cfg.activityId or 0))

	if self._actCfg == nil then
		self:close()

		return
	end

	CollectTangyuanModel.instance:setActivityIdAndPlanId(self._actCfg.activityId, self._actCfg.taskPlanId)

	self._timeTxt.text = self._actCfg.timeDesc
	self._isTaskRed = RedPointModel.instance:isActive("c15")

	local effPath = "20230120/yuanxiaohaoli/fx_ui_jyxdhl_fw.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)

	self._itemEffsList = self._itemEffsList or {}
	self._curViewDatas = CollectTangyuanConfig.instance:getCollectTangyuanGroups(self._actCfg.exchangePlan)

	self:_updataShowItemListSR()
	YuanXiaoKingsExchangeAgent.instance:sendPM_KingsExchangeGetInfoReq()
end

function CollectTangyuanView:_updataShowTaskInfo(taskId)
	if self._curInfosList == nil or self._curInfosList.taskInfos == nil then
		return
	end

	self._curInfosList.taskInfos[taskId] = self._curInfosList.taskInfos[taskId] or {}
	self._curInfosList.taskInfos[taskId].gainedPrize = true

	CollectTangyuanModel.instance:setTaskInfos(self._curInfosList.taskInfos)
	self._tableview:ReloadData()
	self:_setTaskRedpoint()
end

function CollectTangyuanView:_updataShowItemListSR(data)
	self._curInfosList = {
		exchangeRecords = {},
		selection = {},
		taskInfos = {}
	}

	if data and data.exchangeRecords then
		for _, info in pairs(data.exchangeRecords) do
			if info and info.prizeId and info.prizeId > 0 then
				self._curInfosList.exchangeRecords[info.prizeId] = info.count
			end
		end
	end

	if data and data.selection then
		for _, info in pairs(data.selection) do
			if info and info.groupId and info.groupId > 0 then
				self._curInfosList.selection[info.groupId] = info.prizeId
			end
		end
	end

	if data and data.taskInfos then
		for _, info in pairs(data.taskInfos) do
			if info and info.taskId and info.taskId > 0 then
				self._curInfosList.taskInfos[info.taskId] = info
			end
		end

		CollectTangyuanModel.instance:setTaskInfos(self._curInfosList.taskInfos)
	end

	self._tableview:ReloadData()
	self:_setTaskRedpoint()
end

function CollectTangyuanView:_setTaskRedpoint()
	if self._isTaskRed then
		GameUtil.SetActive(self._redpointGo, true)
	else
		local allCfgs = CollectTangyuanConfig.instance:getCollectTangyuanTasks(self._actCfg.taskPlanId)
		local taskInfos = self._curInfosList.taskInfos

		for _, v in pairs(allCfgs or {}) do
			if v and taskInfos and taskInfos[v.taskId] and not taskInfos[v.taskId].gainedPrize and taskInfos[v.taskId].curProgress >= v.maxProgress then
				GameUtil.SetActive(self._redpointGo, true)

				return
			end
		end

		GameUtil.SetActive(self._redpointGo, false)
	end
end

function CollectTangyuanView:_getPath()
	return {
		cellPath = "itemCell",
		viewPath = "itemListSR"
	}
end

function CollectTangyuanView:_updateCell(view, cell, data)
	local posGoCon = goutil.findChild(cell.gameObject, "posGoCon")
	local layout = posGoCon:GetComponent(ComponentType.UILayoutSingleLine)
	local viewContent = goutil.findChild(cell, "goodsSR/Viewport/Content").transform
	local viewLayout = goutil.findChild(cell, "goodsSR/Viewport/Content/items"):GetComponent(ComponentType.UILayoutSingleLine)
	local goodsItem = goutil.findChild(cell, "goodsItem")
	local addBtnGo = goutil.findChild(cell, "addBtn")
	local addRedGo = goutil.findChild(addBtnGo, "addRedGo")
	local openBtnGo = goutil.findChild(cell, "openBtn")
	local openTxt = goutil.findChildTextComponent(openBtnGo, "openTxt")
	local redpointGo = goutil.findChild(openBtnGo, "redpointGo")
	local finishGo = goutil.findChild(cell, "finishGo")
	local posGo = goutil.findChild(cell, "posGo")

	for _, item in pairs(goodsList or {}) do
		if item and item.goodsPos then
			MaterialMgr.resetAll(item.goodsPos)
		end
	end

	GameUtil.asBtn(addBtnGo):RemoveClickListener()
	GameUtil.asBtn(openBtnGo):RemoveClickListener()
	GameUtil.SetActive(goodsItem, false)

	if self._itemEffsList and self._itemEffsList[cell] then
		UIEffectManager.instance:stopEffect(self._itemEffsList[cell])

		self._itemEffsList[cell] = nil
	end

	local isFull = true
	local list = string.split(data.cost, "#")
	local cnt = posGoCon.transform.childCount
	local listCnt = #list
	local goodsList = {}

	for i = 1, cnt do
		local go = posGoCon.transform:GetChild(i - 1).gameObject

		goodsList[i] = {
			itemGo = go,
			goodsPos = goutil.findChild(go, "goodsPos"),
			goodsTxt = goutil.findChildTextComponent(go, "goodsTxt")
		}
	end

	for i = cnt + 1, listCnt do
		if not goodsList[i] then
			local go = goutil.cloneAndSetParent(posGo, posGoCon.transform)

			goodsList[i] = {
				itemGo = go,
				goodsPos = goutil.findChild(go, "goodsPos"),
				goodsTxt = goutil.findChildTextComponent(go, "goodsTxt")
			}
		end
	end

	for i, v in ipairs(goodsList) do
		goutil.setActive(v.itemGo, i <= listCnt)
	end

	layout:Layout()

	for i = 1, listCnt do
		local matType, matId, matNum = MaterialMgr.getMatParams(list[i])
		local have = MaterialModel.instance:getMaterialsNumber(matType, matId)

		goodsList[i].goodsTxt.text = string.format("%s/%s", have, matNum)

		if have < matNum then
			isFull = false
		end

		MaterialMgr.setIcon(goodsList[i].goodsPos, matType, matId)
	end

	local childCount = viewLayout.transform.childCount

	for i = 1, childCount do
		local go = viewLayout.transform:GetChild(i - 1).gameObject

		MaterialMgr.resetAll(go)
		GameUtil.SetActive(go, false)
	end

	local isFinish = self:_isSelectPrizesFinish(data)

	if isFinish then
		GameUtil.SetActive(addBtnGo, false)
		GameUtil.SetActive(openBtnGo, false)
		GameUtil.SetActive(finishGo, true)

		return
	end

	GameUtil.SetActive(finishGo, false)
	GameUtil.SetActive(openBtnGo, true)

	local selectList = self:_getSelectPrizesList(data)

	if selectList then
		if not #selectList then
			local goodsCount = 0

			if goodsCount == 0 then
				GameUtil.SetActive(addBtnGo, true)
			else
				GameUtil.SetActive(addBtnGo, false)

				while childCount < goodsCount do
					local go = UGUIToolHelper.AddChild(viewLayout.gameObject, goodsItem)

					Framework.TransformUtil.SetLocalScale(go.transform, 0.85, 0.85, 0.85)

					childCount = childCount + 1
				end

				for i = 1, goodsCount do
					local go = viewLayout.transform:GetChild(i - 1).gameObject

					GameUtil.SetActive(go, true)
					MaterialMgr.resetAll(go)
					MaterialMgr.setCellByCfg(selectList[i].gain, go)
				end
			end

			viewLayout:Layout()

			local sizeDelta = viewContent.sizeDelta

			sizeDelta.x = goodsCount * 90
			viewContent.sizeDelta = sizeDelta

			if goodsCount == 0 or not isFull then
				uGuiUtil.setImageGrayState(openBtnGo, true)
				uGuiUtil.setTextGrayState(openTxt, true)
				GameUtil.SetActive(redpointGo, false)
			else
				uGuiUtil.setImageGrayState(openBtnGo, false)
				uGuiUtil.setTextGrayState(openTxt, false)
				GameUtil.SetActive(redpointGo, true)
			end

			if goodsCount == 0 then
				GameUtil.asBtn(addBtnGo):AddClickListener(function()
					local params = {
						cfg = data,
						activityId = self._actCfg.activityId,
						exchangeRecords = self._curInfosList.exchangeRecords,
						planId = self._actCfg.exchangePlan
					}

					UIStateManager.instance:push(ViewName.CollectTangyuanSelect, params)
				end, self)
			end

			GameUtil.asBtn(openBtnGo):AddClickListener(function()
				if goodsCount == 0 then
					FloatWordMgr.instance:show("请先选择要兑换的奖励！")

					return
				end

				if not isFull then
					FloatWordMgr.instance:show("兑换奖励收集不足！")

					return
				end

				local ids = self._curInfosList.selection[data.groupId]

				YuanXiaoKingsExchangeAgent.instance:sendPM_KingsExchangeGetPrizeReq(self._actCfg.activityId, data.groupId, ids)
			end, self)
		end
	end
end

function CollectTangyuanView:_isSelectPrizesFinish(data)
	if data == nil or data.prizeId == nil then
		return true
	end

	local cfg

	for _, id in pairs(data.prizeId) do
		if id and id > 0 then
			cfg = CollectTangyuanConfig.instance:getCollectTangyuanPrizes(self._actCfg.exchangePlan, id)

			if cfg and cfg.limit > checknumber(self._curInfosList.exchangeRecords[id]) then
				return false
			end
		end
	end

	return true
end

function CollectTangyuanView:_getSelectPrizesList(data)
	if data == nil then
		return {}
	end

	local ids = self._curInfosList.selection[data.groupId]

	if ids == nil or #ids == 0 then
		return {}
	end

	local temp = {}

	for _, id in pairs(ids) do
		local cfg = CollectTangyuanConfig.instance:getCollectTangyuanPrizes(self._actCfg.exchangePlan, id)

		if cfg then
			table.insert(temp, cfg)
		end
	end

	if #temp >= 1 then
		table.sort(temp, function(a, b)
			return a.prizeId < b.prizeId
		end)
	end

	return temp
end

function CollectTangyuanView:_onClickBless()
	local taskRed = self._isTaskRed

	self._isTaskRed = false

	RedPointController.instance:saveUserDayRedPoint("c15")
	UIStateManager.instance:push(ViewName.CollectTangyuanTask)

	if taskRed then
		self:_setTaskRedpoint()
	end
end

function CollectTangyuanView:_onClickBtnTips()
	TipsFacade.instance:openRulesView("collecttangyuan")
end

return CollectTangyuanView
