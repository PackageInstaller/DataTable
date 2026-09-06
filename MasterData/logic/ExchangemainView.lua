-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exchange/view/ExchangemainView.lua

module("logic.extensions.exchange.view.ExchangemainView", package.seeall)

local ExchangemainView = class("ExchangemainView", TableViewComponent)
local json = require("cjson")

function ExchangemainView:ctor()
	ExchangemainView.super.ctor(self)

	self.currTabIndex = false
	self._currLevel1Id = false
	self.currSecTabId = false
	self._dropLineSizeY = 0
end

function ExchangemainView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function ExchangemainView:buildUI()
	ExchangemainView.super.buildUI(self)

	self.winCon = self:getGo("winCon")
	self.subCon = self:getGo("subCon")
	self.goldBarCon = self:getGo("goldBarCon")
	self._closeBtn = self:getBtn("winCon/closeBtn")
	self._tipBtn = self:getBtn("winCon/tipBtn")
	self._bottomBtns = {}
	self._bottomBtnsChange = {}
	self._bottomBtnsDot = {}

	local bottomBtnRoot = self:getGo("bottomBtns/tableview/Viewport/Content")

	for i = 1, bottomBtnRoot.transform.childCount do
		local btn = self:getBtn("bottomBtns/tableview/Viewport/Content/btn_" .. i)

		self._bottomBtns[i] = btn
		self._bottomBtnsDot[i] = goutil.findChild(btn.gameObject, "dot")
		self._bottomBtnsChange[i] = btn.gameObject:GetComponent(ComponentType.UIImageSpriteChange)
	end

	self._dropLineTr = goutil.findChild(self.mainGO, "tableview/Nego_Viewport/Nego_Content/dropLine").transform
	self._dropLineV2 = Vector2.New(166, 0)
	self._dropLineTr.sizeDelta = self._dropLineV2
	self._tabContent = goutil.findChild(self.mainGO, "tableview/Nego_Viewport/Nego_Content").transform
end

function ExchangemainView:bindEvents()
	ExchangemainView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self._onClickClose, self)
	self._tipBtn:AddClickListener(self._onClickTip, self)
end

function ExchangemainView:unbindEvents()
	ExchangemainView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipBtn:RemoveClickListener()
end

function ExchangemainView:onEnter()
	ExchangemainView.super.onEnter(self)
	ExchangeAgent.instance:sendExchangeAllOpenedTabIdsReq()
	self.addGEvent(self, GlobalNotify.ExchangeAllOpenedTabIdsRes, self._forceInitView, self)

	self._ruleKey = "exchangemainview"

	self:_checkJumpParamLegal()
end

function ExchangemainView:onEnterFinished()
	ExchangemainView.super.onEnterFinished(self)
end

function ExchangemainView:onExit()
	ExchangemainView.super.onExit(self)

	self._currLevel1Id = false
	self.currTabIndex = false
	self._currLevel2Id = false
end

function ExchangemainView:_checkJumpParamLegal(params)
	if not params then
		local jumpInTag = self:getFirstParam()

		if jumpInTag then
			params = ExchangeConfig.instance:getJumpInParam(jumpInTag)
		end
	end

	if params then
		local firTabId = params[1]
		local secTabId = params[2]
		local thiTabId = params[3]

		if not firTabId then
			self:_initReEnterTabId()

			return
		end

		local firData = ExchangeConfig.instance:getLevel1TabCfg(firTabId)

		if not firData or not ExchangeModel.instance:_checkOneTabCfgCommonCondition(firData) then
			self:_initReEnterTabId()

			return
		end

		local secData = false

		if secTabId then
			local level2Tabs = ExchangeModel.instance:getLevel2TabCfgs(firTabId)

			for k, v in pairs(level2Tabs) do
				if v.id == secTabId then
					secData = v

					break
				end
			end
		end

		if not string.nilorempty(firData.viewName) then
			secTabId = false
			thiTabId = false
		elseif secData then
			local thiData = false

			if thiTabId then
				local level3Tabs = ExchangeModel.instance:getLevel3TabCfgs(firTabId, secTabId)

				for k, v in pairs(level3Tabs) do
					if v.id == thiTabId then
						thiData = v

						break
					end
				end

				if not thiData then
					thiTabId = false
				end
			end
		else
			secTabId = false
			thiTabId = false
		end

		self._currLevel1Id = firTabId
		self._currLevel2Id = secTabId
		self._currLevel3Id = thiTabId
	else
		self:_initReEnterTabId()
	end
end

function ExchangemainView:_updateRightView()
	local lv2Tabs = self._keyList[self._currLevel2Id]
	local currTabData = lv2Tabs.cfg

	if self._currLevel3Id > 0 and lv2Tabs.leaf and #lv2Tabs.leaf > 0 then
		currTabData = false

		for i, v in ipairs(lv2Tabs.leaf) do
			if v.idx == self._currLevel3Id then
				currTabData = v.cfg

				break
			end
		end
	end

	if not currTabData then
		printError("t_pay_shop_tab_define error", self._currLevel2Id, self._currLevel3Id)

		return
	end

	if not string.nilorempty(currTabData.jumpTo) then
		GotoMgr.gotoByString(currTabData.jumpTo)

		if string.find(currTabData.jumpTo, ViewName.AccconsumeView) then
			self:_onClickClose()
		end

		if currTabData.reportBehavior > 0 then
			SurveyController.instance:reportBehavior(currTabData.reportBehavior)
		end

		return
	end

	self._currTabData = currTabData

	self:_updateView()

	if currTabData.reportBehavior > 0 then
		SurveyController.instance:reportBehavior(currTabData.reportBehavior)
	end

	self:_setSpeMainTopGoldBar()
	self:_setRuleKey()
end

function ExchangemainView:_setSpeMainTopGoldBar()
	local btn_list = {}

	if self._currTabData then
		local list = string.split(self._currTabData.costMats, "#")

		for i, v in ipairs(list) do
			table.insert(btn_list, {
				showAdd = true,
				id = v,
				showAddCallBack = function()
					TipsFacade.instance:openItemSourceView(v, function()
						self:_onClickClose()
					end)
				end
			})
		end
	end

	MainUIController.instance:showGlodBar(self.goldBarCon, self._viewPresentor, btn_list, false)
end

function ExchangemainView:_initLeftTabData(typeId)
	self:_initTabList(typeId)
	self:_updateTabList()
end

function ExchangemainView:_onReloadFinish()
	self._dropLineTr:SetParent(self._tabContent)
	self._dropLineTr:SetAsFirstSibling()
end

function ExchangemainView:_cellSize(view, index)
	local data = self._curViewDatas[index + 1]

	if data.tag == 1 then
		return 100, 65
	end

	return 100, 55
end

function ExchangemainView:_updateCell(view, cell, tabData)
	if tabData.tag == 1 then
		self:_updateRootCell(view, cell, tabData)
	else
		self:_updateLeafCell(view, cell, tabData)
	end

	local newTagGo = goutil.findChild(cell.gameObject, "newTag")

	goutil.setActive(newTagGo, false)
end

function ExchangemainView:_updateRootCell(view, cell, data)
	local selected = data.idx == self._currLevel2Id
	local component = GameUtil.AddLuaOnce(cell.gameObject, ExchangeTabItem)

	if selected then
		local dropLineSizeY = 0

		if data.leaf and #data.leaf > 0 and self._currLevel3Id > 0 then
			dropLineSizeY = 65 + #data.leaf * 55
		end

		self._dropLineV2.y = dropLineSizeY
		self._dropLineTr.sizeDelta = self._dropLineV2

		if dropLineSizeY > 0 then
			self._dropLineTr:SetParent(cell.gameObject.transform)
			GameUtil.setAnchoredPos(self._dropLineTr.gameObject, 0, 0)
		end
	end

	component:setData(self._currLevel1Id, data.cfg, selected, GameUtil.handler(self._onClickRoot, self, data), nil, true)
end

function ExchangemainView:_updateLeafCell(view, cell, data)
	local selected = data.idx == self._currLevel3Id
	local component = GameUtil.AddLuaOnce(cell.gameObject, ExchangeTabItem)

	component:setData(self._currLevel1Id, data.cfg, selected, GameUtil.handler(self._onClickLeaf, self, data))
end

function ExchangemainView:_onClickRoot(data)
	if not ExchangeModel.instance:_checkOneTabCfgCommonCondition(data.cfg, true) then
		FloatWordMgr.instance:show(data.cfg.lockTip)

		return
	end

	if data.idx == self._currLevel2Id and self._currLevel3Id > 0 then
		self._currLevel3Id = 0

		self:_updateTabList()
	else
		self._currLevel2Id = data.idx
		self._currLevel3Id = 0

		if data.leaf and #data.leaf > 0 then
			self._currLevel3Id = data.leaf[1].idx
		end

		self:_updateTabList()
	end
end

function ExchangemainView:_onClickLeaf(data)
	if not ExchangeModel.instance:_checkOneTabCfgCommonCondition(data.cfg, true) then
		FloatWordMgr.instance:show(data.cfg.lockTip)

		return
	end

	self._currLevel3Id = data.idx

	self:reloadData()
	self:_updateRightView()
end

function ExchangemainView:_findLevel2AndLevel3Id()
	local rootIdx = self._currLevel2Id
	local leafIdx = self._currLevel3Id
	local isFindRoot = false

	for i, data in ipairs(self._allTabList) do
		local isNotPreviewOpen = ExchangeModel.instance:_checkOneTabCfgCommonCondition(data.cfg, true)

		if isNotPreviewOpen then
			if not rootIdx then
				isFindRoot = true
				rootIdx = data.idx
				isHit = true

				if data.leaf then
					for ii, vv in ipairs(data.leaf) do
						leafIdx = vv.idx

						break
					end
				end

				break
			end

			if data.idx == rootIdx then
				isFindRoot = true

				if data.leaf then
					for ii, vv in ipairs(data.leaf) do
						if not leafIdx or leafIdx == vv.idx then
							leafIdx = vv.idx

							break
						end
					end
				end
			end
		end
	end

	if isFindRoot then
		self._currLevel2Id = rootIdx
		self._currLevel3Id = leafIdx or 0
	else
		self._currLevel2Id = false
		self._currLevel3Id = false

		self:_findLevel2AndLevel3Id()
	end
end

function ExchangemainView:_updateTabList()
	self:_findLevel2AndLevel3Id()

	local rootIdx = self._currLevel2Id
	local leafIdx = self._currLevel3Id
	local tabList = {}

	for i, v in ipairs(self._allTabList) do
		local data = v

		table.insert(tabList, data)

		if data.idx == rootIdx and leafIdx > 0 and data.leaf then
			for ii, vv in ipairs(data.leaf) do
				table.insert(tabList, vv)
			end
		end
	end

	self._curViewDatas = tabList

	self:reloadData()
	self:_updateRightView()
end

function ExchangemainView:_updateView()
	if self._currTabData then
		if self:_needPopView() then
			UIStateManager.instance:popByName(self._currTabData.viewName)
		end

		local params

		if not string.nilorempty(self._currTabData.param) then
			params = string.split(self._currTabData.param, "#")
		end

		if self:_needAddTabDataInParams() then
			if not params then
				params = {
					0,
					self._currTabData
				}
			else
				table.insert(params, self._currTabData)
			end
		end

		if params then
			self:showTabAt(self.subCon, self._currTabData.viewName, unpack(params))
		else
			self:showTabAt(self.subCon, self._currTabData.viewName)
		end
	end
end

function ExchangemainView:_needAddTabDataInParams()
	return false
end

function ExchangemainView:_needPopView(tabCfg)
	local viewName = self._currTabData.viewName

	return viewName == "baseexchangestack"
end

function ExchangemainView:_onClickTip()
	TipsFacade.instance:openRulesView(self._ruleKey)
end

function ExchangemainView:_initBottomBtns()
	local params = self:getOpenParam()
	local showTabTypes = {}
	local tabTypes = params and params[2] and params[2] or ExchangeModel.instance:getJumpPageParam()

	if tabTypes then
		local temp

		ExchangeModel.instance:recordJumpPageParam(tabTypes)

		if type(tabTypes) == "string" then
			temp = json.decode(tabTypes)
		elseif type(tabTypes) == "table" then
			temp = tabTypes
		end

		if temp and #temp > 0 then
			for i, tabType in ipairs(temp) do
				showTabTypes[checkint(tabType)] = true
			end
		end
	else
		showTabTypes[self._currLevel1Id] = true

		local firData = ExchangeConfig.instance:getLevel1TabCfg(self._currLevel1Id)

		if firData and checkint(firData.tabBelongTo) > 0 then
			local jumpPageCfg = ExchangeConfig.instance:getJumpPageCfg(firData.tabBelongTo)

			if jumpPageCfg then
				if not jumpPageCfg.tabTypes then
					local teamIds = {}

					for k, v in ipairs(teamIds) do
						showTabTypes[v] = true
					end
				end
			end
		end
	end

	local lv1tabCfgs = ExchangeModel.instance:getLevel1TabCfgs()

	for i, v in ipairs(self._bottomBtns) do
		goutil.setActive(v.gameObject, false)
	end

	local sortBtnList = {}

	if not self._currLevel1Id then
		for i, cfg in ipairs(lv1tabCfgs) do
			if ExchangeModel.instance:_checkOneTabCfgCommonCondition(cfg, true) then
				self._currLevel1Id = cfg.type

				break
			end
		end
	end

	local hasShowType = false

	for index, data in ipairs(lv1tabCfgs) do
		local btn = self._bottomBtns[data.type]
		local isPass = true

		if isPass and btn then
			hasShowType = true

			goutil.setActive(btn.gameObject, true)
			btn:AddClickListener(function()
				self._currLevel2Id = false
				self._currLevel3Id = false

				self:_onClickBottomBtn(data)
			end)

			if self._currLevel1Id == data.type then
				self:_onClickBottomBtn(data, true)
			end

			table.insert(sortBtnList, {
				type = data.type
			})
		end
	end

	for i = #sortBtnList, 1, -1 do
		local btn = self._bottomBtns[sortBtnList[i].type]

		if btn then
			btn.transform:SetAsFirstSibling()
		end
	end

	if not hasShowType then
		self._currLevel1Id = false
		self._currLevel2Id = false
		self._currLevel3Id = false

		local data

		for i, cfg in ipairs(lv1tabCfgs) do
			if ExchangeModel.instance:_checkOneTabCfgCommonCondition(cfg, true) then
				data = cfg

				break
			end
		end

		if data then
			self._currLevel1Id = data.type

			local btn = self._bottomBtns[self._currLevel1Id]

			if btn then
				goutil.setActive(btn.gameObject, true)
				btn:AddClickListener(function()
					self._currLevel2Id = false
					self._currLevel3Id = false

					self:_onClickBottomBtn(data)
				end)
				self:_onClickBottomBtn(data, true)
			end
		end
	end
end

function ExchangemainView:_onClickBottomBtn(data, force)
	if not string.nilorempty(data.jumpTo) then
		GotoMgr.gotoByString(data.jumpTo)

		return
	end

	self._currLevel1Id = data.type

	for typeId, v in pairs(self._bottomBtnsChange) do
		v:SetState(typeId == data.type and 1 or 0)
	end

	if data.reportBehavior > 0 then
		SurveyController.instance:reportBehavior(data.reportBehavior)
	end

	if not string.nilorempty(data.viewName) then
		self:showTabAt(self.subCon, data.viewName)
	else
		self.currTabIndex = false

		self:_initLeftTabData(data.type)
	end
end

function ExchangemainView:_initReEnterTabId()
	return
end

function ExchangemainView:_onClickClose()
	self:close()
end

function ExchangemainView:_checkRedDot()
	return
end

function ExchangemainView:_initTabList(typeId)
	local tabCfgs = ExchangeModel.instance:getLevel2TabCfgs(typeId)
	local list = {}
	local keyList = {}

	for key, v in ipairs(tabCfgs) do
		local data = {}

		data.tag = 1
		data.idx = v.id
		data.name = v.name
		data.cfg = v

		local level3TabCfgs = ExchangeModel.instance:getLevel3TabCfgs(typeId, v.id)

		if level3TabCfgs then
			local tempList = {}

			for j, vv in ipairs(level3TabCfgs) do
				local tem = {}

				tem.tag = 2
				tem.idx = vv.id
				tem.name = vv.name
				tem.cfg = vv

				table.insert(tempList, tem)
			end

			data.leaf = tempList
		end

		table.insert(list, data)

		keyList[v.id] = data
	end

	self._allTabList = list
	self._keyList = keyList

	print(">>>>>>>>>>>>>>>>>>>>>>>>兑换main", #self._allTabList)
end

function ExchangemainView:_payResult(stutas)
	if stutas == 0 then
		self:_forceUpdateView()
	end
end

function ExchangemainView:_forceUpdateView()
	self:_checkJumpParamLegal({
		self._currLevel1Id,
		self._currLevel2Id,
		self._currLevel3Id
	})
	self:_initBottomBtns()
end

function ExchangemainView:_forceInitView()
	self:_checkJumpParamLegal()
	self:_initBottomBtns()
end

function ExchangemainView:_clearTableview(cell)
	return
end

function ExchangemainView:_setRuleKey()
	self._ruleKey = self._currTabData and not string.nilorempty(self._currTabData.ruleKey) and self._currTabData.ruleKey or "exchangemainview"
end

return ExchangemainView
