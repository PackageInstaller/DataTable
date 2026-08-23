local var_0_0 = g.core.config.download_pic_info
local var_0_1 = g.core.const.ConstMgr.WaitGameConst
local SilentAutoChangeBgComp = class("SilentAutoChangeBgComp", require("app.fairyGUI.upgrade.UI_SilentAutoChangeBgComp"))

function SilentAutoChangeBgComp:ctor()
	self._bgPathArray = {}
	self._delayTime = 0
	self._showIndex = 1

	if g.core.utils.Rule.isSpecialChannelWaitGameBg() then
		self:initSpecialChannelBg()
	else
		self:initBgArray()
	end
end

function SilentAutoChangeBgComp:initBgArray()
	for iter_2_0 = 1, var_0_0.getLength() do
		local var_2_0 = var_0_0.indexOf(iter_2_0)

		if var_2_0.res > 0 then
			table.insert(self._bgPathArray, (table.concat({
				"bg/upgrade/autoChange/",
				var_2_0.res,
				".jpg"
			})))
		end
	end

	self.m_bgLoader:setURL(self._bgPathArray[self._showIndex])
end

function SilentAutoChangeBgComp:initSpecialChannelBg()
	for iter_3_0 = 1, var_0_0.getLength() do
		local var_3_0 = var_0_0.indexOf(iter_3_0)

		if var_3_0.res ~= 1 then
			if var_3_0.res == 3 then
				table.insert(self._bgPathArray, (table.concat({
					"bg/upgrade/autoChange/",
					var_3_0.res,
					".jpg"
				})))
			end
		end
	end

	self.m_bgLoader:setURL(self._bgPathArray[self._showIndex])
end

function SilentAutoChangeBgComp:onLoad()
	self:newSchedule(handler(self, self._autoChangeBg), 1)
end

function SilentAutoChangeBgComp:_autoChangeBg()
	self._delayTime = self._delayTime + 1

	if self._delayTime > var_0_1.DELAY_CHANGE_BG_TIME then
		self._showIndex = self._showIndex + 1

		if self._showIndex > #self._bgPathArray then
			self._showIndex = 1
		end

		self._delayTime = 0
	end

	self.m_bgLoader:setURL(self._bgPathArray[self._showIndex])
end

function SilentAutoChangeBgComp:updatePreBg()
	self._delayTime = 0
	self._showIndex = self._showIndex - 1

	if self._showIndex <= 0 then
		self._showIndex = #self._bgPathArray
	end

	self.m_bgLoader:setURL(self._bgPathArray[self._showIndex])
end

function SilentAutoChangeBgComp:updateNextBg()
	self._delayTime = 0
	self._showIndex = self._showIndex + 1

	if self._showIndex > #self._bgPathArray then
		self._showIndex = 1
	end

	self.m_bgLoader:setURL(self._bgPathArray[self._showIndex])
end

function SilentAutoChangeBgComp:onUnload()
	self:cancelAllSchedule()
end

return SilentAutoChangeBgComp
