-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/view/OriMatGameBuffSelectView.lua

module("logic.extensions.orimatgame.view.OriMatGameBuffSelectView", package.seeall)

local OriMatGameBuffSelectView = class("OriMatGameBuffSelectView", ViewComponent)

function OriMatGameBuffSelectView:buildUI()
	OriMatGameBuffSelectView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")

	local buffScrView = self:getGo("buffCol/scrView")
	local buffScrCell = self:getGo("buffCol/scrCell")

	self._buffScrollerList = ScrollerList.create(buffScrView, buffScrCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))

	self._buffScrollerList:setCenterMode(true)
end

function OriMatGameBuffSelectView:bindEvents()
	OriMatGameBuffSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function OriMatGameBuffSelectView:unbindEvents()
	OriMatGameBuffSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function OriMatGameBuffSelectView:onEnter()
	OriMatGameBuffSelectView.super.onEnter(self)

	self._selectedBlessingId = nil
	self._blessingIds = OriMatGameGameController.instance:getRandomBlessings(3)

	if #self._blessingIds <= 0 then
		local tipsContent = "没有可选的祝福"

		local function okFunc()
			self:close()
		end

		TipsFacade.instance:openTipWindowNoX("提示", tipsContent, okFunc, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self:_onUpdate()
end

function OriMatGameBuffSelectView:onExit()
	OriMatGameBuffSelectView.super.onExit(self)
	self._buffScrollerList:dispose()
	GlobalDispatcher:dispatch(GlobalNotify.OriMatGameResumesRunning)
end

function OriMatGameBuffSelectView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function OriMatGameBuffSelectView:_onUpdateData()
	local blessingCfgList = {}

	for _, blessingId in ipairs(self._blessingIds) do
		local blessingCfg = OriMatGameConfig.instance:getBlessingCfg(blessingId)

		if blessingCfg then
			table.insert(blessingCfgList, blessingCfg)
		end
	end

	self._blessingCfgList = blessingCfgList
end

function OriMatGameBuffSelectView:_onUpdateUI()
	self._buffScrollerList:reloadData(self._blessingCfgList)
	GameUtil.SetGray(self._btnSure, self._selectedBlessingId == nil)
end

function OriMatGameBuffSelectView:_updateBuffCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local blessingCfg = data
	local blessingId = blessingCfg.blessingId
	local buffCfg = OriMatGameConfig.instance:getBuffCfg(blessingCfg.buffId)
	local weaponCfg = OriMatGameConfig.instance:getWeaponCfg(blessingCfg.weaponId)
	local icon = goutil.findChild(mainGo, "icon")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local tagSelect = goutil.findChild(mainGo, "tagSelect")
	local weapIcon = goutil.findChild(mainGo, "weapIcon")
	local iconUrl = string.format("ui/icon/%s.png", data.iconUrl)

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, iconUrl)

	local weaponSpriteChange = GameUtil.getUIImageSpriteChange(weapIcon)

	weaponSpriteChange:ChangeSprite(weaponCfg.weaponPic)
	weapIcon:GetComponent(goutil.Type_UIImage):SetNativeSize()

	txtName.text = blessingCfg.name
	txtDesc.text = blessingCfg.desc

	local isSelected = self._selectedBlessingId == blessingId

	GameUtil.SetActive(tagSelect, isSelected)
	GameUtil.addClickHandler(mainGo, function()
		self._selectedBlessingId = blessingId

		self:_onUpdateUI()
	end)
end

function OriMatGameBuffSelectView:_clearBuffCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	uGuiUtil.clearImage(icon)
	GameUtil.rmClickHandler(mainGo)
end

function OriMatGameBuffSelectView:_onClickBtnSure()
	if not self._selectedBlessingId then
		FloatWordMgr.instance:show("请选择一个祝福")

		return
	end

	OriMatGameGameController.instance:applyBlessingBuff(self._selectedBlessingId)

	local unselectedBlessingIds = {}

	for _, blessingId in ipairs(self._blessingIds) do
		if blessingId ~= self._selectedBlessingId then
			table.insert(unselectedBlessingIds, blessingId)
		end
	end

	OriMatGameGameController.instance:returnBlessings(unselectedBlessingIds)
	self:close()
end

return OriMatGameBuffSelectView
