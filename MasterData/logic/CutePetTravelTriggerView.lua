-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/travel/CutePetTravelTriggerView.lua

module("logic.extensions.cutepet.view.CutePetTravelTriggerView", package.seeall)

local CutePetTravelTriggerView = class("CutePetTravelTriggerView", BossTriggerView)

function CutePetTravelTriggerView:onEnter()
	local params = self:getOpenParam()

	if not params[1] then
		self._tipsStr = params[1].tipsStr or ""
		self._callBack = params[1].callBack
		self._txtBossTip.text = self._tipsStr

		local effPath = "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab"

		self.pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

		self.pmEff:setParent(self.mainGO.transform)
		self.pmEff:setLocalPos(0, 0, 0)
		self.pmEff:setScale(1)

		self.isCanClose = false

		settimer(1, self.CalculationSurplusTime, self)
	end
end

function CutePetTravelTriggerView:CalculationSurplusTime()
	self.isCanClose = true

	GameUtil.SetActive(self.textTipsGo, true)
	self:_onClickBtnClose()
end

return CutePetTravelTriggerView
