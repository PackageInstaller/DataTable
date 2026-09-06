-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeChapter3ResetView.lua

module("logic.extensions.luyngarde.view.LuyngardeChapter3ResetView", package.seeall)

local LuyngardeChapter3ResetView = class("LuyngardeChapter3ResetView", ViewComponent)

function LuyngardeChapter3ResetView:ctor()
	LuyngardeChapter3ResetView.super.ctor(self)
end

function LuyngardeChapter3ResetView:unbindEvents()
	LuyngardeChapter3ResetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnClose)
end

function LuyngardeChapter3ResetView:bindEvents()
	LuyngardeChapter3ResetView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function LuyngardeChapter3ResetView:buildUI()
	LuyngardeChapter3ResetView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._btnClose = self:getGo("btnClose")

	local goTableview = self:getGo("tableview")
	local goCell = self:getGo("tablecell")

	self._tableview = ScrollerList.create(goTableview, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableview:setCenterMode(true)
end

function LuyngardeChapter3ResetView:onExit()
	LuyngardeChapter3ResetView.super.onExit(self)
	self._tableview:dispose()
end

function LuyngardeChapter3ResetView:onEnter()
	LuyngardeChapter3ResetView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._resetInfo = params[2]

	if not self._resetInfo then
		self:close()

		return
	end

	local exploreCfgs = LuyngardeConfig.instance:getChapter3ExploreCfgs(self._activityId)

	self._cfgs = LuyngardeConfig.instance:getChapter3ExploreStarShowCfgs(self._activityId, exploreCfgs[self._resetInfo.posInfo.positionId].typeId)
	self._curSelectStar = 1
	self._resetCfgs = LuyngardeConfig.instance:getChapter3ExploreResetCfgs(self._activityId)

	self._tableview:reloadData(self._cfgs)
end

function LuyngardeChapter3ResetView:_updateCell(view, cellGo, data)
	local select = goutil.findChild(cellGo.gameObject, "select")

	goutil.setActive(select, data.star == self._curSelectStar)

	for k = 1, 5 do
		local star = goutil.findChild(cellGo.gameObject, "stars/" .. k)

		goutil.setActive(star, k <= data.showStrar)
	end

	local title = goutil.findChildTextComponent(cellGo.gameObject, "title")

	title.text = data.zdlRecommend

	GameUtil.addClickHandler(cellGo.gameObject, function()
		self._curSelectStar = data.star

		self._tableview:reloadData(self._cfgs)
	end)
end

function LuyngardeChapter3ResetView:_clearCell(cellGo)
	GameUtil.rmClickHandler(cellGo.gameObject)
end

function LuyngardeChapter3ResetView:_onClickBtnSure()
	local times = self._resetInfo.timeInfo.times
	local resetCfg = self._resetCfgs[times + 1]

	if resetCfg then
		local matType, matId, matNum = MaterialMgr.getMatParams(resetCfg.cost)
		local matName = MaterialMgr.getMaterialsName(matType, matId)
		local content = langPara("确定要花费%d%s,\n刷新该挑战吗？", matNum, matName)

		TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, function()
			LuyngardeController.instance:chapter3ResetStar(self._activityId, self._resetInfo.posInfo.positionId, self._curSelectStar)
			self:close()
		end)
	end
end

return LuyngardeChapter3ResetView
