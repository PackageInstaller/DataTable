-- chunkname: @IQIGame\\UI\\DiceGame\\DiceGameIntroductionGroupItem.lua

local m = {
	DiceImages = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	for i = 1, 5 do
		local image = self.DiceGrid.transform:Find("Image_" .. i):GetComponent("Image")

		self.DiceImages[i] = image
	end
end

function m:SetData(name, desc, points)
	UGUIUtil.SetText(self.NameText, name)
	UGUIUtil.SetText(self.ForExampleLabel, DiceGameUIApi:GetString("IntroductionForExampleLabel"))
	UGUIUtil.SetText(self.DescText, desc)

	for i = 1, #self.DiceImages do
		local image = self.DiceImages[i]
		local point = points[i]

		AssetUtil.LoadImage(self, DiceGameUIApi:GetString("DiceImagePath", point), image)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)

	for i = 1, #self.DiceImages do
		self.DiceImages[i] = nil
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
