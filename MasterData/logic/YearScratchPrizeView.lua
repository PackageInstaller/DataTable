-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearscratch/view/YearScratchPrizeView.lua

module("logic.extensions.yearscratch.view.YearScratchprizeView", package.seeall)

local YearScratchprizeView = class("YearScratchprizeView", ViewComponent)

function YearScratchprizeView:ctor()
	YearScratchprizeView.super.ctor(self)
end

function YearScratchprizeView:unbindEvents()
	YearScratchprizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGain)
	GameUtil.rmClickHandler(self._btnClose)
end

function YearScratchprizeView:bindEvents()
	YearScratchprizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGain, self._onClickGain, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function YearScratchprizeView:buildUI()
	YearScratchprizeView.super.buildUI(self)

	self._btnGain = self:getGo("btnGain")
	self._txtNum = self:getTxt("txtNum")
	self._btnClose = self:getGo("btnClose")
end

function YearScratchprizeView:onExit()
	YearScratchprizeView.super.onExit(self)
end

function YearScratchprizeView:onEnter()
	YearScratchprizeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.YearScratchGainPrize, self.close, self)

	self._activityId = self:getFirstParam()
	self._actCfg = YearScratchConfig.instance:getActivityCfg(self._activityId)

	local isOpenGainPrize = ServerTime.now() >= GameUtil.string2time(self._actCfg.gainGodGemTime)
	local var_6_0 = YearScratchModel.instance:isGainPrize()

	if var_6_0 and isOpenGainPrize then
		::label_6_0::

		var_6_0 = not YearScratchModel.instance:isHadGainGem()

		local isCanGain = var_6_0

		GameUtil.SetGray(self._btnGain, not isCanGain)

		local godGemCfg = YearScratchConfig.instance:getGodGemCfg(self._activityId)
		local index = 1

		for i = 1, #godGemCfg do
			if YearScratchModel.instance:getSpaceScratchNum() >= godGemCfg[i].section[1] then
				index = i
			end
		end

		local matType, matId, matNum = MaterialMgr.getMatParams(godGemCfg[index].prize)

		self._txtNum.text = langPara("X%d", matNum)
	end
end

function YearScratchprizeView:_onClickGain()
	local isOpenGainPrize = ServerTime.now() >= GameUtil.string2time(self._actCfg.gainGodGemTime)
	local var_7_0 = YearScratchModel.instance:isGainPrize()

	if var_7_0 and isOpenGainPrize then
		::label_7_0::

		var_7_0 = not YearScratchModel.instance:isHadGainGem()

		local isCanGain = var_7_0

		if isCanGain == true then
			YearScratchAgent.instance:sendPM_YearScratchGainGodGemReq(self._activityId)
		elseif not isOpenGainPrize then
			FloatWordMgr.instance:show(lang("未到解锁时间"))
		elseif not YearScratchModel.instance:isGainPrize() then
			FloatWordMgr.instance:show(lang("不满足参与条件"))
		elseif YearScratchModel.instance:isHadGainGem() then
			FloatWordMgr.instance:show(lang("已领取"))
		end
	end
end

return YearScratchprizeView
