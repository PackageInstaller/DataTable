-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summertreasuresnatch/view/customformation/SummerTreasureSnatchCustomFormationView.lua

module("logic.extensions.summertreasuresnatch.view.customformation.SummerTreasureSnatchCustomFormationView", package.seeall)

local SummerTreasureSnatchCustomFormationView = class("SummerTreasureSnatchCustomFormationView", CustomFormationView)

function SummerTreasureSnatchCustomFormationView:onEnter()
	self.addGEvent(self, GlobalNotify.PM_SummerTreasureSnatchPresetFormationRes, self._onPresetFormationRes, self)
	SummerTreasureSnatchCustomFormationView.super.onEnter(self)
end

function SummerTreasureSnatchCustomFormationView:_onPresetFormationRes()
	self.customFmtMo:updatePresetFormationMap()

	local curTabIndex = self.customFmtMo.curTabIndex
	local formation = self.customFmtMo.forMationMap[curTabIndex]

	if formation:isEmpty() then
		return
	end

	if curTabIndex == 3 then
		self:_onClickClose()
	else
		self.customFmtMo:jumpToTabIndex(curTabIndex + 1)
	end
end

return SummerTreasureSnatchCustomFormationView
