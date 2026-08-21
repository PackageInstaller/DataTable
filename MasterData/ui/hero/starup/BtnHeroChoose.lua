-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\StarUp\\BtnHeroChoose.lua

local GridHeroStarUp = require("UI/Hero/StarUp/GridHeroStarUp")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResInfoNotice = require("ClientData/ResInfoNotice")
local strClassName = "BtnHeroChoose"
local BtnHeroChoose = Class(strClassName, UIControls.ScrollViewLoopCell)

function BtnHeroChoose:ctor()
	self:initUI()
end

function BtnHeroChoose:initUI()
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelfClick)

	self.imgTickHero1 = UIControls.Image(self, "TickHero1")
	self.imgTickHero2 = UIControls.Image(self, "TickHero2")
	self.imgHeroAdd = UIControls.Image(self, "HeroAdd")
	self.imgHeroLock = UIControls.Image(self, "HeroLock")
	self.imgIconRecommend = UIControls.Image(self, "IconRec")
end

function BtnHeroChoose:setHero(hero, idx)
	self.idx = idx
	self.hero = hero

	if not self.gridHero then
		self.gridHero = GridHeroStarUp(self, "GridHeroStarUpPanel", "System/StarUp/GridHeroStarUp")

		self.gridHero:setClickCallback(Slot(self.onBtnSelfClick, self))
		self.gridHero:setVisible(true)
	end

	self.gridHero:setHero(self.hero)

	self.status = self:getChooseStatus()

	self.imgTickHero1:setVisible(self.status == Const.HERO_STARUP_GRID_STATUS_BE_STARUP)
	self.imgTickHero2:setVisible(self.status == Const.HERO_STARUP_GRID_STATUS_BE_MATERIAL)
	self.imgHeroAdd:setCanvasGroupAlpha(self.status == Const.HERO_STARUP_GRID_STATUS_CAN_MATERIAL and self.hero.banStarMaterial ~= 1 and 1 or 0)
	self.imgHeroLock:setVisible(self.status == Const.HERO_STARUP_GRID_STATUS_LOCK)
	self.imgIconRecommend:setVisible(self.status == Const.HERO_STARUP_GRID_STATUS_CAN_MATERIAL and self.hero.quality < 4)

	if self.status == Const.HERO_STARUP_GRID_STATUS_NONE or self.status == Const.HERO_STARUP_GRID_STATUS_BE_STARUP then
		self.gridHero.imgIconNew:setVisible(self.hero.canStarUp == 1)
	elseif self.status == Const.HERO_STARUP_GRID_STATUS_CAN_MATERIAL then
		self.gridHero.imgIconNew:setVisible(false)
	else
		self.gridHero.imgIconNew:setVisible(false)
	end

	self.gridHero:setObjGray(self.hero:isUniqueHero())
end

function BtnHeroChoose:onBtnSelfClick()
	if self.hero:isUniqueHero() then
		MsgManager.notice(ResInfoNotice[257].content)

		return
	end

	if self.status == Const.HERO_STARUP_GRID_STATUS_NONE then
		self.mWindow:setHeroToExchagngePanel(self.hero)
	elseif self.status == Const.HERO_STARUP_GRID_STATUS_BE_STARUP then
		self.mWindow.exchangePanel:clearHero()
	elseif self.status == Const.HERO_STARUP_GRID_STATUS_CAN_MATERIAL then
		if self.mWindow:isLastAsyncFormationHero(self.hero) then
			MsgManager.clientNotice(162)
		else
			local passType = self.mWindow.exchangePanel:getCanBeMaterialType(self.hero)

			if not passType then
				MsgManager.clientNotice(166)

				return
			end

			if passType ~= Const.HERO_STARUP_MATERIAL_TYPE.SAME_ID and self.hero.banStarMaterial == 1 then
				MsgManager.clientNotice(334)

				return
			end

			if self.hero.lock == 1 then
				local function yesFunc()
					self.mWindow:setVisible(false)

					local heroMainDlg = UIManager.getUI("heroMainDlg", true)

					if heroMainDlg then
						heroMainDlg:initForHeroList(self.hero.gid)
					end
				end

				local msgContent = Lang.get(30391)

				UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, yesFunc)

				return
			end

			if passType ~= Const.HERO_STARUP_MATERIAL_TYPE.SAME_ID and self.hero.quality >= 4 then
				local function yesFunc()
					self.mWindow.exchangePanel:addMaterial(self.hero)
				end

				if self.hero:isRelatedHero() then
					UIManager.getUI("relatedStarUpNoticeDlg", true):setHero(self.hero.id, 3, yesFunc)
				else
					local msgContent = ResClientNotice[268].notice

					UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, yesFunc)
				end

				return
			end

			self.mWindow.exchangePanel:addMaterial(self.hero)
		end
	elseif self.status == Const.HERO_STARUP_GRID_STATUS_BE_MATERIAL then
		self.mWindow.exchangePanel:removeMaterial(self.hero)
	elseif self.status == Const.HERO_STARUP_GRID_STATUS_LOCK then
		MsgManager.clientNotice(163)
	elseif self.status == Const.HERO_STARUP_GRID_STATUS_CANT_UP then
		MsgManager.clientNotice(164)
	end
end

function BtnHeroChoose:getChooseStatus()
	if self.mWindow.exchangePanel.hero and self.mWindow.exchangePanel.hero.gid == self.hero.gid then
		return Const.HERO_STARUP_GRID_STATUS_BE_STARUP
	end

	if self.mWindow.exchangePanel.hero and self.mWindow.exchangePanel:isBeMaterial(self.hero) then
		return Const.HERO_STARUP_GRID_STATUS_BE_MATERIAL
	end

	if self.mWindow.exchangePanel.hero and CurAvatar:isStarUpNeed(self.mWindow.exchangePanel.hero, self.hero) then
		return Const.HERO_STARUP_GRID_STATUS_CAN_MATERIAL
	end

	if self.mWindow.exchangePanel.hero then
		return Const.HERO_STARUP_GRID_STATUS_LOCK
	elseif self.hero.star < self.hero:getMaxStar() then
		return Const.HERO_STARUP_GRID_STATUS_NONE
	else
		return Const.HERO_STARUP_GRID_STATUS_CANT_UP
	end
end

return BtnHeroChoose
