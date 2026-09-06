-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/view/OriMatGameWeaponView.lua

module("logic.extensions.orimatgame.view.OriMatGameWeaponView", package.seeall)

local OriMatGameWeaponView = class("OriMatGameWeaponView", ViewComponent)

function OriMatGameWeaponView:buildUI()
	OriMatGameWeaponView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._weaponIcon = self:getGo("infoCol/weaponIcon")
	self._txtName = self:getTxt("infoCol/name/txt")
	self._txtAttack = self:getTxt("infoCol/attack/txt")
	self._txtRange = self:getTxt("infoCol/range/txt")
	self._txtDuration = self:getTxt("infoCol/duration/txt")
	self._btnTipInfo = self:getGo("infoCol/btnTip")
	self._txtWeaponDesc = self:getTxt("infoCol/txtWeaponDesc")

	local blessingScrView = self:getGo("blessingView/scrView")
	local blessingScrCell = self:getGo("blessingView/scrCell")

	self._blessingScrollerList = ScrollerList.create(blessingScrView, blessingScrCell, GameUtil.handler(self._updateBlessingCell, self), GameUtil.handler(self._clearBlessingCell, self))

	local weaponScrView = self:getGo("weaponCol/scrView")
	local weaponScrCell = self:getGo("weaponCol/scrCell")

	self._weaponScrollerList = ScrollerList.create(weaponScrView, weaponScrCell, GameUtil.handler(self._updateWeaponCell, self), GameUtil.handler(self._clearWeaponCell, self))
end

function OriMatGameWeaponView:bindEvents()
	OriMatGameWeaponView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnTipInfo, self._onClickBtnTipInfo, self)
end

function OriMatGameWeaponView:unbindEvents()
	OriMatGameWeaponView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnTipInfo)
end

function OriMatGameWeaponView:onEnter()
	OriMatGameWeaponView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])
	self._subMo = OriMatGameController.instance:getSubMo(self._seasonId)

	local seasonData = OriMatGameConfig.instance:getSeasonData(self._seasonId)

	if seasonData then
		self._weaponPlanId = seasonData.weaponPlanId or 0
	end

	local cfg = OriMatGameConfig.instance:getWeaponPlanCfg(self._weaponPlanId)

	if cfg then
		if not cfg.weaponIdList then
			local weaponIdList = {}

			self._currentWeaponId = weaponIdList[1] or 0
			self._level = 1

			self:_onUpdate()
		end
	end
end

function OriMatGameWeaponView:onExit()
	OriMatGameWeaponView.super.onExit(self)
	self._blessingScrollerList:dispose()
	self._weaponScrollerList:dispose()
end

function OriMatGameWeaponView:_onUpdate()
	self:_onUpdateWeaponCol()
	self:_onUpdateWeaponInfo()
end

function OriMatGameWeaponView:_onUpdateWeaponCol()
	local cfg = OriMatGameConfig.instance:getWeaponPlanCfg(self._weaponPlanId)

	if cfg then
		if not cfg.weaponIdList then
			local weaponIdList = {}
			local weaponDataList = {}

			for _, weaponId in ipairs(weaponIdList) do
				local data = OriMatGameConfig.instance:getWeaponCfg(weaponId)

				if data then
					table.insert(weaponDataList, data)
				end
			end

			table.sort(weaponDataList, function(a, b)
				local isNewA = self._subMo:isNewWeapon(a.weaponId)
				local isNewB = self._subMo:isNewWeapon(b.weaponId)

				if isNewA == isNewB then
					return a.weaponId < b.weaponId
				end

				return isNewA and not isNewB
			end)
			self._weaponScrollerList:reloadData(weaponDataList)
		end
	end
end

function OriMatGameWeaponView:_updateWeaponCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local weaponId = data.weaponId
	local icon = goutil.findChild(mainGo, "icon")
	local tagSelect = goutil.findChild(mainGo, "tagSelect")
	local tagNew = goutil.findChild(mainGo, "tagNew")
	local spriteChange = GameUtil.getUIImageSpriteChange(icon)

	spriteChange:ChangeSprite(data.weaponPic)
	icon:GetComponent(goutil.Type_UIImage):SetNativeSize()

	local isSelected = self._currentWeaponId == weaponId

	GameUtil.SetActive(tagSelect, isSelected)

	local isNew = self._subMo:isNewWeapon(weaponId)

	GameUtil.SetActive(tagNew, isNew)
	GameUtil.addClickHandler(mainGo, function()
		self._currentWeaponId = weaponId

		self:_onUpdateWeaponInfo()
		self._weaponScrollerList:reloadData(self._weaponScrollerList:getData())
	end)
end

function OriMatGameWeaponView:_clearWeaponCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function OriMatGameWeaponView:_onUpdateWeaponInfo()
	local weaponCfg = OriMatGameConfig.instance:getWeaponCfg(self._currentWeaponId)
	local weaponLevelCfg = OriMatGameConfig.instance:getWeaponLevelCfgByWeapon(self._currentWeaponId, self._level)

	self._txtName.text = weaponCfg.weaponName or ""

	local spriteChange = GameUtil.getUIImageSpriteChange(self._weaponIcon)

	spriteChange:ChangeSprite(weaponCfg.weaponPic)
	self._weaponIcon:GetComponent(goutil.Type_UIImage):SetNativeSize()

	self._txtWeaponDesc.text = weaponCfg.weaponDes
	self._txtAttack.text = weaponLevelCfg.baseAtk
	self._txtRange.text = weaponLevelCfg.baseAtkRadius
	self._txtDuration.text = weaponLevelCfg.baseAtkInterval

	self:_onUpdateBlessingCol()
end

function OriMatGameWeaponView:_onUpdateBlessingCol()
	local blessingList = OriMatGameConfig.instance:getBlessingDataList(self._currentWeaponId)

	self._blessingScrollerList:reloadData(blessingList)
end

function OriMatGameWeaponView:_updateBlessingCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local buffData = OriMatGameConfig.instance:getBuffCfg(data.buffId)
	local icon = goutil.findChild(mainGo, "icon")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local iconUrl = string.format("ui/icon/%s.png", data.iconUrl)

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, iconUrl)

	txtDesc.text = data.desc
end

function OriMatGameWeaponView:_clearBlessingCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	uGuiUtil.clearImage(icon)
end

function OriMatGameWeaponView:_onClickBtnTip()
	local key = OriMatGameConfig.instance:getCommonValue("RULEKEY_WEAPON", false)

	TipsFacade.instance:openRulesView(key)
end

function OriMatGameWeaponView:_onClickBtnTipInfo()
	OriMatGameController.instance:openWeaponUpgradeDescTipsView(self._currentWeaponId, self._btnTipInfo)
end

return OriMatGameWeaponView
