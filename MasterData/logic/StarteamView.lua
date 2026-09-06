-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starteam/view/StarteamView.lua

module("logic.extensions.starteam.view.StarteamView", package.seeall)

local StarteamView = class("StarteamView", ViewComponent)

function StarteamView:ctor()
	StarteamView.super.ctor(self)
end

function StarteamView:buildUI()
	StarteamView.super.buildUI(self)

	self.txtTime = self:getTxt("txtTime")
	self.txtPower = self:getTxt("txtPower")
	self.cell = self:getGo("cell")
	self.scroll = self:getGo("ScrollView")
	self.tableView = ScrollerList.create(self.scroll, self.cell, GameUtil.handler(self.updateCell, self), GameUtil.handler(self.clearCell, self))
end

function StarteamView:bindEvents()
	StarteamView.super.bindEvents(self)
end

function StarteamView:unbindEvents()
	StarteamView.super.unbindEvents(self)
end

function StarteamView:destroyUI()
	StarteamView.super.destroyUI(self)
end

function StarteamView:onEnter()
	StarteamView.super.onEnter(self)

	self.txtPower.text = "" .. RoleModel.instance:getMaxPower()

	StarTeamController.instance:getInfo(GameUtil.handler(self.updateList, self))
	self:onTimer()
	settimer(1, self.onTimer, self)
end

function StarteamView:onEnterFinished()
	StarteamView.super.onEnterFinished(self)
end

function StarteamView:onExit()
	StarteamView.super.onExit(self)
	self.tableView:dispose()
	removetimer(self.onTimer, self)
end

function StarteamView:onExitFinished()
	StarteamView.super.onExitFinished(self)
end

function StarteamView:onTimer()
	local nowTime = ServerTime.now()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.StarTeam, 15001)
	local timer = endTime - nowTime

	self.txtTime.text = timer > 0 and lang("剩余时间：") .. GameUtil.FormatTimeWordsNoSec(timer) or lang("活动时间已经结束")
end

function StarteamView:clearCell(cell)
	for i = 1, 6 do
		local con = goutil.findChild(cell, "con_" .. i)

		MaterialMgr.resetAll(con)
	end
end

function StarteamView:updateCell(view, cell, data)
	local btn = goutil.findChild(cell, "btn")
	local txt = goutil.findChildTextComponent(cell, "btn/txt")
	local txtPower = goutil.findChildTextComponent(cell, "txtPower")
	local noAchieve = goutil.findChild(cell, "noAchieve")
	local imgReceived = goutil.findChild(cell, "imgReceived")
	local zdl = RoleModel.instance:getMaxPower()

	GameUtil.SetActive(noAchieve, false)
	GameUtil.SetActive(imgReceived, false)
	GameUtil.SetActive(btn, false)

	local cfgStr = MaterialMgr.changeItemStr(data.cfg.reward)
	local arr = string.split(cfgStr, "#")

	for i = 1, 6 do
		local con = goutil.findChild(cell, "con_" .. i)

		MaterialMgr.resetAll(con)

		local str = arr[i]

		if str then
			MaterialMgr.setCellByCfg(str, con)
		end
	end

	txtPower.text = lang("战斗力达到:") .. data.cfg.teamZdlReq

	if zdl >= data.cfg.teamZdlReq and data.state == 0 then
		GameUtil.SetActive(btn, true)
	elseif data.state == 1 then
		GameUtil.SetActive(imgReceived, true)
	else
		GameUtil.SetActive(noAchieve, true)
	end

	GameUtil.addClickHandler(btn, function()
		if zdl >= data.cfg.teamZdlReq and data.state == 0 then
			StarTeamController.instance:sendGetPrize(data.index, GameUtil.handler(self.updateList, self))
		elseif data.state == 1 then
			TipsFacade.instance:openCommonTips(lang("你已经领取过奖励了"))
		else
			TipsFacade.instance:openCommonTips(lang("你的最高战斗力还没达到") .. data.cfg.teamZdlReq)
		end
	end)
end

function StarteamView:updateList()
	if self:isOpen() then
		local list = {}
		local cfgList = StarTeamConfig.instance:getPrizeList()
		local gain = StarTeamModel.instance:getHasGain()

		for i, v in ipairs(cfgList) do
			local tem = {}

			tem.cfg = v
			tem.index = i
			tem.state = gain[i] == true and 1 or 0

			table.insert(list, tem)
		end

		ArraySort.sortOn(list, {
			"state",
			"index"
		})
		self.tableView:reloadData(list)
	end
end

return StarteamView
