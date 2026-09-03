-- chunkname: @/tmp/or_script/lua_compile/dm/launch/login/view/LoginQueueMediator.lua

LoginQueueMediator = class("LoginQueueMediator", DmPopupViewMediator, _M)

LoginQueueMediator:has("_loginSystem", {
	is = "r"
}):injectWith("LoginSystem")

local kBtnHandlers = {}

function LoginQueueMediator:initialize()
	super.initialize(self)
end

function LoginQueueMediator:dispose()
	super.dispose(self)
end

function LoginQueueMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_LOGIN_SUCC, self, self.close)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_LOGIN_ONQUEUE, self, self.refreshView)
end

function LoginQueueMediator:enterWithData(data)
	self:setupView()
	self:initData(data)
	self:initView()
end

function LoginQueueMediator:refreshView(event)
	local data = event:getData()

	self:initData(data)

	if not self._init then
		return
	end

	self:initView()
end

function LoginQueueMediator:setupView()
	self._mainPanel = self:getView():getChildByName("main")

	local cancelBtn = bindWidget(self, "main.btn_cancel", OneLevelViceButton, {
		handler = function()
			self:onClickCancel()
		end
	})

	self._queueInfo1 = self._mainPanel:getChildByFullName("image.Text_2")
	self._queueInfo2 = self._mainPanel:getChildByFullName("image.Text_4")
	self._queueInfo3 = self._mainPanel:getChildByFullName("image.Text_3")
end

function LoginQueueMediator:initData(data)
	if data and data.data then
		data = data.data
	end

	self._data = data
end

function LoginQueueMediator:initView()
	if not self._data then
		return
	end

	if not self._data.size then
		local curQueueLen = 2

		if not self._data.pos then
			local curQueuePos = 2

			if not self._data.sec then
				local needSecond = 10
				local time = ""

				if needSecond > 1800 then
					time = Strings:get("LOGIN_QUEUE_UI5")
				else
					local timeStr = TimeUtil:formatTime("${d}:${HH}:${MM}:${SS}", needSecond)
					local parts = string.split(timeStr, ":", nil, true)
					local timeTab = {}

					timeTab.day = tonumber(parts[1])
					timeTab.hour = tonumber(parts[2])
					timeTab.min = tonumber(parts[3])
					timeTab.sec = tonumber(parts[4])

					if timeTab.day > 0 then
						time = timeTab.day .. Strings:get("TimeUtil_Day") .. timeTab.hour .. Strings:get("TimeUtil_Hour")
					elseif timeTab.hour > 0 then
						time = timeTab.hour .. Strings:get("TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min")
					elseif timeTab.min > 0 then
						if timeTab.sec > 10 then
							timeTab.min = timeTab.min + 1
						end

						time = timeTab.min .. Strings:get("TimeUtil_Min")
					else
						time = timeTab.sec .. Strings:get("TimeUtil_Sec")
					end
				end

				local info1 = Strings:get("LOGIN_QUEUE_UI2", {
					num1 = curQueuePos - 1
				})
				local info2 = Strings:get("LOGIN_QUEUE_UI7", {
					num2 = curQueueLen
				})
				local info3 = Strings:get("LOGIN_QUEUE_UI3", {
					time = time
				})

				self._queueInfo1:setString(info1)
				self._queueInfo2:setString(info2)
				self._queueInfo3:setString(info3)

				self._init = true
			end
		end
	end
end

function LoginQueueMediator:onClickCancel()
	if self._cancel then
		return
	end

	self._cancel = true

	self:dispatch(Event:new(EVT_LOGIN_CANCEL_QUEUE))
	self:close()
end

function LoginQueueMediator:onTouchMaskLayer()
	AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
	self:dispatch(ShowTipEvent({
		tip = Strings:get("LOGIN_QUEUE_UI6")
	}))
end
