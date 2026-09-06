-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/view/OriMatGameWeaponTipsWinView.lua

module("logic.extensions.orimatgame.view.OriMatGameWeaponTipsWinView", package.seeall)

local OriMatGameWeaponTipsWinView = class("OriMatGameWeaponTipsWinView", ViewComponent)

function OriMatGameWeaponTipsWinView:buildUI()
	OriMatGameWeaponTipsWinView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._weaponIcon = self:getGo("infoCol/weaponIcon")
	self._txtName = self:getTxt("infoCol/name/txt")
	self._txtAttack = self:getTxt("infoCol/attack/txt")
	self._txtRange = self:getTxt("infoCol/range/txt")
	self._txtDuration = self:getTxt("infoCol/duration/txt")
	self._btnTipInfo = self:getGo("infoCol/btnTip")
	self._txtWeaponDesc = self:getTxt("infoCol/txtWeaponDesc")

	local blessingScrView = self:getGo("blessingCol/scrView")
	local blessingScrCell = self:getGo("blessingCol/scrCell")

	self._blessingScrollerList = ScrollerList.create(blessingScrView, blessingScrCell, GameUtil.handler(self._updateBlessingCell, self), GameUtil.handler(self._clearBlessingCell, self))
end

function OriMatGameWeaponTipsWinView:bindEvents()
	OriMatGameWeaponTipsWinView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTipInfo, self._onClickBtnTipInfo, self)
end

function OriMatGameWeaponTipsWinView:unbindEvents()
	OriMatGameWeaponTipsWinView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTipInfo)
end

function OriMatGameWeaponTipsWinView:onEnter()
	OriMatGameWeaponTipsWinView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._weaponId = checknumber(params[1])
	self._level = 1
	self._weaponCfg = OriMatGameConfig.instance:getWeaponCfg(self._weaponId)
	self._weaponLevelCfg = OriMatGameConfig.instance:getWeaponLevelCfgByWeapon(self._weaponId, self._level)

	if not self._weaponCfg then
		printError("OriMatGameWeaponTipsWinView:onEnter 武器配置不存在, weaponId:", self._weaponId)
		self:close()

		return
	end

	if not self._weaponLevelCfg then
		printError("OriMatGameWeaponTipsWinView:onEnter 武器等级配置不存在, weaponId:", self._weaponId, " level:", self._level)
		self:close()

		return
	end

	self:_onUpdate()
end

function OriMatGameWeaponTipsWinView:onExit()
	OriMatGameWeaponTipsWinView.super.onExit(self)
	self:_onClearBlessingCol()
end

function OriMatGameWeaponTipsWinView:_onUpdate()
	self._txtName.text = self._weaponCfg.weaponName or ""

	local spriteChange = GameUtil.getUIImageSpriteChange(self._weaponIcon)

	spriteChange:ChangeSprite(self._weaponCfg.weaponPic)
	self._weaponIcon:GetComponent(goutil.Type_UIImage):SetNativeSize()

	self._txtWeaponDesc.text = self._weaponCfg.weaponDes
	self._txtAttack.text = self._weaponLevelCfg.baseAtk
	self._txtRange.text = self._weaponLevelCfg.baseAtkRadius
	self._txtDuration.text = self._weaponLevelCfg.baseAtkInterval

	self:_onUpdateBlessingCol()
end

function OriMatGameWeaponTipsWinView:_onUpdateBlessingCol()
	local blessingList = OriMatGameConfig.instance:getBlessingDataList(self._weaponId)

	self._blessingScrollerList:reloadData(blessingList)
end

function OriMatGameWeaponTipsWinView:_onClearBlessingCol()
	self._blessingScrollerList:dispose()
end

function OriMatGameWeaponTipsWinView:_updateBlessingCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local buffData = OriMatGameConfig.instance:getBuffCfg(data.buffId)
	local icon = goutil.findChild(mainGo, "icon")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local iconUrl = string.format("ui/icon/%s.png", data.iconUrl)

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, iconUrl)

	txtDesc.text = data.desc
end

function OriMatGameWeaponTipsWinView:_clearBlessingCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	uGuiUtil.clearImage(icon)
end

function OriMatGameWeaponTipsWinView:_onClickBtnTipInfo()
	OriMatGameController.instance:openWeaponUpgradeDescTipsView(self._weaponId, self._btnTipInfo)
end

return OriMatGameWeaponTipsWinView
