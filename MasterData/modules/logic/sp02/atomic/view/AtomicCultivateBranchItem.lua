-- chunkname: @modules/logic/sp02/atomic/view/AtomicCultivateBranchItem.lua

module("modules.logic.sp02.atomic.view.AtomicCultivateBranchItem", package.seeall)

local AtomicCultivateBranchItem = class("AtomicCultivateBranchItem", LuaCompBase)

function AtomicCultivateBranchItem:init(go)
	self.go = go
	self.goSelect = gohelper.findChild(go, "#go_selectbg")
	self.txtName = gohelper.findChildTextMesh(go, "#txt_name")
	self.goLock = gohelper.findChild(go, "#go_lockicon")
	self.goUpArrow = gohelper.findChild(go, "#go_uparrow")
	self.btnClick = gohelper.findChildButtonWithAudio(go, "#btn_click", AudioEnum3_10.Outside.play_ui_langchao_general_click)
	self.anim = gohelper.findChildComponent(go, "", typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicCultivateBranchItem:addEventListeners()
	self.addClickCb(self, self.btnClick, self._btnclickOnClick, self)
end

function AtomicCultivateBranchItem:removeEventListeners()
	self:removeClickCb(self.btnClick)
end

function AtomicCultivateBranchItem:_btnclickOnClick()
	if not self.config then
		return
	end

	AtomicTalentController.instance:trySelectBranch(self.config.id)
end

function AtomicCultivateBranchItem:_editableInitView()
	return
end

function AtomicCultivateBranchItem:updateData(config)
	self.config = config

	gohelper.setActive(self.go, config ~= nil)

	if not config then
		return
	end

	self:refreshUI()
end

function AtomicCultivateBranchItem:refreshUI()
	local isUnlock = AtomicTalentViewModel.instance:isBranchUnlocked(self.config.id)
	local isSelect = AtomicTalentViewModel.instance:isBranchSelected(self.config.id)
	local isShowLight = AtomicTalentViewModel.instance:isBranchCanLight(self.config.id)

	gohelper.setActive(self.goLock, not isUnlock)
	gohelper.setActive(self.goSelect, isSelect)
	gohelper.setActive(self.goUpArrow, isShowLight)

	self.txtName.text = self.config.name

	if isUnlock and self._isUnlock == false then
		self.anim:Play("unlock")
	end

	self._isUnlock = isUnlock

	if isSelect and self._isSelect ~= isSelect then
		self.anim:Play("select")
	end

	self._isSelect = isSelect
end

function AtomicCultivateBranchItem:onDestroy()
	return
end

return AtomicCultivateBranchItem
