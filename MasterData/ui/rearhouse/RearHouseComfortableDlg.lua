-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\RearHouseComfortableDlg.lua

local ResRearHouseComfortable = require("ClientData/ResRearHouseComfortable")
local ResRandClient = require("ClientData/ResRandClient")
local ResHousePrivilege = require("ClientData/ResHousePrivilege")
local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local PrivilegeCell = Class("PrivilegeCell", UIControls.Child)

function PrivilegeCell:ctor(...)
	self:initUI()
end

function PrivilegeCell:initUI(...)
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onBtnSensorClick)

	self.imgIcon = UIControls.Image(self, "Icon")
	self.txtName = UIControls.Label(self, "Text")
	self.aniBtn = UIControls.UIAni(self, "")

	self.aniBtn:addEventFinish(self.onBtnAniFinish)

	self.panelEfx = UIControls.Panel(self, "Efx")
end

function PrivilegeCell:setData(pId, isNew, index)
	self.pId = pId
	self.privilegeData = ResHousePrivilege[pId] or {}

	self.txtName:setText(self.privilegeData.name)

	self.mIndex = index
	self.isNew = isNew
	self.type = self.privilegeData.type

	self.imgIcon:setImage("Atlas/" .. self.privilegeData.icon_path, self.privilegeData.icon_name)
	self:showMergeEfx(false)
end

function PrivilegeCell:playMoveAni(...)
	self.aniBtn:startAni("BtnPrivilege", true)
end

function PrivilegeCell:onBtnAniFinish(aniCom, aniName)
	if aniName == "BtnPrivilege" and self.isNew and self.mIndex == 1 then
		self.mWindow:startPrivilegeMerge()
	end
end

function PrivilegeCell:showMergeEfx(v)
	self.panelEfx:setVisible(v)
end

function PrivilegeCell:onBtnSensorClick(...)
	self.mWindow:showTips(self.privilegeData)
end

local strClassName = "RearHouseComfortableDlg"
local RearHouseComfortableDlg = Class(strClassName, UIControls.Window)
local MAX_AWARD_NUM = 4

function RearHouseComfortableDlg:ctor(...)
	self:initUI()
end

function RearHouseComfortableDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.btnBlock = UIControls.Button(self, "BgPanel/ComfortableTipsPanel/Block")

	self.btnBlock:addEventClick(self.onBtnBlockClick)

	self.slider = UIControls.Slider(self, "BgPanel/Slider")
	self.txtClaimTimes = UIControls.Label(self, "BgPanel/BtnConfirm/TextNum")
	self.txtComfortable = UIControls.Label(self, "BgPanel/TextComfortableTitle/TextComfortable")
	self.txtNextComfortable = UIControls.Label(self, "BgPanel/TextNextComfortableTitle/TextNextComfortable")
	self.panelMaxComfort = UIControls.Panel(self, "BgPanel/TextNextComfortableTitle/ComfortableMaxPanel")
	self.txtClaimNum = UIControls.Label(self, "BgPanel/BtnConfirm/TextNum")
	self.txtTipsTitle = UIControls.Label(self, "BgPanel/ComfortableTipsPanel/TipsPanel/TextTitle")
	self.txtTipsDesc = UIControls.Label(self, "BgPanel/ComfortableTipsPanel/TipsPanel/Text")
	self.txtAward = UIControls.Label(self, "BgPanel/TextAward")
	self.panelTips = UIControls.Panel(self, "BgPanel/ComfortableTipsPanel")
	self.imgFrame = UIControls.Image(self, "BgPanel/ImgHeroFrame")
	self.aniBox = UIControls.UIAni(self, "BgPanel/ImgBox")

	self.aniBox:addEventFinish(self.onBoxAniFinish)

	self.aniAward = UIControls.UIAni(self, "BgPanel/AwardPanel")

	self.aniAward:addEventFinish(self.onAwardAniFinish)
	self.aniAward:addEventAnimateCue(self.onAwardAniCue)

	self.imgBox = UIControls.Image(self, "BgPanel/Slider/Handle/IconBox")
	self.imgConfirmDis = UIControls.Image(self, "BgPanel/ImgConfirmDis")

	self.imgConfirmDis:setVisible(true)

	self.panelAwardMax = UIControls.Panel(self, "BgPanel/AwardMaxPanel")
	self.panelAward = UIControls.Panel(self, "BgPanel/AwardPanel")
	self.audioAward = UIControls.LazyAudioPlayer(self, "BgPanel/AwardPanel")
	self.awardCells = {}
	self.privilegeCells = {}
end

function RearHouseComfortableDlg:initAwards(...)
	for i, cell in ipairs(self.awardCells) do
		cell:destroy()
	end

	if self.isMaxState == true then
		return
	end

	self.awardCells = {}

	local index = 1
	local newIds = RearHouseCommon.getNewPrivilegeIdsByComfortId(self.lastClaimData.curPart, self.lastClaimData.nextPart)

	self.newPrivileteIds = newIds
	self.soundPlayNum = 0

	for _, id in ipairs(newIds) do
		if index > MAX_AWARD_NUM then
			break
		end

		local cell = PrivilegeCell(self, "BgPanel/AwardPanel/Award" .. index, "System/Backyard/BtnPrivilege")

		cell:setVisible(true)
		cell:setData(id)

		cell.isAward = false

		table.insert(self.awardCells, cell)

		index = index + 1
	end

	local clientItems = RearHouseCommon.getAwardData(self.curData.rand_id)

	for i = 1, #clientItems do
		if index > MAX_AWARD_NUM then
			break
		end

		local clientItem = clientItems[i]
		local cell = UIControls.getGridAwardContainer(self, "BgPanel/AwardPanel/Award" .. index)

		cell:setObj(clientItem)

		cell.grid.mDisableWays = true

		cell:setVisible(true)

		cell.isAward = true

		table.insert(self.awardCells, cell)

		index = index + 1
	end
end

function RearHouseComfortableDlg:initPrivileges(...)
	local ids = RearHouseCommon.getPrivilegeIdsWithoutDefaultNow()

	self.initPrivilegeIds = ids

	if self.lastClaimData.curPart == 1 then
		return
	end

	self:_createPrivilegeCell(ids, 0, false)
end

function RearHouseComfortableDlg:_createPrivilegeCell(ids, offset, isNew)
	for i, id in ipairs(ids) do
		local cell = self.privilegeCells[i + offset]

		if cell == nil then
			cell = PrivilegeCell(self, "BgPanel/ComfortableList/Content", "System/Backyard/BtnPrivilege")

			table.insert(self.privilegeCells, cell)
		end

		cell:setVisible(true)
		cell:setData(id, isNew, i)
	end

	for i = #ids + offset + 1, #self.privilegeCells do
		self.privilegeCells[i]:setVisible(false)
	end
end

function RearHouseComfortableDlg:coAddNewPrivilegeAni(...)
	local ids = RearHouseCommon.getPrivilegeIdsWithoutDefaultNow()
	local newIds = {}

	self.mergeTypes = {}

	local isFind = false

	for _, newId in ipairs(ids) do
		isFind = false

		for _, oldId in ipairs(self.initPrivilegeIds) do
			if newId == oldId then
				isFind = true

				break
			end
		end

		if isFind == false then
			table.insert(newIds, newId)
		end
	end

	local newData, oldData

	for _, nid in ipairs(newIds) do
		newData = ResHousePrivilege[nid]

		for _, oid in ipairs(self.initPrivilegeIds) do
			oldData = ResHousePrivilege[oid]

			if newData.type == oldData.type then
				table.insert(self.mergeTypes, newData.type)

				break
			end
		end
	end

	self:_createPrivilegeCell(newIds, 0, true)
	self:_createPrivilegeCell(self.initPrivilegeIds, #newIds, false)

	for i = 1, #newIds do
		local cell = self.privilegeCells[i]

		cell:playMoveAni()
	end
end

function RearHouseComfortableDlg:setData(...)
	self:refreshData()
	self:_refreshUI()
end

function RearHouseComfortableDlg:refreshUI(...)
	self:refreshData()

	local isPrivilege = false

	for _, itemGrid in ipairs(self.awardCells) do
		if itemGrid.isAward == true then
			itemGrid:setVisible(false)
		else
			isPrivilege = true
		end
	end

	if isPrivilege then
		self.aniAward:startAni("CloseAwardPanel", true)
	else
		self:initAwards()
		self.aniAward:startAni("ShowAwardPanel", true)
	end
end

function RearHouseComfortableDlg:refreshData(...)
	local data = CurAvatar.rearHouseData

	self.txtComfortable:setText(data.comfort)

	self.lastClaimData = RearHouseCommon.getComfortableData(data.award_comfort)
	self.histotyComfortData = RearHouseCommon.getComfortableData(data.max_comfort)

	local value = 0

	self.toClaimPart = 1
	self.isMaxState = self.lastClaimData.isMax == true and self.lastClaimData.nextPart < 0

	if self.isMaxState == true then
		self.panelAward:setVisible(false)
		self.panelAwardMax:setVisible(true)
		self.txtNextComfortable:setVisible(false)
		self.panelMaxComfort:setVisible(true)
		self.imgConfirmDis:setVisible(true)
		self.txtAward:setVisible(false)
		self.imgFrame:playAnimator("ShowHeroFrame4")
	else
		self.panelAward:setVisible(true)
		self.panelAwardMax:setVisible(false)
		self.txtNextComfortable:setVisible(true)
		self.panelMaxComfort:setVisible(false)

		local nextData = ResRearHouseComfortable[self.lastClaimData.nextPart]

		self.txtNextComfortable:setText(nextData.comfortable_num)

		self.curData = ResRearHouseComfortable[self.lastClaimData.nextPart]

		if self.histotyComfortData.curPart - self.lastClaimData.curPart == 0 then
			value = self:_getValue(self.histotyComfortData.curPart, self.histotyComfortData.nextPart, data.max_comfort)
		elseif self.histotyComfortData.curPart - self.lastClaimData.curPart > 0 then
			value = 1
		end

		self:testAni(value)

		self.toClaimPart = self.lastClaimData.nextPart
	end
end

function RearHouseComfortableDlg:_getValue(prePart, nextPart, curValue)
	local preValue = ResRearHouseComfortable[prePart].comfortable_num or 0
	local nextValue = ResRearHouseComfortable[nextPart].comfortable_num or 0

	return (curValue - preValue) / (nextValue - preValue)
end

function RearHouseComfortableDlg:onAwardClaimed(...)
	return
end

function RearHouseComfortableDlg:testAni(value)
	self.slider:setValue(0, 0)
	self.imgBox:setVisible(true)
	self.slider:setValue(value, value / 0.8)

	self.coSliderAni = coroutine.start(self.coSliderFunc, self, value)
end

function RearHouseComfortableDlg:coSliderFunc(value)
	self.imgFrame:playAnimator("ShowHeroFrame1")
	coroutine.wait(value / 0.8)

	if value == 1 then
		self.imgFrame:playAnimator("ShowHeroFrame2")
		self.aniBox:setVisible(true)
		self.aniBox:startAni("ComfortableBoxDrop", true)
		self.imgBox:setVisible(false)
		coroutine.wait(1.05)
	else
		self.imgFrame:playAnimator("ShowHeroFrame4")
	end
end

function RearHouseComfortableDlg:startPrivilegeMerge(...)
	self.coMerge = coroutine.start(self.coMergePrivilege, self)
end

function RearHouseComfortableDlg:coMergePrivilege(...)
	local efxCells = {}

	for i, typeId in ipairs(self.mergeTypes) do
		for index, cell in ipairs(self.privilegeCells) do
			if cell:getVisible() == true and cell.type == typeId then
				table.insert(efxCells, cell)
			end
		end
	end

	for _, cell in ipairs(efxCells) do
		cell:showMergeEfx(true)
	end

	coroutine.wait(0.8)
	self:initPrivileges()
end

function RearHouseComfortableDlg:_refreshUI(...)
	self:initAwards()
	self:initPrivileges()
end

function RearHouseComfortableDlg:showTips(data)
	self.panelTips:setVisible(true)
	self.txtTipsTitle:setText(data.name)
	self.txtTipsDesc:setText(data.desc)
end

function RearHouseComfortableDlg:onAwardAniCue(aniCom, eventKey)
	self.soundPlayNum = self.soundPlayNum + 1

	if self.soundPlayNum <= #self.newPrivileteIds and "Award" .. self.soundPlayNum == eventKey then
		self.audioAward:playAudio()
	end
end

function RearHouseComfortableDlg:onAwardAniFinish(aniCom, aniName)
	if aniName == "CloseAwardPanel" then
		self:coAddNewPrivilegeAni()
		self:initAwards()
		self.aniAward:startAni("ShowAwardPanel", true)
	elseif aniName == "ShowAwardPanel" then
		-- block empty
	end
end

function RearHouseComfortableDlg:onBoxAniFinish(aniCom, aniName)
	if aniName == "ComfortableBoxDrop" then
		self.btnConfirm:setVisible(true)
		self.imgConfirmDis:setVisible(false)
	end
end

function RearHouseComfortableDlg:onBtnBlockClick(...)
	self.panelTips:setVisible(false)
end

function RearHouseComfortableDlg:onBtnConfirmClick(...)
	RPC.houseComfortAwardGet(self.toClaimPart)

	if self.toClaimPart - self.lastClaimData.curPart > 1 then
		CurAvatar.showComfortAwardPanel = true
	else
		for _, itemGrid in ipairs(self.awardCells) do
			if itemGrid:getVisible() and itemGrid.grid then
				itemGrid:setVisible(false)
				itemGrid.grid:flyToCommonFuncEntryPanel()
			end
		end

		CurAvatar.showComfortAwardPanel = false
	end

	self.btnConfirm:setVisible(false)
	self.imgConfirmDis:setVisible(true)
	self.aniBox:setVisible(false)
end

function RearHouseComfortableDlg:onBtnCloseClick(...)
	self:setVisible(false)
end

function RearHouseComfortableDlg:destroy(...)
	RearHouseComfortableDlg.super.destroy(self)

	if self.coSliderAni then
		coroutine.stop(self.coSliderAni)

		self.coSliderAni = nil
	end

	if self.coAwardAni then
		coroutine.stop(self.coAwardAni)

		self.coAwardAni = nil
	end

	if self.coMerge then
		coroutine.stop(self.coMerge)

		self.coMerge = nil
	end
end

return RearHouseComfortableDlg
