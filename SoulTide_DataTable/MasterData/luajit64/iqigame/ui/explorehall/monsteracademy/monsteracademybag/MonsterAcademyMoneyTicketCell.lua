-- chunkname: @IQIGame\\UI\\ExploreHall\\MonsterAcademy\\MonsterAcademyBag\\MonsterAcademyMoneyTicketCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateUpdateItemEvent()
		self:OnUpdateMonsterItemEvent()
	end

	function self.delegateOnClickTipBtn()
		self:OnBtnTipBtn()
	end

	self:AddListener()
end

function m:AddListener()
	self.TipBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickTipBtn)
	EventDispatcher.AddEventListener(EventID.MonsterAcademyUpdateItemEvent, self.delegateUpdateItemEvent)
end

function m:RemoveListener()
	self.TipBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickTipBtn)
	EventDispatcher.RemoveEventListener(EventID.MonsterAcademyUpdateItemEvent, self.delegateUpdateItemEvent)
end

function m:SetData(data)
	self.moneyID = data

	local path = UIGlobalApi.GetImagePath(CfgGalgameMonsterItemTable[self.moneyID].UIIcon)

	AssetUtil.LoadImage(self, path, self.Icon:GetComponent("Image"))

	local value = MonsterAcademyModule.GetItemNum(self.moneyID)

	UGUIUtil.SetText(self.ValueText, value)
end

function m:OnUpdateMonsterItemEvent()
	if self.moneyID > 0 then
		local value = MonsterAcademyModule.GetItemNum(self.moneyID)

		UGUIUtil.SetText(self.ValueText, value)
	end
end

function m:OnBtnTipBtn()
	if self.moneyID > 0 then
		UIModule.Open(Constant.UIControllerName.TextFollowingTipUI, Constant.UILayer.UI, {
			title = CfgGalgameMonsterItemTable[self.moneyID].Name,
			content = CfgGalgameMonsterItemTable[self.moneyID].Describe,
			refTrans = self.View.transform
		})
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
