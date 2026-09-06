-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/view/OriMatGameSpecialGridView.lua

module("logic.extensions.orimatgame.view.OriMatGameSpecialGridView", package.seeall)

local OriMatGameSpecialGridView = class("OriMatGameSpecialGridView", ViewComponent)

function OriMatGameSpecialGridView:ctor()
	OriMatGameSpecialGridView.super.ctor(self)
end

function OriMatGameSpecialGridView:unbindEvents()
	OriMatGameSpecialGridView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function OriMatGameSpecialGridView:bindEvents()
	OriMatGameSpecialGridView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function OriMatGameSpecialGridView:buildUI()
	OriMatGameSpecialGridView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tableview/tablecell")
	self._tableview = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function OriMatGameSpecialGridView:onExit()
	OriMatGameSpecialGridView.super.onExit(self)
	GlobalDispatcher:dispatch(GlobalNotify.OriMatGameResumesRunning)
	self._tableview:dispose()
end

function OriMatGameSpecialGridView:onEnter()
	OriMatGameSpecialGridView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._mapBuffIdList = params[1] or {}

	self:_updateUI()
end

function OriMatGameSpecialGridView:_updateUI()
	local dataList = {}

	for _, mapBuffId in ipairs(self._mapBuffIdList) do
		local data = OriMatGameConfig.instance:getMapBuffCfg(mapBuffId)

		if data then
			table.insert(dataList, data)
		end
	end

	self._tableview:reloadData(dataList)
end

function OriMatGameSpecialGridView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local weaponId = checknumber(data.weaponId)
	local weaponCfg = OriMatGameConfig.instance:getWeaponCfg(weaponId)
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local iconWeapon = goutil.findChildComponent(go, "weaponicon", "UIImageSpriteChange")
	local imageIcon = iconWeapon:GetComponent(goutil.Type_UIImage)
	local imgBubble = goutil.findChildComponent(go, "bubble", "Image")

	iconWeapon:ChangeSprite(weaponCfg.weaponPic)
	imageIcon:SetNativeSize()

	txtDesc.text = data.buffDesc or ""

	Framework.ColorUtil.SetImageColor(imgBubble, data.background)
end

function OriMatGameSpecialGridView:_clearCell(cell)
	return
end

return OriMatGameSpecialGridView
