-- chunkname: @modules/logic/versionactivity1_4/dailyallowance/DailyAllowanceView.lua

module("modules.logic.versionactivity1_4.dailyallowance.DailyAllowanceView", package.seeall)

local DailyAllowanceView = class("DailyAllowanceView", BaseView)

function DailyAllowanceView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagePresent = gohelper.findChildSingleImage(self.viewGO, "#simage_Present")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "LimitTime/#txt_LimitTime")
	self._txtDescr = gohelper.findChildText(self.viewGO, "#txt_Descr")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DailyAllowanceView:addEvents()
	return
end

function DailyAllowanceView:removeEvents()
	return
end

function DailyAllowanceView:_editableInitView()
	self._simageFullBG:LoadImage(ResUrl.getV1Aa4DailyAllowanceIcon("v1a4_gold_fullbg"))
	self._simagePresent:LoadImage(ResUrl.getV1Aa4DailyAllowanceIcon("v1a4_gold_present"))
end

function DailyAllowanceView:onUpdateParam()
	self:_refreshUI()
end

function DailyAllowanceView:onOpen()
	self._actId = self.viewParam.actId

	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)
	self:_refreshUI()
end

function DailyAllowanceView:_refreshUI()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self._actId]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()
	local day = Mathf.Floor(offsetSecond / TimeUtil.OneDaySecond)
	local hourSecond = offsetSecond % TimeUtil.OneDaySecond
	local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)
	local remainTime = day .. luaLang("time_day") .. hour .. luaLang("time_hour2")

	self._txtLimitTime.text = string.format(luaLang("remain"), remainTime)
end

function DailyAllowanceView:onClose()
	return
end

function DailyAllowanceView:onDestroyView()
	self._simageFullBG:UnLoadImage()
	self._simagePresent:UnLoadImage()
end

return DailyAllowanceView
