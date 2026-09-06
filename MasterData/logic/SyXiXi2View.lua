-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/syxixi/view/SyXiXi2View.lua

module("logic.extensions.SyXiXi.view.SyXiXi2View", package.seeall)

local SyXiXi2View = class("SyXiXi2View", ViewComponent)

function SyXiXi2View:ctor()
	SyXiXi2View.super.ctor(self)
end

function SyXiXi2View:unbindEvents()
	SyXiXi2View.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
end

function SyXiXi2View:bindEvents()
	SyXiXi2View.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "syxixiclg_lv2_rule")
	end, self)
end

function SyXiXi2View:buildUI()
	SyXiXi2View.super.buildUI(self)

	self._txtTitle = self:getTxt("txtTitle")
	self._closeBtn = self:getBtn("btnClose")
	self._bg = self:getGo("bg")
	self._tipsBtn = self:getBtn("btnTip")
	self._scrollObj = self:getGo("tableview")
	self._tableCell = self:getGo("cell")

	self._tableCell:SetActive(false)

	self._tableview = ScrollerList.create(self._scrollObj, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearTableview, self))
end

function SyXiXi2View:onExit()
	SyXiXi2View.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_SKL_GETINFORES, self.onRefreshUI, self)
	self._tableview:dispose()
end

function SyXiXi2View:onEnter()
	SyXiXi2View.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_SKL_GETINFORES, self.onRefreshUI, self)

	local params = self:getOpenParam()

	if params and params[2] then
		self._txtTitle.text = params[2]
	end

	self.activityId = checknumber(self:getFirstParam())
	self.stagesCfgs = XingJiangConfig.instance:getStage2Cfgs(self.activityId)
	self.totalCount = #self.stagesCfgs

	XingJiangController.instance:sendInfo2Req(self.activityId)
end

function SyXiXi2View:onRefreshUI()
	self.stageId = XingJiangModel.instance:getExStageById(self.activityId)

	if XingJiangModel.instance:checkIsPassExById(self.activityId) then
		FloatWordMgr.instance:show("已通过所有关卡")
		self:close()

		return
	end

	self._tableview:MoveCellToCenter(self.stageId - 1)
	self._tableview:reloadData(self.stagesCfgs)
	self._tableview:refresh()
end

function SyXiXi2View:_updateCell(index, cell, data)
	local isPass = data.stageId < self.stageId
	local isCurStage = data.stageId == self.stageId
	local imgNum = goutil.findChild(cell, "zdl/imgRecZdl"):GetComponent(ComponentType.UIImgNumeralText)
	local btn = GameUtil.asBtn(goutil.findChild(cell, "btnChallenge"))
	local btnImg = goutil.findChildComponent(cell, "btnChallenge", typeof(UIImageSpriteChange))
	local diffChange = goutil.findChildComponent(cell, "mode/img", typeof(UIImageSpriteChange))

	diffChange:SetState(data.difficulty - 1)
	imgNum:SetText(tostring(data.battlePowers))

	goutil.findChildTextComponent(cell, "btnChallenge/txt").text = isPass and "已通关" or data.chapterDifficulty
	goutil.findChildTextComponent(cell, "txtTip").text = data.passCondition

	goutil.findChild(cell, "pass"):SetActive(isPass)
	goutil.findChild(cell, "redpoint"):SetActive(isCurStage and not isPass)

	local idx = data.chapterDifficulty == "简单" and 0 or data.chapterDifficulty == "普通" and 1 or 2

	btnImg:SetState(idx)

	local prizeStr = data.prize
	local tabPize = string.split(prizeStr, "#")

	for i, v in ipairs(tabPize) do
		local type, id, num = MaterialMgr.getMatParams(v)
		local go = goutil.findChild(cell, "reward/icon" .. i)

		MaterialMgr.setIcon(go, type, id)

		goutil.findChildTextComponent(go, "num").text = "x" .. num
	end

	btn:AddClickListener(function()
		if isPass then
			FloatWordMgr.instance:show("今日已通关")
		elseif isCurStage then
			self:_onClickGoFight(self.activityId, data.creepsMasterId)
		else
			FloatWordMgr.instance:show("请通关前置关卡")
		end
	end, self)
end

function SyXiXi2View:_clearTableview(cell)
	GameUtil.rmClickHandler(goutil.findChild(cell, "btnChallenge"))
end

function SyXiXi2View:_onClickGoFight(activityId, creepsMasterId)
	UIStateManager.instance:push(ViewName.Xj2MissionView, self.activityId, creepsMasterId)
end

return SyXiXi2View
