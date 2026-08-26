-- chunkname: @modules/logic/versionactivity3_6/yami/view/game/V3a6YaMiSelectHeroGridItem.lua

module("modules.logic.versionactivity3_6.yami.view.game.V3a6YaMiSelectHeroGridItem", package.seeall)

local V3a6YaMiSelectHeroGridItem = class("V3a6YaMiSelectHeroGridItem", ListScrollCellExtend)

function V3a6YaMiSelectHeroGridItem:ctor(index)
	self._index = index
end

function V3a6YaMiSelectHeroGridItem:onInitView()
	self._goadd = gohelper.findChild(self.viewGO, "root/#go_add")
	self._goitem = gohelper.findChild(self.viewGO, "root/#go_item")
	self._golockstate = gohelper.findChild(self.viewGO, "root/#go_lockstate")
	self._gostate1 = gohelper.findChild(self.viewGO, "root/#go_lockstate/#go_state1")
	self._txtnum1 = gohelper.findChildText(self.viewGO, "root/#go_lockstate/#go_state1/#txt_num")
	self._btnunlock = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_lockstate/#go_state1/#btn_unlock")
	self._gostate2 = gohelper.findChild(self.viewGO, "root/#go_lockstate/#go_state2")
	self._txtnum2 = gohelper.findChildText(self.viewGO, "root/#go_lockstate/#go_state2/#txt_num")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6YaMiSelectHeroGridItem:addEvents()
	self._btnunlock:AddClickListener(self._btnunlockOnClick, self)
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onRefreshCurrency, self.refreshLock, self)
end

function V3a6YaMiSelectHeroGridItem:removeEvents()
	self._btnunlock:RemoveClickListener()
	self._btnclick:RemoveClickListener()
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onRefreshCurrency, self.refreshLock, self)
end

function V3a6YaMiSelectHeroGridItem:_btnclickOnClick()
	V3a6YaMiController.instance:openSelectHeroHandbookView()
end

function V3a6YaMiSelectHeroGridItem:_btnunlockOnClick()
	self:playUnlockAnim()
	V3a6YaMiRpc.instance:sendAct231UnlockSeatRequest(self._index, self.refreshLock, self)
end

function V3a6YaMiSelectHeroGridItem:_editableInitView()
	self._animPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
end

function V3a6YaMiSelectHeroGridItem:refreshLock()
	local isUnlockSeat = self._seatMo:isUnlock()

	if not isUnlockSeat then
		local curCost = V3a6YaMiModel.instance:getCurSelectMaterialCost()
		local seatCo = self._seatMo.co
		local cost = seatCo and seatCo.cost
		local isEnoughCurrency = V3a6YaMiModel.instance:isEnoughCurrency(cost + curCost)
		local isCanUnlock = V3a6YaMiModel.instance:isUnlockSeat(seatCo.preId) and isEnoughCurrency

		self._txtnum1.text = cost
		self._txtnum2.text = cost

		gohelper.setActive(self._gostate1, isCanUnlock)
		gohelper.setActive(self._gostate2, not isCanUnlock)
	end

	gohelper.setActive(self._golockstate, self._isPlayingUnlockAnim or not isUnlockSeat)
	gohelper.setActive(self._goadd, isUnlockSeat and (not self._heroId or not (self._heroId > 0)))
end

function V3a6YaMiSelectHeroGridItem:playUnlockAnim()
	self._isPlayingUnlockAnim = false

	if self._animPlayer then
		self._isPlayingUnlockAnim = true

		gohelper.setActive(self._golockstate, true)
		self._animPlayer:Play("unlock", self._playedUnlockAnim, self)
	end
end

function V3a6YaMiSelectHeroGridItem:_playedUnlockAnim()
	self._isPlayingUnlockAnim = false

	gohelper.setActive(self._golockstate, false)
end

function V3a6YaMiSelectHeroGridItem:onDestroy()
	return
end

function V3a6YaMiSelectHeroGridItem:onRefresh()
	self._heroId = V3a6YaMiModel.instance:getSelectHeroIdByIndex(self._index)
	self._seatMo = V3a6YaMiModel.instance:getSeatMo(self._index)

	self._seatMo:setHeroId(self._heroId)

	if self._heroId and self._heroId > 0 then
		if not self._heroItem then
			local prefab = self.viewContainer:getRes(V3a6YaMiEnum.ResPath.v3a6_dormitorymode_employeeitem)
			local go = gohelper.clone(prefab, self._goitem)

			self._heroItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, V3a6YaMiSelectHeroItem)
			self._heroItem.viewContainer = self.viewContainer
		end

		gohelper.setActive(self._goitem, true)
		self._heroItem:onUpdateMO(V3a6YaMiModel.instance:getHeroMoById(self._heroId))
	else
		gohelper.setActive(self._goitem, false)
	end

	self:refreshLock()
end

return V3a6YaMiSelectHeroGridItem
