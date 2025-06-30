-- chunkname: @IQIGame\\UI\\HomeLandVisit\\HomeLandHelpBtnCell.lua

local HomeLandHelpBtnCell = {}

function HomeLandHelpBtnCell.__New(ui)
	local o = Clone(HomeLandHelpBtnCell)

	o:InitView(ui)

	return o
end

function HomeLandHelpBtnCell:InitView(ui)
	self.goView = ui

	LuaCodeInterface.BindOutlet(self.goView, self)

	self.btnHelp = self.BtnHelp:GetComponent("Button")

	function self.delegateBtnHelp()
		self:OnBtnHelp()
	end

	function self.delegateOnHomelandDragIngEventArgs(sender, args)
		self:OnDragIng(sender, args)
	end

	self:AddEventListener()
end

function HomeLandHelpBtnCell:AddEventListener()
	self.btnHelp.onClick:AddListener(self.delegateBtnHelp)
	GameEntry.LuaEvent:Subscribe(HomelandDragIngEventArgs.EventId, self.delegateOnHomelandDragIngEventArgs)
end

function HomeLandHelpBtnCell:RemoveEventListener()
	self.btnHelp.onClick:RemoveListener(self.delegateBtnHelp)
	GameEntry.LuaEvent:Unsubscribe(HomelandDragIngEventArgs.EventId, self.delegateOnHomelandDragIngEventArgs)
end

function HomeLandHelpBtnCell:SetData(roomID, decorateCid, canvas)
	self.roomID = roomID
	self.decorateCid = decorateCid
	self.canvas = canvas

	self:UpdatePos()
end

function HomeLandHelpBtnCell:OnBtnHelp()
	if self.decorateCid then
		local cfgDecorate = CfgHomeLandDecorateTable[self.decorateCid]
		local cfgBuilding = CfgHomeLandBuildingTable[cfgDecorate.FunctionBuilding]
		local buildingData = HomeLandLuaModule.GetBuildingDataByID(cfgBuilding.Id)
		local isCanHelp = HomeLandVisitMould.CheckShowHelpBtnCondition(self.decorateCid)

		if not isCanHelp then
			NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, HomeLandVisitUIApi:GetString("HelpErrorMsg"))

			return
		end

		if buildingData.cfgBuildingID == 36000003 then
			local plantData = buildingData:GetPlantDataByDecorateCid(self.decorateCid)

			HomeLandVisitMould.Help(buildingData.buildingPOD.id, {
				buildingData.buildingPOD.cid,
				plantData.plantCid
			})
		else
			HomeLandVisitMould.Help(buildingData.buildingPOD.id, {
				buildingData.buildingPOD.cid
			})
		end
	end
end

function HomeLandHelpBtnCell:UpdatePos()
	local object = UnityEngine.GameObject.Find("Root/Castle/Rooms/Room" .. self.roomID .. "/Objects/decorate_" .. self.decorateCid)

	if object then
		local transform = object.transform:Find("EntityObject_" .. self.decorateCid .. "/Image_centre")

		if transform ~= nil then
			local pos = transform.position
			local uiPos = self:ConvertPosToUI(pos)

			self.goView.transform.position = uiPos
		end
	end
end

function HomeLandHelpBtnCell:ConvertPosToUI(pos)
	local v_v3 = pos

	if UnityEngine.Camera.main and not LuaCodeInterface.GameObjIsDestroy(UnityEngine.Camera.main) then
		v_v3 = UnityEngine.Camera.main:WorldToScreenPoint(pos)
	end

	local v_ui = self.canvas.worldCamera:ScreenToWorldPoint(v_v3)
	local v_new = Vector3(v_ui.x, v_ui.y, self.canvas.transform.anchoredPosition3D.z - 1)

	return v_new
end

function HomeLandHelpBtnCell:OnDragIng(sender, args)
	self:UpdatePos()
end

function HomeLandHelpBtnCell:Dispose()
	self:RemoveEventListener()
	LuaCodeInterface.ClearOutlet(self.goView, self)
	UnityEngine.GameObject.Destroy(self.goView)

	self.goView = nil
end

return HomeLandHelpBtnCell
