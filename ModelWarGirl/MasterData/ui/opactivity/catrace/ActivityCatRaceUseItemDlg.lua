-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\CatRace\\ActivityCatRaceUseItemDlg.lua

local ResItem = require("ClientData/ResItem")
local strClassName = "activityCatUseItemDlg"
local NumControlPanel = require("UI/MainState/Item/NumControlPanel")
local ActivityCatRaceUseItemDlg = Class(strClassName, UIControls.Window)

function ActivityCatRaceUseItemDlg:ctor()
	self:initUI()
end

function ActivityCatRaceUseItemDlg:initUI()
	self.itemGridPanel = UIControls.Panel(self, "BgPanel/ItemPanel/MileItem")
	self.itemNameTxt = UIControls.Label(self, "BgPanel/ItemPanel/TextItemName")
	self.itemDescTxt = UIControls.Label(self, "BgPanel/ItemPanel/TextItem")
	self.itemNumTxt = UIControls.Label(self, "BgPanel/ItemPanel/TextNum")
	self.itemTotalDescTxt = UIControls.Label(self, "BgPanel/TextNumIncrease")
	self.numPanel = NumControlPanel(self, "BgPanel/NumPanel")
	self.numPanel.mEventNumChanged = Slot(self.onNumChanged, self)
	self.denyBtn = UIControls.Button(self, "BgPanel/BtnDeny")

	self.denyBtn:addEventClick(self._onBtnDeny)

	self.confirmBtn = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.confirmBtn:addEventClick(self._onBtnConfirm)

	self.totalValue = 0
	self.perValue = 0
end

function ActivityCatRaceUseItemDlg:setData(itemID, confirmCallback, index)
	self.itemID = itemID
	self.itemNum = CurAvatar:getItemNumById(itemID)
	self.confirmCallback = confirmCallback
	self.itemData = ResItem[itemID]
	self.grid = UIControls.ItemGridChild(self, "BgPanel/ItemPanel/MileItem", "System/Common/Grid/GridMaterialItem")
	self.grid.mEnableTips = true

	self.grid:setVisible(true)

	local fakeItem = BaseObject.GetObject(self.itemID, self.itemNum)

	self.grid:setObj(fakeItem)

	self.grid.uiConfig = {
		CloseSrcWindow = 1
	}

	self.itemNumTxt:setText(string.format(Lang.get(30234), ClientUtils.getNumShortStr(self.itemNum)))
	self.itemDescTxt:setText(self.itemData.desc)
	self.itemNameTxt:setText(self.itemData.name)
	self.numPanel:onShow(self.itemNum, self.itemNum, Lang.get(588))

	self.nowNum = self.itemNum
	self.perValue = self.itemData.extend_args1

	self:refreshData()
end

function ActivityCatRaceUseItemDlg:_onBtnConfirm()
	if self.nowNum <= 0 then
		MsgManager.notice(Lang.get(30497))
	else
		local use = {}

		use.data = {}
		use.data.id = self.itemData.id
		use.data.num = self.nowNum

		RPC.itemUse({
			use
		})
		self:setVisible(false)

		if self.confirmCallback then
			self.confirmCallback(self.totalValue)
		end
	end
end

function ActivityCatRaceUseItemDlg:_onBtnDeny()
	self:setVisible(false)
end

function ActivityCatRaceUseItemDlg:onNumChanged(num)
	self.nowNum = num

	self:refreshData()
end

function ActivityCatRaceUseItemDlg:refreshData()
	if self.perValue then
		self.totalValue = self.nowNum * self.perValue
	end

	self.itemTotalDescTxt:setText(utils.format(Lang.get(52479), self.totalValue))
end

return ActivityCatRaceUseItemDlg
