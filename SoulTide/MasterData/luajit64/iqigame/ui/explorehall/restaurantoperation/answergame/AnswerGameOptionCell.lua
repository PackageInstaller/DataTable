-- chunkname: @IQIGame\\UI\\ExploreHall\\RestaurantOperation\\AnswerGame\\AnswerGameOptionCell.lua

local m = {
	isSelect = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnSelect()
		self:OnBtnSelect()
	end

	self:AddListener()
end

function m:AddListener()
	self.State0:GetComponent("Button").onClick:AddListener(self.DelegateBtnSelect)
end

function m:RemoveListener()
	self.State0:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnSelect)
end

function m:SetData(data)
	self.optionData = data

	UGUIUtil.SetText(self.Text1, self.optionData.content)
	UGUIUtil.SetText(self.Text2, self.optionData.content)
	UGUIUtil.SetText(self.Text3, self.optionData.content)
	self.State0:SetActive(false)
	self.State1:SetActive(false)
	self.State2:SetActive(false)

	if ROAnswerGameModule.answerQuestionData.questionPOD.state == 0 then
		self.State0:SetActive(true)
	elseif ROAnswerGameModule.answerQuestionData.questionPOD.state == 2 then
		if self.optionData.isRightOption then
			self.State2:SetActive(true)
		else
			self.State0:SetActive(true)
		end
	elseif self.optionData.isRightOption then
		self.State2:SetActive(true)
	elseif ROAnswerGameModule.answerQuestionData.playerSelectID and ROAnswerGameModule.answerQuestionData.playerSelectID == self.optionData.id then
		self.State1:SetActive(true)
	else
		self.State0:SetActive(true)
	end
end

function m:SetSelect(top)
	self.isSelect = top

	self.State0:SetActive(not top)
	self.State1:SetActive(false)
	self.State2:SetActive(top)

	if top then
		self.optionData.selectID = self.optionData.id
	else
		self.optionData.selectID = 0
	end
end

function m:OnBtnSelect()
	if self.selectCallBack then
		self.selectCallBack(self)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	self.selectCallBack = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
