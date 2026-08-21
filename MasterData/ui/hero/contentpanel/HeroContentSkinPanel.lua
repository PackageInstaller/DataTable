-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\ContentPanel\\HeroContentSkinPanel.lua

local ModelTool = require("Entity/ModelTool")
local ModelFactory = Framework.Entity.ModelFactory
local ResItemHeroSkin = require("ClientData/ResItemHeroSkin")
local HeroTagChild = require("UI/Hero/HeroTagChild")
local ResSkinTag = require("ClientData/ResSkinTag")
local SkinCell = require("UI/Hero/ContentPanel/SkinCell")
local ResItemHeroBase = require("ClientData/ResItemHeroBase")
local HeroTagTipChild = require("UI/Hero/ContentPanel/HeroTagTipChild")
local RoleImageEnjoy = require("UI/Hero/RoleImageEnjoy")
local strClassName = "HeroContentSkinPanel"
local HeroContentSkinPanel = Class(strClassName, UIControls.Panel)
local SHOW_TYPE_MODEL = 1
local SHOW_TYPE_PORTRAIT = 2
local SHOW_INFO = {
	{
		Lang.get(958),
		"BtnDrawing",
		"showOnModel"
	},
	{
		Lang.get(30236),
		"BtnModel",
		"showOn2D"
	}
}

function HeroContentSkinPanel:ctor()
	self.skinData = {}
	self.skinCells = {}
	self.tagList = {}
	self.tagTips = {}
	self.hideByScale = true

	self:initUI()
end

function HeroContentSkinPanel:initUI()
	self.txtName = UIControls.Label(self, self.mPath .. "/TxtPanel/TxtName")
	self.markPanel = UIControls.Panel(self, self.mPath .. "/MarkPanel")
	self.markTipPanel = UIControls.Panel(self, self.mPath .. "/MarkTipsPanel")
	self.btnMarkTip = UIControls.Button(self, self.mPath .. "/MarkPanel")

	self.btnMarkTip:addEventClick(self.onMarkClick)

	self.btnCloseMarkTip = UIControls.Button(self, self.mPath .. "/MarkTipsPanel/BtnCloes")

	self.btnCloseMarkTip:addEventClick(self.onCloseMark)

	self.oriSkinPanel = UIControls.Panel(self, self.mPath .. "/OriSkinPanel")
	self.txtOriDesc = UIControls.Label(self, self.mPath .. "/OriSkinPanel/Text")
	self.rolePortrait = UIControls.Role(self, self.mPath .. "/ImgSkinPanel", 0, 0)
	self.img2D = UIControls.Panel(self, self.mPath .. "/ImgSkinPanel")
	self.scrollPage = UIControls.ScrollView(self, self.mPath .. "/SkinPanel/SkinMaskPanel/SkinList")

	self.scrollPage:addScrollCorrectOnChanged(self.onCorrectEvent)

	self.btnSkinStory = UIControls.Button(self, self.mPath .. "/TxtPanel/TxtName/BtnSkinStory")

	self.btnSkinStory:addEventClick(self.onSkinStoryClick)

	self.enjoyPanel = RoleImageEnjoy(self, self.mPath .. "/EnjoyPanel", "System/Hero/EnjoyPanel", 0, 0)
	self.toShowType = SHOW_TYPE_PORTRAIT
end

function HeroContentSkinPanel:setHero(hero, needResetSel)
	local svrData = CurAvatar:getSkinDataByHeroId(hero.id)

	self.svrData = svrData.skin or {}
	self.skinData = {}
	self.hero = hero
	self.skinId = self.hero.skin

	if self.curSelId then
		self.skinCells[self.curSelId]:setSelected(false)

		self.curSelId = nil
	end

	if self.skinId == 0 then
		self.curSelId = 1
	end

	self:setData(needResetSel)

	if needResetSel then
		self.toShowType = SHOW_TYPE_MODEL

		self:changeShowType(true)
	end
end

function HeroContentSkinPanel:checkReplaceSkinData(data)
	if data.upgrade_skin_id and ResItemHeroSkin[data.hero_id][data.upgrade_skin_id] then
		local skinUpdateData = ResItemHeroSkin[data.hero_id][data.upgrade_skin_id]

		if CurAvatar:hasGetHeroSkin(skinUpdateData.item_id) then
			return skinUpdateData
		end
	end

	return data
end

function HeroContentSkinPanel:canShowSkin(data)
	if data.not_show == 1 then
		return false
	elseif not ClientUtils.isTimeConfigPassed(data.valid_time_id) then
		return false
	elseif data.is_upgrade_skin then
		return false
	elseif self.svrData and self.svrData[data.id] then
		return true
	elseif data.condition_id and ConditionLimitManager.inLimitState(data.condition_id) then
		return false
	elseif data.only_has_show == 1 then
		return false
	end

	return true
end

function HeroContentSkinPanel:setData(resetSel)
	self.skinData = {}

	local clientData = ResItemHeroSkin[self.hero.id]

	if clientData ~= nil then
		for idx, data in ipairs(clientData) do
			if self:canShowSkin(data) then
				local replaceData = self:checkReplaceSkinData(data)

				table.insert(self.skinData, replaceData)
			end
		end
	end

	if self.toShowType == SHOW_TYPE_MODEL then
		self.mWindow:hideModel(true)
	end

	self.scrollPage:getComObj().horizontal = true

	self:refreshSkinPanel()
	self:refreshSkin2d()
	self:refreshPanelInfo()

	if resetSel then
		self.mParent:resetCurSel()
	end
end

function HeroContentSkinPanel:refreshSkinPanel()
	local default = {
		id = 0,
		name = Lang.get(30382),
		model_id = self.hero.resData.model
	}

	if not self.skinCells[1] then
		local cell = SkinCell(self, self.mPath .. "/SkinPanel/SkinMaskPanel/SkinList/Content", "System/Hero/SkinCardCell", 0, 0, true)

		cell.mEventClick = Slot(self.onCellBtnClick, self)
		cell.mEventCellClick = Slot(self.onCellClick, self)
		cell.index = 1
		self.skinCells[1] = cell
	end

	if #self.skinData + 1 >= #self.skinCells then
		for i = #self.skinCells + 1, #self.skinData + 1 do
			local cell = SkinCell(self, self.mPath .. "/SkinPanel/SkinMaskPanel/SkinList/Content", "System/Hero/SkinCardCell", 0, 0, true)

			cell.mEventClick = Slot(self.onCellBtnClick, self)
			cell.mEventCellClick = Slot(self.onCellClick, self)
			cell.index = i
			self.skinCells[i] = cell
		end
	end

	for i = 2, #self.skinCells do
		if self.skinData[i - 1] then
			local data = self.skinData[i - 1]
			local hasGet = false

			if self.svrData[data.id] then
				hasGet = true
			end

			local onWear = false

			if data.id == self.skinId then
				if not self.curSelId then
					self.curSelId = i
				end

				onWear = true
			end

			self.skinCells[i]:setVisible(true)
			self.skinCells[i]:setData(data, hasGet, onWear)
		else
			self.skinCells[i]:destroy()

			self.skinCells[i] = nil
		end
	end

	if not self.curSelId then
		self.curSelId = 2
	end

	if self.skinId == 0 then
		self.skinCells[1]:setData(default, true, true)
	else
		self.skinCells[1]:setData(default, true, false)
	end

	self:clearCoroutine()

	self.coCorrectToPage = coroutine.start(self.delayScrollToCorrectPage, self)
end

function HeroContentSkinPanel:delayScrollToCorrectPage()
	coroutine.step()
	self.scrollPage:scrollToCorrectPage(self.curSelId)
	self.skinCells[self.curSelId]:setSelected(true)
end

function HeroContentSkinPanel:refreshSkin2d(skinId)
	local id = skinId and skinId or self.skinId
	local skin2dId = self.hero.id

	if id ~= 0 then
		for index, skinData in pairs(self.skinData) do
			if skinData.id == id then
				skin2dId = skinData.port_id

				break
			end
		end
	end

	if skin2dId ~= nil then
		self.rolePortrait:showRole(skin2dId, UIConst.ROLEIMAGE_SHOWTYPE_SHOW_SKIN)
		self.enjoyPanel:addDrage(self.img2D, self.rolePortrait.image, self.hero.camp)
	end
end

function HeroContentSkinPanel:refreshPanelInfo()
	local isOriganel = self.curSelId == 1

	self.markPanel:setVisible(not isOriganel)
	self.oriSkinPanel:setVisible(isOriganel)
	self.markTipPanel:setVisible(false)
	self.txtOriDesc:setText(self.hero.resData.hero_des)

	if isOriganel == true then
		if Const.REVIEW_VERSION and self.hero.resData.hero_name == "S-VIII" then
			self.txtName:setText(Lang.get(111526))
		else
			self.txtName:setText(self.hero.resData.hero_name)
		end

		self.btnSkinStory:setVisible(false)
	else
		local curSkinData = self.skinData[self.curSelId - 1]

		if curSkinData.tag_id then
			if #curSkinData.tag_id > #self.tagList then
				for i = #self.tagList + 1, #curSkinData.tag_id do
					local tag = HeroTagChild(self, self.mPath .. "/MarkPanel", "System/Hero/MarkCell", 0, 0, true)

					self.tagList[i] = tag
				end
			end

			for i = 1, #self.tagList do
				if curSkinData.tag_id[i] then
					self.tagList[i]:setVisible(true)

					local info = ResSkinTag[curSkinData.tag_id[i]]

					self.tagList[i]:setData(info)
				else
					self.tagList[i]:setVisible(false)
				end
			end
		end

		if Const.REVIEW_VERSION and self.hero.resData.hero_name == "S-VIII" then
			self.txtName:setText("暗匿者·" .. curSkinData.name)
		else
			self.txtName:setText(self.hero.resData.hero_name .. "·" .. curSkinData.name)
		end

		self.skinStoryData = curSkinData

		self.btnSkinStory:setVisible(true)
	end
end

function HeroContentSkinPanel:changeHeroSkin(modelSkinId, skinId)
	local sData

	for index, skinData in ipairs(self.skinData) do
		if skinData.id == skinId then
			sData = skinData

			break
		end
	end

	local baseId

	if sData and sData.base_id then
		baseId = sData.base_id
	elseif self.hero.base == 0 then
		baseId = self.hero.resData.model
	else
		baseId = ResItemHeroBase[self.hero.id][self.hero.base].base_id
	end

	self.mWindow:changeHeroSkin(modelSkinId, baseId)
end

function HeroContentSkinPanel:onCorrectEvent(sender, currentPageIndex)
	self.currentSkinIndex = currentPageIndex

	if self.curSelId and self.curSelId ~= currentPageIndex then
		self.skinCells[self.curSelId]:setSelected(false)
	end

	self.curSelId = currentPageIndex

	self.skinCells[currentPageIndex]:setSelected(true)

	local cell = self.skinCells[self.curSelId]

	self:refreshSkin2d(cell.data.id)

	if self.toShowType == SHOW_TYPE_MODEL then
		self.rolePortrait:setVisible(true)
	else
		self:changeHeroSkin(cell.data.model_id, cell.data.id)
	end

	self:refreshPanelInfo()
end

function HeroContentSkinPanel:onCellBtnClick(cell)
	if cell.hasGet == true then
		local skinData = self.skinData[self.curSelId - 1]
		local skinId = skinData and skinData.id or 0

		RPC.skinWear(self.hero.gid, skinId, Const.SKIN_TYPE_SKIN)
	else
		local itemId = self.skinData[self.curSelId - 1].item_id
		local fakeItem = BaseObject.GetObject(itemId)

		UIManager.getUI("skinTips"):showObj(self.mWindow, fakeItem)
	end
end

function HeroContentSkinPanel:onCellClick(cell)
	self.scrollPage:scrollToCorrectPage(cell.index)
	self.mParent:checkNew()
end

function HeroContentSkinPanel:onBtnPortraitClick()
	self:changeShowType()
end

function HeroContentSkinPanel:onMarkClick()
	local curSkinData = self.skinData[self.curSelId - 1]
	local tagList = curSkinData.tag_id

	if tagList and #tagList > 0 then
		self.markTipPanel:setVisible(true)

		if #tagList > #self.tagTips then
			for i = #self.tagTips + 1, #tagList do
				local markTag = HeroTagTipChild(self, self.mPath .. "/MarkTipsPanel/MarkDesPanel/Content", "System/Hero/MarkDesCell", 0, 0, true)

				self.tagTips[i] = markTag
			end
		end

		for idx, tag in ipairs(self.tagTips) do
			if tagList[idx] and self.tagList[idx] then
				self.tagTips[idx]:setVisible(true)
				self.tagTips[idx]:setData(self.tagList[idx].data)
			else
				self.tagTips[idx]:setVisible(false)
			end
		end
	end
end

function HeroContentSkinPanel:onCloseMark()
	self.markTipPanel:setVisible(false)
end

function HeroContentSkinPanel:onSkinStoryClick()
	if self.skinStoryData then
		UIManager.getUI("heroSkinStoryTips"):show(self)
	end
end

function HeroContentSkinPanel:changeShowType(ignoreFunc)
	local info = SHOW_INFO[self.toShowType]

	self.mParent.btnChange2d:setText(info[1])
	self.mParent.imgChange2d:setImage("Atlas/HeroAtlas/HeroSkinAtlas", info[2])

	local isShowImage = self.toShowType == SHOW_TYPE_PORTRAIT

	self.enjoyPanel:showEnjoyPanel(isShowImage)

	if isShowImage then
		BeginnerManager.ShowHeroEnjoyPanel()
	end

	local func = self[info[3]]

	if func and not ignoreFunc then
		func(self)
	end
end

function HeroContentSkinPanel:showOnModel()
	if self.curSelId then
		local skinData = self.skinData[self.curSelId - 1]
		local skinId = skinData and skinData.id or 0
		local modelId = skinId ~= 0 and skinData.model_id or self.hero.resData.model

		if modelId then
			self:changeHeroSkin(modelId, skinId)
		end
	end

	self.mWindow:hideModel(false)
	self.img2D:setVisible(false)

	self.toShowType = SHOW_TYPE_PORTRAIT
end

function HeroContentSkinPanel:showOn2D()
	self.mWindow:hideModel(true)
	self.img2D:setVisible(true)

	self.toShowType = SHOW_TYPE_MODEL
end

function HeroContentSkinPanel:resetCurSel(ignoreAnim)
	if not self.hero then
		return
	end

	local data

	for _, skinData in pairs(self.skinData) do
		if skinData.id == self.skinId then
			data = skinData

			break
		end
	end

	if data and data.model_id then
		self:changeHeroSkin(data.model_id, data.id)
	elseif self.skinId == 0 then
		local modelId = self.hero.resData.model

		self:changeHeroSkin(modelId, self.hero.skin)
	end

	if self.curSelId then
		self.skinCells[self.curSelId]:setSelected(false)

		self.curSelId = nil
	end

	for index, data in pairs(self.skinData) do
		if data.id == self.hero.skin then
			self.curSelId = index + 1

			break
		end
	end

	if not self.curSelId then
		self.curSelId = 1
	end

	if self.skinCells[self.curSelId] then
		self.skinCells[self.curSelId]:setSelected(true)
	end

	if self.toShowType == SHOW_TYPE_MODEL then
		ignoreAnim = false
	end

	self.mWindow:hideModel(false, ignoreAnim)
	self:resetShowType()
end

function HeroContentSkinPanel:resetShowType()
	if self.enjoyPanel.isAppreciate then
		self.enjoyPanel:outEnjoyClick()
	end

	self.img2D:setVisible(false)

	self.toShowType = SHOW_TYPE_MODEL

	self:changeShowType(true)

	self.toShowType = SHOW_TYPE_PORTRAIT
end

function HeroContentSkinPanel:onHide()
	self.scrollPage:stopMovement()
	self.scrollPage:cancelScroll()

	if CurAvatar.unlockNewSkin[self.hero.id] then
		CurAvatar.unlockNewSkin[self.hero.id] = nil
		CurAvatar.canNewSkinUnlockDic[self.hero.gid] = false
	end

	CurAvatar:checkSkinNew()
	self.mParent:checkNew()
end

function HeroContentSkinPanel:clearPanel()
	return
end

function HeroContentSkinPanel:onDestroy()
	self:clearCoroutine()
end

function HeroContentSkinPanel:clearCoroutine()
	if self.coCorrectToPage then
		coroutine.stop(self.coCorrectToPage)

		self.coCorrectToPage = nil
	end
end

return HeroContentSkinPanel
