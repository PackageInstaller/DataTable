-- chunkname: @modules/logic/fightuiswitch/view/FightUISwitchView.lua

module("modules.logic.fightuiswitch.view.FightUISwitchView", package.seeall)

local FightUISwitchView = class("FightUISwitchView", BaseView)

function FightUISwitchView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "root/#simage_bg")
	self._goScene = gohelper.findChild(self.viewGO, "root/#go_Scene")
	self._goleft = gohelper.findChild(self.viewGO, "root/#go_left")
	self._gobottom = gohelper.findChild(self.viewGO, "root/#go_bottom")
	self._scrolleffect = gohelper.findChildScrollRect(self.viewGO, "root/#go_bottom/#scroll_effect")
	self._goeffectItem = gohelper.findChild(self.viewGO, "root/#go_bottom/#scroll_effect/Viewport/Content/#go_effectItem")
	self._goSceneName = gohelper.findChild(self.viewGO, "root/#go_bottom/#go_SceneName")
	self._txtSceneName = gohelper.findChildText(self.viewGO, "root/#go_bottom/#go_SceneName/#txt_SceneName")
	self._txtTime = gohelper.findChildText(self.viewGO, "root/#go_bottom/#go_SceneName/#txt_SceneName/#txt_Time")
	self._btnclickname = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_bottom/#go_SceneName/#btn_name")
	self._txtSceneDescr = gohelper.findChildText(self.viewGO, "root/#go_bottom/#txt_SceneDescr")
	self._goright = gohelper.findChild(self.viewGO, "root/#go_right")
	self._scrollstyle = gohelper.findChildScrollRect(self.viewGO, "root/#go_right/#scroll_style")
	self._gostylestate = gohelper.findChild(self.viewGO, "root/#go_right/#go_stylestate")
	self._goselect = gohelper.findChild(self.viewGO, "root/#go_right/#go_stylestate/#go_select")
	self._goobtain = gohelper.findChild(self.viewGO, "root/#go_right/#go_stylestate/#go_obtain")
	self._golock = gohelper.findChild(self.viewGO, "root/#go_right/#go_stylestate/#go_lock")
	self._gouse = gohelper.findChild(self.viewGO, "root/#go_right/#go_stylestate/#go_use")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightUISwitchView:addEvents()
	self:_addEventCb()
	self._btnselect:AddClickListener(self.onClickSelect, self)
	self._btnobtain:AddClickListener(self.onClickObtain, self)
	self._btnclickname:AddClickListener(self.onClickName, self)
end

function FightUISwitchView:removeEvents()
	self:_removeEventCb()
	self._btnselect:RemoveClickListener()
	self._btnobtain:RemoveClickListener()
	self._btnclickname:RemoveClickListener()
end

function FightUISwitchView:onClickSelect()
	FightUISwitchModel.instance:useCurStyleId()
end

function FightUISwitchView:onClickObtain()
	local mo = FightUISwitchModel.instance:getCurStyleMo()
	local co = mo and mo:getItemConfig()

	if co then
		MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Item, co.id)
	end
end

function FightUISwitchView:onClickName()
	local mo = FightUISwitchModel.instance:getCurStyleMo()

	FightUISwitchController.instance:openSceneView(mo)
end

function FightUISwitchView:_editableInitView()
	gohelper.setActive(self._goeffectItem, false)

	self._btnselect = SLFramework.UGUI.UIClickListener.Get(self._goselect.gameObject)
	self._btnobtain = SLFramework.UGUI.UIClickListener.Get(self._goobtain.gameObject)
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function FightUISwitchView:onUpdateParam()
	return
end

function FightUISwitchView:_addEventCb()
	self.addEventCb(self, FightUISwitchController.instance, FightUISwitchEvent.UseFightUIStyle, self._onUseFightUIStyle, self)
	self.addEventCb(self, FightUISwitchController.instance, FightUISwitchEvent.SelectFightUIStyle, self._onSelectFightUIStyle, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onUpdateItemList, self)
	self.viewContainer:registerCallback(ViewEvent.ToSwitchTab, self._toSwitchTab, self)
end

function FightUISwitchView:_removeEventCb()
	self.removeEventCb(self, FightUISwitchController.instance, FightUISwitchEvent.UseFightUIStyle, self._onUseFightUIStyle, self)
	self.removeEventCb(self, FightUISwitchController.instance, FightUISwitchEvent.SelectFightUIStyle, self._onSelectFightUIStyle, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onUpdateItemList, self)
	self.viewContainer:unregisterCallback(ViewEvent.ToSwitchTab, self._toSwitchTab, self)
	TaskDispatcher.cancelTask(self._classifyBtnClickCb, self)
end

function FightUISwitchView:_onUseFightUIStyle(classify, styleId)
	FightUISwitchListModel.instance:onModelUpdate()
	self:_refreshBtn()

	classify = classify or FightUISwitchModel.instance:getCurShowStyleClassify()

	local info = FightUISwitchEnum.StyleClassifyInfo[classify]
	local title = luaLang(info.ClassifyTitle)

	ToastController.instance:showToast(ToastEnum.FightUISwitchSuccess, title)
end

function FightUISwitchView:_onSelectFightUIStyle(classify, styleId)
	self:_refreshStyle()
end

function FightUISwitchView:_onUpdateItemList()
	self:_refreshStyle()
end

function FightUISwitchView:_toSwitchTab(tabContainerId, tabId)
	self._effectComp:clearEffectAnim()
end

function FightUISwitchView:onOpen()
	local styleClassify

	if self.viewParam and self.viewParam.jumpTabs and self.viewParam.jumpTabs[1] == MainEnum.SwitchType.FightUI and self.viewParam.jumpTabs[2] then
		for tab, info in ipairs(FightUISwitchEnum.StyleClassifyInfo) do
			if info.Sort == self.viewParam.jumpTabs[2] then
				styleClassify = tab

				break
			end
		end
	end

	styleClassify = styleClassify or FightUISwitchEnum.StyleClassify.FightCard

	FightUISwitchModel.instance:setCurShowStyleClassify(styleClassify)

	self._effectComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._gobottom, FightUISwitchEffectComp)

	FightUISwitchModel.instance:initMo()
	self:_initClassify()
	self:_refreshStyle()
	self._animator:Play(FightUISwitchEnum.AnimKey.Open)
end

function FightUISwitchView:_initClassify()
	self._classifyItems = self:getUserDataTb_()
	self._styleClassify = {}

	for i, v in pairs(FightUISwitchEnum.StyleClassifyInfo) do
		v.Classify = i

		table.insert(self._styleClassify, v)
		table.sort(self._styleClassify, self._sortClassify)
	end

	local newUnlockIds = FightUISwitchModel.instance:getNewUnlockIds()

	self._classifyIndex = FightUISwitchModel.instance:getCurShowStyleClassify()

	for i, info in ipairs(self._styleClassify) do
		local item = self:_getClassifyItem(i)
		local classify = info.Classify

		item.classify = classify

		item:onUpdateMO(classify, i)
		item:addBtnListeners(self._clickClassifyBtn, self)
		item:setTxt(luaLang(info.ClassifyTitle))

		local isSelect = self._classifyIndex == classify

		item:onSelect(isSelect)
		item:showLine(i < #self._styleClassify)

		if newUnlockIds[classify] then
			local isShowReddot = LuaUtil.tableNotEmpty(newUnlockIds[classify])

			if isSelect then
				item:showReddot(false)
				self:_cancelNewUnlockClassifyReddot(classify)
			else
				item:showReddot(newUnlockIds[classify])
			end
		end
	end
end

function FightUISwitchView._sortClassify(x, y)
	return x.Sort < y.Sort
end

function FightUISwitchView:_getClassifyItem(index)
	local item = self._classifyItems[index]

	if not item then
		local path = self.viewContainer:getSetting().otherRes[3]
		local childGO = self:getResInst(path, self._goleft, "classify" .. index)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, MainSwitchClassifyItem)
		self._classifyItems[index] = item
	end

	return item
end

function FightUISwitchView:_clickClassifyBtn(index)
	local classify = self._styleClassify[index].Classify

	if self._classifyIndex == classify then
		return
	end

	self._effectComp:clearEffectAnim()

	self._classifyIndex = classify

	self:playSwitchAnim()
	TaskDispatcher.cancelTask(self._classifyBtnClickCb, self)
	TaskDispatcher.runDelay(self._classifyBtnClickCb, self, FightUISwitchEnum.SwitchAnimDelayTime)
	self:_refreshClassifyReddot(classify, index)
end

function FightUISwitchView:_refreshClassifyReddot(classify, index)
	local newUnlockIds = FightUISwitchModel.instance:getNewUnlockIds()

	if newUnlockIds[classify] then
		local isShowReddot = LuaUtil.tableNotEmpty(newUnlockIds[classify])

		if newUnlockIds[classify] then
			self:_cancelNewUnlockClassifyReddot(classify)

			local item = self:_getClassifyItem(index)

			item:showReddot(false)
		end
	end
end

function FightUISwitchView:_cancelNewUnlockClassifyReddot(classify)
	FightUISwitchModel.instance:cancelNewUnlockClassifyReddot(classify)
	FightUISwitchController.instance:dispatchEvent(FightUISwitchEvent.cancelClassifyReddot, classify)
end

function FightUISwitchView:playSwitchAnim()
	self._animator:Play(FightUISwitchEnum.AnimKey.Switch, 0, 0)
end

function FightUISwitchView:_classifyBtnClickCb()
	FightUISwitchModel.instance:setCurShowStyleClassify(self._classifyIndex)
	self:_refreshStyle()
	FightUISwitchListModel.instance:setMoList()

	for i, item in ipairs(self._classifyItems) do
		item:onSelect(self._classifyIndex == item.classify)
	end
end

function FightUISwitchView:_refreshStyle()
	local mo = FightUISwitchModel.instance:getCurStyleMo()
	local co = mo and mo:getItemConfig()

	if co then
		self._txtSceneName.text = co.name
		self._txtSceneDescr.text = co.desc
	end

	self._txtTime.text = mo:getObtainTime() or ""

	self._effectComp:refreshEffect(self._goScene, FightUISwitchModel.instance:getCurStyleMo(), self.viewName)
	self._effectComp:setViewAnim(self._animator)
	self:_refreshBtn()
end

function FightUISwitchView:_refreshBtn()
	local mo = FightUISwitchModel.instance:getCurStyleMo()
	local isUse = mo:isUse()
	local isUnlock = mo:isUnlock()
	local isCanJump = mo:canJump()

	gohelper.setActive(self._gouse, isUse)
	gohelper.setActive(self._goobtain, not isUnlock and isCanJump)
	gohelper.setActive(self._goselect, isUnlock and not isUse)
	gohelper.setActive(self._golock, not isUnlock and not isCanJump)
end

function FightUISwitchView:playCloseAnim()
	return
end

function FightUISwitchView:onClose()
	self._effectComp:onClose()
	FightUISwitchController.instance:dispose()
end

function FightUISwitchView:onDestroyView()
	self._effectComp:onDestroy()
end

return FightUISwitchView
