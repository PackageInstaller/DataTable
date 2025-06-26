-- chunkname: @IQIGame\\UI\\FurnitureLottery\\FurnitureLotteryShowPic.lua

local FurnitureLotteryShowPic = {}

function FurnitureLotteryShowPic.__New(ui)
	local o = Clone(FurnitureLotteryShowPic)

	o:InitView(ui)

	return o
end

function FurnitureLotteryShowPic:InitView(ui)
	self.rootUI = ui

	LuaCodeInterface.BindOutlet(self.rootUI, self)

	self.rollingImageComponent = self.BulletinContainer:GetComponent("RollingImageComponent")
end

function FurnitureLotteryShowPic:AddEventListener()
	return
end

function FurnitureLotteryShowPic:RemoveEventListener()
	return
end

function FurnitureLotteryShowPic:UpdateView(data)
	self.furnitureLotteryData = data

	if self.furnitureLotteryData ~= nil then
		self.TimeTip:SetActive(self.furnitureLotteryData.endDateTime > 0)

		if self.furnitureLotteryData.endDateTime > 0 then
			self.TextTime:GetComponent("Text").text = "限时采购，截至到" .. tostring(getDateText(self.furnitureLotteryData.endDateTime))
		end

		self.togs = {}

		local imgPaths = {}

		for i = 1, #self.furnitureLotteryData.cfgInfo.ShowImage do
			table.insert(imgPaths, UIGlobalApi.GetImagePath(self.furnitureLotteryData.cfgInfo.ShowImage[i]))
		end

		self.rollingImageComponent:Init(imgPaths)

		local parentTransform = self.TogDotGroup.transform

		for i = 0, parentTransform.childCount - 1 do
			local obj = parentTransform:GetChild(0).gameObject

			UnityEngine.GameObject.DestroyImmediate(obj)
		end

		for i = 1, #imgPaths do
			local starObj = UnityEngine.Object.Instantiate(self.Tog)

			starObj:SetActive(true)

			local toggle = starObj:GetComponent("Toggle")

			toggle.group = self.TogDotGroup:GetComponent("ToggleGroup")
			toggle.isOn = false

			table.insert(self.togs, toggle)
			starObj.transform:SetParent(parentTransform, false)
		end

		self.currentIndex = 1

		self:ShowDot()
	end
end

function FurnitureLotteryShowPic:ShowDot()
	if self.togs ~= nil then
		for i = 1, #self.togs do
			self.togs[i].isOn = i == self.currentIndex
		end
	end
end

function FurnitureLotteryShowPic:OnUpdate()
	if self.rollingImageComponent ~= nil then
		local index = self.rollingImageComponent.CurrentIndex + 1

		if self.currentIndex ~= index then
			self.currentIndex = index

			self:ShowDot()
		end
	end
end

function FurnitureLotteryShowPic:OnDestroy()
	self:OnClose()
	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
end

function FurnitureLotteryShowPic:OnOpen()
	self.rootUI:SetActive(true)
	self:AddEventListener()
end

function FurnitureLotteryShowPic:OnClose()
	self.rootUI:SetActive(false)
	self:RemoveEventListener()
end

return FurnitureLotteryShowPic
