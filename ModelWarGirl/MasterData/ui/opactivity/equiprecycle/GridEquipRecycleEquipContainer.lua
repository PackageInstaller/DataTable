-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\EquipRecycle\\GridEquipRecycleEquipContainer.lua

local GridEquipRecycleEquipContainer = Class("GridEquipRecycleEquipContainer", UIControls.ScrollViewLoopCell)

function GridEquipRecycleEquipContainer:ctor(...)
	self:initUI()
end

function GridEquipRecycleEquipContainer:initUI(...)
	self.gridEquip = UIControls.EquipGridChild(self, "GridEquipItem", "System/Common/Grid/GridEquipItem", 0, 0, true)
	self.gridEquip.mEnableTips = false
	self.txtNum = UIControls.Label(self, "NumPanel/TxtNum")
	self.button = UIControls.Button(self, "Button")

	self.button:addEventClick(self.onBtnClick)
end

function GridEquipRecycleEquipContainer:setObject(equip)
	self.equip = equip

	self.gridEquip:setObj(equip)

	if self.equip.recycleListIndex and self.equip.recycleListIndex ~= 0 then
		self.txtNum:setText(equip.recycleIndex)

		if equip.inOtherList then
			self:playStateAnimator("Container2Lock")
		elseif equip.recycleIndex == 1 and equip.listStarted then
			self:playStateAnimator("Container2NumLock")
		else
			self:playStateAnimator("Container2Num")
		end
	else
		self:playStateAnimator("Container2")
	end
end

function GridEquipRecycleEquipContainer:setSelectCallback(fun)
	self.selectCallback = fun
end

function GridEquipRecycleEquipContainer:setSelected(...)
	return
end

function GridEquipRecycleEquipContainer:setState(...)
	return
end

function GridEquipRecycleEquipContainer:onBtnSelect(sender)
	if self.selectCallback then
		self.selectCallback(self)
	end
end

function GridEquipRecycleEquipContainer:onBtnClick()
	if self.selectCallback then
		self.selectCallback(self)
	end
end

return GridEquipRecycleEquipContainer
