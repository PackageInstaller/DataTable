-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/solicitwealth/view/SolicitwealthgetView.lua

module("logic.extensions.solicitwealth.view.SolicitwealthgetView", package.seeall)

local SolicitwealthgetView = class("SolicitwealthgetView", ItemGetFlyView)

function SolicitwealthgetView:ctor()
	SolicitwealthgetView.super.ctor(self)
end

function SolicitwealthgetView:buildUI()
	SolicitwealthgetView.super.buildUI(self)
end

function SolicitwealthgetView:bindEvents()
	SolicitwealthgetView.super.bindEvents(self)
end

function SolicitwealthgetView:unbindEvents()
	SolicitwealthgetView.super.unbindEvents(self)
end

function SolicitwealthgetView:destroyUI()
	SolicitwealthgetView.super.destroyUI(self)
end

function SolicitwealthgetView:onEnter()
	local params = self:getOpenParam()

	self._hitList = params[1]
	self._hitIndex = 1

	local lv, moneyCatLevel = RoleModel.instance:getMyLevel(), SolicitWealthConfig.instance:getLevel()

	self._baseGetNum = moneyCatLevel[math.min(lv, #moneyCatLevel)].prizeNum
	self._finishNum = 0
	self._items = params[2]
	self._data = params[2][1]
	self._effList = {}

	SolicitwealthgetView.super.onEnter(self)
	GlobalDispatcher:addListener(SolicitWealthConfig.SWITCHVIEW, self._switchview, self)
end

function SolicitwealthgetView:onEnterFinished()
	SolicitwealthgetView.super.onEnterFinished(self)
end

function SolicitwealthgetView:onExit()
	SolicitwealthgetView.super.onExit(self)
	GlobalDispatcher:removeListener(SolicitWealthConfig.SWITCHVIEW, self._switchview, self)
	removetimer(self._popItem, self)

	for i, v in ipairs(self._effList) do
		UIEffectManager.instance:stopEffect(v)
	end
end

function SolicitwealthgetView:onExitFinished()
	SolicitwealthgetView.super.onExitFinished(self)
end

function SolicitwealthgetView:_tryPopItem()
	self:_popItem()
	settimer(0.2, self._popItem, self, true)
end

function SolicitwealthgetView:_popItem()
	if self._hitList[self._hitIndex] then
		local cell = self:_getFreeCell()
		local obj = {
			name = "金币",
			color = self._data.color,
			hit = self._hitList[self._hitIndex] / 10000
		}

		obj.mo = {
			materialType = self._data.materialType,
			id = self._data.id,
			num = self._baseGetNum * (self._hitList[self._hitIndex] / 10000)
		}

		self:_updateCell(cell, obj)
		self:_startTweenPos()

		self._hitIndex = self._hitIndex + 1
	end
end

function SolicitwealthgetView:_updateCell(go, obj)
	SolicitwealthgetView.super._updateCell(self, go, obj)

	if obj.hit > 1 then
		local effect = goutil.findChild(go, "container/effect")

		goutil.setActive(effect, true)

		if obj.hit ~= 1 then
			local effect_path = "fx_ui_zhaocaimao/fx_ui_zhaocaimao_tx_zi" .. obj.hit .. ".prefab"
			local effect = UIEffectManager.instance:playEffect(self, effect_path, nil, 0, 0, false, nil, nil, function(finishHandler, eff)
				eff.effGo.transform:SetParent(effect.transform)
				eff:setScale(1)
				Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
			end)

			table.insert(self._effList, effect)
		end
	else
		goutil.setActive(goutil.findChild(go, "container/effect"), false)
	end
end

function SolicitwealthgetView:_onFinish(icon)
	self._finishNum = self._finishNum + 1

	MaterialMgr.resetAll(icon)

	if self._finishNum >= #self._hitList then
		self:close()
		GlobalDispatcher:dispatch(SolicitWealthConfig.UNLOCK)
	end
end

function SolicitwealthgetView:_switchview()
	self._finishNum = 99
end

return SolicitwealthgetView
