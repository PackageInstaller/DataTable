-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddessContestHudView.lua

module("logic.extensions.goddesscontest.view.GoddessContestHudView", package.seeall)

local GoddessContestHudView = class("GoddessContestHudView", ViewComponent)

function GoddessContestHudView:buildUI()
	GoddessContestHudView.super.buildUI(self)

	self._goCell = self:getGo("tableCell")
	self._goTableView = self:getGo("tableView")
	self._tableView = ScrollerList.create(self._goTableView, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function GoddessContestHudView:bindEvents()
	GoddessContestHudView.super.bindEvents(self)
end

function GoddessContestHudView:unbindEvents()
	GoddessContestHudView.super.unbindEvents(self)
end

function GoddessContestHudView:onEnter()
	GoddessContestHudView.super.onEnter(self)

	self._curActId = GoddessContestModel.instance:getCurActId()
	self._hudCfgs = GoddessContestConfig.instance:getWinnerHudCfgsByActId(self._curActId)

	self._tableView:reloadData(self._hudCfgs)
	self._tableView:MoveCellToBegin(0)
end

function GoddessContestHudView:onExit()
	GoddessContestHudView.super.onExit(self)
	self._tableView:dispose()
end

function GoddessContestHudView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	cell.data = data

	if not string.nilorempty(data.redPointId) then
		RedPointController.instance:regRedPoint(cell.redPoint, unpack(string.split(data.redPointId, "#")))
	end

	self:_dealLockState(cell)

	if not string.nilorempty(data.picPath) then
		uGuiUtil.setSpriteToImage(cell.btn, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgPngUrl(langPara("goddesscontest/%s", data.picPath)))
	end

	GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickTab, self, cell))
end

function GoddessContestHudView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.btn = goutil.findChild(cell.go, "btn")
	cell.redPoint = goutil.findChild(cell.btn, "redPoint")
	cell.lock = goutil.findChild(cell.btn, "lock")
	cell.txtTime = goutil.findChildTextComponent(cell.lock, "txtTime")
	cell.txtTime.text = ""
	cell.data = nil

	GameUtil.rmClickHandler(cell.btn)
	uGuiUtil.clearImage(cell.btn)
	goutil.setActive(cell.redPoint, false)
	goutil.setActive(cell.lock, false)
	RedPointController.instance:unregRedPoint(cell.redPoint)

	return cell
end

function GoddessContestHudView:_onClickTab(cell)
	if cell and cell.data then
		local isLock = GameUtil.GetActive(cell.lock)

		if isLock then
			FloatWordMgr.instance:show("尚未开启！")
		elseif not string.nilorempty(cell.data.gotoStr) then
			GotoMgr.gotoByString(cell.data.gotoStr)
		end
	end
end

function GoddessContestHudView:_dealLockState(cell)
	if cell and cell.data and cell.data.dealType == "Frenzy" then
		goutil.setActive(cell.lock, true)

		local cfgs = GoddessContestConfig.instance:getFrenzyCfgsByActId(self._curActId)

		for _, v in ipairs(cfgs) do
			local timeStr = v.triggerTime

			if not string.nilorempty(timeStr) then
				local timeStrParams = string.split(timeStr, "#")
				local timePeriodType = GameUtil.getTimePeriodType(timeStrParams[1], timeStrParams[2])

				if timePeriodType == GameUtil.inTimePeriod then
					goutil.setActive(cell.lock, false)

					return
				elseif timePeriodType == GameUtil.beforeTimePeriod then
					local startDate = GameUtil.string2date(timeStrParams[1])

					if string.nilorempty(cell.txtTime.text) then
						cell.txtTime.text = string.format("%02d月%02d日%02d点开启", startDate.month, startDate.day, startDate.hour)
					end
				end
			end
		end
	end
end

return GoddessContestHudView
