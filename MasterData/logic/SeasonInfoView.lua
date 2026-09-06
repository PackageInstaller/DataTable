-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonInfoView.lua

module("logic.extensions.season.view.SeasonInfoView", package.seeall)

local SeasonInfoView = class("SeasonInfoView", ViewComponent)

function SeasonInfoView:ctor()
	SeasonInfoView.super.ctor(self)
end

function SeasonInfoView:unbindEvents()
	SeasonInfoView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnPaint:RemoveClickListener()
end

function SeasonInfoView:bindEvents()
	SeasonInfoView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
	self._btnPaint:AddClickListener(self._onClickPaint, self)
end

function SeasonInfoView:buildUI()
	SeasonInfoView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnRank = self:getBtn("left/btnRank")
	self._btnPaint = self:getBtn("left/btnPaint")
	self._txtTime = self:getTxt("time/txt")
	self._goSeasonTab = self:getGo("season")
	self._goSeasonView = self:getGo("season/seasonView")
	self._goSeasonCell = self:getGo("season/seasonCell")
	self._seasonTabView = ScrollerList.create(self._goSeasonView, self._goSeasonCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._goLeft = self:getGo("left")
	self._txtName = goutil.findChildTextComponent(self._goLeft, "txtName")
	self._txtPaintNum = goutil.findChildTextComponent(self._goLeft, "btnPaint/txtNum")
	self._banner = goutil.findChild(self._goLeft, "banner")
	self._goRight = self:getGo("right")
	self._achievementPve = goutil.findChild(self._goRight, "achievementPve")
	self._achievementPve_txtProgress = goutil.findChildTextComponent(self._achievementPve, "txtProgress")
	self._achievementPve_txtBoss = goutil.findChildTextComponent(self._achievementPve, "txtBoss")
	self._achievementPve_txtScore = goutil.findChildTextComponent(self._achievementPve, "txtScore")

	local achievementPve_goPlot = goutil.findChild(self._achievementPve, "txtOccupied/plot")

	self._achievementPve_tileItemList = {}

	for idx, mainGo in ipairs(GameUtil.getChildren(achievementPve_goPlot)) do
		local item = {}

		item.go = mainGo
		item.txtNum = goutil.findChildTextComponent(mainGo, "txtNum")
		self._achievementPve_tileItemList[idx] = item
	end

	self._achievementGve = goutil.findChild(self._goRight, "achievementGve")
	self._achievementGve_txtProgress = goutil.findChildTextComponent(self._achievementGve, "txtProgress")
	self._achievementGve_txtBoss = goutil.findChildTextComponent(self._achievementGve, "txtBoss")
	self._achievementGve_txtScore = goutil.findChildTextComponent(self._achievementGve, "txtScore")
	self._achievementGve_txtBossFriend = goutil.findChildTextComponent(self._achievementGve, "txtBossFriend")
	self._achievementGve_txtFriendName = goutil.findChildTextComponent(self._achievementGve, "txtFriendName")
	self._achievementGve_head = goutil.findChild(self._achievementGve, "head")

	local achievementGve_goPlot = goutil.findChild(self._achievementGve, "txtOccupied/plot")

	self._achievementGve_tileItemList = {}

	for idx, mainGo in ipairs(GameUtil.getChildren(achievementGve_goPlot)) do
		local item = {}

		item.go = mainGo
		item.txtNum = goutil.findChildTextComponent(mainGo, "txtNum")
		self._achievementGve_tileItemList[idx] = item
	end

	self._goReward = goutil.findChild(self._goRight, "reward")
	self._goRewardView = goutil.findChild(self._goReward, "tableview")
	self._goRewardCell = goutil.findChild(self._goReward, "item")
	self._rewardView = ScrollerList.create(self._goRewardView, self._goRewardCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function SeasonInfoView:onExit()
	SeasonInfoView.super.onExit(self)
	removetimer(self.updateTimer, self)
	uGuiUtil.clearImage(self._banner)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonInfoUpdate, self._refreshView, self)
	self._rewardView:dispose()
	self._seasonTabView:dispose()
	HeadItemController.instance:resetHeadCell(self._achievementGve_head)
end

function SeasonInfoView:onEnter()
	SeasonInfoView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonInfoUpdate, self._refreshView, self)

	local seasonId = SeasonModel.instance:getSeasonId()

	self:_setTopTapView()
	self:_onSendGetInfo(seasonId)
end

function SeasonInfoView:updateInActBtns()
	local conf = SeasonConfig.instance:getSeasonConfigBySeasonId(self._curSelectId)
	local isInActTime = conf and GameUtil.checkIsInTimePeriod(conf.startTime, conf.endTime)

	GameUtil.SetActive(self._btnPaint, isInActTime)

	local pos = GameUtil.getLocalPos(self._btnRank.gameObject)

	if not isInActTime then
		GameUtil.setLocalPos(self._btnRank.gameObject, pos.x, -210, pos.z)
	else
		GameUtil.setLocalPos(self._btnRank.gameObject, pos.x, -109, pos.z)
	end
end

function SeasonInfoView:_setTopTapView()
	local list = SeasonConfig.instance:getSeasonConfigList()

	self._seasonTabView:reloadData(list)
end

function SeasonInfoView:_refreshView()
	local data = SeasonModel.instance:getSeasonInfoData(self._curSelectId)

	if not data then
		return
	end

	self:updateInActBtns()

	self._viewData = data

	self._rewardView:reloadData(data.rewardData)

	self._txtPaintNum.text = data.nowFragmentNum .. "/" .. data.maxFragmentNum
	self._txtName.text = data.seasonModeCfg.name

	self:_refreshAchievementPveUI()
	self:_refreshAchievementGveUI()

	local BigBgUrl = "ui/bigbg/season/board_saijiwanfa_44.png"

	if not string.nilorempty(data.seasonModeCfg.imgInfo) then
		BigBgUrl = "ui/bigbg/season/" .. data.seasonModeCfg.imgInfo .. ".png"
	end

	uGuiUtil.clearImage(self._banner)
	uGuiUtil.setSpriteToImage(self._banner, uGuiUtil.SpriteType.BigBg, BigBgUrl)

	self._endTime = GameUtil.string2time(data.seasonModeCfg.endTime)

	self:updateTimer()
	removetimer(self.updateTimer, self)
	settimer(1, self.updateTimer, self)
end

function SeasonInfoView:_refreshAchievementPveUI()
	local data = self._viewData

	if self._viewData == nil or data.gameMode ~= SeasonModel.PVE_GAME_MODE_PVE and data.gameMode ~= SeasonModel.PVE_GAME_MODE_NONE then
		GameUtil.SetActive(self._achievementPve, false)

		return
	end

	GameUtil.SetActive(self._achievementPve, true)

	self._achievementPve_txtProgress.text = "完成度: <color=#6CEF89FF>" .. string.format("%.2f%%", checknumber(data.gamePercent)) .. "</color>"
	self._achievementPve_txtBoss.text = "BOSS挑战: <color=#6CEF89FF>" .. (data.isFinish and "完成" or "未完成") .. "</color>"
	self._achievementPve_txtScore.text = "积分排名: <color=#6CEF89FF>" .. ((data.rank > 0 or nil) and (data.rank or "未上榜")) .. "</color>"

	for idx, item in ipairs(self._achievementPve_tileItemList) do
		item.txtNum.text = data.occupied[idx] or 0
	end
end

function SeasonInfoView:_refreshAchievementGveUI()
	local data = self._viewData

	if self._viewData == nil or data.gameMode ~= SeasonModel.PVE_GAME_MODE_GVE then
		GameUtil.SetActive(self._achievementGve, false)

		return
	end

	GameUtil.SetActive(self._achievementGve, true)

	self._achievementGve_txtProgress.text = "完成度: <color=#6CEF89FF>" .. string.format("%.2f%%", checknumber(data.gamePercent)) .. "</color>"
	self._achievementGve_txtBoss.text = "我的BOSS挑战: <color=#6CEF89FF>" .. (data.isFinish and "完成" or "未完成") .. "</color>"
	self._achievementGve_txtBossFriend.text = "队友BOSS挑战: <color=#6CEF89FF>" .. (data.teammateIsFinish and "完成" or "未完成") .. "</color>"
	self._achievementGve_txtScore.text = "积分排名: <color=#6CEF89FF>" .. ((data.rank > 0 or nil) and (data.rank or "未上榜")) .. "</color>"

	for idx, item in ipairs(self._achievementGve_tileItemList) do
		item.txtNum.text = data.occupied[idx] or 0
	end

	if data.teamate then
		self._achievementGve_txtFriendName.text = data.teamate.userName or ""
	end

	if data.teamate then
		HeadItemController.instance:setHeadCellByInfo(self._achievementGve_head, data.teamate, true)
	else
		HeadItemController.instance:resetHeadCell(self._achievementGve_head)
	end
end

function SeasonInfoView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	MaterialMgr.setCellByCfg(data.reward, goCell)
	goutil.setActive(cell.goGeted, data.isReceive)
end

function SeasonInfoView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.goGeted = goutil.findChild(cell.go, "geted")

	MaterialMgr.resetAll(goCell)

	return cell
end

function SeasonInfoView:_updateTabCell(view, goCell, data)
	local cell = self:_clearTabCell(goCell)

	cell.textName.text = langPara("S%s%s", data.seasonId, data.name)

	cell.changeTab:SetState(data.seasonId == self._curSelectId and 1 or 0)
	GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onClickTopTap, self, data))
end

function SeasonInfoView:_clearTabCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.textName = goutil.findChildTextComponent(goCell, "txtName")
	cell.changeTab = goCell.gameObject:GetComponent(typeof(UIChangeGroup))

	GameUtil.rmClickHandler(cell.go)

	return cell
end

function SeasonInfoView:updateTimer()
	local residue = self._endTime - ServerTime.now()

	if residue > 0 then
		local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(residue)

		self._txtTime.text = day > 0 and string.format("剩余时间: %s天%s时%s分", day, hour, min) or string.format("剩余时间： %s时%s分%s秒", hour, min, sec)
	else
		removetimer(self.updateTimer, self)

		self._txtTime.text = "剩余时间: 已结束"

		return
	end
end

function SeasonInfoView:_onClickRank()
	UIStateManager.instance:push(ViewName.SeasonRankMainView, self._curSelectId)
end

function SeasonInfoView:_onClickPaint()
	UIStateManager.instance:push(ViewName.SeasonPaintView, self._curSelectId)
end

function SeasonInfoView:_onClickClose()
	self:close()
end

function SeasonInfoView:_onClickTopTap(data)
	self:_onSendGetInfo(data.seasonId)
end

function SeasonInfoView:_onSendGetInfo(seasonId)
	self._curSelectId = seasonId

	SeasonController.instance:sendGetSeasonInfo(self._curSelectId)
	self._seasonTabView:refresh()

	local idx = 1
	local data = self._seasonTabView:getData()

	for i, v in ipairs(data) do
		if data.seasonId == self._curSelectId then
			idx = i

			break
		end
	end

	self._seasonTabView:MoveCellToCenter(idx)
end

return SeasonInfoView
