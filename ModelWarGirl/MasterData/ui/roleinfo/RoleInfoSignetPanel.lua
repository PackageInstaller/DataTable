-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RoleInfo\\RoleInfoSignetPanel.lua

local ResSignet = require("ClientData/ResSignet")
local SignetCell = Class("RoleInfoSignetPanel_SignetCell", UIControls.Child)

function SignetCell:ctor()
	self.noHavePanel = UIControls.Panel(self, "UnHave")
	self.havePanel = UIControls.Panel(self, "HavePanel")
	self.imgIcon = UIControls.Image(self, "HavePanel/Icon")
	self.txtName = UIControls.Label(self, "HavePanel/TextName")
	self.btn = UIControls.Button(self, "HavePanel")

	self.btn:addEventClick(self.onClickBtn)
end

function SignetCell:init(clickCb)
	self.clickCb = clickCb
end

function SignetCell:setData(signetData)
	self.signetData = signetData
	self.signetId = self.signetData and self.signetData.id or nil

	local checkData = self.signetData ~= nil

	self.noHavePanel:setVisible(not checkData)
	self.havePanel:setVisible(checkData)

	if checkData then
		local config = ResSignet[self.signetId]

		self.txtName:setText(config.name)

		if config.big_icon then
			self.imgIcon:setImage("Atlas/CommonAtlas/IconAtlas/" .. config.big_icon_path, config.big_icon)
		end
	end
end

function SignetCell:onClickBtn()
	self.clickCb(self)
end

local RoleInfoSignetPanel = Class("RoleInfoSignetPanel", UIControls.Panel)

function RoleInfoSignetPanel:ctor()
	if UIControls.checkControlFunc(self, self.mPath .. "/BtnAll") then
		self.btnAll = UIControls.Button(self, self.mPath .. "/BtnAll")

		self.btnAll:addEventClick(self.onClickBtnAll)
	end

	if UIControls.checkControlFunc(self, self.mPath .. "/BtnEdit") then
		self.btnEdit = UIControls.Button(self, self.mPath .. "/BtnEdit")

		self.btnEdit:addEventClick(self.onClickBtnEdit)
	end

	self.slotOnClickSignetCell = Slot(self.onClickSignetCell, self)
	self.signetCellList = {}

	for i = 1, 5 do
		local cell = SignetCell(self, self.mPath .. "/AchievementItem" .. i, "System/PlayerInfor/AchievementItem")

		cell:init(self.slotOnClickSignetCell)
		cell:setVisible(true)
		table.insert(self.signetCellList, cell)
	end

	if UIControls.checkControlFunc(self, self.mPath .. "/ProgressPanel/TextProgress") then
		self.txtProgress = UIControls.Label(self, self.mPath .. "/ProgressPanel/TextProgress")
	end

	if UIControls.checkControlFunc(self, self.mPath .. "/Raycast") then
		self.raycast = UIControls.Panel(self, self.mPath .. "/Raycast")
	end

	self.slotSelectPanelCancelCb = Slot(self.selectPanelCancelCb, self)
	self.slotSelectPanelConfirmCb = Slot(self.selectPanelConfirmCb, self)
	self.slotSelectPanelChangeCb = Slot(self.selectPanelChangeCb, self)
	self.checkInEdit = false
end

function RoleInfoSignetPanel:init(roleInfoSignetSelectPanel)
	self.roleInfoSignetSelectPanel = roleInfoSignetSelectPanel

	if self.roleInfoSignetSelectPanel then
		self.roleInfoSignetSelectPanel:init(self.slotSelectPanelCancelCb, self.slotSelectPanelConfirmCb, self.slotSelectPanelChangeCb)
	end
end

function RoleInfoSignetPanel:setData(signetDataList, canEdit)
	self.initialSignetDataList = signetDataList
	self.signetDataList = utils.deepcopy(signetDataList)
	self.maxSelectNum = CurAvatar.maxSelectSigentNum
	self.canEdit = canEdit

	self:refreshView()
end

function RoleInfoSignetPanel:refreshView()
	self:refreshSignetList()

	if self.txtProgress and self.canEdit then
		self.txtProgress:setText(CurAvatar:getCurSignetNum() .. "/" .. CurAvatar:getMaxSignetNum())
	end

	if self.btnEdit then
		self.btnEdit:setVisible(self.canEdit)
	end
end

function RoleInfoSignetPanel:refreshSignetList()
	for i = 1, #self.signetCellList do
		local cell = self.signetCellList[i]

		cell:setData(self.signetDataList[i])
	end
end

function RoleInfoSignetPanel:onClickSignetCell(cell)
	if not cell.signetId then
		return
	end

	if self.checkInEdit then
		for i = #self.signetDataList, 1, -1 do
			local signetId = self.signetDataList[i].id

			if signetId == cell.signetId then
				table.remove(self.signetDataList, i)
				self:refreshSignetList()
				self.roleInfoSignetSelectPanel:changeData(self.signetDataList)

				break
			end
		end
	else
		local ui = UIManager.getUI("signetInfoDlg", true)

		ui:setData(cell.signetId, cell.signetData, true)
	end
end

function RoleInfoSignetPanel:selectPanelCancelCb()
	self.checkInEdit = false

	self.raycast:setVisible(false)
	self.mWindow:playAni("HideAchievement")

	self.signetDataList = utils.deepcopy(self.initialSignetDataList)

	self:refreshSignetList()
end

function RoleInfoSignetPanel:selectPanelConfirmCb()
	self.checkInEdit = false

	self.raycast:setVisible(false)
	self.mWindow:playAni("HideAchievement")

	local signetIdList = {}

	for i = 1, #self.signetDataList do
		table.insert(signetIdList, self.signetDataList[i].id)
	end

	RPC.roleCommEditSignet(signetIdList)
end

function RoleInfoSignetPanel:selectPanelChangeCb(list)
	self.signetDataList = list

	self:refreshSignetList()
end

function RoleInfoSignetPanel:hideBtnAll()
	self.btnAll:setVisible(false)
end

function RoleInfoSignetPanel:onClickBtnAll()
	local ui = UIManager.getUI("signetMainDlg", true)

	ui:hideBtnEdit()
end

function RoleInfoSignetPanel:onClickBtnEdit()
	self.checkInEdit = true

	self.mWindow:playAni("ShowAchievement")
	self.raycast:setVisible(true)
	self.roleInfoSignetSelectPanel:setData(self.maxSelectNum, self.signetDataList)
end

return RoleInfoSignetPanel
