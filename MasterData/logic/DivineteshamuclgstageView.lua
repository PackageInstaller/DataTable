-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineteshamuclg/view/DivineteshamuclgstageView.lua

module("logic.extensions.divineteshamuclg.view.DivineteshamuclgstageView", package.seeall)

local DivineteshamuclgstageView = class("DivineteshamuclgstageView", ViewComponent)

function DivineteshamuclgstageView:ctor()
	DivineteshamuclgstageView.super.ctor(self)
end

function DivineteshamuclgstageView:unbindEvents()
	DivineteshamuclgstageView.super.unbindEvents(self)
	self._btnDesc:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnReset:RemoveClickListener()

	for i, v in pairs(self._cellItems) do
		v.btn:RemoveClickListener()
	end
end

function DivineteshamuclgstageView:bindEvents()
	DivineteshamuclgstageView.super.bindEvents(self)
	self._btnDesc:AddClickListener(self._onClickbtnDesc, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnReset:AddClickListener(self._onClickbtnReset, self)
end

function DivineteshamuclgstageView:buildUI()
	DivineteshamuclgstageView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._btnDesc = self:getBtn("btnDesc")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._itemConGo = self:getGo("rule/item/con")
	self._receiveGo = self:getGo("rule/item/receive")
	self._txtDesc = self:getTxt("rule/txtDesc")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._cellconGo = self:getGo("cellcon")
	self._cellGo = self:getGo("cell")
	self._btnReset = self:getBtn("btnReset")
	self._lineGo1 = self:getGo("line1")
	self._lineGo2 = self:getGo("line2")

	goutil.setActive(self._cellGo, false)
	goutil.setActive(self._lineGo1, false)
	goutil.setActive(self._lineGo2, false)
end

function DivineteshamuclgstageView:_createCells(posCfgs)
	self._cellItems = self._cellItems or {}

	for i = 0, #posCfgs do
		if not self._cellItems[i] then
			local go = goutil.cloneAndSetParent(self._cellGo, self._cellconGo.transform)

			goutil.setActive(go, true)

			self._cellItems[i] = {
				go = go,
				btn = Framework.ButtonAdapter.Get(go)
			}

			self._cellItems[i].btn:AddClickListener(GameUtil.handler(self._onClickItemCell, self, posCfgs[i].cellId))
		end
	end
end

function DivineteshamuclgstageView:onExit()
	DivineteshamuclgstageView.super.onExit(self)
	self._scrollerList:dispose()
	MaterialMgr.resetAll(self._itemConGo)
end

function DivineteshamuclgstageView:onEnter()
	DivineteshamuclgstageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineTeshamuResetFloorRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.DivineTeshamuAdvanceRes, self._onDivineTeshamuAdvanceRes, self)
	self.addGEvent(self, GlobalNotify.DivineTeshamuInfoRes, self._updateUI, self)

	self._activityId = self:getFirstParam()
	self._prizeCfgs = DivineteshamuclgConfig.instance:getPrizeCfgs(self._activityId)

	self:_updateUI()
	DivineteshamuclgController.instance:showChangeSet()
end

function DivineteshamuclgstageView:_onClickbtnDesc()
	UIStateManager.instance:push(ViewName.DivineteshamuclgtipsView, self._activityId)
end

function DivineteshamuclgstageView:_onClickbtnClose()
	self:close()
end

function DivineteshamuclgstageView:_onClickbtnTip()
	local challengeCfg = DivineteshamuclgController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function DivineteshamuclgstageView:_updateUI()
	self._info = DivineteshamuclgModel.instance:getInfo(self._activityId)

	if not self._info then
		return
	end

	self:_preHandleInfo()
	self._scrollerList:reloadData(self._prizeCfgs)

	local isHit = false

	for i, v in ipairs(self._prizeCfgs) do
		if not self._info_map[v.floorId].isFirstPass then
			isHit = true

			self:_onClickTabCell(v.floorId)

			break
		end
	end

	if not isHit then
		self:_onClickTabCell(self._prizeCfgs[#self._prizeCfgs].floorId)
	end
end

function DivineteshamuclgstageView:_updateRule()
	local cfg = DivineteshamuclgConfig.instance:getPrizeCfg(self._activityId, self._curFloorId)
	local isGain = self._info_map[self._curFloorId].isFirstPass

	self._txtDesc.text = cfg.ruleDesc

	MaterialMgr.setCellByCfg(cfg.prize, self._itemConGo)
	goutil.setActive(self._receiveGo, isGain)
end

function DivineteshamuclgstageView:_updateItems()
	local cfgs = DivineteshamuclgConfig.instance:getStageCellPosCfgs(self._activityId, self._curFloorId)

	self:_createCells(cfgs)

	for i, v in pairs(self._cellItems) do
		goutil.setActive(v.go, false)
	end

	for i = 0, #cfgs do
		local go = self._cellItems[i].go

		self:_updateItem(go, cfgs[i].cellId)
		goutil.setActive(go, true)
	end

	self:_updateLines()
end

function DivineteshamuclgstageView:_updateItem(go, cellId)
	local goHead = goutil.findChild(go, "head/con")
	local headRoot = goutil.findChild(go, "head")
	local txtHead = goutil.findChildTextComponent(go, "head/txtHead")
	local goPass = goutil.findChild(go, "pass")
	local goQizi = goutil.findChild(go, "qizi")
	local txtDesc = goutil.findChildTextComponent(go, "desc/bg/txtDesc")
	local goQidian = goutil.findChild(go, "desc/qidian")
	local uiChange = goutil.findChild(go, "bg"):GetComponent(ComponentType.UIImageSpriteChange)

	HeadItemController.instance:resetHeadCell(goHead)

	local posCfg = DivineteshamuclgConfig.instance:getStageCellPosCfg(self._activityId, self._curFloorId, cellId)
	local curStageId = self._info_map[self._curFloorId].curStageId
	local isPass = cellId == 0 or cellId > 0 and DivineteshamuclgModel.instance:isStagePass(self._activityId, self._curFloorId, cellId)
	local cfg = DivineteshamuclgConfig.instance:getStageCfg(self._activityId, self._curFloorId, cellId)
	local isInStart = curStageId == 1 and cellId == 0 and not DivineteshamuclgModel.instance:isStagePass(self._activityId, self._curFloorId, curStageId)
	local isShowHead = isInStart or isPass and curStageId == cellId

	goutil.setActive(headRoot, isShowHead)

	if isShowHead then
		HeadItemController.instance:setMyHeadCell(goHead)

		local count = DivineteshamuclgModel.instance:getSoldierCount(self._activityId, self._curFloorId)

		txtHead.text = string.format("我的士兵：%s", count)
	end

	local state = 0
	local descStr = ""
	local isStart = false

	if cellId == 0 then
		state = 0
		descStr = "起点"
		isStart = true
	elseif not cfg.canJumpId then
		state = 2
		descStr = string.format("驻兵：%s\n目标点", cfg.soldierCount)
	else
		state = 1
		descStr = string.format("驻兵：%s", cfg.soldierCount)
	end

	txtDesc.text = descStr

	uiChange:SetState(state)
	goutil.setActive(goPass, isPass and cellId ~= 0)
	goutil.setActive(goQizi, cellId > 0 and not cfg.canJumpId)
	goutil.setActive(goQidian, isStart)
	Framework.TransformUtil.SetAnchoredPos(go.transform, posCfg.pos[1], posCfg.pos[2])
end

function DivineteshamuclgstageView:_updateLines()
	self._lineGos = self._lineGos or {}

	for i, v in ipairs(self._lineGos) do
		goutil.destroy(v)
	end

	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()
	local cfgs = DivineteshamuclgConfig.instance:getStageCfgsByFloorId(self._activityId, self._curFloorId)
	local stageCnt = #cfgs

	for cellId, v in pairs(self._cellItems) do
		if cellId <= stageCnt then
			local stageId = cellId
			local pos = v.go.transform.position
			local screenPos1 = uiCamera:WorldToScreenPoint(pos)
			local isStagePass = cellId == 0 or DivineteshamuclgModel.instance:isStagePass(self._activityId, self._curFloorId, stageId)
			local canJumpId

			if cellId == 0 then
				canJumpId = {
					1
				}
			else
				local stageCfg = DivineteshamuclgConfig.instance:getStageCfg(self._activityId, self._curFloorId, stageId)

				canJumpId = stageCfg.canJumpId
			end

			if canJumpId then
				for i, targetStageId in ipairs(canJumpId) do
					local target = self._cellItems[targetStageId]
					local posTarget = target.go.transform.position
					local screenPos2 = uiCamera:WorldToScreenPoint(posTarget)
					local centerScreenPos = (screenPos1 + screenPos2) / 2
					local posCenter = uiCamera:ScreenToWorldPoint(centerScreenPos)
					local cloneLine = goutil.cloneAndSetParent((isStagePass or nil) and self._lineGo2, self._cellconGo.transform)

					table.insert(self._lineGos, cloneLine)
					Framework.TransformUtil.SetPos(cloneLine.transform, posCenter.x, posCenter.y, posCenter.z)

					local direction = screenPos2 - screenPos1
					local angle = Mathf.Atan2(direction.y, direction.x) * Mathf.Rad2Deg

					Framework.TransformUtil.SetEuler(cloneLine.transform, 0, 0, angle - 90)
					goutil.setActive(cloneLine, true)
				end
			end
		end
	end
end

function DivineteshamuclgstageView:_updateCell(view, cell, data, tag)
	local goLockGo = goutil.findChild(cell.gameObject, "btn/lockGo")
	local goPassGo = goutil.findChild(cell.gameObject, "btn/passGo")
	local goSelect = goutil.findChild(cell.gameObject, "btn/select")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "btn/txtName")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local isPass = self._info_map[data.floorId].isFirstPass
	local isLock = data.floorId > 1 and not self._info_map[data.floorId - 1].isFirstPass
	local isSelect = true

	goto label_16_0

	::label_16_0::

	local isLastFirstPass = data.floorId > 1 and data.floorId == #self._prizeCfgs and self._info_map[data.floorId].isFirstPass

	txtName.text = string.format("第%s层", data.floorId)

	goutil.setActive(goSelect, isSelect or isLastFirstPass)
	goutil.setActive(goPassGo, isPass)
	goutil.setActive(goLockGo, isLock)
	btn:AddClickListener(function()
		self:_onClickTabCell(data.floorId)
	end)
end

function DivineteshamuclgstageView:_onClickTabCell(floorId, force)
	local cfgs = DivineteshamuclgConfig.instance:getStageCfgsByFloorId(self._activityId, floorId)
	local prizeCfgs = DivineteshamuclgConfig.instance:getPrizeCfgs(self._activityId)
	local preFloorId = floorId - 1

	if preFloorId > 0 and not self._info_map[preFloorId].isFirstPass then
		FloatWordMgr.instance:show("通关上一层开启")

		return
	end

	if self._info_map[floorId].isFirstPass and not force and floorId < #prizeCfgs then
		FloatWordMgr.instance:show("已通关")

		return
	end

	self._curFloorId = floorId

	self._scrollerList:refresh()
	self:_updateRule()
	self:_updateItems()
end

function DivineteshamuclgstageView:_clearCell(cell)
	return
end

function DivineteshamuclgstageView:_preHandleInfo()
	self._info_map = {}

	for i, v in ipairs(self._info.divineTeshamuFloorInfos) do
		self._info_map[v.floorId] = v
	end
end

function DivineteshamuclgstageView:_onClickbtnReset()
	if not self._info_map then
		return
	end

	if not DivineteshamuclgModel.instance:hasStagePass(self._activityId, self._curFloorId) then
		FloatWordMgr.instance:show("无需重置")

		return
	end

	local content = "是否将全部关卡重置为未挑战"

	TipsFacade.instance:openPopupWindow("提示", content, function()
		DivineTeshamuAgent.instance:sendPM_DivineTeshamuResetFloorReq(self._activityId, self._curFloorId)
	end)
end

function DivineteshamuclgstageView:_onClickItemCell(cellId)
	if not self._info_map then
		return
	end

	local curStageId = self._info_map[self._curFloorId].curStageId

	if cellId == 0 then
		FloatWordMgr.instance:show("起点无需挑战")

		return
	end

	local stageId = cellId
	local curStagePass = DivineteshamuclgModel.instance:isStagePass(self._activityId, self._curFloorId, curStageId)

	if not curStagePass and curStageId == 1 and stageId == 1 then
		self:_enterMissionView(stageId)

		return
	end

	if not curStagePass then
		FloatWordMgr.instance:show("需要先通过前置关卡")

		return
	end

	if curStageId == stageId then
		FloatWordMgr.instance:show("当前关卡已通过")

		return
	end

	local canJump = false
	local canJumpId

	if cellId == 0 then
		canJumpId = {
			1
		}
	else
		local stageCfg = DivineteshamuclgConfig.instance:getStageCfg(self._activityId, self._curFloorId, curStageId)

		canJumpId = stageCfg.canJumpId
	end

	if canJumpId then
		for i, targetStageId in ipairs(canJumpId) do
			if targetStageId == stageId then
				canJump = true

				local stagePass = DivineteshamuclgModel.instance:isStagePass(self._activityId, self._curFloorId, targetStageId)

				if not stagePass then
					self:_enterMissionView(stageId)

					break
				end

				DivineTeshamuAgent.instance:sendPM_DivineTeshamuAdvanceReq(self._activityId, self._curFloorId, targetStageId)

				break
			end
		end
	end

	if not canJump then
		FloatWordMgr.instance:show("当前关卡无法到达")

		return
	end
end

function DivineteshamuclgstageView:_enterMissionView(stageId)
	local mo = DivineteshamuclgModel.instance:getFmtMo()

	mo:initParams(self._activityId, self._curFloorId, stageId)
	CustomFmtController.instance:showMissionView(mo)
end

function DivineteshamuclgstageView:_onDivineTeshamuAdvanceRes()
	self:_updateUI()
end

return DivineteshamuclgstageView
