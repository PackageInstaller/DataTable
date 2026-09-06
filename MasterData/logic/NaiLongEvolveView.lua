-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailongevolve/view/NaiLongEvolveView.lua

module("logic.extensions.nailongevolve.view.NaiLongEvolveView", package.seeall)

local NaiLongEvolveView = class("NaiLongEvolveView", ViewComponent)

function NaiLongEvolveView:ctor()
	NaiLongEvolveView.super.ctor(self)
end

local POS_TYPE_NUM = 4

function NaiLongEvolveView:unbindEvents()
	NaiLongEvolveView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnGoldBar)

	for i = 1, POS_TYPE_NUM do
		local btn = self:getGo("btns/btn" .. i)

		GameUtil.rmClickHandler(btn)
	end
end

function NaiLongEvolveView:bindEvents()
	NaiLongEvolveView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnGoldBar, self._onClickBtnGoldBar, self)

	for posType = 1, POS_TYPE_NUM do
		local btn = self:getGo("btns/btn" .. posType)

		GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickBtnEvolve, self, posType))
	end
end

function NaiLongEvolveView:buildUI()
	NaiLongEvolveView.super.buildUI(self)

	self._con = self:getGo("con")
	self._txtSkillPointNum = self:getTxt("rightCol/txtSkillPointNum")
	self._item = self:getGo("goldBar/item")
	self._txtNum = self:getTxt("goldBar/txtNum")
	self._btnReset = self:getGo("rightCol/btnReset")
	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnGoldBar = self:getGo("goldBar")
	self._cell = self:getGo("rightCol/cell")
	self._tableview = self:getGo("rightCol/tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function NaiLongEvolveView:onExit()
	NaiLongEvolveView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.clearIcon(self._item)
end

function NaiLongEvolveView:onEnter()
	NaiLongEvolveView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_MilkDragonClgPosLvlUpRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_MilkDragonClgResetPosLvlRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._actCfg = NaiLongEvolveConfig.instance:getActData(self._activityId)
	self._stageCfgs = NaiLongEvolveConfig.instance:getStageData(self._activityId)
	self._typePosCfgs = NaiLongEvolveConfig.instance:getPosData(self._activityId)
	self._accuBuffCfgs = NaiLongEvolveConfig.instance:getAccuBuffSortList(self._activityId)
	self._info = NaiLongEvolveModel.instance:getInfo(self._activityId)
	self._posTypeNames = NaiLongEvolveConfig.instance:getPosNames(self._activityId)
	self._curActiveScore = 0

	self:_onSetUI()
end

function NaiLongEvolveView:_onSetUI()
	local skinId = self._actCfg.skinId

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	local activeAccBuffIdx = NaiLongEvolveController.instance:getCurActiveAccuBuffIndex(self._activityId)
	local scrollData = {}

	for i, cfg in ipairs(self._accuBuffCfgs) do
		local data = {}

		data.idx = i
		data.cfg = cfg

		table.insert(scrollData, data)
	end

	local matStr = self._actCfg.scoreIcon
	local arr = string.split(matStr, ":")

	MaterialMgr.clearIcon(self._item)
	MaterialMgr.setIcon(self._item, arr[1], arr[2])

	self._txtNum.text = self._info.curScore or 0

	if not self._info.consumedScore then
		self._txtSkillPointNum.text = "累计消耗技能点：" .. self._info.consumedScore

		for i = 1, POS_TYPE_NUM do
			local txtPosTypeTitle = self:getTxt("rightCol/levelUpDescs/ScrollView/Viewport/Content/txtPosTypeTitle" .. i)
			local txtPosTypeDesc = self:getTxt("rightCol/levelUpDescs/ScrollView/Viewport/Content/txtPosTypeDesc" .. i)
			local txtBtn = self:getTxt("btns/btn" .. i .. "/text")
			local name = self._posTypeNames[i]

			if self._info.posType2LvlDic[i] then
				local level = self._info.posType2LvlDic[i]
				local typePosCfg = self._typePosCfgs[i][level]

				txtPosTypeTitle.text = name .. " Lv." .. self._info.posType2LvlDic[i]
				txtPosTypeDesc.text = typePosCfg and typePosCfg.desc
				txtBtn.text = name .. " Lv." .. self._info.posType2LvlDic[i]
			else
				local typePosCfg = self._typePosCfgs[i][0]

				txtPosTypeTitle.text = name .. " Lv.0"
				txtPosTypeDesc.text = typePosCfg and typePosCfg.desc
				txtBtn.text = name .. " Lv.0"
			end
		end

		self:_getCurActiveScore()
		self._scrollList:reloadData(scrollData)
		self._scrollList:MoveCellToCenter(activeAccBuffIdx - 1)
	end
end

function NaiLongEvolveView:_onUpdate()
	self._info = NaiLongEvolveModel.instance:getInfo(self._activityId)

	self:_onSetUI()
end

function NaiLongEvolveView:_updateCell(view, cell, data)
	local curActivateGo = goutil.findChild(cell, "curActivate")
	local imgChooseGo = goutil.findChild(cell, "imgChoose")
	local bgGo = goutil.findChild(cell, "bg")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local idx = data.idx

	txtScore.text = data.cfg.accScore
	txtDesc.text = data.cfg.desc

	GameUtil.SetActive(bgGo, idx % 2 == 1)
	GameUtil.SetActive(curActivateGo, self._curActiveScore == data.cfg.accScore)
	GameUtil.SetActive(imgChooseGo, self._curActiveScore == data.cfg.accScore)
end

function NaiLongEvolveView:_clearCell(cell)
	return
end

function NaiLongEvolveView:_getCurActiveScore()
	local curConsumedScore = self._info.consumedScore
	local accScore = 0

	for i, cfg in ipairs(self._accuBuffCfgs) do
		if curConsumedScore >= cfg.accScore then
			accScore = cfg.accScore
		end
	end

	self._curActiveScore = accScore
end

function NaiLongEvolveView:_onClickBtnEvolve(posType)
	if not self._info.posType2LvlDic[posType] then
		local typePosCfgs = NaiLongEvolveConfig.instance:getPosData(self._activityId)
		local lastPosLvl = NaiLongEvolveConfig.instance:getPosLastLvl(self._activityId, posType)

		UIStateManager.instance:push(ViewName.NaiLongEvolveLevelupView, self._activityId, posType)
	end
end

function NaiLongEvolveView:_onClickBtnReset()
	local pass = NaiLongEvolveController.instance:isPass(self._activityId)

	if pass then
		FloatWordMgr.instance:show("已通关，无需重置")

		return
	end

	if self._info.consumedScore <= 0 then
		FloatWordMgr.instance:show("未消耗技能点，无需重置")

		return
	end

	TipsFacade.instance:openTipWindow("提示", "是否将所有部位等级重置为0级并返还全部技能点？", function()
		NaiLongEvolveController.instance:sendPM_MilkDragonClgResetPosLvlReq(self._activityId)
	end, "确定")
end

function NaiLongEvolveView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyEvolve

	TipsFacade.instance:openRulesView(key)
end

function NaiLongEvolveView:_onClickBtnGoldBar()
	local scoreIcon = self._actCfg.scoreIcon
	local arr = string.split(scoreIcon, ":")

	CommonTipsMgr.instance:openMaterialTips(self._btnGoldBar, checknumber(arr[1]), checknumber(arr[2]), checknumber(self._info.curScore))
end

return NaiLongEvolveView
