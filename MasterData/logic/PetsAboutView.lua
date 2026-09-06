-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petshandbook/view/PetsAboutView.lua

module("logic.extensions.petshandbook.view.PetsAboutView", package.seeall)

local PetsAboutView = class("PetsAboutView")

function PetsAboutView.AddOnce(go)
	local component = PetsAboutView.Get(go)

	component = component or Framework.LuaComponentContainer.Add(go, PetsAboutView)

	return component
end

function PetsAboutView.Remove(go)
	Framework.LuaComponentContainer.Remove(go, PetsAboutView)
end

function PetsAboutView.Get(go)
	return (Framework.LuaComponentContainer.Get(go, PetsAboutView))
end

function PetsAboutView:ctor(container)
	self._container = container
end

function PetsAboutView:_onBuildUI()
	self._tableview = goutil.findChild(self._container, "Scrl_Pet"):GetComponent("UITableview")

	self._tableview:RegisterCallback(self.GetCellNum, self.getTableView, self.onCellAtIndex, self)
	self._tableview:RegisterUpdateCellCallback(self.onCellUpdate)
	self._tableview:SetOffsetWithoutRefresh(0)
end

function PetsAboutView:unbindEvents()
	return
end

function PetsAboutView:reLoadData()
	self:_initCellData()
	self._tableview:ReloadData()
end

function PetsAboutView:setTableCell(cell)
	self._tableCell = cell
end

function PetsAboutView:setPetData(petData)
	self._petData = petData
end

function PetsAboutView:_initCellData()
	self._cellData = PetsHandBookModel.instance:getAboutPets(self._petData)
end

function PetsAboutView:GetCellNum()
	return #self._cellData
end

function PetsAboutView:onCellAtIndex(view, index)
	local cell = view:DequeueCell()

	if not cell then
		cell = view:AddChild(self._tableCell)

		local component = PetsItemView.AddOnce(cell.gameObject)

		component:addListener(ItemPet.Events.Click, self._OnClickPet, self)
	end

	local cellDat = self._cellData[index + 1]

	cell.data = index + 1

	self:onCellInit(view, cell, cellDat)

	return cell
end

function PetsAboutView:onCellUpdate(view, cell)
	local idx = cell.index
	local CellDat = self._cellData[idx + 1]

	cell.data = idx + 1

	self:onCellInit(view, cell, CellDat)
end

function PetsAboutView:onCellInit(view, cell, cellDat)
	local component = PetsItemView.AddOnce(cell.gameObject)

	component:Init(cellDat, true)
end

function PetsAboutView:_OnClickPet(data)
	GlobalDispatcher:dispatch(GlobalNotify.RefreshDetail, data)
end

return PetsAboutView
