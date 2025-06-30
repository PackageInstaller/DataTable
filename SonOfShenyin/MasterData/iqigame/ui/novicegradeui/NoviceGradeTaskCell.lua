-- chunkname: @IQIGame\\UI\\NoviceGradeUI\\NoviceGradeTaskCell.lua

local m = {
	objPoll = {}
}

function m.New(go)
	local o = Clone(m)

	o:Initialize(go)

	return o
end

function m:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.btnGet = self.getBtn:GetComponent("Button")

	function self.DelegateOnClick()
		self:OnClick()
	end

	self.gameObject = go

	self:AddListener()
end

function m:Dispose()
	for _, v in pairs(self.objPoll) do
		v:Dispose()
	end

	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function m:AddListener()
	self.btnGet.onClick:AddListener(self.DelegateOnClick)
end

function m:RemoveListener()
	self.btnGet.onClick:RemoveListener(self.DelegateOnClick)
end

function m:OnClick()
	ActivityPassModule.SubmitTask({
		self.data.cid
	})
end

function m:Refresh(data)
	self.data = data

	if data.status == Constant.passTaskStatus.hasDone then
		LuaUtility.SetText(self.gradeNumText, string.format(ColorCfg.NoviceGradeUI.NumberText, data.needSchedule))
	else
		LuaUtility.SetText(self.gradeNumText, string.format(ColorCfg.White, data.needSchedule))
	end

	LuaUtility.SetGameObjectShow(self.getImg.gameObject, data.status == Constant.passTaskStatus.hasDone)
	LuaUtility.SetGameObjectShow(self.btnGet.gameObject, data.status == Constant.passTaskStatus.hasDone)
	LuaUtility.SetGameObjectShow(self.noFinishedText, data.status == Constant.passTaskStatus.doing)
	LuaUtility.SetGameObjectShow(self.IsFinishedState.gameObject, data.status == Constant.passTaskStatus.hadGot)
	LuaUtility.SetGameObjectShow(self.CommonSlotUI.gameObject, false)

	local actionParam = UIUtil.GetConfigArr(data.cfgTaskConfig.ActionParam)
	local actionParamLength = #actionParam

	for i = 1, actionParamLength do
		local itemCell = self.objPoll[i]

		if itemCell == nil then
			local obj = UnityEngine.Object.Instantiate(self.CommonSlotUI)

			obj.transform:SetParent(self.rewardGrid.transform, false)

			itemCell = ItemCell.New(obj)
			self.objPoll[i] = itemCell
		end

		itemCell:SetItem(ItemData.CreateByCIDAndNumber(actionParam[i][1], actionParam[i][2]))
		itemCell:SetNum(actionParam[i][2])
	end
end

return m
