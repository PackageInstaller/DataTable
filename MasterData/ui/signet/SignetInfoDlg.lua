-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Signet\\SignetInfoDlg.lua

local ResSignet = require("ClientData/ResSignet")
local SignetTipCell = Class("SignetInfoDlg_SignetTipCell", UIControls.Child)

function SignetTipCell:ctor()
	self.panel = UIControls.Panel(self, "")
	self.imgIcon = UIControls.Image(self, "Icon")
	self.txtName = UIControls.Label(self, "TxtName")
	self.txtDes = UIControls.Label(self, "TxtDesc")
	self.havePanel = UIControls.Panel(self, "FinishTimePanel")
	self.txtTime = UIControls.Label(self, "FinishTimePanel/TextTime")
	self.noHavePanel = UIControls.Panel(self, "BgDis")
	self.slider = UIControls.Slider(self, "Slider")
	self.txtProgress = UIControls.Label(self, "Slider/TextProgress")
	self.imgDefault = UIControls.Image(self, "ImgShow")
	self.imgNext = UIControls.Image(self, "ImgNext")
end

function SignetTipCell:setData(signetId, signetData, idx, maxIdx, checkDefault)
	local config = ResSignet[signetId]

	self.txtName:setText(config.name)

	if config.big_icon then
		self.imgIcon:setImage("Atlas/CommonAtlas/IconAtlas/" .. config.big_icon_path, config.big_icon)
	end

	self.txtDes:setText(config.description)

	local checkData = signetData ~= nil

	self.havePanel:setVisible(checkData)
	self.noHavePanel:setVisible(not checkData)

	local checkShowNext = idx < maxIdx

	self.imgNext:setVisible(checkShowNext)
	self.imgDefault:setVisible(checkDefault or false)

	local progress, needProgress = CurAvatar:getSignetProcess(signetId, signetData)

	if checkData then
		self.txtTime:setText(os.date("%Y/%m/%d", signetData.achieve_time))
	end

	local percent = needProgress ~= 0 and progress / needProgress or 0

	self.txtProgress:setText(progress .. "/" .. needProgress)
	self.slider:setValue(percent)
end

local SignetInfoDlg = Class("SignetInfoDlg", UIControls.Window)

function SignetInfoDlg:ctor()
	self.onePanel = UIControls.Panel(self, "BgPanel/OneAchievementPanel")
	self.multiPanel = UIControls.Panel(self, "BgPanel/GroupAchievementPanel")
	self.contentPanel = UIControls.Panel(self, "BgPanel/GroupAchievementPanel/AchievementList/Content")
	self.oneSignetTipCell = nil
	self.multiSignetTipCellList = nil
end

function SignetInfoDlg:destroy()
	if self.timer then
		self.timer:Stop()
	end
end

function SignetInfoDlg:setData(signetId, signetData, forceOne)
	local config = ResSignet[signetId]
	local signetIdList = CurAvatar:getSignetConfigIdListByGroup(config.group)

	self.checkShowMulti = not forceOne and signetIdList and #signetIdList > 1 and true or false

	self.onePanel:setVisible(not self.checkShowMulti)
	self.multiPanel:setVisible(self.checkShowMulti)

	if self.checkShowMulti then
		local defaultSignetId, checkHave = CurAvatar:getShowSignetIdByGroup(config.group)

		self:showMulti(signetIdList, defaultSignetId, checkHave)
	else
		self:showOne(signetId, signetData)
	end
end

function SignetInfoDlg:showOne(signetId, signetData)
	if not self.oneSignetTipCell then
		self.oneSignetTipCell = SignetTipCell(self, "BgPanel/OneAchievementPanel/AchievementTipsCell", "System/HandBook/AchievementTipsCell")

		self.oneSignetTipCell:setVisible(true)
	end

	self.oneSignetTipCell:setData(signetId, signetData, 1, 1)
end

function SignetInfoDlg:showMulti(signetIdList, defaultSignetId, checkHave)
	local cellList = self.multiSignetTipCellList or {}
	local dataNum = #signetIdList
	local cellNum = #cellList

	self.defaultCell = nil

	local defaultIdx = 1

	if checkHave and dataNum > 2 then
		defaultIdx = utils.getIndexByValue(signetIdList, defaultSignetId)

		if defaultIdx > dataNum - 2 then
			defaultIdx = dataNum - 2
		end
	end

	for i = 1, dataNum do
		local cell

		if i <= cellNum then
			cell = cellList[i]
		else
			cell = SignetTipCell(self, "BgPanel/GroupAchievementPanel/AchievementList/Content", "System/HandBook/AchievementTipsCell")

			table.insert(cellList, cell)
		end

		cell:setVisible(true)

		local signetId = signetIdList[i]
		local signetData = CurAvatar:getSignetData(signetId)
		local checkDefault = defaultSignetId == signetId and checkHave

		cell:setData(signetId, signetData, i, dataNum, checkDefault)

		if i == defaultIdx then
			self.defaultCell = cell
		end
	end

	if dataNum < cellNum then
		for i = dataNum + 1, cellNum do
			cellList[i]:setVisible(false)
		end
	end

	if self.defaultCell then
		self.slotFocusToDefault = self.slotFocusToDefault or Slot(self.focusToDefault, self)
		self.timer = FrameTimer.New(self.slotFocusToDefault, 1)

		self.timer:Start()
	end
end

function SignetInfoDlg:focusToDefault()
	if self.checkShowMulti and self.defaultCell then
		local pos = self.defaultCell.panel:getPosition()
		local halfHeight = self.defaultCell.panel:getRectSize().height * 0.5

		self.contentPanel:setPosition(0, -(pos.y + halfHeight))
	end
end

return SignetInfoDlg
