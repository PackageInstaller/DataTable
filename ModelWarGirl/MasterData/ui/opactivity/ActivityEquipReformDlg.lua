-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityEquipReformDlg.lua

local ReformEquipListPart = require("UI/OpActivity/ReformEquipListPart")
local EquipAssistAttrCell = require("UI/Equip/EquipAssistAttrCell")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResEquipBaptize = require("ClientData/ResEquipBaptize")
local ResColor = require("ClientData/ResColor")
local EventConst = require("EventConst")
local strClassName = "ActivityEquipReformDlg"
local ActivityEquipReformDlg = Class(strClassName, UIControls.Window)

function ActivityEquipReformDlg:ctor()
	self:initUI()
end

function ActivityEquipReformDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.textServeTimes = UIControls.Label(self, "MainInfoPanel/BgServeTimes/TextServeTimes")
	self.textTime = UIControls.Label(self, "MainInfoPanel/BgTime/TextTime")
	self.aniSelf = UIControls.UIAni(self, "")

	self.aniSelf:addEventFinish(self.onAniFinish)

	self.equipListPart = ReformEquipListPart(self, "MainInfoPanel/EquipListPanel")
	self.equipListPanel = UIControls.Panel(self, "MainInfoPanel/EquipListPanel")
	self.addPanel = UIControls.Panel(self, "MainInfoPanel/EquipShowPanel/AddPanel")
	self.bgInitNothing = UIControls.Panel(self, "MainInfoPanel/AttrChangePanel/InitialAttrPanel/BgNothing")
	self.bgNewNothing = UIControls.Panel(self, "MainInfoPanel/AttrChangePanel/NewAttrPanel/BgNothing")
	self.attrInitPanel = UIControls.Panel(self, "MainInfoPanel/AttrChangePanel/InitialAttrPanel/AttrPanel")
	self.attrNewPanel = UIControls.Panel(self, "MainInfoPanel/AttrChangePanel/NewAttrPanel/AttrPanel")
	self.assistInitCells = {}
	self.assistNewCells = {}
	self.attrAnis = {}

	for i = 1, 4 do
		local initCell = EquipAssistAttrCell(self, "MainInfoPanel/AttrChangePanel/InitialAttrPanel/AttrPanel/Attr0" .. i)

		table.insert(self.assistInitCells, initCell)

		local newCell = EquipAssistAttrCell(self, "MainInfoPanel/AttrChangePanel/NewAttrPanel/AttrPanel/Attr0" .. i)

		table.insert(self.assistNewCells, newCell)

		local aniAttr = UIControls.UIAni(self, "MainInfoPanel/AttrChangePanel/NewAttrPanel/AttrPanel/Attr0" .. i)

		table.insert(self.attrAnis, aniAttr)
	end

	self.textLockNum = UIControls.Label(self, "MainInfoPanel/WashingLvPanel/TextNum")
	self.textLockExp = UIControls.Label(self, "MainInfoPanel/WashingLvPanel/TextExp")
	self.slider = UIControls.Slider(self, "MainInfoPanel/WashingLvPanel/Slider")
	self.btnWashingLvTips = UIControls.Button(self, "MainInfoPanel/WashingLvPanel/BtnWashingLvTips")

	self.btnWashingLvTips:addEventClick(self.onBtnWashingLvTipsClick)

	self.textLockLv = UIControls.Label(self, "MainInfoPanel/WashingLvPanel/BtnWashingLvTips/TextLv")
	self.btnFinish = UIControls.Button(self, "MainInfoPanel/AttrChangePanel/FuncPanel/BtnFinish")

	self.btnFinish:addEventClick(self.onBtnFinishClick)

	self.btnWash = UIControls.Button(self, "MainInfoPanel/AttrChangePanel/FuncPanel/BtnWash")

	self.btnWash:addEventClick(self.onBtnWashClick)

	self.iconWash = UIControls.Image(self, "MainInfoPanel/AttrChangePanel/FuncPanel/BtnWash/Icon")
	self.textWashNum = UIControls.Label(self, "MainInfoPanel/AttrChangePanel/FuncPanel/BtnWash/TextNum")
	self.btnInitial = UIControls.Button(self, "MainInfoPanel/AttrChangePanel/FuncPanel/BtnInitial")

	self.btnInitial:addEventClick(self.onBtnInitialClick)

	self.funcPanel = UIControls.Panel(self, "MainInfoPanel/AttrChangePanel/FuncPanel")
	self.slot4RefreshPanel = Slot(self.refreshItem, self)

	EventCenter.addEventListener(EventConst.ITEM_UPDATE, self.slot4RefreshPanel)

	self.btnEquipTips = UIControls.Button(self, "MainInfoPanel/EquipShowPanel/BtnTips")

	self.btnEquipTips:addEventClick(self.onBtnEquipTipsClick)

	self.btnInfo = UIControls.Button(self, "MainInfoPanel/Random/BtnInfo")

	self.btnInfo:addEventClick(self.onBtnInfoClick)

	self.randomInfoPanel = UIControls.Panel(self, "MainInfoPanel/Random/RandomInfoPanel")
	self.randomPanel = UIControls.Panel(self, "MainInfoPanel/Random")

	self.randomPanel:setVisible(false)

	self.uIClickThrough = UIControls.Button(self, "MainInfoPanel/Random/RandomInfoPanel/UIClickThrough")

	self.uIClickThrough:addEventClick(self.onUIClickThroughClick)

	self.textRandomRule = UIControls.Label(self, "MainInfoPanel/Random/RandomInfoPanel/Bg/BgRule/Text")
	self.attrInfoList = {}

	for i = 1, 10 do
		local attr = UIControls.Label(self, "MainInfoPanel/Random/RandomInfoPanel/Bg/ContentAttr/Attr" .. i)

		table.insert(self.attrInfoList, attr)
	end
end

function ActivityEquipReformDlg:setData(actObj)
	self.actObj = actObj
	self.actData = self.actObj.actData
	self.progressLimit = self.actData.miscData.progress_limit
	self.levelPro = self.actData.miscData.level_progress
	self.maxLockLevel = self.progressLimit / self.levelPro

	ClientTimerManager.AddSecondFormatTickUI(self.textTime, self.actObj:getRemainOpenTime(), false, Lang.get(48655), Slot(self._timerOver, self))
	self.textServeTimes:setText(string.format(Lang.get(89827), self.actData.remainCount))

	self.reformCostId = self.actData.miscData.baptize_item_id
	self.reformCostNum = self.actData.miscData.baptize_item_num or 1

	local itemIcon = BaseObject.getItemIconPath(self.reformCostId)

	if itemIcon then
		self.iconWash:setImage(itemIcon[1], itemIcon[2])
	end

	self.textWashNum:setText(self.reformCostNum)
	self:refreshPanel()
end

function ActivityEquipReformDlg:refreshPanel()
	self:refreshProPanel()
	self:refreshEquipInitPanel()
end

function ActivityEquipReformDlg:refreshItem()
	local haveItemNum = CurAvatar:getItemNumById(self.reformCostId)

	if haveItemNum >= self.reformCostNum then
		self.textWashNum:setFontColor(ResColor.WHITE)
	else
		self.textWashNum:setFontColor(ResColor.RED)
	end
end

function ActivityEquipReformDlg:refreshProPanel()
	self.curLockPro = self.actData.equipReformData.lock_progress or 0
	self.curLockLevel = math.min(self.maxLockLevel, math.floor(self.curLockPro / self.levelPro))

	self.textLockNum:setText(string.format(Lang.get(89840), self.curLockLevel))
	self.textLockLv:setText(string.format(Lang.get(89837), self.curLockLevel))
	self:refreshItem()

	if self.curLockLevel == self.maxLockLevel then
		self.textLockExp:setVisible(false)
		self.slider:setValue(1)
		self.textLockLv:setText(Lang.get(89838))
	else
		local curLvPro = self.curLockPro - self.curLockLevel * self.levelPro

		self.slider:setValue(curLvPro / self.levelPro)
		self.textLockExp:setVisible(true)
		self.textLockExp:setText(string.format("%d/%d", curLvPro, self.levelPro))
	end
end

function ActivityEquipReformDlg:refreshEquipInitPanel(equipGid)
	if self.actData.equipReformData.gid and CurAvatar.bagEquips[self.actData.equipReformData.gid] or equipGid and CurAvatar.bagEquips[equipGid] then
		self.funcPanel:setVisible(true)
		self.randomPanel:setVisible(true)

		self.initEquip = CurAvatar.bagEquips[self.actData.equipReformData.gid]

		if equipGid then
			self.initEquip = CurAvatar.bagEquips[equipGid]

			self.funcPanel:setVisible(false)
		end

		self.equipListPanel:setVisible(self.actData.equipReformData.gid and CurAvatar.bagEquips[self.actData.equipReformData.gid] == nil)
		self.addPanel:setVisible(false)
		self.bgInitNothing:setVisible(false)
		self.attrInitPanel:setVisible(true)

		if not self.gridEquip then
			self.gridEquip = UIControls.EquipGridChild(self, "MainInfoPanel/EquipShowPanel/GridPanel", "System/Common/Grid/GridEquipItem", 0, 0, true)
		end

		self.gridEquip.mEnableTips = false
		self.gridEquip.inBag = true

		self.gridEquip:setObj(self.initEquip)

		for index, cell in ipairs(self.assistInitCells) do
			local info = self.initEquip.assistProps[index]

			if info then
				cell:setVisible(true)
				cell:setAttr(info[1], info[2])
			else
				cell:setVisible(false)
			end
		end

		self:refreshSubAttrPanel()
	else
		self.funcPanel:setVisible(false)
		self.equipListPanel:setVisible(true)
		self.addPanel:setVisible(true)
		self.bgInitNothing:setVisible(true)
		self.attrInitPanel:setVisible(false)
		self.equipListPart:refreshData()
		self.equipListPart:setConfirmCallBack(Slot(self.onComfirmChooseEquip, self))
		self.equipListPart:setChooseCallBack(Slot(self.onChooseEquip, self))
	end
end

function ActivityEquipReformDlg:refreshSubAttrPanel(needPlayAni)
	if self.actData.equipReformData.sub_attr and #self.actData.equipReformData.sub_attr > 0 then
		self.bgNewNothing:setVisible(false)
		self.attrNewPanel:setVisible(true)
		self.btnInitial:setEnable(true)

		local subAttr = self.actData.equipReformData.sub_attr

		self.lockNum = 0

		for index, cell in ipairs(self.assistNewCells) do
			local info = subAttr[index]

			if info then
				cell:setVisible(true)
				cell:setAttr(info.type, info.value)
				cell:setLockInfo(index, info.lock)
				cell:setLockClick(Slot(self.onLockClick, self))
				cell:setLockSelClick(Slot(self.onLockCancleClick, self))

				if info.lock == Const.REFORM_EQUIP_SUB_ATTR_LOCK then
					self.lockNum = self.lockNum + 1
				elseif needPlayAni then
					self.attrAnis[index]:startAni("RefreshWashAttr")
				end
			else
				cell:setVisible(false)
			end
		end
	else
		self.bgNewNothing:setVisible(true)
		self.attrNewPanel:setVisible(false)
		self.btnInitial:setEnable(false)
	end
end

function ActivityEquipReformDlg:setRandomSubAttrPanel()
	local subAttrs = ResEquipBaptize[self.initEquip.subType].sub_attr_range

	for i, attrInfo in ipairs(self.attrInfoList) do
		if subAttrs[i] then
			local zhName = ClientUtils.getRolePropZhNameByType(subAttrs[i])

			attrInfo:setText(zhName)
			attrInfo:setVisible(true)
		else
			attrInfo:setVisible(false)
		end
	end

	self.textRandomRule:setText(ClientUtils.getClientNotice(745))
end

function ActivityEquipReformDlg:onChooseEquipResp()
	if self.equipListPanel:getVisible() then
		self.equipListPanel:setVisible(false)
	end

	self.textServeTimes:setText(string.format(Lang.get(89827), self.actData.remainCount))
	self:refreshEquipInitPanel()
end

function ActivityEquipReformDlg:playRefreshSubAttrAni()
	self.aniSelf:startAni("RefreshActivityEquipWashingCanvas")

	if self.equipListPanel:getVisible() then
		self.equipListPanel:setVisible(false)
	end

	self:refreshProPanel()
	self:refreshSubAttrPanel(true)
end

function ActivityEquipReformDlg:playFinishAni(equip)
	self.equipInfo = equip

	self.aniSelf:startAni("FinishActivityEquipWashingCanvas")
end

function ActivityEquipReformDlg:onAniFinish(aniCom, aniName)
	if aniName == "FinishActivityEquipWashingCanvas" and self.equipInfo then
		UIManager.getUI("activityEquipMakeSuccessDlg", true):onShow(Const.EQUIP_REFINE_TYPE.Reform, self.equipInfo)
	end
end

function ActivityEquipReformDlg:onChooseEquip(sender)
	self:refreshEquipInitPanel(sender.curChooseGid)
end

function ActivityEquipReformDlg:onComfirmChooseEquip(sender)
	if sender.curChooseGid then
		local function yesFunc()
			RPC.opActEquipBaptizeChoose(self.actObj.opId, sender.curChooseGid)
		end

		UIManager.showConfirmWithId(1099, yesFunc)
	else
		MsgManager.notice(Lang.get(89839))
	end
end

function ActivityEquipReformDlg:onLockClick(sender)
	if self.lockNum >= self.curLockLevel then
		MsgManager.notice(ClientUtils.getClientNotice(730))

		return
	end

	local pos = sender.pos

	RPC.opActEquipBaptizeAttrLock(self.actObj.opId, pos, Const.REFORM_EQUIP_LOCK_TYPE.Lock)
end

function ActivityEquipReformDlg:onLockCancleClick(sender)
	local pos = sender.pos

	RPC.opActEquipBaptizeAttrLock(self.actObj.opId, pos, Const.REFORM_EQUIP_LOCK_TYPE.UnLock)
end

function ActivityEquipReformDlg:onBtnFinishClick()
	local function yesFunc()
		RPC.opActEquipBaptizeDone(self.actObj.opId)
	end

	UIManager.showConfirmWithId(1103, yesFunc)
end

function ActivityEquipReformDlg:onBtnWashClick()
	if self:checkItemEnough(self.reformCostId, self.reformCostNum) then
		RPC.opActEquipBaptizeRandAttr(self.actObj.opId)
	end
end

function ActivityEquipReformDlg:onBtnInitialClick()
	local function yesFunc()
		RPC.opActEquipBaptizeInit(self.actObj.opId)
	end

	UIManager.showConfirmWithId(1104, yesFunc)
end

function ActivityEquipReformDlg:onBtnWashingLvTipsClick()
	UIManager.getUI("activityEquipReformLvDlg", true):setData(self.maxLockLevel, self.curLockLevel)
end

function ActivityEquipReformDlg:checkItemEnough(itemId, num)
	local costItemNum = CurAvatar:getItemNumById(itemId)

	if costItemNum < num then
		local fakeItem = BaseObject.GetObject(itemId)

		UIManager.getUI("itemTips"):showObj(self, fakeItem, {
			AutoOpenGuide = 1
		})
		MsgManager.notice(string.format(ResClientNotice[675].notice, fakeItem.name))

		return false
	end

	return true
end

function ActivityEquipReformDlg:_timerOver()
	if self.textTime and self.textTime:isAlive() then
		self.textTime:setText(Lang.get(32785))
	end
end

function ActivityEquipReformDlg:onBtnEquipTipsClick()
	if self.gridEquip then
		self.mTipsConfig = UIControls.TipsConfig()

		UIManager.getUI("equipTips"):show(self.gridEquip, self.mTipsConfig, self.uiConfig)

		local equipTips = UIManager.tryGetUI("equipTips")

		equipTips.btnBuild:setVisible(false)
		equipTips.panelFunc:setVisible(true)
	end
end

function ActivityEquipReformDlg:onBtnInfoClick()
	self:setRandomSubAttrPanel()
	self.randomInfoPanel:setVisible(true)
end

function ActivityEquipReformDlg:onUIClickThroughClick()
	self.randomInfoPanel:setVisible(false)
end

function ActivityEquipReformDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_EQUIP_REFORM)
end

function ActivityEquipReformDlg:onBtnCloseClick()
	if self.actData.equipReformData.gid and CurAvatar.bagEquips[self.actData.equipReformData.gid] then
		local refineDlg = UIManager.tryGetUI("activityEquipRefineDlg")

		if refineDlg then
			refineDlg:setVisible(false)
		end
	end

	self:setVisible(false)
end

function ActivityEquipReformDlg:onDestroy()
	EventCenter.removeEventListener(EventConst.ITEM_UPDATE, self.slot4RefreshPanel)
	ActivityEquipReformDlg.super.onClose(self)
end

return ActivityEquipReformDlg
