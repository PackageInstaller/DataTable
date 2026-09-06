-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonFindEnergyPopView.lua

module("logic.extensions.season.view.SeasonFindEnergyPopView", package.seeall)

local SeasonFindEnergyPopView = class("SeasonFindEnergyPopView", ViewComponent)

function SeasonFindEnergyPopView:ctor()
	SeasonFindEnergyPopView.super.ctor(self)
end

function SeasonFindEnergyPopView:unbindEvents()
	SeasonFindEnergyPopView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
end

function SeasonFindEnergyPopView:bindEvents()
	SeasonFindEnergyPopView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnBuy:AddClickListener(self._onClickBuy, self)
end

function SeasonFindEnergyPopView:buildUI()
	SeasonFindEnergyPopView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnBuy = self:getBtn("btnBuy")
	self._goTxtDesc = self:getGo("btnBuy/txtDesc")
	self._goTxtDesc_1 = self:getGo("btnBuy/txtDesc_1")
	self._payIcon = self:getGo("btnBuy/txtDesc/payIcon")
	self._txtDesc = self:getTxt("btnBuy/txtDesc")
	self._txtDesc_1 = self:getTxt("btnBuy/txtDesc_1")
	self._txtProgress = self:getTxt("txtProgress")
	self._txtTips = self:getTxt("txtDesc")
	self._slider = self:getSlider("energyProgress")

	self._slider:SetValue(0)
end

function SeasonFindEnergyPopView:onExit()
	SeasonFindEnergyPopView.super.onExit(self)
end

function SeasonFindEnergyPopView:onEnter()
	SeasonFindEnergyPopView.super.onEnter(self)

	local params = self:getOpenParam()

	if params == nil then
		self:close()

		return
	end

	data = params[1]
	self._viewData = data
	self._txtTips.text = "有参与本活动玩家,未登录游戏,每日任务全部能量可按天找回,最多累计" .. data.maxFindDay .. "天"

	self:_setBuyBtnTips(data.canFindDay > 0)

	if data.canFindDay > 0 then
		self._txtProgress.text = data.nowEnergy .. "/" .. data.maxEnergy

		self._slider:SetValue(checknumber(data.nowEnergy) / checknumber(data.maxEnergy))
		MaterialMgr.updateItemByStr(self._payIcon, data.findCost, self._txtDesc)
	else
		self._txtProgress.text = "0/" .. data.maxEnergy

		self._slider:SetValue(0)
	end
end

function SeasonFindEnergyPopView:_setBuyBtnTips(canFind)
	goutil.setActive(self._goTxtDesc, canFind)
	goutil.setActive(self._goTxtDesc_1, not canFind)
end

function SeasonFindEnergyPopView:_onClickBuy()
	if self._viewData then
		if self._viewData.canFindDay > 0 then
			local costCfg = self._viewData.findCost
			local haveCount = MaterialMgr.getMatCount(costCfg)
			local _, _, needCount = MaterialMgr.getMatParams(costCfg)

			if haveCount < needCount then
				local tips = "所需" .. MaterialMgr.getMaterialsNameByCfg(costCfg) .. "不足！"

				FloatWordMgr.instance:show(tips)
			else
				SeasonModeWarOrderController.instance:sendSeasonFindEnergy(self._viewData)
			end
		else
			TipsFacade.instance:openCommonTips("无需找回")
		end
	end

	self:close()
end

function SeasonFindEnergyPopView:_onClickClose()
	self:close()
end

return SeasonFindEnergyPopView
