-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityEquipMakeFinishDlg.lua

local strClassName = "ActivityEquipMakeFinishDlg"
local ActivityEquipMakeFinishDlg = Class(strClassName, UIControls.Window)

function ActivityEquipMakeFinishDlg:ctor()
	self:initUI()
end

function ActivityEquipMakeFinishDlg:initUI()
	self.aniSelf = UIControls.UIAni(self, "")

	self.aniSelf:addEventFinish(self._onAniFinish)
end

function ActivityEquipMakeFinishDlg:_onAniFinish(aniCom, aniName)
	if aniName == "InActivityEquipCustomFinishCanvas" or aniName == "LoopActivityEquipCustomFinishCanvas" then
		if self.equipInfo then
			UIManager.getUI("activityEquipMakeSuccessDlg", true):onShow(Const.EQUIP_REFINE_TYPE.Make, self.equipInfo)
			self:setVisible(false)
		else
			self.aniSelf:startAni("LoopActivityEquipCustomFinishCanvas")
		end
	end
end

function ActivityEquipMakeFinishDlg:setData(opId)
	RPC.opActEquipMakeChoose(opId, Const.MAKE_EQUIP_CHOOSE_TYPE.Get, 0)
end

function ActivityEquipMakeFinishDlg:onFinishResp(equipInfo)
	self.equipInfo = equipInfo
end

return ActivityEquipMakeFinishDlg
