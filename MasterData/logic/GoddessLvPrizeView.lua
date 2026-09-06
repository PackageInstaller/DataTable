-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddess/view/GoddessLvPrizeView.lua

module("logic.extensions.goddess.view.GoddessLvPrizeView", package.seeall)

local GoddessLvPrizeView = class("GoddessLvPrizeView", ViewComponent)

function GoddessLvPrizeView:buildUI()
	GoddessLvPrizeView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._goCell = self:getGo("tablecell")
	self._goTable = self:getGo("tableview")
	self._tableview = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function GoddessLvPrizeView:onEnter()
	GoddessLvPrizeView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.GoddessError, self._onError, self)
	GlobalDispatcher:addListener(GlobalNotify.GoddessInfoUpdate, self._refreshView, self)
	self:_refreshView()
end

function GoddessLvPrizeView:onExit()
	GoddessLvPrizeView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GoddessError, self._onError, self)
	GlobalDispatcher:removeListener(GlobalNotify.GoddessInfoUpdate, self._refreshView, self)
end

function GoddessLvPrizeView:bindEvents()
	GoddessLvPrizeView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function GoddessLvPrizeView:unbindEvents()
	GoddessLvPrizeView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function GoddessLvPrizeView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	cell.txtDes.text = langPara("亲密度达到%s级", data.level)

	if self._curInfo.curLv >= data.level then
		goutil.setActive(cell.markNotFinish, false)

		if table.keyof(self._curHasGainIds, data.id) then
			goutil.setActive(cell.markGain, true)
			goutil.setActive(cell.btnGain, false)
		else
			goutil.setActive(cell.markGain, false)
			goutil.setActive(cell.btnGain, true)
		end
	else
		goutil.setActive(cell.markGain, false)
		goutil.setActive(cell.btnGain, false)
		goutil.setActive(cell.markNotFinish, true)
	end

	GameUtil.addClickHandler(cell.btnGain, GameUtil.handler(self._onClickGainPrize, self, data))

	local matPrzies = not string.nilorempty(data.prize) and string.split(data.prize, "#") or {}

	for i = 1, 4 do
		if matPrzies[i] then
			MaterialMgr.setCellByCfg(matPrzies[i], cell.itemcells[i])
		end
	end
end

function GoddessLvPrizeView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.itemcells = {}

	for i = 1, 4 do
		cell.itemcells[i] = goutil.findChild(cell.go, "items/" .. i)

		MaterialMgr.resetAll(cell.itemcells[i])
	end

	cell.txtDes = goutil.findChildTextComponent(cell.go, "imgDes/txt")
	cell.markNotFinish = goutil.findChild(cell.go, "state/markNotFinish")
	cell.markGain = goutil.findChild(cell.go, "state/markGain")
	cell.btnGain = goutil.findChild(cell.go, "state/btnGain")

	GameUtil.rmClickHandler(cell.btnGain)

	return cell
end

function GoddessLvPrizeView:_refreshView()
	local curDataList = {}

	self._curInfo = GoddessModel.instance:getCurGoddessInfo()

	if self._curInfo then
		if self._curInfo then
			self._curHasGainIds = self._curInfo.gainPrizeIds or {}

			local id_insert = 1

			for k, v in ipairs(self._curInfo) do
				if not table.keyof(self._curHasGainIds, v.id) then
					table.insert(curDataList, id_insert, v)

					id_insert = 1 + id_insert
				else
					table.insert(curDataList, v)
				end
			end
		end

		self._tableview:reloadData(curDataList)
	end
end

function GoddessLvPrizeView:_onClickGainPrize(data)
	GoddessController.instance:gainGoodFeelingPrize(self._curInfo.raceId, data.id)
end

function GoddessLvPrizeView:_onError(staus)
	return
end

return GoddessLvPrizeView
