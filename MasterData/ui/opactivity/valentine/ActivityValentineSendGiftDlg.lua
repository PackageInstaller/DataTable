-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\Valentine\\ActivityValentineSendGiftDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ActivityValentineGiftCell = Class("ActivityValentineGiftCell", UIControls.Child)

function ActivityValentineGiftCell:ctor()
	self.gridAward = UIControls.getGridContainer(self, "GridAward")

	self.gridAward:setVisible(true)

	self.btnGift = UIControls.Button(self, "BtnConfirm")

	self.btnGift:addEventClick(self.onGiftClick)

	self.panelAward = UIControls.Panel(self, "GridAward")
	self.imgBg = UIControls.Image(self, "LockNode/IconImg")
end

function ActivityValentineGiftCell:setData(item, formData)
	self.item = item
	self.formData = formData

	if self.item.num > 0 then
		self.gridAward:setVisible(true)
		self.btnGift:setVisible(true)
		self.gridAward:setObj(item)
	else
		self.gridAward:setVisible(false)
		self.btnGift:setVisible(false)
	end

	if self.formData.bg_icon_path then
		self.imgBg:setImage("Atlas/" .. self.formData.bg_icon_path, self.formData.bg_icon)
	end
end

function ActivityValentineGiftCell:onGiftClick()
	self.mParent.preSendData = self.formData

	RPC.opActChatGameGivingGift(self.mParent.actObj.opId, self.item.id, 1)
end

local strClassName = "ActivityValentineSendGiftDlg"
local ActivityValentineSendGiftDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivityValentineSendGiftDlg, ActivityPanelMixin)

function ActivityValentineSendGiftDlg:initUI()
	self.btnClose = UIControls.Button(self, "GvieMainPanel/CloseBtn")

	self.btnClose:addEventClick(self.onBtnClose)

	self.textLikeable = UIControls.Label(self, "GvieMainPanel/NameText/NumText")
	self.efxLikeable = UIControls.Panel(self, "GvieMainPanel/NameText/Efx")
	self.panelNothing = UIControls.Panel(self, "GvieMainPanel/BagPanel/NothingNode")
	self.panelContent = UIControls.Panel(self, "GvieMainPanel/BagPanel/Content")
	self.giftCells = {}
	self.aniLikeable = UIControls.UIAni(self, "GvieMainPanel/HeroImg")
	self.textNpc = UIControls.Label(self, "GvieMainPanel/HeroImg/NumText")
	self.bgNpc = UIControls.Panel(self, "GvieMainPanel/HeroImg/BackImge")

	self.textNpc:setVisible(false)
	self.bgNpc:setVisible(false)

	self.cellPath = "System/Activity/ActivityCookValentine/GiveCell"

	if self.replaceableCellPath and self.replaceableCellPath[1] then
		self.cellPath = "System/Activity/" .. self.replaceableCellPath[1] .. "/GiveCell"
	end
end

function ActivityValentineSendGiftDlg:_setData()
	self:refreshData()
end

function ActivityValentineSendGiftDlg:refreshData()
	self.actData = self.actObj.actData
	self.miscData = self.actData.miscData
	self.formulaData = self.actData.formulaData
	self.nowLikeAbility = self.actData.nowLikeAbility or 0

	self.textLikeable:setText(string.format(Lang.get(65473), self.nowLikeAbility))

	local items = {}

	for _, itId in ipairs(self.miscData.choclateItemList) do
		local hasNum = CurAvatar:getItemNumById(itId)

		table.insert(items, BaseObject.GetObject(itId, hasNum))
	end

	if #items > 0 then
		self.panelNothing:setVisible(false)
		self.panelContent:setVisible(true)

		for index = #self.giftCells, #items - 1 do
			local newCell = ActivityValentineGiftCell(self, "GvieMainPanel/BagPanel/Content", self.cellPath)

			table.insert(self.giftCells, newCell)
		end

		for index, cell in ipairs(self.giftCells) do
			local item = items[index]

			if item then
				cell:setVisible(true)
				cell:setData(item, self.formulaData[item.id])
			else
				cell:setVisible(false)
			end
		end
	else
		self.panelNothing:setVisible(true)
		self.panelContent:setVisible(false)
	end
end

function ActivityValentineSendGiftDlg:onRealRefresh()
	self:refreshData()
	self.aniLikeable:startAni("ShowHeroText")
	self.efxLikeable:setVisible(false)
	self.efxLikeable:setVisible(true)
	self.bgNpc:setVisible(true)
	self.textNpc:setVisible(true)

	local voice = self.preSendData.send_voice_action

	if voice and #voice > 0 then
		local vInfo = voice[math.random(1, #voice)]

		CueManager.playVocal(vInfo.id)
		self.textNpc:setText(vInfo.notice or "")
	end
end

function ActivityValentineSendGiftDlg:updateActivityData()
	if self.nowLikeAbility and self.actData.nowLikeAbility > self.nowLikeAbility and self.preSendData then
		local commonBonusDlg = UIManager.tryGetUI("commonBonusDlg")

		if commonBonusDlg then
			commonBonusDlg.closeCB = Slot(self.onRealRefresh, self)
		else
			self:onRealRefresh()
		end
	else
		self:refreshData()
	end
end

function ActivityValentineSendGiftDlg:onBtnClose()
	self:setVisible(false)

	local activityValentineChatDlg = UIManager.tryGetUI("activityValentineChatDlg")

	if activityValentineChatDlg then
		activityValentineChatDlg:refreshLockState()
	end
end

return ActivityValentineSendGiftDlg
