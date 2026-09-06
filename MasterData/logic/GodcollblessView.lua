-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscollector/view/GodcollblessView.lua

module("logic.extensions.goddesscollector.view.GodcollblessView", package.seeall)

local GodcollblessView = class("GodcollblessView", ViewComponent)

function GodcollblessView:ctor()
	GodcollblessView.super.ctor(self)
end

function GodcollblessView:unbindEvents()
	GodcollblessView.super.unbindEvents(self)
	self._btnBless:RemoveClickListener()
end

function GodcollblessView:bindEvents()
	GodcollblessView.super.bindEvents(self)
	self._btnBless:AddClickListener(self._onClickbtnBless, self)
end

function GodcollblessView:buildUI()
	GodcollblessView.super.buildUI(self)

	self._btnBless = self:getBtn("btnBless")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "btnBless/txtDesc")
	self._txtBtnName = goutil.findChildTextComponent(self.mainGO, "btnBless/namebg/txtName")
	self._rolecon = self:getGo("con")
	self._cellconGo = self:getGo("cellcon")
	self._cellGo = self:getGo("cellcon/cell")
	self._itemGroup = ItemGroup.New(self._cellconGo, self._cellGo, nil, nil, true)
	self._txtBtnName.text = GoddesscollectorConfig.instance:getCommonValue("BLESS_BTNTEXT")
	self._txtDesc.text = GoddesscollectorConfig.instance:getCommonValue("BLESS_DESC")
end

function GodcollblessView:onExit()
	GodcollblessView.super.onExit(self)
	RoleObjectPool.instance:removeRole(self._roleObj)
end

function GodcollblessView:onEnter()
	GodcollblessView.super.onEnter(self)
	self:_setRole()
	self:_setItems()
end

function GodcollblessView:_onClickbtnBless()
	TipsFacade.instance:openRulesView("godcollblessview")
end

function GodcollblessView:_setRole()
	local skinId = GoddesscollectorConfig.instance:getCommonValue("BLESS_SHOW_RACECID", true)

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, skinId, self._rolecon, 0.8, nil, true, 0, -75)
end

function GodcollblessView:_setItems()
	local list = GoddesscollectorConfig.instance:getBlessClientCfgs()

	self._itemGroup:updateWithMoArray(list, function(item, cfg)
		self:_updateCell(item, cfg)
	end)
end

function GodcollblessView:_updateCell(item, cfg)
	Framework.TransformUtil.SetAnchoredPos(item.mainGO.transform, 220 * (item.index - 1), 0)

	local btnSure = Framework.ButtonAdapter.GetFrom(item.mainGO, "btnSure")
	local goImgPoint = goutil.findChild(item.mainGO, "imgPoint")
	local goLock = goutil.findChild(item.mainGO, "lock")
	local txtLock = goutil.findChildTextComponent(item.mainGO, "lock/txtLock")
	local textTime = goutil.findChildTextComponent(item.mainGO, "textTime")
	local txtBtnSure = goutil.findChildTextComponent(item.mainGO, "btnSure/Text")
	local imgIconChange = goutil.findChild(item.mainGO, "imgIcon"):GetComponent(ComponentType.UIImageSpriteChange)

	imgIconChange:SetState(cfg.id - 1)

	textTime.text = cfg.openDesc

	local isOpen = true

	if cfg.funcId > 0 then
		isOpen = FuncOpenModel.instance:getFuncIsOpen(cfg.funcId)
	end

	goutil.setActive(goLock, not isOpen)

	if cfg.funcId > 0 and not isOpen then
		txtLock.text = FuncOpenModel.instance:getFuncLockDescription(cfg.funcId)
	end

	local isRed = false

	goutil.setActive(goImgPoint, isRed)

	txtBtnSure.text = isOpen and "前往" or "已结束"

	GameUtil.SetGray(btnSure.gameObject, not isOpen)
	btnSure:AddClickListener(function()
		if not isOpen then
			return
		end

		if not string.nilorempty(cfg.jumpTo) then
			GotoMgr.gotoByString(cfg.jumpTo)
		end
	end)
end

return GodcollblessView
