-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetGuestView.lua

module("logic.extensions.cutepet.view.CutePetGuestView", package.seeall)

local CutePetGuestView = class("CutePetGuestView", ViewComponent)

function CutePetGuestView:ctor()
	CutePetGuestView.super.ctor(self)
end

function CutePetGuestView:buildUI()
	CutePetGuestView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnRule = self:getGo("leftTop/btnTip")
	self._btnOneKey = self:getGo("btnOneKey")
	self._txtCount = self:getTxt("txtPetCount/txtNum")
	self._tableView = self:getGo("tableview")
	self._tableCell = self:getGo("cell")
	self._tableList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._timeTip = self:getGo("timeTip")
	self._txtTipTime = self:getTxt("timeTip/txtTipTime")
	self._txtTipDesc = self:getTxt("timeTip/txtTipDesc")
end

function CutePetGuestView:bindEvents()
	CutePetGuestView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
end

function CutePetGuestView:unbindEvents()
	CutePetGuestView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnOneKey)
end

function CutePetGuestView:onExit()
	CutePetGuestView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_OpenGuestHouseLoadInfoResp, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_GainOrFreeGuestHouseSlotCutePetResp, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_SpeedUpGuestHouseSlotResp, self._refreshView, self)
	self._tableList:dispose()
	removetimer(self._onTimeClock, self)
	removetimer(self._updateTimeTip, self)
end

function CutePetGuestView:onEnter()
	CutePetGuestView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_OpenGuestHouseLoadInfoResp, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_GainOrFreeGuestHouseSlotCutePetResp, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_SpeedUpGuestHouseSlotResp, self._refreshView, self)

	if FuncOpenController.instance:checkFuncIdOrShowLockTips(910) == false then
		self:close()

		return
	end

	self._planId = CutePetConfig.instance:getCommonValue("GuestHouseSpeedUpPlanId", true)
	self._speedUpCfg = CutePetConfig.instance:getGuestSpeedUpCfg(self._planId)

	self:_refreshView()
	CutePetGardenAgent.instance:sendPM_OpenGuestHouseLoadInfoReq()

	local privateUseTime = CutePetConfig.instance:getPrivilegeCommonValue("Privilege_GuestHouseGenCutePetPerNSecd", true)
	local hour, min, sec = GameUtil.getTimeHHMMSS(privateUseTime)

	self._txtTipDesc.text = hour >= 1 and langPara("招待所打扫时间减少为%d小时", hour) or min >= 1 and langPara("招待所打扫时间减少为%d分", min) or langPara("招待所打扫时间减少为%d秒", sec)

	self:_updateTimeTip()
	settimer(10, self._updateTimeTip, self)
end

function CutePetGuestView:_refreshView()
	local cur = CutePetModel.instance:getCutePetsCount()
	local total = CutePetController.instance:getCutePetCapacity()

	self._txtCount.text = string.format("%s/%s", cur, total)

	local slotInfo = CutePetModel.instance:getGuestSlotInfo() or {}

	self.tagartTime = CutePetModel.instance:getGuestComeTime()
	self._timeCellIndex = 0
	self._slotList = {}

	local count = math.max(#slotInfo, CutePetConfig.instance:getCommonValue("GuestHouseCapacity", true))

	for i = 1, count do
		if i <= #slotInfo then
			table.insert(self._slotList, {
				info = slotInfo[i]
			})
		elseif i == #slotInfo + 1 then
			table.insert(self._slotList, {
				waitTime = true
			})

			self._timeCellIndex = i - 1
		else
			table.insert(self._slotList, {
				isEmpty = true
			})
		end
	end

	self._tableList:reloadData(self._slotList)
	self._tableList:MoveCellToCenter(0)
	removetimer(self._onTimeClock, self)
	settimer(1, self._onTimeClock, self)
	self:_onTimeClock()
end

function CutePetGuestView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local bg = goutil.findChild(go, "bg")
	local txtName = goutil.findChildTextComponent(go, "petInfo/txtName")
	local petCon = goutil.findChild(go, "petCon")
	local empty = goutil.findChild(go, "txtWait")
	local newPetTime = goutil.findChild(go, "txtNewPetTime")
	local txtNewPetTime = goutil.findChildTextComponent(go, "txtNewPetTime/txtTime")
	local imgType = goutil.findChildComponent(go, "petInfo/imgType", "UIImageSpriteChange")
	local petInfo = goutil.findChild(go, "petInfo")
	local btnCheck = GameUtil.asBtn(goutil.findChild(go, "btnCheck"))
	local btnQuicklyGet = GameUtil.asBtn(goutil.findChild(go, "btnQuicklyGet"))

	self:_unRegisterTimeClock(txtNewPetTime)
	btnQuicklyGet:RemoveClickListener()
	btnCheck:RemoveClickListener()
	GameUtil.SetActive(empty, false)
	GameUtil.SetActive(txtName, false)
	GameUtil.SetActive(petCon, false)
	GameUtil.SetActive(newPetTime, false)
	GameUtil.SetActive(imgType, false)
	GameUtil.SetActive(btnCheck, false)
	GameUtil.SetActive(btnQuicklyGet, false)
	GameUtil.SetActive(petInfo, false)
	MaterialMgr.clearIcon(petCon)

	if data.isEmpty == true then
		GameUtil.SetActive(empty, true)
	elseif data.waitTime == true then
		GameUtil.SetActive(newPetTime, true)
		GameUtil.SetActive(btnQuicklyGet, true)
		self:_registerTimeClock(txtNewPetTime, self.tagartTime)
		btnQuicklyGet:AddClickListener(function()
			local cost = self._speedUpCfg.cost
			local sec = self._speedUpCfg.speedUpSecd
			local min = math.floor(sec / 60)
			local type, id, _ = MaterialMgr.getMatParams(cost)
			local name = MaterialMgr.getMaterialsName(type, id)
			local leftTime = self.tagartTime - ServerTime.now()
			local maxNum = math.ceil(leftTime / sec)

			TipsFacade.instance:openPopupCostAdjustView(type, id, 1, langPara("每消耗一张%s减少%s分钟等待时间，是否确定？", name, min), function(num)
				CutePetController.instance:sendPM_SpeedUpGuestHouseSlotReq(self._planId, num)
				btnCheck.transform:SetAsLastSibling()
			end, maxNum)
		end)
	elseif data.info then
		GameUtil.SetActive(imgType, true)
		GameUtil.SetActive(petCon, true)
		GameUtil.SetActive(txtName, true)
		GameUtil.SetActive(btnCheck, true)
		GameUtil.SetActive(petInfo, true)

		local raceCfg = CutePetConfig.instance:getCutePetById(data.info.cutePetRace)

		txtName.text = raceCfg.name

		imgType:SetState(raceCfg.type - 1)
		MaterialMgr.setIcon(petCon, MatType.CutePet, data.info.cutePetRace)
		btnCheck:AddClickListener(function()
			btnQuicklyGet.transform:SetAsLastSibling()
			self:_onClickSlot(data.info.slotId)
		end)
	end
end

function CutePetGuestView:_clearCell(cell)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local petCon = goutil.findChild(go, "petCon")
	local empty = goutil.findChild(go, "txtWait")
	local newPetTime = goutil.findChild(go, "txtNewPetTime")
	local txtNewPetTime = goutil.findChildTextComponent(go, "txtNewPetTime/txtTime")
	local imgType = goutil.findChildComponent(go, "imgType", "UIImageSpriteChange")
	local btnCheck = GameUtil.asBtn(goutil.findChild(go, "btnCheck"))
	local btnQuicklyGet = GameUtil.asBtn(goutil.findChild(go, "btnQuicklyGet"))

	self:_unRegisterTimeClock(txtNewPetTime)
	MaterialMgr.clearIcon(petCon)
end

function CutePetGuestView:_registerTimeClock(txt, tagTime)
	self._timeClockTxt = self._timeClockTxt or {}
	self._timeClockTxt[txt] = {
		textCmp = txt,
		time = tagTime
	}
end

function CutePetGuestView:_unRegisterTimeClock(txt)
	if self._timeClockTxt then
		self._timeClockTxt[txt] = nil
	end
end

function CutePetGuestView:_onTimeClock()
	if self._timeClockTxt then
		for i, v in pairs(self._timeClockTxt) do
			local leftTime = v.time - ServerTime.now()

			if leftTime > 0 then
				v.textCmp.text = GameUtil.FormatTimeSymbol(leftTime)
			else
				v.textCmp.text = "00:00:00"

				CutePetGardenAgent.instance:sendPM_OpenGuestHouseLoadInfoReq()

				return
			end
		end
	end
end

function CutePetGuestView:_onClickSlot(slotId)
	CutePetController.instance:sendPM_ViewGuestHouseSlotCutePetReq(slotId)
end

function CutePetGuestView:_onClickRule()
	TipsFacade.instance:openRulesView("cute_pet_guest_rule")
end

function CutePetGuestView:_onClickOneKey()
	local canGetCount = CutePetController.instance:getCutePetCapacity() - CutePetModel.instance:getCutePetsCount()

	if canGetCount <= 0 then
		FloatWordMgr.instance:show(lang("萌宠数量已满"))

		return
	end

	local slotIds = {}

	canGetCount = math.max(0, canGetCount)

	for i, v in ipairs(self._slotList) do
		if not v.info or canGetCount < i then
			break
		end

		table.insert(slotIds, v.info.slotId)
	end

	if #slotIds > 0 then
		CutePetGardenAgent.instance:sendPM_BatchGainGuestHouseSlotCutePetReq(slotIds)
	else
		FloatWordMgr.instance:show(lang("无可领取萌宠"))
	end
end

function CutePetGuestView:_onClickClose()
	self:close()
end

function CutePetGuestView:_updateTimeTip()
	local isInTime, txtTime = CutePetController.instance:updateTimeTip(CutePetConfig.instance:getPrivilegeCommonValue("PrivilegeTimePlan_GuestHouseGenCutePet", false))

	goutil.setActive(self._timeTip, isInTime)

	self._txtTipTime.text = txtTime
end

return CutePetGuestView
