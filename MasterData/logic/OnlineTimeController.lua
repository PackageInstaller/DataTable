-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/onlinetime/controller/OnlineTimeController.lua

module("logic.extensions.onlinetime.controller.OnlineTimeController", package.seeall)

local OnlineTimeController = class("OnlineTimeController", BaseController)

function OnlineTimeController:onInit()
	self.timeIndex = 0

	self:onReset()
end

function OnlineTimeController:onReset()
	removetimer(self.updateTime, self)

	self.timeIndex = 0
	self.isInitHud = false
end

function OnlineTimeController:sendGetInfo()
	OnlineTimeAgent.instance:sendOnlineTimePrizeInfoReq(self._onOnlineTimePrizeInfoRes, self)
end

function OnlineTimeController:initHud(go)
	if go ~= nil then
		self._btnHud = Framework.ButtonAdapter.Get(go)

		self._btnHud:AddClickListener(self._onClickBtn, self)

		self.txtTime = goutil.findChildTextComponent(go, "TxtC_Time")
		self.imgIcon = goutil.findChildImageComponent(go, "ImgC_Icon")
		self._Animator = self.imgIcon.gameObject:GetComponent("Animator")
		self.txtTime.text = ""
		self.isInitHud = true
	else
		self.isInitHud = false
	end
end

function OnlineTimeController:updateTime()
	if self.isInitData then
		OnlineTimeModel.instance:addTime()

		self.timeIndex = self.timeIndex + 1

		if self.timeIndex % 5 == 0 then
			OnlineTimeModel.instance:refreshItemStatus()
		end
	end
end

function OnlineTimeController:checkCanGet()
	if OnlineTimeModel.instance:checkHasGift() and self.isInitHud then
		self:playAni()
	end
end

function OnlineTimeController:playAni()
	if self.imgIcon then
		self:IconRotation(0, 20, function()
			self:IconRotation(0, 0, function()
				self:IconRotation(0, -20, function()
					self:IconRotation(0, 0, function()
						self:IconScale(0, 0.1, 0.08, function()
							self:IconScale(0.1, 0, 0.08, function()
								self:IconMove(0, 50, 0.2, function()
									self:IconMove(50, 0, 0.05, function()
										return
									end)
								end)
							end)
						end)
					end)
				end)
			end)
		end)
	end
end

function OnlineTimeController:IconRotation(from, to, callBack)
	TweenUtil.ValueTo(from, to, 0.08, function(n)
		Framework.TransformUtil.SetLocalRotation(self.imgIcon.transform, 0, 0, n)
	end, function()
		if callBack ~= nil then
			callBack()
		end
	end, self)
end

function OnlineTimeController:IconScale(from, to, time, callBack)
	TweenUtil.ValueTo(from, to, time, function(num)
		GameUtil.setLocalScale(self.imgIcon.gameObject, 1 + num, 1 - num * 5, 1)
	end, function()
		if callBack ~= nil then
			callBack()
		end
	end, self)
end

function OnlineTimeController:IconMove(from, to, time, callBack)
	TweenUtil.ValueTo(from, to, time, function(n)
		local newPos = Vector3.New(0, n, 0)

		uGuiUtil.setLocalPosition(self.imgIcon.gameObject, newPos)
	end, function()
		if callBack ~= nil then
			callBack()
		end
	end, self)
end

function OnlineTimeController:_onOnlineTimePrizeInfoRes(msg)
	OnlineTimeModel.instance:initData(msg)

	self.isInitData = true

	settimer(1, self.updateTime, self)
end

function OnlineTimeController:refreshUI()
	if self.isInitHud then
		if OnlineTimeModel.instance:checkGiftAllget() then
			self.txtTime.text = ""

			removetimer(self.updateTime, self)
		else
			local time = OnlineTimeModel.instance:getTime()

			if OnlineTimeModel.instance:checkHasGift() then
				local min = OnlineTimeConfig.GIFT_TIME_ARR[OnlineTimeModel.instance:getGiftIdx()]

				self.txtTime.text = string.format(lang("%s分钟奖励"), min)
			else
				local hour, min, sec = GameUtil.getTimeHHMMSS(time)

				self.txtTime.text = string.format("%02d:%02d:%02d", hour, min, sec)
			end
		end
	end
end

function OnlineTimeController:_onClickBtn()
	BonusController.instance:openBonusView(ViewName.onlinetime)
end

function OnlineTimeController:getPrize(idx)
	local rq = PrizePublicDef_pb.PM_GainPrizeReq()

	OnlineTimeAgent.instance:sendOnlineTimePrizeReq(idx - 1, rq, function()
		OnlineTimeModel.instance:setGiftIdx(idx)
		OnlineTimeModel.instance:refreshItemStatus()
		self:updateTime()
	end)
end

OnlineTimeController.instance = OnlineTimeController.New()

return OnlineTimeController
