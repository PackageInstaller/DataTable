-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineevolve/view/DivineEvolveHandbookView.lua

module("logic.extensions.divineevolve.view.DivineEvolveHandbookView", package.seeall)

local DivineEvolveHandbookView = class("DivineEvolveHandbookView", TableViewComponent)

DivineEvolveHandbookView.EventClick = "divineclick"

function DivineEvolveHandbookView:ctor()
	DivineEvolveHandbookView.super.ctor(self)
end

function DivineEvolveHandbookView:buildUI()
	DivineEvolveHandbookView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnLook = self:getBtn("btnLook")
	self._roleGo = self:getGo("role")
end

function DivineEvolveHandbookView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "tableview"
	}
end

function DivineEvolveHandbookView:bindEvents()
	DivineEvolveHandbookView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnLook:AddClickListener(self._onClickLook, self)
end

function DivineEvolveHandbookView:unbindEvents()
	DivineEvolveHandbookView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnLook:RemoveClickListener()
end

function DivineEvolveHandbookView:onEnter()
	DivineEvolveHandbookView.super.onEnter(self)
	DivineEvolveController.instance:registerNotify(DivineEvolveHandbookView.EventClick, self._onClickItem, self)

	self._curRaceId = nil

	self:_showList()
end

function DivineEvolveHandbookView:onExit()
	DivineEvolveHandbookView.super.onExit(self)
	DivineEvolveController.instance:unregisterNotify(DivineEvolveHandbookView.EventClick, self._onClickItem, self)
	self:_resetRoleModel()
end

function DivineEvolveHandbookView:_onClickClose()
	self:close()
end

function DivineEvolveHandbookView:_onClickLook()
	if self._curRaceId and self._curRaceId > 0 then
		local cfg = CharacterConfig.instance:getPetCo(self._curRaceId)

		if cfg then
			UIStateManager.instance:push(ViewName.DivineEvolveLookView, cfg.kamuiProgramId)
		end
	end
end

function DivineEvolveHandbookView:_onClickItem(index)
	for i, v in ipairs(self._curViewDatas) do
		v.isSelect = i == index
	end

	self:reloadData()
end

function DivineEvolveHandbookView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local name = goutil.findChildTextComponent(cell, "name")
	local select = goutil.findChild(cell, "select")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")

	local function func()
		goutil.setActive(select, true)

		if cell then
			if self._curRaceId == data.cfg.raceId then
				return
			end

			self:_setRaceId(data.cfg)
			DivineEvolveController.instance:notify(DivineEvolveHandbookView.EventClick, cell.data)
		end
	end

	btn:AddClickListener(func)
	MaterialMgr.setCell(MatType.Pet, data.cfg.raceId, item)

	name.text = data.cfg.name

	goutil.setActive(select, data.isSelect)
end

function DivineEvolveHandbookView:_setRaceId(cfg)
	if not cfg then
		return
	end

	self._curRaceId = cfg.raceId

	self:_showRoleModel(cfg.faceIds)
end

function DivineEvolveHandbookView:_clearTableview(cell)
	local item = goutil.findChild(cell, "item")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")

	MaterialMgr.resetAll(item)
	btn:RemoveClickListener()
end

function DivineEvolveHandbookView:_showList()
	local divineList = DivineEvolveController.instance:getDivineList()
	local list = {}
	local firstCfg

	for i, v in ipairs(divineList) do
		local element = {}

		element.cfg = v
		element.isSelect = i == 1

		table.insert(list, element)

		if i == 1 then
			firstCfg = v
		end
	end

	self:updateListData(list)
	self:_setRaceId(firstCfg)
end

function DivineEvolveHandbookView:_showRoleModel(curFaceId)
	local offset = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(loader, curFaceId, self._roleGo, scale, nil, true, x, y)
end

function DivineEvolveHandbookView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

return DivineEvolveHandbookView
