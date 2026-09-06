-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scratch/view/ScratchRewardList.lua

module("logic.extensions.scratch.view.ScratchRewardList", package.seeall)

local ScratchRewardList = class("ScratchRewardList")

function ScratchRewardList:ctor()
	return
end

function ScratchRewardList:buildUI(go, item)
	self._tableview = goutil.findChild(go, "rewardList"):GetComponent("UITableview")
	self._tableCell = item

	self._tableCell:SetActive(false)
end

function ScratchRewardList:bindEvents()
	return
end

function ScratchRewardList:unbindEvents()
	return
end

function ScratchRewardList:onEnter(planId, typeId)
	GlobalDispatcher:addListener(GlobalNotify.ScratchRemoveSelect, self._removeSpecificId, self)
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)

	self._curViewDatas = {}
	self._typeId = typeId

	local cfgs = ScratchConfig.instance:getScratchPrizeCfgsById(planId, typeId)

	for i, v in ipairs(cfgs) do
		local element = {}

		element.id = v.id
		element.planId = v.planId
		element.rewardType = v.type
		element.prize = v.prize
		element.isSelect = false

		table.insert(self._curViewDatas, element)
	end

	self._tableview:ReloadData()
end

function ScratchRewardList:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.ScratchRemoveSelect, self._removeSpecificId, self)
	self._tableview:Travel(self._clearTableview, self)
	self._tableview:UnRegisterAllCallbacks()
end

function ScratchRewardList:_numInView()
	return #self._curViewDatas
end

function ScratchRewardList:_cellSize()
	return 80, 80
end

function ScratchRewardList:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	cell.index = index

	self:_updateCell(view, cell, data)

	return cell
end

function ScratchRewardList:_updateCell(view, cell, data)
	local idx = cell.index
	local component = GameUtil.AddLuaOnce(cell.gameObject, ScratchRewardItem)

	component:init(idx, data, self)
end

function ScratchRewardList:_clearTableview(cell)
	local component = GameUtil.AddLuaOnce(cell.gameObject, ScratchRewardItem)

	component:reset()
end

function ScratchRewardList:_removeSpecificId(rewardType)
	if self._typeId == rewardType then
		local id = ScratchModel.instance:removeFirstSelect(rewardType)
		local index = -1

		for i, v in ipairs(self._curViewDatas) do
			if v.id == id then
				index = i - 1
			end
		end

		local cell = self._tableview:GetCellAtIndex(index)

		if cell then
			local component = GameUtil.GetLua(cell.gameObject, ScratchRewardItem)

			if component then
				component:cancelSelect()
			end
		end
	end
end

return ScratchRewardList
