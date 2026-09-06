-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liyangking/view/LiYangKingHelpCenterView.lua

module("logic.extensions.liyangking.view.LiYangKingHelpCenterView", package.seeall)

local LiYangKingHelpCenterView = class("LiYangKingHelpCenterView", ViewComponent)

function LiYangKingHelpCenterView:ctor()
	LiYangKingHelpCenterView.super.ctor(self)
end

function LiYangKingHelpCenterView:unbindEvents()
	LiYangKingHelpCenterView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRefresh)
end

function LiYangKingHelpCenterView:bindEvents()
	LiYangKingHelpCenterView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnChange, self._onClickBtnChange, self)
	GameUtil.addClickHandler(self._btnRefresh, self._onClickBtnRefresh, self)
end

function LiYangKingHelpCenterView:buildUI()
	LiYangKingHelpCenterView.super.buildUI(self)

	self._txtHelpTime = self:getTxt("curHelpTime/txt")

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
	self._goEmpty = self:getGo("list1/goEmpty")
	self._goEmpty2 = self:getGo("list2/goEmpty")
end

function LiYangKingHelpCenterView:onExit()
	LiYangKingHelpCenterView.super.onExit(self)
	self._tableview1:dispose()
	self._tableview2:dispose()
	self._tableviewFilter:dispose()

	for cellGo, scrollList in pairs(self._scrollMap) do
		scrollList:dispose()

		self._scrollMap[cellGo] = nil
	end
end

function LiYangKingHelpCenterView:onEnter()
	LiYangKingHelpCenterView.super.onEnter(self)

	self._CDTimer = -1
	self._activityId = checknumber(self:getFirstParam())
	self._scrollMap = {}

	self.addGEvent(self, GlobalNotify.PM_PrinceLiyangClgHelpInfoRes, self._handleGetHelpInfo, self)
	self.addGEvent(self, GlobalNotify.PM_PrinceLiyangClgInfoRes, self._onClgGetInfoRes, self)
	self.addGEvent(self, GlobalNotify.PM_PrinceLiyangClgHelpCenterRes, self._handleGetHelpInfoList, self)
	LiYangKingController.instance:sendPM_PrinceLiyangClgHelpCenterReq(self._activityId, self._curStar)
	LiYangKingController.instance:sendPM_PrinceLiyangClgInfoReq(self._activityId)
	self:_updateUIByCfg()
end

function LiYangKingHelpCenterView:_updateUIByCfg()
	self._actCfg = LiYangKingConfig.instance:getActCfg(self._activityId)
	self._exploreStarCfgs = LiYangKingConfig.instance:getChapter3ExploreStarShowCfgs(self._activityId, 1)
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

function LiYangKingHelpCenterView:_handleGetHelpInfo(msg)
	local info = GameUtil.pbToTable(msg)

	if not info.position then
		LiYangKingController.instance:sendPM_PrinceLiyangClgHelpCenterReq(self._activityId, self._curStar)
	end
end

function LiYangKingHelpCenterView:_handleGetHelpInfoList(msg)
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

function LiYangKingHelpCenterView:_onClickBtnChange()
	goutil.setActive(self._goTableFilter, not GameUtil.GetActive(self._goTableFilter))
	self._tableviewFilter:reloadData(self._filterList)
end

function LiYangKingHelpCenterView:_updateCell(view, cell, data)
	local id = data.id
	local exploreStarCfg = LiYangKingConfig.instance:getChapter3ExploreStarCfg(self._activityId, id)
	local showStarCfg = LiYangKingConfig.instance:getChapter3ExploreStarShowCfgByStar(self._activityId, exploreStarCfg.typeId, exploreStarCfg.star)
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")

	txtDesc.text = string.format("有大神帮我打打这个%sboss 吗？跪谢了", showStarCfg.showTitle)

	local headIcon = goutil.findChild(cell.gameObject, "headIcon")

	HeadItemController.instance:setHeadCellByInfo(headIcon, data.headInfo, true)

	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")

	txtName.text = data.headInfo.userName

	local tableviewReward = goutil.findChild(cell, "tableviewReward")
	local tablecell = goutil.findChild(cell, "tableviewReward/tablecell")
	local prizeArr = string.split(exploreStarCfg.helpPrize, "#")
	local scrollList = self._scrollMap[cell]

	if scrollList == nil then
		scrollList = ScrollerList.create(tableviewReward, tablecell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	end

	scrollList:reloadData(prizeArr)

	local btnHelp = goutil.findChild(cell.gameObject, "btnHelp")

	GameUtil.addClickHandler(btnHelp, GameUtil.handler(self._onClickHelp, self, data))
end

function LiYangKingHelpCenterView:_clearCell(cell)
	local headIcon = goutil.findChild(cell.gameObject, "headIcon")

	HeadItemController.instance:resetHeadCell(headIcon)

	local btnHelp = goutil.findChild(cell.gameObject, "btnHelp")

	GameUtil.rmClickHandler(btnHelp)

	local scrollList = self._scrollMap[cell]

	if scrollList then
		scrollList:dispose()

		self._scrollMap[cell] = nil
	end
end

function LiYangKingHelpCenterView:_updateRewardCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell)
end

function LiYangKingHelpCenterView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell)
end

function LiYangKingHelpCenterView:_onClickHelp(data)
	local getCurMaxCanHelpNum = LiYangKingController.instance:getMaxCanHelpNum(self._activityId)
	local clgInfo = LiYangKingModel.instance:getClgInfo(self._activityId)
	local curHasHelpNum = clgInfo.helpPrizeTimes
	local key = "LiYangKingHelpCenterView" .. self._activityId
	local toggleTip = GameUtil.getUserDayData(key)

	if getCurMaxCanHelpNum <= curHasHelpNum and toggleTip == nil then
		if toggleTip == nil then
			local tipStr = "您已达到最大奖励次数，请提升威望等级或第二天再来帮助吧！"
			local togText = "不再提醒"

			local function funcTog()
				GameUtil.saveUserDayData(key, true)
			end

			local function okFunc()
				LiYangKingController.instance:sendPM_PrinceLiyangClgHelpInfoReq(self._activityId, data.userId, data.positionId, data.helpId)
			end

			TipsFacade.instance:openPopupWindowNoCancelWithTog("提示", tipStr, okFunc, funcTog, "继续帮助", togText)
		end
	else
		LiYangKingController.instance:sendPM_PrinceLiyangClgHelpInfoReq(self._activityId, data.userId, data.positionId, data.helpId)
	end
end

function LiYangKingHelpCenterView:_updateCellFilter(view, cell, data)
	local select = goutil.findChild(cell.gameObject, "select")

	goutil.setActive(select, self._curStar == data.star)

	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")

	txtName.text = data.showTitle

	GameUtil.addClickHandler(cell.gameObject, function()
		self._curStar = data.star

		goutil.setActive(self._goTableFilter, false)

		self._txtFilter.text = data.showTitle

		self._tableviewFilter:reloadData(self._filterList)
		LiYangKingController.instance:sendPM_PrinceLiyangClgHelpCenterReq(self._activityId, self._curStar)
	end)
end

function LiYangKingHelpCenterView:_clearCellFilter(cell)
	GameUtil.rmClickHandler(cell.gameObject)
end

function LiYangKingHelpCenterView:_onClickBtnRefresh()
	if self._CDTimer < 0 then
		self._CDTimer = ServerTime.now() + self._actCfg.c3RefreshCd

		LiYangKingController.instance:sendPM_PrinceLiyangClgHelpCenterReq(self._activityId, self._curStar)
	elseif ServerTime.now() > self._CDTimer then
		self._CDTimer = ServerTime.now() + self._actCfg.c3RefreshCd

		LiYangKingController.instance:sendPM_PrinceLiyangClgHelpCenterReq(self._activityId, self._curStar)
		FloatWordMgr.instance:show("刷新成功")
	else
		FloatWordMgr.instance:show(string.format("刷新太过频繁，请%s秒后重试", self._CDTimer - ServerTime.now()))
	end
end

function LiYangKingHelpCenterView:_onClgGetInfoRes()
	local info = LiYangKingModel.instance:getClgInfo(self._activityId)
	local maxCanHelpNum = LiYangKingController.instance:getMaxCanHelpNum(self._activityId)
	local helpPrizeTimes = info.helpPrizeTimes
	local leftHelpNum = math.max(maxCanHelpNum - helpPrizeTimes, 0)

	self._txtHelpTime.text = string.format("当前剩余帮打次数:%d", leftHelpNum)
end

return LiYangKingHelpCenterView
