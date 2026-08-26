-- chunkname: @modules/logic/dungeon/view/DungeonNavigateButtonsView.lua

module("modules.logic.dungeon.view.DungeonNavigateButtonsView", package.seeall)

local DungeonNavigateButtonsView = class("DungeonNavigateButtonsView", NavigateButtonsView)

function DungeonNavigateButtonsView:onInitView()
	self._btnRecheck = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_recheck")

	DungeonNavigateButtonsView.super.onInitView(self)
end

function DungeonNavigateButtonsView:addEvents()
	DungeonNavigateButtonsView.super.addEvents(self)
	self._btnRecheck:AddClickListener(self._btnRecheckOnClick, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self._checkRecheckElementBtn, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._OnCloseViewFinish, self, LuaEventSystem.Low)
end

function DungeonNavigateButtonsView:removeEvents()
	DungeonNavigateButtonsView.super.removeEvents(self)
	self._btnRecheck:RemoveClickListener()
end

function DungeonNavigateButtonsView:_editableInitView()
	DungeonNavigateButtonsView.super._editableInitView(self)

	self._animRecheck = self._btnRecheck.gameObject:GetComponent(typeof(UnityEngine.Animator))
end

function DungeonNavigateButtonsView:_btnRecheckOnClick()
	if self._overrideClickRecheckFunc then
		self._overrideClickRecheckFunc(self._overrideClickRecheckObj)
	end

	if not self._chapterId then
		return
	end

	DungeonController.instance:openRecheckElementView(self._chapterId, false)
end

function DungeonNavigateButtonsView:initChapterRecheck(chapterId)
	self._chapterId = chapterId

	self:refreshRecheckElement()
end

function DungeonNavigateButtonsView:setOverrideClickRecheck(overrideClickRecheckFunc, overrideClickRecheckObj)
	self._overrideClickRecheckFunc = overrideClickRecheckFunc
	self._overrideClickRecheckObj = overrideClickRecheckObj
end

function DungeonNavigateButtonsView:refreshRecheckElement(isForceShow)
	if not self._btnRecheck then
		return
	end

	local elements = DungeonMapModel.instance:getCanRecheckElements(self._chapterId)

	if self._chapterId and elements then
		self._canRecheckElements = tabletool.copy(elements)
	end

	if not isForceShow then
		::label_8_0::

		local var_8_0 = self._canRecheckElements

		if self._canRecheckElements then
			local isShowBtn = #self._canRecheckElements > 0

			gohelper.setActive(self._btnRecheck.gameObject, isShowBtn)
		end
	end
end

function DungeonNavigateButtonsView:_OnCloseViewFinish(viewName)
	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return
	end

	if not self._isNeedPlayAnim then
		return
	end

	self._isNeedPlayAnim = false

	gohelper.setActive(self._btnRecheck.gameObject, true)
	self._animRecheck:Play("once", 0, 0)
end

function DungeonNavigateButtonsView:_checkRecheckElementBtn(id)
	if not LuaUtil.tableContains(self._canRecheckElements, id) then
		local elementCo = DungeonConfig.instance:getChapterMapElement(id)

		if not elementCo then
			return
		end

		local isCanRecheck = DungeonMapModel.instance:isCanRecheckElements(elementCo)

		if isCanRecheck then
			GameFacade.showToast(ToastEnum.DungeonFragmentRechechTip, elementCo.title)

			local fragmentId = elementCo.fragment

			if not fragmentId or fragmentId == 0 then
				self._isNeedPlayAnim = false

				gohelper.setActive(self._btnRecheck.gameObject, true)
				self._animRecheck:Play("once", 0, 0)

				return
			end

			self._isNeedPlayAnim = true
		end
	end

	self:refreshRecheckElement()
end

function DungeonNavigateButtonsView:forceHideRecheck(isHide)
	self._forceHideRecheck = isHide

	if isHide then
		gohelper.setActive(self._btnRecheck.gameObject, false)
	else
		self:refreshRecheckElement()
	end
end

DungeonNavigateButtonsView.prefabPath = "ui/viewres/common/commonbtnsview.prefab"

return DungeonNavigateButtonsView
