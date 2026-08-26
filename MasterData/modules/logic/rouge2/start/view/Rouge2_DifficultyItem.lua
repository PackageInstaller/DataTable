-- chunkname: @modules/logic/rouge2/start/view/Rouge2_DifficultyItem.lua

module("modules.logic.rouge2.start.view.Rouge2_DifficultyItem", package.seeall)

local Rouge2_DifficultyItem = class("Rouge2_DifficultyItem", LuaCompBase)

function Rouge2_DifficultyItem:init(go)
	self.go = go
	self._goNormal = gohelper.findChild(self.go, "Root/#go_Normal")
	self._txtNormalName = gohelper.findChildText(self.go, "Root/#go_Normal/#txt_Name")
	self._goLocked = gohelper.findChild(self.go, "Root/#go_Locked")
	self._txtLockedName = gohelper.findChildText(self.go, "Root/#go_Locked/#txt_Name")
	self._goSelected = gohelper.findChild(self.go, "Root/#go_Selected")
	self._txtSelectedName = gohelper.findChildText(self.go, "Root/#go_Selected/#txt_Name")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "Root/#btn_Click")
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.go)

	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnSelectDifficulty, self._onSelectDifficulty, self)
end

function Rouge2_DifficultyItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function Rouge2_DifficultyItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function Rouge2_DifficultyItem:_btnClickOnClick()
	if not self._isUnlock then
		GameFacade.showToast(ToastEnum.Rouge2LockDifficulty)

		return
	end

	Rouge2_DifficultySelectListModel.instance:selectDifficulty(self._difficulty)
end

function Rouge2_DifficultyItem:onUpdateMO(difficultyCo)
	self._config = difficultyCo
	self._difficulty = difficultyCo.difficulty
	self._isUnlock = Rouge2_OutsideModel.instance:isOpenedDifficulty(self._difficulty)
	self._isNewUnlock = self:isNewUnlock()
	self._title = self._config and self._config.title
	self._desc = self._config and self._config.desc

	self:refreshUI()
	self:onSelect(false)
	self:setUse(true)
end

function Rouge2_DifficultyItem:refreshUI()
	self._txtNormalName.text = self._title
	self._txtLockedName.text = self._title
	self._txtSelectedName.text = self._title

	gohelper.setActive(self._goNormal, self._isUnlock and not self._isNewUnlock)
	gohelper.setActive(self._goLocked, not self._isUnlock or self._isNewUnlock)
end

function Rouge2_DifficultyItem:setUse(isUse)
	if self._isUse == isUse then
		return
	end

	self._isUse = isUse

	gohelper.setActive(self.go, isUse)

	if isUse then
		self._animatorPlayer:Play("open", self._normalAnimDone, self)
	end
end

function Rouge2_DifficultyItem:onSelect(isSelect)
	local isShowSelect = isSelect and not self._isNewUnlock
	local animName = isShowSelect and "select" or "unselect"

	self._animatorPlayer:Play(animName, self._normalAnimDone, self)
	gohelper.setActive(self._goSelected, isShowSelect)
end

function Rouge2_DifficultyItem:_normalAnimDone()
	return
end

function Rouge2_DifficultyItem:_onSelectDifficulty(difficulty)
	self:onSelect(difficulty == self._difficulty)
end

function Rouge2_DifficultyItem:_onOpenViewFinish(viewName)
	if not self._isNewUnlock or viewName ~= ViewName.Rouge2_DifficultySelectView then
		return
	end

	self._isNewUnlock = false

	self._animatorPlayer:Play("unlock", self._onPlayUnlockAnimDone, self)

	local key = PlayerPrefsKey.Rouge2UnlockDifficultyId .. "#" .. self._difficulty

	GameUtil.playerPrefsSetNumberByUserId(key, 1)
end

function Rouge2_DifficultyItem:_onPlayUnlockAnimDone()
	local selectDifficulty = Rouge2_DifficultySelectListModel.instance:getCurSelectDifficulty()

	self:onSelect(selectDifficulty == self._difficulty)
	self:refreshUI()
end

function Rouge2_DifficultyItem:isNewUnlock()
	if not self._isUnlock then
		return
	end

	if self._config then
		local preDifficulty = self._config.preDifficulty

		if not preDifficulty or preDifficulty == 0 then
			return
		end

		local key = PlayerPrefsKey.Rouge2UnlockDifficultyId .. "#" .. self._difficulty
		local value = GameUtil.playerPrefsGetNumberByUserId(key, 0)

		return not value or tonumber(value) == 0
	end
end

function Rouge2_DifficultyItem:onDestory()
	return
end

return Rouge2_DifficultyItem
