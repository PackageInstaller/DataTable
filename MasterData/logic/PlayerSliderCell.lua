-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/helpdragonmom/view/PlayerSliderCell.lua

module("logic.extensions.helpdragonmom.view.PlayerSliderCell", package.seeall)

local PlayerSliderCell = class("PlayerSliderCell")

function PlayerSliderCell:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self.mainGO = go
	self._txtScore = goutil.findChildTextComponent(go, "txtScore")
	self._item = goutil.findChild(go, "item")
	self._canGet = goutil.findChild(go, "canGet")
	self._geted = goutil.findChild(go, "geted")
end

function PlayerSliderCell:getGo()
	return self.mainGO
end

function PlayerSliderCell:init(data, view, rectTrans, callbackParams)
	self._view = view
	self._rectTrans = rectTrans
	self._data = data
	self._callbackParams = callbackParams
	self._txtScore.text = self._callbackParams.parseGetProgress and self._callbackParams.parseGetProgress(data) or self._callbackParams.needScore
	self._prize = self._callbackParams.prize and self._callbackParams.prize or self._data.prize

	self:_doInit()
	self:_afterInit()
end

function PlayerSliderCell:_doInit()
	local matType, id, matNum = MaterialMgr.getMatParams(self._prize)

	MaterialMgr.resetAll(self._item)

	local proxy = MaterialMgr.setCellByCfg(self._prize, self._item)

	proxy.binder:setAutoTips(false)
	proxy.binder:setBgActive(not self._callbackParams.bHideCellBg)
	proxy:setCallBack(function()
		self:_onClickItem()
	end)
end

function PlayerSliderCell:_afterInit()
	if self._callbackParams and self._callbackParams.initCellFunc then
		self._callbackParams.initCellFunc(self._item, self._data, self._view)
	end

	self:update()
end

function PlayerSliderCell:_onClickItem()
	local rewardCfg = self._data
	local matType, id, matNum = MaterialMgr.getMatParams(self._prize)

	if self._callbackParams and self._callbackParams.isPlayerRewardCanGet(rewardCfg) then
		if self._callbackParams.getRewardTip then
			local tip = self._callbackParams.getRewardTip(rewardCfg)

			if not string.nilorempty(tip) then
				FloatWordMgr.instance:show(tip)

				return
			end
		end

		self._callbackParams.sendGainPlayerPrizeReq(rewardCfg)
	elseif not goutil.isNil(self._item) then
		CommonTipsMgr.instance:openMaterialTips(self._item, matType, id, 0)
	end
end

function PlayerSliderCell:update()
	local rewardCfg = self._data
	local isGeted = self._callbackParams.isPlayerRewardGeted(rewardCfg)
	local isCanGet = self._callbackParams.isPlayerRewardCanGet(rewardCfg)

	goutil.setActive(self._canGet, isCanGet)
	goutil.setActive(self._geted, isGeted)

	if isCanGet then
		self:_playEffect()
	else
		self:_clearEffect()
	end

	if self._callbackParams and self._callbackParams.updateCellFunc then
		self._callbackParams.updateCellFunc(self._item, self._data, self._view)
	end

	return isGeted, isCanGet
end

function PlayerSliderCell:getRewardState()
	local isGeted = self._callbackParams.isPlayerRewardGeted(self._data)
	local isCanGet = self._callbackParams.isPlayerRewardCanGet(self._data)

	return isGeted, isCanGet
end

function PlayerSliderCell:getNormalizedPos()
	return self._callbackParams.normalizedPos
end

function PlayerSliderCell:clear()
	MaterialMgr.resetAll(self._item)
end

function PlayerSliderCell:_playEffect()
	self:_clearEffect()

	if not self._callbackParams.effPath then
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
		local uiEffect = UIEffectManager.instance:playEffect(self._view, effPath, self._canGet.transform, 0, 0, true, false, nil, function(target, eff)
			if not goutil.isNil(self._rectTrans) then
				eff:setClipping(self._rectTrans)
			end
		end)

		uiEffect:setParent(self._canGet.transform)
		uiEffect:setLocalPos(0, 0, 0)
		uiEffect:setScale(1)

		self._uiEffect = uiEffect
	end
end

function PlayerSliderCell:_clearEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

return PlayerSliderCell
