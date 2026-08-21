-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingFacilitiesTempleItemCell.lua

module("logic.extensions.livingfacilities.view.LivingFacilitiesTempleItemCell", package.seeall)

local ButtonAdapter = Astral.ButtonAdapter
local M = class("LivingFacilitiesTempleItemCell")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	self._iconImg = self._viewElementsRegistry:findUIElement("live_template_item_-2133991108", UIComponentType.ImageBigBG)
	self._goSign = self._viewElementsRegistry:findUIElement("live_template_item_-2061565922")
	self._imgSign = self._viewElementsRegistry:findUIElement("live_template_item_1866576516", UIComponentType.Image)
	self._gatherGo = self._viewElementsRegistry:findUIElement("live_template_item_-1063484544")
	self._gatherText = self._viewElementsRegistry:findUIElement("live_template_item_-1110520759", UIComponentType.Text)
	self._nameText = self._viewElementsRegistry:findUIElement("live_template_item_-960298907", UIComponentType.Text)
	self._selectGo = self._viewElementsRegistry:findUIElement("live_template_item_1013617179")
	self._btnClick = ButtonAdapter.Get(self._viewElementsRegistry:findUIElement("live_template_item_-1187814421"))
	self._nameImage = self._viewElementsRegistry:findUIElement("live_template_item_1160852391")
end

function M:_clickSelf()
	HouseDispatcher:dispatchEvent(HouseEventType.LIVE_TEMPLE_SELECT, self._index)
end

function M:refreshSelectStatus(status)
	goutil.setActive(self._selectGo, status)
end

function M:setCellData(data, index)
	self._data = data
	self._index = index

	self._btnClick:AddClickListener(self._clickSelf, self)
	self:refreshView()
end

function M:_refreshIcon()
	self._iconImg:ClearImage()

	if self._isMould then
		goutil.setActive(self._goSign.gameObject, true)
		goutil.setActive(self._gatherGo.gameObject, true)

		local totalMyCount, totalCount = self._data:getCollectProgress()

		if totalCount > 0 then
			self._gatherText.text = string.format("%d%%", totalMyCount / totalCount * 100)
		else
			self._gatherText.text = "100%"
		end

		local fileName = string.format("ui/dynicon/room/room_live_template/%s.png", self._data:getIcon())

		self._iconImg:SetImage(fileName, nil, self)
	else
		goutil.setActive(self._goSign.gameObject, false)
		goutil.setActive(self._gatherGo.gameObject, false)

		local defaultFileName = "ui/dynicon/room/room_live_template/room_temple_default.png"
		local zoneMo = LivingFacilitiesZoneController.instance:getCurrentZoneMo()
		local type = zoneMo:getType()

		if LivingFacilitiesZoneController.instance:isTemplateIconNewest(type, self._index) then
			local imgIcon = self._iconImg.gameObject:GetComponent(UIComponentType.Image)
			local fullPath = LivingFacilitiesZoneController.instance:getTemplateIconFullPath(type, self._index)
			local width = LivingFacilitiesZoneController.SNAPSHOT_RT_WIDTH
			local height = LivingFacilitiesZoneController.SNAPSHOT_RT_HEIGHT
			local succeed = SpaceXFileUtil.SetImageSpriteByIO(imgIcon, fullPath, width, height)

			if not succeed then
				self._iconImg:SetImage(defaultFileName, nil, self)
			end
		else
			self._iconImg:SetImage(defaultFileName, nil, self)
		end
	end
end

function M:refreshView()
	if self._data then
		goutil.setActive(self._nameImage.gameObject, true)
		goutil.setActive(self._nameText.gameObject, true)
		goutil.setActive(self._iconImg.gameObject, true)

		self._nameText.text = self._data:getName()

		self:_refreshIcon()
	else
		goutil.setActive(self._iconImg.gameObject, false)
		goutil.setActive(self._goSign.gameObject, false)
		goutil.setActive(self._gatherGo.gameObject, false)
		goutil.setActive(self._nameImage.gameObject, false)
		goutil.setActive(self._nameText.gameObject, false)
	end
end

function M:setTempleStatus(status)
	self._isMould = status
end

function M:onExit()
	self._iconImg:ClearImage()

	if self._btnClick then
		self._btnClick:RemoveClickListener()
	end
end

function M:onDestroy()
	self._btnClick = nil
	self._data = nil
	self._index = nil
end

return M
