-- chunkname: @IQIGame\\Scene\\RestaurantOperation\\RestaurantOperationOutPutView.lua

local m = {
	incomeID = 5
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.imgCom = self.ImgPercent:GetComponent("Image")

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:FrameUpdate()
	local nowTime = PlayerModule.GetServerTime()
	local date = getDateTimeTable(nowTime)
	local per = date.sec / 60

	self.imgCom.fillAmount = per

	self.TextNode:SetActive(per < 0.1)

	if per < 0.05 then
		local value = RestaurantOperationModule.ROAttributePOD.income[self.incomeID]

		value = value or 0

		UGUIUtil.SetText(self.TextValue, RestaurantOperationMainUIApi:GetString("TextValue", CfgRestaurantOperationIncomeTable[self.incomeID].AttName, value))
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
