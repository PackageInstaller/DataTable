-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetPoolResultDlg.lua

local ResPetGashaponConfig = require("ClientData/ResPetGashaponConfig")
local ResPetGashaponDraw = require("ClientData/ResPetGashaponDraw")
local ResPetGashaponDrawLib = require("ClientData/ResPetGashaponDrawLib")
local ResPetGashaponDrawUp = require("ClientData/ResPetGashaponDrawUp")
local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local strClassName = "GridAwardGashaponChild"
local GridAwardGashaponChild = Class(strClassName, UIControls.Child)

function GridAwardGashaponChild:ctor()
	self:initUI()
end

function GridAwardGashaponChild:initUI()
	self.aniGrid = UIControls.UIAni(self, "")

	self.aniGrid:addEventFinish(self.aniFinishCallBack)

	self.bgGashapon = UIControls.Image(self, "BgGashapon")
	self.imgLinked = UIControls.Image(self, "BgGashapon/ImgLinked")
	self.bgGashaponLeft = UIControls.Image(self, "BgGashaponLeft")
	self.bgGashaponRight = UIControls.Image(self, "BgGashaponRight")
	self.efx = UIControls.LazyEffectPlayer(self, "EfxQuality/Efx")
end

function GridAwardGashaponChild:setData(data)
	self.data = data
	self.gashaponId = data.temp_param
	self.itemId = data.id
	self.itemNum = data.common_param
	self.configData = ResPetGashaponConfig[self.gashaponId]
	self.curActId = self.mParent.curActId

	if self.configData.icon_path then
		self.bgGashapon:setImage(self.configData.icon_path, self.configData.icon)
		self.bgGashaponLeft:setImage(self.configData.icon_path, self.configData.icon .. "a")
		self.bgGashaponRight:setImage(self.configData.icon_path, self.configData.icon .. "b")
	end

	self.imgLinked:setVisible(self.configData.quality == Const.PET_DRAW_QUALITY_ACT)

	local item = BaseObject.GetObject(self.itemId, self.itemNum)

	if self.nameGridContainer == nil then
		self.nameGridContainer = UIControls.GridNameContainerChild(self, "GridAward", "System/Common/Grid/GridAwardGetHolder", 0, 0, true)
	end

	self.nameGridContainer.mDisableWays = true

	self.nameGridContainer:setObj(item)
	self.aniGrid:startAni("ResetGridPetGashapon", true)
end

function GridAwardGashaponChild:playOpenEfx()
	local specEffectPath = "Effects/UI/efx_ui_PetPoolResultGridCanvas_04_02.prefab"

	if self.curActId and ResPetGashaponDrawUp[self.curActId] and ResPetGashaponDrawUp[self.curActId].effect_path then
		specEffectPath = ResPetGashaponDrawUp[self.curActId].effect_path[2]
	end

	local efxPath = {
		"Effects/UI/efx_ui_PetPoolResultGridCanvas_01_02.prefab",
		"Effects/UI/efx_ui_PetPoolResultGridCanvas_02_02.prefab",
		"Effects/UI/efx_ui_PetPoolResultGridCanvas_03_02.prefab",
		specEffectPath
	}

	self.efx:playEffectByPath(efxPath[self.configData.quality])
end

function GridAwardGashaponChild:aniFinishCallBack(aniCom, aniName)
	if aniName == "ShowGridPetGashaponHighest" or aniName == "ShowGridPetGashaponSpe" then
		local item = BaseObject.GetObject(self.itemId)

		if item.itemType == Const.ITEM_TYPE_PET then
			if self.mParent.petAndAmuletDic and self.mParent.petAndAmuletDic[item.id] then
				local transItem = BaseObject.GetObject(item.translateItemId)

				self.nameGridContainer:playTransItemEfx(transItem)
			else
				self.mParent.petAndAmuletDic[item.id] = true

				UIManager.getUI("getNewPetDlg", true):setData(item)
			end
		elseif item.itemType == Const.ITEM_TYPE_PET_AMULET then
			if self.mParent.petAndAmuletDic and self.mParent.petAndAmuletDic[item.id] then
				local transItem = BaseObject.GetObject(item.translateItemId)

				self.nameGridContainer:playTransItemEfx(transItem)
			else
				self.mParent.petAndAmuletDic[item.id] = true
			end
		end
	end
end

local strClassName = "PetPoolResultDlg"
local PetPoolResultDlg = Class(strClassName, UIControls.Window)

function PetPoolResultDlg:ctor()
	self:initUI()
end

function PetPoolResultDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnAgain = UIControls.Button(self, "BtnPanel/BtnAgain")

	self.btnAgain:addEventClick(self.onBtnAgainClick)

	self.aniSelf = UIControls.UIAni(self, "")

	self.aniSelf:addEventAnimateCue(self.onAnimateCue)

	self.gridPanel = {}

	for i = 1, 10 do
		local gridPetGashapon = UIControls.Panel(self, "PetGashaponListPanel/GridPetGashapon" .. i)
		local efx = UIControls.LazyEffectPlayer(self, "PetGashaponListPanel/GridPetGashapon" .. i .. "/EfxFlash/Efx")

		table.insert(self.gridPanel, {
			gridPetGashapon = gridPetGashapon,
			efx = efx
		})
	end

	self.icon = UIControls.Image(self, "BtnPanel/BtnAgain/Icon")
	self.textNum = UIControls.Label(self, "BtnPanel/BtnAgain/TextNum")
	self.grids = {}
end

function PetPoolResultDlg:setData(items, curActId)
	self.items = items
	self.drawNum = #items
	self.curActId = curActId

	local specEffectPath = "Effects/UI/efx_ui_PetPoolResultGridCanvas_04_01.prefab"

	if self.curActId and ResPetGashaponDrawUp[self.curActId] and ResPetGashaponDrawUp[self.curActId].effect_path then
		specEffectPath = ResPetGashaponDrawUp[self.curActId].effect_path[1]
	end

	for i = 1, 10 do
		if self.items[i] then
			self.gridPanel[i].gridPetGashapon:setVisible(true)

			local configData = ResPetGashaponConfig[self.items[i].temp_param]
			local efxPath = {
				"Effects/UI/efx_ui_PetPoolResultGridCanvas_01_01.prefab",
				"Effects/UI/efx_ui_PetPoolResultGridCanvas_02_01.prefab",
				"Effects/UI/efx_ui_PetPoolResultGridCanvas_03_01.prefab",
				specEffectPath
			}

			self.gridPanel[i].efx:playEffectByPath(efxPath[configData.quality])

			local grid = self.grids[i]

			if grid == nil then
				grid = GridAwardGashaponChild(self, "PetGashaponListPanel/GridPetGashapon" .. i, "System/PetPool/GridPetGashapon", 0, 0, true)
			end

			grid:setData(self.items[i])

			self.grids[i] = grid
		else
			self.gridPanel[i].gridPetGashapon:setVisible(false)

			if self.grids[i] then
				self.grids[i]:destroy()

				self.grids[i] = nil
			end
		end
	end

	self.aniSelf:startAni("ShowPetPoolResultGridCanvas", true)

	self.itemID = ResPetGashaponDraw[1].cost_item
	self.costNum = ResPetGashaponDraw[1].cost_num
	self.libId = ResPetGashaponDraw[1].limit_lib
	self.haveNum = CurAvatar:getItemNumById(self.itemID)

	local itemIcon = BaseObject.getItemIconPath(self.itemID)

	if itemIcon then
		self.icon:setImage(itemIcon[1], itemIcon[2])
	end

	self.textNum:setText(self.costNum * 10)
	self.btnAgain:setVisible(false)
	self.btnClose:setVisible(false)

	local mainDlg = UIManager.tryGetUI("petPoolMainDlg")

	if mainDlg then
		self.petAndAmuletDic = mainDlg.petAndAmuletDic or {}
	end
end

function PetPoolResultDlg:onAnimateCue(aniCom, eventKey)
	if eventKey == "ShowGashapon" then
		for i, cell in ipairs(self.grids) do
			if cell.configData.quality == Const.PET_DRAW_QUALITY_NORMAL or cell.configData.quality == Const.PET_DRAW_QUALITY_SPECIAL then
				cell.aniGrid:startAni("ShowGridPetGashapon", true)
			elseif cell.configData.quality == Const.PET_DRAW_QUALITY_SPECIAL_CHOOSE then
				cell.aniGrid:startAni("ShowGridPetGashaponSpe", true)
			elseif cell.configData.quality == Const.PET_DRAW_QUALITY_ACT then
				cell.aniGrid:startAni("ShowGridPetGashaponHighest", true)
			end

			cell:playOpenEfx()
		end
	end

	self.coFunc = coroutine.start(function(...)
		coroutine.wait(3)

		if self.btnAgain then
			self.btnAgain:setVisible(self:checkCanDrawAgain())
			self.btnClose:setVisible(true)
		end
	end)
end

function PetPoolResultDlg:checkCanDrawAgain()
	if self.drawNum < 10 then
		return false
	end

	if self.haveNum < self.costNum * 10 then
		return false
	end

	local remainCount = 0

	for i, v in pairs(ResPetGashaponDrawLib[self.libId] or {}) do
		if ResPetGashaponConfig[v.gashapon_id].quality ~= Const.PET_DRAW_QUALITY_NORMAL then
			remainCount = remainCount + v.limit

			for _, record in pairs(CurAvatar.roleDrawData[Const.DrawTypePet].drawRecord or {}) do
				if record.gashapon_id and v.gashapon_id == record.gashapon_id then
					remainCount = remainCount - record.drawed_num
				end
			end
		end
	end

	for actId, v in pairs(ResPetGashaponDrawUp) do
		local actObj = CurAvatar:getActivityObj(actId)

		if actObj and actObj:isValid() then
			for _, v in pairs(ResPetGashaponDrawLib[actObj.actData.replaceLibId] or {}) do
				remainCount = remainCount + v.limit

				for _, record in pairs(actObj.actData.drawData.drawRecord or {}) do
					if record.gashapon_id and v.gashapon_id == record.gashapon_id then
						remainCount = remainCount - record.drawed_num
					end
				end
			end
		end
	end

	if remainCount < 10 then
		return false
	end

	return true
end

function PetPoolResultDlg:onBtnAgainClick()
	if not DrawCardUtils.checkRemainCount(Const.DrawTypePet, self.drawNum) then
		MsgManager.notice(Lang.get(30265))

		return
	end

	local totalCount = CurAvatar.roleDrawData[Const.DrawTypePet].count

	RPC.draw(Const.DrawTypePet, self.drawNum, Const.DrawCostTypeItem, nil, totalCount)

	if CurAvatar.consecutiveDrawsNum then
		CurAvatar.consecutiveDrawsNum = CurAvatar.consecutiveDrawsNum + self.drawNum
	else
		CurAvatar.consecutiveDrawsNum = self.drawNum
	end

	local mainDlg = UIManager.tryGetUI("petPoolMainDlg")

	if mainDlg then
		mainDlg:getCurPetAndAmuletDicData()
	end

	self:setVisible(false)
end

function PetPoolResultDlg:onBtnCloseClick()
	self:setVisible(false)

	local items = {}
	local onceNum = ResPetGashaponDraw[1].point_num
	local drawCount = 0

	if CurAvatar.consecutiveDrawsNum then
		drawCount = CurAvatar.consecutiveDrawsNum + self.drawNum
	else
		drawCount = self.drawNum
	end

	table.insert(items, {
		id = ResPetGashaponDraw[1].point_item,
		num = drawCount * onceNum
	})
	CurAvatar:onGetBonusNotice("commonBonusDlg", "onShow", {
		"",
		{},
		items,
		{},
		{},
		{},
		{},
		Lang.get(36348),
		Slot(self.closeCB, self)
	})

	CurAvatar.consecutiveDrawsNum = nil
end

function PetPoolResultDlg:closeCB()
	local petPoolMainDlg = UIManager.tryGetUI("petPoolMainDlg")

	if petPoolMainDlg then
		petPoolMainDlg:playResetOpenAni()
	end
end

function PetPoolResultDlg:onClose()
	for i, v in pairs(self.grids or {}) do
		v.nameGridContainer:clearCoroutine()
	end

	if self.coFunc then
		coroutine.stop(self.coFunc)
	end

	self.coFunc = nil
end

return PetPoolResultDlg
