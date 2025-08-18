-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\PlayEntry\\Main\\NewAwardPreviewPanel.lua

local ResRandClient = require("ClientData/ResRandClient")
local strClassName = "NewAwardPreviewPanel"
local NewAwardPreviewPanel = Class(strClassName, UIControls.Panel)

function NewAwardPreviewPanel:ctor()
	self:initUI()
end

function NewAwardPreviewPanel:initUI()
	self.imgNothing = UIControls.Image(self, self.mPath .. "/AwardInfo/ImgNothing")
	self.txtChapterTitle = UIControls.Label(self, self.mPath .. "/AwardInfo/NextPanel/TxtTitle")
	self.panelNext = UIControls.Panel(self, self.mPath .. "/AwardInfo/NextPanel")
	self.btnClose = UIControls.Button(self, self.mPath .. "/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)
	self:initShow()
end

function NewAwardPreviewPanel:onBtnCloseClick()
	self.mWindow:changeNewAwardPreivewPanelShow(false)
end

function NewAwardPreviewPanel:initShow()
	local baseAwards = ResRandClient[CurAvatar.mainStageCur.deposit_assgin_award] or {}
	local baseAwardIDs = baseAwards.show_ids or {}
	local baseAwardNums = baseAwards.show_nums or {}
	local bonus = {}

	for index, awardID in ipairs(baseAwardIDs) do
		if awardID == Const.MONEY_ID_GOLD or awardID == Const.MONEY_ID_EXP or awardID == Const.MONEY_ID_HERO_EXP or awardID == Const.MONEY_ID_HERO_EXP2 then
			table.insert(bonus, {
				awardID,
				baseAwardNums[index]
			})
		end
	end

	for i = 1, 4 do
		local awardID = bonus[i][1]
		local awardNum = bonus[i][2]

		if awardID and awardNum then
			if awardID == Const.MONEY_ID_GOLD then
				awardNum = CurAvatar:getPrivilegeValue(Const.PRIVITY_KEY_GOLD, awardNum)
			elseif awardID == Const.MONEY_ID_HERO_EXP then
				awardNum = CurAvatar:getPrivilegeValue(Const.PRIVITY_KEY_HERO_EXP, awardNum)
			end

			awardNum = math.floor(awardNum * 10 * 60 * 24)

			local fakeItem = BaseObject.GetObject(awardID, awardNum)
			local itemGrid = UIControls.ItemGridChild(self, self.mPath .. "/AwardInfo/PresentPanel", "System/Common/Grid/GridMaterialItem", 0, 0, true)

			itemGrid.mDisableWays = true

			itemGrid:setObj(fakeItem)
		end
	end

	local nextChapterData = CurAvatar:getNextChapterAwardInfo()

	if nextChapterData then
		self.txtChapterTitle:setText(string.format(Lang.get(45493), nextChapterData.chapter))
		self.txtChapterTitle:setVisible(true)
		self.panelNext:setVisible(true)
		self.imgNothing:setVisible(false)

		baseAwards = ResRandClient[nextChapterData.deposit_assgin_award] or {}
		baseAwardIDs = baseAwards.show_ids or {}
		baseAwardNums = baseAwards.show_nums or {}
		bonus = {}

		for index, awardID in ipairs(baseAwardIDs) do
			if awardID == Const.MONEY_ID_GOLD or awardID == Const.MONEY_ID_EXP or awardID == Const.MONEY_ID_HERO_EXP or awardID == Const.MONEY_ID_HERO_EXP2 then
				table.insert(bonus, {
					awardID,
					baseAwardNums[index]
				})
			end
		end

		for i = 1, 4 do
			local awardID = bonus[i][1]
			local awardNum = bonus[i][2]

			if awardID and awardNum then
				if awardID == Const.MONEY_ID_GOLD then
					awardNum = CurAvatar:getPrivilegeValue(Const.PRIVITY_KEY_GOLD, awardNum)
				elseif awardID == Const.MONEY_ID_HERO_EXP then
					awardNum = CurAvatar:getPrivilegeValue(Const.PRIVITY_KEY_HERO_EXP, awardNum)
				end

				awardNum = math.floor(awardNum * 10 * 60 * 24)

				local fakeItem = BaseObject.GetObject(awardID, awardNum)
				local itemGrid = UIControls.ItemGridChild(self, self.mPath .. "/AwardInfo/NextPanel", "System/Common/Grid/GridMaterialItem", 0, 0, true)

				itemGrid.mDisableWays = true

				itemGrid:setObj(fakeItem)
			end
		end
	else
		self.panelNext:setVisible(false)
		self.txtChapterTitle:setVisible(false)
		self.imgNothing:setVisible(true)
	end
end

return NewAwardPreviewPanel
