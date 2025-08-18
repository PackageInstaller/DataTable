-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\PreviewStageCell.lua

local ResAchieve = require("ClientData/ResAchieve")
local ResRandClient = require("ClientData/ResRandClient")
local ResTrunkAchieveMisc = require("ClientData/ResTrunkAchieveMisc")
local strClassName = "ChapterAwardPanel"
local ChapterAwardPanel = Class(strClassName, UIControls.Panel)

function ChapterAwardPanel:ctor()
	self:initUI()
end

function ChapterAwardPanel:initUI()
	self.imgPreview = UIControls.Image(self, self.mPath .. "/ImgPreview")
	self.panelLock = UIControls.Panel(self, self.mPath .. "/TextLock")
	self.panelGo = UIControls.Panel(self, self.mPath .. "/TextGo")
	self.panelGot = UIControls.Panel(self, self.mPath .. "/ImgState")
	self.awardGridList = {}
end

function ChapterAwardPanel:setPreviewStageData(previewStageData)
	self.previewStageData = previewStageData

	if self.previewStageData.resData.spec_icon_path then
		self.imgPreview:setImage("Atlas/TaskAtlas/TaskPreviewAtlas", "BgGiftYellow")
	else
		self.imgPreview:setImage("Atlas/TaskAtlas/TaskPreviewAtlas", "BgGiftWhite")
	end

	if self.previewStageData.resData.relate_achieve then
		local achieveInfo = ResAchieve[self.previewStageData.resData.relate_achieve]

		if not achieveInfo then
			return
		end

		local awardIdList = {}
		local awardNum = {}
		local awardRandId = achieveInfo.award_randid

		if awardRandId and ResRandClient[awardRandId] and ResRandClient[awardRandId].show_ids then
			for i, itemId in ipairs(ResRandClient[awardRandId].show_ids) do
				local itemNum = ResRandClient[awardRandId].show_nums[i]

				awardIdList[i] = itemId
				awardNum[i] = itemNum
			end
		end

		local specInfo = ResTrunkAchieveMisc[self.previewStageData.resData.relate_achieve]

		if specInfo then
			local itemIds = specInfo.item_id
			local itemNums = specInfo.item_num

			for i, itemId in ipairs(itemIds) do
				local itemNum = itemNums[i]

				table.insert(awardIdList, itemId)
				table.insert(awardNum, itemNum)
			end
		end

		for i, _ in ipairs(awardIdList) do
			local awardObjectNum = awardNum[i] or 1

			if not self.awardGridList[i] then
				self.awardGridList[i] = UIControls.getGridAwardContainer(self, self.mPath .. "/GridItemPanel")
			end

			self.awardGridList[i].mDisableWays = true

			local item = BaseObject.GetObject(awardIdList[i], awardObjectNum)

			self.awardGridList[i]:setObj(item)

			if self.previewStageData.state == Const.STAGE_BONUS_STATE.GOT then
				self.awardGridList[i]:setState(false, true)
			else
				self.awardGridList[i]:setState(false, false)
			end

			self.awardGridList[i]:setVisible(true)
		end

		for i = #awardIdList + 1, #self.awardGridList do
			self.awardGridList[i]:setVisible(false)
		end
	end

	self.panelLock:setVisible(self.previewStageData.state == Const.STAGE_BONUS_STATE.DIS)
	self.panelGo:setVisible(self.previewStageData.state == Const.STAGE_BONUS_STATE.NEXT)
	self.panelGot:setVisible(self.previewStageData.state == Const.STAGE_BONUS_STATE.GOT)
end

local strClassName = "ChapterPreviewPanel"
local ChapterPreviewPanel = Class(strClassName, UIControls.Panel)

function ChapterPreviewPanel:ctor()
	self:initUI()
end

function ChapterPreviewPanel:initUI()
	self.imgPreview = UIControls.Image(self, self.mPath .. "/ImgPreview")
	self.btnPreview = UIControls.Button(self, self.mPath .. "/GridItemPanel/PreviewItem")

	self.btnPreview:addEventClick(self.onBtnPreviewClick)

	self.imgGamePlay = UIControls.Image(self, self.mPath .. "/GridItemPanel/PreviewItem/Icon")
	self.panelLock = UIControls.Panel(self, self.mPath .. "/GridItemPanel/PreviewItem/LockPanel")
	self.aniLock = UIControls.UIAni(self, self.mPath .. "/GridItemPanel/PreviewItem/LockPanel")
	self.txtTitle = UIControls.Label(self, self.mPath .. "/TextTitle")
	self.btnState = UIControls.Button(self, self.mPath .. "/BtnState")

	self.btnState:setVisible(not RegionUtils.isJP() and not RegionUtils.isKR())
	self.btnState:addEventClick(self.onBtnPreviewClick)
end

function ChapterPreviewPanel:onBtnPreviewClick()
	if self.previewStageData and not RegionUtils.isJP() and not RegionUtils.isKR() then
		UIManager.getUI("infoNotice", true):showSystemInfo(self.previewStageData.resData.play_des_id)
	end
end

function ChapterPreviewPanel:setPreviewStageData(previewStageData)
	self.previewStageData = previewStageData

	if self.previewStageData.resData.spec_icon_path then
		self.imgPreview:setImage("Atlas/TaskAtlas/TaskPreviewAtlas", "BgFunctionYellow")
	else
		self.imgPreview:setImage("Atlas/TaskAtlas/TaskPreviewAtlas", "BgFunctionWhite")
	end

	self.panelLock:setVisible(self.previewStageData.state ~= Const.STAGE_BONUS_STATE.GOT)
	self.txtTitle:setText(self.previewStageData.resData.bonus_desc or "")

	local iconInfo = ClientUtils.getMoneyIcon(self.previewStageData.resData.bonus_id)

	if iconInfo then
		self.imgGamePlay:setImage(iconInfo[1], iconInfo[2])
	end
end

local strClassName = "PreviewStageCell"
local PreviewStageCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function PreviewStageCell:ctor()
	self:initUI()
end

function PreviewStageCell:initUI()
	self.imgBgCell = UIControls.Image(self, "BgCell")
	self.imgIndicate = UIControls.Image(self, "ImgIndicate")
	self.txtRule = UIControls.Label(self, "TextRule")
	self.txtLevel = UIControls.Label(self, "TextLevel")
	self.imgGo = UIControls.Panel(self, "ImgGo")
	self.panelChapterAward = ChapterAwardPanel(self, "ChapterAwardPanel")
	self.panelChapterPlay = ChapterPreviewPanel(self, "ChapterPreviewPanel")
	self.efxUnlock = UIControls.LazyEffectPlayer(self, "Efx")
end

function PreviewStageCell:playUnlockEfx()
	if self.previewStageData.resData.play_des_id then
		self.panelChapterPlay.panelLock:setVisible(true)
		self.panelChapterPlay.aniLock:startAni("UnLockPreviewWin", true)
	end

	self.efxUnlock:setVisible(true)
end

function PreviewStageCell:coPlayAniFunc(aniName)
	coroutine.step()
	self.panelChapterPlay.aniLock:startAni(aniName, true)
end

function PreviewStageCell:clearCoroutine()
	if self.coPlayAni then
		coroutine.stop(self.coPlayAni)

		self.coPlayAni = nil
	end
end

function PreviewStageCell:onClear()
	PreviewStageCell.super.onClear(self)
	self:clearCoroutine()
	self.efxUnlock:setVisible(false)
	self.panelChapterPlay.aniLock:startAni("UnLockPreviewReset", true)
end

function PreviewStageCell:setPreviewStageData(previewStageData)
	self.previewStageData = previewStageData

	if self.previewStageData.resData.spec_icon_path then
		self.imgBgCell:setImage("Atlas/TaskAtlas/TaskPreviewAtlas", "BgRewardBottom")
	else
		self.imgBgCell:setImage("Atlas/TaskAtlas/TaskPreviewAtlas", "BgOrdinaryBottom")
	end

	if self.previewStageData.resData.play_des_id then
		self.imgIndicate:setImage("Atlas/TaskAtlas/TaskPreviewAtlas", "BgFunctionBlack")
		self.panelChapterAward:setVisible(false)
		self.panelChapterPlay:setVisible(true)
		self.panelChapterPlay:setPreviewStageData(self.previewStageData)
	else
		self.imgIndicate:setImage("Atlas/TaskAtlas/TaskPreviewAtlas", "BgGiftBlack")
		self.panelChapterPlay:setVisible(false)
		self.panelChapterAward:setVisible(true)
		self.panelChapterAward:setPreviewStageData(self.previewStageData)
	end

	local targetDesc = string.format(Lang.get(30569), self.previewStageData.resData.target_desc)

	self.txtRule:setText(targetDesc)

	if self.previewStageData.resData.rec_level and self.previewStageData.state ~= Const.STAGE_BONUS_STATE.GOT then
		self.txtLevel:setVisible(true)
		self.txtLevel:setText(string.format(Lang.get(45491), self.previewStageData.resData.rec_level))
	else
		self.txtLevel:setVisible(false)
	end

	self.imgGo:setVisible(self.previewStageData.state == Const.STAGE_BONUS_STATE.NEXT)
end

return PreviewStageCell
