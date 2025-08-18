-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Item\\OpenChoose\\ChooseGroupPanel.lua

local ResRandClient = require("ClientData/ResRandClient")
local ChoosePanel = require("UI/MainState/Item/OpenChoose/ChoosePanel")
local strClassName = "ChooseGroupPanel"
local ChooseGroupPanel = Class(strClassName, ChoosePanel)

function ChooseGroupPanel:ctor()
	self:_initUI()
end

local MULTI_ONCE_NUM = 10

function ChooseGroupPanel:_initUI()
	for i = 1, 3 do
		local btnGroup = UIControls.Button(self, self.mPath .. "/GroupPanel/BtnGroup" .. i)

		btnGroup:addEventClick(self.onBtnSelectClick)

		self.btnList[i] = btnGroup
	end

	self.btnMultiUse = UIControls.Button(self, self.mPath .. "/BtnMore", "Text")

	self.btnMultiUse:addEventClick(self.onBtnMultiUseClick)
end

function ChooseGroupPanel:resetChoose()
	ChooseGroupPanel.super.resetChoose(self)
	self:_refreshMoreBtn()
end

function ChooseGroupPanel:setItem(itemGift)
	self.itemGift = itemGift

	self.txtTitle:setText(self.itemGift.name)
	self.txtTimes:setText(self.itemGift.num)

	for i, random_id in ipairs(self.itemGift.resData.extend_args3) do
		local campId = ResRandClient[random_id].show_ids[1]

		self.btnList[campId]:setVisible(true)

		self.btnList[campId].idx = i
	end

	self:onBtnSelectClick(self.btnList[1])
	self:_refreshMoreBtn()
end

function ChooseGroupPanel:_refreshMoreBtn()
	if self.itemGift.id == 540205 and self.itemGift.num >= MULTI_ONCE_NUM then
		self.btnMultiUse:setText(Lang.get(30498))
		self.btnMultiUse:setVisible(true)
	elseif self.itemGift.id == 540205 and self.itemGift.num >= 2 then
		self.btnMultiUse:setText(Lang.get(30499))
		self.btnMultiUse:setVisible(true)
	else
		self.btnMultiUse:setVisible(false)
	end
end

function ChooseGroupPanel:onBtnMultiUseClick()
	if self.itemGift.num >= MULTI_ONCE_NUM then
		RPC.itemUse({
			{
				id = self.itemGift.id,
				num = MULTI_ONCE_NUM
			}
		}, self.curSelectIdx)
	elseif self.itemGift.num > 0 then
		RPC.itemUse({
			{
				id = self.itemGift.id,
				num = self.itemGift.num
			}
		}, self.curSelectIdx)
	end
end

return ChooseGroupPanel
