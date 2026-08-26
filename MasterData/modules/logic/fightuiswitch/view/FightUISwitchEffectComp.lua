-- chunkname: @modules/logic/fightuiswitch/view/FightUISwitchEffectComp.lua

module("modules.logic.fightuiswitch.view.FightUISwitchEffectComp", package.seeall)

local FightUISwitchEffectComp = class("FightUISwitchEffectComp", LuaCompBase)

function FightUISwitchEffectComp:onInitView()
	self._scrolleffect = gohelper.findChildScrollRect(self.viewGO, "#scroll_effect")
	self._goeffectItem = gohelper.findChild(self.viewGO, "#scroll_effect/Viewport/Content/#go_effectItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightUISwitchEffectComp:_editableInitView()
	gohelper.setActive(self._goeffectItem, false)
end

function FightUISwitchEffectComp:init(go)
	self.viewGO = go
	self._showResObjTb = nil
	self._sceneParent = nil

	self:onInitView()

	self._effectItems = self:getUserDataTb_()
	self._showResObjTb = self:getUserDataTb_()

	self:addEvent()
end

function FightUISwitchEffectComp:addEvent()
	FightUISwitchController.instance:registerCallback(FightUISwitchEvent.LoadFinish, self._loadFinish, self)
end

function FightUISwitchEffectComp:removeEvent()
	FightUISwitchController.instance:unregisterCallback(FightUISwitchEvent.LoadFinish, self._loadFinish, self)
end

function FightUISwitchEffectComp:_loadFinish(viewName)
	if self._viewName ~= viewName then
		return
	end

	local res = self:_getSceneRes()
	local prefab = FightUISwitchController.instance:getRes(res)

	if prefab and self._sceneParent then
		local objTb = self._showResObjTb[res]
		local resObj

		if not objTb or not objTb.resObj then
			objTb = self:getUserDataTb_()
			objTb.resObj = gohelper.clone(prefab, self._sceneParent)

			recthelper.setAnchor(objTb.resObj.transform, 0, 0)
			gohelper.setActive(objTb.resObj, true)

			self._showResObjTb[res] = objTb
		end

		resObj = objTb.resObj

		if objTb and not objTb.effectSceneTb then
			objTb.effectSceneTb = self:getUserDataTb_()

			for i, mo in ipairs(self._effectMoList) do
				if not string.nilorempty(mo.co.res) then
					local effectRoot = gohelper.findChild(resObj.gameObject, mo.co.res)

					self._effectSceneTb = self._effectSceneTb or self:getUserDataTb_()

					local tb = self._effectSceneTb[res]

					tb = tb or self:getUserDataTb_()

					if not tb[mo.co.res] then
						tb[mo.co.res] = self:getUserDataTb_()
						tb[mo.co.res].root = effectRoot
						tb[mo.co.res].anim = effectRoot:GetComponent(typeof(UnityEngine.Animator))
						self._effectSceneTb[res] = tb
					end
				end
			end
		end

		for _res, objTb in pairs(self._showResObjTb) do
			gohelper.setActive(objTb.resObj, _res == res)
		end

		self:_runRepeatEffectAnim()
	end
end

function FightUISwitchEffectComp:setViewAnim(anim)
	self._viewAnimator = anim
end

function FightUISwitchEffectComp:refreshEffect(parent, mo, viewName)
	self._sceneParent = parent
	mo = mo or FightUISwitchModel.instance:getCurStyleMo()
	self._mo = mo
	self._viewName = viewName
	self._effectMoList = mo:getAllEffectMos()

	self:clearEffectAnim()
	self:_loadScene()

	if self._effectMoList then
		for i, mo in ipairs(self._effectMoList) do
			local item = self:_getEffectItem(i)

			item:onUpdateMO(mo, i)
			item:addBtnListeners(self._clickEffectBtn, self)
			item:setTxt(mo:getName())
		end

		for i = 1, #self._effectItems do
			local item = self._effectItems[i]

			item:setActive(i <= #self._effectMoList)
		end
	end

	self:_showCurEffect(1)
end

function FightUISwitchEffectComp:_getEffectItem(index)
	local item = self._effectItems[index]

	if not item then
		local childGO = gohelper.cloneInPlace(self._goeffectItem, "effect_" .. index)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, MainSwitchClassifyItem)
		self._effectItems[index] = item
	end

	return item
end

function FightUISwitchEffectComp:_loadScene()
	if not self._sceneParent or not self._mo then
		return
	end

	FightUISwitchController.instance:loadRes(self._mo.id, self._viewName)
end

function FightUISwitchEffectComp:_getSceneRes()
	return (FightUISwitchModel.instance:getSceneRes(self._mo:getConfig(), self._viewName))
end

function FightUISwitchEffectComp:_refreshEffectSceneRoot()
	local res = self._showEffectMo.co.res
	local sceneRes = self:_getSceneRes()

	if self._effectSceneTb and self._effectSceneTb[sceneRes] then
		for _res, tb in pairs(self._effectSceneTb[sceneRes]) do
			if tb.root then
				gohelper.setActive(tb.root, _res == res)
			end
		end
	end
end

function FightUISwitchEffectComp:_runRepeatEffectAnim()
	self._showEffectIndex = 0

	self:_playEffectAnim()
end

function FightUISwitchEffectComp:_playEffectAnim()
	local index = self._showEffectIndex + 1

	if index > #self._effectMoList then
		index = 1
	end

	local index = index or self._showEffectIndex

	self:_showCurEffect(index)

	local delayTime = self:_getEffectDelayTime()

	TaskDispatcher.runDelay(self._showNextEffect, self, delayTime)
end

function FightUISwitchEffectComp:_showNextEffect()
	TaskDispatcher.cancelTask(self._playEffectAnim, self)

	if self._viewAnimator then
		self._viewAnimator:Play(FightUISwitchEnum.AnimKey.Switch, 0, 0)
		TaskDispatcher.runDelay(self._playEffectAnim, self, FightUISwitchEnum.SwitchAnimDelayTime)
	else
		self:_playEffectAnim()
	end
end

function FightUISwitchEffectComp:_getCurShowEffectSceneRootTb()
	local sceneRes = self:_getSceneRes()
	local res = self._showEffectMo.co.res

	if self._effectSceneTb and self._effectSceneTb[sceneRes] then
		return self._effectSceneTb[sceneRes][res]
	end
end

function FightUISwitchEffectComp:_showCurEffect(index)
	local moLength = #self._effectMoList

	if not self._effectMoList or moLength < index then
		return
	end

	self._showEffectIndex = index
	self._showEffectMo = self._effectMoList[index]

	if not self._showEffectMo then
		return
	end

	if self._effectItems then
		for i, item in ipairs(self._effectItems) do
			item:onSelectByIndex(index)
		end
	end

	self:_refreshEffectSceneRoot()

	local progress

	self._scrolleffect.horizontalNormalizedPosition = index < 3 and 0 or index > moLength - 3 and 1 or math.floor(index / moLength)
end

function FightUISwitchEffectComp:clearEffectAnim()
	TaskDispatcher.cancelTask(self._showNextEffect, self)
	TaskDispatcher.cancelTask(self._playEffectAnim, self)
	TaskDispatcher.cancelTask(self._repeatShowEffectAnim, self)
	TaskDispatcher.cancelTask(self._repeatShowEffectAnimCB, self)
end

function FightUISwitchEffectComp:_clickEffectBtn(index)
	self:clearEffectAnim()

	if self._showEffectIndex == index then
		return
	end

	self._showEffectIndex = index
	self._repeatEffectTime = self:_getEffectDelayTime()

	TaskDispatcher.cancelTask(self._repeatShowEffectAnim, self)
	TaskDispatcher.cancelTask(self._repeatShowEffectAnimCB, self)

	if self._viewAnimator then
		self._viewAnimator:Play(FightUISwitchEnum.AnimKey.Switch, 0, 0)
		TaskDispatcher.runDelay(self._repeatShowEffectAnim, self, FightUISwitchEnum.SwitchAnimDelayTime)
	else
		self:_repeatShowEffectAnim()
	end
end

function FightUISwitchEffectComp:_getEffectDelayTime()
	local time = FightUISwitchEnum.SwitchAnimTime
	local tb = self:_getCurShowEffectSceneRootTb()

	if tb then
		if not tb.delayLength then
			local stateInfo = tb.anim:GetCurrentAnimatorStateInfo(0)
			local time = stateInfo.length

			tb.delayLength = math.max(time, FightUISwitchEnum.SwitchAnimTime)
		end

		time = tb.delayLength
	end

	return time
end

function FightUISwitchEffectComp:_repeatShowEffectAnim()
	self:_showCurEffect(self._showEffectIndex)
	TaskDispatcher.runRepeat(self._repeatShowEffectAnimCB, self, self._repeatEffectTime)
end

function FightUISwitchEffectComp:_repeatShowEffectAnimCB()
	local tb = self:_getCurShowEffectSceneRootTb()

	if tb and tb.anim then
		gohelper.setActive(tb.anim.gameObject, false)
		gohelper.setActive(tb.anim.gameObject, true)
	end
end

function FightUISwitchEffectComp:onClose()
	self:clearEffectAnim()

	self._effectSceneRoot = nil

	self:removeEvent()

	if self._effectItems then
		for i = 1, #self._effectItems do
			local item = self._effectItems[i]

			gohelper.destroy(item.viewGO)
		end
	end
end

function FightUISwitchEffectComp:onDestroy()
	self:clearEffectAnim()

	self._effectSceneRoot = nil
end

return FightUISwitchEffectComp
