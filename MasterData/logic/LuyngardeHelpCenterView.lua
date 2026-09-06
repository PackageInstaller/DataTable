-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeHelpCenterView.lua

module("logic.extensions.luyngarde.view.LuyngardeHelpCenterView", package.seeall)

local LuyngardeHelpCenterView = class("LuyngardeHelpCenterView", ViewComponent)

function LuyngardeHelpCenterView:ctor()
	LuyngardeHelpCenterView.super.ctor(self)
end

function LuyngardeHelpCenterView:unbindEvents()
	LuyngardeHelpCenterView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRefresh)
end

function LuyngardeHelpCenterView:bindEvents()
	LuyngardeHelpCenterView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnChange, self._onClickBtnChange, self)
	GameUtil.addClickHandler(self._btnRefresh, self._onClickBtnRefresh, self)
end

function LuyngardeHelpCenterView:buildUI()
	LuyngardeHelpCenterView.super.buildUI(self)

	local goCell = self:getGo("tablecell")
	local goTableview1 = self:getGo("list1/tableview")
	local goTableview2 = self:getGo("list2/tableview")

	self._tableview1 = ScrollerList.create(goTableview1, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._tableview2 = ScrollerList.create(goTableview2, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnClose = self:getGo("leftTop/btnClose")
	self._goTableFilter = self:getGo("filter/tableview")

	local goCellFilter = self:getGo("filter/tablecell")

	self._btnChange = self:getGo("filter/btnChange")
	self._txtFilter = self:getTxt("filter/btnChange/txt")
	self._tableviewFilter = ScrollerList.create(self._goTableFilter, goCellFilter, GameUtil.handler(self._updateCellFilter, self), GameUtil.handler(self._clearCellFilter, self))
	self._btnRefresh = self:getGo("btnRefresh")
	self._txtCurscore = self:getTxt("curscore/txt")
	self._goEmpty = self:getGo("list1/goEmpty")
	self._goEmpty2 = self:getGo("list2/goEmpty")
end

function LuyngardeHelpCenterView:onExit()
	LuyngardeHelpCenterView.super.onExit(self)
	self._tableview1:dispose()
	self._tableview2:dispose()
	self._tableviewFilter:dispose()
end

function LuyngardeHelpCenterView:onEnter()
	LuyngardeHelpCenterView.super.onEnter(self)

	self._CDTimer = -1
	self._activityId = checknumber(self:getFirstParam())

	self.addGEvent(self, GlobalNotify.LuyngardeGetChapter3Info, self._handleGetInfo, self)
	self.addGEvent(self, GlobalNotify.LuyngardeChapter3GetHelpInfo, self._handleGetHelpInfo, self)
	self.addGEvent(self, GlobalNotify.LuyngardeChapter3GetHelpInfoList, self._handleGetHelpInfoList, self)
	LuyngardeController.instance:getChapter3Info(self._activityId)
	LuyngardeController.instance:getChapter3ExploreHelpCenter(self._activityId, self._curStar)
	self:_updateUIByCfg()
end

function LuyngardeHelpCenterView:_updateUIByCfg()
	self._actCfg = LuyngardeConfig.instance:getActCfg(self._activityId)
	self._exploreStarCfgs = LuyngardeConfig.instance:getChapter3ExploreStarShowCfgs(self._activityId, 1)
	self._filterList = {}

	table.insert(self._filterList, {
		showTitle = "全部"
	})

	for _, cfg in ipairs(self._exploreStarCfgs) do
		table.insert(self._filterList, {
			star = cfg.star,
			showTitle = cfg.showTitle
		})
	end

	goutil.setActive(self._goTableFilter, false)

	for _, data in ipairs(self._filterList) do
		if data.star == self._curStar then
			self._txtFilter.text = data.showTitle

			break
		end
	end
end

function LuyngardeHelpCenterView:_handleGetInfo()
	local info = LuyngardeModel.instance:getChapter3InfoByActId(self._activityId)

	self._txtCurscore.text = string.format("我当前的积分:%s", info.score)
end

function LuyngardeHelpCenterView:_handleGetHelpInfo(msg)
	local info = GameUtil.pbToTable(msg)

	if not info.position then
		LuyngardeController.instance:getChapter3ExploreHelpCenter(self._activityId, self._curStar)
	end
end

function LuyngardeHelpCenterView:_handleGetHelpInfoList(msg)
	local myUserId = checknumber(RoleModel.instance:getUserId())
	local info = GameUtil.pbToTable(msg)

	if not info.items then
		local dataList1 = {}
		local dataList2 = {}

		for _, info in ipairs(info.items) do
			if myUserId ~= checknumber(info.userId) and checknumber(info.helpId) > 0 then
				if info.positionId == 1 then
					table.insert(dataList1, info)
				else
					table.insert(dataList2, info)
				end
			end
		end

		self._tableview1:reloadData(dataList1)
		goutil.setActive(self._goEmpty, #dataList1 == 0)
		self._tableview2:reloadData(dataList2)
		goutil.setActive(self._goEmpty2, #dataList2 == 0)
	end
end

function LuyngardeHelpCenterView:_onClickBtnChange()
	goutil.setActive(self._goTableFilter, not GameUtil.GetActive(self._goTableFilter))
	self._tableviewFilter:reloadData(self._filterList)
end

function LuyngardeHelpCenterView:_updateCell(view, cell, data)
	local id = data.id
	local exploreStarCfg = LuyngardeConfig.instance:getChapter3ExploreStarCfg(self._activityId, id)
	local showStarCfg = LuyngardeConfig.instance:getChapter3ExploreStarShowCfgByStar(self._activityId, exploreStarCfg.typeId, exploreStarCfg.star)
	local txtScore = goutil.findChildTextComponent(cell.gameObject, "txtScore")

	txtScore.text = string.format("%s 积分", exploreStarCfg.helpScore)

	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")

	txtDesc.text = string.format("有大神帮我打打这个%sboss 吗？跪谢了", showStarCfg.showTitle)

	local headIcon = goutil.findChild(cell.gameObject, "headIcon")

	HeadItemController.instance:setHeadCellByInfo(headIcon, data.headInfo, true)

	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")

	txtName.text = data.headInfo.userName

	local icon = goutil.findChild(cell.gameObject, "icon")
	local masterCfgs = LuyngardeConfig.instance:getCreepCfgs(exploreStarCfg.creepsMasterId)
	local skinId = checknumber(masterCfgs[1].faceId)

	if skinId == 0 then
		skinId = masterCfgs[1].raceId
	end

	MaterialMgr.setCell(MatType.Pet, skinId, icon)

	local btnHelp = goutil.findChild(cell.gameObject, "btnHelp")

	GameUtil.addClickHandler(btnHelp, GameUtil.handler(self._onClickHelp, self, data))
end

function LuyngardeHelpCenterView:_clearCell(cell)
	local headIcon = goutil.findChild(cell.gameObject, "headIcon")

	HeadItemController.instance:resetHeadCell(headIcon)

	local icon = goutil.findChild(cell.gameObject, "icon")
	local btnHelp = goutil.findChild(cell.gameObject, "btnHelp")

	GameUtil.rmClickHandler(btnHelp)
	MaterialMgr.resetAll(icon)
end

function LuyngardeHelpCenterView:_onClickHelp(data)
	LuyngardeController.instance:getChapter3ExploreHelpInfo(self._activityId, data.userId, data.positionId, data.helpId)
end

function LuyngardeHelpCenterView:_updateCellFilter(view, cell, data)
	local select = goutil.findChild(cell.gameObject, "select")

	goutil.setActive(select, self._curStar == data.star)

	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")

	txtName.text = data.showTitle

	GameUtil.addClickHandler(cell.gameObject, function()
		self._curStar = data.star

		goutil.setActive(self._goTableFilter, false)

		self._txtFilter.text = data.showTitle

		self._tableviewFilter:reloadData(self._filterList)
		LuyngardeController.instance:getChapter3ExploreHelpCenter(self._activityId, self._curStar)
	end)
end

function LuyngardeHelpCenterView:_clearCellFilter(cell)
	GameUtil.rmClickHandler(cell.gameObject)
end

function LuyngardeHelpCenterView:_onClickBtnRefresh()
	if self._CDTimer < 0 then
		self._CDTimer = ServerTime.now() + self._actCfg.c3RefreshCd

		LuyngardeController.instance:getChapter3ExploreHelpCenter(self._activityId, self._curStar)
	elseif ServerTime.now() > self._CDTimer then
		self._CDTimer = ServerTime.now() + self._actCfg.c3RefreshCd

		LuyngardeController.instance:getChapter3ExploreHelpCenter(self._activityId, self._curStar)
		FloatWordMgr.instance:show("刷新成功")
	else
		FloatWordMgr.instance:show(string.format("刷新太过频繁，请%s秒后重试", self._CDTimer - ServerTime.now()))
	end
end

return LuyngardeHelpCenterView
