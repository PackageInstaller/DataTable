-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\ChapterPreviewDlg.lua

local PreviewStageCell = require("UI/MainState/PreviewStageCell")
local strClassName = "ChapterPreviewDlg"
local ChapterPreviewDlg = Class(strClassName, UIControls.Window)

function ChapterPreviewDlg:ctor()
	self:initUI()
end

function ChapterPreviewDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnPreview = UIControls.Button(self, "BgPanel/PreviewInfoPanel")

	self.btnPreview:addEventClick(self.onBtnPreviewClick)

	self.txtTitlePreview = UIControls.Label(self, "BgPanel/PreviewInfoPanel/TextPreviewTitle")
	self.imgBgPreview = UIControls.Image(self, "BgPanel/PreviewInfoPanel/BgPreview")
	self.txtRulePreview = UIControls.Label(self, "BgPanel/PreviewInfoPanel/TextRule")
	self.cells = {}
	self.scrollPreviewStage = UIControls.ScrollViewLoopV(self, "BgPanel/PreviewList")

	self.scrollPreviewStage:addEventCellChanged(self.onPreviewStageChanged)
end

function ChapterPreviewDlg:onPreviewStageChanged(sender, targetCell, newIdx)
	targetCell = targetCell or PreviewStageCell(sender, "System/Task/ChapterPreviewAwardCell", newIdx)

	if not self.previewStageDataList or #self.previewStageDataList == 0 then
		return
	end

	if self.previewStageDataList[newIdx] ~= nil then
		targetCell:setPreviewStageData(self.previewStageDataList[newIdx], newIdx)
	end

	self.cells[newIdx] = targetCell
end

function ChapterPreviewDlg:setPreviewStageData(previewStageDataList)
	self.specStageData = utils.getNowSpecStageBonus()

	if self.specStageData then
		self.txtTitlePreview:setText(self.specStageData.bonus_desc)

		if self.specStageData.play_des_id then
			self.txtRulePreview:setText(string.format(Lang.get(45489), self.specStageData.target_desc))
		else
			self.txtRulePreview:setText(string.format(Lang.get(45490), self.specStageData.target_desc))
		end

		self.imgBgPreview:setImage(self.specStageData.spec_icon_path, self.specStageData.spec_icon)
	end

	self.btnPreview:setEnable(not RegionUtils.isJP() and not RegionUtils.isKR())

	self.previewStageDataList = previewStageDataList

	local nowBonus, isNotGot = utils.getStageBonusInfo(nil, true)
	local startIdx = math.max(nowBonus.id - 1, 1)

	self.scrollPreviewStage:setTotalCount(#self.previewStageDataList, math.min(#self.previewStageDataList - 3, startIdx))
	self:playUnlockEfx()
end

function ChapterPreviewDlg:playUnlockEfx()
	if CurAvatar.cacheUnlockPreviewStage then
		for _, cell in pairs(self.cells) do
			if cell.previewStageData.resData.id == CurAvatar.cacheUnlockPreviewStage then
				cell:playUnlockEfx()
			end
		end

		CurAvatar.cacheUnlockPreviewStage = nil
	end
end

function ChapterPreviewDlg:onBtnCloseClick()
	self:setVisible(false)
end

function ChapterPreviewDlg:onBtnPreviewClick()
	if self.specStageData then
		if self.specStageData.play_des_id then
			UIManager.getUI("infoNotice", true):showSystemInfo(self.specStageData.play_des_id)
		else
			local achieveAwardDlg = UIManager.getUI("achieveAwardDlg", true)

			if self.specStageData.relate_achieve then
				achieveAwardDlg:showPreviewAward(self.specStageData.relate_achieve)
			end
		end
	end
end

return ChapterPreviewDlg
