-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\HandBook\\HandBookTeamPatchDlg.lua

local ResBookGemAttr = require("ClientData/ResBookGemAttr")
local ResBookGemAttrLimit = require("ClientData/ResBookGemAttrLimit")
local NumControlPanel = require("UI/MainState/Item/NumControlPanel")
local EventConst = require("EventConst")
local ResColor = require("ClientData/ResColor")
local ResClientNotice = require("ClientData/ResClientNotice")
local AttrCell = Class("HandBookTeamPatchDlg_AttrCell", UIControls.Panel)

function AttrCell:ctor()
	self.txtName = UIControls.Label(self, self.mPath .. "/Text")
	self.txtBefore = UIControls.Label(self, self.mPath .. "/TextNumBefore")
	self.txtAfter = UIControls.Label(self, self.mPath .. "/TextNumAfter")
	self.maxPanel = UIControls.Panel(self, self.mPath .. "/TextMax")
	self.addPanel = UIControls.Panel(self, self.mPath .. "/UpPanel")
	self.txtAdd = UIControls.Label(self, self.mPath .. "/UpPanel/TextNum")
end

function AttrCell:setData(teamId, attrId)
	self.teamId = teamId
	self.initialValue = CurAvatar:getTeamPatchAttrValue(self.teamId, attrId)

	self.txtBefore:setText("+" .. self.initialValue)

	self.maxValue = ResBookGemAttrLimit[attrId].limit

	self.maxPanel:setVisible(self.initialValue >= self.maxValue)
end

function AttrCell:setUpdateAttrValue(addValue)
	local afterValue = addValue + self.initialValue

	afterValue = math.min(afterValue, self.maxValue)

	self.txtAfter:setText("+" .. afterValue)

	local checkAdd = addValue > 0

	self.txtAfter:setFontColor(checkAdd and ResColor.TEAMPATCH02 or ResColor.TEAMPATCH01)
	self.addPanel:setVisible(checkAdd)

	if checkAdd then
		self.txtAdd:setText(addValue)
	end
end

local UpdateCell = Class("HandBookTeamPatchDlg_UpdateCell", UIControls.Panel)

function UpdateCell:ctor()
	self.numControlPanel = NumControlPanel(self, self.mPath .. "/NumPanel")
	self.numControlPanel.mEventNumChanged = Slot(self.onValueChange, self)
end

function UpdateCell:init(valueChangeCb)
	self.valueChangeCb = valueChangeCb
end

function UpdateCell:setData(attr, maxNum, maxTip)
	self.attr = attr
	self.value = 0

	self:setMaxNum(maxNum, maxTip)
end

function UpdateCell:setMaxNum(maxNum, maxTip)
	self.numControlPanel:onShow(maxNum, self.value, nil, maxTip, 0)
end

function UpdateCell:onValueChange(value)
	if self.value == value then
		return
	end

	self.value = value

	if self.valueChangeCb then
		self.valueChangeCb(self.attr, value)
	end
end

local HandBookTeamPatchDlg = Class("HandBookTeamPatchDlg", UIControls.Window)

function HandBookTeamPatchDlg:ctor()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onClickBtnClose)

	self.btnAdd = UIControls.Button(self, "MainInfoPanel/TeamPanel/BtnAdd")

	self.btnAdd:addEventClick(self.onClickBtnAdd)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onClickBtnTips)

	self.teamPanel = UIControls.Panel(self, "MainInfoPanel/TeamPanel/TeamDetailPanel")
	self.imgTeamIcon = UIControls.Image(self, "MainInfoPanel/TeamPanel/TeamDetailPanel/Icon")
	self.txtTeamName = UIControls.Label(self, "MainInfoPanel/TeamPanel/TeamDetailPanel/TextName")
	self.txtPatchNum = UIControls.Label(self, "MainInfoPanel/TeamPanel/TeamDetailPanel/TextNum")
	self.updatingPanel = UIControls.Panel(self, "MainInfoPanel/TeamPanel/TeamDetailPanel/UpdatingPanel")
	self.btnSwitch = UIControls.Button(self, "MainInfoPanel/TeamPanel/TeamDetailPanel/BtnSwitch")

	self.btnSwitch:addEventClick(self.onClickBtnAdd)

	self.efxTeam = UIControls.LazyEffectPlayer(self, "MainInfoPanel/TeamPanel/TeamDetailPanel/EfxFinish")
	self.redDotPatch = UIControls.RedDot(self, "MainInfoPanel/TeamPanel/BtnAdd/IconNew")

	self.redDotPatch:addHint({
		UIConst.RD_HINT_HANDBOOK_TEAM_PATCH
	})

	self.emptyPanel = UIControls.Panel(self, "MainInfoPanel/PatchPanel/ImgEmpty")
	self.patchPanel = UIControls.Panel(self, "MainInfoPanel/PatchPanel/PatchDetailPanel")
	self.attrCellList = {}

	local attrCell1 = AttrCell(self, "MainInfoPanel/PatchPanel/PatchDetailPanel/InfoPanel/AttackPanel")
	local attrCell2 = AttrCell(self, "MainInfoPanel/PatchPanel/PatchDetailPanel/InfoPanel/HPPanel")

	table.insert(self.attrCellList, attrCell1)
	table.insert(self.attrCellList, attrCell2)

	self.updateCellList = {}
	self.slotOnUpdateCellValueChange = Slot(self.onUpdateCellValueChange, self)

	local updateCell1 = UpdateCell(self, "MainInfoPanel/PatchPanel/PatchDetailPanel/UpdatePanel/AttackPatch")

	updateCell1:init(self.slotOnUpdateCellValueChange)

	local updateCell2 = UpdateCell(self, "MainInfoPanel/PatchPanel/PatchDetailPanel/UpdatePanel/HPPatch")

	updateCell2:init(self.slotOnUpdateCellValueChange)
	table.insert(self.updateCellList, updateCell1)
	table.insert(self.updateCellList, updateCell2)

	self.imgCost = UIControls.Image(self, "MainInfoPanel/PatchPanel/PatchDetailPanel/UpdatePanel/IconPanel/Icon")
	self.txtCostNum = UIControls.Label(self, "MainInfoPanel/PatchPanel/PatchDetailPanel/UpdatePanel/IconPanel/TextNum")
	self.btnUpdate = UIControls.Button(self, "MainInfoPanel/PatchPanel/PatchDetailPanel/UpdatePanel/BtnUpdate")

	self.btnUpdate:addEventClick(self.onClickBtnUpdate)

	self.slotOnHandBookTeamPatchChange = Slot(self.onHandBookTeamPatchChange, self)
end

function HandBookTeamPatchDlg:onOpen()
	HandBookTeamPatchDlg.super.onOpen(self)
	EventCenter.addEventListener(EventConst.HANDBOOK_TEAM_PATCH_CHANGE, self.slotOnHandBookTeamPatchChange)

	self.attrList = {
		Const.ATTR_TYPE.EQUIP_ATTACK,
		Const.ATTR_TYPE.EQUIP_LIFE
	}
	self.attrConfigDic = {}

	for attr, configList in pairs(ResBookGemAttr) do
		local idx = utils.getIndexByValue(self.attrList, attr)

		if idx > 0 then
			for gemId, config in pairs(configList) do
				self.attrConfigDic[attr] = config

				break
			end
		end
	end

	self:setSelectTeam(nil)
end

function HandBookTeamPatchDlg:onClose()
	HandBookTeamPatchDlg.super.onClose(self)
	EventCenter.removeEventListener(EventConst.HANDBOOK_TEAM_PATCH_CHANGE, self.slotOnHandBookTeamPatchChange)
end

function HandBookTeamPatchDlg:setSelectTeam(teamId)
	self.teamId = teamId
	self.checkTeam = self.teamId and self.teamId > 0
	self.updateValueDic = {}

	self:refreshTeam()
	self:refreshUpdatePanel()
end

function HandBookTeamPatchDlg:refreshTeam()
	self.btnAdd:setVisible(not self.checkTeam)
	self.teamPanel:setVisible(self.checkTeam)

	if not self.checkTeam then
		return
	end

	self.imgTeamIcon:setImage("Atlas/CommonAtlas/IconTeamLargeAtlas", "IconTeam0" .. self.teamId)
	self.txtTeamName:setText(Const.HERO_TEAM_CONFIG[self.teamId].name)
	self.txtPatchNum:setText(CurAvatar:getTeamPatchTotalNum(self.teamId))
end

function HandBookTeamPatchDlg:refreshUpdatePanel()
	self.emptyPanel:setVisible(not self.checkTeam)
	self.patchPanel:setVisible(self.checkTeam)

	if not self.checkTeam then
		return
	end

	self.itemLimit = 0
	self.costItemId = 0

	for attrType, config in pairs(self.attrConfigDic) do
		self.costItemId = config.gem_id
		self.itemLimit = CurAvatar:getItemNumById(self.costItemId)

		break
	end

	self.teamLimit, self.nextOtherTeamPatchNum = CurAvatar:getTeamPatchLimitDueOtherTeam(self.teamId)
	self.teamLimit = self.teamLimit - CurAvatar:getTeamPatchTotalNum(self.teamId)
	self.valueLimitDic = {}
	self.attrLimitDic = {}

	for _, attr in pairs(self.attrList) do
		local curPatchNum = CurAvatar:getTeamPatchAttrPatchNum(self.teamId, attr)

		self.valueLimitDic[attr] = CurAvatar:getTeamPatchLimitDueMaxValue(attr) - curPatchNum

		local attrLimit, dueAttr, nextPatchNum = CurAvatar:getTeamPatchLimitDueOtherAttr(self.teamId, attr)

		self.attrLimitDic[attr] = {
			value = attrLimit - curPatchNum,
			dueAttr = dueAttr,
			nextPatchNum = nextPatchNum
		}
	end

	self.attrCellDic = {}

	for idx, cell in pairs(self.attrCellList) do
		local attr = self.attrList[idx]

		cell:setData(self.teamId, attr)
		cell:setUpdateAttrValue(0)

		self.attrCellDic[attr] = cell
	end

	self:refreshCost()

	for idx, cell in ipairs(self.updateCellList) do
		local attr = self.attrList[idx]
		local maxNum, maxTip = self:getMaxNumAndMaxTip(attr)

		cell:setData(attr, maxNum, maxTip)
	end
end

function HandBookTeamPatchDlg:refreshCost()
	self.totalCost = 0

	for _, v in pairs(self.updateValueDic) do
		self.totalCost = self.totalCost + v
	end

	self.txtCostNum:setText(self.totalCost)
	self.updatingPanel:setVisible(self.totalCost > 0)
end

function HandBookTeamPatchDlg:onUpdateCellValueChange(attr, value)
	self.updateValueDic[attr] = value

	self:refreshCost()

	local attrCell = self.attrCellDic[attr]
	local attrValue = value * self.attrConfigDic[attr].param

	attrCell:setUpdateAttrValue(attrValue)

	for _, cell in ipairs(self.updateCellList) do
		if cell.attr and cell.attr > 0 and cell.attr ~= attr then
			local maxNum, maxTip = self:getMaxNumAndMaxTip(cell.attr)

			cell:setMaxNum(maxNum, maxTip)
		end
	end
end

function HandBookTeamPatchDlg:getMaxNumAndMaxTip(attr)
	local otherCost = self.totalCost - (self.updateValueDic[attr] or 0)
	local realItemLimit = self.itemLimit - otherCost
	local realTeamLimit = self.teamLimit - otherCost
	local valueLimit = self.valueLimitDic[attr]
	local attrLimit = self.attrLimitDic[attr].value
	local maxNum = math.min(realItemLimit, valueLimit, attrLimit, realTeamLimit)
	local maxTip

	if maxNum == valueLimit then
		maxTip = ResClientNotice[723].notice
	elseif maxNum == realTeamLimit then
		maxTip = string.format(ResClientNotice[737].notice, self.nextOtherTeamPatchNum)
	elseif maxNum == attrLimit then
		local dueAttr = self.attrLimitDic[attr].dueAttr
		local nextPatchNum = self.attrLimitDic[attr].nextPatchNum
		local dueAttrName = ""
		local nextAttrNum = 0
		local limitConfig = ResBookGemAttrLimit[dueAttr]

		if limitConfig then
			dueAttrName = limitConfig.attr_name
			nextAttrNum = nextPatchNum * limitConfig.rate
		end

		maxTip = utils.format(ResClientNotice[738].notice, dueAttrName, nextAttrNum)
	else
		maxTip = ResClientNotice[741].notice
	end

	return maxNum, maxTip
end

function HandBookTeamPatchDlg:onClickBtnClose()
	self:setVisible(false)
end

function HandBookTeamPatchDlg:onClickBtnTips()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_HANDBOOK_TEAM_PATCH)
end

function HandBookTeamPatchDlg:onClickBtnAdd()
	local ui = UIManager.getUI("handBookTeamPatchSelectDlg", true)

	if ui then
		ui:setData(self.teamId)
	end
end

function HandBookTeamPatchDlg:onClickBtnUpdate()
	local list = {}
	local dic = self.updateValueDic or {}

	for attrType, num in pairs(dic) do
		if num > 0 then
			table.insert(list, {
				attr = attrType,
				use_num = num,
				gem_id = self.attrConfigDic[attrType].gem_id
			})
		end
	end

	if #list > 0 then
		RPC.proficentBookGemUse(self.teamId, list)
	elseif self.itemLimit > 0 then
		MsgManager.clientNotice(722)
	else
		UIManager.showConfirmWithId(1093)
	end
end

function HandBookTeamPatchDlg:onHandBookTeamPatchChange(teamId)
	if teamId ~= self.teamId then
		return
	end

	self.efxTeam:playEffect()

	self.updateValueDic = {}

	self:refreshTeam()
	self:refreshUpdatePanel()
end

return HandBookTeamPatchDlg
