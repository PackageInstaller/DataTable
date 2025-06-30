-- chunkname: @IQIGame\\UI\\ExploreHall\\MonsterAcademy\\MonsterAcademyDialogOptionCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateBtnSelf()
		self:OnBtnSelf()
	end

	self:AddListener()
end

function m:AddListener()
	self.View:GetComponent("Button").onClick:AddListener(self.delegateBtnSelf)
end

function m:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.delegateBtnSelf)
end

function m:OnBtnSelf()
	if self.clickCallBack then
		self.clickCallBack(self.jumpCid, self.index)
	end
end

function m:SetData(jumpCid, index, labelStr)
	self.jumpCid = jumpCid
	self.index = index

	UGUIUtil.SetText(self.OptionLabel, labelStr)
end

function m:Dispose()
	self.clickCallBack = nil

	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
