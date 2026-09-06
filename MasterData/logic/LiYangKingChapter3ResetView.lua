-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liyangking/view/LiYangKingChapter3ResetView.lua

module("logic.extensions.liyangking.view.LiYangKingChapter3ResetView", package.seeall)

local LiYangKingChapter3ResetView = class("LiYangKingChapter3ResetView", ViewComponent)

function LiYangKingChapter3ResetView:ctor()
	LiYangKingChapter3ResetView.super.ctor(self)
end

function LiYangKingChapter3ResetView:unbindEvents()
	LiYangKingChapter3ResetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnClose)
end

function LiYangKingChapter3ResetView:bindEvents()
	LiYangKingChapter3ResetView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function LiYangKingChapter3ResetView:buildUI()
	LiYangKingChapter3ResetView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._btnClose = self:getGo("btnClose")

	local goTableview = self:getGo("tableview")
	local goCell = self:getGo("tablecell")

	self._tableview = ScrollerList.create(goTableview, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableview:setCenterMode(true)
end

function LiYangKingChapter3ResetView:onExit()
	LiYangKingChapter3ResetView.super.onExit(self)
	self._tableview:dispose()
end

function LiYangKingChapter3ResetView:onEnter()
	LiYangKingChapter3ResetView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._resetInfo = params[2]

	if not self._resetInfo then
		self:close()

		return
	end

	local exploreCfgs = LiYangKingConfig.instance:getChapter3ExploreCfgs(self._activityId)

	self._cfgs = LiYangKingConfig.instance:getChapter3ExploreStarShowCfgs(self._activityId, exploreCfgs[self._resetInfo.posInfo.positionId].typeId)
	self._curSelectStar = 1
	self._resetCfgs = LiYangKingConfig.instance:getChapter3ExploreResetCfgs(self._activityId)

	self._tableview:reloadData(self._cfgs)
end

function LiYangKingChapter3ResetView:_updateCell(view, cellGo, data)
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

function LiYangKingChapter3ResetView:_clearCell(cellGo)
	GameUtil.rmClickHandler(cellGo.gameObject)
end

function LiYangKingChapter3ResetView:_onClickBtnSure()
	local times = self._resetInfo.timeInfo.times
	local resetCfg = self._resetCfgs[times + 1]

	if resetCfg then
		local matType, matId, matNum = MaterialMgr.getMatParams(resetCfg.cost)
		local matName = MaterialMgr.getMaterialsName(matType, matId)
		local content = langPara("确定要花费%d%s,\n刷新该挑战吗？", matNum, matName)

		TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, function()
			LiYangKingController.instance:sendPM_PrinceLiyangClgResetStarReq(self._activityId, self._resetInfo.posInfo.positionId, self._curSelectStar)
			self:close()
		end)
	end
end

return LiYangKingChapter3ResetView
