-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetPoolMainDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResPetGashaponDrawUp = require("ClientData/ResPetGashaponDrawUp")
local ResPetGashaponDraw = require("ClientData/ResPetGashaponDraw")
local ResColor = require("ClientData/ResColor")
local ResPetGashaponDrawLib = require("ClientData/ResPetGashaponDrawLib")
local ResPetGashaponConfig = require("ClientData/ResPetGashaponConfig")
local NumControlPanel = require("UI/MainState/Item/NumControlPanel")
local UserData = require("Helper/UserData")
local ResGridSpecialImgConfig = require("ClientData/ResGridSpecialImgConfig")
local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local GashaponGridChild = Class("GashaponGridChild", UIControls.Child)

function GashaponGridChild:ctor()
	self.textNum = UIControls.Label(self, "TextNum")
	self.imgLinked = UIControls.Image(self, "BtnGashapon/BgGashapon/ImgLinked")
	self.bgGashapon = UIControls.Image(self, "BtnGashapon/BgGashapon")
	self.btnAdd = UIControls.Button(self, "BtnAdd")

	self.btnAdd:addEventClick(self.onBtnAddClick)

	self.btnChange = UIControls.Button(self, "BtnChange")

	self.btnChange:addEventClick(self.onBtnChangeClick)

	self.btnGashapon = UIControls.Button(self, "BtnGashapon")

	self.btnGashapon:addEventClick(self.onBtnGashaponClick)

	if UIControls.checkControlFunc(self, "NewLabel") then
		self.newLabel = UIControls.Panel(self, "NewLabel")
	end
end

function GashaponGridChild:setData(data, drawCount)
	self.data = data
	self.configData = ResPetGashaponConfig[data.gashapon_id]

	if data.limit then
		self.textNum:setText(string.format("%d/%d", drawCount, data.limit))
	else
		self.textNum:setText(string.format("%d/∞", drawCount))
	end

	if self.configData.icon_path then
		self.bgGashapon:setImage(self.configData.icon_path, self.configData.icon)
	end

	if self.configData.quality == Const.PET_DRAW_QUALITY_SPECIAL_CHOOSE then
		local isChoosed = self:isChoosed()

		self.btnAdd:setVisible(not isChoosed)
		self.btnChange:setVisible(isChoosed)
	else
		self.btnAdd:setVisible(false)
		self.btnChange:setVisible(false)
	end

	if self.configData.subscript_id then
		self.imgLinked:setVisible(true)
		self.imgLinked:setImage("Atlas/" .. ResGridSpecialImgConfig[self.configData.subscript_id].icon_path, ResGridSpecialImgConfig[self.configData.subscript_id].icon_name)
	else
		self.imgLinked:setVisible(false)
	end
end

function GashaponGridChild:isChoosed()
	for i, v in pairs(CurAvatar.roleDrawData[Const.DrawTypePet].drawSelect or {}) do
		if v.gashapon_id == self.data.gashapon_id and v.select_item_id and utils.tableIsContainsElement(self.configData.items, v.select_item_id) and CurAvatar:gashaponItemTimeValid(v.select_item_id) then
			return true
		end
	end

	return false
end

function GashaponGridChild:onBtnGashaponClick()
	local item = BaseObject.GetObject(self.configData.item_id)

	UIManager.getUI("itemTips"):showObj(self, item)
end

function GashaponGridChild:onBtnAddClick()
	local petPoolSpeChooseDlg = UIManager.getUI("petPoolSpeChooseDlg", true)

	petPoolSpeChooseDlg:setData(self.data.gashapon_id)
	self.mParent:refreshNewLabel(true)
end

function GashaponGridChild:onBtnChangeClick()
	local petPoolSpeChooseDlg = UIManager.getUI("petPoolSpeChooseDlg", true)

	petPoolSpeChooseDlg:setData(self.data.gashapon_id)
	self.mParent:refreshNewLabel(true)
end

local strClassName = "PetPoolMainDlg"
local PetPoolMainDlg = Class(strClassName, UIControls.Window)

function PetPoolMainDlg:ctor()
	self:initUI()
end

function PetPoolMainDlg:onOpen()
	PetPoolMainDlg.super.onOpen(self)
end

function PetPoolMainDlg:initUI()
	self.aniSelf = UIControls.UIAni(self, "")

	self.aniSelf:addEventFinish(self.aniFinishCallBack)

	self.btnResetAni = UIControls.UIAni(self, "MainInfoPanel/GashaponPanel/BtnResetPanel")
	self.btnDrawLog = UIControls.Button(self, "MainInfoPanel/BtnDrawLog")

	self.btnDrawLog:addEventClick(self.onBtnDrawLogClick)

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.btnProbability = UIControls.Button(self, "MainInfoPanel/BtnProbability")

	self.btnProbability:addEventClick(self.onBtnProbabilityClick)

	self.btnSpeStore = UIControls.Button(self, "MainInfoPanel/BtnSpeStore")

	self.btnSpeStore:addEventClick(self.onBtnSpeStoreClick)

	self.gashaponPanel = UIControls.Panel(self, "MainInfoPanel/GashaponPanel")
	self.iconBallHighest = {}
	self.gridHighest = {}

	for i = 1, 3 do
		local iconBallHighest = UIControls.Image(self, "MainInfoPanel/GashaponPanel/BallPanel/IconBallHighest" .. i)

		table.insert(self.iconBallHighest, iconBallHighest)

		local gridGashaponHighest = UIControls.Panel(self, "MainInfoPanel/GashaponPanel/GashaponPoolList/GridGashaponHighest" .. i)

		gridGashaponHighest:setVisible(false)

		local imgFinish = UIControls.Panel(self, "MainInfoPanel/GashaponPanel/GashaponPoolList/GridGashaponHighest" .. i .. "/ImgFinish")

		table.insert(self.gridHighest, {
			gridGashaponHighest = gridGashaponHighest,
			imgFinish = imgFinish
		})
	end

	self.iconBallCom = {}
	self.gridCom = {}

	for i = 1, 4 do
		local iconBallCom = UIControls.Image(self, "MainInfoPanel/GashaponPanel/BallPanel/IconBallCom" .. i)

		table.insert(self.iconBallCom, iconBallCom)

		local gridGashaponCom = UIControls.Panel(self, "MainInfoPanel/GashaponPanel/GashaponPoolList/GridGashaponCom" .. i)
		local imgFinish = UIControls.Panel(self, "MainInfoPanel/GashaponPanel/GashaponPoolList/GridGashaponCom" .. i .. "/ImgFinish")

		table.insert(self.gridCom, {
			gridGashaponCom = gridGashaponCom,
			imgFinish = imgFinish
		})
	end

	self.gashaponComGrids = {}
	self.gashaponHighestGrids = {}
	self.numPanel = NumControlPanel(self, "MainInfoPanel/GashaponPanel/BtnStartPanel/NumPanel")
	self.numPanel.mEventNumChanged = Slot(self.onNumChanged, self)
	self.iconPrice = UIControls.Image(self, "MainInfoPanel/GashaponPanel/BtnStartPanel/PricePanel/IconPrice")
	self.textPriceNum = UIControls.Label(self, "MainInfoPanel/GashaponPanel/BtnStartPanel/PricePanel/TextPriceNum")
	self.btnStartText = UIControls.Label(self, "MainInfoPanel/GashaponPanel/BtnStartPanel/BtnStart/Text")
	self.btnStart = UIControls.Button(self, "MainInfoPanel/GashaponPanel/BtnStartPanel/BtnStart")

	self.btnStart:addEventClick(self.onBtnStartClick)

	self.btnReset = UIControls.Button(self, "MainInfoPanel/GashaponPanel/BtnResetPanel/BtnReset")

	self.btnReset:addEventClick(self.onBtnResetClick)

	self.lockResetPanel = UIControls.Image(self, "MainInfoPanel/GashaponPanel/BtnResetPanel/BtnReset/LockResetPanel")
	self.resetPanel = UIControls.Image(self, "MainInfoPanel/GashaponPanel/BtnResetPanel/BtnReset/ResetPanel")
	self.attentionSwitch = UIControls.Toggle(self, "MainInfoPanel/GashaponPanel/BgSkip/AttentionSwitch")

	self.attentionSwitch:addEventValueChanged(self.onToggleChange)

	self.bgTime = UIControls.Image(self, "MainInfoPanel/GashaponPanel/BgTime")
	self.textTime = UIControls.Label(self, "MainInfoPanel/GashaponPanel/BgTime/TextTime")
	self.bgTextChat = UIControls.Panel(self, "MainInfoPanel/GashaponPanel/BgTextChat")
	self.textChat = UIControls.Label(self, "MainInfoPanel/GashaponPanel/BgTextChat/TextChat")
	self.petAndAmuletDic = {}

	if UIControls.checkControlFunc(self, "MainInfoPanel/GashaponPanel/BtnPetFullStar") then
		self.btnPetFullStar = UIControls.Button(self, "MainInfoPanel/GashaponPanel/BtnPetFullStar")

		self.btnPetFullStar:addEventClick(self.onBtnPetFullStarClick)
		self.btnPetFullStar:setVisible(false)

		self.textSlogan = UIControls.Label(self, "MainInfoPanel/GashaponPanel/BtnPetFullStar/TextSlogan")
	end

	if UIControls.checkControlFunc(self, "limitNumPanel") then
		self.limitNumPanel = UIControls.Panel(self, "limitNumPanel")

		self.limitNumPanel:setVisible(false)

		self.node01 = UIControls.Panel(self, "limitNumPanel/Node01")
		self.node02 = UIControls.Panel(self, "limitNumPanel/Node02")
		self.remainTxt = UIControls.Label(self, "limitNumPanel/Node01/TextNum01")
	end
end

function PetPoolMainDlg:setData()
	RedDotManager.setKeyState(UIConst.RD_HINT_PET_DRAW, false)

	self.actObjs = {}
	self.actHighestItems = {}
	self.curActId = 0

	for actId, v in pairs(ResPetGashaponDrawUp) do
		local actObj = CurAvatar:getActivityObj(actId)

		if actObj and actObj:isValid() then
			actObj.actData.skipCheckItemNew = true

			actObj:checkNew()
			CurAvatar:addActivityRelated(actObj.actId, "activityCommonStoreDlg")
			table.insert(self.actObjs, {
				actObj = actObj,
				tData = v
			})

			if actId > self.curActId then
				self.curActId = actId
			end

			local replaceLibId = actObj.actData.drawDetailData.lib

			for i, data in pairs(ResPetGashaponDrawLib[replaceLibId] or {}) do
				if data.limit and ResPetGashaponConfig[data.gashapon_id].quality == Const.PET_DRAW_QUALITY_ACT then
					table.insert(self.actHighestItems, {
						data = data,
						actObj = actObj
					})
				end
			end

			CurAvatar:checkGameAssistant(Const.GAME_ASSISTANT_TRIGGER_TYPE.ActOpen, {
				arg = actObj.actType
			}, true)
		end
	end

	self.itemID = ResPetGashaponDraw[1].cost_item
	self.costNum = ResPetGashaponDraw[1].cost_num

	local iconPath = BaseObject.getItemIconPath(self.itemID)

	if iconPath then
		self.iconPrice:setImage(iconPath[1], iconPath[2])
	end

	self.limitLibId = ResPetGashaponDraw[1].limit_lib
	self.unLimitLibId = ResPetGashaponDraw[1].unlimit_lib
	self.comSpecialItems = {}

	for i, v in pairs(ResPetGashaponDrawLib[self.unLimitLibId] or {}) do
		if ResPetGashaponConfig[v.gashapon_id].quality == Const.PET_DRAW_QUALITY_NORMAL then
			self.normalItem = v
		end
	end

	for i, v in pairs(ResPetGashaponDrawLib[self.limitLibId] or {}) do
		if v.limit and (ResPetGashaponConfig[v.gashapon_id].quality == Const.PET_DRAW_QUALITY_SPECIAL or ResPetGashaponConfig[v.gashapon_id].quality == Const.PET_DRAW_QUALITY_SPECIAL_CHOOSE) then
			table.insert(self.comSpecialItems, v)
		end
	end

	table.sort(self.comSpecialItems, function(a, b)
		if a.quality ~= b.quality then
			return a.quality > b.quality
		else
			return a.gashapon_id < b.gashapon_id
		end
	end)

	local isCloseAnimation = UserData.loadCommonData(CurAvatar.uid .. "PetPoolMainAnimation")

	if isCloseAnimation and isCloseAnimation == "1" then
		self.attentionSwitch:setOn(true)

		self.toggleIsOn = true
	else
		self.attentionSwitch:setOn(false)

		self.toggleIsOn = false
		isCloseAnimation = "0"
	end

	UserData.saveCommonData(CurAvatar.uid .. "PetPoolMainAnimation", isCloseAnimation)
	self.bgTime:setVisible(self.curActId ~= 0)

	if self.curActId ~= 0 then
		local actObj = CurAvatar:getActivityObj(self.curActId)

		if actObj then
			local startEndTime = actObj:getStartEndTime()
			local startTime = startEndTime[1]
			local endTime = startEndTime[2]
			local startTimeTxt = ClientUtils.getServerTimeData(startTime, Lang.get(30270))
			local endTimeTxt = ClientUtils.getServerTimeData(endTime, Lang.get(30270))

			self.textTime:setText(string.format("%s-%s", startTimeTxt, endTimeTxt))

			if self.btnPetFullStar then
				self.btnPetFullStar:setVisible(true)
				self.textSlogan:setText(actObj.actData.drawDetailData.slogan or "")
			end
		end
	end

	self.haveNum = CurAvatar:getItemNumById(self.itemID)

	if self.haveNum > 10 then
		self.nowNum = 10
	elseif self.haveNum <= 0 then
		self.nowNum = 1
	else
		self.nowNum = self.haveNum
	end

	self:refreshBallUI()
	self:refreshDrawUI()
	self:refreshNewLabel()
end

function PetPoolMainDlg:onShowActivity()
	self:setData()
end

function PetPoolMainDlg:refreshBallUI()
	for i, v in ipairs(self.comSpecialItems) do
		local drawCount = 0

		for _, record in pairs(CurAvatar.roleDrawData[Const.DrawTypePet].drawRecord or {}) do
			if record.gashapon_id and v.gashapon_id == record.gashapon_id then
				drawCount = record.drawed_num

				break
			end
		end

		if self.iconBallCom[i] then
			if drawCount < v.limit then
				local configData = ResPetGashaponConfig[v.gashapon_id]

				self.iconBallCom[i]:setImage(configData.icon_path, configData.icon)
			else
				local configData = ResPetGashaponConfig[self.normalItem.gashapon_id]

				self.iconBallCom[i]:setImage(configData.icon_path, configData.icon)
			end
		end

		if self.gridCom[i] then
			self.gridCom[i].imgFinish:setVisible(drawCount >= v.limit)

			local gashaponComGrid = self.gashaponComGrids[i]

			if gashaponComGrid == nil then
				gashaponComGrid = GashaponGridChild(self, "MainInfoPanel/GashaponPanel/GashaponPoolList/GridGashaponCom" .. i .. "/GridPanel", "System/PetPool/PetPoolCommon/GridGashapon", 0, 0, true)
			end

			gashaponComGrid:setData(v, drawCount)

			self.gashaponComGrids[i] = gashaponComGrid
		end
	end

	for i, v in ipairs(self.actHighestItems or {}) do
		local data = v.data
		local actObj = v.actObj
		local replacePath = ResPetGashaponDrawUp[actObj.actId].replace_path or "System/PetPool/PetPoolCommon"
		local drawCount = 0

		for _, record in pairs(actObj.actData.drawData.drawRecord or {}) do
			if record.gashapon_id and data.gashapon_id == record.gashapon_id then
				drawCount = record.drawed_num

				break
			end
		end

		if self.iconBallHighest[i] then
			self.iconBallHighest[i]:setVisible(true)

			if drawCount < data.limit then
				local configData = ResPetGashaponConfig[data.gashapon_id]

				self.iconBallHighest[i]:setImage(configData.icon_path, configData.icon)
			else
				local configData = ResPetGashaponConfig[self.normalItem.gashapon_id]

				self.iconBallHighest[i]:setImage(configData.icon_path, configData.icon)
			end
		end

		if self.gridHighest[i] then
			self.gridHighest[i].gridGashaponHighest:setVisible(true)
			self.gridHighest[i].imgFinish:setVisible(drawCount >= data.limit)

			local gashaponHighestGrid = self.gashaponHighestGrids[i]

			if gashaponHighestGrid == nil then
				gashaponHighestGrid = GashaponGridChild(self, "MainInfoPanel/GashaponPanel/GashaponPoolList/GridGashaponHighest" .. i .. "/GridPanel", replacePath .. "/GridGashapon", 0, 0, true)
			end

			gashaponHighestGrid:setData(data, drawCount)

			self.gashaponHighestGrids[i] = gashaponHighestGrid
		end
	end

	local remainCount = self:getRemainCount()

	self.bgTextChat:setVisible(remainCount <= 10)

	if remainCount == 0 then
		self.textChat:setText(Lang.get(79267))
	else
		self.textChat:setText(string.format(Lang.get(79268), remainCount))
	end
end

function PetPoolMainDlg:refreshNewLabel(isHide)
	for i, grid in pairs(self.gashaponComGrids or {}) do
		if grid.configData.quality == Const.PET_DRAW_QUALITY_SPECIAL_CHOOSE and grid.newLabel then
			if isHide then
				grid.newLabel:setVisible(false)
			else
				grid.newLabel:setVisible(CurAvatar:checkGashaponItemNew())
			end
		end
	end
end

function PetPoolMainDlg:refreshDrawUI()
	self.haveNum = CurAvatar:getItemNumById(self.itemID)

	local remainCount = self:getRemainCount()

	if remainCount < 10 then
		self.nowNum = math.min(self.nowNum, math.max(remainCount, 1))
	end

	self.numPanel:onShow(10, self.nowNum, "")
	self.textPriceNum:setText(self.costNum * self.nowNum)

	if self.haveNum >= self.costNum * self.nowNum then
		self.textPriceNum:setFontColor(ResColor.WHITE)
	else
		self.textPriceNum:setFontColor(ResColor.RED)
	end

	local isCanReset = CurAvatar:checkPetPoolCanReset()

	self.lockResetPanel:setVisible(not isCanReset)
	self.resetPanel:setVisible(isCanReset)
	self.btnStart:setEnable(true)
	self:_refreshRemainCount()
end

function PetPoolMainDlg:_refreshRemainCount(...)
	if self.limitNumPanel and CurAvatar:dayDrawCountLimitOpen() then
		self.limitNumPanel:setVisible(true)

		local todayRemain = CurAvatar:getDrawDayCount(Const.DrawTypePet, Const.DayDrawMaxCountFree)

		if todayRemain >= Const.DayDrawMaxCountFree then
			self.node01:setVisible(false)
			self.node02:setVisible(true)
		else
			self.node01:setVisible(true)
			self.node02:setVisible(false)
			self.remainTxt:setText(todayRemain .. "/" .. Const.DayDrawMaxCountFree)
		end
	end
end

function PetPoolMainDlg:onNumChanged(num)
	if num < 1 then
		MsgManager.notice(Lang.get(78796))

		num = 1
	end

	self.nowNum = num

	self.textPriceNum:setText(self.costNum * self.nowNum)
	self.btnStartText:setText(string.format(Lang.get(78795), self.nowNum))

	if self.haveNum >= self.costNum * self.nowNum then
		self.textPriceNum:setFontColor(ResColor.WHITE)
	else
		self.textPriceNum:setFontColor(ResColor.RED)
	end
end

function PetPoolMainDlg:getRemainCount()
	local remainCount = 0

	for i, v in pairs(ResPetGashaponDrawLib[self.limitLibId] or {}) do
		if ResPetGashaponConfig[v.gashapon_id].quality ~= Const.PET_DRAW_QUALITY_NORMAL then
			remainCount = remainCount + v.limit

			for _, record in pairs(CurAvatar.roleDrawData[Const.DrawTypePet].drawRecord or {}) do
				if record.gashapon_id and v.gashapon_id == record.gashapon_id then
					remainCount = remainCount - record.drawed_num
				end
			end
		end
	end

	for _, data in pairs(self.actObjs) do
		local actObj = data.actObj

		for _, v in pairs(ResPetGashaponDrawLib[actObj.actData.replaceLibId] or {}) do
			remainCount = remainCount + v.limit

			for _, record in pairs(actObj.actData.drawData.drawRecord or {}) do
				if record.gashapon_id and v.gashapon_id == record.gashapon_id then
					remainCount = remainCount - record.drawed_num
				end
			end
		end
	end

	return remainCount
end

function PetPoolMainDlg:checkIsSelectAllBall()
	for _, v in pairs(ResPetGashaponDrawLib[self.limitLibId] or {}) do
		if ResPetGashaponConfig[v.gashapon_id].quality == Const.PET_DRAW_QUALITY_SPECIAL_CHOOSE then
			local isNotSelectId = v.gashapon_id

			for _, select in pairs(CurAvatar.roleDrawData[Const.DrawTypePet].drawSelect or {}) do
				if select.gashapon_id == v.gashapon_id and select.select_item_id and utils.tableIsContainsElement(ResPetGashaponConfig[v.gashapon_id].items, select.select_item_id) and CurAvatar:gashaponItemTimeValid(select.select_item_id) then
					isNotSelectId = nil
				end
			end

			if isNotSelectId then
				return false, isNotSelectId
			end
		end
	end

	return true
end

function PetPoolMainDlg:isAllDrawed()
	for i, v in pairs(ResPetGashaponDrawLib[self.limitLibId] or {}) do
		local isHave = false

		for _, record in pairs(CurAvatar.roleDrawData[Const.DrawTypePet].drawRecord or {}) do
			if record.gashapon_id and v.gashapon_id == record.gashapon_id then
				isHave = true

				if v.limit and record.drawed_num < v.limit then
					return false
				end
			end
		end

		if not isHave then
			return false
		end
	end

	for _, data in pairs(self.actObjs) do
		local actObj = data.actObj

		for _, v in pairs(ResPetGashaponDrawLib[actObj.actData.replaceLibId] or {}) do
			local isHave = false

			for _, record in pairs(actObj.actData.drawData.drawRecord or {}) do
				if record.gashapon_id and v.gashapon_id == record.gashapon_id then
					isHave = true

					if v.limit and record.drawed_num < v.limit then
						return false
					end
				end
			end

			if not isHave then
				return false
			end
		end
	end

	return true
end

function PetPoolMainDlg:onToggleChange(sender, isOn)
	local isCloseAnimation = isOn == true and "1" or "0"

	self.toggleIsOn = isOn

	UserData.saveCommonData(CurAvatar.uid .. "PetPoolMainAnimation", isCloseAnimation)
end

function PetPoolMainDlg:onPetDrawResp(items)
	self.drawGetItems = items

	if self.toggleIsOn then
		self:openResultDlgAndRefreshUI()
	else
		self.aniSelf:startAni("ShowPetPoolRandom", true)
	end
end

function PetPoolMainDlg:aniFinishCallBack(aniCom, aniName)
	if aniName == "ShowPetPoolRandom" then
		self:openResultDlgAndRefreshUI()
		self.aniSelf:startAni("ResetPetPoolRandom", true)
	elseif aniName == "ShowPetPoolReset" then
		self:refreshBallUI()
		self:refreshDrawUI()
	end
end

function PetPoolMainDlg:playResetOpenAni()
	local isPlayResetAni = UserData.loadCommonData(CurAvatar.uid .. "PetPoolMainResetAnimation")

	if not isPlayResetAni or isPlayResetAni ~= "1" then
		local isCanReset = CurAvatar:checkPetPoolCanReset()

		if isCanReset then
			self.btnResetAni:startAni("UnLockReset", true)
			UserData.saveCommonData(CurAvatar.uid .. "PetPoolMainResetAnimation", "1")
			BeginnerManager.CheckPetPoolCanReset()
		end
	end
end

function PetPoolMainDlg:openResultDlgAndRefreshUI()
	local petPoolResultDlg = UIManager.getUI("petPoolResultDlg", true)

	petPoolResultDlg:setData(self.drawGetItems, self.curActId)

	self.drawGetItems = nil

	self:refreshBallUI()
	self:refreshDrawUI()
end

function PetPoolMainDlg:onPetDrawRestResp()
	self.aniSelf:startAni("ShowPetPoolReset", true)
	UserData.saveCommonData(CurAvatar.uid .. "PetPoolMainResetAnimation", "0")
end

function PetPoolMainDlg:openChooseDlg(notSelectId)
	local petPoolSpeChooseDlg = UIManager.getUI("petPoolSpeChooseDlg", true)

	petPoolSpeChooseDlg:setData(notSelectId)
end

function PetPoolMainDlg:onBtnStartClick()
	self.haveNum = CurAvatar:getItemNumById(self.itemID)

	if self.nowNum < 1 then
		MsgManager.notice(Lang.get(78796))

		return
	end

	local isAllSelect, notSelectId = self:checkIsSelectAllBall()

	if not isAllSelect then
		local msgContent = Lang.get(79269)

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", msgContent, Functor(self.openChooseDlg, self, notSelectId), nil, -1, Lang.get(126), Lang.get(7))

		return
	end

	if self.haveNum < self.costNum * self.nowNum then
		MsgManager.notice(Lang.get(200))

		local fakeItem = BaseObject.GetObject(self.itemID)

		fakeItem.mDisableWays = false

		UIManager.getUI("itemTips"):showObj(self, fakeItem)

		return
	end

	local isCanReset = CurAvatar:checkPetPoolCanReset()

	if isCanReset then
		local content = Lang.get(79270)

		UIManager.showConfirm(UIConst.CONFIRM_THREEBTN, "", content, {
			Slot(self.onBtnResetClick, self),
			nil,
			Slot(self._realDrawFunc, self)
		}, -1, {
			Lang.get(79271),
			Lang.get(569),
			Lang.get(79272)
		})
	else
		self:_realDrawFunc()
	end
end

function PetPoolMainDlg:_realDrawFunc()
	if not DrawCardUtils.checkRemainCount(Const.DrawTypePet, self.nowNum) then
		MsgManager.notice(Lang.get(30265))

		return
	end

	self.btnStart:setEnable(false)
	self:getCurPetAndAmuletDicData()

	local totalCount = CurAvatar.roleDrawData[Const.DrawTypePet].count

	RPC.draw(Const.DrawTypePet, self.nowNum, Const.DrawCostTypeItem, nil, totalCount)
end

function PetPoolMainDlg:getCurPetAndAmuletDicData()
	self.petAndAmuletDic = {}

	for i, v in pairs(CurAvatar.petDic) do
		self.petAndAmuletDic[v.id] = true
	end

	for i, v in pairs(CurAvatar.petAmuletDic) do
		self.petAndAmuletDic[v.id] = true
	end
end

function PetPoolMainDlg:onBtnResetClick()
	local isCanReset = CurAvatar:checkPetPoolCanReset()

	if not isCanReset then
		MsgManager.notice(Lang.get(78798))

		return
	end

	RPC.petDrawRest()
end

function PetPoolMainDlg:onBtnDrawLogClick()
	UIManager.getUI("petPoolDrawLogDlg", true):setData(Const.DrawPoolIdPetGashapon)
end

function PetPoolMainDlg:onBtnProbabilityClick()
	UIManager.getUI("petPoolProbabilityDlg", true):setData(self.curActId, self.actObjs)
end

function PetPoolMainDlg:onBtnSpeStoreClick()
	local subMallId = ResPetGashaponDraw[1].sub_mall_id or 69

	UIManager.getUI("activityCommonStoreDlg", true):setData(nil, subMallId)
end

function PetPoolMainDlg:onBtnPetFullStarClick()
	if ResPetGashaponDrawUp[self.curActId] then
		UIManager.getUI("petPoolFullStarDlg", true):setData(ResPetGashaponDrawUp[self.curActId].pet_id)
	end
end

function PetPoolMainDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_PET_DRAW)
end

function PetPoolMainDlg:showMsgAndClose()
	if self.curActId ~= 0 then
		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(5), Lang.get(79273), Slot(self.onBtnCloseClick, self))
	end
end

function PetPoolMainDlg:onBtnCloseClick()
	self:setVisible(false)

	local needCloseUI = {
		"petPoolSpeChooseDlg",
		"infoNotice",
		"petPoolDrawLogDlg",
		"petPoolProbabilityDlg",
		"petPoolResultDlg",
		"activityCommonStoreDlg"
	}

	for i, uiName in pairs(needCloseUI) do
		local ui = UIManager.tryGetUI(uiName)

		if ui then
			ui:setVisible(false)
		end
	end
end

return PetPoolMainDlg
