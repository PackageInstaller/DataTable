-- chunkname: @IQIGame\\UI\\Activity\\DoubleFight\\InvasionScoreTipCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function m:SetData(data)
	if data then
		local path = InvasionScoreTipsUIApi:GetString("TypePath", data.type)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))

		local per = data.scoreValue / data.maxValue

		self.ImgPer:GetComponent("Image").fillAmount = per

		UGUIUtil.SetText(self.Text1, InvasionScoreTipsUIApi:GetString("TextType", data.type))
		UGUIUtil.SetText(self.Text2, InvasionScoreTipsUIApi:GetString("TextTypeValue", data.type, data.value))
		UGUIUtil.SetText(self.Text3, InvasionScoreTipsUIApi:GetString("TextMax", data.scoreValue, data.maxValue))
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
