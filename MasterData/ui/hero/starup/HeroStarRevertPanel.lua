-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\StarUp\\HeroStarRevertPanel.lua

local ResStarUpRevert = require("ClientData/ResStarUpRevert")
local ResHeroMisc = require("ClientData/ResHeroMisc")
local strClassName = "HeroStarRevertPanel"
local ResStarUpCondition = require("ClientData/ResStarUpCondition")
local HeroStarRevertPanel = Class(strClassName, UIControls.Panel)

function HeroStarRevertPanel:ctor()
	self.gridRevertList = {}

	self:initUI()
end

function HeroStarRevertPanel:initUI()
	self.btnConfirm = UIControls.Button(self, self.mPath .. "/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.imgCostIcon = UIControls.Image(self, self.mPath .. "/BtnConfirm/Icon1")
	self.txtCostNum = UIControls.Label(self, self.mPath .. "/BtnConfirm/TextNum1")
	self.txtRule = UIControls.Label(self, self.mPath .. "/TextRule")
	self.imgStarColor = UIControls.Image(self, self.mPath .. "/ImgStarColor")
	self.cells = {}
	self.scrollRevertItems = UIControls.ScrollViewLoopV(self, self.mPath .. "/RevertList")

	self.scrollRevertItems:addEventCellChanged(self.onRevertItemsChanged)

	self.txtMaterialNum = UIControls.Label(self, self.mPath .. "/NumPanel/TextNum")
	self.imgMaterialIcon = UIControls.Image(self, self.mPath .. "/NumPanel/Icon")
	self.txtTime = UIControls.Label(self, self.mPath .. "/TextTime")
	self.costId = ResHeroMisc[1].star_return_cost_id
end

function HeroStarRevertPanel:initFreeStatus()
	local remainTime = ResHeroMisc[1].star_return_cd - (ClientUtils.getServerTime() - CurAvatar:getFreeStarRevertTick()) + 2

	if remainTime > 0 then
		self.imgCostIcon:setVisible(true)

		self.costNum = 1

		self.txtCostNum:setText(self.costNum)

		if ClientUtils.getMoney(self.costId) < self.costNum then
			self.txtCostNum:setFontColor(ResColor.RED)
		else
			self.txtCostNum:setFontColor(ResColor.WHITE)
		end

		ClientTimerManager.AddSecondFormatTickUI(self.txtTime, remainTime, false, Lang.get(48669), Slot(self.timeDownCallBack, self))
	else
		self:timeDownCallBack()
	end
end

function HeroStarRevertPanel:timeDownCallBack()
	self.txtTime:setText(string.format(Lang.get(36318), utils.calcShortTimeTxt(ResHeroMisc[1].star_return_cd)))
	self.imgCostIcon:setVisible(false)
	self.txtCostNum:setText(Lang.get(1261))
	self.txtCostNum:setFontColor(ResColor.WHITE)
end

function HeroStarRevertPanel:onRevertItemsChanged(sender, targetCell, newIdx)
	targetCell = targetCell or UIControls.getGridContainerLoop(sender, newIdx)

	if not self.revertItems or #self.revertItems == 0 then
		return
	end

	if self.revertItems[newIdx] ~= nil then
		local item = self.revertItems[newIdx]

		targetCell:setObj(item)
		targetCell:setVisible(true)

		targetCell.grid.mDisableWays = true

		if item.itemType == nil or item.itemType ~= Const.ITEM_TYPE_HERO then
			targetCell.grid.mEnableTips = true
		else
			targetCell.grid.mEnableTips = false

			targetCell.grid:setHeroRealLv()
		end
	end

	self.cells[newIdx] = targetCell
end

function HeroStarRevertPanel:onBtnConfirmClick()
	if self.hero:isRelatedHero() then
		UIManager.getUI("relatedStarUpNoticeDlg", true):setHero(self.hero.id, 2, Slot(self._realRevert, self))
	else
		self:_realRevert()
	end
end

function HeroStarRevertPanel:_realRevert()
	local remainTime = ResHeroMisc[1].star_return_cd - (ClientUtils.getServerTime() - CurAvatar:getFreeStarRevertTick()) + 2

	local function starBackRPC()
		RPC.heroStarBack(self.hero.gid, self.hero.star)
	end

	if remainTime > 0 then
		if ClientUtils.getMoney(self.costId) < self.costNum then
			local tempItem = BaseObject.GetObject(self.costId)

			MsgManager.notice(string.format(Lang.get(30029), tempItem.name))
			UIManager.getUI("itemTips"):showObj(self.mWindow, tempItem, {
				CloseSrcWindow = 1,
				AutoOpenGuide = 1
			})

			return
		end

		if #self.revertItems > 0 then
			local msgContent = ClientUtils.getClientNotice(414)

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", msgContent, starBackRPC, nil, -1)
		end
	elseif #self.revertItems > 0 then
		local msgContent = ClientUtils.getClientNotice(413)

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", msgContent, starBackRPC, nil, -1)
	end
end

function HeroStarRevertPanel:setHero(hero)
	self:initFreeStatus()

	self.hero = hero

	if not self.gridHero then
		self.gridHero = UIControls.HeroGridChild(self, self.mPath .. "/GridHeroStarUpPanel", "System/StarUp/GridHeroStarUp", 0, 0, true)
		self.gridHero.mEnableTips = false
	end

	self.gridHero:setObj(self.hero)

	local stepImgIdx = ResStarUpCondition[hero.star].step_img_idx or 1
	local color = self.hero:getQualityColor(stepImgIdx)

	self.imgStarColor:setObjColor(color)

	self.revertItems = CurAvatar:getStarRevertMaterial(self.hero)

	if #self.revertItems > 0 then
		self.scrollRevertItems:setTotalCount(#self.revertItems)
	end

	local iconInfo = ClientUtils.getMoneyIcon(self.costId)

	if iconInfo then
		self.imgCostIcon:setImage(iconInfo[1], iconInfo[2])
		self.imgMaterialIcon:setImage(iconInfo[1], iconInfo[2])
	end

	self.txtMaterialNum:setText(ClientUtils.getMoney(self.costId))

	if self.hero.reverReasonSimple == 1 then
		self.txtRule:setText(Lang.get(36320))
	else
		self.txtRule:setText(Lang.get(36321))
	end
end

return HeroStarRevertPanel
