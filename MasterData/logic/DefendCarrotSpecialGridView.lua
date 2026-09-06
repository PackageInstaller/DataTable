-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/view/DefendCarrotSpecialGridView.lua

module("logic.extensions.defendcarrot.view.DefendCarrotSpecialGridView", package.seeall)

local DefendCarrotSpecialGridView = class("DefendCarrotSpecialGridView", ViewComponent)

function DefendCarrotSpecialGridView:ctor()
	DefendCarrotSpecialGridView.super.ctor(self)
end

function DefendCarrotSpecialGridView:unbindEvents()
	DefendCarrotSpecialGridView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DefendCarrotSpecialGridView:bindEvents()
	DefendCarrotSpecialGridView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DefendCarrotSpecialGridView:buildUI()
	DefendCarrotSpecialGridView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tableview/tablecell")
	self._tableview = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DefendCarrotSpecialGridView:onExit()
	DefendCarrotSpecialGridView.super.onExit(self)
	GlobalDispatcher:dispatch(GlobalNotify.DefendCarrotGameResumesRunning)
	self._tableview:dispose()
end

function DefendCarrotSpecialGridView:onEnter()
	DefendCarrotSpecialGridView.super.onEnter(self)

	self._curActivityId = 0
	self._curStageId = 0

	local params = self:getOpenParam()

	if params then
		self._curActivityId = checknumber(params[1])
		self._curStageId = checknumber(params[2])
	end

	if self._curActivityId <= 0 then
		self._curActivityId = 517001
	end

	self:_updateUI()
end

function DefendCarrotSpecialGridView:_updateUI()
	local specialGridCfgs = DefendCarrotConfig.instance:getAllMapBuffCfgs() or {}
	local dataList = {}

	for _, cfg in ipairs(specialGridCfgs) do
		if cfg.isShow then
			table.insert(dataList, cfg)
		end
	end

	self._tableview:reloadData(dataList)
end

function DefendCarrotSpecialGridView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local weaponId = checknumber(data.weaponId)
	local weaponCfg = DefendCarrotConfig.instance:getWeaponCfg(self._curActivityId, weaponId)
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local iconWeapon = goutil.findChildComponent(go, "weaponicon", "UIImageSpriteChange")
	local imageIcon = iconWeapon:GetComponent(goutil.Type_UIImage)
	local imgBubble = goutil.findChildComponent(go, "bubble", "Image")

	iconWeapon:ChangeSprite(weaponCfg.weaponPic)
	imageIcon:SetNativeSize()

	txtDesc.text = data.buffDesc or ""

	Framework.ColorUtil.SetImageColor(imgBubble, data.background)
end

function DefendCarrotSpecialGridView:_clearCell(cell)
	return
end

return DefendCarrotSpecialGridView
