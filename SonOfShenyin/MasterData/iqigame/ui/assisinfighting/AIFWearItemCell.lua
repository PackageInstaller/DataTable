-- chunkname: @IQIGame\\UI\\AssisInFighting\\AIFWearItemCell.lua

AIFWearItemCell = {
	SkillCellList = {}
}

function AIFWearItemCell.New(go, mainView)
	local o = Clone(AIFWearItemCell)

	o:Initialize(go, mainView)

	return o
end

function AIFWearItemCell:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.ElementIcon = self.Element:GetComponent("Image")
	self.ProfessionIcon = self.Profession:GetComponent("Image")
	self.WarlockIcon = self._WarlockIcon:GetComponent("Image")

	self:AddClick(self.ChangeBtn, self.ChengeHeroClick)
	self:AddClick(self.AddBtn, self.AddHeroClick)
end

function AIFWearItemCell:RefreshData(_WarlockData, pos)
	self.warlockData = _WarlockData
	self.pos = pos

	LuaUtility.SetGameObjectShow(self.ShowRoot, self.warlockData ~= nil)
	LuaUtility.SetGameObjectShow(self.HideRoot, self.warlockData == nil)

	if self.warlockData ~= nil then
		local path1 = WarlockApi:GetElementIconPath(self.warlockData:GetCfg().Elements)

		AssetUtil.LoadImage(self, path1, self.ElementIcon)

		local path2 = WarlockApi:GetProfessionIconPath(self.warlockData:GetCfg().Profession)

		AssetUtil.LoadImage(self, path2, self.ProfessionIcon)

		local path3 = self.warlockData:GetCurStaticSkinImagePath(Constant.SkinImageType.AssistInFightingImg)

		AssetUtil.LoadImage(self, path3, self.WarlockIcon)
		UGUIUtil.SetText(self.Lvtext, OtherExtendApi:GetTextTitle_1() .. self.warlockData.lv)
		self:RefreshSkillData()
	end
end

function AIFWearItemCell:RefreshSkillData()
	for i = 1, 4 do
		if self.SkillCellList[i] == nil then
			local itemSkillObj = UnityEngine.Object.Instantiate(self.mainView.SkillCell.gameObject)

			itemSkillObj:SetActive(true)

			itemSkillObj.name = i

			itemSkillObj.transform:SetParent(self.SkillItemRoot.transform, false)

			self.SkillCellList[i] = {
				obj = itemSkillObj,
				userTable = {}
			}

			local userTable = self.SkillCellList[i].userTable

			LuaCodeInterface.BindOutlet(self.SkillCellList[i].obj, userTable)
		end

		local userTable = self.SkillCellList[i].userTable

		if self.warlockData.SkillGroups[i] ~= nil then
			userTable.ShowRoot:SetActive(true)
			userTable.HideRoot:SetActive(false)

			local v = self.warlockData.SkillGroups[i]
			local SkillIcon = userTable.Icon:GetComponent("Image")
			local config = AssistInFightingModule.GetSkillConfig(v.skillCid)
			local path1 = UIGlobalApi.GetIconPath(config.Icon)

			AssetUtil.LoadImage(self, path1, SkillIcon, nil, nil, nil, true)

			if userTable.SkillLv == nil then
				userTable.SkillLv = userTable.Lv:GetComponent("Text")
			end

			local skillLv = v.lv + v.extLv

			if skillLv < 10 then
				userTable.SkillLv.text = "0" .. skillLv
			else
				userTable.SkillLv.text = skillLv
			end

			if userTable.SkillName == nil then
				userTable.SkillName = userTable.Name:GetComponent("Text")
			end

			userTable.SkillName.text = config.Name
		else
			userTable.ShowRoot:SetActive(false)
			userTable.HideRoot:SetActive(true)
		end
	end
end

function AIFWearItemCell:AddHeroClick(_self, go)
	local list = AssistInFightingModule.GethelpHeroList(self.pos)
	local userdata = {
		list,
		Constant.UIControllerName.AssistInFightingUI
	}

	UIModule.Open(Constant.UIControllerName.WarlockChoosePanel, Constant.UILayer.UI, userdata)

	AssistInFightingModule.CurOperationWarlockData.pos = self.pos
	AssistInFightingModule.CurOperationWarlockData.curWarlockData = self.warlockData
end

function AIFWearItemCell:ChengeHeroClick(_self, go)
	self:AddHeroClick(_self, go)
end

function AIFWearItemCell:AddClick(Obj, action)
	local button = Obj:GetComponent("Button")

	button.onClick:RemoveAllListeners()
	button.onClick:AddListener(function()
		action(self, button.gameObject)
	end)
end

function AIFWearItemCell:RemoveClick(Obj, action)
	local button = Obj:GetComponent("Button")

	button.onClick:RemoveListener(function()
		action(self, button.gameObject)
	end)
end

function AIFWearItemCell:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i = 1, #self.SkillCellList do
		LuaCodeInterface.ClearOutlet(self.SkillCellList[i].obj, self.SkillCellList[i].userTable)
	end

	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

function AIFWearItemCell:OnAssisInFightingChangeDelegate()
	return
end

return AIFWearItemCell
