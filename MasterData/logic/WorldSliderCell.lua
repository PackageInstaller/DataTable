-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/helpdragonmom/view/WorldSliderCell.lua

module("logic.extensions.helpdragonmom.view.WorldSliderCell", package.seeall)

local WorldSliderCell = class("WorldSliderCell")

function WorldSliderCell:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self.mainGO = go
	self._txtScore = goutil.findChildTextComponent(go, "txtScore")
	self._item = goutil.findChild(go, "item")
	self._canGet = goutil.findChild(go, "canGet")
	self._geted = goutil.findChild(go, "geted")
end

function WorldSliderCell:getGo()
	return self.mainGO
end

function WorldSliderCell:init(data, view, rectTrans, callbackParams)
	self._view = view
	self._rectTrans = rectTrans
	self._data = data
	self._callbackParams = callbackParams
	self._txtScore.text = callbackParams.progressTxt or callbackParams.progress

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

function WorldSliderCell:update()
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
end

function WorldSliderCell:getRewardState()
	local isGeted = self._callbackParams.isWorldRewardGeted(self._data)
	local isCanGet = self._callbackParams.isWorldRewardCanGet(self._data)

	return isGeted, isCanGet
end

function WorldSliderCell:getNormalizedPos()
	return self._callbackParams.normalizedPos
end

function WorldSliderCell:clear()
	MaterialMgr.resetAll(self._item)
end

function WorldSliderCell:_playEffect()
	self:_clearEffect()

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

function WorldSliderCell:_clearEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

return WorldSliderCell
