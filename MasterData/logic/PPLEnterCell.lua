-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/maintainpowerpilla/view/PPLEnterCell.lua

module("logic.extensions.maintainpowerpilla.view.PPLEnterCell", package.seeall)

local PPLEnterCell = class("PPLEnterCell")

function PPLEnterCell:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self.mainGO = go
	self._txtScore = goutil.findChildTextComponent(go, "txtScore")
	self._item = goutil.findChild(go, "item")
	self._canGet = goutil.findChild(go, "canGet")
	self._geted = goutil.findChild(go, "geted")
end

function PPLEnterCell:getGo()
	return self.mainGO
end

function PPLEnterCell:init(data, view, rectTrans)
	self._view = view
	self._rectTrans = rectTrans
	self._data = data
	self._txtScore.text = data.stageName

	local matType, id, matNum = MaterialMgr.getMatParams(data.prize)

	MaterialMgr.resetAll(self._item)

	local proxy = MaterialMgr.setCellByCfg(data.prize, self._item)

	proxy.binder:setAutoTips(false)
	proxy:setCallBack(function()
		if PowerPillaModel.instance:isRewardCanGet(data.stage) then
			MaintainPowerPillaAgent.instance:sendPM_MPPGainStagePrizeReq(PowerPillaModel.instance:getActivityId(), data.stage)
		elseif not goutil.isNil(self._item) then
			CommonTipsMgr.instance:openMaterialTips(self._item, matType, id, 0)
		end
	end)
	self:update()
end

function PPLEnterCell:update()
	local isGeted = PowerPillaModel.instance:isRewardGeted(self._data.stage)
	local isCanGet = PowerPillaModel.instance:isRewardCanGet(self._data.stage)

	goutil.setActive(self._canGet, isCanGet)
	goutil.setActive(self._geted, isGeted)

	if isCanGet then
		self:_playEffect()
	else
		self:_clearEffect()
	end
end

function PPLEnterCell:clear()
	MaterialMgr.resetAll(self._item)
end

function PPLEnterCell:_playEffect()
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

function PPLEnterCell:_clearEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

return PPLEnterCell
