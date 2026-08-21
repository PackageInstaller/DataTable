-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetRuneInfoPanel.lua

local ResPetRune = require("ClientData/ResPetRune")
local ResColor = require("ClientData/ResColor")
local ResClientNotice = require("ClientData/ResClientNotice")
local strClassName = "PetRuneInfoPanel"
local PetRuneInfoPanel = Class(strClassName, UIControls.Panel)

function PetRuneInfoPanel:ctor(...)
	self:initUI()
end

function PetRuneInfoPanel:initUI(...)
	self.textName = UIControls.Label(self, self.mPath .. "/TextName")
	self.textLvNum = UIControls.Label(self, self.mPath .. "/AttrPanel/AttrLessPanel/Attr1/TextNum")
	self.textAttrName = UIControls.Label(self, self.mPath .. "/AttrPanel/AttrLessPanel/Attr1/TextName")
	self.attr1 = UIControls.Panel(self, self.mPath .. "/AttrPanel/AttrLessPanel/Attr1")
	self.attrImage = UIControls.Image(self, self.mPath .. "/AttrPanel/AttrLessPanel/Attr1/Image")
	self.btnUpgrade = UIControls.Button(self, self.mPath .. "/BtnUpgrade")

	self.btnUpgrade:addEventClick(self.onBtnUpgradeClick)

	self.iconNew = UIControls.Image(self, self.mPath .. "/BtnUpgrade/IconNew")

	if UIControls.checkControlFunc(self, self.mPath .. "/HeroPanel") then
		self.btnChange = UIControls.Button(self, self.mPath .. "/HeroPanel/BtnChange")

		self.btnChange:addEventClick(self.onBtnChangeClick)
	end

	if UIControls.checkControlFunc(self, self.mPath .. "/LockTips") then
		self.lockTips = UIControls.Panel(self, self.mPath .. "/LockTips")
		self.lockText01 = UIControls.Label(self, self.mPath .. "/LockTips/Text01")
		self.lockText02 = UIControls.Label(self, self.mPath .. "/LockTips/Text02")
		self.lockText03 = UIControls.Label(self, self.mPath .. "/LockTips/Text03")
	end

	if UIControls.checkControlFunc(self, self.mPath .. "/UnLockTips") then
		self.unLockTips = UIControls.Label(self, self.mPath .. "/UnLockTips")
	end
end

function PetRuneInfoPanel:setData()
	self.selectRuneIndex = self.mParent.selectRuneIndex or 1
	self.selectTree = self.mParent.selectTree or 1
	self.type = self.mParent.type or Const.PET_RUNE_TYPE_NORMAL

	if self.mParent.type == Const.PET_RUNE_TYPE_NORMAL then
		self.rune = self:getSelectNormalRune()
	else
		self.rune, self.heroGid = self:getSelectExlcusiveRune()
	end

	self:initChoosedHero()
	self:refreshRuneInfoUI()
end

function PetRuneInfoPanel:getSelectNormalRune()
	self.normalRuneData = self.mParent.normalRuneData

	local groupNodeNum = 0

	for node_id, nodeGroup in ipairs(self.normalRuneData[self.selectTree]) do
		for i, node in ipairs(nodeGroup) do
			groupNodeNum = groupNodeNum + 1

			if groupNodeNum == self.selectRuneIndex then
				return node
			end
		end
	end
end

function PetRuneInfoPanel:getSelectExlcusiveRune()
	local rune = self.mParent.exclusiveRuneNodeDic[self.selectRuneIndex]

	if rune then
		local runeData = ResPetRune[rune.id]

		return runeData, rune.hero_gid
	end

	return nil
end

function PetRuneInfoPanel:refreshUI(...)
	self:setData()
end

function PetRuneInfoPanel:initChoosedHero(...)
	self.choosedHero = nil

	if self.rune and self.heroGid and CurAvatar.heroDic[self.heroGid] then
		self.choosedHero = CurAvatar.heroDic[self.heroGid]
	end
end

function PetRuneInfoPanel:refreshRuneInfoUI()
	if self.rune then
		self.disRuneData = nil

		self.textName:setText(self.rune.name)
		self.textAttrName:setText(self.rune.buff_desc)
		self.attr1:setVisible(true)

		self.costItemId = self.rune.cost_item
		self.costNum = self.rune.cost_num
		self.haveNum = CurAvatar:getItemNumById(self.costItemId)

		if self.type == Const.PET_RUNE_TYPE_EXCLUSIVE then
			local maxLevelRune = CurAvatar:getMaxLevelExclusiveRune(self.rune)

			self.btnUpgrade:setVisible(self.rune.level < maxLevelRune.level)

			if Const.REVIEW_VERSION then
				self.textLvNum:setText(string.format(Lang.get(111361), self.rune.level))
			else
				self.textLvNum:setText(string.format("Lv.%d", self.rune.level))
			end

			self.textLvNum:setVisible(true)
			self.unLockTips:setVisible(self.rune.level == maxLevelRune.level)
			self.attrImage:setImage("Atlas/PetAtlas/PetRuneMainAtlas", "IconStar")
			self.iconNew:setVisible(self.haveNum >= self.costNum)
		else
			self.textLvNum:setVisible(false)

			if self.lockTips then
				self.lockTips:setVisible(true)

				local isGet = true

				for i, nodeId in ipairs(self.rune.pre_node or {}) do
					if not CurAvatar.normalRuneDic[nodeId] then
						isGet = false

						break
					end
				end

				self.lockText01:setText(Lang.get(80600))
				self.lockText01:setFontColor(isGet == true and ResColor.WHITE or ResColor.GREYWHITE)

				local count = 0

				for _, v in pairs(CurAvatar.normalRuneDic) do
					count = count + 1
				end

				local unlockCount = self.rune.unlock_level or 0

				self.lockText02:setText(string.format(Lang.get(80601), count, unlockCount))
				self.lockText02:setFontColor(unlockCount <= count and ResColor.WHITE or ResColor.GREYWHITE)

				local maxActiveNum = math.floor(CurAvatar.petDegreeLevel / Const.PET_RUNE_DEGREE_LIMIT_NUM)

				if maxActiveNum == 0 then
					self.lockText03:setText(Lang.get(80813))
				else
					self.lockText03:setText(string.format(Lang.get(80602), count, maxActiveNum))
				end

				self.lockText03:setFontColor(count < maxActiveNum and ResColor.WHITE or ResColor.GREYWHITE)
			end

			if self.mParent:isNodeActive(self.selectTree, self.rune.node_id, self.rune.id) then
				self.btnUpgrade:setVisible(false)
				self.lockTips:setVisible(false)
				self.textAttrName:setFontColor(ResColor.WHITE)

				local attrImageName = self.rune.group == 1 and "IconFood" or "IconPlay"

				self.attrImage:setImage("Atlas/PetAtlas/PetRuneMainAtlas", attrImageName)
			else
				self.textAttrName:setFontColor(ResColor.GREYWHITE)

				if CurAvatar:checkNormalRuneNodeCanActive(self.rune) then
					self.btnUpgrade:setVisible(true)
					self.lockTips:setVisible(false)
					self.iconNew:setVisible(self.haveNum >= self.costNum)
				else
					self.btnUpgrade:setVisible(false)
					self.lockTips:setVisible(true)
				end

				local attrImageName = self.rune.group == 1 and "IconFoodDis" or "IconPlayDis"

				self.attrImage:setImage("Atlas/PetAtlas/PetRuneMainAtlas", attrImageName)
			end
		end
	else
		if self.type == Const.PET_RUNE_TYPE_EXCLUSIVE then
			for i, v in pairs(ResPetRune) do
				if v.node_type == Const.PET_RUNE_TYPE_EXCLUSIVE and v.node_id == self.selectRuneIndex and v.level == 1 then
					self.disRuneData = v
				end
			end

			self.attrImage:setImage("Atlas/PetAtlas/PetRuneMainAtlas", "IconStarDis")
		else
			self.disRuneData = self.rune
		end

		if self.disRuneData then
			self.textName:setText(self.disRuneData.name)

			self.costItemId = self.disRuneData.cost_item or 500022
			self.costNum = self.disRuneData.cost_num or 1

			self.textAttrName:setText(self.disRuneData.buff_desc or "")
			self.textAttrName:setFontColor(ResColor.GREYWHITE)

			if Const.REVIEW_VERSION then
				self.textLvNum:setText(string.format(Lang.get(111361), 1))
			else
				self.textLvNum:setText(string.format("Lv.%d", 1))
			end

			self.textLvNum:setFontColor(ResColor.GREYWHITE)
		end

		self.attr1:setVisible(true)
		self.btnUpgrade:setVisible(true)
		self.unLockTips:setVisible(false)

		self.haveNum = CurAvatar:getItemNumById(self.costItemId)

		self.iconNew:setVisible(self.haveNum >= self.costNum)
	end

	if self.choosedHero then
		if not self.heroGrid then
			self.heroGrid = UIControls.HeroGridChild(self, self.mPath .. "/HeroPanel/HeroItem", "System/StarUp/GridHeroStarUp", 0, 0, true)
			self.heroGrid.mEnableTips = false
			self.heroGrid.isShowPreviewTips = false
		end

		self.heroGrid:setVisible(true)
		self.heroGrid:setObj(self.choosedHero)
	elseif self.heroGrid then
		self.heroGrid:setVisible(false)
	end

	if self.costItemId then
		if not self.costGrid then
			self.costGrid = UIControls.ItemGridChild(self, self.mPath .. "/ItemPanel/ItemNode", "System/Common/Grid/GridMaterialItem", 0, 0, true)
		end

		local clientItem = BaseObject.GetObject(self.costItemId, self.costNum)

		self.costGrid:setObj(clientItem)
		self.costGrid:setVisible(true)

		if self.costGrid.textNum then
			self.costGrid.textNum:setText(string.format("%d/%d", self.haveNum, self.costNum))

			local color = self.haveNum < self.costNum and ResColor.RED or ResColor.BLACK

			self.costGrid.textNum:setFontColor(color)
		end
	end
end

function PetRuneInfoPanel:isNodeCanActive()
	if self.type == Const.PET_RUNE_TYPE_NORMAL and self.rune then
		for i, nodeId in ipairs(self.rune.pre_node or {}) do
			if not CurAvatar.normalRuneDic[nodeId] then
				return false
			end
		end

		local count = 0

		for _, runeList in pairs(self.mParent.normalRuneNodeDic) do
			for i, nodeList in pairs(runeList or {}) do
				count = count + #nodeList
			end
		end

		if self.rune.unlock_level and count < self.rune.unlock_level then
			return false
		end
	end

	return true
end

function PetRuneInfoPanel:onBtnUpgradeClick()
	if self.type == Const.PET_RUNE_TYPE_EXCLUSIVE then
		if self.haveNum < self.costNum then
			MsgManager.notice(ResClientNotice[710].notice)

			return
		end

		local resid = 0

		if self.rune then
			local runeData = ResPetRune[self.rune.id]

			for i, v in pairs(ResPetRune) do
				if v.node_type == Const.PET_RUNE_TYPE_EXCLUSIVE and v.node_id == runeData.node_id and v.level == runeData.level + 1 then
					resid = v.id

					break
				end
			end
		else
			resid = self.disRuneData.id
		end

		RPC.petRuneUp(resid)
	else
		if self.haveNum < self.costNum then
			MsgManager.notice(ResClientNotice[686].notice)

			return
		end

		RPC.petRuneUp(self.rune.id)
	end
end

function PetRuneInfoPanel:onBtnChangeClick()
	if self.disRuneData then
		MsgManager.notice(ResClientNotice[687].notice)
	else
		self.mParent:openHeroBag()
	end
end

return PetRuneInfoPanel
