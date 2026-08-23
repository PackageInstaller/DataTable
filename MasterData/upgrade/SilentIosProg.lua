local UpgradeConst = require("upgrade.UpgradeConst")
local SilentIosProg = class("SilentIosProg", require("app.fairyGUI.upgrade.UI_SilentIosProg"))

function SilentIosProg:ctor()
	self.m_prog:setMax(100)
	self.m_prog:setValue(0)
	self.m_proTxt:setText("0%")
end

function SilentIosProg:onLoad()
	self:newSchedule(handler(self, self._showTextRun), 0.5)
end

function SilentIosProg:updateFuncCallBack(arg_3_1, arg_3_2)
	if tolua.isnull(self) then
		return
	end

	if arg_3_1 == UpgradeConst.EN_UI_SILENT.START then
		self:_onUpgradeUIStart(arg_3_2)
	elseif arg_3_1 == UpgradeConst.EN_UI_SILENT.ERROR then
		self:_onUpgradeUIError(arg_3_2)
	elseif arg_3_1 == UpgradeConst.EN_UI_SILENT.PROGRESS then
		self:_onUpgradeUIProgress(arg_3_2)
	elseif arg_3_1 == UpgradeConst.EN_UI_SILENT.FINISHED then
		self:_onUpgradeUIFinish()
	elseif arg_3_1 == UpgradeConst.EN_UI_SILENT.UNZIP_START then
		self:_onUpgradeUIUnzip()
		self:_onUnzipProgress(false, arg_3_2)
	elseif arg_3_1 == UpgradeConst.EN_UI_SILENT.UNZIP_OK then
		self:_onUnzipProgress(true)
	end
end

function SilentIosProg:_onUpgradeUIStart(arg_4_1)
	return
end

function SilentIosProg:_onUpgradeUIError(arg_5_1)
	return
end

function SilentIosProg:_onUpgradeUIProgress(arg_6_1)
	local var_6_0, var_6_1

	if arg_6_1 then
		var_6_0 = arg_6_1.total or 1

		if arg_6_1 then
			var_6_1 = arg_6_1.finish or 0
		end
	end

	local var_6_2 = 0

	if var_6_0 > 1 then
		var_6_2 = var_6_1 * 100 / var_6_0
	end

	self.m_prog:setValue(var_6_2)
	self.m_proTxt:setText(math.ceil(var_6_2) .. "%")
end

function SilentIosProg:_onUpgradeUIFinish(arg_7_1)
	self:setVisible(false)
end

function SilentIosProg:_onUpgradeUIUnzip(arg_8_1)
	return
end

function SilentIosProg:_onUnzipProgress(arg_9_1, arg_9_2)
	return
end

function SilentIosProg:_showTextRun()
	self._index = self._index or 0

	local var_10_0 = g.core.lang:get(100015)

	self._index = self._index % 4

	for iter_10_0 = 1, self._index do
		var_10_0 = var_10_0 .. "."
	end

	self._index = self._index + 1

	self.m_tipsTxt:setText(var_10_0)
end

return SilentIosProg
