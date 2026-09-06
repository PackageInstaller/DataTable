-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaruishiclg/view/OriginaruishiclgstageView.lua

module("logic.extensions.originaruishiclg.view.OriginaruishiclgstageView", package.seeall)

local OriginaruishiclgstageView = class("OriginaruishiclgstageView", ViewComponent)

function OriginaruishiclgstageView:ctor()
	OriginaruishiclgstageView.super.ctor(self)
end

function OriginaruishiclgstageView:unbindEvents()
	OriginaruishiclgstageView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function OriginaruishiclgstageView:bindEvents()
	OriginaruishiclgstageView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function OriginaruishiclgstageView:buildUI()
	OriginaruishiclgstageView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrViewInRule = self:getGo("infoCol/txtRule")
	self._txtRule = self:getTxt("infoCol/txtRule/Viewport/Content")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._rewardGo = self:getGo("reward")
	self._txtReward = self:getTxt("reward/txtReward")
	self._strTxtReward = self._txtReward.text
	self._prizeItem = self:getGo("reward/prizeItem")
	self._tagHasGain = self:getGo("reward/tagHasGain")
end

function OriginaruishiclgstageView:onExit()
	OriginaruishiclgstageView.super.onExit(self)
	self._scrollerList:dispose()
	MaterialMgr.resetAll(self._prizeItem)
end

function OriginaruishiclgstageView:onEnter()
	OriginaruishiclgstageView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._selctFloorId = OriginaruishiclgController.instance:getLastSelectFloorId()

	if self._selctFloorId <= 0 then
		self._selctFloorId = 1
	end

	if OriginaruishiclgModel.instance:isFloorPass(self._activityId, self._selctFloorId) then
		local floorCfgs = OriginaruishiclgConfig.instance:getFloorCfgs(self._activityId) or {}

		for floorId, stageDataList in ipairs(floorCfgs) do
			self._selctFloorId = floorId

			local isPass = OriginaruishiclgModel.instance:isFloorPass(self._activityId, floorId)

			if not isPass then
				break
			end
		end
	end

	self:_updateUI()
end

function OriginaruishiclgstageView:_onClickbtnTip()
	local challengeCfg = OriginaruishiclgController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function OriginaruishiclgstageView:_onClickbtnClose()
	self:close()
end

function OriginaruishiclgstageView:_updateUI()
	local floorCfgs = OriginaruishiclgConfig.instance:getFloorCfgs(self._activityId) or {}

	self._scrollerList:reloadData(floorCfgs)

	if self._selctFloorId > 0 then
		local passNum, totalNum = OriginaruishiclgModel.instance:getFloorPassNum(self._activityId, self._selctFloorId)
		local stageCfgs = OriginaruishiclgConfig.instance:getFloorCfg(self._activityId, self._selctFloorId)
		local curIdx = Mathf.Min(passNum + 1, #stageCfgs)
		local stageData = stageCfgs[curIdx]

		if stageData then
			if not stageData.creepsMasterId then
				local creepsMasterId = 0
				local masterData = OriginaruishiclgConfig.instance:getCreepsMasterCfg(creepsMasterId)

				if masterData then
					self._txtRule.text = masterData.WinDesc or "暂无"
				end
			end
		end
	else
		self._txtRule.text = "暂无"
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._txtRule.gameObject:GetComponent(goutil.Type_RectTransform))

	self._scrViewInRule:GetComponent(ComponentType.ScrollRect).verticalNormalizedPosition = 1

	self:_updateReward()
end

function OriginaruishiclgstageView:_updateCell(view, cell, stageCfgs, tag)
	local index = cell.data
	local posA = goutil.findChild(cell.gameObject, "posA")
	local posB = goutil.findChild(cell.gameObject, "posB")
	local goLock = goutil.findChild(cell.gameObject, "node/lock")
	local goNode = goutil.findChild(cell.gameObject, "node")
	local goPass = goutil.findChild(cell.gameObject, "node/pass")
	local goSelect = goutil.findChild(cell.gameObject, "node/select")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "node/txtName")
	local txtNum = goutil.findChildTextComponent(cell.gameObject, "node/txtNum")
	local posGo = index % 2 == 0 and posA or posB
	local x, y, z = Framework.TransformUtil.GetLocalPos(posGo.transform, 0, 0, 0)

	GameUtil.setLocalPos(goNode, x, y, z)

	local dataList = self._scrollerList:getData()

	GameUtil.setUIGroupIdx(goNode, (index - 1) % #dataList + 1 - 1)

	local curStageCfg = stageCfgs[1]
	local isPass = OriginaruishiclgModel.instance:isFloorPass(self._activityId, curStageCfg.floorId)
	local passNum, totalNum = OriginaruishiclgModel.instance:getFloorPassNum(self._activityId, curStageCfg.floorId)
	local isLock = false
	local openTimeSec

	if not isPass then
		local stageIndex = Mathf.Min(passNum + 1, #stageCfgs)
		local stageData = stageCfgs[stageIndex]
		local openTime = GameUtil.string2time(stageData.openTime)

		isLock = openTime > ServerTime.now()

		if isLock then
			openTimeSec = openTime
		end

		if not isLock and not OriginaruishiclgModel.instance:isStagePass(self._activityId, stageData.stageId) then
			curStageCfg = stageData
		end
	end

	goutil.setActive(goLock, isLock)
	goutil.setActive(goPass, isPass)
	goutil.setActive(goSelect, curStageCfg.floorId == self._selctFloorId)
	GameUtil.setUIImageColorIdx(goNode, (isLock or isPass) and 1 or 0)

	txtName.text = curStageCfg.floorName
	txtNum.text = string.format("<color=#eeffc2>%s/%s</color>", passNum, totalNum)

	GameUtil.addClickHandler(goNode, function()
		if isPass then
			FloatWordMgr.instance:show("已通关")

			return
		elseif isLock then
			local str = GameUtil.formatTimeStamp("%Y-%m-%d %H:%M:%S 开放", openTimeSec)

			FloatWordMgr.instance:show(str)

			return
		else
			self._selctFloorId = curStageCfg.floorId

			OriginaruishiclgController.instance:setLastSelectFloorId(curStageCfg.floorId)
			self:_updateReward()

			local fmtMo = OriginaruishiclgModel.instance:getFmtMo()

			fmtMo:initParams(self._activityId, curStageCfg.stageId, curStageCfg.creepsMasterId)
			CustomFmtController.instance:showMissionView(fmtMo)
		end
	end)
end

function OriginaruishiclgstageView:_clearCell(cell)
	local goNode = goutil.findChild(cell.gameObject, "node")

	GameUtil.rmClickHandler(goNode)
end

function OriginaruishiclgstageView:_updateReward()
	if self._selctFloorId <= 0 then
		MaterialMgr.resetAll(self._prizeItem)
		GameUtil.SetActive(self._rewardGo, false)

		return
	end

	GameUtil.SetActive(self._rewardGo, true)

	local passNum, totalNum = OriginaruishiclgModel.instance:getFloorPassNum(self._activityId, self._selctFloorId)
	local stageCfgs = OriginaruishiclgConfig.instance:getFloorCfg(self._activityId, self._selctFloorId)
	local nextIdx = Mathf.Min(passNum + 1, #stageCfgs)
	local stageData = stageCfgs[nextIdx]

	MaterialMgr.setCellByCfg(stageData.prize, self._prizeItem)

	local isPass = OriginaruishiclgModel.instance:isStagePass(self._activityId, stageData.stageId)

	GameUtil.SetActive(self._tagHasGain, isPass)

	self._txtReward.text = string.format(self._strTxtReward, passNum, totalNum)
end

function OriginaruishiclgstageView:_updateCellReward(view, cell, stageCfg, tag)
	local goCon = goutil.findChild(cell.gameObject, "con")
	local goGain = goutil.findChild(cell.gameObject, "gain")
	local isGain = OriginaruishiclgModel.instance:isStagePass(self._activityId, stageCfg.stageId)

	MaterialMgr.setCellByCfg(stageCfg.prize, goCon)
	goutil.setActive(goGain, isGain)
end

function OriginaruishiclgstageView:_clearCellReward(cell)
	local goCon = goutil.findChild(cell.gameObject, "con")

	MaterialMgr.resetAll(goCon)
end

return OriginaruishiclgstageView
