-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityZeroDiceStepMediator.lua

ActivityZeroDiceStepMediator = class("ActivityZeroDiceStepMediator", DmPopupViewMediator, _M)

ActivityZeroDiceStepMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	["main.closeBack"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickBack"
	}
}

function ActivityZeroDiceStepMediator:initialize()
	super.initialize(self)
end

function ActivityZeroDiceStepMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_ZREO_RANDOM, self, self.showRandomAnim)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_ZREO_FIXED, self, self.showFixedAnim)
end

function ActivityZeroDiceStepMediator:dispose()
	super.dispose(self)
end

function ActivityZeroDiceStepMediator:enterWithData(data)
	self:initData(data)
	self:setupView()
end

function ActivityZeroDiceStepMediator:initData(data)
	self.type = data.type
	self.callback = data.callback
	self.request = data.request
	self.isRequest = false
end

function ActivityZeroDiceStepMediator:resumeWithData()
	self:initData()
	self._tableView:reloadData()
end

local tagBtn = 1000

function ActivityZeroDiceStepMediator:setupView()
	self._main = self:getView():getChildByFullName("main")
	self._bg = self._main:getChildByFullName("bg")
	self._selectStep = self._main:getChildByFullName("selectStep")
	self._closeBack = self._main:getChildByFullName("closeBack")
	self._Pointer = self._main:getChildByFullName("Pointer")
	self._selectStepNum = self._selectStep:getChildByFullName("selectStepNum")

	self._selectStep:setVisible(false)

	if self.type == ActivityZeroDiceType.KFixed then
		self._bg:loadTexture("asset/ui/activity/hd_cl_bs_bg_2.png", 0)
		self._Pointer:loadTexture("hd_cl_bs_zz_2.png", 1)
	else
		self._bg:loadTexture("asset/ui/activity/hd_cl_bs_bg_1.png", 0)
		self._Pointer:loadTexture("hd_cl_bs_zz_1.png", 1)
	end

	for i = 1, 7 do
		local stepBtn = self._main:getChildByFullName("stepBtn_" .. i)

		stepBtn:setTag(tagBtn + i)

		local function callFunc(sender)
			if self.isRequest then
				return
			end

			local step = tonumber(sender:getTag()) - tagBtn

			if self.type == ActivityZeroDiceType.KFixed and step < 7 then
				self:sendRequest(step)
			elseif self.type == ActivityZeroDiceType.KRandom and step == 7 then
				self:sendRequest()
			end
		end

		mapButtonHandlerClick(nil, stepBtn, {
			clickAudio = "Se_Click_Select_1",
			func = callFunc
		})
	end

	self:setSelectStepNum(6, true)
end

function ActivityZeroDiceStepMediator:sendRequest(step)
	self.isRequest = true

	self.request(step)
end

function ActivityZeroDiceStepMediator:showFixedAnim(event)
	local data = event:getData().response

	if not data.point then
		return
	end

	self:setSelectStepNum(tonumber(data.point))
	performWithDelay(self:getView(), function()
		if self.callback then
			self.callback(data)
			self:onClickBack()
		end
	end, 1)
end

function ActivityZeroDiceStepMediator:showRandomAnim(event)
	local data = event:getData().response

	if not data.point then
		return
	end

	local point = data.point
	local roundCountMin = 8
	local roundCountMax = 14
	local roundCount = math.random(roundCountMin, roundCountMax)
	local angleTotal = 360 * roundCount + point * 60

	if point == 1 then
		angleTotal = angleTotal + 2
	elseif point == 5 then
		angleTotal = angleTotal - 2
	end

	self._Pointer:setRotation(0)
	self._Pointer:runAction(cc.Sequence:create(cc.EaseExponentialInOut:create(cc.RotateBy:create(5, angleTotal)), cc.CallFunc:create(function()
		self:setSelectStepNum(tonumber(data.point))
		performWithDelay(self:getView(), function()
			if self.callback then
				self.callback(data)
				self:onClickBack()
			end
		end, 1)
	end)))
end

function ActivityZeroDiceStepMediator:setSelectStepNum(num, isInit)
	local angle = num * 60

	self._selectStep:setVisible(not isInit)
	self._selectStep:setRotation(angle)
	self._Pointer:setRotation(angle)

	local curImg = self._selectStepNum:getChildByTag(10000)

	if curImg then
		curImg:removeFromParent()
	end

	local _img = ccui.ImageView:create("sz_" .. num .. ".png", ccui.TextureResType.plistType)

	_img:setTag(10000)
	_img:addTo(self._selectStepNum):center(self._selectStepNum:getContentSize())
end

function ActivityZeroDiceStepMediator:refreshData()
	return
end

function ActivityZeroDiceStepMediator:refreshView(hasAnim)
	return
end

function ActivityZeroDiceStepMediator:updateView()
	self:refreshData()
end

function ActivityZeroDiceStepMediator:onClickBack(sender, eventType)
	if sender and self.isRequest then
		return
	end

	self:close()
end
