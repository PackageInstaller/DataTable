-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\ContentPanel\\HeroContentBasePanel.lua

local ResItemHeroBase = require("ClientData/ResItemHeroBase")
local ResItemHeroSkin = require("ClientData/ResItemHeroSkin")
local ResClientNotice = require("ClientData/ResClientNotice")
local BaseCell = Class("BaseCell", UIControls.Child)

function BaseCell:ctor()
	self.panel = UIControls.Panel(self, "")
	self.btn = UIControls.Button(self, "")

	self.btn:addEventClick(self.onBtnClick)

	self.txtName = UIControls.Label(self, "TxtName")
	self.imgBase = UIControls.Image(self, "ImgBed")
	self.imgStageBg = UIControls.Image(self, "BgState")
	self.txtState = UIControls.Label(self, "BgState/TxtDes")
	self.imgLock = UIControls.Image(self, "ImgLock")
	self.iconNew = UIControls.Image(self, "IconNew")
end

function BaseCell:setData(data, hasGet, onWear, curStar)
	self.data = data
	self.hasGet = hasGet
	self.onWear = onWear
	self.unlockNewBase = false

	local unlockNewBase = CurAvatar.unlockNewBase

	if unlockNewBase[self.data.hero_id] and self.data.id == unlockNewBase[self.data.hero_id] then
		self.unlockNewBase = true
	end

	if data.icon_path then
		self.imgBase:setImage("Atlas" .. data.icon_path, data.icon_name)
	else
		self.imgBase:setImage("Atlas/CommonAtlas/IconAtlas/HeroBaseAtlas/BaseCommonA", "Base00")
	end

	self.txtName:setText(data.name)
	self:setGet(hasGet, curStar)
	self:setWear(onWear)
end

function BaseCell:setGet(hasGet, curStar)
	local unlock_star = self.data.unlock_star

	if hasGet == true then
		self.imgLock:setVisible(false)
		self.iconNew:setVisible(false)
	elseif curStar and unlock_star <= curStar then
		self.imgLock:setVisible(false)
		self.iconNew:setVisible(true)
	else
		self.imgLock:setVisible(true)
		self.iconNew:setVisible(false)
	end

	if self.unlockNewBase == true then
		self.iconNew:setVisible(true)
	end
end

function BaseCell:setWear(isOnWear)
	self.imgStageBg:setVisible(isOnWear)
end

function BaseCell:setSel(isSelected)
	self.btn:setEnable(not isSelected)
end

function BaseCell:onBtnClick()
	if self.unlockNewBase == true then
		self.unlockNewBase = false

		self.iconNew:setVisible(false)

		CurAvatar.unlockNewBase[self.data.hero_id] = nil

		CurAvatar:checkBaseNew()
	end

	if self.mEventClick then
		self:mEventClick(self.data)
	end
end

local strClassName = "HeroContentBasePanel"
local HeroContentBasePanel = Class(strClassName, UIControls.Panel)

function HeroContentBasePanel:ctor()
	self.baseData = {}
	self.baseCells = {}
	self.cellHight = nil
	self.hasShow = false

	self:initUI()
end

function HeroContentBasePanel:initUI()
	self.btnWear = UIControls.Button(self, self.mPath .. "/BtnDress", "Text")
	self.unlockPanel = UIControls.Panel(self, self.mPath .. "/UnlockPanel")
	self.txtUnlock = UIControls.Label(self, self.mPath .. "/UnlockPanel/Text")
	self.txtOnWear = UIControls.Panel(self, self.mPath .. "/BtnDress1")

	self.txtOnWear:setVisible(false)

	self.imgDes = UIControls.Image(self, self.mPath .. "/ImgDes")

	self.btnWear:addEventClick(self.onBtnWearClick)

	self.cellPanel = UIControls.Panel(self, self.mPath .. "/BedInfoPanel/BedPanel")
	self.cellPanelPos = self.cellPanel:getPosition()
end

function HeroContentBasePanel:setHero(hero, isEnter)
	self.isEnter = isEnter

	local svrData = CurAvatar:getSkinDataByHeroId(hero.id)

	self.svrData = svrData.base or {}
	self.hero = hero
	self.baseId = self.hero.base

	self:setData()

	local skinId = self.hero.skin
	local skinData = skinId ~= 0 and ResItemHeroSkin[self.hero.id][skinId] or nil

	if skinData and self.hasSpecBase == true then
		self:changeHeroBase(skinData.id)
	elseif self.baseId ~= 0 then
		self:changeHeroBase(self.baseId)
	end
end

function HeroContentBasePanel:setData(resetSel)
	if resetSel then
		self.hasShow = true
	end

	self.baseData = {}
	self.baseData = ResItemHeroBase[self.hero.id] or {}

	self:checkSpecBase()
	self.imgDes:setVisible(self.hasSpecBase)
	self:refreshBasePanel()

	if resetSel == true then
		self.mParent:resetCurSel()
		self.mWindow:hideModel(false)
	end

	self:refreshPanelInfo()
end

function HeroContentBasePanel:refreshBasePanel()
	local default = {
		id = 0,
		base_id = self.hero.resData.model,
		name = Lang.get(30381)
	}

	if not self.baseCells[1] then
		local cell = BaseCell(self, self.mPath .. "/BedInfoPanel/BedPanel", "System/Hero/BedCell", 0, 0, true)

		cell.mEventClick = Slot(self.onCellBtnClick, self)
		self.baseCells[1] = cell

		if not self.cellHight then
			local obj = cell:getController()

			if obj and obj.transform.sizeDelta then
				self.cellHight = obj.transform.sizeDelta.y
			end
		end
	end

	if self.baseId == 0 and self.hasSpecBase ~= true then
		self.baseCells[1]:setData(default, true, true, 0)

		if self.isEnter then
			self.baseCells[1]:setSel(true)
		end
	else
		self.baseCells[1]:setData(default, true, false, 0)
		self.baseCells[1]:setSel(false)
	end

	if #self.baseData + 1 > #self.baseCells then
		for i = #self.baseCells + 1, #self.baseData + 1 do
			local cell = BaseCell(self, self.mPath .. "/BedInfoPanel/BedPanel", "System/Hero/BedCell", 0, 0, true)

			cell.mEventClick = Slot(self.onCellBtnClick, self)
			self.baseCells[i] = cell
		end
	end

	for i = 2, #self.baseCells do
		if self.baseData[i - 1] then
			self.baseCells[i]:setVisible(true)

			local hasGet = false

			if self.svrData[i - 1] then
				hasGet = true
			end

			local onWear = false

			if i == self.baseId + 1 then
				self.baseCells[1]:setWear(false)

				if self.hasSpecBase == false then
					onWear = true
				end
			end

			self.baseCells[i]:setVisible(true)
			self.baseCells[i]:setData(self.baseData[i - 1], hasGet, onWear, self.hero.star)

			if self.isEnter then
				self.baseCells[i]:setSel(onWear)
			end
		else
			self.baseCells[i]:setVisible(false)
		end
	end

	self.isEnter = nil

	self:setPosTarget()
end

function HeroContentBasePanel:setPosTarget()
	if self.curSelId and self.cellHight then
		local count = math.floor((self.curSelId - 1) / 2)
		local deltaY = self.cellHight * count

		self.cellPanel:setPosition(self.cellPanelPos.x, self.cellPanelPos.y + deltaY)
	end
end

function HeroContentBasePanel:checkSpecBase()
	self.hasSpecBase = false

	local curSkin = self.hero.skin

	if curSkin and curSkin ~= 0 then
		local sData = ResItemHeroSkin[self.hero.id] and ResItemHeroSkin[self.hero.id][curSkin] or nil

		if sData and sData.base_id then
			self.hasSpecBase = true
		end
	end
end

function HeroContentBasePanel:refreshPanelInfo()
	local curBase = self.baseCells[self.curSelId]

	if not curBase then
		return
	end

	local curBaseInfo = curBase.data

	if curBaseInfo.unlock_star and curBaseInfo.unlock_star > self.hero.star then
		self.btnWear:setVisible(false)
		self.unlockPanel:setVisible(true)
		self.txtOnWear:setVisible(false)
		self.txtUnlock:setText(curBaseInfo.unlock_desc)
	elseif curBase.hasGet == false then
		self.btnWear:setVisible(true)
		self.btnWear:setText(Lang.get(483))
		self.txtOnWear:setVisible(false)
		self.unlockPanel:setVisible(false)
	else
		if curBase.onWear == true then
			self.btnWear:setVisible(false)
			self.txtOnWear:setVisible(true)
		else
			self.btnWear:setVisible(true)
			self.btnWear:setText(Lang.get(1189))
			self.txtOnWear:setVisible(false)
		end

		self.unlockPanel:setVisible(false)
	end
end

function HeroContentBasePanel:onCellBtnClick(cell)
	if self.curSelCell then
		self.curSelCell:setSel(false)
	end

	self.mParent:checkNew()

	if cell.data.id then
		cell:setSel(true)
		self:changeHeroBase(cell.data.id)

		self.curSelId = cell.data.id + 1
		self.curSelCell = cell

		self:refreshPanelInfo()
	end
end

function HeroContentBasePanel:resetCurSel()
	if not self.hero then
		return
	end

	if self.curSelCell then
		self.curSelCell:setSel(false)
	end

	self.curSelId = self.baseId + 1
	self.curSelCell = self.baseCells[self.curSelId]

	self.curSelCell:setSel(true)
	self:checkSpecBase()
	self:changeHeroBase(self.baseId)
end

function HeroContentBasePanel:changeHeroBase(baseId, justDo)
	if self.hasSpecBase == false then
		local modelId

		if baseId == 0 then
			modelId = self.hero.resData.model
		else
			modelId = ResItemHeroBase[self.hero.id][baseId].base_id
		end

		self.mWindow:changeHeroBase(modelId)
	end
end

function HeroContentBasePanel:onBtnWearClick()
	if not self.curSelCell then
		return
	end

	local baseId = self.curSelCell.data.id

	if self.curSelCell.hasGet == false then
		RPC.skinUnlock(self.hero.gid, baseId)
	else
		if self.hasSpecBase == true then
			MsgManager.notice(ResClientNotice[408].notice)

			return
		end

		RPC.skinWear(self.hero.gid, baseId, Const.SKIN_TYPE_BASE)
	end
end

function HeroContentBasePanel:onHide()
	if self.hasShow == true then
		CurAvatar.unlockNewBase[self.hero.id] = nil

		CurAvatar:checkBaseNew()
		self.mParent:checkNew()

		self.hasShow = false
	end
end

return HeroContentBasePanel
