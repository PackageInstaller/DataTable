-- chunkname: @IQIGame\\UI\\SoulSkill\\SoulSkillView.lua

local SoulSkillView = {
	groupCellPool = {},
	infoCellPool = {}
}
local SoulSkillViewSkillCellInfo = require("IQIGame.UI.SoulSkill.SoulSkillViewSkillCellInfo")
local SoulSkillGroupCell = require("IQIGame.UI.SoulSkill.SoulSkillGroupCell")

function SoulSkillView.New(view, mainView)
	local obj = Clone(SoulSkillView)

	obj:Init(view, mainView)

	return obj
end

function SoulSkillView:Init(view, mainView)
	self.View = view
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(self.View, self)

	for i = 1, 3 do
		self.groupCellPool[i] = SoulSkillGroupCell.New(self.goTabBlock.transform:Find("Tab_" .. i).gameObject, self, i)
	end

	for i = 1, 4 do
		local go = self.goCellBlock.transform:Find("Mould_" .. i).gameObject

		self.infoCellPool[i] = SoulSkillViewSkillCellInfo.New(go, self)
	end

	self.itemCell = ItemCell2.New(self.goItemCell)
	self.tfCostMoney = self.goCostMoney:GetComponent("Text")
	self.tfCondition = self.goCondition:GetComponent("Text")
	self.btnUp = self.goBtnUp:GetComponent("Button")
	self.btnJumpTip = self.goTipBtnJump:GetComponent("Button")
	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnGuide = self.goTitleBlock.transform:Find("Button_02"):GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onClickBtnGuideDelegate()
		self:OnClickBtnGuide()
	end

	function self.onClickBtnUpDelegate()
		self:OnClickBtnUP()
	end

	function self.onChangeSkillSuccessDelegate()
		self:OnChangeSkillSuccess()
	end

	function self.onUpdateItemDelegate()
		self:OnUpdateItem()
	end

	function self.onSkillStrengthenUpSuccessDelegate()
		self:OnSkillUpSuccess()
	end

	function self.onClickBtnJumpTipDelegate()
		self:OnClickBtnJumpTip()
	end

	self.goSignMax:GetComponent("Text").text = SoulUIApi:GetString("skillViewMaxDesc")
	self.goBtnUp.transform:Find("Text"):GetComponent("Text").text = SoulUIApi:GetString("skillViewBtnUpTxt")
	self.goBtnClose.transform:Find("Text"):GetComponent("Text").text = SoulUIApi:GetString("Title", 4)
	self.goTitleBlock.transform:Find("Info/Text_01"):GetComponent("Text").text = SoulUIApi:GetString("TitleEng", 4)
	self.goTitleBlock.transform:Find("Info/Text_02"):GetComponent("Text").text = SoulUIApi:GetString("TitleHelp", 4)
	self.goTipBtnJump.transform:Find("Text"):GetComponent("Text").text = SoulUIApi:GetString("skillViewTipBtnJumpTxt")
end

function SoulSkillView:Open(soulData)
	self.soulData = soulData

	self.View:SetActive(true)
	self:OnAddListeners()
	self:RefreshGroupCells()
	self:SelectDefaultGroup()
end

function SoulSkillView:Close()
	self:OnHide()
	self.View:SetActive(false)
end

function SoulSkillView:OnHide()
	for i, v in pairs(self.groupCellPool) do
		v:OnHide()
	end

	for i, v in pairs(self.infoCellPool) do
		v:OnHide()
	end

	self.curInfoCell = nil
	self.curGroupIndex = nil

	self:OnRemoveListeners()
end

function SoulSkillView:OnDestroy()
	self.mainView = nil

	for i, v in pairs(self.groupCellPool) do
		v:OnDestroy()
	end

	for i, v in pairs(self.infoCellPool) do
		v:OnDestroy()
	end

	self.itemCell:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function SoulSkillView:OnAddListeners()
	self:OnRemoveListeners()

	for i, v in pairs(self.groupCellPool) do
		v:OnAddListeners()
	end

	for i, v in pairs(self.infoCellPool) do
		v:OnAddListeners()
	end

	self.btnUp.onClick:AddListener(self.onClickBtnUpDelegate)
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnGuide.onClick:AddListener(self.onClickBtnGuideDelegate)
	self.btnJumpTip.onClick:AddListener(self.onClickBtnJumpTipDelegate)
	EventDispatcher.AddEventListener(EventID.SoulSkillChangeSuccess, self.onChangeSkillSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.onUpdateItemDelegate)
	EventDispatcher.AddEventListener(EventID.SoulSkillStrengthenUpSuccess, self.onSkillStrengthenUpSuccessDelegate)
end

function SoulSkillView:OnRemoveListeners()
	for i, v in pairs(self.groupCellPool) do
		v:OnRemoveListeners()
	end

	for i, v in pairs(self.infoCellPool) do
		v:OnRemoveListeners()
	end

	self.btnUp.onClick:RemoveListener(self.onClickBtnUpDelegate)
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnGuide.onClick:RemoveListener(self.onClickBtnGuideDelegate)
	self.btnJumpTip.onClick:RemoveListener(self.onClickBtnJumpTipDelegate)
	EventDispatcher.RemoveEventListener(EventID.SoulSkillChangeSuccess, self.onChangeSkillSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.onUpdateItemDelegate)
	EventDispatcher.RemoveEventListener(EventID.SoulSkillStrengthenUpSuccess, self.onSkillStrengthenUpSuccessDelegate)
end

function SoulSkillView:OnClickBtnJumpTip()
	JumpModule.Jump(10213001)
end

function SoulSkillView:OnUpdateItem()
	self:RefreshUpBlock(self.curInfoCell)
end

function SoulSkillView:OnSkillUpSuccess()
	self.curInfoCell:ReRefresh()
	self:RefreshUpBlock(self.curInfoCell)
	self:RefreshGroupCells()
end

function SoulSkillView:OnChangeSkillSuccess()
	self:RefreshGroupCells()
	self:RefreshGroupDetail(self.curGroupIndex)
	self:RefreshUpBlock(self.curInfoCell)
end

function SoulSkillView:OnClickGroupCell(cell)
	self.curGroupIndex = cell.groupIndex

	for i, v in pairs(self.groupCellPool) do
		v.goSignSelect:SetActive(v.groupIndex == self.curGroupIndex)
	end

	self.goTip:SetActive(cell.groupIndex == 3)
	self.goTipBtnJump:SetActive(cell.groupIndex == 3)
	self.goBottomBlock:SetActive(cell.groupIndex ~= 3)
	self.goCellBlock:SetActive(cell.groupIndex ~= 3)

	if cell.groupIndex == 3 then
		return
	end

	self:RefreshGroupDetail(self.curGroupIndex)
end

function SoulSkillView:OnClickSkillCellInfo(isOn, cell)
	if isOn then
		self.curInfoCell = cell

		self:RefreshUpBlock(cell)
	end
end

function SoulSkillView:OnClickBtnUP()
	local canUpLv = not self.curInfoCell.isMax and self.soulData.lv >= self.curInfoCell.cfgStrengthenDataTarget.UnLockLv

	if not canUpLv then
		NoticeModule.ShowNoticeNoCallback(21041036)

		return
	end

	if self.isCostEnough == false then
		NoticeModule.ShowNotice(21041051)

		return
	end

	if self.isMoneyCostEnough == false then
		NoticeModule.ShowNoticeNoCallback(21041038)

		return
	end

	SoulModule.ActivationSkillStrengthen(self.soulData.soulCid, self.curInfoCell.cfgSkillData.Id, self.curInfoCell.cfgStrengthenDataTarget.Id)
end

function SoulSkillView:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.SoulSkillUI)
end

function SoulSkillView:OnClickBtnGuide()
	return
end

function SoulSkillView:RefreshGroupCells()
	for i, v in ipairs(self.groupCellPool) do
		local groupid = CfgSoulTable[self.soulData.soulCid].DefaultSkill[i]
		local cfgGroupData = CfgSkillGroupTable[groupid]

		v:Refresh(self.soulData, cfgGroupData)
	end
end

function SoulSkillView:SelectDefaultGroup()
	if self.curGroupIndex == nil then
		self.curGroupIndex = 1
	end

	self.groupCellPool[self.curGroupIndex]:OnClickBtnSelf()
end

function SoulSkillView:RefreshGroupDetail(groupIndex)
	local curGroupCell = self.groupCellPool[groupIndex]

	for i, v in ipairs(self.infoCellPool) do
		v:Refresh(i, curGroupCell.skillIds[i], groupIndex, self.soulData)
	end

	if self.curInfoCell == nil then
		self.curInfoCell = self.infoCellPool[1]
	end

	for i, v in pairs(self.infoCellPool) do
		v.toggleSelf.isOn = false
	end

	self.curInfoCell.toggleSelf.isOn = true
end

function SoulSkillView:RefreshUpBlock(cell)
	self.goUpBlock:SetActive(cell.isUnlock and not cell.isMax)
	self.goSignMax.transform.parent.gameObject:SetActive(cell.isUnlock and cell.isMax)

	if not cell.isUnlock or cell.isMax then
		return
	end

	self.isCostEnough = true
	self.isMoneyCostEnough = true

	for i, v in ipairs(cell.cfgStrengthenDataTarget.UnLockCost) do
		if i % 2 ~= 0 then
			local id = v
			local count = cell.cfgStrengthenDataTarget.UnLockCost[i + 1]
			local ownCount = WarehouseModule.GetItemNumByCfgID(id)

			if id ~= 1 then
				self.itemCell:Refresh(id, count)

				if ownCount < count then
					self.isCostEnough = false
				end
			else
				self.tfCostMoney.text = SoulUIApi:GetString("skillViewMoneyCount", count, ownCount)

				self.goCostMoney.transform.parent.gameObject:SetActive(true)

				if ownCount < count then
					self.isMoneyCostEnough = false
				end
			end
		end
	end

	local canUpLv = self.soulData.lv >= cell.cfgStrengthenDataTarget.UnLockLv

	self.tfCondition.text = SoulUIApi:GetString("skillViewCondition", cell.cfgStrengthenDataTarget.UnLockLv)

	self.goCondition.transform.parent.gameObject:SetActive(not canUpLv)
	self.goBtnUp:GetComponent("GrayComponent"):SetGray(not canUpLv)
end

return SoulSkillView
