-- chunkname: @IQIGame\\UI\\Activity\\DollBingo\\BingoCell.lua

local BingoCell = {}

function BingoCell.New(view, index)
	local obj = Clone(BingoCell)

	obj:Init(view, index)

	return obj
end

function BingoCell:Init(view, index)
	self.View = view
	self.index = index

	LuaCodeInterface.BindOutlet(self.View, self)

	self.icon = self.goIcon:GetComponent("Image")

	if self.goIndex ~= nil then
		self.goIndex:GetComponent("Text").text = ActivityNewDollBingoUIApi:GetString("bingoCellIndex", self.index)

		self.goIndex:SetActive(false)
	end

	self:StopAnim()
end

function BingoCell:Refresh(state, cfgNewActivityData, cfgNumData)
	self.goSignEnable:SetActive(state)

	local grayComp = self.View:GetComponent("ImageGroupGrayComponent")

	if grayComp ~= nil then
		grayComp:EnableGray(not state)
	end

	if self.index == 9 then
		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgNewActivityData.MainCharacterHead), self.icon)
	else
		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgNumData.IconImage), self.icon)
	end

	self:StopAnim()
end

function BingoCell:OnHide()
	return
end

function BingoCell:PlayAnim()
	local comp = self.goSignEnable:GetComponent(typeof(UnityEngine.Animation))

	if comp == nil then
		return
	end

	comp:Play()
end

function BingoCell:StopAnim()
	local comp = self.goSignEnable:GetComponent(typeof(UnityEngine.Animation))

	if comp == nil then
		return
	end

	comp:Stop()
end

function BingoCell:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return BingoCell
