-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/view/ServerlistView.lua

module("logic.extensions.login.view.ServerlistView", package.seeall)

local ServerlistView = class("ServerlistView", ViewComponent)

function ServerlistView:ctor()
	ServerlistView.super.ctor(self)
end

function ServerlistView:buildUI()
	ServerlistView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnRecommond = self:getGo("btnRecommond")
	self.btnSeverList = self:getGo("btnSeverList")
	self.btnChangeSever = self:getGo("sever/btnChangeSever")
	self.txtNowSever = self:getTxt("sever/txtNowSever")
	self.txtNowIsland = self:getTxt("sever/txtNowIsland")
	self.severCell = self:getGo("sever/severCell")
	self.tableview = self:getGo("sever/tableview")
	self.headCell = self:getGo("havePlayer/headCell")
	self.playerTableview = self:getGo("havePlayer/tableview")
	self.serverScr = ScrollerList.create(self.tableview, self.severCell, GameUtil.handler(self.updateCell, self), GameUtil.handler(self.clearCell, self))
	self.playerScr = ScrollerList.create(self.playerTableview, self.headCell, GameUtil.handler(self.updatePlayerCell, self), GameUtil.handler(self.clearPlayerCell, self))
end

function ServerlistView:bindEvents()
	ServerlistView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnChangeSever, self.onChangeServer, self)
	GameUtil.addClickHandler(self.btnRecommond, self.onRecommond, self)
	GameUtil.addClickHandler(self.btnSeverList, self.onSeverList, self)
end

function ServerlistView:unbindEvents()
	ServerlistView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnChangeSever)
	GameUtil.rmClickHandler(self.btnRecommond)
	GameUtil.rmClickHandler(self.btnSeverList)
end

function ServerlistView:destroyUI()
	ServerlistView.super.destroyUI(self)
end

function ServerlistView:onEnter()
	ServerlistView.super.onEnter(self)

	self.data = self:getFirstParam()
	self.areaList = self.data.areaList
	self.playerInfoList = self.data.playerInfoList
	self.curIdx = 1

	self:refreshUI()
	GlobalDispatcher:addListener(GlobalNotify.OnIslandListCellSelect, self._handleOnIslandListCellSelect, self)
end

function ServerlistView:onEnterFinished()
	ServerlistView.super.onEnterFinished(self)
end

function ServerlistView:onExit()
	ServerlistView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnIslandListCellSelect, self._handleOnIslandListCellSelect, self)
	self.serverScr:dispose()
	self.playerScr:dispose()
end

function ServerlistView:onExitFinished()
	ServerlistView.super.onExitFinished(self)
end

function ServerlistView:_handleOnIslandListCellSelect()
	local isSuccess = self:updateDownInfo()

	if Framework.OSDef.isEditor and isSuccess then
		self:close()
	end
end

function ServerlistView:updateSerList()
	local list

	if self.curIdx == 1 then
		GameUtil.setUIGroupIdx(self.btnRecommond, 1)
		GameUtil.setUIGroupIdx(self.btnSeverList, 0)

		list = self:getTuijianList()
	else
		GameUtil.setUIGroupIdx(self.btnRecommond, 0)
		GameUtil.setUIGroupIdx(self.btnSeverList, 1)

		list = self.areaList
	end

	ArraySort.sortOn(list, "id", ArraySort.DESCENDING)
	self.serverScr:reloadData(list)
	self.playerScr:reloadData(self.playerInfoList)
end

function ServerlistView:updateDownInfo()
	self.txtNowSever.text = "--"
	self.txtNowIsland.text = "--"

	local status = LoginModel.instance.curAreaStatus

	if status then
		local area = self:getAreaStatusById(status.id)

		if area then
			self.txtNowSever.text = area.name

			local addrList = area.socketAddresses

			if addrList and #addrList > 0 then
				local addr = self:getIsland(addrList)

				self.txtNowIsland.text = addr.name

				return true
			end
		end
	end

	return false
end

function ServerlistView:refreshUI()
	self:updateSerList()
	self:updateDownInfo()
end

function ServerlistView:getAreaStatusById(areaId)
	if self.areaList then
		for k, v in pairs(self.areaList) do
			if v.id == areaId then
				return v
			end
		end
	end
end

function ServerlistView:getPlayerByArea(status)
	if self.playerInfoList then
		for k, v in pairs(self.playerInfoList) do
			if v.areaId == status.id then
				return v
			end
		end
	end
end

function ServerlistView:getIsland(moList, withFull)
	local wid = LoginModel.instance.wantGoIslandId
	local sortedServers = {}
	local baseNumber = 0

	for k, v in pairs(moList) do
		if not v.state then
			if not LoginServerListModel.rcmWeights[v.state + 1] then
				v.weight = 0

				if wid ~= nil and v.id == wid then
					return v
				end

				if withFull or v.state ~= 10 then
					baseNumber = baseNumber + v.weight

					table.insert(sortedServers, v)
				end
			end
		end
	end

	local len = #sortedServers

	if len == 0 then
		return
	end

	local rate = math.random(1, baseNumber)
	local w = 0
	local idx

	for i = 1, len do
		if rate <= w + sortedServers[i].weight then
			idx = i

			break
		end

		w = w + sortedServers[i].weight
	end

	idx = idx or 1

	local svr = sortedServers[idx]

	LoginModel.instance.wantGoIslandId = svr.id

	return svr
end

function ServerlistView:getTuijianList()
	local list = {}
	local status = LoginModel.instance.curAreaStatus

	if self.areaList then
		for k, v in pairs(self.areaList) do
			if v.labelId ~= 0 and v.modeId == 0 or v.id == status.id then
				table.insert(list, v)
			end
		end
	end

	return list
end

function ServerlistView:onRecommond()
	if self.curIdx ~= 1 then
		self.curIdx = 1

		self:updateSerList()
	end
end

function ServerlistView:onSeverList()
	if self.curIdx ~= 2 then
		self.curIdx = 2

		self:updateSerList()
	end
end

function ServerlistView:onChangeServer()
	local status = LoginModel.instance.curAreaStatus

	if status then
		local area = self:getAreaStatusById(status.id)

		if area then
			ViewMgr.instance:open(ViewName.IslandlistView, area)
		end
	end
end

function ServerlistView:updateCell(view, cell, data)
	local imgTag = goutil.findChild(cell, "imgTag")
	local imgState = goutil.findChild(cell, "imgState")
	local txtSeverName = goutil.findChildTextComponent(cell, "txtSeverName")
	local head = goutil.findChild(cell, "head")
	local icon = goutil.findChild(cell, "head/icon")
	local imgHeadKuang = goutil.findChild(cell, "head/imgHeadKuang")
	local txtLevel = goutil.findChildTextComponent(cell, "head/level/txtLevel")

	GameUtil.SetActive(imgTag, false)

	if data.labelId > 0 then
		GameUtil.SetActive(imgTag, true)
		GameUtil.setUIImageSpriteIdx(imgTag, data.labelId - 1)
	end

	GameUtil.setUIImageColorIdx(cell, 0)

	local status = LoginModel.instance.curAreaStatus

	if status and data.id == status.id then
		GameUtil.setUIImageColorIdx(cell, 1)
	end

	GameUtil.addClickHandler(cell, GameUtil.handler(self.clickSerCell, self, data))

	if data.modeId == 1 or data.modeId == 2 then
		GameUtil.setUIImageSpriteIdx(imgState, 3)
	elseif data.regUserCountPercent == 100 then
		GameUtil.setUIImageSpriteIdx(imgState, 2)
	else
		GameUtil.setUIImageSpriteIdx(imgState, 1)
	end

	txtSeverName.text = data.name

	GameUtil.SetActive(head, false)

	local player = self:getPlayerByArea(data)

	if player then
		GameUtil.SetActive(head, true)

		txtLevel.text = MofangModel.instance:getCurLvAndExp(checknumber(player.playerExp))

		HeadItemController.instance:setHeadCell(icon, player.headIconId, player.headFrameId, player.vipLv)
	end
end

function ServerlistView:clearCell(cell)
	return
end

function ServerlistView:clickSerCell(data)
	local status = LoginModel.instance.curAreaStatus

	if status and data and data.id == status.id then
		self:close()
	else
		LoginModel.instance.curAreaStatus = data
		LoginModel.instance.socketAccount = nil
		LoginModel.instance.wantGoIslandId = nil

		GlobalDispatcher:dispatch(GlobalNotify.OnServerListCellSelect)
		self:close()
	end
end

function ServerlistView:updatePlayerCell(view, cell, data)
	local icon = goutil.findChild(cell, "icon")
	local imgHeadKuang = goutil.findChild(cell, "imgHeadKuang")
	local tag = goutil.findChild(cell, "tag")
	local txtLevel = goutil.findChildTextComponent(cell, "level/txtLevel")
	local txtTime = goutil.findChildTextComponent(cell, "dayTime/txtTime")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtSever = goutil.findChildTextComponent(cell, "txtSever")

	GameUtil.SetActive(tag, checkbool(data.userClosing))

	txtLevel.text = MofangModel.instance:getCurLvAndExp(data.playerExp)

	HeadItemController.instance:setHeadCell(icon, data.headIconId, data.headFrameId, data.vipLv)

	txtName.text = data.userName

	local area = self:getAreaStatusById(data.areaId)

	txtSever.text = area and area.name or ""

	GameUtil.addClickHandler(cell, GameUtil.handler(self.clickSerCell, self, area))

	if data.hasPreCreatePlayer then
		txtTime.text = lang("预创角色")
	else
		local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(data.lastLoginTimeGapSec)

		txtTime.text = day > 0 and langPara("%s天前", day) or hour > 0 and langPara("%s小时前", hour) or min < 1 and lang("刚刚") or langPara("%s分钟前", math.max(1, min))
	end
end

function ServerlistView:clearPlayerCell(cell)
	return
end

return ServerlistView
