-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/companionmall/view/CompanionMallSelectView.lua

module("logic.extensions.companionmall.view.CompanionMallSelectView", package.seeall)

local CompanionMallSelectView = class("CompanionMallSelectView", ViewComponent)
local CompanionState = {
	HasBuy = 2,
	NotBuy = 4,
	HasReceive = 3,
	SoldOut = 1,
	None = 0
}

function CompanionMallSelectView:ctor()
	CompanionMallSelectView.super.ctor(self)
end

function CompanionMallSelectView:unbindEvents()
	CompanionMallSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function CompanionMallSelectView:bindEvents()
	CompanionMallSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function CompanionMallSelectView:buildUI()
	CompanionMallSelectView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtRemain = self:getTxt("txtRemain")
	self._btnSure = self:getGo("btnSure")

	local goCell = self:getGo("cell")
	local goTab = self:getGo("tableview")

	self._tableview = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function CompanionMallSelectView:onExit()
	CompanionMallSelectView.super.onExit(self)
	self._tableview:dispose()
end

function CompanionMallSelectView:onEnter()
	CompanionMallSelectView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.COMPANION_MALL_GET_INFO, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.COMPANION_MALL_SELECT_ITEM_FINISH, self._handleSelectFinish, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		self._activityId = CompanionMallController.instance:getDefaultActId()
	end

	self._packGroupId = checknumber(params[2])

	if self._packGroupId == 0 then
		self._packGroupId = 1
	end

	self._sortId = checknumber(params[3])

	if self._sortId == 0 then
		self._sortId = 1
	end

	self._curSelectIdList = params[4] or {}

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	CompanionMallController.instance:sendGetInfo(self._activityId)
end

function CompanionMallSelectView:_updateUIByCfg()
	self._curItemCfgs = CompanionMallConfig.instance:getItemGroupCfgs(self._activityId, self._packGroupId) or {}
	self._selectNumLimit = 0

	local packShowCfg = CompanionMallConfig.instance:getPackShowCfg(self._activityId, self._packGroupId, self._sortId)

	if packShowCfg then
		local dealType = packShowCfg.dealType

		if dealType == "single" then
			self._selectNumLimit = 1
		elseif dealType == "pack" then
			local selectPackId = packShowCfg.selectPackId
			local selectPackCfg = CompanionMallConfig.instance:getSelectPackCfg(self._activityId, selectPackId)

			if selectPackCfg then
				self._selectNumLimit = selectPackCfg.selectCount
			end
		elseif dealType == "all" then
			self:close()
		end
	end
end

function CompanionMallSelectView:_updateUIByInfo()
	local info = CompanionMallModel.instance:getInfo(self._activityId) or {}

	self._companionStateMap = {}
	self._companionMap = {}

	if not info.companionInfo then
		for _, companionInfo in ipairs(info.companionInfo) do
			local itemCfg = CompanionMallConfig.instance:getItemCfgById(self._activityId, companionInfo.companionId)
			local state = CompanionState.None

			if itemCfg then
				if companionInfo.hasGainCompanion then
					state = CompanionState.HasReceive
				elseif companionInfo.hasBuyCompanion then
					state = CompanionState.HasBuy
				elseif not companionInfo.curGlobalGainCount then
					local curGlobalGainCount = 0

					state = curGlobalGainCount == -1 and CompanionState.None or curGlobalGainCount >= itemCfg.limitTimes and CompanionState.SoldOut or CompanionState.NotBuy
				end
			end

			self._companionStateMap[companionInfo.companionId] = state
			self._companionMap[companionInfo.companionId] = companionInfo
		end

		self._curSelectCount = 0
		self._curSelectIdMap = {}

		for _, selectId in ipairs(self._curSelectIdList) do
			if not self._companionStateMap[selectId] then
				local state = CompanionState.None

				if state == CompanionState.NotBuy then
					self._curSelectIdMap[selectId] = true
					self._curSelectCount = self._curSelectCount + 1
				end
			end
		end

		self:_updateList()
	end
end

function CompanionMallSelectView:_onClickBtnSure()
	if self._curSelectCount > self._selectNumLimit then
		FloatWordMgr.instance:show(langPara("选择的周边数量不能超过%d个", self._selectNumLimit))

		return
	end

	local selectIdList = {}

	for id, _ in pairs(self._curSelectIdMap) do
		table.insert(selectIdList, id)
	end

	GlobalDispatcher:dispatch(GlobalNotify.COMPANION_MALL_SELECT_ITEM_FINISH, self._sortId, selectIdList)
end

function CompanionMallSelectView:_updateList()
	self._tableview:reloadData(self._curItemCfgs)

	local addColor = self._curSelectCount <= self._selectNumLimit and "#20b376" or "#eb4642"

	self._txtRemain.text = langPara("已经选择：<color=%s>%d</color>/%s", addColor, self._curSelectCount, self._selectNumLimit)
end

function CompanionMallSelectView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local markSelect = goutil.findChild(go, "markSelect")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtCount = goutil.findChildTextComponent(go, "txtCount")
	local txtState = goutil.findChildTextComponent(go, "txtState")
	local item = goutil.findChild(go, "item")

	GameUtil.addClickHandler(go, GameUtil.handler(self._onClickSelect, self, data.companionId), self)
	MaterialMgr.setCellByCfg(data.showItem, item)
	goutil.setActive(markSelect, self._curSelectIdMap[data.companionId] == true)

	local matType, matId, matNum = MaterialMgr.getMatParams(data.showItem)

	txtName.text = MaterialMgr.getMaterialsName(matType, matId)
	txtCount.text = "x" .. matNum

	if not self._companionStateMap[data.companionId] then
		txtState.text = self._companionStateMap[data.companionId] == CompanionState.SoldOut and lang("已售罄") or self._companionStateMap[data.companionId] == CompanionState.HasBuy and lang("已购买") or self._companionStateMap[data.companionId] == CompanionState.HasReceive and lang("已领取") or self._companionStateMap[data.companionId] == CompanionState.NotBuy and lang("未拥有") or ""
	end
end

function CompanionMallSelectView:_clearCell(cell)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(go)
end

function CompanionMallSelectView:_onClickSelect(id)
	if not self._companionStateMap[id] then
		if self._companionStateMap[id] == CompanionState.SoldOut then
			FloatWordMgr.instance:show(lang("该周边已售罄"))

			return
		elseif self._companionStateMap[id] == CompanionState.HasBuy then
			FloatWordMgr.instance:show(lang("您已购买该周边"))

			return
		elseif self._companionStateMap[id] == CompanionState.HasReceive then
			FloatWordMgr.instance:show(lang("您已领取该周边"))

			return
		elseif self._companionStateMap[id] == CompanionState.None then
			FloatWordMgr.instance:show(lang("未有该周边数据"))

			return
		end

		if self._curSelectIdMap[id] then
			self._curSelectIdMap[id] = nil
			self._curSelectCount = self._curSelectCount - 1
		else
			self._curSelectIdMap[id] = true
			self._curSelectCount = self._curSelectCount + 1
		end

		self:_updateList()
	end
end

function CompanionMallSelectView:_handleSelectFinish()
	FloatWordMgr.instance:show(lang("完成选择"))
	self:close()
end

return CompanionMallSelectView
