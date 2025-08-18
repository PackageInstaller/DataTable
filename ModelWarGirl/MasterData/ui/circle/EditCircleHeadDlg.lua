-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\EditCircleHeadDlg.lua

local CircleHeadCell = require("UI/Circle/CircleHeadCell")
local CircleHeadFrameItem = require("UI/Circle/CircleHeadFrameItem")
local ResClanMisc = require("ClientData/ResClanMisc")
local strClassName = "EditCircleHeadDlg"
local EditCircleHeadDlg = Class(strClassName, UIControls.Window)

function EditCircleHeadDlg:ctor()
	self:initUI()
end

function EditCircleHeadDlg:initUI()
	self.txtTitle = UIControls.Label(self, "Bg/TextTitle")
	self.btnHead = UIControls.Button(self, "Bg/TabPanel/BtnChooseHead")

	self.btnHead:addEventClick(self.onTabButtonClick)

	self.imgNewTabHead = UIControls.Image(self, "Bg/TabPanel/BtnChooseHead/IconNew")
	self.btnHeadFrame = UIControls.Button(self, "Bg/TabPanel/BtnChooseHeadFrame")

	self.btnHeadFrame:addEventClick(self.onTabButtonClick)

	self.imgNewTabHeadFrame = UIControls.Image(self, "Bg/TabPanel/BtnChooseHeadFrame/IconNew")
	self.btnClose = UIControls.Button(self, "Bg/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.panelHead = UIControls.Panel(self, "Bg/HeadListPanel")
	self.panelHeadFrame = UIControls.Panel(self, "Bg/HeadFrameListPanel")
	self.imgHeadPreview = UIControls.Image(self, "Bg/PreviewPlayerHead/Mask/IconPlayerHead")
	self.imgHeadFramePreview = UIControls.Image(self, "Bg/PreviewPlayerHead/IconPlayerHeadFrame")
	self.txtName = UIControls.Label(self, "Bg/TextName")
	self.txtGainWay = UIControls.Label(self, "Bg/TextGain")
	self.btnUse = UIControls.Button(self, "Bg/BtnState", "Text")

	self.btnUse:addEventClick(self.onBtnUseClick)

	self.headCells = {}
	self.scrollCircleHead = UIControls.ScrollViewLoopV(self, "Bg/HeadListPanel")

	self.scrollCircleHead:addEventCellChanged(self.onCircleHeadChanged)

	self.cells = {}
	self.scrollCircleHeadFrame = UIControls.ScrollViewLoopV(self, "Bg/HeadFrameListPanel")

	self.scrollCircleHeadFrame:addEventCellChanged(self.onCircleHeadFrameChanged)

	self.txtTips = UIControls.Label(self, "Bg/TextTips")
	self.imgLimit = UIControls.Image(self, "Bg/TextName/IconLimit")

	self.imgLimit:setVisible(false)

	self.txtTime = UIControls.Label(self, "Bg/TextName/IconLimit/TextTime")

	self.txtTime:setVisible(true)
	self:initWindowShow()
end

function EditCircleHeadDlg:refreshTabHint()
	local elemCnt = utils.getTableElemCount(CurAvatar.hintCircleHeadDic, true)

	self.imgNewTabHead:setVisible(elemCnt > 0)

	elemCnt = utils.getTableElemCount(CurAvatar.hintCircleHeadFrameDic, true)

	self.imgNewTabHeadFrame:setVisible(elemCnt > 0)
end

function EditCircleHeadDlg:onCircleHeadFrameChanged(sender, targetCell, newIdx)
	targetCell = targetCell or CircleHeadFrameItem(sender, "System/Circle/GridCircleHeadFrame", newIdx)

	if not self.circleHeadFrameDataList or #self.circleHeadFrameDataList == 0 then
		return
	end

	if self.circleHeadFrameDataList[newIdx] ~= nil then
		targetCell:setSelectCallback(Slot(self.onCircleHeadFrameCellClick, self))

		if newIdx > 1 then
			targetCell:setCircleHeadFrameData(self.circleHeadFrameDataList[newIdx])
		else
			targetCell:setCircleHeadFrameData(nil, true)
		end
	end

	self.cells[newIdx] = targetCell
end

function EditCircleHeadDlg:initWindowShow()
	if CurAvatar.myCircle then
		self.selectHeadId = CurAvatar.myCircle.headId
		self.circleHeadDataList = CurAvatar:getCanUseCircleHeadDataList()

		self.scrollCircleHead:setTotalCount(#self.circleHeadDataList)

		local frameData = CurAvatar.myCircle.haveFrameDic[CurAvatar.myCircle.headFrameId]

		if frameData and frameData.endTime and frameData.endTime > 0 and frameData.endTime < ClientUtils.getServerTime() then
			self.selectFrameId = 0
		else
			self.selectFrameId = CurAvatar.myCircle.headFrameId
		end

		self.circleHeadFrameDataList = CurAvatar.myCircle:getCanUseHeadFrameList()

		table.insert(self.circleHeadFrameDataList, 1, {})
		self.scrollCircleHeadFrame:setTotalCount(#self.circleHeadFrameDataList)
		self:onTabButtonClick(self.btnHead)
		self:refreshTabHint()

		self.inited = true
	end
end

function EditCircleHeadDlg:onCircleHeadCellClick(sender)
	self.selectHeadId = sender.circleHeadData.resData.id

	self.scrollCircleHead:setTotalCount(#self.circleHeadDataList)
	self:refreshPreviewShow()
end

function EditCircleHeadDlg:onCircleHeadFrameCellClick(sender)
	self.selectFrameId = sender.id

	self.scrollCircleHeadFrame:setTotalCount(#self.circleHeadFrameDataList)
	self:refreshPreviewShow()
end

function EditCircleHeadDlg:refreshShow()
	self.scrollCircleHeadFrame:setTotalCount(#self.circleHeadFrameDataList)
	self.scrollCircleHead:setTotalCount(#self.circleHeadDataList)
	self:refreshPreviewShow()
end

function EditCircleHeadDlg:refreshTimeDown(circleHeadFrameData)
	ClientTimerManager.RemoveSecondTickUI(self.txtTime)

	if circleHeadFrameData and circleHeadFrameData.svrData and circleHeadFrameData.svrData.endTime > 0 then
		self.headFrameEndTime = circleHeadFrameData.svrData.endTime

		local leftTime = self.headFrameEndTime - ClientUtils.getServerTime()

		if leftTime > 0 then
			ClientTimerManager.AddSecondFormatTickUI(self.txtTime, leftTime, nil, Lang.get(48659), Slot(self.checkHeadFrameValid, self), nil)
			self.imgLimit:setVisible(true)
		else
			self.imgLimit:setVisible(true)
			self.txtTime:setText(Lang.get(653))
		end
	else
		self.headFrameEndTime = 0

		self.imgLimit:setVisible(false)
	end
end

function EditCircleHeadDlg:checkHeadFrameValid()
	return
end

function EditCircleHeadDlg:refreshPreviewShow()
	if self.status == Const.CIRCLE_EDIT_HEAD_STATUS_HEAD then
		local circleHeadData

		for _, data in ipairs(self.circleHeadDataList) do
			if data.resData.id == self.selectHeadId then
				circleHeadData = data

				break
			end
		end

		self.imgHeadPreview:setImage(circleHeadData.resData.icon_path, circleHeadData.resData.icon_name)
		self.txtName:setText(circleHeadData.resData.name)
		self.txtGainWay:setText(circleHeadData.resData.desc)
		self.txtGainWay:setVisible(true)

		if self.selectHeadId == CurAvatar.myCircle.headId then
			self.btnUse:setEnable(false)
			self.btnUse:setText(Lang.get(901))
		else
			self.btnUse:setEnable(true)
			self.btnUse:setText(Lang.get(588))
		end

		self.imgLimit:setVisible(false)
		self.txtTips:setText(string.format(Lang.get(30178), ResClanMisc[1].rehead_cd))
	else
		if self.selectFrameId ~= 0 then
			local circleHeadFrameData

			for _, data in ipairs(self.circleHeadFrameDataList) do
				if data.resData and data.resData.id == self.selectFrameId then
					circleHeadFrameData = data

					break
				end
			end

			if circleHeadFrameData then
				utils.setCircleHeadFrame(self.imgHeadFramePreview, circleHeadFrameData.resData.id, circleHeadFrameData.svrData.endTime)
				self.txtName:setText(circleHeadFrameData.resData.name)
				self.txtGainWay:setText(circleHeadFrameData.resData.desc)
				self.txtGainWay:setVisible(true)
				self:refreshTimeDown(circleHeadFrameData)
			else
				self.selectFrameId = 0

				self.scrollCircleHeadFrame:setTotalCount(#self.circleHeadFrameDataList)
				self:refreshPreviewShow()
			end
		else
			self.imgHeadFramePreview:setVisible(false)
			self.txtName:setText(Lang.get(30736))
			self.txtGainWay:setVisible(false)

			self.headFrameEndTime = 0

			self.imgLimit:setVisible(false)
		end

		if self.selectFrameId == CurAvatar.myCircle.headFrameId then
			self.btnUse:setEnable(false)
			self.btnUse:setText(Lang.get(901))
		else
			self.btnUse:setEnable(true)
			self.btnUse:setText(Lang.get(588))
		end

		self.txtTips:setText(string.format(Lang.get(30178), ResClanMisc[1].re_head_frame_cd))
	end
end

function EditCircleHeadDlg:onCircleHeadChanged(sender, targetCell, newIdx)
	targetCell = targetCell or CircleHeadCell(sender, "System/Circle/GridCircleHead", newIdx)

	if not self.circleHeadDataList or #self.circleHeadDataList == 0 then
		return
	end

	if self.circleHeadDataList[newIdx] ~= nil then
		targetCell:setSelectCallback(Slot(self.onCircleHeadCellClick, self))
		targetCell:setCircleHeadData(self.circleHeadDataList[newIdx], newIdx)
	end

	self.headCells[newIdx] = targetCell
end

function EditCircleHeadDlg:onTabButtonClick(sender)
	if sender == self.btnHead then
		self.status = Const.CIRCLE_EDIT_HEAD_STATUS_HEAD

		self.btnHead:setEnable(false)
		self.btnHeadFrame:setEnable(true)
		self.panelHead:setVisible(true)
		self.panelHeadFrame:setVisible(false)
	else
		self.status = Const.CIRCLE_EDIT_HEAD_STATUS_HEADFRAME

		self.btnHead:setEnable(true)
		self.btnHeadFrame:setEnable(false)
		self.panelHead:setVisible(false)
		self.panelHeadFrame:setVisible(true)
	end

	self:refreshPreviewShow()
end

function EditCircleHeadDlg:onBtnCloseClick()
	self:setVisible(false)
end

function EditCircleHeadDlg:onBtnUseClick()
	if CurAvatar.myCircle then
		if self.status == Const.CIRCLE_EDIT_HEAD_STATUS_HEAD then
			if self.selectHeadId == CurAvatar.myCircle.headId then
				MsgManager.clientNotice(234)

				return
			end

			if ClientUtils.getServerTime() < CurAvatar.myCircle.reheadTick + ResClanMisc[1].rehead_cd * 60 * 60 + 3 then
				MsgManager.clientNotice(222)

				return
			end

			RPC.clanRehead(self.selectHeadId)
		else
			if self.selectFrameId == CurAvatar.myCircle.headFrameId then
				MsgManager.notice(Lang.get(39269))

				return
			end

			if ClientUtils.getServerTime() < CurAvatar.myCircle.reheadFrameTick + ResClanMisc[1].re_head_frame_cd * 60 * 60 + 3 then
				MsgManager.notice(utils.format(Lang.get(39270), ResClanMisc[1].re_head_frame_cd))

				return
			end

			if self.headFrameEndTime > 0 then
				local leftTime = self.headFrameEndTime - ClientUtils.getServerTime()

				if leftTime <= 0 then
					MsgManager.notice(Lang.get(40576))

					return
				end
			end

			RPC.clanReHeadFrame(self.selectFrameId)
		end
	end
end

return EditCircleHeadDlg
