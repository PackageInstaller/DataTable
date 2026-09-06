-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckyskinlottery/view/RewardSliderCell.lua

module("logic.extensions.luckyskinlottery.view.RewardSliderCell", package.seeall)

local RewardSliderCell = class("RewardSliderCell", WorldSliderCell)

function RewardSliderCell:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self.mainGO = go
	self._item = goutil.findChild(go, "item")
	self._canGet = goutil.findChild(go, "canGet")
	self._geted = goutil.findChild(go, "geted")
	self._txtRate = goutil.findChildTextComponent(go, "txtRate")
end

function RewardSliderCell:init(data, view, rectTrans, callbackParams, isSkin)
	self._view = view
	self._rectTrans = rectTrans
	self._data = data
	self._callbackParams = callbackParams
	self._isSkin = isSkin
	self._txtRate.text = string.format("%s%%", callbackParams.rate)

	local matType, id, matNum = MaterialMgr.getMatParams(data.prize or callbackParams.prize)

	MaterialMgr.resetAll(self._item)

	local proxy = MaterialMgr.setCellByCfg(data.prize or callbackParams.prize, self._item)

	proxy.binder:setAutoTips(false)
	proxy:setCallBack(function()
		local rewardCfg = self._data

		if self._callbackParams and self._callbackParams.isWorldRewardCanGet(rewardCfg) then
			self._callbackParams.sendGainWorldPrizeReq(rewardCfg)
		elseif not goutil.isNil(self._item) then
			CommonTipsMgr.instance:openMaterialTips(self._item, matType, id, 0)
		end
	end)
	self:update()
end

function RewardSliderCell:update()
	local rewardCfg = self._data
	local isGeted = self._callbackParams.isWorldRewardGeted(rewardCfg)
	local isCanGet = self._callbackParams.isWorldRewardCanGet(rewardCfg)

	goutil.setActive(self._canGet, isCanGet)
	goutil.setActive(self._geted, isGeted)

	if isCanGet then
		self:_playEffect()
	else
		self:_clearEffect()
	end

	if isGeted and self._isSkin then
		self._txtRate.text = "未抽中"
	end
end

return RewardSliderCell
