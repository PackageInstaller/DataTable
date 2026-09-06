-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petshandbook/view/PetGetWaysView.lua

module("logic.extensions.petshandbook.view.PetGetWaysView", package.seeall)

local PetGetWaysView = class("PetGetWaysView")

function PetGetWaysView.addOnce(go)
	local component = PetGetWaysView.get(go)

	component = component or Framework.LuaComponentContainer.Add(go, PetGetWaysView)

	return component
end

function PetGetWaysView.remove(go)
	Framework.LuaComponentContainer.Remove(go, PetGetWaysView)
end

function PetGetWaysView.get(go)
	return (Framework.LuaComponentContainer.Get(go, PetGetWaysView))
end

function PetGetWaysView:ctor(container)
	self._container = container
end

function PetGetWaysView:_onBuildUI()
	self._tableview = goutil.findChild(self._container, "Scrl_Ways"):GetComponent("UITableview")

	self._tableview:RegisterCallback(self.GetCellNum, self.getTableView, self.onCellAtIndex, self)
	self._tableview:RegisterUpdateCellCallback(self.onCellUpdate)
	self._tableview:SetOffsetWithoutRefresh(0)

	self._tableCell = goutil.findChild(self._container, "WayCell")
end

function PetGetWaysView:bindEvents()
	return
end

function PetGetWaysView:unbindEvents()
	return
end

function PetGetWaysView:reLoadData()
	self:_initCellData()
	self._tableview:ReloadData()
end

function PetGetWaysView:setRaceId(raceId)
	self.raceId = raceId
end

function PetGetWaysView:_initCellData()
	self._cellData = PetsHandBookModel.instance:getPetsWay(self.raceId)
end

function PetGetWaysView:GetCellNum()
	return #self._cellData
end

function PetGetWaysView:onCellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local cellDat = self._cellData[index + 1]

	cell.data = index + 1

	self:onCellInit(view, cell, cellDat)

	return cell
end

function PetGetWaysView:onCellUpdate(view, cell)
	local idx = cell.index

	cell.data = idx + 1

	self:onCellInit(view, cell, CellDat)
end

function PetGetWaysView:onCellInit(view, cell, cellDat)
	local name = goutil.findChildTextComponent(cell.gameObject, "Button/Text")

	name.text = cellDat.name

	Framework.ButtonAdapter.GetFrom(cell.gameObject, "Button"):AddClickListener(function()
		self:_onGotoGet(cellDat)
	end, self)
end

function PetGetWaysView:_onGotoGet(cellDat)
	GotoMgr.gotoByString(cellDat.jumpTo)
end

return PetGetWaysView
