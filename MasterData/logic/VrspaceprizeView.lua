-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vrspace/view/VrspaceprizeView.lua

module("logic.extensions.vrspace.view.VrspaceprizeView", package.seeall)

local VrspaceprizeView = class("VrspaceprizeView", ViewComponent)

VrspaceprizeView.TAB_MODE_1 = 0
VrspaceprizeView.TAB_MODE_2 = 1

function VrspaceprizeView:buildUI()
	VrspaceprizeView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	self._rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")
	self._itemScrollercell = goutil.findChild(self.mainGO, "rankCol/itemScrollercell")
	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)

	self._btnTab1 = self:getGo("btnTab1")
	self._changeGroup1 = self._btnTab1:GetComponent(ComponentType.UIChangeGroup)
	self._btnTab2 = self:getGo("btnTab2")
	self._changeGroup2 = self._btnTab2:GetComponent(ComponentType.UIChangeGroup)
	self._txtTips = self:getTxt("tips/txt")
end

function VrspaceprizeView:bindEvents()
	VrspaceprizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTab1, self._onClickTab1, self)
	GameUtil.addClickHandler(self._btnTab2, self._onClickTab2, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function VrspaceprizeView:unbindEvents()
	VrspaceprizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTab1)
	GameUtil.rmClickHandler(self._btnTab2)
	GameUtil.rmClickHandler(self._btnClose)
end

function VrspaceprizeView:onEnter()
	VrspaceprizeView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		FloatWordMgr.instance:show("缺失活动id")

		return
	end

	self._mode = VrspaceprizeView.TAB_MODE_1

	self.addGEvent(self, GlobalNotify.VR_SPACE_INFO_UPDATE, self._onRefreshUI, self)
	VRSpaceController.instance:sendGetInfo(self._activityId)
	self:_onRefreshUI()
end

function VrspaceprizeView:onExit()
	VrspaceprizeView.super.onExit(self)
	self._rankScrollList:dispose()
end

function VrspaceprizeView:_onRefreshUI()
	self._info = VRSpaceModel.instance:getInfo(self._activityId) or {}

	if not self._info.modeInfos then
		local modeInfos = {}

		self._modeInfoMap = {}

		for i, v in ipairs(modeInfos) do
			self._modeInfoMap[v.mode] = v
		end

		self._stageInfoMap = {}

		if not self._modeInfoMap[self._mode] then
			for i, v in ipairs((not self._modeInfoMap[self._mode].virtualStageInfos or nil) and {}) do
				self._stageInfoMap[v.stageId] = v
			end

			self._everPassRealityStageId = checknumber(self._modeInfoMap[self._mode].everPassRealityStageId)

			self:_updateTabInfo()
			self:_onUpdateRankScrollerList()
		end
	end
end

function VrspaceprizeView:_onUpdateRankScrollerList()
	local list = {}
	local vplanCfg = VRSpaceConfig.instance:getPlanCfgById(self._activityId, self._mode, 0) or {}
	local vstagePlanId = checknumber(vplanCfg.stagePlanId)
	local vlist = VRSpaceConfig.instance:getStageCfgListById(vstagePlanId) or {}

	for i, v in ipairs(vlist) do
		local tem = {}

		tem.name = langPara("虚拟-第%s关", v.stageId)
		tem.type = 0
		tem.cfg = v

		table.insert(list, tem)
	end

	local rplanCfg = VRSpaceConfig.instance:getPlanCfgById(self._activityId, self._mode, 1) or {}
	local rstagePlanId = checknumber(rplanCfg.stagePlanId)
	local rlist = VRSpaceConfig.instance:getStageCfgListById(rstagePlanId) or {}

	for i, v in ipairs(rlist) do
		local tem = {}

		tem.name = langPara("现实-第%s关", v.stageId)
		tem.type = 1
		tem.cfg = v

		table.insert(list, tem)
	end

	self._rankScrollList:reloadData(list)
end

function VrspaceprizeView:_updateRankCell(view, cell, data, tag)
	local txtRankRange = goutil.findChildTextComponent(cell, "txtRankRange")
	local itemScrollerview = goutil.findChild(cell, "itemScrollerview")
	local txtNotFinish = goutil.findChild(cell, "state/txtNotFinish")
	local txtReceived = goutil.findChild(cell, "state/txtReceived")

	txtRankRange.text = data.name

	if itemScrollerview and self._itemScrollercell then
		local prizeStrArr = string.split(data.cfg.prize, "#")

		if not self._itemScrollListDic[cell] then
			local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[cell] = self._itemScrollListDic[cell]

			self._itemScrollListDic[cell]:reloadData(prizeStrArr)
			self._itemScrollListDic[cell]:dragNotifyParent()
		end
	end

	GameUtil.SetActive(txtNotFinish, false)
	GameUtil.SetActive(txtReceived, false)

	if data.type == 0 then
		GameUtil.SetActive(txtNotFinish, self._stageInfoMap[data.cfg.stageId] == nil)
		GameUtil.SetActive(txtReceived, self._stageInfoMap[data.cfg.stageId] ~= nil)
	else
		GameUtil.SetActive(txtNotFinish, self._everPassRealityStageId < data.cfg.stageId)
		GameUtil.SetActive(txtReceived, self._everPassRealityStageId >= data.cfg.stageId)
	end
end

function VrspaceprizeView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function VrspaceprizeView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function VrspaceprizeView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function VrspaceprizeView:_updateTabInfo()
	self._changeGroup1:SetState(self._mode == VrspaceprizeView.TAB_MODE_1 and 1 or 0)
	self._changeGroup2:SetState(self._mode == VrspaceprizeView.TAB_MODE_2 and 1 or 0)
end

function VrspaceprizeView:_onClickTab1()
	self._mode = VrspaceprizeView.TAB_MODE_1

	self:_onRefreshUI()
end

function VrspaceprizeView:_onClickTab2()
	self._mode = VrspaceprizeView.TAB_MODE_2

	self:_onRefreshUI()
end

return VrspaceprizeView
