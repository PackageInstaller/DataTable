-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/raiders/RaidersPetShow.lua

module("logic.extensions.legend.view.raiders.RaidersPetShow", package.seeall)

local RaidersPetShow = class("RaidersPetShow")

function RaidersPetShow:ctor()
	return
end

function RaidersPetShow:buildUI(parent)
	self._tableview = parent:GetComponent("UITableview")
	self._tableCell = goutil.findChild(parent, "item")

	self._tableCell:SetActive(false)
end

function RaidersPetShow:destroyUI()
	self._tableview = nil
	self._tableCell = nil
end

function RaidersPetShow:onEnter(raceIdList)
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)

	self._curViewDatas = raceIdList

	self._tableview:SetOffsetWithoutRefresh(0)
	self._tableview:ReloadData()
end

function RaidersPetShow:onExit()
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = {}

	self._tableview:UnRegisterAllCallbacks()
end

function RaidersPetShow:_numInView()
	return #self._curViewDatas
end

function RaidersPetShow:_cellSize()
	return 76, 76
end

function RaidersPetShow:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	self:_updateCell(view, cell, data)

	return cell
end

function RaidersPetShow:_updateCell(view, cell, data)
	Framework.TransformUtil.SetLocalScale(cell.gameObject.transform, 0.9, 0.9, 0.9)

	local parentGo = goutil.findChild(cell.gameObject, "node")

	MaterialMgr.setCell(MatType.Pet, data, parentGo)
end

function RaidersPetShow:_clearTableview(cell)
	local parentGo = goutil.findChild(cell.gameObject, "node")

	MaterialMgr.resetAll(parentGo)
end

return RaidersPetShow
