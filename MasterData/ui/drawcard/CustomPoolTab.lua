-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\CustomPoolTab.lua

local ResDrawPoolClient = require("ClientData/ResDrawPoolClient")
local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local strClassName = "CustomPoolTab"
local CustomPoolTab = Class(strClassName, UIControls.Panel)

function CustomPoolTab:ctor(...)
	self:initUI()
end

function CustomPoolTab:initUI(...)
	self.nameTxt = UIControls.Label(self, self.mPath .. "/Text")
	self.heroImg = UIControls.Image(self, self.mPath .. "/Mask/ImgHero")
	self.timePanel = UIControls.Panel(self, self.mPath .. "/EndTime")
	self.timeTxt = UIControls.Label(self, self.mPath .. "/EndTime/Text")
	self.reddot = UIControls.RedDot(self, self.mPath .. "/IconNew")
	self.rootBtn = UIControls.Button(self, self.mPath)

	self.rootBtn:addEventClick(self._onRootBtnClick)

	self.lockImg = UIControls.Image(self, self.mPath .. "/ImgLock")
end

function CustomPoolTab:setCustomPoolInfo(poolId, actObj)
	self.poolId = poolId

	local poolInfo = DrawCardUtils.getPoolClientInfo(poolId)

	if poolInfo then
		self.nameTxt:setText(poolInfo.title)

		local tabImgStr = poolInfo.tabBg

		if tabImgStr then
			local path = utils.splitString(tabImgStr, ";")

			if path and #path == 2 then
				self.heroImg:setImage(path[1], path[2])
			end
		end
	end

	if not actObj then
		return
	end

	if actObj:isValid() then
		local reddotEvent = actObj.redDotId

		self.reddot:addHint({
			reddotEvent
		})

		local remainOpenTime = actObj:getRemainOpenTime()

		if remainOpenTime <= Const.TIME_ONE_DAY then
			self.timePanel:setVisible(true)
			ClientTimerManager.AddSecondFormatTickUI(self.timeTxt, remainOpenTime, false, Lang.get(48659))
		else
			self.timePanel:setVisible(false)
		end

		self:setObjGray(false)
		self.lockImg:setVisible(false)
	else
		self:setObjGray(true)
		self.lockImg:setVisible(true)
	end

	self.actObj = actObj
end

function CustomPoolTab:setEnable(enable)
	self.rootBtn:setEnable(enable)
end

function CustomPoolTab:addEventClick(func)
	self.selectCallback = func
end

function CustomPoolTab:_onRootBtnClick()
	if not self.selectCallback or not self.actObj then
		return
	end

	local isValid, desc = self.actObj:isValid()

	if isValid then
		self.selectCallback()
	else
		MsgManager.notice(desc)
	end
end

return CustomPoolTab
