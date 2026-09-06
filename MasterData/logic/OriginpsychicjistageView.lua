-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originpsychicji/view/OriginpsychicjistageView.lua

module("logic.extensions.originpsychicji.view.OriginpsychicjistageView", package.seeall)

local OriginpsychicjistageView = class("OriginpsychicjistageView", ViewComponent)

OriginpsychicjistageView.StageIdx2CellIdxConfig = {
	{
		[3] = 1,
		[4] = 4
	},
	{
		[4] = 2,
		[5] = 5
	},
	{
		[5] = 3
	}
}

function OriginpsychicjistageView:ctor()
	OriginpsychicjistageView.super.ctor(self)
end

function OriginpsychicjistageView:unbindEvents()
	OriginpsychicjistageView.super.unbindEvents(self)
	self._btnClg:RemoveClickListener()

	for i, v in ipairs(self._clgCells) do
		v.btn:RemoveClickListener()
	end

	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function OriginpsychicjistageView:bindEvents()
	OriginpsychicjistageView.super.bindEvents(self)
	self._btnClg:AddClickListener(self._onClickbtnClg, self)

	for i, v in ipairs(self._clgCells) do
		v.btn:AddClickListener(function()
			self:_onClickCell(i)
		end)
	end

	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function OriginpsychicjistageView:buildUI()
	OriginpsychicjistageView.super.buildUI(self)

	self._btnClg = self:getBtn("btnClg")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._tablecellGo = self:getGo("ruleright/tablecell")
	self._tableviewGo = self:getGo("ruleright/tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self:_buildClgCells()

	self._txtDescLeft = self:getTxt("ruleleft/txtDesc")

	self:_buildLineCells()

	self._txtContent = self:getTxt("ruleright/tableviewrule/viewport/content")
	self._txtTitle = self:getTxt("leftTop/txtTitle")
end

function OriginpsychicjistageView:_buildClgCells()
	self._clgCells = {}

	for i = 1, 5 do
		local go = self:getGo("cells/cell" .. i)
		local var_6_0 = {
			go = go,
			gouGo = goutil.findChild(go, "gou"),
			txtNum = goutil.findChildTextComponent(go, "txtNum"),
			selectGo = goutil.findChild(go, "select"),
			btn = Framework.ButtonAdapter.Get(goutil.findChild(go, "btn"))
		}

		var_6_0.iconChange = goutil.findChild(go, "img"):GetComponent(ComponentType.UIImageSpriteChange)

		local cell = var_6_0

		table.insert(self._clgCells, cell)
	end
end

function OriginpsychicjistageView:_buildLineCells()
	self._linesGoList = {}
	self._linesGo = self:getGo("lines")

	for i = 1, 5 do
		self._linesGoList[i] = goutil.findChild(self._linesGo, "linecell" .. i)
	end
end

function OriginpsychicjistageView:onExit()
	OriginpsychicjistageView.super.onExit(self)
	self._scrollerList:dispose()
end

function OriginpsychicjistageView:onEnter()
	OriginpsychicjistageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.OriginPsychicJiSaveRes, self._updateUI, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._clgType = params[2]

	self:_initSelectStageId()
	self:_updateUI()

	local key1 = ""
	local key2 = ""

	if self._clgType == OriginpsychicjiController.ClgType.Normal then
		key1 = "originpsychicjienergy_normal"
		key2 = "originpsychicjibattle_normal"
	else
		key1 = "originpsychicjienergy_ext"
		key2 = "originpsychicjibattle_ext"
	end

	local rule1 = RulesConfig.instance:getRuleCo(key1)
	local rule2 = RulesConfig.instance:getRuleCo(key2)

	self._txtDescLeft.text = rule1.rules
	self._txtContent.text = rule2.rules

	OriginpsychicjiController.instance:tryShowCI()

	self._txtTitle.text = self._clgType == OriginpsychicjiController.ClgType.Normal and "同心征途" or "绝境统御"
end

function OriginpsychicjistageView:_onClickbtnTip()
	local challengeCfg = OriginpsychicjiController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function OriginpsychicjistageView:_onClickbtnClose()
	self:close()
	OriginpsychicjiController.instance:setLastSelectStageId(0)
end

function OriginpsychicjistageView:_onClickbtnClg()
	if self._clgType == OriginpsychicjiController.ClgType.Normal and OriginpsychicjiModel.instance:isAllNormalStagePass(self._activityId) then
		FloatWordMgr.instance:show("全部关卡已通关")

		return
	end

	if not self._selectStageId or self._selectStageId <= 0 then
		FloatWordMgr.instance:show("请选择挑战关卡")

		return
	end

	if self._clgType == OriginpsychicjiController.ClgType.Normal and OriginpsychicjiModel.instance:isNormalStagePass(self._activityId, self._selectStageId) then
		FloatWordMgr.instance:show("关卡已通关")

		return
	end

	local fmtMo = OriginpsychicjiModel.instance:getFmtMo()

	fmtMo:initParams(self._activityId, self._clgType, self._selectStageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function OriginpsychicjistageView:_updateUI()
	self:_updateClgCells()
	self:_updateCellLines()
	self:_updateReward()
end

function OriginpsychicjistageView:_updateReward()
	local list = {}

	if self._clgType == OriginpsychicjiController.ClgType.Normal then
		local cfgs = OriginpsychicjiConfig.instance:getNormalStageCfgs(self._activityId)

		for i, cfg in ipairs(cfgs) do
			local isGain = OriginpsychicjiModel.instance:isNormalStagePass(self._activityId, cfg.stageId)

			table.insert(list, {
				prize = cfg.prize,
				isGain = isGain
			})
		end
	else
		local info = OriginpsychicjiModel.instance:getInfo(self._activityId)
		local actCfg = OriginpsychicjiConfig.instance:getActCfg(self._activityId)

		table.insert(list, {
			prize = actCfg.prize,
			isGain = info.hasPassExtStage
		})
	end

	self._scrollerList:reloadData(list)
end

function OriginpsychicjistageView:_updateClgCells()
	local cfgs

	for i, cfg in ipairs(self._clgType == OriginpsychicjiController.ClgType.Normal and OriginpsychicjiConfig.instance:getNormalStageCfgs(self._activityId) or OriginpsychicjiConfig.instance:getExtStageCfgs(self._activityId)) do
		self:_updateClgCell(i, cfg)
	end
end

function OriginpsychicjistageView:_updateClgCell(idx, stageCfg)
	local clgCell = self._clgCells[idx]

	if not clgCell then
		printError(string.format("第%s个cell丢失，看看是不是要这么多个", idx))

		return
	end

	local isPass = OriginpsychicjiModel.instance:getStageIsPass(self._activityId, self._clgType, stageCfg.stageId)

	goutil.setActive(clgCell.gouGo, isPass)
	goutil.setActive(clgCell.selectGo, self._selectStageId == stageCfg.stageId)

	clgCell.txtNum.text = OriginpsychicjiModel.instance:getStageEnergyValue(self._activityId, self._clgType, stageCfg.stageId)

	clgCell.iconChange:SetState(idx - 1)
end

function OriginpsychicjistageView:_onClickCell(stageId)
	if self._clgType == OriginpsychicjiController.ClgType.Normal and OriginpsychicjiModel.instance:isNormalStagePass(self._activityId, stageId) then
		FloatWordMgr.instance:show("关卡已通关")

		return
	end

	OriginpsychicjiController.instance:setLastSelectStageId(stageId)

	self._selectStageId = stageId

	self:_updateClgCells()
end

function OriginpsychicjistageView:_updateCellLines()
	if self._clgType == OriginpsychicjiController.ClgType.Normal then
		goutil.setActive(self._linesGo, false)
	else
		goutil.setActive(self._linesGo, true)

		for i, v in ipairs(self._linesGoList) do
			goutil.setActive(go, false)
		end

		local cfgs = OriginpsychicjiConfig.instance:getExtStageCfgs(self._activityId)
		local cnt = 0
		local map = {}

		for i, v in ipairs(cfgs) do
			for j, cStageId in ipairs(v.connectStage) do
				if cStageId ~= v.stageId then
					local key1 = string.format("%s_%s", v.stageId, cStageId)
					local key2 = string.format("%s_%s", cStageId, v.stageId)

					if not map[key1] and not map[key2] then
						map[key1] = true
						map[key2] = true
						cnt = cnt + 1

						self:_setLineParams(cnt, v.stageId, cStageId)
					end
				end
			end
		end
	end
end

function OriginpsychicjistageView:_setLineParams(idx, stageIdStart, stageIdEnd)
	local go = self:_getNewLineGo(stageIdStart, stageIdEnd)
	local lineGo = goutil.findChild(go, "line")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local yuanChange = goutil.findChild(go, "yuan"):GetComponent(ComponentType.UIImageSpriteChange)
	local v1 = OriginpsychicjiModel.instance:getStageEnergyValue(self._activityId, self._clgType, stageIdStart)
	local v2 = OriginpsychicjiModel.instance:getStageEnergyValue(self._activityId, self._clgType, stageIdEnd)

	txtNum.text = math.abs(v1 - v2)

	goutil.setActive(go, true)

	local bgIdx = 0

	if stageIdStart == 1 and stageIdEnd == 4 then
		bgIdx = 8
	elseif stageIdStart == 1 and stageIdEnd == 3 then
		bgIdx = 10
	elseif stageIdStart == 2 and stageIdEnd == 4 then
		bgIdx = 11
	elseif stageIdStart == 2 and stageIdEnd == 5 then
		bgIdx = 9
	elseif stageIdStart == 3 and stageIdEnd == 5 then
		bgIdx = 7
	elseif stageIdStart == 3 and stageIdEnd == 1 then
		bgIdx = 10
	elseif stageIdStart == 4 and stageIdEnd == 1 then
		bgIdx = 8
	elseif stageIdStart == 4 and stageIdEnd == 2 then
		bgIdx = 11
	elseif stageIdStart == 5 and stageIdEnd == 2 then
		bgIdx = 9
	elseif stageIdStart == 5 and stageIdEnd == 3 then
		bgIdx = 7
	end

	yuanChange:SetState(bgIdx - 7)
end

function OriginpsychicjistageView:_getLineCellIdx(stageIdStart, stageIdEnd)
	local minId = math.min(stageIdStart, stageIdEnd)
	local maxId = math.max(stageIdStart, stageIdEnd)

	return OriginpsychicjistageView.StageIdx2CellIdxConfig[minId][maxId]
end

function OriginpsychicjistageView:_getNewLineGo(stageIdStart, stageIdEnd)
	local idx = self:_getLineCellIdx(stageIdStart, stageIdEnd)

	return self._linesGoList[idx]
end

function OriginpsychicjistageView:_updateCell(view, cell, data, tag)
	local goGain = goutil.findChild(cell.gameObject, "gain")
	local goCon = goutil.findChild(cell.gameObject, "con")

	MaterialMgr.setCellByCfg(data.prize, goCon)
	goutil.setActive(goGain, data.isGain)
end

function OriginpsychicjistageView:_clearCell(cell)
	local goCon = goutil.findChild(cell.gameObject, "con")

	MaterialMgr.resetAll(goCon)
end

function OriginpsychicjistageView:_initSelectStageId()
	self._selectStageId = OriginpsychicjiController.instance:getLastSelectStageId()

	if self._selectStageId > 0 and self._clgType == OriginpsychicjiController.ClgType.Normal and OriginpsychicjiModel.instance:isNormalStagePass(self._activityId, self._selectStageId) then
		self._selectStageId = 0

		OriginpsychicjiController.instance:setLastSelectStageId(0)
	end
end

return OriginpsychicjistageView
