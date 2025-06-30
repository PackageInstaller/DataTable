-- chunkname: @IQIGame\\UI\\RoleDevelopment\\ItemCell\\BreachMaterialsItem.lua

local m = {
	isSelect = false,
	ItemNum = 0,
	SelectCount = 0,
	isSkillItem = false
}

function m.New(view, selectCallBack, CancelCallBack)
	local obj = Clone(m)

	obj:Init(view, selectCallBack, CancelCallBack)

	return obj
end

function m:Init(view, selectCallBack, CancelCallBack)
	self.View = view
	self.SelectCallBack = selectCallBack
	self.CancelCallBack = CancelCallBack

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ItemCell = ItemCell.PackageOrReuseView(self, self.CommonSlotUI, false, false)

	function self.DelegateSelectBtnClick()
		self:OnSelectBtnClick()
	end

	function self.DelegateReduceBtnClick()
		self:CancelSelectState()
	end

	LuaUtility.SetGameObjectShow(self.SelectState, false)

	self.isSelect = false

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateSelectBtnClick)
	self.ReduceBtn:GetComponent("Button").onClick:AddListener(self.DelegateReduceBtnClick)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateSelectBtnClick)
	self.ReduceBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateReduceBtnClick)
end

function m:SetData(itemData, instanceId)
	self.ItemData = itemData
	self.instanceId = instanceId
	self.SkillData = self.ItemData.skillData
	self.isSkillItem = self.ItemData:GetCfg().ItemTypes == Constant.ItemType.Skill

	self.ItemCell:SetItem(self.ItemData)
	self.ItemCell:SetItemLvVisable(false)

	if self.isSkillItem then
		self.Lock:SetActive(self.ItemData.skillData.lock)
		self.TagHero:SetActive(self.ItemData.skillData.heroCid ~= 0)

		if self.ItemData.skillData.heroCid ~= 0 then
			AssetUtil.LoadImage(self, SkinModule.GetHeroCurrentSkinImgPath(self.ItemData.skillData.heroCid, Constant.SkinImageType.HeadIcon), self.TagHero:GetComponent("Image"))
		end

		self.ItemCell:SetItemLv(self.ItemData.skillData.lv)
	else
		self.Lock:SetActive(false)
		self.TagHero:SetActive(false)
		self.ItemCell:SetNum(1)
	end
end

function m:OnSelectBtnClick()
	if self.isSelect then
		return
	end

	if RoleDevelopmentModule.SelectBreachMaterialIsMax then
		NoticeModule.ShowNotice(20005)

		return
	end

	if self.isSkillItem then
		if self.SkillData.lock then
			NoticeModule.ShowNotice(45014)

			return
		elseif self.SkillData.heroCid ~= 0 then
			NoticeModule.ShowNotice(45015)

			return
		end
	end

	self.isSelect = true

	if self.SelectCallBack then
		self.SelectCallBack(self.ItemData, self.instanceId)
	end

	LuaUtility.SetGameObjectShow(self.SelectState, self.isSelect)
end

function m:CancelSelectState()
	if not self.isSelect then
		return
	end

	if self.CancelCallBack then
		self.CancelCallBack(self.ItemData, self.instanceId)
	end

	self.isSelect = false

	LuaUtility.SetGameObjectShow(self.SelectState, self.isSelect)
end

function m:InitState()
	self.isSelect = false

	LuaUtility.SetGameObjectShow(self.SelectState, self.isSelect)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
