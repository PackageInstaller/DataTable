-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/dreamteam/DreamTeamHudEquipView.lua

module("logic.extensions.operationsummary.view.dreamteam.DreamTeamHudEquipView", package.seeall)

local DreamTeamHudEquipView = class("DreamTeamHudEquipView", ViewComponent)

function DreamTeamHudEquipView:buildUI()
	DreamTeamHudEquipView.super.buildUI(self)

	self._btnGoTo = self:getBtn("btnGoTo")
	self._goCell = self:getGo("cell")
	self._goTable = self:getGo("tableview")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DreamTeamHudEquipView:onEnter()
	DreamTeamHudEquipView.super.onEnter(self)
	DreamTeamHudController.instance:setRDInfo(RedPointModel.ID_DREAMTEAMHUD_THIRD, DreamTeamHudController.UserDataSaveType.First)
	self:_refreshView()
end

function DreamTeamHudEquipView:onExit()
	DreamTeamHudEquipView.super.onExit(self)
end

function DreamTeamHudEquipView:bindEvents()
	DreamTeamHudEquipView.super.bindEvents(self)
	self._btnGoTo:AddClickListener(self._onClickGoTo, self)
end

function DreamTeamHudEquipView:unbindEvents()
	DreamTeamHudEquipView.super.unbindEvents(self)
	self._btnGoTo:RemoveClickListener()
end

function DreamTeamHudEquipView:_refreshView()
	local curDataList = DreamTeamHudConfig.instance:getEquipmentViewCfgs()

	self._tableView:reloadData(curDataList)
end

function DreamTeamHudEquipView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(data.skinId))

	uGuiUtil.setSpriteToImage(cell.con.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	if string.nilorempty(data.showCells) then
		goutil.setActive(cell.txtLock, true)
	else
		goutil.setActive(cell.txtLock, false)

		local prizes = string.split(data.showCells, "#")
		local matStr_1 = prizes[1]
		local matStr_2 = prizes[2]

		MaterialMgr.setCellByCfg(matStr_1, cell.prize_1)
		MaterialMgr.setCellByCfg(matStr_2, cell.prize_2)
	end
end

function DreamTeamHudEquipView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.con = goutil.findChild(cell.go, "mask/con")
	cell.prize_1 = goutil.findChild(cell.go, "prize_1")
	cell.prize_2 = goutil.findChild(cell.go, "prize_2")
	cell.txtLock = goutil.findChild(cell.go, "txtLock")

	MaterialMgr.resetAll(cell.prize_1)
	MaterialMgr.resetAll(cell.prize_2)
	uGuiUtil.clearImage(cell.con)

	return cell
end

function DreamTeamHudEquipView:_onClickGoTo()
	MaterialMgr.openGetSourceByStr("1004:1034:1")
end

return DreamTeamHudEquipView
