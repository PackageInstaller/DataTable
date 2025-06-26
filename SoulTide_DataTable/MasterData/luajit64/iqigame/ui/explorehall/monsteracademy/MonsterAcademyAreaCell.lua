-- chunkname: @IQIGame\\UI\\ExploreHall\\MonsterAcademy\\MonsterAcademyAreaCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateBtnArea()
		self:OnBtnArea()
	end

	self:AddListener()
end

function m:AddListener()
	self.BtnArea:GetComponent("Button").onClick:AddListener(self.delegateBtnArea)
end

function m:RemoveListener()
	self.BtnArea:GetComponent("Button").onClick:RemoveListener(self.delegateBtnArea)
end

function m:SetData(data)
	self.monsterAcademyAreaData = data
	self.View.name = self.monsterAcademyAreaData.cfgID

	self:UpdateView()
end

function m:UpdateView()
	self.View:SetActive(self.monsterAcademyAreaData.isLock)
	UGUIUtil.SetText(self.TextName, self.monsterAcademyAreaData.cfgInfo.Name)
	self.Tag:SetActive(#self.monsterAcademyAreaData.areaFunDic > 0)

	local showTagFunction = false
	local showTagDate = false
	local showRestFunction = false
	local specialEvent = false

	for i, v in pairs(self.monsterAcademyAreaData.areaFunDic) do
		if v.cfgFunction.AreaImage == 1 then
			showTagDate = true
		end

		if v.cfgFunction.AreaImage == 2 then
			showTagFunction = true
		end

		if v.cfgFunction.AreaImage == 3 then
			showRestFunction = true
		end

		if v.cfgFunction.AreaImage == 4 then
			specialEvent = true
		end
	end

	self.TagFunction:SetActive(showTagFunction)
	self.TagDate:SetActive(showTagDate)
	self.TagRestFunction:SetActive(showRestFunction)
	self.TagspecialEvent:SetActive(specialEvent)
	self:RefreshPos()
end

function m:RefreshPos()
	if self.monsterAcademyAreaData then
		local position = MonsterAcademyModule.GetSceneAreaPoint(self.monsterAcademyAreaData.cfgID)
		local uiPos, v_v3 = self:ConvertPosToUI(position)

		self.View.transform.position = uiPos
	end
end

function m:ConvertPosToUI(pos)
	local v_v3 = pos

	if UnityEngine.Camera.main and not LuaCodeInterface.GameObjIsDestroy(UnityEngine.Camera.main) then
		v_v3 = UnityEngine.Camera.main:WorldToScreenPoint(pos)
	end

	local canvas = self.View:GetComponentInParent(typeof(UIController)):GetComponent("Canvas")
	local v_ui = canvas.worldCamera:ScreenToWorldPoint(v_v3)
	local v_new = Vector3(v_ui.x, v_ui.y, canvas.transform.anchoredPosition3D.z - 1)

	return v_new, v_v3
end

function m:OnBtnArea()
	local cfgArea = CfgGalgameMonsterAreaTable[self.monsterAcademyAreaData.cfgID]

	if cfgArea then
		local cfgTime = MonsterAcademyModule.GetCfgGalGameDataByDayNum(MonsterAcademyModule.SaveDataDetailPOD.basePOD.day)

		if table.indexOf(cfgArea.WeekLimit, cfgTime.Week) == -1 then
			NoticeModule.ShowNotice(21045048)

			return
		end

		UIModule.Open(Constant.UIControllerName.MonsterAcademySelectPanelUI, Constant.UILayer.UI, {
			AreaCid = self.monsterAcademyAreaData.cfgID
		})
	end
end

function m:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
