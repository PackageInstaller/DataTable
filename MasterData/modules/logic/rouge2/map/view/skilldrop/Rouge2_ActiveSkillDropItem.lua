-- chunkname: @modules/logic/rouge2/map/view/skilldrop/Rouge2_ActiveSkillDropItem.lua

module("modules.logic.rouge2.map.view.skilldrop.Rouge2_ActiveSkillDropItem", package.seeall)

local Rouge2_ActiveSkillDropItem = class("Rouge2_ActiveSkillDropItem", LuaCompBase)

function Rouge2_ActiveSkillDropItem:init(go)
	self.go = go
	self._goRoot = gohelper.findChild(self.go, "go_Root")
	self._goSelect = gohelper.findChild(self.go, "go_Select")
	self._btnSelect = gohelper.findChildButtonWithAudio(self.go, "go_Select/btn_Select", AudioEnum.Rouge2.SelectActiveSkill)
end

function Rouge2_ActiveSkillDropItem:addEventListeners()
	self._btnSelect:AddClickListener(self._btnSelectOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onConfirmSelectDrop, self.onConfirmSelectDrop, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.OnSelectDropSkillItem, self._onSelectSkillDropItem, self)
end

function Rouge2_ActiveSkillDropItem:removeEventListeners()
	self._btnSelect:RemoveClickListener()
end

function Rouge2_ActiveSkillDropItem:_btnSelectOnClick()
	if self._viewType ~= Rouge2_MapEnum.ItemDropViewEnum.Select then
		return
	end

	GameFacade.showOptionMessageBox(MessageBoxIdDefine.Rouge2SelectActiveSkill, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.NotShow, self._reallySelect, nil, nil, self)
end

function Rouge2_ActiveSkillDropItem:_reallySelect()
	if not self._isSelect then
		return
	end

	GameUtil.setActiveUIBlock("Rouge2_ActiveSkillDropItem", true, false)
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onConfirmSelectDrop, self._index)
	self._commonSkillItem:playAnim("light", self._onSelectAnimDone, self)
end

function Rouge2_ActiveSkillDropItem:_onSelectAnimDone()
	self:_tryStatDrop()
	GameUtil.setActiveUIBlock("Rouge2_ActiveSkillDropItem", false, true)

	self._rpcCallback = Rouge2_Rpc.instance:sendRouge2SelectDropRequest({
		self._index
	}, self._rpcReceiveCallback, self)
end

function Rouge2_ActiveSkillDropItem:_rpcReceiveCallback(_, resultCode)
	if resultCode ~= 0 then
		return
	end

	self._rpcCallback = nil

	ViewMgr.instance:closeView(ViewName.Rouge2_ActiveSkillDropView)
end

function Rouge2_ActiveSkillDropItem:_tryStatDrop()
	if self._viewType ~= Rouge2_MapEnum.ItemDropViewEnum.Select then
		return
	end

	local itemNameList = Rouge2_BackpackHelper.getItemNameList(self._dataType, self._parentView._skillList)

	if self._skillCo then
		Rouge2_StatController.instance:statSelectDrop(Rouge2_MapEnum.DropType.ActiveSkill, self._skillId, self._skillCo, itemNameList)
	end
end

function Rouge2_ActiveSkillDropItem:onConfirmSelectDrop(index)
	if index == self._index then
		return
	end

	self._isClsoe = true

	self._commonSkillItem:playAnim("close")
end

function Rouge2_ActiveSkillDropItem:setParentView(parentView, goParentScroll)
	self._parentView = parentView

	if not self._commonSkillItem then
		local goCommonSkill = self._parentView:getResInst(Rouge2_Enum.ResPath.CommonSkillItem, self._goRoot)

		self._commonSkillItem = Rouge2_CommonSkillItem.Get(goCommonSkill)

		self._commonSkillItem:initClickCallback(self.onClickSelf, self)
		self._commonSkillItem:initDescModeFlag(Rouge2_Enum.ItemDescModeDataKey.SkillDrop)
		self._commonSkillItem:setParentScroll(goParentScroll)
	end
end

function Rouge2_ActiveSkillDropItem:onUpdateMO(index, viewType, dataType, dataId)
	self._index = index
	self._viewType = viewType
	self._dataType = dataType
	self._dataId = dataId
	self._skillCo = Rouge2_BackpackHelper.getItemCofigAndMo(self._dataType, self._dataId)
	self._skillId = self._skillCo and self._skillCo.id

	self._commonSkillItem:onUpdateMO(index, viewType, dataType, dataId)
	self._commonSkillItem:playAnim("open")

	self._isClsoe = false
	self._isSelect = false

	gohelper.setActive(self._goSelect, false)
end

function Rouge2_ActiveSkillDropItem:onSelect(isSelect)
	if self._isSelect == isSelect then
		return
	end

	self._isSelect = isSelect

	gohelper.setActive(self._goSelect, isSelect)
	self._commonSkillItem:onSelect(isSelect)
end

function Rouge2_ActiveSkillDropItem:_onSelectSkillDropItem(index)
	self:onSelect(index == self._index)
end

function Rouge2_ActiveSkillDropItem:onClickSelf()
	if self._viewType ~= Rouge2_MapEnum.ItemDropViewEnum.Select and self._viewType ~= Rouge2_MapEnum.ItemDropViewEnum.LevelUp then
		return
	end

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.OnSelectDropSkillItem, self._index)
end

function Rouge2_ActiveSkillDropItem:_onCloseView(viewName)
	if viewName ~= ViewName.Rouge2_ActiveSkillDropView or self._isClsoe then
		return
	end

	self._commonSkillItem:playAnim("close")
end

function Rouge2_ActiveSkillDropItem:onDestroy()
	GameUtil.setActiveUIBlock("Rouge2_ActiveSkillDropItem", false, true)

	if self._rpcCallback then
		Rouge2_Rpc.instance:removeCallbackById(self._rpcCallback)

		self._rpcCallback = nil
	end
end

return Rouge2_ActiveSkillDropItem
