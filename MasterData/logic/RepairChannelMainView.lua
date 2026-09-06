-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/repairchannel/view/RepairChannelMainView.lua

module("logic.extensions.repairchannel.view.RepairChannelMainView", package.seeall)

local RepairChannelMainView = class("RepairChannelMainView", ViewComponent)
local BranchCellCount = 2

function RepairChannelMainView:ctor()
	RepairChannelMainView.super.ctor(self)
end

function RepairChannelMainView:unbindEvents()
	RepairChannelMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnPortal1)
	GameUtil.rmClickHandler(self._btnPortal2)
	GameUtil.rmClickHandler(self._btnRepair)
	BeginDragHandler.Get(self._map):RemoveLuaHandler(self._beginDragHandler)
	EndDragHandler.Get(self._map):RemoveLuaHandler(self._endDragHandler)
	DragHandler.Get(self._map):RemoveLuaHandler(self._dragHandler)
end

function RepairChannelMainView:bindEvents()
	RepairChannelMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, 1))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, 2))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, 3))
	GameUtil.addClickHandler(self._btnPortal1, GameUtil.handler(self._onClickBtnPortal, self, 1))
	GameUtil.addClickHandler(self._btnPortal2, GameUtil.handler(self._onClickBtnPortal, self, 2))
	GameUtil.addClickHandler(self._btnRepair, self._onClickBtnRepair, self)

	self._beginDragHandler = BeginDragHandler.Get(self._map):AddLuaHandler(function(_go, eventData)
		self:_onDragBeginHandler(_go, eventData)
	end)
	self._endDragHandler = EndDragHandler.Get(self._map):AddLuaHandler(function(_go, eventData)
		self:_onDragEndHandler(_go, eventData)
	end)
	self._dragHandler = DragHandler.Get(self._map):AddLuaHandler(function(_go, eventData)
		self:_onDragHandler(_go, eventData)
	end)
end

function RepairChannelMainView:buildUI()
	RepairChannelMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._btnPortal1 = self:getGo("map/btnPortal1")
	self._btnPortal2 = self:getGo("map/btnPortal2")
	self._nodeRepair = self:getGo("map/nodeRepair")
	self._btnRepair = self:getGo("map/nodeRepair/btnRepair")
	self._markPass = self:getGo("map/nodeRepair/markPass")
	self._nodeRepairCopy = self:getGo("nodeRepairCopy")
	self._conNodes = self:getGo("map/conNodes")

	goutil.setActive(self._nodeRepairCopy, false)

	self._redpoint = self:getGo("jumpBtnCol/btnJump3/redpoint")
	self._map = self:getGo("map")
end

function RepairChannelMainView:onExit()
	RepairChannelMainView.super.onExit(self)
	GameUtil.clearCells(self._conNodes, self._clearNodeCell, self)
end

function RepairChannelMainView:onEnter()
	RepairChannelMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_RepairChannelGetInfoRes, self._updateUIByInfo, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = RepairChannelController.instance:getDefaultActivityId() or 0
	end

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	RepairChannelController.instance:getInfo(self._activityId)
	self:moveMapToXandY(self._originPos[1], self._originPos[2])
	RedPointController.instance:regRedPoint(self._redpoint, RedPointModel.ID_REPAIR_CHANNEL)
end

function RepairChannelMainView:_updateUIByCfg()
	self._actCfg = RepairChannelConfig.instance:getActCfgByActId(self._activityId) or {}
	self._btnJumpToStrs = self._actCfg.btnJumpToStrs or {}
	self._portalJumpToStrs = self._actCfg.portalJumpToStrs or {}

	if not self._actCfg.storyId then
		local storyId = 0

		if storyId > 0 then
			local userDataKey = string.format("RepairChannel_%d_IsPlayed_Story", self._activityId)
			local hasPlayed = checknumber(GameUtil.getUserData(userDataKey)) > 0

			if not hasPlayed then
				GameUtil.saveUserData(userDataKey, 1)
				GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
			end
		end

		self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

		local branchCount = RepairChannelConfig.instance:getBranchCountByActId(self._activityId)

		self._totalBranchCount = branchCount
		self._branchNodeCountMap = {}

		for branchId = 1, branchCount do
			local nodeCfgList = RepairChannelConfig.instance:getNodeCfgsByBranchId(self._activityId, branchId) or {}

			self._branchNodeCountMap[branchId] = #nodeCfgList
		end

		self._moveArea = self._actCfg.moveArea or {
			-200,
			200,
			-150,
			150
		}
		self._originPos = self._actCfg.originPos or {
			0,
			0
		}

		GameUtil.setAnchoredPos(self._nodeRepair, -self._originPos[1], -self._originPos[2])

		self._nodeCfgList = RepairChannelConfig.instance:getNodeCfgListByActId(self._activityId) or {}

		if branchCount > BranchCellCount then
			printError("分支数量超过预设上限，当前分支数量:", branchCount, "预设上限:", BranchCellCount)
			self:close()

			return
		end
	end
end

function RepairChannelMainView:_updateUIByInfo()
	self._isAllPass = false

	local matchCount = 0

	self._repairProgressMap = RepairChannelModel.instance:getBranchProgressMap(self._activityId) or {}

	for branchId, progress in pairs(self._repairProgressMap) do
		if not self._branchNodeCountMap[branchId] then
			if self._branchNodeCountMap[branchId] <= progress and self._branchNodeCountMap[branchId] > 0 then
				matchCount = matchCount + 1
			end
		end
	end

	self._isAllPass = matchCount == self._totalBranchCount and self._totalBranchCount > 0

	GameUtil.updateCellsList(self._conNodes, self._nodeRepairCopy, self._nodeCfgList, self._updateNodeCell, self)
	goutil.setActive(self._markPass, self._isAllPass)

	if self._isAllPass then
		GameUtil.setAnchoredPos(self._map, 0, -130)
	end
end

function RepairChannelMainView:_onClickBtnTip()
	if not self._actCfg.ruleKey then
		TipsFacade.instance:openRulesView(self._actCfg.ruleKey)
	end
end

function RepairChannelMainView:_onClickBtnJump(index)
	if not self._btnJumpToStrs[index] then
		if not GameUtil.isEmptyString(self._btnJumpToStrs[index]) then
			GotoMgr.gotoByString(self._btnJumpToStrs[index])
		end
	end
end

function RepairChannelMainView:_onClickBtnPortal(index)
	local branchId = index

	if not self._repairProgressMap[branchId] then
		if not self._branchNodeCountMap[branchId] then
			local nodeCount = 0

			if self._repairProgressMap[branchId] < nodeCount or nodeCount == 0 then
				TipsFacade.instance:openCommonTips(lang("道路尚未修复完成，无法使用传送门"))

				return
			end

			if not self._portalJumpToStrs[index] then
				local jumpToStr = ""

				if not GameUtil.isEmptyString(jumpToStr) then
					GotoMgr.gotoByString(jumpToStr)
				end
			end
		end
	end
end

function RepairChannelMainView:_onDragBeginHandler(go, delta)
	local vec = goutil.screenToLocalPos(delta.position, self._map.transform)
	local pos = self._map.transform:TransformPoint(vec)

	self._dragOffset = self._map.transform:InverseTransformPoint(pos) or Vector3.zero
end

function RepairChannelMainView:_onDragHandler(go, delta)
	local vec = goutil.screenToLocalPos(delta.position, self.mainGO.transform)
	local pos = self.mainGO.transform:TransformPoint(vec)
	local localPos = self.mainGO.transform:InverseTransformPoint(pos) or Vector3.zero

	localPos = localPos - self._dragOffset

	self:moveMapToXandY(localPos.x, localPos.y)
end

function RepairChannelMainView:_onDragEndHandler(go, delta)
	return
end

function RepairChannelMainView:_onClickBtnRepair()
	self:moveMapToXandY(self._originPos[1], self._originPos[2])

	if self._isAllPass then
		TipsFacade.instance:openCommonTips(lang("已经全部修复完成了哦"))

		return
	end

	UIStateManager.instance:push(ViewName.RepairChannelDetailView, self._activityId)
end

function RepairChannelMainView:moveMapToXandY(x, y)
	local clampedX = Mathf.Clamp(x, checknumber(self._moveArea[1]), checknumber(self._moveArea[2]))
	local clampedY = Mathf.Clamp(y, checknumber(self._moveArea[3]), checknumber(self._moveArea[4]))

	GameUtil.setAnchoredPos(self._map, clampedX, clampedY)
end

function RepairChannelMainView:_onClickNode(nodeCfg)
	if not nodeCfg.branchId then
		if not nodeCfg.nodeId then
			local nodeId = 0

			if not self._repairProgressMap[nodeCfg.branchId] then
				local repairedNodeId = 0

				if not nodeCfg.pos then
					local pos = {
						0,
						0
					}

					self:moveMapToXandY(-pos[1], -pos[2])

					if nodeId < repairedNodeId + 1 then
						TipsFacade.instance:openCommonTips(lang("该节点已修复完成了哦"))

						return
					elseif nodeId > repairedNodeId + 1 then
						TipsFacade.instance:openCommonTips(lang("请按照顺序修复哦"))

						return
					end

					UIStateManager.instance:push(ViewName.RepairChannelDetailView, self._activityId, nodeCfg)
				end
			end
		end
	end
end

function RepairChannelMainView:_updateNodeCell(nodeGo, nodeCfg)
	if not nodeCfg.nodeId then
		local nodeId = 0

		if not nodeCfg.branchId then
			local branchId = 0

			if not self._repairProgressMap[branchId] then
				local repairedNodeId = 0

				if not nodeCfg.pos then
					local pos = {
						0,
						0
					}

					if not nodeCfg.nodeName then
						local nodeName = ""
						local isRepaired = nodeId <= repairedNodeId and repairedNodeId ~= 0

						GameUtil.SetGray(nodeGo, not isRepaired)

						for i = 1, BranchCellCount do
							local btnRepair = goutil.findChild(nodeGo, string.format("btnRepair%s", i))
							local txt = goutil.findChildTextComponent(btnRepair, "txt")

							txt.text = nodeName

							goutil.setActive(btnRepair, i == branchId)
							GameUtil.addClickHandler(btnRepair, GameUtil.handler(self._onClickNode, self, nodeCfg), self)
						end

						GameUtil.setAnchoredPos(nodeGo, pos[1], pos[2])
					end
				end
			end
		end
	end
end

function RepairChannelMainView:_clearNodeCell(nodeGo)
	for i = 1, BranchCellCount do
		local btnRepair = goutil.findChild(nodeGo, string.format("btnRepair%s", i))

		GameUtil.rmClickHandler(btnRepair)
	end
end

return RepairChannelMainView
