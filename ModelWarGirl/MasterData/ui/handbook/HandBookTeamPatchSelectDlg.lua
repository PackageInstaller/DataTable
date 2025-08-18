-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\HandBook\\HandBookTeamPatchSelectDlg.lua

local ResBookGemAttrLimit = require("ClientData/ResBookGemAttrLimit")
local TeamCell = Class("HandBookTeamPatchSelectDlg_TeamCell", UIControls.Child)

function TeamCell:ctor()
	self.imgIcon = UIControls.Image(self, "ContentPanel/Icon")
	self.txtName = UIControls.Label(self, "ContentPanel/TextTitle")
	self.txtPatchNum = UIControls.Label(self, "ContentPanel/PatchPanel/TextPatch")
	self.txtAttackValue = UIControls.Label(self, "ContentPanel/AttackPanel/TextAttrValue")
	self.txtHpValue = UIControls.Label(self, "ContentPanel/HPPanel/TextAttrValue")
	self.btn = UIControls.Button(self, "ContentPanel/BtnSelect")

	self.btn:addEventClick(self.onClickBtn)

	self.contentPanel = UIControls.Panel(self, "ContentPanel")
	self.maxPanel = UIControls.Panel(self, "ContentPanel/MaxPanel")
end

function TeamCell:init(clickCb)
	self.clickCb = clickCb
end

function TeamCell:setData(team, checkSelect)
	self.team = team

	self.imgIcon:setImage("Atlas/CommonAtlas/IconTeamLargeAtlas", "IconTeam0" .. team)
	self.txtName:setText(Const.HERO_TEAM_CONFIG[self.team].name)
	self.txtPatchNum:setText(CurAvatar:getTeamPatchTotalNum(self.team))

	local attackValue = CurAvatar:getTeamPatchAttrValue(self.team, Const.ATTR_TYPE.EQUIP_ATTACK)
	local maxAttackValue = ResBookGemAttrLimit[Const.ATTR_TYPE.EQUIP_ATTACK].limit

	self.txtAttackValue:setText("+" .. attackValue)

	local hpValue = CurAvatar:getTeamPatchAttrValue(self.team, Const.ATTR_TYPE.EQUIP_LIFE)
	local maxHpValue = ResBookGemAttrLimit[Const.ATTR_TYPE.EQUIP_LIFE].limit

	self.txtHpValue:setText("+" .. hpValue)

	local checkLimit = maxAttackValue <= attackValue and maxHpValue <= hpValue

	self.maxPanel:setVisible(checkLimit)
	self.contentPanel:playAnimator(checkSelect and "TeamPatchSelectSlc" or "TeamPatchSelectNml")
end

function TeamCell:onClickBtn()
	self.clickCb(self)
end

local HandBookTeamPatchSelectDlg = Class("HandBookTeamPatchSelectDlg", UIControls.Window)

function HandBookTeamPatchSelectDlg:ctor()
	self.slotClickCell = Slot(self.onClickCell, self)
	self.teamCellList = {}

	for i = 1, 6 do
		local cell = TeamCell(self, "BgPanel/TeamList/Content", "System/HandBook/TeamPatchSelectCell")

		cell:init(self.slotClickCell)
		cell:setVisible(true)
		table.insert(self.teamCellList, cell)
	end
end

function HandBookTeamPatchSelectDlg:setData(selectTeam)
	for i = 1, #self.teamCellList do
		local cell = self.teamCellList[i]

		cell:setData(i, i == selectTeam)
	end
end

function HandBookTeamPatchSelectDlg:onClickCell(cell)
	local ui = UIManager.getUI("handBookTeamPatchDlg")

	if ui then
		ui:setSelectTeam(cell.team)
	end

	self:setVisible(false)
end

function HandBookTeamPatchSelectDlg:onClickBtnClose()
	self:setVisible(false)
end

return HandBookTeamPatchSelectDlg
