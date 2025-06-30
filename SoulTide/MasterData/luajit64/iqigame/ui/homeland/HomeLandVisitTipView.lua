-- chunkname: @IQIGame\\UI\\HomeLand\\HomeLandVisitTipView.lua

local HomeLandVisitTipView = {}

function HomeLandVisitTipView.New(view)
	local obj = Clone(HomeLandVisitTipView)

	obj:Init(view)

	return obj
end

function HomeLandVisitTipView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function HomeLandVisitTipView:UpDateView(type)
	if type == 1 then
		local value = CfgDiscreteDataTable[6520014].Data[1]
		local todayHelpCount = value - PlayerModule.PlayerInfo.todayHelpHomeCount

		UGUIUtil.SetText(self.TextTitle, HomeLandChooseCastleApi:GetString("HelpTextTitle"))
		UGUIUtil.SetText(self.TextMsg1, HomeLandChooseCastleApi:GetString("HelpTextMsg1", todayHelpCount, value))
		UGUIUtil.SetText(self.TextMsg2, HomeLandChooseCastleApi:GetString("HelpTextMsg2"))
	elseif type == 2 then
		local value1 = CfgDiscreteDataTable[6520015].Data[1]
		local todayOpenVisitTreasure = value1 - PlayerModule.PlayerInfo.todayOpenVisitTreasureChest

		UGUIUtil.SetText(self.TextTitle, HomeLandChooseCastleApi:GetString("TreasureTextTitle"))
		UGUIUtil.SetText(self.TextMsg1, HomeLandChooseCastleApi:GetString("TreasureTextMsg1", todayOpenVisitTreasure, value1))
		UGUIUtil.SetText(self.TextMsg2, HomeLandChooseCastleApi:GetString("TreasureTextMsg2"))
	end
end

function HomeLandVisitTipView:Open()
	self.View:SetActive(true)
end

function HomeLandVisitTipView:Close()
	self.View:SetActive(false)
end

function HomeLandVisitTipView:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return HomeLandVisitTipView
