-- chunkname: @IQIGame\\UI\\AssisInFighting\\AIFFriendHeroCell.lua

AIFFriendHeroCell = {
	SkillCellList = {}
}

function AIFFriendHeroCell.New(go, mainView)
	local o = Clone(AIFFriendHeroCell)

	o:Initialize(go, mainView)

	return o
end

function AIFFriendHeroCell:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	function self.Delegation_UpFormationBtnClick()
		self:UpFormationBtnClick()
	end

	function self.Delegation_AddHeroClick()
		self:AddHeroClick()
	end

	function self.Delegation_DetailsBtnClick()
		self:DetailsBtnClick()
	end

	self.mainView = mainView
	self.gameObject = go
	self.ElementIcon = self.Element:GetComponent("Image")
	self.ProfessionIcon = self.Profession:GetComponent("Image")
	self.WarlockIcon = self._WarlockIcon:GetComponent("Image")
	self.Name = self.NameText:GetComponent("Text")
	self.UpFormationBtn = self.UpFormationBtn:GetComponent("Button")

	self.UpFormationBtn.onClick:AddListener(self.Delegation_UpFormationBtnClick)

	self.AddFriend = self.AddFriend:GetComponent("Button")

	self.AddFriend.onClick:AddListener(self.Delegation_AddHeroClick)

	self.DetailsBtn = self.DetailsBtn:GetComponent("Button")

	self.DetailsBtn.onClick:AddListener(self.Delegation_DetailsBtnClick)

	self.LvText = self.Lvtext:GetComponent("Text")
end

function AIFFriendHeroCell:RefreshData(_HeroData)
	self._HeroData = _HeroData

	local path1 = WarlockApi:GetElementIconPath(self._HeroData.BaseData.Elements)

	AssetUtil.LoadImage(self, path1, self.ElementIcon)

	local path2 = WarlockApi:GetProfessionIconPath(self._HeroData.BaseData.Profession)

	AssetUtil.LoadImage(self, path2, self.ProfessionIcon)

	local headPath = SkinModule.GetHeroSkinImgPathByTypeWithSkinCid(self._HeroData.hero.heroSkin.skinCid, Constant.SkinImageType.AssistInFightingImg)

	AssetUtil.LoadImage(self, headPath, self.WarlockIcon, function()
		return
	end)

	self.LvText.text = OtherExtendApi:GetTextTitle_1() .. self._HeroData.hero.lv
	self.Name.text = self._HeroData.pname

	self:RefreshSkillData()

	if self._HeroData.type == 5 then
		self.AddFriend.interactable = false
	else
		self.AddFriend.interactable = true
	end

	self.AddFriend.gameObject:SetActive(not self._HeroData.isFriend)
	self.MyFriend:SetActive(self._HeroData.isFriend)
end

function AIFFriendHeroCell:LoadImage(path, icon)
	if path ~= nil then
		icon.sprite = self.mainView.UIController:GetPreloadedAsset(path)
	end

	icon.transform.localScale = Vector3.New(1, 1, 1)

	icon:SetNativeSize()
end

function AIFFriendHeroCell:RefreshSkillData()
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

		if self._HeroData.hero.skill[i] ~= nil then
			userTable.ShowRoot:SetActive(true)
			userTable.HideRoot:SetActive(false)

			local v = self._HeroData.hero.skill[i]
			local SkillIcon = userTable.Icon:GetComponent("Image")
			local config = AssistInFightingModule.GetSkillConfig(v.skillCid)
			local path1 = UIGlobalApi.GetIconPath(config.Icon)

			AssetUtil.LoadImage(self, path1, SkillIcon)

			if userTable.SkillLv == nil then
				userTable.SkillLv = userTable.Lv:GetComponent("Text")
			end

			if v.lv < 10 then
				userTable.SkillLv.text = "0" .. v.lv
			else
				userTable.SkillLv.text = v.lv
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

function AIFFriendHeroCell:AddHeroClick()
	FriendModule.SendApplyFriend(self._HeroData.pid)
end

function AIFFriendHeroCell:DetailsBtnClick(_self, go)
	PlayerModule.GetHeroInfoAndOpenRoleDetailsUI(self._HeroData.pid, self._HeroData.serverId, self._HeroData.hero.cid)
end

function AIFFriendHeroCell:UpFormationBtnClick(_self, go)
	local helpHeroPOD = Clone(self._HeroData)

	EventDispatcher.Dispatch(EventID.SelectHelpHeroEvent, helpHeroPOD)
	UIModule.Close(Constant.UIControllerName.AssistInFigChooseUI)
end

function AIFFriendHeroCell:OnDestroy()
	self.UpFormationBtn.onClick:RemoveListener(self.UpFormationBtnClick)
	self.AddFriend.onClick:RemoveListener(self.AddHeroClick)
	self.DetailsBtn.onClick:RemoveListener(self.DetailsBtnClick)
	AssetUtil.UnloadAsset(self)

	for i = 1, #self.SkillCellList do
		LuaCodeInterface.ClearOutlet(self.SkillCellList[i].obj, self.SkillCellList[i].userTable)
	end

	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

return AIFFriendHeroCell
