-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Equip\\EquipBuildMaterialPanel.lua

local ResEquipBuildMisc = require("ClientData/ResEquipBuildMisc")
local ResEquipTowerCustomEquipEffect = require("ClientData/ResEquipTowerCustomEquipEffect")
local strClassName = "EquipBuildMaterialPanel"
local EquipBuildMaterialPanel = Class(strClassName, UIControls.Panel)

function EquipBuildMaterialPanel:ctor()
	self:initUI()
end

function EquipBuildMaterialPanel:initUI()
	self.btnBuild = UIControls.Button(self, self.mPath .. "/BtnPowerUp", "Text")

	self.btnBuild:addEventClick(self.onBtnBuildClick)

	self.btnEquipGrid = UIControls.Button(self, self.mPath .. "/GridEquip/BtnChoose")

	self.btnEquipGrid:addEventClick(self.onBtnEquipClick)

	self.btnStoneGrid = UIControls.Button(self, self.mPath .. "/GridHeroStone/BtnChoose")

	self.btnStoneGrid:addEventClick(self.onBtnStoneClick)

	self.btnChange = UIControls.Button(self, self.mPath .. "/BtnChange")

	self.btnChange:addEventClick(self.onBtnChangeListClick)

	self.txtBuildGold = UIControls.Label(self, self.mPath .. "/BtnPowerUp/TextNum")
	self.iconMoney = UIControls.Image(self, self.mPath .. "/BtnPowerUp/TextNum/IconMoney")
	self.txtCommonNum = UIControls.Label(self, self.mPath .. "/GridCommonStone/BgNum/TextNum")
	self.imgCommonHigh = UIControls.Image(self, self.mPath .. "/GridCommonStone/LinkPanel/ImgHigh")
	self.imgCommonCom = UIControls.Image(self, self.mPath .. "/GridCommonStone/LinkPanel/ImgCommon")
	self.imgCommonDis = UIControls.Image(self, self.mPath .. "/GridCommonStone/LinkPanel/ImgDis")
	self.efxCommon = UIControls.Panel(self, self.mPath .. "/GridCommonStone/EfxHigh")
	self.imgEquipHigh = UIControls.Image(self, self.mPath .. "/GridEquip/LinkPanel/ImgHigh")
	self.imgEquipCom = UIControls.Image(self, self.mPath .. "/GridEquip/LinkPanel/ImgCommon")
	self.imgEquipDis = UIControls.Image(self, self.mPath .. "/GridEquip/LinkPanel/ImgDis")
	self.efxEquip = UIControls.Panel(self, self.mPath .. "/GridEquip/EfxHigh")
	self.txtStoneNum = UIControls.Label(self, self.mPath .. "/GridHeroStone/BgNum/TextNum")
	self.imgStoneHigh = UIControls.Image(self, self.mPath .. "/GridHeroStone/LinkPanel/ImgHigh")
	self.imgStoneCom = UIControls.Image(self, self.mPath .. "/GridHeroStone/LinkPanel/ImgCommon")
	self.imgStoneDis = UIControls.Image(self, self.mPath .. "/GridHeroStone/LinkPanel/ImgDis")
	self.efxStone = UIControls.Panel(self, self.mPath .. "/GridHeroStone/EfxHigh")
	self.imgEquipChoose = UIControls.Image(self, self.mPath .. "/GridEquip/ImgChosen")
	self.imgEquipChooseBg = UIControls.Image(self, self.mPath .. "/GridEquip/Bg")
	self.imgStoneChoose = UIControls.Image(self, self.mPath .. "/GridHeroStone/ImgChosen")
	self.imgStoneChooseBg = UIControls.Image(self, self.mPath .. "/GridHeroStone/Bg")
	self.efxPreview = UIControls.Panel(self, self.mPath .. "/GridEquipPreview/EfxHigh")
	self.anim = UIControls.UIAni(self, self.mPath .. "/AniPowerUpPanel")
	self.panelMaterialLight = UIControls.Panel(self, self.mPath .. "/AniPowerUpPanel/MaterialLightPanel")
	self.bgDes = UIControls.Panel(self, self.mPath .. "/BgDes")
	self.textDes = UIControls.Label(self, self.mPath .. "/BgDes/Text")
end

function EquipBuildMaterialPanel:setData()
	self.buildType = self.mWindow.buildType
	self.equip = self.mWindow.targetEquip
	self.stone = self.mWindow.targetStone

	self:updateMaterialCostNum()

	local fakeItemCommon = BaseObject.GetObject(self.commonItemId)

	self.itemGridCommon = UIControls.ItemGridChild(self, self.mPath .. "/GridCommonStone/GridPanel", "System/Common/Grid/GridMaterialItem", 0, 0, true)

	self.itemGridCommon:setObj(fakeItemCommon)
	self.imgEquipChoose:setVisible(self.mWindow.listType == Const.BUILD_PANEL_TYPE_EQUIP)
	self.imgStoneChoose:setVisible(self.mWindow.listType == Const.BUILD_PANEL_TYPE_STONE)

	if self.mWindow.listType == Const.BUILD_PANEL_TYPE_EQUIP then
		self.imgEquipChooseBg:setImage("Atlas/HeroAtlas/HeroEquipPowerUpAtlas", "BgFrameChoice2")
		self.imgStoneChooseBg:setImage("Atlas/HeroAtlas/HeroEquipPowerUpAtlas", "BgFrameChoice1")
	else
		self.imgEquipChooseBg:setImage("Atlas/HeroAtlas/HeroEquipPowerUpAtlas", "BgFrameChoice1")
		self.imgStoneChooseBg:setImage("Atlas/HeroAtlas/HeroEquipPowerUpAtlas", "BgFrameChoice2")
	end

	local moneyInfo = ClientUtils.getMoneyIcon(self.moneyId)

	if moneyInfo then
		self.iconMoney:setImage(moneyInfo[1], moneyInfo[2])
	end

	self.txtBuildGold:setText(self.goldNum or 0)
	self:updateStoneInfo()
	self:updateEquipInfo()

	if self:checkCanBuild() then
		if not self.gridBuildEquip then
			self.gridBuildEquip = UIControls.EquipGridChild(self, self.mPath .. "/GridEquipPreview", "System/Common/Grid/GridEquipItem", 0, 0, true)
		end

		self.gridBuildEquip.mEnableTips = false

		local fakeEquip = BaseObject.CopyObject(self.equip)

		fakeEquip.defineEffectId = self.stone.resData.extend_args1
		fakeEquip.resDefineEffctData = ResEquipTowerCustomEquipEffect[self.stone.resData.extend_args1]
		fakeEquip.buildQuality = self.equip.buildQuality or 1
		fakeEquip.buildType = self.buildType
		fakeEquip.inWearing = self.equip.inWearing

		if self.buildType == Const.BUILD_TYPE_SPECIAL_QUIALITY_UP then
			fakeEquip.showBuildUp = true
		end

		self.gridBuildEquip:setObj(fakeEquip)
		self.mParent:updateEquip(fakeEquip)
		self.imgCommonHigh:setVisible(true)
		self.imgCommonCom:setVisible(false)
		self.imgEquipHigh:setVisible(true)
		self.imgEquipCom:setVisible(false)
		self.imgStoneHigh:setVisible(true)
		self.imgStoneCom:setVisible(false)
		self.efxCommon:setVisible(true)
		self.efxEquip:setVisible(true)
		self.efxStone:setVisible(true)
		self.efxPreview:setVisible(true)
		self.panelMaterialLight:setVisible(true)
	else
		if self.gridBuildEquip then
			self.gridBuildEquip:destroy()

			self.gridBuildEquip = nil
		end

		self.imgCommonHigh:setVisible(false)
		self.imgEquipHigh:setVisible(false)
		self.imgStoneHigh:setVisible(false)
		self.efxCommon:setVisible(false)
		self.efxEquip:setVisible(false)
		self.efxStone:setVisible(false)
		self.efxPreview:setVisible(false)
		self.panelMaterialLight:setVisible(false)
	end
end

function EquipBuildMaterialPanel:updateMaterialCostNum()
	for i, v in pairs(ResEquipBuildMisc) do
		self.goldNum = v.build_item_num
		self.moneyId = v.build_item_id or 100001
		self.commonItemId = v.item_id

		if self.buildType == Const.BUILD_TYPE_SPECIAL_QUIALITY_UP then
			self.commonNeedNum = v.develop_nor_num
			self.stoneNeedNum = v.develop_spe_num

			self.btnBuild:setText(Lang.get(56680))
		else
			self.commonNeedNum = v.build_nor_num
			self.stoneNeedNum = v.build_spe_num

			self.btnBuild:setText(Lang.get(55850))
		end
	end

	local itemNum = CurAvatar:getItemNumById(self.commonItemId)

	if itemNum < self.commonNeedNum then
		self.txtCommonNum:setText(string.format("<color=#ff0000>%d/%d</color>", itemNum, self.commonNeedNum))
		self.imgCommonCom:setVisible(false)
		self.imgCommonDis:setVisible(true)

		self.isCommonItemEnough = false
	else
		self.txtCommonNum:setText(string.format("<color=#ffffff>%d/%d</color>", itemNum, self.commonNeedNum))
		self.imgCommonCom:setVisible(true)
		self.imgCommonDis:setVisible(false)

		self.isCommonItemEnough = true
	end

	local myGoldNum = ClientUtils.getMoney(self.moneyId)

	if myGoldNum >= self.goldNum then
		self.isGoldEnough = true
	else
		self.isGoldEnough = false
	end
end

function EquipBuildMaterialPanel:updateEquipInfo()
	if self.equip then
		self.imgEquipCom:setVisible(true)
		self.imgEquipDis:setVisible(false)
	else
		self.imgEquipCom:setVisible(false)
		self.imgEquipDis:setVisible(true)
	end
end

function EquipBuildMaterialPanel:updateStoneInfo()
	if self.stone then
		if not self.itemGridStone then
			self.itemGridStone = UIControls.ItemGridChild(self, self.mPath .. "/GridHeroStone/GridPanel", "System/Common/Grid/GridMaterialItem", 0, 0, true)
		end

		self.itemGridStone.mEnableTips = false

		self.itemGridStone.btnSensor:setObjEnabled(false)

		local fakeItemStone = BaseObject.GetObject(self.stone.id, self.stone.num)

		self.itemGridStone:setObj(fakeItemStone)

		local stoneNum = CurAvatar:getItemNumById(self.stone.id)

		self.txtStoneNum:setVisible(true)

		if stoneNum < self.stoneNeedNum then
			self.txtStoneNum:setText(string.format("<color=#ff0000>%d/%d</color>", stoneNum, self.stoneNeedNum))
			self.imgStoneCom:setVisible(false)
			self.imgStoneDis:setVisible(true)

			self.isStoneEnough = false
		else
			self.txtStoneNum:setText(string.format("<color=#ffffff>%d/%d</color>", stoneNum, self.stoneNeedNum))
			self.imgStoneCom:setVisible(true)
			self.imgStoneDis:setVisible(false)

			self.isStoneEnough = true
		end

		self.bgDes:setVisible(true)

		local heroName = ""
		local desc = ""

		if Const.EQUIP_BUILD_OPEN and self.stone.resData.extend_args1 and ResEquipTowerCustomEquipEffect[self.stone.resData.extend_args1] then
			local heroId = ResEquipTowerCustomEquipEffect[self.stone.resData.extend_args1][1].hero_id
			local fakeHero = BaseObject.GetObject(heroId)

			heroName = fakeHero.name
		end

		if self.buildType == Const.BUILD_TYPE_SPECIAL_QUIALITY_UP then
			desc = string.format(Lang.get(96568), heroName)
		else
			desc = string.format(Lang.get(96569), heroName)
		end

		self.textDes:setText(desc)
	else
		if self.itemGridStone then
			self.itemGridStone:destroy()

			self.itemGridStone = nil
		end

		self.txtStoneNum:setVisible(false)
		self.imgStoneCom:setVisible(false)
		self.imgStoneDis:setVisible(true)
		self.bgDes:setVisible(false)
	end
end

function EquipBuildMaterialPanel:checkCanBuild()
	local buildQuality = 0

	if self.equip and self.equip.buildQuality then
		buildQuality = self.equip.buildQuality
	end

	return self.equip and self.stone and self.isStoneEnough and self.isCommonItemEnough and buildQuality < Const.EQUIP_BUILD_MAX and self.isGoldEnough
end

function EquipBuildMaterialPanel:onBtnBuildClick()
	if self:checkCanBuild() then
		self.anim:startAni("AniPowerUp", true)

		if self.buildType == Const.BUILD_TYPE_SPECIAL_QUIALITY_UP then
			RPC.equipBuildLevelUp(self.equip.gid, self.stone.id)
		else
			RPC.equipBuild(self.equip.gid, self.stone.id)
		end
	elseif self.equip == nil then
		MsgManager.clientNotice(651)
	elseif self.stone == nil then
		MsgManager.clientNotice(652)
	elseif not self.isStoneEnough then
		MsgManager.clientNotice(654)
	elseif not self.isCommonItemEnough then
		MsgManager.clientNotice(653)
	elseif self.equip.buildQuality and self.equip.buildQuality >= Const.EQUIP_BUILD_MAX then
		MsgManager.clientNotice(655)
	elseif not self.isGoldEnough then
		MsgManager.notice(Lang.get(78294))
	end
end

function EquipBuildMaterialPanel:onBtnEquipClick()
	self.imgEquipChoose:setVisible(true)
	self.imgStoneChoose:setVisible(false)

	if self.mWindow.listType == Const.BUILD_PANEL_TYPE_EQUIP then
		self.mWindow:clearEquip()
	else
		self.mWindow:refreshItemList(Const.BUILD_PANEL_TYPE_EQUIP)
	end
end

function EquipBuildMaterialPanel:onBtnStoneClick()
	self.imgEquipChoose:setVisible(false)
	self.imgStoneChoose:setVisible(true)

	if self.mWindow.listType == Const.BUILD_PANEL_TYPE_STONE then
		self.mWindow:clearStone()
	else
		self.mWindow:refreshItemList(Const.BUILD_PANEL_TYPE_STONE)
	end
end

function EquipBuildMaterialPanel:onBtnChangeListClick()
	if self.mWindow.listType == Const.BUILD_PANEL_TYPE_STONE then
		self.imgEquipChoose:setVisible(true)
		self.imgStoneChoose:setVisible(false)
		self.mWindow:refreshItemList(Const.BUILD_PANEL_TYPE_EQUIP)
	else
		self.imgEquipChoose:setVisible(false)
		self.imgStoneChoose:setVisible(true)
		self.mWindow:refreshItemList(Const.BUILD_PANEL_TYPE_STONE)
	end
end

return EquipBuildMaterialPanel
