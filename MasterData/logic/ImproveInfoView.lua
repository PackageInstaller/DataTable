-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/improveinfo/view/ImproveInfoView.lua

module("logic.extensions.improveinfo.view.ImproveInfoView", package.seeall)

local ImproveInfoView = class("ImproveInfoView", ViewComponent)

function ImproveInfoView:buildUI()
	ImproveInfoView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._phoneInput = self:getInput("phone/input")
	self._phoneInputPlaceholder = self:getTxt("phone/input/Placeholder")
	self._phoneSubmitBtn = self:getBtn("phone/submitBtn")
	self._phoneComplete = self:getGo("phone/complete")
	self._phoneChange = self._phoneSubmitBtn.gameObject:GetComponent("UIImageSpriteChange")
	self._phoneSubmitText = goutil.findChildTextComponent(self._phoneSubmitBtn.gameObject, "Text")
	self._qqInput = self:getInput("qq/input")
	self._qqInputPlaceholder = self:getTxt("qq/input/Placeholder")
	self._qqSubmitBtn = self:getBtn("qq/submitBtn")
	self._qqChange = self._qqSubmitBtn.gameObject:GetComponent("UIImageSpriteChange")
	self._qqSubmitText = goutil.findChildTextComponent(self._qqSubmitBtn.gameObject, "Text")
	self._qqComplete = self:getGo("qq/complete")
	self._toggle = self:getToggle("Toggle")
	self._reward = {}

	for i = 1, 3 do
		local path = "reward" .. i

		self._reward[i] = {
			item = self:getGo(path .. "/item"),
			effect = self:getGo(path .. "/effect"),
			received = self:getGo(path .. "/receive")
		}
	end
end

function ImproveInfoView:bindEvents()
	ImproveInfoView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._phoneSubmitBtn:AddClickListener(function()
		self:_onClickSubmit(GameEnum.TELEPHONE, self._phoneInput, self._phoneSubmitText, self._phoneChange, self._phoneComplete, self._phoneInputPlaceholder)
	end)
	self._qqSubmitBtn:AddClickListener(function()
		self:_onClickSubmit(GameEnum.QQ, self._qqInput, self._qqSubmitText, self._qqChange, self._qqComplete, self._qqInputPlaceholder)
	end)
	self._toggle:AddOnValueChanged(self._toggleChange, self)
end

function ImproveInfoView:unbindEvents()
	ImproveInfoView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._phoneSubmitBtn:RemoveClickListener()
	self._qqSubmitBtn:RemoveClickListener()
	self._toggle:RemoveOnValueChanged()
end

function ImproveInfoView:onEnter()
	ImproveInfoView.super.onEnter(self)

	self._effList = {}
	self._prizeInfo = {}
	self._prizeNum = 0
	self._submitedCompleteStr = "修改成功"
	self._submitCompleteStr = "提交成功"

	local _prizeStr = ImproveInfoConfig.instance:getPrize()

	for i, v in ipairs(self._reward) do
		v.proxy = MaterialMgr.setCellByCfg(_prizeStr[i].prize, v.item)
	end

	GlobalDispatcher:addListener(PlayerAgent.PM_GetCheckInInfoRes, self._GetUserInitInfoRes, self)
	GlobalDispatcher:addListener(PlayerAgent.PM_SubmitCheckInInfoRes, self._SubmitCheckInInfoRes, self)
	GlobalDispatcher:addListener(PlayerAgent.PM_GainCheckInPrizeRes, self._GainCheckInPrizeRes, self)
	PlayerAgent.instance:sendPM_GetCheckInInfoReq()
end

function ImproveInfoView:onExit()
	ImproveInfoView.super.onExit(self)
	GlobalDispatcher:removeListener(PlayerAgent.PM_GetCheckInInfoRes, self._GetUserInitInfoRes, self)
	GlobalDispatcher:removeListener(PlayerAgent.PM_SubmitCheckInInfoRes, self._SubmitCheckInInfoRes, self)
	GlobalDispatcher:removeListener(PlayerAgent.PM_GainCheckInPrizeRes, self._GainCheckInPrizeRes, self)

	if self._selected == 1 and not self._toggle.isOn then
		PlayerAgent.instance:sendPM_SubmitCheckInInfoReq(3, "2")
	elseif self._selected == 2 and self._toggle.isOn then
		PlayerAgent.instance:sendPM_SubmitCheckInInfoReq(3, "1")
	end

	for i, v in ipairs(self._reward) do
		MaterialMgr.resetAll(v.item)

		v.canGain = nil
	end
end

function ImproveInfoView:_GetUserInitInfoRes(status, msg)
	if status ~= 0 then
		return
	end

	goutil.setActive(self._phoneComplete, msg.info.telephone ~= "0")

	if msg.info.telephone ~= "0" then
		self._phoneInputPlaceholder.text = self:_encryStr(msg.info.telephone)
		self._msgPhone = msg.info.telephone
		self._phoneSubmitText.text = lang("tip_revise")

		self._phoneChange:SetState(1)

		self._reward[1].canGain = true
	else
		self._phoneInputPlaceholder.text = lang("tip_click_write")
		self._phoneSubmitText.text = lang("tip_submit")

		self._phoneChange:SetState(0)
	end

	self._phoneInput:SetText("")
	goutil.setActive(self._qqComplete, msg.info.qq ~= "0")

	if msg.info.qq ~= "0" then
		self._qqInputPlaceholder.text = self:_encryStr(msg.info.qq)
		self._qqSubmitText.text = lang("tip_revise")

		self._qqChange:SetState(1)

		self._reward[2].canGain = true
	else
		self._qqInputPlaceholder.text = lang("tip_click_write")
		self._qqSubmitText.text = lang("tip_submit")

		self._qqChange:SetState(0)
	end

	self._qqInput:SetText("")

	self._selected = msg.info.selected
	self._toggle.isOn = self._selected == 1
	self._reward[3].canGain = self._selected == 1

	for i, v in ipairs(msg.info.gainedPrizeIds) do
		self._prizeInfo[v] = true
	end

	self:_updatePrize()
end

function ImproveInfoView:_SubmitCheckInInfoRes(status, msg)
	if status ~= 0 then
		return
	end

	if self._resType == 3 then
		if self._resToggle then
			self._toggle.isOn = true
			self._resToggle = nil
			self._reward[3].canGain = true
		end
	else
		if self._resSubmitText.text ~= lang("tip_revise") then
			self._reward[self._resType].canGain = true
			self._resSubmitText.text = lang("tip_revise")

			self._resImgChange:SetState(1)
			goutil.setActive(self._resComplete, true)
			FloatWordMgr.instance:show(self._submitCompleteStr)
		else
			FloatWordMgr.instance:show(self._submitedCompleteStr)
		end

		if self._resType == 1 then
			self._msgPhone = self._resInput:GetText()
		end

		self._resInputPlaceholder.text = self:_encryStr(self._resInput:GetText())

		self._resInput:SetText("")
	end

	self:_updatePrize()
end

function ImproveInfoView:_GainCheckInPrizeRes(status, msg)
	self._prizeInfo[self._resGainIndex] = true

	UIEffectManager.instance:stopEffect(self._effList[self._resGainIndex])
	goutil.setActive(self._reward[self._resGainIndex].received, true)
	self._reward[self._resGainIndex].proxy:setCallBack()
	self._reward[self._resGainIndex].proxy:setAutoTips(true)
end

function ImproveInfoView:_onClickSubmit(type, input, submitText, imgChange, complete, placeholder)
	self._resSubmitText = submitText
	self._resImgChange = imgChange
	self._resComplete = complete
	self._resInput = input
	self._resInputPlaceholder = placeholder
	self._resType = type == 1 and 1 or 2

	PlayerAgent.instance:sendPM_SubmitCheckInInfoReq(self._resType, input:GetText())
end

function ImproveInfoView:_updatePrize()
	local effResPath = "fx_ui_tequan/fx_ui_tequan_kuang.prefab"

	for i, v in ipairs(self._reward) do
		goutil.setActive(v.received, self._prizeInfo[i])

		if v.canGain and not self._prizeInfo[i] then
			if self._effList[i] == nil then
				self._effList[i] = UIEffectManager.instance:playEffect(self, effResPath, nil, 0, 0, true, false, nil, function(target, eff)
					eff.effGo.transform:SetParent(v.effect.transform)
					GameUtil.setAnchoredPos(eff.effGo, 0, 0)
					GameUtil.setLocalScale(eff.effGo, 1.5, 1.5, 1)
				end)
				self._effList[i].hideEffWhileNotOnTop = true
			end

			v.proxy:setAutoTips(false)
			v.proxy:setCallBack(function()
				self._resGainIndex = i

				PlayerAgent.instance:sendPM_GainCheckInPrizeReq(i)
			end)
		end
	end
end

function ImproveInfoView:_toggleChange()
	if self._selected == 0 and self._toggle.isOn then
		if self._msgPhone then
			self._resType = 3
			self._resToggle = true

			PlayerAgent.instance:sendPM_SubmitCheckInInfoReq(3, "1")
		else
			self._toggle.isOn = false

			FloatWordMgr.instance:show(lang("text_write_phone"))
		end
	end
end

function ImproveInfoView:_encryStr(str)
	local newStr = string.sub(str, string.len(str) - 3)

	return "*********" .. newStr
end

return ImproveInfoView
