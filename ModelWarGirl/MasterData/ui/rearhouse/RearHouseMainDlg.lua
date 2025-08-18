-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\RearHouseMainDlg.lua

local RearHouseDragObject = require("Logic/RearHouse/RearHouseDragObject")
local RearHouseDragCenter = require("Logic/RearHouse/RearHouseDragCenter")
local ResRearHouse = require("ClientData/ResRearHouse")
local ResCommonHardCode = require("ClientData/ResCommonHardCode")
local ResRearHouseMiscConfig = require("ClientData/ResRearHouseMiscConfig")
local ResRearHouseBagConfig = require("ClientData/ResRearHouseBagConfig")
local ResRearHouseLevelConfig = require("ClientData/ResRearHouseLevelConfig")
local ResRearHouseSceneConfig = require("ClientData/ResRearHouseSceneConfig")
local ResHero = require("ClientData/ResHero")
local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local RearHouseModelCenter = require("Logic/RearHouse/RearHouseModelCenter")
local RearHouseMoreRoomPanel = require("UI/RearHouse/RearHouseMoreRoomPanel")
local strClassName = "RearHouseMainDlg"
local RearHouseMainDlg = Class(strClassName, UIControls.Window)
local HOUSE_SHARE_CD = ResCommonHardCode[46].value[1]

function RearHouseMainDlg:ctor(...)
	self:initUI()
end

function RearHouseMainDlg:onClose(...)
	RearHouseMainDlg.super.onClose(self)
	RearHouseDragCenter.clearState(true)
end

function RearHouseMainDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.btnEdit = UIControls.Button(self, "Bg/BtnEdit", "TextNum")

	self.btnEdit:addEventClick(self.onBtnEditClick)

	self.btnShopDis = UIControls.Button(self, "Bg/BtnShopDis")

	self.btnShopDis:addEventClick(self.onBtnShopClick)

	self.btnShop = UIControls.Button(self, "Bg/BtnShop")

	self.btnShop:addEventClick(self.onBtnShopClick)

	self.imgEditNew = UIControls.Image(self, "Bg/BtnEdit/IconNew")
	self.redHintEditNew = UIControls.RedDot(self, "Bg/BtnEdit/IconNew")
	self.panelBlock = UIControls.Panel(self, "Block")
	self.redHintUpgrade = UIControls.RedDot(self, "Bg/BtnBackyardLv/IconNew")

	self.redHintUpgrade:addHint({
		UIConst.RD_HINT_REAR_HOUSE_UPGREAD_BTN
	})

	self.panelFuncBg = UIControls.Panel(self, "Bg")
	self.panelBg = UIControls.DragClickPanel(self, "DragBg")
	self.btnDispatch = UIControls.Button(self, "Bg/BtnDispatch")

	self.btnDispatch:addEventClick(self.onBtnDispatchClick)

	self.btnDispatchDis = UIControls.Button(self, "Bg/BtnDispatchDis")

	self.btnDispatchDis:addEventClick(self.onBtnDispatchClick)

	self.redHintDispath = UIControls.RedDot(self, "Bg/BtnDispatch/IconNew")

	self.redHintDispath:addHint({
		UIConst.RD_HINT_DISPATCH_AWARD
	})

	self.btnComfortable = UIControls.Button(self, "Bg/BtnComfortable", "TextNum")

	self.btnComfortable:addEventClick(self.onBtnComfortableClick)

	self.redHintComfortable = UIControls.RedDot(self, "Bg/BtnComfortable/IconNew")

	self.redHintComfortable:addHint({
		UIConst.RD_HINT_COMFORTABLE_AWARD
	})

	self.btnLv = UIControls.Button(self, "Bg/BtnBackyardLv", "TextNum")

	self.btnLv:addEventClick(self.onBtnLvClick)

	self.txtMaxLevel = UIControls.Label(self, "Bg/BtnBackyardLv/TextMax")
	self.btnHide = UIControls.Button(self, "Bg/BtnHide")

	self.btnHide:addEventClick(self.onBtnHideClick)

	self.btnClean = UIControls.Button(self, "Bg/BtnClean", "TextNum")

	self.btnClean:addEventClick(self.onBtnCleanClick)

	self.redHintClean = UIControls.RedDot(self, "Bg/BtnClean/IconNew")

	self.redHintClean:addHint({
		UIConst.RD_HINT_REAR_HOUSE_CLEAN
	})

	self.btnCleanDis = UIControls.Button(self, "Bg/BtnCleanDis")

	self.btnCleanDis:addEventClick(self.onBtnCleanClick)

	self.slider = UIControls.Slider(self, "Bg/Slider")

	self.slider:addEventValueChanged(self.onSliderValueChange)

	self.btnVisit = UIControls.Button(self, "Bg/BtnVisit")

	self.btnVisit:addEventClick(self.onBtnVisitClick)

	self.txtPopularity = UIControls.Label(self, "Bg/BtnPopularity/TextNum")
	self.btnRank = UIControls.Button(self, "Bg/BtnRank")

	self.btnRank:addEventClick(self.onBtnRankClick)

	self.btnAttr = UIControls.Button(self, "Bg/BtnAttr")

	self.btnAttr:addEventClick(self.onBtnAttrClick)

	self.btnShare = UIControls.Button(self, "Bg/BtnShare")

	self.btnShare:addEventClickCD(self.onBtnHouseShareClick, HOUSE_SHARE_CD, Lang.get(61564), CurAvatar.houseShareTime)

	self.btnChangeRoom = UIControls.Button(self, "Bg/BtnChangeRoom", "TextNum")

	self.btnChangeRoom:addEventClick(self.onBtnChangeRoomClick)

	self.imgChangeRoomNew = UIControls.Image(self, "Bg/BtnChangeRoom/IconNew")
	self.redHintChangeRoomNew = UIControls.RedDot(self, "Bg/BtnChangeRoom/IconNew")
	self.panelRoom = RearHouseMoreRoomPanel(self, "Bg/ChangeRoomPanel")
	self.btnPopularity = UIControls.Button(self, "Bg/BtnPopularity")

	self.btnPopularity:addEventClick(self.onClickBtnPopularity)

	self.redPopularity = UIControls.RedDot(self, "Bg/BtnPopularity/IconNew")

	self.redPopularity:addHint({
		UIConst.RD_HINT_REAR_HOUSE_POPULARITY_AWARD
	})

	self.hideFlag = false
	self.btnSetMainRoom = UIControls.Button(self, "Bg/BtnSetMainRoom")

	self.btnSetMainRoom:addEventClick(self.onBtnSetMainRoomClick)
end

function RearHouseMainDlg:onOpen(...)
	RearHouseMainDlg.super.onOpen(self)

	self.mainState = GameFsm.getState(Const.STATE_MAIN_REAR_HOUSE)

	RearHouseDragCenter.setMode(self)
	self.mainState:setCurUI(self)
	self:refreshUI()
	RearHouseDragCenter.refreshItems()
	BeginnerManager.CheckRearHouseLevel()
	CurAvatar:getRHCommentInfo()
end

function RearHouseMainDlg:setCameraControlState(min, max)
	self.btnFar:setEnable(not max)
	self.btnNear:setEnable(not min)
end

function RearHouseMainDlg:show()
	if CurAvatar.rearHouseState.unlock_award == 0 then
		-- block empty
	end
end

function RearHouseMainDlg:refreshUI(...)
	local data = CurAvatar.rearHouseData
	local wallIndex = RearHouseDragCenter.getCurZoneId()
	local own = RearHouseModelCenter.getPutedNum(Const.REARHOUSE_TYPE_HERO, wallIndex)
	local level = data.level
	local limit = RearHouseCommon.getLimitNumByType(Const.REARHOUSE_TYPE_HERO, wallIndex)

	self.uid = CurAvatar.uid

	self.btnEdit:setText(own .. "/" .. limit)
	self.btnComfortable:setText(data.comfort)

	local bigLv = ResRearHouseLevelConfig[data.level].level_part
	local lastPartLv = 0

	for i, info in ipairs(ResRearHouseLevelConfig) do
		if info.level_part == bigLv then
			lastPartLv = i - 1

			break
		end
	end

	local isShopOpen = RearHouseCommon.isShopUnlock()

	self.btnShopDis:setVisible(not isShopOpen)
	self.btnShop:setVisible(isShopOpen)

	local isDispatchOpen = RearHouseCommon.isDispatchUnlock()

	self.btnDispatchDis:setVisible(not isDispatchOpen)
	self.btnDispatch:setVisible(isDispatchOpen)

	if data.level >= #ResRearHouseLevelConfig then
		self.btnLv:setText("")
		self.txtMaxLevel:setVisible(true)
	else
		self.btnLv:setText(bigLv .. "." .. data.level - lastPartLv)
	end

	if RearHouseCommon.isCleanUnlock() then
		self.btnCleanDis:setVisible(false)
		self.btnClean:setVisible(true)

		if RearHouseCommon.isMaxCleanToday() then
			self.btnClean:setObjGray(true)
		else
			self.btnClean:setObjGray(false)
		end

		self.btnClean:setText(RearHouseCommon.getMaxCleanTimes() - RearHouseCommon.getTodayCleanTimes() .. "/" .. RearHouseCommon.getMaxCleanTimes())
	else
		self.btnCleanDis:setVisible(true)
		self.btnClean:setVisible(false)
	end

	local favorInfo = CurAvatar:getFavorInfo()

	if favorInfo then
		self.txtPopularity:setText(ClientUtils.getNumShortStr2(favorInfo.favoredNum))
	end

	local num = RearHouseCommon.getUnlockRoomNum(CurAvatar.rearHouseData.level)

	if num > 1 then
		self.btnChangeRoom:setVisible(true)
		self.btnChangeRoom:setText(wallIndex)
		self.btnSetMainRoom:setVisible(true)
	else
		self.btnChangeRoom:setVisible(false)
		self.btnSetMainRoom:setVisible(false)
	end

	self.panelRoom:refreshData()
	self:checkEditRedHint()
	self.redHintChangeRoomNew:clearHint()

	local redIds = {}

	for i = 1, num do
		table.insert(redIds, UIConst["RD_HINT_REAR_HOUSE_EDIT" .. i])
	end

	self.redHintChangeRoomNew:addHint(redIds)
	self:refreshBtnPopularity()
	self:refreshBtnMainRoomState()
end

function RearHouseMainDlg:refreshBtnMainRoomState()
	local wallIndex = RearHouseDragCenter.getCurZoneId()

	if CurAvatar.mainRoom and CurAvatar.mainRoom == wallIndex then
		self.btnSetMainRoom:setEnable(false)
	else
		self.btnSetMainRoom:setEnable(true)
	end
end

function RearHouseMainDlg:showUI(v)
	self.hideFlag = not v

	if self.panelFund then
		self.panelFund:setVisible(v)
	end

	self.btnClose:setVisible(v)
	self.btnTips:setVisible(v)
	self.panelFuncBg:setVisible(v)

	if not v then
		RearHouseDragCenter.clearState(true)
	end

	MsgManager.showMsgOnScreen(v)
end

function RearHouseMainDlg:setSliderValue(value)
	self.slider:setValue(value)
end

function RearHouseMainDlg:checkEditRedHint(...)
	local wallIndex = RearHouseDragCenter.getCurZoneId()

	self.redHintEditNew:clearHint()
	self.redHintEditNew:addHint({
		UIConst["RD_HINT_REAR_HOUSE_EDIT" .. wallIndex],
		UIConst.RD_HINT_REAR_HOUSE_NEW_ITEM
	})
end

function RearHouseMainDlg:onBtnChangeRoomClick(...)
	local num = RearHouseCommon.getUnlockRoomNum(CurAvatar.rearHouseData.level)

	if num == 2 then
		local houseIndex = RearHouseDragCenter.getCurZoneId()
		local state = GameFsm.getState(Const.STATE_MAIN_REAR_HOUSE)
		local nextId = RearHouseCommon.getNextRoomId(houseIndex, CurAvatar.rearHouseData.level)

		if state then
			state:changeWall(nextId, true)
		end

		self:checkEditRedHint()
	elseif not self.panelRoom:getVisible() then
		self.panelRoom:setVisible(true)
		self.panelRoom:setData(false)
	end
end

function RearHouseMainDlg:onChangeWall(...)
	return
end

function RearHouseMainDlg:onBtnAttrClick(...)
	if not RearHouseCommon.isAttrFurniturePuted() then
		MsgManager.clientNotice(353)
	else
		UIManager.getUI("rearHouseAttrDlg", true)
	end
end

function RearHouseMainDlg:onBtnRankClick(...)
	local rankMainDlg = UIManager.getUI("rankMainDlg", true)

	rankMainDlg:initByRankType(Const.RANK_TYPE_HOUSEFAVOR)
end

function RearHouseMainDlg:onBtnVisitClick(...)
	UIManager.getUI("rearHouseVisitChooseDlg", true)
end

function RearHouseMainDlg:onSliderValueChange(com, value)
	RearHouseDragCenter.onSliderValueChange(value)
end

function RearHouseMainDlg:onBtnCleanClick(...)
	local isOpen, unlockLevel = RearHouseCommon.isCleanUnlock()

	if isOpen == false then
		local data = CurAvatar:getRearHouseLevelInfo(unlockLevel)

		MsgManager.notice(utils.format(Lang.get(30679), data.bigLv, data.smallLv))
	elseif RearHouseCommon.isMaxCleanToday() == true then
		MsgManager.notice(Lang.get(30713))
	else
		local gids = RearHouseCommon.getAllHeroGidInRearHouse()

		if #gids > 0 then
			RearHouseDragCenter.playCleanEffect()
		else
			MsgManager.notice(Lang.get(30714))
		end
	end
end

function RearHouseMainDlg:onBtnComfortableClick(...)
	UIManager.getUI("rearHouseComfortableDlg", true):setData()
end

function RearHouseMainDlg:onBtnDispatchClick(...)
	local isOpen, unlockLevel = RearHouseCommon.isDispatchUnlock()

	if isOpen then
		UIManager.getUI("dispatchDlg", true)
	else
		local data = CurAvatar:getRearHouseLevelInfo(unlockLevel)

		MsgManager.notice(utils.format(Lang.get(30679), data.bigLv, data.smallLv))
	end
end

function RearHouseMainDlg:onBtnShopClick(...)
	local isOpen, unlockLevel = RearHouseCommon.isShopUnlock()

	if isOpen then
		UIManager.getUI("rearHouseShopDlg", true)
	else
		local data = CurAvatar:getRearHouseLevelInfo(unlockLevel)

		MsgManager.notice(utils.format(Lang.get(30679), data.bigLv, data.smallLv))
	end
end

function RearHouseMainDlg:onBtnLvClick(...)
	if CurAvatar.rearHouseData.level >= #ResRearHouseLevelConfig then
		MsgManager.notice(Lang.get(30715))
	else
		UIManager.getUI("rearHouseLvUpDlg", true)
	end
end

function RearHouseMainDlg:onBtnCloseClick(...)
	GameFsm.getState(Const.STATE_MAIN):enterDefaultMainState()
end

function RearHouseMainDlg:onBtnTipsClick(...)
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_REAR_HOUSE)
end

function RearHouseMainDlg:onBtnEditClick(...)
	UIManager.getUI("rearHouseEditDlg", true):show()
end

function RearHouseMainDlg:onBtnHideClick(...)
	self:showUI(false)
end

function RearHouseMainDlg:onBtnHouseShareClick(...)
	local isHouseShareOpen = RearHouseCommon.isHouseShareUnlock()

	if isHouseShareOpen then
		local msgContent = Lang.get(62969)

		local function yesFunc(...)
			RPC.houseShare(Const.CHANNEL_WORLD, self.uid, 0)
		end

		local function noFunc(...)
			self.btnShare:clearButtonCd()
		end

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", msgContent, yesFunc, noFunc)

		return true
	else
		local noticeMsg = Lang.get(61046)

		MsgManager.notice(noticeMsg)

		return false
	end
end

function RearHouseMainDlg:onBtnSetMainRoomClick()
	local houseIndex = RearHouseDragCenter.getCurZoneId()

	RPC.houseMainRoomSet(houseIndex)
end

function RearHouseMainDlg:blockClick(isBlock)
	self.panelBlock:setVisible(isBlock)
end

function RearHouseMainDlg:onOpenCrystalLevelDlg()
	CurAvatar:onClickCrystalStage()
end

function RearHouseMainDlg:onOpenCrystalLevelAchieveDlg()
	CurAvatar:onClickCrystalStageAchieve()
end

function RearHouseMainDlg:refreshBtnPopularity()
	local check = CurAvatar:checkRearHousePopularityOpen()

	self.btnPopularity:setEnable(check)
end

function RearHouseMainDlg:onClickBtnPopularity()
	UIManager.getUI("rearHousePopularityAwardDlg", true)
end

function RearHouseMainDlg:onOpenPopularityAwardDlg()
	local check = CurAvatar:checkRearHousePopularityOpen()

	if check then
		UIManager.getUI("rearHousePopularityAwardDlg", true)
	end
end

return RearHouseMainDlg
