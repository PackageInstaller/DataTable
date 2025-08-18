-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\SceneUI\\RearHouseNewCrystalDlg.lua

local RearHouseDragCenter = require("Logic/RearHouse/RearHouseDragCenter")
local ImageType = typeof(UnityEngine.UI.Image)
local LabelType = typeof(UnityEngine.UI.Text)
local RearHouseModelCenter = require("Logic/RearHouse/RearHouseModelCenter")
local LoadUtils = require("Entity/LoadUtils")
local UserData = require("Helper/UserData")
local OLD_STAGE_NAME = "art_one/fn_wj_tai_05_01"
local SECOND_STAGE_NAME = "art_one/fn_wj_tai_05_02"
local SECOND_STAGE_EFF_NAME = "art_one/fn_wj_tai_05_02/efx_scene_crystal"
local RearHouseNewCrystalDlg = Class("RearHouseNewCrystalDlg")

function RearHouseNewCrystalDlg:ctor()
	self.goOldStage = UnityEngine.GameObject.Find(OLD_STAGE_NAME).gameObject
	self.goSecondStage = UnityEngine.GameObject.Find(SECOND_STAGE_NAME).gameObject
	self.goSecondStageEff = UnityEngine.GameObject.Find(SECOND_STAGE_EFF_NAME).gameObject
	self.loaderId = LoadUtils.loadPrefabSync("Drag/RearHouse/WorldBackyardLv.prefab", Slot(self.onPrefabGOLoaded, self))
end

local MAX_NEW_LV_STAR = 10
local OLD_LV_NUM = 5

function RearHouseNewCrystalDlg:onPrefabGOLoaded(go)
	self.mObject = go
	self.panelOldLv = self.mObject.transform:Find("OldLvInfo")
	self.oldLvBgs = {}
	self.oldLvLabels = {}

	for index = 1, OLD_LV_NUM do
		self.oldLvBgs[index] = self.mObject.transform:Find("OldLvInfo/Img" .. index)
		self.oldLvLabels[index] = self.mObject.transform:Find("OldLvInfo/Img" .. index .. "/TextLv0" .. index):GetComponent(LabelType)
	end

	self.panelNewLv = self.mObject.transform:Find("NewLvInfo")
	self.labelOldLv = self.mObject.transform:Find("NewLvInfo/TextOldLvNum"):GetComponent(LabelType)
	self.labelNewLv = self.mObject.transform:Find("NewLvInfo/ImgNewLv/TextLvNum"):GetComponent(LabelType)
	self.panelLvs = {}
	self.panelLvEff = {}

	for index = 1, MAX_NEW_LV_STAR do
		self.panelLvs[index] = self.mObject.transform:Find("NewLvInfo/LvSlider/ImgLv" .. index)
		self.panelLvEff[index] = self.mObject.transform:Find("NewLvInfo/LvSlider/ImgLv" .. index .. "/ImgHighlight")
	end

	self.panelNewEfx = self.mObject.transform:Find("NewLvInfo/Efx")
	self.panelNewImg = self.mObject.transform:Find("NewLvInfo/ImgNewLv/IconNewCat")
	self.panelUnlockEfx = self.mObject.transform:Find("NewLvInfo/Efx2")

	self:onRefreshLevel()
end

function RearHouseNewCrystalDlg:clear()
	self.mObject = nil

	if self.loaderId then
		LoadUtils.UnLoadPrefab(self.loaderId)

		self.loaderId = nil
	end

	if self.coShowSecondUnlock then
		coroutine.stop(self.coShowSecondUnlock)

		self.coShowSecondUnlock = nil
	end
end

function RearHouseNewCrystalDlg:checkSecondUnlock()
	if CurAvatar:isCrystalSecondPartNew() and not CurAvatar:isBeginnerFinished(330) then
		self:playSecondUnlock()
	end
end

function RearHouseNewCrystalDlg:playSecondUnlock()
	self.goSecondStageEff:SetActive(true)

	self.coShowSecondUnlock = coroutine.start(self.funcCoShowSecondUnlock, self)
end

function RearHouseNewCrystalDlg:funcCoShowSecondUnlock()
	coroutine.wait(1.5)
	UIManager.getUI("rearHouseUnlockDlg", true):setData({
		Lang.get(29963)
	})
	coroutine.wait(2)
	self.panelUnlockEfx.gameObject:SetActive(true)

	self.coShowSecondUnlock = nil
end

function RearHouseNewCrystalDlg:onClickCrystalStage()
	self.panelUnlockEfx.gameObject:SetActive(false)
end

function RearHouseNewCrystalDlg:onRefreshLevel()
	if RearHouseDragCenter.isInMode(Const.REARHOUSE_CREATE_MODE.VISIT) then
		self:onHideShow()

		if CurAvatar:isCrystalSecondPartNew() then
			self.goOldStage:SetActive(false)
			self.goSecondStage:SetActive(true)
		else
			self.goOldStage:SetActive(true)
			self.goSecondStage:SetActive(false)
		end

		return
	end

	self.isNewStep = CurAvatar:isCrystalSecondPartNew()

	if self.isNewStep then
		self.goOldStage:SetActive(false)
		self.goSecondStage:SetActive(true)
		self.goSecondStageEff:SetActive(false)
		self.panelOldLv.gameObject:SetActive(false)
		self.panelNewLv.gameObject:SetActive(true)

		if Const.REVIEW_VERSION then
			self.labelOldLv.text = Lang.get(1203) .. CurAvatar.crystalData.level
		else
			self.labelOldLv.text = "LV." .. CurAvatar.crystalData.level
		end

		local showLevel, star, maxStar, nextLevelData = ClientUtils.GetCrystalNewLevelState()

		self.labelNewLv.text = showLevel

		for index, cell in ipairs(self.panelLvEff) do
			cell.gameObject:SetActive(index <= star)
		end
	else
		self.goOldStage:SetActive(true)
		self.goSecondStage:SetActive(false)
		self.panelOldLv.gameObject:SetActive(true)
		self.panelNewLv.gameObject:SetActive(false)

		local levelData = RearHouseModelCenter.levelData or {}

		for index, cell in ipairs(self.oldLvLabels) do
			if levelData[index] then
				self.oldLvBgs[index].gameObject:SetActive(true)

				if Const.REVIEW_VERSION then
					cell.text = Lang.get(1203) .. levelData[index].level
				else
					cell.text = "LV." .. levelData[index].level
				end

				cell.color = levelData[index].color
			else
				self.oldLvBgs[index].gameObject:SetActive(false)
			end
		end
	end

	self:checkSecondNew()
end

function RearHouseNewCrystalDlg:checkSecondNew()
	if CurAvatar:isCrystalSecondPartNew() and RedDotManager.getKeyState(UIConst.RD_HINT_REAR_HOUSE_CRYSTLE) then
		self.panelNewImg.gameObject:SetActive(true)
		self.panelNewEfx.gameObject:SetActive(true)
	else
		self.panelNewImg.gameObject:SetActive(false)
		self.panelNewEfx.gameObject:SetActive(false)
	end
end

function RearHouseNewCrystalDlg:onHideShow()
	self.panelOldLv.gameObject:SetActive(false)
	self.panelNewLv.gameObject:SetActive(false)
end

return RearHouseNewCrystalDlg
