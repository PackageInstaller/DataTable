-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinesuperdragon/view/DivinesuperdragonsuperstageView.lua

module("logic.extensions.divinesuperdragon.view.DivinesuperdragonsuperstageView", package.seeall)

local DivinesuperdragonsuperstageView = class("DivinesuperdragonsuperstageView", ViewComponent)

function DivinesuperdragonsuperstageView:ctor()
	DivinesuperdragonsuperstageView.super.ctor(self)
end

function DivinesuperdragonsuperstageView:unbindEvents()
	DivinesuperdragonsuperstageView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnSuperClg:RemoveClickListener()
	self._btnBuff:RemoveClickListener()
end

function DivinesuperdragonsuperstageView:bindEvents()
	DivinesuperdragonsuperstageView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnSuperClg:AddClickListener(self._onClickbtnSuperClg, self)
	self._btnBuff:AddClickListener(self._onClickbtnBuff, self)
end

function DivinesuperdragonsuperstageView:buildUI()
	DivinesuperdragonsuperstageView.super.buildUI(self)

	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._fmtCellGo = self:getGo("fmtCell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._txtTimeGo = self:getGo("txtTime")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "txtTime/txt")
	self._btnSuperClg = self:getBtn("superroot/btnSuperClg")
	self._superrootGo = self:getGo("superroot")
	self._conGo = self:getGo("superroot/con")
	self._btnBuff = self:getBtn("superroot/tipsCol/btnBuff")
	self._rewardtableviewGo = self:getGo("rewardRoot/tableview")
	self._rewardtablecellGo = self:getGo("rewardRoot/tablecell")
	self._rewardScrollerList = ScrollerList.create(self._rewardtableviewGo, self._rewardtablecellGo, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._slider = self:getSlider("rewardRoot/tableview/Viewport/content/progressSlider")
	self._txttablecellGo = self:getGo("superroot/tipsCol/tablecell")
	self._txttableviewGo = self:getGo("superroot/tipsCol/tableview")
	self._txtScrollerList = ScrollerList.create(self._txttableviewGo, self._txttablecellGo, GameUtil.handler(self._updateTxtCell, self), GameUtil.handler(self._clearTxtCell, self))

	self._txtScrollerList:regGetCellSize(function(view, index)
		return self:_getTxtCellSize(index)
	end)

	self._total = self:getGo("total")
	self._rewardRoot = self:getGo("rewardRoot")
end

function DivinesuperdragonsuperstageView:onExit()
	DivinesuperdragonsuperstageView.super.onExit(self)
	self._scrollerList:dispose()
	self._rewardScrollerList:dispose()
	self._txtScrollerList:dispose()

	if self._roleObj then
		RoleObjectPool.instance:removeRole(self._roleObj)

		self._roleObj = nil
	end
end

function DivinesuperdragonsuperstageView:onEnter()
	DivinesuperdragonsuperstageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = DivinesuperdragonController.instance:getActivityId()
	end

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._selectStageId = DivinesuperdragonModel.instance:getLastSuperStageViewStageId(self._activityId)
	self._progeress = DivinesuperdragonModel.instance:getSuperStageProgress(self._activityId)

	if self._progeress >= self._selectStageId then
		local cfg = DivinesuperdragonConfig.instance:getSuperStageCfg(self._activityId, self._progeress + 1)

		self._selectStageId = not cfg and self._progeress or self._progeress + 1
	end

	local cfgs = DivinesuperdragonConfig.instance:getSuperStageCfgs(self._activityId)

	self._scrollerList:reloadData(cfgs)
	self._scrollerList:MoveCellToBegin(self._selectStageId - 1)
	self:_initAoqiGodUI()
	self:_updateUI()
	self:_setActTime()
end

function DivinesuperdragonsuperstageView:_initAoqiGodUI()
	GameUtil.SetActive(self._total, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._rewardRoot, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._txtTimeGo, not self._isAoqiGodProcessType)
end

function DivinesuperdragonsuperstageView:_onClickbtnClose()
	DivinesuperdragonModel.instance:setLastSuperStageViewStageId(self._activityId, 0)
	self:close()
end

function DivinesuperdragonsuperstageView:_onClickbtnTip()
	local key = DivinesuperdragonConfig.instance:getRuleKey(self._activityId, "ruleKeyChaoshen")

	TipsFacade.instance:openRulesView(key)
end

function DivinesuperdragonsuperstageView:_updateCell(view, cell, cfg, tag)
	local bgGo = goutil.findChild(cell, "bg")
	local txt = goutil.findChildTextComponent(cell.gameObject, "txt")
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)
	local changeGroup = cell.gameObject:GetComponent(ComponentType.UIChangeGroup)
	local goSelect = goutil.findChild(cell, "select")

	if self._selectStageId <= 0 then
		self:_onClickBtnStage(cfg.stageId)
	end

	changeGroup:SetState(self._selectStageId == cfg.stageId and 1 or 0)
	goutil.setActive(goSelect, self._selectStageId == cfg.stageId)

	txt.text = string.format("第%s关", cell.data)

	GameUtil.SetGray(bgGo, self._progeress >= cfg.stageId)
	btn:AddClickListener(function()
		self:_onClickBtnStage(cfg.stageId)
	end)
end

function DivinesuperdragonsuperstageView:_onClickBtnStage(stageId)
	self._selectStageId = stageId

	self._scrollerList:refresh()
	self:_updateUI()
end

function DivinesuperdragonsuperstageView:_clearCell(cell)
	return
end

function DivinesuperdragonsuperstageView:_updateFmtCell(mainGo, groupId, dataBitId)
	local isPass = false
	local stageCfg = DivinesuperdragonConfig.instance:getSuperStageCfg(self._activityId, self._selectStageId)
	local creepsMasterId = stageCfg.creepsMasterId
	local creepsCfgs = DivinesuperdragonConfig.instance:getCreepsCfgs(creepsMasterId)
	local fmt = goutil.findChild(mainGo, "fmt")
	local fmtView = goutil.findChild(mainGo, "fmt/fmtView")
	local imgPass = goutil.findChild(mainGo, "fmt/imgPass")
	local btnClg = goutil.findChild(mainGo, "btnClg")

	for posId = 1, fmtView.transform.childCount do
		local go = fmtView.transform:GetChild(posId - 1)
		local icon = goutil.findChild(go, "icon")
		local creepsData

		for _, cData in ipairs(creepsCfgs) do
			if cData.posId == posId then
				creepsData = cData

				break
			end
		end

		if creepsData then
			local skinId = checknumber(creepsData.faceId)

			if skinId == 0 then
				skinId = creepsData.raceId
			end

			local proxy = MaterialMgr.setCell(MatType.Pet, skinId, icon)

			if proxy then
				proxy.binder:setClickCallBack(nil)
			end
		else
			MaterialMgr.resetAll(icon)
		end
	end

	GameUtil.SetActive(imgPass, isPass)
	GameUtil.addClickHandler(btnClg, GameUtil.handler(self._onClickBtnClg, self))
end

function DivinesuperdragonsuperstageView:_onClickFmtCellBtnFormation(groupId, dataBitId)
	local result, tips = FarnasController.instance:getTryFightNorClgResultAndTips(self._activityId, dataBitId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	FarnasController.instance:enterBattleOfNorClg(self._activityId, groupId, dataBitId)
end

function DivinesuperdragonsuperstageView:_onClickBtnClg()
	local stageCfg = DivinesuperdragonConfig.instance:getSuperStageCfg(self._activityId, self._selectStageId)

	if not stageCfg then
		return
	end

	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.DivineSuperDragon, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	if self._selectStageId > self._progeress + 1 then
		FloatWordMgr.instance:show(string.format("先通过第%s关", self._progeress + 1))

		return
	end

	local creepsMasterId = stageCfg.creepsMasterId

	DivinesuperdragonController.instance:enterMission(self._activityId, GameEnum.DivinesuperdragonClgType.SuperStage, creepsMasterId)
	DivinesuperdragonModel.instance:setLastSuperStageViewStageId(self._activityId, self._selectStageId)
end

function DivinesuperdragonsuperstageView:_updateUI()
	self:_updateRewards()
	self:_updateSelectStageUI()
end

function DivinesuperdragonsuperstageView:_updateRewards()
	local list = DivinesuperdragonConfig.instance:getSuperStageCfgs(self._activityId)
	local scoreList = {}

	for i, v in ipairs(list) do
		table.insert(scoreList, i)
	end

	self._rewardScrollerList:reloadData(list)
	self._rewardScrollerList:updateUnderSlider(self._slider, self._progeress, scoreList)
end

function DivinesuperdragonsuperstageView:_updateSelectStageUI()
	local stageCfg = DivinesuperdragonConfig.instance:getSuperStageCfg(self._activityId, self._selectStageId)

	if not stageCfg then
		return
	end

	goutil.setActive(self._fmtCellGo, not stageCfg.buffEffected)
	goutil.setActive(self._superrootGo, stageCfg.buffEffected)

	if not stageCfg.buffEffected then
		self:_updateFmtCell(self._fmtCellGo)
	else
		self:_setRole(stageCfg.raceId)
		self:_setRuleDesc(stageCfg.ruleDesc)
	end
end

function DivinesuperdragonsuperstageView:_setActTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function DivinesuperdragonsuperstageView:_onClickbtnSuperClg()
	self:_onClickBtnClg()
end

function DivinesuperdragonsuperstageView:_onClickbtnBuff()
	UIStateManager.instance:push(ViewName.DivinesuperdragonsuperstagebuffView, self._activityId)
end

function DivinesuperdragonsuperstageView:_setRole(raceId)
	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, raceId, self._conGo, 1, nil, true, 0, 0)
end

function DivinesuperdragonsuperstageView:_setRuleDesc(ruleDesc)
	self._ruleTxtList = string.split(ruleDesc, "\n")

	self._txtScrollerList:reloadData(self._ruleTxtList)
end

function DivinesuperdragonsuperstageView:_updateRewardCell(view, cell, cfg, tag)
	local goGeted = goutil.findChild(cell.gameObject, "geted")
	local goItem = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(goItem)
	MaterialMgr.setCellByCfg(cfg.passedPrize, goItem)
	goutil.setActive(goGeted, self._progeress >= cfg.stageId)
end

function DivinesuperdragonsuperstageView:_clearRewardCell(cell)
	local goItem = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(goItem)
end

function DivinesuperdragonsuperstageView:_updateTxtCell(view, cell, txt, tag)
	local txtDesc = cell:GetComponent(goutil.Type_UIText)

	txtDesc.text = txt
end

function DivinesuperdragonsuperstageView:_clearTxtCell(cell)
	return
end

function DivinesuperdragonsuperstageView:_getTxtCellSize(index)
	if self._ruleTxtList and self._ruleTxtList[index + 1] then
		local input = self._ruleTxtList[index + 1]

		input = string.trim(input)

		local nonChineseLength, chineseLength = self:_countChineseAndNonChinese(input)

		nonChineseLength = nonChineseLength / 2

		return 267, math.ceil((nonChineseLength + chineseLength) / 14 + 1) * 20
	end

	return 267, 100
end

function DivinesuperdragonsuperstageView:_countChineseAndNonChinese(str)
	local nonChineseLength = 0
	local chineseLength = 0

	for uchar in string.gmatch(str, "[%z\x01-\x7F\xC2-\xF4][\x80-\xBF]*") do
		if string.byte(uchar) >= 228 then
			chineseLength = chineseLength + 1
		else
			nonChineseLength = nonChineseLength + 1
		end
	end

	return nonChineseLength, chineseLength
end

return DivinesuperdragonsuperstageView
