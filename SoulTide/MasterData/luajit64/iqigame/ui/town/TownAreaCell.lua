-- chunkname: @IQIGame\\UI\\Town\\TownAreaCell.lua

TownAreaCell = {
	outScreenType = 0
}

function TownAreaCell.New(go, rootCanvas)
	local o = Clone(TownAreaCell)

	o:InitView(go, rootCanvas)

	return o
end

function TownAreaCell:InitView(itemCellView, rootCanvas)
	self.goView = itemCellView
	self.rootCanvas = rootCanvas

	LuaCodeInterface.BindOutlet(self.goView, self)

	self.textNameComponent = self.TextName:GetComponent("Text")
	self.grayComp = self.goView:GetComponent("ImageGroupGrayComponent")

	function self.delegateClickStory1()
		self:OnClickStory1()
	end

	function self.delegateClickStory2()
		self:OnClickStory2()
	end

	function self.delegateUpDateTownHandBookEvent()
		self:OnUpDateTownHandBookEvent()
	end

	self.GuildRed:SetActive(false)
	self:AddListener()
end

function TownAreaCell:SetItem(townAreaData)
	self.townAreaData = townAreaData

	if self.townAreaData == nil then
		self:Close()
	else
		self:Update()
	end
end

function TownAreaCell:AddListener()
	self.Mould2:GetComponent("Button").onClick:AddListener(self.delegateClickStory1)
	self.Mould3:GetComponent("Button").onClick:AddListener(self.delegateClickStory2)
	EventDispatcher.AddEventListener(EventID.UpDateTownHandBookEvent, self.delegateUpDateTownHandBookEvent)
end

function TownAreaCell:RemoveListener()
	self.Mould2:GetComponent("Button").onClick:RemoveListener(self.delegateClickStory1)
	self.Mould3:GetComponent("Button").onClick:RemoveListener(self.delegateClickStory2)
	EventDispatcher.RemoveEventListener(EventID.UpDateTownHandBookEvent, self.delegateUpDateTownHandBookEvent)
end

function TownAreaCell:Refresh()
	if self.townAreaData ~= nil then
		self.townAreaData = TownModule.GetTownAreaData(self.townAreaData.cfgID)

		self:Update()
	end
end

function TownAreaCell:Update()
	self.goView.name = tostring(self.townAreaData.cfgID)
	self.textNameComponent.text = self.townAreaData.cfgInfo.ShortName

	self.grayComp:EnableGray(not self.townAreaData.isLock)
	self.Grid:SetActive(false)
	self.goView:SetActive(self.townAreaData.isLock)
	self.Mould1:SetActive(false)
	self.Mould2:SetActive(false)
	self.Mould3:SetActive(false)
	self.Mould4:SetActive(false)
	self.Mould5:SetActive(false)
	self.Effect:SetActive(false)

	self.townFunctionData1 = nil
	self.townFunctionData2 = nil

	local show = self.townAreaData.cfgID == 15001 or self.townAreaData.cfgID == 15002

	self.BtnSelf:SetActive(not show)

	if self.townAreaData.cfgID == 10110 then
		self.Grid:SetActive(self.townAreaData.isLock)
		self:SetGuildRedPoint(GuildModule.status)
	end

	if self.townAreaData.isLock == true then
		for i = 1, #self.townAreaData.townFunDic do
			local townFunctionData = self.townAreaData.townFunDic[i]
			local icon
			local isShow = false

			if townFunctionData ~= nil and townFunctionData:IsFunctionOpen() then
				icon = townFunctionData.icon
				isShow = true
			end

			if isShow then
				self.Grid:SetActive(true)

				local imgCom

				if townFunctionData.threadType == 1 then
					self.townFunctionData1 = townFunctionData

					self.Mould2:SetActive(true)
					self.Effect:SetActive(true)

					imgCom = self.Icon2:GetComponent("Image")
				elseif townFunctionData.threadType == 2 then
					self.townFunctionData2 = townFunctionData

					self.Mould3:SetActive(true)
					self.Effect:SetActive(true)

					imgCom = self.Icon3:GetComponent("Image")
				elseif townFunctionData.functionType == TownModule.TOWN_FUNCTION_SOUL_NEW_STORY then
					self.Mould4:SetActive(true)
					self.Effect:SetActive(true)

					imgCom = self.Icon4:GetComponent("Image")
				elseif townFunctionData.functionType == TownModule.TOWN_FUNCTION_SHOPPING then
					self.Mould5:SetActive(true)

					imgCom = self.Icon5:GetComponent("Image")
				else
					self.Mould1:SetActive(true)

					imgCom = self.Icon1:GetComponent("Image")
				end

				if imgCom ~= nil and icon ~= nil then
					local iconPath = UIGlobalApi.ImagePath .. icon

					AssetUtil.LoadImage(self, iconPath, imgCom)
				end
			end
		end
	end

	self:UpdatePos()
end

function TownAreaCell:SetGuildRedPoint(top)
	self.GuildRed:SetActive(top)
end

function TownAreaCell:OnUpDateTownHandBookEvent()
	self:Update()
end

function TownAreaCell:UpdatePos()
	if self.townAreaData then
		local point = UnityEngine.GameObject.Find("Root/TownAreaPoints/" .. self.townAreaData.cfgID)

		if point then
			local pos = point.transform.position
			local uiPos, v_v3 = self:ConvertPosToUI(pos)

			self.goView.transform.position = uiPos

			if v_v3.x < 0 then
				self.outScreenType = -1
			elseif v_v3.x > UnityEngine.Screen.width then
				self.outScreenType = 1
			else
				self.outScreenType = 0
			end

			self.v_v3 = v_v3
		end
	end
end

function TownAreaCell:OnClickStory1()
	if self.townFunctionData1 then
		TownModule.ExecutionEvent(self.townFunctionData1)

		self.townFunctionData1 = nil
	end
end

function TownAreaCell:OnClickStory2()
	if self.townFunctionData2 then
		TownModule.ExecutionEvent(self.townFunctionData2)

		self.townFunctionData2 = nil
	end
end

function TownAreaCell:ConvertPosToUI(pos)
	local v_v3 = pos

	if UnityEngine.Camera.main and not LuaCodeInterface.GameObjIsDestroy(UnityEngine.Camera.main) then
		v_v3 = UnityEngine.Camera.main:WorldToScreenPoint(pos)
	end

	local v_ui = self.rootCanvas.worldCamera:ScreenToWorldPoint(v_v3)
	local v_new = Vector3(v_ui.x, v_ui.y, self.rootCanvas.transform.anchoredPosition3D.z - 1)

	return v_new, v_v3
end

function TownAreaCell:ScreenToWorldPoint()
	local pos = screenToWorldPoint(self.rootCanvas.worldCamera, UnityEngine.Camera.main, self.goView.transform, nil)

	return pos
end

function TownAreaCell:Close()
	self.goView:SetActive(false)
end

function TownAreaCell:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.goView, self)
	UnityEngine.Object.Destroy(self.goView)

	self.goView = nil
end

return TownAreaCell
