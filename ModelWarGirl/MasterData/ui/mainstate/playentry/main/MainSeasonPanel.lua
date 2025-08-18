-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\PlayEntry\\Main\\MainSeasonPanel.lua

local ResColor = require("ClientData/ResColor")
local MainSeasonPanel = Class("MainSeasonPanel", UIControls.Child)

function MainSeasonPanel:ctor()
	self.btnChapters = {}
	self.bars = {}

	for i = 1, Const.MAIN_STAGE_CHAPTER_NUM do
		local btn = UIControls.Button(self, "InfoPanel/BtnLv" .. i)

		btn.txt = UIControls.Label(self, "InfoPanel/BtnLv" .. i .. "/Text")
		btn.chapter = i

		btn:addEventClick(self.onChapterSelect)

		self.btnChapters[i] = btn

		local bar = UIControls.MaterialProgress(self, "InfoPanel/Bar" .. i)

		self.bars[i] = bar
	end

	self.panelSeason = UIControls.Panel(self, "BgRound")
	self.txtSeason = UIControls.Label(self, "BgRound/TextRound")
	self.mEventChapterClick = nil
end

function MainSeasonPanel:show(tgtSeason, tgtChapter)
	local showSeason = tgtSeason ~= nil

	self.panelSeason:setVisible(showSeason)

	if showSeason then
		self.txtSeason:setText(string.format(Lang.get(30518), tgtSeason))
	else
		self.txtSeason:setText("")
	end

	local atlas = "Atlas/MainBattleAtlas/MainBattleAtlas"

	for chapter, btnChapter in ipairs(self.btnChapters) do
		if tgtChapter == nil or chapter < tgtChapter then
			btnChapter:setImage(atlas, "BgBusPlateNml")
			btnChapter.txt:setFontColor(ResColor.ORANGEBTN)
		elseif chapter == tgtChapter then
			btnChapter:setImage(atlas, "BgBusPlateSel")
			btnChapter.txt:setFontColor(ResColor.BLACK)
		else
			btnChapter:setImage(atlas, "BgBusPlateDis")
			btnChapter.txt:setFontColor(ResColor.GREYMIDDLE)
		end
	end
end

function MainSeasonPanel:showBar(showIdx, runIdx)
	runIdx = runIdx or 0

	for i, bar in ipairs(self.bars) do
		bar:setVisible(showIdx == nil or i < showIdx)

		if i == runIdx then
			bar:setValue(0)
		else
			bar:setValue(1)
		end
	end

	return self.bars[runIdx]
end

function MainSeasonPanel:onChapterSelect(sender)
	if self.mEventChapterClick then
		self.mEventChapterClick(sender.chapter)
	end
end

return MainSeasonPanel
