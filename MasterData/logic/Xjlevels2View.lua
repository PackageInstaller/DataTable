-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/view/Xjlevels2View.lua

module("logic.extensions.xingjiang.view.Xjlevels2View", package.seeall)

local Xjlevels2View = class("Xjlevels2View", ViewComponent)

function Xjlevels2View:ctor()
	Xjlevels2View.super.ctor(self)
end

function Xjlevels2View:unbindEvents()
	Xjlevels2View.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
end

function Xjlevels2View:bindEvents()
	Xjlevels2View.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "starCrimsonChapter_rule2")
	end, self)
end

function Xjlevels2View:buildUI()
	Xjlevels2View.super.buildUI(self)

	self._closeBtn = self:getBtn("btnClose")
	self._bg = self:getGo("bg")
	self._tipsBtn = self:getBtn("btnTip")
	self._scrollObj = self:getGo("tableview")
	self._tableCell = self:getGo("cell")

	self._tableCell:SetActive(false)

	self._tableview = ScrollerList.create(self._scrollObj, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearTableview, self))
end

function Xjlevels2View:onExit()
	Xjlevels2View.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_SKL_GETINFORES, self.onRefreshUI, self)
	self._tableview:dispose()
end

function Xjlevels2View:onEnter()
	Xjlevels2View.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_SKL_GETINFORES, self.onRefreshUI, self)

	self.activityId = XingJiangModel.instance.curActId2
	self.stagesCfgs = XingJiangConfig.instance:getStage2Cfgs(self.activityId)
	self.totalCount = #self.stagesCfgs

	XingJiangController.instance:sendInfo2Req(self.activityId)
end

function Xjlevels2View:onRefreshUI()
	self.stageId = XingJiangModel.instance.curStageId2

	if not self.stageId or self.stageId > self.totalCount then
		FloatWordMgr.instance:show("已通过所有关卡")
		GameUtil.saveUserData("xingjiangover2", "1")
		self:close()

		return
	end

	self._tableview:reloadData(self.stagesCfgs)
	self._tableview:refresh()
end

function Xjlevels2View:_updateCell(index, cell, data)
	local isPass = data.stageId < self.stageId
	local isCurStage = data.stageId == self.stageId
	local imgNum = goutil.findChild(cell, "zdl/imgRecZdl"):GetComponent(ComponentType.UIImgNumeralText)
	local btn = GameUtil.asBtn(goutil.findChild(cell, "btnChallenge"))
	local diffChange = goutil.findChildComponent(cell, "mode/img", typeof(UIImageSpriteChange))

	diffChange:SetState(data.difficulty - 1)
	imgNum:SetText(tostring(data.battlePowers))

	goutil.findChildTextComponent(cell, "btnChallenge/txt").text = isPass and "已通关" or data.chapterDifficulty
	goutil.findChildTextComponent(cell, "txtTip").text = data.passCondition

	goutil.findChild(cell, "pass"):SetActive(isPass)
	goutil.findChild(cell, "redpoint"):SetActive(isCurStage and not isPass)

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
			UIStateManager.instance:push(ViewName.Xj2MissionView, self.activityId, data.creepsMasterId)
		else
			FloatWordMgr.instance:show("请通关前置关卡")
		end
	end, self)
end

function Xjlevels2View:_clearTableview(cell)
	GameUtil.rmClickHandler(goutil.findChild(cell, "btnChallenge"))
end

return Xjlevels2View
